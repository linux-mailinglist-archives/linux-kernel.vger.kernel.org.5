Return-Path: <linux-kernel+bounces-99174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E38878478
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF87E1F2141B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C21947F63;
	Mon, 11 Mar 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="amxbtUyL"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFAF4CB2B;
	Mon, 11 Mar 2024 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172919; cv=none; b=aM10hzXuNohtM+pS6WpOKr3bsuIiKMBl8s1v3h/O1UPdEXCOs4J4YOkdc58LN0X6McOHOvm7FvmgQc45b8sUWm0EmxQfpHNcBr1PyjmTTtfrcy0+5ydLLxxKV5M63ld2azduO7BC+O2zhLwxOJyTYm6p5+/kQhjGqtxC7hah9GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172919; c=relaxed/simple;
	bh=OC6W03HD5w5XzvIUse7kOpoUdYLAdyN2h9g5MsyIFf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOB3I3JzSbed3zDSwuTU96gsvNqje5V7iCDF+zWVN9FC2jcHvlZromuk0hbSqze/pkSHQx1En6ntUqYAozlGpeWpBZCWqV7NVtf6VYZIDW9SHVZ9oCSaTxr8RUgyZWP+JKQdMoxziFVfnqAgi1S6rdJAq75Sgkrlxrog5hpoKGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=amxbtUyL; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id AE56E284712;
	Mon, 11 Mar 2024 17:01:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1710172913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DL6xFHGXFNPD+ftT31HPFoLwwjNBtmulha/FNOeYtwI=;
	b=amxbtUyLKj3cfPpHtGbG2w7Z3T41tpCqqfbiuxkWfy1eRzy2l66T4RvwC+oLUn4tLqAoGH
	rgGlTZm4wiyAu5HoNwPpV8oWNlFgTCApSuwx2quDxEeUEwkEn0dz4Ith0NbPA1axzxMiPo
	OfEqLz6VGg48rYe8+rgD4xBsoIPGHmU=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 8AEAD45665F;
	Mon, 11 Mar 2024 17:01:53 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH v4 2/5] mfd: add driver for Marvell 88PM886 PMIC
Date: Mon, 11 Mar 2024 16:51:54 +0100
Message-ID: <20240311160110.32185-3-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311160110.32185-1-karelb@gimli.ms.mff.cuni.cz>
References: <20240311160110.32185-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

Marvell 88PM886 is a PMIC which provides various functions such as
onkey, battery, charger and regulators. It is found for instance in the
samsung,coreprimevelte smartphone with which this was tested. Implement
basic support to allow for the use of regulators and onkey.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    RFC v4:
    - Use MFD_CELL_* macros.
    - Address Lee's feedback:
      - Do not define regmap_config.val_bits and .reg_bits.
      - Drop everything regulator related except mfd_cell (regmap
        initialization, IDs enum etc.). Drop pm886_initialize_subregmaps.
      - Do not store regmap pointers as an array as there is now only one
        regmap. Also drop the corresponding enum.
      - Move regmap_config to the header as it is needed in the regulators
        driver.
      - pm886_chip.whoami -> chip_id
      - Reword chip ID mismatch error message and print the ID as
        hexadecimal.
      - Fix includes in include/linux/88pm886.h.
      - Drop the pm886_irq_number enum and define the (for the moment) only
        IRQ explicitly.
    - Have only one MFD cell for all regulators as they are now registered
      all at once in the regulators driver.
    - Reword commit message.
    - Make device table static and remove comma after the sentinel to signal
      that nothing should come after it.
    RFC v3:
    - Drop onkey cell .of_compatible.
    - Rename LDO page offset and regmap to REGULATORS.
    RFC v2:
    - Remove some abstraction.
    - Sort includes alphabetically and add linux/of.h.
    - Depend on OF, remove of_match_ptr and add MODULE_DEVICE_TABLE.
    - Use more temporaries and break long lines.
    - Do not initialize ret in probe.
    - Use the wakeup-source DT property.
    - Rename ret to err.
    - Address Lee's comments:
      - Drop patched in presets for base regmap and related defines.
      - Use full sentences in comments.
      - Remove IRQ comment.
      - Define regmap_config member values.
      - Rename data to sys_off_data.
      - Add _PMIC suffix to Kconfig.
      - Use dev_err_probe.
      - Do not store irq_data.
      - s/WHOAMI/CHIP_ID
      - Drop LINUX part of include guard name.
      - Merge in the regulator series modifications in order to have more
        devices and modify the commit message accordingly. Changes with
        respect to the original regulator series patches:
        - ret -> err
        - Add temporary for dev in pm88x_initialize_subregmaps.
        - Drop of_compatible for the regulators.
        - Do not duplicate LDO regmap for bucks.
    - Rewrite commit message.

 drivers/mfd/88pm886.c       | 149 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig         |  12 +++
 drivers/mfd/Makefile        |   1 +
 include/linux/mfd/88pm886.h |  38 +++++++++
 4 files changed, 200 insertions(+)
 create mode 100644 drivers/mfd/88pm886.c
 create mode 100644 include/linux/mfd/88pm886.h

