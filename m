Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91ABB78FE77
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349808AbjIANk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349783AbjIANkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:40:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD73E4C;
        Fri,  1 Sep 2023 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693575649; x=1725111649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sjkw9blR7lrj8rU5FhWqajRdJOMeEfGAx83S3/jcdd4=;
  b=Cw27xvGRILy3AGnRs9iB2+vOapXW/TVFlghxIiQFNZyGRf8faPNZEmwg
   phNxPRFzhfAV+1leoJL67w6/LP9d51qLct2YM0qefyl8s313EVJpAXWiH
   rrDF9kIL+9Gtt7dz1Ol59lUbe76i+DUttcfSFHEmZyMIfJqnMedq+ekzT
   xJJXYLw9hbIVaKqE5nYSwUW3lxC7xrxZWOb7SXC8Hepax45cvyJ4FBQ9I
   Kh63kN+LGCJ+NHn+JxcfD2bCMNPawo51xSro7wK/adQyZhQnhnPIGsxCZ
   E6WVnUslk8AxkXX3QjDBvDqDKtbWtrgMurAIGS+OarirDrN/xnSjcwJgS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="366447080"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="366447080"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:40:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="1070754508"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="1070754508"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 01 Sep 2023 06:40:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 340AD78D; Fri,  1 Sep 2023 16:40:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 05/10] gpio: pca953x: Simplify code with cleanup helpers
Date:   Fri,  1 Sep 2023 16:40:36 +0300
Message-Id: <20230901134041.1165562-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
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

Use macros defined in linux/cleanup.h to automate resource lifetime
control in gpio-pca953x.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pca953x.c | 77 ++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 48 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 71d87d570a2b..99379ee98749 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -10,6 +10,7 @@
 
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
+#include <linux/cleanup.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/i2c.h>
@@ -519,12 +520,10 @@ static int pca953x_gpio_direction_input(struct gpio_chip *gc, unsigned off)
 	struct pca953x_chip *chip = gpiochip_get_data(gc);
 	u8 dirreg = chip->recalc_addr(chip, chip->regs->direction, off);
 	u8 bit = BIT(off % BANK_SZ);
-	int ret;
 
-	mutex_lock(&chip->i2c_lock);
-	ret = regmap_write_bits(chip->regmap, dirreg, bit, bit);
-	mutex_unlock(&chip->i2c_lock);
-	return ret;
+	guard(mutex)(&chip->i2c_lock);
+
+	return regmap_write_bits(chip->regmap, dirreg, bit, bit);
 }
 
 static int pca953x_gpio_direction_output(struct gpio_chip *gc,
@@ -536,17 +535,15 @@ static int pca953x_gpio_direction_output(struct gpio_chip *gc,
 	u8 bit = BIT(off % BANK_SZ);
 	int ret;
 
-	mutex_lock(&chip->i2c_lock);
+	guard(mutex)(&chip->i2c_lock);
+
 	/* set output level */
 	ret = regmap_write_bits(chip->regmap, outreg, bit, val ? bit : 0);
 	if (ret)
-		goto exit;
+		return ret;
 
 	/* then direction */
-	ret = regmap_write_bits(chip->regmap, dirreg, bit, 0);
-exit:
-	mutex_unlock(&chip->i2c_lock);
-	return ret;
+	return regmap_write_bits(chip->regmap, dirreg, bit, 0);
 }
 
 static int pca953x_gpio_get_value(struct gpio_chip *gc, unsigned off)
@@ -557,9 +554,8 @@ static int pca953x_gpio_get_value(struct gpio_chip *gc, unsigned off)
 	u32 reg_val;
 	int ret;
 
-	mutex_lock(&chip->i2c_lock);
-	ret = regmap_read(chip->regmap, inreg, &reg_val);
-	mutex_unlock(&chip->i2c_lock);
+	scoped_guard(mutex, &chip->i2c_lock)
+		ret = regmap_read(chip->regmap, inreg, &reg_val);
 	if (ret < 0)
 		return ret;
 
@@ -572,9 +568,9 @@ static void pca953x_gpio_set_value(struct gpio_chip *gc, unsigned off, int val)
 	u8 outreg = chip->recalc_addr(chip, chip->regs->output, off);
 	u8 bit = BIT(off % BANK_SZ);
 
-	mutex_lock(&chip->i2c_lock);
+	guard(mutex)(&chip->i2c_lock);
+
 	regmap_write_bits(chip->regmap, outreg, bit, val ? bit : 0);
-	mutex_unlock(&chip->i2c_lock);
 }
 
 static int pca953x_gpio_get_direction(struct gpio_chip *gc, unsigned off)
@@ -585,9 +581,8 @@ static int pca953x_gpio_get_direction(struct gpio_chip *gc, unsigned off)
 	u32 reg_val;
 	int ret;
 
-	mutex_lock(&chip->i2c_lock);
-	ret = regmap_read(chip->regmap, dirreg, &reg_val);
-	mutex_unlock(&chip->i2c_lock);
+	scoped_guard(mutex, &chip->i2c_lock)
+		ret = regmap_read(chip->regmap, dirreg, &reg_val);
 	if (ret < 0)
 		return ret;
 
