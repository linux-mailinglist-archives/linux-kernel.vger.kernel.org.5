Return-Path: <linux-kernel+bounces-128032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C5E895538
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC740289278
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF8485624;
	Tue,  2 Apr 2024 13:21:24 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF4480631;
	Tue,  2 Apr 2024 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064084; cv=none; b=G1izORQr+QoV/D6/tGMy63JQn52w8c3xxDVwqeLw1/9Rl06ALjFrQ/O/rbpMmwn8rLqTgrt0xVF9PQf5Ld0Wl6a/yIBrUtmZ9vGhgBY1KIbajnFOhskglxKTvQFuPP0BsY6SfAeUU9vWD6c3fJp/D8bRB8o4JitosSiQH0+t7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064084; c=relaxed/simple;
	bh=soN8FkpcgRBwdzzFH5CZlu5Cs9CmIZZdqx8WdcS451g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iT0tCtPNDNEe+L5ptvgaCt0tq1EV9pPVJZsEH0aRlfx5+Iy1Xb7sYtCP0nP+eASLMwFNbvWeXf1W+O6ynbTgXZsgvgzhOJGc39t7oqXyW//BbgjvcJ2dhAG9BScEcsR3oOm/mRPkB3DZHGX/XyfV2Wj5zkgMWxpEDdmDuqk2W9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69867.dsl.pool.telekom.hu [::ffff:81.182.152.103])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000644A9.00000000660C064A.002529D9; Tue, 02 Apr 2024 15:21:14 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
  Conor Dooley <conor+dt@kernel.org>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
  devicetree@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 3/3] platform/x86: ideapad-laptop: add FnLock LED class device
Date: Tue,  2 Apr 2024 15:21:02 +0200
Message-ID: <2db08c948568a8d5352780864956c3271b4e42ce.1712063200.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712063200.git.soyer@irl.hu>
References: <cover.1712063200.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Some Ideapad/Yoga Laptops have an FnLock LED in the Esc key.

Expose Fnlock as an LED class device for easier OSD support.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/platform/x86/ideapad-laptop.c | 97 ++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 529df08af548..8a5bef4eedfe 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -152,6 +152,11 @@ struct ideapad_private {
 		struct led_classdev led;
 		unsigned int last_brightness;
 	} kbd_bl;
+	struct {
+		bool initialized;
+		struct led_classdev led;
+		unsigned int last_brightness;
+	} fn_lock;
 };
 
 static bool no_bt_rfkill;
@@ -531,6 +536,19 @@ static int ideapad_fn_lock_set(struct ideapad_private *priv, bool state)
 		state ? SALS_FNLOCK_ON : SALS_FNLOCK_OFF);
 }
 
+static void ideapad_fn_lock_led_notify(struct ideapad_private *priv, int brightness)
+{
+	if (!priv->fn_lock.initialized)
+		return;
+
+	if (brightness == priv->fn_lock.last_brightness)
+		return;
+
+	priv->fn_lock.last_brightness = brightness;
+
+	led_classdev_notify_brightness_hw_changed(&priv->fn_lock.led, brightness);
+}
+
 static ssize_t fn_lock_show(struct device *dev,
 			    struct device_attribute *attr,
 			    char *buf)
@@ -561,6 +579,8 @@ static ssize_t fn_lock_store(struct device *dev,
 	if (err)
 		return err;
 
+	ideapad_fn_lock_led_notify(priv, state);
+
 	return count;
 }
 
@@ -1479,6 +1499,65 @@ static void ideapad_kbd_bl_exit(struct ideapad_private *priv)
 	led_classdev_unregister(&priv->kbd_bl.led);
 }
 
