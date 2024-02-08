Return-Path: <linux-kernel+bounces-57796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3138C84DD84
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AF41C27266
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ABD6F53B;
	Thu,  8 Feb 2024 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DN/ALtsm"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183E16F061
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386377; cv=none; b=BjiFRQ0synUDwMnTNYNdadG0u/d/BJRTN5obuRgtt9w8xT+ntdipEgE5aO46JRpO4znMV0PRlg8Hu0SCv25kKVx5cFqjJFiYLy/xv0WUeu/cTfVR0x8hvuISCxzld7m4Xih7F8bk21cTMmGArSXeAT0PzFuZ15jevfe4Wjx1/9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386377; c=relaxed/simple;
	bh=sbeEFCjaW/O4DVCAwoiNebLnpHebEBuzjUexVdu18I8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NmhF5KaeQb4qd5/eCQ48lkhT2RVvbTU9JTBqV7yE0WspejBGcsWqrtS+gnW+lCckjgvSljUybroJN6ITHIfvHQqzOceGdPYOSrOohXQsJ1CsF1E3A9Xe2quTFBcCL/CVk6bLmM6Z7WARITVP4lu3Lht+4xGuMP+VXtNr/LcfSKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DN/ALtsm; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-511717231bfso206287e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386373; x=1707991173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mk8/t4lpC1U+h34P66Tm04NaklyP+2BT7bb9Fj0gLH4=;
        b=DN/ALtsmGpnfp6MnozgRlTw8+p7hlPsUi4FiB6yHlxY2fByVJWrm5TVu8KvvWbg1LV
         bm6CEQcvrgV0E+lfqUUJ17rUhB7xW83tC/BLrr56L4WeP2J6KL91Lg37mSxe/Zy7G4sd
         kMMjDjY89OhXOUL9AmbYs57LizbWebD+odxNvB5tL9wdkwYQsudEg5QqAm6gJ/eBmF2Z
         7eQZbjwVuVaTrhbvBW6xjNc9HQysG0JmCK1ObRytP6u3uud1uanWy/5r9VG5DEsLILU1
         ms0fpRAChQpwdb3ZH0xH/5MZ41WO8Qbcd3irTKOSEfLNk+K6t7rit2RIZR4j0pP6TQ+B
         TrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386373; x=1707991173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mk8/t4lpC1U+h34P66Tm04NaklyP+2BT7bb9Fj0gLH4=;
        b=WwANJiGjYLyeAVNVhjZue+9j5dsDUZuo/D8huWIfjzRAz26ZSpjyk5vfRTyu24UU+t
         cwV1G509b8AJWdGoQ419vTUtgEpG+w+7pRbf/AHSCEAVS+nIM9v95BLIJchbO92gMCBU
         54Uz4fsYyeeZx9qgv1O/UecTfKo0vdzYyOFn/Y0IA3yZA6XCBaZwPHMdfhVnluqhbPvs
         Rz7yh1l8kaE7V5AUet4CUAWFcL/34+7VyqjJpFE8b9dBcJs0+FCAs6SVsSAzBoW7s0nc
         Ci2qXapknV/TE8Qhd1XJqs69ktwohfaeqspwYW2UiIg1BoIjeAJ8ENLqyq/tzrRh/a3z
         csBA==
X-Gm-Message-State: AOJu0YxpVzdaf5nWjqoxFNw7oPntYRAjMezXzjX6ZU2aOOvkBOez/lLL
	kl/2n2nXgpYdtT1o+leiQx6gOTU2GRivMUAIVv4/JhSyJspFD+wkDB6DHzEOoGw=
