Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBE77CC29A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbjJQMJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbjJQMHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:07:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5794426A8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso4129595e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544345; x=1698149145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZqsH4ukWg8dp7mZFhLrP2ADJHJW7V1bq0dpTxn7+d4=;
        b=Iq1DEkCJyf74Eh8GJ/Efr891aLtBnfMpBjFVOBThjueAGkIcYWTn84YwEg1jIkjkzj
         /1yLkN/BT5jJOkAQkOrxX7pX27R2YawzkBnpj0jhWgOfpaU5k3GXyPh/XgsE6upNz5bW
         /sSV/zYp1O7jO5+QES3HjYe5VSfUeHASkiMdsBEZ+BJMQOV1PCbsVKZwtS32sG93Cm9X
         YWDXIncFJ7iA6sjNDNa/UcuTT/QG4BRCXL6577wK4BMPaHnTW9VRCLCdiQiZ2etB+kCK
         4ASmM0H7LYfSsmWnK6mDNs1boApbmLd7IKo7Zy0wIKN+PWpbM+zQXTbSl2zf0oZd+uT+
         gCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544345; x=1698149145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZqsH4ukWg8dp7mZFhLrP2ADJHJW7V1bq0dpTxn7+d4=;
        b=CbUQ9ieDTl1GY4LxwuBF7R7Pat2Y4f4xLb6CPZAwkmZBTMGTWKKxC9/E+q111Q30NE
         osinCFEizL//jjEVKUYwwp8uqxz84d8C/V8VwJTZVfMx2dX0tanq1uOj425RhSpFT0YY
         xz0nb//mziqKsjkyBA9SpC3IF0JmX16hxuKb5PfanqLGVHz27G46fVSO53SUk4bLrEsW
         FliQ+/GVvxLhqzfldRAGBcTSiIB4VQrfkmD9lidi7DIZLYnXNkEj18UdVkP6zSrFk0Un
         fLuIKrw2gqLTw1IjJLmGeaeo4A3IEA7I+8xhZ+7flKCdZTQfmKnmW0BSJpLVH6Fyht7K
         jMsg==
X-Gm-Message-State: AOJu0Yy3VJbvutuZsvlkP/tXn8UimQm8n+CMFK/LZGaE9/O3a5NMogSt
        p5tS1z4puCJ87WoZKUhxNxkglw==
X-Google-Smtp-Source: AGHT+IH0yWFOp9rKJ0cOBfUSaAmYAWjud/N6WGuc8A1DibebU/JZOq50dqOAWD6Ha/rOJpk+qlKpfw==
X-Received: by 2002:a05:600c:1392:b0:405:3955:5872 with SMTP id u18-20020a05600c139200b0040539555872mr1630146wmf.18.1697544345467;
        Tue, 17 Oct 2023 05:05:45 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:45 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 59/73] pinctrl: cy8c95x0: drop the wrapper around pinctrl_gpio_direction_input()
Date:   Tue, 17 Oct 2023 14:04:17 +0200
Message-Id: <20231017120431.68847-60-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

pinctrl_gpio_direction_input() now has the same signature as the
wrapper around it so we can drop them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 04285c930e94..adecb7d85da1 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -552,11 +552,6 @@ static int cy8c95x0_read_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
 	return ret;
 }
 
-static int cy8c95x0_gpio_direction_input(struct gpio_chip *gc, unsigned int off)
-{
-	return pinctrl_gpio_direction_input(gc, off);
-}
-
 static int cy8c95x0_gpio_direction_output(struct gpio_chip *gc,
 					  unsigned int off, int val)
 {
@@ -814,7 +809,7 @@ static int cy8c95x0_setup_gpiochip(struct cy8c95x0_pinctrl *chip)
 
 	gc->request = gpiochip_generic_request;
 	gc->free = gpiochip_generic_free;
-	gc->direction_input  = cy8c95x0_gpio_direction_input;
+	gc->direction_input = pinctrl_gpio_direction_input;
 	gc->direction_output = cy8c95x0_gpio_direction_output;
 	gc->get = cy8c95x0_gpio_get_value;
 	gc->set = cy8c95x0_gpio_set_value;
-- 
2.39.2

