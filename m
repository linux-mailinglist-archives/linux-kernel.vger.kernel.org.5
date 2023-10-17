Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922E07CC282
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343771AbjJQMIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbjJQMHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:07:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF77E19BB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4064867903cso62408435e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544321; x=1698149121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEGizAbOxMwHBeRhJGcb8ss//xXj+RtWLOdU8JMZ+S4=;
        b=GIUDjfOeExe7e8WYs8tVMrgzRTUUx5dBVFxo6ksvEFa3/ohDpIyDJuQYP6xjFqki4U
         4Cs8s7K4XaZb7vyUsJ5hrW0g1y9spP/wgvFxTaFH+TGFsVP7fkQ75xQBBT/y/86O/Yr3
         boZ5ufFXIgKDgos+NOjZDJQlulU4UWmyNtxpXDeHHJkLTGUwy1OcwlGfwlN1eBGyAN1D
         IZeUI019B6iBhBV2jCdlcb8i53g2zVdNqA8R9FVhkFXfByhjlNQUGi8m7pRrCeant/fy
         DpEhjTeNGEjoG2un4xmjtMFanCq8nWM+HHpz/I+2QN2Y3BVvf73qPZg7zQr5Tw+jD2qG
         l/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544321; x=1698149121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEGizAbOxMwHBeRhJGcb8ss//xXj+RtWLOdU8JMZ+S4=;
        b=Eq6KchUt8CetwCezUOgkv5zldFoH8tevGg7on+92Gzbr9XQMQUxH+nEHMHj8yJyEuX
         2On/jFRhsp7SNfWV9E2BqT21IlXGzG6rkKg/0I1GNT6pc011K3DLb6bRh6+/OmAESX47
         zh9kdAo5WvOzCdG40TTijn72MBKv6OSbqlPc5O/mel9p+iTr70RHB0TivJjo78On2zl1
         Nfyo+P18MFW6iF3vypwXTCjuGA50+dxlP/iFmKFFLXKgTtTac/IHOGxpCpDrfgO+nBXH
         +OH4fxhqPUrP7ZZQaQnQk02oAtgVCquG6lWlYs14otKwzckm6ySPVx/Ez0j/phEnUmvd
         X8Qg==
X-Gm-Message-State: AOJu0Yy8ljC8VsdCpChYloBqrl6wAYGiYIn/7AGfHF4NZBiYfM5ifN7q
        DWqAY3DV+xVuS+ZGr4vK9ZUeHg==
X-Google-Smtp-Source: AGHT+IFIOngxq1pIAToZEwbs7J6cyGu+pyUOwiSkrMvmFdYAHXIOcaxr312ZZreBXjxOFPU3xWKx8Q==
X-Received: by 2002:a05:600c:4fc8:b0:406:53ab:a9af with SMTP id o8-20020a05600c4fc800b0040653aba9afmr1615188wmq.10.1697544321692;
        Tue, 17 Oct 2023 05:05:21 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:21 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v3 35/73] pinctrl: st: use new pinctrl GPIO helpers
Date:   Tue, 17 Oct 2023 14:03:53 +0200
Message-Id: <20231017120431.68847-36-brgl@bgdev.pl>
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

Replace the pinctrl helpers taking the global GPIO number as argument
with the improved variants that instead take a pointer to the GPIO chip
and the controller-relative offset.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/pinctrl/pinctrl-st.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index c1f36b164ea5..ec763572ab3e 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -719,7 +719,7 @@ static void st_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 static int st_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	pinctrl_gpio_direction_input(chip->base + offset);
+	pinctrl_gpio_direction_input_new(chip, offset);
 
 	return 0;
 }
@@ -730,7 +730,7 @@ static int st_gpio_direction_output(struct gpio_chip *chip,
 	struct st_gpio_bank *bank = gpiochip_get_data(chip);
 
 	__st_gpio_set(bank, offset, value);
-	pinctrl_gpio_direction_output(chip->base + offset);
+	pinctrl_gpio_direction_output_new(chip, offset);
 
 	return 0;
 }
-- 
2.39.2

