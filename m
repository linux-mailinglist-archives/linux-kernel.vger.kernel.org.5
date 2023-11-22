Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6ADE7F4ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjKVRy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKVRy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:54:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93426101;
        Wed, 22 Nov 2023 09:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700675692; x=1732211692;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YCdU8G3RGqUX0Po0bGsZzggEg0XQbmO7+fvYqgSfd2c=;
  b=Mo/Uu3QW/OfmhTZ5S4wcDckSKBsxUjSdxRaOXVZd/3ozOoP2K4FC4Q+6
   5BfdevoRQ6OSa0NQ+RgMyTrOW3IMDwPG/v2x9BMLawZB/DJvNp6TY+wUz
   i75NFq7oBif6FnzRCQr4gYJ2u3oxNc5URsZIuFm8OQnQ99HMak2RMHJ9d
   uCCAPlM1DBxLJqN8kPg32A3epkB/dU/b1SApo6TB2ncHbiRB8fTjyAJ91
   /03QJTwXQhsmQl0U0vh9NGbcNE5QWyy1GTACUgb/OomuPQf4gkxt48SQg
   C5R/YtBVNxRei983kx0d9xANsBm2LHq33zTQgKdwC4p9/adS+BmbJW4/m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="389268414"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="389268414"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 09:54:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="837516073"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="837516073"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 22 Nov 2023 09:54:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A79B42A2; Wed, 22 Nov 2023 19:54:46 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: lynxpoint: Simplify code with cleanup helpers
Date:   Wed, 22 Nov 2023 19:54:44 +0200
Message-ID: <20231122175444.2316719-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use macros defined in linux/cleanup.h to automate resource lifetime
control in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-lynxpoint.c | 72 +++++++----------------
 1 file changed, 21 insertions(+), 51 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
index e6878e4cf20c..1fb0bba8b386 100644
--- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
+++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/array_size.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -291,10 +292,9 @@ static int lp_pinmux_set_mux(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *lg = pinctrl_dev_get_drvdata(pctldev);
 	const struct intel_pingroup *grp = &lg->soc->groups[group];
-	unsigned long flags;
 	int i;
 
-	raw_spin_lock_irqsave(&lg->lock, flags);
+	guard(raw_spinlock_irqsave)(&lg->lock);
 
 	/* Now enable the mux setting for each pin in the group */
 	for (i = 0; i < grp->grp.npins; i++) {
@@ -312,8 +312,6 @@ static int lp_pinmux_set_mux(struct pinctrl_dev *pctldev,
 		iowrite32(value, reg);
 	}
 
-	raw_spin_unlock_irqrestore(&lg->lock, flags);
-
 	return 0;
 }
 
@@ -334,10 +332,9 @@ static int lp_gpio_request_enable(struct pinctrl_dev *pctldev,
 	struct intel_pinctrl *lg = pinctrl_dev_get_drvdata(pctldev);
 	void __iomem *reg = lp_gpio_reg(&lg->chip, pin, LP_CONFIG1);
 	void __iomem *conf2 = lp_gpio_reg(&lg->chip, pin, LP_CONFIG2);
-	unsigned long flags;
 	u32 value;
 
-	raw_spin_lock_irqsave(&lg->lock, flags);
+	guard(raw_spinlock_irqsave)(&lg->lock);
 
 	/*
 	 * Reconfigure pin to GPIO mode if needed and issue a warning,
@@ -352,8 +349,6 @@ static int lp_gpio_request_enable(struct pinctrl_dev *pctldev,
 	/* Enable input sensing */
 	lp_gpio_enable_input(conf2);
 
-	raw_spin_unlock_irqrestore(&lg->lock, flags);
-
 	return 0;
 }
 
@@ -363,14 +358,11 @@ static void lp_gpio_disable_free(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *lg = pinctrl_dev_get_drvdata(pctldev);
 	void __iomem *conf2 = lp_gpio_reg(&lg->chip, pin, LP_CONFIG2);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&lg->lock, flags);
+	guard(raw_spinlock_irqsave)(&lg->lock);
 
 	/* Disable input sensing */
 	lp_gpio_disable_input(conf2);
-
-	raw_spin_unlock_irqrestore(&lg->lock, flags);
 }
 
 static int lp_gpio_set_direction(struct pinctrl_dev *pctldev,
@@ -379,10 +371,9 @@ static int lp_gpio_set_direction(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *lg = pinctrl_dev_get_drvdata(pctldev);
 	void __iomem *reg = lp_gpio_reg(&lg->chip, pin, LP_CONFIG1);
-	unsigned long flags;
 	u32 value;
 
-	raw_spin_lock_irqsave(&lg->lock, flags);
+	guard(raw_spinlock_irqsave)(&lg->lock);
 
 	value = ioread32(reg);
 	value &= ~DIR_BIT;
@@ -400,8 +391,6 @@ static int lp_gpio_set_direction(struct pinctrl_dev *pctldev,
 	}
 	iowrite32(value, reg);
 
-	raw_spin_unlock_irqrestore(&lg->lock, flags);
-
 	return 0;
 }
 
@@ -421,13 +410,11 @@ static int lp_pin_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
 	struct intel_pinctrl *lg = pinctrl_dev_get_drvdata(pctldev);
 	void __iomem *conf2 = lp_gpio_reg(&lg->chip, pin, LP_CONFIG2);
 	enum pin_config_param param = pinconf_to_config_param(*config);
-	unsigned long flags;
 	u32 value, pull;
 	u16 arg;
 
-	raw_spin_lock_irqsave(&lg->lock, flags);
-	value = ioread32(conf2);
-	raw_spin_unlock_irqrestore(&lg->lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &lg->lock)
+		value = ioread32(conf2);
 
 	pull = value & GPIWP_MASK;
 
@@ -464,11 +451,10 @@ static int lp_pin_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 	struct intel_pinctrl *lg = pinctrl_dev_get_drvdata(pctldev);
 	void __iomem *conf2 = lp_gpio_reg(&lg->chip, pin, LP_CONFIG2);
 	enum pin_config_param param;
-	unsigned long flags;
-	int i, ret = 0;
+	unsigned int i;
 	u32 value;
 
-	raw_spin_lock_irqsave(&lg->lock, flags);
+	guard(raw_spinlock_irqsave)(&lg->lock);
 
 	value = ioread32(conf2);
 
@@ -489,19 +475,13 @@ static int lp_pin_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			value |= GPIWP_UP;
 			break;
 		default:
-			ret = -ENOTSUPP;
+			return -ENOTSUPP;
 		}
