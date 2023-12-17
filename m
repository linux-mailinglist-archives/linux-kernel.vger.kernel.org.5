Return-Path: <linux-kernel+bounces-2602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F81F815F49
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91F5B22595
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC23374CA;
	Sun, 17 Dec 2023 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="P9Bgm7UJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5844361;
	Sun, 17 Dec 2023 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 9949A28C345;
	Sun, 17 Dec 2023 14:20:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1702819220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wvYhe1HTlC8OK5D+YolHQgHF1zQFZby+es+2ouNx1Xs=;
	b=P9Bgm7UJ7B4AQnlFt8wC6YQFn6BmjMCEvD222Liu+ojmLi0cuHg/h9IgLHLo419ur899Q2
	eTS3u9VtyIEbY6FAo9JmkE61k9k4JWI7ghgAxtDO2yHgh5CBu3ZvG7uIwExbJo6OmLYyBh
	F7S3snrgBCpZnlqU9QtEKyy1SNeRb+U=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 75ADD44AF99;
	Sun, 17 Dec 2023 14:20:20 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH 2/5] mfd: add 88pm88x driver
Date: Sun, 17 Dec 2023 14:17:00 +0100
Message-ID: <20231217131838.7569-3-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
References: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

Marvell 88PM880 and 8PM886 are two similar PMICs with mostly matching
register mapping. They provide various functions such as onkey, battery,
charger and regulators.

Add support for 88PM886 found for instance in the samsung,coreprimevelte
smartphone with which this was tested. Support for 88PM880 is not
implemented here but should be straightforward to add.

Implement only the most basic support omitting the currently unused
registers and I2C subclients which should thus be added with the
respective subdevices. However, add support for the onkey already.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 drivers/mfd/88pm88x.c       | 199 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig         |  11 ++
 drivers/mfd/Makefile        |   1 +
 include/linux/mfd/88pm88x.h |  60 +++++++++++
 4 files changed, 271 insertions(+)
 create mode 100644 drivers/mfd/88pm88x.c
 create mode 100644 include/linux/mfd/88pm88x.h

