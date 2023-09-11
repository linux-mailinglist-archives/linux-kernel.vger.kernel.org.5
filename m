Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0504B79BDE5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358545AbjIKWLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbjIKIX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:23:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4370618D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:23:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-502b1bbe5c3so1961387e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694420630; x=1695025430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+8MTCJJPEn/JGBNuu906jziHv3DlZsxUiatrimUoug=;
        b=zdOr+da2+Y/aYSuIr42gW1N0c188zGDemgWKrDbKSawpkLKCoXoQ3s/ulGlmhhmW9A
         kvGU00vVrPLekvoZCcggVbbNlcuJPbFLI6nh9I+MT/i0Aobj7KeZ6cMcSlNHQ3h0wnwJ
         hrxPmgfamUCVbr5i9EXC6RU9cZyUKsrysdzC1UKMAzo9kFkbQdVAt2ypDicKaYAV+BzC
         zL17CbrSSb7rZhulYuJsBf/vXyg9IJFjsv1IIKv+K+jdOWVgbPuZhbR7fjTIj87JsIPX
         bi771YGfW5X+a2iQZjou7WU8dWJBKjIZe05QzflvVTQgmk3MXxk8ITqQ7ad4f3B8ZBDm
         luKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694420630; x=1695025430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+8MTCJJPEn/JGBNuu906jziHv3DlZsxUiatrimUoug=;
        b=JxuauutDI0gCMnPh6BKMGX4RE2mJT9zDkl9Vm1Rf7ZLSe7hBXIfJ5+YLQ/crchj8PN
         yQr0D+kpxODxb95hO2TopwOCP3n7qTZmrbd6YrtfCJi1NZ3o7KSMfhztZ+wjM6/Iq3UA
         eX7nuKABENrqcxrIbLB9zDMrGeTp9ZGsS8aqhx1Suh+EnAcBdXeG+gJIGI5PM/n/woy8
         i8AmL0EDy6snUO5iXzE3jX8achGEWsPVwCrZv2IP/thr1tyMh7/wfT+yLaJe4kNRvpnN
         Rf0CwBEsgo3Ph2671XveLwN0aW/4ByK9ZyVXyZV7V1gMskgmyzBPVfOPNYtgxsjJzLmb
         fgYw==
X-Gm-Message-State: AOJu0YxHqNuTVPhALZKX/TvKz3DTzImvvRsHqeqeWzUPQWbF0noUCO1W
        hdmfGXzYO2CzNJIK6oaYO6CFkA==
X-Google-Smtp-Source: AGHT+IH2r7bEFi9jxVEwNGLaxc6z7Q9adp/d/GtZ3BsKXID0oUG7bLJPmPTXt/XXRsoZ48ICBEYqow==
X-Received: by 2002:a05:6512:1185:b0:4f8:5cde:a44f with SMTP id g5-20020a056512118500b004f85cdea44fmr5691530lfr.10.1694420630585;
        Mon, 11 Sep 2023 01:23:50 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b00500968ddca9sm1247712lff.136.2023.09.11.01.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 01:23:50 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Sep 2023 10:23:48 +0200
Subject: [PATCH v2 1/7] ASoC: max9768: Convert to use GPIO descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-descriptors-asoc-max-v2-1-b9d793fb768e@linaro.org>
References: <20230911-descriptors-asoc-max-v2-0-b9d793fb768e@linaro.org>
In-Reply-To: <20230911-descriptors-asoc-max-v2-0-b9d793fb768e@linaro.org>
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

The MAX9768 is pretty straight forward to convert to GPIO
descriptors.

To name the GPIO properties, I looke at the bindings in
maxim,max9759.yaml which names these GPIO "mute" and
"shutdown" respectively.

No board files using platform data exist in the kernel, new
users can use GPIO descriptor tables if desired.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/sound/max9768.h    |  4 ----
 sound/soc/codecs/max9768.c | 45 +++++++++++++++++++++++----------------------
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/include/sound/max9768.h b/include/sound/max9768.h
index 0f78b41d030e..8509ba0079b0 100644
--- a/include/sound/max9768.h
+++ b/include/sound/max9768.h
@@ -9,14 +9,10 @@
 
 /**
  * struct max9768_pdata - optional platform specific MAX9768 configuration
- * @shdn_gpio:	GPIO to SHDN pin. If not valid, pin must be hardwired HIGH
- * @mute_gpio:	GPIO to MUTE pin. If not valid, control for mute won't be added
  * @flags: configuration flags, e.g. set classic PWM mode (check datasheet
  *         regarding "filterless modulation" which is default).
  */
 struct max9768_pdata {
-	int shdn_gpio;
-	int mute_gpio;
 	unsigned flags;
 #define MAX9768_FLAG_CLASSIC_PWM	(1 << 0)
 };
diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index d22b4ba51ed8..8d0ca1be99c0 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -9,7 +9,7 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regmap.h>
 
 #include <sound/core.h>
@@ -27,8 +27,8 @@
 
 struct max9768 {
 	struct regmap *regmap;
-	int mute_gpio;
-	int shdn_gpio;
+	struct gpio_desc *mute;
+	struct gpio_desc *shdn;
 	u32 flags;
 };
 
@@ -42,7 +42,7 @@ static int max9768_get_gpio(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *c = snd_soc_kcontrol_component(kcontrol);
 	struct max9768 *max9768 = snd_soc_component_get_drvdata(c);
-	int val = gpio_get_value_cansleep(max9768->mute_gpio);
+	int val = gpiod_get_value_cansleep(max9768->mute);
 
 	ucontrol->value.integer.value[0] = !val;
 
@@ -55,7 +55,7 @@ static int max9768_set_gpio(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *c = snd_soc_kcontrol_component(kcontrol);
 	struct max9768 *max9768 = snd_soc_component_get_drvdata(c);
 
-	gpio_set_value_cansleep(max9768->mute_gpio, !ucontrol->value.integer.value[0]);
+	gpiod_set_value_cansleep(max9768->mute, !ucontrol->value.integer.value[0]);
 
 	return 0;
 }
@@ -138,7 +138,7 @@ static int max9768_probe(struct snd_soc_component *component)
 			return ret;
 	}
 
-	if (gpio_is_valid(max9768->mute_gpio)) {
+	if (max9768->mute) {
 		ret = snd_soc_add_component_controls(component, max9768_mute,
 				ARRAY_SIZE(max9768_mute));
 		if (ret)
@@ -171,28 +171,29 @@ static int max9768_i2c_probe(struct i2c_client *client)
 {
 	struct max9768 *max9768;
 	struct max9768_pdata *pdata = client->dev.platform_data;
-	int err;
 
 	max9768 = devm_kzalloc(&client->dev, sizeof(*max9768), GFP_KERNEL);
 	if (!max9768)
 		return -ENOMEM;
 
-	if (pdata) {
-		/* Mute on powerup to avoid clicks */
-		err = devm_gpio_request_one(&client->dev, pdata->mute_gpio,
-				GPIOF_INIT_HIGH, "MAX9768 Mute");
-		max9768->mute_gpio = err ?: pdata->mute_gpio;
-
-		/* Activate chip by releasing shutdown, enables I2C */
-		err = devm_gpio_request_one(&client->dev, pdata->shdn_gpio,
-				GPIOF_INIT_HIGH, "MAX9768 Shutdown");
-		max9768->shdn_gpio = err ?: pdata->shdn_gpio;
-
+	/* Mute on powerup to avoid clicks */
+	max9768->mute = devm_gpiod_get_optional(&client->dev,
+						"mute",
+						GPIOD_OUT_HIGH);
+	if (IS_ERR(max9768->mute))
+		return PTR_ERR(max9768->mute);
+	gpiod_set_consumer_name(max9768->mute, "MAX9768 Mute");
+
+	/* Activate chip by releasing shutdown, enables I2C */
+	max9768->shdn = devm_gpiod_get_optional(&client->dev,
+						"shutdown",
+						GPIOD_OUT_HIGH);
+	if (IS_ERR(max9768->shdn))
+		return PTR_ERR(max9768->shdn);
+	gpiod_set_consumer_name(max9768->shdn, "MAX9768 Shutdown");
+
+	if (pdata)
 		max9768->flags = pdata->flags;
-	} else {
-		max9768->shdn_gpio = -EINVAL;
-		max9768->mute_gpio = -EINVAL;
-	}
 
 	i2c_set_clientdata(client, max9768);
 

-- 
2.34.1

