Return-Path: <linux-kernel+bounces-157604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDB88B137F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E208CB2B024
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549BB83CD4;
	Wed, 24 Apr 2024 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="YOUHiuwJ"
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07296839E2;
	Wed, 24 Apr 2024 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986382; cv=none; b=sgz+HsC5+HnL5Jirg+QznrXtreuC7+cVxxbSsKsrN+DBTA9CXn/qrw6xThGI20JC9+LxfqIaJQznhpmn4l1Zr9Z2kAwTYpzmtzNBsQA3lfe/ZlG6vptT3rZejfziwO4nqF+FbbifWTXCDCu6ZE8XCQAUUqiE7QqLIjvS8L0hXZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986382; c=relaxed/simple;
	bh=gmKhwrKJ7KkWdLFrjoM7B8JA1ns8GbRqJN0IY0d4Jt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXZoHLJ8A0vKz18ydAjWtjo6sOOc1QXpGL5Trx414of8UQD/N0u6ZxVHa/q7tTEKbw3OkKjBpruzUJz/VlhQQcbdX0A6aT90CjozvsEbOPoTZw9mDYqJ4QYU4iQycjC0fmRYrP7j9Me9kBoG7XDjnCWybH6A6NuSam6DQY41xsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=YOUHiuwJ; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:332e:0:640:784d:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id DA35061C30;
	Wed, 24 Apr 2024 22:19:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id IJRtcgXMoCg0-wOIrQrK4;
	Wed, 24 Apr 2024 22:19:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713986375; bh=2+rCwqdAWPAFb5cCgnBE9YdZvQ4hDgvaFdanWPm/XQQ=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=YOUHiuwJ1lZPfnwkhfXIiBt3AOTeMzu4JLbG6wDiFw1giTFNigMJXmROkta0jVJkm
	 Sk5Cn9hRB8f17bYg0lOiG3wuDE3le5HJr6JOZftKJrsXy78XJf2NYmMBeMIHr8kxBj
	 KdlCZXN/bdOoYVTxF21CJOVRV8g/7jzCgwTgy570=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Konstantin Pugin <rilian.la.te@ya.ru>
To: 
Cc: krzk@kernel.org,
	conor@kernel.org,
	lkp@intel.com,
	vz@mleia.com,
	robh@kernel.org,
	jcmvbkbc@gmail.com,
	nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com,
	corbet@lwn.net,
	ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de,
	Maarten.Brock@sttls.nl,
	Konstantin Pugin <ria.freelander@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v8 3/3] serial: sc16is7xx: add support for EXAR XR20M1172 UART
Date: Wed, 24 Apr 2024 22:18:54 +0300
Message-ID: <20240424191908.32565-4-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424191908.32565-1-rilian.la.te@ya.ru>
References: <20240424191908.32565-1-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Pugin <ria.freelander@gmail.com>

XR20M1172 register set is mostly compatible with SC16IS762, but it has
a support for additional division rates of UART with special DLD register.
So, add handling this register by appropriate devicetree bindings.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
---
 drivers/tty/serial/Kconfig         |  3 +-
 drivers/tty/serial/sc16is7xx.c     | 61 ++++++++++++++++++++++++++++--
 drivers/tty/serial/sc16is7xx.h     |  1 +
 drivers/tty/serial/sc16is7xx_i2c.c |  1 +
 drivers/tty/serial/sc16is7xx_spi.c |  1 +
 5 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4fdd7857ef4d..9d0438cfe147 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1029,7 +1029,7 @@ config SERIAL_SC16IS7XX_CORE
 	select SERIAL_SC16IS7XX_SPI if SPI_MASTER
 	select SERIAL_SC16IS7XX_I2C if I2C
 	help
-	  Core driver for NXP SC16IS7xx UARTs.
+	  Core driver for NXP SC16IS7xx and compatible UARTs.
 	  Supported ICs are:
 
 	    SC16IS740
@@ -1038,6 +1038,7 @@ config SERIAL_SC16IS7XX_CORE
 	    SC16IS752
 	    SC16IS760
 	    SC16IS762
