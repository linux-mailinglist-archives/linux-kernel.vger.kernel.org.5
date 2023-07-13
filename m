Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCB1752B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjGMUVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGMUU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:20:58 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB02F2120;
        Thu, 13 Jul 2023 13:20:56 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DKKm6F040716;
        Thu, 13 Jul 2023 15:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689279648;
        bh=jiyf7SMZhRp6ELomw3YRQevQiYE+P8LZ/as5/ZPw2Ic=;
        h=From:To:CC:Subject:Date;
        b=lF1xf5dEIP08lvZ17ag3cXXXer5s9SaEzAKC5E0+xaQ9nQXA6p82J1XIjvDXkaQT9
         oK+k6r6y4fcG5ScNypJHNUXSmEjDIQbR/f2XjCcu1fI4k5afxAiVtyslc7HO72hL99
         Fl9KwyaGcmjnHG3GbqMrSgXLGo0/qVJvcxVsOOuo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DKKmmp030526
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 15:20:48 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 15:20:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 15:20:48 -0500
Received: from fllv0040.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DKKlqY020094;
        Thu, 13 Jul 2023 15:20:48 -0500
From:   Andrew Davis <afd@ti.com>
To:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v4] gpio: pisosr: Use devm_gpiochip_add_data() to simplify remove path
Date:   Thu, 13 Jul 2023 15:20:46 -0500
Message-ID: <20230713202046.150986-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm version of gpiochip add function to handle removal for us.

While here update copyright and module author.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes from v3:
 - Do not cast void * lock explicitly
 - Rebase on v6.5-rc1

Changes from v2:
 - Rebase on v6.4-rc2

Changes from v1:
 - Use devm to cleanup mutex

 drivers/gpio/gpio-pisosr.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-pisosr.c b/drivers/gpio/gpio-pisosr.c
index 67071bea08c26..e3013e778e151 100644
--- a/drivers/gpio/gpio-pisosr.c
+++ b/drivers/gpio/gpio-pisosr.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
- *	Andrew F. Davis <afd@ti.com>
+ * Copyright (C) 2015-2023 Texas Instruments Incorporated - https://www.ti.com/
+ *	Andrew Davis <afd@ti.com>
  */
 
 #include <linux/bitmap.h>
@@ -116,6 +116,11 @@ static const struct gpio_chip template_chip = {
 	.can_sleep		= true,
 };
 
+static void pisosr_mutex_destroy(void *lock)
+{
+	mutex_destroy(lock);
+}
+
 static int pisosr_gpio_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -126,8 +131,6 @@ static int pisosr_gpio_probe(struct spi_device *spi)
 	if (!gpio)
 		return -ENOMEM;
 
-	spi_set_drvdata(spi, gpio);
-
 	gpio->chip = template_chip;
 	gpio->chip.parent = dev;
 	of_property_read_u16(dev->of_node, "ngpios", &gpio->chip.ngpio);
@@ -145,8 +148,11 @@ static int pisosr_gpio_probe(struct spi_device *spi)
 				     "Unable to allocate load GPIO\n");
 
 	mutex_init(&gpio->lock);
+	ret = devm_add_action_or_reset(dev, pisosr_mutex_destroy, &gpio->lock);
+	if (ret)
+		return ret;
 
-	ret = gpiochip_add_data(&gpio->chip, gpio);
+	ret = devm_gpiochip_add_data(dev, &gpio->chip, gpio);
 	if (ret < 0) {
 		dev_err(dev, "Unable to register gpiochip\n");
 		return ret;
@@ -155,15 +161,6 @@ static int pisosr_gpio_probe(struct spi_device *spi)
 	return 0;
 }
 
-static void pisosr_gpio_remove(struct spi_device *spi)
-{
-	struct pisosr_gpio *gpio = spi_get_drvdata(spi);
-
-	gpiochip_remove(&gpio->chip);
-
-	mutex_destroy(&gpio->lock);
-}
-
 static const struct spi_device_id pisosr_gpio_id_table[] = {
 	{ "pisosr-gpio", },
 	{ /* sentinel */ }
@@ -182,11 +179,10 @@ static struct spi_driver pisosr_gpio_driver = {
 		.of_match_table = pisosr_gpio_of_match_table,
 	},
 	.probe = pisosr_gpio_probe,
-	.remove = pisosr_gpio_remove,
 	.id_table = pisosr_gpio_id_table,
 };
 module_spi_driver(pisosr_gpio_driver);
 
-MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
+MODULE_AUTHOR("Andrew Davis <afd@ti.com>");
 MODULE_DESCRIPTION("SPI Compatible PISO Shift Register GPIO Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.39.2

