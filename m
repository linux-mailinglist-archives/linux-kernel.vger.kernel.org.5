Return-Path: <linux-kernel+bounces-57798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBAF84DD89
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C5D1F28AB2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AA96BFC2;
	Thu,  8 Feb 2024 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="E5uVvmAv"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F236F509
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386379; cv=none; b=WnDvD7vWz/e4+aPFCHhhSSbf0wVrkwQffa/aUaBT/2U9pMUuCgsfEmkawWxUeD7tfBUqHQORAvbPBg2ewjHBjtymtycT46F+rqGtFGu40ivWci5Ngbeo8eQX5Yjuev9SxRLCvrCQCmUAmPoXQsem4dgS7V0MfzpNkIR/9rU5Hl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386379; c=relaxed/simple;
	bh=nqqbS2qohTq/5yvdbqYSBh0+77NQz8ZBBvynqMCXiJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H9YFkAdeDfaKbGWqPoC3bdKAt2XfPksFt8Dw/UmPRsxJSQrW39MwraWdWnTiU2NXPGbwmLHrL+Od4Jpq+OygZIidvxjxeuvwtRZ7eWsfk9NFgOIIfhPnvK87fXvK0439KFYpHte5xBj0uUiKHWnVzIbEf9u9Y+DshXuQSHieSVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=E5uVvmAv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b53d7c093so533281f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386375; x=1707991175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tw6Pf3/mNBAClq4IyQDOFbA2QhsVTUfszg40T5HZdL0=;
        b=E5uVvmAvitzHvkO9C3USCr3Cyi7jMj5LFWtCZWON5FRl38jy4tl82SIxWApvP/t452
         rIHFN6U94uxS+LJhuoEwBPlttxtPtCjStZ5dyCxcnCW3zDnIvl5mAEFVb9EIsR3kE/wH
         5R1/ewhfZ1gykCEgxSpN1jYfChDWOeJI5M7XNjRXNbS2DAqS41xVSu780ZnClG8hCaA0
         VpS7259Gu6YAqvuEVnPGqLPldSAUJj1m/ax3rw3+12ZxFqZK+O/D6h6DMTw8JK+ZDkuo
         eoinlT1bbwb2xr9oDBBogofaArxwrL5mPsxUVHv/abnzdjihFv7d1QAS9wB0fHtPiZCx
         mK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386375; x=1707991175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tw6Pf3/mNBAClq4IyQDOFbA2QhsVTUfszg40T5HZdL0=;
        b=Z+L4d78DQz7ZLuI66ydZ9DYUjRiMVB2sRqwo/RPHfC/smXBMDDwSXDnklUZfbgyJ0k
         WHyvsNTRhcuxya1I59dwXy42TEL8CSO/5ii+bZsPbJG7Np1HKtGAs3v2YmDJioperO2h
         zYT5RLr+p07QNd8szj5COsQ9npUNoLG4Jqmw/nryF/a4vZMPdmknLD8GDXNI9HMI108z
         FzfZyI5BEzyJE1C0cetm5YW476H58wTZw5JT700zxkILRKJN53kzXzbQJxDgBp95GnRy
         VXW+ewpFU3fMtXbZU6aNY93EXcEqqhIDdL4+9yuBWomBXZFv/5J+8K7k5oRA3juXZi0v
         0xEw==
X-Gm-Message-State: AOJu0YxjXcu0Ykr1+VVzSQkHEhLCtzVFGAQc/lnVZ7MHR2RlxVGNsNMX
	t8/Z1QcU5e0Uya+KM8DHvDAMR/VXCjpOQNm0O37DwZyO74AJ23K10gdEydlBcnI=
X-Google-Smtp-Source: AGHT+IF7aSliF1bS/hoW00jA8rqVHoDWdBy6QKI5zrq1nPbWER85XxobwzkHjUYJqd2O5MsKxbjYrQ==
X-Received: by 2002:a5d:5889:0:b0:33b:4ec0:8159 with SMTP id n9-20020a5d5889000000b0033b4ec08159mr3704032wrf.33.1707386375106;
        Thu, 08 Feb 2024 01:59:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpQA+i2qmzFmk802gcTHwt9lCaXpxug5opoef4pZAfxJxL2PrfaIZrPfJA2j4rES3gdsyGg0R7/vd3hzZ5UxcpsbioddUNDek8ObF1zOT7OJLGB858Fy58s5EzgxU1MVt6gsa2josB4aMEP6cxpMyMFUmsW+859/TkYuEAaXQ1zGCqYC38ZPNWU/diplYEBSaH7qtPazxMjGRnCJKsW7QbUHV9xVhQUqIsfGs91NW+d5BrMvmV+2utdJmsft9x1aEnzlv+GxfnSisBOo5lnes//tr3yiHuJYpkaofOY3KFzogxUx/TfZocgPLsd+id3+V3/LdGLz8Dq/aevvfZpNrSUNf0AP/i4A==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:34 -0800 (PST)
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
Subject: [PATCH v3 09/24] gpio: remove gpio_lock
Date: Thu,  8 Feb 2024 10:59:05 +0100
Message-Id: <20240208095920.8035-10-brgl@bgdev.pl>
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