+/*
+ * FnLock LED
+ */
+static enum led_brightness ideapad_fn_lock_led_cdev_get(struct led_classdev *led_cdev)
+{
+	struct ideapad_private *priv = container_of(led_cdev, struct ideapad_private, fn_lock.led);
+
+	return ideapad_fn_lock_get(priv);
+}
+
+static int ideapad_fn_lock_led_cdev_set(struct led_classdev *led_cdev,
+	enum led_brightness brightness)
+{
+	struct ideapad_private *priv = container_of(led_cdev, struct ideapad_private, fn_lock.led);
+
+	return ideapad_fn_lock_set(priv, brightness);
+}
+
+static int ideapad_fn_lock_led_init(struct ideapad_private *priv)
+{
+	int brightness, err;
+
+	if (!priv->features.fn_lock)
+		return -ENODEV;
+
+	if (WARN_ON(priv->fn_lock.initialized))
+		return -EEXIST;
+
+	priv->fn_lock.led.max_brightness = 1;
+
+	brightness = ideapad_fn_lock_get(priv);
+	if (brightness < 0)
+		return brightness;
+
+	priv->fn_lock.last_brightness = brightness;
+	priv->fn_lock.led.name                    = "platform::" LED_FUNCTION_FNLOCK;
+	priv->fn_lock.led.brightness_get          = ideapad_fn_lock_led_cdev_get;
+	priv->fn_lock.led.brightness_set_blocking = ideapad_fn_lock_led_cdev_set;
+	priv->fn_lock.led.flags                   = LED_BRIGHT_HW_CHANGED;
+
+	err = led_classdev_register(&priv->platform_device->dev, &priv->fn_lock.led);
+	if (err)
+		return err;
+
+	priv->fn_lock.initialized = true;
+
+	return 0;
+}
+
+static void ideapad_fn_lock_led_exit(struct ideapad_private *priv)
+{
+	if (!priv->fn_lock.initialized)
+		return;
+
+	priv->fn_lock.initialized = false;
+
+	led_classdev_unregister(&priv->fn_lock.led);
+}
+
 /*
  * module init/exit
  */
@@ -1741,8 +1820,10 @@ static void ideapad_wmi_notify(struct wmi_device *wdev, union acpi_object *data)
 		if (priv->features.set_fn_lock_led) {
 			int brightness = ideapad_fn_lock_get(priv);
 
-			if (brightness >= 0)
+			if (brightness >= 0) {
 				ideapad_fn_lock_set(priv, brightness);
+				ideapad_fn_lock_led_notify(priv, brightness);
+			}
 		}
 
 		if (data->type != ACPI_TYPE_INTEGER) {
@@ -1754,6 +1835,10 @@ static void ideapad_wmi_notify(struct wmi_device *wdev, union acpi_object *data)
 		dev_dbg(&wdev->dev, "WMI fn-key event: 0x%llx\n",
 			data->integer.value);
 
+		/* 0x02 FnLock, 0x03 Esc */
+		if (data->integer.value == 0x02 || data->integer.value == 0x03)
+			ideapad_fn_lock_led_notify(priv, data->integer.value == 0x02);
+
 		ideapad_input_report(priv,
 				     data->integer.value | IDEAPAD_WMI_KEY);
 
@@ -1847,6 +1932,14 @@ static int ideapad_acpi_add(struct platform_device *pdev)
 			dev_info(&pdev->dev, "Keyboard backlight control not available\n");
 	}
 
+	err = ideapad_fn_lock_led_init(priv);
+	if (err) {
+		if (err != -ENODEV)
+			dev_warn(&pdev->dev, "Could not set up FnLock LED: %d\n", err);
+		else
+			dev_info(&pdev->dev, "FnLock control not available\n");
+	}
+
 	/*
 	 * On some models without a hw-switch (the yoga 2 13 at least)
 	 * VPCCMD_W_RF must be explicitly set to 1 for the wifi to work.
@@ -1903,6 +1996,7 @@ static int ideapad_acpi_add(struct platform_device *pdev)
 	for (i = 0; i < IDEAPAD_RFKILL_DEV_NUM; i++)
 		ideapad_unregister_rfkill(priv, i);
 
+	ideapad_fn_lock_led_exit(priv);
 	ideapad_kbd_bl_exit(priv);
 	ideapad_input_exit(priv);
 
@@ -1930,6 +2024,7 @@ static void ideapad_acpi_remove(struct platform_device *pdev)
 	for (i = 0; i < IDEAPAD_RFKILL_DEV_NUM; i++)
 		ideapad_unregister_rfkill(priv, i);
 
+	ideapad_fn_lock_led_exit(priv);
 	ideapad_kbd_bl_exit(priv);
 	ideapad_input_exit(priv);
 	ideapad_debugfs_exit(priv);
-- 
2.44.0


