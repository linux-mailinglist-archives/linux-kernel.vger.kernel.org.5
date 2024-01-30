Return-Path: <linux-kernel+bounces-44649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C815842574
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F87E1C27DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0AD12A166;
	Tue, 30 Jan 2024 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DUZqnO4K"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5998F1292F8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618943; cv=none; b=SbfCsmqK3yOgAfHYUKTpcEPV2QuyhRgoica3IdR5exCo2JEMO4n+XwFUtcng6M4D0ODbZIb8T0Ti2n7kGtMM7G8NlzLX9NCEYVvZGUv+9AB6aQLhvWCWbOYxHMZvTR86sT9TruWmYvin2bG9XZqicgusjX9kjFghgelwsFWHa7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618943; c=relaxed/simple;
	bh=p9qFxfRDRuKahCeEITtAp/nZTu9vev5Cmk1NVuQ7PFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DYMrMIMUoevIFlVEoCczaEmBu3WGmnYDINbA67P+/seLeIdpxuOxvo32ZLk70g0xISSV7s0n8w1qkomCBQs+7grJXb80xIBybYGV4gbjJB/VjDQxR0JLMV893QTcAV8dlcDcZy3ZFzmOBpMuYX+SdEh1qUkyOZpT8zwN5sYvy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DUZqnO4K; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33ae7ae1c32so1714657f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706618940; x=1707223740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mlp9NoRNWG5wkw0gnE37vvJcfWnX6lVcfqfuQVzAw4=;
        b=DUZqnO4KCNJgb4pBBA8CSjJuCPOyuE5s5ZjBXIF8c9XkSAI+3UYiRx+9uW8F4jNf6v
         6SwOc8D2sxT4Gd6tYe6aahVcH7qt0vNZwdHZX+hdwJG/BLPX4yAzLSyKmwhhSmX+oSve
         KWD1TDGzEJCcu1Zg64tiytwBXoVOCF6w0QonbyBkiTKOmEW3CQJT0wxIIwBhKNwoy4yb
         TsjFmBn5rch2ha6S9FDlspKMx+OP80LQ98PIYMQvtNeKK3ug4Wb+/eGPeGWcrhwCgwzk
         nIGNMMXUTk0ML20ZXWlqpvLpJyTPitbof+A7sfSHijHFF3J41o/B12Pu1ETEPz8uG+0a
         ozJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618940; x=1707223740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mlp9NoRNWG5wkw0gnE37vvJcfWnX6lVcfqfuQVzAw4=;
        b=OTAu1SHi1iN4ketxIMwFX7yxh5sbbuDlmO3brHyWbi1UdBFFF2ZLm6LKjgODNXi3WG
         T8JUZAF7fwpzxcXblZ5OiKgSY+mtS9jLWBcItUMJM4uMkOVriC7K3w1AfUnfuWftMy5J
         BPI7aDaiWSyiVIrNQQrsHWp5UWAPqnhmH5N2wkFrNlp1KvCrT80a8LVR8bsWYpJeIPe8
         4DlSoqShPE0JcmpckKa/ie+m1VCjY5wqyAuHAdAAqc2P2OTxg5ecOUraMFx6uExsXlS0
         2AGppewhWlwMB3z477YPVtl1I64Eb0P3/FMmasWDdjqvA2DuQzQlu/qWpZ66uIcTZhCm
         0shw==
X-Gm-Message-State: AOJu0YwozoGq4NOfJpTXXOTo83T2+58ai3kpVnGqU7sp80nubPPaOSqm
	zEp0euP2Y/ioQmDgwNLIfLz21uihhiUUMAIsSuB5kHkZWn+uD2HuDq/ll3iNXHo=
X-Google-Smtp-Source: AGHT+IGDWA2iBJpdCn+igJe5tAk5amog3d34nSIBkescrm60Rf5It6dm8S+wfa5Hoowj22tI2nU+Ng==
X-Received: by 2002:a5d:588b:0:b0:33a:f4d6:613 with SMTP id n11-20020a5d588b000000b0033af4d60613mr3528661wrf.69.1706618939847;
        Tue, 30 Jan 2024 04:48:59 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:abc8:f77e:abeb:129c])
        by smtp.gmail.com with ESMTPSA id en8-20020a056000420800b0033940016d6esm6625337wrb.93.2024.01.30.04.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:48:59 -0800 (PST)
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
Subject: [PATCH 22/22] gpio: mark unsafe gpio_chip manipulators as deprecated
Date: Tue, 30 Jan 2024 13:48:28 +0100
Message-Id: <20240130124828.14678-23-brgl@bgdev.pl>
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

We still have some functions that return the address of the GPIO chip
associated with the GPIO device. This is dangerous and the users should
find a better solution. Let's add appropriate comments to the kernel
docs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5741bbfdc178..7ecdd8cc39c5 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -211,6 +211,11 @@ EXPORT_SYMBOL_GPL(desc_to_gpio);
 /**
  * gpiod_to_chip - Return the GPIO chip to which a GPIO descriptor belongs
  * @desc:	descriptor to return the chip of
+ *
+ * *DEPRECATED*
+ * This function is unsafe and should not be used. Using the chip address
+ * without taking the SRCU read lock may result in dereferencing a dangling
+ * pointer.
  */
 struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
 {
@@ -275,6 +280,7 @@ EXPORT_SYMBOL(gpio_device_get_label);
  * Returns:
  * Address of the GPIO chip backing this device.
  *
+ * *DEPRECATED*
  * Until we can get rid of all non-driver users of struct gpio_chip, we must
  * provide a way of retrieving the pointer to it from struct gpio_device. This
  * is *NOT* safe as the GPIO API is considered to be hot-unpluggable and the
-- 
2.40.1


