Return-Path: <linux-kernel+bounces-52405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 716F48497AA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3101F2112B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779D2171A4;
	Mon,  5 Feb 2024 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pXBbcU1t"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD1168D7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128554; cv=none; b=Gmxe3OIiT8iTUo//fchK7L5pyn9ujByUWyCVwHtdQIac99BrOIpffXHZtPw/eCFi0oM0hCB943CjNNcyBSNf1UISN/HSu6snENx1x1f6sFDuCWn+ayvngMsAJIwNM/Ozwe3kMQ346VkdhBSDGw70wRma6XN2MF0AebJl8r48fSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128554; c=relaxed/simple;
	bh=XQFHQAy3ghz/oY8YrhiC5FeoWgHjjSFto3B6DYb1uTc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dtpRSGJizgf2U7aCbi+3cm7koEpLH/1LiNO1MAdOnrpC+oCnDnEytZaHGKlWBBvON2xmoaBs+qjPzqmEY+zefDp1ev2awkivX3X0Jv2vC5952PXtseQ+PyIkAkqfDVgExehNGO591kFYClmIBExRtMplrpNw2oZgKWRbSiQYkv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pXBbcU1t; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso34791985e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 02:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707128551; x=1707733351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nh3ag7/b079PDR25gLSSEiCZjsjzGkwvuNbtbymbZQU=;
        b=pXBbcU1t/iYrCUWh4sZVKalWP9hCcJ3ssI1ljAG0BUTVnT9MHDymwJhWwFlitPbp03
         R17rXCBcB5GXGeS7JDEEBkAXtzBAYlFlcwIII3XG+/9WtoJkuMFJ4WVZnyhcfR8rrOwD
         DEhrzPInLEfnq/xIp4btGeHqK8hzwcPrEs1j1abNU1kY4JDwD0GJBJ+LuxdQWaXKP8Vp
         sUe133n1wS+vnlYBG+6BhDxzoHT9tee5/GzqY2ekXKEpgxyBc6s1krCUmn1eYXzNa3co
         osq2x9+S9tMmAQFrXO9TSGH+iDwaniAwKeYuoqOWlDu5WyDgbAiBqBj0klZL8sJpsxDe
         HBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707128551; x=1707733351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nh3ag7/b079PDR25gLSSEiCZjsjzGkwvuNbtbymbZQU=;
        b=Pf+uRMR+lw65SY2qI1mdElMaAxAhuWuKIYGvo4rwFzQt4Hmlbmij4qVNpvZdUSI/6i
         rB8cJIO6+m8VrDyBKBxTnhauFg47I9oOa0Z2dcxAlu+vuWX6fWL7t0YyhAEmFJGRTUJR
         EzMYhoevaKjd6W6u3wKo2WDUX7AbvHwmB/p8l53RgxQpP/olMZgdZ1oQnAt7rx9Z2YpZ
         B5WZc1/yri2nPMIA7/ieepB4AG7l0CPl0VjUhnP55j5427WhqJjUet+lHsJvPuBbLvTJ
         GRB4cLpokju0zc6SPJStTBM3lv2AM/Br2Q5EbFfr9/k/jvN+f6erBwWfONtlkvEFF1Cj
         ElVg==
X-Gm-Message-State: AOJu0YwGVUbV8PDfqq2QOq9ojafm6KPGWgDKjQAh9x3yZiBfPP4PBqMk
	/wN55RhCT5vijzyyznM0hCtUE1QqJuer5BGsvAu+pvBAHiPCi4SN29XcBk3em6g=
X-Google-Smtp-Source: AGHT+IEWTkkzFApDuOQaRlyxx+mqNV7F77qhWxhdcVAS21O2eADNQV04LXT9BAXP63xdqM3pU1aCTA==
X-Received: by 2002:a05:6000:128c:b0:33b:38ce:9e13 with SMTP id f12-20020a056000128c00b0033b38ce9e13mr2184212wrx.41.1707128551408;
        Mon, 05 Feb 2024 02:22:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVorJWZf/Rvh+vcTsNO3vi+G8XRadLeKdvf7sqiWpW+/xL2+VyyEaXmuh+spSb0imLes4frjJkHSJORhs/rpAzc1y4kZPkTi50H07SrwwZ08XBGpj1d3Dcs6S1RlaCcgoFgsl/y8wUbe3MIgPU=
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d929:10db:5b5c:b49d])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d4c8b000000b0033b3d726d41sm1657392wrs.104.2024.02.05.02.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:22:31 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: remove GPIO device from the list unconditionally in error path
Date: Mon,  5 Feb 2024 11:22:29 +0100
Message-Id: <20240205102229.42460-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Since commit 48e1b4d369cf ("gpiolib: remove the GPIO device from the list
when it's unregistered") we remove the GPIO device entry from the global
list (used to order devices by their GPIO ranges) when unregistering the
chip, not when releasing the device. It will not happen when the last
reference is put anymore. This means, we need to remove it in error path
in gpiochip_add_data_with_key() unconditionally, without checking if the
device's .release() callback is set.

Fixes: 48e1b4d369cf ("gpiolib: remove the GPIO device from the list when it's unregistered")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d50a786f8176..d52b340562ce 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1005,15 +1005,15 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 err_free_gpiochip_mask:
 	gpiochip_remove_pin_ranges(gc);
 	gpiochip_free_valid_mask(gc);
+err_remove_from_list:
+	spin_lock_irqsave(&gpio_lock, flags);
+	list_del(&gdev->list);
+	spin_unlock_irqrestore(&gpio_lock, flags);
 	if (gdev->dev.release) {
 		/* release() has been registered by gpiochip_setup_dev() */
 		gpio_device_put(gdev);
 		goto err_print_message;
 	}
-err_remove_from_list:
-	spin_lock_irqsave(&gpio_lock, flags);
-	list_del(&gdev->list);
-	spin_unlock_irqrestore(&gpio_lock, flags);
 err_free_label:
 	kfree_const(gdev->label);
 err_free_descs:
-- 
2.40.1


