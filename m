Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174C9793B61
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239789AbjIFLdT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Sep 2023 07:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjIFLdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:33:18 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F48198A;
        Wed,  6 Sep 2023 04:32:47 -0700 (PDT)
Received: from msexch01.omp.ru (10.188.4.12) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Wed, 6 Sep 2023
 14:32:21 +0300
Received: from msexch01.omp.ru ([fe80::4020:d881:621a:6b6b]) by
 msexch01.omp.ru ([fe80::4020:d881:621a:6b6b%5]) with mapi id 15.02.0986.014;
 Wed, 6 Sep 2023 14:32:21 +0300
From:   Denis Glazkov <d.glazkov@omp.ru>
CC:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Denis Glazkov <d.glazkov@omp.ru>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] certs: Add the ability to add only CA certificates to the
 secondary trusted keyring
Thread-Topic: [PATCH] certs: Add the ability to add only CA certificates to
 the secondary trusted keyring
Thread-Index: AQHZ4LXMGo0R4XrZsUCxHjqcRoLMCg==
Date:   Wed, 6 Sep 2023 11:32:21 +0000
Message-ID: <20230906113211.82362-1-d.glazkov@omp.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.188.4.41]
x-kse-serverinfo: msexch01.omp.ru, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 9/6/2023 8:51:00 AM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MISSING_HEADERS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building a chain of trust for IMA certificates issued from
intermediate certificates using a secondary trusted keying, there
is no way to restrict the addition of IMA certificates to trusted
certificates, since any certificate signed by an built-in or
secondary trusted certificate can be added to the secondary
trusted keying.

With root privileges, an attacker can load a certificate intended
for IMA into the trusted certificates and sign the kernel modules
with the corresponding private key. This allows an attacker to
load untrusted modules into kernel space.

This patch adds the configuration that once enabled, only
certificates that meet the following requirements can be added
to the secondary trusted keying:

1. The certificate is a CA.
2. The certificate must be used for verifying a CA's signatures.
3. The certificate must not be used for digital signatures.

Signed-off-by: Denis Glazkov <d.glazkov@omp.ru>
---
 certs/Kconfig          |  9 +++++++++
 certs/system_keyring.c | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/certs/Kconfig b/certs/Kconfig
index 1f109b070877..4a4dc8aab892 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -90,6 +90,15 @@ config SECONDARY_TRUSTED_KEYRING
 	  those keys are not blacklisted and are vouched for by a key built
 	  into the kernel or already in the secondary trusted keyring.
 
+config SECONDARY_TRUSTED_KEYRING_FOR_CA_CERTIFICATES_ONLY
+	bool "Allow only CA certificates to be added to the secondary trusted keyring"
+	depends on SECONDARY_TRUSTED_KEYRING
+	help
+	  If set, only CA certificates can be added to the secondary trusted keyring.
+	  An acceptable CA certificate must include the `keyCertSign` value in
+	  the `keyUsage` field. CA certificates that include the `digitalSignature`
+	  value in the `keyUsage` field will not be accepted.
+
 config SYSTEM_BLACKLIST_KEYRING
 	bool "Provide system-wide ring of blacklisted keys"
 	depends on KEYS
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 9de610bf1f4b..8d45c19ba92e 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -90,6 +90,10 @@ int restrict_link_by_builtin_and_secondary_trusted(
 	const union key_payload *payload,
 	struct key *restrict_key)
 {
+#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING_FOR_CA_CERTIFICATES_ONLY
+	struct public_key *pub;
+#endif
+
 	/* If we have a secondary trusted keyring, then that contains a link
 	 * through to the builtin keyring and the search will follow that link.
 	 */
@@ -99,6 +103,23 @@ int restrict_link_by_builtin_and_secondary_trusted(
 		/* Allow the builtin keyring to be added to the secondary */
 		return 0;
 
+#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING_FOR_CA_CERTIFICATES_ONLY
+	if (dest_keyring == secondary_trusted_keys) {
+		if (type != &key_type_asymmetric)
+			return -EOPNOTSUPP;
+
+		pub = payload->data[asym_crypto];
+		if (!pub)
+			return -ENOPKG;
+		if (!test_bit(KEY_EFLAG_CA, &pub->key_eflags))
+			return -EPERM;
+		if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pub->key_eflags))
+			return -EPERM;
+		if (test_bit(KEY_EFLAG_DIGITALSIG, &pub->key_eflags))
+			return -EPERM;
+	}
+#endif
+
 	return restrict_link_by_signature(dest_keyring, type, payload,
 					  secondary_trusted_keys);
 }
-- 
2.34.1
