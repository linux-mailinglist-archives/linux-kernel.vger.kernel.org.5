Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE7C77819C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbjHJTaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbjHJT3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:29:54 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29A8213B;
        Thu, 10 Aug 2023 12:29:52 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AJTWKf014280;
        Thu, 10 Aug 2023 14:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691695772;
        bh=VrtrQ3GU8JjhFSuPRH3d5qvvuZnXWjpP/mWSDCkePgA=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=GOOD9qC7yklGkcdXWsjzBQfucrlBUVzns+tHM/j4YqBIz23B2e5WSI/I5EULui3Pc
         FNFc2WA0hYne91v3qCfLK99iFOBZcC/X+/qS7ezqxqAjj2iRBwLjsxdapBlNC2RTBF
         F7gtsGW3ArY4oHrp+K/AGzL0UCG73SLo94+RRXXE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AJTWIG008389
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 14:29:32 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 14:29:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 14:29:32 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AJTVJT021396;
        Thu, 10 Aug 2023 14:29:31 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
Date:   Fri, 11 Aug 2023 00:58:49 +0530
Subject: [PATCH v2 2/6] crypto: crc64 - add crc64-iso framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230719-mcrc-upstream-v2-2-4152b987e4c2@ti.com>
References: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
In-Reply-To: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691695767; l=27904;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=3KNkcGKPCcjIKPeE0LkPLqrrMAnA0buSfXwEjWprSS0=;
 b=gAS75l1VWI/+ITb9ok0lP2DhRmPZl+lCjovQlgItenwb6YqV+erwvWwHI1yKesU63XBdXk29I
 we5n0JZ1DBlCsxx+NDMvUUON6iPo4yQkPrchjoLp4fPA5NvZSOFvw0W
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware specific features may be able to calculate a crc64-iso, so provide
a framework for drivers to register their implementation. If nothing is
registered, fallback to the generic table lookup implementation. The
implementation is modeled after the crc64-rocksoft equivalent

Add testmgr, tcrypt tests and vectors for 64-bit cyclic
redundancy checks (CRC) according to the ISO 3309 standard.

The ISO 3309 64-bit CRC model parameters are as follows:
    Generator Polynomial: x^64 + x^4 + x^3 + x + 1
    Polynomial Value: 0x000000000000001B
    Initial value: 0x0000000000000000
    Reflected Input: False
    Reflected Output: False
    Xor Final: 0x0000000000000000

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 crypto/Kconfig             |  11 +++
 crypto/Makefile            |   1 +
 crypto/crc64_iso_generic.c | 119 ++++++++++++++++++++++++++++
 crypto/tcrypt.c            |   5 ++
 crypto/testmgr.c           |   7 ++
 crypto/testmgr.h           | 404 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/crc64.h      |   4 +
 lib/crc64-iso.c            | 126 ++++++++++++++++++++++++++++++
 8 files changed, 677 insertions(+)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 650b1b3620d8..6a6e69aa25da 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1146,6 +1146,17 @@ config CRYPTO_CRCT10DIF
 
 	  CRC algorithm used by the SCSI Block Commands standard.
 
+config CRYPTO_CRC64_ISO
+	tristate "CRC64 based on ISO 3309 Model algorithm"
+	depends on CRC64
+	select CRYPTO_HASH
+	help
+	  CRC64 CRC algorithm based on the ISO 3309 Model CRC Algorithm
+
+	  Generator polynomial: x^64 + x^4 + x^3 + x + 1
+	  Polynomial value: 0x000000000000001b
+	  See https://en.wikipedia.org/wiki/Cyclic_redundancy_check
+
 config CRYPTO_CRC64_ROCKSOFT
 	tristate "CRC64 based on Rocksoft Model algorithm"
 	depends on CRC64
diff --git a/crypto/Makefile b/crypto/Makefile
index 953a7e105e58..c087553818f6 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -157,6 +157,7 @@ obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += michael_mic.o
 obj-$(CONFIG_CRYPTO_CRC32C) += crc32c_generic.o
 obj-$(CONFIG_CRYPTO_CRC32) += crc32_generic.o
 obj-$(CONFIG_CRYPTO_CRCT10DIF) += crct10dif_common.o crct10dif_generic.o
+obj-$(CONFIG_CRYPTO_CRC64_ISO) += crc64_iso_generic.o
 obj-$(CONFIG_CRYPTO_CRC64_ROCKSOFT) += crc64_rocksoft_generic.o
 obj-$(CONFIG_CRYPTO_AUTHENC) += authenc.o authencesn.o
 obj-$(CONFIG_CRYPTO_LZO) += lzo.o lzo-rle.o
