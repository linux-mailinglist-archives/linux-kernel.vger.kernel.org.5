Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2212B78787B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243207AbjHXTYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243165AbjHXTXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:23:51 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA361BE9;
        Thu, 24 Aug 2023 12:23:48 -0700 (PDT)
Received: from dslb-188-097-211-187.188.097.pools.vodafone-ip.de ([188.97.211.187] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qZFvm-00036P-E7; Thu, 24 Aug 2023 21:23:46 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 6/6] hwrng: imx-rngc - remove interrupt handler
Date:   Thu, 24 Aug 2023 21:20:59 +0200
Message-Id: <20230824192059.1569591-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824192059.1569591-1-martin@kaiser.cx>
References: <20230824192059.1569591-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the interrupt handler and the code for its installation and
cleanup.

We use readl_poll_timeout now for the selftest and the initial seed.
There are no more users of the interrupt.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
- separate commit for removing irq code

 drivers/char/hw_random/imx-rngc.c | 55 -------------------------------
 1 file changed, 55 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 3a3f0f923bed..7fe09c59ce19 100644
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
@@ -143,26 +128,6 @@ static int imx_rngc_read(struct hwrng *rng, void *data, size_t max, bool wait)
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
@@ -198,21 +163,9 @@ static int imx_rngc_init(struct hwrng *rng)
 	ctrl |= RNGC_CTRL_AUTO_SEED;
 	writel(ctrl, rngc->base + RNGC_CONTROL);
 
-	/*
-	 * if initialisation was successful, we keep the interrupt
-	 * unmasked until imx_rngc_cleanup is called
-	 * we mask the interrupt ourselves if we return an error
-	 */
 	return 0;
 }
 
-static void imx_rngc_cleanup(struct hwrng *rng)
-{
-	struct imx_rngc *rngc = container_of(rng, struct imx_rngc, rng);
-
-	imx_rngc_irq_mask_clear(rngc);
-}
-
 static int __init imx_rngc_probe(struct platform_device *pdev)
 {
 	struct imx_rngc *rngc;
@@ -246,12 +199,9 @@ static int __init imx_rngc_probe(struct platform_device *pdev)
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
@@ -259,11 +209,6 @@ static int __init imx_rngc_probe(struct platform_device *pdev)
 
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

