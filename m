Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351537A1510
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjIOFCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjIOFCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:02:03 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DF02720;
        Thu, 14 Sep 2023 22:01:55 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 8C56A424B0;
        Fri, 15 Sep 2023 10:01:51 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1694754112; bh=49MaGxNQqyAPhOgveIuAGVdV6GmbhsB4KycALCG40Ns=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=iDiDsx1m068luOVjQClVdWY2bJdlgk4nUzBHYhT71OHfXnef7REhdtdLRm0G90THh
         QdfLb8AVZLxT6k+tdkTRHQzp6FcJU5Q6oE51nGKLyjtVdU/Jt45PqdWjOzEkFHSbip
         mudzeH4zUGo/e334iXB3lOWryIvfPnerIwaUfAqVOVTxLiDMEawk2e63kTb1aHwW7x
         6h9Yrs6ItEP3gmxXVN3xnIsxirKDbCrhvTGOdsH1AZZTA19twVpMX9b/mdvgeQlprx
         eHtSOtFYBfTEjy8TTc7hPuVPS6/DtkR/NGgAESYcbADkEoisOGPqfrkVouzbZgC7Np
         sfiaDA5fFo7tg==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Fri, 15 Sep 2023 10:01:21 +0500
Subject: [PATCH v3 4/4] power: supply: Add driver for pm8916 lbc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-pm8916-bms-lbc-v3-4-f30881e951a0@trvn.ru>
References: <20230915-pm8916-bms-lbc-v3-0-f30881e951a0@trvn.ru>
In-Reply-To: <20230915-pm8916-bms-lbc-v3-0-f30881e951a0@trvn.ru>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=13852; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=49MaGxNQqyAPhOgveIuAGVdV6GmbhsB4KycALCG40Ns=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlA+U7xqFwtrvgnaPf9znUOoIED+nLJnMDFVlni
 wrnoh/H61uJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZQPlOwAKCRBDHOzuKBm/
 dVKmEACStgqDq6p2UvOMcGb5V8AhZUAsrUqApHzvDgIqZaxXvkv7Z0MMMFuR1wfC6mOHmCSJz9L
 no9VR8fZaZ3VH0jUu5TYvxV/GHuTqyfI0pgFiAaVEQedNjTWG+FB1sWg9QOo0UdxoMdsrqlOCI/
 JsH792mxSpF6FjDjAD0GuVBLI8zDOn+Zad8VDoTQ1B01/Hsn1aH7P1IEFLHcEwmhKH7TMcDOPvM
 1GNOWcLbs29gzeJeuMoNrnO65t87Yee/ImroFoKwepnhr5xZQ5TxN6sUEYhBmhqCx99gNOLMook
 3LvR1OWYf1VQ7wMOnIlWRCp/lEo8/aXAXURhOgPC/V6Tqx5Ln7R5q+zK14PG9czMI3yRMtcc1Yx
 L8e+iu9whjKs8gI6eWLFGEge38xkDtaxwOSBr5GJUi4uhBLLKICZcZ8E6ObtD8RKjus+p1jEDl7
 pMVmkcZUL15l+tPbj9V8CI2KNbg3hxbVphVzfcDXKN5YO7k1++mp5lsfPN26cQhSv2S0/CXT0BC
 SU+EOb1rAhBSGTQDud/f8bjO2l+OziJfC5xkP6xw3QqejVLJP/MGhXroaAAlHnoARxjGs1bPwV6
 Sf8XlM+hYCHiuuHPbupeWuGRdZ/54cZkLlZXcSmMV7xOPzc3ip9iScWFuKlnhGpz/IJ7C6cJhys
 s589nn4l1J5auvg==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
v3: INPUT_CURRENT_LIMIT -> CONSTANT_CHARGE_CURRENT, use device_property_*
---
 drivers/power/supply/Kconfig      |  11 ++
 drivers/power/supply/Makefile     |   1 +
 drivers/power/supply/pm8916_lbc.c | 381 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 393 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index c6375c03e5ce..95e296b80550 100644
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
index 000000000000..6d92e98cbecc
--- /dev/null
+++ b/drivers/power/supply/pm8916_lbc.c
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Nikita Travkin <nikita@trvn.ru>
+ */
+
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/extcon-provider.h>
+#include <linux/mod_devicetable.h>
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
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
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
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
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
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static enum power_supply_property pm8916_lbc_charger_properties[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
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
+	int ret = 0;
+	unsigned int tmp;
+
+	ret = device_property_read_u32(dev, "qcom,fast-charge-safe-voltage", &chg->charge_voltage_safe);
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
+	ret = device_property_read_u32(dev, "qcom,fast-charge-safe-current", &chg->charge_current_safe);
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
+	len = device_property_count_u32(dev, "reg");
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
+	ret = device_property_read_u32_array(dev, "reg", chg->reg, len);
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
+	{}
+};
+MODULE_DEVICE_TABLE(of, pm8916_lbc_charger_of_match);
+
+static struct platform_driver pm8916_lbc_charger_driver = {
+	.driver = {
+		.name = "pm8916-lbc",
+		.of_match_table = pm8916_lbc_charger_of_match,
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

