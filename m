Return-Path: <linux-kernel+bounces-35911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E397C8398BF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938E4294E12
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA5912F58C;
	Tue, 23 Jan 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b1GdQCaa"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F968129A65;
	Tue, 23 Jan 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035638; cv=none; b=H+9oqXtq+CzVlCCaTFp7wPpbjCIZbWzqpkkp+152hCsS47joxw6vZkoOKuhfL0QcA12JGlRckoyi7efeo4bebUoiCUwxNQ4xptaif/VpPTiu+xXfa7zHLWPp1f+ABVIcbCsLwKu3SioGnae8LBQefELi/AR7VI3wZqXUzX8Wth0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035638; c=relaxed/simple;
	bh=uuk5ZJNnp7hwBMq0qOXDSxDbEk3g6Jmp0Hv4JOCZbIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O0qn4gMLiLFMi+buaTYPR6NoWVqPJ/wDbUOCRLumz88fDxyONuGoIhy8aBQQn72VhlhtADJXVOOo5krSIKU9xO35pk+dPsFTWCc/SXm5dSC4cYI5EdPkM34vMqDWpUsngCYTv5cXp491U32vrA0mXyj0GB6yuqXpoLrsnrWSal0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b1GdQCaa; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 13FAAC0011;
	Tue, 23 Jan 2024 18:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706035629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/659CNP7DMlNf44fXpBGy4taT/5l+5grnHN1/NR7rwU=;
	b=b1GdQCaaZ0opbzjCq3Jmg/qi/dRqK/lpgSqDXoMwGsYlHO/uJVBYGkdtYY+DoqoWsSvQvm
	lkm12jQNxLaa+00GZy2MOoWdF224B8BwFtjB1tVywtW8Tx2sAbbm3fFA/5yQnNQitRMHmF
	/GOzbJSiT4M0GrYP1XIvqXYaWXNluE1n0GyBL0sCk4m8JDNbk78wvKgkoX7IojkmqyuuCF
	KCazIUwtwQ0YFrdLaaNEOQ+EZBbkdwNTUpMGreEQE+VBKc7wkKCAuDd8no98/TLZWpMWKH
	NHCpZAtc/dn7IFsFt160i1NM3wtGtZVbKySKhwa6uBvzKMdjZ89983F4RB0m8w==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Jan 2024 19:46:55 +0100
Subject: [PATCH v3 10/17] pinctrl: eyeq5: add platform driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240123-mbly-clk-v3-10-392b010b8281@bootlin.com>
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
In-Reply-To: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Add the Mobileye EyeQ5 pin controller driver. It might grow to add later
support of other platforms from Mobileye. It belongs to a syscon region
called OLB.

Existing pins and their function live statically in the driver code
rather than in the devicetree, see compatible match data.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 MAINTAINERS                     |   1 +
 drivers/pinctrl/Kconfig         |  15 +
 drivers/pinctrl/Makefile        |   1 +
 drivers/pinctrl/pinctrl-eyeq5.c | 595 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 612 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd3b5834386f..9c423a4feb86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14794,6 +14794,7 @@ F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/eyeq5_defconfig
 F:	arch/mips/mobileye/board-epm5.its.S
 F:	drivers/clk/clk-eyeq5.c
+F:	drivers/pinctrl/pinctrl-eyeq5.c
 F:	drivers/reset/reset-eyeq5.c
 F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
 F:	include/dt-bindings/soc/mobileye,eyeq5.h
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 8163a5983166..abe94de85b3d 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -195,6 +195,21 @@ config PINCTRL_EQUILIBRIUM
 	  desired pin functions, configure GPIO attributes for LGM SoC pins.
 	  Pin muxing and pin config settings are retrieved from device tree.
 
