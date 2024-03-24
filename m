Return-Path: <linux-kernel+bounces-115107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0563F888D22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6DE1F29CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747021C5DE4;
	Mon, 25 Mar 2024 01:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFzzlmyl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D617E18180F;
	Sun, 24 Mar 2024 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324091; cv=none; b=MDGvjX/MzfJ4bT0GxcraZ55wUQ5kmpmhWlbYGDH5+uGfQCX2ueyvp62aIWklmFmmiwE+PCF9pGq8MiKWyux1iuG8voglzHys+UVyRngl4EklcXgao8W27CRi+Rk4L9scZjNDHZOWaZY9cTC4XL1XOD980UmyFN5mFKkKZi0RVwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324091; c=relaxed/simple;
	bh=GMvWa03Qa7FSPRuDtAM5CuxjChNnwKQlEtknCNEXyko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tk2GFWFk3fIvfHKK4cArQArp+dbrTbIsvgjAoyo96qZdXBiZTEYzQf2+nx54eQtm9OyrW3QbwLwy0GW2FgSVI7PJ0KsuxAgpm82QnjUR0PBRPfZkjEdzDmMStHRHSl9PZdJGnFezjqXOxSUYdlPWA6JPFE6FKJSLvoC7EdIXpo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFzzlmyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D06FC433C7;
	Sun, 24 Mar 2024 23:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324090;
	bh=GMvWa03Qa7FSPRuDtAM5CuxjChNnwKQlEtknCNEXyko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BFzzlmylG7B8NxXmXHt5haHAc5w/h4TRI7Lbekarl431HUTdDqta+DCP6CcLZNDkW
	 p3fwEqC8luPddf7XrsAJWHP0LSXJTXHtVRkbfUjzoUfrn7Qo6DZ6CzLzpr0C3LDBZX
	 BApJO2Zz5YCk1t1oJZf4RVd/t4KNYirDondxcCBOhUA8j4sPrbU2vTaKEZqNjqDkK1
	 iDT3cme8gPck9wzVo2TyMJX01d6cOz94emke7hm48A9Mw+wr0Ln2rUQ+WzllHXBl5l
	 JODUw9kwq/PtRWtdUjyuFUPR5JNr8rYbE8sw4stn9L4AT3734oAnwESAQHy779TWEs
	 fnK8kI7kZ+I2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Bee <knaerzche@gmail.com>,
	Zheng Yang <zhengyang@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 091/183] drm/rockchip: inno_hdmi: Fix video timing
Date: Sun, 24 Mar 2024 19:45:04 -0400
Message-ID: <20240324234638.1355609-92-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index f2e2cc66f4897..95888e64bd8bc 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -401,7 +401,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_H, (value >> 8) & 0xFF);
 
-	value = mode->hsync_start - mode->hdisplay;
+	value = mode->htotal - mode->hsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_H, (value >> 8) & 0xFF);
 
@@ -416,7 +416,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	value = mode->vtotal - mode->vdisplay;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VBLANK, value & 0xFF);
 
-	value = mode->vsync_start - mode->vdisplay;
+	value = mode->vtotal - mode->vsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VDELAY, value & 0xFF);
 
 	value = mode->vsync_end - mode->vsync_start;
-- 
2.43.0


