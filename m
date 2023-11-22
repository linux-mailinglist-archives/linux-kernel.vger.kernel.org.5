Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B56B7F40D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbjKVJB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjKVJBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:01:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDED191
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:01:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 650E6C433C7;
        Wed, 22 Nov 2023 09:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700643674;
        bh=Fpq23KvRDGia0ydq12t7YPCBxFq5/1IJdWRXN2CI1J0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=Eu9eyZJktSG54KUl5S5+OqVsMTLG4D2hBQmLphZBJ9P2QpRtlAmbDAvdJ2rykiuUr
         n474ElbvDWbOIWd0/FhhHGL7xbrHZ4C377+0a11F1ZvH24lo4lEnSAkQZOssSH0iLZ
         ojDIlaQV8fb0DgkQqUTsD6lz3o+KGkSB8OVjn6XLmnIu+T2O/mWS21X9xy4xpc6ZTk
         8va5Cfy4DoX1VylsH+RnAkRCP7/9hIhpWJmh03MJAaAsTE+dBBnaIPvbcUr7jnfNRb
         FkkHKHBgbE6RVJcyeO53PWENnVPefGnkl47tEEY77N+6cXr/WO+8kmQlnTvo2a24j/
         ariN9LixwU91A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 4398FC61D96;
        Wed, 22 Nov 2023 09:01:14 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Wed, 22 Nov 2023 11:59:39 +0300
Subject: [PATCH v5 01/39] gpio: ep93xx: split device in multiple
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-ep93xx-v5-1-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
In-Reply-To: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
To:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700643671; l=25387;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=xJnrfSTlai0RhyB9fAswf9JH+K5AcpVYo0l0O1nui2g=; =?utf-8?q?b=3D5wO65iwh/47E?=
 =?utf-8?q?wrzj4FfMrmF45l85OmGpt94zgNhBtQXM2JoPTWXwMvxSdTCsxOrzMUFvqKJaVJOp?=
 3N5BF5f5BYjeE65ttqvzRyFcsGsFYKa86epd64yRGV34/RD34mlj
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

Prepare ep93xx SOC gpio to convert into device tree driver:
- dropped banks and legacy defines
- split AB IRQ and make it shared

We are relying on IRQ number information A, B ports have single shared
IRQ, while F port have dedicated IRQ for each line.

Also we had to split single ep93xx platform_device into multiple, one
for each port, without this we can't do a full working transition from
legacy platform code into device tree capable. All GPIO_LOOKUP were
change to match new chip namings.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/mach-ep93xx/core.c          | 121 ++++++++++++--
 arch/arm/mach-ep93xx/edb93xx.c       |   2 +-
 arch/arm/mach-ep93xx/ts72xx.c        |   4 +-
 arch/arm/mach-ep93xx/vision_ep9307.c |  10 +-
 drivers/gpio/gpio-ep93xx.c           | 311 +++++++++++++----------------------
 5 files changed, 228 insertions(+), 220 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 71b113976420..c81a2e84821b 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -35,6 +35,7 @@
 #include <linux/reboot.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/random.h>
+#include <linux/ioport.h>
 
 #include "hardware.h"
 #include <linux/platform_data/video-ep93xx.h>
@@ -139,9 +140,80 @@ EXPORT_SYMBOL_GPL(ep93xx_chip_revision);
 /*************************************************************************
  * EP93xx GPIO
  *************************************************************************/
-static struct resource ep93xx_gpio_resource[] = {
-	DEFINE_RES_MEM(EP93XX_GPIO_PHYS_BASE, 0xcc),
+/* port A */
+static struct resource ep93xx_a_gpio_resources[] = {
+	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE,        0x04, "data"),
+	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE + 0x10, 0x04, "dir"),
+	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE + 0x90, 0x1c, "intr"),
 	DEFINE_RES_IRQ(IRQ_EP93XX_GPIO_AB),