diff --git a/drivers/mfd/88pm886.c b/drivers/mfd/88pm886.c
new file mode 100644
index 000000000000..88f21f813ec1
--- /dev/null
+++ b/drivers/mfd/88pm886.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/i2c.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/88pm886.h>
+
+#define PM886_REG_INT_STATUS1			0x05
+
+#define PM886_REG_INT_ENA_1			0x0a
+#define PM886_INT_ENA1_ONKEY			BIT(0)
+
+#define PM886_IRQ_ONKEY				0
+
+static struct regmap_irq pm886_regmap_irqs[] = {
+	REGMAP_IRQ_REG(PM886_IRQ_ONKEY, 0, PM886_INT_ENA1_ONKEY),
+};
+
+static struct regmap_irq_chip pm886_regmap_irq_chip = {
+	.name = "88pm886",
+	.irqs = pm886_regmap_irqs,
+	.num_irqs = ARRAY_SIZE(pm886_regmap_irqs),
+	.num_regs = 4,
+	.status_base = PM886_REG_INT_STATUS1,
+	.ack_base = PM886_REG_INT_STATUS1,
+	.unmask_base = PM886_REG_INT_ENA_1,
+};
+
+static struct resource pm886_onkey_resources[] = {
+	DEFINE_RES_IRQ_NAMED(PM886_IRQ_ONKEY, "88pm886-onkey"),
+};
+
+static struct mfd_cell pm886_devs[] = {
+	MFD_CELL_RES("88pm886-onkey", pm886_onkey_resources),
+	MFD_CELL_NAME("88pm886-regulator"),
+};
+
+static int pm886_power_off_handler(struct sys_off_data *sys_off_data)
+{
+	struct pm886_chip *chip = sys_off_data->cb_data;
+	struct regmap *regmap = chip->regmap;
+	struct device *dev = &chip->client->dev;
+	int err;
+
+	err = regmap_update_bits(regmap, PM886_REG_MISC_CONFIG1, PM886_SW_PDOWN,
+				PM886_SW_PDOWN);
+	if (err) {
+		dev_err(dev, "Failed to power off the device: %d\n", err);
+		return NOTIFY_BAD;
+	}
+	return NOTIFY_DONE;
+}
+
+static int pm886_setup_irq(struct pm886_chip *chip,
+		struct regmap_irq_chip_data **irq_data)
+{
+	struct regmap *regmap = chip->regmap;
+	struct device *dev = &chip->client->dev;
+	int err;
+
+	/* Set interrupt clearing mode to clear on write. */
+	err = regmap_update_bits(regmap, PM886_REG_MISC_CONFIG2,
+			PM886_INT_INV | PM886_INT_CLEAR | PM886_INT_MASK_MODE,
+			PM886_INT_WC);
+	if (err) {
+		dev_err(dev, "Failed to set interrupt clearing mode: %d\n", err);
+		return err;
+	}
+
+	err = devm_regmap_add_irq_chip(dev, regmap, chip->client->irq,
+					IRQF_ONESHOT, -1, &pm886_regmap_irq_chip,
+					irq_data);
+	if (err) {
+		dev_err(dev, "Failed to request IRQ: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int pm886_probe(struct i2c_client *client)
+{
+	struct regmap_irq_chip_data *irq_data;
+	struct device *dev = &client->dev;
+	struct pm886_chip *chip;
+	struct regmap *regmap;
+	unsigned int chip_id;
+	int err;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->client = client;
+	chip->chip_id = (uintptr_t)device_get_match_data(dev);
+	i2c_set_clientdata(client, chip);
+
+	regmap = devm_regmap_init_i2c(client, &pm886_i2c_regmap);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to initialize regmap\n");
+	chip->regmap = regmap;
+
+	err = regmap_read(regmap, PM886_REG_ID, &chip_id);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to read chip ID\n");
+
+	if (chip->chip_id != chip_id)
+		return dev_err_probe(dev, -EINVAL, "Unsupported chip: 0x%x\n", chip_id);
+
+	err = pm886_setup_irq(chip, &irq_data);
+	if (err)
+		return err;
+
+	err = devm_mfd_add_devices(dev, 0, pm886_devs, ARRAY_SIZE(pm886_devs),
+				NULL, 0, regmap_irq_get_domain(irq_data));
+	if (err)
+		return dev_err_probe(dev, err, "Failed to add devices\n");
+
+	err = devm_register_power_off_handler(dev, pm886_power_off_handler, chip);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to register power off handler\n");
+
+	device_init_wakeup(dev, device_property_read_bool(dev, "wakeup-source"));
+
+	return 0;
+}
+
+static const struct of_device_id pm886_of_match[] = {
+	{ .compatible = "marvell,88pm886-a1", .data = (void *)PM886_A1_CHIP_ID },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pm886_of_match);
+
+static struct i2c_driver pm886_i2c_driver = {
+	.driver = {
+		.name = "88pm886",
+		.of_match_table = pm886_of_match,
+	},
+	.probe = pm886_probe,
+};
+module_i2c_driver(pm886_i2c_driver);
+
+MODULE_DESCRIPTION("Marvell 88PM886 PMIC driver");
+MODULE_AUTHOR("Karel Balej <balejk@matfyz.cz>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index e7a6e45b9fac..9ef921c59f30 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -794,6 +794,18 @@ config MFD_88PM860X
 	  select individual components like voltage regulators, RTC and
 	  battery-charger under the corresponding menus.
 
+config MFD_88PM886_PMIC
+	bool "Marvell 88PM886 PMIC"
+	depends on I2C=y
+	depends on OF
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
index c66f07edcd0e..d016b7fed354 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x.o
 obj-$(CONFIG_MFD_88PM800)	+= 88pm800.o 88pm80x.o
 obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
+obj-$(CONFIG_MFD_88PM886_PMIC)	+= 88pm886.o
 obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
 obj-$(CONFIG_MFD_SM501)		+= sm501.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
diff --git a/include/linux/mfd/88pm886.h b/include/linux/mfd/88pm886.h
new file mode 100644
index 000000000000..a5e6524bb19d
--- /dev/null
+++ b/include/linux/mfd/88pm886.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __MFD_88PM886_H
+#define __MFD_88PM886_H
+
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+#define PM886_A1_CHIP_ID		0xa1
+
+#define PM886_REGMAP_CONF_MAX_REG	0xfe
+
+#define PM886_REG_ID			0x00
+
+#define PM886_REG_STATUS1		0x01
+#define PM886_ONKEY_STS1		BIT(0)
+
+#define PM886_REG_MISC_CONFIG1		0x14
+#define PM886_SW_PDOWN			BIT(5)
+
+#define PM886_REG_MISC_CONFIG2		0x15
+#define PM886_INT_INV			BIT(0)
+#define PM886_INT_CLEAR			BIT(1)
+#define PM886_INT_RC			0x00
+#define PM886_INT_WC			BIT(1)
+#define PM886_INT_MASK_MODE		BIT(2)
+
+struct pm886_chip {
+	struct i2c_client *client;
+	unsigned int chip_id;
+	struct regmap *regmap;
+};
+
+static const struct regmap_config pm886_i2c_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = PM886_REGMAP_CONF_MAX_REG,
+};
+#endif /* __MFD_88PM886_H */
-- 
2.44.0


