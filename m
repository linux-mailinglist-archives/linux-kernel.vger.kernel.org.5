Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8394A7DC1AB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjJ3VPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjJ3VPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:15:03 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04591E4;
        Mon, 30 Oct 2023 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=T4bpafi4wDXiw73pjC/hG/AEsWrMCKBgzmGC8f4wvEg=; b=Ep6vlwg3j5td1u0IWj6u/FJyZr
        njBeIetuNw250LulYprcBszHXe6aD5ba1aK4zt/u4kL8jwVXnonQIFrbyZVGz3AlIjVMAUOHMh1KI
        dGaRcDLwVph2boOmmsDSJvGeEun+5AESNRuWfHOi/TFwXxmoOthBAS/FnX93E1sU0mts=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:39622 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qxZaz-0005eW-SJ; Mon, 30 Oct 2023 17:14:51 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     hugo@hugovil.com, lech.perczak@camlingroup.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Date:   Mon, 30 Oct 2023 17:14:47 -0400
Message-Id: <20231030211447.974779-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH] serial: sc16is7xx: improve regmap debugfs by using one regmap per port
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

With this current driver regmap implementation, it is hard to make sense
of the register addresses displayed using the regmap debugfs interface,
because they do not correspond to the actual register addresses documented
in the datasheet. For example, register 1 is displayed as registers 04 thru
07:

$ cat /sys/kernel/debug/regmap/spi0.0/registers
  04: 10 -> Port 0, register offset 1
  05: 10 -> Port 1, register offset 1
  06: 00 -> Port 2, register offset 1 -> invalid
  07: 00 -> port 3, register offset 1 -> invalid
  ...

The reason is that bits 0 and 1 of the register address correspond to the
channel (port) bits, so the register address itself starts at bit 2, and we
must 'mentally' shift each register address by 2 bits to get its real
address/offset.

Also, only channels 0 and 1 are supported by the chip, so channel mask
combinations of 10b and 11b are invalid, and the display of these
registers is useless.

This patch adds a separate regmap configuration for each port, similar to
what is done in the max310x driver, so that register addresses displayed
match the register addresses in the chip datasheet. Also, each port now has
its own debugfs entry.

Example with new regmap implementation:

$ cat /sys/kernel/debug/regmap/spi0.0-port0/registers
1: 10
2: 01
3: 00
...

$ cat /sys/kernel/debug/regmap/spi0.0-port1/registers
1: 10
2: 01
3: 00

As an added bonus, this also simplifies some operations (read/write/modify)
because it is no longer necessary to manually shift register addresses.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 143 +++++++++++++++++++--------------
 1 file changed, 81 insertions(+), 62 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index db2bb1c0d36c..4c69c30fbac1 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -300,8 +300,8 @@
 
 
 /* Misc definitions */
+#define SC16IS7XX_SPI_READ_BIT		BIT(7)
 #define SC16IS7XX_FIFO_SIZE		(64)