+};
+
+static struct platform_device ep93xx_a_gpio = {
+	.name           = "gpio-ep93xx",
+	.id             = 0,
+	.num_resources = ARRAY_SIZE(ep93xx_a_gpio_resources),
+	.resource = ep93xx_a_gpio_resources,
+};
+
+/* port B */
+static struct resource ep93xx_b_gpio_resources[] = {
+	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE + 0x04, 0x04, "data"),
+	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE + 0x14, 0x04, "dir"),
+	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE + 0xac, 0x1c, "intr"),
+	DEFINE_RES_IRQ(IRQ_EP93XX_GPIO_AB),
+};
+
+static struct platform_device ep93xx_b_gpio = {
+	.name           = "gpio-ep93xx",
+	.id             = 1,
+	.num_resources = ARRAY_SIZE(ep93xx_b_gpio_resources),
+	.resource = ep93xx_b_gpio_resources,
+};
+
+/* port C */
+static struct resource ep93xx_c_gpio_resources[] = {
+	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE + 0x08, 0x04, "data"),
+	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE + 0x18, 0x04, "dir"),
+};
+
+static struct platform_device ep93xx_c_gpio = {
+	.name           = "gpio-ep93xx",
+	.id             = 2,
+	.num_resources = ARRAY_SIZE(ep93xx_c_gpio_resources),
+	.resource = ep93xx_c_gpio_resources,
+};
+
+/* port D */
+static struct resource ep93xx_d_gpio_resources[] = {
+	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE + 0x0c, 0x04, "data"),
+	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE + 0x1c, 0x04, "dir"),
+};
+
+static struct platform_device ep93xx_d_gpio = {
+	.name           = "gpio-ep93xx",
+	.id             = 3,
+	.num_resources = ARRAY_SIZE(ep93xx_d_gpio_resources),
+	.resource = ep93xx_d_gpio_resources,
+};
+
+/* port E */
+static struct resource ep93xx_e_gpio_resources[] = {
+	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE + 0x20, 0x04, "data"),
+	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE + 0x24, 0x04, "dir"),
+};
+
+static struct platform_device ep93xx_e_gpio = {
+	.name           = "gpio-ep93xx",
+	.id             = 4,
+	.num_resources = ARRAY_SIZE(ep93xx_e_gpio_resources),
+	.resource = ep93xx_e_gpio_resources,
+};
+
+/* port F */
+static struct resource ep93xx_f_gpio_resources[] = {
+	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE + 0x30, 0x04, "data"),
+	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE + 0x34, 0x04, "dir"),
+	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE + 0x4c, 0x1c, "intr"),
 	DEFINE_RES_IRQ(IRQ_EP93XX_GPIO0MUX),
 	DEFINE_RES_IRQ(IRQ_EP93XX_GPIO1MUX),
 	DEFINE_RES_IRQ(IRQ_EP93XX_GPIO2MUX),
@@ -152,11 +224,34 @@ static struct resource ep93xx_gpio_resource[] = {
 	DEFINE_RES_IRQ(IRQ_EP93XX_GPIO7MUX),
 };
 
-static struct platform_device ep93xx_gpio_device = {
-	.name		= "gpio-ep93xx",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(ep93xx_gpio_resource),
-	.resource	= ep93xx_gpio_resource,
+static struct platform_device ep93xx_f_gpio = {
+	.name           = "gpio-ep93xx",
+	.id             = 5,
+	.num_resources = ARRAY_SIZE(ep93xx_f_gpio_resources),
+	.resource = ep93xx_f_gpio_resources,
+};
+
+/* port G */
+static struct resource ep93xx_g_gpio_resources[] = {
+	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE + 0x38, 0x04, "data"),
+	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE + 0x3c, 0x04, "dir"),
+};
+
+static struct platform_device ep93xx_g_gpio = {
+	.name           = "gpio-ep93xx",
+	.id             = 6,
+	.num_resources = ARRAY_SIZE(ep93xx_g_gpio_resources),
+	.resource = ep93xx_g_gpio_resources,
+};
+
+static struct platform_device *ep93xx_gpio_device[] __initdata = {
+	&ep93xx_a_gpio,
+	&ep93xx_b_gpio,
+	&ep93xx_c_gpio,
+	&ep93xx_d_gpio,
+	&ep93xx_e_gpio,
+	&ep93xx_f_gpio,
+	&ep93xx_g_gpio,
 };
 
 /*************************************************************************
@@ -335,9 +430,9 @@ static struct gpiod_lookup_table ep93xx_i2c_gpiod_table = {
 	.dev_id		= "i2c-gpio.0",
 	.table		= {
 		/* Use local offsets on gpiochip/port "G" */
