Return-Path: <linux-kernel+bounces-84899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE3486AD5A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A919B211E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B112F15B114;
	Wed, 28 Feb 2024 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DBZ/9Xhe"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006FE12F38F;
	Wed, 28 Feb 2024 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119711; cv=none; b=dubIT8FopCTpcVP/7WY2d53oy27LlXLJ8FrUjv2/IRtx6UTDpWdCsqnIYYw7j8VNGeYcvB/HKJUD1FCkYgtV+77mLvfqHyyX1NNFYDoO+8GjCZmmRtXFMTg1ebFpakM0x16vf+9e0QrVQqVoHTaIf8I+SepnqiAVPZ9tAbZfm70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119711; c=relaxed/simple;
	bh=Bt01r7qnkqveaEZoAxJtWKfIOL9IL4OdMDDB8Om59DE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MRcVqtzmk2kCE3x9KH69U8CS5wt/O+z8EXXnxdtvVdb25Y0R0h/0mhADy0Tnljj/iJEnmgkxHpjPDGcoxKJ+BMooKofx2kjrdD1ysrAcgMp8DVcYW09EEdXNjv3TjgoYgDxkYhY35W7S5p7bsjGGmLKXTgtYoCYk894d7o4jMY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DBZ/9Xhe; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A12871BF204;
	Wed, 28 Feb 2024 11:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CKPeuaFeg2qn7vKIBXgXa0jHiCHpqCVug3U+r+c9qM=;
	b=DBZ/9XhetHH8Lu80R4BIRRy4pKmJa5KlrneukUL2KEppGtVd3Jimh3KZ4BpnODbAenFSAX
	5Ryf78hAO1Vg0QkgruAEsm4wpy7sGXOsipe0c7doA6m5DaCxtvT6DA0JriskHl6Vk3gLrJ
	tmuDTaJNM4ICu4cC8v4BAYh+zafRD5U/xpLtizRBobm32ikRp/JuSAUp7zGAzqskd+v+47
	s1J7L6SHK7JYNkm9MVsR/kaCcvpiPj6Db+9KHyiGExr5N6XCgvkhcAnM1pgNYmNv9YjXqp
	tMi+0eTiHlFSR9AK2JY2zT16dcymg4LzQbKqhBkbo1MB0XPFXrnmWIz3VjqvBg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:20 +0100
Subject: [PATCH v2 22/30] gpio: nomadik: support shared GPIO IRQs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-22-3ba757474006@bootlin.com>
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

Support a single IRQs used by multiple GPIO banks. Change the IRQ
handler type from a chained handler (as used by gpiolib
for ->parent_handler) to a threaded IRQ.

Use the generic_handle_domain_irq_safe() helper. The non-safe version
must be called in a no-IRQ context.

The Mobileye EyeQ5 platform uses this GPIO controller and share an IRQ
for its two banks.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/gpio/gpio-nomadik.c | 68 ++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index c22a0864ca70..ca5c28965224 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -255,27 +255,28 @@ static void nmk_gpio_irq_shutdown(struct irq_data *d)
 	clk_disable(nmk_chip->clk);
 }
 
-static void nmk_gpio_irq_handler(struct irq_desc *desc)
+static irqreturn_t nmk_gpio_irq_handler(int irq, void *dev_id)
 {
-	struct irq_chip *host_chip = irq_desc_get_chip(desc);
-	struct gpio_chip *chip = irq_desc_get_handler_data(desc);
-	struct nmk_gpio_chip *nmk_chip = gpiochip_get_data(chip);
-	u32 status;
-
-	chained_irq_enter(host_chip, desc);
+	struct nmk_gpio_chip *nmk_chip = dev_id;
+	struct gpio_chip *chip = &nmk_chip->chip;
+	unsigned long mask = GENMASK(chip->ngpio - 1, 0);
+	unsigned long status;
+	int bit;
 
 	clk_enable(nmk_chip->clk);
+
 	status = readl(nmk_chip->addr + NMK_GPIO_IS);
-	clk_disable(nmk_chip->clk);
 
-	while (status) {
-		int bit = __ffs(status);
+	/* Ensure we cannot leave pending bits; this should never occur. */
+	if (unlikely(status & ~mask))
+		writel(status & ~mask, nmk_chip->addr + NMK_GPIO_IC);
 
-		generic_handle_domain_irq(chip->irq.domain, bit);
-		status &= ~BIT(bit);
-	}
+	clk_disable(nmk_chip->clk);
 
-	chained_irq_exit(host_chip, desc);
+	for_each_set_bit(bit, &status, chip->ngpio)
+		generic_handle_domain_irq_safe(chip->irq.domain, bit);
+
+	return IRQ_RETVAL((status & mask) != 0);
 }
 
 /* I/O Functions */
