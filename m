Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7657D77F7BE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351478AbjHQNbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351522AbjHQNa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:30:57 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD1230E1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:30:33 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b974031aeaso120816651fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692279031; x=1692883831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8CZiR3Xu/7M/67rXheXq6UmPj0XpjwcOmaMWEgamKE=;
        b=yDki6LM9i+qIBriM0siP4gm0m6lgEoRUE4r0QuVtdYVNCXuY/59crM8xRcx9tYCoIS
         wY+XE7xhsPko65uATsdQKdKuyhOibWuCcpS2n6IdzqehGTA7fdg5vmU/6zVTJrgoqN9J
         +W60qZz/H2kqL9Nc34WtTVIPyMeV8l/2vIyrGIrgkzNPugmytyVlf3eF2iGlVPQoB6WU
         kJeBP2PyxKWMG7YYVtQW4eOLDaSj7psCCoDeSX+HUBtP2ZJBApoiJxBSXc5nceWYOnbt
         565A8KdGvIBMDNLZhVuAyxo5H/Ed3FoQ3WqvgCW8y35jp9I5y+hvurf+xrdusMuoNIpV
         8sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692279031; x=1692883831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8CZiR3Xu/7M/67rXheXq6UmPj0XpjwcOmaMWEgamKE=;
        b=kQTKlhN6zijohCN6ddbRCr1a8oObGNKNkdRt4K372PJ7At452qwMyPPPBhED4X6Aio
         IiKeL0qjJBAXKUMGiduQkAd3A7WJORcsJS3c0s1jQuEmNbVFx80Yd2UzLCI1dXHAyVZy
         IYY1I/Prc8Nb869yZIb8UAq2kbznknIBlpPxJDbHD5h5psV9JlhYd5oDqjYKqtFX6IyY
         ekNRCmFAkVMYnfeGmm6sCmWyVKvMDB9YiwZl/9zG2SogzMozrklrN5TB8ft06a4mKTkD
         0oVgSQ/qq5nH/huKM3DGs8XGQ0luFQ28Vj7jjz84blt3f2oLqHGOaNpa1UUs5pKC9l+R
         66qQ==
X-Gm-Message-State: AOJu0Yz85kEAxyg4CV8DMT2hgCJkD1H3Mer5ZHTD0h/H10TEHlLZz+CF
        JY9nYMJv3RL0Ii48xUm0VHYNWA==
X-Google-Smtp-Source: AGHT+IGeE48HlRTtW96eQmBM/iq4mFm1r01zZ9fkv9Usp47iNIzhkqyXOenaleIaAC/pWfpbMAx+Lg==
X-Received: by 2002:a2e:80c7:0:b0:2b6:cbba:1307 with SMTP id r7-20020a2e80c7000000b002b6cbba1307mr4889203ljg.0.1692279031310;
        Thu, 17 Aug 2023 06:30:31 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id z22-20020a05651c023600b002b9de06f119sm3941689ljn.67.2023.08.17.06.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 06:30:30 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Aug 2023 15:30:17 +0200
Subject: [PATCH 3/5] ASoC: rt5668: Convert to use GPIO descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230817-descriptors-asoc-rt-v1-3-434f5f177cee@linaro.org>
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

Convert the RT5668 to use GPIO descriptors and drop the
legacy GPIO headers.

We remove the global GPIO number from the platform data,
but it is still possible to create board files using GPIO
descriptor tables, if desired.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/sound/rt5668.h    |  3 ---
 sound/soc/codecs/rt5668.c | 17 ++++++++---------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/sound/rt5668.h b/include/sound/rt5668.h
index 182edfbc9e7a..b682418c6cd6 100644
--- a/include/sound/rt5668.h
+++ b/include/sound/rt5668.h
@@ -25,9 +25,6 @@ enum rt5668_jd_src {
 };
 
 struct rt5668_platform_data {
-
-	int ldo1_en; /* GPIO for LDO1_EN */
-
 	enum rt5668_dmic1_data_pin dmic1_data_pin;
 	enum rt5668_dmic1_clk_pin dmic1_clk_pin;
 	enum rt5668_jd_src jd_src;
diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index f04c810fd710..4623b3e62487 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -15,8 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/acpi.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/mutex.h>
 #include <sound/core.h>
@@ -43,6 +42,7 @@ static const char *rt5668_supply_names[RT5668_NUM_SUPPLIES] = {
 struct rt5668_priv {
 	struct snd_soc_component *component;
 	struct rt5668_platform_data pdata;
+	struct gpio_desc *ldo1_en;
 	struct regmap *regmap;
 	struct snd_soc_jack *hs_jack;
 	struct regulator_bulk_data supplies[RT5668_NUM_SUPPLIES];
@@ -2393,9 +2393,6 @@ static int rt5668_parse_dt(struct rt5668_priv *rt5668, struct device *dev)
 	of_property_read_u32(dev->of_node, "realtek,jd-src",
 		&rt5668->pdata.jd_src);
 
-	rt5668->pdata.ldo1_en = of_get_named_gpio(dev->of_node,
-		"realtek,ldo1-en-gpios", 0);
-
 	return 0;
 }
 
@@ -2497,10 +2494,12 @@ static int rt5668_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
-	if (gpio_is_valid(rt5668->pdata.ldo1_en)) {
-		if (devm_gpio_request_one(&i2c->dev, rt5668->pdata.ldo1_en,
-					  GPIOF_OUT_INIT_HIGH, "rt5668"))
-			dev_err(&i2c->dev, "Fail gpio_request gpio_ldo\n");
+	rt5668->ldo1_en = devm_gpiod_get_optional(&i2c->dev,
+						  "realtek,ldo1-en",
+						  GPIOD_OUT_HIGH);
+	if (IS_ERR(rt5668->ldo1_en)) {
+		dev_err(&i2c->dev, "Fail gpio request ldo1_en\n");
+		return PTR_ERR(rt5668->ldo1_en);
 	}
 
 	/* Sleep for 300 ms miniumum */

-- 
2.34.1

