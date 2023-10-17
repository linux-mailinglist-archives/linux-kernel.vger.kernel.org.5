Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D3A7CC28A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjJQMIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343619AbjJQMH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:07:26 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9FC213F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:43 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c50906f941so56970931fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544340; x=1698149140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDbQa4pbNgPSy0Q7qNPPuIZ1OX8+KoCwyythnm8P9i8=;
        b=mYI4b8ge26f4cBfLQjNoyAP6xewpEAX+N+wtc/jQGGHm78NJMqKsuXaJHxKprHo1J+
         kz+LCQAVjftP+LL/Oj1Fg8vOVrLpdTpWxJkAiiWzlt09cj+IoFPQCoZHxrqy2m2e0AX+
         /KcvB9rBOzEHjZw5M5lK0dpx9ayOfj/jetxPzGqgza/9Yy6r9mnEh/qFe3b0jIEulKH4
         0JSaj8G6xOOc/jO5X8a+G7oGMfSPR3I1c61JcduGy7ZgQv3rcYgi2pkdUV/S1QUrypHM
         P4OiSVznNPwULTQxfS9jrcXxYLngx4rKR4bx4floMwUfk3SL120pC/sLvwn0QdsvN4hy
         48hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544340; x=1698149140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDbQa4pbNgPSy0Q7qNPPuIZ1OX8+KoCwyythnm8P9i8=;
        b=UIdlogsjnFpWgEmLrpzSDirk0uWbJKsqtjBfr43RV5eSz4J/DPupCpeT4l/pL963FF
         VqzwbUiULTa4nyAsY8/WErky4py8+486a7FtNo+zbZWkNp6JY9FYNnOs/bknPPpoi6B7
         FtOmEcKgS6gQm6/o4izyDrEQMXcrfovDG9waBxoQ9v7B5LvPzMcFCnZrX32flIhVTo3T
         J//BctDQu8UHxUJuZzLL51YylVrNekXoXr+I5umjT9A7dK8O+pzIAsXKSOws4wRR3+1/
         6slUaDH0yorv5J5HkLWCIxTaAkrwNmCJTnCE/1fOUuv9Zwjafd3ShXIujlAF3IM1RAn/
         CSyA==
X-Gm-Message-State: AOJu0YxywmhL7AKvjIx9mSS0G+LsdDSvlfM+RuTZXnkZkNAmrGVqpIvP
        HwpV0TQ7mZL6XyWhJhaW9WuYIA==
X-Google-Smtp-Source: AGHT+IHN/WqckhmUqxmQwvvCJ12TWzSuYj9MFFn4yz5D/MYVMFJ2znX2y6gYLUB9FdDFmJon/erAlw==
X-Received: by 2002:a2e:a162:0:b0:2bc:f5a0:cc25 with SMTP id u2-20020a2ea162000000b002bcf5a0cc25mr1529232ljl.2.1697544340583;
        Tue, 17 Oct 2023 05:05:40 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:40 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 54/73] pinctrl: intel: drop the wrappers around pinctrl_gpio_direction_input()
Date:   Tue, 17 Oct 2023 14:04:12 +0200
Message-Id: <20231017120431.68847-55-brgl@bgdev.pl>
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

pinctrl_gpio_direction_input() now has the same signature as the
wrappers around it so we can drop them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 0f8e27d16929..f772be70e56d 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -990,11 +990,6 @@ static int intel_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 	return GPIO_LINE_DIRECTION_OUT;
 }
 
-static int intel_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
-{
-	return pinctrl_gpio_direction_input(chip, offset);
-}
-
 static int intel_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
 				       int value)
 {
@@ -1007,7 +1002,7 @@ static const struct gpio_chip intel_gpio_chip = {
 	.request = gpiochip_generic_request,
 	.free = gpiochip_generic_free,
 	.get_direction = intel_gpio_get_direction,
-	.direction_input = intel_gpio_direction_input,
+	.direction_input = pinctrl_gpio_direction_input,
 	.direction_output = intel_gpio_direction_output,
 	.get = intel_gpio_get,
 	.set = intel_gpio_set,
-- 
2.39.2

