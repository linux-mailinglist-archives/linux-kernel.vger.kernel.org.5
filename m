Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BFB7B6C39
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbjJCOwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbjJCOvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:51:39 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97DFE5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:51:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so9992685e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696344693; x=1696949493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6f2Ek6wUAMXrQ0iQTwEIlp72Yx/GmOv3RdXzeN7wCE=;
        b=VsljBR/L4p91DUJCiMBygW13RIDBc/oKl2Vh8llIXH3rz92aHYFX/C3Sa/QeeOmf1E
         m07hfTQuDS7d0YhyU7Z7NwKwh/jfYcqbbihJxmjMZ+29euOn1CJTA3wm1PrSIp4xRds9
         UMSTyhQ9W8yaeHdpbEZOBNjAIGv3h3OqTz8xOfrW/0oeLsrzm2wK0yJ4swV0y4+gkst7
         w8GfOzMYvknSAIO6g9axC3YZCITqP8p6xkvENq+hYOjAKEvHulU8s9WfcqeVcZ/YbxU3
         pMzoEQVrAy+ixwosu5SfeHrS1bLF2Yo4RcK57EidHQVCDy2mrl/fLyteLFHMc3e/1JgN
         K0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344693; x=1696949493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6f2Ek6wUAMXrQ0iQTwEIlp72Yx/GmOv3RdXzeN7wCE=;
        b=NtxmKqKfFb+GvYW1JJbjbue+xgoknKBLEr6AB6jrxYPo75/XBHkZoNAt9a+UesHXyh
         0Z5ggh+iGT6l0qrCWM1c/ia/DfXtZU+boCtg3IkoRZSIRD8i84hlgwb5tBEzvoJtkG+B
         czU3EC3ZMNWog1gvr6AZ8pfhtZ6kaHP6qbrUp8k+KiWmlO8tFg4lmGFaJQ+TXJO90Nfd
         oAOLclwl4bvmVz3+hpP+jo1hj3DRdlhpO9VjadqTgcH8G14lgsw6ZcB5vrjUMM2YZV/m
         e6uViwSfVwHKs2bOn3kfMN9GnxlmeBk5RAJDN9TfxR6QIBmJZ/fiipxXgJPd/MYVi4l+
         CoyQ==
X-Gm-Message-State: AOJu0Yxk0bnnNgUlB0lvzfu00K+R/JzcVXuXfzgqAnjwbix+TVfn2LF3
        +KhidYJQw71WSVJFTlDnEnZf2Q==
X-Google-Smtp-Source: AGHT+IH6y9GBPSV5/VueicE1G8fZ89J4CKXlTPhCV1NN8mHj//Qi8MPfLlyjb0HmUghciIpzzhpzAA==
X-Received: by 2002:a05:600c:b56:b0:401:be70:53b6 with SMTP id k22-20020a05600c0b5600b00401be7053b6mr12193455wmr.15.1696344693054;
        Tue, 03 Oct 2023 07:51:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003fe29f6b61bsm1462773wmr.46.2023.10.03.07.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:51:32 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Subject: [PATCH 13/36] pinctrl: nuvoton: use new pinctrl GPIO helpers
Date:   Tue,  3 Oct 2023 16:50:51 +0200
Message-Id: <20231003145114.21637-14-brgl@bgdev.pl>
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

