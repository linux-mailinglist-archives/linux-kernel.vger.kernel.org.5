Return-Path: <linux-kernel+bounces-57793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5656284DD7C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5C11C26FEB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9986EB51;
	Thu,  8 Feb 2024 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fIyq1VYF"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFEA6D1CA
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386373; cv=none; b=IXUq+TDfn1r2zgVqnDN3l03hN0STKeOZxsvuz4xrFSPh4f7HkoI6SF8VSmoGucIy1kJ2snhjxb76rp39tw1zuUBG+4v5v4M64NX8ufGDspeUr348+rp3zFcPs7tJTZ1RxCZ6E3fEZV9Nn584gYbZa7mBrp1JPvd0cBAl8KnqhbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386373; c=relaxed/simple;
	bh=6KkqrXGs7aycNx1Pt1Ey9nkvS1TWh574Lfn+nakYYbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=krnZZUiw/nc5I9kSKDe3sBPlGIOBQCYq+nNtW5sdS0RsD6R7TLf1dbJ7LpdC8MF6D9oPb00QOPyjJBfa6AqD4cKAvDRMVsL1Z+KYnJ1rAlLd3tgGRErLDAnmChosMSGA7EQmGkHmwXANNuz8+aSBoh1eEWW8kXI/A00yJUr2Cj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fIyq1VYF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b5978de44so157409f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386370; x=1707991170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1boCyVDUOl0s5Ne2S4ZzfbfT4tyxZK7BzbtLRid5RA4=;
        b=fIyq1VYFJI7cvyPQPdMO5MJQHDqa362juBQa7cxrESd76PXRx+EpV1uN3MLYXbZK36
         4fLWeC7BkV2p6B5ir8BLT6N3TK1sAFXkZ9hFbG0UfwL3hMHrcf6+904drlj1EGnr8mLQ
         EH9o28yJsQis3t1RhHiAh0rhakt77gb+PH/F4Iq1AAA+rWBIxxsoSH9lMs9efiJvwSXN
         4GReGopslVIVfSMMnJKcBPpxqgW9+L9LkedIngC5oG9FK4ihgYFTrG5UbokeR1Kf17JO
         aNqK/VuH3NrPOYxcqWBJoVPlIFy8D57AkW61RKLHPxaEmM5k6exAdqn2miNg1lnrwAAH
         emMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386370; x=1707991170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1boCyVDUOl0s5Ne2S4ZzfbfT4tyxZK7BzbtLRid5RA4=;
        b=XDK3CNBOhX5ABv4AVAVTXw1t6Z3fjrPdfeCI+trX0WvymlfTcSLo1Bi8BcQrNWsXXH
         kr44hQ6zm4ikJLQo+Wtb8D+qwSReevoHVYBWzeirw3hRAMcgDfSMKQUFJSU6ACc5kS6d
         nC32JVWtLxIhcpCXaFU80XsHZPx89xMuTUqS7MHIJti849YhhKgmiBRZhwD19cTt4kk/
         oO5XiDhJIuduZXiV4jsk4UlJraXw8x1G3Yhd+rgw8A2N+bwb43yDXCxQP9luJJKHQ6wN
         z4JGxQHOV0H0D+DSkUKNBRlc+hOXLSjpCksX42eg4Mz9R366KhnNtVAxfj0xU6IR2AMG
         fFHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7nNyXWjTslAMVfN2zwi4CciK70v9u7MwkNKSL3AiaIfpLv5dfzHF2V/Lj1b2Pzd9WRhO80utNJA5n4V/uesFpJsVFxdL3KuKVAPTL
X-Gm-Message-State: AOJu0Yygi2ZBBpcUV0vVZMTqjWr8C7KVtwN1sRSqaoChosV7WU+dfka1
	i/17kSJYmGQW0Wiu9FDhv7+eNGgxqy3kSk7L4D6FLu0JuzVAVB6x21pAcCjl9Vs=
X-Google-Smtp-Source: AGHT+IFFjVS3YwVCuCcafKppGcchURFZOMOOvCIbiPgHcDeN2vkcCaZ2bLRdkf/VgJ0z60f3HMJ+4A==
X-Received: by 2002:a5d:6745:0:b0:33b:1b0b:934a with SMTP id l5-20020a5d6745000000b0033b1b0b934amr5045544wrw.47.1707386370056;
        Thu, 08 Feb 2024 01:59:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqKubOYfamGk7FwY+dOGwErNuYFvV3vdl+FBXnWHX0baBexvPKKbQVUdSe2WMmItVrRP6ihIscsP+WxONbrCmBWQR1L/5mA7w0Ykus5eWVhaNxoEV4xCrlltppGb9FRS9lDiqRdKzvXqpoB7tYYyJOqAaTVCwPunYjimZhOUxdxxL/N8TjIyTLTqdm7X+jPMBp9C04LCH8QL+4wa5D8VSaT8Bx8+rK7Ewqc5JYKax/ghM/nWY8Ov1RCh+rBFji1AXRfyQWAeGxjj+jJJ8t+5Y9U1CX1JfYxv328w/4ieJq9wAH0SvDmhqlPJBz0CJTwqXKa1b4vrqzhPBq41HUMNg8PcD6OHiwuw==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:29 -0800 (PST)
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
Subject: [PATCH v3 04/24] gpio: provide and use gpiod_get_label()
Date: Thu,  8 Feb 2024 10:59:00 +0100
Message-Id: <20240208095920.8035-5-brgl@bgdev.pl>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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
index 8ca9aebfa81f..8331fdbb6faa 100644
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
@@ -2391,7 +2396,7 @@ char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)
 	 *
 	 * Until this happens, this allocation needs to be atomic.
 	 */
-	label = kstrdup(desc->label, GFP_ATOMIC);
+	label = kstrdup(gpiod_get_label(desc), GFP_ATOMIC);
 	if (!label)
 		return ERR_PTR(-ENOMEM);
 
@@ -4732,7 +4737,7 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
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


