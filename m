Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B527CC28F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbjJQMIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343675AbjJQMHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:07:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0CF2713
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:52 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso55558775e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544349; x=1698149149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlzkIOQCjUnaLQIijso5Hp4dS0y/amt7GTYGhDxNGpk=;
        b=vILeJu/SGi8uYS7u4bdsmG8n+Jt2CcWOXKNhBuN6LgS5+tB8xba+e8mkgpwF4P/B4t
         6bwraGL59wnQoyCYAT3Fpo72ThdLRCmyCC5JoQ4bUIWMPkvXdFmq1P6qylCXLQQE7DSP
         tPDee4dG7B9jyaPG0NiK3f/ydnMLIk3VwEQRQzucdnQibu0MiFjr0EiPjWro4xmYgXvY
         l/+xv5S0NjwOh1x0CuavjlJvOiqsMWnBSHapiR7EEU6cHgyMNb4gPuAr/xw7NWJhBvOo
         HT/GATKUD5GpY1Cx4OcooAF3WLcG3AXZvvk92ZsAz2ZmqR7SueGc+4QiPQAoWd0QNWpQ
         qNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544349; x=1698149149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlzkIOQCjUnaLQIijso5Hp4dS0y/amt7GTYGhDxNGpk=;
        b=OzZKgKvNJON95Oe5KKnku6IvagA3D0GhhtdgqWtjbSp8wp3BJuerfTbYb/hIydLtdT
         fHqSIKkyuni2GyW8R/DigDOm6UzPK2J9wOPTPg7uwlwRmC48qommxczidpmwoVnBHHgI
         fzjwc5qx2OZAMaTaU+F2afdO44M013A0DRb4QwK6XDozQqOB32+tQbwdQCL2k90i2z3z
         fp+exXB+J7sLGlP3qHZVqA4TXMHll9G5Vf5HCXPz2QdAJMRrqb6Ffpsc2JlguGSAHd19
         cVte9gtmnrSmhcoBxyhYLqMP6GwR2yjZhSs3c4JdYmXUStPsHr+pHCVr6iZREAJ4hR2J
         BbfA==
X-Gm-Message-State: AOJu0YwXU2pJU/Bds7dcQSkVeyTp8s6u+pXMf+7dHFWJ3bxKHwh7W78B
        k+8ibgMvpAm8VFv6znPBAIPirA==
X-Google-Smtp-Source: AGHT+IHKAhNxHGMZwD12fpBu9rtiYo7vwmeRY7ABks2s9oTibAZ6b5mFhWbrDyN7Os3NcQouNImWvw==
X-Received: by 2002:a05:600c:1392:b0:406:513d:7373 with SMTP id u18-20020a05600c139200b00406513d7373mr1749009wmf.11.1697544349588;
        Tue, 17 Oct 2023 05:05:49 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:49 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 64/73] pinctrl: mediatek: common: drop the wrappers around pinctrl_gpio_direction_input()
Date:   Tue, 17 Oct 2023 14:04:22 +0200
Message-Id: <20231017120431.68847-65-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
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

pinctrl_gpio_direction_input() now has the same signature as the
wrappers around it so we can drop them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 41e9847e3085..e79d66a04194 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -808,12 +808,6 @@ static const struct pinmux_ops mtk_pmx_ops = {
 	.gpio_request_enable	= mtk_pmx_gpio_request_enable,
 };
 
-static int mtk_gpio_direction_input(struct gpio_chip *chip,
-					unsigned offset)
-{
-	return pinctrl_gpio_direction_input(chip, offset);
-}
-
 static int mtk_gpio_direction_output(struct gpio_chip *chip,
 					unsigned offset, int value)
 {
@@ -898,7 +892,7 @@ static const struct gpio_chip mtk_gpio_chip = {
 	.request		= gpiochip_generic_request,
 	.free			= gpiochip_generic_free,
 	.get_direction		= mtk_gpio_get_direction,
-	.direction_input	= mtk_gpio_direction_input,
+	.direction_input	= pinctrl_gpio_direction_input,
 	.direction_output	= mtk_gpio_direction_output,
 	.get			= mtk_gpio_get,
 	.set			= mtk_gpio_set,
-- 
2.39.2