-		GPIO_LOOKUP_IDX("G", 1, NULL, 0,
+		GPIO_LOOKUP_IDX("gpio-ep93xx.6", 1, NULL, 0,
 				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
-		GPIO_LOOKUP_IDX("G", 0, NULL, 1,
+		GPIO_LOOKUP_IDX("gpio-ep93xx.6", 0, NULL, 1,
 				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
@@ -440,8 +535,8 @@ static struct gpiod_lookup_table ep93xx_leds_gpio_table = {
 	.dev_id = "leds-gpio",
 	.table = {
 		/* Use local offsets on gpiochip/port "E" */
-		GPIO_LOOKUP_IDX("E", 0, NULL, 0, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("E", 1,	NULL, 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-ep93xx.4", 0, NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-ep93xx.4", 1, NULL, 1, GPIO_ACTIVE_HIGH),
 		{ }
 	},
 };
@@ -974,6 +1069,7 @@ static struct device __init *ep93xx_init_soc(void)
 struct device __init *ep93xx_init_devices(void)
 {
 	struct device *parent;
+	unsigned int i;
 
 	/* Disallow access to MaverickCrunch initially */
 	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_CPENA);
@@ -988,7 +1084,8 @@ struct device __init *ep93xx_init_devices(void)
 	parent = ep93xx_init_soc();
 
 	/* Get the GPIO working early, other devices need it */
-	platform_device_register(&ep93xx_gpio_device);
+	for (i = 0; i < ARRAY_SIZE(ep93xx_gpio_device); i++)
+		platform_device_register(ep93xx_gpio_device[i]);
 
 	amba_device_register(&uart1_device, &iomem_resource);
 	amba_device_register(&uart2_device, &iomem_resource);
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 4b90899a66e9..c1e880946f72 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -105,7 +105,7 @@ static struct spi_board_info edb93xx_spi_board_info[] __initdata = {
 static struct gpiod_lookup_table edb93xx_spi_cs_gpio_table = {
 	.dev_id = "spi0",
 	.table = {
-		GPIO_LOOKUP("A", 6, "cs", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("gpio-ep93xx.0", 6, "cs", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index d3de7283ecb3..0bbdf587c685 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -268,7 +268,7 @@ static struct spi_board_info bk3_spi_board_info[] __initdata = {
 static struct gpiod_lookup_table bk3_spi_cs_gpio_table = {
 	.dev_id = "spi0",
 	.table = {
-		GPIO_LOOKUP("F", 3, "cs", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("gpio-ep93xx.5", 3, "cs", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
@@ -318,7 +318,7 @@ static struct gpiod_lookup_table ts72xx_spi_cs_gpio_table = {
 	.dev_id = "spi0",
 	.table = {
 		/* DIO_17 */
-		GPIO_LOOKUP("F", 2, "cs", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("gpio-ep93xx.5", 2, "cs", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index 30d9cf3791eb..020223b0be2b 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -206,9 +206,9 @@ static struct gpiod_lookup_table vision_spi_mmc_gpio_table = {
 	.dev_id = "mmc_spi.2", /* "mmc_spi @ CS2 */
 	.table = {
 		/* Card detect */
-		GPIO_LOOKUP_IDX("B", 7, NULL, 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-ep93xx.1", 7, NULL, 0, GPIO_ACTIVE_LOW),
 		/* Write protect */
-		GPIO_LOOKUP_IDX("F", 0, NULL, 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-ep93xx.5", 0, NULL, 1, GPIO_ACTIVE_HIGH),
 		{ },
 	},
 };
@@ -244,9 +244,9 @@ static struct spi_board_info vision_spi_board_info[] __initdata = {
 static struct gpiod_lookup_table vision_spi_cs_gpio_table = {
 	.dev_id = "spi0",
 	.table = {
-		GPIO_LOOKUP_IDX("A", 6, "cs", 0, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("A", 7, "cs", 1, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("G", 2, "cs", 2, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-ep93xx.0", 6, "cs", 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-ep93xx.0", 7, "cs", 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-ep93xx.6", 2, "cs", 2, GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 6cedf46efec6..a55f635585f4 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -18,30 +18,10 @@
 #include <linux/gpio/driver.h>
 #include <linux/bitops.h>
 #include <linux/seq_file.h>
-
-#define EP93XX_GPIO_F_INT_STATUS 0x5c
-#define EP93XX_GPIO_A_INT_STATUS 0xa0
-#define EP93XX_GPIO_B_INT_STATUS 0xbc
-
-/* Maximum value for gpio line identifiers */
-#define EP93XX_GPIO_LINE_MAX 63
-
-/* Number of GPIO chips in EP93XX */
-#define EP93XX_GPIO_CHIP_NUM 8
-
-/* Maximum value for irq capable line identifiers */
-#define EP93XX_GPIO_LINE_MAX_IRQ 23
-
-#define EP93XX_GPIO_A_IRQ_BASE 64
-#define EP93XX_GPIO_B_IRQ_BASE 72
-/*
- * Static mapping of GPIO bank F IRQS:
- * F0..F7 (16..24) to irq 80..87.
- */
-#define EP93XX_GPIO_F_IRQ_BASE 80
+#include <linux/interrupt.h>
 
 struct ep93xx_gpio_irq_chip {
-	u8 irq_offset;
+	void __iomem *base;
 	u8 int_unmasked;
 	u8 int_enabled;
 	u8 int_type1;
@@ -50,15 +30,11 @@ struct ep93xx_gpio_irq_chip {
 };
 
 struct ep93xx_gpio_chip {
+	void __iomem			*base;
 	struct gpio_chip		gc;
 	struct ep93xx_gpio_irq_chip	*eic;
 };
 
-struct ep93xx_gpio {
-	void __iomem		*base;
-	struct ep93xx_gpio_chip	gc[EP93XX_GPIO_CHIP_NUM];
-};
-
 #define to_ep93xx_gpio_chip(x) container_of(x, struct ep93xx_gpio_chip, gc)
 
 static struct ep93xx_gpio_irq_chip *to_ep93xx_gpio_irq_chip(struct gpio_chip *gc)
@@ -79,25 +55,23 @@ static struct ep93xx_gpio_irq_chip *to_ep93xx_gpio_irq_chip(struct gpio_chip *gc
 #define EP93XX_INT_RAW_STATUS_OFFSET	0x14
 #define EP93XX_INT_DEBOUNCE_OFFSET	0x18
 
-static void ep93xx_gpio_update_int_params(struct ep93xx_gpio *epg,
-					  struct ep93xx_gpio_irq_chip *eic)
+static void ep93xx_gpio_update_int_params(struct ep93xx_gpio_irq_chip *eic)
 {
-	writeb_relaxed(0, epg->base + eic->irq_offset + EP93XX_INT_EN_OFFSET);
+	writeb_relaxed(0, eic->base + EP93XX_INT_EN_OFFSET);
 
 	writeb_relaxed(eic->int_type2,
-		       epg->base + eic->irq_offset + EP93XX_INT_TYPE2_OFFSET);
+		       eic->base + EP93XX_INT_TYPE2_OFFSET);
 
 	writeb_relaxed(eic->int_type1,
-		       epg->base + eic->irq_offset + EP93XX_INT_TYPE1_OFFSET);
+		       eic->base + EP93XX_INT_TYPE1_OFFSET);
 
 	writeb_relaxed(eic->int_unmasked & eic->int_enabled,
-		       epg->base + eic->irq_offset + EP93XX_INT_EN_OFFSET);
+		       eic->base + EP93XX_INT_EN_OFFSET);
 }
 
 static void ep93xx_gpio_int_debounce(struct gpio_chip *gc,
 				     unsigned int offset, bool enable)
 {
-	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
 	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
 	int port_mask = BIT(offset);
 
@@ -106,53 +80,43 @@ static void ep93xx_gpio_int_debounce(struct gpio_chip *gc,
 	else
 		eic->int_debounce &= ~port_mask;
 
-	writeb(eic->int_debounce,
-	       epg->base + eic->irq_offset + EP93XX_INT_DEBOUNCE_OFFSET);
+	writeb(eic->int_debounce, eic->base + EP93XX_INT_DEBOUNCE_OFFSET);
 }
 
-static void ep93xx_gpio_ab_irq_handler(struct irq_desc *desc)
+static u32 ep93xx_gpio_ab_irq_handler(struct gpio_chip *gc)
 {
-	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
-	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
-	struct irq_chip *irqchip = irq_desc_get_chip(desc);
+	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
 	unsigned long stat;
 	int offset;
 
-	chained_irq_enter(irqchip, desc);
-
-	/*
-	 * Dispatch the IRQs to the irqdomain of each A and B
-	 * gpiochip irqdomains depending on what has fired.
-	 * The tricky part is that the IRQ line is shared
-	 * between bank A and B and each has their own gpiochip.
-	 */
-	stat = readb(epg->base + EP93XX_GPIO_A_INT_STATUS);
+	stat = readb(eic->base + EP93XX_INT_STATUS_OFFSET);
 	for_each_set_bit(offset, &stat, 8)
-		generic_handle_domain_irq(epg->gc[0].gc.irq.domain,
-					  offset);
+		generic_handle_domain_irq(gc->irq.domain, offset);
 
-	stat = readb(epg->base + EP93XX_GPIO_B_INT_STATUS);
-	for_each_set_bit(offset, &stat, 8)
-		generic_handle_domain_irq(epg->gc[1].gc.irq.domain,
-					  offset);
+	return stat;
+}
 
-	chained_irq_exit(irqchip, desc);
+static irqreturn_t ep93xx_ab_irq_handler(int irq, void *dev_id)
+{
+	return IRQ_RETVAL(ep93xx_gpio_ab_irq_handler(dev_id));
 }
 
 static void ep93xx_gpio_f_irq_handler(struct irq_desc *desc)
 {
-	/*
-	 * map discontiguous hw irq range to continuous sw irq range:
-	 *
-	 *  IRQ_EP93XX_GPIO{0..7}MUX -> EP93XX_GPIO_LINE_F{0..7}
-	 */
 	struct irq_chip *irqchip = irq_desc_get_chip(desc);
-	unsigned int irq = irq_desc_get_irq(desc);
-	int port_f_idx = (irq & 7) ^ 4; /* {20..23,48..51} -> {0..7} */
-	int gpio_irq = EP93XX_GPIO_F_IRQ_BASE + port_f_idx;
+	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
+	struct gpio_irq_chip *gic = &gc->irq;
+	unsigned int parent = irq_desc_get_irq(desc);
+	unsigned int i;
 
 	chained_irq_enter(irqchip, desc);
-	generic_handle_irq(gpio_irq);
+	for (i = 0; i < gic->num_parents; i++)
+		if (gic->parents[i] == parent)
+			break;
+
+	if (i < gic->num_parents)
+		generic_handle_domain_irq(gc->irq.domain, i);
+
 	chained_irq_exit(irqchip, desc);
 }
 
@@ -160,31 +124,29 @@ static void ep93xx_gpio_irq_ack(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
-	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
-	int port_mask = BIT(d->irq & 7);
+	int port_mask = BIT(irqd_to_hwirq(d));
 
 	if (irqd_get_trigger_type(d) == IRQ_TYPE_EDGE_BOTH) {
 		eic->int_type2 ^= port_mask; /* switch edge direction */
-		ep93xx_gpio_update_int_params(epg, eic);
+		ep93xx_gpio_update_int_params(eic);
 	}
 
-	writeb(port_mask, epg->base + eic->irq_offset + EP93XX_INT_EOI_OFFSET);
+	writeb(port_mask, eic->base + EP93XX_INT_EOI_OFFSET);
 }
 
 static void ep93xx_gpio_irq_mask_ack(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
-	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
-	int port_mask = BIT(d->irq & 7);
+	int port_mask = BIT(irqd_to_hwirq(d));
 
 	if (irqd_get_trigger_type(d) == IRQ_TYPE_EDGE_BOTH)
 		eic->int_type2 ^= port_mask; /* switch edge direction */
 
 	eic->int_unmasked &= ~port_mask;
-	ep93xx_gpio_update_int_params(epg, eic);
+	ep93xx_gpio_update_int_params(eic);
 
-	writeb(port_mask, epg->base + eic->irq_offset + EP93XX_INT_EOI_OFFSET);
+	writeb(port_mask, eic->base + EP93XX_INT_EOI_OFFSET);
 	gpiochip_disable_irq(gc, irqd_to_hwirq(d));
 }
 
@@ -192,10 +154,9 @@ static void ep93xx_gpio_irq_mask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
-	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
 
-	eic->int_unmasked &= ~BIT(d->irq & 7);
-	ep93xx_gpio_update_int_params(epg, eic);
+	eic->int_unmasked &= ~BIT(irqd_to_hwirq(d));
+	ep93xx_gpio_update_int_params(eic);
 	gpiochip_disable_irq(gc, irqd_to_hwirq(d));
 }
 
@@ -203,11 +164,10 @@ static void ep93xx_gpio_irq_unmask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
-	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
 
 	gpiochip_enable_irq(gc, irqd_to_hwirq(d));
-	eic->int_unmasked |= BIT(d->irq & 7);
-	ep93xx_gpio_update_int_params(epg, eic);
+	eic->int_unmasked |= BIT(irqd_to_hwirq(d));
+	ep93xx_gpio_update_int_params(eic);
 }
 
 /*
@@ -219,8 +179,7 @@ static int ep93xx_gpio_irq_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
-	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
-	int offset = d->irq & 7;
+	irq_hw_number_t offset = irqd_to_hwirq(d);
 	int port_mask = BIT(offset);
 	irq_flow_handler_t handler;
 
@@ -264,51 +223,11 @@ static int ep93xx_gpio_irq_type(struct irq_data *d, unsigned int type)
 
 	eic->int_enabled |= port_mask;
 
-	ep93xx_gpio_update_int_params(epg, eic);
+	ep93xx_gpio_update_int_params(eic);
 
 	return 0;
 }
 
-/*************************************************************************
- * gpiolib interface for EP93xx on-chip GPIOs
- *************************************************************************/
-struct ep93xx_gpio_bank {
-	const char	*label;
-	int		data;
-	int		dir;
-	int		irq;
-	int		base;
-	bool		has_irq;
-	bool		has_hierarchical_irq;
-	unsigned int	irq_base;
-};
-
-#define EP93XX_GPIO_BANK(_label, _data, _dir, _irq, _base, _has_irq, _has_hier, _irq_base) \
-	{							\
-		.label		= _label,			\
-		.data		= _data,			\
-		.dir		= _dir,				\
-		.irq		= _irq,				\
-		.base		= _base,			\
-		.has_irq	= _has_irq,			\
-		.has_hierarchical_irq = _has_hier,		\
-		.irq_base	= _irq_base,			\
-	}
-
-static struct ep93xx_gpio_bank ep93xx_gpio_banks[] = {
-	/* Bank A has 8 IRQs */
-	EP93XX_GPIO_BANK("A", 0x00, 0x10, 0x90, 0, true, false, EP93XX_GPIO_A_IRQ_BASE),
-	/* Bank B has 8 IRQs */
-	EP93XX_GPIO_BANK("B", 0x04, 0x14, 0xac, 8, true, false, EP93XX_GPIO_B_IRQ_BASE),
-	EP93XX_GPIO_BANK("C", 0x08, 0x18, 0x00, 40, false, false, 0),
-	EP93XX_GPIO_BANK("D", 0x0c, 0x1c, 0x00, 24, false, false, 0),
-	EP93XX_GPIO_BANK("E", 0x20, 0x24, 0x00, 32, false, false, 0),
-	/* Bank F has 8 IRQs */
-	EP93XX_GPIO_BANK("F", 0x30, 0x34, 0x4c, 16, false, true, EP93XX_GPIO_F_IRQ_BASE),
-	EP93XX_GPIO_BANK("G", 0x38, 0x3c, 0x00, 48, false, false, 0),
-	EP93XX_GPIO_BANK("H", 0x40, 0x44, 0x00, 56, false, false, 0),
-};
-
 static int ep93xx_gpio_set_config(struct gpio_chip *gc, unsigned offset,
 				  unsigned long config)
 {
@@ -342,110 +261,102 @@ static const struct irq_chip gpio_eic_irq_chip = {
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
-static int ep93xx_gpio_add_bank(struct ep93xx_gpio_chip *egc,
-				struct platform_device *pdev,
-				struct ep93xx_gpio *epg,
-				struct ep93xx_gpio_bank *bank)
+static int ep93xx_setup_irqs(struct platform_device *pdev,
+			     struct ep93xx_gpio_chip *egc)
 {
-	void __iomem *data = epg->base + bank->data;
-	void __iomem *dir = epg->base + bank->dir;
 	struct gpio_chip *gc = &egc->gc;
 	struct device *dev = &pdev->dev;
-	struct gpio_irq_chip *girq;
-	int err;
+	struct gpio_irq_chip *girq = &gc->irq;
+	int ret, irq, i;
+	void __iomem *intr;
 
-	err = bgpio_init(gc, dev, 1, data, NULL, NULL, dir, NULL, 0);
-	if (err)
-		return err;
+	intr = devm_platform_ioremap_resource_byname(pdev, "intr");
+	if (IS_ERR(intr))
+		return PTR_ERR(intr);
 
-	gc->label = bank->label;
-	gc->base = bank->base;
+	gc->set_config = ep93xx_gpio_set_config;
+	egc->eic = devm_kzalloc(dev, sizeof(*egc->eic), GFP_KERNEL);
+	if (!egc->eic)
+		return -ENOMEM;
 
-	girq = &gc->irq;
-	if (bank->has_irq || bank->has_hierarchical_irq) {
-		gc->set_config = ep93xx_gpio_set_config;
-		egc->eic = devm_kcalloc(dev, 1,
-					sizeof(*egc->eic),
-					GFP_KERNEL);
-		if (!egc->eic)
-			return -ENOMEM;
-		egc->eic->irq_offset = bank->irq;
-		gpio_irq_chip_set_chip(girq, &gpio_eic_irq_chip);
-	}
+	egc->eic->base = intr;
+	gpio_irq_chip_set_chip(girq, &gpio_eic_irq_chip);
+	girq->num_parents = platform_irq_count(pdev);
+	if (girq->num_parents == 0)
+		return -EINVAL;
 
-	if (bank->has_irq) {
-		int ab_parent_irq = platform_get_irq(pdev, 0);
+	girq->parents = devm_kcalloc(dev, girq->num_parents,
+				   sizeof(*girq->parents),
+				   GFP_KERNEL);
+	if (!girq->parents)
+		return -ENOMEM;
 
-		girq->parent_handler = ep93xx_gpio_ab_irq_handler;
-		girq->num_parents = 1;
-		girq->parents = devm_kcalloc(dev, girq->num_parents,
-					     sizeof(*girq->parents),
-					     GFP_KERNEL);
-		if (!girq->parents)
-			return -ENOMEM;
-		girq->default_type = IRQ_TYPE_NONE;
-		girq->handler = handle_level_irq;
-		girq->parents[0] = ab_parent_irq;
-		girq->first = bank->irq_base;
-	}
+	if (girq->num_parents == 1) { /* A/B irqchips */
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0)
+			return irq;
 
-	/* Only bank F has especially funky IRQ handling */
-	if (bank->has_hierarchical_irq) {
-		int gpio_irq;
-		int i;
+		ret = devm_request_irq(dev, irq, ep93xx_ab_irq_handler,
+				       IRQF_SHARED, gc->label, gc);
+		if (ret)
+			return dev_err_probe(dev, ret, "requesting IRQ: %d\n", irq);
 
-		/*
-		 * FIXME: convert this to use hierarchical IRQ support!
-		 * this requires fixing the root irqchip to be hierarchical.
-		 */
+		girq->parents[0] = irq;
+	} else { /* F irqchip */
 		girq->parent_handler = ep93xx_gpio_f_irq_handler;
-		girq->num_parents = 8;
-		girq->parents = devm_kcalloc(dev, girq->num_parents,
-					     sizeof(*girq->parents),
-					     GFP_KERNEL);
-		if (!girq->parents)
-			return -ENOMEM;
-		/* Pick resources 1..8 for these IRQs */
+
 		for (i = 0; i < girq->num_parents; i++) {
-			girq->parents[i] = platform_get_irq(pdev, i + 1);
-			gpio_irq = bank->irq_base + i;
-			irq_set_chip_data(gpio_irq, &epg->gc[5]);
-			irq_set_chip_and_handler(gpio_irq,
-						 girq->chip,
-						 handle_level_irq);
-			irq_clear_status_flags(gpio_irq, IRQ_NOREQUEST);
+			irq = platform_get_irq(pdev, i);
+			if (irq < 0)
+				continue;
+
+			girq->parents[i] = irq;
 		}
-		girq->default_type = IRQ_TYPE_NONE;
-		girq->handler = handle_level_irq;
-		girq->first = bank->irq_base;
+
+		girq->map = girq->parents;
 	}
 
-	return devm_gpiochip_add_data(dev, gc, epg);
+	girq->default_type = IRQ_TYPE_NONE;
+	/* TODO: replace with handle_bad_irq() once we are fully hierarchical */
+	girq->handler = handle_simple_irq;
+
+	return 0;
 }
 
 static int ep93xx_gpio_probe(struct platform_device *pdev)
 {
-	struct ep93xx_gpio *epg;
-	int i;
+	struct ep93xx_gpio_chip *egc;
+	struct gpio_chip *gc;
+	void __iomem *data;
+	void __iomem *dir;
+	int ret;
 
-	epg = devm_kzalloc(&pdev->dev, sizeof(*epg), GFP_KERNEL);
-	if (!epg)
+	egc = devm_kzalloc(&pdev->dev, sizeof(*egc), GFP_KERNEL);
+	if (!egc)
 		return -ENOMEM;
 
-	epg->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(epg->base))
-		return PTR_ERR(epg->base);
+	data = devm_platform_ioremap_resource_byname(pdev, "data");
+	if (IS_ERR(data))
+		return PTR_ERR(data);
 
-	for (i = 0; i < ARRAY_SIZE(ep93xx_gpio_banks); i++) {
-		struct ep93xx_gpio_chip *gc = &epg->gc[i];
-		struct ep93xx_gpio_bank *bank = &ep93xx_gpio_banks[i];
+	dir = devm_platform_ioremap_resource_byname(pdev, "dir");
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
 
-		if (ep93xx_gpio_add_bank(gc, pdev, epg, bank))
-			dev_warn(&pdev->dev, "Unable to add gpio bank %s\n",
-				 bank->label);
+	gc = &egc->gc;
+	ret = bgpio_init(gc, &pdev->dev, 1, data, NULL, NULL, dir, NULL, 0);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "unable to init generic GPIO\n");
+
+	gc->label = dev_name(&pdev->dev);
+	if (platform_irq_count(pdev) > 0) {
+		dev_dbg(&pdev->dev, "setting up irqs for %s\n", dev_name(&pdev->dev));
+		ret = ep93xx_setup_irqs(pdev, egc);
+		if (ret)
+			dev_err_probe(&pdev->dev, ret, "setup irqs failed");
 	}
 
-	return 0;
+	return devm_gpiochip_add_data(&pdev->dev, gc, egc);
 }
 
 static struct platform_driver ep93xx_gpio_driver = {

-- 
2.41.0

