Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF407F4717
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343966AbjKVMzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343967AbjKVMy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:54:59 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5998ED40;
        Wed, 22 Nov 2023 04:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=VA7b6
        WBTMIAGBJxNdRyiCDjOIsP+lU6aHbLbiR0LI+E=; b=L3uibHnxQ7RVihcugKUQJ
        dCgo1WZJwNACPvrljQZvbed0B2R7SQpH7F0u2/rw+u8mVLZXL5eBuwz8KmgDdAep
        ChH78ju6z3bE9a7W4C2aXsba8bhh1x+cWw9EYKp7ls6yRLAd7nz8AqKPGZsmAFAm
        mVWP4udDU6qtmcBykuhDSY=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wBHVG72+V1lbLH7BQ--.50817S2;
        Wed, 22 Nov 2023 20:54:18 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        s.hauer@pengutronix.de, Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 03/12] drm/rockchip: vop2: set half_block_en bit in all mode
Date:   Wed, 22 Nov 2023 20:54:13 +0800
Message-Id: <20231122125413.3454489-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122125316.3454268-1-andyshrk@163.com>
References: <20231122125316.3454268-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHVG72+V1lbLH7BQ--.50817S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF47tw4UJF1DWr13Kr4DArb_yoW5ZF48pr
        47ArWDKr4DKr1jgFZ7JrZ8ZF4akws3Ka17XrZxKwnYqrWak3yDW3WkKr9rArZ8tryfuFW8
        XFn3CrW7urWIyF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSa0PUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiFhwwXl44X9nwQAAAs0
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Yan <andy.yan@rock-chips.com>

At first we thought the half_block_en bit in AFBCD_CTRL register
only work in afbc mode. But the fact is that it control the line
buffer in all mode(afbc/tile/line), so we need configure it in
all case.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 25 ++++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 57784d0a22a6..639dfebc6bd1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -521,6 +521,18 @@ static bool rockchip_vop2_mod_supported(struct drm_plane *plane, u32 format,
 	return vop2_convert_afbc_format(format) >= 0;
 }
 
+/*
+ * 0: Full mode, 16 lines for one tail
+ * 1: half block mode, 8 lines one tail
+ */
+static bool vop2_half_block_enable(struct drm_plane_state *pstate)
+{
+	if (pstate->rotation & (DRM_MODE_ROTATE_270 | DRM_MODE_ROTATE_90))
+		return false;
+	else
+		return true;
+}
+
 static u32 vop2_afbc_transform_offset(struct drm_plane_state *pstate,
 				      bool afbc_half_block_en)
 {
@@ -1144,6 +1156,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 	bool rotate_90 = pstate->rotation & DRM_MODE_ROTATE_90;
 	struct rockchip_gem_object *rk_obj;
 	unsigned long offset;
+	bool half_block_en;
 	bool afbc_en;
 	dma_addr_t yrgb_mst;
 	dma_addr_t uv_mst;
@@ -1236,6 +1249,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 	dsp_info = (dsp_h - 1) << 16 | ((dsp_w - 1) & 0xffff);
 
 	format = vop2_convert_format(fb->format->format);
+	half_block_en = vop2_half_block_enable(pstate);
 
 	drm_dbg(vop2->drm, "vp%d update %s[%dx%d->%dx%d@%dx%d] fmt[%p4cc_%s] addr[%pad]\n",
 		vp->id, win->data->name, actual_w, actual_h, dsp_w, dsp_h,
@@ -1243,6 +1257,9 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 		&fb->format->format,
 		afbc_en ? "AFBC" : "", &yrgb_mst);
 
+	if (vop2_cluster_window(win))
+		vop2_win_write(win, VOP2_WIN_AFBC_HALF_BLOCK_EN, half_block_en);
+
 	if (afbc_en) {
 		u32 stride;
 
@@ -1283,13 +1300,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 		vop2_win_write(win, VOP2_WIN_AFBC_UV_SWAP, uv_swap);
 		vop2_win_write(win, VOP2_WIN_AFBC_AUTO_GATING_EN, 0);
 		vop2_win_write(win, VOP2_WIN_AFBC_BLOCK_SPLIT_EN, 0);
-		if (pstate->rotation & (DRM_MODE_ROTATE_270 | DRM_MODE_ROTATE_90)) {
-			vop2_win_write(win, VOP2_WIN_AFBC_HALF_BLOCK_EN, 0);
-			transform_offset = vop2_afbc_transform_offset(pstate, false);
-		} else {
-			vop2_win_write(win, VOP2_WIN_AFBC_HALF_BLOCK_EN, 1);
-			transform_offset = vop2_afbc_transform_offset(pstate, true);
-		}
+		transform_offset = vop2_afbc_transform_offset(pstate, half_block_en);
 		vop2_win_write(win, VOP2_WIN_AFBC_HDR_PTR, yrgb_mst);
 		vop2_win_write(win, VOP2_WIN_AFBC_PIC_SIZE, act_info);
 		vop2_win_write(win, VOP2_WIN_AFBC_TRANSFORM_OFFSET, transform_offset);
-- 
2.34.1

