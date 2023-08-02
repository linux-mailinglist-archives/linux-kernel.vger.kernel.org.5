Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED0B76CB7A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjHBLHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjHBLHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:07:49 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C670E4C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:07:46 -0700 (PDT)
X-ASG-Debug-ID: 1690974462-1eb14e747c08800001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id D5OitRhmYR9E5rJI (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 02 Aug 2023 19:07:42 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Wed, 2 Aug
 2023 19:07:41 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Wed, 2 Aug
 2023 19:07:39 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <TonyWWang-oc@zhaoxin.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <seanjc@google.com>, <kim.phillips@amd.com>,
        <peterz@infradead.org>, <pbonzini@redhat.com>,
        <pawan.kumar.gupta@linux.intel.com>, <babu.moger@amd.com>,
        <jiaxi.chen@linux.intel.com>, <jmattson@google.com>,
        <sandipan.das@amd.com>, <linux-crypto@vger.kernel.org>
CC:     <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH] crypto: Zhaoxin: Hardware Engine Driver for SHA1/256/384/512
Date:   Wed, 2 Aug 2023 19:07:41 +0800
X-ASG-Orig-Subj: [PATCH] crypto: Zhaoxin: Hardware Engine Driver for SHA1/256/384/512
Message-ID: <20230802110741.4077-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.65.162]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1690974462
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 17075
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.112209
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is developed to take advantage of the hardware
accelerating engine for SHA1/256/384/512 on Zhaoxin CPUs with
Family 7 and newer.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/include/asm/cpufeatures.h |   2 +
 drivers/crypto/Kconfig             |  15 +
 drivers/crypto/Makefile            |   1 +
 drivers/crypto/zhaoxin-sha.c       | 500 +++++++++++++++++++++++++++++
 drivers/crypto/zhaoxin-sha.h       |  25 ++
 5 files changed, 543 insertions(+)
 create mode 100644 drivers/crypto/zhaoxin-sha.c
 create mode 100644 drivers/crypto/zhaoxin-sha.h

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index cb8ca46213be..37c6edbc4add 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -156,6 +156,8 @@
 #define X86_FEATURE_PHE_EN		( 5*32+11) /* PHE enabled */
 #define X86_FEATURE_PMM			( 5*32+12) /* PadLock Montgomery Multiplier */
 #define X86_FEATURE_PMM_EN		( 5*32+13) /* PMM enabled */
+#define X86_FEATURE_PHE2		( 5*32+25) /* "phe2" Zhaoxin Hash Engine */
+#define X86_FEATURE_PHE2_EN		( 5*32+26) /* "phe2_en" PHE2 enabled */
 
 /* More extended AMD flags: CPUID level 0x80000001, ECX, word 6 */
 #define X86_FEATURE_LAHF_LM		( 6*32+ 0) /* LAHF/SAHF in long mode */
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 44e44b8d9ce6..ff466c8367db 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -798,4 +798,19 @@ config CRYPTO_DEV_SA2UL
 source "drivers/crypto/aspeed/Kconfig"
 source "drivers/crypto/starfive/Kconfig"
 
+config CRYPTO_DEV_ZHAOXIN_SHA
+	tristate "Support for Zhaoxin SHA1/SHA256/SHA384/SHA512 algorithms"
+	select CRYPTO_HASH
+	select CRYPTO_SHA1
+	select CRYPTO_SHA256
+	select CRYPTO_SHA384
+	select CRYPTO_SHA512
+	help
+	  Use Zhaoxin HW engine for SHA1/SHA256/SHA384/SHA512 algorithms.
+
+	  Available in ZX-C+ and newer processors.
+
+	  If unsure say M. The compiled module will be
+	  called zhaoxin-sha.
+
 endif # CRYPTO_HW
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index d859d6a5f3a4..b77c02d6dab7 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -51,3 +51,4 @@ obj-y += hisilicon/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
 obj-y += intel/
 obj-y += starfive/
