Return-Path: <linux-kernel+bounces-63201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4AD852C43
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8BEB28698C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654BB22F19;
	Tue, 13 Feb 2024 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ycJ7JVO2"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739A42232D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816678; cv=none; b=S2AuEScCrA02CUT8FaB6NA3tkqNX6ZBNycYIUQz9E1pyPKUYPXy17mSCGXnFvWQQFvtgXXSkWnPrc88skhlM1HItoK0XSfh1WNlSN2WXUAoSnLeR/ek38PkJ9HKqaBOb0fS6+OTMeRTX/IR86+6TstKWFztbP6Y7Ma7PCTjBrvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816678; c=relaxed/simple;
	bh=uiPH+suZkaL06kXCeEFh77vFLZuPv8neSgnWiG0ld20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WW9ruLRmLwXoThdCnwDpMGbfMPwufII3rqYuPyQVC593KOeWU4ZXTQV3mAl4DSSLiUJvW0r5cA4O0aZJV06Sz+eAfwx4Y5gY8Q8YoZrb6syBlxn7C7GWLsvLjExOb0IMiLbG1P1TrbVH0M/aaXP2HidIv8RpNUfP8CD1/9goWzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ycJ7JVO2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-410c1ebf5e4so17016145e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 01:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707816673; x=1708421473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9rnJQl4J3fWPBLaleaIS+OzS1vPICPuUXU9m4u+NCg=;
        b=ycJ7JVO2Ht3c3WExKwBqvFBcLpZgT1JF3ZB02HyQa+k4R4isYUSgIMdqe8wa1ZRnDS
         H/UtAFKrqjLcxEnEkF4mAYT3VHmuSVwCICLveZ/Jy60AJFB1R2xDoEpQNt/YJi1Ib5bT
         KOplhIiWRtYt6vlWF7TdeHTjmAkY4uOqi4IsHvjSGCOb4Fwr9KgpiA+4BIYER4TlsSz4
         m+5zjUZaIBQZAUbFmpyeM+cbxaBtvv6H+PkDqiBh8/cKUO0SN0cyhimjKV+Nyknn8T99
         MYJo/PkDOtpkGff8lfHYRhfdGa1DeB2sWyG89ax2DsLJ8SQ2ATTHuP5omF/VfLsamLhE
         MuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707816673; x=1708421473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9rnJQl4J3fWPBLaleaIS+OzS1vPICPuUXU9m4u+NCg=;
        b=xE+JaHxy/6KmQIT2Z6glvFVIJn3sGIKGslaoQUbczrf44vzMRJs9763qiGClpq5Amo
         +LqwbOQvncrxew7VoPHEObD0SBaO8NPUR91xeq7FVmfXx1bjQuNO3uLkAdEjf+KgK1ai
         exOU19ShyzU1libPXLuwET4+kI0VxJILGq1+PTPZDCDHUuXlMCblg/cYvxC8C4w7qmfn
         BJLRZRRXYR8GFKBnUkw2k1DOP/YeCh4lktmnim6Q3Z2SRtJwpQLqjVKQjzP5FbbV+7uL
         2LjOmulvGbwfRe/0yPZdCU8CLmboACFkojG2n7n/8faxs96WE0NAE1Th+6mKr0dtyZB5
         8drA==
X-Forwarded-Encrypted: i=1; AJvYcCUFV/xjcAUP/5vKS80Lsqh0QMSLE/DrCWB7MqwqUJqwnTskkml4AIFVERbi5aJhlD7pChteUFrsjDUBi8gnmPErpi6cah6ke5/jOAW0
X-Gm-Message-State: AOJu0YwaUw4DDTVEYAkVziztdxZ9Fkz5B68J0f7ekSjOcimMCsk5E5df
	xSen2CyLAuVE9xmt2B2vsIk2WBqibHoOdXI6qtTnvPbHdshSr1LnIKct18MYaaA=
