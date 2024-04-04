Return-Path: <linux-kernel+bounces-131930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2549898DA5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1FF1F23745
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F109ECA62;
	Thu,  4 Apr 2024 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PJu7yEYN"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C6012EBD0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253654; cv=none; b=t4EKu+rAGS/8sqbqGx1n8wC7INioUrzgfKzPDIxxpteDaXngWK9cMxbB5/UCCYiTjj6UI2bOtGXw/4KihOdaMxD6Z3J3yq2y1mQR53S0pekpT25UjHdTASD6TlqeFPzF3u/5Co7aTxBSEp30fFAmOKexw3Fv6LmcvZunE3fQQ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253654; c=relaxed/simple;
	bh=8i9lD1082HlTW7L8l7PDfunKHQG6xnh5Rkq/dOV1DGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QV6Dt2xHkLWkZOrDV7ptzUF1yWmZ2tkNQRRZHfMEi8DlMV44zfC1tyH2oNStb2WHTFqb0sFFujE0Qvnu1Bs60YgzrDaO+vjWiKu8vI8zH4EZo9E3NCZxLV/y8wOp8tQnjI7470Fwa9Fli16j+YgU178LIYA+bdG6DswBKkStGc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PJu7yEYN; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43182c2457bso6658491cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 11:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712253651; x=1712858451; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eW6Ut/fw1eGESzWpDoiTGmn7OMtXM3kSDS/x7RatDPw=;
        b=PJu7yEYNk3KqTw1bbGYxbGY5CEBTJduVGVNS4jL3XcnatYMQFo1WhaOxJjlJBc/w47
         WPJo5AiEnlWhsA8CCzScA8+boPJKCKDPNnORFvDHphusoPTctUriQyS+xxqnb4Ad+Bzj
         Q2Hea+ycRFaXjMy2CgrwhBWiImq/Kl961709A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712253651; x=1712858451;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eW6Ut/fw1eGESzWpDoiTGmn7OMtXM3kSDS/x7RatDPw=;
        b=dnWcxXmAR3EyVo+N8/3m4ULy4CkvdfeyIj4dXUFNjfskWwFzhHdXR8+sTQuEnmGSFG
         JIzhqMWDKDJHrF1XNBPS8QdvWNNihLJltaKv9zBK96y0Hkh2DQd64aRqmPoOJ8NARX1x
         rWKRkCcWWH6h9r9fkYCSuwSqm6Y4WmL09WVZi1rP2aw4lfpNzoRSOEz5SL2ZYc2cMTp1
         GTRV3kLr6gEs566IoJPebMC046rMJrmkHU6qkWl17KlqeYYhlaceCKDKjiUN/0TOHdyb
         mfkPKCJhPEL7cXrc5Fqufvelr6XhOSh/XnxN934M53j+hopul0NPEioI3qwWN8I1O7Ba
         H+Wg==
X-Forwarded-Encrypted: i=1; AJvYcCX6kxaUjrgafFPRsEJwLn5jPWxb9I6iSa3az2zaJ5f4L/sjCVq/6aa+S5RGGvKt/akZ65cHD+bhWfxtnFjtHmKcPOJH8v3/er0UI80A
X-Gm-Message-State: AOJu0YySz/ZScQ1hGm3LmWSd0cbmv7NCzT3Fjio9G3JHpxlwg6d1IEYy
	4w8QRzEqjKe2TEbVpjUlC9I1hLL9m4AFy83c83Zw0z1z2udpsYIARrC6vOv4gw==
X-Google-Smtp-Source: AGHT+IFfGtC4jZ50T09wLazeGDqgzXOVUXT6T5H8//nsyVwVVzCVYZ23/iHcHbbRp3uOEqkarB+J0g==
X-Received: by 2002:ac8:5cc6:0:b0:432:d303:9ec with SMTP id s6-20020ac85cc6000000b00432d30309ecmr3529186qta.52.1712253651024;
        Thu, 04 Apr 2024 11:00:51 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id ea3-20020a05622a5b0300b004315aa3d5d7sm7900282qtb.0.2024.04.04.11.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 11:00:50 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 04 Apr 2024 18:00:49 +0000
