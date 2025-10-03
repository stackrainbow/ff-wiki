#!/bin/bash

# Flag file to track if modification has been done
FLAG_FILE="/tmp/wiki_css_modified"

# Check if modification has already been done
if [ ! -f "$FLAG_FILE" ]; then
    echo "First run detected. Modifying login CSS file..."
    
    # Find the login.*.js file in /wiki/assets/css
    LOGIN_FILE=$(find /wiki/assets/css -name "login.*.css" -type f | head -n 1)
    
    if [ -n "$LOGIN_FILE" ]; then
        echo "Found login file: $LOGIN_FILE"
        
        # Append the CSS patches
        cat <<'EOF' >> "$LOGIN_FILE"

        .login {
          background-size: auto !important; 
          background-position: 90% !important;
        }
        
        .login-logo { 
          width: 108px !important; 
          height: 108px !important; 
          padding: 24px 0 0 24px !important;
        }
        
        /* Only affect v-avatar inside login-logo */
        .login-logo .v-avatar { 
          width: 68px !important; 
          height: 68px !important; 
        }
EOF
        
        echo "CSS modification applied successfully"
    else
        echo "Warning: No login.*.css file found in /wiki/assets/css"
    fi
    
    # Create flag file to prevent future modifications
    touch "$FLAG_FILE"
    echo "Flag file created at $FLAG_FILE"
else
    echo "CSS modification already applied (flag file exists)"
fi

# Start the node server
echo "Starting node server..."
exec node server
