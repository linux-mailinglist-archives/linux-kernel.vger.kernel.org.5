Return-Path: <linux-kernel+bounces-57808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A58484DDA3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85536B230AB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964E178B63;
	Thu,  8 Feb 2024 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="M5mSXy1n"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171DD7641C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386390; cv=none; b=jxNJNCpoEMWyyrczDiz5HGKNsuXa0AY8LxGfmzSl45HgvcRmp6UgAxRq4o78WUzUard2CkaPACqgwKJTNz4JNWYLIqQDCcP8M4YSLqpho0mJN1g6nR4ptFaq7/bsQ+L14NwbMqhLxBqMkPbbf0Zov8W6Bl3RwefmXfmtBMck6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386390; c=relaxed/simple;
	bh=ljjZy/qeWAChuW+CO/Y5jU0Jf2aUL7O/Whh7X+N9I7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mJvHkDkByhmYFYE8r4jbuQ8t4hKTfRXrnZJ/Bv1OBsWk2jbsZbeKV8ZkiCTNOdHW+5aUScj2jCOkb6hfzw2yYlzOy9p8TFMzdvkXIJn60KRYdKOJqxD4Pxod8CGH84pSmeZXkYY5/KSnI3eCOK/KRLxFXIkk3uOhK9fzWeNXzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=M5mSXy1n; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b0ecb1965so1042317f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386386; x=1707991186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIvNEBkPA+Jjg13j8QnlUqFTrBX7oVdTnxr73OrkEHQ=;
        b=M5mSXy1nCoEwNgnxZYBq3fDTGWqIuIG1FVyJlEw5r05PiohxeiAWTcvkgOHmYQr7aS
         dUoDvc3NCRhjEl8A9tvZ6johSAtfZJ2cZg+KxG89PEkbNZv15IZpT4vKe1/cXSvmBb4i
         fPeCUSe9RccDtnK7XuAqpO/9IkMSAH2Fzos59+uvKt95tO+eTSM0XrA2GYeuOP7lFkp7
         MTH7IwlIGaA9IAscBeyCRPITAAUcr4t19UghL4VCSqWBGhAcBBo/I8dzrghi+/e54BjE
         ruhzTpUQFv0n3POKlPBQ6agaVMOywUSEDt1ze3QbfD7A2ONviafBtub75k8dMC4W2LCp
         Rx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386386; x=1707991186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIvNEBkPA+Jjg13j8QnlUqFTrBX7oVdTnxr73OrkEHQ=;
        b=mnROXojHHEpNeF5hZKdABZXqWYhu8ZyHBpMIj3+5tBg/K+V+7uMH75utJlw5fzc/Nq
         XT9FBeL58ur6OaKcuOzIjugn3+uIOc5AicdTaeD6z8epGBYEmVr3iMyvopFiAYK+HboP
         omajLalBrc3vIrb0zo2IsJc8ZSDLJBTis8pl2Lux2zHlIn0SADcMrkUtb8sgAYT5cIns
         4Oli+ExbA/S1W6yQtWVF6CEDjXotibwieQUCViJIIdArddqEktmPmRAA1o6pvmdigGTW
         WmzdDQyzn8Sb4mgL7zPjgG1pF6r5tQqLctXAPNgvQFeBAzbt1WprEng6WjU27kqguMgQ
         WRqg==
X-Gm-Message-State: AOJu0YyvIbDjQZuMaY73gRK9OGZ63yXsgvIIGQfKL1QUW3K+yDU8JI0w
	uqNhGSQME54K+Y/H2ND/fAUzfbIQKazUV0M+6nMV/YEULz1xaRGxgCO8s5JlfEY=
