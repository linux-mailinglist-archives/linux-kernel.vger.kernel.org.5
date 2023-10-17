Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E3D7CC241
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbjJQMFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbjJQMFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:05:20 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0CC12F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-405361bb94eso62866485e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544302; x=1698149102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHI6d381lpIvDTYFHvoZ0PRRcyIxnTmGZ3C+R5KwSLA=;
        b=xpGnHqrZuoCz6+EV12Afs8+S1U5sJTTraQOcG4CxG5k5r234LOCcZsW+Ub34LyYR4A
         m2y/Zyu7Ed7KxqnBtrXHNsK4LKrff36ZjSbZGzU/kkTrbzqWFvZT9P+fp8Y5RfAjps3j
         Ec2y6N51A7yprRuAoLof+Q+abltqPWl42bQaAE8FS16EckYbxTNQSCWyPL0iRzdIdEuc
         qoxa8mrMGxPeYWacg4/m0UqtQL/JXGy1eFPypeZSeN6d5L5qF3iJNSKWH+OCrq7sIg4m
         t2pOg8vqY2sIBz0hC1QL5/7mvY7diwN6WefDda1qANwgbnCp4fUdWpmVoe7TXmbtvlOX
         6zfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544302; x=1698149102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHI6d381lpIvDTYFHvoZ0PRRcyIxnTmGZ3C+R5KwSLA=;
        b=c9HAANhdojgbdzDLLIn227eoowbvpG+KjgAaNI1yKaa8CacceO/RZaM9Zo3ouEVpeM
         7090lchvbG/+Awhm5YbLmd8jvxGwnc4iqS6uOf7SzU+SFaU27FnYa5lWEKluJNIiG6tJ
         A405GaiJcDWidJ85ifFOGXOkdrAnG5VE41+VYt60PeW9J/J1waHyxcskeczIdZyj38Ze
         JX2Wb3Vdj5S1OzSc4Y5E/XCB2sEslSySHgANw1OFeQvlHSenzyTkGElm+rcgHxBHnfI7
         vbYcF2RPURI+ZeZTMyVRP7ZIJgaf1/DcrJqqcatSu6OzGyRCbmKMBdyMHkOzrufWMNxY
         onfg==
X-Gm-Message-State: AOJu0Yy/nup/ZxOmBJrX0PPWJZ8HrkzXnttS7sfMCWrcQ+9P88WcvnUa
        9YvV7WWp8AymO3o1TvxAIr/MJQ==
X-Google-Smtp-Source: AGHT+IEZXS/C3l9TxoArNZaOgJVdtOfkTccpusxbFvRTIJTxzaX3Jx0VGHsyc/KxyBQRFu/tYhvF0g==
X-Received: by 2002:a05:600c:3b13:b0:3fb:feb0:6f40 with SMTP id m19-20020a05600c3b1300b003fbfeb06f40mr1702876wms.11.1697544301931;
        Tue, 17 Oct 2023 05:05:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 13/73] pinctrl: nuvoton: npcm7xx: use new pinctrl GPIO helpers
Date:   Tue, 17 Oct 2023 14:03:31 +0200
Message-Id: <20231017120431.68847-14-brgl@bgdev.pl>
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
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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
-- 
2.39.2

