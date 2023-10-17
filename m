Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E367C7CC363
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343623AbjJQMWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjJQMVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:21:50 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B4D1FDC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40837ebba42so824455e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544331; x=1698149131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvcpVfHBT1ioZV4rtJYhpr2yYteam0jg6LilLlpkpAQ=;
        b=ByNoGA6g+KZLZ1Thdh2u333n5fIQHNONL6VDQYmDngMxgwrohqMnWmJRasVG2v9Hg1
         2Nuogw1Rs2TReFdCjvIRe9WVFZ1Ec9EN8pBp/w1a3Y1qiv4zOZzsigXYw1b5/3f7XecK
         VfjmIjCg/6BODDOTe4xb8UHMr2t3c/DrFYc/AEcU/NoRmf4BzV/eMQw7ntdEVZldXeCy
         GOGe+3jDpYSvsX25myi/fOVeypDSbwPYNjIDlN+Q48LczAPbAEaB3p0WlPB5bnvEQD7d
         9Y7qa7Z5hUWL+u3rw6RQsKpzBsjUCYvOFVhvKsABPsajCmNZHhjoolyi352U5ohN3/hv
         ufCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544331; x=1698149131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvcpVfHBT1ioZV4rtJYhpr2yYteam0jg6LilLlpkpAQ=;
        b=jMUP9r4EBRtNw+X+K/7SDwybEqsRmP/ByFXjag6yomxtf6BXrec5Z1l+Dh2k3yh14Y
         G6r3jbuXss0XVrXn3ha/5ki01AWX8atseIuJhybkCoWFAsbeVymG20KDPjOCzLc1M5fx
         xxxYZ5lNvmlBoPm0RsTZFsDzTbToyAgBOPf1oL+FsG+BRit1W7XjC28FmKytjD6b/Max
         K03W9zk31/ZS9R8zEwK4W2KcbxscdAwxUev9FfS1YcUOw1U6eQYUeUB+C/7XQyncYDr/
         JbCNRolRj04IC2R8UF5fD52fMcRTPUbtjjUB2Bxn3j37yBPzg9bsdefD0QL8VXGnsbr4
         x9Tw==
X-Gm-Message-State: AOJu0YyUhFCy8cdqcBsCLA6IIThhfz1XXVyMrVGi0w0vPTW8SCN4gmcF
        hKvYfJYbeCPeK7URnyMx7hc8ew==
X-Google-Smtp-Source: AGHT+IEdpHNoEPbxCgAIi2ENMc5sDcdMwGKQ85LmL1s6Z47xEo1PPTlnhpR2eRjOvLTqA0ljLAmrWQ==
X-Received: by 2002:a05:600c:4e8f:b0:406:545a:f8fe with SMTP id f15-20020a05600c4e8f00b00406545af8femr1578699wmq.29.1697544331697;
        Tue, 17 Oct 2023 05:05:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:31 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 45/73] treewide: rename pinctrl_gpio_direction_input_new()
Date:   Tue, 17 Oct 2023 14:04:03 +0200
Message-Id: <20231017120431.68847-46-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Now that pinctrl_gpio_direction_input() is no longer used, let's drop the
'_new' suffix from its improved variant.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mvebu.c                     | 2 +-
 drivers/gpio/gpio-pxa.c                       | 2 +-
 drivers/gpio/gpio-rockchip.c                  | 2 +-
 drivers/gpio/gpio-tegra.c                     | 2 +-
 drivers/gpio/gpio-vf610.c                     | 2 +-
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c      | 2 +-
 drivers/pinctrl/core.c                        | 6 +++---
 drivers/pinctrl/intel/pinctrl-cherryview.c    | 2 +-
 drivers/pinctrl/intel/pinctrl-intel.c         | 2 +-
 drivers/pinctrl/intel/pinctrl-lynxpoint.c     | 2 +-
 drivers/pinctrl/mediatek/pinctrl-moore.c      | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 2 +-
 drivers/pinctrl/mediatek/pinctrl-paris.c      | 2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c     | 2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c     | 2 +-
 drivers/pinctrl/pinctrl-as3722.c              | 2 +-
 drivers/pinctrl/pinctrl-axp209.c              | 2 +-
 drivers/pinctrl/pinctrl-cy8c95x0.c            | 2 +-
 drivers/pinctrl/pinctrl-ingenic.c             | 2 +-
 drivers/pinctrl/pinctrl-ocelot.c              | 2 +-
 drivers/pinctrl/pinctrl-rk805.c               | 2 +-
 drivers/pinctrl/pinctrl-st.c                  | 2 +-
 drivers/pinctrl/renesas/gpio.c                | 2 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c         | 2 +-
 drivers/pinctrl/vt8500/pinctrl-wmt.c          | 2 +-
 include/linux/pinctrl/consumer.h              | 6 +++---
 26 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index c0ca0aa7b5cd..159a302486ac 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -346,7 +346,7 @@ static int mvebu_gpio_direction_input(struct gpio_chip *chip, unsigned int pin)
 	 * Check with the pinctrl driver whether this pin is usable as
 	 * an input GPIO
 	 */
