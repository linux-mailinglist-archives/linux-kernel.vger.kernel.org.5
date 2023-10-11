Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D677C530B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346313AbjJKMJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346387AbjJKMJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:09:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A942B7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-406618d0992so65240665e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026153; x=1697630953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJlcPxZYJ+2xOtgJ5lT3aANbc/q/A7LyEHQjQgc784Q=;
        b=mfKRNXwqSKH+2YHokj16KJld4cVsvnY0UhCgpiBBqXKh0JyD9Fy4hwnGDeVccdoMa2
         BbBR9uPxxebavQWK/L46oLyrpdQD98xj3AQ4aN2vKvE7fwFMxqZhTyGmPOwhFu6ir0vS
         XS8BsRp8vBP/w6EQa9XgTREmZH4coO6ZD5JJ+Kxj2jIV0hK6kU/Dl8e2jtmbA/t9FiWV
         tS+MDxFGzNsYPo8slzm+eD60eBAQS986yOmeyO08eUwls70MbldDWKjuWMlNDxwSQTZ5
         g3P0B3L9fUvxON/Vz9b3OGhRL+k7v8FvQQGanMVqSmqBx4nlA2NmxYT1Z8Pl8iWAQN21
         +6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026153; x=1697630953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJlcPxZYJ+2xOtgJ5lT3aANbc/q/A7LyEHQjQgc784Q=;
        b=b2I9Fa22wuNGLSGkb4bxulmxdXS0FVWW/zHVgPBSI365xMDrqKphe/lr8mM+zofo35
         +U6Ge8F5A6HDFhRVcYUGf5o5VlhRT6LpAGLFOieryHnG5xVkMDgfrlGirKScoUSzXItc
         RfprSigkiypdrUOfoS4i6x2LrzC2izpKweGt92NPBpU3DYbyCNi/Gai8l/rJV9dnUOK2
         SJKSaN2MIuGtZ6PvzP23USWk7Uuq9DqCQGOpKMjuZTofp39c9uIKenwWVBZnHKND6AR6
         w7XDuS21Ifmc6xq50kCRRkfMqYyWU4OPTNiWhVW+BoPiDt796NO5fjCg+QHCdigfZH6r
         bsxg==
X-Gm-Message-State: AOJu0YzMcjwni8wMF4MOKDS3BC055SSMzZyDZq7ZZwmu4JD8dgw5USeN
        EuiAKpuFVOF4b1OAgrhmCo7LGg==
X-Google-Smtp-Source: AGHT+IGd8u3EUxeSQhN/iBNTJNso3uP64x7DOIOqfn+png+3prvah4wSyH4OmjcFAz6zQK5rRN5WBw==
X-Received: by 2002:a7b:cb89:0:b0:3fe:15f0:dfbc with SMTP id m9-20020a7bcb89000000b003fe15f0dfbcmr18927550wmi.12.1697026152784;
        Wed, 11 Oct 2023 05:09:12 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:12 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 06/62] gpio: tegra: use new pinctrl GPIO helpers
Date:   Wed, 11 Oct 2023 14:07:34 +0200
Message-Id: <20231011120830.49324-7-brgl@bgdev.pl>
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
---
 drivers/gpio/gpio-tegra.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index ea715582bcf3..08951ddcd294 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -139,14 +139,14 @@ static void tegra_gpio_disable(struct tegra_gpio_info *tgi, unsigned int gpio)
 
 static int tegra_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_request(chip->base + offset);
+	return pinctrl_gpio_request_new(chip, offset);
 }
 
 static void tegra_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
 	struct tegra_gpio_info *tgi = gpiochip_get_data(chip);
 
-	pinctrl_gpio_free(chip->base + offset);
+	pinctrl_gpio_free_new(chip, offset);
 	tegra_gpio_disable(tgi, offset);
 }
 
@@ -179,7 +179,7 @@ static int tegra_gpio_direction_input(struct gpio_chip *chip,
 	tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, offset), offset, 0);
 	tegra_gpio_enable(tgi, offset);
 
-	ret = pinctrl_gpio_direction_input(chip->base + offset);
+	ret = pinctrl_gpio_direction_input_new(chip, offset);
 	if (ret < 0)
 		dev_err(tgi->dev,
 			"Failed to set pinctrl input direction of GPIO %d: %d",
@@ -199,7 +199,7 @@ static int tegra_gpio_direction_output(struct gpio_chip *chip,
 	tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, offset), offset, 1);
 	tegra_gpio_enable(tgi, offset);
 
-	ret = pinctrl_gpio_direction_output(chip->base + offset);
+	ret = pinctrl_gpio_direction_output_new(chip, offset);
 	if (ret < 0)
 		dev_err(tgi->dev,
 			"Failed to set pinctrl output direction of GPIO %d: %d",
-- 
2.39.2

