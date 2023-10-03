Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A227B6C5C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbjJCOwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbjJCOvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:51:38 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D503DCE
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:51:32 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405361bb94eso10662615e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696344691; x=1696949491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LC9FxBCiC3OrfTLsSY8qEZzHDKeEz4Ow69tozPBiOU=;
        b=DfhEG8N1TQ+niwpn2oiprZQFtUsQK2ddMZuHmy9NfocuNqdyQhQVTRDBQmGDeDqLW1
         yh79XKB4TcNaY/xP2awyPUVku2hl5Ah6cSFvyfj4AmRCUn7DUwfHCXTfdblyNxGdAwEU
         YIr2rHiuVc52fxJilYzRbsroo7BMOrtxOjiyrTwcGA2Es1cdoXpGs/fGNmz5PR8ii0ty
         +mzTspe+ChH9puSyXQskjEpMJZHaA4FZlhmk5iSlxmTSzyza9RGTNwHa1Rrgbd7X5tkN
         6DfVk2OlfiG8d+31JcvgBu8if5ZLhTc5Esf6UbOBfOxu6QN/26fdor5ihXRNDfUfR0YT
         x9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344691; x=1696949491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LC9FxBCiC3OrfTLsSY8qEZzHDKeEz4Ow69tozPBiOU=;
        b=FQBxmdeSp5fdLFIf+/C6zsv8H5WDLYE6CzCHeNG8YDkplmyKguCQoGFxzpTOd0HCnM
         p23ZPrnOyJ6tnY3rW+eBD96rBqy4MFgjr8c4fSuNeX4/l6Tx20rEhZmyklg9yqcigQej
         pA4q1TOjZUbFaVPp5VRwm33yOv0anb5wJvEhZ6Fdxw0YR2Q6FDJj3EDTRWl0dAbgCnbw
         wd3hpTCiT6LjAFb54fZUowbAXEbjAudkgbiCvKSEuexKaLA7WRs5YXm987r1ttyUp+p6
         39A3XnRMZRHE8nTo7F+dudaf02YhTZIJKEK/3Kn+r4ptHK6toQ50KA1Upqt5oZ52pigB
         hWaw==
X-Gm-Message-State: AOJu0YxR7iLVzH2DBUUKKXPRxkK43/DTqIDZVRjq8nPICLA25CCKSsgS
        /xvlJsrm8Su7oYReeL1UHlFSg/gQu1yoDySBTnY=
X-Google-Smtp-Source: AGHT+IFpQEVFjE6dVQ9qy2mvBwzXGuvI1FBsZGmD55brX7KL3Pm93Jl+8ULe8KF+Tl/kJ8OOzL4hMA==
X-Received: by 2002:a05:600c:2317:b0:402:f5c4:2e5a with SMTP id 23-20020a05600c231700b00402f5c42e5amr13357135wmo.37.1696344691351;
        Tue, 03 Oct 2023 07:51:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003fe29f6b61bsm1462773wmr.46.2023.10.03.07.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:51:30 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 11/36] gpio: rockchip: use new pinctrl GPIO helpers
Date:   Tue,  3 Oct 2023 16:50:49 +0200
Message-Id: <20231003145114.21637-12-brgl@bgdev.pl>
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
 drivers/gpio/gpio-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 23040a8cea34..3576793f0bd9 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -159,9 +159,9 @@ static int rockchip_gpio_set_direction(struct gpio_chip *chip,
 
 
 	if (input)
-		pinctrl_gpio_direction_input(bank->pin_base + offset);
+		pinctrl_gpio_direction_input_new(chip, offset);
 	else
-		pinctrl_gpio_direction_output(bank->pin_base + offset);
+		pinctrl_gpio_direction_output_new(chip, offset);
 
 	raw_spin_lock_irqsave(&bank->slock, flags);
 	rockchip_gpio_writel_bit(bank, offset, data, bank->gpio_regs->port_ddr);
-- 
2.39.2

