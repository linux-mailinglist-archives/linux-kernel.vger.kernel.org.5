Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E81277F7C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351490AbjHQNbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351518AbjHQNa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:30:56 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCA626B7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:30:30 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9aa1d3029so119514281fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692279028; x=1692883828;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mdsM2oTBK6JwOUfDT8eQud/HNhMQh59h+NrcC2uv04=;
        b=xyiHgLhOGT0eA/twbpDbHpTXZTiRfEq4iQnsqJI6jqPRDlECTn6jEbpxZsiNXaDBP/
         XzG65jAQAsypqzgoX/lfmHvRHZwcJWIdjWQbWlUI8ph1H4/gIW8dgGQWbgMtMwcQVOUN
         emfFcUJQOJccYFeMvtziBgs8MNxhgmE1r8glLRgs77dN5TCBfWXOy2F1k+dFAmr/F1nu
         VhYNWZa82zhSkx4Tc3YE0asHBYpI+U0csizzwp8PhEAiZzsuPACpd32OdrYVWxubGUYX
         iULaMHb1ge+DkG5RSfti1uw3lQ4RucJt4RjZ6lvOuVqTZuXEcwiFUMcOEo/YJHRrTzwb
         cUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692279028; x=1692883828;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mdsM2oTBK6JwOUfDT8eQud/HNhMQh59h+NrcC2uv04=;
        b=DxZk4Ya960TV2OufFp8FywYh7gVbs82l4aO0+KbGc6Xa1k2jle5Bls6o6ubXZUp/kC
         IUv+iyB/LDEGhnsTH/j9s+hMWCjsH3DqWlZ6GlCspVyhcCEGu+y0Pqm8/4FVNC8d8Gak
         KG1giPhBDIhqf6jCpZdglfOtRM61S2qx5gE/crMwVGaGYS+o2016Le3W1HYtA1PB0aZj
         t/s7W5wPa4/hz3iEhujRD+1fWKQF9nbFm7zu0MXb+Uaxe17LkkEF96iKm9CEICPNw/hD
         s6Cnss/JAq8ERf/7QSZFz79BFk8VdjEVI0dQMwELEYz+Rq3IyBeX6E6c7Oat3RM8l9GV
         TgyQ==
X-Gm-Message-State: AOJu0YyCznROx6/j+ST9kIXqFwqKdp2/b9qrawfivpYmjvdb3XevK/8K
        RaRCCzvrl0BHgyzr3XHPKUvBaQ==
X-Google-Smtp-Source: AGHT+IEYnpQSnBJ1Eq6Rlg/01iPWGoY2TquJN2t/26s2G2NC6QbAzjm0QtygB5LDyBMgkTzmpq9Eag==
X-Received: by 2002:a2e:b04a:0:b0:2b9:f1ad:94f5 with SMTP id d10-20020a2eb04a000000b002b9f1ad94f5mr3870619ljl.40.1692279028565;
        Thu, 17 Aug 2023 06:30:28 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id z22-20020a05651c023600b002b9de06f119sm3941689ljn.67.2023.08.17.06.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 06:30:27 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Aug 2023 15:30:15 +0200
Subject: [PATCH 1/5] ASoC: rt5640: Convert to just use GPIO descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230817-descriptors-asoc-rt-v1-1-434f5f177cee@linaro.org>
References: <20230817-descriptors-asoc-rt-v1-0-434f5f177cee@linaro.org>
In-Reply-To: <20230817-descriptors-asoc-rt-v1-0-434f5f177cee@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RT5640 driver is already using GPIO descriptors for some
stuff, all that is needed is to convert the remaining LDO1
control line to also use descriptors.

Simplify the code using gpiod_get_optional() and drop the
special "of" parsing function: these descriptors need not
come from device tree and it's optional so hey.

Keep some NULL checks around the GPIO operations even though
gpiolib is essentially NULL-tolerant, because by checking
for whether we have a valid GPIO descriptor or not we can
avoid a 400 ms delay which is great.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/rt5640.c | 55 +++++++++++++----------------------------------
 sound/soc/codecs/rt5640.h |  2 +-
 2 files changed, 16 insertions(+), 41 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 0ed4fa261abf..33a6d545a9db 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -12,11 +12,10 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/acpi.h>
