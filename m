Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0B17EB564
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjKNRMl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Nov 2023 12:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKNRMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:12:39 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21857124;
        Tue, 14 Nov 2023 09:12:34 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id F3D6724E24A;
        Wed, 15 Nov 2023 01:12:32 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Nov
 2023 01:12:32 +0800
Received: from ubuntu.localdomain (161.142.156.101) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Nov
 2023 01:12:30 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] crypto: starfive - RSA poll csr for done status
Date:   Wed, 15 Nov 2023 01:12:14 +0800
Message-ID: <20231114171214.240855-3-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114171214.240855-1-jiajie.ho@starfivetech.com>
References: <20231114171214.240855-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [161.142.156.101]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware could not clear irq status without resetting the entire module.
Driver receives irq immediately when mask bit is cleared causing
intermittent errors in RSA calculations. Switch to use csr polling for
done status instead.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/jh7110-cryp.c |  8 -----
 drivers/crypto/starfive/jh7110-cryp.h | 10 +++++-
 drivers/crypto/starfive/jh7110-rsa.c  | 49 +++++++--------------------
 3 files changed, 22 insertions(+), 45 deletions(-)

diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starfive/jh7110-cryp.c
index 08e974e0dd12..1e3cadcb179b 100644
--- a/drivers/crypto/starfive/jh7110-cryp.c
+++ b/drivers/crypto/starfive/jh7110-cryp.c
@@ -109,12 +109,6 @@ static irqreturn_t starfive_cryp_irq(int irq, void *priv)
 		tasklet_schedule(&cryp->hash_done);
 	}
 
-	if (status & STARFIVE_IE_FLAG_PKA_DONE) {
-		mask |= STARFIVE_IE_MASK_PKA_DONE;
-		writel(mask, cryp->base + STARFIVE_IE_MASK_OFFSET);
-		complete(&cryp->pka_done);
-	}
-
 	return IRQ_HANDLED;
 }
 
@@ -159,8 +153,6 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(cryp->rst),
 				     "Error getting hardware reset line\n");
 
-	init_completion(&cryp->pka_done);
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
diff --git a/drivers/crypto/starfive/jh7110-cryp.h b/drivers/crypto/starfive/jh7110-cryp.h
index fe011d50473d..8510f8c1f307 100644
--- a/drivers/crypto/starfive/jh7110-cryp.h
+++ b/drivers/crypto/starfive/jh7110-cryp.h
@@ -125,6 +125,15 @@ union starfive_pka_cacr {
 	};
 };
 
