Return-Path: <linux-kernel+bounces-102170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B6187AF03
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E021F251F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E53A196193;
	Wed, 13 Mar 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhSlV0tS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C225196184;
	Wed, 13 Mar 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349389; cv=none; b=qhaRI+TSdCXpgmeKRvE0ktL1s4s0J8g54EyMJ4T8lbe92DQiwvc0WJNBTpC1fnWm1Y/MZCPfmIp5kWa3wj4bbS0sV6w13XeNLWDiqOMatVw3TqQ+/FtGfmjvUa4zvWO/K29aroyPnnFznAcWDYEUPAf6Y3ooTPFBWkdT3a+cPJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349389; c=relaxed/simple;
	bh=xPiUPQYscynxkKGIfs+R1lHQXhx6tKGZToAu1fRTuTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFqZbWob6+gPJ3fIADac2hOJ80aZ8lldxWWt6xZs4T8FD6hPxVjLrAludp3AZPd3/v8kdcz5OcnJYVgPUFbFHbfhYo7UxQkBl2pNay9gpCohG56n1HiA71PYcJYa6pNYHmXMGyBWH9/sCKRd/sI6QX5NJKZjZB2/NObmz+19B5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhSlV0tS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4915FC433A6;
	Wed, 13 Mar 2024 17:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349389;
	bh=xPiUPQYscynxkKGIfs+R1lHQXhx6tKGZToAu1fRTuTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhSlV0tSuS7Ieb4LlqwjAXca+D0xzc6rT3n7WhMa2tNbXAWpyu4i69pZFDrSZosjq
	 mPIB3zBTwGGrpFsA1oZnx+sSaCoIwELHUybAixrnNkTP5avLEjwp2gLG9mp1QiR7Dm
	 ToSqbXv5rg2vsjWS2aY+pqUgv247iY54vqbpA7Tug8WAWZZVxWQOFufOFyodznwIoX
	 uIbHjI+n165Yfmu4pxUFnBtRobv4CZv9dWKScLZ8ttXW7eO/MSKWEtrSYm0gC32iMO
	 MJVjPfjKq1XEwV3xMBLAjmVmuuWaczW15goxhgZTmeUxV1D+zr749sTqI2H1Flpdpu
	 O2N04sJ/qqiiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 49/51] serial: max310x: implement I2C support
Date: Wed, 13 Mar 2024 13:02:10 -0400
Message-ID: <20240313170212.616443-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

[ Upstream commit 2e1f2d9a9bdbe12ee475c82a45ac46a278e8049a ]

I2C implementation on this chip has a few key differences
compared to SPI, as described in previous patches.
 * extended register space access needs no extra logic
 * slave address is used to select which UART to communicate
   with

To accommodate these differences, add an I2C interface config,
set the RevID register address and implement an empty method
for setting the GlobalCommand register, since no special handling
is needed for the extended register space.

To handle the port-specific slave address, create an I2C dummy
device for each port, except the base one (UART0), which is
expected to be the one specified in firmware, and create a
regmap for each I2C device.
Add minimum and maximum slave addresses to each devtype for
sanity checking.

Also, use a separate regmap config with no write_flag_mask,
since I2C has a R/W bit in its slave address, and set the
max register to the address of the RevID register, since the
extended register space needs no extra logic.

Finally, add the I2C driver.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Link: https://lore.kernel.org/r/20220605144659.4169853-5-demonsingur@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 3f42b142ea11 ("serial: max310x: fix IO data corruption in batched operations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/Kconfig   |   1 +
 drivers/tty/serial/max310x.c | 135 ++++++++++++++++++++++++++++++++++-
 2 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index a9751a83d5dbb..def45baec28f8 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -354,6 +354,7 @@ config SERIAL_MAX310X
 	depends on SPI_MASTER
 	select SERIAL_CORE
 	select REGMAP_SPI if SPI_MASTER
+	select REGMAP_I2C if I2C
 	help
 	  This selects support for an advanced UART from Maxim (Dallas).
 	  Supported ICs are MAX3107, MAX3108, MAX3109, MAX14830.
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index b90281ac54c85..ed1aaa19854fd 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
+#include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
@@ -73,6 +74,7 @@
 
 /* Extended registers */
 #define MAX310X_SPI_REVID_EXTREG	MAX310X_REG_05 /* Revision ID */
+#define MAX310X_I2C_REVID_EXTREG	(0x25) /* Revision ID */
 
 /* IRQ register bits */
 #define MAX310X_IRQ_LSR_BIT		(1 << 0) /* LSR interrupt */
