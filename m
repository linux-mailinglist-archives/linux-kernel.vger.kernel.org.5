Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AB17CC286
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343660AbjJQMIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343550AbjJQMHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:07:24 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165B52118
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-408382da7f0so623075e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544338; x=1698149138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8yAQcDn5NqavITdTu+94YWVTuN3+Lvdw4mYFyDalzc=;
        b=3HqZrJ0pMNTJhLp55B7mfeuFV97tJozM1ARjbt3FCu9eVoX1oADAYvh7oGqDKbKLZ5
         dytmZSrHdDhPn8rVc4r0Y3R7+Oe0mw3N88MAhHH1H3bjGemDEHtIqmwwGvI9w5bqWBBW
         1sxJt/Old9yWIX+vZ6H/hqyu15MFpbNVB8i1hHdiHw5sVtc/1jvdtp2oPHcleCBnj1O6
         sRktwMpgXr3pq1+6z8QtF6ZFJc2oGT5+3dD2ckrdxly6Eo2l10AqzRv3zUoivhcpZzc2
         ZBB50JgOZogLLXm/OGTBlaBfdp9LnoLcMMmFQGkKJ8/xIxVzgR1peArY6hCVgz848dyA
         1vGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544338; x=1698149138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8yAQcDn5NqavITdTu+94YWVTuN3+Lvdw4mYFyDalzc=;
        b=EgfLyE55KdRGr298YIYm8qyHsFohYyJGFV/YZuUxKS+4tiWF7Sq97/eAsWLo18q2hh
         rDx+y6W0z84QqtQxfbdQb2uAJi6+/B4GA4ZafDN+IRCaw70i6mWphSFAA9e9/frKI/p0
         CqqhXdIt2KJayvCDP1yqRV4zSXmZpgHDy98Ma0nAevDLBM0mfywwJApUK16kQNSohtkv
         b6PmDDf4OL3qCyxkMpmTJOIIhipVtmioXjhAxy4JOj6VN/XrfaW+E1sPfJOWG5EMz6Tk
         YA9uZcaVssn2v1Kofv+oabfikOBh2+WNHUuqCsxdkE4smo/G41rJMCI9ULoEOgXVkE02
         hVNA==
X-Gm-Message-State: AOJu0Yzp0S2M1lvs7y6Wc8/dPQyLUgXGuhnruWV+aAWqYTxlRuWeRfDt
        LXTbssJIDTgoMEosFgvdPbOZQg==
X-Google-Smtp-Source: AGHT+IHpq57euEx4cvlqeeY4qTce39hHLaQEQolHZiN9d1I6xCBqMADth37mmsTUBz+dCa97s2EOWA==
X-Received: by 2002:a05:600c:1f8f:b0:406:849f:f3cd with SMTP id je15-20020a05600c1f8f00b00406849ff3cdmr1511927wmb.29.1697544338272;
        Tue, 17 Oct 2023 05:05:38 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:37 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 51/73] pinctrl: change the signature of gpio_to_pin()
Date:   Tue, 17 Oct 2023 14:04:09 +0200
Message-Id: <20231017120431.68847-52-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Modify gpio_to_pin() to be in line with public GPIO helpers and take
a pair of GPIO chip & offset as arguments.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/core.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index ec78a75a5d7c..da5d716f154d 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -269,7 +269,8 @@ static int pinctrl_register_pins(struct pinctrl_dev *pctldev,
 /**
  * gpio_to_pin() - GPIO range GPIO number to pin number translation
  * @range: GPIO range used for the translation
- * @gpio: gpio pin to translate to a pin number
+ * @gc: GPIO chip structure from the GPIO subsystem
+ * @offset: hardware offset of the GPIO relative to the controller
  *
  * Finds the pin number for a given GPIO using the specified GPIO range
  * as a base for translation. The distinction between linear GPIO ranges
@@ -280,13 +281,13 @@ static int pinctrl_register_pins(struct pinctrl_dev *pctldev,
  * result of successful pinctrl_get_device_gpio_range calls)!
  */
 static inline int gpio_to_pin(struct pinctrl_gpio_range *range,
-				unsigned int gpio)
+			      struct gpio_chip *gc, unsigned int offset)
 {
-	unsigned int offset = gpio - range->base;
+	unsigned int pin = gc->base + offset - range->base;
 	if (range->pins)
-		return range->pins[offset];
+		return range->pins[pin];
 	else
-		return range->pin_base + offset;
+		return range->pin_base + pin;
 }
 
 /**
@@ -777,7 +778,7 @@ bool pinctrl_gpio_can_use_line(struct gpio_chip *gc, unsigned int offset)
 	mutex_lock(&pctldev->mutex);
 
 	/* Convert to the pin controllers number space */
-	pin = gpio_to_pin(range, gc->base + offset);
+	pin = gpio_to_pin(range, gc, offset);
 
 	result = pinmux_can_be_used_for_gpio(pctldev, pin);
 
@@ -812,7 +813,7 @@ int pinctrl_gpio_request(struct gpio_chip *gc, unsigned int offset)
 	mutex_lock(&pctldev->mutex);
 
 	/* Convert to the pin controllers number space */
-	pin = gpio_to_pin(range, gc->base + offset);
+	pin = gpio_to_pin(range, gc, offset);
 
 	ret = pinmux_request_gpio(pctldev, range, pin, gc->base + offset);
 
@@ -844,7 +845,7 @@ void pinctrl_gpio_free(struct gpio_chip *gc, unsigned int offset)
 	mutex_lock(&pctldev->mutex);
 
 	/* Convert to the pin controllers number space */
-	pin = gpio_to_pin(range, gc->base + offset);
+	pin = gpio_to_pin(range, gc, offset);
 
 	pinmux_free_gpio(pctldev, pin, range);
 
@@ -868,7 +869,7 @@ static int pinctrl_gpio_direction(struct gpio_chip *gc, unsigned int offset,
 	mutex_lock(&pctldev->mutex);
 
 	/* Convert to the pin controllers number space */
-	pin = gpio_to_pin(range, gc->base + offset);
+	pin = gpio_to_pin(range, gc, offset);
 	ret = pinmux_gpio_direction(pctldev, range, pin, input);
 
 	mutex_unlock(&pctldev->mutex);
@@ -929,7 +930,7 @@ int pinctrl_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 		return ret;
 
 	mutex_lock(&pctldev->mutex);
-	pin = gpio_to_pin(range, gc->base + offset);
+	pin = gpio_to_pin(range, gc, offset);
 	ret = pinconf_set_config(pctldev, pin, configs, ARRAY_SIZE(configs));
 	mutex_unlock(&pctldev->mutex);
 
-- 
2.39.2

