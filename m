Return-Path: <linux-kernel+bounces-44635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEF1842557
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E38F1F2B096
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC6E768FF;
	Tue, 30 Jan 2024 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="SElsLa6t"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52BE6DD11
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618930; cv=none; b=snORlXXN2Jurxrd+a7eCPNkm4XopgPJgfnYNdc0r8Xo0wk+Ti1MFA38arzcBLuUFd8ooXyF8i7jagqs3i9gjxfrrEWg+psHVTpaPa1trZ7Y0EVKR4gdkpdIHtNpsWvyWjXQzgVlon3JhAEaschP5a0uSgvntGllQFk808789R14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618930; c=relaxed/simple;
	bh=p2h7HZnOPsK5/BAPlWhXykE++wUlNbvr66TKp9HVCxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=us14YVfc/ptY44V590yT9Kn/qxeXvdT0rUhQvrM6c4BjFyC+EOceZ2Z39Tu7bmlvkVYJTehhu/nzqo/1LW5EMLrQ+E/9rwKyONURivWwfICWZXeo07aAQe+h48noMJrU+leKccnsUc9bXt6qyIfPRIA9ATUG3KBXW6IP3Ei3AkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=SElsLa6t; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40faff092a2so872965e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706618927; x=1707223727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hx4dI/SeySHXD1hWEoudVUeXvciOCRh+p3Pv4t1b4q0=;
        b=SElsLa6tGjLu4tFZFz2HcD9w48STiHv+MGPwdGPNo0jjRzTPAtSJpvI0PFCTg2sPJu
         4OWkDyOniubX9QdtSaNLvFohJrxRPh9clCEDugYy1NUev6WFUtN94VcoSXPr7B0+sE0u
         lAb4rCQWiq1W4xZkrliZvFiqsmyUUQ0o0AdM8jRQ7G+KX222aNFQyKjhfcxod72Dopz+
         hLNtw8Kqg5vofb5C3nKL27EhidJrAuupe2eewAtPdBRjA7JARb+9kttQNSZHCV8xxnSA
         4Q9Vq2AM7H8lHQ9TkDnk2toiukVakvI/VJXkn/1mgXpWkrQavcx3KJN+AvGhaeGSD0xm
         wiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618927; x=1707223727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hx4dI/SeySHXD1hWEoudVUeXvciOCRh+p3Pv4t1b4q0=;
        b=X/m5XJkDj2js9m7rpDbiAR+YDu8yBXYyiSC2fs7PTLamssLN08OWCyyXQAFJ5HFTpk
         5rj9fVHENuV9hJ1/RWRQoIDV6rf6kaabXwYT3MsbU5/BCrbWLBTlWynsTfAgSY/QgAqY
         vR5uRearQOtzVNyz8hJ429yJobltYYobXUQu29pJrm8Z6rG/Fh3RaaE+iwGsK5P2YbO1
         LFggIC9ci74KKGAmp0KTahBgSUrrqHWwLheCZ4nVZG9R1ErFu16X2ZplAQ6CtdGT3Kvs
         wnpYEzWW4OINOj1x2uSj07nQ7j1P16jpbpzMb6/9fKRlZIT5wKMenlisZ6m80TyGK/0i
         2aXg==
X-Gm-Message-State: AOJu0YzenSgF70DGFmk1+cS/TP2YcaVe1c2jkW5CRgxq+4PmcVzXfiLY
	EFWwfO2jESShdbxkBhKuBR37FPpUVoufRGnSbTyJyFNnaMWZlsIvPvGY3KF2wN1SvH7FY6oJJv0
	n
X-Google-Smtp-Source: AGHT+IFbwYsTFa4MdWk0nmHyqp7UelTYlEJ3oybMy3DdKTBOhBBa+wLk/yf6UBDYgr3WGRmPLJZUBQ==
X-Received: by 2002:a5d:4e87:0:b0:33a:fcfc:d5d3 with SMTP id e7-20020a5d4e87000000b0033afcfcd5d3mr852608wru.2.1706618927092;
        Tue, 30 Jan 2024 04:48:47 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:abc8:f77e:abeb:129c])
        by smtp.gmail.com with ESMTPSA id en8-20020a056000420800b0033940016d6esm6625337wrb.93.2024.01.30.04.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:48:46 -0800 (PST)
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
Subject: [PATCH 08/22] gpio: sysfs: use gpio_device_find() to iterate over existing devices
Date: Tue, 30 Jan 2024 13:48:14 +0100
Message-Id: <20240130124828.14678-9-brgl@bgdev.pl>
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

With the list of GPIO devices now protected with SRCU we can use
gpio_device_find() to traverse it from sysfs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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
index 93b80f3e9fe2..87d05134384e 100644
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


