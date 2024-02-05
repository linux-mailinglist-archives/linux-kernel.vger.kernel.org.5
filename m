Return-Path: <linux-kernel+bounces-52326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D5C8496BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090991C252C8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE1A1BC27;
	Mon,  5 Feb 2024 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Nuao0lpK"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC901B80C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125689; cv=none; b=nngdVD3dKMLSppMsrRt/jnH/eJcKOPd/1+W8mwEhur5nVq5PWDRH8FrlAdP5wHH0wx6ZC0PTvQqpRkkGeLfRU13l2WFgsNnLkVaHC/PCqZzDk4wuMnV5IaLp9eRmyozLynKTsvIC47S3kFflI+jtuHnPGf+IRMuz6eszwA5Plfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125689; c=relaxed/simple;
	bh=sR04Q3usSUpqWJ46O/KNDsk7BbO6EIW7XnGPi8eaia8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uH5Tx72b59nFBaDlQEh2G2ZrGeveeNZ4ka8qAd/sPCwx8Ki3Zk7xApG4zvJSkTkQkqWfFOwIj1u2OYS/Dq/17TYbdm9pRfU/1dRAo8sMjcfLD8nbDHd7B+5KJC2OwFtZNL511/75354FToDBJgB/EEJTydMMScFSGsRSBwuMAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Nuao0lpK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fdd65a9bdso2706355e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707125685; x=1707730485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANtgl/tgq51oFHA95121eXS9npOxkHEx1ig3f0DQeJE=;
        b=Nuao0lpKZ1fMSAACPr4RNvbfevd32J4SGwdIRwBJvZErfMuINYZUm3KMud7VMxjZ9M
         IvhP8ORh6liEzvp5+PBSVsWvpXDyiaxQW/oSvjTvHHdzAMBa2TPVjQsuBeWgA9XvjsCg
         +3zYnlU685GCEZX40vRr+ls58jPM1tKT17t+HmmBwrupK5VsU87ozN+51Xh2+3IRL2Rm
         PEbC0WRvdRKt3f31TOo5AfYkb/WzzXFZ8wLcL5ho3m6uIfqkHHtsAfE7VA+y9R38EPei
         h1ZZP2CmifOx+W8RvL5dVmrO15eDF0KS1irQQiZTIF5HIqeScwFlC2IDXXhNFgiWuFKR
         iX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125685; x=1707730485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANtgl/tgq51oFHA95121eXS9npOxkHEx1ig3f0DQeJE=;
        b=VT0KNJeb2DNn2Wl5yTlr+4kOBl2+Bw+y4S/QRMbNud4NDCzeB4dFBGBIn4Le7f5Kv+
         uYUKCPVrhEbUkS6pn45CsH+fPrjXIyIlTl5bYOGKbBu2BibWV6CpzHV6lqiWdaN2kqS+
         pA8/3vtNhk55DBDSK+1ETuy/eaPwhs4s8k1zgZ12yXvpgnXXR9ebsa3J5jPgBTcpVJJa
         lSPuuvHBx5Vd/UR9WvTAT0Tenfuq6HyXQWnmop82h5UEXIENca0eK3ibbizU21C1eIlW
         BnsdYqBHiUrZjoejlvCoGl1t80NlQM/cSyBizOaHBUMC4GbFU01XPZvr8ppsZG8yXg3D
         2Ixg==
X-Gm-Message-State: AOJu0YxEOo0gXOeqSbdMCTBoRCVYINTV40llwK/OoctZDLg9EuQP7ocQ
	L4WJMGXuTk32bkbcNbC8YBQGQgF1vcVYMM8s6dEJ3Dp1ECVuUVt4aY0+cA656Pk=
