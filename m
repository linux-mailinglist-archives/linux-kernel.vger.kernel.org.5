Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC37BC247
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjJFWnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbjJFWnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:43:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A1293;
        Fri,  6 Oct 2023 15:43:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB3EC433C7;
        Fri,  6 Oct 2023 22:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632228;
        bh=vU0MD6zQSd/9wJqpp2u4BnkSbs9vInQtgXvnmfV7Sp8=;
        h=From:To:Cc:Subject:Date:From;
        b=Vx3Jjwepc9I/PBd0V2H54HRiPKmZfWPZl8acvys5eMoJcTB2XWKf+OvSEeQRsg4gD
         YPv1rv23ybUvgvJlmnefuQX4tGMRdkqJ7ypfmJpnZkZs3hCPnMuja8OkpXhFyHABPD
         nxKw3dYwCkKWOZx/WFTHR4OPrVLH/Jxf7it14axbzCAQ0TUZV9DnK00Stjv1tmhJ2m
         0rLosWHAPTHUFv/deXYRlCA36/vdVglWoxJnJ35FfILgNdmIw/1N9+pDDR4Ok8fQen
         /EStTvj317d7slOGAG/FUMmlZzcOJMKpYolUkX+fWJQdpoydvTKO3n9T0bKM3E2Ppy
         q8C7CMdhQCBJw==
Received: (nullmailer pid 441819 invoked by uid 1000);
        Fri, 06 Oct 2023 22:43:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: jz4740: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 17:43:43 -0500
Message-Id: <20231006224343.441720-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mmc/host/jz4740_mmc.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index f379ce5b582d..6a45991ca056 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -18,9 +18,10 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/scatterlist.h>
 
@@ -1040,7 +1041,6 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	int ret;
 	struct mmc_host *mmc;
 	struct jz4740_mmc_host *host;
-	const struct of_device_id *match;
 
 	mmc = mmc_alloc_host(sizeof(struct jz4740_mmc_host), &pdev->dev);
 	if (!mmc) {
@@ -1050,13 +1050,8 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 
 	host = mmc_priv(mmc);
 
-	match = of_match_device(jz4740_mmc_of_match, &pdev->dev);
-	if (match) {
-		host->version = (enum jz4740_mmc_version)match->data;
-	} else {
-		/* JZ4740 should be the only one using legacy probe */
-		host->version = JZ_MMC_JZ4740;
-	}
+	/* Default if no match is JZ4740 */
+	host->version = (enum jz4740_mmc_version)device_get_match_data(&pdev->dev);
 
 	ret = mmc_of_parse(mmc);
 	if (ret) {
@@ -1200,7 +1195,7 @@ static struct platform_driver jz4740_mmc_driver = {
 	.driver = {
 		.name = "jz4740-mmc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.of_match_table = of_match_ptr(jz4740_mmc_of_match),
+		.of_match_table = jz4740_mmc_of_match,
 		.pm = pm_sleep_ptr(&jz4740_mmc_pm_ops),
 	},
 };
-- 
2.40.1

