Return-Path: <linux-kernel+bounces-63200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B92852C42
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2491F2516D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0565722EF4;
	Tue, 13 Feb 2024 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3JphTJhu"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9666E224F2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816678; cv=none; b=qIty0t9uk/5O3kQMnw/MMGR1VUtcTQgpBSLFjZk931YNf5qkNBLB/cUWNVApFPMSmRGJ5G3BFlWRuXzHCeAnpqNoREX6RKBFgcfeUKX1xElWyZBuYBKXVfMITWKPwJHhnzKBiAqy1iTapzPqsccZ2HJhq6kGR5CA603BUZsH/nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816678; c=relaxed/simple;
	bh=bA1DQr6eNnKSnBh6jQHkYSW2oFUilm3Qa6INtty5rTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HM+JbVbf/8RjEgSrlNDrH4LArhYS2bAIy6pbPK3iCfcch4/0P+/RJFuiwf4ImSnGEnpt+qSITkhT66IiTC/8QgCy7LPZH3ukFgD+a11sjcCm7TrENslPpa1tupOR6cPr248FvPgEtvk1TNXOqpXH4pwP6klHf8aCO8WJBruhtu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3JphTJhu; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ce0802f17so89435f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 01:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707816675; x=1708421475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mgf3CLa998KoIkw7FSWo/gVoKncfOZNXGb2ZGFv5c5c=;
        b=3JphTJhul1nLTufgIkRV/OjKia16bvHmtq+WgflQWzu0wT9JCYwYUFtpDkN8AE+NE+
         m1Nf5Xk1rkjGUeBZzCteTHI0pHK4WMqsxM7dvGsL2hTc1qNnMJETGifnzrrPZ2JU0eTk
         UNj7kG083YM//xu0RpEyyZFXnMeOsNGcEOk5WUlp/YCOvNodqaAU5oKXTjK2JtxlIfav
         i5TRT+n0gyVL/2jjKNvAK4UE7UyQszOafxUkImiatRXbMljod9KKwnav6Hw2BWLEsD8I
         Xn0gp+WTW6bnapmqp+TVt230gEysUwFr69N+DW/dHmTwLRLdxTutB5L1M/QTov8BxZWN
         pI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707816675; x=1708421475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mgf3CLa998KoIkw7FSWo/gVoKncfOZNXGb2ZGFv5c5c=;
        b=RqM6pwsgaSjIFwUPlfAt/f9VMSYJXALku6IMcsdF4g1xfu6CgJHkLgrscpxDe65nj6
         T02xScAJVmR6k665p72n9DA5UFe1MS1ZE9XTdoZSW5GfQVpPWNIPPCYvJV5iR+nDeL5R
         jrOXhQw82eQ/03FnBXEQvQx15/vv5W6vgFSh+3uWlrPsB9e8ZUWS9uOeDvgz1mRqd56p
         I44mfp9TJYC4WsgczOibdUp+vZ6n3uZKkeh2PLj5z//i3G+psYoZQgPiA0gL0ZkqH9as
         3DswqMh9GD3WNvs4RCuNZ7+8PI8b7I7113q5l28CZxSAlFIej6UuUWjgPTVQMMjadjP1
         zT4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbbR79KixB0+JM2OECZW0gwc6YJIUmpXVkYJd3dma8NmX3aCn1+lKij5D30NAOcZQF0aSOMIBVYq3olnxwGuXyHgS+b+fT/TDu8MHI
X-Gm-Message-State: AOJu0YynHr79VFy0IWqaDS2gaR5kNJBPU7xM+0mueWuKdQ1Spj+5rggv
	fru/y6OX5Wmfrt63CROb6pOHLt8My5PbTSwhjFF6eXISOBgbk2DG/h19pV+dovo=