+config PINCTRL_EYEQ5
+	bool "Mobileye EyeQ5 pinctrl driver"
+	depends on OF
+	depends on MACH_EYEQ5 || COMPILE_TEST
+	select PINMUX
+	select GENERIC_PINCONF
+	select MFD_SYSCON
+	default MACH_EYEQ5
+	help
+	  Pin controller driver for the Mobileye EyeQ5 platform. It does both
+	  pin config & pin muxing. It does not handle GPIO.
+
+	  Pin muxing supports two functions for each pin: first is GPIO, second
+	  is pin-dependent. Pin config is about bias & drive strength.
+
 config PINCTRL_GEMINI
 	bool
 	depends on ARCH_GEMINI
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 1071f301cc70..0033940914d9 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_PINCTRL_DA850_PUPD) += pinctrl-da850-pupd.o
 obj-$(CONFIG_PINCTRL_DA9062)	+= pinctrl-da9062.o
 obj-$(CONFIG_PINCTRL_DIGICOLOR)	+= pinctrl-digicolor.o
 obj-$(CONFIG_PINCTRL_EQUILIBRIUM)   += pinctrl-equilibrium.o
+obj-$(CONFIG_PINCTRL_EYEQ5)	+= pinctrl-eyeq5.o
 obj-$(CONFIG_PINCTRL_GEMINI)	+= pinctrl-gemini.o
 obj-$(CONFIG_PINCTRL_INGENIC)	+= pinctrl-ingenic.o
 obj-$(CONFIG_PINCTRL_K210)	+= pinctrl-k210.o
