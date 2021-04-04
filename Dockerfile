FROM sixeyed/docker-ee:windowsservercore-ltsc2016
SHELL ["powershell"]
SHELL ["powershell","-Command","$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $verbosePreference = 'Continue';"]
ENTRYPOINT Write-output "hello"
RUN echo "Hello World - Dockerfile" > c:\inetpub\wwwroot\index.html
COPY wwwroot c://inetpub/wwwroot
RUN powershell Import-Module WebAdministration
RUN powershell New-WebAppPull -Name 'TestPull'
EXPOSE 80
HEALTHCHECK CMD powershell -command `  
    try { `
     $response = iwr http://localhost; `
     if ($response.StatusCode -eq 200) { return 0} `
     else {return 1}; `
    } catch { return 1 }