diff --git a/drivers/mfd/88pm88x.c b/drivers/mfd/88pm88x.c
new file mode 100644
index 000000000000..5db6c65b667d
--- /dev/null
+++ b/drivers/mfd/88pm88x.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/mfd/core.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+
+#include <linux/mfd/88pm88x.h>
+
+/* interrupt status registers */
+#define PM88X_REG_INT_STATUS1			0x05
+
+#define PM88X_REG_INT_ENA_1			0x0a
+#define PM88X_INT_ENA1_ONKEY			BIT(0)
+
+enum pm88x_irq_number {
+	PM88X_IRQ_ONKEY,
+
+	PM88X_MAX_IRQ
+};
+
+static struct regmap_irq pm88x_regmap_irqs[] = {
+	REGMAP_IRQ_REG(PM88X_IRQ_ONKEY, 0, PM88X_INT_ENA1_ONKEY),
+};
+
+static struct regmap_irq_chip pm88x_regmap_irq_chip = {
+	.name = "88pm88x",
+	.irqs = pm88x_regmap_irqs,
+	.num_irqs = ARRAY_SIZE(pm88x_regmap_irqs),
+	.num_regs = 4,
+	.status_base = PM88X_REG_INT_STATUS1,
+	.ack_base = PM88X_REG_INT_STATUS1,
+	.unmask_base = PM88X_REG_INT_ENA_1,
+};
+
+static struct reg_sequence pm886_presets[] = {
+	/* disable watchdog */
+	REG_SEQ0(PM88X_REG_WDOG, 0x01),
+	/* GPIO1: DVC, GPIO0: input */
+	REG_SEQ0(PM88X_REG_GPIO_CTRL1, 0x40),
+	/* GPIO2: input */
+	REG_SEQ0(PM88X_REG_GPIO_CTRL2, 0x00),
+	/* DVC2, DVC1 */
+	REG_SEQ0(PM88X_REG_GPIO_CTRL3, 0x44),
+	/* GPIO5V_1:input, GPIO5V_2: input */
+	REG_SEQ0(PM88X_REG_GPIO_CTRL4, 0x00),
+	/* output 32 kHz from XO */
+	REG_SEQ0(PM88X_REG_AON_CTRL2, 0x2a),
+	/* OSC_FREERUN = 1, to lock FLL */
+	REG_SEQ0(PM88X_REG_BK_OSC_CTRL1, 0x0f),
+	/* XO_LJ = 1, enable low jitter for 32 kHz */
+	REG_SEQ0(PM88X_REG_LOWPOWER2, 0x20),
+	/* OV_VSYS and UV_VSYS1 comparators on VSYS disabled, VSYS_OVER_TH : 5.6V */
+	REG_SEQ0(PM88X_REG_LOWPOWER4, 0xc8),
+	/* set the duty cycle of charger DC/DC to max */
+	REG_SEQ0(PM88X_REG_BK_OSC_CTRL3, 0xc0),
+};
+
+static struct resource onkey_resources[] = {
+	DEFINE_RES_IRQ_NAMED(PM88X_IRQ_ONKEY, "88pm88x-onkey"),
+};
+
+static struct mfd_cell pm88x_devs[] = {
+	{
+		.name = "88pm88x-onkey",
+		.num_resources = ARRAY_SIZE(onkey_resources),
+		.resources = onkey_resources,
+		.id = -1,
+	},
+};
+
+static struct pm88x_data pm886_a1_data = {
+	.whoami = PM886_A1_WHOAMI,
+	.presets = pm886_presets,
+	.num_presets = ARRAY_SIZE(pm886_presets),
+};
+
+static const struct regmap_config pm88x_i2c_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0xfe,
+};
+
+static int pm88x_power_off_handler(struct sys_off_data *data)
+{
+	struct pm88x_chip *chip = data->cb_data;
+	int ret;
+
+	ret = regmap_update_bits(chip->regmaps[PM88X_REGMAP_BASE], PM88X_REG_MISC_CONFIG1,
+			PM88X_SW_PDOWN, PM88X_SW_PDOWN);
+	if (ret) {
+		dev_err(&chip->client->dev, "Failed to power off the device: %d\n", ret);
+		return NOTIFY_BAD;
+	}
+	return NOTIFY_DONE;
+}
+
+static int pm88x_setup_irq(struct pm88x_chip *chip)
+{
+	int ret;
+
+	/* set interrupt clearing mode to clear on write */
+	ret = regmap_update_bits(chip->regmaps[PM88X_REGMAP_BASE], PM88X_REG_MISC_CONFIG2,
+			PM88X_INT_INV | PM88X_INT_CLEAR | PM88X_INT_MASK_MODE,
+			PM88X_INT_WC);
+	if (ret) {
+		dev_err(&chip->client->dev, "Failed to set interrupt clearing mode: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_regmap_add_irq_chip(&chip->client->dev, chip->regmaps[PM88X_REGMAP_BASE],
+			chip->client->irq, IRQF_ONESHOT, -1, &pm88x_regmap_irq_chip,
+			&chip->irq_data);
+	if (ret) {
+		dev_err(&chip->client->dev, "Failed to request IRQ: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int pm88x_probe(struct i2c_client *client)
+{
+	struct pm88x_chip *chip;
+	int ret = 0;
+	unsigned int chip_id;
+
+	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->client = client;
+	chip->data = device_get_match_data(&client->dev);
+	i2c_set_clientdata(client, chip);
+
+	device_init_wakeup(&client->dev, 1);
+
+	chip->regmaps[PM88X_REGMAP_BASE] = devm_regmap_init_i2c(client, &pm88x_i2c_regmap);
+	if (IS_ERR(chip->regmaps[PM88X_REGMAP_BASE])) {
+		ret = PTR_ERR(chip->regmaps[PM88X_REGMAP_BASE]);
+		dev_err(&client->dev, "Failed to initialize regmap: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_read(chip->regmaps[PM88X_REGMAP_BASE], PM88X_REG_ID, &chip_id);
+	if (ret) {
+		dev_err(&client->dev, "Failed to read chip ID: %d\n", ret);
+		return ret;
+	}
+	if (chip->data->whoami != chip_id) {
+		dev_err(&client->dev, "Device reported wrong chip ID: %u\n", chip_id);
+		return -EINVAL;
+	}
+
+	ret = pm88x_setup_irq(chip);
+	if (ret)
+		return ret;
+
+	ret = devm_mfd_add_devices(&client->dev, 0, pm88x_devs, ARRAY_SIZE(pm88x_devs),
+			NULL, 0, regmap_irq_get_domain(chip->irq_data));
+	if (ret) {
+		dev_err(&client->dev, "Failed to add devices: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_register_patch(chip->regmaps[PM88X_REGMAP_BASE], chip->data->presets,
+			chip->data->num_presets);
+	if (ret) {
+		dev_err(&client->dev, "Failed to register regmap patch: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_register_power_off_handler(&client->dev, pm88x_power_off_handler, chip);
+	if (ret) {
+		dev_err(&client->dev, "Failed to register power off handler: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+const struct of_device_id pm88x_of_match[] = {
+	{ .compatible = "marvell,88pm886-a1", .data = &pm886_a1_data },
+	{ },
+};
+
+static struct i2c_driver pm88x_i2c_driver = {
+	.driver = {
+		.name = "88pm88x",
+		.of_match_table = of_match_ptr(pm88x_of_match),
+	},
+	.probe = pm88x_probe,
+};
+module_i2c_driver(pm88x_i2c_driver);
+
+MODULE_DESCRIPTION("Marvell 88PM88X PMIC driver");
+MODULE_AUTHOR("Karel Balej <balejk@matfyz.cz>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 90ce58fd629e..c593279fd766 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -794,6 +794,17 @@ config MFD_88PM860X
 	  select individual components like voltage regulators, RTC and
 	  battery-charger under the corresponding menus.
 
+config MFD_88PM88X
+	bool "Marvell 88PM886"
+	depends on I2C=y
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	select MFD_CORE
+	help
+	  This enables support for Marvell 88PM886 Power Management IC.
+	  This includes the I2C driver and the core APIs _only_, you have to
+	  select individual components like onkey under the corresponding menus.
+
 config MFD_MAX14577
 	tristate "Maxim Semiconductor MAX14577/77836 MUIC + Charger Support"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index c66f07edcd0e..14e42b045c92 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x.o
 obj-$(CONFIG_MFD_88PM800)	+= 88pm800.o 88pm80x.o
 obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
+obj-$(CONFIG_MFD_88PM88X)	+= 88pm88x.o
 obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
 obj-$(CONFIG_MFD_SM501)		+= sm501.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
diff --git a/include/linux/mfd/88pm88x.h b/include/linux/mfd/88pm88x.h
new file mode 100644
index 000000000000..a34c57447827
--- /dev/null
+++ b/include/linux/mfd/88pm88x.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __LINUX_MFD_88PM88X_H
+#define __LINUX_MFD_88PM88X_H
+
+#include <linux/mfd/core.h>
+
+#define PM886_A1_WHOAMI		0xa1
+
+#define PM88X_REG_ID			0x00
+
+#define PM88X_REG_STATUS1		0x01
+#define PM88X_ONKEY_STS1		BIT(0)
+
+#define PM88X_REG_MISC_CONFIG1		0x14
+#define PM88X_SW_PDOWN			BIT(5)
+
+#define PM88X_REG_MISC_CONFIG2		0x15
+#define PM88X_INT_INV			BIT(0)
+#define PM88X_INT_CLEAR			BIT(1)
+#define PM88X_INT_RC			0x00
+#define PM88X_INT_WC			BIT(1)
+#define PM88X_INT_MASK_MODE		BIT(2)
+
+#define PM88X_REG_WDOG			0x1d
+
+#define PM88X_REG_LOWPOWER2		0x21
+#define PM88X_REG_LOWPOWER4		0x23
+
+#define PM88X_REG_GPIO_CTRL1		0x30
+
+#define PM88X_REG_GPIO_CTRL2		0x31
+
+#define PM88X_REG_GPIO_CTRL3		0x32
+
+#define PM88X_REG_GPIO_CTRL4		0x33
+
+#define PM88X_REG_BK_OSC_CTRL1		0x50
+#define PM88X_REG_BK_OSC_CTRL3		0x52
+
+#define PM88X_REG_AON_CTRL2		0xe2
+
+enum pm88x_regmap_index {
+	PM88X_REGMAP_BASE,
+
+	PM88X_REGMAP_NR
+};
+
+struct pm88x_data {
+	unsigned int whoami;
+	struct reg_sequence *presets;
+	unsigned int num_presets;
+};
+
+struct pm88x_chip {
+	struct i2c_client *client;
+	struct regmap_irq_chip_data *irq_data;
+	const struct pm88x_data *data;
+	struct regmap *regmaps[PM88X_REGMAP_NR];
+};
+#endif /* __LINUX_MFD_88PM88X_H */
-- 
2.43.0