-	ret = pinctrl_gpio_direction_input_new(chip, pin);
+	ret = pinctrl_gpio_direction_input(chip, pin);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 2fd797b91270..c60197d5fde0 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -260,7 +260,7 @@ static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 	int ret;
 
 	if (pxa_gpio_has_pinctrl()) {
-		ret = pinctrl_gpio_direction_input_new(chip, offset);
+		ret = pinctrl_gpio_direction_input(chip, offset);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 3576793f0bd9..05afb67fd677 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -159,7 +159,7 @@ static int rockchip_gpio_set_direction(struct gpio_chip *chip,
 
 
 	if (input)
-		pinctrl_gpio_direction_input_new(chip, offset);
+		pinctrl_gpio_direction_input(chip, offset);
 	else
 		pinctrl_gpio_direction_output_new(chip, offset);
 
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index fcb3b474d1df..a9a00b28cc55 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -179,7 +179,7 @@ static int tegra_gpio_direction_input(struct gpio_chip *chip,
 	tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, offset), offset, 0);
 	tegra_gpio_enable(tgi, offset);
 
-	ret = pinctrl_gpio_direction_input_new(chip, offset);
+	ret = pinctrl_gpio_direction_input(chip, offset);
 	if (ret < 0)
 		dev_err(tgi->dev,
 			"Failed to set pinctrl input direction of GPIO %d: %d",
diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 2c22a31ffbdc..fd1c06abb5a7 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -130,7 +130,7 @@ static int vf610_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
 	}
 
-	return pinctrl_gpio_direction_input_new(chip, gpio);
+	return pinctrl_gpio_direction_input(chip, gpio);
 }
 
 static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
