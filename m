Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1257FD94A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjK2OYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbjK2OYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:24:37 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C9110D3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:32 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b40423df8so31816795e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701267871; x=1701872671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fr1TOXD+5EiiAKWXZPldv8mvv4Hxfk7OfOL3Vw/aLQs=;
        b=b2ZS6wga3v9XoxDjeUSryuw1P4M6qlXzKNKjP25dKpR2fGbQkDw6OlONxWl6vU+60W
         vBvnnoN19QdApekYchbioO0xkDXZWeS9uGMY315nz8+jc9GCZfp1FYrzehNWBL3In4Hp
         kuqk02sODqkYicoWGnwkgmyYg/mVEer1w2PUL+rrBQYRsF4+6+BBdcXK6SKQQQ9fFzKR
         4/sMLazccw4ZJkEXhVOOBRWtMPpjHfAQDR1CE4JTd+YKPXRU8Al4N+12V5AF0MkwYo0Q
         awHCZ913nFmMcU8BYLhjfODTfHBJXm9gQPVuVQVpsp4quE9tPp9Yz6ZjOMmDGQJ+0n+i
         6q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701267871; x=1701872671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fr1TOXD+5EiiAKWXZPldv8mvv4Hxfk7OfOL3Vw/aLQs=;
        b=iN55S8+k94hyIT9qDXPW0rA7CgZexzzjER/mD2ZHbCaU/zWiVMEGd0gQ4ITg/dktQ7
         J3wgEYs3ss9A1XtqBZAhNbc+P8SABIwot1aV982Zy/8xWpJL38BG90R74R+C6Ae0l2KT
         Ni9OA3VZv6xfA6wL6KRFlJs9GSVGKnFv9T8BexGCU6KMnaY4tuH45NhyPBH6w3ONKT+N
         JoRwrJr5dBr1WtM9thO3pVVg16uLLedHSHy++IyWyvrHJb4IYpeqxohClDp0a7YE9yOX
         KHwiB0vv2G1QVnh3Y4ZUIjHc/q3iaCbNotfOKw9i+Lk1QxV9Iw5QTrwzcdFeYaCTZQ17
         QfxA==
X-Gm-Message-State: AOJu0Ywxn9xLlNqHWWLlCfsSJMECK1SkIzuN8iPhCvYB7ln+LPRf837e
        IHn7nGvY8Z3VZgKrFMhSeJfo8g==
X-Google-Smtp-Source: AGHT+IGXheSQA/LGa1P9UW8p+tbga/Gnp13k7Ued9roRRHog+HQ8GZ429C+BiN61YuawC8IhiKC8tw==
X-Received: by 2002:a05:600c:1c9d:b0:408:434c:dae7 with SMTP id k29-20020a05600c1c9d00b00408434cdae7mr10543652wms.2.1701267871356;
        Wed, 29 Nov 2023 06:24:31 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4520:2f25:4d3a:4adf])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c3ba800b0040b34720206sm2406848wms.12.2023.11.29.06.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:24:30 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 09/10] gpiolib: use gpiochip_dup_line_label() in for_each helpers
Date:   Wed, 29 Nov 2023 15:24:10 +0100
Message-Id: <20231129142411.76863-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129142411.76863-1-brgl@bgdev.pl>
References: <20231129142411.76863-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Rework for_each_requested_gpio_in_range() to use the new helper to
retrieve a dynamically allocated copy of the descriptor label and free
it at the end of each iteration.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/driver.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 9796a34e2fee..6405f6d454af 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -543,8 +543,10 @@ char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset);
  * @label:	label of current GPIO
  */
 #define for_each_requested_gpio_in_range(chip, i, base, size, label)			\
-	for (i = 0; i < size; i++)							\
-		if ((label = gpiochip_is_requested(chip, base + i)) == NULL) {} else
+	for (i = 0; i < size; i++, kfree(label))					\
+		if ((label = gpiochip_dup_line_label(chip, base + i)) == NULL) {}	\
+		else if (IS_ERR(label)) {}						\
+		else
 
 /* Iterates over all requested GPIO of the given @chip */
 #define for_each_requested_gpio(chip, i, label)						\
-- 
2.40.1

