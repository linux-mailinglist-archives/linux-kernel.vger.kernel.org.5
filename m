Return-Path: <linux-kernel+bounces-33251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B2983674A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A9D28ED72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F40D50A90;
	Mon, 22 Jan 2024 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA8PcUpM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F5C50A77;
	Mon, 22 Jan 2024 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935498; cv=none; b=CNCRyQPsu34bkvlLquWS1CeCv7g4eFqWsLypj1Wb3ZVxuzGDHVTQNT6uWvkWtSmerCQzW0Qy7FSnGZ6PusQjCYGI9mj2NaGywYN3rPE8nv9HxrO8qIQB/Tzn/JmgaBIWQerYdozg9Y3ADQcCr3FRsvx3P2WYyUf1r8xud+mGyRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935498; c=relaxed/simple;
	bh=Q6sIsbe65AUAC9gyFfi7YSXgGHrOKXFTe+igPa6lJiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5urL1bGHfZ5m+okOA/LJQ2j7t+v2ceqiYgiN9bLwHby50azVsq6NPjjdw+rUcH4pC1ucGAYWllwAuTDNXgmpE1PR/gbeI8kfTWui9rj4pwJ5b4RaudvjVFMnrX6ZRebylps6k+I6r8Ze7ioF/oWu3RnPyCFXLM4x7kA8BYWv/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA8PcUpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326F8C433C7;
	Mon, 22 Jan 2024 14:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935498;
	bh=Q6sIsbe65AUAC9gyFfi7YSXgGHrOKXFTe+igPa6lJiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DA8PcUpMzzIrILDYOJi8qunu94bKbb7sKJIH4VGPAu2NkxSF0TT0zrT9nDwvuHyco
	 4gGNEk6Wn6D7Q9O6eM5yxEb0uAGbEN67M5SAYFV3hbEKORLl0xRLc2qHgfpJPLPV7L
	 dX9pLVpQCZSjX+LSeurRyfIqiIpt/5itn37GhUyeL/Cz3j/+29F2eIYjrkCkMkTlVa
	 j09oyHLNQ7zs+a26VRFB00EzNrSwBT3gSKShwootuWD52DQi62uBbm8lphWU9ay2cO
	 NmilKNHXzHAygOMWIvGsqhXuuz7RADIrkHmpbefMYN5VkXWKMB7nim7XVf40ys/HRj
	 Eyvv9NySfDExg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 33/88] media: uvcvideo: Fix power line control for a Chicony camera
Date: Mon, 22 Jan 2024 09:51:06 -0500
Message-ID: <20240122145608.990137-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Ricardo Ribalda <ribalda@chromium.org>

[ Upstream commit dba3e701917a4cce92920f8ccb9fa4d4ee5ac07e ]

The device does not implement the control properly.

Fixes v4l2-compliance error:

info: checking control 'Power Line Frequency' (0x00980918)
fail: v4l2-test-controls.cpp(552): could not set valid menu item 3

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 08fcd2ffa727..4b5ea3501753 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2592,6 +2592,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
+	/* Chicony Electronics Co., Ltd Integrated Camera */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x04f2,
+	  .idProduct		= 0xb67c,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
+	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_uvc11 },
 	/* Chicony EasyCamera */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
-- 
2.43.0


