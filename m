Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0616802EC5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbjLDJgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjLDJfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:35:30 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC8C1A2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:35:25 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c09d62b70so11320875e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701682524; x=1702287324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUM8/16TtFRuJWbQL1BXzPDgwc0PUnSgAFPYdXYTVlM=;
        b=FyFfMo7HI5+vw6MJIdRERUca43k5eYUzMMRtv3IJ4beevHXsYl/Xqdzg+hFR2UxqBz
         J/n61hAUMqRf/v4cT72e4fM4bYXXHmX1Emqunn7A4SYznehtvhhZifQbpDzZ3OYZ3gqh
         M+pN5bAFFzndXW333+WVRjNvFCj8dfEQyaatai5GicMThDfA5d/4qYwoCQ0MC51g2Rak
         361wrFDOO3UjsYgg5K6dxfCP/hgque6u3vESzRJ80KJ6KkaEZ6TRG2CR/MG1LnEjQw1K
         KKem0GS4J2JuMCcMxnrrKcjReFVwcqyQ4KEKAxMaQyiKIvx6ebYrGGxpagOWbwGeq2wa
         1YzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701682524; x=1702287324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUM8/16TtFRuJWbQL1BXzPDgwc0PUnSgAFPYdXYTVlM=;
        b=IyHVFfH5KzrVOu/4nCHBlOK/MtjP8PYtwIgBFKUn+BWtDbMI/jX4S7+8RANJe3VmO/
         AL4cvAw4abhR3DzUL9kr9R6OFfH4HNJa+qDKhYjrX8jkjQayC//Ub2ctzO60aYaFGDux
         T1u1OrXkvnP2dRaknnqubfviSuP3gQ+C48q1MiloiV498se+dkNlp0oHopi+4acUT3Np
         /FnZ1W1vCL4fIH4rPoX/0lqtLtrgIVx9aAWUlRl7CxRInxNC7C0KgLfDt9riBAKrk+GK
         L5jC0M8d040MMB2BJFrle7DCspT5sG3raF/OOIuZue6WePN1fux75xOqF3tDu6GbS9/C
         e7jw==
X-Gm-Message-State: AOJu0Yy9XL+f4giF/gNbTH+iooSUkc3yMwtRVKFwWObegVdhH2+aPLYJ
        aNZ0Q1uqRvDlo/KgUm9+ZQZzmg==
X-Google-Smtp-Source: AGHT+IFIyn9k8yICnEpxu1kT5sz0yPZeDdyS6pUYcY8kYaa7qco4dUZC7Fm9sqnREfN+Da2D/gi3iQ==
X-Received: by 2002:a05:600c:364d:b0:40b:5e21:c5c7 with SMTP id y13-20020a05600c364d00b0040b5e21c5c7mr1679318wmq.149.1701682523813;
        Mon, 04 Dec 2023 01:35:23 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4cb1:229e:8c33:122a])
        by smtp.gmail.com with ESMTPSA id fs16-20020a05600c3f9000b0040b48690c49sm14266219wmb.6.2023.12.04.01.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 01:35:23 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 10/10] gpiolib: remove gpiochip_is_requested()
Date:   Mon,  4 Dec 2023 10:35:09 +0100
Message-Id: <20231204093509.19225-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204093509.19225-1-brgl@bgdev.pl>
References: <20231204093509.19225-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We have no external users of gpiochip_is_requested(). Let's remove it
and replace its internal calls with direct testing of the REQUESTED flag.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c      | 48 ++++++++++---------------------------
 include/linux/gpio/driver.h |  1 -
 2 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d4b33782cc10..4e190be75dc2 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1085,7 +1085,7 @@ void gpiochip_remove(struct gpio_chip *gc)
 
 	spin_lock_irqsave(&gpio_lock, flags);
 	for (i = 0; i < gdev->ngpio; i++) {
-		if (gpiochip_is_requested(gc, i))
+		if (test_bit(FLAG_REQUESTED, &gdev->descs[i].flags))
 			break;
 	}
 	spin_unlock_irqrestore(&gpio_lock, flags);
@@ -2373,33 +2373,6 @@ void gpiod_free(struct gpio_desc *desc)
 	gpio_device_put(desc->gdev);
 }
 
-/**
- * gpiochip_is_requested - return string iff signal was requested
- * @gc: controller managing the signal
- * @offset: of signal within controller's 0..(ngpio - 1) range
- *
- * Returns NULL if the GPIO is not currently requested, else a string.
- * The string returned is the label passed to gpio_request(); if none has been
- * passed it is a meaningless, non-NULL constant.
- *
- * This function is for use by GPIO controller drivers.  The label can
- * help with diagnostics, and knowing that the signal is used as a GPIO
- * can help avoid accidentally multiplexing it to another controller.
- */
-const char *gpiochip_is_requested(struct gpio_chip *gc, unsigned int offset)
-{
-	struct gpio_desc *desc;
-
-	desc = gpiochip_get_desc(gc, offset);
-	if (IS_ERR(desc))
-		return NULL;
-
-	if (test_bit(FLAG_REQUESTED, &desc->flags) == 0)
-		return NULL;
-	return desc->label;
-}
-EXPORT_SYMBOL_GPL(gpiochip_is_requested);
-
 /**
  * gpiochip_dup_line_label - Get a copy of the consumer label.
  * @gc: GPIO chip controlling this line.
@@ -2414,18 +2387,23 @@ EXPORT_SYMBOL_GPL(gpiochip_is_requested);
  */
 char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)
 {
-	const char *label;
-	char *copy;
+	struct gpio_desc *desc;
+	char *label;
 
-	label = gpiochip_is_requested(gc, offset);
-	if (!label)
+	desc = gpiochip_get_desc(gc, offset);
+	if (IS_ERR(desc))
 		return NULL;
 
-	copy = kstrdup(label, GFP_KERNEL);
-	if (!copy)
+	guard(spinlock_irqsave)(&gpio_lock);
+
+	if (!test_bit(FLAG_REQUESTED, &desc->flags))
+		return NULL;
+
+	label = kstrdup(desc->label, GFP_KERNEL);
+	if (!label)
 		return ERR_PTR(-ENOMEM);
 
-	return copy;
+	return label;
 }
 EXPORT_SYMBOL_GPL(gpiochip_dup_line_label);
 
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 910fc50d3ab5..bd9bea7cb270 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -531,7 +531,6 @@ struct gpio_chip {
 #endif /* CONFIG_OF_GPIO */
 };
 
-const char *gpiochip_is_requested(struct gpio_chip *gc, unsigned int offset);
 char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset);
 
 
-- 
2.40.1

