Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FB5769F35
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjGaRQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjGaRPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:15:34 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C0F3C07;
        Mon, 31 Jul 2023 10:13:17 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id D73254244A;
        Mon, 31 Jul 2023 22:06:45 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1690823206; bh=XnE0sBmGyTeS42aQNFh0ggmPeJzYQmEk9QgohtuCRQY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=SovFyxs/p6Rl02tiHmcku3EajmXrDt2USXkn12ksatcXx7YKJUbO/wx0f4CIlmlPm
         Bp8XbRe8mPETCdY/GDMlVwOnDN/CLPkNGmFpYwLcsM0uVlHp0jbumPiT3twFXs1rwv
         j1esr/GRPWWCVC68sOgx7gFHo6H4Cs99MWz9argwhtRxXRXCyIaOyH94ZPCvvJFReU
         v1a1f8D/WAC9yItYq6IViqzoL/JTWGvR7xqASCTChPqMa3dv8GPzs20w/tgkAqoeB2
         jh+27p0I/ZLQFCyyNZW/yqILmSGUDxMFxcxlGUxaRpMqM/ezrd/ntF3ym2r/E/3+2y
         0COd3iQu55/3g==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Mon, 31 Jul 2023 22:06:27 +0500
Subject: [PATCH v2 4/4] power: supply: Add driver for pm8916 lbc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-pm8916-bms-lbc-v2-4-82a4ebb39c16@trvn.ru>
References: <20230731-pm8916-bms-lbc-v2-0-82a4ebb39c16@trvn.ru>
In-Reply-To: <20230731-pm8916-bms-lbc-v2-0-82a4ebb39c16@trvn.ru>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=13843; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=XnE0sBmGyTeS42aQNFh0ggmPeJzYQmEk9QgohtuCRQY=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBkx+ojQWxmgpl5jl/vvGlQU8L64kJgMCrRAiXsh
 43C7KLFHrCJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZMfqIwAKCRBDHOzuKBm/
 dSo0D/4nNnEk4ZhGX9u2z5yUmhAEkNmqM+iI/sA8C7j3NUWGlqXM2HP6BAHj52DSdiuzpKyzuhp
 O+XNUKSUyQZAf1LaGw5yYvC2lKKhIEUqq+pmIxqcpGi/Gk4Vq5VWf3ppACDnDw6B7SLnCYcrjfK
 Frl12/u1vmLFz5a1FAwP2CiFhzKd3NqQFYjcNx6HvZOPLnhVAmyA/h6Kr0JrYwSVfFFaMUqhb9y
 rXk46xMuWhYBfcs7cxFqCama7EoVQQ3KxYRmhPGR4re5spOqODHTdCKiCWu8SRrPnN1jAxFmzFM
 RUUt37F+HrUzmBhAe7P4AvHQYhAG3cm42p3k+CTUf5TKGrK7pfEDQluiyxtisuoZFDRX+GQqjnZ
 n2LkXUJdIrLxX5zgTMWbgrR5KdJ1bCUtRRgmwDtj+Eu2K80/VagVDP8GSqo35OrLpzO8se0DoC7
 llOPiW0EMxdzgUDvSZPH1FVFV5juhAJyBb8T8JHv5KHaeyZQmdCnoc7ZkcgWjKLpf8d0e3kI8Fg
 QQ+98oSiHg4glL96/iS2KWgVWd2vt8m3anguEhOgXIyXHbPwKBMpVP5iDnkSqTRRDOOrfR3zFts
 qJE4NKwqIMVF0sg9L3nnkOl6+4Qp1as933DDGr9+Bk54i66uV6OcjA7koQcvIKacwOaqNNydF6P
 PCLe7ZrnN5nhXsg==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm8916 LBC is a Linear Battery Charger hardware block in pm8916 PMIC.

This block implements simple CC/CV charging for Li-Po batteries.
The hardware has internal state machine to switch between modes and
works mostly autonomously, only needing the limits and targets to be
set to operate.