X-Google-Smtp-Source: AGHT+IGu7AV2g+1a36De252fFR0xcNPrjo1k8rYbx+lJBpIvj5d/fm5Zh6zPQRv4el6GZ7jSXCC8kA==
X-Received: by 2002:adf:f60d:0:b0:33c:dec9:a269 with SMTP id t13-20020adff60d000000b0033cdec9a269mr401577wrp.57.1707816674892;
        Tue, 13 Feb 2024 01:31:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBfUUc+m/zso3LmxVL3ectj0GR5TFj6O0zYCe7BNEZt/73ERjArn95DGehdmTOb9lieFNOXZrX9X8WnhABHgbk6/acXcpquEdsU7HOXeUmZz7rY9LKQawaFqddadrkjFUP1jl9kl+7zVpiGOIAzCwqB1LjAcQP3Pb97eDroOD2RxGyrQV1MnFZ8w+uPwgve4vVnjRAHVFnPFyM5HLq+OeIWvFqFouqYyK5m5BZKuj4INOIxAKk2ahGE1lT0VfyHkR4VvEmNiRhQ/edZIfP7sYxq3B4hD88v+2wzhzI+G7WvlQk6yEeHd9vaGDe3aTmYgLYQ5+NejUO//U6pRCtA/JCd4lp33p1mLYFR1MtpM0=
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f634:2e37:58a9:242a])
        by smtp.gmail.com with ESMTPSA id p16-20020adfcc90000000b0033b2497fdaesm8980897wrj.95.2024.02.13.01.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:31:14 -0800 (PST)
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
Subject: [PATCH 3/3] gpio: use rcu_dereference_protected() to make lockdep happy
Date: Tue, 13 Feb 2024 10:31:08 +0100
Message-Id: <20240213093108.13922-4-brgl@bgdev.pl>
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

Lockdep with CONFIG_PROVE_RCU enabled reports false positives about
suspicious rcu_dereference() usage. Let's silence it by using
rcu_dereference_protected().

Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202402122234.d85cca9b-lkp@intel.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 12 ++++++++----
 drivers/gpio/gpiolib.h |  4 +++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c1391a9a0af6..d7503376b918 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -109,7 +109,8 @@ const char *gpiod_get_label(struct gpio_desc *desc)
 		return "interrupt";
 
 	return test_bit(FLAG_REQUESTED, &flags) ?
-			rcu_dereference(desc->label) : NULL;
+			rcu_dereference_protected(desc->label,
+					lockdep_is_held(&desc->srcu)) : NULL;
 }
 
 static int desc_set_label(struct gpio_desc *desc, const char *label)
@@ -2978,7 +2979,8 @@ static int gpiod_get_raw_value_commit(const struct gpio_desc *desc)
 
 	guard(srcu)(&gdev->srcu);
 
-	gc = rcu_dereference(gdev->chip);
+	gc = rcu_dereference_protected(gdev->chip,
+				       lockdep_is_held(&gdev->srcu));
 	if (!gc)
 		return -ENODEV;
 
@@ -3012,7 +3014,8 @@ static bool gpio_device_chip_cmp(struct gpio_device *gdev, struct gpio_chip *gc)
 {
 	guard(srcu)(&gdev->srcu);
 
-	return gc == rcu_dereference(gdev->chip);
+	return gc == rcu_dereference_protected(gdev->chip,
+					       lockdep_is_held(&gdev->srcu));
 }
 
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
@@ -3593,7 +3596,8 @@ int gpiod_to_irq(const struct gpio_desc *desc)
 	gdev = desc->gdev;
 	/* FIXME Cannot use gpio_chip_guard due to const desc. */
 	guard(srcu)(&gdev->srcu);
-	gc = rcu_dereference(gdev->chip);
+	gc = rcu_dereference_protected(gdev->chip,
+				       lockdep_is_held(&gdev->srcu));
 	if (!gc)
 		return -ENODEV;
 
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 07443d26cbca..a857848b8955 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/gpio/consumer.h> /* for enum gpiod_flags */
 #include <linux/gpio/driver.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
 #include <linux/srcu.h>
@@ -202,7 +203,8 @@ DEFINE_CLASS(gpio_chip_guard,
 
 		_guard.gdev = desc->gdev;
 		_guard.idx = srcu_read_lock(&_guard.gdev->srcu);
-		_guard.gc = rcu_dereference(_guard.gdev->chip);
+		_guard.gc = rcu_dereference_protected(_guard.gdev->chip,
+					lockdep_is_held(&_guard.gdev->srcu));
 
 		_guard;
 	     }),
-- 
2.40.1


