Return-Path: <linux-kernel+bounces-65074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCA885477C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B651C28A728
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B96318021;
	Wed, 14 Feb 2024 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="aqzg1vpt"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE71A29A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907513; cv=none; b=PVJATw5sGyvy2eKixOFMZa6GkA2FFYz+p2Lo0fVPIJadpS81OnBzqfbxGn5MUuqidL8euLHgoSKlq9/qj6ePkRaSZXY/nRjbiSPmsAeJmMA+RFhOLiTaW+JoX30tBdsCoJFiStTtJHAjA2eVbry2rIM1Rk/RgSg2iLNUAbpkI8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907513; c=relaxed/simple;
	bh=WdQFa2ePJ6/QoxeNCFbUr5gtPyRyjF5Kjt+3Q2HEPXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aEaGEkrvqrJaPRXf1+der596Jsn7LuvjPTpxAvqWb9DPwVI5Sg3Dz9om/ssLdKny+flfRn3RwOQFa5yjZ/4Dkry8R18aL41jQJiTU5Za5SPKyAq7xyYDraQNKjhQjeTdknyDOWqnocNge/r05nWPm2O/fPzxoeLkL+XIXavuTG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=aqzg1vpt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40efcb37373so42027865e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 02:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707907509; x=1708512309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C/5fTN37ykfJWG/a6PN4F37MkWi8mM5N7iPK0vS9DcU=;
        b=aqzg1vpt1bp5KpyAs6KgEAZiD/M2hENKQKIKI7Jwms3tKr4tysr3k5qGYOB47wlmN9
         MCw2u5FtVczRvg85f293CYF0fr7A0+rXLDuy6SRmb+sDv1xFi0ZLKxW6DDCjTp9X5Jzq
         9M6PUOsDQ/gxMP/XJoJDdMELSI/6vxCNHuB7g7an9ceI5GoOHv4Z0M6iK6OHMUmusE4b
         WetrvSus+vcsmiJWNRXGMLOEesa9gt23oFc1pIDki3yqYY/qZsU1dKYtBOcNyO5gzLZk
         ttE+005wG/m620GfqYhZtA9rlqWhBbg4BqZGxEMwGMkiFfGTfgX+MlwkYzA9WrmoDXSC
         SQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707907509; x=1708512309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/5fTN37ykfJWG/a6PN4F37MkWi8mM5N7iPK0vS9DcU=;
        b=JmxBE/mI8bDWUxG8+JRzE2p5fUBkTL7vCRdv7Df2dq2y5MfABDjzFIHhU0lR50l0mE
         kJMHYjQfOjSmdcwLJZa1/etbMwozZn/NnGV/hCGPaP37dfCC9+tyJUwmGsDZGF5tgPrH
         3f8wIKVmMizeKyFXxjT4jrr/uG9tmaL5ZwEoaPquMKweNt978VsceLEgj5PILDTjhvpy
         JEN8GfzVJAp48QMzx/bro5NhrfHhIj/Zuc3wy/StJm9gQHaONJ4Mm2De+GJ/slXFQ0b5
         GwkkLcwpTVe1h2A4EkxO+rlDL1ksCX8A6w73Str9K8LWnJIr2/SF9m5c0oM9CLn2OJil
         FmBg==
X-Forwarded-Encrypted: i=1; AJvYcCW7FVOyFHhrD12kdBvcZky2pPiqjiVmH8A0CFI/FGrPvyYX+kdbt13ftwOkH/fdq34PH+20/skhOXvw1skaqVfNAc2wQ91v3q2D3woc
X-Gm-Message-State: AOJu0YxJ0VJsbnvyq7nwOltdq1V0jowQCcJM8zGg+kgQ7SOUKojrkfYX
	KHkky0mIOeEZxdBr2QeImY3+/OxLa9Yko/4SD9k8l34m2/9cyhzhGum470UbAH0=
X-Google-Smtp-Source: AGHT+IGiKEvsl9augwO+cMFc4o0rMudVgy8PYQw0HqO3klGgmCZH48BaRj0Cukr0QQgUs3yQI7rmgg==
X-Received: by 2002:a05:600c:474f:b0:411:ddc2:28b2 with SMTP id w15-20020a05600c474f00b00411ddc228b2mr1639794wmo.27.1707907509268;
        Wed, 14 Feb 2024 02:45:09 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:cfee:a5b6:1f9b:9c9b])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b00411e1574f7fsm1528662wmj.44.2024.02.14.02.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 02:45:08 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: sim: add lockdep asserts
Date: Wed, 14 Feb 2024 11:45:06 +0100
Message-Id: <20240214104506.16771-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We have three functions in gpio-sim that are called with the device lock
already held. We use the "_unlocked" suffix in their names to indicate
that. This has proven to be confusing though as the naming convention in
the kernel varies between using "_locked" or "_unlocked" for this
purpose. Naming convention also doesn't enforce anything. Let's remove
the suffix and add lockdep annotation at the top of these functions.

This makes it clear the function requires a lock to be held (and which
one specifically!) as well as results in a warning if it's not the case.
The only place where the information is lost is the place where the
function is called but the caller doesn't care about that information
anyway.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sim.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index c4106e37e6db..db42dc5616e4 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -22,6 +22,7 @@
 #include <linux/irq_sim.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -697,8 +698,10 @@ static struct gpio_sim_device *gpio_sim_hog_get_device(struct gpio_sim_hog *hog)
 	return gpio_sim_line_get_device(line);
 }
 
