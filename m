Return-Path: <linux-kernel+bounces-133945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 899F489AB45
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0970E1F21916
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D547A376E7;
	Sat,  6 Apr 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVFCMWO9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4743714C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712412416; cv=none; b=bCxTy9nsjhS4ciRlzcOB6dS6EC/4C+n+FsHXrxoC4bwhCL+t6xfMn/06mdrzPMzYrknDMiG5FW592JQrzjoFLXWuCLxKIe+k5JET8WHQKa4TGYxgTf+vYo6v9N9M1vhvz343Jpg9l79LNNYbiNc6PzU5X0c2A+ABOUXdPpoiF6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712412416; c=relaxed/simple;
	bh=nzJ5LJz1dkENss5UDJFe0rRZWw8tbHqe4CR5ZPUeIGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tdCLufC/wA3SFzDydxUM3bnx0DG40wxgDweLoSXquEdm7koOmXIaOBaBveV+jiRLn/yHHBfqjSKVkN0Yw787TK0FChGTRro0AcdLGNH9FsDwFqMj1Ut3RY+ez14EdVrZ7Qo+wE78fV0KiUosZbkuUsYw9eTBbkNqImGCT0EDVV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVFCMWO9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712412413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=815qTGiW62Is3bxnjhsZ1q1GspWioFJPBfeZXmuWzQQ=;
	b=UVFCMWO9DjXXZFbcGLabzUwoZoVB9sMMFu4KcPs/O+AZKIkx0b01duZsbxTnrXhL+mQLwz
	r4DzFtQPMaPLZ6wu67fQCZ8lki76S1CFcYrZMoJDQ1wmjGi4v4Fvg6biaqRdnxMBsGCChs
	eXugIn3ZHfjO/MPd8CMMwfvgaHaaqIo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-n2BfoK42OUW-uv43xfVpKw-1; Sat,
 06 Apr 2024 10:06:50 -0400
X-MC-Unique: n2BfoK42OUW-uv43xfVpKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31CCC3803507;
	Sat,  6 Apr 2024 14:06:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6B5F840C6CB3;
	Sat,  6 Apr 2024 14:06:49 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: Add LC824206XA microUSB switch driver
Date: Sat,  6 Apr 2024 16:06:21 +0200
Message-ID: <20240406140621.18355-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Add a new driver for the ON Semiconductor LC824206XA microUSB switch and
accessory detector chip.

ON Semiconductor has an "Advance Information" datasheet available
(ENA2222-D.PDF), but no full datasheet. So there is no documentation
available for the registers.

This driver is based on the register info from the extcon-fsa9285.c driver,
from the Lollipop Android sources for the Lenovo Yoga Tablet 2 (Pro)
830 / 1050 / 1380 models. Note despite the name this is actually a driver
for the LC824206XA not the FSA9285.

This has only been tested on a Lenovo Yoga Tablet 2 Pro 1380 and
using the driver on other setups may require additional work.

So far this driver is only used on x86/ACPI (non devicetree) devs.
Therefor there is no devicetree bindings documentation for this driver's
"onnn,enable-miclr-for-dcp" property since this is not used in actual
devicetree files and the dt bindings maintainers have requested properties
with no actual dt users to _not_ be added to the dt bindings.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/Kconfig             |  11 +
 drivers/extcon/Makefile            |   1 +
 drivers/extcon/extcon-lc824206xa.c | 500 +++++++++++++++++++++++++++++
 3 files changed, 512 insertions(+)
 create mode 100644 drivers/extcon/extcon-lc824206xa.c

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index 5f869eacd19a..10212a585142 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -75,6 +75,17 @@ config EXTCON_INTEL_MRFLD
 	  Say Y here to enable extcon support for charger detection / control
 	  on the Intel Merrifield Basin Cove PMIC.
 
