Return-Path: <linux-kernel+bounces-65522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C261854E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265A11F22E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2FB60BB5;
	Wed, 14 Feb 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j9wNif49"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A475F871;
	Wed, 14 Feb 2024 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927898; cv=none; b=g6SPC49ejLtYEdoZ4SifplYh1YCZnqPe2ulkov6l+eIbF0f832UgHtGspkjfBfa7FsuvkPSXY15Aw/Br32NYx4xooGtP4ZNbYBO+hPwqEy6eiekA8DtwZcEBcl1w8CaKMECeX54NYAXEAOtiGv87AbWC8nL8qFjF70M6MbgRRcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927898; c=relaxed/simple;
	bh=VOfDw64xrAjLKL7SdlbDSsAR3K/CMdlWhNnXfibl/HE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kMSTDzA/SSjO48tjLBKDQrZvEz70MewzjNvn8OUD3TmNKjLn0zNsRz7tfKqisvOZlJvYMfqlu49RfqJ5fOZJVgcgMBCnwUUwCo5oHtmLFv9gax2mjGBBOj4oz7pmDT2o+Q0ZAmxcNEq6Q3x+gzArLcMAlb3xRC6KtlpaZEbgr0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j9wNif49; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2B3860007;
	Wed, 14 Feb 2024 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJ14tHqSqLHFtg6avp0X1Ritv/bgPHCct9WWR86lzjo=;
	b=j9wNif49vyuB2N1ghzZdkYvXJqOuDxV5K/Bldfi6wun0Dm4St/QW8qVvmsniMdQNAVjdux
	fdjzOJeQ8JFIcPHNUnSazEhL49lZEUk3oQLWhS2JDjbItD/P5snFOqYU4/0lkF7dC+l1V+
	sTaPtDu38kiFYbHT/4QoqFLwDIw0fN5kbgUms2Sfv89z5dSfYEyMqvsaJrN4KTpWhufaD2
	UGHCNDOPeAw1R0Q039aeKRlxcjaAZcWwsAneDh46npdB3nUHBguxcwYkzrDQIhMKThYDVU
	OPTfx7eZilXMG6v7fqVRljHF77nY1TZFxer30Y4qof4lz5kG/tizbRvwBCKpOg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:24:05 +0100
Subject: [PATCH 12/23] gpio: nomadik: request dynamic ID allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-12-f88c0ccf372b@bootlin.com>
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
In-Reply-To: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
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
X-Mailer: b4 0.12.4
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
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 55 +++++++++++++++++++++----------
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index e39477e1a58f..8d47aef8d2c4 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -516,7 +516,7 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 
 	nmk_chip->bank = id;
 	chip = &nmk_chip->chip;
-	chip->base = id * NMK_GPIO_PER_CHIP;
+	chip->base = -1;
 	chip->ngpio = NMK_GPIO_PER_CHIP;
 	chip->label = dev_name(&gpio_pdev->dev);
 	chip->parent = &gpio_pdev->dev;
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 8099dd947701..c7693fbc0484 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -530,25 +530,33 @@ static int nmk_get_group_pins(struct pinctrl_dev *pctldev, unsigned int selector
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
@@ -903,8 +911,19 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned int function,
 		 * Then mask the pins that need to be sleeping now when we're
 		 * switching to the ALT C function.
 		 */
-		for (i = 0; i < g->grp.npins; i++)
-			slpm[g->grp.pins[i] / NMK_GPIO_PER_CHIP] &= ~BIT(g->grp.pins[i]);
+		for (i = 0; i < g->grp.npins; i++) {
+			struct nmk_gpio_chip *nmk_chip;
+
+			nmk_chip = find_nmk_gpio_from_pin(g->grp.pins[i], NULL);
+			if (!nmk_chip) {
+				dev_err(npct->dev,
+					"invalid pin offset %d in group %s at index %d\n",
+					g->grp.pins[i], g->grp.name, i);
+				goto out_pre_slpm_init;
+			}
+
+			slpm[nmk_chip->bank] &= ~BIT(g->grp.pins[i]);
+		}
 		nmk_gpio_glitch_slpm_init(slpm);
 	}
 
@@ -912,7 +931,7 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned int function,
 		struct nmk_gpio_chip *nmk_chip;
 		unsigned int bit;
 
-		nmk_chip = find_nmk_gpio_from_pin(g->grp.pins[i]);
+		nmk_chip = find_nmk_gpio_from_pin(g->grp.pins[i], &bit);
 		if (!nmk_chip) {
 			dev_err(npct->dev,
 				"invalid pin offset %d in group %s at index %d\n",
@@ -923,7 +942,6 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned int function,
 			g->grp.pins[i], g->altsetting);
 
 		clk_enable(nmk_chip->clk);
-		bit = g->grp.pins[i] % NMK_GPIO_PER_CHIP;
 		/*
 		 * If the pin is switching to altfunc, and there was an
 		 * interrupt installed on it which has been lazy disabled,
@@ -954,17 +972,18 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned int function,
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
@@ -982,10 +1001,11 @@ static int nmk_gpio_request_enable(struct pinctrl_dev *pctldev,
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
@@ -995,11 +1015,11 @@ static int nmk_gpio_request_enable(struct pinctrl_dev *pctldev,
 
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
 
@@ -1040,7 +1060,7 @@ static int nmk_pin_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 	int pull, slpm, output, val, i;
 	bool lowemi, gpiomode, sleep;
 
-	nmk_chip = find_nmk_gpio_from_pin(pin);
+	nmk_chip = find_nmk_gpio_from_pin(pin, &bit);
 	if (!nmk_chip) {
 		dev_err(npct->dev,
 			"invalid pin offset %d\n", pin);
@@ -1098,7 +1118,6 @@ static int nmk_pin_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			lowemi ? "on" : "off");
 
 		clk_enable(nmk_chip->clk);
-		bit = pin % NMK_GPIO_PER_CHIP;
 		if (gpiomode)
 			/* No glitch when going to GPIO mode */
 			__nmk_gpio_set_mode(nmk_chip, bit, NMK_GPIO_ALT_GPIO);

-- 
2.43.1


