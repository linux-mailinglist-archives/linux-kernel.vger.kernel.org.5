Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7025477F847
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351679AbjHQOER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351663AbjHQODn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:03:43 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E5B10E6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:03:30 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9c0391749so124004211fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692281009; x=1692885809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=088USFovIsdoCEmzlnqhLgFZBLMNvUbAonAQf/mwAxw=;
        b=wRf+w2hVofU/IxEx6VHKnhqF/EYCqFXdyuaJFbKv7U3n8gNC3s046jZuHdCtATWzhp
         7U+8q70z10E91FBbXknUsa7BIRqpjTQ5hPd1GCS2pGrZlLyL6pz1pl+l0rFTBKED5yEf
         qNoaBvGX1VuQAEsKhM1euCnfrtZPVGfaXH0VkOCThH8yZk0p8wRgSyxXILk2cE4F/fBV
         Y0TbdJSMpiRgUQGkZqjNO1mW4Xh94qm3XAFCZ9ivTmkc6a2u74fEHaQmoR7b2S+YklNA
         k0jO1unCHxZqyc3/6nFonNc8eBLICRKLTzZbKav5rgosKv6v5VHO6y/pxuFFa9sEED1D
         xJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692281009; x=1692885809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=088USFovIsdoCEmzlnqhLgFZBLMNvUbAonAQf/mwAxw=;
        b=l638WTpy/SREBrMVMF5uN1wF/hYqBPw00RifB7YsY1v+/zmRLXRm3H2IsMjv/l37Ap
         IIOUv9uSLVhoMi+RU2Jb7mVa/RBJrgZKek4rAWCeKNg2k6U5SVfQuneKrr7wY6cbzeQe
         Dvz++Yn3e0tWFmVjpBHFz3TrRbASgOKM9D7hzJJh8GcanyWc+M2jBNTYWJlNQ5fPsjDU
         VW7sizXpvIJqKVjwobAiHnOsvTAlh8MDB/VKLY0ZxhM7V/h633iap8ceJYDyF9o9dEKc
         vyNs1MRuO2qRW07/oSZHpwR6zM0zfPIe5ylzPVDQnOJUBBTA11M4ChnC3T6FwiJhjGfg
         D0kA==
X-Gm-Message-State: AOJu0YyL3tftSFuXUBAIVW3i0U8YHyI9gPsEE0VjJyJINRZUsYJh1ykM
        VNSKg2msJXl3QoVbq1mPNfmzUA==
X-Google-Smtp-Source: AGHT+IG2Pux8VKOdbP86Oj7Mi6rjgF8/0qq8sb4PVwu1oDpFYcRedBksyLzRLMctv2SUuMjfYx1nQw==
X-Received: by 2002:a2e:9c99:0:b0:2b6:e618:b593 with SMTP id x25-20020a2e9c99000000b002b6e618b593mr4368277lji.31.1692281009055;
        Thu, 17 Aug 2023 07:03:29 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id g3-20020a2eb0c3000000b002b9c3e18095sm4064645ljl.14.2023.08.17.07.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:03:28 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Aug 2023 16:03:17 +0200
Subject: [PATCH v2 1/5] ASoC: rt5640: Convert to just use GPIO descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230817-descriptors-asoc-rt-v2-1-02fa2ca3e5b0@linaro.org>
References: <20230817-descriptors-asoc-rt-v2-0-02fa2ca3e5b0@linaro.org>
In-Reply-To: <20230817-descriptors-asoc-rt-v2-0-02fa2ca3e5b0@linaro.org>
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
index eceed8209787..8920726c38e8 100644
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
@@ -2812,8 +2811,8 @@ static int rt5640_suspend(struct snd_soc_component *component)
 	rt5640_reset(component);
 	regcache_cache_only(rt5640->regmap, true);
 	regcache_mark_dirty(rt5640->regmap);
-	if (gpio_is_valid(rt5640->ldo1_en))
-		gpio_set_value_cansleep(rt5640->ldo1_en, 0);
+	if (rt5640->ldo1_en)
+		gpiod_set_value_cansleep(rt5640->ldo1_en, 0);
 
 	return 0;
 }
@@ -2822,8 +2821,8 @@ static int rt5640_resume(struct snd_soc_component *component)
 {
 	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 
-	if (gpio_is_valid(rt5640->ldo1_en)) {
-		gpio_set_value_cansleep(rt5640->ldo1_en, 1);
+	if (rt5640->ldo1_en) {
+		gpiod_set_value_cansleep(rt5640->ldo1_en, 1);
 		msleep(400);
 	}
 
@@ -2986,22 +2985,6 @@ static const struct acpi_device_id rt5640_acpi_match[] = {
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
@@ -3015,12 +2998,16 @@ static int rt5640_i2c_probe(struct i2c_client *i2c)
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
@@ -3030,18 +3017,6 @@ static int rt5640_i2c_probe(struct i2c_client *i2c)
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

