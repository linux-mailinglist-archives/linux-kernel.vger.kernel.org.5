Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DE77C5318
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346867AbjJKMKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346649AbjJKMJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:09:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6EA91
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405524e6768so65065845e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026159; x=1697630959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6f2Ek6wUAMXrQ0iQTwEIlp72Yx/GmOv3RdXzeN7wCE=;
        b=dzR5nyuY+jQz+C1n+mkdc+f+cUiIeUmqz82UagoVHzlPGx8TaHvndDGPqoLsc1M1k8
         kMPym9S2uOc9L0GbHoTiP5JwBU8ZrUCNB9bXdX61dEUvLcEgiB3MoeWn/8FNXsAc6EA+
         5vZjXVzaxeDQLTwwKs8vQ6HqcgqOnJ2fDGVotKjk77Q30zfSYjZUhnHOVMXry+AiMUcx
         4hoOAkFzCcjV4Mcx9WC/GlIo93FSaCfLDRVcDAeYoSyu11tIei1XP+JBOILpCvPF5doD
         MS8NfFKLHKvgmorRmB+ot+gYx1blCqonSzAAl8Hnom/cmShgIfP09lqg/m72DYnB43w/
         vkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026159; x=1697630959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6f2Ek6wUAMXrQ0iQTwEIlp72Yx/GmOv3RdXzeN7wCE=;
        b=PV7je7zV6WXbNSz+g0s2FMRgLFOOJwDyussErN6o2hIQoKgSiT5WfSVDacsSturgKh
         +IPLFFPyEZmfZcgYIiV2s12Qh2IeHLk5f68OSClaPrEEm5KQBo8pjQ2MALemhna2NobW
         Fi6jXhQfmm2X0xSYApwGH0taraPPWhjGiPGbxZvemSLXBSKvoa60aEaKiCsJAFa91Gif
         q2BAm5Ie0meUUqpUvMoIEZnpQl6gJHxgPAlQWosDWV0vccFyeapqXivGl+Q2Q8KN3/Gy
         LtlDgHr3ZzW57JNqGpNtLM/qTip7eH/D85BBmsfHgzvsd1w7+mdLUbGm6A9nLDr+BMfS
         EyOw==
X-Gm-Message-State: AOJu0YzN4rjye40dex6QQtk1XTrknalpVCubC2Y3ldTcrRZL86qpS8Dv
        FqfqoWyjtAQUO05blr6iPPqkuA==
X-Google-Smtp-Source: AGHT+IFPwvD7l0Q28mPezig2fI7XmnEslb/COLkFqUN9cMZV99oxKddRGq+vSalkycgSAEACAmVjaw==
X-Received: by 2002:a05:600c:24c:b0:406:44d2:8431 with SMTP id 12-20020a05600c024c00b0040644d28431mr17812077wmj.6.1697026158980;
        Wed, 11 Oct 2023 05:09:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 13/62] pinctrl: nuvoton: use new pinctrl GPIO helpers
Date:   Wed, 11 Oct 2023 14:07:41 +0200
Message-Id: <20231011120830.49324-14-brgl@bgdev.pl>
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
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 8 ++++----
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 8bdd0124e2eb..62134a7f0b4e 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -171,7 +171,7 @@ static int npcmgpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 	struct npcm7xx_gpio *bank = gpiochip_get_data(chip);
 	int ret;
 
-	ret = pinctrl_gpio_direction_input(offset + chip->base);
+	ret = pinctrl_gpio_direction_input_new(chip, offset);
 	if (ret)
 		return ret;
 
@@ -188,7 +188,7 @@ static int npcmgpio_direction_output(struct gpio_chip *chip,
 	dev_dbg(chip->parent, "gpio_direction_output: offset%d = %x\n", offset,
 		value);
 
-	ret = pinctrl_gpio_direction_output(offset + chip->base);
+	ret = pinctrl_gpio_direction_output_new(chip, offset);
 	if (ret)
 		return ret;
 
@@ -201,7 +201,7 @@ static int npcmgpio_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	int ret;
 
 	dev_dbg(chip->parent, "gpio_request: offset%d\n", offset);
-	ret = pinctrl_gpio_request(offset + chip->base);
+	ret = pinctrl_gpio_request_new(chip, offset);
 	if (ret)
 		return ret;
 
@@ -211,7 +211,7 @@ static int npcmgpio_gpio_request(struct gpio_chip *chip, unsigned int offset)
 static void npcmgpio_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
 	dev_dbg(chip->parent, "gpio_free: offset%d\n", offset);
-	pinctrl_gpio_free(offset + chip->base);
+	pinctrl_gpio_free_new(chip, offset);
 }
 
 static void npcmgpio_irq_handler(struct irq_desc *desc)
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index da21f6a45888..0b6d6964087e 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -173,7 +173,7 @@ static int npcmgpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 	struct npcm8xx_gpio *bank = gpiochip_get_data(chip);
 	int ret;
 
-	ret = pinctrl_gpio_direction_input(offset + chip->base);
+	ret = pinctrl_gpio_direction_input_new(chip, offset);
 	if (ret)
 		return ret;
 
@@ -186,7 +186,7 @@ static int npcmgpio_direction_output(struct gpio_chip *chip,
 	struct npcm8xx_gpio *bank = gpiochip_get_data(chip);
 	int ret;
 
-	ret = pinctrl_gpio_direction_output(offset + chip->base);
+	ret = pinctrl_gpio_direction_output_new(chip, offset);
 	if (ret)
 		return ret;
 
@@ -198,7 +198,7 @@ static int npcmgpio_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	struct npcm8xx_gpio *bank = gpiochip_get_data(chip);
 	int ret;
 
-	ret = pinctrl_gpio_request(offset + chip->base);
+	ret = pinctrl_gpio_request_new(chip, offset);
 	if (ret)
 		return ret;
 
@@ -207,7 +207,7 @@ static int npcmgpio_gpio_request(struct gpio_chip *chip, unsigned int offset)
 
 static void npcmgpio_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
-	pinctrl_gpio_free(offset + chip->base);
+	pinctrl_gpio_free_new(chip, offset);
 }
 
 static void npcmgpio_irq_handler(struct irq_desc *desc)
-- 
2.39.2

