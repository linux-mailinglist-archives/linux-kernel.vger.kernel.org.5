Return-Path: <linux-kernel+bounces-101989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E62A87AD5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4FA5B234EC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA63F149016;
	Wed, 13 Mar 2024 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUlYfEby"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE457148FF6;
	Wed, 13 Mar 2024 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348200; cv=none; b=ZKKHwnNw7JN/7ebIbzjRFAoExAsAq7lC1ySa8P1rwoH97lplPfmECPRGi9rbkGeNo6cb3ozO2On/jQk7IwxrNVqJBHypAbmk9Fu/9i/4Bz+ORaGRdmqDLVH/fJvGnjZ1QWEitr/RKz6AKyhhS7p5qQhO8iZrQ0Tqmi5mSEWJVtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348200; c=relaxed/simple;
	bh=tUKeK3rvwuNybJHsTZfWYGg+fGIv/4In9a6RGBZKds4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYPzl9nX11cvKOgreWGrpVBrmsAYQxOCPxaRjEHkXSHfSugEcgiIGk2sQmBZZtsgaP5zqBkmDcgCaICGZ/nndlfM6raJJTfj1nAB60CiFSBSarN1maMP5MG70h/d7ZVuJbdt7jcoEYE2nEqhIZ995Ste/0LtOuQhDDzQvjg6Mvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUlYfEby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2714C433C7;
	Wed, 13 Mar 2024 16:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348200;
	bh=tUKeK3rvwuNybJHsTZfWYGg+fGIv/4In9a6RGBZKds4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUlYfEbyE7BPZHvjo7hdUFAqh6CZrG1OaY54pkNsogPWMrQrSgJAu6W3nnAXzp3oB
	 7XYWLWrUERPfbgK7HfHlZfMFGfmqfyMOV7S2tA4UHqvGv4i/gTTwm0OMyj53QVjvjY
	 RlwhcKeyXm9nz/dX+UtWCGEpzewFa2g7jx7QKsmGK4g9SU1653ZoK4OEnz6aBdmYOQ
	 galNhQCgXfn9qDbRl4NA1EjbYtD64gOgUwyFCt3Uyi6FYm3oRIrQQSk1WxJOpX2vAs
	 IuEvaCQ45SXvJ8gmJThaNXDku+8AaA8stYnaPM1JDy5RUrLexMtXAJmfscm5wgRvvP
	 u7Jc2r1iodMYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 49/76] serial: max310x: use a separate regmap for each port
Date: Wed, 13 Mar 2024 12:41:56 -0400
Message-ID: <20240313164223.615640-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

[ Upstream commit 6ef281daf020592c219fa91780abc381c6c20db5 ]

The driver currently does manual register manipulation in
multiple places to talk to a specific UART port.

In order to talk to a specific UART port over SPI, the bits U1
and U0 of the register address can be set, as explained in the
Command byte configuration section of the datasheet.

Make this more elegant by creating regmaps for each UART port
and setting the read_flag_mask and write_flag_mask
accordingly.

All communcations regarding global registers are done on UART
port 0, so replace the global regmap entirely with the port 0
regmap.

Also, remove the 0x1f masks from reg_writeable(), reg_volatile()
and reg_precious() methods, since setting the U1 and U0 bits of
the register address happens inside the regmap core now.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Link: https://lore.kernel.org/r/20220605144659.4169853-3-demonsingur@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: b35f8dbbce81 ("serial: max310x: prevent infinite while() loop in port startup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max310x.c | 68 +++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index c9032e300a586..d61e8a6bc99dd 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -262,6 +262,7 @@ struct max310x_one {
 	struct work_struct	tx_work;
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
+	struct regmap		*regmap;
 
 	u8 rx_buf[MAX310X_FIFO_SIZE];
 };
