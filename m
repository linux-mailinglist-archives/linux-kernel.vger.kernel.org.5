Return-Path: <linux-kernel+bounces-127905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D646E895294
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED771F2374E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E94C7E0F4;
	Tue,  2 Apr 2024 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hy8FKegc"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3E874262
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059773; cv=none; b=ihYL6PQJi+yi26RGnkdyO6OaVL9RQI13AqkVAygPv4tZJB6nglcg5X+Me7M01Oq9Odr7jFfaquyA7oPce6+TUG+y5D59Ym5ppTPeiMeBJMkp9p/zoX1x4KBMfg2Pzjx+yGzVzCZo9pOTNO03SGVGpprAjFbYyAUp8o+pyuGFAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059773; c=relaxed/simple;
	bh=ahRMcLkjFExP99f5A5yoUFbXddpWpyopk22CXBLQ9xI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B7ZvqMDCzkfps5Vm/UyHQv2V7wxrzBgwkhxtvYjQQzdvOH7XJJCMUH6dcBRDrIDYI2rCtgNOMz/hE1jr6X1f/vR6LfbhTssWboImUAmWJwEnRonpV2awxrfzwb7mf8LvtueVPWRxquQG1FI32jvlA79KJ1zIQx1mQ9g/BCEd5Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hy8FKegc; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e8a1b8cf28so973316a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712059770; x=1712664570; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j5rFxrXL2P+kdAdamW3tYXEeRPfGn55Rv8VJMgZBhXg=;
        b=hy8FKegcCoCS4rcGDmq2D7ojkfRcfgHQs+ZMiLSxXUzOfx2U8Lububh1Mg/tCE01Sf
         CLtrM+4VK7EA0dRtpJs9S2Gvdz/pSNI2rJqkI8EbZTL2ZMkTaFraKB+Kevu9wJEXDv+8
         A5bNSViI1jesLx4cieOVHefUL4fakz0zauMxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712059770; x=1712664570;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5rFxrXL2P+kdAdamW3tYXEeRPfGn55Rv8VJMgZBhXg=;
        b=EhbFWxNszKKSkur4ZHoaSn4p/3CMN+XKoJJiiNZA7prNDAoXXSROnJOb54K8pDR6ZS
         2QT6j/JBd/8zg8q6R1R9NWMoNwYbAx/e+LQrsbgAMsFI16a94b2pJBtOaxXx7IT1AZDf
         NhJgsB3U2M+1HlAZMWcahQjUv26iNTZ0GT0n4DHCwr/Ob3B/dDjQ/Lc0/n2C0GFQJThJ
         y/AsNEw/AirgdquWBsMHGGzgjnNQYJATMUkUxD31kfXAgC9IJ1OoLkfYVYhtjcwe3r/T
         bxv5a/OIRBkJtneT8HpuC/0HaJjF0sVR5ovyCdeBS2K8ScngDTTU/O+zVr8SOHJyvj1G
         bnfA==
X-Forwarded-Encrypted: i=1; AJvYcCUBawbeLPLga8+4QIf65I3if6mYUpnf2k8wnC3Fd+E3pQWbS/OhFyaemj7Sk5vKYApld/jyJzuPsRLad65mKJ6nDebMLN2FFjQTbJ9P
X-Gm-Message-State: AOJu0YyEv0K2fJoN/eVlCBLem+ZFd7bSxZ7zNRwDMRpdDrqZA59XJPns
	Qz2iM7jIuPOwZW9dJ1lmqy5mVz5UQ+FJ7Vmi8qYE6+opNlAtWfgffy9MPaexWg==
X-Google-Smtp-Source: AGHT+IF0N+GkNk9od58Bnsg5BIymhK0X9MmZ/yo2fBafw081AKnRmBo1/1M9LLtSJyRF5cVRDTdOsA==
X-Received: by 2002:a9d:6c8f:0:b0:6e6:c811:4891 with SMTP id c15-20020a9d6c8f000000b006e6c8114891mr13403540otr.29.1712059770483;
        Tue, 02 Apr 2024 05:09:30 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id r9-20020a056214124900b00698f0a22f5csm4396702qvv.130.2024.04.02.05.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:09:30 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 02 Apr 2024 12:09:29 +0000
Subject: [PATCH v5] media: ucvideo: Add quirk for Logitech Rally Bar
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-rallybar-v5-1-7bdd0fbc51f7@chromium.org>
X-B4-Tracking: v=1; b=H4sIAHj1C2YC/3XMwQrCMAzG8VeRnq00WVo3T76HeMi66ArqpNPhG
 Ht3O0EYMo9fyO8/qFZikFbtVoOK0oU2NLc07HqlfM23s+hQpa3QYAaIqCNfLn3JUUPhxXhHlRW
 n0vs9yim8PqnDMe06tI8m9p9yB9N1IdKBBp1jiUxVBsad9r6OzTU8r5smntXU6fCfxWRtTkXlk
 AsLtGCzryUDZm6zZA2XUGy9EDMuWJrbfGYpWd6SNY5ACMofO47jG+LFC/dXAQAA
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
 drivers/media/usb/uvc/uvc_driver.c | 30 ++++++++++++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 08fcd2ffa727b..9663bcac68438 100644
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


