Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7331D7CC275
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343633AbjJQMHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343689AbjJQMGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:06:48 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F2410E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:28 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c51388ccebso38602041fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544325; x=1698149125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTp45qpeTF/+gPzHARMv2KmOGY0Alfi//g8E89OVTQM=;
        b=lnqIygFwxJPZDnH9pan8NDRztJbA2YqC1qs3fLsxb/tRKPzEuYWYGFf28qwvN+7w8w
         2ShK8I5u6DSNkkrx6NY95kvqO0e+yWU1J4fSKHyJ/KbBp+NwpU5bZk/+xC9Y76lxhHZw
         jRgLRrtuZEWyRXctqf5+noGpCFz4IE6uOVcOcxt5z5fAy1qjJg0fJ/s0TAIU903GWZOy
         qiTFhDq0FTNzDBCHv08/m/adH8eLXtaSM+fjBpbsFjydLoPmNGDjH9/X62sLubRBIU8f
         ueXeV+d6IKzBfmqVoZ7IAqPoi6uR6ceSLrrsM/OaSzwH2zFrik4O4ampCqid2liVUCB3
         TMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544325; x=1698149125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTp45qpeTF/+gPzHARMv2KmOGY0Alfi//g8E89OVTQM=;
        b=hMhrPinnju2A6pI+G4FhZZEGbFJF8LmZHPKp6b7bMhOeBiCiRjbG30UUayNQ9dVagI
         GwIpvzw7hRgFbnYmMuw3SrO54yEnD9IRaXTaxnuutrJBvv3+O5JEkneJMhyN2TfT5grB
         hVKGcObKUWk+pm7Xwm3Gmi52gdEqLGN0fHrkO+DshK+16uqy+uXTeQgwH0F4vQyT61t+
         KoZTpd8+g0OHeiOI6z550ehtHdd7/M/YIXZWbkUCEqy3dqZgSX61xZrilo5X3e+hksQs
         QRR8vZtVNqWL81PDqGooqLaHTEEcFlm8J3Uc+W5j0P6QAjbVvS7Idfh5VBdxtI7VDRXu
         rAEA==
X-Gm-Message-State: AOJu0YzZjiXcLhVYX/UfTJFQ6ofD5iiyAM+jasbVeblBQhUl5oetLjEa
        i2+20Eh+f4jCbYVRyl6pxodLJQ==
X-Google-Smtp-Source: AGHT+IGdoHFWz6qAcVFDGAMc7KnLo665dhnHhEtx9RUpTzfX4R2j7ZSCVSU8KKqG9zlUAWhnHQlB/Q==
X-Received: by 2002:a2e:7e0b:0:b0:2bc:efa4:2c32 with SMTP id z11-20020a2e7e0b000000b002bcefa42c32mr1383090ljc.37.1697544325140;
        Tue, 17 Oct 2023 05:05:25 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:24 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 38/73] pinctrl: remove pinctrl_gpio_free()
Date:   Tue, 17 Oct 2023 14:03:56 +0200
Message-Id: <20231017120431.68847-39-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are no more users of pinctrl_gpio_free() so remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/core.c           | 41 +++++++++++++-------------------
 include/linux/pinctrl/consumer.h |  5 ----
 2 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 46e5fe90718b..5a1414bfeacc 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -819,29 +819,6 @@ int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset)
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_request_new);
 
-/* This function is deprecated and will be removed. Don't use. */
-void pinctrl_gpio_free(unsigned gpio)
-{
-	struct pinctrl_dev *pctldev;
-	struct pinctrl_gpio_range *range;
-	int ret;
-	int pin;
-
-	ret = pinctrl_get_device_gpio_range(gpio, &pctldev, &range);
-	if (ret) {
-		return;
-	}
-	mutex_lock(&pctldev->mutex);
-
-	/* Convert to the pin controllers number space */
-	pin = gpio_to_pin(range, gpio);
-
-	pinmux_free_gpio(pctldev, pin, range);
-
-	mutex_unlock(&pctldev->mutex);
-}
-EXPORT_SYMBOL_GPL(pinctrl_gpio_free);
-
 /**
  * pinctrl_gpio_free_new() - free control on a single pin, currently used as GPIO
  * @gc: GPIO chip structure from the GPIO subsystem
@@ -853,7 +830,23 @@ EXPORT_SYMBOL_GPL(pinctrl_gpio_free);
  */
 void pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset)
 {
-	return pinctrl_gpio_free(gc->base + offset);
+	struct pinctrl_gpio_range *range;
+	struct pinctrl_dev *pctldev;
+	int ret, pin;
+
+	ret = pinctrl_get_device_gpio_range(gc->base + offset, &pctldev,
+					    &range);
+	if (ret)
+		return;
+
+	mutex_lock(&pctldev->mutex);
+
+	/* Convert to the pin controllers number space */
+	pin = gpio_to_pin(range, gc->base + offset);
+
+	pinmux_free_gpio(pctldev, pin, range);
+
+	mutex_unlock(&pctldev->mutex);
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_free_new);
 
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 83a414a347cf..90b2f0b78c4b 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -28,7 +28,6 @@ struct pinctrl_state;
 /* External interface to pin control */
 bool pinctrl_gpio_can_use_line_new(struct gpio_chip *gc, unsigned int offset);
 int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset);
-void pinctrl_gpio_free(unsigned gpio);
 void pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset);
 int pinctrl_gpio_direction_input(unsigned gpio);
 int pinctrl_gpio_direction_input_new(struct gpio_chip *gc,
@@ -83,10 +82,6 @@ pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset)
 	return 0;
 }
 
-static inline void pinctrl_gpio_free(unsigned gpio)
-{
-}
-
 static inline void
 pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset)
 {
-- 
2.39.2

