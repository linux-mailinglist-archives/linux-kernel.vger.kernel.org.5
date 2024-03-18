Return-Path: <linux-kernel+bounces-106839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B8E87F450
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF947B22286
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61663604BA;
	Mon, 18 Mar 2024 23:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JC9Dt8oD"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC3C5FDC9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710806139; cv=none; b=nhJpFGNGbdjEtk913O9gKag6yYxSSwWiQektzhPSYl3QSndNI6J7i090cIlZwj1YlCNDFOPDuuCMCkcx2v/U0fAGpUp7v2oosHYCGzwG6W7WID3QduXpDJKx5eq8Ja1HRhx7GdWmUVAiKIDVd4Abz/QJ/Em43wNGV9u9M4ciTxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710806139; c=relaxed/simple;
	bh=GiL+LY/p8pfW4zfMJcj2rtwh2jcG/Fnaf75jG+Q9ISo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BYF3NGfn+wlf1xOIpBqv+qM+QxSwegNyLPiwMTF7JAtdWLPyJM+GnqMKOndsZDjbAWNfDwsssfev8faWxPDPGlC/9hplD5x8zT1U0bvYjY74rVQcfxmO56mrcFEQfHF/jFUIoGfP6kIBB1AJIyYamXSbybSAZj89hdT0APRep5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JC9Dt8oD; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4766e56ccccso1484161137.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710806136; x=1711410936; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6pBQRCTkt0thzPciZm+J+ubbehmNUxiTZuEht3ecr8=;
        b=JC9Dt8oDuQ5DGfl9SBDV4syZLlNwld2gHA7HGlhJS1cCPCPWOSmv9MOE4cY5iBbWS9
         5j0/lfeiK7ZhtcvsBXfX65upehxIQ68524wyLxzzOD+PwsfXb9nVTS80pwVjqAoVjoGa
         hY58oiVUy5BrjqSK0WB9w9nFR1+FOnl3fM0fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710806136; x=1711410936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6pBQRCTkt0thzPciZm+J+ubbehmNUxiTZuEht3ecr8=;
        b=jmlPJMBc+mx07DMuHl9qy017DrN4AXxMNNJ1Jq01lc8kXvo+5srLQ2Pfunh+cr1ri/
         LWVyAskhFQHbgUaaxmux8JZUgOab70eXGErgnnWcZrhTWcjj3TW+JU/+JQlEQ/xHgr3M
         GJR+gvWTFc3/vHLqhPpKIUQ2WUVGrNEORG1cfzo66TrccsXbu8Z8Td19cQv9Ycnn0nmB
         O5xtL0wWxIZkfs3PKMzzZSyea2Zfq95WhehdJphM+PiQIxq3MFe++GqHUCOa5c49DaUx
         +lYfWNQnOlwykbmH/6tdFrjXEGiJBSDPgTuMUeJvf68/1sa0I90rADux7TvLd0BIwTx5
         IMrw==
X-Forwarded-Encrypted: i=1; AJvYcCVPUhOItk54wtnkbp2txEh4RXrvxVBvkDUuFI+kNvo0N2FpWCLeDxeRpOHUh2Y+Wv6VF1lRh7Qc/+Do46wzp11EyTtUfVE0GwRZ0rT8
X-Gm-Message-State: AOJu0YxwYqQAKcaDaEQFKMz5bFwJfgqskur4NEqnv+hyPrhavJcYE+sd
	SuReUT+r7NH+HtygpmO7CUVTtgsEsLuBqcMKwr6XweZTrUwDivY6+VHqgBGn4khnhS2ZU6t31Gv
	kJQ==
X-Google-Smtp-Source: AGHT+IFBabBj+6xRu60riOc9EQF1MmElf0xBgwYMRJnZti1Q2kw6Mf8MiniTK/5OOo99/XzpC649HQ==
X-Received: by 2002:a05:6102:34ef:b0:474:cb60:cf3d with SMTP id bi15-20020a05610234ef00b00474cb60cf3dmr844617vsb.9.1710806136048;
        Mon, 18 Mar 2024 16:55:36 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id h15-20020ae9ec0f000000b00787930320b6sm4991690qkg.70.2024.03.18.16.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 16:55:35 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 18 Mar 2024 23:55:27 +0000