@@ -2811,8 +2810,8 @@ static int rt5640_suspend(struct snd_soc_component *component)
 	rt5640_reset(component);
 	regcache_cache_only(rt5640->regmap, true);
 	regcache_mark_dirty(rt5640->regmap);
-	if (gpio_is_valid(rt5640->ldo1_en))
-		gpio_set_value_cansleep(rt5640->ldo1_en, 0);
+	if (rt5640->ldo1_en)
+		gpiod_set_value_cansleep(rt5640->ldo1_en, 0);
 
 	return 0;
 }
@@ -2821,8 +2820,8 @@ static int rt5640_resume(struct snd_soc_component *component)
 {
 	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 
-	if (gpio_is_valid(rt5640->ldo1_en)) {
-		gpio_set_value_cansleep(rt5640->ldo1_en, 1);
+	if (rt5640->ldo1_en) {
+		gpiod_set_value_cansleep(rt5640->ldo1_en, 1);
 		msleep(400);
 	}
 
@@ -2985,22 +2984,6 @@ static const struct acpi_device_id rt5640_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rt5640_acpi_match);
 #endif
 
-static int rt5640_parse_dt(struct rt5640_priv *rt5640, struct device_node *np)
-{
-	rt5640->ldo1_en = of_get_named_gpio(np, "realtek,ldo1-en-gpios", 0);
-	/*
-	 * LDO1_EN is optional (it may be statically tied on the board).
-	 * -ENOENT means that the property doesn't exist, i.e. there is no
-	 * GPIO, so is not an error. Any other error code means the property
-	 * exists, but could not be parsed.
-	 */
-	if (!gpio_is_valid(rt5640->ldo1_en) &&
-			(rt5640->ldo1_en != -ENOENT))
-		return rt5640->ldo1_en;
-
-	return 0;
-}
-
 static int rt5640_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5640_priv *rt5640;
@@ -3014,12 +2997,16 @@ static int rt5640_i2c_probe(struct i2c_client *i2c)
 		return -ENOMEM;
 	i2c_set_clientdata(i2c, rt5640);
 
-	if (i2c->dev.of_node) {
-		ret = rt5640_parse_dt(rt5640, i2c->dev.of_node);
-		if (ret)
-			return ret;
-	} else
-		rt5640->ldo1_en = -EINVAL;
+	rt5640->ldo1_en = devm_gpiod_get_optional(&i2c->dev,
+						  "realtek,ldo1-en",
+						  GPIOD_OUT_HIGH);
+	if (IS_ERR(rt5640->ldo1_en))
+		return PTR_ERR(rt5640->ldo1_en);
+
+	if (rt5640->ldo1_en) {
+		gpiod_set_consumer_name(rt5640->ldo1_en, "RT5640 LDO1_EN");
+		msleep(400);
+	}
 
 	rt5640->regmap = devm_regmap_init_i2c(i2c, &rt5640_regmap);
 	if (IS_ERR(rt5640->regmap)) {
@@ -3029,18 +3016,6 @@ static int rt5640_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
-	if (gpio_is_valid(rt5640->ldo1_en)) {
-		ret = devm_gpio_request_one(&i2c->dev, rt5640->ldo1_en,
-					    GPIOF_OUT_INIT_HIGH,
-					    "RT5640 LDO1_EN");
-		if (ret < 0) {
-			dev_err(&i2c->dev, "Failed to request LDO1_EN %d: %d\n",
-				rt5640->ldo1_en, ret);
-			return ret;
-		}
-		msleep(400);
-	}
-
 	regmap_read(rt5640->regmap, RT5640_VENDOR_ID2, &val);
 	if (val != RT5640_DEVICE_ID) {
 		dev_err(&i2c->dev,
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index 9847a1ae01f4..94b9a502f7f9 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -2138,7 +2138,7 @@ struct rt5640_priv {
 	struct regmap *regmap;
 	struct clk *mclk;
 
-	int ldo1_en; /* GPIO for LDO1_EN */
+	struct gpio_desc *ldo1_en; /* GPIO for LDO1_EN */
 	int irq;
 	int jd_gpio_irq;
 	int sysclk;

-- 
2.34.1

