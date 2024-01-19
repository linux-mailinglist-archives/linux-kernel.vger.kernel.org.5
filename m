Return-Path: <linux-kernel+bounces-31052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DF6832821
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA363283D51
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B332653E07;
	Fri, 19 Jan 2024 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BvVAah7Z"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E843C493;
	Fri, 19 Jan 2024 10:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661169; cv=none; b=O0SLV933BiguqJRvmfaTAQCBv1T8Crqu2wSDKuTuXIwExRRioGctOVVbp47ISAc58Um3DsWq9o1DyTgUBA2oCH8o7C0Ajb2qb4ZdGqoxLRk2xetz4SUPQgBpKzAqJMOr/2mPsbCEH4phM4/gVGynuAwMDDLF3+RJqBMJXWrma7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661169; c=relaxed/simple;
	bh=KxQtTG+bdahH4GYu6kErROj559jzNsux+B3iRtc5c8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aj4L4CEIcWupXdh6Sz/+zuOyccaTMpkdDg/uQbMhiXYviHzNgqrD5uNywtHeLhH23zkSJHngs6fncx/65kSjlYJIIC3VPetJfekPOKk/pVjGkpBuLHdWz7uMWbg4E7amzYKqHWQvmq68sTpCebdySslZwIBJlVIFVptQA2xZXXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BvVAah7Z; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705661160;
	bh=KxQtTG+bdahH4GYu6kErROj559jzNsux+B3iRtc5c8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BvVAah7Zv6QVxEnxz+3I7hWNhOCCSDOu3AlrfK9FMiGkDbOaBSIpuW5qyZJLPYgCI
	 DO6PglY4NRl/APDGYxX014XjygAlH9bbxjAZVSqmU6CppzakgNX2gGk5SM3BQM2LB+
	 QicvBBFusU2sbxddA2fE08NYzPLWqqUeNYD2/nTJx9+cxwcPxM1dah6dAFiNjPCTPP
	 74pqQD3jSlsEkkWI4eoF+YFpUXbHqf/Ip5H2ESRnS/+/jq/ShrCg46IiY+apXm8r1o
	 0W+Nd8VLQYvkRHkHZxYq6QHcjY/a/aLJSX/J5cZIHYpvHpy7BCuYxQPIRcb4dHvagx
	 /gj7t+53NJd9w==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F101F3782083;
	Fri, 19 Jan 2024 10:45:58 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: gregkh@linuxfoundation.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heikki.krogerus@linux.intel.com,
	matthias.bgg@gmail.com,
	dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org,
	andersson@kernel.org,
	nathan@kernel.org,
	luca.weiss@fairphone.com,
	tianping.fang@mediatek.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/2] usb: typec: mux: Add ITE IT5205 Alternate Mode Passive MUX driver
Date: Fri, 19 Jan 2024 11:45:50 +0100
Message-ID: <20240119104550.140061-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119104550.140061-1-angelogioacchino.delregno@collabora.com>
References: <20240119104550.140061-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ITE IT5202 is a USB Type-C Alternate Mode Passive MUX, used for
muxing the SBU lines of a Type-C port with DisplayPort altmode and
also providing an orientation switch.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/usb/typec/mux/Kconfig  |  10 ++
 drivers/usb/typec/mux/Makefile |   1 +
 drivers/usb/typec/mux/it5205.c | 292 +++++++++++++++++++++++++++++++++
 3 files changed, 303 insertions(+)
 create mode 100644 drivers/usb/typec/mux/it5205.c

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index d2cb5e733e57..399c7b0983df 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -36,6 +36,16 @@ config TYPEC_MUX_INTEL_PMC
 	  control the USB role switch and also the multiplexer/demultiplexer
 	  switches used with USB Type-C Alternate Modes.
 