This driver allows setting limits and enabling the LBC block, monitoring
it's state.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
v2: Fix missed warnings, get irq by name
---
 drivers/power/supply/Kconfig      |  11 ++
 drivers/power/supply/Makefile     |   1 +
 drivers/power/supply/pm8916_lbc.c | 383 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 395 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index e93a5a4d03e2..a2ea249a57c6 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -640,6 +640,17 @@ config BATTERY_PM8916_BMS_VM
 	  To compile this driver as module, choose M here: the
 	  module will be called pm8916_bms_vm.
 
+config CHARGER_PM8916_LBC
+	tristate "Qualcomm PM8916 Linear Battery Charger support"
+	depends on MFD_SPMI_PMIC || COMPILE_TEST
+	help
+	  Say Y here to add support for Linear Battery Charger block
+	  found in some Qualcomm PMICs such as PM8916. This hardware
+	  blokc provides simple CC/CV battery charger.
+
+	  To compile this driver as module, choose M here: the
+	  module will be called pm8916_lbc.
+
 config CHARGER_BQ2415X
 	tristate "TI BQ2415x battery charger driver"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index fdf7916f80ed..e4bd9eb1261b 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_CHARGER_MT6360)	+= mt6360_charger.o
 obj-$(CONFIG_CHARGER_MT6370)	+= mt6370-charger.o
 obj-$(CONFIG_CHARGER_QCOM_SMBB)	+= qcom_smbb.o
 obj-$(CONFIG_BATTERY_PM8916_BMS_VM)	+= pm8916_bms_vm.o
+obj-$(CONFIG_CHARGER_PM8916_LBC)	+= pm8916_lbc.o
 obj-$(CONFIG_CHARGER_BQ2415X)	+= bq2415x_charger.o
 obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
 obj-$(CONFIG_CHARGER_BQ24257)	+= bq24257_charger.o
