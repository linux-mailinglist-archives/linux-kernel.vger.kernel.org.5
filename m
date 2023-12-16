Return-Path: <linux-kernel+bounces-2222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 593378159CF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1101F282EED
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6332E858;
	Sat, 16 Dec 2023 14:13:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2DC31597;
	Sat, 16 Dec 2023 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 3CAF024DC13;
	Sat, 16 Dec 2023 22:13:14 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 16 Dec
 2023 22:13:14 +0800
Received: from ubuntu.localdomain (161.142.156.108) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 16 Dec
 2023 22:13:08 +0800
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] crypto: starfive: Add sm3 support for JH8100
Date: Sat, 16 Dec 2023 22:12:33 +0800
Message-ID: <20231216141234.417498-5-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231216141234.417498-1-jiajie.ho@starfivetech.com>
References: <20231216141234.417498-1-jiajie.ho@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Add driver support for SM3 module in JH8100 SoC. Updated dedicated dma
allows access to 64-bit memory address space.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/Kconfig       |  23 ++
 drivers/crypto/starfive/Makefile      |   3 +
 drivers/crypto/starfive/jh7110-cryp.c |  48 ++-
 drivers/crypto/starfive/jh7110-cryp.h |  59 +++
 drivers/crypto/starfive/jh7110-hash.c |  20 +-
 drivers/crypto/starfive/jh8100-sm3.c  | 532 ++++++++++++++++++++++++++
 6 files changed, 676 insertions(+), 9 deletions(-)
 create mode 100644 drivers/crypto/starfive/jh8100-sm3.c

diff --git a/drivers/crypto/starfive/Kconfig b/drivers/crypto/starfive/Kc=
onfig
index 0fe389e9f932..e05990f90685 100644
--- a/drivers/crypto/starfive/Kconfig
+++ b/drivers/crypto/starfive/Kconfig
@@ -24,3 +24,26 @@ config CRYPTO_DEV_JH7110
 	  skciphers, AEAD and hash functions.
=20
 	  If you choose 'M' here, this module will be called jh7110-crypto.
+
+config CRYPTO_DEV_JH8100
+	tristate "StarFive JH8100 cryptographic engine drivers"
+	depends on (SOC_STARFIVE && DW_AXI_DMAC) || COMPILE_TEST
+	depends on HAS_DMA
+	select CRYPTO_ENGINE
+	select CRYPTO_HMAC
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	select CRYPTO_SM3_GENERIC
+	select CRYPTO_RSA
+	select CRYPTO_AES
+	select CRYPTO_CCM
+	select CRYPTO_GCM
+	select CRYPTO_CBC
+	select CRYPTO_ECB
+	select CRYPTO_CTR
+	help
+	  Support for StarFive JH8100 crypto hardware acceleration engine.
+	  This module provides additional support for SM2 signature verificatio=
n,
+	  SM3 hash/hmac functions and SM4 skcipher.
+
+	  If you choose 'M' here, this module will be called jh8100-crypto.
diff --git a/drivers/crypto/starfive/Makefile b/drivers/crypto/starfive/M=
akefile
index 8c137afe58ad..67717fca3f5d 100644
--- a/drivers/crypto/starfive/Makefile
+++ b/drivers/crypto/starfive/Makefile
@@ -2,3 +2,6 @@
=20
 obj-$(CONFIG_CRYPTO_DEV_JH7110) +=3D jh7110-crypto.o
 jh7110-crypto-objs :=3D jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-=
aes.o
+
+obj-$(CONFIG_CRYPTO_DEV_JH8100) +=3D jh8100-crypto.o
+jh8100-crypto-objs :=3D jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-=
aes.o jh8100-sm3.o
diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starf=
ive/jh7110-cryp.c
index fe33e87f25ab..fb7c19705fbf 100644
--- a/drivers/crypto/starfive/jh7110-cryp.c
+++ b/drivers/crypto/starfive/jh7110-cryp.c
@@ -106,6 +106,26 @@ static irqreturn_t starfive_cryp_irq(int irq, void *=
priv)
 	return IRQ_HANDLED;
 }
