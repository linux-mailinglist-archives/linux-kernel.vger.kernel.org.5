Return-Path: <linux-kernel+bounces-18129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D1A825938
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BE31C21DB0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08E434541;
	Fri,  5 Jan 2024 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KsUqs6qp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8958328DB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704476409;
	bh=hWk1W4Y/uqGBsgP+2O2pUAprqjBWjIZHflJNW21OcLE=;
	h=From:To:Cc:Subject:Date:From;
	b=KsUqs6qpuGBnBzSYHOMDounBY2qPlZe2mMPtFXri5Qaj74t1aVz/xAk1OxVnfr/ox
	 2eRiHt/5maTLd+yk2TaNG/DmoT2F0JJODIcP0q7y7aryeHseCLkIZ1lib7igGoD/ij
	 ypnshdEqI9ATVP75qRqfJlhuN9ebn9ZDq14wUVTZgdSfvt5yn6SmxQy8l2dIuPG/Nn
	 wyke6lv7it/qELjg6nOnZ/L4cSiyKNfmLIhh+9B8n6FBrFetMRsQvZ0vFIO7RTc1oX
	 Ct/jT2jVoPS1ko3JdY4Z4io6XwulTg9DMn0fcZK9c+ccDXJlYRTC0Ia6qVKts4PkRi
	 2P2/z5SBYIyjQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 89A3D378003D;
	Fri,  5 Jan 2024 17:40:09 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v2] drm/rockchip: vop2: Drop unused if_dclk_rate variable
Date: Fri,  5 Jan 2024 19:40:06 +0200
Message-ID: <20240105174007.98054-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
introduced a variable which ended up being unused:

rockchip_drm_vop2.c:1688:23: warning: variable ‘if_dclk_rate’ set but not used [-Wunused-but-set-variable]

This has been initially used as part of a formula to compute the clock
dividers, but eventually it has been replaced by static values.

Drop the variable declaration and move its assignment to the comment
block, to serve as documentation of how the constants have been
generated.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v2:
 - Move variable assignment to comment block, per Heiko's review
 - Update commit message

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 89afeadd0bad..b7b44b69cc8c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1684,7 +1684,6 @@ static unsigned long rk3588_calc_cru_cfg(struct vop2_video_port *vp, int id,
 	unsigned long dclk_core_rate = v_pixclk >> 2;
 	unsigned long dclk_rate = v_pixclk;
 	unsigned long dclk_out_rate;
-	unsigned long if_dclk_rate;
 	unsigned long if_pixclk_rate;
 	int K = 1;
 
@@ -1699,8 +1698,8 @@ static unsigned long rk3588_calc_cru_cfg(struct vop2_video_port *vp, int id,
 		}
 
 		if_pixclk_rate = (dclk_core_rate << 1) / K;
-		if_dclk_rate = dclk_core_rate / K;
 		/*
+		 * if_dclk_rate = dclk_core_rate / K;
 		 * *if_pixclk_div = dclk_rate / if_pixclk_rate;
 		 * *if_dclk_div = dclk_rate / if_dclk_rate;
 		 */
-- 
2.43.0