X-Google-Smtp-Source: AGHT+IF6fRp5/NHFrkShluMjplKtXhZ9HNS6Xtid9aBfV69DG+FErqtNw2vxAvZAgYE4y/y6AgOs3A==
X-Received: by 2002:a05:6512:b88:b0:511:54ab:9bed with SMTP id b8-20020a0565120b8800b0051154ab9bedmr7080929lfv.2.1707386373063;
        Thu, 08 Feb 2024 01:59:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRljNZ8szBqDwxNd0CM2I2xNoQaylNLB28T9chIG/h2gQxNAq5f9dxmB8Um+x1TV+v4cSc660TokB8uXinEGSxMY4cARwOIznlCFIaPIjgP0nqFpENQ37u6d3igm0Jf3YyaeDSULJV8e65QVb+j36yOXCK8HHtSaoCqRg7+Ws29s2X3vOBroBiJfsr304tlboYQwgygVomzQ6KX/2lDsrJnxKbWscjQtBZ8aW0aa00ciLLfp+PDjOsa7aIBN2i1E7CydvT3J4V+1TAGS6Ceoz0+iQpgAs9xyTjY6W32NDPFAneYYtZXp27E2W8pTCEXC99IYD1PzHX42XAC7gfHvsSZKk3OsV5zQ==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:32 -0800 (PST)
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
Subject: [PATCH v3 07/24] gpio: protect the descriptor label with SRCU
Date: Thu,  8 Feb 2024 10:59:03 +0100
Message-Id: <20240208095920.8035-8-brgl@bgdev.pl>
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

In order to ensure that the label is not freed while it's being
accessed, let's protect it with SRCU and synchronize it everytime it's
changed.

Let's modify desc_set_label() to manage the memory used for the label as
it can only be freed once synchronize_srcu() returns.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 10 +++++---
 drivers/gpio/gpiolib.c      | 47 +++++++++++++++++++++++--------------
 drivers/gpio/gpiolib.h      | 34 +++++++++++++++++++--------
 3 files changed, 61 insertions(+), 30 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 2c0a0700762d..75f4912339a6 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2297,6 +2297,7 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 {
 	struct gpio_chip *gc = desc->gdev->chip;
 	unsigned long dflags;
+	const char *label;
 
 	memset(info, 0, sizeof(*info));
 	info->offset = gpio_chip_hwgpio(desc);
@@ -2305,9 +2306,12 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 		if (desc->name)
 			strscpy(info->name, desc->name, sizeof(info->name));
 
-		if (gpiod_get_label(desc))
-			strscpy(info->consumer, gpiod_get_label(desc),
-				sizeof(info->consumer));
+		scoped_guard(srcu, &desc->srcu) {
+			label = gpiod_get_label(desc);
+			if (label)
+				strscpy(info->consumer, label,
+					sizeof(info->consumer));
+		}
 
 		dflags = READ_ONCE(desc->flags);
 	}
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index b26d39bc3389..a87ab8f013c4 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -114,12 +114,26 @@ const char *gpiod_get_label(struct gpio_desc *desc)
 	    !test_bit(FLAG_REQUESTED, &flags))
 		return "interrupt";
 
-	return test_bit(FLAG_REQUESTED, &flags) ? desc->label : NULL;
+	return test_bit(FLAG_REQUESTED, &flags) ?
+			rcu_dereference(desc->label) : NULL;
 }
 
-static inline void desc_set_label(struct gpio_desc *d, const char *label)
+static int desc_set_label(struct gpio_desc *desc, const char *label)
 {
-	d->label = label;
+	const char *new = NULL, *old;
+
+	if (label) {
+		/* FIXME: make this GFP_KERNEL once the spinlock is out. */
+		new = kstrdup_const(label, GFP_ATOMIC);
+		if (!new)
+			return -ENOMEM;
+	}
+
+	old = rcu_replace_pointer(desc->label, new, 1);
+	synchronize_srcu(&desc->srcu);
+	kfree_const(old);
+
+	return 0;
 }
 
 /**
@@ -2229,9 +2243,7 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 	 * before IRQs are enabled, for non-sleeping (SOC) GPIOs.
 	 */
 
-	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags) == 0) {
-		desc_set_label(desc, label ? : "?");
-	} else {
+	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags)) {
 		ret = -EBUSY;
 		goto out_free_unlock;
 	}
@@ -2259,6 +2271,13 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 		spin_lock_irqsave(&gpio_lock, flags);
 	}
 	spin_unlock_irqrestore(&gpio_lock, flags);
+
+	ret = desc_set_label(desc, label ? : "?");
+	if (ret) {
+		clear_bit(FLAG_REQUESTED, &desc->flags);
+		return ret;
+	}
+
 	return 0;
 
 out_free_unlock:
@@ -2343,8 +2362,6 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 			gc->free(gc, gpio_chip_hwgpio(desc));
 			spin_lock_irqsave(&gpio_lock, flags);
 		}
