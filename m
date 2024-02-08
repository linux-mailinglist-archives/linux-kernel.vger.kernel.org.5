Return-Path: <linux-kernel+bounces-57803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD93484DD98
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6573028A67F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B22B762F6;
	Thu,  8 Feb 2024 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1qtX6wqj"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BAA74E09
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386384; cv=none; b=GeWDP3/d7ENax1IiOnT+0GG/oOnqqDoOdYU8A6bKr6AgJI4mPfPt1M4STxMuZqIcg/HzrTodJ9EnpB1cvGHAhevp/TaEbGpfY7Wk+xLTJ0eLvREoWWhM0bdO+RxMf8Mbzi1tmzsO2Pew6/JaltTSDhxJo8U5NGSdi154Q3ujdvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386384; c=relaxed/simple;
	bh=yLFHAeDDaUuIFRqdSf+MG12ymiBBzwEskiNkeG6cKEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQMaq1SjLLvyRQXRgQT4QPWRwAVfMM7RLQlbJlT0gR0BdEComUyVp6TrmR0wfWUhxRZXeiIgE8Zs0xQDVIOTGZ3wyHJhVdUIEXbeUjgc9jS4eN1Y69C68HnSP+i69J27uV7FI2H++Zfomj2XEdpJuIorfIAcThaQbVSrsahcLD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1qtX6wqj; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so1134721f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386380; x=1707991180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsALcY7SVXjN//VI/pQguwi8KjWlDmDQg/LjiqJYZd0=;
        b=1qtX6wqj8/0p2hfysZ3jRLMZqZOS4HDed+2AdsWmkj5lHaoMuxRPZ2xTWkKvAqZH9F
         /kX83412zMylpC6URrLgRwWH3T8M6qN+55KhDGtEGafn3BVifZA/4fZ9hHqyv5dNsfAA
         BF9qJwGRahu04jBeofmWAub9/wEptX2Pb0GyjLsBo+fsaDVqJ/bBQwX8suifnz9qM0Z5
         iCHNGpplhZEtSXIXVR+SiRGpuvHxx8gUA7tfWt+PtnzV7f5wNqcgOMIFp3SP0gx3KF3K
         /0OWsG34aTZkE5a9RrGCA2ZbYCqA7R+d9h0hRvx3y2JLp1UrRXjnkhDYScsSA71KuT8M
         vf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386380; x=1707991180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsALcY7SVXjN//VI/pQguwi8KjWlDmDQg/LjiqJYZd0=;
        b=jA4ABQdDqEOgZGmDIYoRmsHqcX45/Gcchfm4YXn3TGTJZjuUh7cZLfK0Hl249zShPy
         FVA/pTbWix8YFwRPstiuSvbQ6ROgYJs0QDFhAFpjzoxtOU3SrHj5ySvydZ9tEd5yQeKI
         er7XNQh/KPPtpaTQsDusQbpSKI42oOZtO+tOtm4w9OMgTDJIB0Btzov9V4m9q262hwx8
         k3VmGTieNVXsvfw/gAju7zCsnwsYXsVV3pnpNeiNmcrq4R49T2LtHXUzjeCk4DLPHBJn
         L9hLjfHEkQ6cZIVvtWNwEuMpGkm8LsUcpYvLYjHl4nLlbNwhc9EnLmsrOBmBf8k98cE/
         bQfA==
X-Gm-Message-State: AOJu0YzHN9P584S3RyWjqaQicwMPDcEPr6op0hof9+n2okGx11bmesI+
	KBKKQvmTxt1uhCflFZMvaF7EcWdBcNryGd2i1KEVWM7MAPku7UAhdr8ejG0hpRM=
X-Google-Smtp-Source: AGHT+IFrf5Mi2lbu0tAJ9MwJBdkg3fx6DDnSA74evr3YBdKkBJ30+7jCIZH5ZmX0DxE3/CQy1WwcGg==
X-Received: by 2002:a5d:46cd:0:b0:33b:3770:730 with SMTP id g13-20020a5d46cd000000b0033b37700730mr4376990wrs.65.1707386380111;
        Thu, 08 Feb 2024 01:59:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWbyshcKUDQFIROX24EyWLxBStQmm0RK0cYD73MuCllakt7BZAuQG/6v+kj05bIzySdLlMqzEyzVXz1kjAG/Iugn+frgOb/ZrGoL4OuGkfBJfCMYN7xgAOAfnPW1psQWs7+6lJ3nN3DKlWiDpV1Hg7BJ3drork0Dyldb8n/ohbfBlY1BrceiLQpag4B72N7NdhAYPIQqMyhUmIuW59G8B6Rv8/ThlF3W+EjVX3QwWjfguU+XeRxkoDeQQhE10CYleJnas2CLJG20Pg6SglHGqw4G5Y9uv0pNPAh0NDa3EaqKZQOsKupHIXA9D6EvzLmHBtdXl0V7pGJwkEDBaAAQjmclPGAdR2oLA==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:39 -0800 (PST)
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
Subject: [PATCH v3 14/24] gpio: cdev: replace gpiochip_get_desc() with gpio_device_get_desc()
Date: Thu,  8 Feb 2024 10:59:10 +0100
Message-Id: <20240208095920.8035-15-brgl@bgdev.pl>
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

gpio_device_get_desc() is the safer alternative to gpiochip_get_desc().
As we don't really need to dereference the chip pointer to retrieve the
descriptors in character device code, let's use it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 3588aaf90e45..8e37e3befa08 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -332,7 +332,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 	/* Request each GPIO */
 	for (i = 0; i < handlereq.lines; i++) {
 		u32 offset = handlereq.lineoffsets[i];
-		struct gpio_desc *desc = gpiochip_get_desc(gdev->chip, offset);
+		struct gpio_desc *desc = gpio_device_get_desc(gdev, offset);
 
 		if (IS_ERR(desc)) {
 			ret = PTR_ERR(desc);
@@ -1739,7 +1739,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 	/* Request each GPIO */
 	for (i = 0; i < ulr.num_lines; i++) {
 		u32 offset = ulr.offsets[i];
-		struct gpio_desc *desc = gpiochip_get_desc(gdev->chip, offset);
+		struct gpio_desc *desc = gpio_device_get_desc(gdev, offset);
 
 		if (IS_ERR(desc)) {
 			ret = PTR_ERR(desc);
@@ -2123,7 +2123,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	lflags = eventreq.handleflags;
 	eflags = eventreq.eventflags;
 
-	desc = gpiochip_get_desc(gdev->chip, offset);
+	desc = gpio_device_get_desc(gdev, offset);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
@@ -2419,7 +2419,7 @@ static int lineinfo_get_v1(struct gpio_chardev_data *cdev, void __user *ip,
 		return -EFAULT;
 
 	/* this doubles as a range check on line_offset */
-	desc = gpiochip_get_desc(cdev->gdev->chip, lineinfo.line_offset);
+	desc = gpio_device_get_desc(cdev->gdev, lineinfo.line_offset);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
@@ -2456,7 +2456,7 @@ static int lineinfo_get(struct gpio_chardev_data *cdev, void __user *ip,
 	if (memchr_inv(lineinfo.padding, 0, sizeof(lineinfo.padding)))
 		return -EINVAL;
 
-	desc = gpiochip_get_desc(cdev->gdev->chip, lineinfo.offset);
+	desc = gpio_device_get_desc(cdev->gdev, lineinfo.offset);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
-- 
2.40.1