+union starfive_pka_casr {
+	u32 v;
+	struct {
+#define STARFIVE_PKA_DONE			BIT(0)
+		u32 done			:1;
+		u32 rsvd_0			:31;
+	};
+};
+
 struct starfive_rsa_key {
 	u8	*n;
 	u8	*e;
@@ -183,7 +192,6 @@ struct starfive_cryp_dev {
 	struct crypto_engine			*engine;
 	struct tasklet_struct			aes_done;
 	struct tasklet_struct			hash_done;
-	struct completion			pka_done;
 	size_t					assoclen;
 	size_t					total_in;
 	size_t					total_out;
diff --git a/drivers/crypto/starfive/jh7110-rsa.c b/drivers/crypto/starfive/jh7110-rsa.c
index f31bbd825f88..c2b1f598873c 100644
--- a/drivers/crypto/starfive/jh7110-rsa.c
+++ b/drivers/crypto/starfive/jh7110-rsa.c
@@ -6,13 +6,7 @@
  */
 
 #include <linux/crypto.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/dma-direct.h>
-#include <linux/interrupt.h>
 #include <linux/iopoll.h>
-#include <linux/io.h>
-#include <linux/mod_devicetable.h>
 #include <crypto/akcipher.h>
 #include <crypto/algapi.h>
 #include <crypto/internal/akcipher.h>
@@ -28,13 +22,13 @@
 #define STARFIVE_PKA_CAER_OFFSET	(STARFIVE_PKA_REGS_OFFSET + 0x108)
 #define STARFIVE_PKA_CANR_OFFSET	(STARFIVE_PKA_REGS_OFFSET + 0x208)
 
-// R^2 mod N and N0'
+/* R ^ 2 mod N and N0' */
 #define CRYPTO_CMD_PRE			0x0
-// A * R mod N   ==> A
+/* A * R mod N   ==> A */
 #define CRYPTO_CMD_ARN			0x5
-// A * E * R mod N ==> A
+/* A * E * R mod N ==> A */
 #define CRYPTO_CMD_AERN			0x6
-// A * A * R mod N ==> A
+/* A * A * R mod N ==> A */
 #define CRYPTO_CMD_AARN			0x7
 
 #define STARFIVE_RSA_MAX_KEYSZ		256
@@ -43,21 +37,10 @@
 static inline int starfive_pka_wait_done(struct starfive_cryp_ctx *ctx)
 {
 	struct starfive_cryp_dev *cryp = ctx->cryp;
+	u32 status;
 
-	return wait_for_completion_timeout(&cryp->pka_done,
-					   usecs_to_jiffies(100000));
-}
-
-static inline void starfive_pka_irq_mask_clear(struct starfive_cryp_ctx *ctx)
-{
-	struct starfive_cryp_dev *cryp = ctx->cryp;
-	u32 stat;
-
-	stat = readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
-	stat &= ~STARFIVE_IE_MASK_PKA_DONE;
-	writel(stat, cryp->base + STARFIVE_IE_MASK_OFFSET);
-
-	reinit_completion(&cryp->pka_done);
+	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_PKA_CASR_OFFSET, status,
+					  status & STARFIVE_PKA_DONE, 10, 100000);
 }
 
 static void starfive_rsa_free_key(struct starfive_rsa_key *key)
@@ -114,10 +97,9 @@ static int starfive_rsa_montgomery_form(struct starfive_cryp_ctx *ctx,
 		rctx->csr.pka.not_r2 = 1;
 		rctx->csr.pka.ie = 1;
 
-		starfive_pka_irq_mask_clear(ctx);
 		writel(rctx->csr.pka.v, cryp->base + STARFIVE_PKA_CACR_OFFSET);
 
-		if (!starfive_pka_wait_done(ctx))
+		if (starfive_pka_wait_done(ctx))
 			return -ETIMEDOUT;
 
 		for (loop = 0; loop <= opsize; loop++)
@@ -136,10 +118,9 @@ static int starfive_rsa_montgomery_form(struct starfive_cryp_ctx *ctx,
 		rctx->csr.pka.start = 1;
 		rctx->csr.pka.ie = 1;
 
-		starfive_pka_irq_mask_clear(ctx);
 		writel(rctx->csr.pka.v, cryp->base + STARFIVE_PKA_CACR_OFFSET);
 
-		if (!starfive_pka_wait_done(ctx))
+		if (starfive_pka_wait_done(ctx))
 			return -ETIMEDOUT;
 	} else {
 		rctx->csr.pka.v = 0;
@@ -151,10 +132,9 @@ static int starfive_rsa_montgomery_form(struct starfive_cryp_ctx *ctx,
 		rctx->csr.pka.pre_expf = 1;
 		rctx->csr.pka.ie = 1;
 
-		starfive_pka_irq_mask_clear(ctx);
 		writel(rctx->csr.pka.v, cryp->base + STARFIVE_PKA_CACR_OFFSET);
 
-		if (!starfive_pka_wait_done(ctx))
+		if (starfive_pka_wait_done(ctx))
 			return -ETIMEDOUT;
 
 		for (loop = 0; loop <= count; loop++)
@@ -172,10 +152,9 @@ static int starfive_rsa_montgomery_form(struct starfive_cryp_ctx *ctx,
 		rctx->csr.pka.start = 1;
 		rctx->csr.pka.ie = 1;
 
-		starfive_pka_irq_mask_clear(ctx);
 		writel(rctx->csr.pka.v, cryp->base + STARFIVE_PKA_CACR_OFFSET);
 
-		if (!starfive_pka_wait_done(ctx))
+		if (starfive_pka_wait_done(ctx))
 			return -ETIMEDOUT;
 	}
 
@@ -226,11 +205,10 @@ static int starfive_rsa_cpu_start(struct starfive_cryp_ctx *ctx, u32 *result,
 		rctx->csr.pka.start = 1;
 		rctx->csr.pka.ie = 1;
 
-		starfive_pka_irq_mask_clear(ctx);
 		writel(rctx->csr.pka.v, cryp->base + STARFIVE_PKA_CACR_OFFSET);
 
 		ret = -ETIMEDOUT;
-		if (!starfive_pka_wait_done(ctx))
+		if (starfive_pka_wait_done(ctx))
 			goto rsa_err;
 
 		if (mlen) {
@@ -242,10 +220,9 @@ static int starfive_rsa_cpu_start(struct starfive_cryp_ctx *ctx, u32 *result,
 			rctx->csr.pka.start = 1;
 			rctx->csr.pka.ie = 1;
 
-			starfive_pka_irq_mask_clear(ctx);
 			writel(rctx->csr.pka.v, cryp->base + STARFIVE_PKA_CACR_OFFSET);
 
-			if (!starfive_pka_wait_done(ctx))
+			if (starfive_pka_wait_done(ctx))
 				goto rsa_err;
 		}
 	}
-- 
2.34.1

