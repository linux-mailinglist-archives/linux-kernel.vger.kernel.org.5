Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8A47B6C63
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbjJCOxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240287AbjJCOwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:52:22 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F4D1985
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:51:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso10484795e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696344713; x=1696949513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3d049XbB9Hr0P+CwffX8woDpf6okLSBkc/Gu+wrSQE=;
        b=SJJEUN5fY0cY5t5t3j85eDrsCk/P//UwPirL/FT9DvZfFV9bvhNYpnwZYSbx6RHlZE
         cw9JCHkwmU6cKC6hXNqT9+VubLU8M/ZZVPE/j9N9eFNn0c+ys+uUBBkNl2SjIPIie7OL
         GpoMKqZ4g4hR8Hv4nXiwPinLV5g97Ht1+2PPNPmMMXGMqRIZshLakbfQb8Dut4h4+zFY
         vnRFe4q1Nw3SfpFEgEtbZ7vctYpo2wuwfxzwkBt9HLORb1SXWt+TQY2PhbhHo3KFR97Y
         QMzO00lL2Jw3qCqqVclno4qCceg85sGr/TkKA71BMq/NSSoHwmj/q1Dh2qAOnD+0tUHC
         86XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344713; x=1696949513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3d049XbB9Hr0P+CwffX8woDpf6okLSBkc/Gu+wrSQE=;
        b=dh2RS0gRE1Qc9fHssL5q+N1XdFil03IVsCrAIQyhQI0Nn4glQFnSe0HGEu4sbJcMUC
         csltGt4hI9nR1FKLb+3FYfr93RBaSrMflI7VkLNCJ6hUPLRbFtPQHb1HdeAHpVO+fg0K
         eK1hZ1W8MIWkQRtnLDw9XJXjpGOGkye4x2ai2OE5DuJuw+LvxIm3VvfzNqw44+TBXx0+
         2O79ZpMK4ayITIWwhNqshZ/wOC3UQd6gFCZfdln0TM5np3hst1aHe3TTSfHZ48hny5M7
         H4uKOHd3f+vW5n2jKL2ccWEmForxUNHmfZMcL0/Cp8std6Sb7LTJ4VWovggWql4Ebgzz
         uhvQ==
X-Gm-Message-State: AOJu0YyH3XzsSViP2PjsKcQZXs+FDX/SwYPS6cVQoIGnza2m0oXtwnIU
        a9ooOxci8lHc/47J3P39E4HLkg==
X-Google-Smtp-Source: AGHT+IGgmg6wSpAtbjOu1hjUunHEkNWGqFhOq8yN/kF5ez666mUP5J0za6/KdHNDb6d6cZz0kedwAA==
X-Received: by 2002:a05:600c:2317:b0:402:f5c4:2e5a with SMTP id 23-20020a05600c231700b00402f5c42e5amr13358149wmo.37.1696344713167;
        Tue, 03 Oct 2023 07:51:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003fe29f6b61bsm1462773wmr.46.2023.10.03.07.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:51:52 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 35/36] treewide: rename pinctrl_gpio_direction_output_new()
Date:   Tue,  3 Oct 2023 16:51:13 +0200
Message-Id: <20231003145114.21637-36-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003145114.21637-1-brgl@bgdev.pl>
References: <20231003145114.21637-1-brgl@bgdev.pl>
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

