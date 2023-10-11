Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1E17C53C5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346781AbjJKMXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346870AbjJKMXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:23:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32F091
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-325e9cd483eso6397189f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026181; x=1697630981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTYBgbzA/nOA5w7jzT/+OjvsvBmscN77IyfTCYZLhsA=;
        b=X1ltQVEDv3tLnt5SfX4Y5P9Y0lXSThaSsEhVMfqfoFrnhgpQmE9JziKc5LH5znlcoD
         HrU2HnJ2r/nFJpZkw6CNgrCdMLYB26VhZ6Ge6KqPsFbl3Xlz2WAlGwu0zRpxsv8vQohr
         RHeQPHIrVUnSwR5dvN+mGWaxcz1xULd3gV8SBsyGs810WqoyA6+5Y8rv8YMOC4YAmBza
         5FVkr/tZdoXW5HhQyyplqvjJaDv8WbSrfvuwZcLkkLFTRUxL5EVQ6CYT2GyM+xNaeVYl
         6jYLqV8dmjGjFMqaPlDJqFsauRUmX378L4mFm5GaH0RiEI2PiORW79Xqlr1AlYcxej8H
         eG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026181; x=1697630981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTYBgbzA/nOA5w7jzT/+OjvsvBmscN77IyfTCYZLhsA=;
        b=jbKz0woOUoRZw5DrSiVgvEWDtXGEbdrTX8C5ceJhG+Ig40S/tGi9zSuFmgb2eN7N6E
         uwAey+gL4Tf9OHEnZhu2sJbBBVzzMygE96ML8F+re3u5nf0V4f7iwasoQX8erRtdTKE3
         mMZc3XbAHyOI6AsIPXipnkBMRABk4MSWo6XcE2aXBBFMFb/kZfeIw97+RUhU21FhAsD3
         N2p5szQaSBJn1cQyGwfMdLzDHSewKRCMhJ8hgLIIHik67WbHa3/hi9TvbW/ZMf2aC4ty
         OSsn5LPCU+zIw72zFZsF2theGSA5kdn3h9pnnpRxMdBQrMlkFgmlBepzFti7lDX8wFKP
         5iHg==
X-Gm-Message-State: AOJu0YxRjpYqEWxPxDq1VWTd8nX5pSSOuaa1iXQtu+DfxxwaOsVm/N1P
        tSFzUSKnkq1I3NZS7q2OFQkO1Q==
X-Google-Smtp-Source: AGHT+IGHZ/PFdhjR/5K1C7uzdVgnB9ZFfY7bKq1ghGP5Zjg/Uy+3Xk0x+KNbaVH79vPI3snaTwy1pA==
X-Received: by 2002:a05:6000:184b:b0:32c:9fc6:d32 with SMTP id c11-20020a056000184b00b0032c9fc60d32mr4851654wri.37.1697026181015;
        Wed, 11 Oct 2023 05:09:41 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:40 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 37/62] treewide: rename pinctrl_gpio_request_new()
Date:   Wed, 11 Oct 2023 14:08:05 +0200
Message-Id: <20231011120830.49324-38-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011120830.49324-1-brgl@bgdev.pl>
References: <20231011120830.49324-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Now that pinctrl_gpio_request() is no longer used, let's drop the '_new'
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
 drivers/pinctrl/spear/pinctrl-plgpio.c             | 2 +-
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 2 +-
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 2 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              | 2 +-
 include/linux/pinctrl/consumer.h                   | 4 ++--
 17 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index d3aa1cfd4ace..af851c89cacc 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -750,7 +750,7 @@ static int aspeed_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	if (!have_gpio(gpiochip_get_data(chip), offset))
 		return -ENODEV;
 
