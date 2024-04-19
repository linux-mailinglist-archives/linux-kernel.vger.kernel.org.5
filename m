Return-Path: <linux-kernel+bounces-151414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AD38AAE92
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29EF21F22327
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6BC83A09;
	Fri, 19 Apr 2024 12:35:22 +0000 (UTC)
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08F5812F;
	Fri, 19 Apr 2024 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713530121; cv=none; b=P5qhuBfEj0/joa1GqqsHRrhxgV0vcrHO0M4zyxtgQLO04IcAPe95wJ9ncmoeNTQ+BUG9pW4BnN1pRF/vuJEAHXVP8juAgqvOV1Ldnij2T/VOyVu8mNSjjaAX/1LfHEWrVQb8Pgecks09PoMZR3QVsulllfh2ZHexkqIqj34ffgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713530121; c=relaxed/simple;
	bh=dxcXW3Z5o69jrxta3xxO8E57aeJDmyUL46fXb1HiMZg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cqbH3BrJBqww2Y5WWLW+TX2vZMOpkNGO3Pq95hH1h1pQNfq50gEjuLA+0h8hSRhP+D61IGNHGWr2E+T2rskWkjY5FIBv4PAoiyx8r293xuXZ9yRaUsS9uTbX6Lx82BQHWz3ciiZwjMuQPg0ML4zUunq1Ahr1YazbhFyzOcvoH8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from localhost.localdomain (unknown [82.64.135.138])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 29DC82003CC;
	Fri, 19 Apr 2024 14:35:08 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 4D89840039; Fri, 19 Apr 2024 14:34:12 +0200 (CEST)
Date: Fri, 19 Apr 2024 14:34:12 +0200
From: Etienne Buira <etienne.buira@free.fr>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, etienne.buira@free.fr
Subject: [PATCH v2] gpio-syscon: do not report bogus error
Message-ID: <ZiJkxBU3bYNWOdbK@Z926fQmE5jqhFMgp6>
Mail-Followup-To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, etienne.buira@free.fr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Do not issue "can't read the data register offset!" when gpio,syscon-dev
is not set albeit unneeded.  gpio-syscon is used with rk3328 chip, but
this iomem region is documented in
Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml and
does not require gpio,syscon-dev setting.

It has been suggested to automatically detect if node has a valid
parent, but that would defeat the purpose of error message, for example
arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi could then be used
without gpio,syscon-dev, and lead to funny results without error
message.

It has been tried to mandate use of gpio,syscon-dev, but that raised
objection.

So while this patch may be kludgy, it looks the less bad to address
the spurious dev_err call.

v2:
  - changed flag name

Signed-off-by: Etienne Buira <etienne.buira@free.fr>
---
 drivers/gpio/gpio-syscon.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 6e1a2581e6ae..4f103ce26019 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -13,9 +13,10 @@
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 
-#define GPIO_SYSCON_FEAT_IN	BIT(0)
-#define GPIO_SYSCON_FEAT_OUT	BIT(1)
-#define GPIO_SYSCON_FEAT_DIR	BIT(2)
+#define GPIO_SYSCON_FEAT_IN		BIT(0)
+#define GPIO_SYSCON_FEAT_OUT		BIT(1)
+#define GPIO_SYSCON_FEAT_DIR		BIT(2)
+#define GPIO_SYSCON_FEAT_USE_PARENT	BIT(3)
 
 /* SYSCON driver is designed to use 32-bit wide registers */
 #define SYSCON_REG_SIZE		(4)
@@ -27,7 +28,9 @@
  * @flags:		Set of GPIO_SYSCON_FEAT_ flags:
  *			GPIO_SYSCON_FEAT_IN:	GPIOs supports input,
  *			GPIO_SYSCON_FEAT_OUT:	GPIOs supports output,
- *			GPIO_SYSCON_FEAT_DIR:	GPIOs supports switch direction.
+ *			GPIO_SYSCON_FEAT_DIR:	GPIOs supports switch direction,
+ *			GPIO_SYSCON_FEAT_USE_PARENT:	gpio,syscon-dev do not
+ *				have to be set, parent regspace will be used.
  * @bit_count:		Number of bits used as GPIOs.
  * @dat_bit_offset:	Offset (in bits) to the first GPIO bit.
  * @dir_bit_offset:	Optional offset (in bits) to the first bit to switch
@@ -149,7 +152,7 @@ static void rockchip_gpio_set(struct gpio_chip *chip, unsigned int offset,
 
 static const struct syscon_gpio_data rockchip_rk3328_gpio_mute = {
 	/* RK3328 GPIO_MUTE is an output only pin at GRF_SOC_CON10[1] */
-	.flags		= GPIO_SYSCON_FEAT_OUT,
+	.flags		= GPIO_SYSCON_FEAT_OUT | GPIO_SYSCON_FEAT_USE_PARENT,
 	.bit_count	= 1,
 	.dat_bit_offset = 0x0428 * 8 + 1,
 	.set		= rockchip_gpio_set,
@@ -221,19 +224,21 @@ static int syscon_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->syscon))
 		return PTR_ERR(priv->syscon);
 
-	ret = of_property_read_u32_index(np, "gpio,syscon-dev", 1,
-					 &priv->dreg_offset);
-	if (ret)
-		dev_err(dev, "can't read the data register offset!\n");
+	if (!(priv->data->flags & GPIO_SYSCON_FEAT_USE_PARENT)) {
+		ret = of_property_read_u32_index(np, "gpio,syscon-dev", 1,
+						 &priv->dreg_offset);
+		if (ret)
+			dev_err(dev, "can't read the data register offset!\n");
 
-	priv->dreg_offset <<= 3;
+		priv->dreg_offset <<= 3;
 
-	ret = of_property_read_u32_index(np, "gpio,syscon-dev", 2,
-					 &priv->dir_reg_offset);
-	if (ret)
-		dev_dbg(dev, "can't read the dir register offset!\n");
+		ret = of_property_read_u32_index(np, "gpio,syscon-dev", 2,
+						 &priv->dir_reg_offset);
+		if (ret)
+			dev_dbg(dev, "can't read the dir register offset!\n");
 
-	priv->dir_reg_offset <<= 3;
+		priv->dir_reg_offset <<= 3;
+	}
 
 	priv->chip.parent = dev;
 	priv->chip.owner = THIS_MODULE;

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.43.0


