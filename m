Return-Path: <linux-kernel+bounces-128031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB3E895537
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8099C1C21CDA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B331885278;
	Tue,  2 Apr 2024 13:21:24 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7657F7D9;
	Tue,  2 Apr 2024 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064084; cv=none; b=ZDtraJqwt9ONd178zcHSNY14m9okod0IxrZen7vS+Xg1NBhj1hW5TujaJ/h0I8DPF2g+aTExe4q1i9SlwacUwNZoD5z/6SbA9CelwEJB10VymYcde9KRbnhxqYCLeyscQa5bUX3Z1BuhqJ80HNZCeEqixzb+Wc/fGXGXHhsFlUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064084; c=relaxed/simple;
	bh=eqOnowuBwudlc18x7RPtSFiahPlp8fewD9/UlPbj0Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nGfYO9MvYYiZzbQK3gPFn6QkSCOM+uiT+S+IbyZ/mKvCchjohID+hVI89pw8Rlsxj9vHsvyl5vpizPBKhVch+Vy1GZGvD/4sU9xOqsQpX+6swppUDgMxoIWoBtuJQxxe1GbExvkrUD+d7WLqsRIVBwuwUX35x+dlgcaDdqpxXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69867.dsl.pool.telekom.hu [::ffff:81.182.152.103])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000064405.00000000660C064A.002529C9; Tue, 02 Apr 2024 15:21:13 +0200
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
Subject: [PATCH 2/3] platform/x86: ideapad-laptop: add fn_lock_get/set functions
Date: Tue,  2 Apr 2024 15:21:01 +0200
Message-ID: <dfd3a62a2b71339bbddf01e8a2ccd5ca92ce7202.1712063200.git.soyer@irl.hu>
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

The FnLock is retrieved and set in several places in the code.

Move details into ideapad_fn_lock_get and ideapad_fn_lock_set functions.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/platform/x86/ideapad-laptop.c | 38 +++++++++++++++++++--------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 901849810ce2..529df08af548 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -513,11 +513,8 @@ static ssize_t fan_mode_store(struct device *dev,
 
 static DEVICE_ATTR_RW(fan_mode);
 
-static ssize_t fn_lock_show(struct device *dev,
-			    struct device_attribute *attr,
-			    char *buf)
+static int ideapad_fn_lock_get(struct ideapad_private *priv)
 {
-	struct ideapad_private *priv = dev_get_drvdata(dev);
 	unsigned long hals;
 	int err;
 
@@ -525,7 +522,27 @@ static ssize_t fn_lock_show(struct device *dev,
 	if (err)
 		return err;
 
-	return sysfs_emit(buf, "%d\n", !!test_bit(HALS_FNLOCK_STATE_BIT, &hals));
+	return !!test_bit(HALS_FNLOCK_STATE_BIT, &hals);
+}
+
+static int ideapad_fn_lock_set(struct ideapad_private *priv, bool state)
+{
+	return exec_sals(priv->adev->handle,
+		state ? SALS_FNLOCK_ON : SALS_FNLOCK_OFF);
+}
+
+static ssize_t fn_lock_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct ideapad_private *priv = dev_get_drvdata(dev);
+	int brightness;
+
+	brightness = ideapad_fn_lock_get(priv);
+	if (brightness < 0)
+		return brightness;
+
+	return sysfs_emit(buf, "%d\n", brightness);
 }
 
 static ssize_t fn_lock_store(struct device *dev,
@@ -540,7 +557,7 @@ static ssize_t fn_lock_store(struct device *dev,
 	if (err)
 		return err;
 
-	err = exec_sals(priv->adev->handle, state ? SALS_FNLOCK_ON : SALS_FNLOCK_OFF);
+	err = ideapad_fn_lock_set(priv, state);
 	if (err)
 		return err;
 
@@ -1709,7 +1726,6 @@ static void ideapad_wmi_notify(struct wmi_device *wdev, union acpi_object *data)
 {
 	struct ideapad_wmi_private *wpriv = dev_get_drvdata(&wdev->dev);
 	struct ideapad_private *priv;
-	unsigned long result;
 
 	mutex_lock(&ideapad_shared_mutex);
 
@@ -1722,11 +1738,11 @@ static void ideapad_wmi_notify(struct wmi_device *wdev, union acpi_object *data)
 		ideapad_input_report(priv, 128);
 		break;
 	case IDEAPAD_WMI_EVENT_FN_KEYS:
-		if (priv->features.set_fn_lock_led &&
-		    !eval_hals(priv->adev->handle, &result)) {
-			bool state = test_bit(HALS_FNLOCK_STATE_BIT, &result);
+		if (priv->features.set_fn_lock_led) {
+			int brightness = ideapad_fn_lock_get(priv);
 
-			exec_sals(priv->adev->handle, state ? SALS_FNLOCK_ON : SALS_FNLOCK_OFF);
+			if (brightness >= 0)
+				ideapad_fn_lock_set(priv, brightness);
 		}
 
 		if (data->type != ACPI_TYPE_INTEGER) {
-- 
2.44.0


