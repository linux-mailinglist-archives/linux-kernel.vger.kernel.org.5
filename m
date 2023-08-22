Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D2678457E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbjHVP2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbjHVP2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:28:39 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B9DCDA;
        Tue, 22 Aug 2023 08:28:37 -0700 (PDT)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qYTJ6-0006li-5r; Tue, 22 Aug 2023 17:28:36 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/3] hwrng: imx-rngc - use polling to wait for end of seeding
Date:   Tue, 22 Aug 2023 17:25:53 +0200
Message-Id: <20230822152553.190858-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822152553.190858-1-martin@kaiser.cx>
References: <20230822152553.190858-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use polling to wait until the imx-rngc is properly seeded.

We do this only in the init function when the imx-rngc becomes active.
Polling is ok at this time, there's nothing else we could do while
we're waiting.

We can now remove the code for the interrupt and the completion.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/imx-rngc.c | 81 ++++---------------------------
 1 file changed, 9 insertions(+), 72 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index d2df468fd460..7ab9aada72d0 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -63,12 +63,6 @@ struct imx_rngc {
 	struct clk		*clk;
 	void __iomem		*base;
 	struct hwrng		rng;
-	struct completion	rng_op_done;
-	/*
-	 * err_reg is written only by the irq handler and read only
-	 * when interrupts are masked, we need no spinlock
-	 */
-	u32			err_reg;
 };
 
 
@@ -91,15 +85,6 @@ static inline void imx_rngc_irq_mask_clear(struct imx_rngc *rngc)
 	writel(cmd, rngc->base + RNGC_COMMAND);
 }
 
-static inline void imx_rngc_irq_unmask(struct imx_rngc *rngc)
-{
-	u32 ctrl;
-
-	ctrl = readl(rngc->base + RNGC_CONTROL);
-	ctrl &= ~(RNGC_CTRL_MASK_DONE | RNGC_CTRL_MASK_ERROR);
-	writel(ctrl, rngc->base + RNGC_CONTROL);
-}
-
 static int imx_rngc_self_test(struct imx_rngc *rngc)
 {
 	u32 cmd, status;
@@ -143,56 +128,32 @@ static int imx_rngc_read(struct hwrng *rng, void *data, size_t max, bool wait)
 	return retval ? retval : -EIO;
 }
 
-static irqreturn_t imx_rngc_irq(int irq, void *priv)
-{
-	struct imx_rngc *rngc = (struct imx_rngc *)priv;
-	u32 status;
-
-	/*
-	 * clearing the interrupt will also clear the error register
-	 * read error and status before clearing
-	 */
-	status = readl(rngc->base + RNGC_STATUS);
-	rngc->err_reg = readl(rngc->base + RNGC_ERROR);
-
-	imx_rngc_irq_mask_clear(rngc);
-
-	if (status & (RNGC_STATUS_SEED_DONE | RNGC_STATUS_ST_DONE))
-		complete(&rngc->rng_op_done);
-
-	return IRQ_HANDLED;
-}
-
 static int imx_rngc_init(struct hwrng *rng)
 {
 	struct imx_rngc *rngc = container_of(rng, struct imx_rngc, rng);
-	u32 cmd, ctrl;
+	u32 cmd, ctrl, status, err_reg;
 	int ret;
 
 	/* clear error */
 	cmd = readl(rngc->base + RNGC_COMMAND);
 	writel(cmd | RNGC_CMD_CLR_ERR, rngc->base + RNGC_COMMAND);
 
-	imx_rngc_irq_unmask(rngc);
-
 	/* create seed, repeat while there is some statistical error */
 	do {
 		/* seed creation */
 		cmd = readl(rngc->base + RNGC_COMMAND);
 		writel(cmd | RNGC_CMD_SEED, rngc->base + RNGC_COMMAND);
 
-		ret = wait_for_completion_timeout(&rngc->rng_op_done, msecs_to_jiffies(RNGC_TIMEOUT));
-		if (!ret) {
-			ret = -ETIMEDOUT;
-			goto err;
-		}
+		ret = readl_poll_timeout(rngc->base + RNGC_STATUS, status,
+					 status & RNGC_STATUS_SEED_DONE, 1000, RNGC_TIMEOUT * 1000);
+		if (ret < 0)
+			return ret;
 
-	} while (rngc->err_reg == RNGC_ERROR_STATUS_STAT_ERR);
+		err_reg = readl(rngc->base + RNGC_ERROR);
+	} while (err_reg == RNGC_ERROR_STATUS_STAT_ERR);
 
-	if (rngc->err_reg) {
-		ret = -EIO;
-		goto err;
-	}
+	if (err_reg)
+		return -EIO;
 
 	/*
 	 * enable automatic seeding, the rngc creates a new seed automatically
@@ -202,23 +163,7 @@ static int imx_rngc_init(struct hwrng *rng)
 	ctrl |= RNGC_CTRL_AUTO_SEED;
 	writel(ctrl, rngc->base + RNGC_CONTROL);
 
-	/*
-	 * if initialisation was successful, we keep the interrupt
-	 * unmasked until imx_rngc_cleanup is called
-	 * we mask the interrupt ourselves if we return an error
-	 */
 	return 0;
-
-err:
-	imx_rngc_irq_mask_clear(rngc);
-	return ret;
-}
-
-static void imx_rngc_cleanup(struct hwrng *rng)
-{
-	struct imx_rngc *rngc = container_of(rng, struct imx_rngc, rng);
-
-	imx_rngc_irq_mask_clear(rngc);
 }
 
 static int __init imx_rngc_probe(struct platform_device *pdev)
@@ -254,12 +199,9 @@ static int __init imx_rngc_probe(struct platform_device *pdev)
 	if (rng_type != RNGC_TYPE_RNGC && rng_type != RNGC_TYPE_RNGB)
 		return -ENODEV;
 
-	init_completion(&rngc->rng_op_done);
-
 	rngc->rng.name = pdev->name;
 	rngc->rng.init = imx_rngc_init;
 	rngc->rng.read = imx_rngc_read;
-	rngc->rng.cleanup = imx_rngc_cleanup;
 	rngc->rng.quality = 19;
 
 	rngc->dev = &pdev->dev;
@@ -267,11 +209,6 @@ static int __init imx_rngc_probe(struct platform_device *pdev)
 
 	imx_rngc_irq_mask_clear(rngc);
 
-	ret = devm_request_irq(&pdev->dev,
-			irq, imx_rngc_irq, 0, pdev->name, (void *)rngc);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "Can't get interrupt working.\n");
-
 	if (self_test) {
 		ret = imx_rngc_self_test(rngc);
 		if (ret)
-- 
2.39.2

