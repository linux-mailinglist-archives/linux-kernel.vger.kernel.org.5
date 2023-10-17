Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05287CC28E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343681AbjJQMIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbjJQMH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:07:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624CC2125
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-406402933edso55836155e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544339; x=1698149139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpzD63FKTnDkoNuJq4Z0rqQ6O9C3QSfgDXXMR4608kY=;
        b=07QgEBSVAhhSADoKzJRmmqC51TqHYqrlj8l0RkLHTIlnAAKJWd4vourKYo3Luqfu3T
         yy+4N8wczQHTuvFGjCfzCvQ3NXE8ablCvICit1QU5B4OTkVZZuDFJdNk/yPz3PvLQ0A5
         WyvpvmtJwnsDiG9vDL3ph6QkH1teax/9xXcOicgORnJ6/1lzXOD/G3TsZWjfaOESUY+E
         bULrtbITrAnBancIIFmg2z7LhOhxilRSi9vmf+qcgeKPe3z4j+6C/kBGzxgzj+XpRCHy
         R+jkrH7dl7B9I/pcKfD/OA0ffVOZQ9P3kNod7Ih6LiAd1lxAdNewdYpH4+8gQY2kHlis
         Pg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544339; x=1698149139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpzD63FKTnDkoNuJq4Z0rqQ6O9C3QSfgDXXMR4608kY=;
        b=WdsRSz07SqqPLzaoLohxRJBV8RhL4yy/HmdY20PD+MwgQFpzR0YCzNekJKTUzn5krC
         wodvqdkre517It13tBWbR7pmC6At7B7s4PokHjBCHYpF5EvK9JOQzuqznRqmWy5OskzR
         MNFVtupklWwVXVi3mlrfXbFA5m0pMuqD88RUY1hS/Pqpa01lErVIVldqsV+FvOVnCm8k
         E1Rps0+KJSVA/T1/4+/lqZLFRXNEprkRs9hpH/yv9jAGCCOqXO3xLD17I+dGUnHrODS/
         JKhQE1d9Mm0Kwr/YPWWQua9JASenshgOsO3KBCTkzBvZWHiPowcUvchyT1AYKqFTouxw
         m63A==
X-Gm-Message-State: AOJu0YxOrlJGtRmGXrWvsA4BbhWWjWnVj63ApJ8MDCt7Lw/85Av8qe19
        EKWmYvznsUIYJ9BhOgKhx8m+XA==
X-Google-Smtp-Source: AGHT+IFQ4s1y11wlkTn4KHGm3cMaFynX33qrPaSxSiQBylbccwIVK/48jQ16/iA51GQIQbVpC+ySug==
X-Received: by 2002:a05:600c:a01:b0:405:3f19:fc49 with SMTP id z1-20020a05600c0a0100b004053f19fc49mr1487521wmp.34.1697544339820;
        Tue, 17 Oct 2023 05:05:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 53/73] pinctrl: intel: lynxpoint: drop the wrappers around pinctrl_gpio_direction_input()
Date:   Tue, 17 Oct 2023 14:04:11 +0200
Message-Id: <20231017120431.68847-54-brgl@bgdev.pl>
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
 drivers/pinctrl/intel/pinctrl-lynxpoint.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
index e6878e4cf20c..303aaca341ea 100644
--- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
+++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
@@ -539,11 +539,6 @@ static void lp_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 	raw_spin_unlock_irqrestore(&lg->lock, flags);
 }
 
-static int lp_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
-{
-	return pinctrl_gpio_direction_input(chip, offset);
-}
-
 static int lp_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
 				    int value)
 {
@@ -799,7 +794,7 @@ static int lp_gpio_probe(struct platform_device *pdev)
 	gc->owner = THIS_MODULE;
 	gc->request = gpiochip_generic_request;
 	gc->free = gpiochip_generic_free;
-	gc->direction_input = lp_gpio_direction_input;
+	gc->direction_input = pinctrl_gpio_direction_input;
 	gc->direction_output = lp_gpio_direction_output;
 	gc->get = lp_gpio_get;
 	gc->set = lp_gpio_set;
-- 
2.39.2

