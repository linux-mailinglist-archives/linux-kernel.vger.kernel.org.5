Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41D477F848
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351685AbjHQOES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351672AbjHQODo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:03:44 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B16358A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:03:34 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b703a0453fso119157821fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692281013; x=1692885813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVRGKrIqK8zdIPLjLE/8ZwUbdMywu2KHkrv9/v0NkSo=;
        b=oioclo5JM2Z8IQ//cUwFPPQ37qFbQD2VKB4e+vIUFHeDvjfiQwtwWq+AOjZ/raQCf+
         z354ZE7/AFnzPICOq6EWUTqvVSc6x2yVVauyV5h+XVXEkvKAosCUJMnksLP6EvPm3xn3
         NxZ9q1HxjiEYesrw416DCagvdKhMBPua+iPIithASgflIyKuKgq5mMa4uu+Xsy8R+tHT
         sboGbYN+DOvBat7iQn8q2qNXzFJJ/dGa4bbWMj1NjGI1XOomH0nynE+a0ROaJskQTA1H
         NyMWbIgVPJNAFEETbzoFRERS4Oc2pWUsRY3JTQ6Zhs0zW2c4xz+GC8xxejNuZhlfRGdK
         ZSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692281013; x=1692885813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVRGKrIqK8zdIPLjLE/8ZwUbdMywu2KHkrv9/v0NkSo=;
        b=VWSai0oF50715PfnB/JvdoAYijfSjycjANPn+2lcM3JIXhFzmWyE7bNAXa+PqIC1M+
         QHZOC2/2gPQnG//uZUAECtBCW5jJODNPCJMU3LrilvbkCtjKkz4hkDS+pZ7mcYACElfy
         pBYi1b9cNbltiJTwrTcsC5s0ahW8cXZ2kFzCM4H2VEKY6jgZXe/XhiL7cvXh0geqMJUH
         oKkaEXhEOv/t/iPnSwA8k6oK87pZ7ed3pjSKZO1xABIY3PFFSkBRBaIDBeq2RyT4pb9Y
         fsebQWY5ZxpBBBfPcQ3aop9+5r4Lf8iiPaVszq/xE0twohLnnVWvRwkGgiimlIjlzwqC
         Qnzg==
X-Gm-Message-State: AOJu0Yy96IoWgcSVzG7GIwGdtTDbEYDF17rCszlJfXy54yUlbbsSZ1Sc
        gZ9dk76adHaxcqegOvWm/3p2JQ==
X-Google-Smtp-Source: AGHT+IHt8slVZzlqM+67wFP56al0ESEwXNkqY3msrUtb07eUTGraVFPwWUsEKyiz1+fXP8sgs7X0hg==
X-Received: by 2002:a05:651c:203:b0:2b9:575e:5298 with SMTP id y3-20020a05651c020300b002b9575e5298mr4236590ljn.13.1692281013057;
        Thu, 17 Aug 2023 07:03:33 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id g3-20020a2eb0c3000000b002b9c3e18095sm4064645ljl.14.2023.08.17.07.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:03:32 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Aug 2023 16:03:21 +0200
Subject: [PATCH v2 5/5] ASoC: rt5682s: Convert to use GPIO descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230817-descriptors-asoc-rt-v2-5-02fa2ca3e5b0@linaro.org>
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

Convert the RT5682S to use GPIO descriptors and drop the
legacy GPIO headers.

We remove the global GPIO number from the platform data,
but it is still possible to create board files using GPIO
descriptor tables, if desired.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/sound/rt5682s.h    |  3 ---
 sound/soc/codecs/rt5682s.c | 16 +++++++---------
 sound/soc/codecs/rt5682s.h |  2 ++
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/sound/rt5682s.h b/include/sound/rt5682s.h
index f18d91308b9a..66ca0c75b914 100644
--- a/include/sound/rt5682s.h
+++ b/include/sound/rt5682s.h
@@ -32,9 +32,6 @@ enum rt5682s_dai_clks {
 };
 
 struct rt5682s_platform_data {
-
-	int ldo1_en; /* GPIO for LDO1_EN */
-
 	enum rt5682s_dmic1_data_pin dmic1_data_pin;
 	enum rt5682s_dmic1_clk_pin dmic1_clk_pin;
 	enum rt5682s_jd_src jd_src;
diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index c77c675bd5f5..68ac5ea50396 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
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
@@ -2973,9 +2972,6 @@ static int rt5682s_parse_dt(struct rt5682s_priv *rt5682s, struct device *dev)
 	device_property_read_u32(dev, "realtek,amic-delay-ms",
 		&rt5682s->pdata.amic_delay);
 
-	rt5682s->pdata.ldo1_en = of_get_named_gpio(dev->of_node,
-		"realtek,ldo1-en-gpios", 0);
-
 	if (device_property_read_string_array(dev, "clock-output-names",
 					      rt5682s->pdata.dai_clk_names,
 					      RT5682S_DAI_NUM_CLKS) < 0)
@@ -3172,10 +3168,12 @@ static int rt5682s_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
-	if (gpio_is_valid(rt5682s->pdata.ldo1_en)) {
-		if (devm_gpio_request_one(&i2c->dev, rt5682s->pdata.ldo1_en,
-					  GPIOF_OUT_INIT_HIGH, "rt5682s"))
-			dev_err(&i2c->dev, "Fail gpio_request gpio_ldo\n");
+	rt5682s->ldo1_en = devm_gpiod_get_optional(&i2c->dev,
+						   "realtek,ldo1-en",
+						   GPIOD_OUT_HIGH);
+	if (IS_ERR(rt5682s->ldo1_en)) {
+		dev_err(&i2c->dev, "Fail gpio request ldo1_en\n");
+		return PTR_ERR(rt5682s->ldo1_en);
 	}
 
 	/* Sleep for 50 ms minimum */
diff --git a/sound/soc/codecs/rt5682s.h b/sound/soc/codecs/rt5682s.h
index caa7733b430f..1d79d432d0d8 100644
--- a/sound/soc/codecs/rt5682s.h
+++ b/sound/soc/codecs/rt5682s.h
@@ -11,6 +11,7 @@
 
 #include <sound/rt5682s.h>
 #include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
@@ -1446,6 +1447,7 @@ enum {
 struct rt5682s_priv {
 	struct snd_soc_component *component;
 	struct rt5682s_platform_data pdata;
+	struct gpio_desc *ldo1_en;
 	struct regmap *regmap;
 	struct snd_soc_jack *hs_jack;
 	struct regulator_bulk_data supplies[RT5682S_NUM_SUPPLIES];

-- 
2.34.1

