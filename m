Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB1F7BC257
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjJFWpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjJFWph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:45:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3F5A2;
        Fri,  6 Oct 2023 15:45:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0796DC433C7;
        Fri,  6 Oct 2023 22:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632335;
        bh=r0hgPd26vNJNNKdbRDndzXFBSLd85QxGGtazkx8k9RA=;
        h=From:To:Cc:Subject:Date:From;
        b=TkUiToD41EoSHzdGDHb1BVUYjz2DR57gQ89EBfGdiSV7XyLH003ZIKt983ICbgLtz
         t+JCHOx8JtpAZ4RXIbc40AgxuVm9wB5xNNe9pHE6uLlwaGiArTZiDXc/6SJPYP65GX
         sFz803xKiozrR8cnXyva4Gf9I8CEwgye0w+Bjuf5PfvkYSJmwn5uLERDLmkzrqILBW
         KiEJHJSVsyl0GD8SeMHoaq68xllDN2H57S/hf8APFZrlkAU4gW3jANmKpdbuySY4je
         v+0UDNjMSPWq6LOsMz6sB2gDoczswQ0wXPAzfhiGyO6UHjO8HzewgP9JDyLto/1VVC
         k5HX676k/3vIA==
Received: (nullmailer pid 443988 invoked by uid 1000);
        Fri, 06 Oct 2023 22:45:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH] gpio: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 17:45:07 -0500
Message-Id: <20231006224507.443486-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/gpio/gpio-davinci.c |  9 +++------
 drivers/gpio/gpio-mmio.c    |  4 ++--
 drivers/gpio/gpio-mvebu.c   | 10 +++-------
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 8db5717bdabe..bb499e362912 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -16,10 +16,10 @@
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/gpio-davinci.h>
+#include <linux/property.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/spinlock.h>
 #include <linux/pm_runtime.h>
@@ -486,7 +486,6 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 	struct davinci_gpio_platform_data *pdata = dev->platform_data;
 	struct davinci_gpio_regs __iomem *g;
 	struct irq_domain	*irq_domain = NULL;
-	const struct of_device_id *match;
 	struct irq_chip *irq_chip;
 	struct davinci_gpio_irq_data *irqdata;
 	gpio_get_irq_chip_cb_t gpio_get_irq_chip;
@@ -495,10 +494,8 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 	 * Use davinci_gpio_get_irq_chip by default to handle non DT cases
 	 */
 	gpio_get_irq_chip = davinci_gpio_get_irq_chip;
-	match = of_match_device(of_match_ptr(davinci_gpio_ids),
-				dev);
-	if (match)
-		gpio_get_irq_chip = (gpio_get_irq_chip_cb_t)match->data;
+	if (dev->of_node)
+		gpio_get_irq_chip = (gpio_get_irq_chip_cb_t)device_get_match_data(dev);
 
 	ngpio = pdata->ngpio;
 
diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index 74fdf0d87b2c..3ff0ea1e351c 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -56,9 +56,9 @@ o        `                     ~~~~\___/~~~~    ` controller in FPGA is ,.`
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #include "gpiolib.h"
 
@@ -702,7 +702,7 @@ static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
 {
 	struct bgpio_pdata *pdata;
 
-	if (!of_match_device(bgpio_of_match, &pdev->dev))
+	if (!pdev->dev.of_node)
 		return NULL;
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(struct bgpio_pdata),
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 67497116ce27..8f80ca8ec1ed 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -42,9 +42,10 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -1122,7 +1123,6 @@ static void mvebu_gpio_remove_irq_domain(void *data)
 static int mvebu_gpio_probe(struct platform_device *pdev)
 {
 	struct mvebu_gpio_chip *mvchip;
-	const struct of_device_id *match;
 	struct device_node *np = pdev->dev.of_node;
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
@@ -1132,11 +1132,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	int i, cpu, id;
 	int err;
 
-	match = of_match_device(mvebu_gpio_of_match, &pdev->dev);
-	if (match)
-		soc_variant = (unsigned long) match->data;
-	else
-		soc_variant = MVEBU_GPIO_SOC_VARIANT_ORION;
+	soc_variant = (unsigned long)device_get_match_data(&pdev->dev);
 
 	/* Some gpio controllers do not provide irq support */
 	err = platform_irq_count(pdev);
-- 
2.40.1

