Return-Path: <linux-kernel+bounces-159090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9929B8B2930
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF8F1C214BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81F8152E1A;
	Thu, 25 Apr 2024 19:55:21 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A77015250B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 19:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714074921; cv=none; b=SKnlKu9hLNvxxekzcJTs8rm334bFgdIra5e7o1mloovY6sLhwRw5CbZaThN+xrJSd9gMf83k1gR8rDI1bTLJEp14GXEKVlOba3+yJ2edoo7bPCXVHnoa1weN8bm0+g19XxgIvYndhHuKmyPZCDU0SKm7cG764znTgMdJYCSqA68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714074921; c=relaxed/simple;
	bh=20aN88zHAaaE7qI4lJaDymBfFXqYf9mSZVUZZrCxKd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WSJVWHlOAyS5Wpufxm8qCA8H0WhGyiQ+kRYazbT2MwRlbtByEn07RzddkM318SxQZb2u/zJ+Wz3zS+QawxRizjICoNQpBVvAdofbJ7jSXLm4o6YrNeZH0GKhmQSrP13WICROtAuqjpLFkfti9jcjWm6kdLv6meztlx7H8mGQ2Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b01.versanet.de ([83.135.91.1] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s05BY-0005vK-29; Thu, 25 Apr 2024 21:55:12 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@theobroma-systems.com,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 2/2] drm/rockchip: vop2: configure layers for vp3 on rk3588
Date: Thu, 25 Apr 2024 21:55:06 +0200
Message-Id: <20240425195506.2935955-3-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240425195506.2935955-1-heiko@sntech.de>
References: <20240425195506.2935955-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The rk3588 VOP2 has 4 video-ports, yet the driver currently only
configures the first 3, as used on the rk3568.

Add another block to configure the vp3 as well, if applicable.

Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 12 ++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 523880a4e8e74..1a327a9ed7ee4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2303,6 +2303,7 @@ static void vop2_setup_alpha(struct vop2_video_port *vp)
 static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
 {
 	struct vop2 *vop2 = vp->vop2;
+	const struct vop2_data *vop2_data = vop2->data;
 	struct drm_plane *plane;
 	u32 layer_sel = 0;
 	u32 port_sel;
@@ -2344,6 +2345,17 @@ static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	else
 		port_sel |= FIELD_PREP(RK3568_OVL_PORT_SET__PORT2_MUX, 8);
 
+	/* configure vp3 */
+	if (vop2_data->soc_id == 3588) {
+		struct vop2_video_port *vp3 = &vop2->vps[3];
+
+		if (vp3->nlayers)
+			port_sel |= FIELD_PREP(RK3588_OVL_PORT_SET__PORT3_MUX,
+				(vp3->nlayers + vp2->nlayers + vp1->nlayers + vp0->nlayers - 1));
+		else
+			port_sel |= FIELD_PREP(RK3588_OVL_PORT_SET__PORT3_MUX, 8);
+	}
+
 	layer_sel = vop2_readl(vop2, RK3568_OVL_LAYER_SEL);
 
 	ofs = 0;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index 615a16196aff6..f46fb795414e1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -489,6 +489,7 @@ enum dst_factor_mode {
 #define RK3588_OVL_PORT_SEL__CLUSTER2			GENMASK(21, 20)
 #define RK3568_OVL_PORT_SEL__CLUSTER1			GENMASK(19, 18)
 #define RK3568_OVL_PORT_SEL__CLUSTER0			GENMASK(17, 16)
+#define RK3588_OVL_PORT_SET__PORT3_MUX			GENMASK(15, 12)
 #define RK3568_OVL_PORT_SET__PORT2_MUX			GENMASK(11, 8)
 #define RK3568_OVL_PORT_SET__PORT1_MUX			GENMASK(7, 4)
 #define RK3568_OVL_PORT_SET__PORT0_MUX			GENMASK(3, 0)
-- 
2.39.2


