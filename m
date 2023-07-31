Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573C2769F09
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjGaRLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjGaRLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:11:22 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED2835A8;
        Mon, 31 Jul 2023 10:07:45 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 63BA242449;
        Mon, 31 Jul 2023 22:06:45 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1690823205; bh=dy9OhMPgkv6mGaKpif4r7aV9aD//zp0p5RkNyfGYR+A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=oWj7Eyi/CEh6yi6Gmr6BQDs2NOs7EV3adkYoy4k/Il2oWQWDcs81Ifcrb3acRZDFa
         Ur9CIBRJ3foEU5q5uYmgkH9meAiJ9qhLXFTbus8qf/i+yOm88LUIxiC5TOm7j1rFPw
         ADcSlihPqXx8POzbRzgKmWSGYw/HmfNkemKRb6M9W4EKbeS1QT6+XAloJLIp+4lo4f
         6B/KDc6dl3ORPpoOBdcYnm3d3b+MXvricsgD/b5M1bIU4XdSrv++aPorJSKb15ALmo
         wHYHwVEtX4zQo7t39sk2cIVxBzPu2gVsSfrceMlznlTiOFXkyTo33om0YCQFsysRhn
         euCokZA1WfRAA==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Mon, 31 Jul 2023 22:06:26 +0500
Subject: [PATCH v2 3/4] power: supply: Add pm8916 VM-BMS support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-pm8916-bms-lbc-v2-3-82a4ebb39c16@trvn.ru>
References: <20230731-pm8916-bms-lbc-v2-0-82a4ebb39c16@trvn.ru>
In-Reply-To: <20230731-pm8916-bms-lbc-v2-0-82a4ebb39c16@trvn.ru>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=11200; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=dy9OhMPgkv6mGaKpif4r7aV9aD//zp0p5RkNyfGYR+A=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBkx+oijQMpAqRsd5huFWQ1WCdzFVTIFnMUmFNr9
 q/TYsyF2kaJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZMfqIgAKCRBDHOzuKBm/
 dcfOD/0Twat822cuHAN8g+gWaVO4B9OzlmvPAi1qnrwoHYIoRS8xwsUn9x07rRm4mZt5ZOhaziF
 9ehBhZp1xn9+58pbeN/PYB5nZmjrDkmejinGTv0aA1xJo3hhoadQKGB98iDHKS7cOpgmbH4XN8O
 cQrtiOqcEapfeHMTlfln8iO8dExONjCtmzWIAGPRF4uMkNPK7kizvJASxn8tlzcTD8PWIdxmega
 DfOASjDYt+maY4r7weTxiwOHGpT4KbU3FD0cqHcy5h3QxcECdmVpxvf2+YuoPKFZ4LPjsgRbauz
 nMEwHfXLf2f9jhOp+W+eU97n9ke+GuL92R/GtP5n9F/p4wOxpMKG4wLZpc7RK6XYm6UjnxSGgl0
 m1bp6x3QTbpW1B/tC88W9haB+UI2hcEzoO6kGoX5GmRbF+HAfR66fiT451Uusa1BvM6ZVOxMJz2
 9JlmKqH+ciJu5PgoYbjcw6uP5ZfcGI5SHPHo9WbXsaOtcXT4geZtP4oDhKg6xOlDekgUtHw3cwc
 FlDZV1RRoCHGTUjvBz3wiqhAmBBSp/vPXdwQWv/J4o+/XKhdvvwCk7lo72uf6tY2k6zQc9SXOmu
 LH9XS20S64akP9VwgMY9Yk5r9y8bURsWUA3DxK/C3dtwqRHChkNKl2jiaGFa6ga6U1WRErgiI5c
 MssAei7oBl4GvDw==
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

This driver adds basic support for VM-BMS found in pm8916.

VM-BMS is a very basic fuel-gauge hardware block that is, sadly,
incapable of any gauging. The hardware supports measuring OCV in
sleep mode, where the battery is not in use, or measuring average
voltage over time when the device is active.