@@ -291,26 +292,26 @@ static DECLARE_BITMAP(max310x_lines, MAX310X_UART_NRMAX);
 
 static u8 max310x_port_read(struct uart_port *port, u8 reg)
 {
-	struct max310x_port *s = dev_get_drvdata(port->dev);
+	struct max310x_one *one = to_max310x_port(port);
 	unsigned int val = 0;
 
-	regmap_read(s->regmap, port->iobase + reg, &val);
+	regmap_read(one->regmap, reg, &val);
 
 	return val;
 }
 
 static void max310x_port_write(struct uart_port *port, u8 reg, u8 val)
 {
-	struct max310x_port *s = dev_get_drvdata(port->dev);
+	struct max310x_one *one = to_max310x_port(port);
 
-	regmap_write(s->regmap, port->iobase + reg, val);
+	regmap_write(one->regmap, reg, val);
 }
 
 static void max310x_port_update(struct uart_port *port, u8 reg, u8 mask, u8 val)
 {
-	struct max310x_port *s = dev_get_drvdata(port->dev);
+	struct max310x_one *one = to_max310x_port(port);
 
-	regmap_update_bits(s->regmap, port->iobase + reg, mask, val);
+	regmap_update_bits(one->regmap, reg, mask, val);
 }
 
 static int max3107_detect(struct device *dev)
