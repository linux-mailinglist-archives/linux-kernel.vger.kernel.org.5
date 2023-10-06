Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428B77BB46A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjJFJky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjJFJkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:40:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0332DE4;
        Fri,  6 Oct 2023 02:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696585243; x=1728121243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E5jCYljZFG9TXhPWBougop/emuTH6QaDm8PEpiHK0Sk=;
  b=H0j0BqAPcyyBuThH2uC81BoWZZXdzp1G2OlFfjDU0r5NxF599g1Ww5ej
   LGrVUqrgJiwlfs2llTxdsZL8CxQT6Y78dkhKLQusDnXrTKYzZG+BPxtay
   V+1eNhRSLRk9OGwA6IXkoWYdGQsd86/d4lkS6GnwOxNxFomhGwkSCWxsp
   arg61iiyBUtupCMvmjfxFigU1Vi+WIii7O9UV11mDXW9fMdFWMDkTy/Nl
   4KAJlDRJ3QjhYbcTQVHOsZGnVzBh3N9d4yrZ4a/o0ZIecbut2Das88rx4
   O6l2NtlJaLEhRRZgWz59hsGYszl57E8m91byQeede89NJgTJXVpTnZhQ2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="387597897"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="387597897"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 02:40:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="925914578"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="925914578"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 06 Oct 2023 02:40:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 426675C2; Fri,  6 Oct 2023 12:40:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 2/2] pinctrl: cherryview: Simplify code with cleanup helpers
Date:   Fri,  6 Oct 2023 12:40:33 +0300
Message-Id: <20231006094033.3082468-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231006094033.3082468-1-andriy.shevchenko@linux.intel.com>
References: <20231006094033.3082468-1-andriy.shevchenko@linux.intel.com>
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

Use macros defined in linux/cleanup.h to automate resource lifetime
control in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 137 +++++++--------------
 1 file changed, 47 insertions(+), 90 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 9b9f18f50c1d..2ffeccc83ccd 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -12,6 +12,7 @@
 
 #include <linux/acpi.h>
 #include <linux/array_size.h>
+#include <linux/cleanup.h>
 #include <linux/dmi.h>
 #include <linux/gpio/driver.h>
 #include <linux/module.h>
@@ -626,15 +627,12 @@ static void chv_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 			     unsigned int offset)
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-	unsigned long flags;
 	u32 ctrl0, ctrl1;
 
-	raw_spin_lock_irqsave(&chv_lock, flags);
-
-	ctrl0 = chv_readl(pctrl, offset, CHV_PADCTRL0);
-	ctrl1 = chv_readl(pctrl, offset, CHV_PADCTRL1);
-
-	raw_spin_unlock_irqrestore(&chv_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &chv_lock) {
+		ctrl0 = chv_readl(pctrl, offset, CHV_PADCTRL0);
+		ctrl1 = chv_readl(pctrl, offset, CHV_PADCTRL1);
+	}
 
 	if (ctrl0 & CHV_PADCTRL0_GPIOEN) {
 		seq_puts(s, "GPIO ");
@@ -666,17 +664,15 @@ static int chv_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	struct device *dev = pctrl->dev;
 	const struct intel_pingroup *grp;
-	unsigned long flags;
 	int i;
 
 	grp = &pctrl->soc->groups[group];
 
-	raw_spin_lock_irqsave(&chv_lock, flags);
+	guard(raw_spinlock_irqsave)(&chv_lock);
 
 	/* Check first that the pad is not locked */
 	for (i = 0; i < grp->grp.npins; i++) {
 		if (chv_pad_locked(pctrl, grp->grp.pins[i])) {
-			raw_spin_unlock_irqrestore(&chv_lock, flags);
 			dev_warn(dev, "unable to set mode for locked pin %u\n", grp->grp.pins[i]);
 			return -EBUSY;
 		}
@@ -716,8 +712,6 @@ static int chv_pinmux_set_mux(struct pinctrl_dev *pctldev,
 			invert_oe ? "" : "not ");
 	}
 
-	raw_spin_unlock_irqrestore(&chv_lock, flags);
-
 	return 0;
 }
 
