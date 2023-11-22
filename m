Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB37E7F4EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjKVRvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjKVRvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:51:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8951B1;
        Wed, 22 Nov 2023 09:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700675459; x=1732211459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aoHilwn0T4G61TZUWc36CDpobtMElqLk1ayCctLDick=;
  b=Rvvxl4UOuTOogUX61ctaCyB1FDor4JOihm/1fBIeCmIhhdRnrgAq9Vhw
   /ju61FmRa5FeUx0PFQ0matyIlZ5tU4ugix2focJEIglPQ2XUYoX5GES++
   GTNikH/udgpChvANoEWV8uuvjtUOrgFeVuubOJXgUQJYzGvS0j+epcPb3
   GtNVnkT1Kmjicl0gJ7p4VSikH96mzWEpXtA2sKqF+rLxLqkUDjs+/fL9y
   iq2vFt07BYB88lEpgsoQDIly24qU6hvAvwkW0DFk/RXHU/MuUCcWyerud
   lJGhsJsjzPNIOnkd9SGfQf3CsKX8rzDgkXS3b7HPBxpw3eClOKq+cdx35
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456431559"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="456431559"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 09:50:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="770707125"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="770707125"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 22 Nov 2023 09:50:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1854538C; Wed, 22 Nov 2023 19:50:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 4/4] pinctrl: baytrail: Simplify code with cleanup helpers
Date:   Wed, 22 Nov 2023 19:50:39 +0200
Message-ID: <20231122175039.2289945-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231122175039.2289945-1-andriy.shevchenko@linux.intel.com>
References: <20231122175039.2289945-1-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/intel/pinctrl-baytrail.c | 176 +++++++++--------------
 1 file changed, 68 insertions(+), 108 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 84f21a28fe7e..9b76819e606a 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 #include <linux/array_size.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/gpio/driver.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -587,10 +588,9 @@ static void byt_set_group_simple_mux(struct intel_pinctrl *vg,
 				     const struct intel_pingroup group,
 				     unsigned int func)
 {
-	unsigned long flags;
 	int i;
 
-	raw_spin_lock_irqsave(&byt_lock, flags);
+	guard(raw_spinlock_irqsave)(&byt_lock);
 
 	for (i = 0; i < group.grp.npins; i++) {
 		void __iomem *padcfg0;
@@ -608,18 +608,15 @@ static void byt_set_group_simple_mux(struct intel_pinctrl *vg,
 		value |= func;
 		writel(value, padcfg0);
 	}
-
-	raw_spin_unlock_irqrestore(&byt_lock, flags);
 }
 
 static void byt_set_group_mixed_mux(struct intel_pinctrl *vg,
 				    const struct intel_pingroup group,
 				    const unsigned int *func)
 {
-	unsigned long flags;
 	int i;
 
-	raw_spin_lock_irqsave(&byt_lock, flags);
+	guard(raw_spinlock_irqsave)(&byt_lock);
 
 	for (i = 0; i < group.grp.npins; i++) {
 		void __iomem *padcfg0;
@@ -637,8 +634,6 @@ static void byt_set_group_mixed_mux(struct intel_pinctrl *vg,
 		value |= func[i];
 		writel(value, padcfg0);
 	}
-
-	raw_spin_unlock_irqrestore(&byt_lock, flags);
 }
 
 static int byt_set_mux(struct pinctrl_dev *pctldev, unsigned int func_selector,
@@ -676,10 +671,10 @@ static u32 byt_get_gpio_mux(struct intel_pinctrl *vg, unsigned int offset)
 static void byt_gpio_clear_triggering(struct intel_pinctrl *vg, unsigned int offset)
 {
 	void __iomem *reg = byt_gpio_reg(vg, offset, BYT_CONF0_REG);
-	unsigned long flags;
 	u32 value;
 
-	raw_spin_lock_irqsave(&byt_lock, flags);
+	guard(raw_spinlock_irqsave)(&byt_lock);
+
 	value = readl(reg);
 
 	/* Do not clear direct-irq enabled IRQs (from gpio_disable_free) */
@@ -687,7 +682,6 @@ static void byt_gpio_clear_triggering(struct intel_pinctrl *vg, unsigned int off
 		value &= ~(BYT_TRIG_POS | BYT_TRIG_NEG | BYT_TRIG_LVL);
 
 	writel(value, reg);
-	raw_spin_unlock_irqrestore(&byt_lock, flags);
 }
 
 static int byt_gpio_request_enable(struct pinctrl_dev *pctl_dev,
@@ -697,9 +691,8 @@ static int byt_gpio_request_enable(struct pinctrl_dev *pctl_dev,
 	struct intel_pinctrl *vg = pinctrl_dev_get_drvdata(pctl_dev);
 	void __iomem *reg = byt_gpio_reg(vg, offset, BYT_CONF0_REG);
 	u32 value, gpio_mux;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&byt_lock, flags);
+	guard(raw_spinlock_irqsave)(&byt_lock);
 
 	/*
 	 * In most cases, func pin mux 000 means GPIO function.
@@ -712,15 +705,14 @@ static int byt_gpio_request_enable(struct pinctrl_dev *pctl_dev,
 	 */
 	value = readl(reg) & BYT_PIN_MUX;
 	gpio_mux = byt_get_gpio_mux(vg, offset);
-	if (gpio_mux != value) {
-		value = readl(reg) & ~BYT_PIN_MUX;
-		value |= gpio_mux;
-		writel(value, reg);
+	if (gpio_mux == value)
+		return 0;
 
-		dev_warn(vg->dev, FW_BUG "Pin %i: forcibly re-configured as GPIO\n", offset);
-	}
+	value = readl(reg) & ~BYT_PIN_MUX;
+	value |= gpio_mux;
+	writel(value, reg);
 
-	raw_spin_unlock_irqrestore(&byt_lock, flags);
+	dev_warn(vg->dev, FW_BUG "Pin %i: forcibly re-configured as GPIO\n", offset);
 
 	return 0;
 }
@@ -758,10 +750,9 @@ static int byt_gpio_set_direction(struct pinctrl_dev *pctl_dev,
 {
 	struct intel_pinctrl *vg = pinctrl_dev_get_drvdata(pctl_dev);
 	void __iomem *val_reg = byt_gpio_reg(vg, offset, BYT_VAL_REG);
-	unsigned long flags;
 	u32 value;
 
-	raw_spin_lock_irqsave(&byt_lock, flags);
+	guard(raw_spinlock_irqsave)(&byt_lock);
 
 	value = readl(val_reg);
 	value &= ~BYT_DIR_MASK;
@@ -772,8 +763,6 @@ static int byt_gpio_set_direction(struct pinctrl_dev *pctl_dev,
 
 	writel(value, val_reg);
 
-	raw_spin_unlock_irqrestore(&byt_lock, flags);
-
 	return 0;
 }
 
@@ -856,15 +845,15 @@ static int byt_pin_config_get(struct pinctrl_dev *pctl_dev, unsigned int offset,
 	void __iomem *conf_reg = byt_gpio_reg(vg, offset, BYT_CONF0_REG);
 	void __iomem *val_reg = byt_gpio_reg(vg, offset, BYT_VAL_REG);
 	void __iomem *db_reg = byt_gpio_reg(vg, offset, BYT_DEBOUNCE_REG);
-	unsigned long flags;
 	u32 conf, pull, val, debounce;
 	u16 arg = 0;
 
-	raw_spin_lock_irqsave(&byt_lock, flags);
-	conf = readl(conf_reg);
+	scoped_guard(raw_spinlock_irqsave, &byt_lock) {
+		conf = readl(conf_reg);
+		val = readl(val_reg);
+	}
+
 	pull = conf & BYT_PULL_ASSIGN_MASK;
-	val = readl(val_reg);
-	raw_spin_unlock_irqrestore(&byt_lock, flags);
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
@@ -891,9 +880,8 @@ static int byt_pin_config_get(struct pinctrl_dev *pctl_dev, unsigned int offset,
 		if (!(conf & BYT_DEBOUNCE_EN))
 			return -EINVAL;
 
-		raw_spin_lock_irqsave(&byt_lock, flags);
-		debounce = readl(db_reg);
-		raw_spin_unlock_irqrestore(&byt_lock, flags);
+		scoped_guard(raw_spinlock_irqsave, &byt_lock)
+			debounce = readl(db_reg);
 
 		switch (debounce & BYT_DEBOUNCE_PULSE_MASK) {
 		case BYT_DEBOUNCE_PULSE_375US:
@@ -941,11 +929,10 @@ static int byt_pin_config_set(struct pinctrl_dev *pctl_dev,
 	void __iomem *db_reg = byt_gpio_reg(vg, offset, BYT_DEBOUNCE_REG);
 	u32 conf, db_pulse, debounce;
 	enum pin_config_param param;
-	unsigned long flags;
-	int i, ret = 0;
+	int i, ret;
 	u32 arg;
 
-	raw_spin_lock_irqsave(&byt_lock, flags);
+	guard(raw_spinlock_irqsave)(&byt_lock);
 
 	conf = readl(conf_reg);
 
@@ -963,6 +950,8 @@ static int byt_pin_config_set(struct pinctrl_dev *pctl_dev,
 			conf &= ~BYT_PULL_ASSIGN_MASK;
 			conf |= BYT_PULL_ASSIGN_DOWN;
 			ret = byt_set_pull_strength(&conf, arg);
+			if (ret)
+				return ret;
 
 			break;
 		case PIN_CONFIG_BIAS_PULL_UP:
@@ -971,22 +960,15 @@ static int byt_pin_config_set(struct pinctrl_dev *pctl_dev,
 			conf &= ~BYT_PULL_ASSIGN_MASK;
 			conf |= BYT_PULL_ASSIGN_UP;
 			ret = byt_set_pull_strength(&conf, arg);
+			if (ret)
+				return ret;
 
 			break;
 		case PIN_CONFIG_INPUT_DEBOUNCE:
-			if (arg) {
-				conf |= BYT_DEBOUNCE_EN;
-			} else {
-				conf &= ~BYT_DEBOUNCE_EN;
-
-				/*
-				 * No need to update the pulse value.
-				 * Debounce is going to be disabled.
-				 */
-				break;
-			}
-
 			switch (arg) {
+			case 0:
+				db_pulse = 0;
+				break;
 			case 375:
 				db_pulse = BYT_DEBOUNCE_PULSE_375US;
 				break;
@@ -1009,33 +991,28 @@ static int byt_pin_config_set(struct pinctrl_dev *pctl_dev,
 				db_pulse = BYT_DEBOUNCE_PULSE_24MS;
 				break;
 			default:
-				if (arg)
-					ret = -EINVAL;
-				break;
+				return -EINVAL;
 			}
 
-			if (ret)
-				break;
+			if (db_pulse) {
+				debounce = readl(db_reg);
+				debounce = (debounce & ~BYT_DEBOUNCE_PULSE_MASK) | db_pulse;
+				writel(debounce, db_reg);
 
-			debounce = readl(db_reg);
-			debounce = (debounce & ~BYT_DEBOUNCE_PULSE_MASK) | db_pulse;
-			writel(debounce, db_reg);
+				conf |= BYT_DEBOUNCE_EN;
+			} else {
+				conf &= ~BYT_DEBOUNCE_EN;
+			}
 
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
-		writel(conf, conf_reg);
+	writel(conf, conf_reg);
 
-	raw_spin_unlock_irqrestore(&byt_lock, flags);
-
-	return ret;
+	return 0;
 }
 
 static const struct pinconf_ops byt_pinconf_ops = {
@@ -1055,12 +1032,10 @@ static int byt_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct intel_pinctrl *vg = gpiochip_get_data(chip);
 	void __iomem *reg = byt_gpio_reg(vg, offset, BYT_VAL_REG);
-	unsigned long flags;
 	u32 val;
 
-	raw_spin_lock_irqsave(&byt_lock, flags);
-	val = readl(reg);
-	raw_spin_unlock_irqrestore(&byt_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &byt_lock)
+		val = readl(reg);
 
 	return !!(val & BYT_LEVEL);
 }
@@ -1068,35 +1043,34 @@ static int byt_gpio_get(struct gpio_chip *chip, unsigned int offset)
 static void byt_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct intel_pinctrl *vg = gpiochip_get_data(chip);
-	void __iomem *reg = byt_gpio_reg(vg, offset, BYT_VAL_REG);
-	unsigned long flags;
+	void __iomem *reg;
 	u32 old_val;
 
+	reg = byt_gpio_reg(vg, offset, BYT_VAL_REG);
 	if (!reg)
 		return;
 
-	raw_spin_lock_irqsave(&byt_lock, flags);
+	guard(raw_spinlock_irqsave)(&byt_lock);
+
 	old_val = readl(reg);
 	if (value)
 		writel(old_val | BYT_LEVEL, reg);
 	else
 		writel(old_val & ~BYT_LEVEL, reg);
-	raw_spin_unlock_irqrestore(&byt_lock, flags);
 }
 
 static int byt_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 {
 	struct intel_pinctrl *vg = gpiochip_get_data(chip);
-	void __iomem *reg = byt_gpio_reg(vg, offset, BYT_VAL_REG);
-	unsigned long flags;
+	void __iomem *reg;
 	u32 value;
 
+	reg = byt_gpio_reg(vg, offset, BYT_VAL_REG);
 	if (!reg)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&byt_lock, flags);
-	value = readl(reg);
-	raw_spin_unlock_irqrestore(&byt_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &byt_lock)
+		value = readl(reg);
 
 	if (!(value & BYT_OUTPUT_EN))
 		return GPIO_LINE_DIRECTION_OUT;
@@ -1110,17 +1084,15 @@ static int byt_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
 	struct intel_pinctrl *vg = gpiochip_get_data(chip);
 	void __iomem *val_reg = byt_gpio_reg(vg, offset, BYT_VAL_REG);
-	unsigned long flags;
 	u32 reg;
 
-	raw_spin_lock_irqsave(&byt_lock, flags);
+	guard(raw_spinlock_irqsave)(&byt_lock);
 
 	reg = readl(val_reg);
 	reg &= ~BYT_DIR_MASK;
 	reg |= BYT_OUTPUT_EN;
 	writel(reg, val_reg);
 
-	raw_spin_unlock_irqrestore(&byt_lock, flags);
 	return 0;
 }
 
@@ -1135,10 +1107,9 @@ static int byt_gpio_direction_output(struct gpio_chip *chip,
 {
 	struct intel_pinctrl *vg = gpiochip_get_data(chip);
 	void __iomem *val_reg = byt_gpio_reg(vg, offset, BYT_VAL_REG);
-	unsigned long flags;
 	u32 reg;
 
-	raw_spin_lock_irqsave(&byt_lock, flags);
+	guard(raw_spinlock_irqsave)(&byt_lock);
 
 	byt_gpio_direct_irq_check(vg, offset);
 
@@ -1151,7 +1122,6 @@ static int byt_gpio_direction_output(struct gpio_chip *chip,
 
 	writel(reg, val_reg);
 
-	raw_spin_unlock_irqrestore(&byt_lock, flags);
 	return 0;
 }
 
@@ -1166,7 +1136,6 @@ static void byt_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 		void __iomem *conf_reg, *val_reg;
 		const char *pull_str = NULL;
 		const char *pull = NULL;
-		unsigned long flags;
 		const char *label;
 		unsigned int pin;
 
@@ -1184,10 +1153,10 @@ static void byt_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 			continue;
 		}
 
-		raw_spin_lock_irqsave(&byt_lock, flags);
-		conf0 = readl(conf_reg);
-		val = readl(val_reg);
-		raw_spin_unlock_irqrestore(&byt_lock, flags);
+		scoped_guard(raw_spinlock_irqsave, &byt_lock) {
+			conf0 = readl(conf_reg);
+			val = readl(val_reg);
+		}
 
 		comm = intel_get_community(vg, pin);
 		if (!comm) {
@@ -1271,9 +1240,9 @@ static void byt_irq_ack(struct irq_data *d)
 	if (!reg)
 		return;
 
-	raw_spin_lock(&byt_lock);
+	guard(raw_spinlock)(&byt_lock);
+
 	writel(BIT(hwirq % 32), reg);
-	raw_spin_unlock(&byt_lock);
 }
 
 static void byt_irq_mask(struct irq_data *d)
@@ -1291,7 +1260,6 @@ static void byt_irq_unmask(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *vg = gpiochip_get_data(gc);
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-	unsigned long flags;
 	void __iomem *reg;
 	u32 value;
 
@@ -1301,7 +1269,8 @@ static void byt_irq_unmask(struct irq_data *d)
 	if (!reg)
 		return;
 
-	raw_spin_lock_irqsave(&byt_lock, flags);
+	guard(raw_spinlock_irqsave)(&byt_lock);
+
 	value = readl(reg);
 
 	switch (irqd_get_trigger_type(d)) {
@@ -1323,23 +1292,21 @@ static void byt_irq_unmask(struct irq_data *d)
 	}
 
 	writel(value, reg);
-
-	raw_spin_unlock_irqrestore(&byt_lock, flags);
 }
 
 static int byt_irq_type(struct irq_data *d, unsigned int type)
 {
 	struct intel_pinctrl *vg = gpiochip_get_data(irq_data_get_irq_chip_data(d));
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-	u32 value;
-	unsigned long flags;
 	void __iomem *reg;
+	u32 value;
 
 	reg = byt_gpio_reg(vg, hwirq, BYT_CONF0_REG);
 	if (!reg)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&byt_lock, flags);
+	guard(raw_spinlock_irqsave)(&byt_lock);
+
 	value = readl(reg);
 
 	WARN(value & BYT_DIRECT_IRQ_EN,
@@ -1361,8 +1328,6 @@ static int byt_irq_type(struct irq_data *d, unsigned int type)
 	else if (type & IRQ_TYPE_LEVEL_MASK)
 		irq_set_handler_locked(d, handle_level_irq);
 
-	raw_spin_unlock_irqrestore(&byt_lock, flags);
-
 	return 0;
 }
 
@@ -1394,9 +1359,8 @@ static void byt_gpio_irq_handler(struct irq_desc *desc)
 			continue;
 		}
 
-		raw_spin_lock(&byt_lock);
-		pending = readl(reg);
-		raw_spin_unlock(&byt_lock);
+		scoped_guard(raw_spinlock, &byt_lock)
+			pending = readl(reg);
 		for_each_set_bit(pin, &pending, 32)
 			generic_handle_domain_irq(vg->chip.irq.domain, base + pin);
 	}
@@ -1659,10 +1623,9 @@ static int byt_pinctrl_probe(struct platform_device *pdev)
 static int byt_gpio_suspend(struct device *dev)
 {
 	struct intel_pinctrl *vg = dev_get_drvdata(dev);
-	unsigned long flags;
 	int i;
 
-	raw_spin_lock_irqsave(&byt_lock, flags);
+	guard(raw_spinlock_irqsave)(&byt_lock);
 
 	for (i = 0; i < vg->soc->npins; i++) {
 		void __iomem *reg;
@@ -1686,17 +1649,15 @@ static int byt_gpio_suspend(struct device *dev)
 		vg->context.pads[i].val = value;
 	}
 
-	raw_spin_unlock_irqrestore(&byt_lock, flags);
 	return 0;
 }
 
 static int byt_gpio_resume(struct device *dev)
 {
 	struct intel_pinctrl *vg = dev_get_drvdata(dev);
-	unsigned long flags;
 	int i;
 
-	raw_spin_lock_irqsave(&byt_lock, flags);
+	guard(raw_spinlock_irqsave)(&byt_lock);
 
 	for (i = 0; i < vg->soc->npins; i++) {
 		void __iomem *reg;
@@ -1736,7 +1697,6 @@ static int byt_gpio_resume(struct device *dev)
 		}
 	}
 
-	raw_spin_unlock_irqrestore(&byt_lock, flags);
 	return 0;
 }
 
-- 
2.43.0.rc1.1.gbec44491f096

