Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D176A7A5F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjISKMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjISKMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:12:23 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ED7F2;
        Tue, 19 Sep 2023 03:12:15 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38JABx6Y23430197, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38JABx6Y23430197
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 18:11:59 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 19 Sep 2023 18:12:00 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 19 Sep 2023 18:11:59 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Tue, 19 Sep 2023 18:11:59 +0800
From:   Tzuyi Chang <tychang@realtek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tzuyi Chang <tychang@realtek.com>
Subject: [PATCH v3 1/7] pinctrl: realtek: Add common pinctrl driver for Realtek DHC RTD SoCs
Date:   Tue, 19 Sep 2023 18:11:11 +0800
Message-ID: <20230919101117.4097-2-tychang@realtek.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919101117.4097-1-tychang@realtek.com>
References: <20230919101117.4097-1-tychang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTD SoCs share a similar design for pinmux and pinconfig.
This common pinctrl driver supports different variants within the RTD
SoCs.

Signed-off-by: Tzuyi Chang <tychang@realtek.com>
---
v2 to v3 change:
    1. use regmap_update_bits instead of rtd_pinctrl_update_bits
v1 to v2 change:
    1. rename realtek,pdrive to realtek,drive-strength-p
    2. rename realtek,ndrive to realtek,drive-strength-n
    3. rename realtek,dcycle to realtek,duty-cycle
---
 drivers/pinctrl/Kconfig               |   1 +
 drivers/pinctrl/Makefile              |   1 +
 drivers/pinctrl/realtek/Kconfig       |   8 +
 drivers/pinctrl/realtek/Makefile      |   3 +
 drivers/pinctrl/realtek/pinctrl-rtd.c | 580 ++++++++++++++++++++++++++
 drivers/pinctrl/realtek/pinctrl-rtd.h | 124 ++++++
 6 files changed, 717 insertions(+)
 create mode 100644 drivers/pinctrl/realtek/Kconfig
 create mode 100644 drivers/pinctrl/realtek/Makefile
 create mode 100644 drivers/pinctrl/realtek/pinctrl-rtd.c
 create mode 100644 drivers/pinctrl/realtek/pinctrl-rtd.h

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 57d57af1f624..9f79ce1bb621 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -531,6 +531,7 @@ source "drivers/pinctrl/nuvoton/Kconfig"
 source "drivers/pinctrl/nxp/Kconfig"
 source "drivers/pinctrl/pxa/Kconfig"
 source "drivers/pinctrl/qcom/Kconfig"
+source "drivers/pinctrl/realtek/Kconfig"
 source "drivers/pinctrl/renesas/Kconfig"
 source "drivers/pinctrl/samsung/Kconfig"
 source "drivers/pinctrl/spear/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 482b391b5deb..beea6ac8b49e 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -67,6 +67,7 @@ obj-y				+= nuvoton/
 obj-y				+= nxp/
 obj-$(CONFIG_PINCTRL_PXA)	+= pxa/
 obj-y				+= qcom/
+obj-$(CONFIG_ARCH_REALTEK)      += realtek/
 obj-$(CONFIG_PINCTRL_RENESAS)	+= renesas/
 obj-$(CONFIG_PINCTRL_SAMSUNG)	+= samsung/
 obj-$(CONFIG_PINCTRL_SPEAR)	+= spear/
