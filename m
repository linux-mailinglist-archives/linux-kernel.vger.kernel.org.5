Return-Path: <linux-kernel+bounces-57790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C47F084DD76
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54387B22B16
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED786D1C9;
	Thu,  8 Feb 2024 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HfPIuBBh"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6456BFCC
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386371; cv=none; b=uxw96ohoc2mnjgWyQh33tynmaFPm3/wDtYssVs08h7Uhkf4XIYXXv1o8EazUzMRLjCJWP6iqDl52wXf5yPvN0hhWUyeqPOSROqV2dDCEh4pDwlrBAcjJQ1/mF6P1lh9ONAINI0urJVWj/2SstYNTlNofqKCADQsqmRBxdURM+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386371; c=relaxed/simple;
	bh=OSHkv+WDnIBMeHzKm0e8BUcjA4xFxonb/t9zZHvq2fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T5yy7090ljkG7a9pAI9ZWhZMAfxt8jcfhbm9Z3idkZdTDye9mVxh8IQ58kAK4pwZB/J/PRLpNYnvzcqJ5JjviocKXqvsTugXHLp1XbZJtSmPod4yXsuvQhVtkHDIFEBq3bDeHk4t1PR7TxuGA8Ktrz8JqGELQHSaKnHY/9WrRAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HfPIuBBh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40ff28388a6so14706335e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386368; x=1707991168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMiVAuZ1WGGYPqmPuwOhICMBuiJ5VewzakZD6uTNbY4=;
        b=HfPIuBBh5fW4MMcz3mhnDTcewJ94WMKSEyXhptEbglKzdzqBWf0IidlLbOBuFwa2YV
         1Hhno5roKqOKXkdkrb4EL/3hb3Wa3gzV9VyL8Bpvtb/B+m9AvmirMEb15hKkgGbdzOC9
         GNU/QYP8O9mtXkbFGOdBTAuXTtCHtIfSoWFI+sWTZiO7PQETNTYABBUAailIpMMilYnV
         i8wu+JpaDxEBkLHq3st5x805aWd3DbEK0RvCrM54Wg6+pjKWxdy5v4KKlS3HTj46buhC
         sqJBtMpS2PfddA8ypf77gah7Dkp23PpnhDa8MuiUKcoA85g20qzsOaG3mXCjHCRBs/Xf
         tnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386368; x=1707991168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMiVAuZ1WGGYPqmPuwOhICMBuiJ5VewzakZD6uTNbY4=;
        b=YWApLc/Ajidrx88eoTBtSUz70491FEjabQjH0eGT6Iib4LUrNu6HUKNqYniFZmJ9aL
         xC77gTjE1k3koF3wCYOsG8viIF9cU3TvVmE/46u5wnbRCkZ7Ww7j+yA+zYBbialyBFWT
         XAFZdQ7lhQubWMfekJXLQoHM/PpE1ZDxogNfFYEGLhtJsr0+YZI9VB/MQ+cxA5k9AuF/
         1csoUTCn56SmYB6i/LPGWf8SwKyxbypmbeQPE/Jbld+iSQllTz3PIKjmlG6BxbwpzI88
         55uyQ2NBuXI/Np8RTzMelpLZa8tsbcEnP3u1xtbVf+LUbI6mHDjICGfAaxpXHUzsmzw7
         ynYg==
X-Gm-Message-State: AOJu0YyjU1AO+vd8casjXc+HSQnb13GElhsc817ZitCLtQDw1Mp1Brx1
	4R0n5skox8RkqFqyiX2tdU8eU0rzea2jlvGfnUpF1/ZvSjYp+cmdKfhrbyv0ko4=
X-Google-Smtp-Source: AGHT+IFKY3O5mYGZBarKGAA2ip5fNYWH8Q4SS7g8JpsrDPFWfBuHNCDxsh7VgMqSJfkI2Hm43xSQ0w==
X-Received: by 2002:a05:600c:4f8e:b0:40e:7d8f:6b1a with SMTP id n14-20020a05600c4f8e00b0040e7d8f6b1amr7404387wmq.5.1707386367840;
        Thu, 08 Feb 2024 01:59:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+4ZbHZkGaSWduDwdD4tSjMgQfmytcicjQyWOVJMfsVhBbdS07EJ5Jyg+6bYHGsLCynjXlc6Ac5n4G8bVXj+HIqWY7LZ6OCRPfaQ5Mb56ZlrFahhu9pAA9TECXvH0x+oBgGyvLVFdB5ZbOZFcVKrSJtTJ0To2SHKD9t4X57syWmIaFcFTqF1mde/ARz/HpzVrTSogao5VnnkRigh4AP87VHn4MCt4MVTpXynk+q+Z0VNc92rbGfGtpM/Pp8i0FnQHKZiPtYw8jsCRuybT8tO5ExhKvblRdZ7TwyK+5o9VXpzez5A6NQcR87XED83w/UQ/jf2avcC20qydRBNqpMUE07UaPPjqf7A==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:27 -0800 (PST)
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
Subject: [PATCH v3 02/24] gpio: of: assign and read the hog pointer atomically
Date: Thu,  8 Feb 2024 10:58:58 +0100
Message-Id: <20240208095920.8035-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240208095920.8035-1-brgl@bgdev.pl>
References: <20240208095920.8035-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The device nodes representing GPIO hogs cannot be deleted without
unregistering the GPIO chip so there's no need to serialize their access.
However we must ensure that users can get the right address so write and
read it atomically.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-of.c | 4 ++--
 drivers/gpio/gpiolib.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 77509aa19900..bd6b8702c790 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -800,7 +800,7 @@ static int of_gpiochip_add_hog(struct gpio_chip *chip, struct device_node *hog)
 			return ret;
 
 #ifdef CONFIG_OF_DYNAMIC
-		desc->hog = hog;
+		WRITE_ONCE(desc->hog, hog);
 #endif
 	}
 
@@ -848,7 +848,7 @@ static void of_gpiochip_remove_hog(struct gpio_chip *chip,
 	struct gpio_desc *desc;
 
 	for_each_gpio_desc_with_flag(chip, desc, FLAG_IS_HOGGED)
-		if (desc->hog == hog)
+		if (READ_ONCE(desc->hog) == hog)
 			gpiochip_free_own_desc(desc);
 }
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 181faeeceb3f..8ca9aebfa81f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2330,7 +2330,7 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 		clear_bit(FLAG_EDGE_FALLING, &desc->flags);
 		clear_bit(FLAG_IS_HOGGED, &desc->flags);
 #ifdef CONFIG_OF_DYNAMIC
-		desc->hog = NULL;
+		WRITE_ONCE(desc->hog, NULL);
 #endif
 		ret = true;
 	}
-- 
2.40.1