The "multi-function" gpio_lock is pretty much useless with how it's used
in GPIOLIB currently. Because many GPIO API calls can be called from all
contexts but may also call into sleeping driver callbacks, there are
many places with utterly broken workarounds like yielding the lock to
call a possibly sleeping function and then re-acquiring it again without
taking into account that the protected state may have changed.

It was also used to protect several unrelated things: like individual
descriptors AND the GPIO device list. We now serialize access to these
two with SRCU and so can finally remove the spinlock.

There is of course the question of consistency of lockless access to
GPIO descriptors. Because we only support exclusive access to GPIOs
(officially anyway, I'm looking at you broken
GPIOD_FLAGS_BIT_NONEXCLUSIVE bit...) and the API contract with providers
does not guarantee serialization, it's enough to ensure we cannot
accidentally dereference an invalid pointer and that the state we present
to both users and providers remains consistent. To achieve that: read the
flags field atomically except for a few special cases. Read their current
value before executing callback code and use this value for any subsequent
logic. Modifying the flags depends on the particular use-case and can
differ. For instance: when requesting a GPIO, we need to set the
REQUESTED bit immediately so that the next user trying to request the
same line sees -EBUSY.

While at it: the allocations that used GFP_ATOMIC until this point can
now switch to GFP_KERNEL.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c  |  18 +++---
 drivers/gpio/gpiolib-sysfs.c |  17 ++----
 drivers/gpio/gpiolib.c       | 106 +++++++++++------------------------
 drivers/gpio/gpiolib.h       |   2 -
 4 files changed, 46 insertions(+), 97 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 75f4912339a6..3588aaf90e45 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2302,18 +2302,16 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	memset(info, 0, sizeof(*info));
 	info->offset = gpio_chip_hwgpio(desc);
 
