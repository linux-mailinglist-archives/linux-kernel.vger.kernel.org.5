Return-Path: <linux-kernel+bounces-52311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE6B84969F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826A02874FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1464216428;
	Mon,  5 Feb 2024 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ocrqLTly"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E129013AED
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125675; cv=none; b=K1fcy/5Iwga88Ct7sZiCbNjpverqLyOt6V/dh0UcCtCc86L5IB7WVTwNh1aVtXqn5QHbu1RllFYjr0G5S04130edHHK2/ytBk1K6KObgt9IgnBWZHLASeZiYYnd+kilvsi1RnnhRtGgSStB16jaeTXm3enVacZtCtZM70itF9IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125675; c=relaxed/simple;
	bh=Iu1ud2V7hAqRPw6qsJ4BEkBo20yGRwt6IVyG748uVng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ql5yuhUqZDs1RppOskDnTE5UDbta8eX93HAE2jphG1EpRPVbXAfaoX0x/AuZ3OaLAQBCej+0p24/a2ibDTucWtZwTlShib9VlXJ4xpoM/Ai5Y5KPu41VNu+YC6Ku1m6jjrJxul5cDIUvGedKiDas5VXbLfZ3Srh5OIPETwgO3ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ocrqLTly; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fdd11475aso3070225e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707125672; x=1707730472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZKu4GUN8Mdrmtq+mCLkathjFvWJwZX/fdEUwbcMDKM=;
        b=ocrqLTlyHem20c2HZRIZRuPnZkX6vJXs3gzTELx+5TfKM2tkfIk72hkPB8VmNDYD4m
         baV8GCuD35Gkiec/lfL7mMWc+1gHV9o6XJB2BUcDemFK1I/KDuLrGatrhQbsN9qDEKbz
         +6OJwUibzIDSf+W8EHhcVbEEq0vlR3qEcSE6Le8OYZFQ3zJ95KT2o2eAM5hi5wZ0feVq
         w/74MwmtJ6Dv57u+5ckJoBbbENPPztRxJJoQieVglfd2NrK/Zl3k6w2KoglMfO79T3kn
         HoY+WBg2TovQRVpCpJfTCwp0q76QzLmritT8014t2Qxjy5E9S9rz0fPbR+WDsd6IJsl5
         YiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125672; x=1707730472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZKu4GUN8Mdrmtq+mCLkathjFvWJwZX/fdEUwbcMDKM=;
        b=F+ZVn/ew1i063/wdQsde9fcGeZItLwDZrOD8h1T/XJoPDOFzbJtCCEXxyEfeqpQM4+
         CKfUk1YmeU7xzBV3p4BJk6zfalLTDk26LDaHBIjqi8DxbCh5y0JV+oVcVzkhO2l4B1EY
         jf2KXYxWRMvg3wD7WM1geOkExfu/nWLxnPCTtfB0UpLlEc9gllbUVY9PlRbBw2x3l7mB
         0FP6iqdH/UWd58/6wunfjGMyg4fGRaKSszDyPTC3e2WdHH66Lge5GCrg+TkGFpz6ExEw
         liGVic1UVV/ySM4WVVBwe3wgobmNifeaGKXpC5wf8dwdg0zTqU9doTfyzsxHyyCOpc18
         7ikg==
X-Gm-Message-State: AOJu0YxWNI8ud8/HMw7XjyKz9DTvTq3OGvy0w5cAEQ4ysPH1UPAHJra+
	aM1zKjA6BnN6aW3CkUttkQJZoFMJPdUndtH07/2kAhhqkZw66HPscQOPnnb0+bc=
X-Google-Smtp-Source: AGHT+IFDs25h1zo11JFYWw/lWaxEJX4khotrq6H9fGUlWGR98K+wisEz2DEBoU/sA+YMzz+RtVUYaQ==
X-Received: by 2002:a05:600c:190f:b0:40f:ddc8:f801 with SMTP id j15-20020a05600c190f00b0040fddc8f801mr506301wmq.34.1707125672015;
        Mon, 05 Feb 2024 01:34:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVWF4OPWhnyYDlGIv9CoNgJBcAmGOGu4ZDCZ/I3ZjxRyQjJY6xv0cL40qoBgpJYceHqbjp7DG4VWbAQq7dcExpzxlkGQZkW04j6VWRnfm/UMGkzxEQ2b83rP+u8/z7qlIH9WkSxHHjqGkuPoPJk7sS2c6UWBtJGTctulhKyUGl4wG2PNk0InO3RiABpcHD+9T9+G/q/gA0uh+TZUfosdgkOxwKjf6JgCE7W4ENJMHlse6iRE6yY3nXpGO6Ey9bUZIKmOpaEmsxjwuqlePYcRWximBuS2hXvy5ToMcFcLjUIYINzPS/OETEA2sMm4dwPI7Pf11U0lo2YPZYt7LzmH8ZbuLoDGBb5tA==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d929:10db:5b5c:b49d])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c154f00b0040fc771c864sm7980397wmg.14.2024.02.05.01.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:34:31 -0800 (PST)
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
Subject: [PATCH v2 07/23] gpio: protect the descriptor label with SRCU
Date: Mon,  5 Feb 2024 10:34:02 +0100
Message-Id: <20240205093418.39755-8-brgl@bgdev.pl>
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
index ea0c0158faaf..f425e0264b7e 100644
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
@@ -2223,9 +2237,7 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 	 * before IRQs are enabled, for non-sleeping (SOC) GPIOs.
 	 */
 
-	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags) == 0) {
-		desc_set_label(desc, label ? : "?");
-	} else {
+	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags)) {
 		ret = -EBUSY;
 		goto out_free_unlock;
 	}
@@ -2253,6 +2265,13 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
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
@@ -2337,8 +2356,6 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 			gc->free(gc, gpio_chip_hwgpio(desc));
 			spin_lock_irqsave(&gpio_lock, flags);
 		}
-		kfree_const(desc->label);
-		desc_set_label(desc, NULL);
 		clear_bit(FLAG_ACTIVE_LOW, &desc->flags);
 		clear_bit(FLAG_REQUESTED, &desc->flags);
 		clear_bit(FLAG_OPEN_DRAIN, &desc->flags);
@@ -2356,6 +2373,7 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 	}
 
 	spin_unlock_irqrestore(&gpio_lock, flags);
+	desc_set_label(desc, NULL);
 	gpiod_line_state_notify(desc, GPIOLINE_CHANGED_RELEASED);
 
 	return ret;
@@ -2403,6 +2421,8 @@ char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)
 	if (!test_bit(FLAG_REQUESTED, &desc->flags))
 		return NULL;
 
+	guard(srcu)(&desc->srcu);
+
 	/*
 	 * FIXME: Once we mark gpiod_direction_input/output() and
 	 * gpiod_get_direction() with might_sleep(), we'll be able to protect
@@ -3514,16 +3534,8 @@ EXPORT_SYMBOL_GPL(gpiod_cansleep);
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
 
@@ -4733,6 +4745,7 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
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


