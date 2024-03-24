Return-Path: <linux-kernel+bounces-116166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 297BC8899FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFE41C32D50
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F73D3B5075;
	Mon, 25 Mar 2024 03:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9J2Qm4y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D15282A84;
	Sun, 24 Mar 2024 23:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323744; cv=none; b=c944qTBnavsqgnHZjrs03THp0g1xFkTR6aWPaqc/5BOKyPRD2KFD9OeueM2unEDwBxoP06M+JijJ5RXrrAUwfLCeCQCwo1FgIisB9SlylBTD9h+JpBKzzl9zTKv5yvkms4/HHFUHCOvKy5pvI6SGoXMJvnyf3MYawWHhRGp/GdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323744; c=relaxed/simple;
	bh=hHsHjQUDMUNwTrq8KfLKMh80GfvG17A8FJ8f8Y0O8Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWb8+IWhJ3sT2wgbWPLUw81+9g5/pH9wp8DQn0+jqrUD/7b7Fm62gDOuNFuGQaiX42ohz/4kDQwMtPDywsGf6tm1Jsz5KP6XSQsOGtWUc5hkK7cRH0U5Z7cS/hMV9mc6zADaeBnEw2089agK1CelY0Sqn7JXuf2OStOL6/K4iWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9J2Qm4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2A1C43330;
	Sun, 24 Mar 2024 23:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323743;
	bh=hHsHjQUDMUNwTrq8KfLKMh80GfvG17A8FJ8f8Y0O8Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r9J2Qm4y+mSojYLrQ68OvSe4dHma3U6AlgmfV14ktQHugjwDlWnLfFFjT8eebl/w1
	 XFeGj10/YlBMZU+BjvxY2AIay0E5PrPbQ000nCubZkyjTRmbX5fmpGBsbixuV9CSML
	 b/M0au2lsk3BWWrRj3hmxusHtcUyGzblqtIMSZvQ6zc+4aWDQjYBeMWJoKxfzi28w0
	 5Lb40Eq2f+FgpenmTDmZqSLaHtPxbzMB/wUsuNIBMnJjWtUSWgXY3yL0EwbhEPhmxe
	 3wukfn9Hu5jTNMXSpcU3/VATvwRip9dPQzdg5wQZNMYd+Ty/YqqUo+M3kcLbPLT3Z/
	 PsyS07pg6NQLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Bee <knaerzche@gmail.com>,
	Zheng Yang <zhengyang@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 118/238] drm/rockchip: inno_hdmi: Fix video timing
Date: Sun, 24 Mar 2024 19:38:26 -0400
Message-ID: <20240324234027.1354210-119-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Alex Bee <knaerzche@gmail.com>

[ Upstream commit 47a145c03484d33e65d773169d5ca1b9fe2a492e ]

The controller wants the difference between *total and *sync_start in the
HDMI_VIDEO_EXT_*DELAY registers. Otherwise the signal is very unstable for
certain non-VIC modes. See downstream commit [0].

[0] https://github.com/rockchip-linux/kernel/commit/8eb559f2502c

Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
Co-developed-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20231222174220.55249-4-knaerzche@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 78120da5e63aa..27540d308ccb9 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -402,7 +402,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_H, (value >> 8) & 0xFF);
 
-	value = mode->hsync_start - mode->hdisplay;
+	value = mode->htotal - mode->hsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_H, (value >> 8) & 0xFF);
 
@@ -417,7 +417,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	value = mode->vtotal - mode->vdisplay;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VBLANK, value & 0xFF);
 
-	value = mode->vsync_start - mode->vdisplay;
+	value = mode->vtotal - mode->vsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VDELAY, value & 0xFF);
 
 	value = mode->vsync_end - mode->vsync_start;
-- 
2.43.0