X-Google-Smtp-Source: AGHT+IGvg9eLN/pGzCLxk/zi7uN/bHn9gY2+HRAG3E9ooY6h7syoSSP/0EobJQfiCCGWIJ3C36tmnA==
X-Received: by 2002:adf:f44a:0:b0:33b:3c04:ddbd with SMTP id f10-20020adff44a000000b0033b3c04ddbdmr4917395wrp.21.1707386386086;
        Thu, 08 Feb 2024 01:59:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQ/EQOWP5gB7wL9iMIPtnEWtWtOiCiPgt74dBoDZogxfj21dNZ8rHJUfAyzH7eWNeR5qi4HYuqRTz3ythjGeT3qoc8gq9HgKlota9F4tZC+nyZ61L3t0oxORzXEHXESHWLCA9BP4X8Rcc+nuDQVR3VbHNpRu/NaI09pphNLjMFzXqB9dXopCvY1qXKiAHbkvLZ0TVMeXcuOXVgdRWvpFf9bpqqU/PHCTlBnMBPJKat/EphpHopa9MeOORxp0mJelz9jw6gXhgypdHgTdko6tCCKlCRsT3N38xaCFhGwX4LTTjN5KcjjuzIFXVNliRbbSDTk/cZCF9njLXlt3Isr+5WSdGYXp+OEg==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:45 -0800 (PST)
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
Subject: [PATCH v3 20/24] gpio: add the can_sleep flag to struct gpio_device
Date: Thu,  8 Feb 2024 10:59:16 +0100
Message-Id: <20240208095920.8035-21-brgl@bgdev.pl>
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

Duplicating the can_sleep value in GPIO device will allow us to not
needlessly dereference the chip pointer in several places and reduce the
number of SRCU read-only critical sections.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 11 ++++++-----
 drivers/gpio/gpiolib.h |  3 +++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 140a44dec0be..6b696087c7f5 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -901,6 +901,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	}
 
 	gdev->ngpio = gc->ngpio;
+	gdev->can_sleep = gc->can_sleep;
 
 	scoped_guard(mutex, &gpio_devices_lock) {
 		/*
@@ -3072,7 +3073,7 @@ int gpiod_get_raw_value(const struct gpio_desc *desc)
 {
 	VALIDATE_DESC(desc);
 	/* Should be using gpiod_get_raw_value_cansleep() */
-	WARN_ON(desc->gdev->chip->can_sleep);
+	WARN_ON(desc->gdev->can_sleep);
 	return gpiod_get_raw_value_commit(desc);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_raw_value);
@@ -3093,7 +3094,7 @@ int gpiod_get_value(const struct gpio_desc *desc)
 
 	VALIDATE_DESC(desc);
 	/* Should be using gpiod_get_value_cansleep() */
-	WARN_ON(desc->gdev->chip->can_sleep);
+	WARN_ON(desc->gdev->can_sleep);
 
 	value = gpiod_get_raw_value_commit(desc);
 	if (value < 0)
@@ -3366,7 +3367,7 @@ void gpiod_set_raw_value(struct gpio_desc *desc, int value)
 {
 	VALIDATE_DESC_VOID(desc);
 	/* Should be using gpiod_set_raw_value_cansleep() */
-	WARN_ON(desc->gdev->chip->can_sleep);
+	WARN_ON(desc->gdev->can_sleep);
 	gpiod_set_raw_value_commit(desc, value);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_raw_value);
@@ -3407,7 +3408,7 @@ void gpiod_set_value(struct gpio_desc *desc, int value)
 {
 	VALIDATE_DESC_VOID(desc);
 	/* Should be using gpiod_set_value_cansleep() */
-	WARN_ON(desc->gdev->chip->can_sleep);
+	WARN_ON(desc->gdev->can_sleep);
 	gpiod_set_value_nocheck(desc, value);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_value);
@@ -3471,7 +3472,7 @@ EXPORT_SYMBOL_GPL(gpiod_set_array_value);
 int gpiod_cansleep(const struct gpio_desc *desc)
 {
 	VALIDATE_DESC(desc);
-	return desc->gdev->chip->can_sleep;
+	return desc->gdev->can_sleep;
 }
 EXPORT_SYMBOL_GPL(gpiod_cansleep);
 
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 9b7afe87f1bd..43ff4931e2c3 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -34,6 +34,8 @@
  * @descs: array of ngpio descriptors.
  * @ngpio: the number of GPIO lines on this GPIO device, equal to the size
  * of the @descs array.
+ * @can_sleep: indicate whether the GPIO chip driver's callbacks can sleep
+ * implying that they cannot be used from atomic context
  * @base: GPIO base in the DEPRECATED global Linux GPIO numberspace, assigned
  * at device creation time.
  * @label: a descriptive name for the GPIO device, such as the part number
@@ -64,6 +66,7 @@ struct gpio_device {
 	struct gpio_desc	*descs;
 	int			base;
 	u16			ngpio;
+	bool			can_sleep;
 	const char		*label;
 	void			*data;
 	struct list_head        list;
-- 
2.40.1