This driver implements basic value readout from this block.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
v2: Get irq by name
---
 drivers/power/supply/Kconfig         |  11 ++
 drivers/power/supply/Makefile        |   1 +
 drivers/power/supply/pm8916_bms_vm.c | 296 +++++++++++++++++++++++++++++++++++
 3 files changed, 308 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 663a1c423806..e93a5a4d03e2 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -629,6 +629,17 @@ config CHARGER_QCOM_SMBB
 	  documentation for more detail.  The base name for this driver is
 	  'pm8941_charger'.
 
+config BATTERY_PM8916_BMS_VM
+	tristate "Qualcomm PM8916 BMS-VM support"
+	depends on MFD_SPMI_PMIC || COMPILE_TEST
+	help
+	  Say Y to add support for Voltage Mode BMS block found in some
+	  Qualcomm PMICs such as PM8916. This hardware block provides
+	  battery voltage monitoring for the system.
+
+	  To compile this driver as module, choose M here: the
+	  module will be called pm8916_bms_vm.
+
 config CHARGER_BQ2415X
 	tristate "TI BQ2415x battery charger driver"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index a8a9fa6de1e9..fdf7916f80ed 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_CHARGER_MP2629)	+= mp2629_charger.o
 obj-$(CONFIG_CHARGER_MT6360)	+= mt6360_charger.o
 obj-$(CONFIG_CHARGER_MT6370)	+= mt6370-charger.o
 obj-$(CONFIG_CHARGER_QCOM_SMBB)	+= qcom_smbb.o
+obj-$(CONFIG_BATTERY_PM8916_BMS_VM)	+= pm8916_bms_vm.o
 obj-$(CONFIG_CHARGER_BQ2415X)	+= bq2415x_charger.o
 obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
 obj-$(CONFIG_CHARGER_BQ24257)	+= bq24257_charger.o
