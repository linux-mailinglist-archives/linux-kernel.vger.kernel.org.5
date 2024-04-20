Return-Path: <linux-kernel+bounces-152370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 805258ABD06
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 22:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AC628160A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CCC46439;
	Sat, 20 Apr 2024 20:07:38 +0000 (UTC)
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550ED374F7;
	Sat, 20 Apr 2024 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713643657; cv=none; b=vDjbuslxXaL1qvoPU3wJZAIftTSAnL7UNHUtzGnUavanwbYy+xUg+DzzcPcTOJ8Qw7ZrgflZo+n/GoGMBVm3PYHTUZcEvqQTH1HEVjqNzvPJ2KHk3voLiSoeUlrBpgRrSoikkTZtYMZudgfWLf4lpMtV6vBKA6uSf3FzpQcP6EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713643657; c=relaxed/simple;
	bh=N2bafYYP+b4kw+NKMOsMMvGGjOuIQlEGeTYftOJBCZI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=tTpcRCUH0nok4yFmBvxOBwMSjB0N0rpdhbWKJZYWyJozqPM9e2iPkCf06Pe+tfPA9b53g9KuHrJ31f/5e7+19aqYXk5ZhrRTbEBTjBWfs3yDZcqcFsxqErKC/769LqySr4Bz4pbNzo5omTk65EWmMO5UjecGX6fF+oXphM2HW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id ED4D01003D027;
	Sat, 20 Apr 2024 22:07:32 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C669A1D3F8; Sat, 20 Apr 2024 22:07:32 +0200 (CEST)
Message-ID: <3ae8c9a73fbb291c1c863777af175c657a2a10e9.1713608122.git.lukas@wunner.de>
In-Reply-To: <cover.1713608122.git.lukas@wunner.de>
References: <cover.1713608122.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 20 Apr 2024 22:00:05 +0200
Subject: [PATCH 5/6] platform/x86: Use device_show_string() helper for sysfs
 attributes
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Cc: Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>, "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, Azael Avalos <coproscefalo@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "Ilpo Jaervinen" <ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Deduplicate sysfs ->show() callbacks which expose a string at a static
memory location.  Use the newly introduced device_show_string() helper
in the driver core instead by declaring those sysfs attributes with
DEVICE_STRING_ATTR_RO().

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/platform/x86/asus-wmi.c      | 62 +++++++---------------------
 drivers/platform/x86/thinkpad_acpi.c | 10 +----
 drivers/platform/x86/toshiba_acpi.c  |  9 +---
 3 files changed, 20 insertions(+), 61 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 3f07bbf809ef..78d7579b2fdd 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -915,17 +915,12 @@ static ssize_t kbd_rgb_mode_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(kbd_rgb_mode);
 
-static ssize_t kbd_rgb_mode_index_show(struct device *device,
-						 struct device_attribute *attr,
-						 char *buf)
-{
-	return sysfs_emit(buf, "%s\n", "cmd mode red green blue speed");
-}
-static DEVICE_ATTR_RO(kbd_rgb_mode_index);
+static DEVICE_STRING_ATTR_RO(kbd_rgb_mode_index, 0444,
+			     "cmd mode red green blue speed");
 
 static struct attribute *kbd_rgb_mode_attrs[] = {
 	&dev_attr_kbd_rgb_mode.attr,
-	&dev_attr_kbd_rgb_mode_index.attr,
+	&dev_attr_kbd_rgb_mode_index.attr.attr,
 	NULL,
 };
 
@@ -967,17 +962,12 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(kbd_rgb_state);
 
-static ssize_t kbd_rgb_state_index_show(struct device *device,
-						 struct device_attribute *attr,
-						 char *buf)
-{
-	return sysfs_emit(buf, "%s\n", "cmd boot awake sleep keyboard");
-}
-static DEVICE_ATTR_RO(kbd_rgb_state_index);
+static DEVICE_STRING_ATTR_RO(kbd_rgb_state_index, 0444,
+			     "cmd boot awake sleep keyboard");
 
 static struct attribute *kbd_rgb_state_attrs[] = {
 	&dev_attr_kbd_rgb_state.attr,
-	&dev_attr_kbd_rgb_state_index.attr,
+	&dev_attr_kbd_rgb_state_index.attr.attr,
 	NULL,
 };
 
@@ -2493,13 +2483,6 @@ static ssize_t pwm1_enable_store(struct device *dev,
 	return count;
 }
 
-static ssize_t fan1_label_show(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf)
-{
-	return sysfs_emit(buf, "%s\n", ASUS_FAN_DESC);
-}
-
 static ssize_t asus_hwmon_temp1(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
@@ -2534,13 +2517,6 @@ static ssize_t fan2_input_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", value * 100);
 }
 
-static ssize_t fan2_label_show(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf)
-{
-	return sysfs_emit(buf, "%s\n", ASUS_GPU_FAN_DESC);
-}
-
 /* Middle/Center fan on modern ROG laptops */
 static ssize_t fan3_input_show(struct device *dev,
 					struct device_attribute *attr,
@@ -2559,13 +2535,6 @@ static ssize_t fan3_input_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", value * 100);
 }
 