Subject: [PATCH 5/5] media: uvcvideo: Remove PLF device quirking
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-billion-v1-5-2f7bc0ee2030@chromium.org>
References: <20240318-billion-v1-0-2f7bc0ee2030@chromium.org>
In-Reply-To: <20240318-billion-v1-0-2f7bc0ee2030@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

We can use heuristics to figure out the proper range of the control
instead of quirking every single device.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c   |   4 +-
 drivers/media/usb/uvc/uvc_driver.c | 122 -------------------------------------
 drivers/media/usb/uvc/uvcvideo.h   |   2 -
 3 files changed, 2 insertions(+), 126 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 41578ded1174e..11ba1e8ee25b8 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -459,7 +459,7 @@ static void uvc_ctrl_set_rel_speed(struct uvc_control_mapping *mapping,
 	data[first+1] = min_t(int, abs(value), 0xff);
 }
 
-const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
+static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
 	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
 	.entity		= UVC_GUID_UVC_PROCESSING,
 	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
@@ -471,7 +471,7 @@ const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
 				  V4L2_CID_POWER_LINE_FREQUENCY_50HZ),
 };
 
-const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
+static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
 	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
 	.entity		= UVC_GUID_UVC_PROCESSING,
 	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index bbd90123a4e76..5f689fee60a9e 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2383,20 +2383,6 @@ MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
  * Driver initialization and cleanup
  */
 
-static const struct uvc_device_info uvc_ctrl_power_line_limited = {
-	.mappings = (const struct uvc_control_mapping *[]) {
-		&uvc_ctrl_power_line_mapping_limited,
-		NULL, /* Sentinel */
-	},
-};
-
-static const struct uvc_device_info uvc_ctrl_power_line_uvc11 = {
-	.mappings = (const struct uvc_control_mapping *[]) {
-		&uvc_ctrl_power_line_mapping_uvc11,
-		NULL, /* Sentinel */
-	},
-};
-
 static const struct uvc_device_info uvc_quirk_probe_minmax = {
 	.quirks = UVC_QUIRK_PROBE_MINMAX,
 };
@@ -2427,33 +2413,6 @@ static const struct uvc_device_info uvc_quirk_force_y8 = {
  * though they are compliant.
  */
 static const struct usb_device_id uvc_ids[] = {
-	/* Quanta USB2.0 HD UVC Webcam */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x0408,
-	  .idProduct		= 0x3090,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
-	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
-	/* Quanta USB2.0 HD UVC Webcam */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x0408,
-	  .idProduct		= 0x4030,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
-	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
-	/* Quanta USB2.0 HD UVC Webcam */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x0408,
-	  .idProduct		= 0x4034,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
-	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
 	/* LogiLink Wireless Webcam */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
@@ -2583,42 +2542,6 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_RESTRICT_FRAME_RATE) },
-	/* Chicony EasyCamera */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x04f2,
-	  .idProduct		= 0xb5eb,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
-	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
-	/* Chicony Electronics Co., Ltd Integrated Camera */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x04f2,
-	  .idProduct		= 0xb67c,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
-	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_uvc11 },
-	/* Chicony EasyCamera */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x04f2,
-	  .idProduct		= 0xb6ba,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
-	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
-	/* Chicony EasyCamera */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x04f2,
-	  .idProduct		= 0xb746,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
-	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
 	/* Alcor Micro AU3820 (Future Boy PC USB Webcam) */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
@@ -3003,51 +2926,6 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_FORCE_BPP) },
-	/* SunplusIT Inc HD Camera */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x2b7e,
-	  .idProduct		= 0xb752,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
-	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_uvc11 },
-	/* Lenovo Integrated Camera */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x30c9,
-	  .idProduct		= 0x0093,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
-	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_uvc11 },
-	/* Sonix Technology USB 2.0 Camera */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x3277,
-	  .idProduct		= 0x0072,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
-	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
-	/* Acer EasyCamera */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x5986,
-	  .idProduct		= 0x1172,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
-	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
-	/* Acer EasyCamera */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x5986,
-	  .idProduct		= 0x1180,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
-	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
 	/* Intel D410/ASR depth camera */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 611350a82c37f..896bb7362fa27 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -751,8 +751,6 @@ int uvc_status_start(struct uvc_device *dev, gfp_t flags);
 void uvc_status_stop(struct uvc_device *dev);
 
 /* Controls */
-extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited;
-extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11;
 extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
 
 int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,

-- 
2.44.0.291.gc1ea87d7ee-goog


