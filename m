Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE4D7CC236
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343496AbjJQMFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjJQME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:04:58 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383EFFF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:04:56 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so52210981fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544294; x=1698149094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJlcPxZYJ+2xOtgJ5lT3aANbc/q/A7LyEHQjQgc784Q=;
        b=fJfvs3CnP2qp5WbXgHrOpeYrdgkw15gut4Sa2lJmawhADnds+CBtLRhddGne0nJKze
         luRwQ+KLcciyw2wjmPtqTWd2nbXdSxV+TAAuVNGQHl++PwaIJF7xHZGnF4LO7m3ln/Ph
         LlFj0vjjciZiO4owfbToqgT+IHYdYeGNYKce/t/y2RoPrEdyttG9OSp3+f97gsYTO3uk
         WdDp8LZeMLCC3KW+m47/HvJBCKLO+c9IDvcpsQx/XJ2gK/e1ELmWwxYyGLzWGObnFyOF
         MxnZGXC1qsj/EROSJBkOmUzjJ1ASy7w0Alo81k57ZFmmeIS8+x4nOi4j0kPFjIR1WOGs
         0UZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544294; x=1698149094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJlcPxZYJ+2xOtgJ5lT3aANbc/q/A7LyEHQjQgc784Q=;
        b=pXJWjD7wWeBSCKeizlKMUZHM8fQDr/JJq+VTVeVZOP6CTnC0Admv95eGvR+g/mMJhy
         sJXlo2DOkJSw9as0SoWClNYmM9GKgpqCj+4HXuOhFEII5M4uExY7c01T6RR0ZEemt8Fx
         8wM2lQmPgMG5KuRiwd1/M+kTlKftf85Tfl6yKFZSEdYr8HAyECA9ZcgMVr8XaYKc3iac
         bSPwZerGh7pixO6WcpUUuSKYEw4mq3/6I6W9V7cbiSqmfYq37dfJwXpMhqQnalkFCSUv
         rYUHqa2VVToCAIuHlvBZ4E/U5vkopHQGd4/7d+s/xbKQaiLalWSM297LV4qMD9Ak9caH
         Q0ww==
X-Gm-Message-State: AOJu0YxYxiHp2oJC/4LUAlRx8m+mVPRS7VR1smO+lFK9DeIV+m/AqviC
        Rn9u/HioAyDlAfA928HWg7Aiig==
X-Google-Smtp-Source: AGHT+IEO2/sj/qTg2E4G20vfzB2LnuPMvz2vyam82jVzc62j2bqztktVHSf9Uq4DvlJtqAeTSYxYFw==
X-Received: by 2002:a2e:9604:0:b0:2c5:1603:9c48 with SMTP id v4-20020a2e9604000000b002c516039c48mr1638646ljh.20.1697544294507;
        Tue, 17 Oct 2023 05:04:54 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:04:54 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 06/73] gpio: tegra: use new pinctrl GPIO helpers
Date:   Tue, 17 Oct 2023 14:03:24 +0200
Message-Id: <20231017120431.68847-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
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

