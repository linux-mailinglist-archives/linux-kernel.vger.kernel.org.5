Return-Path: <linux-kernel+bounces-2223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6643A8159D2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167C52824B9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F1031597;
	Sat, 16 Dec 2023 14:13:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6CE3174A;
	Sat, 16 Dec 2023 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 4DC5A24DC28;
	Sat, 16 Dec 2023 22:13:22 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 16 Dec
 2023 22:13:22 +0800
Received: from ubuntu.localdomain (161.142.156.108) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 16 Dec
 2023 22:13:14 +0800
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] crypto: starfive: Add sm4 support for JH8100
Date: Sat, 16 Dec 2023 22:12:34 +0800
Message-ID: <20231216141234.417498-6-jiajie.ho@starfivetech.com>
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

Add driver support for sm4 skcipher and aead for StarFive JH8100 SoC.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/Kconfig       |    1 +
 drivers/crypto/starfive/Makefile      |    2 +-
 drivers/crypto/starfive/jh7110-cryp.c |    8 +
 drivers/crypto/starfive/jh7110-cryp.h |   39 +
 drivers/crypto/starfive/jh8100-sm4.c  | 1107 +++++++++++++++++++++++++
 5 files changed, 1156 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/starfive/jh8100-sm4.c

diff --git a/drivers/crypto/starfive/Kconfig b/drivers/crypto/starfive/Kc=
onfig
index e05990f90685..90160676160a 100644
--- a/drivers/crypto/starfive/Kconfig
+++ b/drivers/crypto/starfive/Kconfig
@@ -34,6 +34,7 @@ config CRYPTO_DEV_JH8100
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
 	select CRYPTO_SM3_GENERIC
+	select CRYPTO_SM4_GENERIC
 	select CRYPTO_RSA
 	select CRYPTO_AES
 	select CRYPTO_CCM
diff --git a/drivers/crypto/starfive/Makefile b/drivers/crypto/starfive/M=
akefile
index 67717fca3f5d..8370f20427fd 100644
--- a/drivers/crypto/starfive/Makefile
+++ b/drivers/crypto/starfive/Makefile
@@ -4,4 +4,4 @@ obj-$(CONFIG_CRYPTO_DEV_JH7110) +=3D jh7110-crypto.o
 jh7110-crypto-objs :=3D jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-=
aes.o
=20
 obj-$(CONFIG_CRYPTO_DEV_JH8100) +=3D jh8100-crypto.o
-jh8100-crypto-objs :=3D jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-=
aes.o jh8100-sm3.o
+jh8100-crypto-objs :=3D jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-=
aes.o jh8100-sm3.o jh8100-sm4.o
diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starf=
ive/jh7110-cryp.c
index fb7c19705fbf..63b801cd6555 100644
--- a/drivers/crypto/starfive/jh7110-cryp.c
+++ b/drivers/crypto/starfive/jh7110-cryp.c
@@ -225,10 +225,17 @@ static int starfive_cryp_probe(struct platform_devi=
ce *pdev)
 	ret =3D starfive_sm3_register_algs();
 	if (ret)
 		goto err_algs_sm3;
+
+	ret =3D starfive_sm4_register_algs();
+	if (ret)
+		goto err_algs_sm4;
 #endif
+
 	return 0;
=20
 #ifdef CONFIG_CRYPTO_DEV_JH8100
+err_algs_sm4:
+	starfive_sm3_unregister_algs();
 err_algs_sm3:
 	starfive_rsa_unregister_algs();
 #endif
@@ -269,6 +276,7 @@ static void starfive_cryp_remove(struct platform_devi=
ce *pdev)
 	tasklet_kill(&cryp->hash_done);
 #ifdef CONFIG_CRYPTO_DEV_JH8100
 	starfive_sm3_unregister_algs();
+	starfive_sm4_unregister_algs();
 	tasklet_kill(&cryp->sm3_done);
 #endif
 	crypto_engine_stop(cryp->engine);
diff --git a/drivers/crypto/starfive/jh7110-cryp.h b/drivers/crypto/starf=
ive/jh7110-cryp.h
index e6c8496acbc9..8cc941f90a7e 100644
--- a/drivers/crypto/starfive/jh7110-cryp.h
+++ b/drivers/crypto/starfive/jh7110-cryp.h
@@ -7,6 +7,7 @@
 #include <crypto/scatterwalk.h>
 #include <crypto/sha2.h>
 #include <crypto/sm3.h>
+#include <crypto/sm4.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
@@ -182,6 +183,40 @@ union starfive_sm3_csr {
 	};
 };