-#define SC16IS7XX_REG_SHIFT		2
 #define SC16IS7XX_GPIOS_PER_BANK	4
 
 struct sc16is7xx_devtype {
@@ -323,6 +323,7 @@ struct sc16is7xx_one_config {
 struct sc16is7xx_one {
 	struct uart_port		port;
 	u8				line;
+	struct regmap			*regmap;
 	struct kthread_work		tx_work;
 	struct kthread_work		reg_work;
 	struct kthread_delayed_work	ms_work;
@@ -360,48 +361,37 @@ static void sc16is7xx_stop_tx(struct uart_port *port);
 
 #define to_sc16is7xx_one(p,e)	((container_of((p), struct sc16is7xx_one, e)))
 
-static int sc16is7xx_line(struct uart_port *port)
-{
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
-
-	return one->line;
-}
-
 static u8 sc16is7xx_port_read(struct uart_port *port, u8 reg)
 {
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 	unsigned int val = 0;
-	const u8 line = sc16is7xx_line(port);
 
-	regmap_read(s->regmap, (reg << SC16IS7XX_REG_SHIFT) | line, &val);
+	regmap_read(one->regmap, reg, &val);
 
 	return val;
 }
 
 static void sc16is7xx_port_write(struct uart_port *port, u8 reg, u8 val)
 {
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
-	const u8 line = sc16is7xx_line(port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
-	regmap_write(s->regmap, (reg << SC16IS7XX_REG_SHIFT) | line, val);
+	regmap_write(one->regmap, reg, val);
 }
 
 static void sc16is7xx_fifo_read(struct uart_port *port, unsigned int rxlen)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
-	const u8 line = sc16is7xx_line(port);
-	u8 addr = (SC16IS7XX_RHR_REG << SC16IS7XX_REG_SHIFT) | line;
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
-	regcache_cache_bypass(s->regmap, true);
-	regmap_raw_read(s->regmap, addr, s->buf, rxlen);
-	regcache_cache_bypass(s->regmap, false);
+	regcache_cache_bypass(one->regmap, true);
+	regmap_raw_read(one->regmap, SC16IS7XX_RHR_REG, s->buf, rxlen);
+	regcache_cache_bypass(one->regmap, false);
 }
 
 static void sc16is7xx_fifo_write(struct uart_port *port, u8 to_send)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
-	const u8 line = sc16is7xx_line(port);
-	u8 addr = (SC16IS7XX_THR_REG << SC16IS7XX_REG_SHIFT) | line;
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
 	/*
 	 * Don't send zero-length data, at least on SPI it confuses the chip
@@ -410,19 +400,17 @@ static void sc16is7xx_fifo_write(struct uart_port *port, u8 to_send)
 	if (unlikely(!to_send))
 		return;
 
-	regcache_cache_bypass(s->regmap, true);
-	regmap_raw_write(s->regmap, addr, s->buf, to_send);
-	regcache_cache_bypass(s->regmap, false);
+	regcache_cache_bypass(one->regmap, true);
+	regmap_raw_write(one->regmap, SC16IS7XX_THR_REG, s->buf, to_send);
+	regcache_cache_bypass(one->regmap, false);
 }
 
 static void sc16is7xx_port_update(struct uart_port *port, u8 reg,
 				  u8 mask, u8 val)
 {
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
-	const u8 line = sc16is7xx_line(port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
-	regmap_update_bits(s->regmap, (reg << SC16IS7XX_REG_SHIFT) | line,
-			   mask, val);
+	regmap_update_bits(one->regmap, reg, mask, val);
 }
 
 static int sc16is7xx_alloc_line(void)
@@ -477,7 +465,7 @@ static const struct sc16is7xx_devtype sc16is762_devtype = {
 
 static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 {
-	switch (reg >> SC16IS7XX_REG_SHIFT) {
+	switch (reg) {
 	case SC16IS7XX_RHR_REG:
 	case SC16IS7XX_IIR_REG:
 	case SC16IS7XX_LSR_REG:
@@ -496,7 +484,7 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 
 static bool sc16is7xx_regmap_precious(struct device *dev, unsigned int reg)
 {
-	switch (reg >> SC16IS7XX_REG_SHIFT) {
+	switch (reg) {
 	case SC16IS7XX_RHR_REG:
 		return true;
 	default:
@@ -509,6 +497,7 @@ static bool sc16is7xx_regmap_precious(struct device *dev, unsigned int reg)
 static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 	u8 lcr;
 	u8 prescaler = 0;
 	unsigned long clk = port->uartclk, div = clk / 16 / baud;
@@ -540,12 +529,12 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 			     SC16IS7XX_LCR_CONF_MODE_B);
 
 	/* Enable enhanced features */
-	regcache_cache_bypass(s->regmap, true);
+	regcache_cache_bypass(one->regmap, true);
 	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
 			      SC16IS7XX_EFR_ENABLE_BIT,
 			      SC16IS7XX_EFR_ENABLE_BIT);
 
-	regcache_cache_bypass(s->regmap, false);
+	regcache_cache_bypass(one->regmap, false);
 
 	/* Put LCR back to the normal mode */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
@@ -561,10 +550,10 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 			     SC16IS7XX_LCR_CONF_MODE_A);
 
 	/* Write the new divisor */
-	regcache_cache_bypass(s->regmap, true);
+	regcache_cache_bypass(one->regmap, true);
 	sc16is7xx_port_write(port, SC16IS7XX_DLH_REG, div / 256);
 	sc16is7xx_port_write(port, SC16IS7XX_DLL_REG, div % 256);
-	regcache_cache_bypass(s->regmap, false);
+	regcache_cache_bypass(one->regmap, false);
 
 	/* Put LCR back to the normal mode */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
@@ -1078,7 +1067,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 			     SC16IS7XX_LCR_CONF_MODE_B);
 
 	/* Configure flow control */
-	regcache_cache_bypass(s->regmap, true);
+	regcache_cache_bypass(one->regmap, true);
 	sc16is7xx_port_write(port, SC16IS7XX_XON1_REG, termios->c_cc[VSTART]);
 	sc16is7xx_port_write(port, SC16IS7XX_XOFF1_REG, termios->c_cc[VSTOP]);
 
@@ -1097,7 +1086,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 			      SC16IS7XX_EFR_REG,
 			      SC16IS7XX_EFR_FLOWCTRL_BITS,
 			      flow);
