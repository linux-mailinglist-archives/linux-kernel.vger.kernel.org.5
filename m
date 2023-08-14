Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CFC77B0DB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjHNFlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjHNFk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:40:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D38E6D;
        Sun, 13 Aug 2023 22:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691991655; x=1723527655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=B60kqy8Oicv7rkhRo7vz3j7zQNAq7bCzd/P9le5/yMs=;
  b=FNN68A95CSPw1TvG57DDeoR2gswalvvzNEAAsSG7kLyRJVv9zH214QUf
   HT5ckgzrUYcpnzwjOm885rOfC+94AdDNetj7iSGT59cVL78NYN/ahS9W8
   ri1w2XPdjG78KH661uhLvnvKsXcJa2h4jPoBlvvD0alNgcXSM+/wta5ne
   IBACZBLh3oe5iUx2oFy83AaLYJ442AAtIffoVhhd737jPnB+19PiOQzLY
   7ngzW7ZUMZ+8XJ51+yu1LZxiN2i5X6N70Hvk5sQL/rahKRMAN9w+8H/Ta
   t9LqQVx7+AnhltzDXXyitZmrqVPJOhFTk/QIT4lyqkU222bmt0T4NQOBi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="435860596"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="435860596"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 22:40:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="847512097"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="847512097"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga002.fm.intel.com with ESMTP; 13 Aug 2023 22:40:51 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 3/3] pinctrl: moorefield: Adapt to Intel Tangier driver
Date:   Mon, 14 Aug 2023 11:10:33 +0530
Message-Id: <20230814054033.12004-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230814054033.12004-1-raag.jadav@intel.com>
References: <20230814054033.12004-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of Intel Tangier as a library driver for Moorefield.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/Kconfig              |  11 -
 drivers/pinctrl/intel/Kconfig.tng          |   8 +
 drivers/pinctrl/intel/pinctrl-moorefield.c | 640 +--------------------
 3 files changed, 37 insertions(+), 622 deletions(-)

diff --git a/drivers/pinctrl/intel/Kconfig b/drivers/pinctrl/intel/Kconfig
index 4042d6cbafcb..eaa45ebfd1c1 100644
--- a/drivers/pinctrl/intel/Kconfig
+++ b/drivers/pinctrl/intel/Kconfig
@@ -36,17 +36,6 @@ config PINCTRL_LYNXPOINT
 	  provides an interface that allows configuring of PCH pins and
 	  using them as GPIOs.
 
-config PINCTRL_MOOREFIELD
-	tristate "Intel Moorefield pinctrl driver"
-	depends on X86_INTEL_MID
-	select PINMUX
-	select PINCONF
-	select GENERIC_PINCONF
-	help
-	  Moorefield Family-Level Interface Shim (FLIS) driver provides an
-	  interface that allows configuring of SoC pins and using them as
-	  GPIOs.
-
 config PINCTRL_INTEL
 	tristate
 	select PINMUX
diff --git a/drivers/pinctrl/intel/Kconfig.tng b/drivers/pinctrl/intel/Kconfig.tng
index 8a6d315e34d7..6f88a64d260c 100644
--- a/drivers/pinctrl/intel/Kconfig.tng
+++ b/drivers/pinctrl/intel/Kconfig.tng
@@ -22,4 +22,12 @@ config PINCTRL_MERRIFIELD
 	  an interface that allows configuring of SoC pins and using them as
 	  GPIOs.
 
+config PINCTRL_MOOREFIELD
+	tristate "Intel Moorefield pinctrl driver"
+	select PINCTRL_TANGIER
+	help
+	  Intel Moorefield Family-Level Interface Shim (FLIS) driver provides
+	  an interface that allows configuring of SoC pins and using them as
+	  GPIOs.
+
 endif
diff --git a/drivers/pinctrl/intel/pinctrl-moorefield.c b/drivers/pinctrl/intel/pinctrl-moorefield.c
index 2d38d953f360..807a694b818b 100644
--- a/drivers/pinctrl/intel/pinctrl-moorefield.c
+++ b/drivers/pinctrl/intel/pinctrl-moorefield.c
@@ -6,77 +6,16 @@
  * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  */
 