diff --git a/crypto/crc64_iso_generic.c b/crypto/crc64_iso_generic.c
new file mode 100644
index 000000000000..9fea7a3eb650
--- /dev/null
+++ b/crypto/crc64_iso_generic.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/crc64.h>
+#include <linux/module.h>
+#include <crypto/internal/hash.h>
+#include <asm/unaligned.h>
+
+static int chksum_cra_init(struct crypto_tfm *tfm)
+{
+	u64 *key = crypto_tfm_ctx(tfm);
+
+	*key = 0;
+	return 0;
+}
+
+static int chksum_init(struct shash_desc *desc)
+{
+	u64 *key = crypto_shash_ctx(desc->tfm);
+	u64 *crc = shash_desc_ctx(desc);
+
+	*crc = *key;
+	return 0;
+}
+
+static int chksum_update(struct shash_desc *desc, const u8 *data,
+			 unsigned int length)
+{
+	u64 *crc = shash_desc_ctx(desc);
+
+	*crc = crc64_iso_generic(*crc, data, length);
+	return 0;
+}
+
+static int chksum_final(struct shash_desc *desc, u8 *out)
+{
+	u64 *crc = shash_desc_ctx(desc);
+
+	put_unaligned_le64(*crc, out);
+	return 0;
+}
+
+static int __chksum_finup(u64 crc, const u8 *data, unsigned int len, u8 *out)
+{
+	crc = crc64_iso_generic(crc, data, len);
+
+	put_unaligned_le64(crc, out);
+	return 0;
+}
+
+static int chksum_finup(struct shash_desc *desc, const u8 *data,
+			unsigned int len, u8 *out)
+{
+	u64 *crc = shash_desc_ctx(desc);
+
+	return __chksum_finup(*crc, data, len, out);
+}
+
+static int chksum_digest(struct shash_desc *desc, const u8 *data,
+			 unsigned int length, u8 *out)
+{
+	u64 *key = crypto_shash_ctx(desc->tfm);
+
+	return __chksum_finup(*key, data, length, out);
+}
+
+/*
+ * Setting the seed allows arbitrary accumulators and flexible XOR policy
+ */
+static int chksum_setkey(struct crypto_shash *tfm, const u8 *key,
+			 unsigned int keylen)
+{
+	u64 *mctx = crypto_shash_ctx(tfm);
+
+	if (keylen != sizeof(u64))
+		return -EINVAL;
+
+	*mctx = get_unaligned_le64(key);
+	return 0;
+}
+
+static struct shash_alg alg = {
+	.digestsize	=	sizeof(u64),
+	.setkey		=	chksum_setkey,
+	.init		=	chksum_init,
+	.update		=	chksum_update,
+	.final		=	chksum_final,
+	.finup		=	chksum_finup,
+	.digest		=	chksum_digest,
+	.descsize	=	sizeof(u64),
+	.base		=	{
+		.cra_name		=	CRC64_ISO_STRING,
+		.cra_driver_name	=	"crc64-iso-generic",
+		.cra_priority		=	200,
+		.cra_flags		=       CRYPTO_ALG_OPTIONAL_KEY,
+		.cra_blocksize		=	1,
+		.cra_ctxsize		=       sizeof(u64),
+		.cra_module		=	THIS_MODULE,
+		.cra_init		=       chksum_cra_init,
+	}
+};
+
+static int __init crc64_iso_init(void)
+{
+	return crypto_register_shash(&alg);
+}
+
+static void __exit crc64_iso_exit(void)
+{
+	crypto_unregister_shash(&alg);
+}
+
+module_init(crc64_iso_init);
+module_exit(crc64_iso_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Kamlesh Gurudasani <kamlesh@ti.com>");
+MODULE_DESCRIPTION("ISO model CRC64 calculation");
+MODULE_ALIAS_CRYPTO("crc64-iso");
+MODULE_ALIAS_CRYPTO("crc64-iso-generic");
diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index 202ca1a3105d..a41d52a879d6 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -2327,6 +2327,11 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 				generic_hash_speed_template);
 		if (mode > 300 && mode < 400) break;
 		fallthrough;
+	case 329:
+		test_hash_speed("crc64-iso", sec, generic_hash_speed_template);
+		if (mode > 300 && mode < 400)
+			break;
+		fallthrough;
 	case 399:
 		break;
 
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 216878c8bc3d..bd0414b99287 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4679,6 +4679,13 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.hash = __VECS(crc32c_tv_template)
 		}
+	}, {
+		.alg = "crc64-iso",
+		.test = alg_test_hash,
+		.fips_allowed = 1,
+		.suite = {
+			.hash = __VECS(crc64_iso_tv_template)
+		}
 	}, {
 		.alg = "crc64-rocksoft",
 		.test = alg_test_hash,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 5ca7a412508f..5225abd96818 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -5209,6 +5209,410 @@ static const struct hash_testvec rmd160_tv_template[] = {
 	}
 };
 
