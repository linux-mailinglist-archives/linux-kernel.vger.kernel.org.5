Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F8478F395
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347250AbjHaTt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjHaTt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:49:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAAFE5B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:49:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fef56f7223so11607425e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693511392; x=1694116192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XC4h7QPz634lMnRrF4WW/WFuYrL3CG+anMN89egIVWI=;
        b=sHo/wNgAExZ/NEjtefyQFztxBSZ1Q7HFIU2BuxxAXJZrhAhLBfTWFHZieYmI4G/Sqx
         WDzgRPJLxRCQEiaMgMaZ/lHt5y5sbo7LEalfvLVDHudK4niBsfQU/IgiVMrZViKGawTe
         tamxWydfv3MOP2GtdNMkzNealGIU6xkfjysuF3LBmp+GPSe632CJesOxShoP6f0BY0Mg
         rvQBbOYTggthw7ylOd9n9hyDQWVtIypR179Bj+G9ta7By5sPsFuHyO7IUHZE2gJxFl76
         2JHlYM34QNA7JuXZ6R+LYbd5idsPdbwQop8ET9N5/OdBBGw2UOAupLwYqLGVfPMsVhRl
         rtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693511392; x=1694116192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XC4h7QPz634lMnRrF4WW/WFuYrL3CG+anMN89egIVWI=;
        b=hAMn+5QVQv5YdxlDcCJOzctC0+ILtAt3WDQqx6ZAncguHMhgdKnmkxS/fBwCE3S97M
         gWVoCGGE9qBQEeHImVvsQG9eeu48qQJBrDNx4en06HAn452lAXcG8ZKwUFeuPAPMruJ4
         hIWXG6i0PK2ss7jApf93R+ikEDIcJR1aXJ+ZngeSSwO2NMujn5CHmiKog0NF/sov1yFL
         W4ROA5wz8pRx6ZKsoJ32V0w3tVrIKydBVPW5jwoCKsJLmoUITxakNcwG+TxTu6ZvI50h
         Cs0Lmjz+IosDaguZmOoVzVM1t8M0eF6+mocMWiUxPdt1/T+XYep9iXGb5gvNn3z+EeFK
         KWVQ==
X-Gm-Message-State: AOJu0YzAe4R25mvG5FMb9fdtQ0VnT63Blumje+CgLXBV8r2o3CGcQ10s
        18Hmq9HL1uTJ5nBEjfLkoSoS2Q==
X-Google-Smtp-Source: AGHT+IH0hYYVjHkuWRlFzUZ48R1rnlngflqv6+UTjWWB2+DGqaB9XWDjqOhrDuRXhqJ+BoNANV4Rpw==
X-Received: by 2002:a05:600c:b52:b0:401:b3a5:ebf8 with SMTP id k18-20020a05600c0b5200b00401b3a5ebf8mr233462wmr.16.1693511391723;
        Thu, 31 Aug 2023 12:49:51 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a203:c11c:d490:8489])
        by smtp.gmail.com with ESMTPSA id k33-20020a05600c1ca100b0040210a27e29sm2893779wms.32.2023.08.31.12.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 12:49:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFT PATCH] spi: bcm2835: reduce the abuse of the GPIO API
Date:   Thu, 31 Aug 2023 21:49:34 +0200
Message-Id: <20230831194934.19628-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Currently the bcm2835 SPI driver uses functions meant for GPIO providers
exclusively to locate the GPIO chip it gets its CS pins from and request
the relevant pin. I don't know the background and what bug forced this.
I can however propose a slightly better solution that allows the driver
to request the GPIO correctly using a temporary lookup table.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
This is only build-tested. It should work, but it would be great if
someone from broadcom could test this.

 drivers/spi/spi-bcm2835.c | 54 ++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index e7bb2714678a..3c422f0e1087 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -11,6 +11,7 @@
  * spi-atmel.c, Copyright (C) 2006 Atmel Corporation
  */
 
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/debugfs.h>
@@ -26,9 +27,10 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
-#include <linux/gpio/machine.h> /* FIXME: using chip internals */
-#include <linux/gpio/driver.h> /* FIXME: using chip internals */
+#include <linux/gpio/machine.h> /* FIXME: using GPIO lookup tables */
 #include <linux/of_irq.h>