-#include <linux/bits.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/seq_file.h>
+#include <linux/types.h>
 
-#include <linux/pinctrl/pinconf-generic.h>
-#include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
-#include <linux/pinctrl/pinmux.h>
 
-#include "pinctrl-intel.h"
-
-#define MOFLD_FAMILY_NR			64
-#define MOFLD_FAMILY_LEN		0x400
-
-#define SLEW_OFFSET			0x000
-#define BUFCFG_OFFSET			0x100
-#define MISC_OFFSET			0x300
-
-#define BUFCFG_PINMODE_SHIFT		0
-#define BUFCFG_PINMODE_MASK		GENMASK(2, 0)
-#define BUFCFG_PINMODE_GPIO		0
-#define BUFCFG_PUPD_VAL_SHIFT		4
-#define BUFCFG_PUPD_VAL_MASK		GENMASK(5, 4)
-#define BUFCFG_PUPD_VAL_2K		0
-#define BUFCFG_PUPD_VAL_20K		1
-#define BUFCFG_PUPD_VAL_50K		2
-#define BUFCFG_PUPD_VAL_910		3
-#define BUFCFG_PU_EN			BIT(8)
-#define BUFCFG_PD_EN			BIT(9)
-#define BUFCFG_Px_EN_MASK		GENMASK(9, 8)
-#define BUFCFG_SLEWSEL			BIT(10)
-#define BUFCFG_OVINEN			BIT(12)
-#define BUFCFG_OVINEN_EN		BIT(13)
-#define BUFCFG_OVINEN_MASK		GENMASK(13, 12)
-#define BUFCFG_OVOUTEN			BIT(14)
-#define BUFCFG_OVOUTEN_EN		BIT(15)
-#define BUFCFG_OVOUTEN_MASK		GENMASK(15, 14)
-#define BUFCFG_INDATAOV_VAL		BIT(16)
-#define BUFCFG_INDATAOV_EN		BIT(17)
-#define BUFCFG_INDATAOV_MASK		GENMASK(17, 16)
-#define BUFCFG_OUTDATAOV_VAL		BIT(18)
-#define BUFCFG_OUTDATAOV_EN		BIT(19)
-#define BUFCFG_OUTDATAOV_MASK		GENMASK(19, 18)
-#define BUFCFG_OD_EN			BIT(21)
-
-/**
- * struct mofld_family - Intel pin family description
- * @barno: MMIO BAR number where registers for this family reside
- * @pin_base: Starting pin of pins in this family
- * @npins: Number of pins in this family
- * @protected: True if family is protected by access
- * @regs: family specific common registers
- */
-struct mofld_family {
-	unsigned int barno;
-	unsigned int pin_base;
-	size_t npins;
-	bool protected;
-	void __iomem *regs;
-};
-
-#define MOFLD_FAMILY(b, s, e)				\
-	{						\
-		.barno = (b),				\
-		.pin_base = (s),			\
-		.npins = (e) - (s) + 1,			\
-	}
+#include "pinctrl-tangier.h"
 
 static const struct pinctrl_pin_desc mofld_pins[] = {
 	/* ULPI (13 pins) */
@@ -347,561 +286,39 @@ static const struct pinctrl_pin_desc mofld_pins[] = {
 	PINCTRL_PIN(250, "JTAG_TRST"),
 };
 
-static const struct mofld_family mofld_families[] = {
-	MOFLD_FAMILY(0, 0, 12),
-	MOFLD_FAMILY(1, 13, 24),
-	MOFLD_FAMILY(2, 25, 44),
-	MOFLD_FAMILY(3, 45, 52),
-	MOFLD_FAMILY(4, 53, 66),
-	MOFLD_FAMILY(5, 67, 88),
-	MOFLD_FAMILY(6, 89, 108),
-	MOFLD_FAMILY(7, 109, 131),
-	MOFLD_FAMILY(8, 132, 151),
-	MOFLD_FAMILY(9, 152, 166),
-	MOFLD_FAMILY(10, 167, 180),
-	MOFLD_FAMILY(11, 181, 195),
-	MOFLD_FAMILY(12, 196, 215),
-	MOFLD_FAMILY(13, 216, 228),
-	MOFLD_FAMILY(14, 229, 250),
+static const struct tng_family mofld_families[] = {
+	TNG_FAMILY(0, 0, 12),
+	TNG_FAMILY(1, 13, 24),
+	TNG_FAMILY(2, 25, 44),
+	TNG_FAMILY(3, 45, 52),
+	TNG_FAMILY(4, 53, 66),
+	TNG_FAMILY(5, 67, 88),
+	TNG_FAMILY(6, 89, 108),
+	TNG_FAMILY(7, 109, 131),
+	TNG_FAMILY(8, 132, 151),
+	TNG_FAMILY(9, 152, 166),
+	TNG_FAMILY(10, 167, 180),
+	TNG_FAMILY(11, 181, 195),
+	TNG_FAMILY(12, 196, 215),
+	TNG_FAMILY(13, 216, 228),
+	TNG_FAMILY(14, 229, 250),
 };
 
-/**
- * struct mofld_pinctrl - Intel Merrifield pinctrl private structure
- * @dev: Pointer to the device structure
- * @lock: Lock to serialize register access
- * @pctldesc: Pin controller description
- * @pctldev: Pointer to the pin controller device
- * @families: Array of families this pinctrl handles
- * @nfamilies: Number of families in the array
- * @functions: Array of functions
- * @nfunctions: Number of functions in the array
- * @groups: Array of pin groups
- * @ngroups: Number of groups in the array
- * @pins: Array of pins this pinctrl controls
- * @npins: Number of pins in the array
- */
-struct mofld_pinctrl {
-	struct device *dev;
-	raw_spinlock_t lock;
-	struct pinctrl_desc pctldesc;
-	struct pinctrl_dev *pctldev;
-
-	/* Pin controller configuration */
-	const struct mofld_family *families;
-	size_t nfamilies;
-	const struct intel_function *functions;
-	size_t nfunctions;
-	const struct intel_pingroup *groups;
-	size_t ngroups;
-	const struct pinctrl_pin_desc *pins;
-	size_t npins;
-};
-
-#define pin_to_bufno(f, p)		((p) - (f)->pin_base)
-
-static const struct mofld_family *mofld_get_family(struct mofld_pinctrl *mp, unsigned int pin)
-{
-	const struct mofld_family *family;
-	unsigned int i;
-
-	for (i = 0; i < mp->nfamilies; i++) {
-		family = &mp->families[i];
-		if (pin >= family->pin_base &&
-		    pin < family->pin_base + family->npins)
-			return family;
-	}
-
-	dev_warn(mp->dev, "failed to find family for pin %u\n", pin);
-	return NULL;
-}
-
-static bool mofld_buf_available(struct mofld_pinctrl *mp, unsigned int pin)
-{
-	const struct mofld_family *family;
-
-	family = mofld_get_family(mp, pin);
-	if (!family)
-		return false;
-
-	return !family->protected;
-}
-
-static void __iomem *mofld_get_bufcfg(struct mofld_pinctrl *mp, unsigned int pin)
-{
-	const struct mofld_family *family;
-	unsigned int bufno;
-
-	family = mofld_get_family(mp, pin);
-	if (!family)
-		return NULL;
-
-	bufno = pin_to_bufno(family, pin);
-	return family->regs + BUFCFG_OFFSET + bufno * 4;
-}
-
-static int mofld_read_bufcfg(struct mofld_pinctrl *mp, unsigned int pin, u32 *value)
-{
-	void __iomem *bufcfg;
-
-	if (!mofld_buf_available(mp, pin))
-		return -EBUSY;
-
-	bufcfg = mofld_get_bufcfg(mp, pin);
-	*value = readl(bufcfg);
-
-	return 0;
-}
-
-static void mofld_update_bufcfg(struct mofld_pinctrl *mp, unsigned int pin, u32 bits, u32 mask)
-{
-	void __iomem *bufcfg;
-	u32 value;
-
-	bufcfg = mofld_get_bufcfg(mp, pin);
-	value = readl(bufcfg);
-
-	value &= ~mask;
-	value |= bits & mask;
-
-	writel(value, bufcfg);
-}
-
-static int mofld_get_groups_count(struct pinctrl_dev *pctldev)
-{
-	struct mofld_pinctrl *mp = pinctrl_dev_get_drvdata(pctldev);
-
-	return mp->ngroups;
-}
-
-static const char *mofld_get_group_name(struct pinctrl_dev *pctldev, unsigned int group)
-{
-	struct mofld_pinctrl *mp = pinctrl_dev_get_drvdata(pctldev);
-
-	return mp->groups[group].grp.name;
-}
-
-static int mofld_get_group_pins(struct pinctrl_dev *pctldev, unsigned int group,
-				const unsigned int **pins, unsigned int *npins)
-{
-	struct mofld_pinctrl *mp = pinctrl_dev_get_drvdata(pctldev);
-
-	*pins = mp->groups[group].grp.pins;
-	*npins = mp->groups[group].grp.npins;
-	return 0;
-}
-
-static void mofld_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
-			       unsigned int pin)
-{
-	struct mofld_pinctrl *mp = pinctrl_dev_get_drvdata(pctldev);
-	u32 value, mode;
-	int ret;
-
-	ret = mofld_read_bufcfg(mp, pin, &value);
-	if (ret) {
-		seq_puts(s, "not available");
-		return;
-	}
-
-	mode = (value & BUFCFG_PINMODE_MASK) >> BUFCFG_PINMODE_SHIFT;
-	if (mode == BUFCFG_PINMODE_GPIO)
-		seq_puts(s, "GPIO ");
-	else
-		seq_printf(s, "mode %d ", mode);
-
-	seq_printf(s, "0x%08x", value);
-}
-
-static const struct pinctrl_ops mofld_pinctrl_ops = {
-	.get_groups_count = mofld_get_groups_count,
-	.get_group_name = mofld_get_group_name,
-	.get_group_pins = mofld_get_group_pins,
-	.pin_dbg_show = mofld_pin_dbg_show,
-};
-
-static int mofld_get_functions_count(struct pinctrl_dev *pctldev)
-{
-	struct mofld_pinctrl *mp = pinctrl_dev_get_drvdata(pctldev);
-
-	return mp->nfunctions;
-}
-
-static const char *mofld_get_function_name(struct pinctrl_dev *pctldev, unsigned int function)
-{
-	struct mofld_pinctrl *mp = pinctrl_dev_get_drvdata(pctldev);
-
-	return mp->functions[function].func.name;
-}
-
-static int mofld_get_function_groups(struct pinctrl_dev *pctldev, unsigned int function,
-				     const char * const **groups, unsigned int * const ngroups)
-{
-	struct mofld_pinctrl *mp = pinctrl_dev_get_drvdata(pctldev);
-
-	*groups = mp->functions[function].func.groups;
-	*ngroups = mp->functions[function].func.ngroups;
-	return 0;
-}
-
-static int mofld_pinmux_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
-				unsigned int group)
-{
-	struct mofld_pinctrl *mp = pinctrl_dev_get_drvdata(pctldev);
-	const struct intel_pingroup *grp = &mp->groups[group];
-	u32 bits = grp->mode << BUFCFG_PINMODE_SHIFT;
-	u32 mask = BUFCFG_PINMODE_MASK;
-	unsigned long flags;
-	unsigned int i;
-
-	/*
-	 * All pins in the groups needs to be accessible and writable
-	 * before we can enable the mux for this group.
-	 */
-	for (i = 0; i < grp->grp.npins; i++) {
-		if (!mofld_buf_available(mp, grp->grp.pins[i]))
-			return -EBUSY;
-	}
-
-	/* Now enable the mux setting for each pin in the group */
-	raw_spin_lock_irqsave(&mp->lock, flags);
-	for (i = 0; i < grp->grp.npins; i++)
-		mofld_update_bufcfg(mp, grp->grp.pins[i], bits, mask);
-	raw_spin_unlock_irqrestore(&mp->lock, flags);
-
-	return 0;
-}
-
-static int mofld_gpio_request_enable(struct pinctrl_dev *pctldev,
-				     struct pinctrl_gpio_range *range,
-				     unsigned int pin)
-{
-	struct mofld_pinctrl *mp = pinctrl_dev_get_drvdata(pctldev);
-	u32 bits = BUFCFG_PINMODE_GPIO << BUFCFG_PINMODE_SHIFT;
-	u32 mask = BUFCFG_PINMODE_MASK;
-	unsigned long flags;
-
-	if (!mofld_buf_available(mp, pin))
-		return -EBUSY;
-
-	raw_spin_lock_irqsave(&mp->lock, flags);
-	mofld_update_bufcfg(mp, pin, bits, mask);
-	raw_spin_unlock_irqrestore(&mp->lock, flags);
-
-	return 0;
-}
-
-static const struct pinmux_ops mofld_pinmux_ops = {
-	.get_functions_count = mofld_get_functions_count,
-	.get_function_name = mofld_get_function_name,
-	.get_function_groups = mofld_get_function_groups,
-	.set_mux = mofld_pinmux_set_mux,
-	.gpio_request_enable = mofld_gpio_request_enable,
-};
-
-static int mofld_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
-			    unsigned long *config)
-{
-	struct mofld_pinctrl *mp = pinctrl_dev_get_drvdata(pctldev);
-	enum pin_config_param param = pinconf_to_config_param(*config);
-	u32 value, term;
-	u16 arg = 0;
-	int ret;
-
-	ret = mofld_read_bufcfg(mp, pin, &value);
-	if (ret)
-		return -ENOTSUPP;
-
-	term = (value & BUFCFG_PUPD_VAL_MASK) >> BUFCFG_PUPD_VAL_SHIFT;
-
-	switch (param) {
-	case PIN_CONFIG_BIAS_DISABLE:
-		if (value & BUFCFG_Px_EN_MASK)
-			return -EINVAL;
-		break;
-
-	case PIN_CONFIG_BIAS_PULL_UP:
-		if ((value & BUFCFG_Px_EN_MASK) != BUFCFG_PU_EN)
-			return -EINVAL;
-
-		switch (term) {
-		case BUFCFG_PUPD_VAL_910:
-			arg = 910;
-			break;
-		case BUFCFG_PUPD_VAL_2K:
-			arg = 2000;
-			break;
-		case BUFCFG_PUPD_VAL_20K:
-			arg = 20000;
-			break;
-		case BUFCFG_PUPD_VAL_50K:
-			arg = 50000;
-			break;
-		}
-
-		break;
-
-	case PIN_CONFIG_BIAS_PULL_DOWN:
-		if ((value & BUFCFG_Px_EN_MASK) != BUFCFG_PD_EN)
-			return -EINVAL;
-
-		switch (term) {
-		case BUFCFG_PUPD_VAL_910:
-			arg = 910;
-			break;
-		case BUFCFG_PUPD_VAL_2K:
-			arg = 2000;
-			break;
-		case BUFCFG_PUPD_VAL_20K:
-			arg = 20000;
-			break;
-		case BUFCFG_PUPD_VAL_50K:
-			arg = 50000;
-			break;
-		}
-
-		break;
-
-	case PIN_CONFIG_DRIVE_PUSH_PULL:
-		if (value & BUFCFG_OD_EN)
-			return -EINVAL;
-		break;
-
-	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-		if (!(value & BUFCFG_OD_EN))
-			return -EINVAL;
-		break;
-
-	case PIN_CONFIG_SLEW_RATE:
-		if (!(value & BUFCFG_SLEWSEL))
-			arg = 0;
-		else
-			arg = 1;
-		break;
-
-	default:
-		return -ENOTSUPP;
-	}
-
-	*config = pinconf_to_config_packed(param, arg);
-	return 0;
-}
-
-static int mofld_config_set_pin(struct mofld_pinctrl *mp, unsigned int pin,
-				unsigned long config)
-{
-	unsigned int param = pinconf_to_config_param(config);
-	unsigned int arg = pinconf_to_config_argument(config);
-	u32 bits = 0, mask = 0;
-	unsigned long flags;
-
-	switch (param) {
-	case PIN_CONFIG_BIAS_DISABLE:
-		mask |= BUFCFG_Px_EN_MASK | BUFCFG_PUPD_VAL_MASK;
-		break;
-
-	case PIN_CONFIG_BIAS_PULL_UP:
-		mask |= BUFCFG_Px_EN_MASK | BUFCFG_PUPD_VAL_MASK;
-		bits |= BUFCFG_PU_EN;
-
-		switch (arg) {
-		case 50000:
-			bits |= BUFCFG_PUPD_VAL_50K << BUFCFG_PUPD_VAL_SHIFT;
-			break;
-		case 20000:
-			bits |= BUFCFG_PUPD_VAL_20K << BUFCFG_PUPD_VAL_SHIFT;
-			break;
-		case 2000:
-			bits |= BUFCFG_PUPD_VAL_2K << BUFCFG_PUPD_VAL_SHIFT;
-			break;
-		default:
-			return -EINVAL;
-		}
-
-		break;
-
-	case PIN_CONFIG_BIAS_PULL_DOWN:
-		mask |= BUFCFG_Px_EN_MASK | BUFCFG_PUPD_VAL_MASK;
-		bits |= BUFCFG_PD_EN;
-
-		switch (arg) {
-		case 50000:
-			bits |= BUFCFG_PUPD_VAL_50K << BUFCFG_PUPD_VAL_SHIFT;
-			break;
-		case 20000:
-			bits |= BUFCFG_PUPD_VAL_20K << BUFCFG_PUPD_VAL_SHIFT;
-			break;
-		case 2000:
-			bits |= BUFCFG_PUPD_VAL_2K << BUFCFG_PUPD_VAL_SHIFT;
-			break;
-		default:
-			return -EINVAL;
-		}
-
-		break;
-
-	case PIN_CONFIG_DRIVE_PUSH_PULL:
-		mask |= BUFCFG_OD_EN;
-		bits &= ~BUFCFG_OD_EN;
-		break;
-
-	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-		mask |= BUFCFG_OD_EN;
-		bits |= BUFCFG_OD_EN;
-		break;
-
-	case PIN_CONFIG_SLEW_RATE:
-		mask |= BUFCFG_SLEWSEL;
-		if (arg)
-			bits |= BUFCFG_SLEWSEL;
-		break;
-	}
-
-	raw_spin_lock_irqsave(&mp->lock, flags);
-	mofld_update_bufcfg(mp, pin, bits, mask);
-	raw_spin_unlock_irqrestore(&mp->lock, flags);
-
-	return 0;
-}
-
-static int mofld_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
-			    unsigned long *configs, unsigned int nconfigs)
-{
-	struct mofld_pinctrl *mp = pinctrl_dev_get_drvdata(pctldev);
-	unsigned int i;
-	int ret;
-
-	if (!mofld_buf_available(mp, pin))
-		return -ENOTSUPP;
-
-	for (i = 0; i < nconfigs; i++) {
-		switch (pinconf_to_config_param(configs[i])) {
-		case PIN_CONFIG_BIAS_DISABLE:
-		case PIN_CONFIG_BIAS_PULL_UP:
-		case PIN_CONFIG_BIAS_PULL_DOWN:
-		case PIN_CONFIG_DRIVE_PUSH_PULL:
-		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-		case PIN_CONFIG_SLEW_RATE:
-			ret = mofld_config_set_pin(mp, pin, configs[i]);
-			if (ret)
-				return ret;
-			break;
-
-		default:
-			return -ENOTSUPP;
-		}
-	}
-
-	return 0;
-}
-
-static int mofld_config_group_get(struct pinctrl_dev *pctldev, unsigned int group,
-				  unsigned long *config)
-{
-	const unsigned int *pins;
-	unsigned int npins;
-	int ret;
-
-	ret = mofld_get_group_pins(pctldev, group, &pins, &npins);
-	if (ret)
-		return ret;
-
-	ret = mofld_config_get(pctldev, pins[0], config);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static int mofld_config_group_set(struct pinctrl_dev *pctldev, unsigned int group,
-				  unsigned long *configs, unsigned int num_configs)
-{
-	const unsigned int *pins;
-	unsigned int npins;
-	int i, ret;
-
-	ret = mofld_get_group_pins(pctldev, group, &pins, &npins);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < npins; i++) {
-		ret = mofld_config_set(pctldev, pins[i], configs, num_configs);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static const struct pinconf_ops mofld_pinconf_ops = {
-	.is_generic = true,
-	.pin_config_get = mofld_config_get,
-	.pin_config_set = mofld_config_set,
-	.pin_config_group_get = mofld_config_group_get,
-	.pin_config_group_set = mofld_config_group_set,
+static const struct tng_pinctrl mofld_soc_data = {
+	.pins = mofld_pins,
+	.npins = ARRAY_SIZE(mofld_pins),
+	.families = mofld_families,
+	.nfamilies = ARRAY_SIZE(mofld_families),
 };
 
-static const struct pinctrl_desc mofld_pinctrl_desc = {
-	.pctlops = &mofld_pinctrl_ops,
-	.pmxops = &mofld_pinmux_ops,
-	.confops = &mofld_pinconf_ops,
-	.owner = THIS_MODULE,
-};
-
-static int mofld_pinctrl_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct mofld_family *families;
-	struct mofld_pinctrl *mp;
-	void __iomem *regs;
-	size_t nfamilies;
-	unsigned int i;
-
-	mp = devm_kzalloc(dev, sizeof(*mp), GFP_KERNEL);
-	if (!mp)
-		return -ENOMEM;
-
-	mp->dev = dev;
-	raw_spin_lock_init(&mp->lock);
-
-	regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
-
-	nfamilies = ARRAY_SIZE(mofld_families),
-	families = devm_kmemdup(dev, mofld_families, sizeof(mofld_families), GFP_KERNEL);
-	if (!families)
-		return -ENOMEM;
-
-	/* Splice memory resource by chunk per family */
-	for (i = 0; i < nfamilies; i++) {
-		struct mofld_family *family = &families[i];
-
-		family->regs = regs + family->barno * MOFLD_FAMILY_LEN;
-	}
-
-	mp->families = families;
-	mp->nfamilies = nfamilies;
-	mp->pctldesc = mofld_pinctrl_desc;
-	mp->pctldesc.name = dev_name(dev);
-	mp->pctldesc.pins = mofld_pins;
-	mp->pctldesc.npins = ARRAY_SIZE(mofld_pins);
-
-	mp->pctldev = devm_pinctrl_register(dev, &mp->pctldesc, mp);
-	if (IS_ERR(mp->pctldev))
-		return PTR_ERR(mp->pctldev);
-
-	platform_set_drvdata(pdev, mp);
-	return 0;
-}
-
 static const struct acpi_device_id mofld_acpi_table[] = {
-	{ "INTC1003" },
+	{ "INTC1003", (kernel_ulong_t)&mofld_soc_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, mofld_acpi_table);
 
 static struct platform_driver mofld_pinctrl_driver = {
-	.probe = mofld_pinctrl_probe,
+	.probe = devm_tng_pinctrl_probe,
 	.driver = {
 		.name = "pinctrl-moorefield",
 		.acpi_match_table = mofld_acpi_table,
@@ -924,3 +341,4 @@ MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
 MODULE_DESCRIPTION("Intel Moorefield SoC pinctrl driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:pinctrl-moorefield");
+MODULE_IMPORT_NS(PINCTRL_TANGIER);
-- 
2.17.1

