apiVersion: install.tetrate.io/v1alpha1
kind: ManagementPlane
metadata:
  name: managementplane
  namespace: tsb
spec:
  dataStore:
    postgres:
      connectionLifetime: 8500s
      host: acid-minimal-cluster.default.svc
      name: my_tsb
      port: 5432
  hub: #HUB#
  organization: tetrate
  identityProvider:
    demoLdap:
      disableTLS: true
      host: ldap
      iam:
        matchDN: cn=%s,ou=People,dc=tetrate,dc=io
        matchFilter: (&(objectClass=person)(uid=%s))
      port: 389
      search:
        baseDN: dc=tetrate,dc=io
        recursive: true
      sync:
        groupsFilter: (objectClass=groupOfUniqueNames)
        membershipAttribute: uniqueMember
        usersFilter: (objectClass=person)
  telemetryStore:
    elastic:
      host: tsb-es-http.elastic.svc
      port: 9200
      selfSigned: true
      version: 7
  tenant: tetrate
  tokenIssuer:
    jwt:
      expiration: 3600s
      issuers:
      - name: https://demo.tetrate.io
        signingKey: tls.key
      refreshExpiration: 2592000s
      tokenPruneInterval: 3600s
