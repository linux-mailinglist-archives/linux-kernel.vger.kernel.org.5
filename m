Return-Path: <linux-kernel+bounces-68603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F96E857D05
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E917028651F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32F91292DA;
	Fri, 16 Feb 2024 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMybALGW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A5B128825;
	Fri, 16 Feb 2024 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088406; cv=none; b=nti9srGrutdir8DnS78cH+Fm3aYTAe/RxJx0E2iLDh/n4Q9zt3IMBuvUqalm0EslaqI0HVgTK4pSdv1qoHwZXkR2uGSPFzx4YRW9hEug5XufP/Dj9IAQos7sk5t7s2UZnLqFliUv+Tp7/57rE4hQeela1dunOcBg7K+GCIwFhRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088406; c=relaxed/simple;
	bh=Fua+75fYl25KxH7zo3jRCWk4YuWrcZJH5ZiE41IuRQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H5otpB7D1QWo65S0DPyofP0h9cnn3Vs45gHHP/ACHG5e3NvjZQ+hUs9zMtyggWIY+o6GjNaOGZlBIfQGLM1yYqx/MnHRcmkrkMtOUifFI++1xBQJV4GtRXbnWtvX8E176CeEUmUou4sMvQG+QcRsqTVgf3bqJ7ZKv9FMx650Af8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMybALGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA108C433F1;
	Fri, 16 Feb 2024 13:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708088405;
	bh=Fua+75fYl25KxH7zo3jRCWk4YuWrcZJH5ZiE41IuRQo=;
	h=From:To:Cc:Subject:Date:From;
	b=gMybALGWtGK83QV3RuisQujmIX6Z4uGLabFhmq/aPfU55noI54gh4xVKrs7LKpqYd
	 aOexQACIOuVuHmktqpnUMhdZ/qO1Gzk9Fxm//zDVee/4CWAl/X1NSy4/HF0FGLFETi
	 dxe3r+SKrQt0jGDtAmf3ItVUr2S8/g5s4Avv1U4MUZnKM6oUeHtqY/PRYH6FfCiLhD
	 PLp++c+NQSzMVXU4aKlfJegtGhXGnrJOBF0SFvNW5HkP3eMzGiBqg7FjF+jfOc0Cer
	 QbgNgThIZ/XwpmiG0P+bq+aMyybYRI9dKWz5m7H7BbQSHsRM9QYPReMjOyeha1n/f6
	 JXzbMGIybuwjg==
From: Arnd Bergmann <arnd@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kent Gibson <warthog618@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: cdev: avoid uninitialized variable dereference
Date: Fri, 16 Feb 2024 13:59:50 +0100
Message-Id: <20240216125959.3766309-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The 'gc' variable is never set before it gets printed:

drivers/gpio/gpiolib-cdev.c:2802:11: error: variable 'gc' is uninitialized when used here [-Werror,-Wuninitialized]
 2802 |         chip_dbg(gc, "added GPIO chardev (%d:%d)\n", MAJOR(devt), gdev->id);
      |                  ^~
drivers/gpio/gpiolib.h:277:11: note: expanded from macro 'chip_dbg'
  277 |         dev_dbg(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
      |                  ^~

Use dev_dbg() directly.

Fixes: 8574b5b47610 ("gpio: cdev: use correct pointer accessors with SRCU")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpiolib-cdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 85037fa4925e..d6e8d2b7ac8f 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2783,7 +2783,6 @@ static const struct file_operations gpio_fileops = {
 
 int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
 {
-	struct gpio_chip *gc;
 	int ret;
 
 	cdev_init(&gdev->chrdev, &gpio_fileops);
@@ -2799,7 +2798,7 @@ int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
 	if (!rcu_access_pointer(gdev->chip))
 		return -ENODEV;
 
-	chip_dbg(gc, "added GPIO chardev (%d:%d)\n", MAJOR(devt), gdev->id);
+	dev_dbg(&gdev->dev, "added GPIO chardev (%d:%d)\n", MAJOR(devt), gdev->id);
 
 	return 0;
 }
-- 
2.39.2


