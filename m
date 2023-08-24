Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25E578787A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243202AbjHXTYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjHXTXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:23:50 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1951BDF;
        Thu, 24 Aug 2023 12:23:48 -0700 (PDT)
Received: from dslb-188-097-211-187.188.097.pools.vodafone-ip.de ([188.97.211.187] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qZFvl-00036P-Io; Thu, 24 Aug 2023 21:23:45 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 5/6] hwrng: imx-rngc - use polling for initial seed
Date:   Thu, 24 Aug 2023 21:20:58 +0200
Message-Id: <20230824192059.1569591-6-martin@kaiser.cx>
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

Use polling instead of interrupt + completion to wait until the initial
seed was calculated. This should take about 30ms.

Call readl_poll_timeout and set the poll interval to the recommended
maximum of 20ms. readl_poll_timeout uses usleep_range, this is based on
a hrtimer. The task will we put to sleep while waiting, this does not
burn CPU cycles by waiting in the foreground.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
- use shorter timeout and polling interval
- readl_poll_timeout does not wait in the foreground

 drivers/char/hw_random/imx-rngc.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index c2582673427d..3a3f0f923bed 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -166,34 +166,29 @@ static irqreturn_t imx_rngc_irq(int irq, void *priv)
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
 
-		ret = wait_for_completion_timeout(&rngc->rng_op_done,
-						  usecs_to_jiffies(RNGC_SEED_TIMEOUT));
-		if (!ret) {
-			ret = -ETIMEDOUT;
-			goto err;
-		}
+		ret = readl_poll_timeout(rngc->base + RNGC_STATUS, status,
+					 status & RNGC_STATUS_SEED_DONE, 20000, RNGC_SEED_TIMEOUT);
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
@@ -209,10 +204,6 @@ static int imx_rngc_init(struct hwrng *rng)
 	 * we mask the interrupt ourselves if we return an error
 	 */
 	return 0;
-
-err:
-	imx_rngc_irq_mask_clear(rngc);
-	return ret;
 }
 
 static void imx_rngc_cleanup(struct hwrng *rng)
-- 
2.39.2

