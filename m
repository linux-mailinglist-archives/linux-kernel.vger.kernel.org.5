Return-Path: <linux-kernel+bounces-118660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970A688BDDA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB40F1C39BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD75412BEB4;
	Tue, 26 Mar 2024 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFINn4Da"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033156FBB7;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444843; cv=none; b=An8CkD2srOoUwdTYNrTByYUVovVZcXr8Q/7sqhVmSZC3iYkIF4U2PRSAWYphrpREMPI0qgI+MNO3kLZeCWxWvOhhjLT9dCZwiUb5hl9KHTjojYbLl/MIq0ab4e5G3s3TJVn4MpY8BgvTBDATfTqc6cQnCW9BoG3UCiAOe7xrv+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444843; c=relaxed/simple;
	bh=caawVOpxHFy9cm3i7DwECM4693fhFarzsOiGy9doXoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L1NM2/UnMfMdZrQZlVkcKyRg0vNigRBPZFTU8emL7tCU1weVWqildqRMKRHZHKnZeP/T0DZBjg0zLfAndiKCKnvO/3Nzwa29OQcw+BR8Kuve24UnwwdatX5gxWSMAwxMmE/zzJAXf96PVJR16FJBR4oPAaCWzYJlxMX53bic84Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFINn4Da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47ECEC3279F;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711444842;
	bh=caawVOpxHFy9cm3i7DwECM4693fhFarzsOiGy9doXoc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XFINn4DaLSM3JvDR3ivw9ybi6n2n0N1fOOqf0Dgy3KPRq6S+FtdxGocRtsMYvWq6P
	 IH9jXQ0XRpSofETqPrW6pC0ny79jPdf4A8/buO3rN2mqVCWGuOTohFNM/vSfrci6zd
	 /vt/EPAvISaVlErpXjCs8PNvtDa3nXvXwrw1Nj9DQ0LbRtbWzOhS2l16mzbofUKAsP
	 9gekGHZSkfrghvaOODDofavBmuUBq9LCAVIrg46vQif1UsAExepWkbYANkTfjd8A2k
	 x74zQQZZsItKVmIktUxPt1isu3I18xyffKk5fUNxJCEXmwM/ASenpd6M0INnIUER+r
	 FTaMOP0p93qIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4070DCD11DB;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Tue, 26 Mar 2024 12:18:52 +0300
Subject: [PATCH v9 25/38] gpio: ep93xx: add DT support for gpio-ep93xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-ep93xx-v9-25-156e2ae5dfc8@maquefel.me>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
In-Reply-To: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711444837; l=4650;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=veUYE/VzU1y37Z5M8NkA7tAbUvE+Vs49lzqAWz+krrk=;
 b=xHClAB+tIAg3s3CXvsedoXpLj6apxNnAcRbwg0SnuwzQBxhCVbDSr7P/9HRzBPWVePRdAjICa0Cj
 8NNde3beAhzjy3w6SABVm2R4fv4v3cEFVFPckKqDnEz7Yc3vwNlx
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add OF ID match table.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/gpio/gpio-ep93xx.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index a55f635585f4..ab798c848215 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -12,13 +12,13 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/gpio/driver.h>
 #include <linux/bitops.h>
 #include <linux/seq_file.h>
-#include <linux/interrupt.h>
 
 struct ep93xx_gpio_irq_chip {
 	void __iomem *base;
@@ -138,7 +138,8 @@ static void ep93xx_gpio_irq_mask_ack(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
-	int port_mask = BIT(irqd_to_hwirq(d));
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	int port_mask = BIT(hwirq);
 
 	if (irqd_get_trigger_type(d) == IRQ_TYPE_EDGE_BOTH)
 		eic->int_type2 ^= port_mask; /* switch edge direction */
@@ -147,26 +148,28 @@ static void ep93xx_gpio_irq_mask_ack(struct irq_data *d)
 	ep93xx_gpio_update_int_params(eic);
 
 	writeb(port_mask, eic->base + EP93XX_INT_EOI_OFFSET);
-	gpiochip_disable_irq(gc, irqd_to_hwirq(d));
+	gpiochip_disable_irq(gc, hwirq);
 }
 
 static void ep93xx_gpio_irq_mask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
-	eic->int_unmasked &= ~BIT(irqd_to_hwirq(d));
+	eic->int_unmasked &= ~BIT(hwirq);
 	ep93xx_gpio_update_int_params(eic);
-	gpiochip_disable_irq(gc, irqd_to_hwirq(d));
+	gpiochip_disable_irq(gc, hwirq);
 }
 
 static void ep93xx_gpio_irq_unmask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
-	gpiochip_enable_irq(gc, irqd_to_hwirq(d));
-	eic->int_unmasked |= BIT(irqd_to_hwirq(d));
+	gpiochip_enable_irq(gc, hwirq);
+	eic->int_unmasked |= BIT(hwirq);
 	ep93xx_gpio_update_int_params(eic);
 }
 
@@ -179,11 +182,11 @@ static int ep93xx_gpio_irq_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
-	irq_hw_number_t offset = irqd_to_hwirq(d);
-	int port_mask = BIT(offset);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	int port_mask = BIT(hwirq);
 	irq_flow_handler_t handler;
 
-	gc->direction_input(gc, offset);
+	gc->direction_input(gc, hwirq);
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -209,7 +212,7 @@ static int ep93xx_gpio_irq_type(struct irq_data *d, unsigned int type)
 	case IRQ_TYPE_EDGE_BOTH:
 		eic->int_type1 |= port_mask;
 		/* set initial polarity based on current input level */
-		if (gc->get(gc, offset))
+		if (gc->get(gc, hwirq))
 			eic->int_type2 &= ~port_mask; /* falling */
 		else
 			eic->int_type2 |= port_mask; /* rising */
@@ -285,9 +288,8 @@ static int ep93xx_setup_irqs(struct platform_device *pdev,
 	if (girq->num_parents == 0)
 		return -EINVAL;
 
-	girq->parents = devm_kcalloc(dev, girq->num_parents,
-				   sizeof(*girq->parents),
-				   GFP_KERNEL);
+	girq->parents = devm_kcalloc(dev, girq->num_parents, sizeof(*girq->parents),
+				     GFP_KERNEL);
 	if (!girq->parents)
 		return -ENOMEM;
 
@@ -306,7 +308,7 @@ static int ep93xx_setup_irqs(struct platform_device *pdev,
 		girq->parent_handler = ep93xx_gpio_f_irq_handler;
 
 		for (i = 0; i < girq->num_parents; i++) {
-			irq = platform_get_irq(pdev, i);
+			irq = platform_get_irq_optional(pdev, i);
 			if (irq < 0)
 				continue;
 
@@ -359,9 +361,15 @@ static int ep93xx_gpio_probe(struct platform_device *pdev)
 	return devm_gpiochip_add_data(&pdev->dev, gc, egc);
 }
 
+static const struct of_device_id ep93xx_gpio_match[] = {
+	{ .compatible = "cirrus,ep9301-gpio" },
+	{ /* sentinel */ }
+};
+
 static struct platform_driver ep93xx_gpio_driver = {
 	.driver		= {
 		.name	= "gpio-ep93xx",
+		.of_match_table = ep93xx_gpio_match,
 	},
 	.probe		= ep93xx_gpio_probe,
 };

-- 
2.41.0



