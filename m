Return-Path: <linux-kernel+bounces-44633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0A0842553
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B761F29A83
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B528E6EB66;
	Tue, 30 Jan 2024 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Up9z677Y"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFE16D1BA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618928; cv=none; b=BvbLNddNV1DB45hpI5FGwVMAK36YxEB+7d8h4o/ycmkpEUrGPvZN98swwUPQFIUkj9qIWru1vZPocLsywg2p5SKUx4jQ1u1YUNPNIPAa9dQZG9mjCE0rBKpHikqr8kbFAHBNNS72LJPBwH8KGFNYMfJ2jbw/QUGGxTGO2J5bxYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618928; c=relaxed/simple;
	bh=vIiaPQV4MhISZ6+YFrIpM0mpk0JQM2JDosDXAuvqrK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s/IFibwNdKWyWbFNprQWDNqPX6qPgfgbDHjKR1NJpYgvRfZQH819I65/7rOEDDSacrBCasNO4IIakIIUTFaTxey3Bbb4acoTeOCtd1ONfwMlBKCWv8kw7WgG4sz5sy/ABBkN013z0TmkjczmSjQ+wb0wB9b/76yrmR5OB8hzohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Up9z677Y; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e8d3b29f2so46707425e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706618925; x=1707223725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3leJ4dG0Apw+7NhV2mNQ1kL1h73Kpd6fDKBHFrZXXJo=;
        b=Up9z677YpBnaJA7B+fph1Xo6m9cVqak6lz859Z5bO+3wO6H7zNTkNM3dFEytyOH08z
         IQVlHS21HtRpxtz1fkQfiKinqDw1O86cJgwVtSlX6UuPxF2FGXnFlbfOeup9sRIc04Ve
         RYa0RDnd+MyylDJuI3+iNsHhVDMYSwQMtuu7NaTf1f9JU3DhkP2+hEpwu8p0F6IMuT6g
         /oNougsLtXnAuRwB9KSPj3izyu56QyF7/zWSW8hVkoh4H/+37o7lAqEn2E5xjSHxCKOT
         r5696eXIO7yV+Ec7sR94m8Y0AqPtGft4xERCuUjD4xISDO1oXY+HEHqIuUBW9dsVSzH+
         gXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618925; x=1707223725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3leJ4dG0Apw+7NhV2mNQ1kL1h73Kpd6fDKBHFrZXXJo=;
        b=lhO+BmDYyVzbzFHEuZ+Dug3EUB8zl8R603pNc2w1lpMqzdWdS/d/NdAZqviPOXbTuv
         4odLD3TyePB4MnqjpBt0kwZxLH5tnFab5Fw56YaHG7qRiUMz9l+1FIigLX8yvytZifYg
         FhhkeIej43Nu+UVD4Rpk5750EcpXlTC2OeR6G0QGgVXMMJsTNvr48ijc744/ZIWFqsjc
         SqPQZuLCM5PCLsOarM67CesJ/3mzO+OTExkmoUN1blErloNsvHZiXk/jNOI9hdPZdIO/
         6WUcVjlbaZ3vQElTSVCeEZcsccsABRJboPxhPkCQ8t4sbf21aBD4SeSPJb9Yp0V11Se/
         aGqA==
X-Gm-Message-State: AOJu0Yw0iN50yZEd4Gxwy3gnuoxd/5mcn6ajV5CaNT7c5IaFPOEw2gpH
	VYqgaRInIPb7ApfF6SBE+uDlJZ5iNkoMzsPng4P4ecYX/XfRZws+xiNNgm8TvBs=
X-Google-Smtp-Source: AGHT+IHDtUNe/6MSpmaW0R4KyouNeEG3VWCoyEYN3sX2A1ul8RBxSKEEY/KgHtFmEa5DHYicGssmDg==
X-Received: by 2002:a05:600c:1906:b0:40e:b9fb:103 with SMTP id j6-20020a05600c190600b0040eb9fb0103mr6077806wmq.23.1706618925284;
        Tue, 30 Jan 2024 04:48:45 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:abc8:f77e:abeb:129c])
        by smtp.gmail.com with ESMTPSA id en8-20020a056000420800b0033940016d6esm6625337wrb.93.2024.01.30.04.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:48:44 -0800 (PST)
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
Subject: [PATCH 06/22] gpio: add SRCU infrastructure to struct gpio_desc
Date: Tue, 30 Jan 2024 13:48:12 +0100
Message-Id: <20240130124828.14678-7-brgl@bgdev.pl>
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

Extend the GPIO descriptor with an SRCU structure in order to serialize
the access to the label. Initialize and clean it up where applicable.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 18 ++++++++++++++++--
 drivers/gpio/gpiolib.h |  3 +++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4e6b26b3febb..94e1a603cf8b 100644
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
@@ -829,7 +833,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			       struct lock_class_key *request_key)
 {
 	struct gpio_device *gdev;
-	unsigned int i;
+	unsigned int i, j;
 	int base = 0;
 	int ret = 0;
 
@@ -962,6 +966,13 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	for (i = 0; i < gc->ngpio; i++) {
 		struct gpio_desc *desc = &gdev->descs[i];
 
+		ret = init_srcu_struct(&desc->srcu);
+		if (ret) {
+			for (j = 0; j < i; j++)
+				cleanup_srcu_struct(&desc->srcu);
+			goto err_remove_of_chip;
+		}
+
 		if (gc->get_direction && gpiochip_line_is_valid(gc, i)) {
 			assign_bit(FLAG_IS_OUT,
 				   &desc->flags, !gc->get_direction(gc, i));
@@ -973,7 +984,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 	ret = gpiochip_add_pin_ranges(gc);
 	if (ret)
-		goto err_remove_of_chip;
+		goto err_cleanup_desc_srcu;
 
 	acpi_gpiochip_add(gc);
 
@@ -1012,6 +1023,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
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


