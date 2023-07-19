Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77B3758EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGSHU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjGSHUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:20:16 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14164E43;
        Wed, 19 Jul 2023 00:20:15 -0700 (PDT)
Received: from ipservice-092-217-093-053.092.217.pools.vodafone-ip.de ([92.217.93.53] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qM1Tp-0008I7-LB; Wed, 19 Jul 2023 09:20:13 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/4] hwrng: cctrng - use dev_err_probe in error paths
Date:   Wed, 19 Jul 2023 09:18:06 +0200
Message-Id: <20230719071806.335718-5-martin@kaiser.cx>
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

Use dev_err_probe in error paths to make the code a bit shorter.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/cctrng.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/char/hw_random/cctrng.c b/drivers/char/hw_random/cctrng.c
index 2a1887f6483f..1abbff04a015 100644
--- a/drivers/char/hw_random/cctrng.c
+++ b/drivers/char/hw_random/cctrng.c
@@ -485,10 +485,8 @@ static int cctrng_probe(struct platform_device *pdev)
 	drvdata->circ.buf = (char *)drvdata->data_buf;
 
 	drvdata->cc_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(drvdata->cc_base)) {
-		dev_err(dev, "Failed to ioremap registers");
-		return PTR_ERR(drvdata->cc_base);
-	}
+	if (IS_ERR(drvdata->cc_base))
+		return dev_err_probe(dev, PTR_ERR(drvdata->cc_base), "Failed to ioremap registers");
 
 	/* Then IRQ */
 	irq = platform_get_irq(pdev, 0);
@@ -497,10 +495,8 @@ static int cctrng_probe(struct platform_device *pdev)
 
 	/* parse sampling rate from device tree */
 	rc = cc_trng_parse_sampling_ratio(drvdata);
-	if (rc) {
-		dev_err(dev, "Failed to get legal sampling ratio for rosc\n");
-		return rc;
-	}
+	if (rc)
+		return dev_err_probe(dev, rc, "Failed to get legal sampling ratio for rosc\n");
 
 	drvdata->clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(drvdata->clk))
@@ -513,10 +509,8 @@ static int cctrng_probe(struct platform_device *pdev)
 
 	/* register the driver isr function */
 	rc = devm_request_irq(dev, irq, cc_isr, IRQF_SHARED, "cctrng", drvdata);
-	if (rc) {
-		dev_err(dev, "Could not register to interrupt %d\n", irq);
-		return rc;
-	}
+	if (rc)
+		return dev_err_probe(dev, rc, "Could not register to interrupt %d\n", irq);
 	dev_dbg(dev, "Registered to IRQ: %d\n", irq);
 
 	/* Clear all pending interrupts */
@@ -531,17 +525,13 @@ static int cctrng_probe(struct platform_device *pdev)
 
 	/* init PM */
 	rc = cc_trng_pm_init(drvdata);
-	if (rc) {
-		dev_err(dev, "cc_trng_pm_init failed\n");
-		return rc;
-	}
+	if (rc)
+		return dev_err_probe(dev, rc, "cc_trng_pm_init failed\n");
 
 	/* increment device's usage counter */
 	rc = cc_trng_pm_get(dev);
-	if (rc) {
-		dev_err(dev, "cc_trng_pm_get returned %x\n", rc);
-		return rc;
-	}
+	if (rc)
+		return dev_err_probe(dev, rc, "cc_trng_pm_get returned %x\n", rc);
 
 	/* set pending_hw to verify that HW won't be triggered from read */
 	atomic_set(&drvdata->pending_hw, 1);
-- 
2.30.2

