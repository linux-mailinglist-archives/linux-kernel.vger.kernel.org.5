Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A83F7CC2F3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbjJQMU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjJQMUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:20:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361561BF6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4064867903cso62409455e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544328; x=1698149128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lqh80WdRi0gOj4xJupqHqeCuK7TYCSZZE8MoyG0FXMc=;
        b=Jp9HR6nFwhdnzZ3rk2trcvAffihrRRbD9skIVXxL4UrSkktfEAcQ0zEBNNgc7DA57o
         lg6prSQKRZhqhDb7R1abWL0PdiKfT9ZZ02gunA+qoYz2GAhmDIz2US8pNmzZC/R6hqkn
         iaSHSLts84BPCmm3AH/+M2s3KFNqDpwdxxKMAwy/kY9qpTTQWELq6z+4T9F9uhQ5sHOF
         gRJV3rrQefVLG7dFeTsjOZ4NMgv0ETSZpvtE+34IzWQDjP1mBWjwMxk6nEtaz+WNIAzs
         mO1CD0WBwKZPoRQglRTWGREK9jZzammWM+SMsrS5Fv2ymUArnannog0ymacwrs2xHlgL
         FEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544328; x=1698149128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lqh80WdRi0gOj4xJupqHqeCuK7TYCSZZE8MoyG0FXMc=;
        b=qgss9RXRJbCqhh+Pnxj+bw7TCNbpf/pLXc3oeutFKKnpconOoEBYaDf/DMZ70q071l
         Uo5SvJdDXsbcFWLw2tYpUeyQqfNYbsR1qpCoxEBpsCSyro8iI69w5TbqaCTicl9d0H3a
         sbYQbQVx3U0Ds+Rypifd+0rNWcKXI6s2jp8S/KsutkKCL5iVpnSEYQQqxkLGxmjhH8dQ
         xQtXR7FQktABFBNdhl+mTESj+waL3Mo+l/uaLi+zOSWfT2J7CM1ccu/9bO+f0g/bxpJl
         CMRFQliZKs7KfQ/JY5G9A7HKhgdYu4VcwEsn12oZikcAijua7AL2CVt1SPrppd9bYzFL
         +fDA==
X-Gm-Message-State: AOJu0YxcN3GPg+KScu3jP83R96ODvw8fO2LvDVge32jN6HBX6JSFfjxy
        4HoJFPB543tZY5Jxw9fhybsZV4lduOCEpnJPQhQ=
X-Google-Smtp-Source: AGHT+IGtqD2NSdKrkdy2YLUUP3llJ/HF4BUPh1V5oC58M9d5555REcKLTl3cSqEFX6D3mS1v1zF0ww==
X-Received: by 2002:a05:600c:4f0d:b0:405:37bb:d940 with SMTP id l13-20020a05600c4f0d00b0040537bbd940mr1723644wmq.0.1697544328006;
        Tue, 17 Oct 2023 05:05:28 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:27 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 41/73] pinctrl: remove pinctrl_gpio_set_config()
Date:   Tue, 17 Oct 2023 14:03:59 +0200
Message-Id: <20231017120431.68847-42-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are no more users of pinctrl_gpio_set_config() so remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/core.c           | 38 ++++++++++++++------------------
 include/linux/pinctrl/consumer.h |  6 -----
 2 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 0d66b3d5e685..881845395885 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -904,27 +904,6 @@ int pinctrl_gpio_direction_output_new(struct gpio_chip *gc, unsigned int offset)
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_output_new);
 
-/* This function is deprecated and will be removed. Don't use. */
-int pinctrl_gpio_set_config(unsigned gpio, unsigned long config)
-{
-	unsigned long configs[] = { config };
-	struct pinctrl_gpio_range *range;
-	struct pinctrl_dev *pctldev;
-	int ret, pin;
-
-	ret = pinctrl_get_device_gpio_range(gpio, &pctldev, &range);
-	if (ret)
-		return ret;
-
-	mutex_lock(&pctldev->mutex);
-	pin = gpio_to_pin(range, gpio);
-	ret = pinconf_set_config(pctldev, pin, configs, ARRAY_SIZE(configs));
-	mutex_unlock(&pctldev->mutex);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(pinctrl_gpio_set_config);
-
 /**
  * pinctrl_gpio_set_config_new() - Apply config to given GPIO pin
  * @gc: GPIO chip structure from the GPIO subsystem
@@ -938,7 +917,22 @@ EXPORT_SYMBOL_GPL(pinctrl_gpio_set_config);
 int pinctrl_gpio_set_config_new(struct gpio_chip *gc, unsigned int offset,
 				unsigned long config)
 {
-	return pinctrl_gpio_set_config(gc->base + offset, config);
+	unsigned long configs[] = { config };
+	struct pinctrl_gpio_range *range;
+	struct pinctrl_dev *pctldev;
+	int ret, pin;
+
+	ret = pinctrl_get_device_gpio_range(gc->base + offset, &pctldev,
+					    &range);
+	if (ret)
+		return ret;
+
+	mutex_lock(&pctldev->mutex);
+	pin = gpio_to_pin(range, gc->base + offset);
+	ret = pinconf_set_config(pctldev, pin, configs, ARRAY_SIZE(configs));
+	mutex_unlock(&pctldev->mutex);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_set_config_new);
 
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index e25e9b0599ac..aa3a7a7ca52d 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -33,7 +33,6 @@ int pinctrl_gpio_direction_input_new(struct gpio_chip *gc,
 				     unsigned int offset);
 int pinctrl_gpio_direction_output_new(struct gpio_chip *gc,
 				      unsigned int offset);
-int pinctrl_gpio_set_config(unsigned gpio, unsigned long config);
 int pinctrl_gpio_set_config_new(struct gpio_chip *gc, unsigned int offset,
 				unsigned long config);
 
@@ -97,11 +96,6 @@ pinctrl_gpio_direction_output_new(struct gpio_chip *gc, unsigned int offset)
 	return 0;
 }
 
-static inline int pinctrl_gpio_set_config(unsigned gpio, unsigned long config)
-{
-	return 0;
-}
-
 static inline int
 pinctrl_gpio_set_config_new(struct gpio_chip *gc, unsigned int offset,
 			    unsigned long config)
-- 
2.39.2

