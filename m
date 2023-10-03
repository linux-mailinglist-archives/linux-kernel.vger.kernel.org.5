Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5319E7B6C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbjJCOwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbjJCOwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:52:15 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7614CCFB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:51:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso10483605e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696344706; x=1696949506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ijntmg1NBQ+adP3gjGt2F/CBhwsfnlyjkrlVEXH9faM=;
        b=D3deot8IHzF0xI1bp70GXfbz5+XWcG0rVt1V9/apGDrDAHA/86y6c++BT7a1Hyejb7
         bq19Z85abbtlcf/wKMdkBk38/dQZqBxB7c6+D5+xu/rjlykQ588rZZdoPXGwSB5Gvvvl
         doaIOx8BbTK4AjbmcnU6ZBNjVsQM7fgBgGJi+7g58wFveKzljt+kwDVjl/P8B1WZJ/XP
         UFjqzve/04ejB1wmcQyt/mziNZagc15rsavwdbpzfvm8ndMUUJdfNc+LLpQCX9B37awV
         HyeO88u14Zf46WN59LuXL6n9TWjo+/D5uJxNkoXQypRl+JQMeLYsS/q+S6qafMLCm2UW
         zXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344706; x=1696949506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ijntmg1NBQ+adP3gjGt2F/CBhwsfnlyjkrlVEXH9faM=;
        b=C8cQUm8m6kIlBroXLMsbfoAH8YrMWDcFLCVg01QsuVWISBf83x7/hd2xN6kV0ujwt+
         VvXPrR3TCDUhwtDWPzW0q1a9QugYAxMgByOdqi/zK55cCUQ2g9495VXk5XWt5M8uoiNd
         U4X++OAhC22HBgfLRzV1jDHJvYv5iFTkviLELz+wdrYI4K3g3S6XMCTiAb7IywzJOzU2
         7E1tE8TuDO1dgjd6vv2IaRZzQrXgRl34s1G+98jmOzjdfl7TatMFxq+I2OZD3AZvaQPZ
         p9mH8PuLaPrX4mS1MTgiXd7meYs5VUD0TmQPHYbb0LQ05ctgqAefwBv3Pf+l4DSOfodR
         3QJA==
X-Gm-Message-State: AOJu0YxUpoJ8H3lKgrOzLDrmM73bKNPJkGOkbT+/DaNNwlZYGbUNyeI/
        zgs18FinYOdzqdixwu/g9NeBgQ==
X-Google-Smtp-Source: AGHT+IFnRiXJu0GCtlwU7UjGJn5IwgcCbfKEsEtqdWmix5CtHmQ3G0xReBIU3tCEEIjMP7yPcRRAWg==
X-Received: by 2002:a05:600c:2205:b0:401:b0f2:88c1 with SMTP id z5-20020a05600c220500b00401b0f288c1mr14200438wml.29.1696344705874;
        Tue, 03 Oct 2023 07:51:45 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003fe29f6b61bsm1462773wmr.46.2023.10.03.07.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:51:45 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 28/36] pinctrl: intel: use new pinctrl GPIO helpers
Date:   Tue,  3 Oct 2023 16:51:06 +0200
Message-Id: <20231003145114.21637-29-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003145114.21637-1-brgl@bgdev.pl>
References: <20231003145114.21637-1-brgl@bgdev.pl>
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
 drivers/pinctrl/intel/pinctrl-cherryview.c | 4 ++--
 drivers/pinctrl/intel/pinctrl-intel.c      | 4 ++--
 drivers/pinctrl/intel/pinctrl-lynxpoint.c  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 81ee949b946d..56a6b67d8380 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1172,14 +1172,14 @@ static int chv_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 
 static int chv_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input_new(chip, offset);
 }
 
 static int chv_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
 				     int value)
 {
 	chv_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output_new(chip, offset);
 }
 
 static const struct gpio_chip chv_gpio_chip = {
diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index f49d6e136018..4897c8425391 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -990,14 +990,14 @@ static int intel_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 
 static int intel_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input_new(chip, offset);
 }
 
 static int intel_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
 				       int value)
 {
 	intel_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output_new(chip, offset);
 }
 
 static const struct gpio_chip intel_gpio_chip = {
diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
index c3732a9f0658..544ea8a607c9 100644
--- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
+++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
@@ -545,7 +545,7 @@ static void lp_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 
 static int lp_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input_new(chip, offset);
 }
 
 static int lp_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
@@ -553,7 +553,7 @@ static int lp_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
 {
 	lp_gpio_set(chip, offset, value);
 
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output_new(chip,  offset);
 }
 
 static int lp_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
-- 
2.39.2