+static const struct hash_testvec crc64_iso_tv_template[] = {
+	{
+		.psize = 0,
+		.digest = "\x00\x00\x00\x00\x00\x00\x00\x00",
+	},
+	{
+		.plaintext = "\x01\x02\x03\x04\x05\x06\x07\x08"
+			     "\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10"
+			     "\x11\x12\x13\x14\x15\x16\x17\x18"
+			     "\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20"
+			     "\x21\x22\x23\x24\x25\x26\x27\x28",
+		.psize = 40,
+		.digest = "\xaf\x45\xba\x7d\xf2\xda\xa0\xaa",
+	},
+	{
+		.plaintext = "\x29\x2a\x2b\x2c\x2d\x2e\x2f\x30"
+			     "\x31\x32\x33\x34\x35\x36\x37\x38"
+			     "\x39\x3a\x3b\x3c\x3d\x3e\x3f\x40"
+			     "\x41\x42\x43\x44\x45\x46\x47\x48"
+			     "\x49\x4a\x4b\x4c\x4d\x4e\x4f\x50",
+		.psize = 40,
+		.digest = "\x81\x55\x2e\x76\xf8\xd0\xaa\xa0",
+	},
+	{
+		.plaintext = "\x51\x52\x53\x54\x55\x56\x57\x58"
+			     "\x59\x5a\x5b\x5c\x5d\x5e\x5f\x60"
+			     "\x61\x62\x63\x64\x65\x66\x67\x68"
+			     "\x69\x6a\x6b\x6c\x6d\x6e\x6f\x70"
+			     "\x71\x72\x73\x74\x75\x76\x77\x78",
+		.psize = 40,
+		.digest = "\xc6\xb6\x26\x82\x0d\x25\x5f\x55",
+	},
+	{
+		.plaintext = "\x79\x7a\x7b\x7c\x7d\x7e\x7f\x80"
+			     "\x81\x82\x83\x84\x85\x86\x87\x88"
+			     "\x89\x8a\x8b\x8c\x8d\x8e\x8f\x90"
+			     "\x91\x92\x93\x94\x95\x96\x97\x98"
+			     "\x99\x9a\x9b\x9c\x9d\x9e\x9f\xa0",
+		.psize = 40,
+		.digest = "\x20\x8a\xe6\x59\xdf\xf7\x8d\x87",
+	},
+	{
+		.plaintext = "\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8"
+			     "\xa9\xaa\xab\xac\xad\xae\xaf\xb0"
+			     "\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8"
+			     "\xb9\xba\xbb\xbc\xbd\xbe\xbf\xc0"
+			     "\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8",
+		.psize = 40,
+		.digest = "\x19\x9e\xba\xff\x70\x58\x22\x28",
+
+	},
+	{
+		.plaintext = "\xc9\xca\xcb\xcc\xcd\xce\xcf\xd0"
+			     "\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8"
+			     "\xd9\xda\xdb\xdc\xdd\xde\xdf\xe0"
+			     "\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8"
+			     "\xe9\xea\xeb\xec\xed\xee\xef\xf0",
+		.psize = 40,
+		.digest = "\xa3\xdc\x11\x98\x16\x3e\x44\x4e",
+	},
+	{
+		.plaintext = "\x29\x2a\x2b\x2c\x2d\x2e\x2f\x30"
+			     "\x31\x32\x33\x34\x35\x36\x37\x38"
+			     "\x39\x3a\x3b\x3c\x3d\x3e\x3f\x40"
+			     "\x41\x42\x43\x44\x45\x46\x47\x48"
+			     "\x49\x4a\x4b\x4c\x4d\x4e\x4f\x50",
+		.psize = 40,
+		.digest = "\x81\x55\x2e\x76\xf8\xd0\xaa\xa0",
+	},
+	{
+		.plaintext = "\x51\x52\x53\x54\x55\x56\x57\x58"
+			     "\x59\x5a\x5b\x5c\x5d\x5e\x5f\x60"
+			     "\x61\x62\x63\x64\x65\x66\x67\x68"
+			     "\x69\x6a\x6b\x6c\x6d\x6e\x6f\x70"
+			     "\x71\x72\x73\x74\x75\x76\x77\x78",
+		.psize = 40,
+		.digest = "\xc6\xb6\x26\x82\x0d\x25\x5f\x55",
+	},
+	{
+		.plaintext = "\x79\x7a\x7b\x7c\x7d\x7e\x7f\x80"
+			     "\x81\x82\x83\x84\x85\x86\x87\x88"
+			     "\x89\x8a\x8b\x8c\x8d\x8e\x8f\x90"
+			     "\x91\x92\x93\x94\x95\x96\x97\x98"
+			     "\x99\x9a\x9b\x9c\x9d\x9e\x9f\xa0",
+		.psize = 40,
+		.digest = "\x20\x8a\xe6\x59\xdf\xf7\x8d\x87",
+	},
+	{
+		.plaintext = "\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8"
+			     "\xa9\xaa\xab\xac\xad\xae\xaf\xb0"
+			     "\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8"
+			     "\xb9\xba\xbb\xbc\xbd\xbe\xbf\xc0"
+			     "\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8",
+		.psize = 40,
+		.digest = "\x19\x9e\xba\xff\x70\x58\x22\x28",
+	},
+	{
+		.plaintext = "\xc9\xca\xcb\xcc\xcd\xce\xcf\xd0"
+			     "\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8"
+			     "\xd9\xda\xdb\xdc\xdd\xde\xdf\xe0"
+			     "\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8"
+			     "\xe9\xea\xeb\xec\xed\xee\xef\xf0",
+		.psize = 40,
+		.digest = "\xa3\xdc\x11\x98\x16\x3e\x44\x4e",
+	},
+	{
+		.key = "\xff\xff\xff\xff\xff\xff\xff\xff",
+		.ksize = 8,
+		.plaintext = "\x01\x02\x03\x04\x05\x06\x07\x08"
+			     "\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10"
+			     "\x11\x12\x13\x14\x15\x16\x17\x18"
+			     "\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20"
+			     "\x21\x22\x23\x24\x25\x26\x27\x28"
+			     "\x29\x2a\x2b\x2c\x2d\x2e\x2f\x30"
+			     "\x31\x32\x33\x34\x35\x36\x37\x38"
+			     "\x39\x3a\x3b\x3c\x3d\x3e\x3f\x40"
+			     "\x41\x42\x43\x44\x45\x46\x47\x48"
+			     "\x49\x4a\x4b\x4c\x4d\x4e\x4f\x50"
+			     "\x51\x52\x53\x54\x55\x56\x57\x58"
+			     "\x59\x5a\x5b\x5c\x5d\x5e\x5f\x60"
+			     "\x61\x62\x63\x64\x65\x66\x67\x68"
+			     "\x69\x6a\x6b\x6c\x6d\x6e\x6f\x70"
+			     "\x71\x72\x73\x74\x75\x76\x77\x78"
+			     "\x79\x7a\x7b\x7c\x7d\x7e\x7f\x80"
+			     "\x81\x82\x83\x84\x85\x86\x87\x88"
+			     "\x89\x8a\x8b\x8c\x8d\x8e\x8f\x90"
+			     "\x91\x92\x93\x94\x95\x96\x97\x98"
+			     "\x99\x9a\x9b\x9c\x9d\x9e\x9f\xa0"
+			     "\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8"
+			     "\xa9\xaa\xab\xac\xad\xae\xaf\xb0"
+			     "\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8"
+			     "\xb9\xba\xbb\xbc\xbd\xbe\xbf\xc0"
+			     "\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8"
+			     "\xc9\xca\xcb\xcc\xcd\xce\xcf\xd0"
+			     "\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8"
+			     "\xd9\xda\xdb\xdc\xdd\xde\xdf\xe0"
+			     "\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8"
+			     "\xe9\xea\xeb\xec\xed\xee\xef\xf0",
+		.psize = 240,
+		.digest = "\x8b\xa6\xd7\x91\xb4\x74\x96\x84",
+	}, {
+		.key = "\xff\xff\xff\xff\xff\xff\xff\xff",
+		.ksize = 8,
+		.plaintext = "\x6e\x05\x79\x10\xa7\x1b\xb2\x49"
+			     "\xe0\x54\xeb\x82\x19\x8d\x24\xbb"
+			     "\x2f\xc6\x5d\xf4\x68\xff\x96\x0a"
+			     "\xa1\x38\xcf\x43\xda\x71\x08\x7c"
+			     "\x13\xaa\x1e\xb5\x4c\xe3\x57\xee"
+			     "\x85\x1c\x90\x27\xbe\x32\xc9\x60"
+			     "\xf7\x6b\x02\x99\x0d\xa4\x3b\xd2"
+			     "\x46\xdd\x74\x0b\x7f\x16\xad\x21"
+			     "\xb8\x4f\xe6\x5a\xf1\x88\x1f\x93"
+			     "\x2a\xc1\x35\xcc\x63\xfa\x6e\x05"
+			     "\x9c\x10\xa7\x3e\xd5\x49\xe0\x77"
+			     "\x0e\x82\x19\xb0\x24\xbb\x52\xe9"
+			     "\x5d\xf4\x8b\x22\x96\x2d\xc4\x38"
+			     "\xcf\x66\xfd\x71\x08\x9f\x13\xaa"
+			     "\x41\xd8\x4c\xe3\x7a\x11\x85\x1c"
+			     "\xb3\x27\xbe\x55\xec\x60\xf7\x8e"
+			     "\x02\x99\x30\xc7\x3b\xd2\x69\x00"
+			     "\x74\x0b\xa2\x16\xad\x44\xdb\x4f"
+			     "\xe6\x7d\x14\x88\x1f\xb6\x2a\xc1"
+			     "\x58\xef\x63\xfa\x91\x05\x9c\x33"
+			     "\xca\x3e\xd5\x6c\x03\x77\x0e\xa5"
+			     "\x19\xb0\x47\xde\x52\xe9\x80\x17"
+			     "\x8b\x22\xb9\x2d\xc4\x5b\xf2\x66"
+			     "\xfd\x94\x08\x9f\x36\xcd\x41\xd8"
+			     "\x6f\x06\x7a\x11\xa8\x1c\xb3\x4a"
+			     "\xe1\x55\xec\x83\x1a\x8e\x25\xbc"
+			     "\x30\xc7\x5e\xf5\x69\x00\x97\x0b"
+			     "\xa2\x39\xd0\x44\xdb\x72\x09\x7d"
+			     "\x14\xab\x1f\xb6\x4d\xe4\x58\xef"
+			     "\x86\x1d\x91\x28\xbf\x33\xca\x61"
+			     "\xf8\x6c\x03\x9a\x0e\xa5\x3c\xd3"
+			     "\x47\xde\x75\x0c\x80\x17\xae\x22"
+			     "\xb9\x50\xe7\x5b\xf2\x89\x20\x94"
+			     "\x2b\xc2\x36\xcd\x64\xfb\x6f\x06"
+			     "\x9d\x11\xa8\x3f\xd6\x4a\xe1\x78"
+			     "\x0f\x83\x1a\xb1\x25\xbc\x53\xea"
+			     "\x5e\xf5\x8c\x00\x97\x2e\xc5\x39"
+			     "\xd0\x67\xfe\x72\x09\xa0\x14\xab"
+			     "\x42\xd9\x4d\xe4\x7b\x12\x86\x1d"
+			     "\xb4\x28\xbf\x56\xed\x61\xf8\x8f"
+			     "\x03\x9a\x31\xc8\x3c\xd3\x6a\x01"
+			     "\x75\x0c\xa3\x17\xae\x45\xdc\x50"
+			     "\xe7\x7e\x15\x89\x20\xb7\x2b\xc2"
+			     "\x59\xf0\x64\xfb\x92\x06\x9d\x34"
+			     "\xcb\x3f\xd6\x6d\x04\x78\x0f\xa6"
+			     "\x1a\xb1\x48\xdf\x53\xea\x81\x18"
+			     "\x8c\x23\xba\x2e\xc5\x5c\xf3\x67"
+			     "\xfe\x95\x09\xa0\x37\xce\x42\xd9"
+			     "\x70\x07\x7b\x12\xa9\x1d\xb4\x4b"
+			     "\xe2\x56\xed\x84\x1b\x8f\x26\xbd"
+			     "\x31\xc8\x5f\xf6\x6a\x01\x98\x0c"
+			     "\xa3\x3a\xd1\x45\xdc\x73\x0a\x7e"
+			     "\x15\xac\x20\xb7\x4e\xe5\x59\xf0"
+			     "\x87\x1e\x92\x29\xc0\x34\xcb\x62"
+			     "\xf9\x6d\x04\x9b\x0f\xa6\x3d\xd4"
+			     "\x48\xdf\x76\x0d\x81\x18\xaf\x23"
+			     "\xba\x51\xe8\x5c\xf3\x8a\x21\x95"
+			     "\x2c\xc3\x37\xce\x65\xfc\x70\x07"
+			     "\x9e\x12\xa9\x40\xd7\x4b\xe2\x79"
+			     "\x10\x84\x1b\xb2\x26\xbd\x54\xeb"
+			     "\x5f\xf6\x8d\x01\x98\x2f\xc6\x3a"
+			     "\xd1\x68\xff\x73\x0a\xa1\x15\xac"
+			     "\x43\xda\x4e\xe5\x7c\x13\x87\x1e"
+			     "\xb5\x29\xc0\x57\xee\x62\xf9\x90"
+			     "\x04\x9b\x32\xc9\x3d\xd4\x6b\x02"
+			     "\x76\x0d\xa4\x18\xaf\x46\xdd\x51"
+			     "\xe8\x7f\x16\x8a\x21\xb8\x2c\xc3"
+			     "\x5a\xf1\x65\xfc\x93\x07\x9e\x35"
+			     "\xcc\x40\xd7\x6e\x05\x79\x10\xa7"
+			     "\x1b\xb2\x49\xe0\x54\xeb\x82\x19"
+			     "\x8d\x24\xbb\x2f\xc6\x5d\xf4\x68"
+			     "\xff\x96\x0a\xa1\x38\xcf\x43\xda"
+			     "\x71\x08\x7c\x13\xaa\x1e\xb5\x4c"
+			     "\xe3\x57\xee\x85\x1c\x90\x27\xbe"
+			     "\x32\xc9\x60\xf7\x6b\x02\x99\x0d"
+			     "\xa4\x3b\xd2\x46\xdd\x74\x0b\x7f"
+			     "\x16\xad\x21\xb8\x4f\xe6\x5a\xf1"
+			     "\x88\x1f\x93\x2a\xc1\x35\xcc\x63"
+			     "\xfa\x6e\x05\x9c\x10\xa7\x3e\xd5"
+			     "\x49\xe0\x77\x0e\x82\x19\xb0\x24"
+			     "\xbb\x52\xe9\x5d\xf4\x8b\x22\x96"
+			     "\x2d\xc4\x38\xcf\x66\xfd\x71\x08"
+			     "\x9f\x13\xaa\x41\xd8\x4c\xe3\x7a"
+			     "\x11\x85\x1c\xb3\x27\xbe\x55\xec"
+			     "\x60\xf7\x8e\x02\x99\x30\xc7\x3b"
+			     "\xd2\x69\x00\x74\x0b\xa2\x16\xad"
+			     "\x44\xdb\x4f\xe6\x7d\x14\x88\x1f"
+			     "\xb6\x2a\xc1\x58\xef\x63\xfa\x91"
+			     "\x05\x9c\x33\xca\x3e\xd5\x6c\x03"
+			     "\x77\x0e\xa5\x19\xb0\x47\xde\x52"
+			     "\xe9\x80\x17\x8b\x22\xb9\x2d\xc4"
+			     "\x5b\xf2\x66\xfd\x94\x08\x9f\x36"
+			     "\xcd\x41\xd8\x6f\x06\x7a\x11\xa8"
+			     "\x1c\xb3\x4a\xe1\x55\xec\x83\x1a"
+			     "\x8e\x25\xbc\x30\xc7\x5e\xf5\x69"
+			     "\x00\x97\x0b\xa2\x39\xd0\x44\xdb"
+			     "\x72\x09\x7d\x14\xab\x1f\xb6\x4d"
+			     "\xe4\x58\xef\x86\x1d\x91\x28\xbf"
+			     "\x33\xca\x61\xf8\x6c\x03\x9a\x0e"
+			     "\xa5\x3c\xd3\x47\xde\x75\x0c\x80"
+			     "\x17\xae\x22\xb9\x50\xe7\x5b\xf2"
+			     "\x89\x20\x94\x2b\xc2\x36\xcd\x64"
+			     "\xfb\x6f\x06\x9d\x11\xa8\x3f\xd6"
+			     "\x4a\xe1\x78\x0f\x83\x1a\xb1\x25"
+			     "\xbc\x53\xea\x5e\xf5\x8c\x00\x97"
+			     "\x2e\xc5\x39\xd0\x67\xfe\x72\x09"
+			     "\xa0\x14\xab\x42\xd9\x4d\xe4\x7b"
+			     "\x12\x86\x1d\xb4\x28\xbf\x56\xed"
+			     "\x61\xf8\x8f\x03\x9a\x31\xc8\x3c"
+			     "\xd3\x6a\x01\x75\x0c\xa3\x17\xae"
+			     "\x45\xdc\x50\xe7\x7e\x15\x89\x20"
+			     "\xb7\x2b\xc2\x59\xf0\x64\xfb\x92"
+			     "\x06\x9d\x34\xcb\x3f\xd6\x6d\x04"
+			     "\x78\x0f\xa6\x1a\xb1\x48\xdf\x53"
+			     "\xea\x81\x18\x8c\x23\xba\x2e\xc5"
+			     "\x5c\xf3\x67\xfe\x95\x09\xa0\x37"
+			     "\xce\x42\xd9\x70\x07\x7b\x12\xa9"
+			     "\x1d\xb4\x4b\xe2\x56\xed\x84\x1b"
+			     "\x8f\x26\xbd\x31\xc8\x5f\xf6\x6a"
+			     "\x01\x98\x0c\xa3\x3a\xd1\x45\xdc"
+			     "\x73\x0a\x7e\x15\xac\x20\xb7\x4e"
+			     "\xe5\x59\xf0\x87\x1e\x92\x29\xc0"
+			     "\x34\xcb\x62\xf9\x6d\x04\x9b\x0f"
+			     "\xa6\x3d\xd4\x48\xdf\x76\x0d\x81"
+			     "\x18\xaf\x23\xba\x51\xe8\x5c\xf3"
+			     "\x8a\x21\x95\x2c\xc3\x37\xce\x65"
+			     "\xfc\x70\x07\x9e\x12\xa9\x40\xd7"
+			     "\x4b\xe2\x79\x10\x84\x1b\xb2\x26"
+			     "\xbd\x54\xeb\x5f\xf6\x8d\x01\x98"
+			     "\x2f\xc6\x3a\xd1\x68\xff\x73\x0a"
+			     "\xa1\x15\xac\x43\xda\x4e\xe5\x7c"
+			     "\x13\x87\x1e\xb5\x29\xc0\x57\xee"
+			     "\x62\xf9\x90\x04\x9b\x32\xc9\x3d"
+			     "\xd4\x6b\x02\x76\x0d\xa4\x18\xaf"
+			     "\x46\xdd\x51\xe8\x7f\x16\x8a\x21"
+			     "\xb8\x2c\xc3\x5a\xf1\x65\xfc\x93"
+			     "\x07\x9e\x35\xcc\x40\xd7\x6e\x05"
+			     "\x79\x10\xa7\x1b\xb2\x49\xe0\x54"
+			     "\xeb\x82\x19\x8d\x24\xbb\x2f\xc6"
+			     "\x5d\xf4\x68\xff\x96\x0a\xa1\x38"
+			     "\xcf\x43\xda\x71\x08\x7c\x13\xaa"
+			     "\x1e\xb5\x4c\xe3\x57\xee\x85\x1c"
+			     "\x90\x27\xbe\x32\xc9\x60\xf7\x6b"
+			     "\x02\x99\x0d\xa4\x3b\xd2\x46\xdd"
+			     "\x74\x0b\x7f\x16\xad\x21\xb8\x4f"
+			     "\xe6\x5a\xf1\x88\x1f\x93\x2a\xc1"
+			     "\x35\xcc\x63\xfa\x6e\x05\x9c\x10"
+			     "\xa7\x3e\xd5\x49\xe0\x77\x0e\x82"
+			     "\x19\xb0\x24\xbb\x52\xe9\x5d\xf4"
+			     "\x8b\x22\x96\x2d\xc4\x38\xcf\x66"
+			     "\xfd\x71\x08\x9f\x13\xaa\x41\xd8"
+			     "\x4c\xe3\x7a\x11\x85\x1c\xb3\x27"
+			     "\xbe\x55\xec\x60\xf7\x8e\x02\x99"
+			     "\x30\xc7\x3b\xd2\x69\x00\x74\x0b"
+			     "\xa2\x16\xad\x44\xdb\x4f\xe6\x7d"
+			     "\x14\x88\x1f\xb6\x2a\xc1\x58\xef"
+			     "\x63\xfa\x91\x05\x9c\x33\xca\x3e"
+			     "\xd5\x6c\x03\x77\x0e\xa5\x19\xb0"
+			     "\x47\xde\x52\xe9\x80\x17\x8b\x22"
+			     "\xb9\x2d\xc4\x5b\xf2\x66\xfd\x94"
+			     "\x08\x9f\x36\xcd\x41\xd8\x6f\x06"
+			     "\x7a\x11\xa8\x1c\xb3\x4a\xe1\x55"
+			     "\xec\x83\x1a\x8e\x25\xbc\x30\xc7"
+			     "\x5e\xf5\x69\x00\x97\x0b\xa2\x39"
+			     "\xd0\x44\xdb\x72\x09\x7d\x14\xab"
+			     "\x1f\xb6\x4d\xe4\x58\xef\x86\x1d"
+			     "\x91\x28\xbf\x33\xca\x61\xf8\x6c"
+			     "\x03\x9a\x0e\xa5\x3c\xd3\x47\xde"
+			     "\x75\x0c\x80\x17\xae\x22\xb9\x50"
+			     "\xe7\x5b\xf2\x89\x20\x94\x2b\xc2"
+			     "\x36\xcd\x64\xfb\x6f\x06\x9d\x11"
+			     "\xa8\x3f\xd6\x4a\xe1\x78\x0f\x83"
+			     "\x1a\xb1\x25\xbc\x53\xea\x5e\xf5"
+			     "\x8c\x00\x97\x2e\xc5\x39\xd0\x67"
+			     "\xfe\x72\x09\xa0\x14\xab\x42\xd9"
+			     "\x4d\xe4\x7b\x12\x86\x1d\xb4\x28"
+			     "\xbf\x56\xed\x61\xf8\x8f\x03\x9a"
+			     "\x31\xc8\x3c\xd3\x6a\x01\x75\x0c"
+			     "\xa3\x17\xae\x45\xdc\x50\xe7\x7e"
+			     "\x15\x89\x20\xb7\x2b\xc2\x59\xf0"
+			     "\x64\xfb\x92\x06\x9d\x34\xcb\x3f"
+			     "\xd6\x6d\x04\x78\x0f\xa6\x1a\xb1"
+			     "\x48\xdf\x53\xea\x81\x18\x8c\x23"
+			     "\xba\x2e\xc5\x5c\xf3\x67\xfe\x95"
+			     "\x09\xa0\x37\xce\x42\xd9\x70\x07"
+			     "\x7b\x12\xa9\x1d\xb4\x4b\xe2\x56"
+			     "\xed\x84\x1b\x8f\x26\xbd\x31\xc8"
+			     "\x5f\xf6\x6a\x01\x98\x0c\xa3\x3a"
+			     "\xd1\x45\xdc\x73\x0a\x7e\x15\xac"
+			     "\x20\xb7\x4e\xe5\x59\xf0\x87\x1e"
+			     "\x92\x29\xc0\x34\xcb\x62\xf9\x6d"
+			     "\x04\x9b\x0f\xa6\x3d\xd4\x48\xdf"
+			     "\x76\x0d\x81\x18\xaf\x23\xba\x51"
+			     "\xe8\x5c\xf3\x8a\x21\x95\x2c\xc3"
+			     "\x37\xce\x65\xfc\x70\x07\x9e\x12"
+			     "\xa9\x40\xd7\x4b\xe2\x79\x10\x84"
+			     "\x1b\xb2\x26\xbd\x54\xeb\x5f\xf6"
+			     "\x8d\x01\x98\x2f\xc6\x3a\xd1\x68"
+			     "\xff\x73\x0a\xa1\x15\xac\x43\xda"
+			     "\x4e\xe5\x7c\x13\x87\x1e\xb5\x29"
+			     "\xc0\x57\xee\x62\xf9\x90\x04\x9b"
+			     "\x32\xc9\x3d\xd4\x6b\x02\x76\x0d"
+			     "\xa4\x18\xaf\x46\xdd\x51\xe8\x7f"
+			     "\x16\x8a\x21\xb8\x2c\xc3\x5a\xf1"
+			     "\x65\xfc\x93\x07\x9e\x35\xcc\x40"
+			     "\xd7\x6e\x05\x79\x10\xa7\x1b\xb2"
+			     "\x49\xe0\x54\xeb\x82\x19\x8d\x24"
+			     "\xbb\x2f\xc6\x5d\xf4\x68\xff\x96"
+			     "\x0a\xa1\x38\xcf\x43\xda\x71\x08"
+			     "\x7c\x13\xaa\x1e\xb5\x4c\xe3\x57"
+			     "\xee\x85\x1c\x90\x27\xbe\x32\xc9"
+			     "\x60\xf7\x6b\x02\x99\x0d\xa4\x3b"
+			     "\xd2\x46\xdd\x74\x0b\x7f\x16\xad"
+			     "\x21\xb8\x4f\xe6\x5a\xf1\x88\x1f"
+			     "\x93\x2a\xc1\x35\xcc\x63\xfa\x6e"
+			     "\x05\x9c\x10\xa7\x3e\xd5\x49\xe0"
+			     "\x77\x0e\x82\x19\xb0\x24\xbb\x52"
+			     "\xe9\x5d\xf4\x8b\x22\x96\x2d\xc4"
+			     "\x38\xcf\x66\xfd\x71\x08\x9f\x13"
+			     "\xaa\x41\xd8\x4c\xe3\x7a\x11\x85"
+			     "\x1c\xb3\x27\xbe\x55\xec\x60\xf7"
+			     "\x8e\x02\x99\x30\xc7\x3b\xd2\x69"
+			     "\x00\x74\x0b\xa2\x16\xad\x44\xdb"
+			     "\x4f\xe6\x7d\x14\x88\x1f\xb6\x2a"
+			     "\xc1\x58\xef\x63\xfa\x91\x05\x9c"
+			     "\x33\xca\x3e\xd5\x6c\x03\x77\x0e"
+			     "\xa5\x19\xb0\x47\xde\x52\xe9\x80"
+			     "\x17\x8b\x22\xb9\x2d\xc4\x5b\xf2"
+			     "\x66\xfd\x94\x08\x9f\x36\xcd\x41"
+			     "\xd8\x6f\x06\x7a\x11\xa8\x1c\xb3"
+			     "\x4a\xe1\x55\xec\x83\x1a\x8e\x25"
+			     "\xbc\x30\xc7\x5e\xf5\x69\x00\x97"
+			     "\x0b\xa2\x39\xd0\x44\xdb\x72\x09"
+			     "\x7d\x14\xab\x1f\xb6\x4d\xe4\x58"
+			     "\xef\x86\x1d\x91\x28\xbf\x33\xca"
+			     "\x61\xf8\x6c\x03\x9a\x0e\xa5\x3c"
+			     "\xd3\x47\xde\x75\x0c\x80\x17\xae"
+			     "\x22\xb9\x50\xe7\x5b\xf2\x89\x20"
+			     "\x94\x2b\xc2\x36\xcd\x64\xfb\x6f"
+			     "\x06\x9d\x11\xa8\x3f\xd6\x4a\xe1"
+			     "\x78\x0f\x83\x1a\xb1\x25\xbc\x53"
+			     "\xea\x5e\xf5\x8c\x00\x97\x2e\xc5"
+			     "\x39\xd0\x67\xfe\x72\x09\xa0\x14"
+			     "\xab\x42\xd9\x4d\xe4\x7b\x12\x86"
+			     "\x1d\xb4\x28\xbf\x56\xed\x61\xf8"
+			     "\x8f\x03\x9a\x31\xc8\x3c\xd3\x6a"
+			     "\x01\x75\x0c\xa3\x17\xae\x45\xdc"
+			     "\x50\xe7\x7e\x15\x89\x20\xb7\x2b"
+			     "\xc2\x59\xf0\x64\xfb\x92\x06\x9d"
+			     "\x34\xcb\x3f\xd6\x6d\x04\x78\x0f"
+			     "\xa6\x1a\xb1\x48\xdf\x53\xea\x81"
+			     "\x18\x8c\x23\xba\x2e\xc5\x5c\xf3"
+			     "\x67\xfe\x95\x09\xa0\x37\xce\x42"
+			     "\xd9\x70\x07\x7b\x12\xa9\x1d\xb4"
+			     "\x4b\xe2\x56\xed\x84\x1b\x8f\x26"
+			     "\xbd\x31\xc8\x5f\xf6\x6a\x01\x98",
+		.psize = 2048,
+		.digest = "\x4b\x82\xa5\x0e\x72\x01\x0b\xc6",
+	}
+};
+
 static const u8 zeroes[4096] = { [0 ... 4095] = 0 };
 static const u8 ones[4096] = { [0 ... 4095] = 0xff };
 
