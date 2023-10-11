Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215197C538D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346744AbjJKMUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbjJKMU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:20:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AADB1716
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:05 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so66545755e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026182; x=1697630982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35V8jvCQIw7rAurUbrq7bYE+MEctTdw7nPNJ1A06l4g=;
        b=njgzRyAoJcga0iVfTY06x/Vnv5iV8CTBpVEFs7kPsBUW85uRx7qsPYc5niVmAdJXTt
         c3C3w60yRkPPNyAjN/rbyScPs7rvQbUb6vAWYlkjMYK8zsHMO66viX21Qi5E/+EPxeEM
         vj2LfDIAEGJZ2oBhyHBty5m5y8NTvLrUkxSxVhZPxRvZHgPbPSK5E4flw8BdCMIJgIb/
         Dcw1pwTrKlTmN8/Rlvsa+WwsR4KIMgsc1z8CfsxryLGl9LyD8JGdEpZ1Q4M448GUEnjg
         FFcIqByUMOB35no3I+q78CUTEf5XqRx7Gg78JoQMChgCYBiG8l5OLX2bF8cTn4s8dWHA
         NHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026182; x=1697630982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35V8jvCQIw7rAurUbrq7bYE+MEctTdw7nPNJ1A06l4g=;
        b=LtoeysS0x56I9U5IKlf+16N3y4UsrEbuwmgAwWfonqxcZvIP2vb3iJFK1ChV3f6LHe
         ZO47X0IAic7S6wzu4U2mt1BigyS7e3CL9OAGoG+CK9/kr3NfmQCv83OZkq07SpQheUwn
         1XtwpAdLSayrtj3REOm8MZDj3S9gDNvJI0oUgUrxbHfQDoXkbBH4oblHe5MTuE/dbTBU
         MHX0DdtGN9pWyGWy9hoA3Jt0FTLP8+XLMJYl+mx3nbKgeRu4k5FOar9KJMFvNMAb0RSJ
         PzlvPrLcxu/i1Ta31abnVoCKwdOLKJsh2rpYHAd0d/sXcDQ3vg8sIQv03v6diunxEOHE
         lCsA==
X-Gm-Message-State: AOJu0YwsPzB9tkgLxLbI3FytqUkcevwmmDgAa3uhClv5UR+SGGZpG30G
        /FdVfEzWRyeG0B5qwftH3t/ixw==
X-Google-Smtp-Source: AGHT+IHcSrMJ+J2Z0SfCu4Y3ghOb4tA4yxUcD9YIt3siGmlFrbgCwexfGzP7ItwZjdr5k8VZB2p4LA==
X-Received: by 2002:a05:600c:2298:b0:406:4573:81d2 with SMTP id 24-20020a05600c229800b00406457381d2mr17692837wmf.39.1697026181996;
        Wed, 11 Oct 2023 05:09:41 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:41 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 38/62] treewide: rename pinctrl_gpio_free_new()
Date:   Wed, 11 Oct 2023 14:08:06 +0200
Message-Id: <20231011120830.49324-39-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011120830.49324-1-brgl@bgdev.pl>
References: <20231011120830.49324-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Now that pinctrl_gpio_free()() is no longer used, let's drop the '_new'
suffix from its improved variant.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-aspeed.c                         | 2 +-
 drivers/gpio/gpio-em.c                             | 2 +-
 drivers/gpio/gpio-rcar.c                           | 2 +-
 drivers/gpio/gpio-tegra.c                          | 2 +-
 drivers/gpio/gpiolib.c                             | 2 +-
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c           | 2 +-
 drivers/pinctrl/core.c                             | 6 +++---
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          | 2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c          | 2 +-
 drivers/pinctrl/renesas/gpio.c                     | 2 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            | 2 +-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c            | 2 +-
 drivers/pinctrl/spear/pinctrl-plgpio.c             | 4 ++--
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 2 +-
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 2 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              | 2 +-
 include/linux/pinctrl/consumer.h                   | 4 ++--
 17 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index af851c89cacc..4c417c8486dd 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -755,7 +755,7 @@ static int aspeed_gpio_request(struct gpio_chip *chip, unsigned int offset)
 
 static void aspeed_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