+#include <linux/overflow.h>
+#include <linux/slab.h>
 #include <linux/spi/spi.h>
 
 /* SPI register offsets */
@@ -117,6 +119,7 @@ MODULE_PARM_DESC(polling_limit_us,
 struct bcm2835_spi {
 	void __iomem *regs;
 	struct clk *clk;
+	struct gpio_desc *cs_gpio;
 	unsigned long clk_hz;
 	int irq;
 	struct spi_transfer *tfr;
@@ -1156,11 +1159,6 @@ static void bcm2835_spi_handle_err(struct spi_controller *ctlr,
 	bcm2835_spi_reset_hw(bs);
 }
 
-static int chip_match_name(struct gpio_chip *chip, void *data)
-{
-	return !strcmp(chip->label, data);
-}
-
 static void bcm2835_spi_cleanup(struct spi_device *spi)
 {
 	struct bcm2835_spidev *target = spi_get_ctldata(spi);
@@ -1221,7 +1219,7 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	struct spi_controller *ctlr = spi->controller;
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	struct bcm2835_spidev *target = spi_get_ctldata(spi);
-	struct gpio_chip *chip;
+	struct gpiod_lookup_table *lookup __free(kfree) = NULL;
 	int ret;
 	u32 cs;
 
@@ -1288,29 +1286,37 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	}
 
 	/*
-	 * Translate native CS to GPIO
+	 * TODO: The code below is a slightly better alternative to the utter
+	 * abuse of the GPIO API that I found here before. It creates a
+	 * temporary lookup table, assigns it to the SPI device, gets the GPIO
+	 * descriptor and then releases the lookup table.
 	 *
-	 * FIXME: poking around in the gpiolib internals like this is
-	 * not very good practice. Find a way to locate the real problem
-	 * and fix it. Why is the GPIO descriptor in spi->cs_gpiod
-	 * sometimes not assigned correctly? Erroneous device trees?
+	 * Still the real problem is unsolved. Looks like the cs_gpiods table
+	 * is not assigned correctly from DT?
 	 */
+	lookup = kzalloc(struct_size(lookup, table, 1), GFP_KERNEL);
+	if (!lookup) {
+		ret = -ENOMEM;
+		goto err_cleanup;
+	}
 
-	/* get the gpio chip for the base */
-	chip = gpiochip_find("pinctrl-bcm2835", chip_match_name);
-	if (!chip)
-		return 0;
+	lookup->dev_id = dev_name(&spi->dev);
+	lookup->table[0].key = "pinctrl-bcm2835";
+	lookup->table[0].chip_hwnum = (8 - (spi_get_chipselect(spi, 0)));
+	lookup->table[0].con_id = "cs";
+	lookup->table[0].flags = GPIO_LOOKUP_FLAGS_DEFAULT;
 
-	spi_set_csgpiod(spi, 0, gpiochip_request_own_desc(chip,
-							  8 - (spi_get_chipselect(spi, 0)),
-							  DRV_NAME,
-							  GPIO_LOOKUP_FLAGS_DEFAULT,
-							  GPIOD_OUT_LOW));
-	if (IS_ERR(spi_get_csgpiod(spi, 0))) {
-		ret = PTR_ERR(spi_get_csgpiod(spi, 0));
+	gpiod_add_lookup_table(lookup);
+
+	bs->cs_gpio = devm_gpiod_get(&spi->dev, "cs", GPIOD_OUT_LOW);
+	gpiod_remove_lookup_table(lookup);
+	if (IS_ERR(bs->cs_gpio)) {
+		ret = PTR_ERR(bs->cs_gpio);
 		goto err_cleanup;
 	}
 
+	spi_set_csgpiod(spi, 0, bs->cs_gpio);
+
 	/* and set up the "mode" and level */
 	dev_info(&spi->dev, "setting up native-CS%i to use GPIO\n",
 		 spi_get_chipselect(spi, 0));
-- 
2.39.2

