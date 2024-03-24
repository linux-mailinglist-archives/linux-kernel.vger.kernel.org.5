Return-Path: <linux-kernel+bounces-116327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 433D4889E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA114291E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700FA18636C;
	Mon, 25 Mar 2024 03:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chaNTRUL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BAC294E22;
	Sun, 24 Mar 2024 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324296; cv=none; b=Q8AHAgJw2YSQpSoqxcaMDy7THcLr9jR9mYGzrQTrBjvAKua1raO2zgHrc59pq9cGeRtr4QmnWpp5JgywDd1XOGNLg8LC5bE760BDuLPpXzTcGDknwJQyv3DQuXJjM/Ubj/lWi44m7463LffRvUFjgZt+7RvBaC7irfUUnXoQvZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324296; c=relaxed/simple;
	bh=kWGuqHl5CC1lHEqPCwaKWVxeC8jkTmBoQhuiTXg7F9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8G6HKH6qxLzEb+QTtIfkHcYK2lBMSejAsXXhPaIFuOIItUaUrgjhpYBlkLyGAqOBsqUWePj3R4Gzw82saATUNUbhMahvKdQHfdoZVxcn3jnbLipYK61frYCdfw0VMqRXHRyk6BjH6om5AldJVl1C/YCIRZ1mLU085If5nK50xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chaNTRUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907E3C433F1;
	Sun, 24 Mar 2024 23:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324296;
	bh=kWGuqHl5CC1lHEqPCwaKWVxeC8jkTmBoQhuiTXg7F9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chaNTRUL43hmwuWPrF/nhz5WsX6Jvb+HvCCMYfds1lvxy8Y0OeS9Gggu2ngUCJrEv
	 e0gWRhu1D4gMjb9r5DNKWoKVcfnoAQm7eLy9NMoSkYUlF6NYIj0XLF4E0AXAdS6co1
	 kxg5aOe9j13q/QkwfnYI5EYYjezugNie/prQzV2Wl3A/31CABja+XByyLWIn8o2Wip
	 uGxTFupHJPX2KtkZCxXdduiPXqTVXnl2d4bM2D4gWH+23yjGm7tHq4124l4FI0IYhC
	 a7W97JllZr6aSr5Kdw7z/G9ohrXDZ17UyaYaiQdkvYdmRmT2jz37axZop/zlUbWAPl
	 Uevh2ADPytSYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Bee <knaerzche@gmail.com>,
	Zheng Yang <zhengyang@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 071/148] drm/rockchip: inno_hdmi: Fix video timing
Date: Sun, 24 Mar 2024 19:48:55 -0400
Message-ID: <20240324235012.1356413-72-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 1c02b3e61299c..229a1c908ad02 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -408,7 +408,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HBLANK_H, (value >> 8) & 0xFF);
 
-	value = mode->hsync_start - mode->hdisplay;
+	value = mode->htotal - mode->hsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_L, value & 0xFF);
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_HDELAY_H, (value >> 8) & 0xFF);
 
@@ -423,7 +423,7 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 	value = mode->vtotal - mode->vdisplay;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VBLANK, value & 0xFF);
 
-	value = mode->vsync_start - mode->vdisplay;
+	value = mode->vtotal - mode->vsync_start;
 	hdmi_writeb(hdmi, HDMI_VIDEO_EXT_VDELAY, value & 0xFF);
 
 	value = mode->vsync_end - mode->vsync_start;
-- 
2.43.0


