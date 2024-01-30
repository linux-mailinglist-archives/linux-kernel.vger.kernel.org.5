Return-Path: <linux-kernel+bounces-44637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D4F84255B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A14428DAFD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC7D7CF36;
	Tue, 30 Jan 2024 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oJrN/VB1"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757A74E04
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618932; cv=none; b=daKdT7wptZz+ZK2caOx+Ixxw1591h1XRAg/2PqEJQpNJFi0lBll/6F6cBA2gMmFFvVDiB4/ToIuve3AHagfMD4EQ4qpQJ6JIueIDRjHgQwT/3Yidii5auejgqNdPUaOxambVmy/qdvavT8R300iTZroYEH19C1hpGHVPdbC6Iaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618932; c=relaxed/simple;
	bh=nXx8yVTcWnlXDm0gGqZ7L8XGH6wIb0qkgZgWaKrqUgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ras4THRZfQRgXLNwhOL6vsVI+acODc51J21y4IBklBmOk9dBCcK3PKMyTK8vEIdtly7xOXHm0pkQibEMFNQxH+pKZ05IrfN3cXr76jmxJBoBzsTgnoROXKOvJdSRhtX36/HSyY5NoNe2rnR0Om3ZWbmAI3GMwJFo1RjQhurbb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oJrN/VB1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33ae53eb5a8so1749748f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706618928; x=1707223728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/+GBocpEX3V6OhfNKQDjzYMTqpuy85WJNa2b61gzRM=;
        b=oJrN/VB1EmCDL4MbH0bm9o1gQXHrhjyGEKckfUN9kT5R3J8KVp31IK932pWIrIFMVh
         vK/C0PXRGyjWzS3wyiIFTGSq2wZnhWCu8szb+KsviTJiwBPv82V2r/HU6UODCxwsKlOj
         hLw4XahqGyJXL50rWg3oios0jV5oJBkQcsr4J9LJ7KD9NFpMqKcVxUzWQLyEuP/mY1S7
         gfZ1LzcWdYlkHI1CFJOd2pt4oJavVSGKAYgha12LLNa49p6XU/yMGWS8a825JroRnHfL
         DZdqp1PJMCV7O+TBQXPAKY04qJh73hO9Ox8hi6g+2gEyXMeEEU+BBB4xByMapfaKYL1m
         glvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618928; x=1707223728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/+GBocpEX3V6OhfNKQDjzYMTqpuy85WJNa2b61gzRM=;
        b=m0WX5aKdRjVbybnDZsqCmWBcnVeErHGpjTgdAoxDAq569X7LmU6eqbEBIJFra8VT/k
         2azDn8S6PKqQv1nJf9C8XO0RzZCRazAa0QePDL6NKGzVlY84gJaJIRWbPsKmZzDlvEhs
         0xA2SwT16nFUlX48RDwy0pRVz47viyV3+/ToHxHPWrP2KTKxSBIZZ5TQPwBc/2v7UzxL
         Ohxk5R3ql3WpOoTAK1waA3e90depg5mQCsnwjQ/yCh8UgTQ9DJN8iKRlKeb0aPrdBW7p
         +HoFbtO67wyIz8tLQ7cAgJBUmYIMG8DzF1EUtG6ywOfj8I73WW8yQikj8Q6wK4bzfYrW
         DY8w==
X-Gm-Message-State: AOJu0Ywnz+LYtOflEfy08VKvkN721r3y65ZwjAg8w3RCF4yCHGv+y8dc
	cXeaUe3rDcOF19q9XfHx30j6EimrZSPf2nwHA7Ep8PQGRueWMi17le97pgQHCC4=
X-Google-Smtp-Source: AGHT+IEXGA9cAJWkoWgMayatrsi830SoOlFmzzOlAt7Y2lcLJRYLSnBg2OAelLX6ESPmnxLZmR9s/w==
X-Received: by 2002:adf:f052:0:b0:33a:f66a:8168 with SMTP id t18-20020adff052000000b0033af66a8168mr2275719wro.60.1706618928774;
        Tue, 30 Jan 2024 04:48:48 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:abc8:f77e:abeb:129c])
        by smtp.gmail.com with ESMTPSA id en8-20020a056000420800b0033940016d6esm6625337wrb.93.2024.01.30.04.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:48:48 -0800 (PST)
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
Subject: [PATCH 10/22] gpio: reinforce desc->flags handling
Date: Tue, 30 Jan 2024 13:48:16 +0100
Message-Id: <20240130124828.14678-11-brgl@bgdev.pl>
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

We now removed the gpio_lock spinlock and modified the places
previously protected by it to handle desc->flags access in a consistent
way. Let's improve other places that were previously unprotected by
reading the flags field of gpio_desc once and using the stored value for
logic consistency. If we need to modify the field, let's also write it
back once with a consistent value resulting from the function's logic.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 2a7439db7392..f15b854bbcb2 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -336,18 +336,20 @@ static int gpiochip_find_base_unlocked(int ngpio)
 int gpiod_get_direction(struct gpio_desc *desc)
 {
 	struct gpio_chip *gc;
+	unsigned long flags;
 	unsigned int offset;
 	int ret;
 
 	gc = gpiod_to_chip(desc);
 	offset = gpio_chip_hwgpio(desc);
+	flags = READ_ONCE(desc->flags);
 
 	/*
 	 * Open drain emulation using input mode may incorrectly report
 	 * input here, fix that up.
 	 */
-	if (test_bit(FLAG_OPEN_DRAIN, &desc->flags) &&
-	    test_bit(FLAG_IS_OUT, &desc->flags))
+	if (test_bit(FLAG_OPEN_DRAIN, &flags) &&
+	    test_bit(FLAG_IS_OUT, &flags))
 		return 0;
 
 	if (!gc->get_direction)
@@ -361,7 +363,8 @@ int gpiod_get_direction(struct gpio_desc *desc)
 	if (ret > 0)
 		ret = 1;
 
-	assign_bit(FLAG_IS_OUT, &desc->flags, !ret);
+	assign_bit(FLAG_IS_OUT, &flags, !ret);
+	WRITE_ONCE(desc->flags, flags);
 
 	return ret;
 }
