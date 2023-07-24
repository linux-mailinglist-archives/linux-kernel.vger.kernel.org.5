Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3FF75FB93
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjGXQNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGXQNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:13:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DD010CB;
        Mon, 24 Jul 2023 09:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690215196; x=1721751196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OvpuSgu/bv4KjS8fI5f2MwtNglY+5tuG7uCAwPmElOg=;
  b=KEgwWAPUnDd0G6xFTc70c5miJ7PG4AVLAts9g5LUHt9ljBt13L/R6faC
   0iLW27eN875JDd70tPku3KtJ3pezuQTHF5duhk2MTPxid2h6FPEWy2tpz
   xRZXAo9opBzwGQzdHWTiOqJRPEt12Ltvpi324xvECT3cyLk6LiPbiIKpF
   ec0oFUlwOiMGcIFAtp3buAXcdVoNRCRoNH3mnXFNH1X+Zap/PUuCgdxgA
   UejvILgWJ48/GFkzdsd+HDjvpCSarY1nJmxM67ruR3R80xgz2YmyI/EbD
   p43lajsnabePDy9LakUQNsjgnycHX6hKYdu3KEDzWork7UCsNpOVI2PcY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="364945368"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="364945368"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 09:13:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="702949233"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="702949233"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 24 Jul 2023 09:13:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 923692FF; Mon, 24 Jul 2023 19:13:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 4/6] gpio: ge: Utilise temporary variable for struct device
Date:   Mon, 24 Jul 2023 19:13:18 +0300
Message-Id: <20230724161320.63876-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230724161320.63876-1-andriy.shevchenko@linux.intel.com>
References: <20230724161320.63876-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a temporary variable to keep pointer to struct device.
Utilise it inside the ->probe() implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-ge.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-ge.c b/drivers/gpio/gpio-ge.c
index d019669048e6..268de5496fcb 100644
--- a/drivers/gpio/gpio-ge.c
+++ b/drivers/gpio/gpio-ge.c
@@ -59,7 +59,7 @@ static int __init gef_gpio_probe(struct platform_device *pdev)
 	void __iomem *regs;
 	int ret;
 
-	gc = devm_kzalloc(&pdev->dev, sizeof(*gc), GFP_KERNEL);
+	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
 	if (!gc)
 		return -ENOMEM;
 
@@ -67,9 +67,9 @@ static int __init gef_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	ret = bgpio_init(gc, &pdev->dev, 4, regs + GEF_GPIO_IN,
-			 regs + GEF_GPIO_OUT, NULL, NULL,
-			 regs + GEF_GPIO_DIRECT, BGPIOF_BIG_ENDIAN_BYTE_ORDER);
+	ret = bgpio_init(gc, dev, 4, regs + GEF_GPIO_IN, regs + GEF_GPIO_OUT,
+			 NULL, NULL, regs + GEF_GPIO_DIRECT,
+			 BGPIOF_BIG_ENDIAN_BYTE_ORDER);
 	if (ret)
 		return dev_err_probe(dev, ret, "bgpio_init failed\n");
 
@@ -82,7 +82,7 @@ static int __init gef_gpio_probe(struct platform_device *pdev)
 	gc->ngpio = (uintptr_t)device_get_match_data(dev);
 
 	/* This function adds a memory mapped GPIO chip */
-	ret = devm_gpiochip_add_data(&pdev->dev, gc, NULL);
+	ret = devm_gpiochip_add_data(dev, gc, NULL);
 	if (ret)
 		return dev_err_probe(dev, ret, "GPIO chip registration failed\n");
 
-- 
2.40.0.1.gaa8946217a0b

