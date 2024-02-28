Return-Path: <linux-kernel+bounces-84896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D5286AD4B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B793B249D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8388815A49F;
	Wed, 28 Feb 2024 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fAROkT0H"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866CE14EFC9;
	Wed, 28 Feb 2024 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119709; cv=none; b=IoKWXCiHZs4i08JHjrWnJKmOX7NInD74caILRo5bDmbk/DGMVrrdAajIyiRUXw9YzcBG/go1yA2xADDdlT1nknY1EJ9oTTL/WUJmg/WFYdP3DIenbPhmppBD9etBA0p0NpZi+PKQV/3eVQFTHrXGAWvxsTmWAzZJP87sIaX2gGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119709; c=relaxed/simple;
	bh=U2lbS9LDrBJq41Jr4wQmSyBLCS56Kq+xmsOSxI9mx1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VB2uBnFBMIG8Ycw0W6h01rWuPXe8vkoMMcPfUAaEPtozThQsKL9imTHT1swAL1GsxZj4ge5hiU1B2hVKAOXJrs9icwMjU3o27RUqvuv0Qvp2mYf1mFZtaoBnhTCnAMfdYGXbkh/WQFlMuI7vwboKLgW/adr1akaejIh3Ksp7fuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fAROkT0H; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B3F91BF213;
	Wed, 28 Feb 2024 11:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=It/BSKt5Sbfkf+TU6yukAJhR+S2DFSVZHDKVJ3bhbAM=;
	b=fAROkT0Hljn5SK22F8DzfJSaVfYf9hwl7TSS6FLJHagWJICZGEGoCBYro5wdyTEQGg5sex
	PfWvQrkyVSCbrrwBZjYE7fD+upJ0pPOiyWnHDdEiJsWbavgEHjCCOqgcZdPFV8EgLOApt9
	VVwdTwG+A9gSrjUw3sWqcrVUHJG6djYJRnLDooJ1+1eA7J30kH5tIfKIeDCwFGCTCyOKDS
	KaJ7q/7J/+3Xw20SGCgO1si1njCcnboMtg4X7xpGHJVqqHj+YdFRezhjwLTW11up2gichH
	B9M5I+Vyr5UHay46vfBmjJsNG+3LZ6GrpC2tLJbDnV4TGMcBTL10/KIYLPa7TQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:17 +0100
Subject: [PATCH v2 19/30] gpio: nomadik: request dynamic ID allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-19-3ba757474006@bootlin.com>
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Move away from statically allocated GPIO IDs. Switch to dynamic ID
allocation. Static IDs are deprecated because they cause issues when
multiple GPIO controllers are to be found on the same platform.

Add a bit of complexity to do pin number -> GPIO chip + offset.
Previously, bank number and offsets were retrieved using division and
remainder (bank size being constant 32). Now, to get the pin number
matching a bank base, we must know the sum of ngpios of previous banks.
This is done in find_nmk_gpio_from_pin() which also exposes the offset
inside the bank.

Also remove the assumption that bank sizes are constant. Instead of
using NMK_GPIO_PER_CHIP as bank size, use nmk_gpio_chips[i]->ngpio.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/gpio/gpio-nomadik.c               |  2 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 54 ++++++++++++++++++++-----------
 2 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index fb821a9b6c5f..b7d76cc901dc 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -519,7 +519,7 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 
 	nmk_chip->bank = id;
 	chip = &nmk_chip->chip;
-	chip->base = id * NMK_GPIO_PER_CHIP;
+	chip->base = -1;
 	chip->ngpio = NMK_GPIO_PER_CHIP;
 	chip->label = dev_name(gpio_dev);
 	chip->parent = gpio_dev;
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index b74378302229..5633f0ec2715 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -531,25 +531,33 @@ static int nmk_get_group_pins(struct pinctrl_dev *pctldev, unsigned int selector
 	return 0;
 }
 
-static struct nmk_gpio_chip *find_nmk_gpio_from_pin(unsigned int pin)
+/* This makes the mapping from pin number to a GPIO chip. We also return the pin
+ * offset in the GPIO chip for convenience (and to avoid a second loop).
+ */
+static struct nmk_gpio_chip *find_nmk_gpio_from_pin(unsigned int pin,
+						    unsigned int *offset)
 {
-	int i;
+	int i, j = 0;
 	struct nmk_gpio_chip *nmk_gpio;
 
+	/* We assume that pins are allocated in bank order. */
 	for (i = 0; i < NMK_MAX_BANKS; i++) {
 		nmk_gpio = nmk_gpio_chips[i];
 		if (!nmk_gpio)
 			continue;
-		if (pin >= nmk_gpio->chip.base &&
-		    pin < nmk_gpio->chip.base + nmk_gpio->chip.ngpio)
+		if (pin >= j && pin < j + nmk_gpio->chip.ngpio) {
+			if (offset)
+				*offset = pin - j;
 			return nmk_gpio;
+		}
+		j += nmk_gpio->chip.ngpio;
 	}
 	return NULL;
 }
 
 static struct gpio_chip *find_gc_from_pin(unsigned int pin)
 {
-	struct nmk_gpio_chip *nmk_gpio = find_nmk_gpio_from_pin(pin);
+	struct nmk_gpio_chip *nmk_gpio = find_nmk_gpio_from_pin(pin, NULL);
 
 	if (nmk_gpio)
 		return &nmk_gpio->chip;
@@ -905,8 +913,18 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned int function,
 		 * switching to the ALT C function.
 		 */
 		for (i = 0; i < g->grp.npins; i++) {
-			unsigned int bit = g->grp.pins[i] % NMK_GPIO_PER_CHIP;
-			slpm[g->grp.pins[i] / NMK_GPIO_PER_CHIP] &= ~BIT(bit);
+			struct nmk_gpio_chip *nmk_chip;
+			unsigned int bit;
+
+			nmk_chip = find_nmk_gpio_from_pin(g->grp.pins[i], &bit);
+			if (!nmk_chip) {
+				dev_err(npct->dev,
+					"invalid pin offset %d in group %s at index %d\n",
+					g->grp.pins[i], g->grp.name, i);
+				goto out_pre_slpm_init;
+			}
+
+			slpm[nmk_chip->bank] &= ~BIT(bit);
 		}
 		nmk_gpio_glitch_slpm_init(slpm);
 	}
