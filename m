Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749A67C5382
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjJKMU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjJKMUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:20:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025EE19A7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-405361bb94eso69192205e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026190; x=1697630990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PV4PS0wlUJUsPnHQ+15CSYkWjpePpNEtuLC0jO+O4fA=;
        b=SmIHmEHKMnG2f/01uVvH1kD0bW639bRCf6KaJd2vlyfTV9XvDKyGtnaFBZS4txs77Q
         DIx8+KV6HWPDMFV1N7VvdlvR0mKtld+Wv/MfH7Vn6kP0r8mRUc0F6Fc8zO12p+X8g8an
         ZIO4WrKU1cBzw43RAsKlL1FLcf/lxCmht4NHZ0Odh47tvak9MMiHnd+igSq3c2ZCLaAx
         kLRddvtWUhv0Vo4crOkw6PDuLuUluY3q9m2ytcF5kLM2NNeXUdyTvAGrKVLmh64+2Hrb
         xsHxr8+ynKcMOQXOpRZ2brgtB4EeMOnUSjivFmm+pmiF38zfq/52AJbkuhUlmn/9YCeP
         7M4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026190; x=1697630990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PV4PS0wlUJUsPnHQ+15CSYkWjpePpNEtuLC0jO+O4fA=;
        b=Ne3xhxun9nSAKfU+YfJMariuai4KaxcF9PbLYPTrojXpVk1Cx/P2/7+daEyaITO2by
         mPG3KafQn6BDE94co6vyR6vzh7cYNOFGJ85ZkmYLUKYfZzTxvMdiJY34Pwi0V2n0KNo7
         vg+zQ6mcrgNXk+bCRVT5BZ32jjNuGqng2C0wutxWyfYcv6h5EXDoP8t74V73I3TA9iM2
         3PH59PLJA2LUSkCummEdlxYGmpg+t0XrHA5EDfOsmMfJDuzOD9vwFuLpQrY6mBPYxsoD
         7PkBD0ZBNADMoOdx8lXtIuPTUokaeBygydEukxpSkdtNHEIdrbynUm/d18vXXGrXT56F
         WElg==
X-Gm-Message-State: AOJu0YyIoWk9DyfPgaSxybxjBkAR/sB4XrbbER/UcOJN2IdvdQXb5Gd9
        Zk6Oox4S0Wm5VjGDD4MFnK0mvQ==
X-Google-Smtp-Source: AGHT+IEKkuO4KWkKGW5OySKb472C3QwclFRZfn913ZUhBxKsM11lqZrt/xgzMcaE2ugp1JieZ9X8UQ==
X-Received: by 2002:a7b:c7c5:0:b0:404:4b6f:d70d with SMTP id z5-20020a7bc7c5000000b004044b6fd70dmr19405847wmk.17.1697026189872;
        Wed, 11 Oct 2023 05:09:49 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:49 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 46/62] pinctrl: change the signature of pinctrl_ready_for_gpio_range()
Date:   Wed, 11 Oct 2023 14:08:14 +0200
Message-Id: <20231011120830.49324-47-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011120830.49324-1-brgl@bgdev.pl>
References: <20231011120830.49324-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Modify pinctrl_ready_for_gpio_range() to be in line with public GPIO
helpers and take a pair of GPIO chip & offset as arguments

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/core.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 89df934d65bc..e3da8aeee01d 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -322,7 +322,8 @@ pinctrl_match_gpio_range(struct pinctrl_dev *pctldev, struct gpio_chip *gc,
 /**
  * pinctrl_ready_for_gpio_range() - check if other GPIO pins of
  * the same GPIO chip are in range
- * @gpio: gpio pin to check taken from the global GPIO pin space
+ * @gc: GPIO chip structure from the GPIO subsystem
+ * @offset: hardware offset of the GPIO relative to the controller
  *
  * This function is complement of pinctrl_match_gpio_range(). If the return
  * value of pinctrl_match_gpio_range() is NULL, this function could be used
@@ -333,19 +334,11 @@ pinctrl_match_gpio_range(struct pinctrl_dev *pctldev, struct gpio_chip *gc,
  * is false, it means that pinctrl device may not be ready.
  */
 #ifdef CONFIG_GPIOLIB
-static bool pinctrl_ready_for_gpio_range(unsigned gpio)
+static bool pinctrl_ready_for_gpio_range(struct gpio_chip *gc,
+					 unsigned int offset)
 {
 	struct pinctrl_dev *pctldev;
 	struct pinctrl_gpio_range *range = NULL;
-	/*
-	 * FIXME: "gpio" here is a number in the global GPIO numberspace.
-	 * get rid of this from the ranges eventually and get the GPIO
-	 * descriptor from the gpio_chip.
-	 */
-	struct gpio_chip *chip = gpiod_to_chip(gpio_to_desc(gpio));
-
-	if (WARN(!chip, "no gpio_chip for gpio%i?", gpio))
-		return false;
 
 	mutex_lock(&pinctrldev_list_mutex);
 
@@ -355,8 +348,8 @@ static bool pinctrl_ready_for_gpio_range(unsigned gpio)
 		mutex_lock(&pctldev->mutex);
 		list_for_each_entry(range, &pctldev->gpio_ranges, node) {
 			/* Check if any gpio range overlapped with gpio chip */
-			if (range->base + range->npins - 1 < chip->base ||
-			    range->base > chip->base + chip->ngpio - 1)
+			if (range->base + range->npins - 1 < gc->base ||
+			    range->base > gc->base + gc->ngpio - 1)
 				continue;
 			mutex_unlock(&pctldev->mutex);
 			mutex_unlock(&pinctrldev_list_mutex);
@@ -370,7 +363,11 @@ static bool pinctrl_ready_for_gpio_range(unsigned gpio)
 	return false;
 }
 #else
-static bool pinctrl_ready_for_gpio_range(unsigned gpio) { return true; }
+static inline bool
+pinctrl_ready_for_gpio_range(struct gpio_chip *gc, unsigned int offset)
+{
+	return true;
+}
 #endif
 
 /**
@@ -805,7 +802,7 @@ int pinctrl_gpio_request(struct gpio_chip *gc, unsigned int offset)
 
 	ret = pinctrl_get_device_gpio_range(gc, offset, &pctldev, &range);
 	if (ret) {
-		if (pinctrl_ready_for_gpio_range(gc->base + offset))
+		if (pinctrl_ready_for_gpio_range(gc, offset))
 			ret = 0;
 		return ret;
 	}
-- 
2.39.2