-	return pinctrl_gpio_request_new(chip, offset);
+	return pinctrl_gpio_request(chip, offset);
 }
 
 static void aspeed_gpio_free(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index 35c65ff43f71..08c5427deb71 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -229,7 +229,7 @@ static int em_gio_to_irq(struct gpio_chip *chip, unsigned offset)
 
 static int em_gio_request(struct gpio_chip *chip, unsigned offset)
 {
-	return pinctrl_gpio_request_new(chip, offset);
+	return pinctrl_gpio_request(chip, offset);
 }
 
 static void em_gio_free(struct gpio_chip *chip, unsigned offset)
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 47121e1a6d4e..8c98730a7ad2 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -275,7 +275,7 @@ static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
 		return error;
 	}
 
-	error = pinctrl_gpio_request_new(chip, offset);
+	error = pinctrl_gpio_request(chip, offset);
 	if (error)
 		pm_runtime_put(p->dev);
 
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 08951ddcd294..c974ba368d18 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -139,7 +139,7 @@ static void tegra_gpio_disable(struct tegra_gpio_info *tgi, unsigned int gpio)
 
 static int tegra_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_request_new(chip, offset);
+	return pinctrl_gpio_request(chip, offset);
 }
 
 static void tegra_gpio_free(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index cec816b46679..c3daf819af76 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1965,7 +1965,7 @@ int gpiochip_generic_request(struct gpio_chip *gc, unsigned int offset)
 		return 0;
 #endif
 
-	return pinctrl_gpio_request_new(gc, offset);
+	return pinctrl_gpio_request(gc, offset);
 }
 EXPORT_SYMBOL_GPL(gpiochip_generic_request);
 
diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
index fb98c3e14743..8162dd840933 100644
--- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -335,7 +335,7 @@ static int iproc_gpio_request(struct gpio_chip *gc, unsigned offset)
 	if (!chip->pinmux_is_supported)
 		return 0;
 
-	return pinctrl_gpio_request_new(gc, offset);
+	return pinctrl_gpio_request(gc, offset);
 }
 
 static void iproc_gpio_free(struct gpio_chip *gc, unsigned offset)
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 2c8d0ef798f5..175240a354b7 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -784,7 +784,7 @@ bool pinctrl_gpio_can_use_line(struct gpio_chip *gc, unsigned int offset)
 EXPORT_SYMBOL_GPL(pinctrl_gpio_can_use_line);
 
 /**
- * pinctrl_gpio_request_new() - request a single pin to be used as GPIO
+ * pinctrl_gpio_request() - request a single pin to be used as GPIO
  * @gc: GPIO chip structure from the GPIO subsystem
  * @offset: hardware offset of the GPIO relative to the controller
  *
@@ -792,7 +792,7 @@ EXPORT_SYMBOL_GPL(pinctrl_gpio_can_use_line);
  * as part of their gpio_request() semantics, platforms and individual drivers
  * shall *NOT* request GPIO pins to be muxed in.
  */
