Return-Path: <linux-kernel+bounces-10105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3F781CFFD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96612817B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E961E2F865;
	Fri, 22 Dec 2023 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GdzGwPnP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83F52F845
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7812bed1c86so73881885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703285754; x=1703890554; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d1lUNN/ZbBeQ7+FcfsIqCm9ReLmWHKbxibhu/nClqx0=;
        b=GdzGwPnPOolXyfqoauhgSJHTC7wFVPYNeN7lwEVdLtQZzyIlCZmgKGHHxQ6A1rYMWK
         glcfCm4v8nrSkWXm4ajujn/6/xDbPN9Vnfpt/mRUxMp+5JhSgfTLXjP+w1f1YKwBzLba
         a6O3TG7t9YeQ2MyfsWBSQp77Iu39Grg4hau/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703285754; x=1703890554;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1lUNN/ZbBeQ7+FcfsIqCm9ReLmWHKbxibhu/nClqx0=;
        b=XtYX9BAHHtkT2kTsO6BUoW7UlwLtnkAGfjMAQk3xWGJYotuVNmMTuBFoi4NImL+v+u
         Sa8NrZ3ypmFipa9LxW7R5zUTKFfMf4k1GmYFQy2t1nS964AwdAYJNl/W1r3D/QTjtAIE
         K6LIK/eGqivJ1y5peKqqokmntLJqq+U6hoQ7waKahfq7arFDrbC0axdqdufsLEqmp/pj
         iP/XQi6ey3emRPxnuezZP5dlEq3JDFHTdw3MtLKjtBYN5YOw5CoBquUmC9mJFF4XRkwr
         uU3Yu5NNlEh5QhVxK27+M+pvc0xrCCzL5PfbLF4ra7isI82NX/vuD5XJYfPzmJ41l92b
         Ot9g==
X-Gm-Message-State: AOJu0YzFX6KWxRSiKQjLfYeJ/cpXt9WMJ1iFQ7Etfirm/+16ikcfsM/W
	QTs7PTwUEJS67KmIPxXV4jdeVXDFhPyHh08hBotO9dIC9g==
X-Google-Smtp-Source: AGHT+IGjtzvi/gpUak/rigoRG9O8ppJhWBs/DZTP6zm2L9kkkJ0lMp+Xth+1Mtv3n2QDjSmMIq26Ww==
X-Received: by 2002:a05:620a:11b9:b0:781:123c:4995 with SMTP id c25-20020a05620a11b900b00781123c4995mr2294398qkk.65.1703285754719;
        Fri, 22 Dec 2023 14:55:54 -0800 (PST)
Received: from denia.c.googlers.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id b22-20020a05620a271600b0077f2cbc971csm1649012qkp.121.2023.12.22.14.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 14:55:54 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Dec 2023 22:55:49 +0000
Subject: [PATCH v2] usb: core: Add quirk for Logitech Rallybar
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-rallybar-v2-1-5849d62a9514@chromium.org>
X-B4-Tracking: v=1; b=H4sIAPQThmUC/23MQQ6CMBCF4auQWVtDByTqynsYFqUdYBKgZKqNh
 PTuVtYu/5eXb4dAwhTgXuwgFDmwX3LgqQA7mmUgxS43YImVRkQlZpq2zojSN0ulbWp3oQbyfRX
 q+XNQzzb3yOHlZTvkqH/rHyRqpdUVOzS1q3TZ9A87ip/5PZ+9DNCmlL4qWb/RowAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.3

Logitech Rallybar devices, despite behaving as UVC camera, they have a
different power management system than the rest of the other Logitech
cameras.

USB_QUIRK_RESET_RESUME causes undesired USB disconnects, that make the
device unusable.

These are the only two devices that have this behavior, and we do not
have the list of devices that require USB_QUIRK_RESET_RESUME, so lets
create a new lit for them that un-apply the USB_QUIRK_RESET_RESUME
quirk.

Fixes: e387ef5c47dd ("usb: Add USB_QUIRK_RESET_RESUME for all Logitech UVC webcams")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Tested with a Rallybar Mini with an Acer Chromebook Spin 513
---
Changes in v2:
- Add Fixes tag
- Add UVC maintainer as Cc
- Link to v1: https://lore.kernel.org/r/20231222-rallybar-v1-1-82b2a4d3106f@chromium.org
---
 drivers/usb/core/quirks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 15e9bd180a1d..8fa8de50e7f0 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -553,6 +553,14 @@ static const struct usb_device_id usb_interface_quirk_list[] = {
 	{ }  /* terminating entry must be last */
 };
 
+static const struct usb_device_id usb_interface_unsupported_quirk_list[] = {
+	/* Logitech Rallybar VC systems*/
+	{ USB_DEVICE(0x046d, 0x089b), .driver_info = USB_QUIRK_RESET_RESUME },
+	{ USB_DEVICE(0x046d, 0x08d3), .driver_info = USB_QUIRK_RESET_RESUME },
+
+	{ }  /* terminating entry must be last */
+};
+
 static const struct usb_device_id usb_amd_resume_quirk_list[] = {
 	/* Lenovo Mouse with Pixart controller */
 	{ USB_DEVICE(0x17ef, 0x602e), .driver_info = USB_QUIRK_RESET_RESUME },
@@ -718,6 +726,8 @@ void usb_detect_interface_quirks(struct usb_device *udev)
 	u32 quirks;
 
 	quirks = usb_detect_static_quirks(udev, usb_interface_quirk_list);
+	quirks &= ~usb_detect_static_quirks(udev,
+					usb_interface_unsupported_quirk_list);
 	if (quirks == 0)
 		return;
 

---
base-commit: c0f65a7c112b3cfa691cead54bcf24d6cc2182b5
change-id: 20231222-rallybar-19ce0c64d5e6

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