@@ -748,16 +742,14 @@ static int chv_gpio_request_enable(struct pinctrl_dev *pctldev,
 				   unsigned int offset)
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-	unsigned long flags;
 	u32 value;
 
-	raw_spin_lock_irqsave(&chv_lock, flags);
+	guard(raw_spinlock_irqsave)(&chv_lock);
 
 	if (chv_pad_locked(pctrl, offset)) {
 		value = chv_readl(pctrl, offset, CHV_PADCTRL0);
 		if (!(value & CHV_PADCTRL0_GPIOEN)) {
 			/* Locked so cannot enable */
-			raw_spin_unlock_irqrestore(&chv_lock, flags);
 			return -EBUSY;
 		}
 	} else {
@@ -792,8 +784,6 @@ static int chv_gpio_request_enable(struct pinctrl_dev *pctldev,
 		chv_writel(pctrl, offset, CHV_PADCTRL0, value);
 	}
 
-	raw_spin_unlock_irqrestore(&chv_lock, flags);
-
 	return 0;
 }
 
@@ -802,14 +792,13 @@ static void chv_gpio_disable_free(struct pinctrl_dev *pctldev,
 				  unsigned int offset)
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&chv_lock, flags);
+	guard(raw_spinlock_irqsave)(&chv_lock);
 
-	if (!chv_pad_locked(pctrl, offset))
-		chv_gpio_clear_triggering(pctrl, offset);
+	if (chv_pad_locked(pctrl, offset))
+		return;
 
-	raw_spin_unlock_irqrestore(&chv_lock, flags);
+	chv_gpio_clear_triggering(pctrl, offset);
 }
 
 static int chv_gpio_set_direction(struct pinctrl_dev *pctldev,
@@ -817,10 +806,9 @@ static int chv_gpio_set_direction(struct pinctrl_dev *pctldev,
 				  unsigned int offset, bool input)
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-	unsigned long flags;
 	u32 ctrl0;
 
-	raw_spin_lock_irqsave(&chv_lock, flags);
+	guard(raw_spinlock_irqsave)(&chv_lock);
 
 	ctrl0 = chv_readl(pctrl, offset, CHV_PADCTRL0) & ~CHV_PADCTRL0_GPIOCFG_MASK;
 	if (input)
@@ -829,8 +817,6 @@ static int chv_gpio_set_direction(struct pinctrl_dev *pctldev,
 		ctrl0 |= CHV_PADCTRL0_GPIOCFG_GPO << CHV_PADCTRL0_GPIOCFG_SHIFT;
 	chv_writel(pctrl, offset, CHV_PADCTRL0, ctrl0);
 
-	raw_spin_unlock_irqrestore(&chv_lock, flags);
-
 	return 0;
 }
 
@@ -849,15 +835,14 @@ static int chv_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	enum pin_config_param param = pinconf_to_config_param(*config);
-	unsigned long flags;
 	u32 ctrl0, ctrl1;
 	u16 arg = 0;
 	u32 term;
 
-	raw_spin_lock_irqsave(&chv_lock, flags);
-	ctrl0 = chv_readl(pctrl, pin, CHV_PADCTRL0);
-	ctrl1 = chv_readl(pctrl, pin, CHV_PADCTRL1);
-	raw_spin_unlock_irqrestore(&chv_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &chv_lock) {
+		ctrl0 = chv_readl(pctrl, pin, CHV_PADCTRL0);
+		ctrl1 = chv_readl(pctrl, pin, CHV_PADCTRL1);
+	}
 
 	term = (ctrl0 & CHV_PADCTRL0_TERM_MASK) >> CHV_PADCTRL0_TERM_SHIFT;
 
@@ -932,10 +917,10 @@ static int chv_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
 static int chv_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 			       enum pin_config_param param, u32 arg)
 {
-	unsigned long flags;
 	u32 ctrl0, pull;
 
-	raw_spin_lock_irqsave(&chv_lock, flags);
+	guard(raw_spinlock_irqsave)(&chv_lock);
+
 	ctrl0 = chv_readl(pctrl, pin, CHV_PADCTRL0);
 
 	switch (param) {
@@ -958,7 +943,6 @@ static int chv_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 			pull = CHV_PADCTRL0_TERM_20K << CHV_PADCTRL0_TERM_SHIFT;
 			break;
 		default:
-			raw_spin_unlock_irqrestore(&chv_lock, flags);
 			return -EINVAL;
 		}
 
@@ -976,7 +960,6 @@ static int chv_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 			pull = CHV_PADCTRL0_TERM_20K << CHV_PADCTRL0_TERM_SHIFT;
 			break;
 		default:
-			raw_spin_unlock_irqrestore(&chv_lock, flags);
 			return -EINVAL;
 		}
 
