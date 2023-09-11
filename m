Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEB579B7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348167AbjIKVZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242750AbjIKQQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:16:03 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA521B8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:15:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so50040475e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694448957; x=1695053757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HV5y47B9k2tibzGJFcIzC3Wh2s45fqlwzyzXAYAyLZU=;
        b=z8y66fNgAKCrE8HM53F80h2KHSbY1gumOB3bzhz6J59gV1adggHukPtDk7hUH3bQ3M
         +JTuyhyZbJD4DorNMYMaE1ZJ7F2xvroixDHqmNzT9g7wzhZc+pz3eY+AXdFtM4Upo429
         fY6kZk1FBc20n4X3w+O06oo9WOFm7c/Wq467OgkuuQMvL9Q51IdSEF6g67kq8QkQL1Bt
         QeutQ3/KZ0I61lzYjJC9p2KF2OA2soxXelNBhNaRe2Og17gxc5/ZIh3uCtTmSHoxia/A
         a6WdhM+2J1gjP6KejY9SKlOhNNrpOFYg17kgTpUUX+hduXsY5g9CWcFFoXRBxlwaIujn
         R4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694448957; x=1695053757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HV5y47B9k2tibzGJFcIzC3Wh2s45fqlwzyzXAYAyLZU=;
        b=EBsHkshLpad5ZTY19QLNffcj0jDi0K1P4mILOY/qGhUSr7sMKOPw0+BGbfm7k2L+hG
         /QqmUJNbE4JKlmLibLW6IRYQ8SNXXcrcVV81E9Nk1STIRvJo4FbayVxJQpPRpr8WdO9j
         6axm0gHxmOyd9SB+YIQaIAqkWxch+1yR8P4JLUyyOt1o2NLhDcV5SaqrpH9M0s63Pl1V
         oyU2ARx7ut+NmjNhuojolPScy2+vDkzaKAbACyNyN5yifQ60wuU96czANKvYUz/ErRT0
         GqAPQBj6cwzoKVJLTr9Q58GzXn9cS3n/l4ixwFkKhAo3g8KGSnUnZ0dxqbYdUYynbN10
         X3QA==
X-Gm-Message-State: AOJu0YyLV7JXQQMdQHo0KFqIH6cpnZqChEIA2DaAvuDjnTh+b5blh5I/
        VUYTvmqQKpd4kIBQWUnm2vvNew==
X-Google-Smtp-Source: AGHT+IH4VJSvvSxbVOwJYo159Cuu4FuAwlQeRg83/jubmlshB8+C2StDaNviQOqqFhUF8K4JCTIomg==
X-Received: by 2002:a05:600c:2257:b0:3fe:ef11:d79f with SMTP id a23-20020a05600c225700b003feef11d79fmr8329151wmm.36.1694448956816;
        Mon, 11 Sep 2023 09:15:56 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c2b1:675e:119e:2497])
        by smtp.gmail.com with ESMTPSA id u5-20020a05600c00c500b003fe2de3f94fsm10397693wmm.12.2023.09.11.09.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 09:15:56 -0700 (PDT)
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
Subject: [PATCH v3] spi: bcm2835: reduce the abuse of the GPIO API
Date:   Mon, 11 Sep 2023 18:15:53 +0200
Message-Id: <20230911161553.24313-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Currently the bcm2835 SPI driver uses functions that are available
exclusively to GPIO providers as a way to handle a platform quirk. Let's
use a slightly better alternative that avoids poking around in GPIOLIB's
internals and use GPIO lookup tables.

Link: https://www.spinics.net/lists/linux-gpio/msg36218.html
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
This is only build-tested. It should work, but it would be great if
someone from broadcom could test this.

Andy pointed out elsewhere that we can use GPIO_LOOKUP() even in
dynamically allocated tables, hence v3.

v1 -> v2:
- don't use devres for managing the GPIO but put it manually in .cleanup()
- add a mailing list link explaining the background of the bug
- fix kerneldoc

v2 -> v3:
- use GPIO_LOOKUP() macro for creating the lookup entry as it looks
  better and results in less LOC

 drivers/spi/spi-bcm2835.c | 60 +++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index e7bb2714678a..dfd9c4997052 100644
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
@@ -83,6 +85,7 @@ MODULE_PARM_DESC(polling_limit_us,
  * struct bcm2835_spi - BCM2835 SPI controller
  * @regs: base address of register map
  * @clk: core clock, divided to calculate serial clock
+ * @cs_gpio: chip-select GPIO descriptor
  * @clk_hz: core clock cached speed
  * @irq: interrupt, signals TX FIFO empty or RX FIFO ¾ full
  * @tfr: SPI transfer currently processed
@@ -117,6 +120,7 @@ MODULE_PARM_DESC(polling_limit_us,
 struct bcm2835_spi {
 	void __iomem *regs;
 	struct clk *clk;
+	struct gpio_desc *cs_gpio;
 	unsigned long clk_hz;
 	int irq;
 	struct spi_transfer *tfr;
@@ -1156,15 +1160,11 @@ static void bcm2835_spi_handle_err(struct spi_controller *ctlr,
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
 	struct spi_controller *ctlr = spi->controller;
+	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 
 	if (target->clear_rx_desc)
 		dmaengine_desc_free(target->clear_rx_desc);
@@ -1175,6 +1175,9 @@ static void bcm2835_spi_cleanup(struct spi_device *spi)
 				 sizeof(u32),
 				 DMA_TO_DEVICE);
 
+	gpiod_put(bs->cs_gpio);
+	spi_set_csgpiod(spi, 0, NULL);
+
 	kfree(target);
 }
 
@@ -1221,7 +1224,7 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	struct spi_controller *ctlr = spi->controller;
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	struct bcm2835_spidev *target = spi_get_ctldata(spi);
-	struct gpio_chip *chip;
+	struct gpiod_lookup_table *lookup __free(kfree) = NULL;
 	int ret;
 	u32 cs;
 
@@ -1288,29 +1291,36 @@ static int bcm2835_spi_setup(struct spi_device *spi)
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
+	 * More on the problem that it addresses:
+	 *   https://www.spinics.net/lists/linux-gpio/msg36218.html
 	 */
+	lookup = kzalloc(struct_size(lookup, table, 1), GFP_KERNEL);
+	if (!lookup) {
+		ret = -ENOMEM;
+		goto err_cleanup;
+	}
+
+	lookup->dev_id = dev_name(&spi->dev);
+	lookup->table[0] = GPIO_LOOKUP("pinctrl-bcm2835",
+				       8 - (spi_get_chipselect(spi, 0)),
+				       "cs", GPIO_LOOKUP_FLAGS_DEFAULT);
 
-	/* get the gpio chip for the base */
-	chip = gpiochip_find("pinctrl-bcm2835", chip_match_name);
-	if (!chip)
-		return 0;
-
-	spi_set_csgpiod(spi, 0, gpiochip_request_own_desc(chip,
-							  8 - (spi_get_chipselect(spi, 0)),
-							  DRV_NAME,
-							  GPIO_LOOKUP_FLAGS_DEFAULT,
-							  GPIOD_OUT_LOW));
-	if (IS_ERR(spi_get_csgpiod(spi, 0))) {
-		ret = PTR_ERR(spi_get_csgpiod(spi, 0));
+	gpiod_add_lookup_table(lookup);
+
+	bs->cs_gpio = gpiod_get(&spi->dev, "cs", GPIOD_OUT_LOW);
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