+	    XR20M1172 (Exar)
 
 	  The driver supports both I2C and SPI interfaces.
 
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index dfcc804f558f..09c9e52d7ec2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -10,6 +10,7 @@
 #undef DEFAULT_SYMBOL_NAMESPACE
 #define DEFAULT_SYMBOL_NAMESPACE SERIAL_NXP_SC16IS7XX
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -68,6 +69,7 @@
 /* Special Register set: Only if ((LCR[7] == 1) && (LCR != 0xBF)) */
 #define SC16IS7XX_DLL_REG		(0x00) /* Divisor Latch Low */
 #define SC16IS7XX_DLH_REG		(0x01) /* Divisor Latch High */
+#define XR20M117X_DLD_REG		(0x02) /* Divisor Fractional Register */
 
 /* Enhanced Register set: Only if (LCR == 0xBF) */
 #define SC16IS7XX_EFR_REG		(0x02) /* Enhanced Features */
@@ -221,6 +223,20 @@
 #define SC16IS7XX_TCR_RX_HALT(words)	((((words) / 4) & 0x0f) << 0)
 #define SC16IS7XX_TCR_RX_RESUME(words)	((((words) / 4) & 0x0f) << 4)
 
+/*
+ * Divisor Fractional Register bits (EXAR extension).
+ * EXAR hardware is mostly compatible with SC16IS7XX, but supports additional feature:
+ * 4x and 8x divisor, instead of default 16x. It has a special register to program it.
+ * Bits 0 to 3 is fractional divisor, it used to set value of last 16 bits of
+ * uartclk * (16 / divisor) / baud, in case of default it will be uartclk / baud.
+ * Bits 4 and 5 used as switches, and should not be set to 1 simultaneously.
+ */
+
+#define XR20M117X_DLD_16X			0
+#define XR20M117X_DLD_DIV_MASK			GENMASK(3, 0)
+#define XR20M117X_DLD_8X			BIT(4)
+#define XR20M117X_DLD_4X			BIT(5)
+
 /*
  * TLR register bits
  * If TLR[3:0] or TLR[7:4] are logical 0, the selectable trigger levels via the
@@ -523,6 +539,13 @@ const struct sc16is7xx_devtype sc16is762_devtype = {
 };
 EXPORT_SYMBOL_GPL(sc16is762_devtype);
 
+const struct sc16is7xx_devtype xr20m1172_devtype = {
+	.name		= "XR20M1172",
+	.nr_gpio	= 8,
+	.nr_uart	= 2,
+};
+EXPORT_SYMBOL_GPL(xr20m1172_devtype);
+
 static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -555,18 +578,43 @@ static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
 	return reg == SC16IS7XX_RHR_REG;
 }
 
+static bool sc16is7xx_has_dld(struct device *dev)
+{
+	struct sc16is7xx_port *s = dev_get_drvdata(dev);
+
+	if (s->devtype == &xr20m1172_devtype)
+		return true;
+	return false;
+}
+
 static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 {
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
-	u8 lcr;
+	unsigned long clk = port->uartclk, div, div16;
+	bool has_dld = sc16is7xx_has_dld(port->dev);
+	u8 dld_mode = XR20M117X_DLD_16X;
 	u8 prescaler = 0;
-	unsigned long clk = port->uartclk, div = clk / 16 / baud;
+	u8 divisor = 16;
+	u8 lcr;
+
+	if (has_dld && DIV_ROUND_CLOSEST(clk, baud) < 16)
+		divisor = rounddown_pow_of_two(DIV_ROUND_CLOSEST(clk, baud));
+
+	div16 = (clk * 16) / divisor / baud;
+	div = div16 / 16;
 
 	if (div >= BIT(16)) {
 		prescaler = SC16IS7XX_MCR_CLKSEL_BIT;
 		div /= 4;
 	}
 
+	/* Count additional divisor for EXAR devices */
+	if (divisor == 8)
+		dld_mode = XR20M117X_DLD_8X;
+	if (divisor == 4)
+		dld_mode = XR20M117X_DLD_4X;
+	dld_mode |= FIELD_PREP(XR20M117X_DLD_DIV_MASK, div16);
+
 	/* Enable enhanced features */
 	sc16is7xx_efr_lock(port);
 	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
@@ -587,12 +635,14 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	regcache_cache_bypass(one->regmap, true);
 	sc16is7xx_port_write(port, SC16IS7XX_DLH_REG, div / 256);
 	sc16is7xx_port_write(port, SC16IS7XX_DLL_REG, div % 256);