@@ -984,12 +967,10 @@ static int chv_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 		break;
 
 	default:
-		raw_spin_unlock_irqrestore(&chv_lock, flags);
 		return -EINVAL;
 	}
 
 	chv_writel(pctrl, pin, CHV_PADCTRL0, ctrl0);
-	raw_spin_unlock_irqrestore(&chv_lock, flags);
 
 	return 0;
 }
@@ -997,10 +978,10 @@ static int chv_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 static int chv_config_set_oden(struct intel_pinctrl *pctrl, unsigned int pin,
 			       bool enable)
 {
-	unsigned long flags;
 	u32 ctrl1;
 
-	raw_spin_lock_irqsave(&chv_lock, flags);
+	guard(raw_spinlock_irqsave)(&chv_lock);
+
 	ctrl1 = chv_readl(pctrl, pin, CHV_PADCTRL1);
 
 	if (enable)
@@ -1009,7 +990,6 @@ static int chv_config_set_oden(struct intel_pinctrl *pctrl, unsigned int pin,
 		ctrl1 &= ~CHV_PADCTRL1_ODEN;
 
 	chv_writel(pctrl, pin, CHV_PADCTRL1, ctrl1);
-	raw_spin_unlock_irqrestore(&chv_lock, flags);
 
 	return 0;
 }
@@ -1119,28 +1099,26 @@ static struct pinctrl_desc chv_pinctrl_desc = {
 static int chv_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
-	unsigned long flags;
 	u32 ctrl0, cfg;
 
-	raw_spin_lock_irqsave(&chv_lock, flags);
-	ctrl0 = chv_readl(pctrl, offset, CHV_PADCTRL0);
-	raw_spin_unlock_irqrestore(&chv_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &chv_lock)
+		ctrl0 = chv_readl(pctrl, offset, CHV_PADCTRL0);
 
 	cfg = ctrl0 & CHV_PADCTRL0_GPIOCFG_MASK;
 	cfg >>= CHV_PADCTRL0_GPIOCFG_SHIFT;
 
 	if (cfg == CHV_PADCTRL0_GPIOCFG_GPO)
 		return !!(ctrl0 & CHV_PADCTRL0_GPIOTXSTATE);
+
 	return !!(ctrl0 & CHV_PADCTRL0_GPIORXSTATE);
 }
 
 static void chv_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
-	unsigned long flags;
 	u32 ctrl0;
 
-	raw_spin_lock_irqsave(&chv_lock, flags);
+	guard(raw_spinlock_irqsave)(&chv_lock);
 
 	ctrl0 = chv_readl(pctrl, offset, CHV_PADCTRL0);
 
@@ -1150,19 +1128,15 @@ static void chv_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 		ctrl0 &= ~CHV_PADCTRL0_GPIOTXSTATE;
 
 	chv_writel(pctrl, offset, CHV_PADCTRL0, ctrl0);
-
-	raw_spin_unlock_irqrestore(&chv_lock, flags);
 }
 
 static int chv_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 {
 	struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
 	u32 ctrl0, direction;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&chv_lock, flags);
-	ctrl0 = chv_readl(pctrl, offset, CHV_PADCTRL0);
-	raw_spin_unlock_irqrestore(&chv_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &chv_lock)
+		ctrl0 = chv_readl(pctrl, offset, CHV_PADCTRL0);
 
 	direction = ctrl0 & CHV_PADCTRL0_GPIOCFG_MASK;
 	direction >>= CHV_PADCTRL0_GPIOCFG_SHIFT;