=20
+#ifdef CONFIG_CRYPTO_DEV_JH8100
+static irqreturn_t starfive_cryp_irq1(int irq, void *priv)
+{
+	u32 status;
+	u32 mask;
+	struct starfive_cryp_dev *cryp =3D (struct starfive_cryp_dev *)priv;
+
+	mask =3D readl(cryp->base + STARFIVE_SM_IE_MASK_OFFSET);
+	status =3D readl(cryp->base + STARFIVE_SM_IE_FLAG_OFFSET);
+
+	if (status & STARFIVE_SM_IE_FLAG_SM3_DONE) {
+		mask |=3D STARFIVE_SM_IE_MASK_SM3_DONE;
+		writel(mask, cryp->base + STARFIVE_SM_IE_MASK_OFFSET);
+		tasklet_schedule(&cryp->sm3_done);
+	}
+
+	return IRQ_HANDLED;
+}
+#endif
+
 static int starfive_cryp_probe(struct platform_device *pdev)
 {
 	struct starfive_cryp_dev *cryp;
@@ -156,6 +176,16 @@ static int starfive_cryp_probe(struct platform_devic=
e *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "Failed to register interrupt handler\n");
=20
+#ifdef CONFIG_CRYPTO_DEV_JH8100
+	tasklet_init(&cryp->sm3_done, starfive_sm3_done_task, (unsigned long)cr=
yp);
+
+	irq =3D platform_get_irq(pdev, 1);
+	if (irq < 0)
+		return irq;
+
+	ret =3D devm_request_irq(&pdev->dev, irq, starfive_cryp_irq1, 0,
+			       pdev->name, (void *)cryp);
+#endif
 	clk_prepare_enable(cryp->hclk);
 	clk_prepare_enable(cryp->ahb);
 	reset_control_deassert(cryp->rst);
@@ -191,8 +221,17 @@ static int starfive_cryp_probe(struct platform_devic=
e *pdev)
 	if (ret)
 		goto err_algs_rsa;
=20
+#ifdef CONFIG_CRYPTO_DEV_JH8100
+	ret =3D starfive_sm3_register_algs();
+	if (ret)
+		goto err_algs_sm3;
+#endif
 	return 0;
=20
+#ifdef CONFIG_CRYPTO_DEV_JH8100
+err_algs_sm3:
+	starfive_rsa_unregister_algs();
+#endif
 err_algs_rsa:
 	starfive_hash_unregister_algs();
 err_algs_hash:
@@ -213,7 +252,9 @@ static int starfive_cryp_probe(struct platform_device=
 *pdev)
 	reset_control_assert(cryp->rst);
=20
 	tasklet_kill(&cryp->hash_done);
-
+#ifdef CONFIG_CRYPTO_DEV_JH8100
+	tasklet_kill(&cryp->sm3_done);
+#endif
 	return ret;
 }
=20
@@ -226,7 +267,10 @@ static void starfive_cryp_remove(struct platform_dev=
ice *pdev)
 	starfive_rsa_unregister_algs();
=20
 	tasklet_kill(&cryp->hash_done);
-
+#ifdef CONFIG_CRYPTO_DEV_JH8100
+	starfive_sm3_unregister_algs();
+	tasklet_kill(&cryp->sm3_done);
+#endif
 	crypto_engine_stop(cryp->engine);
 	crypto_engine_exit(cryp->engine);
=20
diff --git a/drivers/crypto/starfive/jh7110-cryp.h b/drivers/crypto/starf=
ive/jh7110-cryp.h
index 3f8f0b001d41..e6c8496acbc9 100644
--- a/drivers/crypto/starfive/jh7110-cryp.h
+++ b/drivers/crypto/starfive/jh7110-cryp.h
@@ -19,12 +19,22 @@
 #define STARFIVE_DMA_IN_LEN_OFFSET		0x10
 #define STARFIVE_DMA_OUT_LEN_OFFSET		0x14
=20
+#define STARFIVE_SM_ALG_CR_OFFSET		0x4000
+#define STARFIVE_SM_IE_MASK_OFFSET		(STARFIVE_SM_ALG_CR_OFFSET + 0x4)
+#define STARFIVE_SM_IE_FLAG_OFFSET		(STARFIVE_SM_ALG_CR_OFFSET + 0x8)
+#define STARFIVE_SM_DMA_IN_LEN_OFFSET		(STARFIVE_SM_ALG_CR_OFFSET + 0xc)
+#define STARFIVE_SM_DMA_OUT_LEN_OFFSET		(STARFIVE_SM_ALG_CR_OFFSET + 0x1=
0)
+#define STARFIVE_SM_ALG_FIFO_IN_OFFSET		(STARFIVE_SM_ALG_CR_OFFSET + 0x2=
0)
+#define STARFIVE_SM_ALG_FIFO_OUT_OFFSET		(STARFIVE_SM_ALG_CR_OFFSET + 0x=
28)
+
 #define STARFIVE_IE_MASK_AES_DONE		0x1
 #define STARFIVE_IE_MASK_HASH_DONE		0x4
 #define STARFIVE_IE_MASK_PKA_DONE		0x8
 #define STARFIVE_IE_FLAG_AES_DONE		0x1
 #define STARFIVE_IE_FLAG_HASH_DONE		0x4
 #define STARFIVE_IE_FLAG_PKA_DONE		0x8
