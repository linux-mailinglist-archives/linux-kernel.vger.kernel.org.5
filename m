Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7427D83AC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345072AbjJZNfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjJZNfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:35:19 -0400
Received: from esa1.ltts.com (unknown [118.185.121.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D35618A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:35:15 -0700 (PDT)
IronPort-SDR: aAA2oINQM4u8R8s6ZyG2BwVPki5ksLO7bxmQ3RcVmd3DJ+98Ipu76o9zLEH8glG+NA5Q9OoI1T
 pseVau6h83iA==
Received: from unknown (HELO BLTSP01651.lnties.com) ([10.20.120.98])
  by esa1.ltts.com with ESMTP; 26 Oct 2023 19:04:03 +0530
From:   Gairuboina Sirisha <sirisha.gairuboina@Ltts.com>
To:     linux-kernel@vger.kernel.org
Cc:     lee@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
Subject: [PATCH v1 2/3] drivers: mfd: Add support for TPS65224 i2c driver
Date:   Thu, 26 Oct 2023 19:02:25 +0530
Message-Id: <20231026133226.290040-3-sirisha.gairuboina@Ltts.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026133226.290040-1-sirisha.gairuboina@Ltts.com>
References: <20231026133226.290040-1-sirisha.gairuboina@Ltts.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>

Added MFD driver that enables I2C communication with and without CRC

Signed-off-by: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
---
 drivers/mfd/Kconfig        |  14 +++
 drivers/mfd/Makefile       |   1 +
 drivers/mfd/tps65224-i2c.c | 245 +++++++++++++++++++++++++++++++++++++
 3 files changed, 260 insertions(+)
 create mode 100644 drivers/mfd/tps65224-i2c.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 2e4906484eed..943d85d49fc5 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1767,12 +1767,26 @@ config MFD_TPS6594_SPI
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called tps6594-spi.
+
 config MFD_TPS65224
         tristate
         select MFD_CORE
         select REGMAP
         select REGMAP_IRQ
 
+config MFD_TPS65224_I2C
+        tristate "TI TPS65224 Power Management chip with I2C"
+        select MFD_TPS65224
+        select REGMAP_I2C
+        select CRC8
+        depends on I2C
+        help
+          If you say yes here you get support for the TPS65224 series of
+          PM chips with I2C interface.
+
+          This driver can also be built as a module.  If so, the module
+          will be called tps65224-i2c.
+
 config TWL4030_CORE
 	bool "TI TWL4030/TWL5030/TWL6030/TPS659x0 Support"
 	depends on I2C=y
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index ff4e158fa4db..4963fecd3e93 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_MFD_TPS6594)	+= tps6594-core.o
 obj-$(CONFIG_MFD_TPS6594_I2C)	+= tps6594-i2c.o
 obj-$(CONFIG_MFD_TPS6594_SPI)	+= tps6594-spi.o
 obj-$(CONFIG_MFD_TPS65224)      += tps65224-core.o
+obj-$(CONFIG_MFD_TPS65224)      += tps65224-i2c.o
 obj-$(CONFIG_MENELAUS)		+= menelaus.o
 
 obj-$(CONFIG_TWL4030_CORE)	+= twl-core.o twl4030-irq.o twl6030-irq.o
diff --git a/drivers/mfd/tps65224-i2c.c b/drivers/mfd/tps65224-i2c.c
new file mode 100644
index 000000000000..c6300138ce4c
--- /dev/null
+++ b/drivers/mfd/tps65224-i2c.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * I2C access driver for TI TPS65224 PMIC
+ *
+ * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * Based on the TPS6594 I2C Interface Driver by
+ * Julien Panis <jpanis@baylibre.com>
+ */
+
+#include <linux/crc8.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/tps65224.h>
+
+static bool enable_crc;
+module_param(enable_crc, bool, 0444);
+MODULE_PARM_DESC(enable_crc, "Enable CRC feature for I2C interface");
+
+DECLARE_CRC8_TABLE(tps65224_i2c_crc_table);
+
+static int tps65224_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	int ret = i2c_transfer(adap, msgs, num);
+
+	if (ret == num)
+		return 0;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+static int tps65224_i2c_reg_read_with_crc(struct i2c_client *client, u8 page, u8 reg, u8 *val)
+{
+	struct i2c_msg msgs[2];
+	u8 buf_rx[] = { 0, 0 };
+	/* I2C address = I2C base address + Page index */
+	const u8 addr = client->addr + page;
+	/*
+	 * CRC is calculated from every bit included in the protocol
+	 * except the ACK bits from the target. Byte stream is:
+	 * - B0: (I2C_addr_7bits << 1) | WR_bit, with WR_bit = 0
+	 * - B1: reg
+	 * - B2: (I2C_addr_7bits << 1) | RD_bit, with RD_bit = 1
+	 * - B3: val
+	 * - B4: CRC from B0-B1-B2-B3
+	 */
+	u8 crc_data[] = { addr << 1, reg, addr << 1 | 1, 0 };
+	int ret;
+
+	/* Write register */
+	msgs[0].addr = addr;
+	msgs[0].flags = 0;
+	msgs[0].len = 1;
+	msgs[0].buf = &reg;
+
+	/* Read data and CRC */
+	msgs[1].addr = msgs[0].addr;
+	msgs[1].flags = I2C_M_RD;
+	msgs[1].len = 2;
+	msgs[1].buf = buf_rx;
+
+	ret = tps65224_i2c_transfer(client->adapter, msgs, 2);
+	if (ret < 0)
+		return ret;
+
+	crc_data[sizeof(crc_data) - 1] = *val = buf_rx[0];
+	if (buf_rx[1] != crc8(tps65224_i2c_crc_table, crc_data, sizeof(crc_data), CRC8_INIT_VALUE))
+		return -EIO;
+
+	return ret;
+}
+
+static int tps65224_i2c_reg_write_with_crc(struct i2c_client *client, u8 page, u8 reg, u8 val)
+{
+	struct i2c_msg msg;
+	u8 buf[] = { reg, val, 0 };
+	/* I2C address = I2C base address + Page index */
+	const u8 addr = client->addr + page;
+	/*
+	 * CRC is calculated from every bit included in the protocol
+	 * except the ACK bits from the target. Byte stream is:
+	 * - B0: (I2C_addr_7bits << 1) | WR_bit, with WR_bit = 0
+	 * - B1: reg
+	 * - B2: val
+	 * - B3: CRC from B0-B1-B2
+	 */
+	const u8 crc_data[] = { addr << 1, reg, val };
+
+	/* Write register, data and CRC */
+	msg.addr = addr;
+	msg.flags = client->flags & I2C_M_TEN;
+	msg.len = sizeof(buf);
+	msg.buf = buf;
+
+	buf[msg.len - 1] = crc8(tps65224_i2c_crc_table, crc_data,
+				sizeof(crc_data), CRC8_INIT_VALUE);
+
+	return tps65224_i2c_transfer(client->adapter, &msg, 1);
+}
+
+static int tps65224_i2c_read(void *context, const void *reg_buf, size_t reg_size,
+			    void *val_buf, size_t val_size)
+{
+	struct i2c_client *client = context;
+	struct tps65224 *tps = i2c_get_clientdata(client);
+	struct i2c_msg msgs[2];
+	const u8 *reg_bytes = reg_buf;
+	u8 *val_bytes = val_buf;
+	const u8 page = reg_bytes[1];
+	u8 reg = reg_bytes[0];
+	int ret = 0;
+	int i;
+
+	if (tps->use_crc) {
+		/*
+		 * Auto-increment feature does not support CRC protocol.
+		 * Converts the bulk read operation into a series of single read operations.
+		 */
+		for (i = 0 ; ret == 0 && i < val_size ; i++)
+			ret = tps65224_i2c_reg_read_with_crc(client, page, reg + i, val_bytes + i);
+
+		return ret;
+	}
+
+	/* Write register: I2C address = I2C base address + Page index */
+	msgs[0].addr = client->addr + page;
+	msgs[0].flags = 0;
+	msgs[0].len = 1;
+	msgs[0].buf = &reg;
+
+	/* Read data */
+	msgs[1].addr = msgs[0].addr;
+	msgs[1].flags = I2C_M_RD;
+	msgs[1].len = val_size;
+	msgs[1].buf = val_bytes;
+
+	return tps65224_i2c_transfer(client->adapter, msgs, 2);
+}
+
+static int tps65224_i2c_write(void *context, const void *data, size_t count)
+{
+	struct i2c_client *client = context;
+	struct tps65224 *tps = i2c_get_clientdata(client);
+	struct i2c_msg msg;
+	const u8 *bytes = data;
+	u8 *buf;
+	const u8 page = bytes[1];
+	const u8 reg = bytes[0];
+	int ret = 0;
+	int i;
+
+	if (tps->use_crc) {
+		/*
+		 * Auto-increment feature does not support CRC protocol.
+		 * Converts the bulk write operation into a series of single write operations.
+		 */
+		for (i = 0 ; ret == 0 && i < count - 2 ; i++)
+			ret = tps65224_i2c_reg_write_with_crc(client, page, reg + i, bytes[i + 2]);
+
+		return ret;
+	}
+
+	/* Setup buffer: page byte is not sent */
+	buf = kzalloc(--count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = reg;
+	for (i = 0 ; i < count - 1 ; i++)
+		buf[i + 1] = bytes[i + 2];
+
+	/* Write register and data: I2C address = I2C base address + Page index */
+	msg.addr = client->addr + page;
+	msg.flags = client->flags & I2C_M_TEN;
+	msg.len = count;
+	msg.buf = buf;
+
+	ret = tps65224_i2c_transfer(client->adapter, &msg, 1);
+
+	kfree(buf);
+	return ret;
+}
+
+static const struct regmap_config tps65224_i2c_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = TPS65224_REG_WD_FAIL_CNT_REG,
+	.volatile_reg = tps65224_is_volatile_reg,
+	.read = tps65224_i2c_read,
+	.write = tps65224_i2c_write,
+};
+
+static const struct of_device_id tps65224_i2c_of_match_table[] = {
+	{ .compatible = "ti,tps65224-q1", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, tps65224_i2c_of_match_table);
+
+static int tps65224_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct tps65224 *tps;
+	const struct of_device_id *match;
+
+	tps = devm_kzalloc(dev, sizeof(*tps), GFP_KERNEL);
+	if (!tps)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, tps);
+
+	tps->dev = dev;
+	tps->reg = client->addr;
+	tps->irq = client->irq;
+
+	tps->regmap = devm_regmap_init(dev, NULL, client, &tps65224_i2c_regmap_config);
+	if (IS_ERR(tps->regmap))
+		return dev_err_probe(dev, PTR_ERR(tps->regmap), "Failed to init regmap\n");
+
+	match = of_match_device(tps65224_i2c_of_match_table, dev);
+	if (!match)
+		return dev_err_probe(dev, -EINVAL, "Failed to find matching chip ID\n");
+
+	crc8_populate_msb(tps65224_i2c_crc_table, TPS65224_CRC8_POLYNOMIAL);
+
+	return tps65224_device_init(tps, enable_crc);
+}
+
+static struct i2c_driver tps65224_i2c_driver = {
+	.driver	= {
+		.name = "tps65224",
+		.of_match_table = tps65224_i2c_of_match_table,
+	},
+	.probe = tps65224_i2c_probe,
+};
+module_i2c_driver(tps65224_i2c_driver);
+
+MODULE_AUTHOR("Gairuboina Sirisha <sirisha.gairuboina@ltts.com");
+MODULE_DESCRIPTION("TPS65224 I2C Interface Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

