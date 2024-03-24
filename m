Return-Path: <linux-kernel+bounces-113797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9485888E91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF301F3347E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3CC1F9C1A;
	Sun, 24 Mar 2024 23:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iomq6AdI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E6C1E5872;
	Sun, 24 Mar 2024 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320833; cv=none; b=N70nYq2YF/HJHb8VC7AJhvljMvE7TOZ6VenrrEAHzScv13UDGL+Ac6k4v+VmkJA2kANlAAUm9b9yD4A2CM/k9N53X7Awpux9WWISg8+UtYWXKh0XFdg2iRyCEBKwTgP7AGfZaHKDtU7a2S/qROnnteo0ThaL3oBu6c0SNr0qR8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320833; c=relaxed/simple;
	bh=OJJPol7J7fIrfaytG9VmHCkxp+IgzNXZBKdiEqSucJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XT/+Ru3hYDlAoQCpInHrcckluwfVHZE7x55asNBQ9pi3VAbJd2PUc+sg+gZiJ3jg1+DNc9OjKBI3lw3kb4RIBiDJht+gL2E7FRT2OprNupkT0I+39dGlyyA3NWRwk10eduIsU3PQ5zC3q5ek+IB/1n4bigEdqUr3ufEGmN+TeGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iomq6AdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8DFC43390;
	Sun, 24 Mar 2024 22:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320832;
	bh=OJJPol7J7fIrfaytG9VmHCkxp+IgzNXZBKdiEqSucJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iomq6AdIW7tdFOtY9SSCGTLpg/uQY19ul6XclnZ6FgLw+T1c2gy8f32ubk8t/2LTS
	 /lBr6cRqB8UAQ7FzO9qyREEs6qfEcGERhE2ylEOHB+frmMvn8KrDH02RiyqVhm/nQ8
	 2kmY9Fpo6oRT68tazcSJeZKGygNMNN7ZsmNWNUTPxFU2G7QgFxJfNE2X3+FLiSKXYI
	 lQPf7ki79xJA3Up1FoSdLHvTs7/nriVABzChY4pMutpe1K0iTjhz6uPyygkWn5Exh+
	 Y92FbNwLWbzxgjQJ01te+3Ym7/wdtJZF9/+KFHT05An+a44/gHrOgo9Iqj3eZLKbBC
	 7Zc56kt9f1OeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Bee <knaerzche@gmail.com>,
	Zheng Yang <zhengyang@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 397/713] drm/rockchip: inno_hdmi: Fix video timing
Date: Sun, 24 Mar 2024 18:42:03 -0400
Message-ID: <20240324224720.1345309-398-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 6e5b922a121e2..345253e033c53 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -412,7 +412,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_H, (value >> 8) & 0xFF);
 
-	value = mode->hsync_start - mode->hdisplay;
+	value = mode->htotal - mode->hsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_H, (value >> 8) & 0xFF);
 
@@ -427,7 +427,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	value = mode->vtotal - mode->vdisplay;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VBLANK, value & 0xFF);
 
-	value = mode->vsync_start - mode->vdisplay;
+	value = mode->vtotal - mode->vsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VDELAY, value & 0xFF);
 
 	value = mode->vsync_end - mode->vsync_start;
-- 
2.43.0


