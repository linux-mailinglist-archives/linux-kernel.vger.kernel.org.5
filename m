Return-Path: <linux-kernel+bounces-33349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DA58368A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951011C22F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99E3651B9;
	Mon, 22 Jan 2024 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O57UgtE4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A006519B;
	Mon, 22 Jan 2024 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935951; cv=none; b=Yhd/OAasTSYyXa/lp4l5N/jykZ5rsMrNPlgoezyfzhzIEVP5WlgZjAXI7F6ZFnz379ubYqt8527iXJryD+clIvu1FbMHJj6pNy3UI1M4Avnp1zuF/BsmttxjUJ8RbW35VDQdKEl1NGKZ840oJQWieguHKhAf0dOJhr5rVgldBOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935951; c=relaxed/simple;
	bh=Q6sIsbe65AUAC9gyFfi7YSXgGHrOKXFTe+igPa6lJiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sI44+l4od1EEBJNqVWMnXpme/FYAS2P0/QAxG2ZC944qeBonILm4F7ZfCwt/4egZyEywtlWE+C+yzGqFHnyA2YDnk8XYlUUne7ttPAq23dPfUXxlFmFzv88Ow0kx6HCkMRp45UWq/0pM6dcm9yXKqlNhG0BBuM0iksvSvAwr2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O57UgtE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F15DC433F1;
	Mon, 22 Jan 2024 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935951;
	bh=Q6sIsbe65AUAC9gyFfi7YSXgGHrOKXFTe+igPa6lJiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O57UgtE4a4RqD5CixrGRokw6EaqMiMyisnMYtv3n73Tsxe5MaCIbu83ZFutYWWDmW
	 CLpkzfOzsSxYh5216tQKPNxD2rtLYaZAswwP8GWlv1YhZ3UcckKd8LZZV04ebozXLM
	 +dsZxpWFSdgl45MgTm/3QGSze7ZA9yYM/d+zG6h1LVDJrWS41IpuyaJ9DXvy/3WtNE
	 /ifXh5NQk/3E6ZH9qCuReypPmbwCl4RWWQTRcVHXH7kb6x0hHgwisN136gI8lpQJpn
	 G+xs/uCK9fB8/i4EhoN0Mk8Q/5Iw4rENNhqwqUzWd+S6ht6dm+3BCo4JL9i7nQLuG7
	 gXXRQWRcLsXGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 27/73] media: uvcvideo: Fix power line control for a Chicony camera
Date: Mon, 22 Jan 2024 10:01:41 -0500
Message-ID: <20240122150432.992458-27-sashal@kernel.org>
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


