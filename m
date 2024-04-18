Return-Path: <linux-kernel+bounces-150222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170258A9BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1E81C217B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58B5165FA8;
	Thu, 18 Apr 2024 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="aITZgeeO"
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2941635D8;
	Thu, 18 Apr 2024 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448690; cv=none; b=TXG2I9Ud/7IzWAX0QrFJ8vmNfECZRLnpo1cYUsWFgYp19+6jTJ3jVmWhRnVlIvJolMugK4MRI1vo07JxE+frE6jCEbYO8b1OJrjFYzMwmTAxgEGFIeeLHdktEJX8ZHjMb9Bq8pxca1P8vYpTPcLEZq/sDbrqmU2hSjovrstQLGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448690; c=relaxed/simple;
	bh=I0yeIY7D8yKRNRnvX+XLrfDsn7nMHd9Me/ZYslSqegs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q8L+rjLnswx27z2VrFn2WZhEy5/M6TSVLHJ8nKZKsGlsdtuAfOesT8wotM0cssrCyQlviMriK7m+nmtsOJWqTsgPXys79CKP+K0cimqFIL+/cS4cgw52+4SCnxZaBRvT8Wno7a4Ydrij8xKq3OfPAvf7hYuUBeRudQJvv3oP+Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=aITZgeeO; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:c8ad:0:640:7c75:0])
	by forward500c.mail.yandex.net (Yandex) with ESMTPS id DFA006104D;
	Thu, 18 Apr 2024 16:58:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id gvF5FWNoJ8c0-szya4TNz;
	Thu, 18 Apr 2024 16:58:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713448685; bh=rcYDGNKniFozwILzvpRXKReJQeQuzjeYpRIJOGjEHeM=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=aITZgeeOPElim/uC0pMZB52iIp+f6uRgeTe1960IRqAxoO22UIM3E0pcYDax16QhB
	 AZW638fWFSgdOHMMR9sewwLWFJK7uph8EknDsjH4OdIS70W+dau7NvslFTd5IrkZdm
	 RFtSxcsRgti4tUcV4IYiq6PuSjHFQJgMYyTxFT4w=
Authentication-Results: mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Konstantin Pugin <rilian.la.te@ya.ru>
To: 
Cc: Konstantin Pugin <ria.freelander@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 3/3] serial: sc16is7xx: add support for EXAR XR20M1172 UART
Date: Thu, 18 Apr 2024 16:57:34 +0300
Message-Id: <20240418135737.3659498-4-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418135737.3659498-1-rilian.la.te@ya.ru>
References: <20240418135737.3659498-1-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Pugin <ria.freelander@gmail.com>

Its register set is mostly compatible with SC16IS762, but
it has a support for additional division rates of UART
with special DLD register. So, add handling this register
via UPF_MAGIC_MULTIPLIER port flag.

Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
---
 drivers/tty/serial/sc16is7xx.c | 54 ++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index a300eebf1401..7fc1c19b3891 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -65,6 +65,7 @@
 /* Special Register set: Only if ((LCR[7] == 1) && (LCR != 0xBF)) */
 #define SC16IS7XX_DLL_REG		(0x00) /* Divisor Latch Low */
 #define SC16IS7XX_DLH_REG		(0x01) /* Divisor Latch High */
+#define SC16IS7XX_DLD_REG		(0x02) /* Divisor Latch Mode (only on EXAR chips) */
 
 /* Enhanced Register set: Only if (LCR == 0xBF) */
 #define SC16IS7XX_EFR_REG		(0x02) /* Enhanced Features */
@@ -218,6 +219,20 @@
 #define SC16IS7XX_TCR_RX_HALT(words)	((((words) / 4) & 0x0f) << 0)
 #define SC16IS7XX_TCR_RX_RESUME(words)	((((words) / 4) & 0x0f) << 4)
 
+/* Divisor Latch Mode bits (EXAR extension)
+ *
+ * EXAR hardware is mostly compatible with SC16IS7XX, but supports additional feature:
+ * 4x and 8x divisor, instead of default 16x. It has a special register to program it.
+ * Bits 0 to 3 is fractional divisor, it used to set value of last 16 bits of
+ * uartclk * (16 / divisor) / baud, in case of default it will be uartclk / baud.
+ * Bits 4 and 5 used as switches, and should not be set to 1 simultaneously.
+ */
+
+#define SC16IS7XX_DLD_16X		0
+#define SC16IS7XX_DLD_DIV(m)	((m) & 0xf)
+#define SC16IS7XX_DLD_8X		BIT(4)
+#define SC16IS7XX_DLD_4X		BIT(5)
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
@@ -559,13 +582,29 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 	u8 lcr;
 	u8 prescaler = 0;
