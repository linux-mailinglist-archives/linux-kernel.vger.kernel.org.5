Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDF27B6C58
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbjJCOwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbjJCOwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:52:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8191B3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:51:43 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-405497850dbso10121025e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696344701; x=1696949501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L71FhZFxQS/v+Kb2FZmLTi+Zct1vRjkWo7sxYZsb/pk=;
        b=ehH9dnNkTsAFzKXl9wp5BTCtWFJ8Ib7oce23tSALCCObFjAhhAzfJjio2ZlkBzkGT6
         R6LfHkQHkCal2t2XHDtbND7AegPdgdNKV+nn7MWVQEPhLjEjDheULuzeDbyfIGLxNN93
         vkmvHah1FT8Qh9TllnIjftcGfWvu0Hu59UJON+MjUvsjKIus7qyL67bv1JqvPC7gGMA1
         +Q3RAQ7PyZE41gs9pief71F7i/ayKnywz+1k2w1CX1gIqWwBWo/iGBO70AUnbZFoqlUW
         ebmw8MJUuiLr051H+gD4Z7G5M8aKBoCIhn8vvoBHXeK53Cqyof/NVLSshS7cCVL3Wbd6
         RzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344701; x=1696949501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L71FhZFxQS/v+Kb2FZmLTi+Zct1vRjkWo7sxYZsb/pk=;
        b=Hy6hb8yxkn5JWxEHY7Oqq080mMPbSp+b+OXpoknNSfPyfK7BR/LA8zWY6qkXRzvfnI
         GRdSoWS/1eoL9Cgqj//dZogPh0+pEicSiPQd7RAlBDi2dElr6J64L/vSfgPuqVVlu94T
         prGKvdz4vlzvKTuWxx6iaCM8SJ/Kw4J1ktZhftx1YoyJPKXzZRBG7wuz1ndMD35wkbyC
         v81bV1ZPB91GKx8tBwnSetoRaSl29PKXnWrc/kj+xycii6ms7J2fRCgTf1CXfD6/g0rL
         HEU+/x8uGw+WGr7VTehNY2HTDaDy9MvbcRDSNGPu46yUyl+SqXxKYtKCPNW8q5acbl7T
         u4DQ==
X-Gm-Message-State: AOJu0YwtHpybDr3DJ4oEK8D1Bd8Jh8MPUvWdhqmxAkSQ0/onO0fhF/g2
        7EleAZi4Yoh0ZNT2MwLWZbsa1A==
X-Google-Smtp-Source: AGHT+IFpgJR8jX4WZ4MEHUckdWS9LRZrLndEAQ1pHTOpK8bldfDDXYffd5Wm7Bb0iTzDawrXwod0XQ==
X-Received: by 2002:a05:600c:2317:b0:405:3a3d:6f41 with SMTP id 23-20020a05600c231700b004053a3d6f41mr12365579wmo.22.1696344701465;
        Tue, 03 Oct 2023 07:51:41 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003fe29f6b61bsm1462773wmr.46.2023.10.03.07.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:51:41 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 23/36] pinctrl: axp209: use new pinctrl GPIO helpers
Date:   Tue,  3 Oct 2023 16:51:01 +0200
Message-Id: <20231003145114.21637-24-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003145114.21637-1-brgl@bgdev.pl>
References: <20231003145114.21637-1-brgl@bgdev.pl>
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
 drivers/pinctrl/pinctrl-axp209.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index 9f5b3ab8e184..d7f081f1d1f6 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -126,7 +126,7 @@ static int axp20x_gpio_get_reg(unsigned int offset)
 
 static int axp20x_gpio_input(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input_new(chip, offset);
 }
 
 static int axp20x_gpio_get(struct gpio_chip *chip, unsigned int offset)
-- 
2.39.2