Subject: [PATCH v6] media: uvcvideo: Add quirk for Logitech Rally Bar
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-rallybar-v6-1-6d67bb6b69af@chromium.org>
X-B4-Tracking: v=1; b=H4sIANDqDmYC/3XNQW7CMBCF4asgr2vkmYydpCvugboY2xNiCUjlQ
 FSEcvcapIq0Spdv5O/3XY2Sk4zqfXNXWaY0puFchnvbqNDz+SA6xbIVGqwAEXXm4/HmOWtog5j
 gKFpxqjz/zNKlr2dq/1F2n8bLkG/P8gSP60pkAg26QY9MsQLjul3o83BK19N2yAf16Ez4n8Vib
 UNtdMitBVqx1Y8lA2Zpq2INe2jrIMSMK5aWtllYKpZrssYRCIFfsfZl6de/ttjax2g6Hyx09R8
 7z/M3A+CGEJMBAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, stable@vger.kernel.org, 
 Oliver Neukum <oneukum@suse.com>, Devinder Khroad <dkhroad@logitech.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Logitech Rally Bar devices, despite behaving as UVC cameras, have a
different power management system that the other cameras from Logitech.

USB_QUIRK_RESET_RESUME is applied to all the UVC cameras from Logitech
at the usb core. Unfortunately, USB_QUIRK_RESET_RESUME causes undesired
USB disconnects in the Rally Bar that make them completely unusable.

There is an open discussion about if we should fix this in the core or
add a quirk in the UVC driver. In order to enable this hardware, let's
land this patch first, and we can revert it later if there is a
different conclusion.

Fixes: e387ef5c47dd ("usb: Add USB_QUIRK_RESET_RESUME for all Logitech UVC webcams")
Cc:  <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Devinder Khroad <dkhroad@logitech.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Tested with a Rallybar Mini with an Acer Chromebook Spin 513
---
Changes in v6: Thanks Laurent
- Fix subject line.
- Move quirk before device init message.
- Link to v5: https://lore.kernel.org/r/20240402-rallybar-v5-1-7bdd0fbc51f7@chromium.org

Changes in v5:
- Update commit message to describe that this is a temp solution.
- Link to v4: https://lore.kernel.org/r/20240108-rallybar-v4-1-a7450641e41b@chromium.org

Changes in v4:
- Include Logi Rally Bar Huddle (Thanks Kyle!)
- Link to v3: https://lore.kernel.org/r/20240102-rallybar-v3-1-0ab197ce4aa2@chromium.org

Changes in v3:
- Move quirk to uvc driver
- Link to v2: https://lore.kernel.org/r/20231222-rallybar-v2-1-5849d62a9514@chromium.org

Changes in v2:
- Add Fixes tag
- Add UVC maintainer as Cc
- Link to v1: https://lore.kernel.org/r/20231222-rallybar-v1-1-82b2a4d3106f@chromium.org
---
 drivers/media/usb/uvc/uvc_driver.c | 31 +++++++++++++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 08fcd2ffa727b..1b4fb9f46bc83 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
+#include <linux/usb/quirks.h>
 #include <linux/usb/uvc.h>
 #include <linux/videodev2.h>
 #include <linux/vmalloc.h>
@@ -2232,6 +2233,9 @@ static int uvc_probe(struct usb_interface *intf,
 		goto error;
 	}
 
+	if (dev->quirks & UVC_QUIRK_FORCE_RESUME)
+		udev->quirks &= ~USB_QUIRK_RESET_RESUME;
+
 	uvc_dbg(dev, PROBE, "UVC device initialized\n");
 	usb_enable_autosuspend(udev);
 	return 0;
@@ -2574,6 +2578,33 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT) },
+	/* Logitech Rally Bar Huddle */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x046d,
+	  .idProduct		= 0x087c,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_FORCE_RESUME) },
+	/* Logitech Rally Bar */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x046d,
+	  .idProduct		= 0x089b,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_FORCE_RESUME) },
+	/* Logitech Rally Bar Mini */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x046d,
+	  .idProduct		= 0x08d3,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_FORCE_RESUME) },
 	/* Chicony CNF7129 (Asus EEE 100HE) */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 6fb0a78b1b009..fa59a21d2a289 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -73,6 +73,7 @@
 #define UVC_QUIRK_FORCE_Y8		0x00000800
 #define UVC_QUIRK_FORCE_BPP		0x00001000
 #define UVC_QUIRK_WAKE_AUTOSUSPEND	0x00002000
+#define UVC_QUIRK_FORCE_RESUME		0x00004000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001

---
base-commit: c0f65a7c112b3cfa691cead54bcf24d6cc2182b5
change-id: 20231222-rallybar-19ce0c64d5e6

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


