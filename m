Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E11F7AEDE7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjIZNX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjIZNXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:23:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27030B4;
        Tue, 26 Sep 2023 06:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695734627; x=1727270627;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=py6wFHJhUEfEmCsI5ZP7hiJ5ZLVHKJsSW1Lc0LOth4Q=;
  b=fUWFlhnIfxAsjbZ11+Bo+7RBUo3w4RdF9HXT7yB7PLXokp+VstmZHknw
   1sEGbskUp5Cq5A9xfeNpKGWdKjZtvDsBNpM+qCLtEwTBxB6R5Rt5tF0Tw
   GQ0KSRibfzEiDIRf7HRfMxigAs+RBGu47idqYs3SdqSH/LorLQlq2gkUE
   nLdiAT1r3mbhdszfX6ZALwbg1WjqDhMTQqPM7IJfRmtaJOzvQCPHWj8JI
   PscCBzi4GVCCwjQyZCXImrlZSPcTe5n62yHKewD+eEXkIQIuYD/mTrh8y
   VqAQg32TG6wx+AngsImrRoN1wlfhOEc72OUXI0gtB3iwct/3uVhj2bRpO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="445693766"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="445693766"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 06:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="752179077"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="752179077"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 26 Sep 2023 06:23:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 60251133D; Tue, 26 Sep 2023 16:23:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 1/1] pinctrl: intel: Simplify code with cleanup helpers
Date:   Tue, 26 Sep 2023 16:23:35 +0300
Message-Id: <20230926132336.416612-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use macros defined in linux/cleanup.h to automate resource lifetime
control in the driver.

While at it, unify the variables and approach in intel_gpio_irq_*().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 136 ++++++++++----------------
 1 file changed, 50 insertions(+), 86 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 3ddd5a57c834..a8e65adaed77 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/log2.h>
@@ -393,20 +394,17 @@ static int intel_pinmux_set_mux(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	const struct intel_pingroup *grp = &pctrl->soc->groups[group];
-	unsigned long flags;
 	int i;
 
-	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	guard(raw_spinlock_irqsave)(&pctrl->lock);
 
 	/*
 	 * All pins in the groups needs to be accessible and writable
 	 * before we can enable the mux for this group.
 	 */
 	for (i = 0; i < grp->grp.npins; i++) {
-		if (!intel_pad_usable(pctrl, grp->grp.pins[i])) {
-			raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+		if (!intel_pad_usable(pctrl, grp->grp.pins[i]))
 			return -EBUSY;
-		}
 	}
 
 	/* Now enable the mux setting for each pin in the group */
@@ -428,8 +426,6 @@ static int intel_pinmux_set_mux(struct pinctrl_dev *pctldev,
 		writel(value, padcfg0);
 	}
 
-	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
-
 	return 0;
 }
 
@@ -485,21 +481,16 @@ static int intel_gpio_request_enable(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	void __iomem *padcfg0;
-	unsigned long flags;
 
 	padcfg0 = intel_get_padcfg(pctrl, pin, PADCFG0);
 
-	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	guard(raw_spinlock_irqsave)(&pctrl->lock);
 
-	if (!intel_pad_owned_by_host(pctrl, pin)) {
-		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+	if (!intel_pad_owned_by_host(pctrl, pin))
 		return -EBUSY;
-	}
 
-	if (!intel_pad_is_unlocked(pctrl, pin)) {
-		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+	if (!intel_pad_is_unlocked(pctrl, pin))
 		return 0;
-	}
 
 	/*
 	 * If pin is already configured in GPIO mode, we assume that
@@ -507,15 +498,11 @@ static int intel_gpio_request_enable(struct pinctrl_dev *pctldev,
 	 * potential glitches on the pin. Otherwise, for the pin in
 	 * alternative mode, consumer has to supply respective flags.
 	 */
-	if (intel_gpio_get_gpio_mode(padcfg0) == PADCFG0_PMODE_GPIO) {
-		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+	if (intel_gpio_get_gpio_mode(padcfg0) == PADCFG0_PMODE_GPIO)
 		return 0;
-	}
 
 	intel_gpio_set_gpio_mode(padcfg0);
 
-	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
-
 	return 0;
 }
 