+#define STARFIVE_SM_IE_MASK_SM3_DONE		0x2
+#define STARFIVE_SM_IE_FLAG_SM3_DONE		0x2
=20
 #define STARFIVE_MSG_BUFFER_SIZE		SZ_16K
 #define MAX_KEY_SIZE				SHA512_BLOCK_SIZE
@@ -68,6 +78,20 @@ union starfive_aes_csr {
 	};
 };
=20
+union starfive_sm_alg_cr {
+	u32 v;
+	struct {
+		u32 start			:1;
+		u32 sm4_dma_en			:1;
+		u32 sm3_dma_en			:1;
+		u32 rsvd_0			:1;
+		u32 alg_done			:1;
+		u32 rsvd_1			:3;
+		u32 clear			:1;
+		u32 rsvd_2			:23;
+	};
+};
+
 union starfive_hash_csr {
 	u32 v;
 	struct {
@@ -132,6 +156,32 @@ union starfive_pka_casr {
 	};
 };
=20
+union starfive_sm3_csr {
+	u32 v;
+	struct {
+		u32 start			:1;
+		u32 reset			:1;
+		u32 ie				:1;
+		u32 firstb			:1;
+#define STARFIVE_SM3_MODE			0x0
+		u32 mode			:3;
+		u32 rsvd_0			:1;
+		u32 final			:1;
+		u32 rsvd_1			:2;
+#define STARFIVE_SM3_HMAC_FLAGS			0x800
+		u32 hmac			:1;
+		u32 rsvd_2			:1;
+#define STARFIVE_SM3_KEY_DONE			BIT(13)
+		u32 key_done			:1;
+		u32 key_flag			:1;
+		u32 hmac_done			:1;
+#define STARFIVE_SM3_BUSY			BIT(16)
+		u32 busy			:1;
+		u32 hashdone			:1;
+		u32 rsvd_3			:14;
+	};
+};
+
 struct starfive_rsa_key {
 	u8	*n;
 	u8	*e;
@@ -190,6 +240,7 @@ struct starfive_cryp_dev {
 	struct scatter_walk			out_walk;
 	struct crypto_engine			*engine;
 	struct tasklet_struct			hash_done;
+	struct tasklet_struct			sm3_done;
 	struct completion			dma_done;
 	size_t					assoclen;
 	size_t					total_in;
@@ -213,6 +264,7 @@ struct starfive_cryp_request_ctx {
 		union starfive_hash_csr		hash;
 		union starfive_pka_cacr		pka;
 		union starfive_aes_csr		aes;
+		union starfive_sm3_csr		sm3;
 	} csr;
=20
 	struct scatterlist			*in_sg;
@@ -239,4 +291,11 @@ int starfive_aes_register_algs(void);
 void starfive_aes_unregister_algs(void);
=20
 void starfive_hash_done_task(unsigned long param);
+
+#ifdef CONFIG_CRYPTO_DEV_JH8100
+int starfive_sm3_register_algs(void);
+void starfive_sm3_unregister_algs(void);
+
+void starfive_sm3_done_task(unsigned long param);
+#endif
 #endif
diff --git a/drivers/crypto/starfive/jh7110-hash.c b/drivers/crypto/starf=
ive/jh7110-hash.c
index 74e151b5f875..45cf82e64fb8 100644
--- a/drivers/crypto/starfive/jh7110-hash.c
+++ b/drivers/crypto/starfive/jh7110-hash.c
@@ -511,12 +511,6 @@ static int starfive_sha512_init_tfm(struct crypto_ah=
ash *hash)
 				      STARFIVE_HASH_SHA512, 0);
 }
=20
-static int starfive_sm3_init_tfm(struct crypto_ahash *hash)
-{
-	return starfive_hash_init_tfm(hash, "sm3-generic",
-				      STARFIVE_HASH_SM3, 0);
-}
-
 static int starfive_hmac_sha224_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "hmac(sha224-generic)",
@@ -541,11 +535,19 @@ static int starfive_hmac_sha512_init_tfm(struct cry=
pto_ahash *hash)
 				      STARFIVE_HASH_SHA512, 1);
 }