+config EXTCON_LC824206XA
+	tristate "LC824206XA extcon Support"
+	depends on I2C
+	depends on POWER_SUPPLY
+	help
+	  Say Y here to enable support for the ON Semiconductor LC824206XA
+	  microUSB switch and accessory detector chip. The LC824206XA is a USB
+	  port accessory detector and switch. The LC824206XA is fully controlled
+	  using I2C and enables USB data, stereo and mono audio, video,
+	  microphone and UART data to use a common connector port.
+
 config EXTCON_MAX14577
 	tristate "Maxim MAX14577/77836 EXTCON Support"
 	depends on MFD_MAX14577
diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
index f779adb5e4c7..0d6d23faf748 100644
--- a/drivers/extcon/Makefile
+++ b/drivers/extcon/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_EXTCON_GPIO)	+= extcon-gpio.o
 obj-$(CONFIG_EXTCON_INTEL_INT3496) += extcon-intel-int3496.o
 obj-$(CONFIG_EXTCON_INTEL_CHT_WC) += extcon-intel-cht-wc.o
 obj-$(CONFIG_EXTCON_INTEL_MRFLD) += extcon-intel-mrfld.o
+obj-$(CONFIG_EXTCON_LC824206XA)	+= extcon-lc824206xa.o
 obj-$(CONFIG_EXTCON_MAX14577)	+= extcon-max14577.o
 obj-$(CONFIG_EXTCON_MAX3355)	+= extcon-max3355.o
 obj-$(CONFIG_EXTCON_MAX77693)	+= extcon-max77693.o
