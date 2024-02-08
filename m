Return-Path: <linux-kernel+bounces-58586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA39284E88D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0CB287905
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560354F1F2;
	Thu,  8 Feb 2024 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIFY9hXr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467AE3F9DF;
	Thu,  8 Feb 2024 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418182; cv=none; b=TZqOtM/ZLUya46DgOmyKHth9nHNSw3XgKjVUL1uVaEU3yLNNR7L81X/S44e/4MHJ1p7dZycbqlvegwYuLMYcSf5GyByJb269NsdBRk6GAuAkiZiq49R/xHhDGUsGzpsuLfadhg6Hz9LHmSuV8L8Zp/p4pjOAiaRycYmFhldruGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418182; c=relaxed/simple;
	bh=v6wTWOcgnBbdVRVq0vTx2zi8kxA67Ld9K3m1TKyiM1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZcl5XkVj8K/XqmtFayXVE9qsKH7n9505Sh2QQCrQZQ1C91Hu+6tPeDqK23i9eUT+CS4ddYVd1VjXk44MAdq9D/zJcqRIEISiQw+ZXXYJqErZ8AKMHs6vU7Uv8anSnqG665zkbYC+fDzxmHzCg3h4WxAFbd68kPDteS7uOdrIVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LIFY9hXr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707418180; x=1738954180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v6wTWOcgnBbdVRVq0vTx2zi8kxA67Ld9K3m1TKyiM1Q=;
  b=LIFY9hXr4ZonEoYdzXaF1hVI877SOcxjlIxB/T+8ia+89IBz7IknZpUk
   EAzT3+qkQc9l+YvqwFtGH52wBxRYakg6Pw3l1BW9qkK5PEiMdfuET/F9T
   oOo9j57L0J33KbgfKL4SQJBR+O+GTFqXSqDhp01SY47MZpg38uVFzif72
   l0eRXX6H6TVE3Ea4lT77YWobMmOdxD1qPKXecbxzaprLcW/ixFMLGLPMO
   6VZ26U6MLjF0JfxRw5a0Es3u4zfOEBGzRmMBf594gb5Yf10rBp60pYQeq
   aSevGCP4S+/W6LBIFKtPyC9ksgSPd0mSVASzcjJLl9mmJ2Mrqf/BCCJS3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1186177"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1186177"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:49:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934215554"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934215554"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:49:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C14AE1043; Thu,  8 Feb 2024 20:49:21 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v1 15/15] auxdisplay: Add driver for MAX695x 7-segment LED controllers
Date: Thu,  8 Feb 2024 20:48:13 +0200
Message-ID: <20240208184919.2224986-16-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
References: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
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


