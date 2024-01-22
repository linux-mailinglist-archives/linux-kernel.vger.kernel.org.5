Return-Path: <linux-kernel+bounces-33350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC868368A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642F3285A74
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4533657C3;
	Mon, 22 Jan 2024 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtFEAi4h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7059657B5;
	Mon, 22 Jan 2024 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935953; cv=none; b=AfVcHy+Xn+Zn7B7SnVo5dGoesjsqBItM/ZTGtVjGLQ5UMd2NQwFAJuYWeeEbRKxMJFfi5iW5qWsykoTcdPcZ47DIs9gvyzJTA8GkLt3gnbuABxN1leRs4CUymdPqkftEi8E2TrFsypz6FGkQ1pNWQXcEgA2iN+c5ocHVhoCcYmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935953; c=relaxed/simple;
	bh=17GJmfWLs0KsSK1OBeqzc+y2Vq8O9026U5moTOdSgME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4i76GzRRS814q5ebBGxEAN6UWWYJXdxaU9gVUmJF1cvk+UV9TY4ye3pjVBm9ekCsGHRjBwILo8kd5JqI+OnjMQs0MYqYFpR/FV9SinDpDQB8DxjMn9ztLVEGGKe6egODgGiK4+LUoOJERia01l8lUJ53QRWtvEJ9H5pfkU+rHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtFEAi4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D34C43390;
	Mon, 22 Jan 2024 15:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935952;
	bh=17GJmfWLs0KsSK1OBeqzc+y2Vq8O9026U5moTOdSgME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZtFEAi4hcli+6aV2SXRwv/Ls61q/OEk1kLSWblufrqQVazU6iYgUid7AHwfW/2cIE
	 +5umiUddt4AWDm+k2tKaPrhuwusc/LKwVNKL+4C5SIc2TvKd8RqewEBzAO3fgwoUu7
	 wqQxVkfArUBlIO2ODDrCZPLMRQGqDKX6LuNa4ILrOMZPqN5efiyAGCAAG0cSTzb/oK
	 QpVLOraEa389Gk52ohU8ElhjIYIpd7VzvaxE+nXyL3whJRkdiFgu3BBWPx6WTYeMqj
	 bbdP4eqIwh/34NudJF3fLZdkGtjv6uVL9I2yUhv/OB3itZ+pjZmO2i9lNY3WqR2MMx
	 mFkuoeA7OK09A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Yunke Cao <yunkec@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 28/73] media: uvcvideo: Fix power line control for SunplusIT camera
Date: Mon, 22 Jan 2024 10:01:42 -0500
Message-ID: <20240122150432.992458-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: Ricardo Ribalda <ribalda@chromium.org>

[ Upstream commit 6180056b0e0c097dad5d1569dcd661eaf509ea43 ]

The device does not implement the power line frequency control
correctly. It is a UVC 1.5 device, but implements the control as a UVC
1.1 device.

Add the corresponding control mapping override.

Bus 003 Device 002: ID 2b7e:b752 SunplusIT Inc HD Camera
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.01
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x2b7e
  idProduct          0xb752
  bcdDevice            0.04
  iManufacturer           1 SunplusIT Inc
  iProduct                2 HD Camera
  iSerial                 3 01.00.00
  bNumConfigurations      1

Cc: Yunke Cao <yunkec@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 4b5ea3501753..bbd90123a4e7 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -3003,6 +3003,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_FORCE_BPP) },
+	/* SunplusIT Inc HD Camera */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x2b7e,
+	  .idProduct		= 0xb752,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
+	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_uvc11 },
 	/* Lenovo Integrated Camera */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
-- 
2.43.0