-	pinctrl_gpio_free_new(chip, offset);
+	pinctrl_gpio_free(chip, offset);
 }
 
 static int usecs_to_cycles(struct aspeed_gpio *gpio, unsigned long usecs,
diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index 08c5427deb71..aa31c189d0ef 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -234,7 +234,7 @@ static int em_gio_request(struct gpio_chip *chip, unsigned offset)
 
 static void em_gio_free(struct gpio_chip *chip, unsigned offset)
 {
-	pinctrl_gpio_free_new(chip, offset);
+	pinctrl_gpio_free(chip, offset);
 
 	/* Set the GPIO as an input to ensure that the next GPIO request won't
 	* drive the GPIO pin as an output.
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 8c98730a7ad2..6159fda38d5d 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -286,7 +286,7 @@ static void gpio_rcar_free(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
 
-	pinctrl_gpio_free_new(chip, offset);
+	pinctrl_gpio_free(chip, offset);
 
 	/*
 	 * Set the GPIO as an input to ensure that the next GPIO request won't
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index c974ba368d18..fcb3b474d1df 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -146,7 +146,7 @@ static void tegra_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
 	struct tegra_gpio_info *tgi = gpiochip_get_data(chip);
 
-	pinctrl_gpio_free_new(chip, offset);
+	pinctrl_gpio_free(chip, offset);
 	tegra_gpio_disable(tgi, offset);
 }
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c3daf819af76..0c499cff3fad 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1981,7 +1981,7 @@ void gpiochip_generic_free(struct gpio_chip *gc, unsigned int offset)
 		return;
 #endif
 
-	pinctrl_gpio_free_new(gc, offset);
+	pinctrl_gpio_free(gc, offset);
 }
 EXPORT_SYMBOL_GPL(gpiochip_generic_free);
 
diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
index 8162dd840933..fd5ce52d05b1 100644
--- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -345,7 +345,7 @@ static void iproc_gpio_free(struct gpio_chip *gc, unsigned offset)
 	if (!chip->pinmux_is_supported)
 		return;
 
-	pinctrl_gpio_free_new(gc, offset);
+	pinctrl_gpio_free(gc, offset);
 }
 
 static int iproc_gpio_direction_input(struct gpio_chip *gc, unsigned gpio)
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 175240a354b7..fa7f8dc5e5d8 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -820,7 +820,7 @@ int pinctrl_gpio_request(struct gpio_chip *gc, unsigned int offset)
 EXPORT_SYMBOL_GPL(pinctrl_gpio_request);
 
 /**
- * pinctrl_gpio_free_new() - free control on a single pin, currently used as GPIO
+ * pinctrl_gpio_free() - free control on a single pin, currently used as GPIO
  * @gc: GPIO chip structure from the GPIO subsystem
  * @offset: hardware offset of the GPIO relative to the controller
  *
@@ -828,7 +828,7 @@ EXPORT_SYMBOL_GPL(pinctrl_gpio_request);
  * as part of their gpio_request() semantics, platforms and individual drivers
  * shall *NOT* request GPIO pins to be muxed in.
  */
-void pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset)
+void pinctrl_gpio_free(struct gpio_chip *gc, unsigned int offset)
 {
 	struct pinctrl_gpio_range *range;
 	struct pinctrl_dev *pctldev;
@@ -848,7 +848,7 @@ void pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset)
 
 	mutex_unlock(&pctldev->mutex);
 }
-EXPORT_SYMBOL_GPL(pinctrl_gpio_free_new);
+EXPORT_SYMBOL_GPL(pinctrl_gpio_free);
 
 static int pinctrl_gpio_direction(unsigned gpio, bool input)
 {
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index ad39b8c060b7..ab7cfc1e66f0 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -211,7 +211,7 @@ static int npcmgpio_gpio_request(struct gpio_chip *chip, unsigned int offset)
 static void npcmgpio_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
 	dev_dbg(chip->parent, "gpio_free: offset%d\n", offset);
-	pinctrl_gpio_free_new(chip, offset);
+	pinctrl_gpio_free(chip, offset);
 }
 
 static void npcmgpio_irq_handler(struct irq_desc *desc)
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index dd4532ae62bf..78dbeef6af86 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -207,7 +207,7 @@ static int npcmgpio_gpio_request(struct gpio_chip *chip, unsigned int offset)
 
 static void npcmgpio_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
-	pinctrl_gpio_free_new(chip, offset);
+	pinctrl_gpio_free(chip, offset);
 }
 
 static void npcmgpio_irq_handler(struct irq_desc *desc)
