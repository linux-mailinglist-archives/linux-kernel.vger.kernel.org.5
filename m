Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222D37656AF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjG0PC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjG0PCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:02:20 -0400
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007641BD1;
        Thu, 27 Jul 2023 08:02:16 -0700 (PDT)
Received: from raven.mansr.com (raven.mansr.com [IPv6:2001:8b0:ca0d:1::3])
        by unicorn.mansr.com (Postfix) with ESMTPS id 70D7D15360;
        Thu, 27 Jul 2023 16:02:13 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id 62DC6221D92; Thu, 27 Jul 2023 16:02:13 +0100 (BST)
From:   Mans Rullgard <mans@mansr.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] rtc: sunxi: use external 32k oscillator if provided
Date:   Thu, 27 Jul 2023 16:01:23 +0100
Message-ID: <20230727150156.29691-1-mans@mansr.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the OSC32K_SRC_SEL bit in the LOSC control register if a clock is
specified in the devicetree.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
The newer sun6i rtc driver is a proper clk provider with parent
selection.  Doing the same thing in this driver would be difficult
while staying compatible with existing devicetrees.  For that reason,
this simpler approach seems reasonable.
---
 drivers/rtc/rtc-sunxi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
index 5d019e3a835a..4f1053eab778 100644
--- a/drivers/rtc/rtc-sunxi.c
+++ b/drivers/rtc/rtc-sunxi.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2013, Carlo Caione <carlo.caione@gmail.com>
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/fs.h>
@@ -21,8 +22,10 @@
 #include <linux/types.h>
 
 #define SUNXI_LOSC_CTRL				0x0000
+#define SUNXI_LOSC_CTRL_KEY			(0x16aa << 16)
 #define SUNXI_LOSC_CTRL_RTC_HMS_ACC		BIT(8)
 #define SUNXI_LOSC_CTRL_RTC_YMD_ACC		BIT(7)
+#define SUNXI_LOSC_CTRL_OSC32K_SRC_SEL		BIT(0)
 
 #define SUNXI_RTC_YMD				0x0004
 
@@ -422,6 +425,7 @@ MODULE_DEVICE_TABLE(of, sunxi_rtc_dt_ids);
 static int sunxi_rtc_probe(struct platform_device *pdev)
 {
 	struct sunxi_rtc_dev *chip;
+	struct clk *extclk;
 	int ret;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
@@ -455,6 +459,14 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/* use external oscillator if present */
+	extclk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
+	if (IS_ERR(extclk))
+		return PTR_ERR(extclk);
+	if (extclk)
+		writel(SUNXI_LOSC_CTRL_KEY | SUNXI_LOSC_CTRL_OSC32K_SRC_SEL,
+		       chip->base + SUNXI_LOSC_CTRL);
+
 	/* clear the alarm count value */
 	writel(0, chip->base + SUNXI_ALRM_DHMS);
 
-- 
2.41.0

