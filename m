Return-Path: <linux-kernel+bounces-57802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0EC84DD97
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4631F29663
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9744762EF;
	Thu,  8 Feb 2024 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pXldQt3l"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5286F50E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386384; cv=none; b=ix0AI+rvh+I4R3MSOo4ynmIyXPgd8Ut5FHZLvHv5ryhb3p7cIqZ8heVhEdVLrMTVCroDrNJMfkoez93nDdnEwzjDJZmOgbBQdSUSQ+dxw606FtjAJ43hC/lwPAx1pMfhEa1BRE3LgQmx2WZy+UlMtY7dl+Y3SPkmhtbQDxb9D4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386384; c=relaxed/simple;
	bh=FDZO/TwcbnTddQUhjEAdRe7rViCju9Ibv+2BryqiENw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f9VH+6C4b0LlK4/FT0RSj0fWSVZc9g4TPcuUt3SM4CREV+D4fV61DeoFQtLCG8+82DmCKXTxwDToIjmMAPK1ETYurxr6NfkNI+i0RcucdKnQBWFKF0Z4gmVbwLc0A524VVnBmYuEne5+6zhtGGkiS7d47IUnYCD/q9pKo4IRR4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pXldQt3l; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4101eb5a115so11525765e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386379; x=1707991179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dheTVBTayhCasfErTOxCrk5zmfbFuKKC4sgrDD6oeo=;
        b=pXldQt3l/WQBEm9FqzrI8g2cRltG0MVB0AC+8Y2D/sfA1GAeigRcgin//oN5MAk0dX
         dujG7hFgnLJBrBY4Wjj0e5YAaME3EsCOvrhOAYMPgubaAa+c2m0XKf6jU9gOb0pCjTTx
         2pVvgFg0Z6KjeGzHMOpxf0DnSvhsPhVYb//jEYVQ8QN4cV5hPGPLPQsbMlsPni2JG2vU
         1KN5vDNplwVuPlUIvAAlT38vYBVL4QrzCJ538vK9JDzmx/svzS6a/oDDLt8kVRkXO3fR
         7u9SUIg15sgftvCJ6Mt39Yr5d9R6qtyn/jsoHT9RvQh0EIcusWx1EGLuT2QERd6RBfvL
         ODDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386379; x=1707991179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dheTVBTayhCasfErTOxCrk5zmfbFuKKC4sgrDD6oeo=;
        b=wytVOwl17BbLvQ7rXRhcukrYKFAUzaHY5Cay0g4b4tiu3LBQTYcYNT0D1D9XthP3qG
         Qn+R5ZQfZc8FODZXCDFv3mzmqXIi/qYgXOJ7oUOXPOMpL44fMZccbEeRha4izVliEhCr
         IE2w03ABr8qMC2zAMtGMXpq+UPa+IYbg65B+LxieHFk4PUBzuzk3SyHNlTk63Cdxei+k
         1/9a9jQ64VgGIg5gSBJn/fqVIoO4Ff8XKp29WUYUEZlJeNdaPtJXSmiC+PN+w19Xfcm0
         LHklW6v9/lNlsNqF0J7vZAiwBw5mflI5DmDP+WH+wrSSQiuer0g3bywFQxiEJ6M2bCfS
         hjKg==
X-Gm-Message-State: AOJu0YwypwacIZfKXbPykcWbTgj+1cbskWY3lW43YEMoGp8mibCCoXpC
	zahveUsW5oC2PJK7G4ywgblBNVAsMrBGuOfeMIqTEVgps/904c5WZK+2da+bU34=
X-Google-Smtp-Source: AGHT+IGvoCSeda2oqxGXWAWNFHn1kUFghSZ+a6X+tj167X2MWxY3zkdNsEwytkWknRL1v5hB13UjdA==
X-Received: by 2002:a05:600c:580d:b0:40f:afd6:b266 with SMTP id jz13-20020a05600c580d00b0040fafd6b266mr6430692wmb.18.1707386379227;
        Thu, 08 Feb 2024 01:59:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXL5JPiAeZBUWUmjrQSoN1J7Ibl/MgYT7es1Lw5yZbX00z6XzS8ZdUh+8EgpuvfB2szke9h9jC06tqCMiLYheC0EOXDSMgRCpJR/TJ3XbcBlBgtIGyzIv0tlz4PLSVsP3Pyy0cXz6FvKGchuDIykfVVtE98nfV1aDCpfn6raaTpnDcB/f2lwNiW39qIj59mLzXkNr0tW/DZ0ajVX9fG5Iz5eL7AO3o97rmEtYZSTaTCf8vEurKqloCMFE5VneMkQogmeNx3p0itvtRTSWKeQ8uA86YRS1+b8SZYqqJpuzDnX6gyMOafSsyhi3tPF7CisK/peJikdddMm4BjbTWtILU4RDX32kmPiQ==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:38 -0800 (PST)
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
Subject: [PATCH v3 13/24] gpio: sysfs: pass the GPIO device - not chip - to sysfs callbacks
Date: Thu,  8 Feb 2024 10:59:09 +0100
Message-Id: <20240208095920.8035-14-brgl@bgdev.pl>
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

We're working towards protecting the chip pointer in struct gpio_device
with SRCU. In order to use it in sysfs callbacks we must pass the pointer
to the GPIO device that wraps the chip instead of the address of the
chip itself as the user data.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index fce4ef9754af..b46d50ac2452 100644
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