diff --git a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
index 097e4dcdda36..e35964359381 100644
--- a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
+++ b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
@@ -508,7 +508,7 @@ static void cs42l43_gpio_set(struct gpio_chip *chip, unsigned int offset, int va
 
 static int cs42l43_gpio_direction_in(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input_new(chip, offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int cs42l43_gpio_direction_out(struct gpio_chip *chip,
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 6872614c4a95..242357f96238 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -874,7 +874,7 @@ static int pinctrl_gpio_direction(unsigned gpio, bool input)
 }
 
 /**
- * pinctrl_gpio_direction_input_new() - request a GPIO pin to go into input mode
+ * pinctrl_gpio_direction_input() - request a GPIO pin to go into input mode
  * @gc: GPIO chip structure from the GPIO subsystem
  * @offset: hardware offset of the GPIO relative to the controller
  *
@@ -882,11 +882,11 @@ static int pinctrl_gpio_direction(unsigned gpio, bool input)
  * as part of their gpio_direction_input() semantics, platforms and individual
  * drivers shall *NOT* touch pin control GPIO calls.
  */
-int pinctrl_gpio_direction_input_new(struct gpio_chip *gc, unsigned int offset)
+int pinctrl_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
 {
 	return pinctrl_gpio_direction(gc->base + offset, true);
 }
-EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_input_new);
+EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_input);
 
 /**
  * pinctrl_gpio_direction_output_new() - request a GPIO pin to go into output
diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index f806b7ce086b..baf32a8156c4 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1148,7 +1148,7 @@ static int chv_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 
 static int chv_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input_new(chip, offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int chv_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index f403eb78f355..2b0d418418f2 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -992,7 +992,7 @@ static int intel_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 
 static int intel_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input_new(chip, offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int intel_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
index 91d228fead45..b4174829e1f9 100644
--- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
+++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
@@ -541,7 +541,7 @@ static void lp_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 
 static int lp_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input_new(chip, offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int lp_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index dc41ffa31357..5a5ec00e32ea 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -512,7 +512,7 @@ static void mtk_gpio_set(struct gpio_chip *chip, unsigned int gpio, int value)
 
 static int mtk_gpio_direction_input(struct gpio_chip *chip, unsigned int gpio)
 {
-	return pinctrl_gpio_direction_input_new(chip, gpio);
+	return pinctrl_gpio_direction_input(chip, gpio);
 }
 
 static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index fc046415b567..b2dc3072050a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -811,7 +811,7 @@ static const struct pinmux_ops mtk_pmx_ops = {
 static int mtk_gpio_direction_input(struct gpio_chip *chip,
 					unsigned offset)
 {
-	return pinctrl_gpio_direction_input_new(chip, offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int mtk_gpio_direction_output(struct gpio_chip *chip,
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 14b151aec2f9..d8c969e506ce 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -916,7 +916,7 @@ static int mtk_gpio_direction_input(struct gpio_chip *chip, unsigned int gpio)
 	if (gpio >= hw->soc->npins)
 		return -EINVAL;
 
-	return pinctrl_gpio_direction_input_new(chip, gpio);
+	return pinctrl_gpio_direction_input(chip, gpio);
 }
 
 static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index ab7cfc1e66f0..d7ce67242248 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -171,7 +171,7 @@ static int npcmgpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 	struct npcm7xx_gpio *bank = gpiochip_get_data(chip);
 	int ret;
 
-	ret = pinctrl_gpio_direction_input_new(chip, offset);
+	ret = pinctrl_gpio_direction_input(chip, offset);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index 78dbeef6af86..c22513e30068 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -173,7 +173,7 @@ static int npcmgpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 	struct npcm8xx_gpio *bank = gpiochip_get_data(chip);
 	int ret;
 
-	ret = pinctrl_gpio_direction_input_new(chip, offset);
+	ret = pinctrl_gpio_direction_input(chip, offset);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pinctrl/pinctrl-as3722.c b/drivers/pinctrl/pinctrl-as3722.c
index 205937f7f9a1..e77b180155f4 100644
--- a/drivers/pinctrl/pinctrl-as3722.c
+++ b/drivers/pinctrl/pinctrl-as3722.c
@@ -502,7 +502,7 @@ static void as3722_gpio_set(struct gpio_chip *chip, unsigned offset,
 
 static int as3722_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	return pinctrl_gpio_direction_input_new(chip, offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int as3722_gpio_direction_output(struct gpio_chip *chip,
diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index d7f081f1d1f6..a6eb3b866a23 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -126,7 +126,7 @@ static int axp20x_gpio_get_reg(unsigned int offset)
 
 static int axp20x_gpio_input(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input_new(chip, offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int axp20x_gpio_get(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 8c6006353515..729c13a249ef 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -554,7 +554,7 @@ static int cy8c95x0_read_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
 
 static int cy8c95x0_gpio_direction_input(struct gpio_chip *gc, unsigned int off)
 {
-	return pinctrl_gpio_direction_input_new(gc, off);
+	return pinctrl_gpio_direction_input(gc, off);
 }
 
 static int cy8c95x0_gpio_direction_output(struct gpio_chip *gc,
diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 5072fb907193..df36141edbf3 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -3563,7 +3563,7 @@ static int ingenic_gpio_get(struct gpio_chip *gc, unsigned int offset)
 static int ingenic_gpio_direction_input(struct gpio_chip *gc,
 		unsigned int offset)
 {
-	return pinctrl_gpio_direction_input_new(gc, offset);
+	return pinctrl_gpio_direction_input(gc, offset);
 }
 
 static int ingenic_gpio_direction_output(struct gpio_chip *gc,
diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index a6022d44ad6c..d02d16084f33 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1779,7 +1779,7 @@ static int ocelot_gpio_get_direction(struct gpio_chip *chip,
 static int ocelot_gpio_direction_input(struct gpio_chip *chip,
 				       unsigned int offset)
 {
-	return pinctrl_gpio_direction_input_new(chip, offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int ocelot_gpio_direction_output(struct gpio_chip *chip,
diff --git a/drivers/pinctrl/pinctrl-rk805.c b/drivers/pinctrl/pinctrl-rk805.c
index 58e6dd932bc7..f0feb3a8e630 100644
--- a/drivers/pinctrl/pinctrl-rk805.c
+++ b/drivers/pinctrl/pinctrl-rk805.c
@@ -289,7 +289,7 @@ static void rk805_gpio_set(struct gpio_chip *chip,
 static int rk805_gpio_direction_input(struct gpio_chip *chip,
 				      unsigned int offset)
 {
-	return pinctrl_gpio_direction_input_new(chip, offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int rk805_gpio_direction_output(struct gpio_chip *chip,
diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index ec763572ab3e..3f6631716779 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -719,7 +719,7 @@ static void st_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 static int st_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	pinctrl_gpio_direction_input_new(chip, offset);
+	pinctrl_gpio_direction_input(chip, offset);
 
 	return 0;
 }
diff --git a/drivers/pinctrl/renesas/gpio.c b/drivers/pinctrl/renesas/gpio.c
index b39125a632b0..54346b7fcdef 100644
--- a/drivers/pinctrl/renesas/gpio.c
+++ b/drivers/pinctrl/renesas/gpio.c
@@ -164,7 +164,7 @@ static void gpio_pin_set_value(struct sh_pfc_chip *chip, unsigned offset,
 
 static int gpio_pin_direction_input(struct gpio_chip *gc, unsigned offset)
 {
-	return pinctrl_gpio_direction_input_new(gc, offset);
+	return pinctrl_gpio_direction_input(gc, offset);
 }
 
 static int gpio_pin_direction_output(struct gpio_chip *gc, unsigned offset,
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index e4453fa58f9e..cbe306f47c0a 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -241,7 +241,7 @@ static void stm32_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 static int stm32_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	return pinctrl_gpio_direction_input_new(chip, offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int stm32_gpio_direction_output(struct gpio_chip *chip,
diff --git a/drivers/pinctrl/vt8500/pinctrl-wmt.c b/drivers/pinctrl/vt8500/pinctrl-wmt.c
index 1a313295611e..54cd556a16b8 100644
--- a/drivers/pinctrl/vt8500/pinctrl-wmt.c
+++ b/drivers/pinctrl/vt8500/pinctrl-wmt.c
@@ -528,7 +528,7 @@ static void wmt_gpio_set_value(struct gpio_chip *chip, unsigned offset,
 
 static int wmt_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	return pinctrl_gpio_direction_input_new(chip, offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int wmt_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 55b465edaff1..9531595d1abd 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -29,8 +29,8 @@ struct pinctrl_state;
 bool pinctrl_gpio_can_use_line(struct gpio_chip *gc, unsigned int offset);
 int pinctrl_gpio_request(struct gpio_chip *gc, unsigned int offset);
 void pinctrl_gpio_free(struct gpio_chip *gc, unsigned int offset);
-int pinctrl_gpio_direction_input_new(struct gpio_chip *gc,
-				     unsigned int offset);
+int pinctrl_gpio_direction_input(struct gpio_chip *gc,
+				 unsigned int offset);
 int pinctrl_gpio_direction_output_new(struct gpio_chip *gc,
 				      unsigned int offset);
 int pinctrl_gpio_set_config_new(struct gpio_chip *gc, unsigned int offset,
@@ -85,7 +85,7 @@ pinctrl_gpio_free(struct gpio_chip *gc, unsigned int offset)
 }
 
 static inline int
-pinctrl_gpio_direction_input_new(struct gpio_chip *gc, unsigned int offset)
+pinctrl_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
 {
 	return 0;
 }
-- 
2.39.2

