Return-Path: <linux-kernel+bounces-57795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA1E84DD81
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40B31C26E55
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A526F09C;
	Thu,  8 Feb 2024 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tylBFRuz"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7386E2DB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386375; cv=none; b=Fo5vuk3f3CxWNVZ2bhBmh1aHw8Bm6nTbAlDNpHsvkpZwGmGTC8AaQtZJrpLuJmMAEkxhBDQYL4mvPhqKp2YslaDciqHeshYNuz8/AsXmXuGEvVjW/CQ89aN+2BhjvxE00ZsIK5cU4Abfu+l4liiEMr2/Qc6wKT/6ttRnIGODYiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386375; c=relaxed/simple;
	bh=mlwjr0aacGOVjyJQQ9hj6Ih/Pg/kHJfwwqJwE2q8KBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BpGAsXFtUuZCH+mX3af3xUK7xGzuUqMa6I8KzA9MgMaubrN+g/cMjGr2V365ySzxy6nJZI391FkEBYJqeNxkjbC1hQ5uWxoBoDze7bNVuyBDJAtDF+ZXGB3grr+QvC1B1gP4AXOOVGAX0qXIIzg7/i/x5ZzMepEy0aWBkqxH+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tylBFRuz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ef3f351d2so3722035e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386372; x=1707991172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qtGEKl9eZhP9SS39ifvqdCChUOXpZpW+8/W/M5yqYc=;
        b=tylBFRuzHSbUWsTv0e9E9FNZvWie+J0Srf1fJ3/RWJ2I8+Piz5q9QW2uMYDyn+gn4N
         13hN6cfpwv0inlzzOKb+CTp0Yc2xkdJOcHxEgWblRleTtsB2WWYPIq/ViA8zQZI/D/E+
         qOVutYFCnmz7PopXmLXscCfizKea6RkjIu7PI7SEk3Gi2j0O9Nta/6QAzsH/kUqAmckd
         8sUuUlwdpIk5cSoYruLbRHzoaAgNCOmTcZSoUFS7TUSv46PZsMW3ipclOeVrv47cNk/z
         JpRHvJYvVzKMCbRNQKqGzIu3+DOsZmqkfXB/73MwYGHFtcTacoHT8G5kqT6AgN3iCOM4
         VGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386372; x=1707991172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qtGEKl9eZhP9SS39ifvqdCChUOXpZpW+8/W/M5yqYc=;
        b=atZyfG7DyFzWysmRgQT+cAmUnN5dpku7mcdLIsliNCLOeOMNXk7iz8oIZLrK5OX3xB
         pxkLvAPS/lajfMeiSiLMUSWzxY7IRXmy1jkEO7JFmJbHgiEjAQpyVFBe6eV5mbi/ylUF
         DhMySVJqg2uLO9a8WpT0Iuk3MW9pERsd9AiPYBRg7MU1cZi+NvEBLXIiul4DKK1HW6ZR
         gwGKR7G43hrYfG647lvi9tcL48w8fLoIsBqPVhQZDy1T9kEqj4cXHWZfsbi1JbsyrOUf
         Izbjri0l9SoO5L+A/1I2zb041YFK/RimvQLZfZ9zHlssGnQcTiFNnhZduRPoBynb9etz
         n9kw==
X-Forwarded-Encrypted: i=1; AJvYcCVrDTkdckQP1U373CoDX+DLvv473kafhoWoFD4bS3pl5sj9wN0ZJotVYdhQoaZL1FuTjQhsnVgdUv0tozMFhJAoTMZv/OAKGJ2X7Xq6
X-Gm-Message-State: AOJu0Yycd96qj8WKJUa4RjOzOChFjWGj3IqOg7JMBEf+Qv/GaPe+pb+c
	RtQ/5zvc4KRfa8PH0y9sWiGc4vmt+9RMfdAmiCzP8c0/45k3T9NRa6zMc6ZmFcI=