@@ -525,13 +512,12 @@ static int intel_gpio_set_direction(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	void __iomem *padcfg0;
-	unsigned long flags;
 
 	padcfg0 = intel_get_padcfg(pctrl, pin, PADCFG0);
 
-	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	guard(raw_spinlock_irqsave)(&pctrl->lock);
+
 	__intel_gpio_set_direction(padcfg0, input);
-	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -550,15 +536,13 @@ static int intel_config_get_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 {
 	const struct intel_community *community;
 	void __iomem *padcfg1;
-	unsigned long flags;
 	u32 value, term;
 
 	community = intel_get_community(pctrl, pin);
 	padcfg1 = intel_get_padcfg(pctrl, pin, PADCFG1);
 
-	raw_spin_lock_irqsave(&pctrl->lock, flags);
-	value = readl(padcfg1);
-	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &pctrl->lock)
+		value = readl(padcfg1);
 
 	term = (value & PADCFG1_TERM_MASK) >> PADCFG1_TERM_SHIFT;
 
@@ -631,7 +615,6 @@ static int intel_config_get_debounce(struct intel_pinctrl *pctrl, unsigned int p
 				     enum pin_config_param param, u32 *arg)
 {
 	void __iomem *padcfg2;
-	unsigned long flags;
 	unsigned long v;
 	u32 value2;
 
@@ -639,9 +622,9 @@ static int intel_config_get_debounce(struct intel_pinctrl *pctrl, unsigned int p
 	if (!padcfg2)
 		return -ENOTSUPP;
 
-	raw_spin_lock_irqsave(&pctrl->lock, flags);
-	value2 = readl(padcfg2);
-	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &pctrl->lock)
+		value2 = readl(padcfg2);
+
 	if (!(value2 & PADCFG2_DEBEN))
 		return -EINVAL;
 
@@ -692,14 +675,12 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 	unsigned int arg = pinconf_to_config_argument(config);
 	const struct intel_community *community;
 	void __iomem *padcfg1;
-	unsigned long flags;
-	int ret = 0;
 	u32 value;
 
 	community = intel_get_community(pctrl, pin);
 	padcfg1 = intel_get_padcfg(pctrl, pin, PADCFG1);
 
-	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	guard(raw_spinlock_irqsave)(&pctrl->lock);
 
 	value = readl(padcfg1);
 	value &= ~(PADCFG1_TERM_MASK | PADCFG1_TERM_UP);
@@ -730,8 +711,7 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 			value |= PADCFG1_TERM_833 << PADCFG1_TERM_SHIFT;
 			break;
 		default:
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
 
 		value |= PADCFG1_TERM_UP;
@@ -749,44 +729,34 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 			value |= PADCFG1_TERM_4K << PADCFG1_TERM_SHIFT;
 			break;
 		case 1000:
-			if (!(community->features & PINCTRL_FEATURE_1K_PD)) {
-				ret = -EINVAL;
-				break;
-			}
+			if (!(community->features & PINCTRL_FEATURE_1K_PD))
+				return -EINVAL;
 			value |= PADCFG1_TERM_1K << PADCFG1_TERM_SHIFT;
 			break;
 		case 833:
-			if (!(community->features & PINCTRL_FEATURE_1K_PD)) {
-				ret = -EINVAL;
-				break;
-			}
+			if (!(community->features & PINCTRL_FEATURE_1K_PD))
+				return -EINVAL;
 			value |= PADCFG1_TERM_833 << PADCFG1_TERM_SHIFT;
 			break;
 		default:
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
 
 		break;
 
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
 
-	if (!ret)
-		writel(value, padcfg1);
+	writel(value, padcfg1);
 
-	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
-
-	return ret;
+	return 0;
 }
 
 static int intel_config_set_debounce(struct intel_pinctrl *pctrl,
 				     unsigned int pin, unsigned int debounce)
 {
 	void __iomem *padcfg0, *padcfg2;
-	unsigned long flags;
 	u32 value0, value2;
 
 	padcfg2 = intel_get_padcfg(pctrl, pin, PADCFG2);
@@ -795,7 +765,7 @@ static int intel_config_set_debounce(struct intel_pinctrl *pctrl,
 
 	padcfg0 = intel_get_padcfg(pctrl, pin, PADCFG0);
 
-	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	guard(raw_spinlock_irqsave)(&pctrl->lock);
 
 	value0 = readl(padcfg0);
 	value2 = readl(padcfg2);
@@ -808,10 +778,8 @@ static int intel_config_set_debounce(struct intel_pinctrl *pctrl,
 		unsigned long v;
 
 		v = order_base_2(debounce * NSEC_PER_USEC / DEBOUNCE_PERIOD_NSEC);
-		if (v < 3 || v > 15) {
-			raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+		if (v < 3 || v > 15)
 			return -EINVAL;
-		}
 
 		/* Enable glitch filter and debouncer */
 		value0 |= PADCFG0_PREGFRXSEL;
@@ -822,8 +790,6 @@ static int intel_config_set_debounce(struct intel_pinctrl *pctrl,
 	writel(value0, padcfg0);
 	writel(value2, padcfg2);
 
-	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
-
 	return 0;
 }
 
@@ -973,7 +939,6 @@ static void intel_gpio_set(struct gpio_chip *chip, unsigned int offset,
 			   int value)
 {
 	struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
-	unsigned long flags;
 	void __iomem *reg;
 	u32 padcfg0;
 	int pin;
@@ -986,20 +951,19 @@ static void intel_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	if (!reg)
 		return;
 
-	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	guard(raw_spinlock_irqsave)(&pctrl->lock);
+
 	padcfg0 = readl(reg);
 	if (value)
 		padcfg0 |= PADCFG0_GPIOTXSTATE;
 	else
 		padcfg0 &= ~PADCFG0_GPIOTXSTATE;
 	writel(padcfg0, reg);
-	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static int intel_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 {
 	struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
-	unsigned long flags;
 	void __iomem *reg;
 	u32 padcfg0;
 	int pin;
@@ -1012,9 +976,9 @@ static int intel_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 	if (!reg)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&pctrl->lock, flags);
-	padcfg0 = readl(reg);
-	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &pctrl->lock)
+		padcfg0 = readl(reg);
+
 	if (padcfg0 & PADCFG0_PMODE_MASK)
 		return -EINVAL;
 
@@ -1058,15 +1022,17 @@ static void intel_gpio_irq_ack(struct irq_data *d)
 
 	pin = intel_gpio_to_pin(pctrl, irqd_to_hwirq(d), &community, &padgrp);
 	if (pin >= 0) {
-		unsigned int gpp, gpp_offset, is_offset;
+		unsigned int gpp, gpp_offset;
+		void __iomem *is;
 
 		gpp = padgrp->reg_num;
 		gpp_offset = padgroup_offset(padgrp, pin);
-		is_offset = community->is_offset + gpp * 4;
 
-		raw_spin_lock(&pctrl->lock);
-		writel(BIT(gpp_offset), community->regs + is_offset);
-		raw_spin_unlock(&pctrl->lock);
+		is = community->regs + community->is_offset + gpp * 4;
+
+		guard(raw_spinlock)(&pctrl->lock);
+
+		writel(BIT(gpp_offset), is);
 	}
 }
 
@@ -1080,7 +1046,6 @@ static void intel_gpio_irq_mask_unmask(struct gpio_chip *gc, irq_hw_number_t hwi
 	pin = intel_gpio_to_pin(pctrl, hwirq, &community, &padgrp);
 	if (pin >= 0) {
 		unsigned int gpp, gpp_offset;
-		unsigned long flags;
 		void __iomem *reg, *is;
 		u32 value;
 
@@ -1090,7 +1055,7 @@ static void intel_gpio_irq_mask_unmask(struct gpio_chip *gc, irq_hw_number_t hwi
 		reg = community->regs + community->ie_offset + gpp * 4;
 		is = community->regs + community->is_offset + gpp * 4;
 
-		raw_spin_lock_irqsave(&pctrl->lock, flags);
+		guard(raw_spinlock_irqsave)(&pctrl->lock);
 
 		/* Clear interrupt status first to avoid unexpected interrupt */
 		writel(BIT(gpp_offset), is);
@@ -1101,7 +1066,6 @@ static void intel_gpio_irq_mask_unmask(struct gpio_chip *gc, irq_hw_number_t hwi
 		else
 			value |= BIT(gpp_offset);
 		writel(value, reg);
-		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 	}
 }
 
@@ -1129,7 +1093,6 @@ static int intel_gpio_irq_type(struct irq_data *d, unsigned int type)
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
 	unsigned int pin = intel_gpio_to_pin(pctrl, irqd_to_hwirq(d), NULL, NULL);
 	u32 rxevcfg, rxinv, value;
-	unsigned long flags;
 	void __iomem *reg;
 
 	reg = intel_get_padcfg(pctrl, pin, PADCFG0);
@@ -1163,7 +1126,7 @@ static int intel_gpio_irq_type(struct irq_data *d, unsigned int type)
 	else
 		rxinv = 0;
 
-	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	guard(raw_spinlock_irqsave)(&pctrl->lock);
 
 	intel_gpio_set_gpio_mode(reg);
 
@@ -1179,8 +1142,6 @@ static int intel_gpio_irq_type(struct irq_data *d, unsigned int type)
 	else if (type & IRQ_TYPE_LEVEL_MASK)
 		irq_set_handler_locked(d, handle_level_irq);
 
-	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
-
 	return 0;
 }
 
@@ -1219,16 +1180,19 @@ static int intel_gpio_community_irq_handler(struct intel_pinctrl *pctrl,
 
 	for (gpp = 0; gpp < community->ngpps; gpp++) {
 		const struct intel_padgroup *padgrp = &community->gpps[gpp];
-		unsigned long pending, enabled, gpp_offset;
+		unsigned long pending, enabled;
+		unsigned int gpp, gpp_offset;
+		void __iomem *reg, *is;
 
-		raw_spin_lock(&pctrl->lock);
+		gpp = padgrp->reg_num;
 
-		pending = readl(community->regs + community->is_offset +
-				padgrp->reg_num * 4);
-		enabled = readl(community->regs + community->ie_offset +
-				padgrp->reg_num * 4);
+		reg = community->regs + community->ie_offset + gpp * 4;
+		is = community->regs + community->is_offset + gpp * 4;
 
-		raw_spin_unlock(&pctrl->lock);
+		scoped_guard(raw_spinlock, &pctrl->lock) {
+			pending = readl(is);
+			enabled = readl(reg);
+		}
 
 		/* Only interrupts that are enabled */
 		pending &= enabled;
-- 
2.40.0.1.gaa8946217a0b