-	scoped_guard(spinlock_irqsave, &gpio_lock) {
-		if (desc->name)
-			strscpy(info->name, desc->name, sizeof(info->name));
+	if (desc->name)
+		strscpy(info->name, desc->name, sizeof(info->name));
 
-		scoped_guard(srcu, &desc->srcu) {
-			label = gpiod_get_label(desc);
-			if (label)
-				strscpy(info->consumer, label,
-					sizeof(info->consumer));
-		}
+	dflags = READ_ONCE(desc->flags);
 
-		dflags = READ_ONCE(desc->flags);
+	scoped_guard(srcu, &desc->srcu) {
+		label = gpiod_get_label(desc);
+		if (label && test_bit(FLAG_REQUESTED, &dflags))
+			strscpy(info->consumer, label,
+				sizeof(info->consumer));
 	}
 
 	/*
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index d6ff044ce887..3fe740b7d84d 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -563,7 +563,6 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 	struct gpio_device *gdev;
 	struct gpiod_data *data;
 	struct gpio_chip *chip;
-	unsigned long flags;
 	struct device *dev;
 	int status, offset;
 
@@ -578,6 +577,9 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 		return -EINVAL;
 	}
 
+	if (!test_and_set_bit(FLAG_EXPORT, &desc->flags))
+		return -EPERM;
+
 	gdev = desc->gdev;
 	chip = gdev->chip;
 
@@ -589,18 +591,11 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 		goto err_unlock;
 	}
 
-	spin_lock_irqsave(&gpio_lock, flags);
-	if (!test_bit(FLAG_REQUESTED, &desc->flags) ||
-	     test_bit(FLAG_EXPORT, &desc->flags)) {
-		spin_unlock_irqrestore(&gpio_lock, flags);
-		gpiod_dbg(desc, "%s: unavailable (requested=%d, exported=%d)\n",
-				__func__,
-				test_bit(FLAG_REQUESTED, &desc->flags),
-				test_bit(FLAG_EXPORT, &desc->flags));
+	if (!test_bit(FLAG_REQUESTED, &desc->flags)) {
+		gpiod_dbg(desc, "%s: unavailable (not requested)\n", __func__);
 		status = -EPERM;
 		goto err_unlock;
 	}
-	spin_unlock_irqrestore(&gpio_lock, flags);
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data) {
@@ -628,7 +623,6 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 		goto err_free_data;
 	}
 
-	set_bit(FLAG_EXPORT, &desc->flags);
 	mutex_unlock(&sysfs_lock);
 	return 0;
 
@@ -636,6 +630,7 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 	kfree(data);
 err_unlock:
 	mutex_unlock(&sysfs_lock);
+	clear_bit(FLAG_EXPORT, &desc->flags);
 	gpiod_dbg(desc, "%s: status %d\n", __func__, status);
 	return status;
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 68543ab34fb6..d0de492acd4c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -76,12 +76,6 @@ static const struct bus_type gpio_bus_type = {
  */
 #define FASTPATH_NGPIO CONFIG_GPIOLIB_FASTPATH_LIMIT
 
-/* gpio_lock prevents conflicts during gpio_desc[] table updates.
- * While any GPIO is requested, its gpio_chip is not removable;
- * each GPIO's "requested" flag serves as a lock and refcount.
- */
-DEFINE_SPINLOCK(gpio_lock);
-
 static DEFINE_MUTEX(gpio_lookup_lock);
 static LIST_HEAD(gpio_lookup_list);
 
@@ -123,8 +117,7 @@ static int desc_set_label(struct gpio_desc *desc, const char *label)
 	const char *new = NULL, *old;
 
 	if (label) {
-		/* FIXME: make this GFP_KERNEL once the spinlock is out. */
-		new = kstrdup_const(label, GFP_ATOMIC);
+		new = kstrdup_const(label, GFP_KERNEL);
 		if (!new)
 			return -ENOMEM;
 	}
@@ -1093,7 +1086,6 @@ EXPORT_SYMBOL_GPL(gpiochip_add_data_with_key);
 void gpiochip_remove(struct gpio_chip *gc)
 {
 	struct gpio_device *gdev = gc->gpiodev;
-	unsigned long flags;
 	unsigned int i;
 
 	down_write(&gdev->sem);
@@ -1119,12 +1111,10 @@ void gpiochip_remove(struct gpio_chip *gc)
 	 */
 	gpiochip_set_data(gc, NULL);
 
-	spin_lock_irqsave(&gpio_lock, flags);
 	for (i = 0; i < gdev->ngpio; i++) {
 		if (test_bit(FLAG_REQUESTED, &gdev->descs[i].flags))
 			break;
 	}
-	spin_unlock_irqrestore(&gpio_lock, flags);
 
 	if (i != gdev->ngpio)
 		dev_crit(&gdev->dev,
@@ -2227,62 +2217,43 @@ EXPORT_SYMBOL_GPL(gpiochip_remove_pin_ranges);
 static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 {
 	struct gpio_chip *gc = desc->gdev->chip;
-	unsigned long flags;
 	unsigned int offset;
 	int ret;
 
+	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags))
+		return -EBUSY;
+
 	if (label) {
 		label = kstrdup_const(label, GFP_KERNEL);
 		if (!label)
 			return -ENOMEM;
 	}
 
-	spin_lock_irqsave(&gpio_lock, flags);
-
 	/* NOTE:  gpio_request() can be called in early boot,
 	 * before IRQs are enabled, for non-sleeping (SOC) GPIOs.
 	 */
 
-	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags)) {
-		ret = -EBUSY;
-		goto out_free_unlock;
-	}
-
 	if (gc->request) {
-		/* gc->request may sleep */
-		spin_unlock_irqrestore(&gpio_lock, flags);
 		offset = gpio_chip_hwgpio(desc);
 		if (gpiochip_line_is_valid(gc, offset))
 			ret = gc->request(gc, offset);
 		else
 			ret = -EINVAL;
-		spin_lock_irqsave(&gpio_lock, flags);
+		if (ret)
+			goto out_clear_bit;
+	}
 
-		if (ret) {
-			desc_set_label(desc, NULL);
-			clear_bit(FLAG_REQUESTED, &desc->flags);
-			goto out_free_unlock;
-		}
-	}
-	if (gc->get_direction) {
-		/* gc->get_direction may sleep */
-		spin_unlock_irqrestore(&gpio_lock, flags);
+	if (gc->get_direction)
 		gpiod_get_direction(desc);
-		spin_lock_irqsave(&gpio_lock, flags);
-	}
-	spin_unlock_irqrestore(&gpio_lock, flags);
 
 	ret = desc_set_label(desc, label ? : "?");
