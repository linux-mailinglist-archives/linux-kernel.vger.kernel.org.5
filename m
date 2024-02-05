Return-Path: <linux-kernel+bounces-52313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5B78496A4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A467F1C249B2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED71C17585;
	Mon,  5 Feb 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eo6843DD"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A3912B7A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125678; cv=none; b=idOmKCzsujmcEsXm0qPrtvn1sTyqV5qF9KG6vZxuv3dxMk5nSg6sTX26n1KMyzoJZYGLoOCRluLukPdrPTkaVvj6qKFKSOlmZzQ/CvfjzwCqaMzMJiYDQanIS8xzqeauQSZKGsD+2OaFOIm2rMJ4c7m2lalon1RlKOwcAE/oV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125678; c=relaxed/simple;
	bh=rfKavv+WG6jGS5BHlahGWQusPjVqbbXZ7CB6SI+xjkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=en6C0DnfR6IafjJddFPtwwKRDqHZCelUwMNRZCxxaBQhXXatQolWkZCCnxBlcFskazb+qRWGOlRaJUx3TltVMJFVYxTpaYgxyw4tZZouniTXjh0050wonxGE5Z6mzANSOtGkYh8yGmTTPyQW/KHG9t7pDT3/hbzlY+p8rPHNh1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eo6843DD; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5100cb238bcso7531976e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707125675; x=1707730475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBVIUbEZhzPUY5wnbR8PSqxrCBFBG4RRWNGnrCutvhg=;
        b=eo6843DD9eFSeuKm9WWRqFLHKuNJsAsJCe1t5eP56+JJ5PPb0Uy35xAGsWJC47J78V
         ooKBZR48+Crkfcf8B5H0p9bmvcyvopaVnz/xZSJxjaRS7kWL+SwnlUxUDSJY6AbFAbTK
         DreAJ6YjZ6jU3kvpSdJ5RSE1G87roRZLMP/SdKjb0YHLiH4fn4wC2j9PFtuvfwdBTLa3
         tN2C8mo/YzPr9ch9cyxyjTXVxNZeTnLmnu2UT7FXZ0hiY1v/KQFIfRyjBGn0knCWk3/k
         3viNMxPwTRhIJwo5KlAhmwXfZjBTAkMB/PTNG85LG9DgDOuMgxM10k4ehNo7RKrQ1p/E
         1upQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125675; x=1707730475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBVIUbEZhzPUY5wnbR8PSqxrCBFBG4RRWNGnrCutvhg=;
        b=DgoVzgmYfUFfxjKDTHummVlCSXcPnxy/zbRVeIUezw1Hw+vliHRbNJENUMsJdku/rj
         Wj9AQ2RtxdF076mV4qk3J9XtY08YLw0+a6RwhFoKUTLuMZQclUX/vpds7avlR9f/KA8W
         77fXLSSqvMtJqc2pNZaDhE1iLO9ZMskn6LWFGZC91EbRnmnhT1CSsFtEAIUhFehkx3aO
         a1MR7/qcl5abUWy7wTkeJVyulOfK0SPR7j/ySFg+xM8ieG6tfefWMmOWxqcPntMl+dsB
         WgeBKWWFUtwywOGlM9dwOVpDq7+d6/oymgK2grZmDedHmuqgPkEDJNAWf/Jbh3kQUQFU
         PIPA==
X-Gm-Message-State: AOJu0Yw21zDVanlHYnQswUNnfntvayJU0d7hSQcz7MpE0K98UwZdZeMO
	3C/LZVhwdgQoiZuscFG77M3JQu55l3lFJ9XYBDZhaQCP+I54Te30tgaUn91i1g4=
X-Google-Smtp-Source: AGHT+IFf5V3o092bmqPbbvpWyHNdPE2eO7k80aGf9SuKa1MQgaO3K0nCTsSkjqLFZNeKshudZ6G6cQ==
X-Received: by 2002:a05:6512:10c8:b0:50e:7410:d5b0 with SMTP id k8-20020a05651210c800b0050e7410d5b0mr6312960lfg.28.1707125674803;
        Mon, 05 Feb 2024 01:34:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU+vRrFS3A2LQom52oicbbrO1+QRNmZbSVSC2RqEnatt0iYkThW7J9MLI/MMTZItiNU4cz3RvUAZw2i+BnyZCheQOcyCcYrKBEa8LZGPtzgg/Wbvo/C/fo9aHnqMgD6aWctF6ZMr1nY7P7LAql/Z9HOAXR7qHTosr4yZLKD4rzhVqqsFyyrS9fNhgwstDS+qJVd6aaaAzK7zoN3jCZdzJRfHMJihL3AFoPtaXNULJtw5Ru1s8z6IDJDfwolEKW3s8fRKtgu9xPmBB/H5TQ3sGWvIkPe3/njUZsQevjoFlwMadyF1zAa8VW9+gzCEtVs2/zxSHsttQNI1q2RrRxH1QAI4Xe8GEtACw==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d929:10db:5b5c:b49d])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c154f00b0040fc771c864sm7980397wmg.14.2024.02.05.01.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:34:34 -0800 (PST)
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
Subject: [PATCH v2 10/23] gpio: reinforce desc->flags handling
Date: Mon,  5 Feb 2024 10:34:05 +0100
Message-Id: <20240205093418.39755-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205093418.39755-1-brgl@bgdev.pl>
References: <20240205093418.39755-1-brgl@bgdev.pl>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5ed5b71590ab..d49f84d692ce 100644
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
@@ -2522,13 +2522,16 @@ static int gpio_set_config(struct gpio_desc *desc, enum pin_config_param mode)
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
@@ -2694,24 +2697,28 @@ EXPORT_SYMBOL_GPL(gpiod_direction_output_raw);
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
@@ -2721,7 +2728,7 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 			ret = gpiod_direction_input(desc);
 			goto set_output_flag;
 		}
-	} else if (test_bit(FLAG_OPEN_SOURCE, &desc->flags)) {
+	} else if (test_bit(FLAG_OPEN_SOURCE, &flags)) {
 		ret = gpio_set_config(desc, PIN_CONFIG_DRIVE_OPEN_SOURCE);
 		if (!ret)
 			goto set_output_value;
@@ -4418,21 +4425,22 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
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