-int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset)
+int pinctrl_gpio_request(struct gpio_chip *gc, unsigned int offset)
 {
 	struct pinctrl_gpio_range *range;
 	struct pinctrl_dev *pctldev;
@@ -817,7 +817,7 @@ int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(pinctrl_gpio_request_new);
+EXPORT_SYMBOL_GPL(pinctrl_gpio_request);
 
 /**
  * pinctrl_gpio_free_new() - free control on a single pin, currently used as GPIO
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 62134a7f0b4e..ad39b8c060b7 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -201,7 +201,7 @@ static int npcmgpio_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	int ret;
 
 	dev_dbg(chip->parent, "gpio_request: offset%d\n", offset);
-	ret = pinctrl_gpio_request_new(chip, offset);
+	ret = pinctrl_gpio_request(chip, offset);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index 0b6d6964087e..dd4532ae62bf 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -198,7 +198,7 @@ static int npcmgpio_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	struct npcm8xx_gpio *bank = gpiochip_get_data(chip);
 	int ret;
 
-	ret = pinctrl_gpio_request_new(chip, offset);
+	ret = pinctrl_gpio_request(chip, offset);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pinctrl/renesas/gpio.c b/drivers/pinctrl/renesas/gpio.c
index e7771a57e6d1..0c4f4d8d0891 100644
--- a/drivers/pinctrl/renesas/gpio.c
+++ b/drivers/pinctrl/renesas/gpio.c
@@ -135,7 +135,7 @@ static int gpio_pin_request(struct gpio_chip *gc, unsigned offset)
 	if (idx < 0 || pfc->info->pins[idx].enum_id == 0)
 		return -EINVAL;
 
-	return pinctrl_gpio_request_new(gc, offset);
+	return pinctrl_gpio_request(gc, offset);
 }
 
 static void gpio_pin_free(struct gpio_chip *gc, unsigned offset)
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 22d4ab7d228c..c5d247d24374 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1056,7 +1056,7 @@ static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	if (ret)
 		return ret;
 
-	ret = pinctrl_gpio_request_new(chip, offset);
+	ret = pinctrl_gpio_request(chip, offset);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index 3d29c77a5aad..1ec0922f735c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -754,7 +754,7 @@ static int rzv2m_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	u8 bit = RZV2M_PIN_ID_TO_PIN(offset);
 	int ret;
 
-	ret = pinctrl_gpio_request_new(chip, offset);
+	ret = pinctrl_gpio_request(chip, offset);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pinctrl/spear/pinctrl-plgpio.c b/drivers/pinctrl/spear/pinctrl-plgpio.c
index 7488f6394318..6d3b7ce1c35a 100644
--- a/drivers/pinctrl/spear/pinctrl-plgpio.c
+++ b/drivers/pinctrl/spear/pinctrl-plgpio.c
@@ -210,7 +210,7 @@ static int plgpio_request(struct gpio_chip *chip, unsigned offset)
 	if (offset >= chip->ngpio)
 		return -EINVAL;
 
-	ret = pinctrl_gpio_request_new(chip, offset);
+	ret = pinctrl_gpio_request(chip, offset);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
index 22a2db8fa315..88e39f68ef25 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
@@ -918,7 +918,7 @@ static struct pinctrl_desc starfive_desc = {
 
 static int starfive_gpio_request(struct gpio_chip *gc, unsigned int gpio)
 {
-	return pinctrl_gpio_request_new(gc, gpio);
+	return pinctrl_gpio_request(gc, gpio);
 }
 
 static void starfive_gpio_free(struct gpio_chip *gc, unsigned int gpio)
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
index 5557ef3fbeb2..c458c6fb992f 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
@@ -547,7 +547,7 @@ static const struct pinconf_ops jh7110_pinconf_ops = {
 
 static int jh7110_gpio_request(struct gpio_chip *gc, unsigned int gpio)
 {
-	return pinctrl_gpio_request_new(gc, gpio);
+	return pinctrl_gpio_request(gc, gpio);
 }
 
 static void jh7110_gpio_free(struct gpio_chip *gc, unsigned int gpio)
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 11d9f07934bd..dddbdc1a64c5 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -217,7 +217,7 @@ static int stm32_gpio_request(struct gpio_chip *chip, unsigned offset)
 		return -EINVAL;
 	}
 
-	return pinctrl_gpio_request_new(chip, offset);
+	return pinctrl_gpio_request(chip, offset);
 }
 
 static void stm32_gpio_free(struct gpio_chip *chip, unsigned offset)
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 220f69f342e1..4aa22af8e4e4 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -27,7 +27,7 @@ struct pinctrl_state;
 
 /* External interface to pin control */
 bool pinctrl_gpio_can_use_line(struct gpio_chip *gc, unsigned int offset);
-int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset);
+int pinctrl_gpio_request(struct gpio_chip *gc, unsigned int offset);
 void pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset);
 int pinctrl_gpio_direction_input_new(struct gpio_chip *gc,
 				     unsigned int offset);
@@ -84,7 +84,7 @@ static inline int pinctrl_gpio_request(unsigned gpio)
 }
 
 static inline int
-pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset)
+pinctrl_gpio_request(struct gpio_chip *gc, unsigned int offset)
 {
 	return 0;
 }
-- 
2.39.2

