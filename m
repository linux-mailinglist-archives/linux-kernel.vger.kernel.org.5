Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C367FF09D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345865AbjK3NrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345694AbjK3Nqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:46:38 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF9C1703
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:44 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b4c2ef584so7730185e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701352003; x=1701956803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NPguL+egm1B/3hLyNOqRomxlJRtvAY3YVXSaylJwM0=;
        b=ZTsTAUO8Q5uQn33PwH90C0RCvf/d9jvERfPGPlJwgjE2f2UWjBaVy5KPIOpfvtUzOL
         zVA6S0UoM195MZr7cRWQz2g24tFJp/tg7DoN8qRtUd5mgr6+RyDZPgNjQyqUhz8L5xwn
         RTqqNYQmW2M8BUpfuNiuZD9pYl5oEjgoIgxfilf75+UGvc680VAok4QuHfiG7F0YjsKW
         PfSk7UW55TqmKvuykMhlZbryg7mX72hRc0Mv+Cd4NGbnQtRIcDWPe3poYU2U8Bw1Kecf
         +q+EuACXDr2HjP4pLhX990eAUw7h4rT0VLIUIeQptXzc5wKY3l+FNqkxDN0p0D6f4Rrl
         lj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352003; x=1701956803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NPguL+egm1B/3hLyNOqRomxlJRtvAY3YVXSaylJwM0=;
        b=ExytPLBNBejymZbZ+3fpw4dLQOH3+ADSRly/rlEFMoHserpy4LDHk0ELgUYuhmmJ4C
         m2c7KTYJ2XxNw5QRM8Kvlq9m2zc5BRFPJjj3LkYXkk15SI9NnddUwQXLaG5eU7wdI5pV
         OIOTZy29HZKotXOQf8cPtm3o3cfafnAYIBSHis23OirE59OvAT9XQ2eZYSR8T1hOfH8H
         4J5om7yplcdhKL0QPO1O0q/t9FrLoTG7iNqHNgruxZ/Umlvk4edvgM2lgTg0qd1HwQzO
         9nt0do9WHy/6Idks8Q8t6pE7QS4ykKBwCUCvIBs4upY3127fMLuEZiajMJBVJNfxZORq
         jHvg==
X-Gm-Message-State: AOJu0Yw98OiHrBbijsab7YEFhIYup4zROSdhVIjVfx0cVTlVIQ2eXPMH
        y082mMnlW5TzlZ29pLgGZ7c5uQ==
X-Google-Smtp-Source: AGHT+IF49lqrlVpVqkD0E02GQZF9bH8Vo6dbPgCqchTj1uNhj8pD7rKcwX/9BEAelWIERBkgSTt5dw==
X-Received: by 2002:a05:600c:4592:b0:40b:26f1:57a2 with SMTP id r18-20020a05600c459200b0040b26f157a2mr16362430wmo.27.1701352003401;
        Thu, 30 Nov 2023 05:46:43 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae84:904:6602:ec1e])
        by smtp.gmail.com with ESMTPSA id n18-20020adffe12000000b0032d2489a399sm1574824wrr.49.2023.11.30.05.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:46:42 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 06/10] pinctrl: nomadik: use gpiochip_dup_line_label()
Date:   Thu, 30 Nov 2023 14:46:26 +0100
Message-Id: <20231130134630.18198-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130134630.18198-1-brgl@bgdev.pl>
References: <20231130134630.18198-1-brgl@bgdev.pl>
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

Use the new gpiochip_dup_line_label() helper to safely retrieve the
descriptor label.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 863732287b1e..7911353ac97d 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2011-2013 Linus Walleij <linus.walleij@linaro.org>
  */
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -917,7 +918,6 @@ static void nmk_gpio_dbg_show_one(struct seq_file *s,
 	struct pinctrl_dev *pctldev, struct gpio_chip *chip,
 	unsigned offset, unsigned gpio)
 {
-	const char *label = gpiochip_is_requested(chip, offset);
 	struct nmk_gpio_chip *nmk_chip = gpiochip_get_data(chip);
 	int mode;
 	bool is_out;
@@ -934,6 +934,10 @@ static void nmk_gpio_dbg_show_one(struct seq_file *s,
 		[NMK_GPIO_ALT_C+4]	= "altC4",
 	};
 
+	char *label = gpiochip_dup_line_label(chip, offset);
+	if (IS_ERR(label))
+		return;
+
 	clk_enable(nmk_chip->clk);
 	is_out = !!(readl(nmk_chip->addr + NMK_GPIO_DIR) & BIT(offset));
 	pull = !(readl(nmk_chip->addr + NMK_GPIO_PDIS) & BIT(offset));
-- 
2.40.1

