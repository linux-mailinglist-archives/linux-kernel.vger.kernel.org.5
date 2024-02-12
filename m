Return-Path: <linux-kernel+bounces-62057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF703851ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E4E1F29B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376074EB2E;
	Mon, 12 Feb 2024 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mP440zFv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABCD4CB55;
	Mon, 12 Feb 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757499; cv=none; b=HjNE7/BbVJWdEYwiDb2hiV6l/VNgn3BLvCNPyiaDE4tTzN2kDjgQm/vVsbzIoz6hwDdfIk1qtAAW/NAtb8x6c/Zh7yEfderwT/lH95iMI6/Lnb7KZx4Pr2HNgW+12F5iymmzOs7fa7W9M9num+ksVsv5rHBn/vqFA7sTgmleGBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757499; c=relaxed/simple;
	bh=v6wTWOcgnBbdVRVq0vTx2zi8kxA67Ld9K3m1TKyiM1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0heQ/feYW9kg8ye6UedVXsu73+092ISBwrA8IocMr2Qj275NbJI47n7QtTQO0bo0cZuEZC9Y/5VPVOvM28s+1aA8cJJjI05zDezuy45PSvfunJUFEUf0CC7BNSkXArQt0KVGAkbWVp20W0d+vIEiqQhVb9l0Hmjg9MtgUyHMEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mP440zFv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707757498; x=1739293498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v6wTWOcgnBbdVRVq0vTx2zi8kxA67Ld9K3m1TKyiM1Q=;
  b=mP440zFvoBdSr7zyr+42Ec/IzOKZd6ODy1GFnvG+CYdtyOiPC4XhGE8G
   zM7WulTm8Olilx4PKWzfwG8+QYB1HlEkpYNMOGiqb/6YT/vako1ju1B1s
   qJl28oofdVrSEY8ftOMSmEqqQgxpaQDfgX7g+Sd3Bml5TJIjI8BVKTp+C
   SEEbLG1klni1GYnabCViX/Ya6JFjVU4dKQD2gsTBvJQ9eTPNO0x6/kqz0
   dDMX+oCM7/0SFsOTMsd1eXus5UtGBILfFC1w9kq7n/1Ag1OYb0xRv4rlq
   UjNUUnE21mP6WlP0RLjrMUpB3cKqcBq3ufeKkwwOXcuZlzVS5Lw7pZeUM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19153247"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19153247"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:04:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935116836"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935116836"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 09:04:50 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4740C4E9; Mon, 12 Feb 2024 19:04:43 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: [PATCH v2 15/15] auxdisplay: Add driver for MAX695x 7-segment LED controllers
Date: Mon, 12 Feb 2024 19:01:48 +0200
Message-ID: <20240212170423.2860895-16-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial driver for the MAX6958 and MAX6959 7-segment LED
controllers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/Kconfig   |  14 +++
 drivers/auxdisplay/Makefile  |   1 +
 drivers/auxdisplay/max6959.c | 200 +++++++++++++++++++++++++++++++++++
 3 files changed, 215 insertions(+)
 create mode 100644 drivers/auxdisplay/max6959.c

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index a34a9a52158f..079d58bb0293 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -187,6 +187,20 @@ config HT16K33
 	  Say yes here to add support for Holtek HT16K33, RAM mapping 16*8
 	  LED controller driver with keyscan.
 
+config MAX6959
+	tristate "Maxim MAX6958/6959 7-segment LED controller with keyscan"
+	depends on I2C
+	select REGMAP_I2C
+	select LINEDISP
+	help
+	  If you say yes here you get support for the following Maxim chips
+	  (I2C 7-segment LED display controller with keyscan):
+	  - MAX6958
+	  - MAX6959 (debounce support)
+
+	  This driver can also be built as a module. If so, the module
+	  will be called max6959.
+
 config ARM_CHARLCD
 	bool "ARM Ltd. Character LCD Driver"
 	depends on PLAT_VERSATILE
diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
index 43bad850481c..f62a258809ef 100644
--- a/drivers/auxdisplay/Makefile
+++ b/drivers/auxdisplay/Makefile
@@ -12,5 +12,6 @@ obj-$(CONFIG_CFAG12864B)	+= cfag12864b.o cfag12864bfb.o
 obj-$(CONFIG_LINEDISP)		+= line-display.o
 obj-$(CONFIG_IMG_ASCII_LCD)	+= img-ascii-lcd.o
 obj-$(CONFIG_HT16K33)		+= ht16k33.o
+obj-$(CONFIG_MAX6959)		+= max6959.o
 obj-$(CONFIG_ARM_CHARLCD)	+= arm-charlcd.o
 obj-$(CONFIG_PARPORT_PANEL)	+= panel.o
