Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5BD7878E7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243318AbjHXToC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240023AbjHXTn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:43:29 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F75E1BDF;
        Thu, 24 Aug 2023 12:43:27 -0700 (PDT)
Received: from dslb-188-097-211-187.188.097.pools.vodafone-ip.de ([188.97.211.187] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qZGEo-0003HB-5c; Thu, 24 Aug 2023 21:43:26 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/3] hwrng: ks-sa - access private data via struct hwrng
Date:   Thu, 24 Aug 2023 21:40:35 +0200
Message-Id: <20230824194037.1575276-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824194037.1575276-1-martin@kaiser.cx>
References: <20230824194037.1575276-1-martin@kaiser.cx>
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

This driver uses a struct ks_sa_rng for its private data. It contains a
struct hwrng. Call container_of to get from hwrng to ks_sa_rng.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/ks-sa-rng.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/char/hw_random/ks-sa-rng.c b/drivers/char/hw_random/ks-sa-rng.c
index 2f2f21f1b659..0857964f8714 100644
--- a/drivers/char/hw_random/ks-sa-rng.c
+++ b/drivers/char/hw_random/ks-sa-rng.c
@@ -113,8 +113,7 @@ static unsigned int refill_delay_ns(unsigned long clk_rate)
 static int ks_sa_rng_init(struct hwrng *rng)
 {
 	u32 value;
-	struct device *dev = (struct device *)rng->priv;
-	struct ks_sa_rng *ks_sa_rng = dev_get_drvdata(dev);
+	struct ks_sa_rng *ks_sa_rng = container_of(rng, struct ks_sa_rng, rng);
 	unsigned long clk_rate = clk_get_rate(ks_sa_rng->clk);
 
 	/* Enable RNG module */
@@ -153,8 +152,7 @@ static int ks_sa_rng_init(struct hwrng *rng)
 
 static void ks_sa_rng_cleanup(struct hwrng *rng)
 {
-	struct device *dev = (struct device *)rng->priv;
-	struct ks_sa_rng *ks_sa_rng = dev_get_drvdata(dev);
+	struct ks_sa_rng *ks_sa_rng = container_of(rng, struct ks_sa_rng, rng);
 
 	/* Disable RNG */
 	writel(0, &ks_sa_rng->reg_rng->control);
@@ -164,8 +162,7 @@ static void ks_sa_rng_cleanup(struct hwrng *rng)
 
 static int ks_sa_rng_data_read(struct hwrng *rng, u32 *data)
 {
-	struct device *dev = (struct device *)rng->priv;
-	struct ks_sa_rng *ks_sa_rng = dev_get_drvdata(dev);
+	struct ks_sa_rng *ks_sa_rng = container_of(rng, struct ks_sa_rng, rng);
 
 	/* Read random data */
 	data[0] = readl(&ks_sa_rng->reg_rng->output_l);
@@ -179,8 +176,7 @@ static int ks_sa_rng_data_read(struct hwrng *rng, u32 *data)
 
 static int ks_sa_rng_data_present(struct hwrng *rng, int wait)
 {
-	struct device *dev = (struct device *)rng->priv;
-	struct ks_sa_rng *ks_sa_rng = dev_get_drvdata(dev);
+	struct ks_sa_rng *ks_sa_rng = container_of(rng, struct ks_sa_rng, rng);
 	u64 now = ktime_get_ns();
 
 	u32	ready;
@@ -225,7 +221,6 @@ static int ks_sa_rng_probe(struct platform_device *pdev)
 		.data_present = ks_sa_rng_data_present,
 		.cleanup = ks_sa_rng_cleanup,
 	};
-	ks_sa_rng->rng.priv = (unsigned long)dev;
 
 	ks_sa_rng->reg_rng = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ks_sa_rng->reg_rng))
@@ -248,8 +243,6 @@ static int ks_sa_rng_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, ks_sa_rng);
-
 	return devm_hwrng_register(&pdev->dev, &ks_sa_rng->rng);
 }
 
-- 
2.39.2