@@ -1203,23 +1177,20 @@ static void chv_gpio_irq_ack(struct irq_data *d)
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	u32 intr_line;
 
-	raw_spin_lock(&chv_lock);
+	guard(raw_spinlock)(&chv_lock);
 
 	intr_line = chv_readl(pctrl, hwirq, CHV_PADCTRL0);
 	intr_line &= CHV_PADCTRL0_INTSEL_MASK;
 	intr_line >>= CHV_PADCTRL0_INTSEL_SHIFT;
 	chv_pctrl_writel(pctrl, CHV_INTSTAT, BIT(intr_line));
-
-	raw_spin_unlock(&chv_lock);
 }
 
 static void chv_gpio_irq_mask_unmask(struct gpio_chip *gc, irq_hw_number_t hwirq, bool mask)
 {
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
 	u32 value, intr_line;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&chv_lock, flags);
+	guard(raw_spinlock_irqsave)(&chv_lock);
 
 	intr_line = chv_readl(pctrl, hwirq, CHV_PADCTRL0);
 	intr_line &= CHV_PADCTRL0_INTSEL_MASK;
@@ -1231,8 +1202,6 @@ static void chv_gpio_irq_mask_unmask(struct gpio_chip *gc, irq_hw_number_t hwirq
 	else
 		value |= BIT(intr_line);
 	chv_pctrl_writel(pctrl, CHV_INTMASK, value);
-
-	raw_spin_unlock_irqrestore(&chv_lock, flags);
 }
 
 static void chv_gpio_irq_mask(struct irq_data *d)
@@ -1257,7 +1226,15 @@ static unsigned chv_gpio_irq_startup(struct irq_data *d)
 {
 	/*
 	 * Check if the interrupt has been requested with 0 as triggering
-	 * type. In that case it is assumed that the current values
+	 * type. If not, bail out, ...
+	 */
+	if (irqd_get_trigger_type(d) != IRQ_TYPE_NONE) {
+		chv_gpio_irq_unmask(d);
+		return 0;
+	}
+
+	/*
+	 * ...otherwise it is assumed that the current values
 	 * programmed to the hardware are used (e.g BIOS configured
 	 * defaults).
 	 *
@@ -1265,17 +1242,15 @@ static unsigned chv_gpio_irq_startup(struct irq_data *d)
 	 * read back the values from hardware now, set correct flow handler
 	 * and update mappings before the interrupt is being used.
 	 */
-	if (irqd_get_trigger_type(d) == IRQ_TYPE_NONE) {
+	scoped_guard(raw_spinlock_irqsave, &chv_lock) {
 		struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 		struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
 		struct device *dev = pctrl->dev;
 		struct intel_community_context *cctx = &pctrl->context.communities[0];
 		irq_hw_number_t hwirq = irqd_to_hwirq(d);
 		irq_flow_handler_t handler;
-		unsigned long flags;
 		u32 intsel, value;
 
-		raw_spin_lock_irqsave(&chv_lock, flags);
 		intsel = chv_readl(pctrl, hwirq, CHV_PADCTRL0);
 		intsel &= CHV_PADCTRL0_INTSEL_MASK;
 		intsel >>= CHV_PADCTRL0_INTSEL_SHIFT;
@@ -1292,7 +1267,6 @@ static unsigned chv_gpio_irq_startup(struct irq_data *d)
 				intsel, hwirq);
 			cctx->intr_lines[intsel] = hwirq;
 		}
-		raw_spin_unlock_irqrestore(&chv_lock, flags);
 	}
 
 	chv_gpio_irq_unmask(d);
@@ -1357,17 +1331,14 @@ static int chv_gpio_irq_type(struct irq_data *d, unsigned int type)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-	unsigned long flags;
 	u32 value;
 	int ret;
 
-	raw_spin_lock_irqsave(&chv_lock, flags);
+	guard(raw_spinlock_irqsave)(&chv_lock);
 
 	ret = chv_gpio_set_intr_line(pctrl, hwirq);