Now that pinctrl_gpio_direction_output() is no longer used, let's drop
the '_new' suffix from its improved variant.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mvebu.c                     | 2 +-
 drivers/gpio/gpio-pxa.c                       | 2 +-
 drivers/gpio/gpio-rockchip.c                  | 2 +-
 drivers/gpio/gpio-tegra.c                     | 2 +-
 drivers/gpio/gpio-vf610.c                     | 2 +-
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c      | 2 +-
 drivers/pinctrl/cirrus/pinctrl-lochnagar.c    | 2 +-
 drivers/pinctrl/core.c                        | 7 +++----
 drivers/pinctrl/intel/pinctrl-cherryview.c    | 2 +-
 drivers/pinctrl/intel/pinctrl-intel.c         | 2 +-
 drivers/pinctrl/intel/pinctrl-lynxpoint.c     | 2 +-
 drivers/pinctrl/mediatek/pinctrl-moore.c      | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 2 +-
 drivers/pinctrl/mediatek/pinctrl-paris.c      | 2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c     | 2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c     | 2 +-
 drivers/pinctrl/pinctrl-as3722.c              | 2 +-
 drivers/pinctrl/pinctrl-cy8c95x0.c            | 2 +-
 drivers/pinctrl/pinctrl-ingenic.c             | 4 ++--
 drivers/pinctrl/pinctrl-ocelot.c              | 2 +-
 drivers/pinctrl/pinctrl-rk805.c               | 2 +-
 drivers/pinctrl/pinctrl-st.c                  | 2 +-
 drivers/pinctrl/renesas/gpio.c                | 2 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c         | 2 +-
 drivers/pinctrl/vt8500/pinctrl-wmt.c          | 2 +-
 include/linux/pinctrl/consumer.h              | 6 +++---
 26 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 20f788240481..6abb1b1139fe 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -365,7 +365,7 @@ static int mvebu_gpio_direction_output(struct gpio_chip *chip, unsigned int pin,
 	 * Check with the pinctrl driver whether this pin is usable as
 	 * an output GPIO
 	 */
-	ret = pinctrl_gpio_direction_output_new(chip, pin);
+	ret = pinctrl_gpio_direction_output(chip, pin);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index c60197d5fde0..91cea97255fa 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -289,7 +289,7 @@ static int pxa_gpio_direction_output(struct gpio_chip *chip,
 	writel_relaxed(mask, base + (value ? GPSR_OFFSET : GPCR_OFFSET));
 
 	if (pxa_gpio_has_pinctrl()) {
-		ret = pinctrl_gpio_direction_output_new(chip, offset);
+		ret = pinctrl_gpio_direction_output(chip, offset);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 05afb67fd677..0bd339813110 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -161,7 +161,7 @@ static int rockchip_gpio_set_direction(struct gpio_chip *chip,
 	if (input)
 		pinctrl_gpio_direction_input(chip, offset);
 	else
-		pinctrl_gpio_direction_output_new(chip, offset);
+		pinctrl_gpio_direction_output(chip, offset);
 
 	raw_spin_lock_irqsave(&bank->slock, flags);
 	rockchip_gpio_writel_bit(bank, offset, data, bank->gpio_regs->port_ddr);
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index a9a00b28cc55..adfbed62eff1 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -199,7 +199,7 @@ static int tegra_gpio_direction_output(struct gpio_chip *chip,
 	tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, offset), offset, 1);
 	tegra_gpio_enable(tgi, offset);
 
-	ret = pinctrl_gpio_direction_output_new(chip, offset);
+	ret = pinctrl_gpio_direction_output(chip, offset);
 	if (ret < 0)
 		dev_err(tgi->dev,
 			"Failed to set pinctrl output direction of GPIO %d: %d",
diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 6551f80c3e51..b11a6d9b1b69 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -134,7 +134,7 @@ static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 
 	vf610_gpio_set(chip, gpio, value);
 
-	return pinctrl_gpio_direction_output_new(chip, gpio);
+	return pinctrl_gpio_direction_output(chip, gpio);
 }
 
 static void vf610_gpio_irq_handler(struct irq_desc *desc)
diff --git a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
index e35964359381..1ba89cf279fb 100644
--- a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
+++ b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
@@ -516,7 +516,7 @@ static int cs42l43_gpio_direction_out(struct gpio_chip *chip,
 {
 	cs42l43_gpio_set(chip, offset, value);
 
-	return pinctrl_gpio_direction_output_new(chip, offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static int cs42l43_gpio_add_pin_ranges(struct gpio_chip *chip)
diff --git a/drivers/pinctrl/cirrus/pinctrl-lochnagar.c b/drivers/pinctrl/cirrus/pinctrl-lochnagar.c
index f3c8a8c14e14..014297a3fbd2 100644
--- a/drivers/pinctrl/cirrus/pinctrl-lochnagar.c
+++ b/drivers/pinctrl/cirrus/pinctrl-lochnagar.c
@@ -1098,7 +1098,7 @@ static int lochnagar_gpio_direction_out(struct gpio_chip *chip,
 {
 	lochnagar_gpio_set(chip, offset, value);
 
-	return pinctrl_gpio_direction_output_new(chip, offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static int lochnagar_fill_func_groups(struct lochnagar_pin_priv *priv)
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index d5a800ff190d..5f40abef5c1e 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -874,8 +874,7 @@ int pinctrl_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
 EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_input);
 
 /**
- * pinctrl_gpio_direction_output_new() - request a GPIO pin to go into output
- *                                       mode
+ * pinctrl_gpio_direction_output() - request a GPIO pin to go into output mode
  * @gc: GPIO chip structure from the GPIO subsystem
  * @offset: hardware offset of the GPIO relative to the controller
  *
@@ -883,11 +882,11 @@ EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_input);
  * as part of their gpio_direction_output() semantics, platforms and individual
  * drivers shall *NOT* touch pin control GPIO calls.
  */
-int pinctrl_gpio_direction_output_new(struct gpio_chip *gc, unsigned int offset)
+int pinctrl_gpio_direction_output(struct gpio_chip *gc, unsigned int offset)
 {
 	return pinctrl_gpio_direction(gc, offset, false);
 }
-EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_output_new);
+EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_output);
 
 /**
  * pinctrl_gpio_set_config_new() - Apply config to given GPIO pin
diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 7d6532066c83..6ab5953b858a 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1179,7 +1179,7 @@ static int chv_gpio_direction_output(struct gpio_chip *chip, unsigned int offset
 				     int value)
 {
 	chv_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output_new(chip, offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static const struct gpio_chip chv_gpio_chip = {
diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index b53159611c56..151d4356e6a6 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -997,7 +997,7 @@ static int intel_gpio_direction_output(struct gpio_chip *chip, unsigned int offs
 				       int value)
 {
 	intel_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output_new(chip, offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static const struct gpio_chip intel_gpio_chip = {
diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
index 6dbf2537016e..0bc83a0ba75f 100644
--- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
+++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
@@ -553,7 +553,7 @@ static int lp_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
 {
 	lp_gpio_set(chip, offset, value);
 
-	return pinctrl_gpio_direction_output_new(chip,  offset);
+	return pinctrl_gpio_direction_output(chip,  offset);
 }
 
 static int lp_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index 5a5ec00e32ea..c3f33f96f920 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -520,7 +520,7 @@ static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
 {
 	mtk_gpio_set(chip, gpio, value);
 
-	return pinctrl_gpio_direction_output_new(chip, gpio);
+	return pinctrl_gpio_direction_output(chip, gpio);
 }
 
 static int mtk_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index b2dc3072050a..41e9847e3085 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -818,7 +818,7 @@ static int mtk_gpio_direction_output(struct gpio_chip *chip,
 					unsigned offset, int value)
 {
 	mtk_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output_new(chip, offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static int mtk_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index d8c969e506ce..6392f1e05d02 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -929,7 +929,7 @@ static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
 
 	mtk_gpio_set(chip, gpio, value);
 
-	return pinctrl_gpio_direction_output_new(chip, gpio);
+	return pinctrl_gpio_direction_output(chip, gpio);
 }
 
 static int mtk_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index d7ce67242248..51aeac7ecc79 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -188,7 +188,7 @@ static int npcmgpio_direction_output(struct gpio_chip *chip,
 	dev_dbg(chip->parent, "gpio_direction_output: offset%d = %x\n", offset,
 		value);
 
-	ret = pinctrl_gpio_direction_output_new(chip, offset);
+	ret = pinctrl_gpio_direction_output(chip, offset);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index c22513e30068..140fdbbe8458 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -186,7 +186,7 @@ static int npcmgpio_direction_output(struct gpio_chip *chip,
 	struct npcm8xx_gpio *bank = gpiochip_get_data(chip);
 	int ret;
 
-	ret = pinctrl_gpio_direction_output_new(chip, offset);
+	ret = pinctrl_gpio_direction_output(chip, offset);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pinctrl/pinctrl-as3722.c b/drivers/pinctrl/pinctrl-as3722.c
index 3f27da80adde..4151656f6245 100644
--- a/drivers/pinctrl/pinctrl-as3722.c
+++ b/drivers/pinctrl/pinctrl-as3722.c
@@ -509,7 +509,7 @@ static int as3722_gpio_direction_output(struct gpio_chip *chip,
 		unsigned offset, int value)
 {
 	as3722_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output_new(chip, offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static int as3722_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 729c13a249ef..04285c930e94 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -571,7 +571,7 @@ static int cy8c95x0_gpio_direction_output(struct gpio_chip *gc,
 	if (ret)
 		return ret;
 
-	return pinctrl_gpio_direction_output_new(gc, off);
+	return pinctrl_gpio_direction_output(gc, off);
 }
 
 static int cy8c95x0_gpio_get_value(struct gpio_chip *gc, unsigned int off)
diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index df36141edbf3..ca58c9db5c2c 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -3570,7 +3570,7 @@ static int ingenic_gpio_direction_output(struct gpio_chip *gc,
 		unsigned int offset, int value)
 {
 	ingenic_gpio_set(gc, offset, value);
-	return pinctrl_gpio_direction_output_new(gc, offset);
+	return pinctrl_gpio_direction_output(gc, offset);
 }
 
 static inline void ingenic_config_pin(struct ingenic_pinctrl *jzpc,
@@ -4054,7 +4054,7 @@ static int ingenic_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 
 		case PIN_CONFIG_OUTPUT:
-			ret = pinctrl_gpio_direction_output_new(jzpc->gc,
+			ret = pinctrl_gpio_direction_output(jzpc->gc,
 							pin - jzpc->gc->base);
 			if (ret)
 				return ret;
diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index d02d16084f33..96b4e9fceb78 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1795,7 +1795,7 @@ static int ocelot_gpio_direction_output(struct gpio_chip *chip,
 		regmap_write(info->map, REG(OCELOT_GPIO_OUT_CLR, info, offset),
 			     pin);
 
-	return pinctrl_gpio_direction_output_new(chip, offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static const struct gpio_chip ocelot_gpiolib_chip = {
diff --git a/drivers/pinctrl/pinctrl-rk805.c b/drivers/pinctrl/pinctrl-rk805.c
index f0feb3a8e630..968f066eb9da 100644
--- a/drivers/pinctrl/pinctrl-rk805.c
+++ b/drivers/pinctrl/pinctrl-rk805.c
@@ -296,7 +296,7 @@ static int rk805_gpio_direction_output(struct gpio_chip *chip,
 				       unsigned int offset, int value)
 {
 	rk805_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output_new(chip, offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static int rk805_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 3f6631716779..db511dbd50e5 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -730,7 +730,7 @@ static int st_gpio_direction_output(struct gpio_chip *chip,
 	struct st_gpio_bank *bank = gpiochip_get_data(chip);
 
 	__st_gpio_set(bank, offset, value);
-	pinctrl_gpio_direction_output_new(chip, offset);
+	pinctrl_gpio_direction_output(chip, offset);
 
 	return 0;
 }
diff --git a/drivers/pinctrl/renesas/gpio.c b/drivers/pinctrl/renesas/gpio.c
index 54346b7fcdef..a5136dacaaf2 100644
--- a/drivers/pinctrl/renesas/gpio.c
+++ b/drivers/pinctrl/renesas/gpio.c
@@ -172,7 +172,7 @@ static int gpio_pin_direction_output(struct gpio_chip *gc, unsigned offset,
 {
 	gpio_pin_set_value(gpiochip_get_data(gc), offset, value);
 
-	return pinctrl_gpio_direction_output_new(gc, offset);
+	return pinctrl_gpio_direction_output(gc, offset);
 }
 
 static int gpio_pin_get(struct gpio_chip *gc, unsigned offset)
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index cbe306f47c0a..917b87acbf0d 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -250,7 +250,7 @@ static int stm32_gpio_direction_output(struct gpio_chip *chip,
 	struct stm32_gpio_bank *bank = gpiochip_get_data(chip);
 
 	__stm32_gpio_set(bank, offset, value);
-	pinctrl_gpio_direction_output_new(chip, offset);
+	pinctrl_gpio_direction_output(chip, offset);
 
 	return 0;
 }
diff --git a/drivers/pinctrl/vt8500/pinctrl-wmt.c b/drivers/pinctrl/vt8500/pinctrl-wmt.c
index 54cd556a16b8..639446bba373 100644
--- a/drivers/pinctrl/vt8500/pinctrl-wmt.c
+++ b/drivers/pinctrl/vt8500/pinctrl-wmt.c
@@ -535,7 +535,7 @@ static int wmt_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
 				     int value)
 {
 	wmt_gpio_set_value(chip, offset, value);
-	return pinctrl_gpio_direction_output_new(chip, offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static const struct gpio_chip wmt_gpio_chip = {
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 9531595d1abd..e7d660e98e86 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -31,8 +31,8 @@ int pinctrl_gpio_request(struct gpio_chip *gc, unsigned int offset);
 void pinctrl_gpio_free(struct gpio_chip *gc, unsigned int offset);
 int pinctrl_gpio_direction_input(struct gpio_chip *gc,
 				 unsigned int offset);
-int pinctrl_gpio_direction_output_new(struct gpio_chip *gc,
-				      unsigned int offset);
+int pinctrl_gpio_direction_output(struct gpio_chip *gc,
+				  unsigned int offset);
 int pinctrl_gpio_set_config_new(struct gpio_chip *gc, unsigned int offset,
 				unsigned long config);
 
@@ -91,7 +91,7 @@ pinctrl_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
 }
 
 static inline int
-pinctrl_gpio_direction_output_new(struct gpio_chip *gc, unsigned int offset)
+pinctrl_gpio_direction_output(struct gpio_chip *gc, unsigned int offset)
 {
 	return 0;
 }
-- 
2.39.2

