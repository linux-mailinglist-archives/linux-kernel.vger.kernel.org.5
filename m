Return-Path: <linux-kernel+bounces-102169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5F787AF00
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA3C1C2310E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BEB605C9;
	Wed, 13 Mar 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSHYZWBf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1183F7DA33;
	Wed, 13 Mar 2024 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349388; cv=none; b=WFIrZC4cR++nGvtyAOala7Cxgqusz3QCykttH/y/A0cKilXIkJwupYdw9A2mj+BK9XBhpBGr8Eyy06UBbuO/M1sR+ox5CUeBZg4xtPqgLD9T2gAiGQn0QECApgpCjUErsPk20O3oIfaLvQkhXwcdudB+XdWx1Okav5EGC64VrYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349388; c=relaxed/simple;
	bh=9lzwCHS6A32+VxdmU1FhUsZBTyFFxCDk4Ecv5s2kmnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gqc9n+1lHgAMN9MKT9zirwi41vxC/A8BAiajl9H1yB7sJ2CrusI5urLb4OTxflJM1T2bic9s7p8fpxbgblAZDxaJ+tGs22M8LOD+RQ6AXorE7JTHfmb28myU8GRMaVtqxq00bBSCtfM7+OEprtktuVwk107vyBkZWk5m5jtP9rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSHYZWBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159FEC433C7;
	Wed, 13 Mar 2024 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349387;
	bh=9lzwCHS6A32+VxdmU1FhUsZBTyFFxCDk4Ecv5s2kmnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BSHYZWBfcZc0gpm016oXochQRFVUw1MY8CQXiUgSACKMwIDQ/7Oor2t/wX8BmYQej
	 Rhb4jWBNOdaxjc307SBYE9cfFSTigPgQUbGtYzruJm7klgHpcdjtVqdJ08/xzs6T3B
	 ihVslZ63Tg/Rq2DrQEYSN1ZdysoeTQHsoMkN8H04DbxQDFeLwlH/SVTIk6NinUz3yr
	 Orknen0fylkNfoJ7c+TJ2kzw6mWzF3bdFf9gbY0a/eWtTozX2x3OQm64QcqISLTI24
	 /E5crA1t4whGMWr+SUJB34XLpGqwIFsdqhHQHWgh9Nn4P8Nd27tkD21mEY2IydL3Hn
	 Cq+57cOnHbjnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 48/51] serial: max310x: make accessing revision id interface-agnostic
Date: Wed, 13 Mar 2024 13:02:09 -0400
Message-ID: <20240313170212.616443-49-sashal@kernel.org>
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

[ Upstream commit b3883ab5e95713e479f774ea68be275413e8e5b2 ]

SPI can only use 5 address bits, since one bit is reserved for
specifying R/W and 2 bits are used to specify the UART port.
To access registers that have addresses past 0x1F, an extended
register space can be enabled by writing to the GlobalCommand
register (address 0x1F).

I2C uses 8 address bits. The R/W bit is placed in the slave
address, and so is the UART port. Because of this, registers
that have addresses higher than 0x1F can be accessed normally.

To access the RevID register, on SPI, 0xCE must be written to
the 0x1F address to enable the extended register space, after
which the RevID register is accessible at address 0x5. 0xCD
must be written to the 0x1F address to disable the extended
register space.

On I2C, the RevID register is accessible at address 0x25.

Create an interface config struct, and add a method for
toggling the extended register space and a member for the RevId
register address. Implement these for SPI.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Link: https://lore.kernel.org/r/20220605144659.4169853-4-demonsingur@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 3f42b142ea11 ("serial: max310x: fix IO data corruption in batched operations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max310x.c | 40 +++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index a09ec46e0310d..b90281ac54c85 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -72,7 +72,7 @@
 #define MAX310X_GLOBALCMD_REG		MAX310X_REG_1F /* Global Command (WO) */
 
 /* Extended registers */
-#define MAX310X_REVID_EXTREG		MAX310X_REG_05 /* Revision ID */
+#define MAX310X_SPI_REVID_EXTREG	MAX310X_REG_05 /* Revision ID */
 
 /* IRQ register bits */
 #define MAX310X_IRQ_LSR_BIT		(1 << 0) /* LSR interrupt */
@@ -253,6 +253,12 @@
 #define MAX14830_BRGCFG_CLKDIS_BIT	(1 << 6) /* Clock Disable */
 #define MAX14830_REV_ID			(0xb0)
 