X-Google-Smtp-Source: AGHT+IF7xF1sC1zEruEl91ExQYdoLugNN6uIujhqm6wWGiVrarrH3BqhqlibKBwtT7ck2eBr9xIv7Q==
X-Received: by 2002:a05:600c:519a:b0:410:1d09:10be with SMTP id fa26-20020a05600c519a00b004101d0910bemr1767956wmb.8.1707386372069;
        Thu, 08 Feb 2024 01:59:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3SpTRg+/wyeLk3YyvoNnZTfqs3AZl025KQLmo/ZdCl5S+qlFwDXk5yPhWn29Jks9DaHl2xGg2rCb1mAML2RCd12SPU5nFup02EGJJWEzzOCjKl43uLj4sGdTiI7bWCogDEl5AnUHYucjWeVsnTKbHjEixrlf5/BqZz5Nrc+o5NBpoWJVdX+QS3ogZQnqcW6r0xU1GI538oz+0B4JsDgz4JrHCAIy4RN2mryIk1mE8f4PJzLwORKTgcWdglqS9NJ7Z9DJaHJ+EqcSROwVAFNTfLE+tPZMKDonuuStdtggQYfIaIdl9CCzLdnHZs0xvv4oinXrrcGhGaNOHbK5fNOZQfyfwVJjVHw==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:31 -0800 (PST)
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
Subject: [PATCH v3 06/24] gpio: add SRCU infrastructure to struct gpio_desc
Date: Thu,  8 Feb 2024 10:59:02 +0100
Message-Id: <20240208095920.8035-7-brgl@bgdev.pl>
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

Extend the GPIO descriptor with an SRCU structure in order to serialize
the access to the label. Initialize and clean it up where applicable.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 18 ++++++++++++++++--
 drivers/gpio/gpiolib.h |  3 +++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index fbfddc9860fd..b26d39bc3389 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -672,6 +672,10 @@ EXPORT_SYMBOL_GPL(gpiochip_line_is_valid);
 static void gpiodev_release(struct device *dev)
 {
 	struct gpio_device *gdev = to_gpio_device(dev);
+	unsigned int i;
+
+	for (i = 0; i < gdev->ngpio; i++)
+		cleanup_srcu_struct(&gdev->descs[i].srcu);
 
 	ida_free(&gpio_ida, gdev->id);
 	kfree_const(gdev->label);
@@ -836,7 +840,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			       struct lock_class_key *request_key)
 {
 	struct gpio_device *gdev;
-	unsigned int i;
+	unsigned int i, j;
 	int base = 0;
 	int ret = 0;
 
@@ -970,6 +974,13 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	for (i = 0; i < gc->ngpio; i++) {
 		struct gpio_desc *desc = &gdev->descs[i];
 
+		ret = init_srcu_struct(&desc->srcu);
+		if (ret) {
+			for (j = 0; j < i; j++)
+				cleanup_srcu_struct(&gdev->descs[j].srcu);
+			goto err_remove_of_chip;
+		}
+
 		if (gc->get_direction && gpiochip_line_is_valid(gc, i)) {
 			assign_bit(FLAG_IS_OUT,
 				   &desc->flags, !gc->get_direction(gc, i));
@@ -981,7 +992,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 	ret = gpiochip_add_pin_ranges(gc);
 	if (ret)
-		goto err_remove_of_chip;
+		goto err_cleanup_desc_srcu;
 
 	acpi_gpiochip_add(gc);
 
@@ -1020,6 +1031,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gpiochip_irqchip_free_valid_mask(gc);
 err_remove_acpi_chip:
 	acpi_gpiochip_remove(gc);
+err_cleanup_desc_srcu:
+	for (i = 0; i < gdev->ngpio; i++)
+		cleanup_srcu_struct(&gdev->descs[i].srcu);
 err_remove_of_chip:
 	gpiochip_free_hogs(gc);
 	of_gpiochip_remove(gc);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 1058f326fe2b..6e14b629c48b 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/notifier.h>
 #include <linux/rwsem.h>
+#include <linux/srcu.h>
 
 #define GPIOCHIP_NAME	"gpiochip"
 
@@ -147,6 +148,7 @@ void gpiod_line_state_notify(struct gpio_desc *desc, unsigned long action);
  * @label:		Name of the consumer
  * @name:		Line name
  * @hog:		Pointer to the device node that hogs this line (if any)
+ * @srcu:		SRCU struct protecting the label pointer.
  *
  * These are obtained using gpiod_get() and are preferable to the old
  * integer-based handles.
@@ -184,6 +186,7 @@ struct gpio_desc {
 #ifdef CONFIG_OF_DYNAMIC
 	struct device_node	*hog;
 #endif
+	struct srcu_struct	srcu;
 };
 
 #define gpiod_not_found(desc)		(IS_ERR(desc) && PTR_ERR(desc) == -ENOENT)
-- 
2.40.1


