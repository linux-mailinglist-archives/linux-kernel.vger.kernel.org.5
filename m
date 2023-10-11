Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7707C5329
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346936AbjJKMKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346775AbjJKMJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:09:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E893139
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-504a7f9204eso8291014e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026165; x=1697630965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgDYd9Rguhjm4qQEjlLUgCLw45ItMDY7i661tMI87TY=;
        b=NXGqg7APoSGYbHOIRd/00LSae6AR2vx9ywofXAB0/1n79w0jDUWUeH9EkFX7Jam5Om
         X79sA9rgO1JlZrMLku64Tl92bMzoqBtM5DHUTbLzapDZ3uXnGO7zdj+B3Tji2IbBoYdr
         k8nxD9I/qM4l2MwAhzS1VHkZzraQQyuomLtUkSw7/XGa6SU2CShoE7vxeKSYTTgwBAJZ
         3uZ41alpb/3zjgTiMCkAkNePr49ZsYgSuRd388Lh0t3/ITyXTDTTVMbERxtj08BsfQo1
         mp+HF0FBSEDhld3mMy1SlctXGSbNR4hCZmevM1h7O/3IVxJNUI2ZTIQhoW/D/thHLMaV
         KUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026165; x=1697630965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgDYd9Rguhjm4qQEjlLUgCLw45ItMDY7i661tMI87TY=;
        b=jIGVEYnO5NP5eMpBnT1byID3TEdva6wWxTYkxVcN40rC3pR0iS+zxV/ifjfP0bdsYb
         lKF3wZKsvwtPq5+Gd4z8fbWi7f3jjS3GfTonxJ+dsTyKRjMj5z4N0V1CXkAwySmXgW+e
         JVsQCdfSOXXoH3uwKLkRv3XY9ZUBuqL2XAg7IvV5c6Pc7xspyVrWnR/IDZogAL7aXUfB
         evw0UsLQLKC/7DSG/WyAeDRqJ1Rcrrw8nVJ1wYejRikg4p/cC6K1Lr0Wd/vJlCHjAQIu
         S3eMD9VncU7D6obM21EOHcx0JeGk1jhKi3EtNz7QZ8ROxJ8omMmyrimoIXycIeB6tVQn
         biMA==
X-Gm-Message-State: AOJu0YzQ0DEUjG0Ai3rLLpFUfaadIJqWs6E+/6LFJhyHxZ6IdpjyfD/T
        vKs7pV3Sc0TcPVdJ5+EkrnYXfg==
X-Google-Smtp-Source: AGHT+IF3ZBeCHQ7UxXAI5x4hDZ/wVHmC4NXEoeGBeKjkPKX50TSAw6cbyyvN919Y1osgvewm9XIvUg==
X-Received: by 2002:ac2:5fae:0:b0:503:1998:b48a with SMTP id s14-20020ac25fae000000b005031998b48amr14881273lfe.62.1697026165466;
        Wed, 11 Oct 2023 05:09:25 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:24 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 20/62] pinctrl: rk805: use new pinctrl GPIO helpers
Date:   Wed, 11 Oct 2023 14:07:48 +0200
Message-Id: <20231011120830.49324-21-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011120830.49324-1-brgl@bgdev.pl>
References: <20231011120830.49324-1-brgl@bgdev.pl>
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

Replace the pinctrl helpers taking the global GPIO number as argument
with the improved variants that instead take a pointer to the GPIO chip
and the controller-relative offset.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/pinctrl-rk805.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rk805.c b/drivers/pinctrl/pinctrl-rk805.c
index 2639a9ee82cd..58e6dd932bc7 100644
--- a/drivers/pinctrl/pinctrl-rk805.c
+++ b/drivers/pinctrl/pinctrl-rk805.c
@@ -289,14 +289,14 @@ static void rk805_gpio_set(struct gpio_chip *chip,
 static int rk805_gpio_direction_input(struct gpio_chip *chip,
 				      unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input_new(chip, offset);
 }
 
 static int rk805_gpio_direction_output(struct gpio_chip *chip,
 				       unsigned int offset, int value)
 {
 	rk805_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output_new(chip, offset);
 }
 
 static int rk805_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
-- 
2.39.2