-
-		if (ret)
-			break;
 	}
 
-	if (!ret)
-		iowrite32(value, conf2);
+	iowrite32(value, conf2);
 
-	raw_spin_unlock_irqrestore(&lg->lock, flags);
-
-	return ret;
+	return 0;
 }
 
 static const struct pinconf_ops lptlp_pinconf_ops = {
@@ -527,16 +507,13 @@ static void lp_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct intel_pinctrl *lg = gpiochip_get_data(chip);
 	void __iomem *reg = lp_gpio_reg(chip, offset, LP_CONFIG1);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&lg->lock, flags);
+	guard(raw_spinlock_irqsave)(&lg->lock);
 
 	if (value)
 		iowrite32(ioread32(reg) | OUT_LVL_BIT, reg);
 	else
 		iowrite32(ioread32(reg) & ~OUT_LVL_BIT, reg);
-
-	raw_spin_unlock_irqrestore(&lg->lock, flags);
 }
 
 static int lp_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
@@ -592,11 +569,10 @@ static void lp_irq_ack(struct irq_data *d)
 	struct intel_pinctrl *lg = gpiochip_get_data(gc);
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	void __iomem *reg = lp_gpio_reg(&lg->chip, hwirq, LP_INT_STAT);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&lg->lock, flags);
+	guard(raw_spinlock_irqsave)(&lg->lock);
+
 	iowrite32(BIT(hwirq % 32), reg);
-	raw_spin_unlock_irqrestore(&lg->lock, flags);
 }
 
 static void lp_irq_unmask(struct irq_data *d)
@@ -613,13 +589,11 @@ static void lp_irq_enable(struct irq_data *d)
 	struct intel_pinctrl *lg = gpiochip_get_data(gc);
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	void __iomem *reg = lp_gpio_reg(&lg->chip, hwirq, LP_INT_ENABLE);
-	unsigned long flags;
 
 	gpiochip_enable_irq(gc, hwirq);
 
-	raw_spin_lock_irqsave(&lg->lock, flags);
-	iowrite32(ioread32(reg) | BIT(hwirq % 32), reg);
-	raw_spin_unlock_irqrestore(&lg->lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &lg->lock)
+		iowrite32(ioread32(reg) | BIT(hwirq % 32), reg);
 }
 
 static void lp_irq_disable(struct irq_data *d)
@@ -628,11 +602,9 @@ static void lp_irq_disable(struct irq_data *d)
 	struct intel_pinctrl *lg = gpiochip_get_data(gc);
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	void __iomem *reg = lp_gpio_reg(&lg->chip, hwirq, LP_INT_ENABLE);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&lg->lock, flags);
-	iowrite32(ioread32(reg) & ~BIT(hwirq % 32), reg);
-	raw_spin_unlock_irqrestore(&lg->lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &lg->lock)
+		iowrite32(ioread32(reg) & ~BIT(hwirq % 32), reg);
 
 	gpiochip_disable_irq(gc, hwirq);
 }
@@ -642,7 +614,6 @@ static int lp_irq_set_type(struct irq_data *d, unsigned int type)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *lg = gpiochip_get_data(gc);
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-	unsigned long flags;
 	void __iomem *reg;
 	u32 value;
 
@@ -656,7 +627,8 @@ static int lp_irq_set_type(struct irq_data *d, unsigned int type)
 		return -EBUSY;
 	}
 
-	raw_spin_lock_irqsave(&lg->lock, flags);
+	guard(raw_spinlock_irqsave)(&lg->lock);
+
 	value = ioread32(reg);
 
 	/* set both TRIG_SEL and INV bits to 0 for rising edge */
@@ -682,8 +654,6 @@ static int lp_irq_set_type(struct irq_data *d, unsigned int type)
 	else if (type & IRQ_TYPE_LEVEL_MASK)
 		irq_set_handler_locked(d, handle_level_irq);
 
-	raw_spin_unlock_irqrestore(&lg->lock, flags);
-
 	return 0;
 }
 
-- 
2.43.0.rc1.1.gbec44491f096