+config TYPEC_MUX_IT5205
+	tristate "ITE IT5205 Type-C USB Alt Mode Passive MUX driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Driver for the ITE IT5205 Type-C USB Alternate Mode Passive MUX
+	  which provides support for muxing DisplayPort and sideband signals
+	  on a common USB Type-C connector.
+	  If compiled as a module, the module will be named it5205.
+
 config TYPEC_MUX_NB7VPQ904M
 	tristate "On Semiconductor NB7VPQ904M Type-C redriver driver"
 	depends on I2C
diff --git a/drivers/usb/typec/mux/Makefile b/drivers/usb/typec/mux/Makefile
index 57dc9ac6f8dc..bb96f30267af 100644
--- a/drivers/usb/typec/mux/Makefile
+++ b/drivers/usb/typec/mux/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_TYPEC_MUX_FSA4480)		+= fsa4480.o
 obj-$(CONFIG_TYPEC_MUX_GPIO_SBU)	+= gpio-sbu-mux.o
 obj-$(CONFIG_TYPEC_MUX_PI3USB30532)	+= pi3usb30532.o
 obj-$(CONFIG_TYPEC_MUX_INTEL_PMC)	+= intel_pmc_mux.o
+obj-$(CONFIG_TYPEC_MUX_IT5205)		+= it5205.o
 obj-$(CONFIG_TYPEC_MUX_NB7VPQ904M)	+= nb7vpq904m.o
 obj-$(CONFIG_TYPEC_MUX_PTN36502)	+= ptn36502.o
 obj-$(CONFIG_TYPEC_MUX_WCD939X_USBSS)	+= wcd939x-usbss.o
