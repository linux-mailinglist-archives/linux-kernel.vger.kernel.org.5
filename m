Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BD67C534A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346728AbjJKMM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346798AbjJKMMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:12:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC23410CF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-406618d0992so65244735e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026178; x=1697630978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYjSdXnBn2U6AI/a2gaGCAgCRKx7tlSdfzxpGqCypic=;
        b=qijQ5k/hN6KFMCD6odx/HGVEp+360Q7pWWpbwyOHiwU4ZC2P/4CE6NUNnVxrueG6hA
         bz6rg4SfkKZggXCFKUW87vwCy75jCUx5bwMVNdYl+rHrkCMEipQw00RxJ1jAmaNm3rGQ
         +UOotZGy4PkCyDipC6cN5eZmI+RWnGmP3vaPpFbs4Y5BBEOHLZbRZe8hqniMJ5NzXgJG
         0PV4ROrx/gsgIeynjklELYHnaiyuWiTvv1bMwKc3fPZI2i09FBMVZ53l8PkSvU1hzcXy
         91UpUjc5MQO9oXvoyzWkU6CN72zmnZDEi8q8bNhpLiZRXHuIEDIwKZwWL+8tVBUEUnKf
         0/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026178; x=1697630978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYjSdXnBn2U6AI/a2gaGCAgCRKx7tlSdfzxpGqCypic=;
        b=jR1s5VJ311NYwZ7HB0PXE6olAnncob2D5LglyhuCwRsbO9NR90nJm5ARkbAQgS/y6+
         Tq85r8qzLA8uyOG0XPBU8EjA00/chyotksSDXZFeK7P/UV6faLeBbL4d1HupJ/33WRsP
         hInVHR2rP0xW+WkgPM8qe22mWTumb7p8xOZpnnXLAwVvAYsgvOwT+4tjNurtIy6tCo0e
         iRV+O+oGU/YL5szy20+6grbLea8VY0nQCMCTJCaPq0Vq+drUZfFnmJ0q4wjLWx9tPdHv
         2CkACbzomtDvYBiNvbLW6qft+QQBKxFoO+J2RYRcMjtt103UjUQ1dIaBlBBU/3SZouQU
         nIlA==
X-Gm-Message-State: AOJu0YyhG1ngaCWzTwK3u4mT03quyb29hLEBJ8HllenfmSkAQzCQRSYq
        JxERlQOEMnn1flfSnyu6KL/V06NyCUVkHI8njJY=
X-Google-Smtp-Source: AGHT+IGkkcc98HAYmTO1Uu1JuhpNbP95aHr2zgrNO7Z2GyIJi9vEbV9WZZMZs0icMbpJICwI8183RA==
X-Received: by 2002:a5d:560a:0:b0:31a:e3ad:f30e with SMTP id l10-20020a5d560a000000b0031ae3adf30emr18624160wrv.68.1697026178350;
        Wed, 11 Oct 2023 05:09:38 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:37 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 34/62] pinctrl: remove pinctrl_gpio_direction_output()
Date:   Wed, 11 Oct 2023 14:08:02 +0200
Message-Id: <20231011120830.49324-35-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011120830.49324-1-brgl@bgdev.pl>
References: <20231011120830.49324-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are no more users of pinctrl_gpio_direction_output() so remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/core.c           | 9 +--------
 include/linux/pinctrl/consumer.h | 1 -
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 1d3afc7d1656..9f8027f381b6 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -888,13 +888,6 @@ int pinctrl_gpio_direction_input_new(struct gpio_chip *gc, unsigned int offset)
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_input_new);
 
-/* This function is deprecated and will be removed. Don't use. */
-int pinctrl_gpio_direction_output(unsigned gpio)
-{
-	return pinctrl_gpio_direction(gpio, false);
-}
-EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_output);
-
 /**
  * pinctrl_gpio_direction_output_new() - request a GPIO pin to go into output
  *                                       mode
@@ -907,7 +900,7 @@ EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_output);
  */
 int pinctrl_gpio_direction_output_new(struct gpio_chip *gc, unsigned int offset)
 {
-	return pinctrl_gpio_direction_output(gc->base + offset);
+	return pinctrl_gpio_direction(gc->base + offset, false);
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_output_new);
 
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index f9cf70887242..4fdc0e570329 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -31,7 +31,6 @@ int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset);
 void pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset);
 int pinctrl_gpio_direction_input_new(struct gpio_chip *gc,
 				     unsigned int offset);
-int pinctrl_gpio_direction_output(unsigned gpio);
 int pinctrl_gpio_direction_output_new(struct gpio_chip *gc,
 				      unsigned int offset);
 int pinctrl_gpio_set_config(unsigned gpio, unsigned long config);
-- 
2.39.2