diff --git a/drivers/power/supply/pm8916_bms_vm.c b/drivers/power/supply/pm8916_bms_vm.c
new file mode 100644
index 000000000000..6cf00bf1c466
--- /dev/null
+++ b/drivers/power/supply/pm8916_bms_vm.c
@@ -0,0 +1,296 @@
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
+
+#define PM8916_PERPH_TYPE 0x04
+#define PM8916_BMS_VM_TYPE 0x020D
+
+#define PM8916_SEC_ACCESS 0xD0
+#define PM8916_SEC_MAGIC 0xA5
+
+#define PM8916_BMS_VM_STATUS1 0x08
+#define PM8916_BMS_VM_FSM_STATE(x) (((x) & 0b00111000) >> 3)
+#define PM8916_BMS_VM_FSM_STATE_S2 0x2
+
+#define PM8916_BMS_VM_MODE_CTL 0x40
+#define PM8916_BMS_VM_MODE_FORCE_S3 (BIT(0) | BIT(1))
+#define PM8916_BMS_VM_MODE_NORMAL (BIT(1) | BIT(3))
+
+#define PM8916_BMS_VM_EN_CTL 0x46
+#define PM8916_BMS_ENABLED BIT(7)
+
+#define PM8916_BMS_VM_FIFO_LENGTH_CTL 0x47
+#define PM8916_BMS_VM_S1_SAMPLE_INTERVAL_CTL 0x55
+#define PM8916_BMS_VM_S2_SAMPLE_INTERVAL_CTL 0x56
+#define PM8916_BMS_VM_S3_S7_OCV_DATA0 0x6A
+#define PM8916_BMS_VM_BMS_FIFO_REG_0_LSB 0xC0
+
+/* Using only 1 fifo is broken in hardware */
+#define PM8916_BMS_VM_FIFO_COUNT 2 /* 2 .. 8 */
+
+#define PM8916_BMS_VM_S1_SAMPLE_INTERVAL 10
+#define PM8916_BMS_VM_S2_SAMPLE_INTERVAL 10
+
+struct pm8916_bms_vm_battery {
+	struct device *dev;
+	struct power_supply *battery;
+	struct power_supply_battery_info *info;
+	struct regmap *regmap;
+	unsigned int reg;
+	unsigned int last_ocv;
+	unsigned int vbat_now;
+};
+
+static int pm8916_bms_vm_battery_get_property(struct power_supply *psy,
+					      enum power_supply_property psp,
+					      union power_supply_propval *val)
+{
+	struct pm8916_bms_vm_battery *bat = power_supply_get_drvdata(psy);
+	struct power_supply_battery_info *info = bat->info;
+	int supplied;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		supplied = power_supply_am_i_supplied(psy);
+
+		if (supplied < 0 && supplied != -ENODEV)
+			return supplied;
+		else if (supplied && supplied != -ENODEV)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		return 0;
+
+	case POWER_SUPPLY_PROP_HEALTH:
+		if (bat->vbat_now < info->voltage_min_design_uv)
+			val->intval = POWER_SUPPLY_HEALTH_DEAD;
+		else if (bat->vbat_now > info->voltage_max_design_uv)
+			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		else
+			val->intval = POWER_SUPPLY_HEALTH_GOOD;
+		return 0;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = bat->vbat_now;
+		return 0;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_BOOT:
+		/* Returning last known ocv value here - it changes after suspend. */
+		val->intval = bat->last_ocv;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static enum power_supply_property pm8916_bms_vm_battery_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_BOOT,
+	POWER_SUPPLY_PROP_HEALTH,
+};
+
+static irqreturn_t pm8916_bms_vm_fifo_update_done_irq(int irq, void *data)
+{
+	struct pm8916_bms_vm_battery *bat = data;
+	u16 vbat_data[PM8916_BMS_VM_FIFO_COUNT];
+	int ret;
+
+	ret = regmap_bulk_read(bat->regmap, bat->reg + PM8916_BMS_VM_BMS_FIFO_REG_0_LSB,
+			       &vbat_data, PM8916_BMS_VM_FIFO_COUNT * 2);
+	if (ret)
+		return IRQ_HANDLED;
+
+	/*
+	 * The VM-BMS hardware only collects voltage data and the software
+	 * has to process it to calculate the OCV and SoC. Hardware provides
+	 * up to 8 averaged measurements for software to take in account.
+	 *
+	 * Just use the last measured value for now to report the current
+	 * battery voltage.
+	 */
+	bat->vbat_now = vbat_data[PM8916_BMS_VM_FIFO_COUNT - 1] * 300;
+
+	power_supply_changed(bat->battery);
+
+	return IRQ_HANDLED;
+}
+
+static const struct power_supply_desc pm8916_bms_vm_battery_psy_desc = {
+	.name = "pm8916-bms-vm",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = pm8916_bms_vm_battery_properties,
+	.num_properties = ARRAY_SIZE(pm8916_bms_vm_battery_properties),
+	.get_property = pm8916_bms_vm_battery_get_property,
+};
+
+static int pm8916_bms_vm_battery_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pm8916_bms_vm_battery *bat;
+	struct power_supply_config psy_cfg = {};
+	int ret, irq;
+	unsigned int tmp;
+
+	bat = devm_kzalloc(dev, sizeof(*bat), GFP_KERNEL);
+	if (!bat)
+		return -ENOMEM;
+
+	bat->dev = dev;
+
+	bat->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!bat->regmap)
+		return -ENODEV;
+
+	of_property_read_u32(dev->of_node, "reg", &bat->reg);
+	if (bat->reg < 0)
+		return -EINVAL;
+
+	irq = platform_get_irq_byname(pdev, "fifo");
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_bms_vm_fifo_update_done_irq,
+					IRQF_ONESHOT, "pm8916_vm_bms", bat);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(bat->regmap, bat->reg + PM8916_PERPH_TYPE, &tmp, 2);
+	if (ret)
+		goto comm_error;
+
+	if (tmp != PM8916_BMS_VM_TYPE)
+		return dev_err_probe(dev, -ENODEV, "Device reported wrong type: 0x%X\n", tmp);
+
+	ret = regmap_write(bat->regmap, bat->reg + PM8916_BMS_VM_S1_SAMPLE_INTERVAL_CTL,
+			   PM8916_BMS_VM_S1_SAMPLE_INTERVAL);
+	if (ret)
+		goto comm_error;
+	ret = regmap_write(bat->regmap, bat->reg + PM8916_BMS_VM_S2_SAMPLE_INTERVAL_CTL,
+			   PM8916_BMS_VM_S2_SAMPLE_INTERVAL);
+	if (ret)
+		goto comm_error;
+	ret = regmap_write(bat->regmap, bat->reg + PM8916_BMS_VM_FIFO_LENGTH_CTL,
+			   PM8916_BMS_VM_FIFO_COUNT << 4 | PM8916_BMS_VM_FIFO_COUNT);
+	if (ret)
+		goto comm_error;
+	ret = regmap_write(bat->regmap,
+			   bat->reg + PM8916_BMS_VM_EN_CTL, PM8916_BMS_ENABLED);
+	if (ret)
+		goto comm_error;
+
+	ret = regmap_bulk_read(bat->regmap,
+			       bat->reg + PM8916_BMS_VM_S3_S7_OCV_DATA0, &tmp, 2);
+	if (ret)
+		goto comm_error;
+
+	bat->last_ocv = tmp * 300;
+	bat->vbat_now = bat->last_ocv;
+
+	psy_cfg.drv_data = bat;
+	psy_cfg.of_node = dev->of_node;
+
+	bat->battery = devm_power_supply_register(dev, &pm8916_bms_vm_battery_psy_desc, &psy_cfg);
+	if (IS_ERR(bat->battery))
+		return dev_err_probe(dev, PTR_ERR(bat->battery), "Unable to register battery\n");
+
+	ret = power_supply_get_battery_info(bat->battery, &bat->info);
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to get battery info\n");
+
+	platform_set_drvdata(pdev, bat);
+
+	return 0;
+
+comm_error:
+	return dev_err_probe(dev, ret, "Unable to communicate with device\n");
+}
+
+static int pm8916_bms_vm_battery_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct pm8916_bms_vm_battery *bat = platform_get_drvdata(pdev);
+	int ret;
+
+	/*
+	 * Due to a hardware quirk the FSM doesn't switch states normally.
+	 * Instead we unlock the debug registers and force S3 (Measure OCV/Sleep)
+	 * mode every time we suspend.
+	 */
+
+	ret = regmap_write(bat->regmap,
+			   bat->reg + PM8916_SEC_ACCESS, PM8916_SEC_MAGIC);
+	if (ret)
+		goto error;
+	ret = regmap_write(bat->regmap,
+			   bat->reg + PM8916_BMS_VM_MODE_CTL, PM8916_BMS_VM_MODE_FORCE_S3);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	dev_err(bat->dev, "Failed to force S3 mode: %pe\n", ERR_PTR(ret));
+	return ret;
+}
+
+static int pm8916_bms_vm_battery_resume(struct platform_device *pdev)
+{
+	struct pm8916_bms_vm_battery *bat = platform_get_drvdata(pdev);
+	int ret;
+	unsigned int tmp;
+
+	ret = regmap_bulk_read(bat->regmap,
+			       bat->reg + PM8916_BMS_VM_S3_S7_OCV_DATA0, &tmp, 2);
+
+	bat->last_ocv = tmp * 300;
+
+	ret = regmap_write(bat->regmap,
+			   bat->reg + PM8916_SEC_ACCESS, PM8916_SEC_MAGIC);
+	if (ret)
+		goto error;
+	ret = regmap_write(bat->regmap,
+			   bat->reg + PM8916_BMS_VM_MODE_CTL, PM8916_BMS_VM_MODE_NORMAL);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	dev_err(bat->dev, "Failed to return normal mode: %pe\n", ERR_PTR(ret));
+	return ret;
+}
+
+static const struct of_device_id pm8916_bms_vm_battery_of_match[] = {
+	{ .compatible = "qcom,pm8916-bms-vm", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, pm8916_bms_vm_battery_of_match);
+
+static struct platform_driver pm8916_bms_vm_battery_driver = {
+	.driver = {
+		.name = "pm8916-bms-vm",
+		.of_match_table = of_match_ptr(pm8916_bms_vm_battery_of_match),
+	},
+	.probe = pm8916_bms_vm_battery_probe,
+	.suspend = pm8916_bms_vm_battery_suspend,
+	.resume = pm8916_bms_vm_battery_resume,
+};
+module_platform_driver(pm8916_bms_vm_battery_driver);
+
+MODULE_DESCRIPTION("pm8916 BMS-VM driver");
+MODULE_AUTHOR("Nikita Travkin <nikita@trvn.ru>");
+MODULE_LICENSE("GPL");

-- 
2.41.0