+obj-$(CONFIG_CRYPTO_DEV_ZHAOXIN_SHA) += zhaoxin-sha.o
diff --git a/drivers/crypto/zhaoxin-sha.c b/drivers/crypto/zhaoxin-sha.c
new file mode 100644
index 000000000000..2da234a9e8b2
--- /dev/null
+++ b/drivers/crypto/zhaoxin-sha.c
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Cryptographic API.
+ *
+ * Support for Zhaoxin hardware crypto engine.
+ *
+ * Copyright (c) 2023  George Xue <georgexue@zhaoxin.com>
+ */
+
+#include <crypto/internal/hash.h>
+#include "zhaoxin-sha.h"
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/scatterlist.h>
+#include <asm/cpu_device_id.h>
+#include <asm/fpu/api.h>
+
+
+static inline void zhaoxin_output_block(uint32_t *src,
+			uint32_t *dst, size_t count)
+{
+	while (count--)
+		*dst++ = swab32(*src++);
+}
+
+/* Add two shash_alg instance for hardware-implemented */
+static int zhaoxin_sha1_init(struct shash_desc *desc)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+
+	*sctx = (struct sha1_state){
+		.state = { SHA1_H0, SHA1_H1, SHA1_H2, SHA1_H3, SHA1_H4 },
+	};
+
+	return 0;
+}
+
+static int zhaoxin_sha1_update(struct shash_desc *desc,
+			const u8 *data,	unsigned int len)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+	unsigned int partial, done;
+	const u8 *src;
+	/*The PHE require the out buffer must 128 bytes and 16-bytes aligned*/
+	u8 buf[128 + ZHAOXIN_SHA_ALIGNMENT - STACK_ALIGN] __attribute__
+		((aligned(STACK_ALIGN)));
+	u8 *dst = PTR_ALIGN(&buf[0], ZHAOXIN_SHA_ALIGNMENT);
+
+	partial = sctx->count & 0x3f;
+	sctx->count += len;
+	done = 0;
+	src = data;
+	memcpy(dst, (u8 *)(sctx->state), SHA1_DIGEST_SIZE);
+
+	if ((partial + len) >= SHA1_BLOCK_SIZE) {
+
+		/* Append the bytes in state's buffer to a block to handle */
+		if (partial) {
+			done = -partial;
+			memcpy(sctx->buffer + partial, data,
+				done + SHA1_BLOCK_SIZE);
+			src = sctx->buffer;
+			asm volatile (".byte 0xf3,0x0f,0xa6,0xc8"
+			: "+S"(src), "+D"(dst)
+			: "a"((long)-1), "c"(1UL));
+			done += SHA1_BLOCK_SIZE;
+			src = data + done;
+		}
+
+		/* Process the left bytes from the input data */
+		if (len - done >= SHA1_BLOCK_SIZE) {
+			asm volatile (".byte 0xf3,0x0f,0xa6,0xc8"
+			: "+S"(src), "+D"(dst)
+			: "a"((long)-1),
+			"c"((unsigned long)((len - done) / SHA1_BLOCK_SIZE)));
+			done += ((len - done) - (len - done) % SHA1_BLOCK_SIZE);
+			src = data + done;
+		}
+		partial = 0;
+	}
+	memcpy((u8 *)(sctx->state), dst, SHA1_DIGEST_SIZE);
+	memcpy(sctx->buffer + partial, src, len - done);
+
+	return 0;
+}
+
+static int zhaoxin_sha1_final(struct shash_desc *desc, u8 *out)
+{
+	struct sha1_state *state = (struct sha1_state *)shash_desc_ctx(desc);
+	unsigned int partial, padlen;
+	__be64 bits;
+	static const u8 padding[64] = { 0x80, };
+
+	bits = cpu_to_be64(state->count << 3);
+
+	/* Pad out to 56 mod 64 */
+	partial = state->count & 0x3f;
+	padlen = (partial < 56) ? (56 - partial) : ((64+56) - partial);
+	zhaoxin_sha1_update(desc, padding, padlen);
+
+	/* Append length field bytes */
+	zhaoxin_sha1_update(desc, (const u8 *)&bits, sizeof(bits));
+
+	/* Swap to output */
+	zhaoxin_output_block((uint32_t *)(state->state), (uint32_t *)out, 5);
+
+	return 0;
+}
+
+static int zhaoxin_sha256_init(struct shash_desc *desc)
+{
+	struct sha256_state *sctx = shash_desc_ctx(desc);
+
+	*sctx = (struct sha256_state){
+		.state = { SHA256_H0, SHA256_H1, SHA256_H2, SHA256_H3,
+				SHA256_H4, SHA256_H5, SHA256_H6, SHA256_H7},
+	};
+
+	return 0;
+}
+
+static int zhaoxin_sha256_update(struct shash_desc *desc, const u8 *data,
+			  unsigned int len)
+{
+	struct sha256_state *sctx = shash_desc_ctx(desc);
+	unsigned int partial, done;
+	const u8 *src;
+	/*The PHE require the out buffer must 128 bytes and 16-bytes aligned*/
+	u8 buf[128 + ZHAOXIN_SHA_ALIGNMENT - STACK_ALIGN] __attribute__
+		((aligned(STACK_ALIGN)));
+	u8 *dst = PTR_ALIGN(&buf[0], ZHAOXIN_SHA_ALIGNMENT);
+
+	partial = sctx->count & 0x3f;
+	sctx->count += len;
+	done = 0;
+	src = data;
+	memcpy(dst, (u8 *)(sctx->state), SHA256_DIGEST_SIZE);
+
+	if ((partial + len) >= SHA256_BLOCK_SIZE) {
+
+		/* Append the bytes in state's buffer to a block to handle */
+		if (partial) {
+			done = -partial;
+			memcpy(sctx->buf + partial, data,
+				done + SHA256_BLOCK_SIZE);
+			src = sctx->buf;
+			asm volatile (".byte 0xf3,0x0f,0xa6,0xd0"
+			: "+S"(src), "+D"(dst)
+			: "a"((long)-1), "c"(1UL));
+			done += SHA256_BLOCK_SIZE;
+			src = data + done;
+		}
+
+		/* Process the left bytes from input data*/
+		if (len - done >= SHA256_BLOCK_SIZE) {
+			asm volatile (".byte 0xf3,0x0f,0xa6,0xd0"
+			: "+S"(src), "+D"(dst)
+			: "a"((long)-1),
+			"c"((unsigned long)((len - done) / 64)));
+			done += ((len - done) - (len - done) % 64);
+			src = data + done;
+		}
+		partial = 0;
+	}
+	memcpy((u8 *)(sctx->state), dst, SHA256_DIGEST_SIZE);
+	memcpy(sctx->buf + partial, src, len - done);
+
+	return 0;
+}
+
+static int zhaoxin_sha256_final(struct shash_desc *desc, u8 *out)
+{
+	struct sha256_state *state =
+		(struct sha256_state *)shash_desc_ctx(desc);
+	unsigned int partial, padlen;
+	__be64 bits;
+	static const u8 padding[64] = { 0x80, };
+
+	bits = cpu_to_be64(state->count << 3);
+
+	/* Pad out to 56 mod 64 */
+	partial = state->count & 0x3f;
+	padlen = (partial < 56) ? (56 - partial) : ((64+56) - partial);
+	zhaoxin_sha256_update(desc, padding, padlen);
+
+	/* Append length field bytes */
+	zhaoxin_sha256_update(desc, (const u8 *)&bits, sizeof(bits));
+
+	/* Swap to output */
+	zhaoxin_output_block((uint32_t *)(state->state), (uint32_t *)out, 8);
+
+	return 0;
+}
+
+static inline void zhaoxin_output_block_512(uint64_t *src,
+			uint64_t *dst, size_t count)
+{
+	while (count--)
+		*dst++ = swab64(*src++);
+}
+
+static int zhaoxin_sha384_init(struct shash_desc *desc)
+{
+	struct sha512_state *sctx = shash_desc_ctx(desc);
+
+	*sctx = (struct sha512_state){
+		.state = { SHA384_H0, SHA384_H1, SHA384_H2, SHA384_H3,
+				SHA384_H4, SHA384_H5, SHA384_H6, SHA384_H7},
+		.count = {0, 0},
+	};
+
+	return 0;
+}
+
+static int zhaoxin_sha512_init(struct shash_desc *desc)
+{
+	struct sha512_state *sctx = shash_desc_ctx(desc);
+
+	*sctx = (struct sha512_state){
+		.state = { SHA512_H0, SHA512_H1, SHA512_H2, SHA512_H3,
+				SHA512_H4, SHA512_H5, SHA512_H6, SHA512_H7},
+		.count = {0, 0},
+	};
+
+	return 0;
+}
+
+static int zhaoxin_sha512_update(struct shash_desc *desc, const u8 *data,
+			  unsigned int len)
+{
+	struct sha512_state *sctx = shash_desc_ctx(desc);
+	unsigned int partial, done;
+
+	const u8 *src;
+	/*The PHE require the out buffer must 128 bytes and 16-bytes aligned*/
+	u8 buf[128 + ZHAOXIN_SHA_ALIGNMENT - STACK_ALIGN] __attribute__
+		((aligned(STACK_ALIGN)));
+	u8 *dst = PTR_ALIGN(&buf[0], ZHAOXIN_SHA_ALIGNMENT);
+
+	partial = sctx->count[0] % SHA512_BLOCK_SIZE;
+
+	sctx->count[0] += len;
+	if (sctx->count[0] < len)
+		sctx->count[1]++;
+
+	done = 0;
+	src = data;
+	memcpy(dst, (u8 *)(sctx->state), SHA512_DIGEST_SIZE);
+
+	if ((partial + len) >= SHA512_BLOCK_SIZE) {
+		/* Append the bytes in state's buffer to a block to handle */
+		if (partial) {
+
+			done = -partial;
+			memcpy(sctx->buf + partial, data, done + SHA512_BLOCK_SIZE);
+
+			src = sctx->buf;
+
+			asm volatile (".byte 0xf3,0x0f,0xa6,0xe0"
+			: "+S"(src), "+D"(dst)
+			: "c"(1UL));
+
+			done += SHA512_BLOCK_SIZE;
+			src = data + done;
+		}
+
+		/* Process the left bytes from input data*/
+		if (len - done >= SHA512_BLOCK_SIZE) {
+			asm volatile (".byte 0xf3,0x0f,0xa6,0xe0"
+			: "+S"(src), "+D"(dst)
+			: "c"((unsigned long)((len - done) / SHA512_BLOCK_SIZE)));
+
+			done += ((len - done) - (len - done) % SHA512_BLOCK_SIZE);
+			src = data + done;
+		}
+		partial = 0;
+	}
+
+	memcpy((u8 *)(sctx->state), dst, SHA512_DIGEST_SIZE);
+	memcpy(sctx->buf + partial, src, len - done);
+
+	return 0;
+}
+
+static int zhaoxin_sha512_final(struct shash_desc *desc, u8 *out)
+{
+	struct sha512_state *state =
+		(struct sha512_state *)shash_desc_ctx(desc);
+	unsigned int partial = state->count[0] % SHA512_BLOCK_SIZE, padlen;
+
+	__be64 bits2[2];
+
+	int dgst_size = crypto_shash_digestsize(desc->tfm);
+
+	static u8 padding[SHA512_BLOCK_SIZE] = { 0x80, };
+
+	memset(padding, 0, SHA512_BLOCK_SIZE);
+	padding[0] = 0x80;
+
+	bits2[0] = cpu_to_be64(state->count[1] << 3 | state->count[0] >> 61);
+	bits2[1] = cpu_to_be64(state->count[0] << 3);
+
+	padlen = (partial < 112) ? (112 - partial) : ((SHA512_BLOCK_SIZE + 112) - partial);
+
+	zhaoxin_sha512_update(desc, padding, padlen);
+
+	/* Append length field bytes */
+	zhaoxin_sha512_update(desc, (const u8 *)bits2, sizeof(__be64[2]));
+
+	/* Swap to output */
+	zhaoxin_output_block_512((uint64_t *)(state->state), (uint64_t *)out, dgst_size/sizeof(uint64_t));
+
+	return 0;
+}
+
+static int zhaoxin_sha_export(struct shash_desc *desc,
+				void *out)
+{
+	int statesize = crypto_shash_statesize(desc->tfm);
+	void *sctx = shash_desc_ctx(desc);
+
+	memcpy(out, sctx, statesize);
+	return 0;
+}
+
+static int zhaoxin_sha_import(struct shash_desc *desc,
+				const void *in)
+{
+	int statesize = crypto_shash_statesize(desc->tfm);
+	void *sctx = shash_desc_ctx(desc);
+
+	memcpy(sctx, in, statesize);
+	return 0;
+}
+
+static struct shash_alg sha1_alg = {
+	.digestsize	=	SHA1_DIGEST_SIZE,
+	.init		=	zhaoxin_sha1_init,
+	.update		=	zhaoxin_sha1_update,
+	.final		=	zhaoxin_sha1_final,
+	.export		=	zhaoxin_sha_export,
+	.import		=	zhaoxin_sha_import,
+	.descsize	=	sizeof(struct sha1_state),
+	.statesize	=	sizeof(struct sha1_state),
+	.base		=	{
+		.cra_name		=	"sha1",
+		.cra_driver_name	=	"sha1-zhaoxin",
+		.cra_priority		=	ZHAOXIN_SHA_CRA_PRIORITY,
+		.cra_blocksize		=	SHA1_BLOCK_SIZE,
+		.cra_module		=	THIS_MODULE,
+	}
+};
+
+static struct shash_alg sha256_alg = {
+	.digestsize	=	SHA256_DIGEST_SIZE,
+	.init		=	zhaoxin_sha256_init,
+	.update		=	zhaoxin_sha256_update,
+	.final		=	zhaoxin_sha256_final,
+	.export		=	zhaoxin_sha_export,
+	.import		=	zhaoxin_sha_import,
+	.descsize	=	sizeof(struct sha256_state),
+	.statesize	=	sizeof(struct sha256_state),
+	.base		=	{
+		.cra_name		=	"sha256",
+		.cra_driver_name	=	"sha256-zhaoxin",
+		.cra_priority		=	ZHAOXIN_SHA_CRA_PRIORITY,
+		.cra_blocksize		=	SHA256_BLOCK_SIZE,
+		.cra_module		=	THIS_MODULE,
+	}
+};
+
+static struct shash_alg sha384_alg = {
+	.digestsize	=	SHA384_DIGEST_SIZE,
+	.init		=	zhaoxin_sha384_init,
+	.update		=	zhaoxin_sha512_update,
+	.final		=	zhaoxin_sha512_final,
+	.export		=	zhaoxin_sha_export,
+	.import		=	zhaoxin_sha_import,
+	.descsize	=	sizeof(struct sha512_state),
+	.statesize	=	sizeof(struct sha512_state),
+	.base		=	{
+		.cra_name		=	"sha384",
+		.cra_driver_name	=	"sha384-zhaoxin",
+		.cra_priority		=	ZHAOXIN_SHA_CRA_PRIORITY,
+		.cra_blocksize		=	SHA384_BLOCK_SIZE,
+		.cra_module		=	THIS_MODULE,
+	}
+};
+
+static struct shash_alg sha512_alg = {
+	.digestsize	=	SHA512_DIGEST_SIZE,
+	.init		=	zhaoxin_sha512_init,
+	.update		=	zhaoxin_sha512_update,
+	.final		=	zhaoxin_sha512_final,
+	.export		=	zhaoxin_sha_export,
+	.import		=	zhaoxin_sha_import,
+	.descsize	=	sizeof(struct sha512_state),
+	.statesize	=	sizeof(struct sha512_state),
+	.base		=	{
+		.cra_name		=	"sha512",
+		.cra_driver_name	=	"sha512-zhaoxin",
+		.cra_priority		=	ZHAOXIN_SHA_CRA_PRIORITY,
+		.cra_blocksize		=	SHA512_BLOCK_SIZE,
+		.cra_module		=	THIS_MODULE,
+	}
+};
+
+
+static const struct x86_cpu_id zhaoxin_sha_ids[] = {
+	X86_MATCH_VENDOR_FAM_FEATURE(ZHAOXIN, 6, X86_FEATURE_PHE, NULL),
+	X86_MATCH_VENDOR_FAM_FEATURE(ZHAOXIN, 7, X86_FEATURE_PHE, NULL),
+	X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 7, X86_FEATURE_PHE, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, zhaoxin_sha_ids);
+
+static int __init zhaoxin_sha_init(void)
+{
+	int rc = -ENODEV;
+
+	struct shash_alg *sha1;
+	struct shash_alg *sha256;
+	struct shash_alg *sha384;
+	struct shash_alg *sha512;
+
+	if (!x86_match_cpu(zhaoxin_sha_ids) || !boot_cpu_has(X86_FEATURE_PHE_EN))
+		return -ENODEV;
+
+	sha1 = &sha1_alg;
+	sha256 = &sha256_alg;
+	sha384 = &sha384_alg;
+	sha512 = &sha512_alg;
+
+
+	rc = crypto_register_shash(sha1);
+	if (rc)
+		goto out;
+
+	rc = crypto_register_shash(sha256);
+	if (rc)
+		goto out_unreg1;
+
+	if (boot_cpu_has(X86_FEATURE_PHE2_EN)) {
+		rc = crypto_register_shash(sha384);
+		if (rc)
+			goto out_unreg2;
+
+		rc = crypto_register_shash(sha512);
+		if (rc)
+			goto out_unreg3;
+	}
+
+	pr_notice(PFX "Using Zhaoxin Hardware Engine for SHA1/SHA256/SHA384/SHA512 algorithms.\n");
+
+	return 0;
+
+out_unreg3:
+	if (boot_cpu_has(X86_FEATURE_PHE2_EN))
+		crypto_unregister_shash(sha384);
+
+out_unreg2:
+	crypto_unregister_shash(sha256);
+out_unreg1:
+	crypto_unregister_shash(sha1);
+
+out:
+	pr_err(PFX "Zhaoxin Hardware Engine for SHA1/SHA256/SHA384/SHA512 initialization failed.\n");
+	return rc;
+}
+
+static void __exit zhaoxin_sha_fini(void)
+{
+	crypto_unregister_shash(&sha1_alg);
+	crypto_unregister_shash(&sha256_alg);
+
+	if (boot_cpu_has(X86_FEATURE_PHE2_EN)) {
+		crypto_unregister_shash(&sha384_alg);
+		crypto_unregister_shash(&sha512_alg);
+	}
+
+}
+
+module_init(zhaoxin_sha_init);
+module_exit(zhaoxin_sha_fini);
+
+MODULE_DESCRIPTION("Zhaoxin Hardware SHA1/SHA256/SHA384/SHA512 algorithms support.");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("George Xue");
+
+MODULE_ALIAS_CRYPTO("sha1-zhaoxin");
+MODULE_ALIAS_CRYPTO("sha256-zhaoxin");
+MODULE_ALIAS_CRYPTO("sha384-zhaoxin");
+MODULE_ALIAS_CRYPTO("sha512-zhaoxin");
+
diff --git a/drivers/crypto/zhaoxin-sha.h b/drivers/crypto/zhaoxin-sha.h
new file mode 100644
index 000000000000..c41bc90a650d
--- /dev/null
+++ b/drivers/crypto/zhaoxin-sha.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Zhaoxin SHA
+ *
+ * Copyright (c) 2023 George Xue<georgexue@zhaoxin.com>
+ */
+
+#ifndef _ZHAOXIN_SHA_H
+#define _ZHAOXIN_SHA_H
+
+#define ZHAOXIN_SHA_ALIGNMENT 16
+
+#define PFX	KBUILD_MODNAME ": "
+
+#define ZHAOXIN_SHA_CRA_PRIORITY	300
+#define ZHAOXIN_SHA_COMPOSITE_PRIORITY 400
+
+#ifdef CONFIG_64BIT
+#define STACK_ALIGN 16
+#else
+#define STACK_ALIGN 4
+#endif
+
+#endif	/* _ZHAOXIN_SHA_H */
+
-- 
2.17.1

