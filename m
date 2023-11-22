Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC437F4114
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbjKVJDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343561AbjKVJB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:01:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A617D4A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:01:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA91FC2BCFE;
        Wed, 22 Nov 2023 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700643675;
        bh=caawVOpxHFy9cm3i7DwECM4693fhFarzsOiGy9doXoc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=nTMnvZUvLOSI80uLfO38WIt9NE+FMM2n6qRs1ZqrteJbO0tz8isZNhMi7A8EjfrTq
         xLCC/ynE5GXOyTtFLtyPfUpNyylaDtVRycsZMkk5ChgwHzV8rR7sE37YG2yYq5n2Uh
         2LPk3nCL2xa95R3KDDii/xt4B/INkgPKt06B3w0k0IDjg7GQXhGEroP07U5cT6hpir
         5N7WakkdcuX//1fKWc15oDSNzgirgvKwwtkYpwnAK5h1UnMba4pLUxSZK905kNcw0F
         jXxN95X1gjmPuiLqwxxrlInVYGCKqhifLGkdq85c40gmsVQG1bB02/hs260RB5ycQm
         VPmePlHGYeaZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id A9DDDC61D9C;
        Wed, 22 Nov 2023 09:01:15 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Wed, 22 Nov 2023 12:00:04 +0300
Subject: [PATCH v5 26/39] gpio: ep93xx: add DT support for gpio-ep93xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-ep93xx-v5-26-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
In-Reply-To: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700643671; l=4650;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=veUYE/VzU1y37Z5M8NkA7tAbUvE+Vs49lzqAWz+krrk=; =?utf-8?q?b=3D7ewF2uzlMvaM?=
 =?utf-8?q?tazjAjRWSoAMn+Kf99EwIP79J80g+TPm7Z1PIiui+U8vkWM+qn8FZFFxtgkvisSk?=
 HTWRpkAoDBoGE/v7Qa6fpbzxvqZim/feUkTs/PHAmGawGvFa6lCk
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