diff --git a/drivers/pinctrl/realtek/Kconfig b/drivers/pinctrl/realtek/Kconfig
new file mode 100644
index 000000000000..d92aad885a81
--- /dev/null
+++ b/drivers/pinctrl/realtek/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config PINCTRL_RTD
+	tristate "Realtek DHC core pin controller driver"
+	depends on ARCH_REALTEK
+	default y
+	select PINMUX
+	select GENERIC_PINCONF
diff --git a/drivers/pinctrl/realtek/Makefile b/drivers/pinctrl/realtek/Makefile
new file mode 100644
index 000000000000..be2c65b26115
--- /dev/null
+++ b/drivers/pinctrl/realtek/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Realtek DHC pin control drivers
+obj-$(CONFIG_PINCTRL_RTD)		+= pinctrl-rtd.o
diff --git a/drivers/pinctrl/realtek/pinctrl-rtd.c b/drivers/pinctrl/realtek/pinctrl-rtd.c
new file mode 100644
index 000000000000..bafe27face80
--- /dev/null
+++ b/drivers/pinctrl/realtek/pinctrl-rtd.c
@@ -0,0 +1,580 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Realtek DHC pin controller driver
+ *
+ * Copyright (c) 2023 Realtek Semiconductor Corp.
+ */
+
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include "../core.h"
+#include "../pinctrl-utils.h"
+#include "pinctrl-rtd.h"
+
+struct rtd_pinctrl {
+	struct device *dev;
+	struct pinctrl_dev *pcdev;
+	void __iomem *base;
+	struct pinctrl_desc desc;
+	const struct rtd_pinctrl_desc *info;
+	struct regmap *regmap_pinctrl;
+};
+
+/* custom pinconf parameters */
+#define RTD_DRIVE_STRENGH_P (PIN_CONFIG_END + 1)
+#define RTD_DRIVE_STRENGH_N (PIN_CONFIG_END + 2)
+#define RTD_DUTY_CYCLE (PIN_CONFIG_END + 3)
+
+static const struct pinconf_generic_params rtd_custom_bindings[] = {
+	{"realtek,drive-strength-p", RTD_DRIVE_STRENGH_P, 0},
+	{"realtek,drive-strength-n", RTD_DRIVE_STRENGH_N, 0},
+	{"realtek,duty-cycle", RTD_DUTY_CYCLE, 0},
+};
+
+static int rtd_pinctrl_get_groups_count(struct pinctrl_dev *pcdev)
+{
+	struct rtd_pinctrl *data = pinctrl_dev_get_drvdata(pcdev);
+
+	return data->info->num_groups;
+}
+
+static const char *rtd_pinctrl_get_group_name(struct pinctrl_dev *pcdev,
+					      unsigned int selector)
+{
+	struct rtd_pinctrl *data = pinctrl_dev_get_drvdata(pcdev);
+
+	return data->info->groups[selector].name;
+}
+
+static int rtd_pinctrl_get_group_pins(struct pinctrl_dev *pcdev,
+				      unsigned int selector,
+				      const unsigned int **pins,
+				      unsigned int *num_pins)
+{
+	struct rtd_pinctrl *data = pinctrl_dev_get_drvdata(pcdev);
+
+	*pins = data->info->groups[selector].pins;
+	*num_pins = data->info->groups[selector].num_pins;
+
+	return 0;
+}
+
+static void rtd_pinctrl_dbg_show(struct pinctrl_dev *pcdev,
+				 struct seq_file *s,
+				 unsigned int offset)
+{
+	struct rtd_pinctrl *data = pinctrl_dev_get_drvdata(pcdev);
+	const struct rtd_pin_desc *mux = &data->info->muxes[offset];
+	const struct rtd_pin_mux_desc *func;
+	u32 val;
+	u32 mask;
+	u32 pin_val;
+	int is_map;
+
+	if (!mux->name) {
+		seq_puts(s, "[not defined]");
+		return;
+	}
+	val = readl_relaxed(data->base + mux->mux_offset);
+	mask = mux->mux_mask;
+	pin_val = val & mask;
+
+	is_map = 0;
+	func = &mux->functions[0];
+	seq_puts(s, "function: ");
+	while (func->name) {
+		if (func->mux_value == pin_val) {
+			is_map = 1;
+			seq_printf(s, "[%s] ", func->name);
+		} else {
+			seq_printf(s, "%s ", func->name);
+		}
+		func++;
+	}
+	if (!is_map)
+		seq_puts(s, "[not defined]");
+}
+
+static const struct pinctrl_ops rtd_pinctrl_ops = {
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
+	.dt_free_map = pinctrl_utils_free_map,
+	.get_groups_count = rtd_pinctrl_get_groups_count,
+	.get_group_name = rtd_pinctrl_get_group_name,
+	.get_group_pins = rtd_pinctrl_get_group_pins,
+	.pin_dbg_show = rtd_pinctrl_dbg_show,
+};
+
+static int rtd_pinctrl_get_functions_count(struct pinctrl_dev *pcdev)
+{
+	struct rtd_pinctrl *data = pinctrl_dev_get_drvdata(pcdev);
+
+	return data->info->num_functions;
+}
+
+static const char *rtd_pinctrl_get_function_name(struct pinctrl_dev *pcdev,
+						 unsigned int selector)
+{
+	struct rtd_pinctrl *data = pinctrl_dev_get_drvdata(pcdev);
+
+	return data->info->functions[selector].name;
+}
+
+static int rtd_pinctrl_get_function_groups(struct pinctrl_dev *pcdev,
+					   unsigned int selector,
+					   const char * const **groups,
+					   unsigned int * const num_groups)
+{
+	struct rtd_pinctrl *data = pinctrl_dev_get_drvdata(pcdev);
+
+	*groups = data->info->functions[selector].groups;
+	*num_groups = data->info->functions[selector].num_groups;
+
+	return 0;
+}
+
+static const struct rtd_pin_desc *rtd_pinctrl_find_mux(struct rtd_pinctrl *data, unsigned int pin)
+{
+	if (!data->info->muxes[pin].name)
+		return &data->info->muxes[pin];
+
+	return NULL;
+}
+
+static int rtd_pinctrl_set_one_mux(struct pinctrl_dev *pcdev,
+				   unsigned int pin, const char *func_name)
+{
+	struct rtd_pinctrl *data = pinctrl_dev_get_drvdata(pcdev);
+	const struct rtd_pin_desc *mux;
+	int ret = 0;
+	int i;
+
+	mux = rtd_pinctrl_find_mux(data, pin);
+	if (!mux)
+		return 0;
+
+	if (!mux->functions) {
+		dev_err(pcdev->dev, "No functions available for pin %s\n", mux->name);
+		return -ENOTSUPP;
+	}
+
+	for (i = 0; mux->functions[i].name; i++) {
+		if (strcmp(mux->functions[i].name, func_name) != 0)
+			continue;
+		ret = regmap_update_bits(data->regmap_pinctrl, mux->mux_offset, mux->mux_mask,
+					mux->functions[i].mux_value);
+		return ret;
+	}
+
+	dev_err(pcdev->dev, "No function %s available for pin %s\n", func_name, mux->name);
+
+	return -EINVAL;
+}
+
+static int rtd_pinctrl_set_mux(struct pinctrl_dev *pcdev,
+			       unsigned int function, unsigned int group)
+{
+	struct rtd_pinctrl *data = pinctrl_dev_get_drvdata(pcdev);
+	const unsigned int *pins;
+	unsigned int num_pins;
+	const char *func_name;
+	const char *group_name;
+	int i, ret;
+
+	func_name = data->info->functions[function].name;
+	group_name = data->info->groups[group].name;
+
+	ret = rtd_pinctrl_get_group_pins(pcdev, group, &pins, &num_pins);
+	if (ret) {
+		dev_err(pcdev->dev, "Getting pins for group %s failed\n", group_name);
+		return ret;
+	}
+
+	for (i = 0; i < num_pins; i++) {
+		ret = rtd_pinctrl_set_one_mux(pcdev, pins[i], func_name);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int rtd_pinctrl_gpio_request_enable(struct pinctrl_dev *pcdev,
+					   struct pinctrl_gpio_range *range,
+					   unsigned int offset)
+{
+	return rtd_pinctrl_set_one_mux(pcdev, offset, "gpio");
+}
+
+static const struct pinmux_ops rtd_pinmux_ops = {
+	.get_functions_count = rtd_pinctrl_get_functions_count,
+	.get_function_name = rtd_pinctrl_get_function_name,
+	.get_function_groups = rtd_pinctrl_get_function_groups,
+	.set_mux = rtd_pinctrl_set_mux,
+	.gpio_request_enable = rtd_pinctrl_gpio_request_enable,
+};
+
+static const struct pinctrl_pin_desc
+	*rtd_pinctrl_get_pin_by_number(struct rtd_pinctrl *data, int number)
+{
+	int i;
+
+	for (i = 0; i < data->info->num_pins; i++) {
+		if (data->info->pins[i].number == number)
+			return &data->info->pins[i];
+	}
+
+	return NULL;
+}
+
+static const struct rtd_pin_config_desc
+	*rtd_pinctrl_find_config(struct rtd_pinctrl *data, unsigned int pin)
+{
+	if (!data->info->configs[pin].name)
+		return &data->info->configs[pin];
+
+	return NULL;
+}
+
+static const struct rtd_pin_sconfig_desc *rtd_pinctrl_find_sconfig(struct rtd_pinctrl *data,
+								   unsigned int pin)
+{
+	int i;
+	const struct pinctrl_pin_desc *pin_desc;
+	const char *pin_name;
+
+	pin_desc = rtd_pinctrl_get_pin_by_number(data, pin);
+	if (!pin_desc)
+		return NULL;
+
+	pin_name = pin_desc->name;
+
+	for (i = 0; i < data->info->num_sconfigs; i++) {
+		if (strcmp(data->info->sconfigs[i].name, pin_name) == 0)
+			return &data->info->sconfigs[i];
+	}
+
+	return NULL;
+}
+
+static int rtd_pconf_parse_conf(struct rtd_pinctrl *data,
+				unsigned int pinnr,
+				enum pin_config_param param,
+				enum pin_config_param arg)
+{
+	const struct rtd_pin_config_desc *config_desc;
+	const struct rtd_pin_sconfig_desc *sconfig_desc;
+	u8 set_val = 0;
+	u16 strength;
+	u32 val;
+	u32 mask;
+	u32 pulsel_off, pulen_off, smt_off, curr_off, pow_off, reg_off, p_off, n_off;
+	const char *name = data->info->pins[pinnr].name;
+	int ret = 0;
+
+	config_desc = rtd_pinctrl_find_config(data, pinnr);
+	if (!config_desc) {
+		dev_err(data->dev, "Not support pin config for pin: %s\n", name);
+		return -ENOTSUPP;
+	}
+	switch ((u32)param) {
+	case PIN_CONFIG_INPUT_SCHMITT:
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		if (config_desc->smt_offset == NA) {
+			dev_err(data->dev, "Not support input schmitt for pin: %s\n", name);
+			return -ENOTSUPP;
+		}
+		smt_off = config_desc->base_bit + config_desc->smt_offset;
+		reg_off = config_desc->reg_offset;
+		set_val = arg;
+
+		mask = BIT(smt_off);
+		val = set_val ? BIT(smt_off) : 0;
+		break;
+
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		if (config_desc->pud_en_offset == NA) {
+			dev_err(data->dev, "Not support push pull for pin: %s\n", name);
+			return -ENOTSUPP;
+		}
+		pulen_off = config_desc->base_bit + config_desc->pud_en_offset;
+		reg_off = config_desc->reg_offset;
+
+		mask =  BIT(pulen_off);
+		val = 0;
+		break;
+
+	case PIN_CONFIG_BIAS_DISABLE:
+		if (config_desc->pud_en_offset == NA) {
+			dev_err(data->dev, "Not support bias disable for pin: %s\n", name);
+			return -ENOTSUPP;
+		}
+		pulen_off = config_desc->base_bit + config_desc->pud_en_offset;
+		reg_off = config_desc->reg_offset;
+
+		mask =  BIT(pulen_off);
+		val = 0;
+		break;
+
+	case PIN_CONFIG_BIAS_PULL_UP:
+		if (config_desc->pud_en_offset == NA) {
+			dev_err(data->dev, "Not support bias pull up for pin:%s\n", name);
+			return -ENOTSUPP;
+		}
+		pulen_off = config_desc->base_bit + config_desc->pud_en_offset;
+		pulsel_off = config_desc->base_bit + config_desc->pud_sel_offset;
+		reg_off = config_desc->reg_offset;
+
+		mask = BIT(pulen_off) | BIT(pulsel_off);
+		val = mask;
+		break;
+
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		if (config_desc->pud_en_offset == NA) {
+			dev_err(data->dev, "Not support bias pull down for pin: %s\n", name);
+			return -ENOTSUPP;
+		}
+		pulen_off = config_desc->base_bit + config_desc->pud_en_offset;
+		pulsel_off = config_desc->base_bit + config_desc->pud_sel_offset;
+		reg_off = config_desc->reg_offset;
+
+		mask = BIT(pulen_off) | BIT(pulsel_off);
+		val = BIT(pulen_off);
+		break;
+
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		curr_off = config_desc->base_bit + config_desc->curr_offset;
+		reg_off = config_desc->reg_offset;
+		strength = arg;
+		val = 0;
+		switch (config_desc->curr_type) {
+		case PADDRI_4_8:
+			if (strength == 4)
+				val = 0;
+			else if (strength == 8)
+				val = BIT(curr_off);
+			else
+				return -EINVAL;
+			break;
+		case PADDRI_2_4:
+			if (strength == 2)
+				val = 0;
+			else if (strength == 4)
+				val = BIT(curr_off);
+			else
+				return -EINVAL;
+			break;
+		case NA:
+			dev_err(data->dev, "Not support drive strength for pin: %s\n", name);
+			return -ENOTSUPP;
+		default:
+			return -EINVAL;
+		}
+		mask = BIT(curr_off);
+		break;
+
+	case PIN_CONFIG_POWER_SOURCE:
+		if (config_desc->power_offset == NA) {
+			dev_err(data->dev, "Not support power source for pin: %s\n", name);
+			return -ENOTSUPP;
+		}
+		reg_off = config_desc->reg_offset;
+		pow_off = config_desc->base_bit + config_desc->power_offset;
+		if (pow_off >= 32) {
+			reg_off += 0x4;
+			pow_off -= 32;
+		}
+		set_val = arg;
+		mask = BIT(pow_off);
+		val = set_val ? mask : 0;
+		break;
+
+	case RTD_DRIVE_STRENGH_P:
+		sconfig_desc = rtd_pinctrl_find_sconfig(data, pinnr);
+		if (!sconfig_desc) {
+			dev_err(data->dev, "Not support P driving for pin: %s\n", name);
+			return -ENOTSUPP;
+		}
+		set_val = arg;
+		reg_off = sconfig_desc->reg_offset;
+		p_off = sconfig_desc->pdrive_offset;
+		if (p_off >= 32) {
+			reg_off += 0x4;
+			p_off -= 32;
+		}
+		mask = GENMASK(p_off + sconfig_desc->pdrive_maskbits - 1, p_off);
+		val = set_val << p_off;
+		break;
+
+	case RTD_DRIVE_STRENGH_N:
+		sconfig_desc = rtd_pinctrl_find_sconfig(data, pinnr);
+		if (!sconfig_desc) {
+			dev_err(data->dev, "Not support N driving for pin: %s\n", name);
+			return -ENOTSUPP;
+		}
+		set_val = arg;
+		reg_off = sconfig_desc->reg_offset;
+		n_off = sconfig_desc->ndrive_offset;
+		if (n_off >= 32) {
+			reg_off += 0x4;
+			n_off -= 32;
+		}
+		mask = GENMASK(n_off + sconfig_desc->ndrive_maskbits - 1, n_off);
+		val = set_val << n_off;
+		break;
+
+	case RTD_DUTY_CYCLE:
+		sconfig_desc = rtd_pinctrl_find_sconfig(data, pinnr);
+		if (!sconfig_desc || sconfig_desc->dcycle_offset == NA) {
+			dev_err(data->dev, "Not support duty cycle for pin: %s\n", name);
+			return -ENOTSUPP;
+		}
+		set_val = arg;
+		reg_off = config_desc->reg_offset;
+		mask = GENMASK(sconfig_desc->dcycle_offset +
+		sconfig_desc->dcycle_maskbits - 1, sconfig_desc->dcycle_offset);
+		val = set_val << sconfig_desc->dcycle_offset;
+		break;
+
+	default:
+		dev_err(data->dev, "unsupported pinconf: %d\n", (u32)param);
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(data->regmap_pinctrl, reg_off, mask, val);
+	if (ret)
+		dev_err(data->dev, "could not update pinconf(%d) for pin(%s)\n", (u32)param, name);
+
+	return ret;
+}
+
+static int rtd_pin_config_get(struct pinctrl_dev *pcdev, unsigned int pinnr,
+			      unsigned long *config)
+{
+	unsigned int param = pinconf_to_config_param(*config);
+	unsigned int arg = 0;
+
+	switch (param) {
+	default:
+		return -ENOTSUPP;
+	}
+
+	*config = pinconf_to_config_packed(param, arg);
+	return 0;
+}
+
+static int rtd_pin_config_set(struct pinctrl_dev *pcdev, unsigned int pinnr,
+			      unsigned long *configs, unsigned int num_configs)
+{
+	struct rtd_pinctrl *data = pinctrl_dev_get_drvdata(pcdev);
+	int i;
+	int ret = 0;
+
+	for (i = 0; i < num_configs; i++) {
+		ret = rtd_pconf_parse_conf(data, pinnr,
+					   pinconf_to_config_param(configs[i]),
+					   pinconf_to_config_argument(configs[i]));
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int rtd_pin_config_group_set(struct pinctrl_dev *pcdev, unsigned int group,
+				    unsigned long *configs, unsigned int num_configs)
+{
+	struct rtd_pinctrl *data = pinctrl_dev_get_drvdata(pcdev);
+	const unsigned int *pins;
+	unsigned int num_pins;
+	const char *group_name;
+	int i, ret;
+
+	group_name = data->info->groups[group].name;
+
+	ret = rtd_pinctrl_get_group_pins(pcdev, group, &pins, &num_pins);
+	if (ret) {
+		dev_err(pcdev->dev, "Getting pins for group %s failed\n", group_name);
+		return ret;
+	}
+
+	for (i = 0; i < num_pins; i++) {
+		ret = rtd_pin_config_set(pcdev, pins[i], configs, num_configs);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct pinconf_ops rtd_pinconf_ops = {
+	.is_generic = true,
+	.pin_config_get = rtd_pin_config_get,
+	.pin_config_set = rtd_pin_config_set,
+	.pin_config_group_set = rtd_pin_config_group_set,
+};
+
+static struct regmap_config rtd_pinctrl_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.use_relaxed_mmio = true,
+};
+
+int rtd_pinctrl_probe(struct platform_device *pdev, const struct rtd_pinctrl_desc *desc)
+{
+	struct rtd_pinctrl *data;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->base = of_iomap(pdev->dev.of_node, 0);
+	if (IS_ERR(data->base))
+		return PTR_ERR(data->base);
+
+	data->dev = &pdev->dev;
+	data->info = desc;
+	data->desc.name = dev_name(&pdev->dev);
+	data->desc.pins = data->info->pins;
+	data->desc.npins = data->info->num_pins;
+	data->desc.pctlops = &rtd_pinctrl_ops;
+	data->desc.pmxops = &rtd_pinmux_ops;
+	data->desc.confops = &rtd_pinconf_ops;
+	data->desc.custom_params = rtd_custom_bindings;
+	data->desc.num_custom_params = ARRAY_SIZE(rtd_custom_bindings);
+	data->desc.owner = THIS_MODULE;
+	data->regmap_pinctrl = devm_regmap_init_mmio(data->dev, data->base,
+						     &rtd_pinctrl_regmap_config);
+
+	if (IS_ERR(data->regmap_pinctrl)) {
+		dev_err(data->dev, "failed to init regmap: %ld\n",
+			PTR_ERR(data->regmap_pinctrl));
+		return PTR_ERR(data->regmap_pinctrl);
+	}
+
+	data->pcdev = pinctrl_register(&data->desc, &pdev->dev, data);
+	if (!data->pcdev)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, data);
+
+	dev_dbg(&pdev->dev, "probed\n");
+
+	return 0;
+}
+EXPORT_SYMBOL(rtd_pinctrl_probe);
+
+MODULE_DESCRIPTION("Realtek DHC SoC pinctrl driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/realtek/pinctrl-rtd.h b/drivers/pinctrl/realtek/pinctrl-rtd.h
new file mode 100644
index 000000000000..e15130896abc
--- /dev/null
+++ b/drivers/pinctrl/realtek/pinctrl-rtd.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2023 Realtek Semiconductor Corp.
+ */
+
+#define NA 0xffffffff
+#define PADDRI_4_8 1
+#define PADDRI_2_4 0
+
+struct rtd_pin_group_desc {
+	const char *name;
+	const unsigned int *pins;
+	unsigned int num_pins;
+};
+
+struct rtd_pin_func_desc {
+	const char *name;
+	const char * const *groups;
+	unsigned int num_groups;
+};
+
+struct rtd_pin_mux_desc {
+	const char *name;
+	u32 mux_value;
+};
+
+struct rtd_pin_config_desc {
+	const char *name;
+	unsigned int reg_offset;
+	unsigned int base_bit;
+	unsigned int pud_en_offset;
+	unsigned int pud_sel_offset;
+	unsigned int curr_offset;
+	unsigned int smt_offset;
+	unsigned int power_offset;
+	unsigned int curr_type;
+};
+
+struct rtd_pin_sconfig_desc {
+	const char *name;
+	unsigned int reg_offset;
+	unsigned int dcycle_offset;
+	unsigned int dcycle_maskbits;
+	unsigned int ndrive_offset;
+	unsigned int ndrive_maskbits;
+	unsigned int pdrive_offset;
+	unsigned int pdrive_maskbits;
+};
+
+struct rtd_pin_desc {
+	const char *name;
+	unsigned int mux_offset;
+	u32 mux_mask;
+	const struct rtd_pin_mux_desc *functions;
+};
+
+struct rtd_pin_reg_list {
+	unsigned int reg_offset;
+	unsigned int val;
+};
+
+#define SHIFT_LEFT(_val, _shift) ((_val) << (_shift))
+
+#define RTK_PIN_MUX(_name, _mux_off, _mux_mask, ...) \
+	{ \
+		.name = # _name, \
+		.mux_offset = _mux_off, \
+		.mux_mask = _mux_mask, \
+		.functions = (const struct rtd_pin_mux_desc []) { \
+			__VA_ARGS__, { } \
+		}, \
+	}
+
+#define RTK_PIN_CONFIG(_name, _reg_off, _base_bit, _pud_en_off, \
+		       _pud_sel_off, _curr_off, _smt_off, _pow_off, _curr_type) \
+	{ \
+		.name = # _name, \
+		.reg_offset = _reg_off, \
+		.base_bit = _base_bit, \
+		.pud_en_offset = _pud_en_off, \
+		.pud_sel_offset = _pud_sel_off, \
+		.curr_offset = _curr_off, \
+		.smt_offset = _smt_off, \
+		.power_offset = _pow_off, \
+		.curr_type = _curr_type, \
+	}
+
+#define RTK_PIN_SCONFIG(_name, _reg_off, _d_offset, _d_mask, \
+			_n_offset, _n_mask, _p_offset, _p_mask) \
+	{ \
+		.name = # _name, \
+		.reg_offset = _reg_off, \
+		.dcycle_offset = _d_offset, \
+		.dcycle_maskbits = _d_mask, \
+		.ndrive_offset = _n_offset, \
+		.ndrive_maskbits = _n_mask, \
+		.pdrive_offset = _p_offset, \
+		.pdrive_maskbits = _p_mask, \
+	}
+
+#define RTK_PIN_FUNC(_mux_val, _name) \
+	{ \
+		.name = _name, \
+		.mux_value = _mux_val, \
+	}
+
+struct rtd_pinctrl_desc {
+	const struct pinctrl_pin_desc *pins;
+	unsigned int num_pins;
+	const struct rtd_pin_group_desc *groups;
+	unsigned int num_groups;
+	const struct rtd_pin_func_desc *functions;
+	unsigned int num_functions;
+	const struct rtd_pin_desc *muxes;
+	unsigned int num_muxes;
+	const struct rtd_pin_config_desc *configs;
+	unsigned int num_configs;
+	const struct rtd_pin_sconfig_desc *sconfigs;
+	unsigned int num_sconfigs;
+	struct rtd_pin_reg_list *lists;
+	unsigned int num_regs;
+};
+
+int rtd_pinctrl_probe(struct platform_device *pdev, const struct rtd_pinctrl_desc *desc);
-- 
2.42.0