diff --git a/drivers/auxdisplay/max6959.c b/drivers/auxdisplay/max6959.c
new file mode 100644
index 000000000000..0c5cbd16c3fe
--- /dev/null
+++ b/drivers/auxdisplay/max6959.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MAX6958/6959 7-segment LED display controller with keyscan
+ * Datasheet:
+ * https://www.analog.com/media/en/technical-documentation/data-sheets/MAX6958-MAX6959.pdf
+ *
+ * Copyright (c) 2024, Intel Corporation.
+ * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ */
+#include <linux/array_size.h>
+#include <linux/bitrev.h>
+#include <linux/bits.h>
+#include <linux/container_of.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include <linux/map_to_7segment.h>
+
+#include "line-display.h"
+
+/* Registers */
+#define REG_DECODE_MODE			0x01
+#define REG_INTENSITY			0x02
+#define REG_SCAN_LIMIT			0x03
+#define REG_CONFIGURATION		0x04
+#define REG_CONFIGURATION_S_BIT		BIT(0)
+
+#define REG_DIGIT(x)			(0x20 + (x))
+#define REG_DIGIT0			0x20
+#define REG_DIGIT1			0x21
+#define REG_DIGIT2			0x22
+#define REG_DIGIT3			0x23
+
+#define REG_SEGMENTS			0x24
+#define REG_MAX				REG_SEGMENTS
+
+/* Defines */
+#define MIN_BRIGHTNESS			0x01
+#define MAX_BRIGHTNESS			0x40
+
+struct max6959_priv {
+	struct linedisp linedisp;
+
+	struct delayed_work work;
+
+	struct regmap *regmap;
+};
+
+static void max6959_disp_update(struct work_struct *work)
+{
+	struct max6959_priv *priv = container_of(work, struct max6959_priv, work.work);
+	struct linedisp *linedisp = &priv->linedisp;
+	struct linedisp_map *map = linedisp->map;
+	char *s = linedisp->curr;
+	u8 buf[4];
+
+	/* Map segments according to datasheet */
+	buf[0] = bitrev8(map_to_seg7(&map->map.seg7, *s++)) >> 1;
+	buf[1] = bitrev8(map_to_seg7(&map->map.seg7, *s++)) >> 1;
+	buf[2] = bitrev8(map_to_seg7(&map->map.seg7, *s++)) >> 1;
+	buf[3] = bitrev8(map_to_seg7(&map->map.seg7, *s++)) >> 1;
+
+	regmap_bulk_write(priv->regmap, REG_DIGIT(0), buf, ARRAY_SIZE(buf));
+}
+
+static int max6959_linedisp_get_map_type(struct linedisp *linedisp)
+{
+	struct max6959_priv *priv = container_of(linedisp, struct max6959_priv, linedisp);
+
+	INIT_DELAYED_WORK(&priv->work, max6959_disp_update);
+	return LINEDISP_MAP_SEG7;
+}
+
+static void max6959_linedisp_update(struct linedisp *linedisp)
+{
+	struct max6959_priv *priv = container_of(linedisp, struct max6959_priv, linedisp);
+
+	schedule_delayed_work(&priv->work, 0);
+}
+
+static const struct linedisp_ops max6959_linedisp_ops = {
+	.get_map_type = max6959_linedisp_get_map_type,
+	.update = max6959_linedisp_update,
+};
+
+static int max6959_enable(struct max6959_priv *priv, bool enable)
+{
+	u8 mask = REG_CONFIGURATION_S_BIT;
+	u8 value = enable ? mask : 0;
+
+	return regmap_update_bits(priv->regmap, REG_CONFIGURATION, mask, value);
+}
+
+static void max6959_power_off(void *priv)
+{
+	max6959_enable(priv, false);
+}
+
+static int max6959_power_on(struct max6959_priv *priv)
+{
+	struct device *dev = regmap_get_device(priv->regmap);
+	int ret;
+
+	ret = max6959_enable(priv, true);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, max6959_power_off, priv);
+}
+
+static const struct regmap_config max6959_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = REG_MAX,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static int max6959_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct max6959_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = devm_regmap_init_i2c(client, &max6959_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	ret = max6959_power_on(priv);
+	if (ret)
+		return ret;
+
+	ret = linedisp_register(&priv->linedisp, dev, 4, NULL, &max6959_linedisp_ops);
+	if (ret)
+		return ret;
+
+	i2c_set_clientdata(client, priv);
+
+	return 0;
+}
+
+static void max6959_i2c_remove(struct i2c_client *client)
+{
+	struct max6959_priv *priv = i2c_get_clientdata(client);
+
+	cancel_delayed_work_sync(&priv->work);
+	linedisp_unregister(&priv->linedisp);
+}
+
+static int max6959_suspend(struct device *dev)
+{
+	return max6959_enable(dev_get_drvdata(dev), false);
+}
+
+static int max6959_resume(struct device *dev)
+{
+	return max6959_enable(dev_get_drvdata(dev), true);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(max6959_pm_ops, max6959_suspend, max6959_resume);
+
+static const struct i2c_device_id max6959_i2c_id[] = {
+	{ "max6959" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max6959_i2c_id);
+
+static const struct of_device_id max6959_of_table[] = {
+	{ .compatible = "maxim,max6959" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max6959_of_table);
+
+static struct i2c_driver max6959_i2c_driver = {
+	.driver = {
+		.name = "max6959",
+		.pm = pm_sleep_ptr(&max6959_pm_ops),
+		.of_match_table = max6959_of_table,
+	},
+	.probe = max6959_i2c_probe,
+	.remove = max6959_i2c_remove,
+	.id_table = max6959_i2c_id,
+};
+module_i2c_driver(max6959_i2c_driver);
+
+MODULE_DESCRIPTION("MAX6958/6959 7-segment LED controller with keyscan");
+MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(LINEDISP);
-- 
2.43.0.rc1.1.gbec44491f096


