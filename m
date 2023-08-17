Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F7277F849
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351695AbjHQOEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351671AbjHQODo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:03:44 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58A42D6D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:03:33 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso117337231fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692281012; x=1692885812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s8QnfXt14InmPur1jaC24sUVlinocDE8jpHSEWJ37+o=;
        b=TV6FCMvT/LoEqFsobincahfEyqStn0Fuyfn5b5hYbFZazgJ1W6IM9va0mjfgxXgRNM
         KFxVwj1TawdUco9eenFuTdc2QsFvm8H8JJjb8LAsrNemqAoRN/LTz/ArVsDkBPQouV5V
         dAjD1U6CLmgytPQuCwo11QMnTcdMgL6wke6WtIJf98Zw1iFq8MsdiwVLVX87SjChjsyl
         oURNiZrNDyXKkU2oeYC5S+RLAr/IexciJQah2Wib9DJyoqsrlxjWyy3SjIWQrJTptdQf
         jSNJe8GZ94Mmcm2lzrWmnyxkpKFclCsKozrp7v6ngM5I/GK6ySpZyupxAz3iTGCe7ub9
         fMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692281012; x=1692885812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8QnfXt14InmPur1jaC24sUVlinocDE8jpHSEWJ37+o=;
        b=Ci4aijMim0aOIpvZslWZG9ZE/yGNE2D4zNlP5qApcXl9FrvuwkNyAFHiBv0aj71/0A
         AaDiZ8Xux1P4fDe/GDOx8Bb7uIVVjIBVEC/EL+JYz4S1RQ7hFCL4gYwlPtB9uBSCMzVJ
         +BZylkAuN+q2XoQaOUoskjYh2U7vd7TZKdl7nQ/JzkZ4fnfKKa/nTYUjFhxi27WfuoAT
         e/82UU0QGI5e/Kagi4AiMT9t6+z2lE5ws11LX0MnjbwPnCXY5kd1nxemuLmYlflqKo8P
         C6PCP/ZgfZhvgQoWoh+REWyAJxdy6zC3nrVN7uzc2olhF7RwB0Sj/XdHtjqFzR6L8Ami
         vyiA==
X-Gm-Message-State: AOJu0YyfC/5V9uwpGsq4cTAFf6U4zcDlA/MDCHfVxp2Lb2zbM7OUa9aA
        gVD80rxqxPHzvqGkrA8bwsF9iwIXvRt/mZ00xF0=
X-Google-Smtp-Source: AGHT+IF5riaWQT2nv6OvAWzXDDhE1Yh2ZeIyZUsJE/SAjXNz/hCQGKh0HlxKGTYoYC1yTHp2FVoyGg==
X-Received: by 2002:a2e:8012:0:b0:2b9:df49:b818 with SMTP id j18-20020a2e8012000000b002b9df49b818mr4043578ljg.53.1692281012072;
        Thu, 17 Aug 2023 07:03:32 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id g3-20020a2eb0c3000000b002b9c3e18095sm4064645ljl.14.2023.08.17.07.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:03:31 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Aug 2023 16:03:20 +0200
Subject: [PATCH v2 4/5] ASoC: rt5682: Convert to use GPIO descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230817-descriptors-asoc-rt-v2-4-02fa2ca3e5b0@linaro.org>
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
 sound/soc/codecs/rt5682-sdw.c |  5 +++++
 sound/soc/codecs/rt5682.c     | 20 +++++++++++++++-----
 sound/soc/codecs/rt5682.h     |  3 +++
 5 files changed, 27 insertions(+), 15 deletions(-)

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
index 65e9c6dc1a54..e67c2e19cb1a 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -320,6 +320,11 @@ static int rt5682_sdw_init(struct device *dev, struct regmap *regmap,
 		return ret;
 	}
 
+
+	ret = rt5682_get_ldo1(rt5682, dev);
+	if (ret)
+		return ret;
+
 	regcache_cache_only(rt5682->sdw_regmap, true);
 	regcache_cache_only(rt5682->regmap, true);
 
diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 694c581070d9..e3aca9c785a0 100644
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
@@ -3094,9 +3093,6 @@ int rt5682_parse_dt(struct rt5682_priv *rt5682, struct device *dev)
 	device_property_read_u32(dev, "realtek,dmic-delay-ms",
 		&rt5682->pdata.dmic_delay);
 
-	rt5682->pdata.ldo1_en = of_get_named_gpio(dev->of_node,
-		"realtek,ldo1-en-gpios", 0);
-
 	if (device_property_read_string_array(dev, "clock-output-names",
 					      rt5682->pdata.dai_clk_names,
 					      RT5682_DAI_NUM_CLKS) < 0)
@@ -3111,6 +3107,20 @@ int rt5682_parse_dt(struct rt5682_priv *rt5682, struct device *dev)
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

