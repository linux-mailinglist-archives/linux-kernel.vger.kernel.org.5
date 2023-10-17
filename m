Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800697CC290
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjJQMIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjJQMHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:07:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8014211C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so52640915e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544339; x=1698149139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJlmvjClNYUGDO9zWdiE9QW26eZ74vwLTwImlwEqdgA=;
        b=CEpZd2qVeeMGuYMjOwPiJPAW0Ucq1BhxbN69wfZllsr9FsELlxC3P5AtIqpc481wzz
         +DdGfPoflsAxAxOsSnudjvwD/Lh/CndCpsngPznGhSNV0dIEfefbtTMaFYWHaD8Zl5T0
         NJOKEqzSBAIg2orALZczMnzvK8Kq63auYE3Kj8Uvc/fWm3lO28drBVz0BbqHN3JPN7nY
         CaJieTgK0RmTWqKJY4786UVs4JF2PumlGCbGSsEQwQWhEtDahId9kS7DIHY+lrnP8g+J
         QxCA5iEG37+M3IMkp8xRt3qps5clCaf498pHJ03efq7N2ER9Zs9cPct4zqArd0XMdO0k
         Grug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544339; x=1698149139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJlmvjClNYUGDO9zWdiE9QW26eZ74vwLTwImlwEqdgA=;
        b=LA0CJW0jMrt+wPPcqIppgcNG/Nk1uJSJBnQ2XGJiBqe7l5gCZmpfp3Fti+KI0940Iv
         a8FuprtJ82jdTJAxYal+AXfMkqCRBsxzQnfgj4jl/4whxkmn0FFZvBxNycFVAoO/5z+X
         xH1RfiBJBRotCByj165iwidn9Ef6QFwuPQk7xR2YudR1ZogGB+Bigva21ZYpCy5TICfc
         pY7WTgZkookHKJwzxZyG74oPj4yaeOV4na/2e53kbpDQcyroxjM6Zv6IKAj/QYlX741l
         d3nxAPnjX9Gp3JLLffg/TRrvq9mRlH1tlR6ld0l2auJabKiwSzFsr7e4PACCj0ktL7OH
         jtnw==
X-Gm-Message-State: AOJu0YzG8yjJ5Yz8r3QmhWFdSR3/wpdmhTILsf+rsPPyeGSn0WYVubjb
        CSjICjgN8q90pXoHKunMW45Cnw==
X-Google-Smtp-Source: AGHT+IGGXXduwT+h/y+ce8+VQO6v5Nn3aPm/K1JNY6WwLKZo05Jjc0x7kKnf6WImcaPW7tNO7SKkGg==
X-Received: by 2002:a05:600c:511b:b0:403:272:4414 with SMTP id o27-20020a05600c511b00b0040302724414mr1672045wms.0.1697544339037;
        Tue, 17 Oct 2023 05:05:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:38 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 52/73] pinctrl: change the signature of pinctrl_ready_for_gpio_range()
Date:   Tue, 17 Oct 2023 14:04:10 +0200
Message-Id: <20231017120431.68847-53-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/core.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index da5d716f154d..932bbcdc0eb1 100644
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