=20
+union starfive_sm4_csr {
+	u32 v;
+	struct {
+		u32 cmode			:1;
+		u32 rsvd_0			:1;
+		u32 ie				:1;
+		u32 sm4rst			:1;
+		u32 rsvd_1			:1;
+#define STARFIVE_SM4_DONE			BIT(5)
+		u32 sm4done			:1;
+#define STARFIVE_SM4_KEY_DONE			BIT(6)
+		u32 krdy			:1;
+		u32 busy			:1;
+		u32 vsm4_start			:1;
+		u32 delay_sm4			:1;
+#define STARFIVE_SM4_CCM_START			BIT(10)
+		u32 ccm_start			:1;
+#define STARFIVE_SM4_GCM_START			BIT(11)
+		u32 gcm_start			:1;
+		u32 rsvd_2			:4;
+#define STARFIVE_SM4_MODE_XFB_1			0x0
+#define STARFIVE_SM4_MODE_XFB_128		0x5
+		u32 stmode			:3;
+		u32 rsvd_3			:2;
+#define STARFIVE_SM4_MODE_ECB			0x0
+#define STARFIVE_SM4_MODE_CBC			0x1
+#define STARFIVE_SM4_MODE_CTR			0x4
+#define STARFIVE_SM4_MODE_CCM			0x5
+#define STARFIVE_SM4_MODE_GCM			0x6
+		u32 mode			:3;
+		u32 rsvd_4			:8;
+	};
+};
+
 struct starfive_rsa_key {
 	u8	*n;
 	u8	*e;
@@ -265,6 +300,7 @@ struct starfive_cryp_request_ctx {
 		union starfive_pka_cacr		pka;
 		union starfive_aes_csr		aes;
 		union starfive_sm3_csr		sm3;
+		union starfive_sm4_csr		sm4;
 	} csr;
=20
 	struct scatterlist			*in_sg;
@@ -296,6 +332,9 @@ void starfive_hash_done_task(unsigned long param);
 int starfive_sm3_register_algs(void);
 void starfive_sm3_unregister_algs(void);
=20
+int starfive_sm4_register_algs(void);
+void starfive_sm4_unregister_algs(void);
+
 void starfive_sm3_done_task(unsigned long param);
 #endif
 #endif
diff --git a/drivers/crypto/starfive/jh8100-sm4.c b/drivers/crypto/starfi=
ve/jh8100-sm4.c
new file mode 100644
index 000000000000..ccde5fb793cc
--- /dev/null
+++ b/drivers/crypto/starfive/jh8100-sm4.c
@@ -0,0 +1,1107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive SM4 acceleration driver
+ *
+ * Copyright (c) 2022 - 2023 StarFive Technology
+ */
+
+#include <crypto/engine.h>
+#include <crypto/gcm.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/internal/aead.h>
+#include <crypto/internal/skcipher.h>
+#include "jh7110-cryp.h"
+#include <linux/iopoll.h>
+
+#define STARFIVE_SM4_REGS_OFFSET	0x4100
+#define STARFIVE_SM4_SM4DIO0R		(STARFIVE_SM4_REGS_OFFSET + 0x0)
+#define STARFIVE_SM4_KEY0		(STARFIVE_SM4_REGS_OFFSET + 0x4)
+#define STARFIVE_SM4_KEY1		(STARFIVE_SM4_REGS_OFFSET + 0x8)
+#define STARFIVE_SM4_KEY2		(STARFIVE_SM4_REGS_OFFSET + 0xC)
+#define STARFIVE_SM4_KEY3		(STARFIVE_SM4_REGS_OFFSET + 0x10)
+#define STARFIVE_SM4_IV0		(STARFIVE_SM4_REGS_OFFSET + 0x14)
+#define STARFIVE_SM4_IV1		(STARFIVE_SM4_REGS_OFFSET + 0x18)
+#define STARFIVE_SM4_IV2		(STARFIVE_SM4_REGS_OFFSET + 0x1c)
+#define STARFIVE_SM4_IV3		(STARFIVE_SM4_REGS_OFFSET + 0x20)
+#define STARFIVE_SM4_CSR		(STARFIVE_SM4_REGS_OFFSET + 0x24)
+#define STARFIVE_SM4_NONCE0		(STARFIVE_SM4_REGS_OFFSET + 0x30)
+#define STARFIVE_SM4_NONCE1		(STARFIVE_SM4_REGS_OFFSET + 0x34)
+#define STARFIVE_SM4_NONCE2		(STARFIVE_SM4_REGS_OFFSET + 0x38)
+#define STARFIVE_SM4_NONCE3		(STARFIVE_SM4_REGS_OFFSET + 0x3c)
+#define STARFIVE_SM4_ALEN0		(STARFIVE_SM4_REGS_OFFSET + 0x40)
+#define STARFIVE_SM4_ALEN1		(STARFIVE_SM4_REGS_OFFSET + 0x44)
+#define STARFIVE_SM4_MLEN0		(STARFIVE_SM4_REGS_OFFSET + 0x48)
+#define STARFIVE_SM4_MLEN1		(STARFIVE_SM4_REGS_OFFSET + 0x4c)
+#define STARFIVE_SM4_IVLEN		(STARFIVE_SM4_REGS_OFFSET + 0x50)
+
+#define FLG_MODE_MASK			GENMASK(2, 0)
+#define FLG_ENCRYPT			BIT(4)
+
+/* Misc */
+#define CCM_B0_ADATA			0x40
+#define SM4_BLOCK_32			(SM4_BLOCK_SIZE / sizeof(u32))
+
+static inline int starfive_sm4_wait_done(struct starfive_cryp_dev *cryp)
+{
+	u32 status;
+
+	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_SM4_CSR, status=
,
+					  status & STARFIVE_SM4_DONE, 10, 100000);
+}
+
+static inline int starfive_sm4_wait_keydone(struct starfive_cryp_dev *cr=
yp)
+{
+	u32 status;
+
+	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_SM4_CSR, status=
,
+					  status & STARFIVE_SM4_KEY_DONE, 10, 100000);
+}
+
+static inline int is_encrypt(struct starfive_cryp_dev *cryp)
+{
+	return cryp->flags & FLG_ENCRYPT;
+}
+
+static int starfive_sm4_aead_write_key(struct starfive_cryp_ctx *ctx, u3=
2 hw_mode)
+{
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	unsigned int value;
+	u32 *key =3D (u32 *)ctx->key;
+
+	writel(key[0], cryp->base + STARFIVE_SM4_KEY0);
+	writel(key[1], cryp->base + STARFIVE_SM4_KEY1);
+	writel(key[2], cryp->base + STARFIVE_SM4_KEY2);
+	writel(key[3], cryp->base + STARFIVE_SM4_KEY3);
+
+	value =3D readl(ctx->cryp->base + STARFIVE_SM4_CSR);
+
+	if (hw_mode =3D=3D STARFIVE_SM4_MODE_GCM)
+		value |=3D STARFIVE_SM4_GCM_START;
+	else
+		value |=3D STARFIVE_SM4_CCM_START;
+
+	writel(value, cryp->base + STARFIVE_SM4_CSR);
+
+	if (starfive_sm4_wait_keydone(cryp))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static inline void starfive_sm4_set_alen(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+
+	writel(upper_32_bits(cryp->assoclen), cryp->base + STARFIVE_SM4_ALEN0);
+	writel(lower_32_bits(cryp->assoclen), cryp->base + STARFIVE_SM4_ALEN1);
+}
+
+static inline void starfive_sm4_set_mlen(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+
+	writel(upper_32_bits(cryp->total_in), cryp->base + STARFIVE_SM4_MLEN0);
+	writel(lower_32_bits(cryp->total_in), cryp->base + STARFIVE_SM4_MLEN1);
+}
+
+static inline int starfive_sm4_ccm_check_iv(const u8 *iv)
+{
+	/* 2 <=3D L <=3D 8, so 1 <=3D L' <=3D 7. */
+	if (iv[0] < 1 || iv[0] > 7)
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline void starfive_sm4_write_iv(struct starfive_cryp_ctx *ctx, =
u32 *iv)
+{
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+
+	writel(iv[0], cryp->base + STARFIVE_SM4_IV0);
+	writel(iv[1], cryp->base + STARFIVE_SM4_IV1);
+	writel(iv[2], cryp->base + STARFIVE_SM4_IV2);
+	writel(iv[3], cryp->base + STARFIVE_SM4_IV3);
+}
+
+static inline void starfive_sm4_get_iv(struct starfive_cryp_dev *cryp, u=
32 *iv)
+{
+	iv[0] =3D readl(cryp->base + STARFIVE_SM4_IV0);
+	iv[1] =3D readl(cryp->base + STARFIVE_SM4_IV1);
+	iv[2] =3D readl(cryp->base + STARFIVE_SM4_IV2);
+	iv[3] =3D readl(cryp->base + STARFIVE_SM4_IV3);
+}
+
+static inline void starfive_sm4_write_nonce(struct starfive_cryp_ctx *ct=
x, u32 *nonce)
+{
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+
+	writel(nonce[0], cryp->base + STARFIVE_SM4_NONCE0);
+	writel(nonce[1], cryp->base + STARFIVE_SM4_NONCE1);
+	writel(nonce[2], cryp->base + STARFIVE_SM4_NONCE2);
+	writel(nonce[3], cryp->base + STARFIVE_SM4_NONCE3);
+}
+
+static int starfive_sm4_write_key(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	u32 *key =3D (u32 *)ctx->key;
+
+	writel(key[0], cryp->base + STARFIVE_SM4_KEY0);
+	writel(key[1], cryp->base + STARFIVE_SM4_KEY1);
+	writel(key[2], cryp->base + STARFIVE_SM4_KEY2);
+	writel(key[3], cryp->base + STARFIVE_SM4_KEY3);
+
+	if (starfive_sm4_wait_keydone(cryp))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int starfive_sm4_ccm_init(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	u8 iv[SM4_BLOCK_SIZE], b0[SM4_BLOCK_SIZE];
+	unsigned int textlen;
+
+	memcpy(iv, cryp->req.areq->iv, SM4_BLOCK_SIZE);
+	memset(iv + SM4_BLOCK_SIZE - 1 - iv[0], 0, iv[0] + 1);
+
+	/* Build B0 */
+	memcpy(b0, iv, SM4_BLOCK_SIZE);
+
+	b0[0] |=3D (8 * ((cryp->authsize - 2) / 2));
+
+	if (cryp->assoclen)
+		b0[0] |=3D CCM_B0_ADATA;
+
+	textlen =3D cryp->total_in;
+
+	b0[SM4_BLOCK_SIZE - 2] =3D textlen >> 8;
+	b0[SM4_BLOCK_SIZE - 1] =3D textlen & 0xFF;
+
+	starfive_sm4_write_nonce(ctx, (u32 *)b0);
+
+	return 0;
+}
+
+static int starfive_sm4_hw_init(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_request_ctx *rctx =3D ctx->rctx;
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	u32 hw_mode;
+	int ret =3D 0;
+
+	/* reset */
+	rctx->csr.sm4.v =3D 0;
+	rctx->csr.sm4.sm4rst =3D 1;
+	writel(rctx->csr.sm4.v, cryp->base + STARFIVE_SM4_CSR);
+
+	/* csr setup */
+	hw_mode =3D cryp->flags & FLG_MODE_MASK;
+
+	rctx->csr.sm4.v =3D 0;
+	rctx->csr.sm4.mode  =3D hw_mode;
+	rctx->csr.sm4.cmode =3D !is_encrypt(cryp);
+	rctx->csr.sm4.stmode =3D STARFIVE_SM4_MODE_XFB_1;
+
+	if (cryp->side_chan) {
+		rctx->csr.sm4.delay_sm4 =3D 1;
+		rctx->csr.sm4.vsm4_start =3D 1;
+	}
+
+	writel(rctx->csr.sm4.v, cryp->base + STARFIVE_SM4_CSR);
+
+	switch (hw_mode) {
+	case STARFIVE_SM4_MODE_GCM:
+		starfive_sm4_set_alen(ctx);
+		starfive_sm4_set_mlen(ctx);
+		writel(GCM_AES_IV_SIZE, cryp->base + STARFIVE_SM4_IVLEN);
+		ret =3D starfive_sm4_aead_write_key(ctx, hw_mode);
+		if (ret)
+			return ret;
+
+		starfive_sm4_write_iv(ctx, (void *)cryp->req.areq->iv);
+		break;
+	case STARFIVE_SM4_MODE_CCM:
+		starfive_sm4_set_alen(ctx);
+		starfive_sm4_set_mlen(ctx);
+		starfive_sm4_ccm_init(ctx);
+		ret =3D starfive_sm4_aead_write_key(ctx, hw_mode);
+		if (ret)
+			return ret;
+		break;
+	case STARFIVE_SM4_MODE_CBC:
+	case STARFIVE_SM4_MODE_CTR:
+		starfive_sm4_write_iv(ctx, (void *)cryp->req.sreq->iv);
+		ret =3D starfive_sm4_write_key(ctx);
+		if (ret)
+			return ret;
+		break;
+	case STARFIVE_SM4_MODE_ECB:
+		ret =3D starfive_sm4_write_key(ctx);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int starfive_sm4_read_authtag(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx =3D ctx->rctx;
+	int i;
+
+	if ((cryp->flags & FLG_MODE_MASK) =3D=3D STARFIVE_SM4_MODE_GCM) {
+		cryp->tag_out[0] =3D readl(cryp->base + STARFIVE_SM4_NONCE0);
+		cryp->tag_out[1] =3D readl(cryp->base + STARFIVE_SM4_NONCE1);
+		cryp->tag_out[2] =3D readl(cryp->base + STARFIVE_SM4_NONCE2);
+		cryp->tag_out[3] =3D readl(cryp->base + STARFIVE_SM4_NONCE3);
+	} else {
+		for (i =3D 0; i < SM4_BLOCK_32; i++)
+			cryp->tag_out[i] =3D readl(cryp->base + STARFIVE_SM4_SM4DIO0R);
+	}
+
+	if (is_encrypt(cryp)) {
+		scatterwalk_map_and_copy(cryp->tag_out, rctx->out_sg,
+					 cryp->total_in, cryp->authsize, 1);
+	} else {
+		if (crypto_memneq(cryp->tag_in, cryp->tag_out, cryp->authsize))
+			return dev_err_probe(cryp->dev, -EBADMSG,
+					     "Failed tag verification\n");
+	}
+
+	return 0;
+}
+
+static void starfive_sm4_finish_req(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	int err =3D 0;
+
+	if (cryp->authsize)
+		err =3D starfive_sm4_read_authtag(ctx);
+
+	if ((cryp->flags & FLG_MODE_MASK) =3D=3D STARFIVE_SM4_MODE_CBC ||
+	    (cryp->flags & FLG_MODE_MASK) =3D=3D STARFIVE_SM4_MODE_CTR)
+		starfive_sm4_get_iv(cryp, (void *)cryp->req.sreq->iv);
+
+	if (cryp->authsize)
+		crypto_finalize_aead_request(cryp->engine, cryp->req.areq, err);
+	else
+		crypto_finalize_skcipher_request(cryp->engine, cryp->req.sreq,
+						 err);
+}
+
+static int starfive_sm4_gcm_write_adata(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx =3D ctx->rctx;
+	u32 *buffer;
+	int total_len, loop;
+
+	total_len =3D ALIGN(cryp->assoclen, SM4_BLOCK_SIZE) / sizeof(unsigned i=
nt);
+	buffer =3D (u32 *)rctx->adata;
+
+	for (loop =3D 0; loop < total_len; loop +=3D 4) {
+		writel(*buffer, cryp->base + STARFIVE_SM4_NONCE0);
+		buffer++;
+		writel(*buffer, cryp->base + STARFIVE_SM4_NONCE1);
+		buffer++;
+		writel(*buffer, cryp->base + STARFIVE_SM4_NONCE2);
+		buffer++;
+		writel(*buffer, cryp->base + STARFIVE_SM4_NONCE3);
+		buffer++;
+
+		if (starfive_sm4_wait_done(cryp))
+			return dev_err_probe(cryp->dev, -ETIMEDOUT,
+					     "Timeout processing gcm aad block");
+	}
+
+	return 0;
+}
+
+static int starfive_sm4_ccm_write_adata(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx =3D ctx->rctx;
+	u32 *buffer;
+	int total_len, loop;
+
+	buffer =3D (u32 *)rctx->adata;
+	total_len =3D ALIGN(cryp->assoclen + 2, SM4_BLOCK_SIZE) / sizeof(unsign=
ed int);
+
+	for (loop =3D 0; loop < total_len; loop +=3D 4) {
+		writel(*buffer, cryp->base + STARFIVE_SM4_SM4DIO0R);
+		buffer++;
+		writel(*buffer, cryp->base + STARFIVE_SM4_SM4DIO0R);
+		buffer++;
+		writel(*buffer, cryp->base + STARFIVE_SM4_SM4DIO0R);
+		buffer++;
+		writel(*buffer, cryp->base + STARFIVE_SM4_SM4DIO0R);
+		buffer++;
+
+		if (starfive_sm4_wait_done(cryp))
+			return dev_err_probe(cryp->dev, -ETIMEDOUT,
+					     "Timeout processing ccm aad block");
+	}
+
+	return 0;
+}
+
+static void starfive_sm4_dma_done(void *param)
+{
+	struct starfive_cryp_dev *cryp =3D param;
+
+	complete(&cryp->dma_done);
+}
+
+static void starfive_sm4_dma_init(struct starfive_cryp_dev *cryp)
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
+	cryp->cfg_out.direction =3D DMA_DEV_TO_MEM;
+	cryp->cfg_out.src_addr_width =3D DMA_SLAVE_BUSWIDTH_8_BYTES;
+	cryp->cfg_out.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_8_BYTES;
+	cryp->cfg_out.src_maxburst =3D cryp->dma_maxburst;
+	cryp->cfg_out.dst_maxburst =3D cryp->dma_maxburst;
+	cryp->cfg_out.src_addr =3D cryp->phys_base + STARFIVE_SM_ALG_FIFO_OUT_O=
FFSET;
+
+	dmaengine_slave_config(cryp->rx, &cryp->cfg_out);
+
+	init_completion(&cryp->dma_done);
+}
+
+static int starfive_sm4_dma_xfer(struct starfive_cryp_dev *cryp,
+				 struct scatterlist *src,
+				 struct scatterlist *dst,
+				 int len)
+{
+	struct dma_async_tx_descriptor *in_desc, *out_desc;
+	union  starfive_sm_alg_cr alg_cr;
+	int ret =3D 0, in_save, out_save;
+
+	alg_cr.v =3D 0;
+	alg_cr.start =3D 1;
+	alg_cr.sm4_dma_en =3D 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_SM_ALG_CR_OFFSET);
+
+	in_save =3D sg_dma_len(src);
+	out_save =3D sg_dma_len(dst);
+
+	writel(ALIGN(len, SM4_BLOCK_SIZE), cryp->base + STARFIVE_SM_DMA_IN_LEN_=
OFFSET);
+	writel(ALIGN(len, SM4_BLOCK_SIZE), cryp->base + STARFIVE_SM_DMA_OUT_LEN=
_OFFSET);
+
+	sg_dma_len(src) =3D ALIGN(len, SM4_BLOCK_SIZE);
+	sg_dma_len(dst) =3D ALIGN(len, SM4_BLOCK_SIZE);
+
+	out_desc =3D dmaengine_prep_slave_sg(cryp->rx, dst, 1, DMA_DEV_TO_MEM,
+					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!out_desc) {
+		ret =3D -EINVAL;
+		goto dma_err;
+	}
+
+	out_desc->callback =3D starfive_sm4_dma_done;
+	out_desc->callback_param =3D cryp;
+
+	reinit_completion(&cryp->dma_done);
+	dmaengine_submit(out_desc);
+	dma_async_issue_pending(cryp->rx);
+
+	in_desc =3D dmaengine_prep_slave_sg(cryp->tx, src, 1, DMA_MEM_TO_DEV,
+					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!in_desc) {
+		ret =3D -EINVAL;
+		goto dma_err;
+	}
+
+	dmaengine_submit(in_desc);
+	dma_async_issue_pending(cryp->tx);
+
+	if (!wait_for_completion_timeout(&cryp->dma_done,
+					 msecs_to_jiffies(1000)))
+		ret =3D -ETIMEDOUT;
+
+dma_err:
+	sg_dma_len(src) =3D in_save;
+	sg_dma_len(dst) =3D out_save;
+
+	alg_cr.v =3D 0;
+	alg_cr.clear =3D 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_SM_ALG_CR_OFFSET);
+
+	return ret;
+}
+
+static int starfive_sm4_map_sg(struct starfive_cryp_dev *cryp,
+			       struct scatterlist *src,
+			       struct scatterlist *dst)
+{
+	struct scatterlist *stsg, *dtsg;
+	struct scatterlist _src[2], _dst[2];
+	unsigned int remain =3D cryp->total_in;
+	unsigned int len, src_nents, dst_nents;
+	int ret;
+
+	if (src =3D=3D dst) {
+		for (stsg =3D src, dtsg =3D dst; remain > 0;
+		     stsg =3D sg_next(stsg), dtsg =3D sg_next(dtsg)) {
+			src_nents =3D dma_map_sg(cryp->dev, stsg, 1, DMA_BIDIRECTIONAL);
+			if (src_nents =3D=3D 0)
+				return dev_err_probe(cryp->dev, -ENOMEM,
+						     "dma_map_sg error\n");
+
+			dst_nents =3D src_nents;
+
+			len =3D min(sg_dma_len(stsg), remain);
+
+			ret =3D starfive_sm4_dma_xfer(cryp, stsg, dtsg, len);
+			dma_unmap_sg(cryp->dev, stsg, 1, DMA_BIDIRECTIONAL);
+			if (ret)
+				return ret;
+
+			remain -=3D len;
+		}
+	} else {
+		for (stsg =3D src, dtsg =3D dst;;) {
+			src_nents =3D dma_map_sg(cryp->dev, stsg, 1, DMA_TO_DEVICE);
+			if (src_nents =3D=3D 0)
+				return dev_err_probe(cryp->dev, -ENOMEM,
+						     "dma_map_sg src error\n");
+
+			dst_nents =3D dma_map_sg(cryp->dev, dtsg, 1, DMA_FROM_DEVICE);
+			if (dst_nents =3D=3D 0)
+				return dev_err_probe(cryp->dev, -ENOMEM,
+						     "dma_map_sg dst error\n");
+
+			len =3D min(sg_dma_len(stsg), sg_dma_len(dtsg));
+			len =3D min(len, remain);
+
+			ret =3D starfive_sm4_dma_xfer(cryp, stsg, dtsg, len);
+			dma_unmap_sg(cryp->dev, stsg, 1, DMA_TO_DEVICE);
+			dma_unmap_sg(cryp->dev, dtsg, 1, DMA_FROM_DEVICE);
+			if (ret)
+				return ret;
+
+			remain -=3D len;
+			if (remain =3D=3D 0)
+				break;
+
+			if (sg_dma_len(stsg) - len) {
+				stsg =3D scatterwalk_ffwd(_src, stsg, len);
+				dtsg =3D sg_next(dtsg);
+			} else if (sg_dma_len(dtsg) - len) {
+				dtsg =3D scatterwalk_ffwd(_dst, dtsg, len);
+				stsg =3D sg_next(stsg);
+			} else {
+				stsg =3D sg_next(stsg);
+				dtsg =3D sg_next(dtsg);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int starfive_sm4_do_one_req(struct crypto_engine *engine, void *a=
req)
+{
+	struct skcipher_request *req =3D
+		container_of(areq, struct skcipher_request, base);
+	struct starfive_cryp_ctx *ctx =3D
+		crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx =3D skcipher_request_ctx(req);
+	int ret;
+
+	cryp->req.sreq =3D req;
+	cryp->total_in =3D req->cryptlen;
+	cryp->total_out =3D req->cryptlen;
+	cryp->assoclen =3D 0;
+	cryp->authsize =3D 0;
+
+	rctx->in_sg =3D req->src;
+	rctx->out_sg =3D req->dst;
+
+	ctx->rctx =3D rctx;
+
+	ret =3D starfive_sm4_hw_init(ctx);
+	if (ret)
+		return ret;
+
+	starfive_sm4_dma_init(cryp);
+
+	ret =3D starfive_sm4_map_sg(cryp, rctx->in_sg, rctx->out_sg);
+	if (ret)
+		return ret;
+
+	starfive_sm4_finish_req(ctx);
+
+	return 0;
+}
+
+static int starfive_sm4_init_tfm(struct crypto_skcipher *tfm,
+				 const char *alg_name)
+{
+	struct starfive_cryp_ctx *ctx =3D crypto_skcipher_ctx(tfm);
+
+	ctx->cryp =3D starfive_cryp_find_dev(ctx);
+	if (!ctx->cryp)
+		return -ENODEV;
+
+	ctx->skcipher_fbk =3D crypto_alloc_skcipher(alg_name, 0,
+						  CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->skcipher_fbk))
+		return dev_err_probe(ctx->cryp->dev, PTR_ERR(ctx->skcipher_fbk),
+				     "%s() failed to allocate fallback for %s\n",
+				     __func__, alg_name);
+
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct starfive_cryp_request_ct=
x) +
+				    sizeof(struct skcipher_request));
+
+	return 0;
+}
+
+static void starfive_sm4_exit_tfm(struct crypto_skcipher *tfm)
+{
+	struct starfive_cryp_ctx *ctx =3D crypto_skcipher_ctx(tfm);
+
+	crypto_free_skcipher(ctx->skcipher_fbk);
+}
+
+static int starfive_sm4_aead_do_one_req(struct crypto_engine *engine, vo=
id *areq)
+{
+	struct aead_request *req =3D
+		container_of(areq, struct aead_request, base);
+	struct starfive_cryp_ctx *ctx =3D
+		crypto_aead_ctx(crypto_aead_reqtfm(req));
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx =3D aead_request_ctx(req);
+	struct scatterlist _dst[2], _src[2];
+	int ret;
+
+	cryp->req.areq =3D req;
+	cryp->assoclen =3D req->assoclen;
+	cryp->authsize =3D crypto_aead_authsize(crypto_aead_reqtfm(req));
+
+	if (is_encrypt(cryp)) {
+		cryp->total_in =3D req->cryptlen;
+		cryp->total_out =3D req->cryptlen;
+	} else {
+		cryp->total_in =3D req->cryptlen - cryp->authsize;
+		cryp->total_out =3D cryp->total_in;
+		scatterwalk_map_and_copy(cryp->tag_in, req->src,
+					 cryp->total_in + cryp->assoclen,
+					 cryp->authsize, 0);
+	}
+
+	if (cryp->assoclen) {
+		if ((cryp->flags & FLG_MODE_MASK) =3D=3D STARFIVE_SM4_MODE_CCM) {
+			rctx->adata =3D kzalloc(cryp->assoclen + 2 + SM4_BLOCK_SIZE, GFP_KERN=
EL);
+			if (!rctx->adata)
+				return -ENOMEM;
+
+			/* Append 2 bytes zeroes at the start of ccm aad */
+			rctx->adata[0] =3D 0;
+			rctx->adata[1] =3D 0;
+
+			sg_copy_to_buffer(req->src,
+					  sg_nents_for_len(req->src, cryp->assoclen),
+					  &rctx->adata[2], cryp->assoclen);
+		} else {
+			rctx->adata =3D kzalloc(cryp->assoclen + SM4_BLOCK_SIZE, GFP_KERNEL);
+			if (!rctx->adata)
+				return dev_err_probe(cryp->dev, -ENOMEM,
+						     "Failed to alloc memory for adata");
+
+			sg_copy_to_buffer(req->src,
+					  sg_nents_for_len(req->src, cryp->assoclen),
+					  rctx->adata, cryp->assoclen);
+		}
+	}
+
+	rctx->in_sg =3D scatterwalk_ffwd(_src, req->src, cryp->assoclen);
+	if (req->src =3D=3D req->dst)
+		rctx->out_sg =3D rctx->in_sg;
+	else
+		rctx->out_sg =3D scatterwalk_ffwd(_dst, req->dst, cryp->assoclen);
+
+	if (cryp->total_in)
+		sg_zero_buffer(rctx->in_sg, sg_nents(rctx->in_sg),
+			       sg_dma_len(rctx->in_sg) - cryp->total_in,
+			       cryp->total_in);
+
+	ctx->rctx =3D rctx;
+
+	ret =3D starfive_sm4_hw_init(ctx);
+	if (ret)
+		return ret;
+
+	if (!cryp->assoclen)
+		goto write_text;
+
+	if ((cryp->flags & FLG_MODE_MASK) =3D=3D STARFIVE_SM4_MODE_CCM)
+		ret =3D starfive_sm4_ccm_write_adata(ctx);
+	else
+		ret =3D starfive_sm4_gcm_write_adata(ctx);
+
+	kfree(rctx->adata);
+
+	if (ret)
+		return ret;
+
+write_text:
+	if (!cryp->total_in)
+		goto finish_req;
+
+	starfive_sm4_dma_init(cryp);
+
+	ret =3D starfive_sm4_map_sg(cryp, rctx->in_sg, rctx->out_sg);
+	if (ret)
+		return ret;
+
+finish_req:
+	starfive_sm4_finish_req(ctx);
+	return 0;
+}
+
+static int starfive_sm4_aead_init_tfm(struct crypto_aead *tfm,
+				      const char *alg_name)
+{
+	struct starfive_cryp_ctx *ctx =3D crypto_aead_ctx(tfm);
+
+	ctx->cryp =3D starfive_cryp_find_dev(ctx);
+	if (!ctx->cryp)
+		return -ENODEV;
+
+	ctx->aead_fbk =3D crypto_alloc_aead(alg_name, 0,
+					  CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->aead_fbk))
+		return dev_err_probe(ctx->cryp->dev, PTR_ERR(ctx->aead_fbk),
+				     "%s() failed to allocate fallback for %s\n",
+				     __func__, alg_name);
+
+	crypto_aead_set_reqsize(tfm, sizeof(struct starfive_cryp_ctx) +
+				sizeof(struct aead_request));
+
+	return 0;
+}
+
+static void starfive_sm4_aead_exit_tfm(struct crypto_aead *tfm)
+{
+	struct starfive_cryp_ctx *ctx =3D crypto_aead_ctx(tfm);
+
+	crypto_free_aead(ctx->aead_fbk);
+}
+
+static bool starfive_sm4_check_unaligned(struct starfive_cryp_dev *cryp,
+					 struct scatterlist *src,
+					 struct scatterlist *dst)
+{
+	struct scatterlist *tsg;
+	int i;
+
+	for_each_sg(src, tsg, sg_nents(src), i)
+		if (!IS_ALIGNED(tsg->length, SM4_BLOCK_SIZE) &&
+		    !sg_is_last(tsg))
+			return true;
+
+	if (src !=3D dst)
+		for_each_sg(dst, tsg, sg_nents(dst), i)
+			if (!IS_ALIGNED(tsg->length, SM4_BLOCK_SIZE) &&
+			    !sg_is_last(tsg))
+				return true;
+
+	return false;
+}
+
+static int starfive_sm4_do_fallback(struct skcipher_request *req, bool e=
nc)
+{
+	struct starfive_cryp_ctx *ctx =3D
+		crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+	struct skcipher_request *subreq =3D skcipher_request_ctx(req);
+
+	skcipher_request_set_tfm(subreq, ctx->skcipher_fbk);
+	skcipher_request_set_callback(subreq, req->base.flags,
+				      req->base.complete,
+				      req->base.data);
+	skcipher_request_set_crypt(subreq, req->src, req->dst,
+				   req->cryptlen, req->iv);
+
+	return enc ? crypto_skcipher_encrypt(subreq) :
+		     crypto_skcipher_decrypt(subreq);
+}
+
+static int starfive_sm4_crypt(struct skcipher_request *req, unsigned lon=
g flags)
+{
+	struct crypto_skcipher *tfm =3D crypto_skcipher_reqtfm(req);
+	struct starfive_cryp_ctx *ctx =3D crypto_skcipher_ctx(tfm);
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	unsigned int blocksize_align =3D crypto_skcipher_blocksize(tfm) - 1;
+
+	cryp->flags =3D flags;
+
+	if ((cryp->flags & FLG_MODE_MASK) =3D=3D STARFIVE_SM4_MODE_ECB ||
+	    (cryp->flags & FLG_MODE_MASK) =3D=3D STARFIVE_SM4_MODE_CBC)
+		if (req->cryptlen & blocksize_align)
+			return -EINVAL;
+
+	if (starfive_sm4_check_unaligned(cryp, req->src, req->dst))
+		return starfive_sm4_do_fallback(req, is_encrypt(cryp));
+
+	return crypto_transfer_skcipher_request_to_engine(cryp->engine, req);
+}
+
+static int starfive_sm4_aead_do_fallback(struct aead_request *req, bool =
enc)
+{
+	struct starfive_cryp_ctx *ctx =3D
+		crypto_aead_ctx(crypto_aead_reqtfm(req));
+	struct aead_request *subreq =3D aead_request_ctx(req);
+
+	aead_request_set_tfm(subreq, ctx->aead_fbk);
+	aead_request_set_callback(subreq, req->base.flags,
+				  req->base.complete,
+				  req->base.data);
+	aead_request_set_crypt(subreq, req->src, req->dst,
+			       req->cryptlen, req->iv);
+	aead_request_set_ad(subreq, req->assoclen);
+
+	return enc ? crypto_aead_encrypt(subreq) :
+		     crypto_aead_decrypt(subreq);
+}
+
+static int starfive_sm4_aead_crypt(struct aead_request *req, unsigned lo=
ng flags)
+{
+	struct starfive_cryp_ctx *ctx =3D crypto_aead_ctx(crypto_aead_reqtfm(re=
q));
+	struct starfive_cryp_dev *cryp =3D ctx->cryp;
+	struct scatterlist *src, *dst, _src[2], _dst[2];
+
+	cryp->flags =3D flags;
+
+	/* sm4-ccm does not support tag verification for non-aligned text,
+	 * use fallback for ccm decryption instead.
+	 */
+	if (((cryp->flags & FLG_MODE_MASK) =3D=3D STARFIVE_SM4_MODE_CCM) &&
+	    !is_encrypt(cryp))
+		return starfive_sm4_aead_do_fallback(req, 0);
+
+	src =3D scatterwalk_ffwd(_src, req->src, req->assoclen);
+
+	if (req->src =3D=3D req->dst)
+		dst =3D src;
+	else
+		dst =3D scatterwalk_ffwd(_dst, req->dst, req->assoclen);
+
+	if (starfive_sm4_check_unaligned(cryp, src, dst))
+		return starfive_sm4_aead_do_fallback(req, is_encrypt(cryp));
+
+	return crypto_transfer_aead_request_to_engine(cryp->engine, req);
+}
+
+static int starfive_sm4_setkey(struct crypto_skcipher *tfm, const u8 *ke=
y,
+			       unsigned int keylen)
+{
+	struct starfive_cryp_ctx *ctx =3D crypto_skcipher_ctx(tfm);
+
+	if (!key || !keylen)
+		return -EINVAL;
+
+	if (keylen !=3D SM4_KEY_SIZE)
+		return -EINVAL;
+
+	memcpy(ctx->key, key, keylen);
+	ctx->keylen =3D keylen;
+
+	return crypto_skcipher_setkey(ctx->skcipher_fbk, key, keylen);
+}
+
+static int starfive_sm4_aead_setkey(struct crypto_aead *tfm, const u8 *k=
ey,
+				    unsigned int keylen)
+{
+	struct starfive_cryp_ctx *ctx =3D crypto_aead_ctx(tfm);
+
+	if (!key || !keylen)
+		return -EINVAL;
+
+	if (keylen !=3D SM4_KEY_SIZE)
+		return -EINVAL;
+
+	memcpy(ctx->key, key, keylen);
+	ctx->keylen =3D keylen;
+
+	return crypto_aead_setkey(ctx->aead_fbk, key, keylen);
+}
+
+static int starfive_sm4_gcm_setauthsize(struct crypto_aead *tfm,
+					unsigned int authsize)
+{
+	struct starfive_cryp_ctx *ctx =3D crypto_aead_ctx(tfm);
+	int ret;
+
+	ret =3D crypto_gcm_check_authsize(authsize);
+	if (ret)
+		return ret;
+
+	return crypto_aead_setauthsize(ctx->aead_fbk, authsize);
+}
+
+static int starfive_sm4_ccm_setauthsize(struct crypto_aead *tfm,
+					unsigned int authsize)
+{
+	struct starfive_cryp_ctx *ctx =3D crypto_aead_ctx(tfm);
+
+	switch (authsize) {
+	case 4:
+	case 6:
+	case 8:
+	case 10:
+	case 12:
+	case 14:
+	case 16:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return crypto_aead_setauthsize(ctx->aead_fbk, authsize);
+}
+
+static int starfive_sm4_ecb_encrypt(struct skcipher_request *req)
+{
+	return starfive_sm4_crypt(req, STARFIVE_SM4_MODE_ECB | FLG_ENCRYPT);
+}
+
+static int starfive_sm4_ecb_decrypt(struct skcipher_request *req)
+{
+	return starfive_sm4_crypt(req, STARFIVE_SM4_MODE_ECB);
+}
+
+static int starfive_sm4_cbc_encrypt(struct skcipher_request *req)
+{
+	return starfive_sm4_crypt(req, STARFIVE_SM4_MODE_CBC | FLG_ENCRYPT);
+}
+
+static int starfive_sm4_cbc_decrypt(struct skcipher_request *req)
+{
+	return starfive_sm4_crypt(req, STARFIVE_SM4_MODE_CBC);
+}
+
+static int starfive_sm4_ctr_encrypt(struct skcipher_request *req)
+{
+	return starfive_sm4_crypt(req, STARFIVE_SM4_MODE_CTR | FLG_ENCRYPT);
+}
+
+static int starfive_sm4_ctr_decrypt(struct skcipher_request *req)
+{
+	return starfive_sm4_crypt(req, STARFIVE_SM4_MODE_CTR);
+}
+
+static int starfive_sm4_gcm_encrypt(struct aead_request *req)
+{
+	return starfive_sm4_aead_crypt(req, STARFIVE_SM4_MODE_GCM | FLG_ENCRYPT=
);
+}
+
+static int starfive_sm4_gcm_decrypt(struct aead_request *req)
+{
+	return starfive_sm4_aead_crypt(req, STARFIVE_SM4_MODE_GCM);
+}
+
+static int starfive_sm4_ccm_encrypt(struct aead_request *req)
+{
+	int ret;
+
+	ret =3D starfive_sm4_ccm_check_iv(req->iv);
+	if (ret)
+		return ret;
+
+	return starfive_sm4_aead_crypt(req, STARFIVE_SM4_MODE_CCM | FLG_ENCRYPT=
);
+}
+
+static int starfive_sm4_ccm_decrypt(struct aead_request *req)
+{
+	int ret;
+
+	ret =3D starfive_sm4_ccm_check_iv(req->iv);
+	if (ret)
+		return ret;
+
+	return starfive_sm4_aead_crypt(req, STARFIVE_SM4_MODE_CCM);
+}
+
+static int starfive_sm4_ecb_init_tfm(struct crypto_skcipher *tfm)
+{
+	return starfive_sm4_init_tfm(tfm, "ecb(sm4-generic)");
+}
+
+static int starfive_sm4_cbc_init_tfm(struct crypto_skcipher *tfm)
+{
+	return starfive_sm4_init_tfm(tfm, "cbc(sm4-generic)");
+}
+
+static int starfive_sm4_ctr_init_tfm(struct crypto_skcipher *tfm)
+{
+	return starfive_sm4_init_tfm(tfm, "ctr(sm4-generic)");
+}
+
+static int starfive_sm4_ccm_aead_init_tfm(struct crypto_aead *tfm)
+{
+	return starfive_sm4_aead_init_tfm(tfm, "ccm_base(ctr(sm4-generic),cbcma=
c(sm4-generic))");
+}
+
+static int starfive_sm4_gcm_aead_init_tfm(struct crypto_aead *tfm)
+{
+	return starfive_sm4_aead_init_tfm(tfm, "gcm_base(ctr(sm4-generic),ghash=
-generic)");
+}
+
+static struct skcipher_engine_alg skcipher_sm4[] =3D {
+{
+	.base.init			=3D starfive_sm4_ecb_init_tfm,
+	.base.exit			=3D starfive_sm4_exit_tfm,
+	.base.setkey			=3D starfive_sm4_setkey,
+	.base.encrypt			=3D starfive_sm4_ecb_encrypt,
+	.base.decrypt			=3D starfive_sm4_ecb_decrypt,
+	.base.min_keysize		=3D SM4_KEY_SIZE,
+	.base.max_keysize		=3D SM4_KEY_SIZE,
+	.base.base =3D {
+		.cra_name		=3D "ecb(sm4)",
+		.cra_driver_name	=3D "starfive-ecb-sm4",
+		.cra_priority		=3D 200,
+		.cra_flags		=3D CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
+		.cra_blocksize		=3D SM4_BLOCK_SIZE,
+		.cra_ctxsize		=3D sizeof(struct starfive_cryp_ctx),
+		.cra_alignmask		=3D 0xf,
+		.cra_module		=3D THIS_MODULE,
+	},
+	.op =3D {
+		.do_one_request =3D starfive_sm4_do_one_req,
+	},
+}, {
+	.base.init			=3D starfive_sm4_ctr_init_tfm,
+	.base.exit			=3D starfive_sm4_exit_tfm,
+	.base.setkey			=3D starfive_sm4_setkey,
+	.base.encrypt			=3D starfive_sm4_ctr_encrypt,
+	.base.decrypt			=3D starfive_sm4_ctr_decrypt,
+	.base.min_keysize		=3D SM4_KEY_SIZE,
+	.base.max_keysize		=3D SM4_KEY_SIZE,
+	.base.ivsize			=3D SM4_BLOCK_SIZE,
+	.base.base =3D {
+		.cra_name		=3D "ctr(sm4)",
+		.cra_driver_name	=3D "starfive-ctr-sm4",
+		.cra_priority		=3D 200,
+		.cra_flags		=3D CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
+		.cra_blocksize		=3D 1,
+		.cra_ctxsize		=3D sizeof(struct starfive_cryp_ctx),
+		.cra_alignmask		=3D 0xf,
+		.cra_module		=3D THIS_MODULE,
+	},
+	.op =3D {
+		.do_one_request =3D starfive_sm4_do_one_req,
+	},
+}, {
+	.base.init			=3D starfive_sm4_cbc_init_tfm,
+	.base.exit			=3D starfive_sm4_exit_tfm,
+	.base.setkey			=3D starfive_sm4_setkey,
+	.base.encrypt			=3D starfive_sm4_cbc_encrypt,
+	.base.decrypt			=3D starfive_sm4_cbc_decrypt,
+	.base.min_keysize		=3D SM4_KEY_SIZE,
+	.base.max_keysize		=3D SM4_KEY_SIZE,
+	.base.ivsize			=3D SM4_BLOCK_SIZE,
+	.base.base =3D {
+		.cra_name		=3D "cbc(sm4)",
+		.cra_driver_name	=3D "starfive-cbc-sm4",
+		.cra_priority		=3D 200,
+		.cra_flags		=3D CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
+		.cra_blocksize		=3D SM4_BLOCK_SIZE,
+		.cra_ctxsize		=3D sizeof(struct starfive_cryp_ctx),
+		.cra_alignmask		=3D 0xf,
+		.cra_module		=3D THIS_MODULE,
+	},
+	.op =3D {
+		.do_one_request =3D starfive_sm4_do_one_req,
+	},
+},
+};
+
+static struct aead_engine_alg aead_sm4[] =3D {
+{
+	.base.setkey			=3D starfive_sm4_aead_setkey,
+	.base.setauthsize		=3D starfive_sm4_gcm_setauthsize,
+	.base.encrypt			=3D starfive_sm4_gcm_encrypt,
+	.base.decrypt			=3D starfive_sm4_gcm_decrypt,
+	.base.init			=3D starfive_sm4_gcm_aead_init_tfm,
+	.base.exit			=3D starfive_sm4_aead_exit_tfm,
+	.base.ivsize			=3D GCM_AES_IV_SIZE,
+	.base.maxauthsize		=3D SM4_BLOCK_SIZE,
+	.base.base =3D {
+		.cra_name		=3D "gcm(sm4)",
+		.cra_driver_name	=3D "starfive-gcm-sm4",
+		.cra_priority		=3D 200,
+		.cra_flags		=3D CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
+		.cra_blocksize		=3D 1,
+		.cra_ctxsize		=3D sizeof(struct starfive_cryp_ctx),
+		.cra_alignmask		=3D 0xf,
+		.cra_module		=3D THIS_MODULE,
+	},
+	.op =3D {
+		.do_one_request =3D starfive_sm4_aead_do_one_req,
+	},
+}, {
+	.base.setkey			=3D starfive_sm4_aead_setkey,
+	.base.setauthsize		=3D starfive_sm4_ccm_setauthsize,
+	.base.encrypt			=3D starfive_sm4_ccm_encrypt,
+	.base.decrypt			=3D starfive_sm4_ccm_decrypt,
+	.base.init			=3D starfive_sm4_ccm_aead_init_tfm,
+	.base.exit			=3D starfive_sm4_aead_exit_tfm,
+	.base.ivsize			=3D SM4_BLOCK_SIZE,
+	.base.maxauthsize		=3D SM4_BLOCK_SIZE,
+	.base.base =3D {
+		.cra_name		=3D "ccm(sm4)",
+		.cra_driver_name	=3D "starfive-ccm-sm4",
+		.cra_priority		=3D 200,
+		.cra_flags		=3D CRYPTO_ALG_ASYNC |
+					  CRYPTO_ALG_NEED_FALLBACK,
+		.cra_blocksize		=3D 1,
+		.cra_ctxsize		=3D sizeof(struct starfive_cryp_ctx),
+		.cra_alignmask		=3D 0xf,
+		.cra_module		=3D THIS_MODULE,
+	},
+	.op =3D {
+		.do_one_request =3D starfive_sm4_aead_do_one_req,
+	},
+},
+};
+
+int starfive_sm4_register_algs(void)
+{
+	int ret;
+
+	ret =3D crypto_engine_register_skciphers(skcipher_sm4, ARRAY_SIZE(skcip=
her_sm4));
+	if (ret)
+		return ret;
+
+	ret =3D crypto_engine_register_aeads(aead_sm4, ARRAY_SIZE(aead_sm4));
+	if (ret)
+		crypto_engine_unregister_skciphers(skcipher_sm4, ARRAY_SIZE(skcipher_s=
m4));
+
+	return ret;
+}
+
+void starfive_sm4_unregister_algs(void)
+{
+	crypto_engine_unregister_aeads(aead_sm4, ARRAY_SIZE(aead_sm4));
+	crypto_engine_unregister_skciphers(skcipher_sm4, ARRAY_SIZE(skcipher_sm=
4));
+}
--=20
2.34.1