-		kfree_const(desc->label);
-		desc_set_label(desc, NULL);
 		clear_bit(FLAG_ACTIVE_LOW, &desc->flags);
 		clear_bit(FLAG_REQUESTED, &desc->flags);
 		clear_bit(FLAG_OPEN_DRAIN, &desc->flags);
@@ -2362,6 +2379,7 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 	}
 
 	spin_unlock_irqrestore(&gpio_lock, flags);
+	desc_set_label(desc, NULL);
 	gpiod_line_state_notify(desc, GPIOLINE_CHANGED_RELEASED);
 
 	return ret;
@@ -2409,6 +2427,8 @@ char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)
 	if (!test_bit(FLAG_REQUESTED, &desc->flags))
 		return NULL;
 
+	guard(srcu)(&desc->srcu);
+
 	/*
 	 * FIXME: Once we mark gpiod_direction_input/output() and
 	 * gpiod_get_direction() with might_sleep(), we'll be able to protect
@@ -3520,16 +3540,8 @@ EXPORT_SYMBOL_GPL(gpiod_cansleep);
 int gpiod_set_consumer_name(struct gpio_desc *desc, const char *name)
 {
 	VALIDATE_DESC(desc);
-	if (name) {
-		name = kstrdup_const(name, GFP_KERNEL);
-		if (!name)
-			return -ENOMEM;
-	}
 
-	kfree_const(desc->label);
-	desc_set_label(desc, name);
-
-	return 0;
+	return desc_set_label(desc, name);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_consumer_name);
 
@@ -4739,6 +4751,7 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
 	int value;
 
 	for_each_gpio_desc(gc, desc) {
+		guard(srcu)(&desc->srcu);
 		if (test_bit(FLAG_REQUESTED, &desc->flags)) {
 			gpiod_get_direction(desc);
 			is_out = test_bit(FLAG_IS_OUT, &desc->flags);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 6e14b629c48b..d2e73eea9e92 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -180,7 +180,7 @@ struct gpio_desc {
 #define FLAG_EVENT_CLOCK_HTE		19 /* GPIO CDEV reports hardware timestamps in events */
 
 	/* Connection label */
-	const char		*label;
+	const char __rcu	*label;
 	/* Name of the GPIO */
 	const char		*name;
 #ifdef CONFIG_OF_DYNAMIC
@@ -223,15 +223,29 @@ static inline int gpio_chip_hwgpio(const struct gpio_desc *desc)
 
 /* With descriptor prefix */
 
-#define gpiod_err(desc, fmt, ...)					       \
-	pr_err("gpio-%d (%s): " fmt, desc_to_gpio(desc), desc->label ? : "?",  \
-		 ##__VA_ARGS__)
-#define gpiod_warn(desc, fmt, ...)					       \
-	pr_warn("gpio-%d (%s): " fmt, desc_to_gpio(desc), desc->label ? : "?", \
-		 ##__VA_ARGS__)
-#define gpiod_dbg(desc, fmt, ...)					       \
-	pr_debug("gpio-%d (%s): " fmt, desc_to_gpio(desc), desc->label ? : "?",\
-		 ##__VA_ARGS__)
+#define gpiod_err(desc, fmt, ...) \
+do { \
+	scoped_guard(srcu, &desc->srcu) { \
+		pr_err("gpio-%d (%s): " fmt, desc_to_gpio(desc), \
+		       gpiod_get_label(desc) ? : "?", ##__VA_ARGS__); \
+	} \
+} while (0)
+
+#define gpiod_warn(desc, fmt, ...) \
+do { \
+	scoped_guard(srcu, &desc->srcu) { \
+		pr_warn("gpio-%d (%s): " fmt, desc_to_gpio(desc), \
+			gpiod_get_label(desc) ? : "?", ##__VA_ARGS__); \
+	} \
+} while (0)
+
+#define gpiod_dbg(desc, fmt, ...) \
+do { \
+	scoped_guard(srcu, &desc->srcu) { \
+		pr_debug("gpio-%d (%s): " fmt, desc_to_gpio(desc), \
+			 gpiod_get_label(desc) ? : "?", ##__VA_ARGS__); \
+	} \
+} while (0)
 
 /* With chip prefix */
 
-- 
2.40.1


