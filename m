Return-Path: <linux-kernel+bounces-14498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A03821DF5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE471C22376
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8A5168AA;
	Tue,  2 Jan 2024 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lI4MKSKK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66815AEA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbe78430946so1080635276.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 06:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704206327; x=1704811127; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jy0uRx2JMKC7IT4IrT6DQeOOAvtEVqpfbBhM8k6y5YU=;
        b=lI4MKSKK0DT9T/8CHJPTLjXGtC2VQyQIeo0slFWaSUBLQN4POb17ew1naXivDDu/dH
         1PGocvTFj7iEoIepWOWsnw8K6DvpBxTfYnnpVNPrFssj2uTKAdqRTr4sKpgzrtPxcQ9N
         sQGG8BVCoe7bHpGNdA2rNyWCsM8zaAy7wPX4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704206327; x=1704811127;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jy0uRx2JMKC7IT4IrT6DQeOOAvtEVqpfbBhM8k6y5YU=;
        b=ml2O5o5g3GWHIaoAoPzxZ/WvCZ+tXHbUEQ71qnWkGsxlhQb03tgU+/B73Dkxu9sZ8W
         JN350NJ9BEsvXNizryGD4Gq7mDBei5NiTNjNBeHFrVWya8V0GmBg5Gop1gRe89k1w9Wv
         HXErTnKaiy3mGWz3YXeeDYT7a+mUigyMZiwMVsOq0xJmguP+rMP6TXrA0pHjnBcsbLUN
         MJHGgVxWuVEiVtUNfKikm5lJWO+3yqChx5Nn2OFNP/tbqpArveU72tBiN6m3kTSAYuKA
         /6Nod7xKboYk0AEZcYRk0ifGpB6s/B8TSqO8t0uvVwZocOEKg4cA9Np64okzDW+HpLqk
         TSsQ==
X-Gm-Message-State: AOJu0YxiqE+/xozay8Oxklssio6sZF0EudHZ31q+HpajdUfw1obM5gbW
	eEqYDXD1+muNhXv0Q0ljNpn2zZit4PGrt52I99OLWmLqeUppZc8=
X-Google-Smtp-Source: AGHT+IF2VmlnzA7AgDC3KwlEUuCIE5PgevZGdecadVjf9tfvv09O27NfPI3ZsHc2De/o71n4pxcOUQ==
X-Received: by 2002:a25:aa2d:0:b0:dbd:5cd5:4d53 with SMTP id s42-20020a25aa2d000000b00dbd5cd54d53mr7126352ybi.96.1704206327096;
        Tue, 02 Jan 2024 06:38:47 -0800 (PST)
Received: from denia.c.googlers.com (204.246.236.35.bc.googleusercontent.com. [35.236.246.204])
        by smtp.gmail.com with ESMTPSA id p13-20020ad451cd000000b00680b34d52f8sm1463586qvq.13.2024.01.02.06.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:38:46 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 02 Jan 2024 14:38:45 +0000
Subject: [PATCH v3] media: ucvideo: Add quirk for Logitech Rally Bar
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-rallybar-v3-1-0ab197ce4aa2@chromium.org>
X-B4-Tracking: v=1; b=H4sIAPUflGUC/3WMwQ6CMBAFf4X0bA27LQ148j+Mh9IWaALUbLWRE
 P7dwtHocV7ezMqiI+8iuxQrI5d89GHOIE4FM4Oee8e9zcywRAGIyEmP49Jq4tAYVxolbeUUy/c
 Huc6/j9Ttnnnw8RloOcoJ9vVHJAEHXmOLWloBpequZqAw+dd0DtSzvZPwn4vZrWrZWIW6qUB+u
 du2fQDDhAwd3wAAAA==
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
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Tested with a Rallybar Mini with an Acer Chromebook Spin 513
---
Changes in v3:
- Move quirk to uvc driver
- Link to v2: https://lore.kernel.org/r/20231222-rallybar-v2-1-5849d62a9514@chromium.org

Changes in v2:
- Add Fixes tag
- Add UVC maintainer as Cc
- Link to v1: https://lore.kernel.org/r/20231222-rallybar-v1-1-82b2a4d3106f@chromium.org
---
 drivers/media/usb/uvc/uvc_driver.c | 21 +++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 08fcd2ffa727..77c1932c29ca 100644
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
 
@@ -2574,6 +2577,24 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT) },
+	/* Logitech Rally Bar */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x046d,
+	  .idProduct		= 0x089b,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_FORCE_RESUME) },
+	/* Logitech Rally Bar */
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


