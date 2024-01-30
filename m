Return-Path: <linux-kernel+bounces-44645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7B484256D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440B01C278DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377EE1292C2;
	Tue, 30 Jan 2024 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OHJjwBYU"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC7D86AE5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618939; cv=none; b=GmXGLPRt/q6BCNsT7yzR/UTeuCu14Rj+5y7TAUmgek8b1wVcXbew6XWHXiVrGULvgCKsdFFa012lNnwrhOj4wLs9VXfwRUXkrerJtxnIMVmk5PpnNhSfJM0I8Ot4ieayX5dwRZOXcPnqzSDQpJ4SLkMo+3DISlq4061As8UZ/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618939; c=relaxed/simple;
	bh=rCYeX5n7NqvUrv+R10qVmknBqfvICmkDgzC01rCJba8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/AI6Ibz9KiYSv18dWAEha2qiz/57anhDt/P3nm03a6WQaEu9mHm3AsNXzscHgWvI/A+vthXcOldLHCOdA8gRbN3SbP0uFiyulr+CxkIM90X+rulsJ2FqGEwbu/IZBXumdXbKvrO9izhJVHgn5Z/xl992KUdiFxQ6ji9DWKVru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OHJjwBYU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40eac352733so45556585e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706618936; x=1707223736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCqWcvsch8PGprpl/SRJm/nQoksVNS4csoU4RAlMWDk=;
        b=OHJjwBYUA9qR7dWkbST21ZSjePzWyqhJFsxfccUVy7q2Z1tjjQudkpXogdx7nhPg55
         HwU83tJIaw6FqTCXB1M0bBzzsU6AaxSwz08koV073Vib7oyHKc3BrLpvWxVnnD0RZksy
         o1izD0KV1tKG1xuyjK2GFe4KD8t8DLEE2zpX2qGK9iy86Kju9nb9GmmWQcMzBtq02t70
         GUUCV+AgqG2g/DX10wpPaGfxWc/nFokH6v5pG10Y3bQfULpApRyP7SgJvuMVGt5wiBtY
         B1t1pl7JEHvcCIB9Czvr0r3PPCwLVOl8vAavyexPuROwDuGXyipurc4+ghjnmwC4QwH8
         EcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618936; x=1707223736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCqWcvsch8PGprpl/SRJm/nQoksVNS4csoU4RAlMWDk=;
        b=cAtzoT2S3wx2NiNYm91qMMELtgmeraElmZqYFsoxQWDUoXsTfkiL+ynerpb78Cl7cb
         XZfTsjn4GihyiQ6wMG8hrUIrgve53LTCfa2r2Qah41ibnHb9Kl564kJ96rmFIiOy8nGN
         xQTLuBGdpb1bu83bIjJkhAXYgx5tXZ9QAeOT3yN2WxcdAsAa2vMsjCJjI4wmp4geE9rF
         ZHDwF00NT0ODe36XzVN7TPn6sld27ksss+G39iYm/vLKI+yD2xGG4csXV/raZKOmJNki
         YG+eyONODyluMqvn1oDimrDZ3OIAHz34aaDO/3YXn8xUtUpTUEKMBEF1X2EvW+zZZFSh
         an8A==
X-Gm-Message-State: AOJu0YyFemzUZplSC+JthhbhianI0g5vCYJIEMXqkYzHfzm2FXlu7irf
	8Dy3Kv3WTUVxBFoQkHi0DQ0Zvp4kHqPFmnHgJvf36DEewH9K06Ow29TWMSyVttQ=
X-Google-Smtp-Source: AGHT+IFbohwdJbNKZ3tDtnEAeXSLNIGKE4qgI4wOPcEjk3GtJoUXRj33dhBmaWCl38TD6nxylGR+5g==
X-Received: by 2002:a05:6000:1ac8:b0:336:6377:6e3d with SMTP id i8-20020a0560001ac800b0033663776e3dmr4450457wry.66.1706618935836;
        Tue, 30 Jan 2024 04:48:55 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:abc8:f77e:abeb:129c])
        by smtp.gmail.com with ESMTPSA id en8-20020a056000420800b0033940016d6esm6625337wrb.93.2024.01.30.04.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:48:55 -0800 (PST)
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
Subject: [PATCH 18/22] gpio: add the can_sleep flag to struct gpio_device
Date: Tue, 30 Jan 2024 13:48:24 +0100
Message-Id: <20240130124828.14678-19-brgl@bgdev.pl>
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

Duplicating the can_sleep value in GPIO device will allow us to not
needlessly dereference the chip pointer in several places and reduce the
number of SRCU read-only critical sections.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 11 ++++++-----
 drivers/gpio/gpiolib.h |  3 +++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e6b9f1c82a7d..9548c9e53197 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -893,6 +893,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	}
 
 	gdev->ngpio = gc->ngpio;
+	gdev->can_sleep = gc->can_sleep;
 
 	scoped_guard(mutex, &gpio_devices_lock) {
 		/*
@@ -3063,7 +3064,7 @@ int gpiod_get_raw_value(const struct gpio_desc *desc)
 {
 	VALIDATE_DESC(desc);
 	/* Should be using gpiod_get_raw_value_cansleep() */
-	WARN_ON(desc->gdev->chip->can_sleep);
+	WARN_ON(desc->gdev->can_sleep);
 	return gpiod_get_raw_value_commit(desc);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_raw_value);
@@ -3084,7 +3085,7 @@ int gpiod_get_value(const struct gpio_desc *desc)
 
 	VALIDATE_DESC(desc);
 	/* Should be using gpiod_get_value_cansleep() */
-	WARN_ON(desc->gdev->chip->can_sleep);
+	WARN_ON(desc->gdev->can_sleep);
 
 	value = gpiod_get_raw_value_commit(desc);
 	if (value < 0)
@@ -3357,7 +3358,7 @@ void gpiod_set_raw_value(struct gpio_desc *desc, int value)
 {
 	VALIDATE_DESC_VOID(desc);
 	/* Should be using gpiod_set_raw_value_cansleep() */
-	WARN_ON(desc->gdev->chip->can_sleep);
+	WARN_ON(desc->gdev->can_sleep);
 	gpiod_set_raw_value_commit(desc, value);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_raw_value);
@@ -3398,7 +3399,7 @@ void gpiod_set_value(struct gpio_desc *desc, int value)
 {
 	VALIDATE_DESC_VOID(desc);
 	/* Should be using gpiod_set_value_cansleep() */
-	WARN_ON(desc->gdev->chip->can_sleep);
+	WARN_ON(desc->gdev->can_sleep);
 	gpiod_set_value_nocheck(desc, value);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_value);
@@ -3462,7 +3463,7 @@ EXPORT_SYMBOL_GPL(gpiod_set_array_value);
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


