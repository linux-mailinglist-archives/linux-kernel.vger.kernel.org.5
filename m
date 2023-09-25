Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9857ACEB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjIYDZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjIYDZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:25:53 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587CAC5;
        Sun, 24 Sep 2023 20:25:45 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 38P3P3TH045477;
        Mon, 25 Sep 2023 11:25:03 +0800 (+08)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Rv7Sv3hfGz2SX8n4;
        Mon, 25 Sep 2023 11:21:35 +0800 (CST)
Received: from ubt.spreadtrum.com (10.0.73.70) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 25 Sep
 2023 11:25:01 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
CC:     <linux-leds@vger.kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] leds: sc27xx: Move mutex_init() to the end of probe
Date:   Mon, 25 Sep 2023 11:24:53 +0800
Message-ID: <20230925032453.724518-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.73.70]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 38P3P3TH045477
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the mutex_init() to avoid redundant mutex_destroy() calls after
that for each time the probe fails.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
V2:
- Move the mutex_init() to the end of .probe() instead of adding
mutex_destroy() according to Lee's comments.
---
 drivers/leds/leds-sc27xx-bltc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
index e199ea15e406..d9183addf7f5 100644
--- a/drivers/leds/leds-sc27xx-bltc.c
+++ b/drivers/leds/leds-sc27xx-bltc.c
@@ -296,7 +296,6 @@ static int sc27xx_led_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, priv);
-	mutex_init(&priv->lock);
 	priv->base = base;
 	priv->regmap = dev_get_regmap(dev->parent, NULL);
 	if (!priv->regmap) {
@@ -309,13 +308,11 @@ static int sc27xx_led_probe(struct platform_device *pdev)
 		err = of_property_read_u32(child, "reg", &reg);
 		if (err) {
 			of_node_put(child);
-			mutex_destroy(&priv->lock);
 			return err;
 		}
 
 		if (reg >= SC27XX_LEDS_MAX || priv->leds[reg].active) {
 			of_node_put(child);
-			mutex_destroy(&priv->lock);
 			return -EINVAL;
 		}
 
@@ -325,9 +322,11 @@ static int sc27xx_led_probe(struct platform_device *pdev)
 
 	err = sc27xx_led_register(dev, priv);
 	if (err)
-		mutex_destroy(&priv->lock);
+		return err;
 
-	return err;
+	mutex_init(&priv->lock);
+
+	return 0;
 }
 
 static int sc27xx_led_remove(struct platform_device *pdev)
-- 
2.41.0

