Return-Path: <linux-kernel+bounces-19175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BD682694F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E77D5B21459
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6812BBA5E;
	Mon,  8 Jan 2024 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HoKSlezc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E698F7D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-680a13af19bso15554666d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 00:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704701868; x=1705306668; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M7JX/XG4UeOfhBADs4/0tfMCsAlccOtRn7KjHfujLog=;
        b=HoKSlezcTZcYFJPKYQX48MdyKiQtxELN1qz5OYZTT7/qfX+hWS0xWujR3rPkVHmHYE
         /mwhsuBZyt0WPRarjqrDajpbqIXqPpfAResAncDLpdBO6EU+qePU04ZhYlLuA3KtPSYQ
         SsAnZsAJe3x9eYqtmavq6NkTB653NVB47gfHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704701868; x=1705306668;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7JX/XG4UeOfhBADs4/0tfMCsAlccOtRn7KjHfujLog=;
        b=lzLj4qI7hIDc2ORYkMeXllKZ/qeYjNwJAeHOS3OE+X5ENFW8t9ZmiOx4GTOdRZLHnR
         Iubcdg8MbUdevV8dX2FEvM8PnA3InVAxFCzLjmsqV+cb7SV1ZLuM6WNSwP/aOMMrJYfj
         l4qg9bALQ/kaULf/xC+S9L5aslV/xA8AMUviEvUVj5ebH7IDxguZeEdff9iWr+DJmDZm
         FZlL/0/8FvevgEsIKlZwsdq1LvjQ8jocpB++ly9T+LiDOUuDHQeK3aTvT/EIyyNl/cxs
         HWokapjFrlj8Di202+0Hk2XUZTvK/Ka5VudRR1jJEI/p+H3LkXfKJDWry1bi92GJcM8L
         QAgg==
X-Gm-Message-State: AOJu0Yz1yqPIkK1/+K2MMIHc5zqPQtj2PVw4+yQ2HPZAjLVtOg277apn
	noapz34CfgQIB2s+Kkjdfb6lTpvnG3aB
X-Google-Smtp-Source: AGHT+IGptTWpMNyQDIYX52xrsGYTAvpv9R4EwsCPc08+j3vCXW2Nc3dRQ9UaKgZZwCuhWj3QWQKeeg==
X-Received: by 2002:a05:6214:c4b:b0:680:c789:c4f2 with SMTP id r11-20020a0562140c4b00b00680c789c4f2mr4369988qvj.86.1704701868179;
        Mon, 08 Jan 2024 00:17:48 -0800 (PST)
Received: from denia.c.googlers.com (204.246.236.35.bc.googleusercontent.com. [35.236.246.204])
        by smtp.gmail.com with ESMTPSA id x12-20020ad4458c000000b00681034fbc9esm924919qvu.94.2024.01.08.00.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 00:17:47 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 08 Jan 2024 08:17:46 +0000
Subject: [PATCH v4] media: ucvideo: Add quirk for Logitech Rally Bar
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-rallybar-v4-1-a7450641e41b@chromium.org>
X-B4-Tracking: v=1; b=H4sIAKqvm2UC/3XM0QqCMBTG8VeRXbfYOU7TrnqP6GJuUwfq4qwkE
 d+9KQQRdvkdzu8/s2DJ2cDOyczIji44P8QhDwnTrRoay52Jm6HAFBCRk+q6qVLEodRW6FyazOY
 svt/J1u61pa63uFsXHp6mrTzCet2JjMCBF1ihkiYFkdcX3ZLv3bM/emrY2hnxn8Vos0KWJkdVZ
 iB3bPqxUoD4tmm0QlVQnrSVSuGPXZblDVULOwUbAQAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, stable@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.3

Logitech Rally Bar devices, despite behaving as UVC cameras, have a
different power management system that the other cameras from Logitech.

USB_QUIRK_RESET_RESUME is applied to all the UVC cameras from Logitech
at the usb core. Unfortunately, USB_QUIRK_RESET_RESUME causes undesired
USB disconnects, that make them completely unusable.

Instead of creating a list for this family of devices in the core, let's
create a quirk in the UVC driver.

Fixes: e387ef5c47dd ("usb: Add USB_QUIRK_RESET_RESUME for all Logitech UVC webcams")
Cc: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Tested with a Rallybar Mini with an Acer Chromebook Spin 513
---
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
 drivers/media/usb/uvc/uvc_driver.c | 30 ++++++++++++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 08fcd2ffa727..9663bcac6843 100644
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
@@ -2233,6 +2234,8 @@ static int uvc_probe(struct usb_interface *intf,
 	}
 
 	uvc_dbg(dev, PROBE, "UVC device initialized\n");
+	if (dev->quirks & UVC_QUIRK_FORCE_RESUME)
+		udev->quirks &= ~USB_QUIRK_RESET_RESUME;
 	usb_enable_autosuspend(udev);
 	return 0;
 
@@ -2574,6 +2577,33 @@ static const struct usb_device_id uvc_ids[] = {
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
index 6fb0a78b1b00..fa59a21d2a28 100644
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


