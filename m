Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9887F80869A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379044AbjLGLVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379021AbjLGLVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:21:42 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370C611F;
        Thu,  7 Dec 2023 03:21:45 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id BAF7842BF7;
        Thu,  7 Dec 2023 16:21:31 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1701948092; bh=ece5ccmSr8WYEr0PIacZKn4N6T5suV02hIkbQE4RaZU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=07WDwAPDD0IX7usUj4jFjXFRAj9QWyCyXQ6GdeO4xJnQ4r+JEvpx2ELrFbdXJQfEv
         ThGwSC3OdL01f0K/M2MmqtKdT6mBBkF0vPFeVen8ZZAVVA8JUfYlU1Jt793dibD/Qx
         2B2/M2JuvfbYVSGizlJwm7GLIVOeafEmyLLvI5yhW37PbP4x+MViMOoXBTxjNBXjbp
         vOwZC9OLnztEuAIRDAVfWfjmvJBkZDc0ZioGWRtBfMMaH+NZOBNuLAUU56YhzJeSqW
         w3jiS/RrcxCQybP0NfbXRDysm2q/qV3bZAkxzGWTFxNDG0nijtd+0jAqVpATTyhZLs
         0zNWhepd7NsrA==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Thu, 07 Dec 2023 16:20:15 +0500
Subject: [PATCH 2/3] power: supply: Add Acer Aspire 1 embedded controller
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-aspire1-ec-v1-2-ba9e1c227007@trvn.ru>
References: <20231207-aspire1-ec-v1-0-ba9e1c227007@trvn.ru>
In-Reply-To: <20231207-aspire1-ec-v1-0-ba9e1c227007@trvn.ru>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=14875; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=ece5ccmSr8WYEr0PIacZKn4N6T5suV02hIkbQE4RaZU=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlcaq42oyVfb+8As2+UP6FIdUQ/cOm1rxGXO47Z
 RE8/3XicESJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZXGquAAKCRBDHOzuKBm/
 dRmKEACb44dnXxR014UE4zEItLRFo+/XIiX+U2XwhrI+mAYLZ7mJF6BphP4V/0ZdGAriJPSJmTs
 i97pT/Q2RRWsZcBZTmC9sI8xGqcXc4tQcXdcxfGn3gZHcZlCgpOMPaJmuGqfAuQP9qeXgLhW4XK
 SzRns7Y6AqpDzlGGmJwGb5vaCY0GZbeQJM7MA/cK8uPx2We9iqwMxK1zZ9vA3V5lnYC2P7s3tY8
 aHc5NzZve35Le2CL8lcbVx2dw0CKb2I4NCxKCFeYTbrwiDRmoEm/mlq5wY2OnArBVKC/YjSz1ae
 zbOpjToBVjZ173wkt9p3kCRUE6fUvemOI63lNToAt6wUdF/vv8u9QKcwfpKR11qhqZUVk98vXeI
 950rW+21RSuP10CtCZ1F3QUumYnltFRr1N3IaaWFD5Q6v40GuX9d0A6xPRBGUQdy9nKWJb1SDzJ
 iUGhSeDQk/lFGHhckbRowiVO/xAvbVzU5Z/a9Zv5qtWiGhrPgWAsln6WTK57NLoU3clTmQv4sMm
 7u9duEgJDH8zaSI69b9m+EddWiyw8m7BoiuvxdbIlsdPiRhMZoPCgpCK5arrddAhqJUD5I9NbsA
 xp/X9MxriR9hl7Q+r3yCLQ2zUUBOlJr9Rn8rp4jjprmY2a4WhJwuhMP11b/VGgB1yrZLxW8EOOP
 Pr8jAMwNY6RO5uA==
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

Acer Aspire 1 is a Snapdragon 7c based laptop. It uses an embedded
controller to control the charging and battery management, as well as to
perform a set of misc functions.

Unfortunately, while all this functionality is implemented in ACPI, it's
currently not possible to use ACPI to boot Linux on such Qualcomm
devices. To allow Linux to still support the features provided by EC,
this driver reimplments the relevant ACPI parts. This allows us to boot
the laptop with Device Tree and retain all the features.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/power/supply/Kconfig           |  14 ++
 drivers/power/supply/Makefile          |   1 +
 drivers/power/supply/acer-aspire1-ec.c | 432 +++++++++++++++++++++++++++++++++
 3 files changed, 447 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index f21cb05815ec..47d2ad14447b 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -984,4 +984,18 @@ config FUEL_GAUGE_MM8013
 	  the state of charge, temperature, cycle count, actual and design
 	  capacity, etc.
 