diff --git a/drivers/usb/typec/mux/it5205.c b/drivers/usb/typec/mux/it5205.c
new file mode 100644
index 000000000000..99203b8a086d
--- /dev/null
+++ b/drivers/usb/typec/mux/it5205.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ITE IT5205 Type-C USB alternate mode passive mux
+ *
+ * Copyright (c) 2020 MediaTek Inc.
+ * Copyright (c) 2024 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ *
+ */
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/usb/typec.h>
+#include <linux/usb/typec_mux.h>
+#include <linux/usb/typec_dp.h>
+#include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio.h>
+#include <linux/usb/tcpm.h>
+
+#define IT5205_REG_CHIP_ID(x)	(0x4 + (x))
+#define IT5205FN_CHIP_ID	0x35323035 /* "5205" */
+
+/* MUX power down register */
+#define IT5205_REG_MUXPDR        0x10
+#define IT5205_MUX_POWER_DOWN    BIT(0)
+
+/* MUX control register */
+#define IT5205_REG_MUXCR         0x11
+#define IT5205_POLARITY_INVERTED BIT(4)
+#define IT5205_DP_USB_CTRL_MASK  GENMASK(3, 0)
+#define IT5205_DP                0x0f
+#define IT5205_DP_USB            0x03
+#define IT5205_USB               0x07
+
+/* Vref Select Register */
+#define IT5205_REG_VSR            0x10
+#define IT5205_VREF_SELECT_MASK   GENMASK(5, 4)
+#define IT5205_VREF_SELECT_3_3V   0x00
+#define IT5205_VREF_SELECT_OFF    0x20
+
+/* CSBU Over Voltage Protection Register */
+#define IT5205_REG_CSBUOVPSR      0x1e
+#define IT5205_OVP_SELECT_MASK    GENMASK(5, 4)
+#define IT5205_OVP_3_90V          0x00
+#define IT5205_OVP_3_68V          0x10
+#define IT5205_OVP_3_62V          0x20
+#define IT5205_OVP_3_57V          0x30
+
+/* CSBU Switch Register */
+#define IT5205_REG_CSBUSR         0x22
+#define IT5205_CSBUSR_SWITCH      BIT(0)
+
+/* Interrupt Switch Register */
+#define IT5205_REG_ISR            0x25
+#define IT5205_ISR_CSBU_MASK      BIT(4)
+#define IT5205_ISR_CSBU_OVP       BIT(0)
+
+struct it5205 {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct typec_switch_dev *sw;
+	struct typec_mux_dev *mux;
+};
+
+static int it5205_switch_set(struct typec_switch_dev *sw, enum typec_orientation orientation)
+{
+	struct it5205 *it = typec_switch_get_drvdata(sw);
+
+	switch (orientation) {
+	case TYPEC_ORIENTATION_NORMAL:
+		regmap_update_bits(it->regmap, IT5205_REG_MUXCR,
+				   IT5205_POLARITY_INVERTED, 0);
+		break;
+	case TYPEC_ORIENTATION_REVERSE:
+		regmap_update_bits(it->regmap, IT5205_REG_MUXCR,
+				   IT5205_POLARITY_INVERTED, IT5205_POLARITY_INVERTED);
+		break;
+	case TYPEC_ORIENTATION_NONE:
+		fallthrough;
+	default:
+		regmap_write(it->regmap, IT5205_REG_MUXCR, 0);
+		break;
+	}
+
+	return 0;
+}
+
+static int it5205_mux_set(struct typec_mux_dev *mux, struct typec_mux_state *state)
+{
+	struct it5205 *it = typec_mux_get_drvdata(mux);
+	u8 val;
+
+	switch (state->mode) {
+	case TYPEC_STATE_USB:
+		val = IT5205_USB;
+		break;
+	case TYPEC_DP_STATE_C:
+		fallthrough;
+	case TYPEC_DP_STATE_E:
+		val = IT5205_DP;
+		break;
+	case TYPEC_DP_STATE_D:
+		val = IT5205_DP_USB;
+		break;
+	case TYPEC_STATE_SAFE:
+		fallthrough;
+	default:
+		val = 0;
+		break;
+	}
+
+	return regmap_update_bits(it->regmap, IT5205_REG_MUXCR,
+				  IT5205_DP_USB_CTRL_MASK, val);
+}
+
+static irqreturn_t it5205_irq_handler(int irq, void *data)
+{
+	struct it5205 *it = data;
+	int ret;
+	u32 val;
+
+	ret = regmap_read(it->regmap, IT5205_REG_ISR, &val);
+	if (ret)
+		return IRQ_NONE;
+
+	if (val & IT5205_ISR_CSBU_OVP) {
+		dev_warn(&it->client->dev, "Overvoltage detected!\n");
+
+		/* Reset CSBU */
+		regmap_update_bits(it->regmap, IT5205_REG_CSBUSR,
+				   IT5205_CSBUSR_SWITCH, 0);
+		regmap_update_bits(it->regmap, IT5205_REG_CSBUSR,
+				   IT5205_CSBUSR_SWITCH, IT5205_CSBUSR_SWITCH);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void it5205_enable_ovp(struct it5205 *it)
+{
+	/* Select Vref 3.3v */
+	regmap_update_bits(it->regmap, IT5205_REG_VSR,
+			   IT5205_VREF_SELECT_MASK, IT5205_VREF_SELECT_3_3V);
+
+	/* Trigger OVP at 3.68V */
+	regmap_update_bits(it->regmap, IT5205_REG_CSBUOVPSR,
+			   IT5205_OVP_SELECT_MASK, IT5205_OVP_3_68V);
+
+	/* Unmask OVP interrupt */
+	regmap_update_bits(it->regmap, IT5205_REG_ISR,
+			   IT5205_ISR_CSBU_MASK, 0);
+
+	/* Enable CSBU Interrupt */
+	regmap_update_bits(it->regmap, IT5205_REG_CSBUSR,
+			   IT5205_CSBUSR_SWITCH, IT5205_CSBUSR_SWITCH);
+}
+
+static const struct regmap_config it5205_regmap = {
+	.max_register = 0x2f,
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int it5205_probe(struct i2c_client *client)
+{
+	struct typec_switch_desc sw_desc = { };
+	struct typec_mux_desc mux_desc = { };
+	struct device *dev = &client->dev;
+	struct it5205 *it;
+	u32 val, chipid = 0;
+	int i, ret;
+
+	it = devm_kzalloc(dev, sizeof(*it), GFP_KERNEL);
+	if (!it)
+		return -ENOMEM;
+
+	ret = devm_regulator_get_enable(dev, "vcc");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get regulator\n");
+
+	it->client = client;
+
+	it->regmap = devm_regmap_init_i2c(client, &it5205_regmap);
+	if (IS_ERR(it->regmap))
+		return dev_err_probe(dev, PTR_ERR(it->regmap),
+				     "Failed to init regmap\n");
+
+	/* IT5205 needs a long time to power up after enabling regulator */
+	msleep(50);
+
+	/* Unset poweroff bit */
+	ret = regmap_write(it->regmap, IT5205_REG_MUXPDR, 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set power on\n");
+
+	/* Read the 32 bits ChipID */
+	for (i = 3; i >= 0; i--) {
+		ret = regmap_read(it->regmap, IT5205_REG_CHIP_ID(i), &val);
+		if (ret)
+			return ret;
+
+		chipid |= val << (i * 8);
+	}
+
+	if (chipid != IT5205FN_CHIP_ID)
+		return dev_err_probe(dev, -EINVAL,
+				     "Unknown ChipID 0x%x\n", chipid);
+
+	/* Initialize as USB mode with default (non-inverted) polarity */
+	ret = regmap_write(it->regmap, IT5205_REG_MUXCR, IT5205_USB);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot set mode to USB\n");
+
+	sw_desc.drvdata = it;
+	sw_desc.fwnode = dev_fwnode(dev);
+	sw_desc.set = it5205_switch_set;
+
+	it->sw = typec_switch_register(dev, &sw_desc);
+	if (IS_ERR(it->sw))
+		return dev_err_probe(dev, PTR_ERR(it->sw),
+				     "failed to register typec switch\n");
+
+	mux_desc.drvdata = it;
+	mux_desc.fwnode = dev_fwnode(dev);
+	mux_desc.set = it5205_mux_set;
+
+	it->mux = typec_mux_register(dev, &mux_desc);
+	if (IS_ERR(it->mux)) {
+		typec_switch_unregister(it->sw);
+		return dev_err_probe(dev, PTR_ERR(it->mux),
+				     "failed to register typec mux\n");
+	}
+
+	i2c_set_clientdata(client, it);
+
+	if (of_property_read_bool(dev->of_node, "ite,ovp-enable") && client->irq) {
+		it5205_enable_ovp(it);
+
+		ret = devm_request_threaded_irq(dev, client->irq, NULL,
+						it5205_irq_handler,
+						IRQF_ONESHOT, dev_name(dev), it);
+		if (ret) {
+			typec_mux_unregister(it->mux);
+			typec_switch_unregister(it->sw);
+			return dev_err_probe(dev, ret, "Failed to request irq\n");
+		}
+	}
+
+	return 0;
+}
+
+static void it5205_remove(struct i2c_client *client)
+{
+	struct it5205 *it = i2c_get_clientdata(client);
+
+	typec_mux_unregister(it->mux);
+	typec_switch_unregister(it->sw);
+}
+
+static const struct i2c_device_id it5205_table[] = {
+	{ "it5205" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, it5205_table);
+
+static const struct of_device_id it5205_of_table[] = {
+	{ .compatible = "ite,it5205" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, it5205_match_table);
+
+static struct i2c_driver it5205_driver = {
+	.driver = {
+		.name = "it5205",
+		.of_match_table = it5205_of_table,
+	},
+	.probe = it5205_probe,
+	.remove = it5205_remove,
+	.id_table = it5205_table,
+};
+module_i2c_driver(it5205_driver);
+
+MODULE_AUTHOR("Tianping Fang <tianping.fang@mediatek.com>");
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_DESCRIPTION("ITE IT5205 alternate mode passive MUX driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


