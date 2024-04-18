Return-Path: <linux-kernel+bounces-150550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC968AA0D6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 484C1B220BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86D7171E68;
	Thu, 18 Apr 2024 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="fdU/mFYX"
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6DC174ECA;
	Thu, 18 Apr 2024 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460346; cv=none; b=JuGSkwYXpvDSKQ1NETAm7U8jesuqkyb5vRKmmgV6lL4oo4gU/noBML+EBD1Ct6caxQcS2w4JcDO8K4CCQ3fEMLBu9RXMy0pt15pxZDD/WjwKnQn/vTGOxxFOfegj5/iyPXMeF0eLsOdrTO1LBwULd2NR+wuR64E3MRjECdHVRL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460346; c=relaxed/simple;
	bh=QPBkGopLO/mAbo3PWDsaNs5YXiaDA4qS8qIbUMNiHqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gD84zoya+ODKBjuNr+/ZxiJDu47+ZU+wVA7/BwCrlsI8tZK0245SLXxFc9fPM1oGkfAK2wyqcdXvbWjJ477iTInGNjZI81WuFh+QmurVWK3kNJX/87hE1ybuNrMRv5K8Qj8lzICORJJ0W3FLGUfhcbzP+1fWTPo78FDhekhCR/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=fdU/mFYX; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:2c01:0:640:acf3:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id AA04B615D1;
	Thu, 18 Apr 2024 20:06:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id M6JHjm3m3Gk0-INaHv4Bc;
	Thu, 18 Apr 2024 20:06:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713459998; bh=1AXbpXo2p67BqwFaHtvoE/mN3T/RrjXfDxP6nZ3RYRI=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=fdU/mFYXC7LPcxisKXM7cfgCwZ4AP5s1Qe2Ba8FPQ8I6IG+OOwCsYYB68icgR5wBf
	 /Hf36Hsp6bRYAqKFu6Ppv4tedZQ3Q/+MMy6ivt0noqfdVCcaN4E//doqCqoDEsFOWn
	 NtQQi0iIlagYHjdx/a0Qt7MyZ0OzZFkAFpQEgZJk=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Konstantin Pugin <rilian.la.te@ya.ru>
To: 
Cc: Konstantin Pugin <ria.freelander@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v3 3/3] serial: sc16is7xx: add support for EXAR XR20M1172 UART
Date: Thu, 18 Apr 2024 20:06:07 +0300
Message-Id: <20240418170610.759838-4-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418170610.759838-1-rilian.la.te@ya.ru>
References: <20240418170610.759838-1-rilian.la.te@ya.ru>
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

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
---
 drivers/tty/serial/sc16is7xx.c | 55 +++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index a300eebf1401..59376c637467 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -65,6 +65,7 @@
 /* Special Register set: Only if ((LCR[7] == 1) && (LCR != 0xBF)) */
 #define SC16IS7XX_DLL_REG		(0x00) /* Divisor Latch Low */
 #define SC16IS7XX_DLH_REG		(0x01) /* Divisor Latch High */
+#define XR20M117X_DLD_REG		(0x02) /* Divisor Fractional Register (only on EXAR chips) */
 
 /* Enhanced Register set: Only if (LCR == 0xBF) */
 #define SC16IS7XX_EFR_REG		(0x02) /* Enhanced Features */
@@ -218,6 +219,20 @@
 #define SC16IS7XX_TCR_RX_HALT(words)	((((words) / 4) & 0x0f) << 0)
 #define SC16IS7XX_TCR_RX_RESUME(words)	((((words) / 4) & 0x0f) << 4)
 
