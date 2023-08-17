Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B122877F7C2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351503AbjHQNbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351524AbjHQNa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:30:57 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6EF30EE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:30:34 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9cf2b1309so11357251fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692279032; x=1692883832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+h0kp+qECVIOMn9Oo5xgS+pDCE42HhSV126thTQIzU=;
        b=l3iRKNCHo/fyL5y1z0db0vfiYid5rb+joqYm4lOtvNZ3lti1/3tPHp2WiXD9pLg4pt
         8cmZweJo57amPfe1MlggPhUnmD0lX/mL0v+cr7p0eg7GzikWtAlJhHN6amlS8yR2nE1z
         Ljuv/JNz7Lz8OY9jsPSzrBSKfPPTkLGnvplta9uHMtwwnG5X9hUmpCYRdrA+5No4MauE
         fpDSNc1YbploKHfZdvg7pv2IglGKMvmfgx/QVVsy9A1dYF8bTKtUjUTYI2dyy0Gj2c4J
         c6uGfCS/TWGGYKIm2bBs8FKz3mti531RcMVwvmFeDS6ALloQ8fMuKp0+c0xVtTKJBEPB
         5SaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692279032; x=1692883832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+h0kp+qECVIOMn9Oo5xgS+pDCE42HhSV126thTQIzU=;
        b=fS94XkdIYqKzyQnNAgJNjQ90RHyfGo7TgQcf1Vt1Gllo5/85FWPmZNMy5KbKSsXPfE
         Jt/7r0HI7049pxF76yBoS4m6+ZOe2D4aAN7p6V/KQchMbkw3mRP1fuLfIwGGZPb/evmQ
         aBuGX1Y5gum3uA4Mr/2ujFibdcaXhB26F7DGZiCc5jjHe7zBWzc7G3xlyc/NZY37p5Rs
         bv08dnb3qUPF10iuM4SCriUlqbCcjeHQe5aagZQztK5i8lK4d7uopsgN/uQVvF+wGbfP
         QtDtGVqStIHucNZ9cHGNy7g3lGsQfkcnPwP84so74wUGATT+Y9VL6mvNXbYpQnluTuBO
         LFpg==
X-Gm-Message-State: AOJu0YxC9vCD+Ma1r1hfl9oSnFbraLZ5J2OxjiAIWOWtxGLGgGEh9JwQ
        oRNyrrhqqRSgyZoP8oSvQVRvKQ==
X-Google-Smtp-Source: AGHT+IEICClpddwtMaBX0Xc4WRIyeh1kbiYwKR7liLC6K4B+ot8zozmNMIN4MsWmxle0NpFaoCf6cQ==
X-Received: by 2002:a05:651c:c91:b0:2bb:7710:f08 with SMTP id bz17-20020a05651c0c9100b002bb77100f08mr1329719ljb.3.1692279032590;
        Thu, 17 Aug 2023 06:30:32 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id z22-20020a05651c023600b002b9de06f119sm3941689ljn.67.2023.08.17.06.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 06:30:31 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Aug 2023 15:30:18 +0200
Subject: [PATCH 4/5] ASoC: rt5682: Convert to use GPIO descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230817-descriptors-asoc-rt-v1-4-434f5f177cee@linaro.org>
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

Convert the RT5682 to use GPIO descriptors and drop the
legacy GPIO headers.

We remove the global GPIO number from the platform data,
but it is still possible to create board files using GPIO
descriptor tables, if desired.

Make sure to make sure SDW devices can associate with
an LDO1 EN descriptor too, if they so desire by putting
the lookup into the common code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/sound/rt5682.h        |  3 ---
 sound/soc/codecs/rt5682-i2c.c | 11 ++++-------
 sound/soc/codecs/rt5682-sdw.c |  4 ++++
 sound/soc/codecs/rt5682.c     | 20 +++++++++++++++-----
 sound/soc/codecs/rt5682.h     |  3 +++
 5 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/include/sound/rt5682.h b/include/sound/rt5682.h
