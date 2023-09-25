Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F217AD81B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjIYMf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYMfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:35:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DD3C0;
        Mon, 25 Sep 2023 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695645349; x=1727181349;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Go8vp6v/man3xMFIBg9nrX061VD2PHNMhl/FU5ZA2k4=;
  b=VyM11OlQZUW1Y/qi5LeFO72al6gvh4cn0s1OD2X/2RHxY+jGm2AOsRnk
   BYEpex9irElZ7e/NeO0GAI3wCNucjdPIdOwguYgnrQC9SLS3WrEc8py3O
   6m0urVidpAldUsKrft1d6du/F2rrlV2dSLUFT/uXrQXVVrYZSuNdNF4Fs
   pNnnRldC9MnY4nLUzYmfvVmzAMQM7n3uRfOA9G1sjEOiCpeHBXGcgluX4
   6XOR3YeqqpFZ6KORudnJlbMj5g9C/kfEE7f7EUcV3Uwf+P6KibKs0xaEX
   M/LmMdIKjQtt49P7EThyXzxyZnyqlijCor+Pw7U4nsU2OcYaaoK+C/qKy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="371560313"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="371560313"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 05:35:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818595758"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="818595758"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 25 Sep 2023 05:35:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 470F6761; Mon, 25 Sep 2023 15:35:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v1 1/1] watchdog: gpio_wdt: Make use of device properties
Date:   Mon, 25 Sep 2023 15:35:43 +0300
Message-Id: <20230925123543.2945710-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Include mod_devicetable.h explicitly to replace the dropped of.h
which included mod_devicetable.h indirectly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/watchdog/gpio_wdt.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 0923201ce874..a7b814ea740b 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -5,12 +5,13 @@
  * Author: 2013, Alexander Shiyan <shc_work@mail.ru>
  */
 
-#include <linux/err.h>
 #include <linux/delay.h>
-#include <linux/module.h>
+#include <linux/err.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/watchdog.h>
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -106,7 +107,6 @@ static const struct watchdog_ops gpio_wdt_ops = {
 static int gpio_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct gpio_wdt_priv *priv;
 	enum gpiod_flags gflags;
 	unsigned int hw_margin;
@@ -119,7 +119,7 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	ret = of_property_read_string(np, "hw_algo", &algo);
+	ret = device_property_read_string(dev, "hw_algo", &algo);
 	if (ret)
 		return ret;
 	if (!strcmp(algo, "toggle")) {
@@ -136,16 +136,14 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->gpiod))
 		return PTR_ERR(priv->gpiod);
 
-	ret = of_property_read_u32(np,
-				   "hw_margin_ms", &hw_margin);
+	ret = device_property_read_u32(dev, "hw_margin_ms", &hw_margin);
 	if (ret)
 		return ret;
 	/* Disallow values lower than 2 and higher than 65535 ms */
 	if (hw_margin < 2 || hw_margin > 65535)
 		return -EINVAL;
 
-	priv->always_running = of_property_read_bool(np,
-						     "always-running");
+	priv->always_running = device_property_read_bool(dev, "always-running");
 
 	watchdog_set_drvdata(&priv->wdd, priv);
 
-- 
2.40.0.1.gaa8946217a0b

