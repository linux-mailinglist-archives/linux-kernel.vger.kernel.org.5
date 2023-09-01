Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1209578FE6D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349813AbjIANk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbjIANkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:40:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8549E77;
        Fri,  1 Sep 2023 06:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693575650; x=1725111650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h89JL8MROH1TsXqD+O8VwXHzswGkoxREgQCkA7hcAz8=;
  b=XRWciBCy7oGdAaT1ttYO15tH6pAZP5Q1hG+Mw+AbCl72poQZW4M0T8X3
   1yirhWu4B3wDNJGdMjpSbgKOllc2kOvmnA+kbYqg50y0JAnL/XN0UphdT
   8gkQap0v3ejwPKYsJzrmP3l7cO90OeKvPEOW3cMlXXPDjJh1vyzch3mnu
   iWURualrHdXL32lfVrKIe2YXa4tKRC2ioVwvrocVyfyIV3SghbqEjGoW0
   Jvi2mJnT0jxD++57FTY8feGFnvrzaDhskCqHDkZiXgYh4nqSMII3/KFJ5
   9CwKGF3j9M2YJbmHsQewoUSAKjAmDN+4TPrbnAhaaD9EsPctlScnoqdYa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="355718603"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="355718603"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854711317"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="854711317"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 01 Sep 2023 06:40:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 534A581C; Fri,  1 Sep 2023 16:40:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 08/10] gpio: pca953x: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
Date:   Fri,  1 Sep 2023 16:40:39 +0300
Message-Id: <20230901134041.1165562-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
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

SIMPLE_DEV_PM_OPS() is deprecated, replace it with pm_sleep_ptr()
and DEFINE_SIMPLE_DEV_PM_OPS() for setting the driver's PM routines.
We can now remove the ifdeffery surrounding the suspend and resume
functions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pca953x.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index fe113c74b7b2..bf27e2d920f7 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1164,7 +1164,6 @@ static int pca953x_probe(struct i2c_client *client)
 	return devm_gpiochip_add_data(dev, &chip->gpio_chip, chip);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int pca953x_regcache_sync(struct pca953x_chip *chip)
 {
 	struct device *dev = &chip->client->dev;
@@ -1270,7 +1269,8 @@ static int pca953x_resume(struct device *dev)
 
 	return 0;
 }
-#endif
+
+static DEFINE_SIMPLE_DEV_PM_OPS(pca953x_pm_ops, pca953x_suspend, pca953x_resume);
 
 /* convenience to stop overlong match-table lines */
 #define OF_653X(__nrgpio, __int) ((void *)(__nrgpio | PCAL653X_TYPE | __int))
@@ -1328,12 +1328,10 @@ static const struct of_device_id pca953x_dt_ids[] = {
 
 MODULE_DEVICE_TABLE(of, pca953x_dt_ids);
 
-static SIMPLE_DEV_PM_OPS(pca953x_pm_ops, pca953x_suspend, pca953x_resume);
-
 static struct i2c_driver pca953x_driver = {
 	.driver = {
 		.name	= "pca953x",
-		.pm	= &pca953x_pm_ops,
+		.pm	= pm_sleep_ptr(&pca953x_pm_ops),
 		.of_match_table = pca953x_dt_ids,
 		.acpi_match_table = pca953x_acpi_ids,
 	},
-- 
2.40.0.1.gaa8946217a0b

