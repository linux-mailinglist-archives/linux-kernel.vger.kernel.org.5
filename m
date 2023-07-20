Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EAB75B2FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjGTPgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjGTPgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:36:16 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5E030EE;
        Thu, 20 Jul 2023 08:36:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4R6Gf50KX0z9xGYG;
        Thu, 20 Jul 2023 23:22:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBHquXFU7lkGHDRBA--.21759S10;
        Thu, 20 Jul 2023 16:35:23 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, pbrobinson@gmail.com,
        zbyszek@in.waw.pl, wiktor@metacode.biz,
        devel@lists.sequoia-pgp.org, gnupg-devel@gnupg.org,
        ebiggers@kernel.org, Jason@zx2c4.com, mail@maciej.szmigiero.name,
        antony@vennard.ch, konstantin@linuxfoundation.org,
        James.Bottomley@HansenPartnership.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 8/9] KEYS: Introduce load_uasym_keyring()
Date:   Thu, 20 Jul 2023 17:32:44 +0200
Message-Id: <20230720153247.3755856-9-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
References: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHquXFU7lkGHDRBA--.21759S10
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1DtrW5Ww17KFyUGF48JFb_yoWruw1fp3
        y0kryrKr4vywn3G3yfCFyjgr43Cr1vkw4Yg3W3Cw15AF1DXrn8ZrsrKF1UKry5Wry5AryF
        qryIvr4Skw1UtaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBF1jj5C8owAAs-
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Preload user asymmetric keys from 'uasym_keys.bin', placed in certs/ of the
kernel source directory.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 certs/Kconfig               | 11 ++++++++++
 certs/Makefile              |  7 +++++++
 certs/system_certificates.S | 18 ++++++++++++++++
 certs/system_keyring.c      | 41 +++++++++++++++++++++++++++++++++++--
 4 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/certs/Kconfig b/certs/Kconfig
index 1f109b07087..16bbf0f4bb6 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -138,4 +138,15 @@ config SYSTEM_BLACKLIST_AUTH_UPDATE
 	  keyring.  The PKCS#7 signature of the description is set in the key
 	  payload.  Blacklist keys cannot be removed.
 
+config UASYM_PRELOAD_PUBLIC_KEYS
+	bool "Preload user asymmetric keys"
+	depends on SYSTEM_TRUSTED_KEYRING
+	select UASYM_KEYS_SIGS
+	default n
+	help
+	  Load at boot time the user asymmetric keys from a reserved area
+	  (populated with the content of 'certs/uasym_keys.bin' provided at
+	  kernel build time), and add them to the built-in keyring. Invalid
+	  keys are ignored and the loading continues.
+
 endmenu
diff --git a/certs/Makefile b/certs/Makefile
index 799ad7b9e68..2e5be6668a6 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -22,6 +22,13 @@ $(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
 
 targets += blacklist_hash_list
 
+ifdef CONFIG_UASYM_PRELOAD_PUBLIC_KEYS
+ifeq ($(shell ls $(srctree)/certs/uasym_keys.bin 2> /dev/null), $(srctree)/certs/uasym_keys.bin)
+AFLAGS_system_certificates.o += -DHAVE_UASYM_KEYRING_BLOB
+$(obj)/system_certificates.o: $(srctree)/certs/uasym_keys.bin
+endif
+endif
+
 quiet_cmd_extract_certs  = CERT    $@
       cmd_extract_certs  = $(obj)/extract-cert "$(extract-cert-in)" $@
 extract-cert-in = $(filter-out $(obj)/extract-cert, $(real-prereqs))
diff --git a/certs/system_certificates.S b/certs/system_certificates.S
index 003e25d4a17..67b7c5effb6 100644
--- a/certs/system_certificates.S
+++ b/certs/system_certificates.S
@@ -44,3 +44,21 @@ module_cert_size:
 #else
 	.long __module_cert_end - __module_cert_start
 #endif
+
+	.align 8
+	.globl uasym_keys
+uasym_keys:
+__uasym_key_list_start:
+#ifdef HAVE_UASYM_KEYRING_BLOB
+	.incbin "certs/uasym_keys.bin"
+#endif
+__uasym_key_list_end:
+
+	.align 8
+	.globl uasym_keys_size
+uasym_keys_size:
+#ifdef CONFIG_64BIT
+	.quad __uasym_key_list_end - __uasym_key_list_start
+#else
+	.long __uasym_key_list_end - __uasym_key_list_start
+#endif
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index dbee2e5b732..6035bd2f795 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -179,6 +179,31 @@ static __init int system_trusted_keyring_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_UASYM_PRELOAD_PUBLIC_KEYS
+extern __initconst const u8 uasym_keys[];
+extern __initconst const unsigned long uasym_keys_size;
+
+/**
+ * load_uasym_keyring - Load user asymmetric keys from a keyring blob
+ *
+ * Load user asymmetric keys from a keyring blob. Halt the parsing if
+ * a parsing error is encountered. If parsing succeed, ignore invalid keys.
+ *
+ * Return: Zero on success or on failure (ignored).
+ */
+static __init int load_uasym_keyring(void)
+{
+	pr_notice("Loading compiled-in user asymmetric keys\n");
+
+	if (preload_uasym_keys(uasym_keys, uasym_keys_size,
+			       builtin_trusted_keys) < 0)
+		pr_err("Can't load user asymmetric keys\n");
+
+	return 0;
+}
+late_initcall(load_uasym_keyring);
+#endif /* CONFIG_UASYM_PRELOAD_PUBLIC_KEYS */
+
 /*
  * Must be initialised before we try and load the keys into the keyring.
  */
@@ -186,13 +211,25 @@ device_initcall(system_trusted_keyring_init);
 
 __init int load_module_cert(struct key *keyring)
 {
+	int ret;
+
 	if (!IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG))
 		return 0;
 
 	pr_notice("Loading compiled-in module X.509 certificates\n");
 
-	return x509_load_certificate_list(system_certificate_list,
-					  module_cert_size, keyring);
+	ret = x509_load_certificate_list(system_certificate_list,
+					 module_cert_size, keyring);
+#ifdef CONFIG_UASYM_PRELOAD_PUBLIC_KEYS
+	if (!ret) {
+		pr_notice("Loading compiled-in user asymmetric keys\n");
+
+		ret = preload_uasym_keys(uasym_keys, uasym_keys_size, keyring);
+		if (ret < 0)
+			pr_err("Can't load user asymmetric keys\n");
+	}
+#endif
+	return ret;
 }
 
 /*
-- 
2.34.1

