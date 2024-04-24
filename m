Return-Path: <linux-kernel+bounces-156415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E118B028D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68D62853CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3932D15747D;
	Wed, 24 Apr 2024 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxYd+Lrs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F96157E79
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941625; cv=none; b=WsBRYFkF7brg3Ul7IJmbPNWLsya4/Kzdh/OfbpKm69yMx9B+UwR/vDKAtKr8jPy8gRuAEXnZeJGAqb7JhEEuJrbefcCXrOcuBxZ35cfixjqHOBioQZqAHYt0K78voezFiY/IUmb0bYmuOJxLuHnhKbXqQldWOLn2V+WNCwpvB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941625; c=relaxed/simple;
	bh=s+B8ItYGzoVn3So0dJK256cBhZJIrk8qxByoCNTGHQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Unp8+EHjARPTEqYnaxWkD8r7pYZhqNCTWdALW5b970D3PMFEy1JvPvakGSgVEG7hO1T76CBkt+e4PrlhEZWAIy59mrGIEmium9EEpemsfZoWrJGuXadR0AuGeCvwf4zquykxQHvnvpWP91u45kzZTQNxB7vIgmXrHp5S06OSpmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gxYd+Lrs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713941621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNiL/A8mDEhqkF3QERPEG//s8LAwW5c1zyzjl4us3zs=;
	b=gxYd+Lrs0Yo4yBdZVyBl3rUcwbsROij5hy99m3QOKDOLgV3f8mrbzZAIZQtrHAdug9yyj8
	OAWTRN49yW2IdPgB2pcResdPZZGbzpbXWZ5ounk2yn/EWA6plF3aCMYGSh+wLuwUdx+7kM
	Oa+QVqES0WNLJg0/wOJLJdcgjFR3Kzo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-PeAeIT9ZNXyhbIGxDSvkXg-1; Wed, 24 Apr 2024 02:53:37 -0400
X-MC-Unique: PeAeIT9ZNXyhbIGxDSvkXg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9C3D8032FA;
	Wed, 24 Apr 2024 06:53:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.73])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2A658C13FA3;
	Wed, 24 Apr 2024 06:53:29 +0000 (UTC)
From: Kate Hsuan <hpa@redhat.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: [PATCH v7 3/6] leds: core: Add led_mc_set_brightness() function
Date: Wed, 24 Apr 2024 14:52:09 +0800
Message-ID: <20240424065212.263784-4-hpa@redhat.com>
In-Reply-To: <20240424065212.263784-1-hpa@redhat.com>
References: <20240424065212.263784-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

From: Hans de Goede <hdegoede@redhat.com>

Add a new led_mc_set_brightness() function for in kernel color/brightness
changing of multi-color LEDs.

led-class-multicolor can be build as a module and led_mc_set_brightness()
will have the builtin callers, so put led_mc_set_brightness() inside
led-core instead, just like how led_set_brightness() is part of the core
and not of the led-class object.

This also adds a new LED_MULTI_COLOR led_classdev flag to allow
led_mc_set_brightness() to verify that it is operating on a multi-color
LED classdev, avoiding casting the passed in LED classdev to a multi-color
LED classdev, when it actually is not a multi-color LED.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
---
 drivers/leds/led-class-multicolor.c |  1 +
 drivers/leds/led-core.c             | 31 +++++++++++++++++++++++++++++
 include/linux/leds.h                | 20 +++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/drivers/leds/led-class-multicolor.c b/drivers/leds/led-class-multicolor.c
index ec62a4811613..df01c0e66c8b 100644
--- a/drivers/leds/led-class-multicolor.c
+++ b/drivers/leds/led-class-multicolor.c
@@ -134,6 +134,7 @@ int led_classdev_multicolor_register_ext(struct device *parent,
 		return -EINVAL;
 
 	led_cdev = &mcled_cdev->led_cdev;
+	led_cdev->flags |= LED_MULTI_COLOR;
 	mcled_cdev->led_cdev.groups = led_multicolor_groups;
 
 	return led_classdev_register_ext(parent, led_cdev, init_data);
diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index 89c9806cc97f..ef7d1c6767ca 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/led-class-multicolor.h>
 #include <linux/leds.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -362,6 +363,36 @@ int led_set_brightness_sync(struct led_classdev *led_cdev, unsigned int value)
 }
 EXPORT_SYMBOL_GPL(led_set_brightness_sync);
 
+/*
+ * This is a led-core function because just like led_set_brightness()
+ * it is used in the kernel by e.g. triggers.
+ */
+void led_mc_set_brightness(struct led_classdev *led_cdev,
+			   unsigned int *intensity_value, unsigned int num_colors,
+			   unsigned int brightness)
+{
+	struct led_classdev_mc *mcled_cdev;
+	unsigned int i;
+
+	if (!(led_cdev->flags & LED_MULTI_COLOR)) {
+		dev_err_once(led_cdev->dev, "error not a multi-color LED\n");
+		return;
+	}
+
+	mcled_cdev = lcdev_to_mccdev(led_cdev);
+	if (num_colors != mcled_cdev->num_colors) {
+		dev_err_once(led_cdev->dev, "error num_colors mismatch %u != %u\n",
+			     num_colors, mcled_cdev->num_colors);
+		return;
+	}
+
+	for (i = 0; i < mcled_cdev->num_colors; i++)
+		mcled_cdev->subled_info[i].intensity = intensity_value[i];
+
+	led_set_brightness(led_cdev, brightness);
+}
+EXPORT_SYMBOL_GPL(led_mc_set_brightness);
+
 int led_update_brightness(struct led_classdev *led_cdev)
 {
 	int ret;
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 4754b02d3a2c..fed88eb9e170 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -115,6 +115,7 @@ struct led_classdev {
 #define LED_BRIGHT_HW_CHANGED	BIT(21)
 #define LED_RETAIN_AT_SHUTDOWN	BIT(22)
 #define LED_INIT_DEFAULT_TRIGGER BIT(23)
+#define LED_MULTI_COLOR		BIT(24)
 
 	/* set_brightness_work / blink_timer flags, atomic, private. */
 	unsigned long		work_flags;
@@ -392,6 +393,25 @@ void led_set_brightness(struct led_classdev *led_cdev, unsigned int brightness);
  */
 int led_set_brightness_sync(struct led_classdev *led_cdev, unsigned int value);
 
+/**
+ * led_mc_set_brightness - set mc LED color intensity values and brightness
+ * @led_cdev: the LED to set
+ * @intensity_value: array of per color intensity values to set
+ * @num_colors: amount of entries in intensity_value array
+ * @brightness: the brightness to set the LED to
+ *
+ * Set a multi-color LED's per color intensity values and brightness.
+ * If necessary, this cancels the software blink timer. This function is
+ * guaranteed not to sleep.
+ *
+ * Calling this function on a non multi-color led_classdev or with the wrong
+ * num_colors value is an error. In this case an error will be logged once
+ * and the call will do nothing.
+ */
+void led_mc_set_brightness(struct led_classdev *led_cdev,
+			   unsigned int *intensity_value, unsigned int num_colors,
+			   unsigned int brightness);
+
 /**
  * led_update_brightness - update LED brightness
  * @led_cdev: the LED to query
-- 
2.44.0