+struct max310x_if_cfg {
+	int (*extended_reg_enable)(struct device *dev, bool enable);
+
+	unsigned int rev_id_reg;
+};
+
 struct max310x_devtype {
 	char	name[9];
 	int	nr;
@@ -275,6 +281,7 @@ struct max310x_one {
 
 struct max310x_port {
 	const struct max310x_devtype *devtype;
+	const struct max310x_if_cfg *if_cfg;
 	struct regmap		*regmap;
 	struct clk		*clk;
 #ifdef CONFIG_GPIOLIB
@@ -364,13 +371,12 @@ static int max3109_detect(struct device *dev)
 	unsigned int val = 0;
 	int ret;
 
-	ret = regmap_write(s->regmap, MAX310X_GLOBALCMD_REG,
-			   MAX310X_EXTREG_ENBL);
+	ret = s->if_cfg->extended_reg_enable(dev, true);
 	if (ret)
 		return ret;
 
-	regmap_read(s->regmap, MAX310X_REVID_EXTREG, &val);
-	regmap_write(s->regmap, MAX310X_GLOBALCMD_REG, MAX310X_EXTREG_DSBL);
+	regmap_read(s->regmap, s->if_cfg->rev_id_reg, &val);
+	s->if_cfg->extended_reg_enable(dev, false);
 	if (((val & MAX310x_REV_MASK) != MAX3109_REV_ID)) {
 		dev_err(dev,
 			"%s ID 0x%02x does not match\n", s->devtype->name, val);
@@ -395,13 +401,12 @@ static int max14830_detect(struct device *dev)
 	unsigned int val = 0;
 	int ret;
 
-	ret = regmap_write(s->regmap, MAX310X_GLOBALCMD_REG,
-			   MAX310X_EXTREG_ENBL);
+	ret = s->if_cfg->extended_reg_enable(dev, true);
 	if (ret)
 		return ret;
 	
-	regmap_read(s->regmap, MAX310X_REVID_EXTREG, &val);
-	regmap_write(s->regmap, MAX310X_GLOBALCMD_REG, MAX310X_EXTREG_DSBL);
+	regmap_read(s->regmap, s->if_cfg->rev_id_reg, &val);
+	s->if_cfg->extended_reg_enable(dev, false);
 	if (((val & MAX310x_REV_MASK) != MAX14830_REV_ID)) {
 		dev_err(dev,
 			"%s ID 0x%02x does not match\n", s->devtype->name, val);
@@ -1250,6 +1255,7 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 #endif
 
 static int max310x_probe(struct device *dev, const struct max310x_devtype *devtype,
+			 const struct max310x_if_cfg *if_cfg,
 			 struct regmap *regmaps[], int irq)
 {
 	int i, ret, fmin, fmax, freq;
@@ -1313,6 +1319,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 
 	s->regmap = regmaps[0];
 	s->devtype = devtype;
+	s->if_cfg = if_cfg;
 	dev_set_drvdata(dev, s);
 
 	/* Check device to ensure we are talking to what we expect */
@@ -1482,6 +1489,19 @@ static struct regmap_config regcfg = {
 };
 
 #ifdef CONFIG_SPI_MASTER
+static int max310x_spi_extended_reg_enable(struct device *dev, bool enable)
+{
+	struct max310x_port *s = dev_get_drvdata(dev);
+
+	return regmap_write(s->regmap, MAX310X_GLOBALCMD_REG,
+			    enable ? MAX310X_EXTREG_ENBL : MAX310X_EXTREG_DSBL);
+}
+
+static const struct max310x_if_cfg __maybe_unused max310x_spi_if_cfg = {
+	.extended_reg_enable = max310x_spi_extended_reg_enable,
+	.rev_id_reg = MAX310X_SPI_REVID_EXTREG,
+};
+
 static int max310x_spi_probe(struct spi_device *spi)
 {
 	const struct max310x_devtype *devtype;
@@ -1508,7 +1528,7 @@ static int max310x_spi_probe(struct spi_device *spi)
 		regmaps[i] = devm_regmap_init_spi(spi, &regcfg);
 	}
 
-	return max310x_probe(&spi->dev, devtype, regmaps, spi->irq);
+	return max310x_probe(&spi->dev, devtype, &max310x_spi_if_cfg, regmaps, spi->irq);
 }
 
 static int max310x_spi_remove(struct spi_device *spi)
-- 
2.43.0