-	regcache_cache_bypass(s->regmap, false);
+	regcache_cache_bypass(one->regmap, false);
 
 	/* Update LCR register */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
@@ -1148,7 +1137,6 @@ static int sc16is7xx_config_rs485(struct uart_port *port, struct ktermios *termi
 static int sc16is7xx_startup(struct uart_port *port)
 {
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	unsigned int val;
 	unsigned long flags;
 
@@ -1165,7 +1153,7 @@ static int sc16is7xx_startup(struct uart_port *port)
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
 			     SC16IS7XX_LCR_CONF_MODE_B);
 
-	regcache_cache_bypass(s->regmap, true);
+	regcache_cache_bypass(one->regmap, true);
 
 	/* Enable write access to enhanced features and internal clock div */
 	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
@@ -1183,7 +1171,7 @@ static int sc16is7xx_startup(struct uart_port *port)
 			     SC16IS7XX_TCR_RX_RESUME(24) |
 			     SC16IS7XX_TCR_RX_HALT(48));
 
-	regcache_cache_bypass(s->regmap, false);
+	regcache_cache_bypass(one->regmap, false);
 
 	/* Now, initialize the UART */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, SC16IS7XX_LCR_WORD_LEN_8);
@@ -1464,7 +1452,7 @@ static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s)
 	if (s->mctrl_mask)
 		regmap_update_bits(
 			s->regmap,
-			SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
+			SC16IS7XX_IOCONTROL_REG,
 			SC16IS7XX_IOCONTROL_MODEM_A_BIT |
 			SC16IS7XX_IOCONTROL_MODEM_B_BIT, s->mctrl_mask);
 