-	if (ret) {
-		clear_bit(FLAG_REQUESTED, &desc->flags);
-		return ret;
-	}
+	if (ret)
+		goto out_clear_bit;
 
 	return 0;
 
-out_free_unlock:
-	spin_unlock_irqrestore(&gpio_lock, flags);
-	kfree_const(label);
+out_clear_bit:
+	clear_bit(FLAG_REQUESTED, &desc->flags);
 	return ret;
 }
 
@@ -2352,35 +2323,32 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 
 	might_sleep();
 
-	spin_lock_irqsave(&gpio_lock, flags);
-
 	gc = desc->gdev->chip;
-	if (gc && test_bit(FLAG_REQUESTED, &desc->flags)) {
-		if (gc->free) {
-			spin_unlock_irqrestore(&gpio_lock, flags);
-			might_sleep_if(gc->can_sleep);
+	flags = READ_ONCE(desc->flags);
+
+	if (gc && test_bit(FLAG_REQUESTED, &flags)) {
+		if (gc->free)
 			gc->free(gc, gpio_chip_hwgpio(desc));
-			spin_lock_irqsave(&gpio_lock, flags);
-		}
-		clear_bit(FLAG_ACTIVE_LOW, &desc->flags);
-		clear_bit(FLAG_REQUESTED, &desc->flags);
-		clear_bit(FLAG_OPEN_DRAIN, &desc->flags);
-		clear_bit(FLAG_OPEN_SOURCE, &desc->flags);
-		clear_bit(FLAG_PULL_UP, &desc->flags);
-		clear_bit(FLAG_PULL_DOWN, &desc->flags);
-		clear_bit(FLAG_BIAS_DISABLE, &desc->flags);
-		clear_bit(FLAG_EDGE_RISING, &desc->flags);
-		clear_bit(FLAG_EDGE_FALLING, &desc->flags);
-		clear_bit(FLAG_IS_HOGGED, &desc->flags);
+
+		clear_bit(FLAG_ACTIVE_LOW, &flags);
+		clear_bit(FLAG_REQUESTED, &flags);
+		clear_bit(FLAG_OPEN_DRAIN, &flags);
+		clear_bit(FLAG_OPEN_SOURCE, &flags);
+		clear_bit(FLAG_PULL_UP, &flags);
+		clear_bit(FLAG_PULL_DOWN, &flags);
+		clear_bit(FLAG_BIAS_DISABLE, &flags);
+		clear_bit(FLAG_EDGE_RISING, &flags);
+		clear_bit(FLAG_EDGE_FALLING, &flags);
+		clear_bit(FLAG_IS_HOGGED, &flags);
 #ifdef CONFIG_OF_DYNAMIC
 		WRITE_ONCE(desc->hog, NULL);
 #endif
 		ret = true;
-	}
+		desc_set_label(desc, NULL);
+		WRITE_ONCE(desc->flags, flags);
 
-	spin_unlock_irqrestore(&gpio_lock, flags);
-	desc_set_label(desc, NULL);
-	gpiod_line_state_notify(desc, GPIOLINE_CHANGED_RELEASED);
+		gpiod_line_state_notify(desc, GPIOLINE_CHANGED_RELEASED);
+	}
 
 	return ret;
 }
@@ -2422,22 +2390,12 @@ char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)
 	if (IS_ERR(desc))
 		return NULL;
 
-	guard(spinlock_irqsave)(&gpio_lock);
-
 	if (!test_bit(FLAG_REQUESTED, &desc->flags))
 		return NULL;
 
 	guard(srcu)(&desc->srcu);
 
-	/*
-	 * FIXME: Once we mark gpiod_direction_input/output() and
-	 * gpiod_get_direction() with might_sleep(), we'll be able to protect
-	 * the GPIO descriptors with mutex (while value setting operations will
-	 * become lockless).
-	 *
-	 * Until this happens, this allocation needs to be atomic.
-	 */
-	label = kstrdup(gpiod_get_label(desc), GFP_ATOMIC);
+	label = kstrdup(gpiod_get_label(desc), GFP_KERNEL);
 	if (!label)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 2bf3f9e13ae4..9b7afe87f1bd 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -135,8 +135,6 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 
 int gpiod_set_transitory(struct gpio_desc *desc, bool transitory);
 
-extern spinlock_t gpio_lock;
-
 void gpiod_line_state_notify(struct gpio_desc *desc, unsigned long action);
 
 /**
-- 
2.40.1


