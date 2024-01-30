Return-Path: <linux-kernel+bounces-44630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE02584254F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE510B25033
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDCC6DCE7;
	Tue, 30 Jan 2024 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3KgxoEmx"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BEF6BB34
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618926; cv=none; b=nwIrAy53QP+bHYDCkw85Id3JHoXWrkfpH9pFrm4W7GWswUYWiwEbJvYlCm56Ae6wLzyjMZpT9mnkRs9nbGNM2Uh7in1UBp0RkXOgOI7FdncEuLQsETNHK3/zyYaixJw5mt647uRGhZ/pqVR/kbyt30Jnx5Ci6CgLpPwd3j0Zw/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618926; c=relaxed/simple;
	bh=cF2k+D4b/VB7YDGfB/hS3tuSMrwHmEsysggVNGfkBq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lPysFnTHkn94U+e9MMzVSm0nA38TSLlAcR0DGK5L+ypyVq6P1n9mvTfp6pgPrdvGItovO3jgsAzOn7KKsy6R1B3VO5IXngyIJdTBW7w/WmPix/oqbtMQh9ij+pTDBURRCCkTKJJNxWyrGzhC9dYre6A3rHdONFnJ8Ia/FSwCcBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3KgxoEmx; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ae3cc8a70so2159233f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706618923; x=1707223723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgPxHPJmVjjVl1RjF4uik1jt9sjY9IEzdebHMw4gZ/8=;
        b=3KgxoEmx3tIufmJKa8ypRaOD/TVjK75Tgm3N3BFy4D7A2uKuy53H8Yke/Bm5dapaxa
         CHyHHTZkKQEGI1+9WqfgVdx63k2atyHaMqqEEByh54+0mJKX11Wiu6MZCj3lv6e9bbhQ
         JeCqyBKrBzquidGiw3QpGmNCAfmXAvzwjeJOELvAEvB8YkbNGz7TTcU71PIfCb0qPEy7
         rRdykFZF9IkzGiukCeQ6qpis8mMeE8M2ustp7wpqaRIc5YYWLbj3fhxtMrn6x1zfGDoW
         y2HHthdC1uNQfaVxL2QXcaT+P9leZUNhPlr9G5AOPfnjZWR+sQ0gdhKhfcPfgN2o6vey
         IBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618923; x=1707223723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgPxHPJmVjjVl1RjF4uik1jt9sjY9IEzdebHMw4gZ/8=;
        b=TSuRxG/bue0cQB/cE1KmPWsilV4knRyeIKI7pLEjjp1X12cHc68wBfi1Kv9I991UAZ
         ikWwDmqNcrk6cH8KWhIneZ13Uy6Y6frMr6O2euzEOO+VW0irtn8UHTfwMeXOolEQxQnl
         l+LzgqRAqyJot/lVJRP4a4YlXaa56JQwkohsCGHyfbUHwsQLAUUozo8LGJt0Ad9OfY/h
         ow96jexBmC172+cghIiSgtKgfVsTAro8tVHhyhcJqN3yIz/iYnBd0MqIdsfR5BRabQwF
         TuxbE02NNXLQh03PIvpLgBXnq5rUU4T2bblADzBwGeAs1KgatfCyL+H3ysEYoO/JrmrR
         hsgw==
X-Gm-Message-State: AOJu0YwsB4MLQ914HG7tRtBnpMV0pPIoC92FQ9efitXWN2Vy+4UIcWNs
	AVmjQJTGmboMcWGhajqvEFJieR/EaEDYeQZjKXiY7Nt+hMvL6Nk9GqMdI3PL370=
X-Google-Smtp-Source: AGHT+IFTF8DtrflSdAGaz5zqaqfub2m8NCkD8FFEMaqpAucY4VSDKcJ+FAWsdrNvxq3hB/c9kC8/Aw==
X-Received: by 2002:adf:ae4a:0:b0:337:bf75:7703 with SMTP id u10-20020adfae4a000000b00337bf757703mr5877694wrd.58.1706618923530;
        Tue, 30 Jan 2024 04:48:43 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:abc8:f77e:abeb:129c])
        by smtp.gmail.com with ESMTPSA id en8-20020a056000420800b0033940016d6esm6625337wrb.93.2024.01.30.04.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:48:43 -0800 (PST)
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
Subject: [PATCH 04/22] gpio: provide and use gpiod_get_label()
Date: Tue, 30 Jan 2024 13:48:10 +0100
Message-Id: <20240130124828.14678-5-brgl@bgdev.pl>
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

We will soon serialize access to the descriptor label using SRCU. The
write-side of the protection will require calling synchronize_srcu()
which must not be called from atomic context. We have two irq helpers:
gpiochip_lock_as_irq() and gpiochip_unlock_as_irq() that set the label
if the GPIO is not requested but is being used as interrupt. They are
called with a spinlock held from the interrupt subsystem.

They must not do it if we are to use SRCU so instead let's move the
special corner case to a dedicated getter.

First: let's implement and use the getter where it's applicable.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 4 ++--
 drivers/gpio/gpiolib.c      | 9 +++++++--
 drivers/gpio/gpiolib.h      | 1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 34d6712fa07c..2c0a0700762d 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2305,8 +2305,8 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 		if (desc->name)
 			strscpy(info->name, desc->name, sizeof(info->name));
 
-		if (desc->label)
-			strscpy(info->consumer, desc->label,
+		if (gpiod_get_label(desc))
+			strscpy(info->consumer, gpiod_get_label(desc),
 				sizeof(info->consumer));
 
 		dflags = READ_ONCE(desc->flags);
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 543d80457647..d0a2f014dacd 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -105,6 +105,11 @@ static void gpiochip_irqchip_free_valid_mask(struct gpio_chip *gc);
 
 static bool gpiolib_initialized;
 
+const char *gpiod_get_label(struct gpio_desc *desc)
+{
+	return desc->label;
+}
+
 static inline void desc_set_label(struct gpio_desc *d, const char *label)
 {
 	d->label = label;
@@ -2382,7 +2387,7 @@ char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)
 	 *
 	 * Until this happens, this allocation needs to be atomic.
 	 */
-	label = kstrdup(desc->label, GFP_ATOMIC);
+	label = kstrdup(gpiod_get_label(desc), GFP_ATOMIC);
 	if (!label)
 		return ERR_PTR(-ENOMEM);
 
@@ -4719,7 +4724,7 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
 			is_irq = test_bit(FLAG_USED_AS_IRQ, &desc->flags);
 			active_low = test_bit(FLAG_ACTIVE_LOW, &desc->flags);
 			seq_printf(s, " gpio-%-3d (%-20.20s|%-20.20s) %s %s %s%s\n",
-				   gpio, desc->name ?: "", desc->label,
+				   gpio, desc->name ?: "", gpiod_get_label(desc),
 				   is_out ? "out" : "in ",
 				   value >= 0 ? (value ? "hi" : "lo") : "?  ",
 				   is_irq ? "IRQ " : "",
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index c3ae5bfa3f2e..1058f326fe2b 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -208,6 +208,7 @@ int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce);
 int gpiod_hog(struct gpio_desc *desc, const char *name,
 		unsigned long lflags, enum gpiod_flags dflags);
 int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev);
+const char *gpiod_get_label(struct gpio_desc *desc);
 
 /*
  * Return the GPIO number of the passed descriptor relative to its chip
-- 
2.40.1