@@ -747,9 +750,6 @@ static void gpiochip_machine_hog(struct gpio_chip *gc, struct gpiod_hog *hog)
 		return;
 	}
 
-	if (test_bit(FLAG_IS_HOGGED, &desc->flags))
-		return;
-
 	rv = gpiod_hog(desc, hog->line_name, hog->lflags, hog->dflags);
 	if (rv)
 		gpiod_err(desc, "%s: unable to hog GPIO line (%s:%u): %d\n",
@@ -2519,13 +2519,16 @@ static int gpio_set_config(struct gpio_desc *desc, enum pin_config_param mode)
 static int gpio_set_bias(struct gpio_desc *desc)
 {
 	enum pin_config_param bias;
+	unsigned long flags;
 	unsigned int arg;
 
-	if (test_bit(FLAG_BIAS_DISABLE, &desc->flags))
+	flags = READ_ONCE(desc->flags);
+
+	if (test_bit(FLAG_BIAS_DISABLE, &flags))
 		bias = PIN_CONFIG_BIAS_DISABLE;
-	else if (test_bit(FLAG_PULL_UP, &desc->flags))
+	else if (test_bit(FLAG_PULL_UP, &flags))
 		bias = PIN_CONFIG_BIAS_PULL_UP;
-	else if (test_bit(FLAG_PULL_DOWN, &desc->flags))
+	else if (test_bit(FLAG_PULL_DOWN, &flags))
 		bias = PIN_CONFIG_BIAS_PULL_DOWN;
 	else
 		return 0;
@@ -2691,24 +2694,28 @@ EXPORT_SYMBOL_GPL(gpiod_direction_output_raw);
  */
 int gpiod_direction_output(struct gpio_desc *desc, int value)
 {
+	unsigned long flags;
 	int ret;
 
 	VALIDATE_DESC(desc);
-	if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
+
+	flags = READ_ONCE(desc->flags);
+
+	if (test_bit(FLAG_ACTIVE_LOW, &flags))
 		value = !value;
 	else
 		value = !!value;
 
 	/* GPIOs used for enabled IRQs shall not be set as output */
-	if (test_bit(FLAG_USED_AS_IRQ, &desc->flags) &&
-	    test_bit(FLAG_IRQ_IS_ENABLED, &desc->flags)) {
+	if (test_bit(FLAG_USED_AS_IRQ, &flags) &&
+	    test_bit(FLAG_IRQ_IS_ENABLED, &flags)) {
 		gpiod_err(desc,
 			  "%s: tried to set a GPIO tied to an IRQ as output\n",
 			  __func__);
 		return -EIO;
 	}
 
-	if (test_bit(FLAG_OPEN_DRAIN, &desc->flags)) {
+	if (test_bit(FLAG_OPEN_DRAIN, &flags)) {
 		/* First see if we can enable open drain in hardware */
 		ret = gpio_set_config(desc, PIN_CONFIG_DRIVE_OPEN_DRAIN);
 		if (!ret)
@@ -2718,7 +2725,7 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 			ret = gpiod_direction_input(desc);
 			goto set_output_flag;
 		}
-	} else if (test_bit(FLAG_OPEN_SOURCE, &desc->flags)) {
+	} else if (test_bit(FLAG_OPEN_SOURCE, &flags)) {
 		ret = gpio_set_config(desc, PIN_CONFIG_DRIVE_OPEN_SOURCE);
 		if (!ret)
 			goto set_output_value;
@@ -4411,21 +4418,22 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
 	int hwnum;
 	int ret;
 
+	if (test_and_set_bit(FLAG_IS_HOGGED, &desc->flags))
+		return 0;
+
 	gc = gpiod_to_chip(desc);
 	hwnum = gpio_chip_hwgpio(desc);
 
 	local_desc = gpiochip_request_own_desc(gc, hwnum, name,
 					       lflags, dflags);
 	if (IS_ERR(local_desc)) {
+		clear_bit(FLAG_IS_HOGGED, &desc->flags);
 		ret = PTR_ERR(local_desc);
 		pr_err("requesting hog GPIO %s (chip %s, offset %d) failed, %d\n",
 		       name, gc->label, hwnum, ret);
 		return ret;
 	}
 
-	/* Mark GPIO as hogged so it can be identified and removed later */
-	set_bit(FLAG_IS_HOGGED, &desc->flags);
-
 	gpiod_dbg(desc, "hogged as %s%s\n",
 		(dflags & GPIOD_FLAGS_BIT_DIR_OUT) ? "output" : "input",
 		(dflags & GPIOD_FLAGS_BIT_DIR_OUT) ?
-- 
2.40.1


