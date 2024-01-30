Return-Path: <linux-kernel+bounces-44640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31EB842564
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6E828E7A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEB2823D5;
	Tue, 30 Jan 2024 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EouG3aw6"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB97C0AA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618934; cv=none; b=QWGSNm1ON1T7bWVJRY11MbNnjgZj04wWyDiclE3zQFNlixqSzPZKSdXYD7EBMVejs6xWz/zljEiyqYbxgaZPGC39E18k84tYDC3wCUE1708IEgaQLrWVO1WXXSgqhRWOu7jHbjyMfjOTyYfp44/TgfMSndHtSKFIIA89UhNgCNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618934; c=relaxed/simple;
	bh=BlasmXWk2cKYg0vYntEQWSleO/ytA4RrXZqAoO9ZuG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V1aFTYyEcS9H1S48jDXPan37Be8DtC3PcPyzjA+NpHDKI8Mja02TKChm793SFuKVGyWCXp4PAZsX46W6zJuRXVL7h5wr//dPPsVcDYJpaBAGsu/+UzmJdqSBBXj2zbl9A0qJ5P7f2eT+Z+A9i/gb26cn47n60lxeWGYd3jxtARs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EouG3aw6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ae3be1c37so1555102f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706618931; x=1707223731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCxDOAXuOOg2T1Tf8oCKLsKFNS/3bOHdr9NifUE/KQs=;
        b=EouG3aw6sYAqU5wtKpHTgANYPotLDMhNgY+IDmeGzRb2wlYU+6/whicse39Wyv7C8c
         BMSzyTYUJZnn7macCbfVpH29MPmpdc/kCxMs5gQHjvISgSItD8lJAvgU6MxWe3sU+wRK
         O4xaUqpENmwMlm19NP+cOmQvfGSTP6qWINSKO10sRrYltQ5YXtdjijSDT9OvTQA8j8yM
         ui+8FhwG+LjMFtYMx/YLxHLOaOyWZEsgA4/BaNFzlIcrdj62XYhgNUvgteAauNZgd8P2
         nKjp+ejDGVkALD/bYGBgXvIEEjiCIQxSnvjO1jmJyZfW3AuF+wZyWOUTgQdQ1nvcJHiF
         c3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618931; x=1707223731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCxDOAXuOOg2T1Tf8oCKLsKFNS/3bOHdr9NifUE/KQs=;
        b=AqZORnIYaxJsBQeK/nkP0Lp1zlwhEm5wTAAeLEU7bN9qo/qTdEdOyTtoCDTPOJWp7d
         4tY7NgCiPBtenWFAZc7uZESxYS1F0gFCzbvq/Giy1Tc8krRPJ301f10oH+2ioVqhLPWM
         KvR7UdNj9+NUrF4Q+ZjUAizxIn6ubDkupveiw1dEkP3irToWyiRZqgj6dXBiVP326AHr
         Pa7ChMNzW2fpaGOfIzsXz+p36HchbFET2iQb0ECB0LJKiIRbQCtHi7PCCbzdWcsUGpJr
         sCSkhWdx5KUbrd0fdVKmHCJF7Nqe8YF9bB9S+aSVK30mnnfLZD4sAZJq2qf4RGZ5rXFU
         3Pbw==
X-Gm-Message-State: AOJu0YyHU7vTi4S9scWxd1aUa2k9E+b8mwmoGSTQTzBmxbj0A/OJ7KfV
	eoTBeWsj4MU2IRr1RRLAfj4lKP1q4T3ZNIRGS7fDVCewA30m9g5T50aNWLg7Uks=
X-Google-Smtp-Source: AGHT+IGp8JPx4damkt0XgQtbknUdfKbHv0TDVvzIuWWhrZpk7IFyABqdnHQu6LKOZDDfCbMGbUU3Gw==
X-Received: by 2002:a5d:55ce:0:b0:33a:e3ac:60d4 with SMTP id i14-20020a5d55ce000000b0033ae3ac60d4mr1295411wrw.15.1706618931370;
        Tue, 30 Jan 2024 04:48:51 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:abc8:f77e:abeb:129c])
        by smtp.gmail.com with ESMTPSA id en8-20020a056000420800b0033940016d6esm6625337wrb.93.2024.01.30.04.48.50
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
Subject: [PATCH 13/22] gpio: sysfs: pass the GPIO device - not chip - to sysfs callbacks
Date: Tue, 30 Jan 2024 13:48:19 +0100
Message-Id: <20240130124828.14678-14-brgl@bgdev.pl>
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

We're working towards protecting the chip pointer in struct gpio_device
with SRCU. In order to use it in sysfs callbacks we must pass the pointer
to the GPIO device that wraps the chip instead of the address of the
chip itself as the user data.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 5da316ea9cc7..654a5bc53047 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -401,27 +401,27 @@ static const struct attribute_group *gpio_groups[] = {
 static ssize_t base_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	const struct gpio_chip *chip = dev_get_drvdata(dev);
+	const struct gpio_device *gdev = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "%d\n", chip->base);
+	return sysfs_emit(buf, "%d\n", gdev->chip->base);
 }
 static DEVICE_ATTR_RO(base);
 
 static ssize_t label_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	const struct gpio_chip *chip = dev_get_drvdata(dev);
+	const struct gpio_device *gdev = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "%s\n", chip->label ?: "");
+	return sysfs_emit(buf, "%s\n", gdev->chip->label ?: "");
 }
 static DEVICE_ATTR_RO(label);
 
 static ssize_t ngpio_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	const struct gpio_chip *chip = dev_get_drvdata(dev);
+	const struct gpio_device *gdev = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "%u\n", chip->ngpio);
+	return sysfs_emit(buf, "%u\n", gdev->chip->ngpio);
 }
 static DEVICE_ATTR_RO(ngpio);
 
@@ -751,7 +751,7 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
 		parent = &gdev->dev;
 
 	/* use chip->base for the ID; it's already known to be unique */
-	dev = device_create_with_groups(&gpio_class, parent, MKDEV(0, 0), chip,
+	dev = device_create_with_groups(&gpio_class, parent, MKDEV(0, 0), gdev,
 					gpiochip_groups, GPIOCHIP_NAME "%d",
 					chip->base);
 	if (IS_ERR(dev))
-- 
2.40.1


