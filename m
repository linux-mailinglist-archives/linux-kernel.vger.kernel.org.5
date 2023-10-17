Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86BC7CC25B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbjJQMGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjJQMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:06:05 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7162A10C8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4083740f92dso1510955e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544310; x=1698149110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgDYd9Rguhjm4qQEjlLUgCLw45ItMDY7i661tMI87TY=;
        b=LlSS2DtzY4fcgC9sZwnpYo0Io/0oc/oxalLxA3j4fGHMLITZD3mHE5v+B82dYk77zg
         r0alUG0mKl5JAshaTAbg26j5b3/tyRzp9FRtXUK6u1TUbezllzC5rqqjDPLEHIjv3Kbv
         9bJmU1Btd2ql63Xz7m8aqrj8GnZpTXpz3ZThvgC+kFJ0H4QfenSBiFHJDLME0CizsvtE
         nJ9jwTvhxiW5de87KH8VL8K54uC6RLW1gwtwYZ03Wt3SCr4vaKNUMXii+mXnqxnLDMwK
         9ndkQBAb3RWmPd4vxTTI/0xSrHE1tsC7GPm1A7mtR98QzJI3C/EeWzkm69eTVAkoMS4K
         I4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544310; x=1698149110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgDYd9Rguhjm4qQEjlLUgCLw45ItMDY7i661tMI87TY=;
        b=Qxu/8ITZoPbyEVdOHt7y9YY1YFkW+WflRqHCVNE8B86af3OTHoxCLvupAQvJkZsxs4
         hdB6gDC8+sDnB7Ldv669y66JBM+FZcuk2JzpANA5AXNoxXHuynumAtGfZW7m7TvUo8GV
         VfyvlduGzhT3gBZ5zOrYFjJsWkBi5yGkv0K24/RSaCsb4u0vCYFz1Jxk3RJpWrX6t1Kk
         KUHDS48uYZQesuDASF+v/g02K4EinWYJSJBX0tZvPX1NjK7zZJKvpVkzKJrLqQr2HVJq
         7RDNa1kfWummhY6/15mPt9qbmIlXKOdvIk875V5R60UPKHc0Qdt35ncXosRZaqlVZ3go
         ZiqQ==
X-Gm-Message-State: AOJu0YwdZRIN8ipafl8+M9TGr2kLGjHyo9fpIle8w0YsjNCUE/NM8kO1
        MrHQvPSVyh7PDMjjG9MZPKDciw==
X-Google-Smtp-Source: AGHT+IHoqOXAdwuaCibM3AvmWGcF7ULgsBaShA2+HrC8/rd7yKj5B3ysn1O2JoofsH7u7HJrI45SGA==
X-Received: by 2002:a05:600c:4455:b0:406:4a32:1919 with SMTP id v21-20020a05600c445500b004064a321919mr1546165wmn.29.1697544310101;
        Tue, 17 Oct 2023 05:05:10 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 22/73] pinctrl: rk805: use new pinctrl GPIO helpers
Date:   Tue, 17 Oct 2023 14:03:40 +0200
Message-Id: <20231017120431.68847-23-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
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