diff --git a/drivers/extcon/extcon-lc824206xa.c b/drivers/extcon/extcon-lc824206xa.c
new file mode 100644
index 000000000000..fdf4da50ff46
--- /dev/null
+++ b/drivers/extcon/extcon-lc824206xa.c
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ON Semiconductor LC824206XA Micro USB Switch driver
+ *
+ * Copyright (c) 2024 Hans de Goede <hansg@kernel.org>
+ *
+ * ON Semiconductor has an "Advance Information" datasheet available
+ * (ENA2222-D.PDF), but no full datasheet. So there is no documentation
+ * available for the registers.
+ *
+ * This driver is based on the register info from the extcon-fsa9285.c driver,
+ * from the Lollipop Android sources for the Lenovo Yoga Tablet 2 (Pro)
+ * 830 / 1050 / 1380 models. Note despite the name this is actually a driver
+ * for the LC824206XA not the FSA9285. The Android sources can be downloaded
+ * from Lenovo's support page for these tablets, filename:
+ * yoga_tab_2_osc_android_to_lollipop_201505.rar.
+ */
+
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/extcon-provider.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/power_supply.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/workqueue.h>
+
+/*
+ * Register defines as mentioned above there is no datasheet with register
+ * info, so this may not be 100% accurate.
+ */
+#define REG00				0x00
+#define REG00_INIT_VALUE		0x01
+
+#define REG_STATUS			0x01
+#define STATUS_OVP			BIT(0)
+#define STATUS_DATA_SHORT		BIT(1)
+#define STATUS_VBUS_PRESENT		BIT(2)
+#define STATUS_USB_ID			GENMASK(7, 3)
+#define STATUS_USB_ID_GND		0x80
+#define STATUS_USB_ID_ACA		0xf0
+#define STATUS_USB_ID_FLOAT		0xf8
+
+/*
+ * This controls the DP/DM muxes + other switches,
+ * meaning of individual bits is unknown.
+ */
+#define REG_SWITCH_CONTROL		0x02
+#define SWITCH_STEREO_MIC		0xc8
+#define SWITCH_USB_HOST			0xec
+#define SWITCH_DISCONNECTED		0xf8
+#define SWITCH_USB_DEVICE		0xfc
+
+/* 5 bits? ADC 0x10 GND, 0x1a-0x1f ACA, 0x1f float */
+#define REG_ID_PIN_ADC_VALUE		0x03
+
+/* Masks for all 3 interrupt registers */
+#define INTR_ID_PIN_CHANGE		BIT(0)
+#define INTR_VBUS_CHANGE		BIT(1)
+/* Both of these get set after a continuous mode ADC conversion */
+#define INTR_ID_PIN_ADC_INT1		BIT(2)
+#define INTR_ID_PIN_ADC_INT2		BIT(3)
+/* Charger type available in reg 0x09 */
+#define INTR_CHARGER_DET_DONE		BIT(4)
+#define INTR_OVP			BIT(5)
+
+/* There are 7 interrupt sources, bit 6 use is unknown (OCP?) */
+#define INTR_ALL			GENMASK(6, 0)
+
+/* Unmask interrupts this driver cares about */
+#define INTR_MASK \
+	(INTR_ALL & ~(INTR_ID_PIN_CHANGE | INTR_VBUS_CHANGE | INTR_CHARGER_DET_DONE))
+
+/* Active (event happened and not cleared yet) interrupts */
+#define REG_INTR_STATUS			0x04
+
+/*
+ * Writing a 1 to a bit here clears it in INTR_STATUS. These bits do NOT
+ * auto-reset to 0, so these must be set to 0 manually after clearing.
+ */
+#define REG_INTR_CLEAR			0x05
+
+/* Interrupts which bit is set to 1 here will not raise the HW IRQ */
+#define REG_INTR_MASK			0x06
+
+/* ID pin ADC control, meaning of individual bits is unknown */
+#define REG_ID_PIN_ADC_CTRL		0x07
+#define ID_PIN_ADC_AUTO			0x40
+#define ID_PIN_ADC_CONTINUOUS		0x44
+
+#define REG_CHARGER_DET			0x08
+#define CHARGER_DET_ON			BIT(0)
+#define CHARGER_DET_CDP_ON		BIT(1)
+#define CHARGER_DET_CDP_VAL		BIT(2)
+
+#define REG_CHARGER_TYPE		0x09
+#define CHARGER_TYPE_UNKNOWN		0x00
+#define CHARGER_TYPE_DCP		0x01
+#define CHARGER_TYPE_SDP_OR_CDP		0x04
+#define CHARGER_TYPE_QC			0x06
+
+#define REG10				0x10
+#define REG10_INIT_VALUE		0x00
+
+struct lc824206xa_data {
+	struct work_struct work;
+	struct i2c_client *client;
+	struct extcon_dev *edev;
+	struct power_supply *psy;
+	struct regulator *vbus_boost;
+	unsigned int usb_type;
+	unsigned int cable;
+	unsigned int previous_cable;
+	u8 switch_control;
+	u8 previous_switch_control;
+	bool vbus_ok;
+	bool vbus_boost_enabled;
+	bool fastcharge_over_miclr;
+};
+
+static const unsigned int lc824206xa_cables[] = {
+	EXTCON_USB_HOST,
+	EXTCON_CHG_USB_SDP,
+	EXTCON_CHG_USB_CDP,
+	EXTCON_CHG_USB_DCP,
+	EXTCON_CHG_USB_ACA,
+	EXTCON_CHG_USB_FAST,
+	EXTCON_NONE,
+};
+
+/* read/write reg helpers to add error logging to smbus byte functions */
+static int lc824206xa_read_reg(struct lc824206xa_data *data, u8 reg)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, reg);
+	if (ret < 0)
+		dev_err(&data->client->dev, "Error %d reading reg 0x%02x\n", ret, reg);
+
+	return ret;
+}
+
+static int lc824206xa_write_reg(struct lc824206xa_data *data, u8 reg, u8 val)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, reg, val);
+	if (ret < 0)
+		dev_err(&data->client->dev, "Error %d writing reg 0x%02x\n", ret, reg);
+
+	return ret;
+}
+
+static int lc824206xa_get_id(struct lc824206xa_data *data)
+{
+	int ret;
+
+	ret = lc824206xa_write_reg(data, REG_ID_PIN_ADC_CTRL, ID_PIN_ADC_CONTINUOUS);
+	if (ret)
+		return ret;
+
+	ret = lc824206xa_read_reg(data, REG_ID_PIN_ADC_VALUE);
+	
+	lc824206xa_write_reg(data, REG_ID_PIN_ADC_CTRL, ID_PIN_ADC_AUTO);
+
+	return ret;
+}
+
+static void lc824206xa_set_vbus_boost(struct lc824206xa_data *data, bool enable)
+{
+	int ret;
+
+	if (data->vbus_boost_enabled == enable)
+		return;
+
+	if (enable)
+		ret = regulator_enable(data->vbus_boost);
+	else
+		ret = regulator_disable(data->vbus_boost);
+
+	if (ret == 0)
+		data->vbus_boost_enabled = enable;
+	else
+		dev_err(&data->client->dev, "Error updating Vbus boost regulator: %d\n", ret);
+}
+
+static void lc824206xa_charger_detect(struct lc824206xa_data *data)
+{
+	int charger_type, ret;
+
+	charger_type = lc824206xa_read_reg(data, REG_CHARGER_TYPE);
+	if (charger_type < 0)
+		return;
+
+	dev_dbg(&data->client->dev, "charger type 0x%02x\n", charger_type);
+
+	switch (charger_type) {
+	case CHARGER_TYPE_UNKNOWN:
+		data->usb_type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
+		/* Treat as SDP */
+		data->cable = EXTCON_CHG_USB_SDP;
+		data->switch_control = SWITCH_USB_DEVICE;
+		break;
+	case CHARGER_TYPE_SDP_OR_CDP:
+		data->usb_type = POWER_SUPPLY_USB_TYPE_SDP;
+		data->cable = EXTCON_CHG_USB_SDP;
+		data->switch_control = SWITCH_USB_DEVICE;
+
+		ret = lc824206xa_write_reg(data, REG_CHARGER_DET,
+					   CHARGER_DET_CDP_ON | CHARGER_DET_ON);
+		if (ret < 0)
+			break;
+
+		msleep(100);
+		ret = lc824206xa_read_reg(data, REG_CHARGER_DET);
+		if (ret >= 0 && (ret & CHARGER_DET_CDP_VAL)) {
+			data->usb_type = POWER_SUPPLY_USB_TYPE_CDP;
+			data->cable = EXTCON_CHG_USB_CDP;
+		}
+
+		lc824206xa_write_reg(data, REG_CHARGER_DET, CHARGER_DET_ON);
+		break;
+	case CHARGER_TYPE_DCP:
+		data->usb_type = POWER_SUPPLY_USB_TYPE_DCP;
+		data->cable = EXTCON_CHG_USB_DCP;
+		if (data->fastcharge_over_miclr)
+			data->switch_control = SWITCH_STEREO_MIC;
+		else
+			data->switch_control = SWITCH_DISCONNECTED;
+		break;
+	case CHARGER_TYPE_QC:
+		data->usb_type = POWER_SUPPLY_USB_TYPE_DCP;
+		data->cable = EXTCON_CHG_USB_DCP;
+		data->switch_control = SWITCH_DISCONNECTED;
+		break;
+	default:
+		dev_warn(&data->client->dev, "Unknown charger type: 0x%02x\n", charger_type);
+		break;
+	}
+}
+
+static void lc824206xa_work(struct work_struct *work)
+{
+        struct lc824206xa_data *data = container_of(work, struct lc824206xa_data, work);
+        bool vbus_boost_enable = false;
+        int status, id;
+
+        status = lc824206xa_read_reg(data, REG_STATUS);
+        if (status < 0)
+        	return;
+
+	dev_dbg(&data->client->dev, "status 0x%02x\n", status);
+
+	data->vbus_ok = (status & (STATUS_VBUS_PRESENT | STATUS_OVP)) == STATUS_VBUS_PRESENT;
+
+	/* Read id pin ADC if necessary */
+	switch (status & STATUS_USB_ID) {
+	case STATUS_USB_ID_GND:
+	case STATUS_USB_ID_FLOAT:
+		break;
+	default:
+		/* Happens when the connector is inserted slowly, log at dbg level */
+		dev_dbg(&data->client->dev, "Unknown status 0x%02x\n", status);
+		fallthrough;
+	case STATUS_USB_ID_ACA:
+		id = lc824206xa_get_id(data);
+		dev_dbg(&data->client->dev, "RID 0x%02x\n", id);
+		switch (id) {
+		case 0x10:
+			status = STATUS_USB_ID_GND;
+			break;
+		case 0x18 ... 0x1e:
+			status = STATUS_USB_ID_ACA;
+			break;
+		case 0x1f:
+			status = STATUS_USB_ID_FLOAT;
+			break;
+		default:
+			dev_warn(&data->client->dev, "Unknown RID 0x%02x\n", id);
+			return;
+		}
+	}
+
+	/* Check for out of spec OTG charging hubs, treat as ACA */
+	if ((status & STATUS_USB_ID) == STATUS_USB_ID_GND &&
+	    data->vbus_ok && !data->vbus_boost_enabled) {
+		dev_info(&data->client->dev, "Out of spec USB host adapter with Vbus present, not enabling 5V output\n");
+		status = STATUS_USB_ID_ACA;
+	}
+
+	switch (status & STATUS_USB_ID) {
+	case STATUS_USB_ID_ACA:
+		data->usb_type = POWER_SUPPLY_USB_TYPE_ACA;
+		data->cable = EXTCON_CHG_USB_ACA;
+		data->switch_control = SWITCH_USB_HOST;
+		break;
+	case STATUS_USB_ID_GND:
+		data->usb_type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
+		data->cable = EXTCON_USB_HOST;
+		data->switch_control = SWITCH_USB_HOST;
+		vbus_boost_enable = true;
+		break;
+	case STATUS_USB_ID_FLOAT:
+		/* When fast charging with Vbus > 5V, OVP will be set */
+		if (data->fastcharge_over_miclr &&
+		    data->switch_control == SWITCH_STEREO_MIC &&
+		    (status & STATUS_OVP)) {
+			data->cable = EXTCON_CHG_USB_FAST;
+			break;
+		}
+
+		if (data->vbus_ok) {
+			lc824206xa_charger_detect(data);
+		} else {
+			data->usb_type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
+			data->cable = EXTCON_NONE;
+			data->switch_control = SWITCH_DISCONNECTED;
+		}
+		break;
+	}
+
+	lc824206xa_set_vbus_boost(data, vbus_boost_enable);
+
+	if (data->switch_control != data->previous_switch_control) {
+		lc824206xa_write_reg(data, REG_SWITCH_CONTROL, data->switch_control);
+		data->previous_switch_control = data->switch_control;
+	}
+
+	if (data->cable != data->previous_cable) {
+		extcon_set_state_sync(data->edev, data->previous_cable, false);
+		extcon_set_state_sync(data->edev, data->cable, true);
+		data->previous_cable = data->cable;
+	}
+
+	power_supply_changed(data->psy);
+}
+
+static irqreturn_t lc824206xa_irq(int irq, void *_data)
+{
+	struct lc824206xa_data *data = _data;
+	int intr_status;
+
+	intr_status = lc824206xa_read_reg(data, REG_INTR_STATUS);
+	if (intr_status < 0)
+		intr_status = INTR_ALL; /* Should never happen, clear all */
+
+	dev_dbg(&data->client->dev, "interrupt 0x%02x\n", intr_status);
+
+	lc824206xa_write_reg(data, REG_INTR_CLEAR, intr_status);
+	lc824206xa_write_reg(data, REG_INTR_CLEAR, 0);
+
+	schedule_work(&data->work);		
+	return IRQ_HANDLED;
+}
+
+/*
+ * Newer charger (power_supply) drivers expect the max input current to be
+ * provided by a parent power_supply device for the charger chip.
+ */
+static int lc824206xa_psy_get_prop(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   union power_supply_propval *val)
+{
+	struct lc824206xa_data *data = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = data->vbus_ok && !data->vbus_boost_enabled;
+		break;
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		val->intval = data->usb_type;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		switch (data->usb_type) {
+		case POWER_SUPPLY_USB_TYPE_DCP:
+		case POWER_SUPPLY_USB_TYPE_ACA:
+			val->intval = 2000000;
+			break;
+		case POWER_SUPPLY_USB_TYPE_CDP:
+			val->intval = 1500000;
+			break;
+		default:
+			val->intval = 500000;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const enum power_supply_usb_type lc824206xa_psy_usb_types[] = {
+	POWER_SUPPLY_USB_TYPE_SDP,
+	POWER_SUPPLY_USB_TYPE_CDP,
+	POWER_SUPPLY_USB_TYPE_DCP,
+	POWER_SUPPLY_USB_TYPE_ACA,
+	POWER_SUPPLY_USB_TYPE_UNKNOWN,
+};
+
+static const enum power_supply_property lc824206xa_psy_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+};
+
+static const struct power_supply_desc lc824206xa_psy_desc = {
+	.name = "lc824206xa-charger-detect",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.usb_types = lc824206xa_psy_usb_types,
+	.num_usb_types = ARRAY_SIZE(lc824206xa_psy_usb_types),
+	.properties = lc824206xa_psy_props,
+	.num_properties = ARRAY_SIZE(lc824206xa_psy_props),
+	.get_property = lc824206xa_psy_get_prop,
+};
+
+static int lc824206xa_probe(struct i2c_client *client)
+{
+	struct power_supply_config psy_cfg = { };
+	struct device *dev = &client->dev;
+	struct lc824206xa_data *data;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	INIT_WORK(&data->work, lc824206xa_work);
+	data->cable = EXTCON_NONE;
+	data->previous_cable = EXTCON_NONE;
+	data->usb_type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
+	/* Some designs use a custom fast-charge protocol over the mic L/R inputs */
+	data->fastcharge_over_miclr =
+		device_property_read_bool(dev, "onnn,enable-miclr-for-dcp");
+
+	data->vbus_boost = devm_regulator_get(dev, "vbus");
+	if (IS_ERR(data->vbus_boost))
+		return dev_err_probe(dev, PTR_ERR(data->vbus_boost),
+				     "getting regulator\n");
+
+	/* Init */
+	ret = lc824206xa_write_reg(data, REG00, REG00_INIT_VALUE);
+	ret |= lc824206xa_write_reg(data, REG10, REG10_INIT_VALUE);
+	msleep(100);
+	ret |= lc824206xa_write_reg(data, REG_INTR_CLEAR, INTR_ALL);
+	ret |= lc824206xa_write_reg(data, REG_INTR_CLEAR, 0);
+	ret |= lc824206xa_write_reg(data, REG_INTR_MASK, INTR_MASK);
+	ret |= lc824206xa_write_reg(data, REG_ID_PIN_ADC_CTRL, ID_PIN_ADC_AUTO);
+	ret |= lc824206xa_write_reg(data, REG_CHARGER_DET, CHARGER_DET_ON);
+	if (ret)
+		return -EIO;
+
+	/* Initialize extcon device */
+	data->edev = devm_extcon_dev_allocate(dev, lc824206xa_cables);
+	if (IS_ERR(data->edev))
+		return PTR_ERR(data->edev);
+
+	ret = devm_extcon_dev_register(dev, data->edev);
+	if (ret)
+		return dev_err_probe(dev, ret, "registering extcon device\n");
+
+	psy_cfg.drv_data = data;
+	data->psy = devm_power_supply_register(dev, &lc824206xa_psy_desc, &psy_cfg);
+	if (IS_ERR(data->psy))
+		return dev_err_probe(dev, PTR_ERR(data->psy), "registering power supply\n");
+
+	ret = devm_request_threaded_irq(dev, client->irq, NULL, lc824206xa_irq,
+					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					KBUILD_MODNAME, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "requesting IRQ\n");
+
+	/* Sync initial state */
+	schedule_work(&data->work);		
+	return 0;
+}
+
+static const struct i2c_device_id lc824206xa_i2c_ids[] = {
+	{ "lc824206xa" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lc824206xa_i2c_ids);
+
+static struct i2c_driver lc824206xa_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.probe = lc824206xa_probe,
+	.id_table = lc824206xa_i2c_ids,
+};
+
+module_i2c_driver(lc824206xa_driver);
+
+MODULE_AUTHOR("Hans de Goede <hansg@kernel.org>");
+MODULE_DESCRIPTION("LC824206XA Micro USB Switch driver");
+MODULE_LICENSE("GPL");
-- 
2.44.0