X-Google-Smtp-Source: AGHT+IHA8NduFh3S0lW3tT7CCz4qthUUvzFX/CHmspOBiF1yPKgUnBDscsjoDwIF9SDv6oCR4WUH5A==
X-Received: by 2002:adf:e605:0:b0:33c:d310:73cb with SMTP id p5-20020adfe605000000b0033cd31073cbmr1260297wrm.19.1707816673613;
        Tue, 13 Feb 2024 01:31:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCpzhdCyVsckx1DwQw+DQV3V0HJyofMCefoCgiQb7HwsBF6O+zIxb4U1RLfjD2YvfYXlQ0dQ2jcon/2CkK7mg6W2SEkeJKlIA3x/GLpEPJoE0UGPGcS69TncKIH73+GvG8mMPdsrtmdRBBt2/h4ZQaeu3sQ0mbUI2RJhzIymYrJr72dX3QRHaJV+JexU5my0a0LYSjUJB21OiGO26MsnRbkFDY2QnxJFgJgKtbVFRKLloC3BwIOQ5RZN+fGl24oVazKyLLMgnVANibhoscJ9YgUfDuNLS6DgxQmBEJXzEnaOWk0gleMpxIR+jOFt5UXPlN3BtIlG9A7q5UTzN01OZsfejXu0hTxvLvOjbAH1s=
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f634:2e37:58a9:242a])
        by smtp.gmail.com with ESMTPSA id p16-20020adfcc90000000b0033b2497fdaesm8980897wrj.95.2024.02.13.01.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:31:13 -0800 (PST)
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
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH 2/3] gpio: cdev: use correct pointer accessors with SRCU
Date: Tue, 13 Feb 2024 10:31:07 +0100
Message-Id: <20240213093108.13922-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240213093108.13922-1-brgl@bgdev.pl>
References: <20240213093108.13922-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We never dereference the chip pointer in character device code so we can
use the lighter rcu_access_pointer() helper. This also makes lockep
happier as it no longer complains about suspicious rcu_dereference()
usage.

Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202402122234.d85cca9b-lkp@intel.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 9323b357df43..85037fa4925e 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -206,7 +206,7 @@ static long linehandle_ioctl(struct file *file, unsigned int cmd,
 
 	guard(srcu)(&lh->gdev->srcu);
 
-	if (!rcu_dereference(lh->gdev->chip))
+	if (!rcu_access_pointer(lh->gdev->chip))
 		return -ENODEV;
 
 	switch (cmd) {
@@ -1521,7 +1521,7 @@ static long linereq_ioctl(struct file *file, unsigned int cmd,
 
 	guard(srcu)(&lr->gdev->srcu);
 
-	if (!rcu_dereference(lr->gdev->chip))
+	if (!rcu_access_pointer(lr->gdev->chip))
 		return -ENODEV;
 
 	switch (cmd) {
@@ -1552,7 +1552,7 @@ static __poll_t linereq_poll(struct file *file,
 
 	guard(srcu)(&lr->gdev->srcu);
 
-	if (!rcu_dereference(lr->gdev->chip))
+	if (!rcu_access_pointer(lr->gdev->chip))
 		return EPOLLHUP | EPOLLERR;
 
 	poll_wait(file, &lr->wait, wait);
@@ -1574,7 +1574,7 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
 
 	guard(srcu)(&lr->gdev->srcu);
 
-	if (!rcu_dereference(lr->gdev->chip))
+	if (!rcu_access_pointer(lr->gdev->chip))
 		return -ENODEV;
 
 	if (count < sizeof(le))
@@ -1875,7 +1875,7 @@ static __poll_t lineevent_poll(struct file *file,
 
 	guard(srcu)(&le->gdev->srcu);
 
-	if (!rcu_dereference(le->gdev->chip))
+	if (!rcu_access_pointer(le->gdev->chip))
 		return EPOLLHUP | EPOLLERR;
 
 	poll_wait(file, &le->wait, wait);
@@ -1913,7 +1913,7 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 
 	guard(srcu)(&le->gdev->srcu);
 
-	if (!rcu_dereference(le->gdev->chip))
+	if (!rcu_access_pointer(le->gdev->chip))
 		return -ENODEV;
 
 	/*
@@ -1996,7 +1996,7 @@ static long lineevent_ioctl(struct file *file, unsigned int cmd,
 
 	guard(srcu)(&le->gdev->srcu);
 
-	if (!rcu_dereference(le->gdev->chip))
+	if (!rcu_access_pointer(le->gdev->chip))
 		return -ENODEV;
 
 	/*
@@ -2510,7 +2510,7 @@ static long gpio_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	guard(srcu)(&gdev->srcu);
 
 	/* We fail any subsequent ioctl():s when the chip is gone */
-	if (!rcu_dereference(gdev->chip))
+	if (!rcu_access_pointer(gdev->chip))
 		return -ENODEV;
 
 	/* Fill in the struct and pass to userspace */
@@ -2595,7 +2595,7 @@ static __poll_t lineinfo_watch_poll(struct file *file,
 
 	guard(srcu)(&cdev->gdev->srcu);
 
-	if (!rcu_dereference(cdev->gdev->chip))
+	if (!rcu_access_pointer(cdev->gdev->chip))
 		return EPOLLHUP | EPOLLERR;
 
 	poll_wait(file, &cdev->wait, pollt);
@@ -2618,7 +2618,7 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 
 	guard(srcu)(&cdev->gdev->srcu);
 
-	if (!rcu_dereference(cdev->gdev->chip))
+	if (!rcu_access_pointer(cdev->gdev->chip))
 		return -ENODEV;
 
 #ifndef CONFIG_GPIO_CDEV_V1
@@ -2696,7 +2696,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	guard(srcu)(&gdev->srcu);
 
 	/* Fail on open if the backing gpiochip is gone */
-	if (!rcu_dereference(gdev->chip))
+	if (!rcu_access_pointer(gdev->chip))
 		return -ENODEV;
 
 	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
@@ -2796,8 +2796,7 @@ int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
 
 	guard(srcu)(&gdev->srcu);
 
-	gc = rcu_dereference(gdev->chip);
-	if (!gc)
+	if (!rcu_access_pointer(gdev->chip))
 		return -ENODEV;
 
 	chip_dbg(gc, "added GPIO chardev (%d:%d)\n", MAJOR(devt), gdev->id);
-- 
2.40.1


