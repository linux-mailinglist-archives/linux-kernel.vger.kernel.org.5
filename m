Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC7C78FE74
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349838AbjIANlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349794AbjIANky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:40:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59735E7E;
        Fri,  1 Sep 2023 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693575652; x=1725111652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hlLpdiIQzng6T1ig7H/wqqoNPL6qvJjJjvam1Mq+2K8=;
  b=i8ByNagikVLXszZZ4X3otUwVJGGPLuzbmTaLXKOa8U2anbG3Rft/Fyl+
   N/5h8gOVSky5diqrn8f3vUzBU3FP94epjFUFU8qhhR5vvxQdyyiT85rDb
   4xtdJUmfeuXFWxJ5PTm0fIpUFWb0Fh+66japFuONm9D1nntCgH+YE0UBV
   bVgGz82y7V4+z1X7DtPnjSnImmA3pxu0I/mJjMhYqNIUKxdW+YXhWoaM3
   sWYkYYHkzJSKe1l32V7pXOiVWCPVdGj/4RH/ASSK0elEyjIKkuIcdIDj1
   MzRfpgSbSMHg1vAtq28QNlmXFgms+I/7TGq4F/1UO8viRvuqX1NKt+An4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373617946"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="373617946"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="986684299"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="986684299"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 01 Sep 2023 06:40:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 481AE7DF; Fri,  1 Sep 2023 16:40:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 07/10] gpio: pca953x: Utilise temporary variable for struct gpio_chip
Date:   Fri,  1 Sep 2023 16:40:38 +0300
Message-Id: <20230901134041.1165562-7-andriy.shevchenko@linux.intel.com>
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

We have a temporary variable to keep pointer to struct gpio_chip.
Utilise it where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pca953x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 4aa15128c91f..fe113c74b7b2 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -680,9 +680,7 @@ static int pca953x_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 
 static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
 {
-	struct gpio_chip *gc;
-
-	gc = &chip->gpio_chip;
+	struct gpio_chip *gc = &chip->gpio_chip;
 
 	gc->direction_input  = pca953x_gpio_direction_input;
 	gc->direction_output = pca953x_gpio_direction_output;
@@ -915,6 +913,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 	struct device *dev = &client->dev;
 	DECLARE_BITMAP(reg_direction, MAX_LINE);
 	DECLARE_BITMAP(irq_stat, MAX_LINE);
+	struct gpio_chip *gc = &chip->gpio_chip;
 	struct gpio_irq_chip *girq;
 	int ret;
 
@@ -943,7 +942,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 	 * this purpose.
 	 */
 	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
-	bitmap_and(chip->irq_stat, irq_stat, reg_direction, chip->gpio_chip.ngpio);
+	bitmap_and(chip->irq_stat, irq_stat, reg_direction, gc->ngpio);
 	mutex_init(&chip->irq_lock);
 
 	girq = &chip->gpio_chip.irq;
-- 
2.40.0.1.gaa8946217a0b

