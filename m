Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D32F7CC26F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjJQMHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343504AbjJQMGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:06:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D75E19B2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4079ed65471so4277315e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544321; x=1698149121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZbQcNg3B/LU86gXN0G+aZQrL0mShPNyFWtL4aswWFs=;
        b=0wJzVaaGbXiIWzduFcHWPdUwaQ4zl9zp7gYqSW58RdmXX8Bh+z9nWxA8qVKxIZnFpn
         hZ8utH+XJLBLEiEuPoOGt/y4N+D6AA2gq/bPq65OHBCw745CtYCFzsdVbUdBFCHDibVH
         wFbxZXPauT50ukx0BkAu5S/Xtd9G3shtqHCKEbkyWyHMyl/yT+W2BHvLpaynDkqGeHbJ
         GQ1+MiErYYLFte505KQ25B406n1uvNVGvAEd4WATKbXeMm8ZVuP5Ioj7lCPPMlX02Qxs
         PWxep3iKI5sDpoG6MXXz2Nfxvx7PsprwxF4JWz3GoTAywMjYAnTeVDRfCgldtcs6ZiHs
         7lPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544321; x=1698149121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZbQcNg3B/LU86gXN0G+aZQrL0mShPNyFWtL4aswWFs=;
        b=m03s180TTArhKn/vJfTuP9CCcnJCMKG7Vb8NJEfOroaJdsHKqZX2r9z+SgtT18qXeh
         Lc3p8UMUOYje5MEJV+z6gqs/9k+Da35xDy8cIpWw3RmluV4XITv06h/VHPcd5VQWJNke
         aJJvznMWumMyycNamkd7/azzpTaCw/TlSSFMPKtBdEGU/NAxRhiQ0YFM8o2n2bb+//cM
         6TJN9FG7AH6RZu8LDIPdK2nTpbBlmYfIywPvpuIyO2MwKjlf2tLrNRCIGLsvnDGIvywz
         GCAw9mgoY4ZZNVEweCrPPAHlK2pSL7cXhWcP0KandW2uiPz2vJGrpetrY5j3ayRsQcJ5
         9x3g==
X-Gm-Message-State: AOJu0YzfAWGM+QwVqPk7NqyVQQhfFRSLtCHQKMOFiAUt74hiasJdJX2n
        GEiabJMukgcNQiZxJLWz4imH8Q==
X-Google-Smtp-Source: AGHT+IEGqhje/Lg4Q9uWy5d7TptwFdHZ6a1KmpZGQ6Lm5urjoTanWnJa92JWj+6WVwM4Gk+L1e0kLw==
X-Received: by 2002:a05:600c:1c26:b0:402:f501:447c with SMTP id j38-20020a05600c1c2600b00402f501447cmr1604758wms.0.1697544320913;
        Tue, 17 Oct 2023 05:05:20 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:20 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3 34/73] pinctrl: intel: lynxpoint: use new pinctrl GPIO helpers
Date:   Tue, 17 Oct 2023 14:03:52 +0200
Message-Id: <20231017120431.68847-35-brgl@bgdev.pl>
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

Replace the pinctrl helpers taking the global GPIO number as argument
with the improved variants that instead take a pointer to the GPIO chip
and the controller-relative offset.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-lynxpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
index d7bc9ef29fcc..91d228fead45 100644
--- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
+++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
@@ -541,7 +541,7 @@ static void lp_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 
 static int lp_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input_new(chip, offset);
 }
 
 static int lp_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
@@ -549,7 +549,7 @@ static int lp_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
 {
 	lp_gpio_set(chip, offset, value);
 
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output_new(chip,  offset);
 }
 
 static int lp_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
-- 
2.39.2

