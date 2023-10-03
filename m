Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74797B6C5F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbjJCOwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240234AbjJCOwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:52:17 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF0210D8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:51:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4054496bde3so10017485e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696344708; x=1696949508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAwenNnDV93VvdW3nmGsY557IVyGH4w4EMYdTvU666g=;
        b=nphNHJuT1lgf+oKq8xOgGVNqmMn7ac26e7B8+i6yF/erLnCZGMS+afFy7K4VthsxPn
         A3jCjTJUSoHLOo9N1xyq1n2DfbgTeQGtikYE3KNRT0hLodEMAWOMSZSoxzp3qKpZzKDy
         y/2IaNRdSxl5+nl/lSwa6g9YxAzJ7hyH8EAaWOjpiKbiyFBGYWNhfPVaZTLnqGO7Dw83
         p4kYsVF3Uuz0Nc0ad/TLaZ2TU0Vwv9IeLDBDS3dZwlFsBTaTs/p4XUYBcpH8vE6ZOW1h
         nu75MDjpDagt02F4QZLkiNYAyOLDcPXTUfgKLpHp3M3eytoX7LI9X524+uMmTgpZechu
         Fzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344708; x=1696949508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAwenNnDV93VvdW3nmGsY557IVyGH4w4EMYdTvU666g=;
        b=BraWxHwyxfK42H5NWcBX70Qn8PKZQBYAz5rwELbSiCvYZCBSxhZ4tqdft4WemiJsZr
         EgSzFFtWX8FcxoZM1ZpxfoGI6cdldGfPgMSoTxGS8SI9sFaMREHQvtXyk9EHipL/f3Ao
         C+4EDcTiT+HF3atwfy8FSWUwG1Ax+V9XjvuapcZ99K41FIIB/GRQvVZrKohO/PnNhRQj
         +/rk+kRE6Q1X11nS4Z6De1u717JCVkai73zG+3xB+405Psg4k2ar5irT5LvPrKz7IFMb
         tQu/4a13M61zsc60CpcvGP/PvcIf6qWh9bqHbgCFechs/OXWn+JmdgISumMon08HCFlt
         GBlQ==
X-Gm-Message-State: AOJu0YzSQQHskw+r5E6R/R1Y0EYh7MupdJMGLgZ8Pr3iEvh2bTmakB3m
        dz9WW6ZAp3B5HoE5cQitkELsCA==
X-Google-Smtp-Source: AGHT+IHuJZasxw0s5vMDjaX7jf4cgy7MisngEGCcRADOEMnGuGYQ/xLp1lhkj5XfrFEdVZZFEjlayA==
X-Received: by 2002:a05:600c:2113:b0:405:1ba2:4fd1 with SMTP id u19-20020a05600c211300b004051ba24fd1mr14474895wml.24.1696344708453;
        Tue, 03 Oct 2023 07:51:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003fe29f6b61bsm1462773wmr.46.2023.10.03.07.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:51:48 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 31/36] treewide: rename pinctrl_gpio_can_use_line_new()
Date:   Tue,  3 Oct 2023 16:51:09 +0200
Message-Id: <20231003145114.21637-32-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003145114.21637-1-brgl@bgdev.pl>
References: <20231003145114.21637-1-brgl@bgdev.pl>
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

Now that pinctrl_gpio_can_use_line() is no longer used, let's drop the
'_new' suffix from its improved variant.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c      | 2 +-
 drivers/pinctrl/core.c           | 4 ++--
 include/linux/pinctrl/consumer.h | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 54ee075410db..02ffda6c1e51 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2287,7 +2287,7 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	 * FIXME: find a non-racy way to retrieve this information. Maybe a
 	 * lock common to both frameworks?
 	 */
-	ok_for_pinctrl = pinctrl_gpio_can_use_line_new(gc, info->offset);
+	ok_for_pinctrl = pinctrl_gpio_can_use_line(gc, info->offset);
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 5bad56ed8176..eb12aec39ed1 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -752,7 +752,7 @@ int pinctrl_get_group_selector(struct pinctrl_dev *pctldev,
 	return -EINVAL;
 }
 
-bool pinctrl_gpio_can_use_line_new(struct gpio_chip *gc, unsigned int offset)
+bool pinctrl_gpio_can_use_line(struct gpio_chip *gc, unsigned int offset)
 {
 	struct pinctrl_gpio_range *range;
 	struct pinctrl_dev *pctldev;
@@ -775,7 +775,7 @@ bool pinctrl_gpio_can_use_line_new(struct gpio_chip *gc, unsigned int offset)
 
 	return result;
 }
-EXPORT_SYMBOL_GPL(pinctrl_gpio_can_use_line_new);
+EXPORT_SYMBOL_GPL(pinctrl_gpio_can_use_line);
 
 /**
  * pinctrl_gpio_request_new() - request a single pin to be used as GPIO
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index aa3a7a7ca52d..4f9ead7f65d2 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -26,7 +26,7 @@ struct pinctrl_state;
 #ifdef CONFIG_PINCTRL
 
 /* External interface to pin control */
-bool pinctrl_gpio_can_use_line_new(struct gpio_chip *gc, unsigned int offset);
+bool pinctrl_gpio_can_use_line(struct gpio_chip *gc, unsigned int offset);
 int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset);
 void pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset);
 int pinctrl_gpio_direction_input_new(struct gpio_chip *gc,
@@ -68,7 +68,7 @@ static inline int pinctrl_pm_select_idle_state(struct device *dev)
 #else /* !CONFIG_PINCTRL */
 
 static inline bool
-pinctrl_gpio_can_use_line_new(struct gpio_chip *gc, unsigned int offset)
+pinctrl_gpio_can_use_line(struct gpio_chip *gc, unsigned int offset)
 {
 	return true;
 }
-- 
2.39.2

