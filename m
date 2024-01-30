Return-Path: <linux-kernel+bounces-44641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1832842567
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A5E2825CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6EB6BB37;
	Tue, 30 Jan 2024 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XU0RB5am"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4767E77B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618935; cv=none; b=ITNTNGLJm7HshMRPw5nFfNTOVmhf52UUL69HAL8O+LrMKfcgz83TfJYGUvFzXgEllwyW6vVkc3ShLHdPsx+GnBEq1gMI8TLk7Res1f/AYCABchU43s8sTFptU9rvBeAEAb61lLjMW5L/xNVZxUvH21q+ZlbgESxiVshrF+k+N+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618935; c=relaxed/simple;
	bh=P0fpiGp5nZFnS9A7xUZ41zg5kM5azFcGUXMbA0N6ucA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R6qb4rNHAXNSC3C7V6bzoo/lyMIz8INZwx3kcbWOhUKx65C8Y3B6ntElOeGRjirbD+AYo4f+ADwr+/BYqNnFs9i4ymUXRpVOUn0gbn4q4vUzN3g/ekL0AMhBMhMIPt6Gi3qBkXWf5a1bcT2ZiXo6a76epnll+7dYpSpMZr6BojQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XU0RB5am; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so43856725e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706618932; x=1707223732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb9TyWMPsQ5KQZC4eDog23uHb9wmzTL3cKu6UEWToqw=;
        b=XU0RB5amldRriGo1UfhkqR9cnervyt6trqV+0tbhHrrVR2b0VSYSZS9hoakr1FxErL
         L+xxBsaijYuQ3AD86vmV2W40rDcVsXnT6qYGn0vupvcuPz3dq/STobZEIxKNGwZ4RyeI
         Sf83YQIKjw4v/koUu3WwY1KfD1umjEDhzf5VhhLhfvlhBiBUN0jYWi1QeFrAl2KKb0sQ
         phtEFBoB6plK+VHUderG4CJPu65ONuI1EIbRUqf1U6osgy6Wg5McN3Sp+MvVHN3bxCkx
         rFaLGnwLYgVnzipCDsJj+jG9VNrp6uP4h1r4BDBqkq8h/QpT37qtA7eoXzFkw6qXAQ8Z
         r1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618932; x=1707223732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xb9TyWMPsQ5KQZC4eDog23uHb9wmzTL3cKu6UEWToqw=;
        b=U+TUet4gN+fT2/DoRPTgnLjoJPzDgT/+DBHu5kJjEsNb+yvcTXRU57WDLUSddf2oD1
         TCGuLGRkYxgnPOEtdCJ1GqOMDi9aTvMEgx75jBg6yBLPH6ZKQUn64CwvSMQCAmwRgaWF
         b5Nb7ypIVTBR9TFo5stX/Ty/LxhUxr1elMNjScWF0WTF5YZpWoNxJcfYfyfZI/+rUbdj
         151Om1YCKCMmE9bsX+lg7yTk7pSGqE4YOVJXYcsrTtnFGw6hC2mVw8yueB1dQOhUfIZB
         yqHlR28gs1Rc7Jv9t/7bgLhUkzVDse3smQuySal1F6J27j5Y5TLhrjkPW64XnDmOaHWV
         Fjvg==
X-Gm-Message-State: AOJu0YzuDgw/PLxKBS9kHAMK4tJOenMR9A4zYTzQ/H2ieoirmHqt1zfW
	kgOG+qZvnpH4vgDSZA2Ybkb8xFILsZRYTqBUSH8e7+9BFn5P8dQcfG2srvdGq64=
X-Google-Smtp-Source: AGHT+IESu436xQNXUagYramPear/UO6nk8cYEQiQJpYS/zkYwkeS0iMklSKZeSi+yMqkzdTCNIEXig==
X-Received: by 2002:a05:600c:4745:b0:40e:6922:6c7a with SMTP id w5-20020a05600c474500b0040e69226c7amr6824308wmo.24.1706618932189;
        Tue, 30 Jan 2024 04:48:52 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:abc8:f77e:abeb:129c])
        by smtp.gmail.com with ESMTPSA id en8-20020a056000420800b0033940016d6esm6625337wrb.93.2024.01.30.04.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:48:51 -0800 (PST)
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
Subject: [PATCH 14/22] gpio: cdev: replace gpiochip_get_desc() with gpio_device_get_desc()
Date: Tue, 30 Jan 2024 13:48:20 +0100
Message-Id: <20240130124828.14678-15-brgl@bgdev.pl>
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

gpio_device_get_desc() is the safer alternative to gpiochip_get_desc().
As we don't really need to dereference the chip pointer to retrieve the
descriptors in character device code, let's use it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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


