Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC8E7CAE97
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjJPQKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbjJPQKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:10:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F44AFA;
        Mon, 16 Oct 2023 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697472629; x=1729008629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F25NQtPqRcWKTHovw7qS8Bdu+1VMkD5tR6I2DEWwAqs=;
  b=jQBJ2hwoROkx8FvePD8cc/B7D1l+VXlme1DFt/iGGBKcva08wcvm21sU
   7OYV/1S2/wGFX3XV9lxfb+C23cQxCnQJMxX4Q31yYAph+X1TjxkHA39nf
   MhW6QMxPoM0JhPDi+k1gEDt1HdE/tThYJgG2Hm3fFb0n6+oC5aUPfLpVX
   HQsbdkID3+lHJDbZ13+zFpZ0zKzm7zRZXDYi6Pc8TulGgSmE3zYn+bj1B
   mhEGhydFuGMQCg5gmqjK/LYLpzGn4QEghdGhU353lPhh44hvcjOU1H0rx
   RzPaPqZdSZ0cGp5L/0AzMAgRsOIKSc/nY8mz+9i04oPYkRJRDJEBisRmL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="7132780"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="7132780"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 09:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785123039"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="785123039"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2023 09:10:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2FDCE988; Mon, 16 Oct 2023 19:10:09 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Subject: [PATCH v1 4/6] leds: gpio: Move temporary variable for struct device to gpio_led_probe()
Date:   Mon, 16 Oct 2023 19:10:03 +0300
Message-Id: <20231016161005.1471768-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231016161005.1471768-1-andriy.shevchenko@linux.intel.com>
References: <20231016161005.1471768-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use temporary variable for struct device in gpio_led_probe() in order
to make code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/leds-gpio.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index 7c9c6a93dfd7..fd3f90f95fa2 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -142,9 +142,8 @@ struct gpio_leds_priv {
 	struct gpio_led_data leds[] __counted_by(num_leds);
 };
 
-static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
+static struct gpio_leds_priv *gpio_leds_create(struct device *dev)
 {
-	struct device *dev = &pdev->dev;
 	struct fwnode_handle *child;
 	struct gpio_leds_priv *priv;
 	int count, ret;
@@ -253,13 +252,13 @@ static struct gpio_desc *gpio_led_get_gpiod(struct device *dev, int idx,
 
 static int gpio_led_probe(struct platform_device *pdev)
 {
-	struct gpio_led_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct gpio_led_platform_data *pdata = dev_get_platdata(dev);
 	struct gpio_leds_priv *priv;
 	int i, ret = 0;
 
 	if (pdata && pdata->num_leds) {
-		priv = devm_kzalloc(&pdev->dev, struct_size(priv, leds, pdata->num_leds),
-				    GFP_KERNEL);
+		priv = devm_kzalloc(dev, struct_size(priv, leds, pdata->num_leds), GFP_KERNEL);
 		if (!priv)
 			return -ENOMEM;
 
@@ -272,22 +271,20 @@ static int gpio_led_probe(struct platform_device *pdev)
 				led_dat->gpiod = template->gpiod;
 			else
 				led_dat->gpiod =
-					gpio_led_get_gpiod(&pdev->dev,
-							   i, template);
+					gpio_led_get_gpiod(dev, i, template);
 			if (IS_ERR(led_dat->gpiod)) {
-				dev_info(&pdev->dev, "Skipping unavailable LED gpio %d (%s)\n",
+				dev_info(dev, "Skipping unavailable LED gpio %d (%s)\n",
 					 template->gpio, template->name);
 				continue;
 			}
 
-			ret = create_gpio_led(template, led_dat,
-					      &pdev->dev, NULL,
+			ret = create_gpio_led(template, led_dat, dev, NULL,
 					      pdata->gpio_blink_set);
 			if (ret < 0)
 				return ret;
 		}
 	} else {
-		priv = gpio_leds_create(pdev);
+		priv = gpio_leds_create(dev);
 		if (IS_ERR(priv))
 			return PTR_ERR(priv);
 	}
-- 
2.40.0.1.gaa8946217a0b