@@ -915,7 +933,7 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned int function,
 		struct nmk_gpio_chip *nmk_chip;
 		unsigned int bit;
 
-		nmk_chip = find_nmk_gpio_from_pin(g->grp.pins[i]);
+		nmk_chip = find_nmk_gpio_from_pin(g->grp.pins[i], &bit);
 		if (!nmk_chip) {
 			dev_err(npct->dev,
 				"invalid pin offset %d in group %s at index %d\n",
@@ -926,7 +944,6 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned int function,
 			g->grp.pins[i], g->altsetting);
 
 		clk_enable(nmk_chip->clk);
-		bit = g->grp.pins[i] % NMK_GPIO_PER_CHIP;
 		/*
 		 * If the pin is switching to altfunc, and there was an
 		 * interrupt installed on it which has been lazy disabled,
@@ -957,17 +974,18 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned int function,
 	ret = 0;
 
 out_glitch:
-	if (glitch) {
+	if (glitch)
 		nmk_gpio_glitch_slpm_restore(slpm);
+out_pre_slpm_init:
+	if (glitch)
 		spin_unlock_irqrestore(&nmk_gpio_slpm_lock, flags);
-	}
 
 	return ret;
 }
 
 static int nmk_gpio_request_enable(struct pinctrl_dev *pctldev,
 				   struct pinctrl_gpio_range *range,
-				   unsigned int offset)
+				   unsigned int pin)
 {
 	struct nmk_pinctrl *npct = pinctrl_dev_get_drvdata(pctldev);
 	struct nmk_gpio_chip *nmk_chip;
@@ -985,10 +1003,11 @@ static int nmk_gpio_request_enable(struct pinctrl_dev *pctldev,
 	chip = range->gc;
 	nmk_chip = gpiochip_get_data(chip);
 
-	dev_dbg(npct->dev, "enable pin %u as GPIO\n", offset);
+	dev_dbg(npct->dev, "enable pin %u as GPIO\n", pin);
+
+	find_nmk_gpio_from_pin(pin, &bit);
 
 	clk_enable(nmk_chip->clk);
-	bit = offset % NMK_GPIO_PER_CHIP;
 	/* There is no glitch when converting any pin to GPIO */
 	__nmk_gpio_set_mode(nmk_chip, bit, NMK_GPIO_ALT_GPIO);
 	clk_disable(nmk_chip->clk);
@@ -998,11 +1017,11 @@ static int nmk_gpio_request_enable(struct pinctrl_dev *pctldev,
 
 static void nmk_gpio_disable_free(struct pinctrl_dev *pctldev,
 				  struct pinctrl_gpio_range *range,
-				  unsigned int offset)
+				  unsigned int pin)
 {
 	struct nmk_pinctrl *npct = pinctrl_dev_get_drvdata(pctldev);
 
-	dev_dbg(npct->dev, "disable pin %u as GPIO\n", offset);
+	dev_dbg(npct->dev, "disable pin %u as GPIO\n", pin);
 	/* Set the pin to some default state, GPIO is usually default */
 }
 
@@ -1043,7 +1062,7 @@ static int nmk_pin_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 	int pull, slpm, output, val, i;
 	bool lowemi, gpiomode, sleep;
 
-	nmk_chip = find_nmk_gpio_from_pin(pin);
+	nmk_chip = find_nmk_gpio_from_pin(pin, &bit);
 	if (!nmk_chip) {
 		dev_err(npct->dev,
 			"invalid pin offset %d\n", pin);
@@ -1101,7 +1120,6 @@ static int nmk_pin_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			lowemi ? "on" : "off");
 
 		clk_enable(nmk_chip->clk);
-		bit = pin % NMK_GPIO_PER_CHIP;
 		if (gpiomode)
 			/* No glitch when going to GPIO mode */
 			__nmk_gpio_set_mode(nmk_chip, bit, NMK_GPIO_ALT_GPIO);

-- 
2.44.0


