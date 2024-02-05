Return-Path: <linux-kernel+bounces-52324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840388496BC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0082BB25A7D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7361B940;
	Mon,  5 Feb 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zxXsC8LE"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9207518EB8
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125686; cv=none; b=BYr5tKaz/OdkLC/Owjlf+wQPNfcB+F5NAM71O0C4flqKN8AnnL4n6Z+xLUdkWMePer93LBI+9vVVb3U7lxOwnesonlx0nkUT1OaMmjVcaiQoNs1tPLVLn5VjlPpjhuaX2ARoOOXLctLEvnNL0y3yZiVWdwDwPG/eIgjfTbjK/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125686; c=relaxed/simple;
	bh=Dy4mC9/ApSM4G2nhOEYNfhdshYRm02m6ARcUBbiiHZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lcAhJKNjlDdxB6QtfLBpjCwWaMs32Z2ePPSc76rWc/+nazk8DMqgoCQmLiz6VZJg0RoazHPLy9pN5ghnqKh9uYP6ktcuQ3o+tUcWCUqbeansnuFsNhCgF90RojpqNX+k3R7RJsGg/Xdd8i77B4fAt1dWyyUeGTFjAJO2NXQ3Fsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zxXsC8LE; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5111e5e4e2bso6456734e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707125682; x=1707730482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iw+aFC5ArC2ijhUY9JiIEGX3/cbiqFWJyl5FMkkWhDw=;
        b=zxXsC8LEaBbNRHIIUAdNOr5R+GRHSZC0RhzRwdim8ICgN9J3fHCuB1ajtMV5zJSBai
         gT9glb/Y7X8WX1LujUDAUJ2FFtWYR7TLFOa+tLOpMfXTvCadPIdMUOy0pMzQHU4iaM+L
         z3O8bP4k4ekD+SR4E3ciE/Dtj+RrKFd324bIYHaEC4sr4BGqHrqBUEVA6qL00uP2SdWr
         +3mSMCLkwMV8kDr3yQYKfvybTEL5lcMfhU6s6NalldQMXCh765g/lwNVvO9ixBroll8y
         HLz9XQIg20XwBzaBfMNT9MRJXP4Ko4XVUToD3KMSqMTsK3dgMq1bLVfaj6ab/41c9UBu
         MljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125682; x=1707730482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iw+aFC5ArC2ijhUY9JiIEGX3/cbiqFWJyl5FMkkWhDw=;
        b=L7OctgnbgRJcV+4tenvUIdyyzAXDNhep5cAuUMxgApLSOvID3mXTEYJfaY4kKybR3P
         NP0XuJvfw1Nh8UkLeQAWw+ROv6HFB4UNejNtiDZMx+V7Ygr/53gU/A88ROLu/rkOTudY
         tM8C1DcFszONPsDNjF5RgfarbDVrXxR/196Gm141lhL/c+WNJLNInD6DJHGqD/isJ7yA
         Osgl9D+u58fqsGI3W4VkmkEsEBa7jw0sMOnIkj/aIAlOxBPe2ogxED4/oEqIgEctQDjo
         kH/JjyLxuUv/UI63Yux4KfhDCC83JoA3C1k8GeBCcu+G0O9CLAAf+bMTBn7+oa4JUUQZ
         fIxw==
X-Gm-Message-State: AOJu0Yx/2mVR++z6lO6K/8BmoMTh8OEeWZp+rnGykUyCCavyBQ7DEIOG
	1AoQBn7lHImT8LTPcnp3wNAbhlx5V44yXBODaoxopTeK0ClSSw9pXotdc6xdS1U=
X-Google-Smtp-Source: AGHT+IH0kgu91seENjOkYZzprpiiHZskLJKVML41ZB5XP9T3vwqrG04okuAk1g3DYhSvhBfBk0+0mQ==
X-Received: by 2002:a05:6512:239c:b0:511:3261:d112 with SMTP id c28-20020a056512239c00b005113261d112mr9043655lfv.9.1707125682699;
        Mon, 05 Feb 2024 01:34:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVTCt4J2ZTbN3EA1wpOUNy4BpzRJVF69tsMRM+N/P3JpQ6XRvjI01O1r4QlVcLcTm0q+KwQGQx6B4KEPf09BG7Lo9M2Hl3u/ZLoAxurWzye+beHodXs4+78XNQ750ntUeGTpazPnXyo0BaNz4nYT5rXDb4yWqu87OcwjG6peV5g4xB54Q4R4XinVQq3cMsbjTdfGnGS7zIx2S+MhiQU5BCXcV33ZOs23NjELsraFc3Xcmpfmr/64b63ai+/quKiyhShqF1xIiI8htQ8Qm7E6RPIaEqvw4/8REyKgkoEnqI4i6z3YWvUfvonjUNQBLzxsyXnVIrOOiVncdUGivf/aKm89A2i0Tg4Og==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d929:10db:5b5c:b49d])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c154f00b0040fc771c864sm7980397wmg.14.2024.02.05.01.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:34:42 -0800 (PST)
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
Subject: [PATCH v2 19/23] gpio: add the can_sleep flag to struct gpio_device
Date: Mon,  5 Feb 2024 10:34:14 +0100
Message-Id: <20240205093418.39755-20-brgl@bgdev.pl>
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
index 95b480f01fca..2f78fa9f8dbf 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -896,6 +896,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	}
 
 	gdev->ngpio = gc->ngpio;
+	gdev->can_sleep = gc->can_sleep;
 
 	scoped_guard(mutex, &gpio_devices_lock) {
 		/*
@@ -3066,7 +3067,7 @@ int gpiod_get_raw_value(const struct gpio_desc *desc)
 {
 	VALIDATE_DESC(desc);
 	/* Should be using gpiod_get_raw_value_cansleep() */
-	WARN_ON(desc->gdev->chip->can_sleep);
+	WARN_ON(desc->gdev->can_sleep);
 	return gpiod_get_raw_value_commit(desc);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_raw_value);
@@ -3087,7 +3088,7 @@ int gpiod_get_value(const struct gpio_desc *desc)
 
 	VALIDATE_DESC(desc);
 	/* Should be using gpiod_get_value_cansleep() */
-	WARN_ON(desc->gdev->chip->can_sleep);
+	WARN_ON(desc->gdev->can_sleep);
 
 	value = gpiod_get_raw_value_commit(desc);
 	if (value < 0)
@@ -3360,7 +3361,7 @@ void gpiod_set_raw_value(struct gpio_desc *desc, int value)
 {
 	VALIDATE_DESC_VOID(desc);
 	/* Should be using gpiod_set_raw_value_cansleep() */
-	WARN_ON(desc->gdev->chip->can_sleep);
+	WARN_ON(desc->gdev->can_sleep);
 	gpiod_set_raw_value_commit(desc, value);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_raw_value);
@@ -3401,7 +3402,7 @@ void gpiod_set_value(struct gpio_desc *desc, int value)
 {
 	VALIDATE_DESC_VOID(desc);
 	/* Should be using gpiod_set_value_cansleep() */
-	WARN_ON(desc->gdev->chip->can_sleep);
+	WARN_ON(desc->gdev->can_sleep);
 	gpiod_set_value_nocheck(desc, value);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_value);
@@ -3465,7 +3466,7 @@ EXPORT_SYMBOL_GPL(gpiod_set_array_value);
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


