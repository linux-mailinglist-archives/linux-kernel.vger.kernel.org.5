Return-Path: <linux-kernel+bounces-65526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5074854E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3561F21B44
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CDB6351C;
	Wed, 14 Feb 2024 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mCxe5QlQ"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8216C6088E;
	Wed, 14 Feb 2024 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927901; cv=none; b=eh8PtnHn1BPeC3Fe8qIsxr1MbG/wMY8k5vyUxpbQhiExD5+JhcsgJ9T0tw1YJtfvFa35q4NfejyAI5h/r2haGuyei4jgDFNutNo2pEbAbV/hoPy1aGvZ8YLJFnNIQQ1Nhws2BRoX9ZgwSFLCDCMzsHt1VgX0sAyYQqGf0guuHoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927901; c=relaxed/simple;
	bh=Dq+giMSUiMzlo14BqRxYrVJPYX/xUeMg7SlukALOVs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ozgzKYCPk+Ekd/OJe5Hhe1mOjiEIl3ZOncNf3kzKUte9zShKFloRz6FTwJHlcXbVXZruMMIcYIJc5uiHYdZV330SbEbpxb58DUV4fcnA0dzg0nCoOW7aApOfcIlXYEAmnX/M68wIymQGEuH/XSg4joXIZQhiXzlO0mHXl2oEsec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mCxe5QlQ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E806860005;
	Wed, 14 Feb 2024 16:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NCaDRLYX6xBK4eyROrBs4lVh6WU3g4rBScYkTurdSWQ=;
	b=mCxe5QlQ1CXL3R/VEcTEcrDDKJ45tWeH1dLQWwLBZquhcJp5kevwlZJYZe52ad1kBS1MfN
	GNJa+X4fuRxTWvUa8avI7ZbBz9MQ6zIO1XzBH7qOY1gSlpd8qvnQqtMe3heeyXUceOrrP8
	Mz0UEQaC2oM9SXp4j2pZ3dE7aOngHFyqkst28vERPlgAEyKzRWEXmJB2bosvfhTdLs8lLu
	ZQDZ717HQvMECJ8TCGvRg3T/WS75/YTP1u/grxJkfjVqODzcAf4pYKy7j3B7J88/P32dHJ
	etJ8HyzzA4TKvHVlDQKBrQq1BgJ4C/u5v6HWf/F+UafmeU851Yg7HwE/lRZKzw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:24:09 +0100
Subject: [PATCH 16/23] gpio: nomadik: support shared GPIO IRQs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-16-f88c0ccf372b@bootlin.com>
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

Support a single IRQs used by multiple GPIO banks. Change the IRQ
handler type from a chained handler (as used by gpiolib
for ->parent_handler) to a threaded IRQ.

Use a fake raw spinlock to ensure generic_handle_irq() is called in a
no-irq context. See Documentation/driver-api/gpio/driver.rst, "CHAINED
CASCADED GPIO IRQCHIPS" for additional information.

The Mobileye EyeQ5 platform uses this GPIO controller and share an IRQ
for its two banks.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/gpio/gpio-nomadik.c       | 67 +++++++++++++++++++++------------------
 include/linux/gpio/gpio-nomadik.h |  1 +
 2 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 25c8490aa1b6..5b1e3b3efcff 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -254,27 +254,31 @@ static void nmk_gpio_irq_shutdown(struct irq_data *d)
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
+	unsigned long flags, status;
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
+
+	clk_disable(nmk_chip->clk);
 
+	for_each_set_bit(bit, &status, chip->ngpio) {
+		raw_spin_lock_irqsave(&nmk_chip->fake_lock, flags);
 		generic_handle_domain_irq(chip->irq.domain, bit);
-		status &= ~BIT(bit);
+		raw_spin_unlock_irqrestore(&nmk_chip->fake_lock, flags);
 	}
 
-	chained_irq_exit(host_chip, desc);
+	return IRQ_RETVAL((status & mask) != 0);
 }
 
 /* I/O Functions */
@@ -566,19 +570,20 @@ static const struct irq_chip nmk_irq_chip = {
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
 
@@ -586,9 +591,9 @@ static int nmk_gpio_probe(struct platform_device *dev)
 		of_property_read_bool(np, "st,supports-sleepmode");
 
 	/* Correct platform device ID */
-	dev->id = nmk_chip->bank;
+	pdev->id = nmk_chip->bank;
 
-	irq = platform_get_irq(dev, 0);
+	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 
@@ -600,7 +605,7 @@ static int nmk_gpio_probe(struct platform_device *dev)
 	spin_lock_init(&nmk_chip->lock);
 
 	chip = &nmk_chip->chip;
-	chip->parent = &dev->dev;
+	chip->parent = dev;
 	chip->request = gpiochip_generic_request;
 	chip->free = gpiochip_generic_free;
 	chip->get_direction = nmk_gpio_get_dir;
@@ -614,17 +619,19 @@ static int nmk_gpio_probe(struct platform_device *dev)
 
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
@@ -633,9 +640,9 @@ static int nmk_gpio_probe(struct platform_device *dev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(dev, nmk_chip);
+	platform_set_drvdata(pdev, nmk_chip);
 
-	dev_info(&dev->dev, "chip registered\n");
+	dev_info(dev, "chip registered\n");
 
 	return 0;
 }
diff --git a/include/linux/gpio/gpio-nomadik.h b/include/linux/gpio/gpio-nomadik.h
index 0166ddb71f43..8f7bb756ad35 100644
--- a/include/linux/gpio/gpio-nomadik.h
+++ b/include/linux/gpio/gpio-nomadik.h
@@ -56,6 +56,7 @@ struct nmk_gpio_chip {
 	unsigned int bank;
 	void (*set_ioforce)(bool enable);
 	spinlock_t lock;
+	raw_spinlock_t fake_lock;
 	bool sleepmode;
 	/* Keep track of configured edges */
 	u32 edge_rising;

-- 
2.43.1