diff --git a/drivers/power/supply/pm8916_lbc.c b/drivers/power/supply/pm8916_lbc.c
new file mode 100644
index 000000000000..490cb7064dbf
--- /dev/null
+++ b/drivers/power/supply/pm8916_lbc.c
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Nikita Travkin <nikita@trvn.ru>
+ */
+
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/extcon-provider.h>
+
+/* Two bytes: type + subtype */
+#define PM8916_PERPH_TYPE 0x04
+#define PM8916_LBC_CHGR_TYPE 0x1502
+#define PM8916_LBC_BAT_IF_TYPE 0x1602
+#define PM8916_LBC_USB_TYPE 0x1702
+#define PM8916_LBC_MISC_TYPE 0x1802
+
+#define PM8916_LBC_CHGR_CHG_OPTION 0x08
+#define PM8916_LBC_CHGR_PMIC_CHARGER BIT(7)
+
+#define PM8916_LBC_CHGR_CHG_STATUS 0x09
+
+#define PM8916_INT_RT_STS 0x10
+
+#define PM8916_LBC_USB_USBIN_VALID BIT(1)
+
+#define PM8916_LBC_CHGR_VDD_MAX 0x40
+#define PM8916_LBC_CHGR_VDD_SAFE 0x41
+#define PM8916_LBC_CHGR_IBAT_MAX 0x44
+#define PM8916_LBC_CHGR_IBAT_SAFE 0x45
+
+#define PM8916_LBC_CHGR_TCHG_MAX_EN 0x60
+#define PM8916_LBC_CHGR_TCHG_MAX_ENABLED BIT(7)
+#define PM8916_LBC_CHGR_TCHG_MAX 0x61
+
+#define PM8916_LBC_CHGR_CHG_CTRL 0x49
+#define PM8916_LBC_CHGR_CHG_EN BIT(7)
+#define PM8916_LBC_CHGR_PSTG_EN BIT(5)
+
+#define PM8916_LBC_CHGR_MIN_CURRENT 90000
+#define PM8916_LBC_CHGR_MAX_CURRENT 1440000
+
+#define PM8916_LBC_CHGR_MIN_VOLTAGE 4000000
+#define PM8916_LBC_CHGR_MAX_VOLTAGE 4775000
+#define PM8916_LBC_CHGR_VOLTAGE_STEP 25000
+
+#define PM8916_LBC_CHGR_MIN_TIME 4
+#define PM8916_LBC_CHGR_MAX_TIME 256
+
+struct pm8916_lbc_charger {
+	struct device *dev;
+	struct extcon_dev *edev;
+	struct power_supply *charger;
+	struct power_supply_battery_info *info;
+	struct regmap *regmap;
+	unsigned int reg[4];
+	bool online;
+	unsigned int charge_voltage_max;
+	unsigned int charge_voltage_safe;
+	unsigned int charge_current_max;
+	unsigned int charge_current_safe;
+};
+
+static const unsigned int pm8916_lbc_charger_cable[] = {
+	EXTCON_USB,
+	EXTCON_NONE,
+};
+
+enum {
+	LBC_CHGR = 0,
+	LBC_BAT_IF,
+	LBC_USB,
+	LBC_MISC,
+};
+
+static int pm8916_lbc_charger_configure(struct pm8916_lbc_charger *chg)
+{
+	int ret = 0;
+	unsigned int tmp;
+
+	chg->charge_voltage_max = clamp_t(u32, chg->charge_voltage_max,
+					  PM8916_LBC_CHGR_MIN_VOLTAGE, chg->charge_voltage_safe);
+
+	tmp = chg->charge_voltage_max - PM8916_LBC_CHGR_MIN_VOLTAGE;
+	tmp /= PM8916_LBC_CHGR_VOLTAGE_STEP;
+	chg->charge_voltage_max = PM8916_LBC_CHGR_MIN_VOLTAGE + tmp * PM8916_LBC_CHGR_VOLTAGE_STEP;
+
+	ret = regmap_write(chg->regmap, chg->reg[LBC_CHGR] + PM8916_LBC_CHGR_VDD_MAX, tmp);
+	if (ret)
+		goto error;
+
+	chg->charge_current_max = min(chg->charge_current_max, chg->charge_current_safe);
+
+	tmp = clamp_t(u32, chg->charge_current_max,
+		      PM8916_LBC_CHGR_MIN_CURRENT, PM8916_LBC_CHGR_MAX_CURRENT);
+
+	tmp = chg->charge_current_max / PM8916_LBC_CHGR_MIN_CURRENT - 1;
+	chg->charge_current_max = (tmp + 1) * PM8916_LBC_CHGR_MIN_CURRENT;
+
+	ret = regmap_write(chg->regmap, chg->reg[LBC_CHGR] + PM8916_LBC_CHGR_IBAT_MAX, tmp);
+	if (ret)
+		goto error;
+
+	ret = regmap_write(chg->regmap, chg->reg[LBC_CHGR] + PM8916_LBC_CHGR_CHG_CTRL,
+			   PM8916_LBC_CHGR_CHG_EN | PM8916_LBC_CHGR_PSTG_EN);
+	if (ret)
+		goto error;
+
+	return ret;
+
+error:
+	dev_err(chg->dev, "Failed to configure charging: %pe\n", ERR_PTR(ret));
+	return ret;
+}
+
+static int pm8916_lbc_charger_get_property(struct power_supply *psy,
+					   enum power_supply_property psp,
+					   union power_supply_propval *val)
+{
+	struct pm8916_lbc_charger *chg = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = chg->online;
+		return 0;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		val->intval = chg->charge_voltage_max;
+		return 0;
+
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		val->intval = chg->charge_current_max;
+		return 0;
+
+	default:
+		return -EINVAL;
+	};
+}
+
+static int pm8916_lbc_charger_set_property(struct power_supply *psy,
+					   enum power_supply_property prop,
+					   const union power_supply_propval *val)
+{
+	struct pm8916_lbc_charger *chg = power_supply_get_drvdata(psy);
+
+	switch (prop) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		chg->charge_current_max = val->intval;
+		return pm8916_lbc_charger_configure(chg);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int pm8916_lbc_charger_property_is_writeable(struct power_supply *psy,
+						    enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static enum power_supply_property pm8916_lbc_charger_properties[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+};
+
+static irqreturn_t pm8916_lbc_charger_state_changed_irq(int irq, void *data)
+{
+	struct pm8916_lbc_charger *chg = data;
+	unsigned int tmp;
+	int ret;
+
+	ret = regmap_read(chg->regmap, chg->reg[LBC_USB] + PM8916_INT_RT_STS, &tmp);
+	if (ret)
+		return IRQ_HANDLED;
+
+	chg->online = !!(tmp & PM8916_LBC_USB_USBIN_VALID);
+	extcon_set_state_sync(chg->edev, EXTCON_USB, chg->online);
+
+	power_supply_changed(chg->charger);
+
+	return IRQ_HANDLED;
+}
+
+static int pm8916_lbc_charger_probe_dt(struct pm8916_lbc_charger *chg)
+{
+	struct device *dev = chg->dev;
+	struct device_node *np = dev->of_node;
+	int ret = 0;
+	unsigned int tmp;
+
+	ret = of_property_read_u32(np, "qcom,fast-charge-safe-voltage", &chg->charge_voltage_safe);
+	if (ret)
+		return ret;
+	if (chg->charge_voltage_safe < PM8916_LBC_CHGR_MIN_VOLTAGE)
+		return -EINVAL;
+
+	chg->charge_voltage_safe = clamp_t(u32, chg->charge_voltage_safe,
+					PM8916_LBC_CHGR_MIN_VOLTAGE, PM8916_LBC_CHGR_MAX_VOLTAGE);
+
+	tmp = chg->charge_voltage_safe - PM8916_LBC_CHGR_MIN_VOLTAGE;
+	tmp /= PM8916_LBC_CHGR_VOLTAGE_STEP;
+	ret = regmap_write(chg->regmap, chg->reg[LBC_CHGR] + PM8916_LBC_CHGR_VDD_SAFE, tmp);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32(np, "qcom,fast-charge-safe-current", &chg->charge_current_safe);
+	if (ret)
+		return ret;
+	if (chg->charge_current_safe < PM8916_LBC_CHGR_MIN_CURRENT)
+		return -EINVAL;
+
+	chg->charge_current_safe = clamp_t(u32, chg->charge_current_safe,
+					PM8916_LBC_CHGR_MIN_CURRENT, PM8916_LBC_CHGR_MAX_CURRENT);
+
+	chg->charge_current_max = chg->charge_current_safe;
+
+	tmp = chg->charge_current_safe / PM8916_LBC_CHGR_MIN_CURRENT - 1;
+	ret = regmap_write(chg->regmap, chg->reg[LBC_CHGR] + PM8916_LBC_CHGR_IBAT_SAFE, tmp);
+	if (ret)
+		return ret;
+
+	/* Disable charger timeout. */
+	ret = regmap_write(chg->regmap, chg->reg[LBC_CHGR] + PM8916_LBC_CHGR_TCHG_MAX_EN, 0x00);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static const struct power_supply_desc pm8916_lbc_charger_psy_desc = {
+	.name = "pm8916-lbc-chgr",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.properties = pm8916_lbc_charger_properties,
+	.num_properties = ARRAY_SIZE(pm8916_lbc_charger_properties),
+	.get_property = pm8916_lbc_charger_get_property,
+	.set_property = pm8916_lbc_charger_set_property,
+	.property_is_writeable = pm8916_lbc_charger_property_is_writeable,
+};
+
+static int pm8916_lbc_charger_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pm8916_lbc_charger *chg;
+	struct power_supply_config psy_cfg = {};
+	int ret, len, irq;
+	unsigned int tmp;
+
+	chg = devm_kzalloc(dev, sizeof(*chg), GFP_KERNEL);
+	if (!chg)
+		return -ENOMEM;
+
+	chg->dev = dev;
+
+	chg->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!chg->regmap)
+		return -ENODEV;
+
+	len = of_property_count_u32_elems(dev->of_node, "reg");
+	if (len < 0)
+		return len;
+	if (len != 4)
+		return dev_err_probe(dev, -EINVAL,
+				     "Wrong amount of reg values: %d (4 expected)\n", len);
+
+	irq = platform_get_irq_byname(pdev, "usb_vbus");
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_lbc_charger_state_changed_irq,
+					IRQF_ONESHOT, "pm8916_lbc", chg);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32_array(dev->of_node, "reg", chg->reg, len);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(chg->regmap, chg->reg[LBC_CHGR] + PM8916_PERPH_TYPE, &tmp, 2);
+	if (ret)
+		goto comm_error;
+	if (tmp != PM8916_LBC_CHGR_TYPE)
+		goto type_error;
+
+	ret = regmap_bulk_read(chg->regmap, chg->reg[LBC_BAT_IF] + PM8916_PERPH_TYPE, &tmp, 2);
+	if (ret)
+		goto comm_error;
+	if (tmp != PM8916_LBC_BAT_IF_TYPE)
+		goto type_error;
+
+	ret = regmap_bulk_read(chg->regmap, chg->reg[LBC_USB] + PM8916_PERPH_TYPE, &tmp, 2);
+	if (ret)
+		goto comm_error;
+	if (tmp != PM8916_LBC_USB_TYPE)
+		goto type_error;
+
+	ret = regmap_bulk_read(chg->regmap, chg->reg[LBC_MISC] + PM8916_PERPH_TYPE, &tmp, 2);
+	if (ret)
+		goto comm_error;
+	if (tmp != PM8916_LBC_MISC_TYPE)
+		goto type_error;
+
+	ret = regmap_read(chg->regmap, chg->reg[LBC_CHGR] + PM8916_LBC_CHGR_CHG_OPTION, &tmp);
+	if (ret)
+		goto comm_error;
+	if (tmp != PM8916_LBC_CHGR_PMIC_CHARGER)
+		dev_err_probe(dev, -ENODEV, "The system is using an external charger\n");
+
+	ret = pm8916_lbc_charger_probe_dt(chg);
+	if (ret)
+		dev_err_probe(dev, ret, "Error while parsing device tree\n");
+
+	psy_cfg.drv_data = chg;
+	psy_cfg.of_node = dev->of_node;
+
+	chg->charger = devm_power_supply_register(dev, &pm8916_lbc_charger_psy_desc, &psy_cfg);
+	if (IS_ERR(chg->charger))
+		return dev_err_probe(dev, PTR_ERR(chg->charger), "Unable to register charger\n");
+
+	ret = power_supply_get_battery_info(chg->charger, &chg->info);
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to get battery info\n");
+
+	chg->edev = devm_extcon_dev_allocate(dev, pm8916_lbc_charger_cable);
+	if (IS_ERR(chg->edev))
+		return PTR_ERR(chg->edev);
+
+	ret = devm_extcon_dev_register(dev, chg->edev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to register extcon device\n");
+
+	ret = regmap_read(chg->regmap, chg->reg[LBC_USB] + PM8916_INT_RT_STS, &tmp);
+	if (ret)
+		goto comm_error;
+
+	chg->online = !!(tmp & PM8916_LBC_USB_USBIN_VALID);
+	extcon_set_state_sync(chg->edev, EXTCON_USB, chg->online);
+
+	chg->charge_voltage_max = chg->info->voltage_max_design_uv;
+	ret = pm8916_lbc_charger_configure(chg);
+	if (ret)
+		return ret;
+
+	return 0;
+
+comm_error:
+	return dev_err_probe(dev, ret, "Unable to communicate with device\n");
+
+type_error:
+	return dev_err_probe(dev, -ENODEV, "Device reported wrong type: 0x%X\n", tmp);
+}
+
+static const struct of_device_id pm8916_lbc_charger_of_match[] = {
+	{ .compatible = "qcom,pm8916-lbc", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, pm8916_lbc_charger_of_match);
+
+static struct platform_driver pm8916_lbc_charger_driver = {
+	.driver = {
+		.name = "pm8916-lbc",
+		.of_match_table = of_match_ptr(pm8916_lbc_charger_of_match),
+	},
+	.probe = pm8916_lbc_charger_probe,
+};
+module_platform_driver(pm8916_lbc_charger_driver);
+
+MODULE_DESCRIPTION("pm8916 LBC driver");
+MODULE_AUTHOR("Nikita Travkin <nikita@trvn.ru>");
+MODULE_LICENSE("GPL");

-- 
2.41.0