-static ssize_t fan3_label_show(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf)
-{
-	return sysfs_emit(buf, "%s\n", ASUS_MID_FAN_DESC);
-}
-
 static ssize_t pwm2_enable_show(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
@@ -2662,15 +2631,16 @@ static ssize_t pwm3_enable_store(struct device *dev,
 static DEVICE_ATTR_RW(pwm1);
 static DEVICE_ATTR_RW(pwm1_enable);
 static DEVICE_ATTR_RO(fan1_input);
-static DEVICE_ATTR_RO(fan1_label);
+static DEVICE_STRING_ATTR_RO(fan1_label, 0444, ASUS_FAN_DESC);
+
 /* Fan2 - GPU fan */
 static DEVICE_ATTR_RW(pwm2_enable);
 static DEVICE_ATTR_RO(fan2_input);
-static DEVICE_ATTR_RO(fan2_label);
+static DEVICE_STRING_ATTR_RO(fan2_label, 0444, ASUS_GPU_FAN_DESC);
 /* Fan3 - Middle/center fan */
 static DEVICE_ATTR_RW(pwm3_enable);
 static DEVICE_ATTR_RO(fan3_input);
-static DEVICE_ATTR_RO(fan3_label);
+static DEVICE_STRING_ATTR_RO(fan3_label, 0444, ASUS_MID_FAN_DESC);
 
 /* Temperature */
 static DEVICE_ATTR(temp1_input, S_IRUGO, asus_hwmon_temp1, NULL);
@@ -2681,11 +2651,11 @@ static struct attribute *hwmon_attributes[] = {
 	&dev_attr_pwm2_enable.attr,
 	&dev_attr_pwm3_enable.attr,
 	&dev_attr_fan1_input.attr,
-	&dev_attr_fan1_label.attr,
+	&dev_attr_fan1_label.attr.attr,
 	&dev_attr_fan2_input.attr,
-	&dev_attr_fan2_label.attr,
+	&dev_attr_fan2_label.attr.attr,
 	&dev_attr_fan3_input.attr,
-	&dev_attr_fan3_label.attr,
+	&dev_attr_fan3_label.attr.attr,
 
 	&dev_attr_temp1_input.attr,
 	NULL
@@ -2702,17 +2672,17 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 		if (asus->fan_type != FAN_TYPE_AGFN)
 			return 0;
 	} else if (attr == &dev_attr_fan1_input.attr
-	    || attr == &dev_attr_fan1_label.attr
+	    || attr == &dev_attr_fan1_label.attr.attr
 	    || attr == &dev_attr_pwm1_enable.attr) {
 		if (asus->fan_type == FAN_TYPE_NONE)
 			return 0;
 	} else if (attr == &dev_attr_fan2_input.attr
-	    || attr == &dev_attr_fan2_label.attr
+	    || attr == &dev_attr_fan2_label.attr.attr
 	    || attr == &dev_attr_pwm2_enable.attr) {
 		if (asus->gpu_fan_type == FAN_TYPE_NONE)
 			return 0;
 	} else if (attr == &dev_attr_fan3_input.attr
-	    || attr == &dev_attr_fan3_label.attr
+	    || attr == &dev_attr_fan3_label.attr.attr
 	    || attr == &dev_attr_pwm3_enable.attr) {
 		if (asus->mid_fan_type == FAN_TYPE_NONE)
 			return 0;
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 82429e59999d..47a64a213d14 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10991,13 +10991,7 @@ static struct ibm_struct auxmac_data = {
 	.name = "auxmac",
 };
 
-static ssize_t auxmac_show(struct device *dev,
-			   struct device_attribute *attr,
-			   char *buf)
-{
-	return sysfs_emit(buf, "%s\n", auxmac);
-}
-static DEVICE_ATTR_RO(auxmac);
+static DEVICE_STRING_ATTR_RO(auxmac, 0444, auxmac);
 
 static umode_t auxmac_attr_is_visible(struct kobject *kobj,
 				      struct attribute *attr, int n)
@@ -11006,7 +11000,7 @@ static umode_t auxmac_attr_is_visible(struct kobject *kobj,
 }
 
 static struct attribute *auxmac_attributes[] = {
-	&dev_attr_auxmac.attr,
+	&dev_attr_auxmac.attr.attr,
 	NULL
 };
 
diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 291f14ef6702..01cf60a015bf 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -1814,12 +1814,7 @@ static DECLARE_WORK(kbd_bl_work, toshiba_acpi_kbd_bl_work);
 /*
  * Sysfs files
  */
-static ssize_t version_show(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%s\n", TOSHIBA_ACPI_VERSION);
-}
-static DEVICE_ATTR_RO(version);
+static DEVICE_STRING_ATTR_RO(version, 0444, TOSHIBA_ACPI_VERSION);
 
 static ssize_t fan_store(struct device *dev,
 			 struct device_attribute *attr,
@@ -2428,7 +2423,7 @@ static ssize_t cooling_method_store(struct device *dev,
 static DEVICE_ATTR_RW(cooling_method);
 
 static struct attribute *toshiba_attributes[] = {
-	&dev_attr_version.attr,
+	&dev_attr_version.attr.attr,
 	&dev_attr_fan.attr,
 	&dev_attr_kbd_backlight_mode.attr,
 	&dev_attr_kbd_type.attr,
-- 
2.43.0