diff --git a/drivers/pinctrl/pinctrl-eyeq5.c b/drivers/pinctrl/pinctrl-eyeq5.c
new file mode 100644
index 000000000000..2d8e5b2168bd
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-eyeq5.c
@@ -0,0 +1,595 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Pinctrl driver for the Mobileye EyeQ5 platform.
+ *
+ * The registers are located in a syscon region called OLB. There are two pin
+ * banks, each being controlled by 5 registers (see enum eq5p_regs) for
+ * pull-down, pull-up, drive strength and muxing.
+ *
+ * For each pin, muxing is between two functions: (0) GPIO or (1) another one
+ * that is pin-dependent. Functions are declared statically in this driver.
+ *
+ * We create pinctrl groups that are 1:1 equivalent to pins: each group has a
+ * single pin, and its index/selector is the pin number/offset.
+ *
+ * We use eq5p_ as prefix, as-in "EyeQ5 Pinctrl", but way shorter.
+ *
+ * Copyright (C) 2024 Mobileye Vision Technologies Ltd.
+ */
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/seq_file.h>
+
+#include "core.h"
+#include "pinctrl-utils.h"
+
+#define GPIO_FUNC_SELECTOR 0
+
+struct eq5p_pinctrl {
+	struct pinctrl_desc desc;
+
+	struct regmap *olb;
+	const unsigned int *regs; /* array of size EQ5P_REG_MAX */
+
+	const struct eq5p_function *funcs;
+	unsigned int nfuncs;
+};
+
+struct eq5p_function {
+	const char *name;
+	const char * const *groups;
+	unsigned int ngroups;
+};
+
+/* OLB registers; those are offsets in an array of address offsets. */
+enum eq5p_regs {
+	EQ5P_PD,
+	EQ5P_PU,
+	EQ5P_DS_LOW,
+	EQ5P_DS_HIGH,
+	EQ5P_IOCR,
+
+	EQ5P_REG_MAX
+};
+
+static int eq5p_pinctrl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	return pctldev->desc->npins;
+}
+
+static const char *eq5p_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
+					       unsigned int selector)
+{
+	return pctldev->desc->pins[selector].name;
+}
+
+static int eq5p_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
+				       unsigned int selector,
+				       const unsigned int **pins,
+				       unsigned int *num_pins)
+{
+	*pins = &pctldev->desc->pins[selector].number;
+	*num_pins = 1;
+	return 0;
+}
+
+static int eq5p_pinconf_get(struct pinctrl_dev *pctldev, unsigned int offset,
+			    unsigned long *config);
+
+static void eq5p_pinctrl_pin_dbg_show(struct pinctrl_dev *pctldev,
+				      struct seq_file *s,
+				      unsigned int offset)
+{
+	struct eq5p_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	const char *pin_name = pctrl->desc.pins[offset].name;
+	const char *func_name, *bias;
+	unsigned int val_pd, val_pu, val_iocr;
+	unsigned long ds_config;
+	u32 drive_strength;
+	bool pd, pu;
+	int i, j;
+
+	/* First, let's get the function name. */
+	regmap_read(pctrl->olb, pctrl->regs[EQ5P_IOCR], &val_iocr);
+	if ((val_iocr & BIT(offset)) == 0) {
+		func_name = pctrl->funcs[GPIO_FUNC_SELECTOR].name;
+	} else {
+		/* All pins have only two functions: GPIO and something else. We
+		 * look for this something else.
+		 */
+		func_name = NULL;
+		for (i = 0; i < pctrl->nfuncs; i++) {
+			if (i == GPIO_FUNC_SELECTOR)
+				continue;
+
+			for (j = 0; j < pctrl->funcs[i].ngroups; j++) {
+				/* Groups and pins are the same thing for us. */
+				const char *x = pctrl->funcs[i].groups[j];
+
+				if (strcmp(x, pin_name) == 0) {
+					func_name = pctrl->funcs[i].name;
+					break;
+				}
+			}
+
+			if (func_name)
+				break;
+		}
+
+		/* We have not found the function attached to this pin, this
+		 * should never occur as all pins have exactly two functions.
+		 */
+		if (!func_name)
+			func_name = "unknown";
+	}
+
+	/* Second, we retrieve the bias. */
+	regmap_read(pctrl->olb, pctrl->regs[EQ5P_PD], &val_pd);
+	pd = (val_pd & BIT(offset)) != 0;
+	regmap_read(pctrl->olb, pctrl->regs[EQ5P_PU], &val_pu);
+	pu = (val_pu & BIT(offset)) != 0;
+	if (pd && pu)
+		bias = "both";
+	else if (pd && !pu)
+		bias = "pulldown";
+	else if (!pd && pu)
+		bias = "pullup";
+	else
+		bias = "none";
+
+	/* Third, we get the drive strength. */
+	ds_config = pinconf_to_config_packed(PIN_CONFIG_DRIVE_STRENGTH, 0);
+	eq5p_pinconf_get(pctldev, offset, &ds_config);
+	drive_strength = pinconf_to_config_argument(ds_config);
+
+	seq_printf(s, "function=%s bias=%s drive_strength=%d",
+		   func_name, bias, drive_strength);
+}
+
+static const struct pinctrl_ops eq5p_pinctrl_ops = {
+	.get_groups_count = eq5p_pinctrl_get_groups_count,
+	.get_group_name = eq5p_pinctrl_get_group_name,
+	.get_group_pins = eq5p_pinctrl_get_group_pins,
+	.pin_dbg_show = eq5p_pinctrl_pin_dbg_show,
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
+	.dt_free_map = pinctrl_utils_free_map,
+};
+
+static int eq5p_pinmux_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	struct eq5p_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctrl->nfuncs;
+}
+
+static const char *eq5p_pinmux_get_function_name(struct pinctrl_dev *pctldev,
+						 unsigned int selector)
+{
+	struct eq5p_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctrl->funcs[selector].name;
+}
+
+static int eq5p_pinmux_get_function_groups(struct pinctrl_dev *pctldev,
+					   unsigned int selector,
+					   const char * const **groups,
+					   unsigned int *num_groups)
+{
+	struct eq5p_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups = pctrl->funcs[selector].groups;
+	*num_groups = pctrl->funcs[selector].ngroups;
+	return 0;
+}
+
+static int eq5p_pinmux_set_mux(struct pinctrl_dev *pctldev,
+			       unsigned int func_selector, unsigned int offset)
+{
+	const char *group_name = pctldev->desc->pins[offset].name;
+	struct eq5p_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	const char *func_name = pctrl->funcs[func_selector].name;
+	bool is_gpio = func_selector == GPIO_FUNC_SELECTOR;
+	unsigned int reg, mask, val;
+
+	dev_dbg(pctldev->dev, "%s: func=%s group=%s\n", __func__, func_name,
+		group_name);
+
+	reg = pctrl->regs[EQ5P_IOCR];
+	mask = BIT(offset);
+	val = is_gpio ? 0 : U32_MAX;
+
+	regmap_update_bits(pctrl->olb, reg, mask, val);
+
+	return 0;
+}
+
+static int eq5p_pinmux_gpio_request_enable(struct pinctrl_dev *pctldev,
+					   struct pinctrl_gpio_range *range,
+					   unsigned int offset)
+{
+	/* Pin offsets and group selectors are the same thing in our case. */
+	return eq5p_pinmux_set_mux(pctldev, GPIO_FUNC_SELECTOR, offset);
+}
+
+static const struct pinmux_ops eq5p_pinmux_ops = {
+	.get_functions_count = eq5p_pinmux_get_functions_count,
+	.get_function_name = eq5p_pinmux_get_function_name,
+	.get_function_groups = eq5p_pinmux_get_function_groups,
+	.set_mux = eq5p_pinmux_set_mux,
+	.gpio_request_enable = eq5p_pinmux_gpio_request_enable,
+	.strict = true,
+};
+
+static int eq5p_pinconf_get(struct pinctrl_dev *pctldev, unsigned int offset,
+			    unsigned long *config)
+{
+	enum pin_config_param param = pinconf_to_config_param(*config);
+	struct eq5p_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	unsigned int reg, val_pd, val_pu, val_ds;
+	bool pd, pu;
+	u32 arg = 0;
+
+	regmap_read(pctrl->olb, pctrl->regs[EQ5P_PD], &val_pd);
+	pd = (val_pd & BIT(offset)) != 0;
+	regmap_read(pctrl->olb, pctrl->regs[EQ5P_PU], &val_pu);
+	pu = (val_pu & BIT(offset)) != 0;
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		arg = !(pd || pu);
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		arg = pd;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		arg = pu;
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		offset *= 2; /* two bits per pin */
+		if (offset >= 32) {
+			reg = pctrl->regs[EQ5P_DS_HIGH];
+			offset -= 32;
+		} else {
+			reg = pctrl->regs[EQ5P_DS_LOW];
+		}
+		regmap_read(pctrl->olb, reg, &val_ds);
+		arg = (val_ds >> offset) & 0b11;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	*config = pinconf_to_config_packed(param, arg);
+	return 0;
+}
+
+static int eq5p_pinconf_set_drive_strength(struct pinctrl_dev *pctldev,
+					   unsigned int offset, u32 arg)
+{
+	struct eq5p_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	unsigned int reg, mask, val;
+
+	if (arg > 3) {
+		dev_err(pctldev->dev, "Unsupported drive strength: %u\n", arg);
+		return -EINVAL;
+	}
+
+	offset *= 2; /* two bits per pin */
+
+	if (offset >= 32) {
+		reg = pctrl->regs[EQ5P_DS_HIGH];
+		offset -= 32;
+	} else {
+		reg = pctrl->regs[EQ5P_DS_LOW];
+	}
+
+	mask = 0b11 << offset;
+	val = arg << offset;
+	regmap_update_bits(pctrl->olb, reg, mask, val);
+	return 0;
+}
+
+static int eq5p_pinconf_set(struct pinctrl_dev *pctldev, unsigned int offset,
+			    unsigned long *configs, unsigned int num_configs)
+{
+	struct eq5p_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	const char *pin_name = pctldev->desc->pins[offset].name;
+	struct device *dev = pctldev->dev;
+	unsigned int i, val, reg_pd, reg_pu;
+
+	val = BIT(offset);
+	reg_pd = pctrl->regs[EQ5P_PD];
+	reg_pu = pctrl->regs[EQ5P_PU];
+
+	for (i = 0; i < num_configs; i++) {
+		enum pin_config_param param = pinconf_to_config_param(configs[i]);
+		u32 arg = pinconf_to_config_argument(configs[i]);
+
+		switch (param) {
+		case PIN_CONFIG_BIAS_DISABLE:
+			dev_dbg(dev, "%s: pin=%s BIAS_DISABLE\n",
+				__func__, pin_name);
+			regmap_clear_bits(pctrl->olb, reg_pd, val);
+			regmap_clear_bits(pctrl->olb, reg_pu, val);
+			break;
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			dev_dbg(dev, "%s: pin=%s BIAS_PULL_DOWN arg=%u\n",
+				__func__, pin_name, arg);
+			if (arg == 0) /* cannot connect to GND */
+				return -EOPNOTSUPP;
+			regmap_set_bits(pctrl->olb, reg_pd, val);
+			regmap_clear_bits(pctrl->olb, reg_pu, val);
+			break;
+		case PIN_CONFIG_BIAS_PULL_UP:
+			dev_dbg(dev, "%s: pin=%s BIAS_PULL_UP arg=%u\n",
+				__func__, pin_name, arg);
+			if (arg == 0) /* cannot connect to VDD */
+				return -EOPNOTSUPP;
+			regmap_clear_bits(pctrl->olb, reg_pd, val);
+			regmap_set_bits(pctrl->olb, reg_pu, val);
+			break;
+		case PIN_CONFIG_DRIVE_STRENGTH:
+			dev_dbg(dev, "%s: pin=%s DRIVE_STRENGTH arg=%u\n",
+				__func__, pin_name, arg);
+			eq5p_pinconf_set_drive_strength(pctldev, offset, arg);
+			break;
+		default:
+			dev_err(dev, "Unsupported pinconf %u\n", param);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
+static const struct pinconf_ops eq5p_pinconf_ops = {
+	.is_generic = true,
+	.pin_config_get = eq5p_pinconf_get,
+	.pin_config_set = eq5p_pinconf_set,
+	/* Pins and groups are equivalent in this driver. */
+	.pin_config_group_get = eq5p_pinconf_get,
+	.pin_config_group_set = eq5p_pinconf_set,
+};
+
+/*
+ * Comments to the right of each pin are the "signal name" in the datasheet.
+ */
+
+static const struct pinctrl_pin_desc eq5p_pins_a[] = { /* Bank A */
+	PINCTRL_PIN(0,  "PA0"),  /* A0_TIMER0_CK */
+	PINCTRL_PIN(1,  "PA1"),  /* A1_TIMER0_EOC */
+	PINCTRL_PIN(2,  "PA2"),  /* A2_TIMER1_CK */
+	PINCTRL_PIN(3,  "PA3"),  /* A3_TIMER1_EOC */
+	PINCTRL_PIN(4,  "PA4"),  /* A4_TIMER2_CK */
+	PINCTRL_PIN(5,  "PA5"),  /* A5_TIMER2_EOC */
+	PINCTRL_PIN(6,  "PA6"),  /* A6_TIMER5_EXT_INCAP1 */
+	PINCTRL_PIN(7,  "PA7"),  /* A7_TIMER5_EXT_INCAP2 */
+	PINCTRL_PIN(8,  "PA8"),  /* A8_TIMER5_EXT_OUTCMP1 */
+	PINCTRL_PIN(9,  "PA9"),  /* A9_TIMER5_EXT_OUTCMP2 */
+	PINCTRL_PIN(10, "PA10"), /* A10_UART_0_TX */
+	PINCTRL_PIN(11, "PA11"), /* A11_UART_0_RX */
+	PINCTRL_PIN(12, "PA12"), /* A12_UART_1_TX */
+	PINCTRL_PIN(13, "PA13"), /* A13_UART_1_RX */
+	PINCTRL_PIN(14, "PA14"), /* A14_CAN_0_TX */
+	PINCTRL_PIN(15, "PA15"), /* A15_CAN_0_RX */
+	PINCTRL_PIN(16, "PA16"), /* A16_CAN_1_TX */
+	PINCTRL_PIN(17, "PA17"), /* A17_CAN_1_RX */
+	PINCTRL_PIN(18, "PA18"), /* A18_SPI_0_DO */
+	PINCTRL_PIN(19, "PA19"), /* A19_SPI_0_DI */
+	PINCTRL_PIN(20, "PA20"), /* A20_SPI_0_CK */
+	PINCTRL_PIN(21, "PA21"), /* A21_SPI_0_CS0 */
+	PINCTRL_PIN(22, "PA22"), /* A22_SPI_0_CS1 */
+	PINCTRL_PIN(23, "PA23"), /* A23_SPI_1_DO */
+	PINCTRL_PIN(24, "PA24"), /* A24_SPI_1_DI */
+	PINCTRL_PIN(25, "PA25"), /* A25_SPI_1_CK */
+	PINCTRL_PIN(26, "PA26"), /* A26_SPI_1_CS0 */
+	PINCTRL_PIN(27, "PA27"), /* A27_SPI_1_CS1 */
+	PINCTRL_PIN(28, "PA28"), /* A28_REF_CLK0 */
+};
+
+static const struct pinctrl_pin_desc eq5p_pins_b[] = { /* Bank B */
+	PINCTRL_PIN(0,  "PB0"),  /* B0_TIMER3_CK */
+	PINCTRL_PIN(1,  "PB1"),  /* B1_TIMER3_EOC */
+	PINCTRL_PIN(2,  "PB2"),  /* B2_TIMER4_CK */
+	PINCTRL_PIN(3,  "PB3"),  /* B3_TIMER4_EOC */
+	PINCTRL_PIN(4,  "PB4"),  /* B4_TIMER6_EXT_INCAP1 */
+	PINCTRL_PIN(5,  "PB5"),  /* B5_TIMER6_EXT_INCAP2 */
+	PINCTRL_PIN(6,  "PB6"),  /* B6_TIMER6_EXT_OUTCMP1 */
+	PINCTRL_PIN(7,  "PB7"),  /* B7_TIMER6_EXT_OUTCMP2 */
+	PINCTRL_PIN(8,  "PB8"),  /* B8_UART_2_TX */
+	PINCTRL_PIN(9,  "PB9"),  /* B9_UART_2_RX */
+	PINCTRL_PIN(10, "PB10"), /* B10_CAN_2_TX */
+	PINCTRL_PIN(11, "PB11"), /* B11_CAN_2_RX */
+	PINCTRL_PIN(12, "PB12"), /* B12_SPI_2_DO */
+	PINCTRL_PIN(13, "PB13"), /* B13_SPI_2_DI */
+	PINCTRL_PIN(14, "PB14"), /* B14_SPI_2_CK */
+	PINCTRL_PIN(15, "PB15"), /* B15_SPI_2_CS0 */
+	PINCTRL_PIN(16, "PB16"), /* B16_SPI_2_CS1 */
+	PINCTRL_PIN(17, "PB17"), /* B17_SPI_3_DO */
+	PINCTRL_PIN(18, "PB18"), /* B18_SPI_3_DI */
+	PINCTRL_PIN(19, "PB19"), /* B19_SPI_3_CK */
+	PINCTRL_PIN(20, "PB20"), /* B20_SPI_3_CS0 */
+	PINCTRL_PIN(21, "PB21"), /* B21_SPI_3_CS1 */
+	PINCTRL_PIN(22, "PB22"), /* B22_MCLK0 */
+};
+
+/* Groups of functions on bank A */
+static const char * const gpioa_groups[] = {
+	"PA0", "PA1", "PA2", "PA3", "PA4", "PA5", "PA6", "PA7", "PA8", "PA9",
+	"PA10", "PA11", "PA12", "PA13", "PA14", "PA15", "PA16", "PA17", "PA18",
+	"PA19", "PA20", "PA21", "PA22", "PA23", "PA24", "PA25", "PA26", "PA27",
+	"PA28",
+};
+static const char * const timer0_groups[] = { "PA0", "PA1" };
+static const char * const timer1_groups[] = { "PA2", "PA3" };
+static const char * const timer2_groups[] = { "PA4", "PA5" };
+static const char * const timer5_groups[] = { "PA6", "PA7", "PA8", "PA9" };
+static const char * const uart0_groups[] = { "PA10", "PA11" };
+static const char * const uart1_groups[] = { "PA12", "PA13" };
+static const char * const can0_groups[] = { "PA14", "PA15" };
+static const char * const can1_groups[] = { "PA16", "PA17" };
+static const char * const spi0_groups[] = { "PA18", "PA19", "PA20", "PA21", "PA22" };
+static const char * const spi1_groups[] = { "PA23", "PA24", "PA25", "PA26", "PA27" };
+static const char * const refclk0_groups[] = { "PA28" };
+
+/* Groups of functions on bank B */
+static const char * const gpiob_groups[] = {
+	"PB0", "PB1", "PB2", "PB3", "PB4", "PB5", "PB6", "PB7", "PB8", "PB9",
+	"PB10", "PB11", "PB12", "PB13", "PB14", "PB15", "PB16", "PB17", "PB18",
+	"PB19", "PB20", "PB21", "PB22",
+};
+static const char * const timer3_groups[] = { "PB0", "PB1" };
+static const char * const timer4_groups[] = { "PB2", "PB3" };
+static const char * const timer6_groups[] = { "PB4", "PB5", "PB6", "PB7" };
+static const char * const uart2_groups[] = { "PB8", "PB9" };
+static const char * const can2_groups[] = { "PB10", "PB11" };
+static const char * const spi2_groups[] = { "PB12", "PB13", "PB14", "PB15", "PB16" };
+static const char * const spi3_groups[] = { "PB17", "PB18", "PB19", "PB20", "PB21" };
+static const char * const mclk0_groups[] = { "PB22" };
+
+#define FUNCTION(a, b) { .name = a, .groups = b, .ngroups = ARRAY_SIZE(b) }
+
+static const struct eq5p_function eq5p_functions_a[] = {
+	/* GPIO having a fixed index is depended upon, see GPIO_FUNC_SELECTOR. */
+	FUNCTION("gpio", gpioa_groups),
+
+	FUNCTION("timer0", timer0_groups),
+	FUNCTION("timer1", timer1_groups),
+	FUNCTION("timer2", timer2_groups),
+	FUNCTION("timer5", timer5_groups),
+	FUNCTION("uart0", uart0_groups),
+	FUNCTION("uart1", uart1_groups),
+	FUNCTION("can0", can0_groups),
+	FUNCTION("can1", can1_groups),
+	FUNCTION("spi0", spi0_groups),
+	FUNCTION("spi1", spi1_groups),
+	FUNCTION("refclk0", refclk0_groups),
+};
+
+static const struct eq5p_function eq5p_functions_b[] = {
+	/* GPIO having a fixed index is depended upon, see GPIO_FUNC_SELECTOR. */
+	FUNCTION("gpio", gpiob_groups),
+
+	FUNCTION("timer3", timer3_groups),
+	FUNCTION("timer4", timer4_groups),
+	FUNCTION("timer6", timer6_groups),
+	FUNCTION("uart2", uart2_groups),
+	FUNCTION("can2", can2_groups),
+	FUNCTION("spi2", spi2_groups),
+	FUNCTION("spi3", spi3_groups),
+	FUNCTION("mclk0", mclk0_groups),
+};
+
+struct eq5p_match {
+	unsigned int regs[EQ5P_REG_MAX];
+	const struct pinctrl_pin_desc *pins;
+	unsigned int npins;
+	const struct eq5p_function *funcs;
+	unsigned int nfuncs;
+};
+
+static int eq5p_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *parent_np = of_get_parent(np);
+	const struct eq5p_match *match = of_device_get_match_data(dev);
+	struct pinctrl_dev *pctldev;
+	struct eq5p_pinctrl *pctrl;
+	int ret;
+
+	pctrl = devm_kzalloc(dev, sizeof(*pctrl), GFP_KERNEL);
+	if (!pctrl)
+		return -ENOMEM;
+
+	pctrl->olb = ERR_PTR(-ENODEV);
+	if (parent_np)
+		pctrl->olb = syscon_node_to_regmap(parent_np);
+	if (IS_ERR(pctrl->olb))
+		pctrl->olb = syscon_regmap_lookup_by_phandle(np, "mobileye,olb");
+	if (IS_ERR(pctrl->olb))
+		return PTR_ERR(pctrl->olb);
+
+	pctrl->regs = match->regs;
+	pctrl->funcs = match->funcs;
+	pctrl->nfuncs = match->nfuncs;
+
+	pctrl->desc.name = dev_name(dev);
+	pctrl->desc.pins = match->pins;
+	pctrl->desc.npins = match->npins;
+	pctrl->desc.pctlops = &eq5p_pinctrl_ops;
+	pctrl->desc.pmxops = &eq5p_pinmux_ops;
+	pctrl->desc.confops = &eq5p_pinconf_ops;
+	pctrl->desc.owner = THIS_MODULE;
+
+	ret = devm_pinctrl_register_and_init(dev, &pctrl->desc, pctrl, &pctldev);
+	if (ret) {
+		dev_err(dev, "Failed registering pinctrl device: %d\n", ret);
+		return ret;
+	}
+
+	ret = pinctrl_enable(pctldev);
+	if (ret) {
+		dev_err(dev, "Failed enabling pinctrl device: %d\n", ret);
+		return ret;
+	}
+
+	dev_info(dev, "probed\n");
+
+	return 0;
+}
+
+static const struct eq5p_match eq5p_match_a = {
+	.regs = {
+		[EQ5P_PD] = 0x0C0,
+		[EQ5P_PU] = 0x0C4,
+		[EQ5P_DS_LOW] = 0x0D0,
+		[EQ5P_DS_HIGH] = 0x0D4,
+		[EQ5P_IOCR] = 0x0B0,
+	},
+	.pins = eq5p_pins_a,
+	.npins = ARRAY_SIZE(eq5p_pins_a),
+	.funcs = eq5p_functions_a,
+	.nfuncs = ARRAY_SIZE(eq5p_functions_a),
+};
+
+static const struct eq5p_match eq5p_match_b = {
+	.regs = {
+		[EQ5P_PD] = 0x0C8,
+		[EQ5P_PU] = 0x0CC,
+		[EQ5P_DS_LOW] = 0x0D8,
+		[EQ5P_DS_HIGH] = 0x0DC,
+		[EQ5P_IOCR] = 0x0B4,
+	},
+	.pins = eq5p_pins_b,
+	.npins = ARRAY_SIZE(eq5p_pins_b),
+	.funcs = eq5p_functions_b,
+	.nfuncs = ARRAY_SIZE(eq5p_functions_b),
+};
+
+static const struct of_device_id eq5p_match[] = {
+	{ .compatible = "mobileye,eyeq5-a-pinctrl", .data = &eq5p_match_a },
+	{ .compatible = "mobileye,eyeq5-b-pinctrl", .data = &eq5p_match_b },
+	{},
+};
+
+static struct platform_driver eq5p_driver = {
+	.driver = {
+		.name = "eyeq5-pinctrl",
+		.of_match_table = eq5p_match,
+	},
+	.probe = eq5p_probe,
+};
+
+static int __init eq5p_init(void)
+{
+	return platform_driver_register(&eq5p_driver);
+}
+core_initcall(eq5p_init);

-- 
2.43.0


