Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1B6758EAD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjGSHUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjGSHUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:20:12 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8D7A4;
        Wed, 19 Jul 2023 00:20:11 -0700 (PDT)
Received: from ipservice-092-217-093-053.092.217.pools.vodafone-ip.de ([92.217.93.53] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qM1Tl-0008I7-L0; Wed, 19 Jul 2023 09:20:09 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/4] hwrng: cctrng - let devres enable the clock
Date:   Wed, 19 Jul 2023 09:18:04 +0200
Message-Id: <20230719071806.335718-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230719071806.335718-1-martin@kaiser.cx>
References: <20230719071806.335718-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call devm_clk_get_optional_enabled in the cctrng driver. We don't have to
disable and unprepare the clock any more in error paths or in the remove
function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/cctrng.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/char/hw_random/cctrng.c b/drivers/char/hw_random/cctrng.c
index 241da7e44675..ac4a2fbc6a0f 100644
--- a/drivers/char/hw_random/cctrng.c
+++ b/drivers/char/hw_random/cctrng.c
@@ -460,30 +460,16 @@ static int cc_trng_clk_init(struct cctrng_drvdata *drvdata)
 {
 	struct clk *clk;
 	struct device *dev = &(drvdata->pdev->dev);
-	int rc = 0;
 
-	clk = devm_clk_get_optional(dev, NULL);
+	clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk),
-				     "Error getting clock\n");
+				     "Failed to get or enable the clock\n");
 
 	drvdata->clk = clk;
-
-	rc = clk_prepare_enable(drvdata->clk);
-	if (rc) {
-		dev_err(dev, "Failed to enable clock\n");
-		return rc;
-	}
-
 	return 0;
 }
 
-static void cc_trng_clk_fini(struct cctrng_drvdata *drvdata)
-{
-	clk_disable_unprepare(drvdata->clk);
-}
-
-
 static int cctrng_probe(struct platform_device *pdev)
 {
 	struct cctrng_drvdata *drvdata;
@@ -545,7 +531,7 @@ static int cctrng_probe(struct platform_device *pdev)
 	rc = devm_request_irq(dev, irq, cc_isr, IRQF_SHARED, "cctrng", drvdata);
 	if (rc) {
 		dev_err(dev, "Could not register to interrupt %d\n", irq);
-		goto post_clk_err;
+		return rc;
 	}
 	dev_dbg(dev, "Registered to IRQ: %d\n", irq);
 
@@ -563,14 +549,14 @@ static int cctrng_probe(struct platform_device *pdev)
 	rc = cc_trng_pm_init(drvdata);
 	if (rc) {
 		dev_err(dev, "cc_trng_pm_init failed\n");
-		goto post_clk_err;
+		return rc;
 	}
 
 	/* increment device's usage counter */
 	rc = cc_trng_pm_get(dev);
 	if (rc) {
 		dev_err(dev, "cc_trng_pm_get returned %x\n", rc);
-		goto post_pm_err;
+		return rc;
 	}
 
 	/* set pending_hw to verify that HW won't be triggered from read */
@@ -597,9 +583,6 @@ static int cctrng_probe(struct platform_device *pdev)
 post_pm_err:
 	cc_trng_pm_fini(drvdata);
 
-post_clk_err:
-	cc_trng_clk_fini(drvdata);
-
 	return rc;
 }
 
@@ -612,8 +595,6 @@ static int cctrng_remove(struct platform_device *pdev)
 
 	cc_trng_pm_fini(drvdata);
 
-	cc_trng_clk_fini(drvdata);
-
 	dev_info(dev, "ARM cctrng device terminated\n");
 
 	return 0;
-- 
2.30.2

