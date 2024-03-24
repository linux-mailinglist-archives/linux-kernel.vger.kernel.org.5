Return-Path: <linux-kernel+bounces-115944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF1D889913
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A05B46001
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7B939002C;
	Mon, 25 Mar 2024 03:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRZUC7sC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6862415B578;
	Sun, 24 Mar 2024 23:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322166; cv=none; b=EORAYpvXpDH7gViI7/Bw3qRJqYfUncNGLIYi58IGAMj2VvMbEHMUt1g9iNfyBkPO0X8Rm63M+2Dc0ajqhADsGpPJ/bW0cJVB6F2uG97tlxgeHN7cqndA44ll+YrzMt8CLkjfp7pRZGV8CbDI2prteUOy08MmU+5XTKdPvCt8fc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322166; c=relaxed/simple;
	bh=To4HsCrsnedksP+Kzm+hV1nDB+dQos6t+2a1BObyQHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYWrEv5a1BWV4HOyqpSj/5W4lh3EkM1oso6Yebup7jGYQ88AFcm3DxzCGoOQgrvsci0Ns5ZPGz3WdIo9UrvmqmIMh8J+xsdABcQ0Mkfra0MlEp6tP2rJZqAQGrv9JyqqaGgsiD+01lJIZGRJEK/S9T+AQBWN7B3sqUts79ZR3Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRZUC7sC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358DEC433F1;
	Sun, 24 Mar 2024 23:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322165;
	bh=To4HsCrsnedksP+Kzm+hV1nDB+dQos6t+2a1BObyQHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRZUC7sCDcSca5IkcQbYB1eDPrB723ZmevSj5nN08vsEooV3VMAPRuKlj/tvFAds9
	 q8twoWBnFcyRQTylsfDX2V5SpFxnRk8nknE4tQfJVEjG+3iv+mZHoJMm7myTj1e8zF
	 i86rcwr1ZEiaUDcnpBSAObiht35ErnPOU5KOsc+3hM9LQSBh84vOUKxuRidkHYtXNn
	 iUTCdD7Olvp6RDJHT+DYAXZBk5w6nZ2yD8tVepuxk2yeC/9nApGTZbJvADUiezyr+B
	 xJz9b4orFh+YEiewSFT7X/tur+cPhqfFcTSWdaluBRo8YWoegUYTbvzliITln67y9Y
	 AwutSlykuJaWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Bee <knaerzche@gmail.com>,
	Zheng Yang <zhengyang@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 244/451] drm/rockchip: inno_hdmi: Fix video timing
Date: Sun, 24 Mar 2024 19:08:40 -0400
Message-ID: <20240324231207.1351418-245-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index f51774866f412..8f230f4c01bc3 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -411,7 +411,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_H, (value >> 8) & 0xFF);
 
-	value = mode->hsync_start - mode->hdisplay;
+	value = mode->htotal - mode->hsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_H, (value >> 8) & 0xFF);
 
@@ -426,7 +426,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	value = mode->vtotal - mode->vdisplay;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VBLANK, value & 0xFF);
 
-	value = mode->vsync_start - mode->vdisplay;
+	value = mode->vtotal - mode->vsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VDELAY, value & 0xFF);
 
 	value = mode->vsync_end - mode->vsync_start;
-- 
2.43.0