diff --git a/include/linux/crc64.h b/include/linux/crc64.h
index 70202da51c2c..10b792080374 100644
--- a/include/linux/crc64.h
+++ b/include/linux/crc64.h
@@ -8,11 +8,15 @@
 #include <linux/types.h>
 
 #define CRC64_ROCKSOFT_STRING "crc64-rocksoft"
+#define CRC64_ISO_STRING "crc64-iso"
 
 u64 __pure crc64_be(u64 crc, const void *p, size_t len);
 u64 __pure crc64_iso_generic(u64 crc, const void *p, size_t len);
 u64 __pure crc64_rocksoft_generic(u64 crc, const void *p, size_t len);
 
+u64 crc64_iso(const unsigned char *buffer, size_t len);
+u64 crc64_iso_update(u64 crc, const unsigned char *buffer, size_t len);
+
 u64 crc64_rocksoft(const unsigned char *buffer, size_t len);
 u64 crc64_rocksoft_update(u64 crc, const unsigned char *buffer, size_t len);
 
diff --git a/lib/crc64-iso.c b/lib/crc64-iso.c
new file mode 100644
index 000000000000..d6e803124fa0
--- /dev/null
+++ b/lib/crc64-iso.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/crc64.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <crypto/hash.h>
+#include <crypto/algapi.h>
+#include <linux/static_key.h>
+#include <linux/notifier.h>
+
+static struct crypto_shash __rcu *crc64_iso_tfm;
+static DEFINE_STATIC_KEY_TRUE(crc64_iso_fallback);
+static DEFINE_MUTEX(crc64_iso_mutex);
+static struct work_struct crc64_iso_rehash_work;
+
+static int crc64_iso_notify(struct notifier_block *self, unsigned long val, void *data)
+{
+	struct crypto_alg *alg = data;
+
+	if (val != CRYPTO_MSG_ALG_LOADED ||
+	    strcmp(alg->cra_name, CRC64_ISO_STRING))
+		return NOTIFY_DONE;
+
+	schedule_work(&crc64_iso_rehash_work);
+	return NOTIFY_OK;
+}
+
+static void crc64_iso_rehash(struct work_struct *work)
+{
+	struct crypto_shash *new, *old;
+
+	mutex_lock(&crc64_iso_mutex);
+	old = rcu_dereference_protected(crc64_iso_tfm,
+					lockdep_is_held(&crc64_iso_mutex));
+	new = crypto_alloc_shash(CRC64_ISO_STRING, 0, 0);
+	if (IS_ERR(new)) {
+		mutex_unlock(&crc64_iso_mutex);
+		return;
+	}
+	rcu_assign_pointer(crc64_iso_tfm, new);
+	mutex_unlock(&crc64_iso_mutex);
+
+	if (old) {
+		synchronize_rcu();
+		crypto_free_shash(old);
+	} else {
+		static_branch_disable(&crc64_iso_fallback);
+	}
+}
+
+static struct notifier_block crc64_iso_nb = {
+	.notifier_call = crc64_iso_notify,
+};
+
+u64 crc64_iso_update(u64 crc, const unsigned char *buffer, size_t len)
+{
+	struct {
+		struct shash_desc shash;
+		u64 crc;
+	} desc;
+	int err;
+
+	if (static_branch_unlikely(&crc64_iso_fallback))
+		return crc64_iso_generic(crc, buffer, len);
+
+	rcu_read_lock();
+	desc.shash.tfm = rcu_dereference(crc64_iso_tfm);
+	desc.crc = crc;
+	err = crypto_shash_update(&desc.shash, buffer, len);
+	rcu_read_unlock();
+
+	WARN_ON_ONCE(err);
+
+	return desc.crc;
+}
+EXPORT_SYMBOL_GPL(crc64_iso_update);
+
+u64 crc64_iso(const unsigned char *buffer, size_t len)
+{
+	return crc64_iso_update(0, buffer, len);
+}
+EXPORT_SYMBOL_GPL(crc64_iso);
+
+static int __init crc64_iso_mod_init(void)
+{
+	INIT_WORK(&crc64_iso_rehash_work, crc64_iso_rehash);
+	crypto_register_notifier(&crc64_iso_nb);
+	crc64_iso_rehash(&crc64_iso_rehash_work);
+	return 0;
+}
+
+static void __exit crc64_iso_mod_fini(void)
+{
+	crypto_unregister_notifier(&crc64_iso_nb);
+	cancel_work_sync(&crc64_iso_rehash_work);
+	crypto_free_shash(rcu_dereference_protected(crc64_iso_tfm, 1));
+}
+
+module_init(crc64_iso_mod_init);
+module_exit(crc64_iso_mod_fini);
+
+static int crc64_iso_transform_show(char *buffer, const struct kernel_param *kp)
+{
+	struct crypto_shash *tfm;
+	int len;
+
+	if (static_branch_unlikely(&crc64_iso_fallback))
+		return sprintf(buffer, "fallback\n");
+
+	rcu_read_lock();
+	tfm = rcu_dereference(crc64_iso_tfm);
+	len = snprintf(buffer, PAGE_SIZE, "%s\n",
+		       crypto_shash_driver_name(tfm));
+	rcu_read_unlock();
+
+	return len;
+}
+
+module_param_call(transform, NULL, crc64_iso_transform_show, NULL, 0444);
+
+MODULE_AUTHOR("Kamlesh Gurudasani <kamlesh@ti.com>");
+MODULE_DESCRIPTION("ISO model CRC64 calculation (library API)");
+MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: crc64");

-- 
2.34.1

