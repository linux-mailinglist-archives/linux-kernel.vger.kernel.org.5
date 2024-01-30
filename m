Return-Path: <linux-kernel+bounces-44631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D53884254E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E581F293CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA026DCFB;
	Tue, 30 Jan 2024 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JeukA9Cd"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2286A34B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618927; cv=none; b=kIy+MtXqCEbm1s6MQ2GaLiV67/YGA8HMQelL54X2W4AfI35ZX5pBctKnPALC4SHLRCTc5XoYqc3ixHVedO2/mL6ACiNDFVArwCxrkqiWzrXjoXNJyepF/aNZeAYlF3UVkO1fwW3592HBOM3vS2Igy8BU28Wp1jIQfh3SU0jxPYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618927; c=relaxed/simple;
	bh=2L0oHe8hqAJZqu/ywZmX8RyoP5OnqmgSjwPvNmkhgL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WYevE9ksQuWyjBHam1fGGPiEvwiKoh45gXaPXNxwcj5rVCF20t97ZfF5g9ialqtjc+h6Wz7XOTu4stfr1cunWNh/jzWWQTxwVWi7/NDD3TcuAc+B96TgSSOmbbFGnGXKkDbHreVwNybuupOQWMohQT06TfrtwqcLs8iUzLsPSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JeukA9Cd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40eac352733so45554345e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706618922; x=1707223722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiK2Xi9L6Klb/ITmaLzgZoXQCyb4RziSydl2Peo+0SA=;
        b=JeukA9Cd21OKLf9e+G7lh9MKpyA0O44BJUotmNRX32MSmWr2PTm3E+H0Fjwq1tcACo
         KkMBfMOppObbo8dCYnCXsTUTFJQfxWA9pN5MGBODDVaowjtfET/L0sSw4RTFYIIpg6k2
         FUTcsvtASmMvo4U29CsjHubarYw10T+Qb3hadXd68WoYm5zWkb5shFcEWBX8vakffiZM
         4GU70NFGn/Jkm//gsyOjud1p9UJEhCfRFDwE7n+6Q/RDH1cyu90NFyh+wQQTrfv2SUrB
         Sa2uEx32Pr+j7J9tT0cql7TRHIOylsou4XxpjmJ/w3J7qmi8p8wdjETssQ10HewnpVWy
         cl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618922; x=1707223722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiK2Xi9L6Klb/ITmaLzgZoXQCyb4RziSydl2Peo+0SA=;
        b=RkSeGOsghCxbD+7pIIPb1d0iLJf7nzdx23dDzL0vbegFj70m6bWx/ofKMVB07dGDgm
         low72Y0vL0MPaKLWfWVPYq4RCyYqMP4aPVPsCsAgdsVFfEyij5THcrEZJnTELjWCzfuV
         p1f7aEzjzL38D3SroIt7GE+/di9vrYGRBF01uENK8LK+hmvoJTyjAUdo+XwTXzl9BS8b
         cYMjK4FnNV1aOQNicZalRRfzP4yzUzG7/Zy+v+Vs3XW5893R8U1obJVnSSe4ElVRPs4K
         UAWI7V4aTFYJ9MtzgtG69/z8USEqUj3p3PY+duZTfWKmk7QbctWLQkL5J4tRSUMFUjOO
         tfsw==
X-Gm-Message-State: AOJu0YzVVCYhkY4YCTLVizGaNqFVEgwn1m+VK7GgNQfeK+bcRSN0y0yq
	jOyd/Yxcdf1WYHuJ8ogU0+mMAIbWHV37k6Iybs2VJWGwDH1QiOId8TvdeiQtHKE=
X-Google-Smtp-Source: AGHT+IGe0xOr3TYjhKbWECqSuTLQzmTfAMJjldLVdEXQiQa1SAsDcGmp1kMsSuzyEaLRcfj/QPlt4g==
X-Received: by 2002:a05:600c:1391:b0:40d:917d:25f3 with SMTP id u17-20020a05600c139100b0040d917d25f3mr7310671wmf.25.1706618922625;
        Tue, 30 Jan 2024 04:48:42 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:abc8:f77e:abeb:129c])
        by smtp.gmail.com with ESMTPSA id en8-20020a056000420800b0033940016d6esm6625337wrb.93.2024.01.30.04.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:48:42 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 03/22] gpio: remove unused logging helpers
Date: Tue, 30 Jan 2024 13:48:09 +0100
Message-Id: <20240130124828.14678-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240130124828.14678-1-brgl@bgdev.pl>
References: <20240130124828.14678-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The general rule of the kernel is to not provide symbols that have no
users upstream. Let's remove logging helpers that are not used anywhere.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index a4a2520b5f31..c3ae5bfa3f2e 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -219,31 +219,18 @@ static inline int gpio_chip_hwgpio(const struct gpio_desc *desc)
 
 /* With descriptor prefix */
 
-#define gpiod_emerg(desc, fmt, ...)					       \
-	pr_emerg("gpio-%d (%s): " fmt, desc_to_gpio(desc), desc->label ? : "?",\
-		 ##__VA_ARGS__)
-#define gpiod_crit(desc, fmt, ...)					       \
-	pr_crit("gpio-%d (%s): " fmt, desc_to_gpio(desc), desc->label ? : "?", \
-		 ##__VA_ARGS__)
 #define gpiod_err(desc, fmt, ...)					       \
 	pr_err("gpio-%d (%s): " fmt, desc_to_gpio(desc), desc->label ? : "?",  \
 		 ##__VA_ARGS__)
 #define gpiod_warn(desc, fmt, ...)					       \
 	pr_warn("gpio-%d (%s): " fmt, desc_to_gpio(desc), desc->label ? : "?", \
 		 ##__VA_ARGS__)
-#define gpiod_info(desc, fmt, ...)					       \
-	pr_info("gpio-%d (%s): " fmt, desc_to_gpio(desc), desc->label ? : "?", \
-		 ##__VA_ARGS__)
 #define gpiod_dbg(desc, fmt, ...)					       \
 	pr_debug("gpio-%d (%s): " fmt, desc_to_gpio(desc), desc->label ? : "?",\
 		 ##__VA_ARGS__)
 
 /* With chip prefix */
 
-#define chip_emerg(gc, fmt, ...)					\
-	dev_emerg(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
-#define chip_crit(gc, fmt, ...)					\
-	dev_crit(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
 #define chip_err(gc, fmt, ...)					\
 	dev_err(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
 #define chip_warn(gc, fmt, ...)					\
-- 
2.40.1


