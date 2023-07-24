Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3374175FB9B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjGXQNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjGXQNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:13:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9D110C7;
        Mon, 24 Jul 2023 09:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690215202; x=1721751202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XpVwes2CK3DStBzedXTEx9rcqomEgbPZWxviJ1EUWe8=;
  b=jlBBdbs76Qp3/avnmdo4pRRsOEWKcbIM9VYEJgBUDevihuKeiadgA/Ab
   cwKKE5H3xJPuPA/2yF8CJEYAIF5ZeztRqWr+PvLqXM7cytRE3mrkO/7NZ
   AzQ12sBQier8I/i3JRKZ2Qvglz22tGsaQ/0wDSpdcQ/4Pa/7F2E6HdeYm
   38E92n6eUyJYoZGs9HPBVOlcb76vUsIvoVYAkcAgfEfnXiJjay8oJSSVO
   sNaU1AUiB+dhLtz+3GrO++NX/J5h04HYtd8G6SlcE47OajXuXn8Jmybv0
   t6b15sjJ4qX5gs3ugi66ka65mBR11wpLqRXJ0zWsuVpEI3tIRRDEDKv6W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="347089841"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347089841"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 09:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="815884108"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815884108"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 09:13:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8AAA22E9; Mon, 24 Jul 2023 19:13:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 3/6] gpio: ge: Make driver OF-independent
Date:   Mon, 24 Jul 2023 19:13:17 +0300
Message-Id: <20230724161320.63876-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230724161320.63876-1-andriy.shevchenko@linux.intel.com>
References: <20230724161320.63876-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing in the driver that requires OF APIs,
make the driver OF independent.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-ge.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpio-ge.c b/drivers/gpio/gpio-ge.c
index f92b3c8a3a8a..d019669048e6 100644
--- a/drivers/gpio/gpio-ge.c
+++ b/drivers/gpio/gpio-ge.c
@@ -21,10 +21,10 @@
 #include <linux/gpio/driver.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #define GEF_GPIO_DIRECT		0x00
@@ -54,6 +54,7 @@ MODULE_DEVICE_TABLE(of, gef_gpio_ids);
 
 static int __init gef_gpio_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct gpio_chip *gc;
 	void __iomem *regs;
 	int ret;
@@ -62,38 +63,30 @@ static int __init gef_gpio_probe(struct platform_device *pdev)
 	if (!gc)
 		return -ENOMEM;
 
-	regs = of_iomap(pdev->dev.of_node, 0);
-	if (!regs)
-		return -ENOMEM;
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	ret = bgpio_init(gc, &pdev->dev, 4, regs + GEF_GPIO_IN,
 			 regs + GEF_GPIO_OUT, NULL, NULL,
 			 regs + GEF_GPIO_DIRECT, BGPIOF_BIG_ENDIAN_BYTE_ORDER);
-	if (ret) {
-		dev_err(&pdev->dev, "bgpio_init failed\n");
-		goto err0;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "bgpio_init failed\n");
 
 	/* Setup pointers to chip functions */
-	gc->label = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOF", pdev->dev.of_node);
-	if (!gc->label) {
-		ret = -ENOMEM;
-		goto err0;
-	}
+	gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pfw", dev_fwnode(dev));
+	if (!gc->label)
+		return -ENOMEM;
 
 	gc->base = -1;
-	gc->ngpio = (u16)(uintptr_t)of_device_get_match_data(&pdev->dev);
+	gc->ngpio = (uintptr_t)device_get_match_data(dev);
 
 	/* This function adds a memory mapped GPIO chip */
 	ret = devm_gpiochip_add_data(&pdev->dev, gc, NULL);
 	if (ret)
-		goto err0;
+		return dev_err_probe(dev, ret, "GPIO chip registration failed\n");
 
 	return 0;
-err0:
-	iounmap(regs);
-	pr_err("%pOF: GPIO chip registration failed\n", pdev->dev.of_node);
-	return ret;
 };
 
 static struct platform_driver gef_gpio_driver = {
-- 
2.40.0.1.gaa8946217a0b

