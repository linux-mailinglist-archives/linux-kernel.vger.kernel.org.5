Return-Path: <linux-kernel+bounces-72961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524D585BB30
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6871F217AE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBE0692E4;
	Tue, 20 Feb 2024 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="kGd0qkkb"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF95267C56;
	Tue, 20 Feb 2024 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430250; cv=none; b=RT/ExP/Lb/pkVo4s47czAbatybXZL6cOCpAfb2AhbnsfGsOByO9/xhf3W8qtvbIoxT3Ji29j33sXTJCSaeIl7++qzwnWqq3ZgUzUhmufGtC8oCW3b+7gvlp3VEfklmqPvrY3yxxUWq67gVyE7SwvuBvkbDXD1hNAqDn3bvXhcvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430250; c=relaxed/simple;
	bh=nFxiVs/VJqX/gcBnVHk7oxVGe4AZrm7vTx0yzBXkcu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BjL6Q/gyPUv3byVM97N7Z3Nhw47OpIj3zX61e3zABLps3YrJX6BkMYFw/eNvlpDRINtC16BrW3Mvy5RNdOb8I/K41kF8knhZ1Cial43xzgrTFa6CtwK0npSDI23O7RVrohFN8i48Fn9N12ujc69XXJ/jWKpTYX+J7vmZB9DFybI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=kGd0qkkb; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 1FA9A4198E;
	Tue, 20 Feb 2024 16:57:19 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1708430239; bh=nFxiVs/VJqX/gcBnVHk7oxVGe4AZrm7vTx0yzBXkcu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kGd0qkkbXfgqle++vqjQJ3/+aVh0BgxR78iiVSQ1pVceEBOcbuAndjM97qdwvKgEZ
	 DwNMLJDCDaa40/CCBOmDTMb+W6Y8iWLBVP396+/DnGSFYbBb1ndNgc5mI7WOgbeW4J
	 4Rjz/Pc0teaZlxNtQZENcMz2IXL/5GpIXM84TB0/5ahh/DZSFTTKFfQpIYPpm1jy5r
	 A28ot8mprmCH//VciIyQ9iaN+sZ6QEx9eJ5MbwskANnk9ggQ3amYFtJYCVXntFRg4G
	 UPzBabTJ4QRk7uWwpiMSaMWERXpE9lb+gYtExKhY2EE86kolvug8GcZBQxeR34Ilog
	 pMQTrIfaDr+Bg==
From: Nikita Travkin <nikita@trvn.ru>
Date: Tue, 20 Feb 2024 16:57:13 +0500
Subject: [PATCH v3 2/3] power: supply: Add Acer Aspire 1 embedded
 controller driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-aspire1-ec-v3-2-02cb139a4931@trvn.ru>
References: <20240220-aspire1-ec-v3-0-02cb139a4931@trvn.ru>
In-Reply-To: <20240220-aspire1-ec-v3-0-02cb139a4931@trvn.ru>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=15558; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=nFxiVs/VJqX/gcBnVHk7oxVGe4AZrm7vTx0yzBXkcu8=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBl1JOdxBDr38GpXidqxD2MthiFwOZSAJbmgKrMY
 GtGHU10/pyJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZdSTnQAKCRBDHOzuKBm/
 dQwmD/96LKNSXSqwnEgdPbHvyDmsC0lk0mGvIWEjtY3IKbZz1Xc5heZnpRdKFKWPsbEL/P1A4ue
 YV9AX8NiTdzL06NMfp+RNKSj+Q+30VBxqvQ386MAu7XI6Nv81GWx2ophy/PsjhhcBA8cqfhMSyD
 TH6x+/ykuaruKgAYIdkDsOAA0CMHE6+uyEKq8LIc3BZ3JDItrzhn5nydEzxw+bCfahuXuXwfa/U
 2iJAJZbopQwwEjcl7xe7r9MQB1OKlf9mw2PETKYIzef9IpL7sHWcrtXnF0KPHagTiyei4TG9Mds
 Hxi+2rhGDqptYfOQVb37sFeO4bD/AhPDKaAqYDbDLKdib23AlrF3w7KqLz4rFkI7wR1epCHLlZn
 8Na0B+36f6+PdergmJ2Yu2ugCHCthDv3Xl7MsvI1AkeNERTAe720TXcsM33Hj0oETVcZ1FMxNvV
 UhnYcrBKa4QfZ/cnq1n2D3gX8En77ZONJZl6Ewxk2WvO2vXn7jXBJ4bJrtjmKxI4j20npWCr5Zj
 Vbdb9JebLYuPWR/7tyFeNpxKev7OdB4qhUgOas9eVR1jC+GWmZKjlMsyrvP7OHIhYnOJ2CWvORc
 OXIVOqH+tlhsXth2RJ+lAWX7I+3SgR+0iodhW0um+GfxN6arKq6O+WA8ZKrLdlyEnvR2yu83YBc
 15b/Qo5FmtPVHPQ==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75

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
 drivers/power/supply/Kconfig           |  14 +
 drivers/power/supply/Makefile          |   1 +
 drivers/power/supply/acer-aspire1-ec.c | 453 +++++++++++++++++++++++++++++++++
 3 files changed, 468 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 3e31375491d5..e91a3acecb41 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -985,4 +985,18 @@ config FUEL_GAUGE_MM8013
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
index 000000000000..f4a141ec44b8
--- /dev/null
+++ b/drivers/power/supply/acer-aspire1-ec.c
@@ -0,0 +1,453 @@
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
+#define ASPIRE_EC_EVENT_KBD_BKL_ON	0x57
+#define ASPIRE_EC_EVENT_KBD_BKL_OFF	0x58
+#define ASPIRE_EC_EVENT_LID_CLOSE	0x9b
+#define ASPIRE_EC_EVENT_LID_OPEN	0x9c
+#define ASPIRE_EC_EVENT_BKL_UNBLANKED	0x9d
+#define ASPIRE_EC_EVENT_BKL_BLANKED	0x9e
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
+		val->intval = le16_to_cpu(ddat.capacity_now) * 100;
+		val->intval /= le16_to_cpu(sdat.capacity_full);
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
+
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
+	case ASPIRE_EC_EVENT_BKL_BLANKED:
+	case ASPIRE_EC_EVENT_BKL_UNBLANKED:
+		/* Display backlight blanked on FN+F6. No action needed. */
+		break;
+
+	case ASPIRE_EC_EVENT_KBD_BKL_ON:
+	case ASPIRE_EC_EVENT_KBD_BKL_OFF:
+		/*
+		 * There is a keyboard backlight connector
+		 * on Aspire 1 that is controlled by FN+F8.
+		 * There is no kb backlight on the device
+		 * though. Seems like this is used on other
+		 * devices like Acer Spin 7. No action needed.
+		 */
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
+	if (!device_property_read_bool(dev, "acer,fn-selects-media-keys"))
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