index 3900a07e3935..4256df721e3a 100644
--- a/include/sound/rt5682.h
+++ b/include/sound/rt5682.h
@@ -31,9 +31,6 @@ enum rt5682_dai_clks {
 };
 
 struct rt5682_platform_data {
-
-	int ldo1_en; /* GPIO for LDO1_EN */
-
 	enum rt5682_dmic1_data_pin dmic1_data_pin;
 	enum rt5682_dmic1_clk_pin dmic1_clk_pin;
 	enum rt5682_jd_src jd_src;
diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index fb8ffb5b2ff6..b05b4f73d8aa 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -15,8 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/acpi.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mutex.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -170,11 +169,9 @@ static int rt5682_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
-	if (gpio_is_valid(rt5682->pdata.ldo1_en)) {
-		if (devm_gpio_request_one(&i2c->dev, rt5682->pdata.ldo1_en,
-					  GPIOF_OUT_INIT_HIGH, "rt5682"))
-			dev_err(&i2c->dev, "Fail gpio_request gpio_ldo\n");
-	}
+	ret = rt5682_get_ldo1(rt5682, &i2c->dev);
+	if (ret)
+		return ret;
 
 	/* Sleep for 300 ms miniumum */
 	usleep_range(300000, 350000);
diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index 3d13ea74b074..0f604ed0ba1a 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -320,6 +320,10 @@ static int rt5682_sdw_init(struct device *dev, struct regmap *regmap,
 		return ret;
 	}
 
+	ret = rt5682_get_ldo1(rt5682, dev);
+	if (ret)
+		return ret;
+
 	/*
 	 * Mark hw_init to false
 	 * HW init will be performed when device reports present
diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 5d992543b791..62b4d353e865 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -15,8 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/acpi.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mutex.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -3091,9 +3090,6 @@ int rt5682_parse_dt(struct rt5682_priv *rt5682, struct device *dev)
 	device_property_read_u32(dev, "realtek,dmic-delay-ms",
 		&rt5682->pdata.dmic_delay);
 
-	rt5682->pdata.ldo1_en = of_get_named_gpio(dev->of_node,
-		"realtek,ldo1-en-gpios", 0);
-
 	if (device_property_read_string_array(dev, "clock-output-names",
 					      rt5682->pdata.dai_clk_names,
 					      RT5682_DAI_NUM_CLKS) < 0)
@@ -3108,6 +3104,20 @@ int rt5682_parse_dt(struct rt5682_priv *rt5682, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(rt5682_parse_dt);
 
+int rt5682_get_ldo1(struct rt5682_priv *rt5682, struct device *dev)
+{
+	rt5682->ldo1_en = devm_gpiod_get_optional(dev,
+						  "realtek,ldo1-en",
+						  GPIOD_OUT_HIGH);
+	if (IS_ERR(rt5682->ldo1_en)) {
+		dev_err(dev, "Fail gpio request ldo1_en\n");
+		return PTR_ERR(rt5682->ldo1_en);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rt5682_get_ldo1);
+
 void rt5682_calibrate(struct rt5682_priv *rt5682)
 {
 	int value, count;
diff --git a/sound/soc/codecs/rt5682.h b/sound/soc/codecs/rt5682.h
index 1a43d595f341..b2d9e87af259 100644
--- a/sound/soc/codecs/rt5682.h
+++ b/sound/soc/codecs/rt5682.h
@@ -11,6 +11,7 @@
 
 #include <sound/rt5682.h>
 #include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
@@ -1430,6 +1431,7 @@ struct rt5682_priv {
 	struct snd_soc_component *component;
 	struct device *i2c_dev;
 	struct rt5682_platform_data pdata;
+	struct gpio_desc *ldo1_en;
 	struct regmap *regmap;
 	struct regmap *sdw_regmap;
 	struct snd_soc_jack *hs_jack;
@@ -1481,6 +1483,7 @@ int rt5682_register_component(struct device *dev);
 void rt5682_calibrate(struct rt5682_priv *rt5682);
 void rt5682_reset(struct rt5682_priv *rt5682);
 int rt5682_parse_dt(struct rt5682_priv *rt5682, struct device *dev);
+int rt5682_get_ldo1(struct rt5682_priv *rt5682, struct device *dev);
 
 int rt5682_register_dai_clks(struct rt5682_priv *rt5682);
 

-- 
2.34.1

