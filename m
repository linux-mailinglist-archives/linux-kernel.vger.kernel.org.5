Return-Path: <linux-kernel+bounces-52312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A848496A0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674621C24378
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177141173A;
	Mon,  5 Feb 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RKjTqk2Z"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216314006
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125676; cv=none; b=oC6TrWk02fCf+9e7kGGzaN66AUBdQ4kToZ32U6dO91mLJtgz3HRzfHiD35mmMzCIl80WAEjsaJ47bl28HgJ4xmQ/qxroBR8IJwXWMiiO+xOv8zQ8Qrz7qUqEsPMHtMyqZeRfhJn/XMQ+xidpl+loAyA1qpCVqcp7smWkoAysvUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125676; c=relaxed/simple;
	bh=QndNeSWqDTX/zFjnwCo02F7D/CRpA6gYSyfRPlHOvEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qFwS8M4eeaecconQa/I3KP85znfXzS3wgXbXjHZYYKE5m0+e9dcUtv7PEs6pSZtlAPlHAE4TuTh9kQ4nZA34ZwFHHJdgdB6pBJMkvy8ZMIv+O2arvd7UUJFSFgQqTrWVVHUorSqiPFBoYgBJ5E4jifwyy6+IWHrIoUBoqLGUQbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RKjTqk2Z; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51147d0abd1so1370700e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707125673; x=1707730473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkfvkjtzEhDkQSOg4G+yVVF8O3dwJMh/iXMkfAAfTgY=;
        b=RKjTqk2ZylDq88zxeYhB89loVrt+e0Nihxz+aoTPRicgpNW/Nq/PAsowxtWAHfCAOL
         +3maT8cXr9s/COgOsAOn+n++p42AXHtfvk09WtU0CyVNvAS0TU8meeDfRp/4UGtmBkqw
         0r+96EsJWBBZPloV646QtKRk3F/Oyi0s0on8sdiakvWUW4WKg6dIz+YcoUVHcDp/y5Ci
         aqYy4vdhLiF4YqO+RsLKC7/sIqlb6wuEHtW1bGnxJ0/NNPLqUEe/CcHITbN7JGsaDtwB
         jKDT6SVU4lcy5ukyeqD7kUOYrLBAEEOVM7MsUAG31QPBlPCKzyv1pjSsNTUxNL4USNCE
         CHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125673; x=1707730473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkfvkjtzEhDkQSOg4G+yVVF8O3dwJMh/iXMkfAAfTgY=;
        b=RSE/BtpS0WbR3ljcA8JVfzkbMuMlmHizP2BQsvI13Ay11FYeh2NbIHM7bX75bkKw8j
         tdOgUGg9gthFF/yGGudpwYdgsk2Jb2pDKZ1J44HvlBcBkZv4ylOFrJRErY2ow5t48fIV
         KTCNkfhoadOdPvPZII6xv60GcYNALUqrKTpQDJezHGCIXQgFttBYGbdJNrFpZg6Ys6qh
         twTGA8qgcSZSuk7uYSBlHBzcFSYNXRyhu+uPxVt9/a6IzRLnIfoxdIetNyePvwBCh2+d
         y9NMrLfO048xHm35g6yrEc23rqh3UrxaCa6IUnfvglE1/N82mmt1YMLMrpj5vkgzQKKF
         lLjA==
X-Gm-Message-State: AOJu0Yy4CAhA8O0l4VyDgkFJ1Fofn24t4YCa68Mb16LqRt0IQOCr5m2F
	eImpWmQPfs7NtjNGnGhdin8TR52hN7ORDPxU44H3nUPcuWk2MUyygCjLQMYTTeY=
