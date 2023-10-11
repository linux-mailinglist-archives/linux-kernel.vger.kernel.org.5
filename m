Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC9E7C5302
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346252AbjJKMJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346388AbjJKMJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:09:14 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68605B9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:12 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50325ce89e9so8954634e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026150; x=1697630950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhFi4LGhC2Y5nFrUut/uRJGJvyUMlfTO1AC2VY89hk8=;
        b=PTwW8Mm60bUz0lSdpHfx/ETkUHRkk6phf/AoBK71eH8GEtZTPihox/Gihy4VS1Ktfz
         M+gCKn/FR1CAQ4vOdBlirgve8PazA0KsjeLbkbaJccxt/INtOCSxmbsXMCFl4Wrnuix+
         DxqVsSn8cTJ0HdlqaO/XbP0Yl24F2fEqeqvkJRNp54EFThVohCPcBgNDOU0baOCR4pKQ
         WrPzCNnzd5Z67G9Z1TGj7R8v/pfGdVfdpTxtRlAB+8IXXJnapwHX5CEjVnevfFt/acpE
         /6CaLDkqvqS+Z0RVy/ZvU2o+mAlyRItMSamEJDeRFgSa7IfyKt15NRZ/FjI2H7hu1e/z
         Q6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026150; x=1697630950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhFi4LGhC2Y5nFrUut/uRJGJvyUMlfTO1AC2VY89hk8=;
        b=cFEXY3hLg0z7fbJGhF7I0BNmzBhadu5YnwIeCGBgKK3kBP/+n0tHNhWeV8E4TS4X2y
         YuRgIcUmWXW8N2ojx6qZapv9Woy23VFBGj2xNhsU1HBKTbUpYV2wBoNuHM92OjYpR7KQ
         L1AHJeF/XkRmQwkiSojQsijRrlbFHWk3A4vPi2Rshwh1ojmiu4YGINxe9yYvIrRsVtfE
         FBX7GGPLZfulcJ1lF9vYAoNNlT76NcaIQEm60RQwYZsIW1tPM+eqLD20YI0hO43u6M1u
         WcrPsbzT1U5s7WGQ8HdWdyc2izS9uOCN7Ks5gRhH9sXVQOfdZ1k735XnQz1rpSGQl/NC
         8aGw==
X-Gm-Message-State: AOJu0Ywf8/utfZFgVoEla69NF/K59Sc+ZrN/iSMEjcwntI9mFB/KDH/3
        BzxP1AwEz+7Z87TwW15/i6TzAQ==
X-Google-Smtp-Source: AGHT+IF3GfioFYS4wMF3LgWfKnAbfvrqUIRw86S7ZSZdwNNMjEgKLHTlQiBeUgJx+Vg4DbeSBVoTwQ==
X-Received: by 2002:ac2:5e33:0:b0:502:9c4e:d46a with SMTP id o19-20020ac25e33000000b005029c4ed46amr12870722lfg.32.1697026150722;
        Wed, 11 Oct 2023 05:09:10 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 04/62] gpio: cdev: use pinctrl_gpio_can_use_line_new()
Date:   Wed, 11 Oct 2023 14:07:32 +0200
Message-Id: <20231011120830.49324-5-brgl@bgdev.pl>
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

Use the improved variant of pinctrl_gpio_can_use_line() which takes a
pointer to the gpio_chip and a controller-relative offset.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 31fc71a612c2..54ee075410db 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2287,8 +2287,7 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	 * FIXME: find a non-racy way to retrieve this information. Maybe a
 	 * lock common to both frameworks?
 	 */
-	ok_for_pinctrl =
-		pinctrl_gpio_can_use_line(gc->base + info->offset);
+	ok_for_pinctrl = pinctrl_gpio_can_use_line_new(gc, info->offset);
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
-- 
2.39.2