+config EC_ACER_ASPIRE1
+	tristate "Acer Aspire 1 Emedded Controller driver"
+	depends on I2C
+	depends on DRM
+	help
+	  Say Y here to enable the EC driver for the (Snapdragon-based)
+	  Acer Aspire 1 laptop. The EC handles battery and charging
+	  monitoring as well as some misc functions like the lid sensor
+	  and USB Type-C DP HPD events.
+
+	  This driver provides battery and AC status support for the mentioned
+	  laptop where this information is not properly exposed via the
+	  standard ACPI devices.
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 58b567278034..6049c87820c0 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -114,3 +114,4 @@ obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
 obj-$(CONFIG_BATTERY_UG3105)	+= ug3105_battery.o
 obj-$(CONFIG_CHARGER_QCOM_SMB2)	+= qcom_pmi8998_charger.o
 obj-$(CONFIG_FUEL_GAUGE_MM8013)	+= mm8013.o
+obj-$(CONFIG_EC_ACER_ASPIRE1)	+= acer-aspire1-ec.o
diff --git a/drivers/power/supply/acer-aspire1-ec.c b/drivers/power/supply/acer-aspire1-ec.c
new file mode 100644
index 000000000000..845a11abf951
--- /dev/null
+++ b/drivers/power/supply/acer-aspire1-ec.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023, Nikita Travkin <nikita@trvn.ru> */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/delay.h>
+
+#include <linux/usb/typec_mux.h>
+#include <drm/drm_bridge.h>
+
+#define ASPIRE_EC_EVENT			0x05
+
+#define ASPIRE_EC_EVENT_WATCHDOG	0x20
+#define ASPIRE_EC_EVENT_LID_CLOSE	0x9b
+#define ASPIRE_EC_EVENT_LID_OPEN	0x9c
+#define ASPIRE_EC_EVENT_FG_INF_CHG	0x85
+#define ASPIRE_EC_EVENT_FG_STA_CHG	0xc6
+#define ASPIRE_EC_EVENT_HPD_DIS		0xa3
+#define ASPIRE_EC_EVENT_HPD_CON		0xa4
+
+#define ASPIRE_EC_FG_DYNAMIC		0x07
+#define ASPIRE_EC_FG_STATIC		0x08
+
+#define ASPIRE_EC_FG_FLAG_PRESENT	BIT(0)
+#define ASPIRE_EC_FG_FLAG_FULL		BIT(1)
+#define ASPIRE_EC_FG_FLAG_DISCHARGING	BIT(2)
+#define ASPIRE_EC_FG_FLAG_CHARGING	BIT(3)
+
+#define ASPIRE_EC_RAM_READ		0x20
+#define ASPIRE_EC_RAM_WRITE		0x21
+
+#define ASPIRE_EC_RAM_WATCHDOG		0x19
+#define ASPIRE_EC_RAM_KBD_MODE		0x43
+
+#define ASPIRE_EC_RAM_KBD_FN_EN		BIT(0)
+#define ASPIRE_EC_RAM_KBD_MEDIA_ON_TOP	BIT(5)
+#define ASPIRE_EC_RAM_KBD_ALWAYS_SET	BIT(6)
+#define ASPIRE_EC_RAM_KBD_NUM_LAYER_EN	BIT(7)
+
+#define ASPIRE_EC_RAM_KBD_MODE_2	0x60
+
+#define ASPIRE_EC_RAM_KBD_MEDIA_NOTIFY	BIT(3)
+
+#define ASPIRE_EC_RAM_HPD_STATUS	0xf4
+#define ASPIRE_EC_HPD_CONNECTED		0x03
+
+#define ASPIRE_EC_RAM_LID_STATUS	0x4c
+#define ASPIRE_EC_LID_OPEN		BIT(6)
+
+struct aspire_ec {
+	struct i2c_client *client;
+	struct power_supply *psy;
+	struct input_dev *idev;
+
+	bool bridge_configured;
+	struct drm_bridge bridge;
+	struct work_struct work;
+};
+
+struct aspire_ec_psy_static_data {
+	u8 unk1;
+	u8 flags;
+	__le16 unk2;
+	__le16 voltage_design;
+	__le16 capacity_full;
+	__le16 unk3;
+	__le16 serial;
+	u8 model_id;
+	u8 vendor_id;
+} __packed;
+
+static const char * const aspire_ec_psy_battery_model[] = {
+	"AP18C4K",
+	"AP18C8K",
+	"AP19B8K",
+	"AP16M4J",
+	"AP16M5J",
+};
+
+static const char * const aspire_ec_psy_battery_vendor[] = {
+	"SANYO",
+	"SONY",
+	"PANASONIC",
+	"SAMSUNG",
+	"SIMPLO",
+	"MOTOROLA",
+	"CELXPERT",
+	"LGC",
+	"GETAC",
+	"MURATA",
+};
+
+struct aspire_ec_psy_dynamic_data {
+	u8 unk1;
+	u8 flags;
+	u8 unk2;
+	__le16 capacity_now;
+	__le16 voltage_now;
+	__le16 current_now;
+	__le16 unk3;
+	__le16 unk4;
+} __packed;
+
+static int aspire_ec_psy_get_property(struct power_supply *psy,
+				      enum power_supply_property psp,
+				      union power_supply_propval *val)
+{
+	struct aspire_ec *ec = power_supply_get_drvdata(psy);
+	struct aspire_ec_psy_static_data sdat;
+	struct aspire_ec_psy_dynamic_data ddat;
+
+	i2c_smbus_read_i2c_block_data(ec->client, ASPIRE_EC_FG_STATIC, sizeof(sdat), (u8 *)&sdat);
+	i2c_smbus_read_i2c_block_data(ec->client, ASPIRE_EC_FG_DYNAMIC, sizeof(ddat), (u8 *)&ddat);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+		if (ddat.flags & ASPIRE_EC_FG_FLAG_CHARGING)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (ddat.flags & ASPIRE_EC_FG_FLAG_DISCHARGING)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else if (ddat.flags & ASPIRE_EC_FG_FLAG_FULL)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		break;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = le16_to_cpu(ddat.voltage_now) * 1000;
+		break;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		val->intval = le16_to_cpu(sdat.voltage_design) * 1000;
+		break;
+
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		val->intval = le16_to_cpu(ddat.capacity_now) * 1000;
+		break;
+
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		val->intval = le16_to_cpu(sdat.capacity_full) * 1000;
+		break;
+
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = le16_to_cpu(ddat.capacity_now) * 100
+			      / le16_to_cpu(sdat.capacity_full);
+		break;
+
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = (s16)le16_to_cpu(ddat.current_now) * 1000;
+		break;
+
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
+		break;
+
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		if (sdat.model_id - 1 < ARRAY_SIZE(aspire_ec_psy_battery_model))
+			val->strval = aspire_ec_psy_battery_model[sdat.model_id - 1];
+		else
+			val->strval = "Unknown";
+		break;
+
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		if (sdat.vendor_id - 3 < ARRAY_SIZE(aspire_ec_psy_battery_vendor))
+			val->strval = aspire_ec_psy_battery_vendor[sdat.vendor_id - 3];
+		else
+			val->strval = "Unknown";
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum power_supply_property aspire_ec_psy_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static const struct power_supply_desc aspire_ec_psy_desc = {
+	.name		= "aspire-ec",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.get_property	= aspire_ec_psy_get_property,
+	.properties	= aspire_ec_psy_props,
+	.num_properties	= ARRAY_SIZE(aspire_ec_psy_props),
+};
+
+static int aspire_ec_ram_read(struct i2c_client *client, u8 off, u8 *data, u8 data_len)
+{
+	i2c_smbus_write_byte_data(client, ASPIRE_EC_RAM_READ, off);
+	i2c_smbus_read_i2c_block_data(client, ASPIRE_EC_RAM_READ, data_len, data);
+	return 0;
+}
+
+static int aspire_ec_ram_write(struct i2c_client *client, u8 off, u8 data)
+{
+	u8 tmp[2] = {off, data};
+
+	i2c_smbus_write_i2c_block_data(client, ASPIRE_EC_RAM_WRITE, sizeof(tmp), tmp);
+	return 0;
+}
+
+static irqreturn_t aspire_ec_irq_handler(int irq, void *data)
+{
+	struct aspire_ec *ec = data;
+	int id;
+	u8 tmp;
+
+	/*
+	 * The original ACPI firmware actually has a small sleep in the handler.
+	 *
+	 * It seems like in most cases it's not needed but when the device
+	 * just exits suspend, our i2c driver has a brief time where data
+	 * transfer is not possible yet. So this delay allows us to suppress
+	 * quite a bunch of spurious error messages in dmesg. Thus it's kept.
+	 */
+	usleep_range(15000, 30000);
+
+	id = i2c_smbus_read_byte_data(ec->client, ASPIRE_EC_EVENT);
+	if (id < 0) {
+		dev_err(&ec->client->dev, "Failed to read event id: %pe\n", ERR_PTR(id));
+		return IRQ_HANDLED;
+	}
+
+	switch (id) {
+	case 0x0: /* No event */
+		break;
+
+	case ASPIRE_EC_EVENT_WATCHDOG:
+		/*
+		 * Here acpi responds to the event and clears some bit.
+		 * Notify (\_SB.I2C3.BAT1, 0x81) // Information Change
+		 * Notify (\_SB.I2C3.ADP1, 0x80) // Status Change
+		 */
+		aspire_ec_ram_read(ec->client, ASPIRE_EC_RAM_WATCHDOG, &tmp, sizeof(tmp));
+		aspire_ec_ram_write(ec->client, ASPIRE_EC_RAM_WATCHDOG, tmp & 0xbf);
+		break;
+
+	case ASPIRE_EC_EVENT_LID_CLOSE:
+		/* Notify (\_SB.LID0, 0x80) // Status Change */
+		input_report_switch(ec->idev, SW_LID, 1);
+		input_sync(ec->idev);
+		break;
+
+	case ASPIRE_EC_EVENT_LID_OPEN:
+		/* Notify (\_SB.LID0, 0x80) // Status Change */
+		input_report_switch(ec->idev, SW_LID, 0);
+		input_sync(ec->idev);
+		break;
+
+	case ASPIRE_EC_EVENT_FG_INF_CHG:
+		/* Notify (\_SB.I2C3.BAT1, 0x81) // Information Change */
+	case ASPIRE_EC_EVENT_FG_STA_CHG:
+		/* Notify (\_SB.I2C3.BAT1, 0x80) // Status Change */
+		power_supply_changed(ec->psy);
+		break;
+
+	case ASPIRE_EC_EVENT_HPD_DIS:
+		if (ec->bridge_configured)
+			drm_bridge_hpd_notify(&ec->bridge, connector_status_disconnected);
+		break;
+
+	case ASPIRE_EC_EVENT_HPD_CON:
+		if (ec->bridge_configured)
+			drm_bridge_hpd_notify(&ec->bridge, connector_status_connected);
+		break;
+
+	default:
+		dev_warn(&ec->client->dev, "Unknown event id=0x%x\n", id);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int aspire_ec_bridge_attach(struct drm_bridge *bridge, enum drm_bridge_attach_flags flags)
+{
+	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
+}
+
+static void aspire_ec_bridge_update_hpd_work(struct work_struct *work)
+{
+	struct aspire_ec *ec = container_of(work, struct aspire_ec, work);
+	u8 tmp;
+
+	aspire_ec_ram_read(ec->client, ASPIRE_EC_RAM_HPD_STATUS, &tmp, sizeof(tmp));
+	if (tmp == ASPIRE_EC_HPD_CONNECTED)
+		drm_bridge_hpd_notify(&ec->bridge, connector_status_connected);
+	else
+		drm_bridge_hpd_notify(&ec->bridge, connector_status_disconnected);
+}
+
+static void aspire_ec_bridge_hpd_enable(struct drm_bridge *bridge)
+{
+	struct aspire_ec *ec = container_of(bridge, struct aspire_ec, bridge);
+
+	schedule_work(&ec->work);
+}
+
+static const struct drm_bridge_funcs aspire_ec_bridge_funcs = {
+	.hpd_enable = aspire_ec_bridge_hpd_enable,
+	.attach = aspire_ec_bridge_attach,
+};
+
+static int aspire_ec_probe(struct i2c_client *client)
+{
+	struct power_supply_config psy_cfg = {0};
+	struct device *dev = &client->dev;
+	struct fwnode_handle *fwnode;
+	struct aspire_ec *ec;
+	int ret;
+	u8 tmp;
+
+	ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
+	if (!ec)
+		return -ENOMEM;
+
+	ec->client = client;
+	i2c_set_clientdata(client, ec);
+
+	/* Battery status reports */
+	psy_cfg.drv_data = ec;
+	ec->psy = devm_power_supply_register(dev, &aspire_ec_psy_desc, &psy_cfg);
+	if (IS_ERR(ec->psy))
+		return dev_err_probe(dev, PTR_ERR(ec->psy),
+				     "Failed to register power supply\n");
+
+	/* Lid switch */
+	ec->idev = devm_input_allocate_device(dev);
+	if (!ec->idev)
+		return -ENOMEM;
+
+	ec->idev->name = "aspire-ec";
+	ec->idev->phys = "aspire-ec/input0";
+	input_set_capability(ec->idev, EV_SW, SW_LID);
+
+	ret = input_register_device(ec->idev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Input device register failed\n");
+
+	/* Enable the keyboard fn keys */
+	tmp = ASPIRE_EC_RAM_KBD_FN_EN | ASPIRE_EC_RAM_KBD_ALWAYS_SET;
+	if (device_property_read_bool(dev, "acer,media-keys-on-top"))
+		tmp |= ASPIRE_EC_RAM_KBD_MEDIA_ON_TOP;
+	aspire_ec_ram_write(client, ASPIRE_EC_RAM_KBD_MODE, tmp);
+
+	aspire_ec_ram_read(client, ASPIRE_EC_RAM_KBD_MODE_2, &tmp, sizeof(tmp));
+	tmp |= ASPIRE_EC_RAM_KBD_MEDIA_NOTIFY;
+	aspire_ec_ram_write(client, ASPIRE_EC_RAM_KBD_MODE_2, tmp);
+
+	/* External Type-C display attach reports */
+	fwnode = device_get_named_child_node(dev, "connector");
+	if (fwnode) {
+		INIT_WORK(&ec->work, aspire_ec_bridge_update_hpd_work);
+		ec->bridge.funcs = &aspire_ec_bridge_funcs;
+		ec->bridge.of_node = to_of_node(fwnode);
+		ec->bridge.ops = DRM_BRIDGE_OP_HPD;
+		ec->bridge.type = DRM_MODE_CONNECTOR_USB;
+
+		ret = devm_drm_bridge_add(dev, &ec->bridge);
+		if (ret) {
+			fwnode_handle_put(fwnode);
+			return dev_err_probe(dev, ret, "Failed to register drm bridge\n");
+		}
+
+		ec->bridge_configured = true;
+	}
+
+	ret = devm_request_threaded_irq(dev, client->irq, NULL,
+					aspire_ec_irq_handler, IRQF_ONESHOT,
+					dev_name(dev), ec);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request irq\n");
+
+	return 0;
+}
+
+static int aspire_ec_resume(struct device *dev)
+{
+	struct aspire_ec *ec = i2c_get_clientdata(to_i2c_client(dev));
+	u8 tmp;
+
+	aspire_ec_ram_read(ec->client, ASPIRE_EC_RAM_LID_STATUS, &tmp, sizeof(tmp));
+	input_report_switch(ec->idev, SW_LID, !!(tmp & ASPIRE_EC_LID_OPEN));
+	input_sync(ec->idev);
+
+	return 0;
+}
+
+static const struct i2c_device_id aspire_ec_id[] = {
+	{ "aspire1-ec", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, aspire_ec_id);
+
+static const struct of_device_id aspire_ec_of_match[] = {
+	{ .compatible = "acer,aspire1-ec", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, aspire_ec_of_match);
+
+static DEFINE_SIMPLE_DEV_PM_OPS(aspire_ec_pm_ops, NULL, aspire_ec_resume);
+
+static struct i2c_driver aspire_ec_driver = {
+	.driver = {
+		.name = "aspire-ec",
+		.of_match_table = aspire_ec_of_match,
+		.pm = pm_sleep_ptr(&aspire_ec_pm_ops),
+	},
+	.probe = aspire_ec_probe,
+	.id_table = aspire_ec_id,
+};
+module_i2c_driver(aspire_ec_driver);
+
+MODULE_DESCRIPTION("Acer Aspire 1 embedded controller");
+MODULE_AUTHOR("Nikita Travkin <nikita@trvn.ru>");
+MODULE_LICENSE("GPL");

-- 
2.43.0

