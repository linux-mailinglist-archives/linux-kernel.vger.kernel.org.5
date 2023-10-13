Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E3E7C7B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjJMCVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJMCVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:21:30 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253FF95;
        Thu, 12 Oct 2023 19:21:25 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 39D2KavT049391;
        Fri, 13 Oct 2023 10:20:36 +0800 (+08)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4S699Y2KqQz2KG27m;
        Fri, 13 Oct 2023 10:16:33 +0800 (CST)
Received: from ubt.spreadtrum.com (10.0.73.88) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 13 Oct
 2023 10:20:34 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
CC:     <linux-leds@vger.kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V3] leds: sc27xx: Move mutex_init() down
Date:   Fri, 13 Oct 2023 10:20:10 +0800
Message-ID: <20231013022010.854367-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.73.88]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 39D2KavT049391
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the mutex_init() to avoid redundant mutex_destroy() calls after
that for each time the probe fails.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
Rebased onto linux-next.

V3: Move the mutex_init() before sc27xx_led_register(), in case it maybe
used right after led registerd.

V2: Move the mutex_init() to the end of .probe() instead of adding mutex_destroy().
---
 drivers/leds/leds-sc27xx-bltc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
index af1f00a2f328..f04db793e8d6 100644
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
 
@@ -323,6 +320,8 @@ static int sc27xx_led_probe(struct platform_device *pdev)
 		priv->leds[reg].active = true;
 	}
 
+	mutex_init(&priv->lock);
+
 	err = sc27xx_led_register(dev, priv);
 	if (err)
 		mutex_destroy(&priv->lock);
-- 
2.41.0

