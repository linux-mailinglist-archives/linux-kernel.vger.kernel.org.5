Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162E97B6C50
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbjJCOwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240253AbjJCOvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:51:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E1DF1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:51:38 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4060b623e64so6338675e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696344697; x=1696949497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGIsRy8XjuOZvKHt9t36YQP6zzvIBqko3/T4/ujae7w=;
        b=PU/F6s6j7k/zkzXy9y/UonWjmhRyUiVXR3TtUxs3as+kEAiHKrF7zqFhIt58KeIDBK
         OLuvrHUN2hTyute2gRo9+ZcKBStowLJ7yuCz4pJiPip+hnued0xzP8h/ihbM4yeo62KP
         4XWhaIvvIk/rCrKE3mL/srp8CObJ86M4AoYTEdPo7FD+pRdbnHXbbc3I2KnY630hriNX
         CHCpYMumrecTsDx0bBxDJ+QNt8Wi8+7C3t/lfcGJbL/bIRFV9Jl+i+4tA/ODF3avbOaF
         co4Bdkt1WUmplaI2r+NbrM1tsPd+Tf5Aq9i0tZ5vGrqchwR9QJWlxEZstgEQ5pXYnvsU
         jQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344697; x=1696949497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGIsRy8XjuOZvKHt9t36YQP6zzvIBqko3/T4/ujae7w=;
        b=OyhbGhvgXnX3CzP+u/IjeJS47+zdxCOzHke5BRHpztq+dsbaSMD01yywisH30BS9/r
         LAfLMNAl1Zae30Ckx38OaF6VfgdjLVzNsQMR+YRz9FUcbVEMC/D/m4xbdJm5kxlOWGTI
         5mRqKid2tXUNKjnSlt/gTKAnZGennQWnonPdnvcy4IJTxcB7SrOtpJJFVaP/kTKGGgry
         Ms2oIzgW8ZwtQXxr+pakD/1+snN5GTF8+WIqMbFYqFbhROwCDG88f8QDicdE+YZk3QxH
         Zf7EmVan5gt8AC8w3oEFprtd45tuj2m1EF1trnVARJcC+rQSk7tFYQMQftXD0pN2Fl00
         9rag==
X-Gm-Message-State: AOJu0YzEzshTl0bVGhE6XC76n9ZTXvltpQhh9XL4GiKiGLhxfdrce15R
        oscMzfgGj9hEMhwiI6cfc6g8wHWwxOcyEhtsb1I=
X-Google-Smtp-Source: AGHT+IGCN1AwzD044eAjypm6azqxuwq5m2YSstStLS9HejuPHtr65UjOm8Z7e3heoU4owiHAnOZr2w==
X-Received: by 2002:a05:600c:4f4b:b0:403:aced:f7f4 with SMTP id m11-20020a05600c4f4b00b00403acedf7f4mr2371018wmq.12.1696344697353;
        Tue, 03 Oct 2023 07:51:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003fe29f6b61bsm1462773wmr.46.2023.10.03.07.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:51:37 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>
Subject: [PATCH 18/36] pinctrl: starfive: use new pinctrl GPIO helpers
Date:   Tue,  3 Oct 2023 16:50:56 +0200
Message-Id: <20231003145114.21637-19-brgl@bgdev.pl>
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

