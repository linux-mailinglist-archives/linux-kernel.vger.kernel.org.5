Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF92C77F7BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351484AbjHQNbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351519AbjHQNa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:30:57 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D512230D1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:30:31 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9a828c920so117327141fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692279030; x=1692883830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNOoqMVm698nOhpI3ydE0vYc8DqBOEZTJiAOy8E0PkI=;
        b=hXyVKPh5fjO2uZcHvmnkc8OqWTqj28BFQCpbN+1dKi/RBkKIy985Dv0LpgHLICT0Pi
         NvP2707PROhIfew4VjATauxQnsHMUsMvtPBmqbBRFkA3nAJiyYf1ew21ouZM/krY4/lA
         OFn1aGBwNVOS+9fJkmCc1dSAVFsP/4cowovT3HGtHfbvq2JvqPzPqFUVut+U0nEDR9Ke
         KyGT4f0T2s8Pr5dHxCXnTXh8bvCHSvCUCCz63D79I0+v5nrsyow+Mf3VMtspEyCJeejB
         wFPEFypF8M+0dHrKeSjwCiOBF3KQdMW80droCb5YLMkeNVr2ukwyM4Ik4xwRf3WP8dhb
         jI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692279030; x=1692883830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNOoqMVm698nOhpI3ydE0vYc8DqBOEZTJiAOy8E0PkI=;
        b=d6AF2axOSKzGv6FIzdF87cnK8+I+0f2YyAr6149eH82wtjhQf6MWtlZBqUb/f/cVxf
         l9qTs4IFlBQXtXvKsOg3y9p8myo62ldoz3I7dxG86i+Gk0j/oV2BmjpfukFleQirOkZ0
         P5d6rnwhZDjYGLcV74uxjSFDBfmJLHzGwHMqw6KJUcGADoYp3u/7fCg4oFB0zze80UMb
         gv3HAvq0W1PZNyix6XMP97FG2AZ2KdA2aq74m4Cv8sGWG1wqTI8KDYDT0O6Q0VX4quah
         SrTY6OUInakbS5OgQZOOxDDc55Jv9VaPtycmSvB78FybkcRABS4RZeMesviUno/K+Zig
         VUOg==
X-Gm-Message-State: AOJu0YwfzKWWvLCriChWXesJm1M6B9EG15v2V2Q/B6xrBLuaDRrKChcl
        qD9dVYc4XIAMdCbDWwYUZterAw==
X-Google-Smtp-Source: AGHT+IGO/arhzSWJPDt9FPBED/DvM6kvsgmgPbfbFOHw19Yk69HSz44ihaJnswd3VeLBgmTbjECv4A==
X-Received: by 2002:a05:651c:1031:b0:2b6:df6b:84c0 with SMTP id w17-20020a05651c103100b002b6df6b84c0mr3985964ljm.25.1692279029964;
        Thu, 17 Aug 2023 06:30:29 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id z22-20020a05651c023600b002b9de06f119sm3941689ljn.67.2023.08.17.06.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 06:30:29 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Aug 2023 15:30:16 +0200
Subject: [PATCH 2/5] ASoC: rt5665: Convert to use GPIO descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230817-descriptors-asoc-rt-v1-2-434f5f177cee@linaro.org>
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

The RT5665 driver has some stub support for GPIO descriptors
going back to the initial driver commit, where there are
two GPIO descriptors for the LDO and headphone detection
defined in the device state. Well, let's make use of the
descriptor properly.

We remove the global GPIO number from the platform data,
but it is still possible to create board files using GPIO
descriptor tables, if desired.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/sound/rt5665.h    |  2 --
 sound/soc/codecs/rt5665.c | 17 ++++++++---------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/sound/rt5665.h b/include/sound/rt5665.h
index 3b3d6a19ca49..e865f041929b 100644
--- a/include/sound/rt5665.h
+++ b/include/sound/rt5665.h
@@ -31,8 +31,6 @@ struct rt5665_platform_data {
 	bool in3_diff;
 	bool in4_diff;
 
-	int ldo1_en; /* GPIO for LDO1_EN */
-
 	enum rt5665_dmic1_data_pin dmic1_data_pin;
 	enum rt5665_dmic2_data_pin dmic2_data_pin;
 	enum rt5665_jd_src jd_src;
diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 83c367af91da..cbc8069ab3a8 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
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
@@ -4657,9 +4656,6 @@ static int rt5665_parse_dt(struct rt5665_priv *rt5665, struct device *dev)
 	of_property_read_u32(dev->of_node, "realtek,jd-src",
 		&rt5665->pdata.jd_src);
 
-	rt5665->pdata.ldo1_en = of_get_named_gpio(dev->of_node,
-		"realtek,ldo1-en-gpios", 0);
-
 	return 0;
 }
 
@@ -4793,10 +4789,13 @@ static int rt5665_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
-	if (gpio_is_valid(rt5665->pdata.ldo1_en)) {
-		if (devm_gpio_request_one(&i2c->dev, rt5665->pdata.ldo1_en,
-					  GPIOF_OUT_INIT_HIGH, "rt5665"))
-			dev_err(&i2c->dev, "Fail gpio_request gpio_ldo\n");
+
+	rt5665->gpiod_ldo1_en = devm_gpiod_get_optional(&i2c->dev,
+							"realtek,ldo1-en",
+							GPIOD_OUT_HIGH);
+	if (IS_ERR(rt5665->gpiod_ldo1_en)) {
+		dev_err(&i2c->dev, "Failed gpio request ldo1_en\n");
+		return PTR_ERR(rt5665->gpiod_ldo1_en);
 	}
 
 	/* Sleep for 300 ms miniumum */

-- 
2.34.1

