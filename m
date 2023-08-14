Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8986E77B0DA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjHNFlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjHNFkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:40:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E741E77;
        Sun, 13 Aug 2023 22:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691991650; x=1723527650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+hUtGdOXwRRN3b0ODbsXOT4kq09YmwRbO4KN5DFH1GU=;
  b=TKn8EisRFJd9DU/Ec8ZVcddSzV88G9DHWeasVqNdI7R1UQs23umnlzmI
   zQVDJOBusi9lNfuwyp/hA3Yo/mh6VS3Fqa7aMQVO9ZGFMK/GwAgpKqjX9
   HBWhYkWFQXxiG6KLicla4aw+1ZMgGB7tbOXwMISvCCVLMdKX8L5Sxetb9
   IkW/A2NuYrKd22J8zjbZzF+z//P2zZe1+pf4GZzvbTiYAxP2VorP+EHsi
   0kpRRJGvyUCKg88Epq4yzgQae13S5xql+UtyhFDCyAjiTjivMi1b231r7
   fVQi40E7JK1eW4mxWXHNt1wY4H5i3FocL3i1zT/tQzB0Ya971HWfq/yoX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="435860576"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="435860576"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 22:40:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="847512038"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="847512038"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga002.fm.intel.com with ESMTP; 13 Aug 2023 22:40:45 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 1/3] pinctrl: tangier: Introduce Intel Tangier driver
Date:   Mon, 14 Aug 2023 11:10:31 +0530
Message-Id: <20230814054033.12004-2-raag.jadav@intel.com>
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

Intel Tangier implements the common pinctrl functionalities for
Merrifield and Moorefield platforms.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/Kconfig           |   1 +
 drivers/pinctrl/intel/Kconfig.tng       |  17 +
 drivers/pinctrl/intel/Makefile          |   1 +
 drivers/pinctrl/intel/pinctrl-tangier.c | 589 ++++++++++++++++++++++++
 drivers/pinctrl/intel/pinctrl-tangier.h |  92 ++++
 5 files changed, 700 insertions(+)
 create mode 100644 drivers/pinctrl/intel/Kconfig.tng
 create mode 100644 drivers/pinctrl/intel/pinctrl-tangier.c
 create mode 100644 drivers/pinctrl/intel/pinctrl-tangier.h

diff --git a/drivers/pinctrl/intel/Kconfig b/drivers/pinctrl/intel/Kconfig
index b3ec00624416..f2bdb0726e31 100644
--- a/drivers/pinctrl/intel/Kconfig
+++ b/drivers/pinctrl/intel/Kconfig
@@ -187,4 +187,5 @@ config PINCTRL_TIGERLAKE
 	  This pinctrl driver provides an interface that allows configuring
 	  of Intel Tiger Lake PCH pins and using them as GPIOs.
 
+source "drivers/pinctrl/intel/Kconfig.tng"
 endmenu
diff --git a/drivers/pinctrl/intel/Kconfig.tng b/drivers/pinctrl/intel/Kconfig.tng
new file mode 100644
index 000000000000..8d7757913b21
--- /dev/null
+++ b/drivers/pinctrl/intel/Kconfig.tng
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Intel Tangier and compatible pin control drivers
+
+if X86_INTEL_MID || COMPILE_TEST
+
+config PINCTRL_TANGIER
+	tristate
+	select PINMUX
+	select PINCONF
+	select GENERIC_PINCONF
+	help
+	  This is a library driver for Intel Tangier pin controller and to
+	  be selected and used by respective compatible platform drivers.
+
+	  If built as a module its name will be pinctrl-tangier.
+
+endif
diff --git a/drivers/pinctrl/intel/Makefile b/drivers/pinctrl/intel/Makefile
index 906dd6c8d837..f6d30f2d973a 100644
--- a/drivers/pinctrl/intel/Makefile
+++ b/drivers/pinctrl/intel/Makefile
@@ -4,6 +4,7 @@
 obj-$(CONFIG_PINCTRL_BAYTRAIL)		+= pinctrl-baytrail.o
 obj-$(CONFIG_PINCTRL_CHERRYVIEW)	+= pinctrl-cherryview.o
 obj-$(CONFIG_PINCTRL_LYNXPOINT)		+= pinctrl-lynxpoint.o
