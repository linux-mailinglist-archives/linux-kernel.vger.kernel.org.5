Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029547C531F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346890AbjJKMKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346779AbjJKMJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:09:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F21111
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4064867903cso68964775e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026163; x=1697630963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGIsRy8XjuOZvKHt9t36YQP6zzvIBqko3/T4/ujae7w=;
        b=ogF4wQxOzbxNLYMKl2QlYia8LNhS3PDHvYVQtIGsi9yAFbf2qr2O99dX4vnc2BckDv
         MdgFrSoQaKWNrAIrkk79Juj4sbh1FIkww0L11GST9dAplcr9PZgs/lGPpovK7dC4J1oN
         LVnEpEzKlJwpP9+iY9dgKo4Jqynsg8MFj+Rr5SltbRSl0Wo6Y4iopD80UIW2wj9Rn+Wv
         xZtW33yvIbhbAhxYXJKP7KJssSC3Ai3Wt37jdP5zBkXWaQZvHeXX8uEzI9IA9Ls+nY8P
         q8UpPlpL4S4uYleliQ1Otddj4KeSrakRgnz1t3o7ZmUWGC9WiBjVF6tqiBqG0MPEXO/T
         z8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026163; x=1697630963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGIsRy8XjuOZvKHt9t36YQP6zzvIBqko3/T4/ujae7w=;
        b=X/6iBxtEL1e8qxBpbephNjB0s0lFjObkIiSjFfEoFkqRgT1Yl2d0dmJoadA1A6oCF0
         /+mx+vzP42GN4XyMfET3/675OzunWyt1hY2DqB8LodDB4YYce8/fsIwicK4XlPNhxuba
         gBPxxRq6gTTgG4+eNIdNobh/WX7Vh22yVN9DZ/k43JoThUOxAxEgCTT4FPGj/0Tko+Z+
         uzCNCutKy5vsLVRgNY3858veFSxHqYtuBuaxHmBg0qvSBdaUmXMj/6AToqQ+NViS6rzt
         7qFFbszVeWOdw326vEZZWJgSZ8aKlRWaNz1vflA2j1zn0HX8Su4chY1JzWPIBYeoAUoz
         Zn8w==
X-Gm-Message-State: AOJu0Yxv8gv9tr1tzF7QW/jKc34TEZ0viqX1gl457bs5uKUs1sEJW6zr
        N+7n3ok1RTI8whMU06LYZ1PYVQ==
X-Google-Smtp-Source: AGHT+IGdEhAgTm297jLZLMTuTEEFLfn05De/g59KDtEQqmhzLoWxNwNsUvx1pSF9h0Tw+KieCl6FQw==
X-Received: by 2002:a05:600c:294a:b0:3f5:fff8:d4f3 with SMTP id n10-20020a05600c294a00b003f5fff8d4f3mr18972034wmd.7.1697026163661;
        Wed, 11 Oct 2023 05:09:23 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:23 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 18/62] pinctrl: starfive: use new pinctrl GPIO helpers
Date:   Wed, 11 Oct 2023 14:07:46 +0200
Message-Id: <20231011120830.49324-19-brgl@bgdev.pl>
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

Replace the pinctrl helpers taking the global GPIO number as argument
with the improved variants that instead take a pointer to the GPIO chip
and the controller-relative offset.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 4 ++--
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
index 530fe340a9a1..22a2db8fa315 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
@@ -918,12 +918,12 @@ static struct pinctrl_desc starfive_desc = {
 
 static int starfive_gpio_request(struct gpio_chip *gc, unsigned int gpio)
 {
-	return pinctrl_gpio_request(gc->base + gpio);
+	return pinctrl_gpio_request_new(gc, gpio);
 }
 
 static void starfive_gpio_free(struct gpio_chip *gc, unsigned int gpio)
 {
-	pinctrl_gpio_free(gc->base + gpio);
+	pinctrl_gpio_free_new(gc, gpio);
 }
 
 static int starfive_gpio_get_direction(struct gpio_chip *gc, unsigned int gpio)
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
index 640f827a9b2c..5557ef3fbeb2 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
@@ -547,12 +547,12 @@ static const struct pinconf_ops jh7110_pinconf_ops = {
 
 static int jh7110_gpio_request(struct gpio_chip *gc, unsigned int gpio)
 {
-	return pinctrl_gpio_request(gc->base + gpio);
+	return pinctrl_gpio_request_new(gc, gpio);
 }
 
 static void jh7110_gpio_free(struct gpio_chip *gc, unsigned int gpio)
 {
-	pinctrl_gpio_free(gc->base + gpio);
+	pinctrl_gpio_free_new(gc, gpio);
 }
 
 static int jh7110_gpio_get_direction(struct gpio_chip *gc,
-- 
2.39.2