-static bool gpio_sim_device_is_live_unlocked(struct gpio_sim_device *dev)
+static bool gpio_sim_device_is_live(struct gpio_sim_device *dev)
 {
+	lockdep_assert_held(&dev->lock);
+
 	return !!dev->pdev;
 }
 
@@ -737,7 +740,7 @@ gpio_sim_device_config_live_show(struct config_item *item, char *page)
 	bool live;
 
 	scoped_guard(mutex, &dev->lock)
-		live = gpio_sim_device_is_live_unlocked(dev);
+		live = gpio_sim_device_is_live(dev);
 
 	return sprintf(page, "%c\n", live ? '1' : '0');
 }
@@ -926,7 +929,7 @@ static bool gpio_sim_bank_labels_non_unique(struct gpio_sim_device *dev)
 	return false;
 }
 
-static int gpio_sim_device_activate_unlocked(struct gpio_sim_device *dev)
+static int gpio_sim_device_activate(struct gpio_sim_device *dev)
 {
 	struct platform_device_info pdevinfo;
 	struct fwnode_handle *swnode;
@@ -934,6 +937,8 @@ static int gpio_sim_device_activate_unlocked(struct gpio_sim_device *dev)
 	struct gpio_sim_bank *bank;
 	int ret;
 
+	lockdep_assert_held(&dev->lock);
+
 	if (list_empty(&dev->bank_list))
 		return -ENODATA;
 
@@ -998,10 +1003,12 @@ static int gpio_sim_device_activate_unlocked(struct gpio_sim_device *dev)
 	return 0;
 }
 
-static void gpio_sim_device_deactivate_unlocked(struct gpio_sim_device *dev)
+static void gpio_sim_device_deactivate(struct gpio_sim_device *dev)
 {
 	struct fwnode_handle *swnode;
 
+	lockdep_assert_held(&dev->lock);
+
 	swnode = dev_fwnode(&dev->pdev->dev);
 	platform_device_unregister(dev->pdev);
 	gpio_sim_remove_hogs(dev);
@@ -1023,12 +1030,12 @@ gpio_sim_device_config_live_store(struct config_item *item,
 
 	guard(mutex)(&dev->lock);
 
-	if (live == gpio_sim_device_is_live_unlocked(dev))
+	if (live == gpio_sim_device_is_live(dev))
 		ret = -EPERM;
 	else if (live)
-		ret = gpio_sim_device_activate_unlocked(dev);
+		ret = gpio_sim_device_activate(dev);
 	else
-		gpio_sim_device_deactivate_unlocked(dev);
+		gpio_sim_device_deactivate(dev);
 
 	return ret ?: count;
 }
@@ -1069,7 +1076,7 @@ static ssize_t gpio_sim_bank_config_chip_name_show(struct config_item *item,
 
 	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev))
+	if (gpio_sim_device_is_live(dev))
 		return device_for_each_child(&dev->pdev->dev, &ctx,
 					     gpio_sim_emit_chip_name);
 
@@ -1098,7 +1105,7 @@ static ssize_t gpio_sim_bank_config_label_store(struct config_item *item,
 
 	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev))
+	if (gpio_sim_device_is_live(dev))
 		return -EBUSY;
 
 	trimmed = gpio_sim_strdup_trimmed(page, count);
@@ -1142,7 +1149,7 @@ gpio_sim_bank_config_num_lines_store(struct config_item *item,
 
 	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev))
+	if (gpio_sim_device_is_live(dev))
 		return -EBUSY;
 
 	bank->num_lines = num_lines;
@@ -1179,7 +1186,7 @@ static ssize_t gpio_sim_line_config_name_store(struct config_item *item,
 
 	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev))
+	if (gpio_sim_device_is_live(dev))
 		return -EBUSY;
 
 	trimmed = gpio_sim_strdup_trimmed(page, count);
@@ -1219,7 +1226,7 @@ static ssize_t gpio_sim_hog_config_name_store(struct config_item *item,
 
 	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev))
+	if (gpio_sim_device_is_live(dev))
 		return -EBUSY;
 
 	trimmed = gpio_sim_strdup_trimmed(page, count);
@@ -1274,7 +1281,7 @@ gpio_sim_hog_config_direction_store(struct config_item *item,
 
 	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev))
+	if (gpio_sim_device_is_live(dev))
 		return -EBUSY;
 
 	if (sysfs_streq(page, "input"))
@@ -1392,7 +1399,7 @@ gpio_sim_bank_config_make_line_group(struct config_group *group,
 
 	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev))
+	if (gpio_sim_device_is_live(dev))
 		return ERR_PTR(-EBUSY);
 
 	line = kzalloc(sizeof(*line), GFP_KERNEL);
@@ -1445,7 +1452,7 @@ gpio_sim_device_config_make_bank_group(struct config_group *group,
 
 	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev))
+	if (gpio_sim_device_is_live(dev))
 		return ERR_PTR(-EBUSY);
 
 	bank = kzalloc(sizeof(*bank), GFP_KERNEL);
@@ -1467,8 +1474,8 @@ static void gpio_sim_device_config_group_release(struct config_item *item)
 	struct gpio_sim_device *dev = to_gpio_sim_device(item);
 
 	scoped_guard(mutex, &dev->lock) {
-		if (gpio_sim_device_is_live_unlocked(dev))
-			gpio_sim_device_deactivate_unlocked(dev);
+		if (gpio_sim_device_is_live(dev))
+			gpio_sim_device_deactivate(dev);
 	}
 
 	mutex_destroy(&dev->lock);
-- 
2.40.1


