Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD5E79C09E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354282AbjIKVxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbjIKIYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:24:01 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827851AE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:23:54 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bf6b37859eso42824191fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694420632; x=1695025432; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBbRRSYAQA5xmq25ubQ8kHHlKCIWtZeRLr/sb85xuNU=;
        b=P96L1DwRALMipzCmAmrjsw+0vvQD0bsjXOSKlPWzM7jf6rnYNzNuqj+aWicxDDIwf0
         CbPmX4alid7an5iAvDv5Z5Kp5DVHfD2PgZjatyuMLRPsluDMxkhsOJHpHlbzTxBReSsm
         YPSR+tWiY69kcD1Z/r3a7kOnH2I3p4Us6VG/7xoeKIAYkmvLak8xSXHgDkoR8ucR93Cp
         tMuMJKdsiDqflhtqhRvHr1djZHhBCk3U7TvV+O6FAMADH3GcBQMbA2J6bpW9ARxLCsDK
         Mon8c4uzj15dBBwwtf+zYjL1qn8P8q5AW/rAcs7ojbV1VJbhSv6c5YVIik9HsZNIkQQz
         tQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694420632; x=1695025432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBbRRSYAQA5xmq25ubQ8kHHlKCIWtZeRLr/sb85xuNU=;
        b=OTkvt77R258RUkzDJq2f8J839UTxIKM4gJddRuYZyyhdAB/1uNSQErBIs67udk6fd4
         xE+KCMTls0HLOVMvl+5zk0neJkEzGxqUe06gnbsxRuJ7bloe/BsWWjdixVA5wB1irBij
         EGBYJHOr0skmqI2ml+gypKP/6ONwhWIaIK4B2IdwZbMMivTT6+Cd7LLWu00n9f59nR+N
         K9MJ++ZPL+yIaBU4iCL2OHNt5kiK9ca8KTCB17aLIsyfXN612W8sXM6cdBK3akskHfjW
         UX9eO4txXhw8yRpCGdplWc9cip18maKziTo4lSnZM8oPqwCAeF0bRWgUrluonxfGDNxz
         9jZQ==
X-Gm-Message-State: AOJu0Yxo4vV4JD6OShEJCy1BhpWbSkax68gl/U3/NOOep1atXNB8KWKU
        /u+3gLxhkb+EjI5c7c8VnO1ZTw==
X-Google-Smtp-Source: AGHT+IE795z4MeyvcfiIIYPz/bYjnDK/11+Ubx+DKYPxh6E6lvf7/Sxx7I8bOqlaNVa5jarhNcJo9w==
X-Received: by 2002:a05:6512:398a:b0:4fd:d213:dfd4 with SMTP id j10-20020a056512398a00b004fdd213dfd4mr8795699lfu.20.1694420632485;
        Mon, 11 Sep 2023 01:23:52 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b00500968ddca9sm1247712lff.136.2023.09.11.01.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 01:23:52 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Sep 2023 10:23:50 +0200
Subject: [PATCH v2 3/7] ASoC: max98373: Convert to use GPIO descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-descriptors-asoc-max-v2-3-b9d793fb768e@linaro.org>
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