@@ -260,6 +262,10 @@ struct max310x_if_cfg {
 };
 
 struct max310x_devtype {
+	struct {
+		unsigned short min;
+		unsigned short max;
+	} slave_addr;
 	char	name[9];
 	int	nr;
 	u8	mode1;
@@ -431,6 +437,10 @@ static const struct max310x_devtype max3107_devtype = {
 	.mode1	= MAX310X_MODE1_AUTOSLEEP_BIT | MAX310X_MODE1_IRQSEL_BIT,
 	.detect	= max3107_detect,
 	.power	= max310x_power,
+	.slave_addr	= {
+		.min = 0x2c,
+		.max = 0x2f,
+	},
 };
 
 static const struct max310x_devtype max3108_devtype = {
@@ -439,6 +449,10 @@ static const struct max310x_devtype max3108_devtype = {
 	.mode1	= MAX310X_MODE1_AUTOSLEEP_BIT,
 	.detect	= max3108_detect,
 	.power	= max310x_power,
+	.slave_addr	= {
+		.min = 0x60,
+		.max = 0x6f,
+	},
 };
 
 static const struct max310x_devtype max3109_devtype = {
@@ -447,6 +461,10 @@ static const struct max310x_devtype max3109_devtype = {
 	.mode1	= MAX310X_MODE1_AUTOSLEEP_BIT,
 	.detect	= max3109_detect,
 	.power	= max310x_power,
+	.slave_addr	= {
+		.min = 0x60,
+		.max = 0x6f,
+	},
 };
 
 static const struct max310x_devtype max14830_devtype = {
@@ -455,6 +473,10 @@ static const struct max310x_devtype max14830_devtype = {
 	.mode1	= MAX310X_MODE1_IRQSEL_BIT,
 	.detect	= max14830_detect,
 	.power	= max14830_power,
+	.slave_addr	= {
+		.min = 0x60,
+		.max = 0x6f,
+	},
 };
 
 static bool max310x_reg_writeable(struct device *dev, unsigned int reg)
@@ -1557,6 +1579,97 @@ static struct spi_driver max310x_spi_driver = {
 };
 #endif
 
+#ifdef CONFIG_I2C
+static int max310x_i2c_extended_reg_enable(struct device *dev, bool enable)
+{
+	return 0;
+}
+
+static struct regmap_config regcfg_i2c = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.writeable_reg = max310x_reg_writeable,
+	.volatile_reg = max310x_reg_volatile,
+	.precious_reg = max310x_reg_precious,
+	.max_register = MAX310X_I2C_REVID_EXTREG,
+};
+
+static const struct max310x_if_cfg max310x_i2c_if_cfg = {
+	.extended_reg_enable = max310x_i2c_extended_reg_enable,
+	.rev_id_reg = MAX310X_I2C_REVID_EXTREG,
+};
+
+static unsigned short max310x_i2c_slave_addr(unsigned short addr,
+					     unsigned int nr)
+{
+	/*
+	 * For MAX14830 and MAX3109, the slave address depends on what the
+	 * A0 and A1 pins are tied to.
+	 * See Table I2C Address Map of the datasheet.
+	 * Based on that table, the following formulas were determined.
+	 * UART1 - UART0 = 0x10
+	 * UART2 - UART1 = 0x20 + 0x10
+	 * UART3 - UART2 = 0x10
+	 */
+
+	addr -= nr * 0x10;
+
+	if (nr >= 2)
+		addr -= 0x20;
+
+	return addr;
+}
+
+static int max310x_i2c_probe(struct i2c_client *client)
+{
+	const struct max310x_devtype *devtype =
+			device_get_match_data(&client->dev);
+	struct i2c_client *port_client;
+	struct regmap *regmaps[4];
+	unsigned int i;
+	u8 port_addr;
+
+	if (client->addr < devtype->slave_addr.min ||
+		client->addr > devtype->slave_addr.max)
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "Slave addr 0x%x outside of range [0x%x, 0x%x]\n",
+				     client->addr, devtype->slave_addr.min,
+				     devtype->slave_addr.max);
+
+	regmaps[0] = devm_regmap_init_i2c(client, &regcfg_i2c);
+
+	for (i = 1; i < devtype->nr; i++) {
+		port_addr = max310x_i2c_slave_addr(client->addr, i);
+		port_client = devm_i2c_new_dummy_device(&client->dev,
+							client->adapter,
+							port_addr);
+
+		regmaps[i] = devm_regmap_init_i2c(port_client, &regcfg_i2c);
+	}
+
+	return max310x_probe(&client->dev, devtype, &max310x_i2c_if_cfg,
+			     regmaps, client->irq);
+}
+
+static int max310x_i2c_remove(struct i2c_client *client)
+{
+	max310x_remove(&client->dev);
+
+	return 0;
+}
+
+static struct i2c_driver max310x_i2c_driver = {
+	.driver = {
+		.name		= MAX310X_NAME,
+		.of_match_table	= max310x_dt_ids,
+		.pm		= &max310x_pm_ops,
+	},
+	.probe_new	= max310x_i2c_probe,
+	.remove		= max310x_i2c_remove,
+};
+#endif
+
 static int __init max310x_uart_init(void)
 {
 	int ret;
@@ -1570,15 +1683,35 @@ static int __init max310x_uart_init(void)
 #ifdef CONFIG_SPI_MASTER
 	ret = spi_register_driver(&max310x_spi_driver);
 	if (ret)
-		uart_unregister_driver(&max310x_uart);
+		goto err_spi_register;
+#endif
+
+#ifdef CONFIG_I2C
+	ret = i2c_add_driver(&max310x_i2c_driver);
+	if (ret)
+		goto err_i2c_register;
 #endif
 
+	return 0;
+
+#ifdef CONFIG_I2C
+err_i2c_register:
+	spi_unregister_driver(&max310x_spi_driver);
+#endif
+
+err_spi_register:
+	uart_unregister_driver(&max310x_uart);
+
 	return ret;
 }
 module_init(max310x_uart_init);
 
 static void __exit max310x_uart_exit(void)
 {
+#ifdef CONFIG_I2C
+	i2c_del_driver(&max310x_i2c_driver);
+#endif
+
 #ifdef CONFIG_SPI_MASTER
 	spi_unregister_driver(&max310x_spi_driver);
 #endif
-- 
2.43.0