@@ -449,7 +450,7 @@ static const struct max310x_devtype max14830_devtype = {
 
 static bool max310x_reg_writeable(struct device *dev, unsigned int reg)
 {
-	switch (reg & 0x1f) {
+	switch (reg) {
 	case MAX310X_IRQSTS_REG:
 	case MAX310X_LSR_IRQSTS_REG:
 	case MAX310X_SPCHR_IRQSTS_REG:
@@ -466,7 +467,7 @@ static bool max310x_reg_writeable(struct device *dev, unsigned int reg)
 
 static bool max310x_reg_volatile(struct device *dev, unsigned int reg)
 {
-	switch (reg & 0x1f) {
+	switch (reg) {
 	case MAX310X_RHR_REG:
 	case MAX310X_IRQSTS_REG:
 	case MAX310X_LSR_IRQSTS_REG:
@@ -488,7 +489,7 @@ static bool max310x_reg_volatile(struct device *dev, unsigned int reg)
 
 static bool max310x_reg_precious(struct device *dev, unsigned int reg)
 {
-	switch (reg & 0x1f) {
+	switch (reg) {
 	case MAX310X_RHR_REG:
 	case MAX310X_IRQSTS_REG:
 	case MAX310X_SPCHR_IRQSTS_REG:
@@ -633,18 +634,16 @@ static s32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 
 static void max310x_batch_write(struct uart_port *port, u8 *txbuf, unsigned int len)
 {
-	struct max310x_port *s = dev_get_drvdata(port->dev);
-	u8 reg = port->iobase + MAX310X_THR_REG;
+	struct max310x_one *one = to_max310x_port(port);
 
-	regmap_raw_write(s->regmap, reg, txbuf, len);
+	regmap_raw_write(one->regmap, MAX310X_THR_REG, txbuf, len);
 }
 
 static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsigned int len)
 {
-	struct max310x_port *s = dev_get_drvdata(port->dev);
-	u8 reg = port->iobase + MAX310X_RHR_REG;
+	struct max310x_one *one = to_max310x_port(port);
 
-	regmap_raw_read(s->regmap, reg, rxbuf, len);
+	regmap_raw_read(one->regmap, MAX310X_RHR_REG, rxbuf, len);
 }
 
 static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
@@ -1247,15 +1246,16 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 #endif
 
 static int max310x_probe(struct device *dev, const struct max310x_devtype *devtype,
-			 struct regmap *regmap, int irq)
+			 struct regmap *regmaps[], int irq)
 {
 	int i, ret, fmin, fmax, freq;
 	struct max310x_port *s;
 	s32 uartclk = 0;
 	bool xtal;
 
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	for (i = 0; i < devtype->nr; i++)
+		if (IS_ERR(regmaps[i]))
+			return PTR_ERR(regmaps[i]);
 
 	/* Alloc port structure */
 	s = devm_kzalloc(dev, struct_size(s, p, devtype->nr), GFP_KERNEL);
@@ -1302,7 +1302,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		goto out_clk;
 	}
 
-	s->regmap = regmap;
+	s->regmap = regmaps[0];
 	s->devtype = devtype;
 	dev_set_drvdata(dev, s);
 
@@ -1312,22 +1312,18 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		goto out_clk;
 
 	for (i = 0; i < devtype->nr; i++) {
-		unsigned int offs = i << 5;
-
 		/* Reset port */
-		regmap_write(s->regmap, MAX310X_MODE2_REG + offs,
+		regmap_write(regmaps[i], MAX310X_MODE2_REG,
 			     MAX310X_MODE2_RST_BIT);
 		/* Clear port reset */
-		regmap_write(s->regmap, MAX310X_MODE2_REG + offs, 0);
+		regmap_write(regmaps[i], MAX310X_MODE2_REG, 0);
 
 		/* Wait for port startup */
 		do {
-			regmap_read(s->regmap,
-				    MAX310X_BRGDIVLSB_REG + offs, &ret);
+			regmap_read(regmaps[i], MAX310X_BRGDIVLSB_REG, &ret);
 		} while (ret != 0x01);
 
-		regmap_write(s->regmap, MAX310X_MODE1_REG + offs,
-			     devtype->mode1);
+		regmap_write(regmaps[i], MAX310X_MODE1_REG, devtype->mode1);
 	}
 
 	uartclk = max310x_set_ref_clk(dev, s, freq, xtal);
@@ -1355,11 +1351,13 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		s->p[i].port.fifosize	= MAX310X_FIFO_SIZE;
 		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
 		s->p[i].port.iotype	= UPIO_PORT;
-		s->p[i].port.iobase	= i * 0x20;
+		s->p[i].port.iobase	= i;
 		s->p[i].port.membase	= (void __iomem *)~0;
 		s->p[i].port.uartclk	= uartclk;
 		s->p[i].port.rs485_config = max310x_rs485_config;
 		s->p[i].port.ops	= &max310x_ops;
+		s->p[i].regmap		= regmaps[i];
+
 		/* Disable all interrupts */
 		max310x_port_write(&s->p[i].port, MAX310X_IRQEN_REG, 0);
 		/* Clear IRQ status register */
@@ -1456,6 +1454,7 @@ static struct regmap_config regcfg = {
 	.val_bits = 8,
 	.write_flag_mask = MAX310X_WRITE_BIT,
 	.cache_type = REGCACHE_RBTREE,
+	.max_register = MAX310X_REG_1F,
 	.writeable_reg = max310x_reg_writeable,
 	.volatile_reg = max310x_reg_volatile,
 	.precious_reg = max310x_reg_precious,
@@ -1465,7 +1464,8 @@ static struct regmap_config regcfg = {
 static int max310x_spi_probe(struct spi_device *spi)
 {
 	const struct max310x_devtype *devtype;
-	struct regmap *regmap;
+	struct regmap *regmaps[4];
+	unsigned int i;
 	int ret;
 
 	/* Setup SPI bus */
@@ -1480,10 +1480,14 @@ static int max310x_spi_probe(struct spi_device *spi)
 	if (!devtype)
 		devtype = (struct max310x_devtype *)spi_get_device_id(spi)->driver_data;
 
-	regcfg.max_register = devtype->nr * 0x20 - 1;
-	regmap = devm_regmap_init_spi(spi, &regcfg);
+	for (i = 0; i < devtype->nr; i++) {
+		u8 port_mask = i * 0x20;
+		regcfg.read_flag_mask = port_mask;
+		regcfg.write_flag_mask = port_mask | MAX310X_WRITE_BIT;
+		regmaps[i] = devm_regmap_init_spi(spi, &regcfg);
+	}
 
-	return max310x_probe(&spi->dev, devtype, regmap, spi->irq);
+	return max310x_probe(&spi->dev, devtype, regmaps, spi->irq);
 }
 
 static int max310x_spi_remove(struct spi_device *spi)
-- 
2.43.0


