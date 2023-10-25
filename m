Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3FB7D737B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjJYSnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjJYSnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:43:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56946111;
        Wed, 25 Oct 2023 11:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698259389; x=1729795389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dpLiufvLW4ReyqiDHIArSLkX2JA+hA4CEIqKp4YRTIA=;
  b=Fq/B05hjLOj7NVxInMmTm3MMZNDfOue2B2WXBujoPldP6kxsC3MLuRbW
   lrBOJDpien2tSkFgptlLCtg64kaixV/P7gK4zP3yZ+JBjaGRipkRogCDY
   2fi7oaEAh5YqqyBZesK/o9Li/ojC4QNoe+YPfBnv1GQdu303IIxjXN7bG
   Xp9ehJDQIS7uCKEIBLcH5jA75vEF951p3GlKcSHOvv6pd68PLQS5FZHrD
   REqzD9A+6WXA1EpB7uSV2p1C1fT2wFBtw1mkpEhWS5gtcls0AnU3DpzgN
   pd7IWKNU3dhB+X4z7P6gU27tvHTLfiIMxXTDKqY5mXy/T3jaU1PGB+UsX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="390233013"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="390233013"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="932458248"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="932458248"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 25 Oct 2023 11:43:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E0D64430; Wed, 25 Oct 2023 21:43:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v1 2/3] gpio: mmio: Make use of device properties
Date:   Wed, 25 Oct 2023 21:42:58 +0300
Message-Id: <20231025184259.250588-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-mmio.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index 3ff0ea1e351c..66308b165a0d 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -58,7 +58,6 @@ o        `                     ~~~~\___/~~~~    ` controller in FPGA is ,.`
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/mod_devicetable.h>
-#include <linux/of.h>
 
 #include "gpiolib.h"
 
@@ -688,7 +687,6 @@ static void __iomem *bgpio_map(struct platform_device *pdev,
 	return devm_ioremap_resource(&pdev->dev, r);
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id bgpio_of_match[] = {
 	{ .compatible = "brcm,bcm6345-gpio" },
 	{ .compatible = "wd,mbl-gpio" },
@@ -697,36 +695,27 @@ static const struct of_device_id bgpio_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, bgpio_of_match);
 
-static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
-					  unsigned long *flags)
+static struct bgpio_pdata *bgpio_parse_fw(struct device *dev, unsigned long *flags)
 {
 	struct bgpio_pdata *pdata;
 
-	if (!pdev->dev.of_node)
+	if (!dev_fwnode(dev))
 		return NULL;
 
-	pdata = devm_kzalloc(&pdev->dev, sizeof(struct bgpio_pdata),
-			     GFP_KERNEL);
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
 	pdata->base = -1;
 
-	if (of_device_is_big_endian(pdev->dev.of_node))
+	if (device_is_big_endian(dev))
 		*flags |= BGPIOF_BIG_ENDIAN_BYTE_ORDER;
 
-	if (of_property_read_bool(pdev->dev.of_node, "no-output"))
+	if (device_property_read_bool(dev, "no-output"))
 		*flags |= BGPIOF_NO_OUTPUT;
 
 	return pdata;
 }
-#else
-static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
-					  unsigned long *flags)
-{
-	return NULL;
-}
-#endif /* CONFIG_OF */
 
 static int bgpio_pdev_probe(struct platform_device *pdev)
 {
@@ -743,7 +732,7 @@ static int bgpio_pdev_probe(struct platform_device *pdev)
 	struct gpio_chip *gc;
 	struct bgpio_pdata *pdata;
 
-	pdata = bgpio_parse_dt(pdev, &flags);
+	pdata = bgpio_parse_fw(dev, &flags);
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
 
@@ -814,7 +803,7 @@ MODULE_DEVICE_TABLE(platform, bgpio_id_table);
 static struct platform_driver bgpio_driver = {
 	.driver = {
 		.name = "basic-mmio-gpio",
-		.of_match_table = of_match_ptr(bgpio_of_match),
+		.of_match_table = bgpio_of_match,
 	},
 	.id_table = bgpio_id_table,
 	.probe = bgpio_pdev_probe,
-- 
2.40.0.1.gaa8946217a0b