=20
+#ifndef CONFIG_CRYPTO_DEV_JH8100
+static int starfive_sm3_init_tfm(struct crypto_ahash *hash)
+{
+	return starfive_hash_init_tfm(hash, "sm3-generic",
+				      STARFIVE_HASH_SM3, 0);
+}
+
 static int starfive_hmac_sm3_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "hmac(sm3-generic)",
 				      STARFIVE_HASH_SM3, 1);
 }
+#endif
=20
 static struct ahash_engine_alg algs_sha2_sm3[] =3D {
 {
@@ -776,7 +778,10 @@ static struct ahash_engine_alg algs_sha2_sm3[] =3D {
 	.op =3D {
 		.do_one_request =3D starfive_hash_one_request,
 	},
-}, {
+},
+
+#ifndef CONFIG_CRYPTO_DEV_JH8100
+{
 	.base.init     =3D starfive_hash_init,
 	.base.update   =3D starfive_hash_update,
 	.base.final    =3D starfive_hash_final,
@@ -834,6 +839,7 @@ static struct ahash_engine_alg algs_sha2_sm3[] =3D {
 		.do_one_request =3D starfive_hash_one_request,
 	},
 },
+#endif
 };
=20
 int starfive_hash_register_algs(void)
diff --git a/drivers/crypto/starfive/jh8100-sm3.c b/drivers/crypto/starfi=
ve/jh8100-sm3.c
new file mode 100644
index 000000000000..7289c5fba0d8
--- /dev/null
+++ b/drivers/crypto/starfive/jh8100-sm3.c
@@ -0,0 +1,532 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SM3 Hash function and HMAC support for StarFive driver
+ *
+ * Copyright (c) 2022 - 2023 StarFive Technology
+ *
+ */
+
+#include <crypto/engine.h>
+#include <crypto/hash.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/internal/hash.h>
+#include "jh7110-cryp.h"
+#include <linux/crypto.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+
+#define STARFIVE_SM3_REGS_OFFSET	0x4200
+#define STARFIVE_SM3_CSR		(STARFIVE_SM3_REGS_OFFSET + 0x0)
+#define STARFIVE_SM3_WDR		(STARFIVE_SM3_REGS_OFFSET + 0x4)
+#define STARFIVE_SM3_RDR		(STARFIVE_SM3_REGS_OFFSET + 0x8)
+#define STARFIVE_SM3_WSR		(STARFIVE_SM3_REGS_OFFSET + 0xC)
+#define STARFIVE_SM3_WLEN3		(STARFIVE_SM3_REGS_OFFSET + 0x10)
+#define STARFIVE_SM3_WLEN2		(STARFIVE_SM3_REGS_OFFSET + 0x14)
+#define STARFIVE_SM3_WLEN1		(STARFIVE_SM3_REGS_OFFSET + 0x18)
+#define STARFIVE_SM3_WLEN0		(STARFIVE_SM3_REGS_OFFSET + 0x1C)
+#define STARFIVE_SM3_WKR		(STARFIVE_SM3_REGS_OFFSET + 0x20)
+#define STARFIVE_SM3_WKLEN		(STARFIVE_SM3_REGS_OFFSET + 0x24)
+
+#define STARFIVE_SM3_BUFLEN		SHA512_BLOCK_SIZE
+#define STARFIVE_SM3_RESET		0x2
+
+static inline int starfive_sm3_wait_busy(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	u32 status;
+
+	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_SM3_CSR, status=
,
+					  !(status & STARFIVE_SM3_BUSY), 10, 100000);
+}
+
+static inline int starfive_sm3_wait_key_done(struct starfive_cryp_ctx *c=
tx)
+{
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	u32 status;
+
+	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_SM3_CSR, status=
,
+					  (status & STARFIVE_SM3_KEY_DONE), 10, 100000);
+}
+
+static int starfive_sm3_hmac_key(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_request_ctx *rctx =3D ctx->rctx;
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	int klen =3D ctx->keylen, loop;
+	unsigned int *key =3D (unsigned int *)ctx->key;
+	unsigned char *cl;
+
+	writel(ctx->keylen, cryp->base + STARFIVE_SM3_WKLEN);
+
+	rctx->csr.sm3.hmac =3D 1;
+	rctx->csr.sm3.key_flag =3D 1;
+
+	writel(rctx->csr.sm3.v, cryp->base + STARFIVE_SM3_CSR);
+
+	for (loop =3D 0; loop < klen / sizeof(unsigned int); loop++, key++)
+		writel(*key, cryp->base + STARFIVE_SM3_WKR);
+
+	if (klen & 0x3) {
+		cl =3D (unsigned char *)key;
+		for (loop =3D 0; loop < (klen & 0x3); loop++, cl++)
+			writeb(*cl, cryp->base + STARFIVE_SM3_WKR);
+	}
+
+	if (starfive_sm3_wait_key_done(ctx))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT,
+				     "starfive_sm3_wait_key_done error\n");
+
+	return 0;
+}
+
+static void starfive_sm3_start(struct starfive_cryp_dev *cryp)
+{
+	union starfive_sm3_csr csr;
+	u32 mask;
+
+	csr.v =3D readl(cryp->base + STARFIVE_SM3_CSR);
+	csr.firstb =3D 0;
+	csr.final =3D 1;
+	csr.ie =3D 1;
+	writel(csr.v, cryp->base + STARFIVE_SM3_CSR);
+
+	mask =3D readl(cryp->base + STARFIVE_SM_IE_MASK_OFFSET);
+	mask &=3D ~STARFIVE_SM_IE_MASK_SM3_DONE;
+	writel(mask, cryp->base + STARFIVE_SM_IE_MASK_OFFSET);
+}
+
+static void starfive_sm3_dma_callback(void *param)
+{
+	struct starfive_cryp_dev *cryp =3D param;
+
+	complete(&cryp->dma_done);
+}
+
+static void starfive_sm3_dma_init(struct starfive_cryp_dev *cryp)
+{
+	cryp->cfg_in.direction =3D DMA_MEM_TO_DEV;
+	cryp->cfg_in.src_addr_width =3D DMA_SLAVE_BUSWIDTH_8_BYTES;
+	cryp->cfg_in.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_8_BYTES;
+	cryp->cfg_in.src_maxburst =3D cryp->dma_maxburst;
+	cryp->cfg_in.dst_maxburst =3D cryp->dma_maxburst;
+	cryp->cfg_in.dst_addr =3D cryp->phys_base + STARFIVE_SM_ALG_FIFO_IN_OFF=
SET;
+
+	dmaengine_slave_config(cryp->tx, &cryp->cfg_in);
+
+	init_completion(&cryp->dma_done);
+}
+
+static int starfive_sm3_dma_xfer(struct starfive_cryp_dev *cryp,
+				 struct scatterlist *sg)
+{
+	struct dma_async_tx_descriptor *in_desc;
+	union  starfive_sm_alg_cr alg_cr;
+	int ret =3D 0;
+
+	alg_cr.v =3D 0;
+	alg_cr.start =3D 1;
+	alg_cr.sm3_dma_en =3D 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_SM_ALG_CR_OFFSET);
+
+	writel(sg_dma_len(sg), cryp->base + STARFIVE_SM_DMA_IN_LEN_OFFSET);
+	sg_dma_len(sg) =3D ALIGN(sg_dma_len(sg), sizeof(u32));
+
+	in_desc =3D dmaengine_prep_slave_sg(cryp->tx, sg, 1, DMA_MEM_TO_DEV,
+					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!in_desc) {
+		ret =3D -EINVAL;
+		goto end;
+	}
+
+	reinit_completion(&cryp->dma_done);
+	in_desc->callback =3D starfive_sm3_dma_callback;
+	in_desc->callback_param =3D cryp;
+
+	dmaengine_submit(in_desc);
+	dma_async_issue_pending(cryp->tx);
+
+	if (!wait_for_completion_timeout(&cryp->dma_done,
+					 msecs_to_jiffies(1000)))
+		ret =3D -ETIMEDOUT;
+
+end:
+	alg_cr.v =3D 0;
+	alg_cr.clear =3D 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_SM_ALG_CR_OFFSET);
+
+	return ret;
+}
+
+static int starfive_sm3_copy_hash(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx =3D ahash_request_ctx(req);
+	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(crypto_ahash_reqtfm(=
req));
+	int count, *data;
+	int mlen;
+
+	if (!req->result)
+		return 0;
+
+	mlen =3D rctx->digsize / sizeof(u32);
+	data =3D (u32 *)req->result;
+
+	for (count =3D 0; count < mlen; count++)
+		data[count] =3D readl(ctx->cryp->base + STARFIVE_SM3_RDR);
+
+	return 0;
+}
+
+void starfive_sm3_done_task(unsigned long param)
+{
+	struct starfive_cryp_dev *cryp =3D (struct starfive_cryp_dev *)param;
+	int err;
+
+	err =3D starfive_sm3_copy_hash(cryp->req.hreq);
+
+	/* Reset to clear hash_done in irq register*/
+	writel(STARFIVE_SM3_RESET, cryp->base + STARFIVE_SM3_CSR);
+
+	crypto_finalize_hash_request(cryp->engine, cryp->req.hreq, err);
+}
+
+static int starfive_sm3_one_request(struct crypto_engine *engine, void *=
areq)
+{
+	struct ahash_request *req =3D
+		container_of(areq, struct ahash_request, base);
+	struct starfive_cryp_ctx *ctx =3D
+		crypto_ahash_ctx(crypto_ahash_reqtfm(req));
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx =3D ctx->rctx;
+	struct scatterlist *tsg;
+	int ret, src_nents, i;
+
+	rctx->csr.sm3.v =3D 0;
+	rctx->csr.sm3.reset =3D 1;
+
+	writel(rctx->csr.sm3.v, cryp->base + STARFIVE_SM3_CSR);
+
+	if (starfive_sm3_wait_busy(ctx))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT,
+				     "Error resetting engine.\n");
+
+	rctx->csr.sm3.v =3D 0;
+	rctx->csr.sm3.mode =3D ctx->hash_mode;
+
+	if (ctx->is_hmac) {
+		ret =3D starfive_sm3_hmac_key(ctx);
+		if (ret)
+			return ret;
+	} else {
+		rctx->csr.sm3.start =3D 1;
+		rctx->csr.sm3.firstb =3D 1;
+		writel(rctx->csr.sm3.v, cryp->base + STARFIVE_SM3_CSR);
+	}
+
+	/* No input message, get digest and end. */
+	if (!rctx->total)
+		goto hash_start;
+
+	starfive_sm3_dma_init(cryp);
+
+	for_each_sg(rctx->in_sg, tsg, rctx->in_sg_len, i) {
+		src_nents =3D dma_map_sg(cryp->dev, tsg, 1, DMA_TO_DEVICE);
+		if (src_nents =3D=3D 0)
+			return dev_err_probe(cryp->dev, -ENOMEM,
+					     "dma_map_sg error\n");
+
+		ret =3D starfive_sm3_dma_xfer(cryp, tsg);
+		dma_unmap_sg(cryp->dev, tsg, 1, DMA_TO_DEVICE);
+		if (ret)
+			return ret;
+	}
+
+hash_start:
+	starfive_sm3_start(cryp);
+
+	return 0;
+}
+
+static void starfive_sm3_set_ahash(struct ahash_request *req,
+				   struct starfive_cryp_ctx *ctx,
+				   struct starfive_cryp_request_ctx *rctx)
+{
+	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
+	ahash_request_set_callback(&rctx->ahash_fbk_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete, req->base.data);
+	ahash_request_set_crypt(&rctx->ahash_fbk_req, req->src,
+				req->result, req->nbytes);
+}
+
+static int starfive_sm3_init(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+	struct starfive_cryp_request_ctx *rctx =3D ahash_request_ctx(req);
+	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(tfm);
+
+	starfive_sm3_set_ahash(req, ctx, rctx);
+
+	return crypto_ahash_init(&rctx->ahash_fbk_req);
+}
+
+static int starfive_sm3_update(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx =3D ahash_request_ctx(req);
+	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(tfm);
+
+	starfive_sm3_set_ahash(req, ctx, rctx);
+
+	return crypto_ahash_update(&rctx->ahash_fbk_req);
+}
+
+static int starfive_sm3_final(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx =3D ahash_request_ctx(req);
+	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(tfm);
+
+	starfive_sm3_set_ahash(req, ctx, rctx);
+
+	return crypto_ahash_final(&rctx->ahash_fbk_req);
+}
+
+static int starfive_sm3_finup(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx =3D ahash_request_ctx(req);
+	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(tfm);
+
+	starfive_sm3_set_ahash(req, ctx, rctx);
+
+	return crypto_ahash_finup(&rctx->ahash_fbk_req);
+}
+
+static int starfive_sm3_digest(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(tfm);
+	struct starfive_cryp_request_ctx *rctx =3D ahash_request_ctx(req);
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+
+	memset(rctx, 0, sizeof(struct starfive_cryp_request_ctx));
+
+	cryp->req.hreq =3D req;
+	rctx->total =3D req->nbytes;
+	rctx->in_sg =3D req->src;
+	rctx->blksize =3D crypto_tfm_alg_blocksize(crypto_ahash_tfm(tfm));
+	rctx->digsize =3D crypto_ahash_digestsize(tfm);
+	rctx->in_sg_len =3D sg_nents_for_len(rctx->in_sg, rctx->total);
+	ctx->rctx =3D rctx;
+
+	return crypto_transfer_hash_request_to_engine(cryp->engine, req);
+}
+
+static int starfive_sm3_export(struct ahash_request *req, void *out)
+{
+	struct starfive_cryp_request_ctx *rctx =3D ahash_request_ctx(req);
+	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
+	ahash_request_set_callback(&rctx->ahash_fbk_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete, req->base.data);
+
+	return crypto_ahash_export(&rctx->ahash_fbk_req, out);
+}
+
+static int starfive_sm3_import(struct ahash_request *req, const void *in=
)
+{
+	struct starfive_cryp_request_ctx *rctx =3D ahash_request_ctx(req);
+	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
+	ahash_request_set_callback(&rctx->ahash_fbk_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete, req->base.data);
+
+	return crypto_ahash_import(&rctx->ahash_fbk_req, in);
+}
+
+static int starfive_sm3_init_algo(struct crypto_ahash *hash,
+				  const char *alg_name,
+				  bool is_hmac)
+{
+	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(hash);
+
+	ctx->cryp =3D starfive_cryp_find_dev(ctx);
+	if (!ctx->cryp)
+		return -ENODEV;
+
+	ctx->ahash_fbk =3D crypto_alloc_ahash(alg_name, 0,
+					    CRYPTO_ALG_NEED_FALLBACK);
+
+	if (IS_ERR(ctx->ahash_fbk))
+		return dev_err_probe(ctx->cryp->dev, PTR_ERR(ctx->ahash_fbk),
+				     "starfive-sm3: Could not load fallback driver.\n");
+
+	crypto_ahash_set_statesize(hash, crypto_ahash_statesize(ctx->ahash_fbk)=
);
+	crypto_ahash_set_reqsize(hash, sizeof(struct starfive_cryp_request_ctx)=
 +
+				 crypto_ahash_reqsize(ctx->ahash_fbk));
+
+	ctx->keylen =3D 0;
+	ctx->hash_mode =3D STARFIVE_SM3_MODE;
+	ctx->is_hmac =3D is_hmac;
+
+	return 0;
+}
+
+static void starfive_sm3_exit_tfm(struct crypto_ahash *hash)
+{
+	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(hash);
+
+	crypto_free_ahash(ctx->ahash_fbk);
+}
+
+static int starfive_sm3_long_setkey(struct starfive_cryp_ctx *ctx,
+				    const u8 *key, unsigned int keylen)
+{
+	struct crypto_wait wait;
+	struct ahash_request *req;
+	struct scatterlist sg;
+	struct crypto_ahash *ahash_tfm;
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	u8 *buf;
+	int ret;
+
+	ahash_tfm =3D crypto_alloc_ahash("sm3-starfive", 0, 0);
+	if (IS_ERR(ahash_tfm))
+		return PTR_ERR(ahash_tfm);
+
+	req =3D ahash_request_alloc(ahash_tfm, GFP_KERNEL);
+	if (!req) {
+		ret =3D -ENOMEM;
+		goto err_free_ahash;
+	}
+
+	crypto_init_wait(&wait);
+	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				   crypto_req_done, &wait);
+	crypto_ahash_clear_flags(ahash_tfm, ~0);
+
+	buf =3D devm_kzalloc(cryp->dev, keylen + STARFIVE_SM3_BUFLEN, GFP_KERNE=
L);
+	if (!buf) {
+		ret =3D -ENOMEM;
+		goto err_free_req;
+	}
+
+	memcpy(buf, key, keylen);
+	sg_init_one(&sg, buf, keylen);
+	ahash_request_set_crypt(req, &sg, ctx->key, keylen);
+
+	ret =3D crypto_wait_req(crypto_ahash_digest(req), &wait);
+
+err_free_req:
+	ahash_request_free(req);
+err_free_ahash:
+	crypto_free_ahash(ahash_tfm);
+	return ret;
+}
+
+static int starfive_sm3_setkey(struct crypto_ahash *hash,
+			       const u8 *key, unsigned int keylen)
+{
+	struct starfive_cryp_ctx *ctx =3D crypto_ahash_ctx(hash);
+	unsigned int digestsize =3D crypto_ahash_digestsize(hash);
+	unsigned int blocksize =3D crypto_ahash_blocksize(hash);
+
+	crypto_ahash_setkey(ctx->ahash_fbk, key, keylen);
+
+	if (keylen <=3D blocksize) {
+		memcpy(ctx->key, key, keylen);
+		ctx->keylen =3D keylen;
+		return 0;
+	}
+
+	ctx->keylen =3D digestsize;
+
+	return starfive_sm3_long_setkey(ctx, key, keylen);
+}
+
+static int starfive_sm3_init_tfm(struct crypto_ahash *hash)
+{
+	return starfive_sm3_init_algo(hash, "sm3-generic", 0);
+}
+
+static int starfive_hmac_sm3_init_tfm(struct crypto_ahash *hash)
+{
+	return starfive_sm3_init_algo(hash, "hmac(sm3-generic)", 1);
+}
+
+static struct ahash_engine_alg algs_sm3[] =3D {
+{
+	.base.init	=3D starfive_sm3_init,
+	.base.update	=3D starfive_sm3_update,
+	.base.final	=3D starfive_sm3_final,
+	.base.finup	=3D starfive_sm3_finup,
+	.base.digest	=3D starfive_sm3_digest,
+	.base.export	=3D starfive_sm3_export,
+	.base.import	=3D starfive_sm3_import,
+	.base.init_tfm	=3D starfive_sm3_init_tfm,
+	.base.exit_tfm	=3D starfive_sm3_exit_tfm,
+	.base.halg =3D {
+		.digestsize	=3D SM3_DIGEST_SIZE,
+		.statesize	=3D sizeof(struct sm3_state),
+		.base =3D {
+			.cra_name		=3D "sm3",
+			.cra_driver_name	=3D "sm3-starfive",
+			.cra_priority		=3D 200,
+			.cra_flags		=3D CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		=3D SM3_BLOCK_SIZE,
+			.cra_ctxsize		=3D sizeof(struct starfive_cryp_ctx),
+			.cra_module		=3D THIS_MODULE,
+		}
+	},
+	.op =3D {
+		.do_one_request =3D starfive_sm3_one_request,
+	},
+}, {
+	.base.init	=3D starfive_sm3_init,
+	.base.update	=3D starfive_sm3_update,
+	.base.final	=3D starfive_sm3_final,
+	.base.finup	=3D starfive_sm3_finup,
+	.base.digest	=3D starfive_sm3_digest,
+	.base.export	=3D starfive_sm3_export,
+	.base.import	=3D starfive_sm3_import,
+	.base.init_tfm	=3D starfive_hmac_sm3_init_tfm,
+	.base.exit_tfm	=3D starfive_sm3_exit_tfm,
+	.base.setkey	=3D starfive_sm3_setkey,
+	.base.halg =3D {
+		.digestsize	=3D SM3_DIGEST_SIZE,
+		.statesize	=3D sizeof(struct sm3_state),
+		.base =3D {
+			.cra_name		=3D "hmac(sm3)",
+			.cra_driver_name	=3D "sm3-hmac-starfive",
+			.cra_priority		=3D 200,
+			.cra_flags		=3D CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		=3D SM3_BLOCK_SIZE,
+			.cra_ctxsize		=3D sizeof(struct starfive_cryp_ctx),
+			.cra_module		=3D THIS_MODULE,
+		}
+	},
+	.op =3D {
+		.do_one_request =3D starfive_sm3_one_request,
+	},
+},
+};
+
+int starfive_sm3_register_algs(void)
+{
+	return crypto_engine_register_ahashes(algs_sm3, ARRAY_SIZE(algs_sm3));
+}
+
+void starfive_sm3_unregister_algs(void)
+{
+	crypto_engine_unregister_ahashes(algs_sm3, ARRAY_SIZE(algs_sm3));
+}
--=20
2.34.1