diff --git a/drivers/pinctrl/renesas/gpio.c b/drivers/pinctrl/renesas/gpio.c
index 0c4f4d8d0891..b39125a632b0 100644
--- a/drivers/pinctrl/renesas/gpio.c
+++ b/drivers/pinctrl/renesas/gpio.c
@@ -140,7 +140,7 @@ static int gpio_pin_request(struct gpio_chip *gc, unsigned offset)
 
 static void gpio_pin_free(struct gpio_chip *gc, unsigned offset)
 {
-	return pinctrl_gpio_free_new(gc, offset);
+	return pinctrl_gpio_free(gc, offset);
 }
 
 static void gpio_pin_set_value(struct sh_pfc_chip *chip, unsigned offset,
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index c5d247d24374..9de350ad7e7d 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1181,7 +1181,7 @@ static void rzg2l_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
 	unsigned int virq;
 
-	pinctrl_gpio_free_new(chip, offset);
+	pinctrl_gpio_free(chip, offset);
 
 	virq = irq_find_mapping(chip->irq.domain, offset);
 	if (virq)
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index 1ec0922f735c..21d7d5ac8c4a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -832,7 +832,7 @@ static int rzv2m_gpio_get(struct gpio_chip *chip, unsigned int offset)
 
 static void rzv2m_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
-	pinctrl_gpio_free_new(chip, offset);
+	pinctrl_gpio_free(chip, offset);
 
 	/*
 	 * Set the GPIO as an input to ensure that the next GPIO request won't
diff --git a/drivers/pinctrl/spear/pinctrl-plgpio.c b/drivers/pinctrl/spear/pinctrl-plgpio.c
index 6d3b7ce1c35a..a05570c7d833 100644
--- a/drivers/pinctrl/spear/pinctrl-plgpio.c
+++ b/drivers/pinctrl/spear/pinctrl-plgpio.c
@@ -248,7 +248,7 @@ static int plgpio_request(struct gpio_chip *chip, unsigned offset)
 	if (!IS_ERR(plgpio->clk))
 		clk_disable(plgpio->clk);
 err0:
-	pinctrl_gpio_free_new(chip, offset);
+	pinctrl_gpio_free(chip, offset);
 	return ret;
 }
 
@@ -278,7 +278,7 @@ static void plgpio_free(struct gpio_chip *chip, unsigned offset)
 	if (!IS_ERR(plgpio->clk))
 		clk_disable(plgpio->clk);
 
-	pinctrl_gpio_free_new(chip, offset);
+	pinctrl_gpio_free(chip, offset);
 }
 
 /* PLGPIO IRQ */
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
index 88e39f68ef25..7beed57d665a 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
@@ -923,7 +923,7 @@ static int starfive_gpio_request(struct gpio_chip *gc, unsigned int gpio)
 
 static void starfive_gpio_free(struct gpio_chip *gc, unsigned int gpio)
 {
-	pinctrl_gpio_free_new(gc, gpio);
+	pinctrl_gpio_free(gc, gpio);
 }
 
 static int starfive_gpio_get_direction(struct gpio_chip *gc, unsigned int gpio)
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
index c458c6fb992f..695c8c0a6e8b 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
@@ -552,7 +552,7 @@ static int jh7110_gpio_request(struct gpio_chip *gc, unsigned int gpio)
 
 static void jh7110_gpio_free(struct gpio_chip *gc, unsigned int gpio)
 {
-	pinctrl_gpio_free_new(gc, gpio);
+	pinctrl_gpio_free(gc, gpio);
 }
 
 static int jh7110_gpio_get_direction(struct gpio_chip *gc,
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index dddbdc1a64c5..e4453fa58f9e 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -222,7 +222,7 @@ static int stm32_gpio_request(struct gpio_chip *chip, unsigned offset)
 
 static void stm32_gpio_free(struct gpio_chip *chip, unsigned offset)
 {
-	pinctrl_gpio_free_new(chip, offset);
+	pinctrl_gpio_free(chip, offset);
 }
 
 static int stm32_gpio_get(struct gpio_chip *chip, unsigned offset)
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 4aa22af8e4e4..7dc7fcf23f9a 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -28,7 +28,7 @@ struct pinctrl_state;
 /* External interface to pin control */
 bool pinctrl_gpio_can_use_line(struct gpio_chip *gc, unsigned int offset);
 int pinctrl_gpio_request(struct gpio_chip *gc, unsigned int offset);
-void pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset);
+void pinctrl_gpio_free(struct gpio_chip *gc, unsigned int offset);
 int pinctrl_gpio_direction_input_new(struct gpio_chip *gc,
 				     unsigned int offset);
 int pinctrl_gpio_direction_output_new(struct gpio_chip *gc,
@@ -94,7 +94,7 @@ static inline void pinctrl_gpio_free(unsigned gpio)
 }
 
 static inline void
-pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset)
+pinctrl_gpio_free(struct gpio_chip *gc, unsigned int offset)
 {
 }
 
-- 
2.39.2