@@ -604,9 +599,8 @@ static int pca953x_gpio_get_multiple(struct gpio_chip *gc,
 	DECLARE_BITMAP(reg_val, MAX_LINE);
 	int ret;
 
-	mutex_lock(&chip->i2c_lock);
-	ret = pca953x_read_regs(chip, chip->regs->input, reg_val);
-	mutex_unlock(&chip->i2c_lock);
+	scoped_guard(mutex, &chip->i2c_lock)
+		ret = pca953x_read_regs(chip, chip->regs->input, reg_val);
 	if (ret)
 		return ret;
 
@@ -621,16 +615,15 @@ static void pca953x_gpio_set_multiple(struct gpio_chip *gc,
 	DECLARE_BITMAP(reg_val, MAX_LINE);
 	int ret;
 
-	mutex_lock(&chip->i2c_lock);
+	guard(mutex)(&chip->i2c_lock);
+
 	ret = pca953x_read_regs(chip, chip->regs->output, reg_val);
 	if (ret)
-		goto exit;
+		return;
 
 	bitmap_replace(reg_val, reg_val, bits, mask, gc->ngpio);
 
 	pca953x_write_regs(chip, chip->regs->output, reg_val);
-exit:
-	mutex_unlock(&chip->i2c_lock);
 }
 
 static int pca953x_gpio_set_pull_up_down(struct pca953x_chip *chip,
@@ -638,7 +631,6 @@ static int pca953x_gpio_set_pull_up_down(struct pca953x_chip *chip,
 					 unsigned long config)
 {
 	enum pin_config_param param = pinconf_to_config_param(config);
-
 	u8 pull_en_reg = chip->recalc_addr(chip, PCAL953X_PULL_EN, offset);
 	u8 pull_sel_reg = chip->recalc_addr(chip, PCAL953X_PULL_SEL, offset);
 	u8 bit = BIT(offset % BANK_SZ);
@@ -651,7 +643,7 @@ static int pca953x_gpio_set_pull_up_down(struct pca953x_chip *chip,
 	if (!(chip->driver_data & PCA_PCAL))
 		return -ENOTSUPP;
 
-	mutex_lock(&chip->i2c_lock);
+	guard(mutex)(&chip->i2c_lock);
 
 	/* Configure pull-up/pull-down */
 	if (param == PIN_CONFIG_BIAS_PULL_UP)
@@ -661,17 +653,13 @@ static int pca953x_gpio_set_pull_up_down(struct pca953x_chip *chip,
 	else
 		ret = 0;
 	if (ret)
-		goto exit;
+		return ret;
 
 	/* Disable/Enable pull-up/pull-down */
 	if (param == PIN_CONFIG_BIAS_DISABLE)
-		ret = regmap_write_bits(chip->regmap, pull_en_reg, bit, 0);
+		return regmap_write_bits(chip->regmap, pull_en_reg, bit, 0);
 	else
-		ret = regmap_write_bits(chip->regmap, pull_en_reg, bit, bit);
-
-exit:
-	mutex_unlock(&chip->i2c_lock);
-	return ret;
+		return regmap_write_bits(chip->regmap, pull_en_reg, bit, bit);
 }
 
 static int pca953x_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
@@ -900,10 +888,8 @@ static irqreturn_t pca953x_irq_handler(int irq, void *devid)
 
 	bitmap_zero(pending, MAX_LINE);
 
-	mutex_lock(&chip->i2c_lock);
-	ret = pca953x_irq_pending(chip, pending);
-	mutex_unlock(&chip->i2c_lock);
-
+	scoped_guard(mutex, &chip->i2c_lock)
+		ret = pca953x_irq_pending(chip, pending);
 	if (ret) {
 		ret = 0;
 
@@ -1235,26 +1221,21 @@ static int pca953x_restore_context(struct pca953x_chip *chip)
 {
 	int ret;
 
-	mutex_lock(&chip->i2c_lock);
+	guard(mutex)(&chip->i2c_lock);
 
 	regcache_cache_only(chip->regmap, false);
 	regcache_mark_dirty(chip->regmap);
 	ret = pca953x_regcache_sync(chip);
-	if (ret) {
-		mutex_unlock(&chip->i2c_lock);
+	if (ret)
 		return ret;
-	}
 
-	ret = regcache_sync(chip->regmap);
-	mutex_unlock(&chip->i2c_lock);
-	return ret;
+	return regcache_sync(chip->regmap);
 }
 
 static void pca953x_save_context(struct pca953x_chip *chip)
 {
-	mutex_lock(&chip->i2c_lock);
+	guard(mutex)(&chip->i2c_lock);
 	regcache_cache_only(chip->regmap, true);
-	mutex_unlock(&chip->i2c_lock);
 }
 
 static int pca953x_suspend(struct device *dev)
-- 
2.40.0.1.gaa8946217a0b

