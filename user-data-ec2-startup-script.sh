#!/bin/bash

# Update packages
dnf update -y

# Install Apache HTTP Server
dnf install -y httpd

# Start Apache and enable it on boot
systemctl enable httpd
systemctl start httpd

# Create the static website
cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AWS EC2 Demo</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 100px auto;
            text-align: center;
            padding: 20px;
        }

        h1 {
            color: #232f3e;
        }

        .box {
            padding: 20px;
            border-radius: 10px;
            background: #f3f4f6;
        }
    </style>
</head>
<body>
    <div class="box">
        <h1>Hello from AWS EC2!</h1>
        <h2>Apache HTTP Server is running successfully.</h2>
        <h2>This is a static website hosted on an EC2 instance.</h2>
        <h2>Hostname: $(hostname)</h2>
    </div>
</body>
</html>
EOF

# Set ownership/permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Restart Apache
systemctl restart httpd