@@ -1479,7 +1467,7 @@ static const struct serial_rs485 sc16is7xx_rs485_supported = {
 
 static int sc16is7xx_probe(struct device *dev,
 			   const struct sc16is7xx_devtype *devtype,
-			   struct regmap *regmap, int irq)
+			   struct regmap *regmaps[], int irq)
 {
 	unsigned long freq = 0, *pfreq = dev_get_platdata(dev);
 	unsigned int val;
@@ -1487,16 +1475,16 @@ static int sc16is7xx_probe(struct device *dev,
 	int i, ret;
 	struct sc16is7xx_port *s;
 
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	for (i = 0; i < devtype->nr_uart; i++)
+		if (IS_ERR(regmaps[i]))
+			return PTR_ERR(regmaps[i]);
 
 	/*
 	 * This device does not have an identification register that would
 	 * tell us if we are really connected to the correct device.
 	 * The best we can do is to check if communication is at all possible.
 	 */
-	ret = regmap_read(regmap,
-			  SC16IS7XX_LSR_REG << SC16IS7XX_REG_SHIFT, &val);
+	ret = regmap_read(regmaps[0], SC16IS7XX_LSR_REG, &val);
 	if (ret < 0)
 		return -EPROBE_DEFER;
 
@@ -1530,7 +1518,7 @@ static int sc16is7xx_probe(struct device *dev,
 			return -EINVAL;
 	}
 
-	s->regmap = regmap;
+	s->regmap = regmaps[0];
 	s->devtype = devtype;
 	dev_set_drvdata(dev, s);
 	mutex_init(&s->efr_lock);
@@ -1545,8 +1533,8 @@ static int sc16is7xx_probe(struct device *dev,
 	sched_set_fifo(s->kworker_task);
 
 	/* reset device, purging any pending irq / data */
-	regmap_write(s->regmap, SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
-			SC16IS7XX_IOCONTROL_SRESET_BIT);
+	regmap_write(s->regmap, SC16IS7XX_IOCONTROL_REG,
+		     SC16IS7XX_IOCONTROL_SRESET_BIT);
 
 	for (i = 0; i < devtype->nr_uart; ++i) {
 		s->p[i].line		= i;
@@ -1570,6 +1558,7 @@ static int sc16is7xx_probe(struct device *dev,
 		s->p[i].port.ops	= &sc16is7xx_ops;
 		s->p[i].old_mctrl	= 0;
 		s->p[i].port.line	= sc16is7xx_alloc_line();
+		s->p[i].regmap		= regmaps[i];
 
 		if (s->p[i].port.line >= SC16IS7XX_MAX_DEVS) {
 			ret = -ENOMEM;
@@ -1598,13 +1587,13 @@ static int sc16is7xx_probe(struct device *dev,
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG,
 				     SC16IS7XX_LCR_CONF_MODE_B);
 
-		regcache_cache_bypass(s->regmap, true);
+		regcache_cache_bypass(regmaps[i], true);
 
 		/* Enable write access to enhanced features */
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_EFR_REG,
 				     SC16IS7XX_EFR_ENABLE_BIT);
 
-		regcache_cache_bypass(s->regmap, false);
+		regcache_cache_bypass(regmaps[i], false);
 
 		/* Restore access to general registers */
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG, 0x00);
@@ -1698,19 +1687,36 @@ static const struct of_device_id __maybe_unused sc16is7xx_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, sc16is7xx_dt_ids);
 
 static struct regmap_config regcfg = {
-	.reg_bits = 7,
-	.pad_bits = 1,
+	.reg_bits = 5,
+	.pad_bits = 3,
 	.val_bits = 8,
 	.cache_type = REGCACHE_RBTREE,
 	.volatile_reg = sc16is7xx_regmap_volatile,
 	.precious_reg = sc16is7xx_regmap_precious,
+	.max_register = SC16IS7XX_EFCR_REG,
 };
 
+static const char *sc16is7xx_regmap_name(unsigned int port_id)
+{
+	static char buf[6];
+
+	snprintf(buf, sizeof(buf), "port%d", port_id);
+
+	return buf;
+}
+
+static unsigned int sc16is7xx_regmap_port_mask(unsigned int port_id)
+{
+	/* CH1,CH0 are at bits 2:1. */
+	return port_id << 1;
+}
+
 #ifdef CONFIG_SERIAL_SC16IS7XX_SPI
 static int sc16is7xx_spi_probe(struct spi_device *spi)
 {
 	const struct sc16is7xx_devtype *devtype;
-	struct regmap *regmap;
+	struct regmap *regmaps[2];
+	unsigned int i;
 	int ret;
 
 	/* Setup SPI bus */
@@ -1732,11 +1738,20 @@ static int sc16is7xx_spi_probe(struct spi_device *spi)
 		devtype = (struct sc16is7xx_devtype *)id_entry->driver_data;
 	}
 
-	regcfg.max_register = (0xf << SC16IS7XX_REG_SHIFT) |
-			      (devtype->nr_uart - 1);
-	regmap = devm_regmap_init_spi(spi, &regcfg);
+	for (i = 0; i < devtype->nr_uart; i++) {
+		regcfg.name = sc16is7xx_regmap_name(i);
+		/*
+		 * If read_flag_mask is 0, the regmap code sets it to a default
+		 * of 0x80. Since we specify our own mask, we must add the READ
+		 * bit ourselves:
+		 */
+		regcfg.read_flag_mask = sc16is7xx_regmap_port_mask(i) |
+			SC16IS7XX_SPI_READ_BIT;
+		regcfg.write_flag_mask = sc16is7xx_regmap_port_mask(i);
+		regmaps[i] = devm_regmap_init_spi(spi, &regcfg);
+	}
 
-	return sc16is7xx_probe(&spi->dev, devtype, regmap, spi->irq);
+	return sc16is7xx_probe(&spi->dev, devtype, regmaps, spi->irq);
 }
 
 static void sc16is7xx_spi_remove(struct spi_device *spi)
@@ -1775,7 +1790,8 @@ static int sc16is7xx_i2c_probe(struct i2c_client *i2c)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
 	const struct sc16is7xx_devtype *devtype;
-	struct regmap *regmap;
+	struct regmap *regmaps[2];
+	unsigned int i;
 
 	if (i2c->dev.of_node) {
 		devtype = device_get_match_data(&i2c->dev);
@@ -1785,11 +1801,14 @@ static int sc16is7xx_i2c_probe(struct i2c_client *i2c)
 		devtype = (struct sc16is7xx_devtype *)id->driver_data;
 	}
 
-	regcfg.max_register = (0xf << SC16IS7XX_REG_SHIFT) |
-			      (devtype->nr_uart - 1);
-	regmap = devm_regmap_init_i2c(i2c, &regcfg);
+	for (i = 0; i < devtype->nr_uart; i++) {
+		regcfg.name = sc16is7xx_regmap_name(i);
+		regcfg.read_flag_mask = sc16is7xx_regmap_port_mask(i);
+		regcfg.write_flag_mask = sc16is7xx_regmap_port_mask(i);
+		regmaps[i] = devm_regmap_init_i2c(i2c, &regcfg);
+	}
 
-	return sc16is7xx_probe(&i2c->dev, devtype, regmap, i2c->irq);
+	return sc16is7xx_probe(&i2c->dev, devtype, regmaps, i2c->irq);
 }
 
 static void sc16is7xx_i2c_remove(struct i2c_client *client)

base-commit: 64ebf8797249e792af2143eb9e4bd404d10a022e
-- 
2.39.2

