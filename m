Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542377FD949
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbjK2OYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjK2OYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:24:37 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B80ED50
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:32 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c897ba4057so81234701fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701267870; x=1701872670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQ4oN2yBzcOb1+JXtPZKrl0tpOl2eK1zlq9JfJmTld4=;
        b=fSB4WGkZG35mb/eSTil6wJYHacf7Xy2ySbuqtE9u4PIxHoqiNA9geqZmdtJfQR8jFZ
         PoM9Sm2m6/g3RKGh5M9zYdJo9+06YpdBb34gqjxqXZzfBq5N5ucgL1SqcC9CVhWFbmWl
         MAhOGo8I5Iz31n0B97Y6/4WjK0J9mt9LbTWH11ptTjP2WvTf9j80SBoxBr4+IhzTbU39
         cb/wepHsOFYajQuRCP265xQ8E4GLlBJaqwEJN2R+Wl1v/S4F7u/qgTpSmcQbD8lH+Q+q
         AR+fgiK99L1kJyju2sbD3TKCLLhoEKM+EIOR8/WYUSh6/XtRP7vS/7vgw4zMZwMj1VoF
         I5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701267870; x=1701872670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQ4oN2yBzcOb1+JXtPZKrl0tpOl2eK1zlq9JfJmTld4=;
        b=r4Z+47Nw8S8FSz7pq98/JY/GIQLKsELphJEgAUmLkqmSTLjEVQw5PULJiIzjPIf3hS
         2wVj+po4FzLjjkwUuAq56HrqkP3IbayilZM0ldNU0/7NDLyQEBnS91HDwjBn137VxvBa
         +cuEq2X/3KsWh6PuJIT/mSLGa7dJWx3Mv6hvKibX+cuBIwFjv6VvRSeAxDX8/BTb2zqt
         gVnClC96ZGx/eil8BHTyz+62QTG/c663URU8w1OyCBidgncdDzn4RFFSNKmSY+rKBF5A
         hjbEYZtuer4qXtv0kfzDkPQ3/u/Hw2CeM+FIXRA5gfQiKnIj67UOELKz8/BGx3bM7Jms
         ItLA==
X-Gm-Message-State: AOJu0YwArOVA4Tg0xxxPQGZbb934u16OaG0rfpsJtcmKUFM5wAnHabDp
        Ofj8CveKIcoFOUfxeNLEs5+ewQ==
X-Google-Smtp-Source: AGHT+IEM0ferBCaODHhUulOSAu3F+ckHAPew6loNpc69zlAeek/BqCYvoUTSVE7JAcLnIlSQGFuJ5w==
X-Received: by 2002:a2e:97d6:0:b0:2c5:16c0:6239 with SMTP id m22-20020a2e97d6000000b002c516c06239mr12471205ljj.51.1701267870294;
        Wed, 29 Nov 2023 06:24:30 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4520:2f25:4d3a:4adf])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c3ba800b0040b34720206sm2406848wms.12.2023.11.29.06.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:24:29 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 08/10] pinctrl: sppctl: use gpiochip_dup_line_label()
Date:   Wed, 29 Nov 2023 15:24:09 +0100
Message-Id: <20231129142411.76863-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129142411.76863-1-brgl@bgdev.pl>
References: <20231129142411.76863-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the new gpiochip_dup_line_label() helper to safely retrieve the
descriptor label.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/sunplus/sppctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/sunplus/sppctl.c b/drivers/pinctrl/sunplus/sppctl.c
index bb5ef391dbe4..ae156f779a16 100644
--- a/drivers/pinctrl/sunplus/sppctl.c
+++ b/drivers/pinctrl/sunplus/sppctl.c
@@ -4,6 +4,7 @@
  * Copyright (C) Sunplus Tech / Tibbo Tech.
  */
 
+#include <linux/cleanup.h>
 #include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -500,16 +501,15 @@ static int sppctl_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 
 static void sppctl_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 {
-	const char *label;
 	int i;
 
 	for (i = 0; i < chip->ngpio; i++) {
-		label = gpiochip_is_requested(chip, i);
-		if (!label)
-			label = "";
+		char *label __free(kfree) = gpiochip_dup_line_label(chip, i);
+		if (IS_ERR(label))
+			continue;
 
 		seq_printf(s, " gpio-%03d (%-16.16s | %-16.16s)", i + chip->base,
-			   chip->names[i], label);
+			   chip->names[i], label ?: "");
 		seq_printf(s, " %c", sppctl_gpio_get_direction(chip, i) ? 'I' : 'O');
 		seq_printf(s, ":%d", sppctl_gpio_get(chip, i));
 		seq_printf(s, " %s", sppctl_first_get(chip, i) ? "gpi" : "mux");
-- 
2.40.1