X-Google-Smtp-Source: AGHT+IEiAxBCDuSUfwYhDsmshalgLzlt7c17tLCl/VIHHdboWKtYEayQQdKgXmml+m/08rFU6F7suA==
X-Received: by 2002:a05:600c:1d91:b0:40e:d425:85a with SMTP id p17-20020a05600c1d9100b0040ed425085amr4337540wms.17.1707125685449;
        Mon, 05 Feb 2024 01:34:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWCM1Y10GDWu31dId5ePrOKe9J3PDr0CUXAPIdd0EMoxggyYXZqtAeqpe8kczKAT1O7ZLJQ2/+nD5DNdEz0SMPvQaV+kr71Xyz/B5a6jEVPwSSpwN8TL2cBy17ayRp2ZSBsWdZGzgVsB/y9LHPSWgNqJewKOlaF1DIzeGCkTLwp2qQeMMOq8XhRj+XesAHax3BPVnb8KcWriACDGekYKcJWmhTaoIH3RKVIzF9flWTM8LJZMcvedkMlXeP7Q7A6RDKdBHVdeId08IbGNOr7uyJ4IzL46khiZsExPc8WpydB8ouM2rBXBYXoTWlziJhLwnncN1x8fn39kIVrfzD+w0gms7pRw+CLEQ==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d929:10db:5b5c:b49d])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c154f00b0040fc771c864sm7980397wmg.14.2024.02.05.01.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:34:45 -0800 (PST)
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
Subject: [PATCH v2 22/23] gpio: remove the RW semaphore from the GPIO device
Date: Mon,  5 Feb 2024 10:34:17 +0100
Message-Id: <20240205093418.39755-23-brgl@bgdev.pl>
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

With all accesses to gdev->chip being protected with SRCU, we can now
remove the RW-semaphore specific to the character device which
fullfilled the same role up to this point.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 1 -
 drivers/gpio/gpiolib.c      | 4 ----
 drivers/gpio/gpiolib.h      | 5 -----
 3 files changed, 10 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index ccdeed013f6b..9323b357df43 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -24,7 +24,6 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/poll.h>
 #include <linux/rbtree.h>
-#include <linux/rwsem.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/timekeeping.h>
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 89e1c98b0bda..c7b039398e0d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -958,7 +958,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
-	init_rwsem(&gdev->sem);
 
 	ret = init_srcu_struct(&gdev->srcu);
 	if (ret)
@@ -1097,8 +1096,6 @@ void gpiochip_remove(struct gpio_chip *gc)
 	struct gpio_device *gdev = gc->gpiodev;
 	unsigned int i;
 
-	down_write(&gdev->sem);
-
 	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
 	gpiochip_sysfs_unregister(gdev);
 	gpiochip_free_hogs(gc);
@@ -1136,7 +1133,6 @@ void gpiochip_remove(struct gpio_chip *gc)
 	 * gone.
 	 */
 	gcdev_unregister(gdev);
-	up_write(&gdev->sem);
 	gpio_device_put(gdev);
 }
 EXPORT_SYMBOL_GPL(gpiochip_remove);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index b3810f7d286a..07443d26cbca 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -16,7 +16,6 @@
 #include <linux/gpio/driver.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
-#include <linux/rwsem.h>
 #include <linux/srcu.h>
 
 #define GPIOCHIP_NAME	"gpiochip"
@@ -46,9 +45,6 @@
  *                       requested, released or reconfigured
  * @device_notifier: used to notify character device wait queues about the GPIO
  *                   device being unregistered
- * @sem: protects the structure from a NULL-pointer dereference of @chip by
- *       user-space operations when the device gets unregistered during
- *       a hot-unplug event
  * @srcu: protects the pointer to the underlying GPIO chip
  * @pin_ranges: range of pins served by the GPIO driver
  *
@@ -73,7 +69,6 @@ struct gpio_device {
 	struct list_head        list;
 	struct blocking_notifier_head line_state_notifier;
 	struct blocking_notifier_head device_notifier;
-	struct rw_semaphore	sem;
 	struct srcu_struct	srcu;
 
 #ifdef CONFIG_PINCTRL
-- 
2.40.1