-	if (ret) {
-		raw_spin_unlock_irqrestore(&chv_lock, flags);
+	if (ret)
 		return ret;
-	}
 
 	/*
 	 * Pins which can be used as shared interrupt are configured in
@@ -1408,8 +1379,6 @@ static int chv_gpio_irq_type(struct irq_data *d, unsigned int type)
 	else if (type & IRQ_TYPE_LEVEL_MASK)
 		irq_set_handler_locked(d, handle_level_irq);
 
-	raw_spin_unlock_irqrestore(&chv_lock, flags);
-
 	return 0;
 }
 
@@ -1433,14 +1402,12 @@ static void chv_gpio_irq_handler(struct irq_desc *desc)
 	struct intel_community_context *cctx = &pctrl->context.communities[0];
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned long pending;
-	unsigned long flags;
 	u32 intr_line;
 
 	chained_irq_enter(chip, desc);
 
-	raw_spin_lock_irqsave(&chv_lock, flags);
-	pending = chv_pctrl_readl(pctrl, CHV_INTSTAT);
-	raw_spin_unlock_irqrestore(&chv_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &chv_lock)
+		pending = chv_pctrl_readl(pctrl, CHV_INTSTAT);
 
 	for_each_set_bit(intr_line, &pending, community->nirqs) {
 		unsigned int offset;
@@ -1629,21 +1596,17 @@ static acpi_status chv_pinctrl_mmio_access_handler(u32 function,
 	void *handler_context, void *region_context)
 {
 	struct intel_pinctrl *pctrl = region_context;
-	unsigned long flags;
-	acpi_status ret = AE_OK;
 
-	raw_spin_lock_irqsave(&chv_lock, flags);
+	guard(raw_spinlock_irqsave)(&chv_lock);
 
 	if (function == ACPI_WRITE)
 		chv_pctrl_writel(pctrl, address, *value);
 	else if (function == ACPI_READ)
 		*value = chv_pctrl_readl(pctrl, address);
 	else
-		ret = AE_BAD_PARAMETER;
+		return AE_BAD_PARAMETER;
 
-	raw_spin_unlock_irqrestore(&chv_lock, flags);
-
-	return ret;
+	return AE_OK;
 }
 
 static int chv_pinctrl_probe(struct platform_device *pdev)
@@ -1751,10 +1714,9 @@ static int chv_pinctrl_suspend_noirq(struct device *dev)
 {
 	struct intel_pinctrl *pctrl = dev_get_drvdata(dev);
 	struct intel_community_context *cctx = &pctrl->context.communities[0];
-	unsigned long flags;
 	int i;
 
-	raw_spin_lock_irqsave(&chv_lock, flags);
+	guard(raw_spinlock_irqsave)(&chv_lock);
 
 	cctx->saved_intmask = chv_pctrl_readl(pctrl, CHV_INTMASK);
 
@@ -1772,8 +1734,6 @@ static int chv_pinctrl_suspend_noirq(struct device *dev)
 		ctx->padctrl1 = chv_readl(pctrl, desc->number, CHV_PADCTRL1);
 	}
 
-	raw_spin_unlock_irqrestore(&chv_lock, flags);
-
 	return 0;
 }
 
@@ -1781,10 +1741,9 @@ static int chv_pinctrl_resume_noirq(struct device *dev)
 {
 	struct intel_pinctrl *pctrl = dev_get_drvdata(dev);
 	struct intel_community_context *cctx = &pctrl->context.communities[0];
-	unsigned long flags;
 	int i;
 
-	raw_spin_lock_irqsave(&chv_lock, flags);
+	guard(raw_spinlock_irqsave)(&chv_lock);
 
 	/*
 	 * Mask all interrupts before restoring per-pin configuration
@@ -1826,8 +1785,6 @@ static int chv_pinctrl_resume_noirq(struct device *dev)
 	chv_pctrl_writel(pctrl, CHV_INTSTAT, 0xffff);
 	chv_pctrl_writel(pctrl, CHV_INTMASK, cctx->saved_intmask);
 
-	raw_spin_unlock_irqrestore(&chv_lock, flags);
-
 	return 0;
 }
 
-- 
2.40.0.1.gaa8946217a0b