-	unsigned long clk = port->uartclk, div = clk / 16 / baud;
+	u8 divisor = 16;
+	u8 dld_mode = SC16IS7XX_DLD_16X;
+	bool has_dld = !!(port->flags & UPF_MAGIC_MULTIPLIER);
+	unsigned long clk = port->uartclk, div, div16;
+
+	if (has_dld)
+		while (DIV_ROUND_CLOSEST(port->uartclk, baud) < divisor)
+			divisor /= 2;
+
+	div16 = clk * (16 / divisor) / baud;
+	div = div16 / 16; /* For divisor = 16, it is the same as clk / 16 / baud */
 
 	if (div >= BIT(16)) {
 		prescaler = SC16IS7XX_MCR_CLKSEL_BIT;
 		div /= 4;
 	}
 
+	/* Count additional divisor for EXAR devices */
+	if (divisor == 8)
+		dld_mode = SC16IS7XX_DLD_8X;
+	if (divisor == 4)
+		dld_mode = SC16IS7XX_DLD_4X;
+
 	/* Enable enhanced features */
 	sc16is7xx_efr_lock(port);
 	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
@@ -586,12 +625,14 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	regcache_cache_bypass(one->regmap, true);
 	sc16is7xx_port_write(port, SC16IS7XX_DLH_REG, div / 256);
 	sc16is7xx_port_write(port, SC16IS7XX_DLL_REG, div % 256);
+	if (has_dld)
+		sc16is7xx_port_write(port, SC16IS7XX_DLD_REG, dld_mode | SC16IS7XX_DLD_DIV(div16));
 	regcache_cache_bypass(one->regmap, false);
 
 	/* Restore LCR and access to general register set */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
-	return DIV_ROUND_CLOSEST(clk / 16, div);
+	return DIV_ROUND_CLOSEST(clk / divisor, div);
 }
 
 static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
@@ -1014,6 +1055,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 	unsigned int lcr, flow = 0;
 	int baud;
 	unsigned long flags;
+	bool has_dld = !!(port->flags & UPF_MAGIC_MULTIPLIER);
 
 	kthread_cancel_delayed_work_sync(&one->ms_work);
 
@@ -1093,7 +1135,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 	/* Get baud rate generator configuration */
 	baud = uart_get_baud_rate(port, termios, old,
 				  port->uartclk / 16 / 4 / 0xffff,
-				  port->uartclk / 16);
+				  port->uartclk / (has_dld ? 4 : 16));
 
 	/* Setup baudrate generator */
 	baud = sc16is7xx_set_baud(port, baud);
@@ -1550,6 +1592,9 @@ static int sc16is7xx_probe(struct device *dev,
 		s->p[i].port.type	= PORT_SC16IS7XX;
 		s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
 		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
+		/* If we have DLD register, then set UPF_MAGIC_MULTIPLIER flag */
+		if (devtype->has_dld)
+			s->p[i].port.flags |= UPF_MAGIC_MULTIPLIER;
 		s->p[i].port.iobase	= i;
 		/*
 		 * Use all ones as membase to make sure uart_configure_port() in
@@ -1688,6 +1733,7 @@ static const struct of_device_id __maybe_unused sc16is7xx_dt_ids[] = {
 	{ .compatible = "nxp,sc16is752",	.data = &sc16is752_devtype, },
 	{ .compatible = "nxp,sc16is760",	.data = &sc16is760_devtype, },
 	{ .compatible = "nxp,sc16is762",	.data = &sc16is762_devtype, },
+	{ .compatible = "exar,xr20m1172",	.data = &xr20m1172_devtype, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sc16is7xx_dt_ids);
@@ -1776,6 +1822,7 @@ static const struct spi_device_id sc16is7xx_spi_id_table[] = {
 	{ "sc16is752",	(kernel_ulong_t)&sc16is752_devtype, },
 	{ "sc16is760",	(kernel_ulong_t)&sc16is760_devtype, },
 	{ "sc16is762",	(kernel_ulong_t)&sc16is762_devtype, },
+	{ "xr20m1172",	(kernel_ulong_t)&xr20m1172_devtype, },
 	{ }
 };
 
@@ -1826,6 +1873,7 @@ static const struct i2c_device_id sc16is7xx_i2c_id_table[] = {
 	{ "sc16is752",	(kernel_ulong_t)&sc16is752_devtype, },
 	{ "sc16is760",	(kernel_ulong_t)&sc16is760_devtype, },
 	{ "sc16is762",	(kernel_ulong_t)&sc16is762_devtype, },
+	{ "xr20m1172",	(kernel_ulong_t)&xr20m1172_devtype, },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sc16is7xx_i2c_id_table);
-- 
2.34.1


