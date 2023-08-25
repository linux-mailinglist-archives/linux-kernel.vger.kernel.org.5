Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49397881BB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243528AbjHYIMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243492AbjHYIMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:12:20 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6723D1FFF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:12:17 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so954466e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692951135; x=1693555935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBbRRSYAQA5xmq25ubQ8kHHlKCIWtZeRLr/sb85xuNU=;
        b=ZXicqbRubMjwCeZSDp32zGvSe2Cg8/FKjVonc3OsBRO2krXO9cvadTN+LEo+huL3zn
         OIhuzcmuZ3+DNGfyUWUCnuHFZT6ri6Nm07495TVslpIaSQ+NwKVr6zekLYT0PZSblQrs
         wagBfLfbz5NQpkh7nX06Io3lM54ZJt2f6MhCztCKdKx86JpxnpZlXLGy1+BQ1Im+EdaN
         AGZG/AsNNs0dYj56gsC/jkl6aRqlgLHWJ1hpp1h+Mfw6U8oU3wtq7mCeGrhqhOULtwHX
         1BxTwnLpJ71GxdGgkFs12MOHXaxOu6FTOzDbnJZI20sPRMcQu5+jN9t8fL8hzsj5adyJ
         pXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692951135; x=1693555935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBbRRSYAQA5xmq25ubQ8kHHlKCIWtZeRLr/sb85xuNU=;
        b=jEWlRoJXml/xE99ZaxxWw9KuD19jzcxtej2Me+AqgWc/NLYE7kVubk1J6E3R6bgDOP
         xQe5AZ1lD7nluGh/pB2i2z6/pTAIpnhEoDnuBkapuGSTNQEQPDK/5x4Jhonebx6L55ii
         TYqW7mVgQFEaflVqn6C6+OQVdyS0lNrbCA1ROT1Qs478N1AozictivU/9yiI8MVBHgCK
         TCOVVCJ00QiMtZ6mCocvIgFF+IuY8l9Xmlkiab3msVA15BzGbxRkn3FlDIReHhrvSyEc
         3wAgnsV2JIBI7Vs1xQ09OwSiLUT50cMNGmnUSKAQ+0yQs2Aucs9yQKNuhveECNHpe4VD
         2EZA==
X-Gm-Message-State: AOJu0Yx1TAqwykpUZahRBgJrYYnnGOBNpLEB6UccqEPoatXv8O+/xKJ/
        A6kdc81FKDKBkKEA/HJ5sXilIg==
X-Google-Smtp-Source: AGHT+IEPLIDpD1w1RF98YcjynCIXKHZQox8F22rws/cF0RMIh/cKJbjBBRiwjVgcU5sTSiS7K0f0rA==
X-Received: by 2002:a05:6512:615:b0:4fd:c923:db59 with SMTP id b21-20020a056512061500b004fdc923db59mr11392637lfe.15.1692951135669;
        Fri, 25 Aug 2023 01:12:15 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q28-20020ac2511c000000b004fe1a35fd15sm195559lfb.140.2023.08.25.01.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 01:12:15 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 25 Aug 2023 10:12:13 +0200
Subject: [PATCH 3/7] ASoC: max98373: Convert to use GPIO descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-descriptors-asoc-max-v1-3-b212292b2f08@linaro.org>
References: <20230825-descriptors-asoc-max-v1-0-b212292b2f08@linaro.org>
In-Reply-To: <20230825-descriptors-asoc-max-v1-0-b212292b2f08@linaro.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
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

Instead of relying on legacy interfaces, convert the driver to
use GPIO descriptors. This is a straight-forward conversion,
we support also sdw devices providing GPIO descriptor tables
if they so desire.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/max98373-i2c.c | 17 -----------------
 sound/soc/codecs/max98373.c     | 35 +++++++++++++++++++----------------
 sound/soc/codecs/max98373.h     |  2 +-
 3 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/max98373-i2c.c b/sound/soc/codecs/max98373-i2c.c
index 0fa5ceca62a2..e7ec7875c4a9 100644
--- a/sound/soc/codecs/max98373-i2c.c
+++ b/sound/soc/codecs/max98373-i2c.c
@@ -3,12 +3,10 @@
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -560,21 +558,6 @@ static int max98373_i2c_probe(struct i2c_client *i2c)
 	/* voltage/current slot & gpio configuration */
 	max98373_slot_config(&i2c->dev, max98373);
 
-	/* Power on device */
-	if (gpio_is_valid(max98373->reset_gpio)) {
-		ret = devm_gpio_request(&i2c->dev, max98373->reset_gpio,
-					"MAX98373_RESET");
-		if (ret) {
-			dev_err(&i2c->dev, "%s: Failed to request gpio %d\n",
-				__func__, max98373->reset_gpio);
-			return -EINVAL;
-		}
-		gpio_direction_output(max98373->reset_gpio, 0);
-		msleep(50);
-		gpio_direction_output(max98373->reset_gpio, 1);
-		msleep(20);
-	}
-
 	/* Check Revision ID */
 	ret = regmap_read(max98373->regmap,
 			  MAX98373_R21FF_REV_ID, &reg);
diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index fde055c6c894..33eb4576da23 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -12,9 +12,8 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <sound/tlv.h>
 #include "max98373.h"
 
@@ -478,20 +477,24 @@ void max98373_slot_config(struct device *dev,
 		max98373->i_slot = value & 0xF;
 	else
 		max98373->i_slot = 1;
-	if (dev->of_node) {
-		max98373->reset_gpio = of_get_named_gpio(dev->of_node,
-						"maxim,reset-gpio", 0);
-		if (!gpio_is_valid(max98373->reset_gpio)) {
-			dev_err(dev, "Looking up %s property in node %s failed %d\n",
-				"maxim,reset-gpio", dev->of_node->full_name,
-				max98373->reset_gpio);
-		} else {
-			dev_dbg(dev, "maxim,reset-gpio=%d",
-				max98373->reset_gpio);
-		}
-	} else {
-		/* this makes reset_gpio as invalid */
-		max98373->reset_gpio = -1;
+
+	/* This will assert RESET */
+	max98373->reset = devm_gpiod_get_optional(dev,
+						  "maxim,reset",
+						  GPIOD_OUT_HIGH);
+	if (IS_ERR(max98373->reset)) {
+		dev_err(dev, "error %ld looking up RESET GPIO line\n",
+			PTR_ERR(max98373->reset));
+		return;
+	}
+
+	/* Cycle reset */
+	if (max98373->reset) {
+		gpiod_set_consumer_name(max98373->reset ,"MAX98373_RESET");
+		gpiod_direction_output(max98373->reset, 1);
+		msleep(50);
+		gpiod_direction_output(max98373->reset, 0);
+		msleep(20);
 	}
 
 	if (!device_property_read_u32(dev, "maxim,spkfb-slot-no", &value))
diff --git a/sound/soc/codecs/max98373.h b/sound/soc/codecs/max98373.h
index e1810b3b1620..af3b62217497 100644
--- a/sound/soc/codecs/max98373.h
+++ b/sound/soc/codecs/max98373.h
@@ -213,7 +213,7 @@ struct max98373_cache {
 
 struct max98373_priv {
 	struct regmap *regmap;
-	int reset_gpio;
+	struct gpio_desc *reset;
 	unsigned int v_slot;
 	unsigned int i_slot;
 	unsigned int spkfb_slot;

-- 
2.34.1

