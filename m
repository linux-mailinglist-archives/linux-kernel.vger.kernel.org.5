Return-Path: <linux-kernel+bounces-49130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ECC846638
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B9D1C24CED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3F4C8E1;
	Fri,  2 Feb 2024 03:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A1qsG+aa"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC2C2D2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 03:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843060; cv=none; b=IRx7V6h3TS7FMAHPTvKtcVPvbSrl2iuouMsHnOLEBPU9DgVJZ4scf+sg3BOGS5HO4Ydw12Ir7giDA14S6Q8MV1OYZ4ldOtW0sCCk+dq9qjPtKg2z0OMqesLrvgUqzzOTIvrLs7lxULtHfc9Tyq21/dak3CZ1hUns3a0Pj53ZoJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843060; c=relaxed/simple;
	bh=7fvoMDGLvlhYIzv6i+KgK8j9y8CMOHfEAGQsrvtQc14=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KyL54jnp7GMzfoh/JtrAwrcTm543x9uRLyxVHnH7z2C7PqmQgvcZ/6fxjHaJE1lGHnNh/EWIcS7ePgC97tI+atiRXenU4thUd+2eSftJbrt0ZKMpvZgEZb+SW3TFwtOJHvvOJnKy9UqvLlIAgXagqvmRPMWJkmKMadKInV1OzzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A1qsG+aa; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so2794196276.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 19:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706843058; x=1707447858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NBFBnWt5PngE+9c3SBPlpOUFG8K2Vi64DLTgnygvKiw=;
        b=A1qsG+aagv8qJyA4r/IQdvg6N1KYFB2gEYWWTWbx4qc3OSsy5gZGqZea028rpsVy2I
         uVkpldcNp1VD1VGSJBPXhugZlnlVRGOkUqXKuMGqmWx58mHgm2Da/oP0KQojRShVo1l2
         Dj1+iEUH2a6DUCsrqjtZJkObaBHYsX0pe9GgPuajsqYWAAG5Tnaq1tx2VKkwle/8UXdH
         DDCiW/+hrmAfdStbYkFA1LbXvCOXNqlpXkyTVFSx04jyMxpdb7o33DbFLOJhFr06UvBX
         Id9EAixwwTY8syaH0VZlKiNbp4aLnGIsZgxFBKupvs2WJ2UxxzcEvWoMP8a0I5Xdb7Wi
         sgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706843058; x=1707447858;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBFBnWt5PngE+9c3SBPlpOUFG8K2Vi64DLTgnygvKiw=;
        b=ZO/UPM8JrrRMJ0v+QMQBWm7EWR2X64qK6+S2IXFr0gP9xhZ3raZwXLqP3u6WeerC/m
         hKnSpLis6+2BBwbgdbk2Afz7KQyMdaAP/Bofbo0yHEhjaEu0E0MI2FIjDx/FcM+cmCOr
         azDB3tr+QGHWTy+bIN8qkHsNYvUiIqjFsgwodOFKYy3gY30+XTEbD/3lE/ooJAQAwGNk
         FWdznYXEOjaBeTquy9n76LhnyHJJRP5YqNJtWnj8Xhhw6Jb0oOrpCy0LLnWhTq20KsRF
         atp7UOVf1PjzRRtqFemrqPoZ2NepZr7WGq2qUHhknJjx3ELEuoPtzf7f/JE+kPNTyIXJ
         /Njw==
X-Gm-Message-State: AOJu0Yzex/iLFDkqX38/Zlj/r5K9ErTZxhioOR7gELsVLwymaUxqsecI
	Yuy7oOAPP1Nt5JCUanJsG8wC+fT8E/xQjTaLJit+2cS+gGX3g8jzkz1bZkzDqyDd3C4TCVXF81Z
	Sdr58aQhUVS909Q==
X-Google-Smtp-Source: AGHT+IHbeop2+ti/vV4Op5SIW5t1qIc/jGyREI2vYL4SUKOUwJyT3jX7yAD8SnAY6YEPgN9Lwc6ekhMZeDtqhSE=
X-Received: from guanyulin.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:1af])
 (user=guanyulin job=sendgmr) by 2002:a05:6902:2491:b0:dc6:e8a7:fdba with SMTP
 id ds17-20020a056902249100b00dc6e8a7fdbamr391501ybb.4.1706843058023; Thu, 01
 Feb 2024 19:04:18 -0800 (PST)
Date: Fri,  2 Feb 2024 03:00:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202030301.2396374-1-guanyulin@google.com>
Subject: [PATCH] usb: sysfs: use kstrtobool() if possible
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, 
	benjamin.tissoires@redhat.com, hadess@hadess.net
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Guan-Yu Lin <guanyulin@google.com>
Content-Type: text/plain; charset="UTF-8"

Replace the self-rolled implementations with kstrtobool(). This reduces
the maintenance efforts in the future.

Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
---
 drivers/usb/core/sysfs.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index 5d21718afb05..e67826ec053e 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -273,9 +273,10 @@ static ssize_t avoid_reset_quirk_store(struct device *dev,
 				      const char *buf, size_t count)
 {
 	struct usb_device	*udev = to_usb_device(dev);
-	int			val, rc;
+	bool			val;
+	int			rc;
 
-	if (sscanf(buf, "%d", &val) != 1 || val < 0 || val > 1)
+	if (kstrtobool(buf, &val) != 0)
 		return -EINVAL;
 	rc = usb_lock_device_interruptible(udev);
 	if (rc < 0)
@@ -322,13 +323,14 @@ static ssize_t persist_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
 	struct usb_device *udev = to_usb_device(dev);
-	int value, rc;
+	bool value;
+	int rc;
 
 	/* Hubs are always enabled for USB_PERSIST */
 	if (udev->descriptor.bDeviceClass == USB_CLASS_HUB)
 		return -EPERM;
 
-	if (sscanf(buf, "%d", &value) != 1)
+	if (kstrtobool(buf, &value) != 0)
 		return -EINVAL;
 
 	rc = usb_lock_device_interruptible(udev);
@@ -739,14 +741,14 @@ static ssize_t authorized_store(struct device *dev,
 {
 	ssize_t result;
 	struct usb_device *usb_dev = to_usb_device(dev);
-	unsigned val;
-	result = sscanf(buf, "%u\n", &val);
-	if (result != 1)
+	bool val;
+
+	if (kstrtobool(buf, &val) != 0)
 		result = -EINVAL;
-	else if (val == 0)
-		result = usb_deauthorize_device(usb_dev);
-	else
+	else if (val)
 		result = usb_authorize_device(usb_dev);
+	else
+		result = usb_deauthorize_device(usb_dev);
 	return result < 0 ? result : size;
 }
 static DEVICE_ATTR_IGNORE_LOCKDEP(authorized, S_IRUGO | S_IWUSR,
-- 
2.43.0.594.gd9cf4e227d-goog


