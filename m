Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C2D7C5319
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346758AbjJKMKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346744AbjJKMJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:09:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5995CC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso63198185e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026160; x=1697630960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ta+JXTCEvoYCkfYdZVmNUE+yvh6PoUsZ4OUodo3JS+4=;
        b=BH/7WiHvr7wrBRUUCxrIAZHfT+/Lej5zcolC9NWcnu+RH9X2FJWXfeeykdBSWG0wce
         ERcSJ0L3YSdblc9GftMXcPvzeemgVC+P4vzwR431x90RZj77pPcOWHKG9/i0qoyWM5k9
         pJzPqSPur26HyPPzGHx5gMc2pQBx/Oz+iHrDtToVpGZfa5gZVxWbL2IlxBVw/eBBV9jz
         9kfHZDU8qmME+cnRYcjOTzj14wiUe8tACwMoBS3lTw4yZZE1KUzmxDy/jdkQIIZ0eVLG
         fvaPpkH04okIPHwK5/szFZTTGUtNcdCvL7XIIfqeNCPFmfzoFquMlSCnJt1rs7t2AKlj
         6Hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026160; x=1697630960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ta+JXTCEvoYCkfYdZVmNUE+yvh6PoUsZ4OUodo3JS+4=;
        b=LRQhTRnyk+eQFaxLJVVlsrD/wW0dEKjySHoiO0AayFajXXhKNVVbeo/yD31EAX6ODJ
         AqXMdvG/yW+rsBAEdP2+UHbvcqb75KtPRIQDZS3sCwkonYoPPb/CCLwo+3/ZpLmt/U45
         tYzqiO08qRfIK/OAXqBIl2RGrEjNHB3DF80X9k/m2rP+srQDguaxNBa7UrvxmaR6TdWD
         xz72ZuTqHBehYG+wNjLuPcmt4tisToo0sZaEZvahac80w7yPDWEk4uCZV+hFSIC0P0pP
         dwXM5xd1em1qqPQ4rtgiyuKF4DmSSsg7w+6B7afB7GqWKLuWWlI4fimVg/WIxV14qPtK
         Cq2w==
X-Gm-Message-State: AOJu0YymD0u7RS82r3qnoGczyNVV/fiXK6jTxwIXzESEc0DVrYneHVjP
        k8q+IumiYGFQDwHASQ3tce9YTnXLxBKOtwM3OwY=
X-Google-Smtp-Source: AGHT+IH2VfH8mrOCd4iVmyA45doYq87E2cK7mxYdHS7WFSih7sVE1Sq2vd+FwaRD40miDa3UMTipZA==
X-Received: by 2002:a05:600c:2298:b0:3fe:1af6:6542 with SMTP id 24-20020a05600c229800b003fe1af66542mr18550360wmf.33.1697026159960;
        Wed, 11 Oct 2023 05:09:19 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:19 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 14/62] pinctrl: renesas: use new pinctrl GPIO helpers
Date:   Wed, 11 Oct 2023 14:07:42 +0200
Message-Id: <20231011120830.49324-15-brgl@bgdev.pl>
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

Replace the pinctrl helpers taking the global GPIO number as argument
with the improved variants that instead take a pointer to the GPIO chip
and the controller-relative offset.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/gpio.c          | 8 ++++----
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 4 ++--
 drivers/pinctrl/renesas/pinctrl-rzv2m.c | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/renesas/gpio.c b/drivers/pinctrl/renesas/gpio.c
index 5758daf94fe2..e7771a57e6d1 100644
--- a/drivers/pinctrl/renesas/gpio.c
+++ b/drivers/pinctrl/renesas/gpio.c
@@ -135,12 +135,12 @@ static int gpio_pin_request(struct gpio_chip *gc, unsigned offset)
 	if (idx < 0 || pfc->info->pins[idx].enum_id == 0)
 		return -EINVAL;
 
-	return pinctrl_gpio_request(gc->base + offset);
+	return pinctrl_gpio_request_new(gc, offset);
 }
 
 static void gpio_pin_free(struct gpio_chip *gc, unsigned offset)
 {
-	return pinctrl_gpio_free(gc->base + offset);
+	return pinctrl_gpio_free_new(gc, offset);
 }
 
 static void gpio_pin_set_value(struct sh_pfc_chip *chip, unsigned offset,
@@ -164,7 +164,7 @@ static void gpio_pin_set_value(struct sh_pfc_chip *chip, unsigned offset,
 
 static int gpio_pin_direction_input(struct gpio_chip *gc, unsigned offset)
 {
-	return pinctrl_gpio_direction_input(gc->base + offset);
+	return pinctrl_gpio_direction_input_new(gc, offset);
 }
 
 static int gpio_pin_direction_output(struct gpio_chip *gc, unsigned offset,
@@ -172,7 +172,7 @@ static int gpio_pin_direction_output(struct gpio_chip *gc, unsigned offset,
 {
 	gpio_pin_set_value(gpiochip_get_data(gc), offset, value);
 
-	return pinctrl_gpio_direction_output(gc->base + offset);
+	return pinctrl_gpio_direction_output_new(gc, offset);
 }
 
 static int gpio_pin_get(struct gpio_chip *gc, unsigned offset)
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index c7c6d912a975..22d4ab7d228c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1056,7 +1056,7 @@ static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	if (ret)
 		return ret;
 
-	ret = pinctrl_gpio_request(chip->base + offset);
+	ret = pinctrl_gpio_request_new(chip, offset);
 	if (ret)
 		return ret;
 
@@ -1181,7 +1181,7 @@ static void rzg2l_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
 	unsigned int virq;
 
-	pinctrl_gpio_free(chip->base + offset);
+	pinctrl_gpio_free_new(chip, offset);
 
 	virq = irq_find_mapping(chip->irq.domain, offset);
 	if (virq)
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index 52aeafaba4b6..3d29c77a5aad 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -754,7 +754,7 @@ static int rzv2m_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	u8 bit = RZV2M_PIN_ID_TO_PIN(offset);
 	int ret;
 
-	ret = pinctrl_gpio_request(chip->base + offset);
+	ret = pinctrl_gpio_request_new(chip, offset);
 	if (ret)
 		return ret;
 
@@ -832,7 +832,7 @@ static int rzv2m_gpio_get(struct gpio_chip *chip, unsigned int offset)
 
 static void rzv2m_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
-	pinctrl_gpio_free(chip->base + offset);
+	pinctrl_gpio_free_new(chip, offset);
 
 	/*
 	 * Set the GPIO as an input to ensure that the next GPIO request won't
-- 
2.39.2