@@ -568,19 +569,20 @@ static const struct irq_chip nmk_irq_chip = {
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
-static int nmk_gpio_probe(struct platform_device *dev)
+static int nmk_gpio_probe(struct platform_device *pdev)
 {
-	struct device_node *np = dev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct nmk_gpio_chip *nmk_chip;
-	struct gpio_chip *chip;
 	struct gpio_irq_chip *girq;
 	bool supports_sleepmode;
+	struct gpio_chip *chip;
 	int irq;
 	int ret;
 
-	nmk_chip = nmk_gpio_populate_chip(np, dev);
+	nmk_chip = nmk_gpio_populate_chip(np, pdev);
 	if (IS_ERR(nmk_chip)) {
-		dev_err(&dev->dev, "could not populate nmk chip struct\n");
+		dev_err(dev, "could not populate nmk chip struct\n");
 		return PTR_ERR(nmk_chip);
 	}
 
@@ -588,9 +590,9 @@ static int nmk_gpio_probe(struct platform_device *dev)
 		device_property_read_bool(dev, "st,supports-sleepmode");
 
 	/* Correct platform device ID */
-	dev->id = nmk_chip->bank;
+	pdev->id = nmk_chip->bank;
 
-	irq = platform_get_irq(dev, 0);
+	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 
@@ -602,7 +604,7 @@ static int nmk_gpio_probe(struct platform_device *dev)
 	spin_lock_init(&nmk_chip->lock);
 
 	chip = &nmk_chip->chip;
-	chip->parent = &dev->dev;
+	chip->parent = dev;
 	chip->request = gpiochip_generic_request;
 	chip->free = gpiochip_generic_free;
 	chip->get_direction = nmk_gpio_get_dir;
@@ -616,17 +618,19 @@ static int nmk_gpio_probe(struct platform_device *dev)
 
 	girq = &chip->irq;
 	gpio_irq_chip_set_chip(girq, &nmk_irq_chip);
-	girq->parent_handler = nmk_gpio_irq_handler;
-	girq->num_parents = 1;
-	girq->parents = devm_kcalloc(&dev->dev, 1,
-				     sizeof(*girq->parents),
-				     GFP_KERNEL);
-	if (!girq->parents)
-		return -ENOMEM;
-	girq->parents[0] = irq;
+	girq->parent_handler = NULL;
+	girq->num_parents = 0;
+	girq->parents = NULL;
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_edge_irq;
 
+	ret = devm_request_irq(dev, irq, nmk_gpio_irq_handler, IRQF_SHARED,
+			       dev_name(dev), nmk_chip);
+	if (ret) {
+		dev_err(dev, "failed requesting IRQ\n");
+		return ret;
+	}
+
 	clk_enable(nmk_chip->clk);
 	nmk_chip->lowemi = readl_relaxed(nmk_chip->addr + NMK_GPIO_LOWEMI);
 	clk_disable(nmk_chip->clk);
@@ -635,9 +639,9 @@ static int nmk_gpio_probe(struct platform_device *dev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(dev, nmk_chip);
+	platform_set_drvdata(pdev, nmk_chip);
 
-	dev_info(&dev->dev, "chip registered\n");
+	dev_info(dev, "chip registered\n");
 
 	return 0;
 }

-- 
2.44.0