X-Google-Smtp-Source: AGHT+IEioOygbwzOiy8IYXaqffGjI1iQJ28ymii8IJ/QHZobuyxDN4NK6zExQjLK8wD8AOwGSbQsug==
X-Received: by 2002:a19:7008:0:b0:511:4f1c:ef43 with SMTP id h8-20020a197008000000b005114f1cef43mr1520317lfc.10.1707125672969;
        Mon, 05 Feb 2024 01:34:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXJv09UAJMwHDheEwlhQmtq785dpHyI9qQU6Sgt9oU0/XH58nkLzfK4Bg+uwolkHslsZJtdQtN4SCOXjNBH6ed0woHAAYAU+ld5fGgnmcxc2E1Bjgsl2aMg5IKMOmz2uhvVUwZblNOp9bfso8qZFr7LGF3fppU6zTPTdPxdcFj976hV2v4tkrSccdQNR9ej7kqvq0CnDQUVVExd0LCXkqGZwpwUPNLKTPhaQ0XW1yRn1+KvpQYICzjMU2F76H1/xZgg85QgN010/3S8yovMH2xqkHgaMlCyFTD/4ZPPYbeYAYnW/rDr6h2AWHrbDZcq9qiXA4B2dRCn4R8zmJtwkP0Dl8q6P4D77Q==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d929:10db:5b5c:b49d])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c154f00b0040fc771c864sm7980397wmg.14.2024.02.05.01.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:34:32 -0800 (PST)
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
Subject: [PATCH v2 08/23] gpio: sysfs: use gpio_device_find() to iterate over existing devices
Date: Mon,  5 Feb 2024 10:34:03 +0100
Message-Id: <20240205093418.39755-9-brgl@bgdev.pl>
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

With the list of GPIO devices now protected with SRCU we can use
gpio_device_find() to traverse it from sysfs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c | 41 ++++++++++++++++--------------------
 drivers/gpio/gpiolib.c       |  2 +-
 drivers/gpio/gpiolib.h       |  1 -
 3 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 6bf5332136e5..3c3b8559cff5 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -790,11 +790,24 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 	}
 }
 
+static int gpiofind_sysfs_register(struct gpio_chip *gc, void *data)
+{
+	struct gpio_device *gdev = gc->gpiodev;
+	int ret;
+
+	if (gdev->mockdev)
+		return 0;
+
+	ret = gpiochip_sysfs_register(gdev);
+	if (ret)
+		chip_err(gc, "failed to register the sysfs entry: %d\n", ret);
+
+	return 0;
+}
+
 static int __init gpiolib_sysfs_init(void)
 {
-	int		status;
-	unsigned long	flags;
-	struct gpio_device *gdev;
+	int status;
 
 	status = class_register(&gpio_class);
 	if (status < 0)
@@ -806,26 +819,8 @@ static int __init gpiolib_sysfs_init(void)
 	 * We run before arch_initcall() so chip->dev nodes can have
 	 * registered, and so arch_initcall() can always gpiod_export().
 	 */
-	spin_lock_irqsave(&gpio_lock, flags);
-	list_for_each_entry(gdev, &gpio_devices, list) {
-		if (gdev->mockdev)
-			continue;
+	gpio_device_find(NULL, gpiofind_sysfs_register);
 
-		/*
-		 * TODO we yield gpio_lock here because
-		 * gpiochip_sysfs_register() acquires a mutex. This is unsafe
-		 * and needs to be fixed.
-		 *
-		 * Also it would be nice to use gpio_device_find() here so we
-		 * can keep gpio_chips local to gpiolib.c, but the yield of
-		 * gpio_lock prevents us from doing this.
-		 */
-		spin_unlock_irqrestore(&gpio_lock, flags);
-		status = gpiochip_sysfs_register(gdev);
-		spin_lock_irqsave(&gpio_lock, flags);
-	}
-	spin_unlock_irqrestore(&gpio_lock, flags);
-
-	return status;
+	return 0;
 }
 postcore_initcall(gpiolib_sysfs_init);
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f425e0264b7e..6cfb75ee739d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -85,7 +85,7 @@ DEFINE_SPINLOCK(gpio_lock);
 static DEFINE_MUTEX(gpio_lookup_lock);
 static LIST_HEAD(gpio_lookup_list);
 
-LIST_HEAD(gpio_devices);
+static LIST_HEAD(gpio_devices);
 /* Protects the GPIO device list against concurrent modifications. */
 static DEFINE_MUTEX(gpio_devices_lock);
 /* Ensures coherence during read-only accesses to the list of GPIO devices. */
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index d2e73eea9e92..2bf3f9e13ae4 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -136,7 +136,6 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 int gpiod_set_transitory(struct gpio_desc *desc, bool transitory);
 
 extern spinlock_t gpio_lock;
-extern struct list_head gpio_devices;
 
 void gpiod_line_state_notify(struct gpio_desc *desc, unsigned long action);
 
-- 
2.40.1