+/*
+ * Divisor Fractional Register bits (EXAR extension)
+ * EXAR hardware is mostly compatible with SC16IS7XX, but supports additional feature:
+ * 4x and 8x divisor, instead of default 16x. It has a special register to program it.
+ * Bits 0 to 3 is fractional divisor, it used to set value of last 16 bits of
+ * uartclk * (16 / divisor) / baud, in case of default it will be uartclk / baud.
+ * Bits 4 and 5 used as switches, and should not be set to 1 simultaneously.
+ */
+
+#define XR20M117X_DLD_16X		0
+#define XR20M117X_DLD_DIV(m)	((m) & GENMASK(3, 0))
+#define XR20M117X_DLD_8X		BIT(4)
+#define XR20M117X_DLD_4X		BIT(5)
+
 /*
  * TLR register bits
  * If TLR[3:0] or TLR[7:4] are logical 0, the selectable trigger levels via the
@@ -310,6 +325,7 @@ struct sc16is7xx_devtype {
 	char	name[10];
 	int	nr_gpio;
 	int	nr_uart;
+	bool has_dld;
 };
 
 #define SC16IS7XX_RECONF_MD		(1 << 0)
@@ -522,6 +538,13 @@ static const struct sc16is7xx_devtype sc16is762_devtype = {
 	.nr_uart	= 2,
 };
 
+static const struct sc16is7xx_devtype xr20m1172_devtype = {
+	.name		= "XR20M1172",
+	.nr_gpio	= 8,
+	.nr_uart	= 2,
+	.has_dld	= true,
+};
+
 static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -556,16 +579,33 @@ static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
 
 static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 {
+	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
-	u8 lcr;
+	unsigned long clk = port->uartclk, div, div16;
+	bool has_dld = s->devtype->has_dld;
+	u8 dld_mode = XR20M117X_DLD_16X;
 	u8 prescaler = 0;
-	unsigned long clk = port->uartclk, div = clk / 16 / baud;
+	u8 divisor = 16;
+	u8 lcr;
+
+	if (has_dld && DIV_ROUND_CLOSEST(clk, baud) < 16)
+		divisor = 1 << (fls(DIV_ROUND_CLOSEST(clk, baud)) - 1);
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
+	dld_mode |= XR20M117X_DLD_DIV(div16);
+
 	/* Enable enhanced features */
 	sc16is7xx_efr_lock(port);
 	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
@@ -586,12 +626,14 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
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
@@ -1010,7 +1052,9 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 				  struct ktermios *termios,
 				  const struct ktermios *old)
 {
+	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	bool has_dld = s->devtype->has_dld;
 	unsigned int lcr, flow = 0;
 	int baud;
 	unsigned long flags;
@@ -1093,7 +1137,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 	/* Get baud rate generator configuration */
 	baud = uart_get_baud_rate(port, termios, old,
 				  port->uartclk / 16 / 4 / 0xffff,
-				  port->uartclk / 16);
+				  port->uartclk / (has_dld ? 4 : 16));
 
 	/* Setup baudrate generator */
 	baud = sc16is7xx_set_baud(port, baud);
@@ -1682,6 +1726,7 @@ static void sc16is7xx_remove(struct device *dev)
 }
 
 static const struct of_device_id __maybe_unused sc16is7xx_dt_ids[] = {
+	{ .compatible = "exar,xr20m1172",	.data = &xr20m1172_devtype, },
 	{ .compatible = "nxp,sc16is740",	.data = &sc16is74x_devtype, },
 	{ .compatible = "nxp,sc16is741",	.data = &sc16is74x_devtype, },
 	{ .compatible = "nxp,sc16is750",	.data = &sc16is750_devtype, },
@@ -1776,6 +1821,7 @@ static const struct spi_device_id sc16is7xx_spi_id_table[] = {
 	{ "sc16is752",	(kernel_ulong_t)&sc16is752_devtype, },
 	{ "sc16is760",	(kernel_ulong_t)&sc16is760_devtype, },
 	{ "sc16is762",	(kernel_ulong_t)&sc16is762_devtype, },
+	{ "xr20m1172",	(kernel_ulong_t)&xr20m1172_devtype, },
 	{ }
 };
 
@@ -1826,6 +1872,7 @@ static const struct i2c_device_id sc16is7xx_i2c_id_table[] = {
 	{ "sc16is752",	(kernel_ulong_t)&sc16is752_devtype, },
 	{ "sc16is760",	(kernel_ulong_t)&sc16is760_devtype, },
 	{ "sc16is762",	(kernel_ulong_t)&sc16is762_devtype, },
+	{ "xr20m1172",	(kernel_ulong_t)&xr20m1172_devtype, },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sc16is7xx_i2c_id_table);
-- 
2.34.1