+obj-$(CONFIG_PINCTRL_TANGIER)		+= pinctrl-tangier.o
 obj-$(CONFIG_PINCTRL_MERRIFIELD)	+= pinctrl-merrifield.o
 obj-$(CONFIG_PINCTRL_MOOREFIELD)	+= pinctrl-moorefield.o
 obj-$(CONFIG_PINCTRL_INTEL)		+= pinctrl-intel.o
diff --git a/drivers/pinctrl/intel/pinctrl-tangier.c b/drivers/pinctrl/intel/pinctrl-tangier.c
new file mode 100644
index 000000000000..40dd60c9e526
--- /dev/null
+++ b/drivers/pinctrl/intel/pinctrl-tangier.c
@@ -0,0 +1,589 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Tangier pinctrl driver
+ *
+ * Copyright (C) 2016, 2023 Intel Corporation
+ *
+ * Authors: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ *          Raag Jadav <raag.jadav@intel.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/seq_file.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include "../core.h"
+#include "pinctrl-intel.h"
+#include "pinctrl-tangier.h"
+
+#define SLEW_OFFSET			0x000
+#define BUFCFG_OFFSET			0x100
+#define MISC_OFFSET			0x300
+
+#define BUFCFG_PINMODE_SHIFT		0
+#define BUFCFG_PINMODE_MASK		GENMASK(2, 0)
+#define BUFCFG_PINMODE_GPIO		0
+#define BUFCFG_PUPD_VAL_SHIFT		4
+#define BUFCFG_PUPD_VAL_MASK		GENMASK(5, 4)
+#define BUFCFG_PUPD_VAL_2K		0
+#define BUFCFG_PUPD_VAL_20K		1
+#define BUFCFG_PUPD_VAL_50K		2
+#define BUFCFG_PUPD_VAL_910		3
+#define BUFCFG_PU_EN			BIT(8)
+#define BUFCFG_PD_EN			BIT(9)
+#define BUFCFG_Px_EN_MASK		GENMASK(9, 8)
+#define BUFCFG_SLEWSEL			BIT(10)
+#define BUFCFG_OVINEN			BIT(12)
+#define BUFCFG_OVINEN_EN		BIT(13)
+#define BUFCFG_OVINEN_MASK		GENMASK(13, 12)
+#define BUFCFG_OVOUTEN			BIT(14)
+#define BUFCFG_OVOUTEN_EN		BIT(15)
+#define BUFCFG_OVOUTEN_MASK		GENMASK(15, 14)
+#define BUFCFG_INDATAOV_VAL		BIT(16)
+#define BUFCFG_INDATAOV_EN		BIT(17)
+#define BUFCFG_INDATAOV_MASK		GENMASK(17, 16)
+#define BUFCFG_OUTDATAOV_VAL		BIT(18)
+#define BUFCFG_OUTDATAOV_EN		BIT(19)
+#define BUFCFG_OUTDATAOV_MASK		GENMASK(19, 18)
+#define BUFCFG_OD_EN			BIT(21)
+
+#define pin_to_bufno(f, p)		((p) - (f)->pin_base)
+
+static const struct tng_family *tng_get_family(struct tng_pinctrl *tp,
+					       unsigned int pin)
+{
+	const struct tng_family *family;
+	unsigned int i;
+
+	for (i = 0; i < tp->nfamilies; i++) {
+		family = &tp->families[i];
+		if (pin >= family->pin_base &&
+		    pin < family->pin_base + family->npins)
+			return family;
+	}
+
+	dev_warn(tp->dev, "failed to find family for pin %u\n", pin);
+	return NULL;
+}
+
+static bool tng_buf_available(struct tng_pinctrl *tp, unsigned int pin)
+{
+	const struct tng_family *family;
+
+	family = tng_get_family(tp, pin);
+	if (!family)
+		return false;
+
+	return !family->protected;
+}
+
+static void __iomem *tng_get_bufcfg(struct tng_pinctrl *tp, unsigned int pin)
+{
+	const struct tng_family *family;
+	unsigned int bufno;
+
+	family = tng_get_family(tp, pin);
+	if (!family)
+		return NULL;
+
+	bufno = pin_to_bufno(family, pin);
+	return family->regs + BUFCFG_OFFSET + bufno * 4;
+}
+
+static int tng_read_bufcfg(struct tng_pinctrl *tp, unsigned int pin, u32 *value)
+{
+	void __iomem *bufcfg;
+
+	if (!tng_buf_available(tp, pin))
+		return -EBUSY;
+
+	bufcfg = tng_get_bufcfg(tp, pin);
+	*value = readl(bufcfg);
+
+	return 0;
+}
+
+static void tng_update_bufcfg(struct tng_pinctrl *tp, unsigned int pin,
+			      u32 bits, u32 mask)
+{
+	void __iomem *bufcfg;
+	u32 value;
+
+	bufcfg = tng_get_bufcfg(tp, pin);
+
+	value = readl(bufcfg);
+	value = (value & ~mask) | (bits & mask);
+	writel(value, bufcfg);
+}
+
+static int tng_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct tng_pinctrl *tp = pinctrl_dev_get_drvdata(pctldev);
+
+	return tp->ngroups;
+}
+
+static const char *tng_get_group_name(struct pinctrl_dev *pctldev,
+				      unsigned int group)
+{
+	struct tng_pinctrl *tp = pinctrl_dev_get_drvdata(pctldev);
+
+	return tp->groups[group].grp.name;
+}
+
+static int tng_get_group_pins(struct pinctrl_dev *pctldev, unsigned int group,
+			      const unsigned int **pins, unsigned int *npins)
+{
+	struct tng_pinctrl *tp = pinctrl_dev_get_drvdata(pctldev);
+
+	*pins = tp->groups[group].grp.pins;
+	*npins = tp->groups[group].grp.npins;
+	return 0;
+}
+
+static void tng_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
+			     unsigned int pin)
+{
+	struct tng_pinctrl *tp = pinctrl_dev_get_drvdata(pctldev);
+	u32 value, mode;
+	int ret;
+
+	ret = tng_read_bufcfg(tp, pin, &value);
+	if (ret) {
+		seq_puts(s, "not available");
+		return;
+	}
+
+	mode = (value & BUFCFG_PINMODE_MASK) >> BUFCFG_PINMODE_SHIFT;
+	if (mode == BUFCFG_PINMODE_GPIO)
+		seq_puts(s, "GPIO ");
+	else
+		seq_printf(s, "mode %d ", mode);
+
+	seq_printf(s, "0x%08x", value);
+}
+
+static const struct pinctrl_ops tng_pinctrl_ops = {
+	.get_groups_count = tng_get_groups_count,
+	.get_group_name = tng_get_group_name,
+	.get_group_pins = tng_get_group_pins,
+	.pin_dbg_show = tng_pin_dbg_show,
+};
+
+static int tng_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	struct tng_pinctrl *tp = pinctrl_dev_get_drvdata(pctldev);
+
+	return tp->nfunctions;
+}
+
+static const char *tng_get_function_name(struct pinctrl_dev *pctldev,
+					 unsigned int function)
+{
+	struct tng_pinctrl *tp = pinctrl_dev_get_drvdata(pctldev);
+
+	return tp->functions[function].func.name;
+}
+
+static int tng_get_function_groups(struct pinctrl_dev *pctldev,
+				   unsigned int function,
+				   const char * const **groups,
+				   unsigned int * const ngroups)
+{
+	struct tng_pinctrl *tp = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups = tp->functions[function].func.groups;
+	*ngroups = tp->functions[function].func.ngroups;
+	return 0;
+}
+
+static int tng_pinmux_set_mux(struct pinctrl_dev *pctldev,
+			      unsigned int function,
+			      unsigned int group)
+{
+	struct tng_pinctrl *tp = pinctrl_dev_get_drvdata(pctldev);
+	const struct intel_pingroup *grp = &tp->groups[group];
+	u32 bits = grp->mode << BUFCFG_PINMODE_SHIFT;
+	u32 mask = BUFCFG_PINMODE_MASK;
+	unsigned long flags;
+	unsigned int i;
+
+	/*
+	 * All pins in the groups needs to be accessible and writable
+	 * before we can enable the mux for this group.
+	 */
+	for (i = 0; i < grp->grp.npins; i++) {
+		if (!tng_buf_available(tp, grp->grp.pins[i]))
+			return -EBUSY;
+	}
+
+	/* Now enable the mux setting for each pin in the group */
+	raw_spin_lock_irqsave(&tp->lock, flags);
+	for (i = 0; i < grp->grp.npins; i++)
+		tng_update_bufcfg(tp, grp->grp.pins[i], bits, mask);
+	raw_spin_unlock_irqrestore(&tp->lock, flags);
+
+	return 0;
+}
+
+static int tng_gpio_request_enable(struct pinctrl_dev *pctldev,
+				   struct pinctrl_gpio_range *range,
+				   unsigned int pin)
+{
+	struct tng_pinctrl *tp = pinctrl_dev_get_drvdata(pctldev);
+	u32 bits = BUFCFG_PINMODE_GPIO << BUFCFG_PINMODE_SHIFT;
+	u32 mask = BUFCFG_PINMODE_MASK;
+	unsigned long flags;
+
+	if (!tng_buf_available(tp, pin))
+		return -EBUSY;
+
+	raw_spin_lock_irqsave(&tp->lock, flags);
+	tng_update_bufcfg(tp, pin, bits, mask);
+	raw_spin_unlock_irqrestore(&tp->lock, flags);
+
+	return 0;
+}
+
+static const struct pinmux_ops tng_pinmux_ops = {
+	.get_functions_count = tng_get_functions_count,
+	.get_function_name = tng_get_function_name,
+	.get_function_groups = tng_get_function_groups,
+	.set_mux = tng_pinmux_set_mux,
+	.gpio_request_enable = tng_gpio_request_enable,
+};
+
+static int tng_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
+			  unsigned long *config)
+{
+	struct tng_pinctrl *tp = pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param param = pinconf_to_config_param(*config);
+	u32 value, term;
+	u16 arg = 0;
+	int ret;
+
+	ret = tng_read_bufcfg(tp, pin, &value);
+	if (ret)
+		return -ENOTSUPP;
+
+	term = (value & BUFCFG_PUPD_VAL_MASK) >> BUFCFG_PUPD_VAL_SHIFT;
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		if (value & BUFCFG_Px_EN_MASK)
+			return -EINVAL;
+		break;
+
+	case PIN_CONFIG_BIAS_PULL_UP:
+		if ((value & BUFCFG_Px_EN_MASK) != BUFCFG_PU_EN)
+			return -EINVAL;
+
+		switch (term) {
+		case BUFCFG_PUPD_VAL_910:
+			arg = 910;
+			break;
+		case BUFCFG_PUPD_VAL_2K:
+			arg = 2000;
+			break;
+		case BUFCFG_PUPD_VAL_20K:
+			arg = 20000;
+			break;
+		case BUFCFG_PUPD_VAL_50K:
+			arg = 50000;
+			break;
+		}
+
+		break;
+
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		if ((value & BUFCFG_Px_EN_MASK) != BUFCFG_PD_EN)
+			return -EINVAL;
+
+		switch (term) {
+		case BUFCFG_PUPD_VAL_910:
+			arg = 910;
+			break;
+		case BUFCFG_PUPD_VAL_2K:
+			arg = 2000;
+			break;
+		case BUFCFG_PUPD_VAL_20K:
+			arg = 20000;
+			break;
+		case BUFCFG_PUPD_VAL_50K:
+			arg = 50000;
+			break;
+		}
+
+		break;
+
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		if (value & BUFCFG_OD_EN)
+			return -EINVAL;
+		break;
+
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		if (!(value & BUFCFG_OD_EN))
+			return -EINVAL;
+		break;
+
+	case PIN_CONFIG_SLEW_RATE:
+		if (value & BUFCFG_SLEWSEL)
+			arg = 1;
+		break;
+
+	default:
+		return -ENOTSUPP;
+	}
+
+	*config = pinconf_to_config_packed(param, arg);
+	return 0;
+}
+
+static int tng_config_set_pin(struct tng_pinctrl *tp, unsigned int pin,
+			      unsigned long config)
+{
+	unsigned int param = pinconf_to_config_param(config);
+	unsigned int arg = pinconf_to_config_argument(config);
+	u32 mask, term, value = 0;
+	unsigned long flags;
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		mask = BUFCFG_Px_EN_MASK | BUFCFG_PUPD_VAL_MASK;
+		break;
+
+	case PIN_CONFIG_BIAS_PULL_UP:
+		/* Set default strength value in case none is given */
+		if (arg == 1)
+			arg = 20000;
+
+		switch (arg) {
+		case 50000:
+			term = BUFCFG_PUPD_VAL_50K;
+			break;
+		case 20000:
+			term = BUFCFG_PUPD_VAL_20K;
+			break;
+		case 2000:
+			term = BUFCFG_PUPD_VAL_2K;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		mask = BUFCFG_Px_EN_MASK | BUFCFG_PUPD_VAL_MASK;
+		value = BUFCFG_PU_EN | (term << BUFCFG_PUPD_VAL_SHIFT);
+		break;
+
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		/* Set default strength value in case none is given */
+		if (arg == 1)
+			arg = 20000;
+
+		switch (arg) {
+		case 50000:
+			term = BUFCFG_PUPD_VAL_50K;
+			break;
+		case 20000:
+			term = BUFCFG_PUPD_VAL_20K;
+			break;
+		case 2000:
+			term = BUFCFG_PUPD_VAL_2K;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		mask = BUFCFG_Px_EN_MASK | BUFCFG_PUPD_VAL_MASK;
+		value = BUFCFG_PD_EN | (term << BUFCFG_PUPD_VAL_SHIFT);
+		break;
+
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		mask = BUFCFG_OD_EN;
+		break;
+
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		mask = BUFCFG_OD_EN;
+		value = BUFCFG_OD_EN;
+		break;
+
+	case PIN_CONFIG_SLEW_RATE:
+		mask = BUFCFG_SLEWSEL;
+		if (arg)
+			value = BUFCFG_SLEWSEL;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	raw_spin_lock_irqsave(&tp->lock, flags);
+	tng_update_bufcfg(tp, pin, value, mask);
+	raw_spin_unlock_irqrestore(&tp->lock, flags);
+
+	return 0;
+}
+
+static int tng_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
+			  unsigned long *configs, unsigned int nconfigs)
+{
+	struct tng_pinctrl *tp = pinctrl_dev_get_drvdata(pctldev);
+	unsigned int i;
+	int ret;
+
+	if (!tng_buf_available(tp, pin))
+		return -ENOTSUPP;
+
+	for (i = 0; i < nconfigs; i++) {
+		switch (pinconf_to_config_param(configs[i])) {
+		case PIN_CONFIG_BIAS_DISABLE:
+		case PIN_CONFIG_BIAS_PULL_UP:
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+		case PIN_CONFIG_DRIVE_PUSH_PULL:
+		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		case PIN_CONFIG_SLEW_RATE:
+			ret = tng_config_set_pin(tp, pin, configs[i]);
+			if (ret)
+				return ret;
+			break;
+
+		default:
+			return -ENOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
+static int tng_config_group_get(struct pinctrl_dev *pctldev,
+				unsigned int group, unsigned long *config)
+{
+	const unsigned int *pins;
+	unsigned int npins;
+	int ret;
+
+	ret = tng_get_group_pins(pctldev, group, &pins, &npins);
+	if (ret)
+		return ret;
+
+	return tng_config_get(pctldev, pins[0], config);
+}
+
+static int tng_config_group_set(struct pinctrl_dev *pctldev,
+				unsigned int group, unsigned long *configs,
+				unsigned int num_configs)
+{
+	const unsigned int *pins;
+	unsigned int npins;
+	int i, ret;
+
+	ret = tng_get_group_pins(pctldev, group, &pins, &npins);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < npins; i++) {
+		ret = tng_config_set(pctldev, pins[i], configs, num_configs);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct pinconf_ops tng_pinconf_ops = {
+	.is_generic = true,
+	.pin_config_get = tng_config_get,
+	.pin_config_set = tng_config_set,
+	.pin_config_group_get = tng_config_group_get,
+	.pin_config_group_set = tng_config_group_set,
+};
+
+static const struct pinctrl_desc tng_pinctrl_desc = {
+	.pctlops = &tng_pinctrl_ops,
+	.pmxops = &tng_pinmux_ops,
+	.confops = &tng_pinconf_ops,
+	.owner = THIS_MODULE,
+};
+
+static int tng_pinctrl_probe(struct platform_device *pdev,
+			     const struct tng_pinctrl *data)
+{
+	struct device *dev = &pdev->dev;
+	struct tng_family *families;
+	struct tng_pinctrl *tp;
+	size_t families_len;
+	void __iomem *regs;
+	unsigned int i;
+
+	tp = devm_kmemdup(dev, data, sizeof(*data), GFP_KERNEL);
+	if (!tp)
+		return -ENOMEM;
+
+	tp->dev = dev;
+	raw_spin_lock_init(&tp->lock);
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	/*
+	 * Make a copy of the families which we can use to hold pointers
+	 * to the registers.
+	 */
+	families_len = size_mul(sizeof(*families), tp->nfamilies);
+	families = devm_kmemdup(dev, tp->families, families_len, GFP_KERNEL);
+	if (!families)
+		return -ENOMEM;
+
+	/* Splice memory resource by chunk per family */
+	for (i = 0; i < tp->nfamilies; i++) {
+		struct tng_family *family = &families[i];
+
+		family->regs = regs + family->barno * TNG_FAMILY_LEN;
+	}
+
+	tp->families = families;
+	tp->pctldesc = tng_pinctrl_desc;
+	tp->pctldesc.name = dev_name(dev);
+	tp->pctldesc.pins = tp->pins;
+	tp->pctldesc.npins = tp->npins;
+
+	tp->pctldev = devm_pinctrl_register(dev, &tp->pctldesc, tp);
+	if (IS_ERR(tp->pctldev))
+		return dev_err_probe(dev, PTR_ERR(tp->pctldev),
+				     "failed to register pinctrl driver\n");
+
+	return 0;
+}
+
+int devm_tng_pinctrl_probe(struct platform_device *pdev)
+{
+	const struct tng_pinctrl *data;
+
+	data = device_get_match_data(&pdev->dev);
+	if (!data)
+		return -ENODATA;
+
+	return tng_pinctrl_probe(pdev, data);
+}
+EXPORT_SYMBOL_NS_GPL(devm_tng_pinctrl_probe, PINCTRL_TANGIER);
+
+MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
+MODULE_AUTHOR("Raag Jadav <raag.jadav@intel.com>");
+MODULE_DESCRIPTION("Intel Tangier pinctrl driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pinctrl/intel/pinctrl-tangier.h b/drivers/pinctrl/intel/pinctrl-tangier.h
new file mode 100644
index 000000000000..955cc967c0bc
--- /dev/null
+++ b/drivers/pinctrl/intel/pinctrl-tangier.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Intel Tangier pinctrl functions
+ *
+ * Copyright (C) 2016, 2023 Intel Corporation
+ *
+ * Authors: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ *          Raag Jadav <raag.jadav@intel.com>
+ */
+
+#ifndef PINCTRL_TANGIER_H
+#define PINCTRL_TANGIER_H
+
+#include <linux/spinlock_types.h>
+#include <linux/types.h>
+
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-intel.h"
+
+struct device;
+struct platform_device;
+
+#define TNG_FAMILY_NR			64
+#define TNG_FAMILY_LEN			0x400
+
+/**
+ * struct tng_family - Tangier pin family description
+ * @barno: MMIO BAR number where registers for this family reside
+ * @pin_base: Starting pin of pins in this family
+ * @npins: Number of pins in this family
+ * @protected: True if family is protected by access
+ * @regs: Family specific common registers
+ */
+struct tng_family {
+	unsigned int barno;
+	unsigned int pin_base;
+	size_t npins;
+	bool protected;
+	void __iomem *regs;
+};
+
+#define TNG_FAMILY(b, s, e)				\
+	{						\
+		.barno = (b),				\
+		.pin_base = (s),			\
+		.npins = (e) - (s) + 1,			\
+	}
+
+#define TNG_FAMILY_PROTECTED(b, s, e)			\
+	{						\
+		.barno = (b),				\
+		.pin_base = (s),			\
+		.npins = (e) - (s) + 1,			\
+		.protected = true,			\
+	}
+
+/**
+ * struct tng_pinctrl - Tangier pinctrl private structure
+ * @dev: Pointer to the device structure
+ * @lock: Lock to serialize register access
+ * @pctldesc: Pin controller description
+ * @pctldev: Pointer to the pin controller device
+ * @families: Array of families this pinctrl handles
+ * @nfamilies: Number of families in the array
+ * @functions: Array of functions
+ * @nfunctions: Number of functions in the array
+ * @groups: Array of pin groups
+ * @ngroups: Number of groups in the array
+ * @pins: Array of pins this pinctrl controls
+ * @npins: Number of pins in the array
+ */
+struct tng_pinctrl {
+	struct device *dev;
+	raw_spinlock_t lock;
+	struct pinctrl_desc pctldesc;
+	struct pinctrl_dev *pctldev;
+
+	/* Pin controller configuration */
+	const struct tng_family *families;
+	size_t nfamilies;
+	const struct intel_function *functions;
+	size_t nfunctions;
+	const struct intel_pingroup *groups;
+	size_t ngroups;
+	const struct pinctrl_pin_desc *pins;
+	size_t npins;
+};
+
+int devm_tng_pinctrl_probe(struct platform_device *pdev);
+
+#endif /* PINCTRL_TANGIER_H */
-- 
2.17.1