+	if (has_dld)
+		sc16is7xx_port_write(port, XR20M117X_DLD_REG, dld_mode);
 	regcache_cache_bypass(one->regmap, false);
 
 	/* Restore LCR and access to general register set */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
-	return DIV_ROUND_CLOSEST(clk / 16, div);
+	return DIV_ROUND_CLOSEST(clk / divisor, div);
 }
 
 static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
@@ -1002,6 +1052,8 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 				  const struct ktermios *old)
 {
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	bool has_dld = sc16is7xx_has_dld(port->dev);
+	u8 divisor = has_dld ? 4 : 16
 	unsigned int lcr, flow = 0;
 	int baud;
 	unsigned long flags;
@@ -1084,7 +1136,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 	/* Get baud rate generator configuration */
 	baud = uart_get_baud_rate(port, termios, old,
 				  port->uartclk / 16 / 4 / 0xffff,
-				  port->uartclk / 16);
+				  port->uartclk / divisor);
 
 	/* Setup baudrate generator */
 	baud = sc16is7xx_set_baud(port, baud);
@@ -1684,6 +1736,7 @@ void sc16is7xx_remove(struct device *dev)
 EXPORT_SYMBOL_GPL(sc16is7xx_remove);
 
 const struct of_device_id __maybe_unused sc16is7xx_dt_ids[] = {
+	{ .compatible = "exar,xr20m1172",	.data = &xr20m1172_devtype, },
 	{ .compatible = "nxp,sc16is740",	.data = &sc16is74x_devtype, },
 	{ .compatible = "nxp,sc16is741",	.data = &sc16is74x_devtype, },
 	{ .compatible = "nxp,sc16is750",	.data = &sc16is750_devtype, },
diff --git a/drivers/tty/serial/sc16is7xx.h b/drivers/tty/serial/sc16is7xx.h
index afb784eaee45..eb2e3bc86f15 100644
--- a/drivers/tty/serial/sc16is7xx.h
+++ b/drivers/tty/serial/sc16is7xx.h
@@ -28,6 +28,7 @@ extern const struct sc16is7xx_devtype sc16is750_devtype;
 extern const struct sc16is7xx_devtype sc16is752_devtype;
 extern const struct sc16is7xx_devtype sc16is760_devtype;
 extern const struct sc16is7xx_devtype sc16is762_devtype;
+extern const struct sc16is7xx_devtype xr20m1172_devtype;
 
 const char *sc16is7xx_regmap_name(u8 port_id);
 
diff --git a/drivers/tty/serial/sc16is7xx_i2c.c b/drivers/tty/serial/sc16is7xx_i2c.c
index 3ed47c306d85..839de902821b 100644
--- a/drivers/tty/serial/sc16is7xx_i2c.c
+++ b/drivers/tty/serial/sc16is7xx_i2c.c
@@ -46,6 +46,7 @@ static const struct i2c_device_id sc16is7xx_i2c_id_table[] = {
 	{ "sc16is752",	(kernel_ulong_t)&sc16is752_devtype, },
 	{ "sc16is760",	(kernel_ulong_t)&sc16is760_devtype, },
 	{ "sc16is762",	(kernel_ulong_t)&sc16is762_devtype, },
+	{ "xr20m1172",	(kernel_ulong_t)&xr20m1172_devtype, },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sc16is7xx_i2c_id_table);
diff --git a/drivers/tty/serial/sc16is7xx_spi.c b/drivers/tty/serial/sc16is7xx_spi.c
index 73df36f8a7fd..2b278282dbd0 100644
--- a/drivers/tty/serial/sc16is7xx_spi.c
+++ b/drivers/tty/serial/sc16is7xx_spi.c
@@ -69,6 +69,7 @@ static const struct spi_device_id sc16is7xx_spi_id_table[] = {
 	{ "sc16is752",	(kernel_ulong_t)&sc16is752_devtype, },
 	{ "sc16is760",	(kernel_ulong_t)&sc16is760_devtype, },
 	{ "sc16is762",	(kernel_ulong_t)&sc16is762_devtype, },
+	{ "xr20m1172",	(kernel_ulong_t)&xr20m1172_devtype, },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, sc16is7xx_spi_id_table);
-- 
2.44.0


