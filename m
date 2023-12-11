Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B8080C8C4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbjLKL7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjLKL7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:59:34 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FE1D12B;
        Mon, 11 Dec 2023 03:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=rcRLl
        amB9MT/I4Ai66VgiB8ZFN6GxQyGTKvo6+ftATo=; b=kwNap58kMxDg85Roz9PCn
        tWCS4hQ/rgxxTG/X1LGQkMDLD4Wrht3G8loEFOydmRHf0GRrfBkmlDoTc/vYytdp
        brqEr37EJlZixMGBDCXL2D20FHLtGxAyAtkp1riAOC/VAW0mb5b4up3ucmWG7xCV
        SJ6ZX7JKg6Wy0ErUuUMCEE=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g5-4 (Coremail) with SMTP id _____wBnh2wr+XZl6dziCw--.13089S2;
        Mon, 11 Dec 2023 19:57:34 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v5 03/16] drm/rockchip: vop2: set half_block_en bit in all mode
Date:   Mon, 11 Dec 2023 19:57:30 +0800
Message-Id: <20231211115730.1784893-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211115547.1784587-1-andyshrk@163.com>
References: <20231211115547.1784587-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBnh2wr+XZl6dziCw--.13089S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF47Jry8CFWrGw4Utr47urg_yoW5uFW7pr
        47ArWDKr4Dtr1jgFZ7JrZ8ZF4akws7Ka17XrZ8KwnYqrW3K3yDW3WkKr9rArZ8tryfuFW8
        XFn3ArW7urWIyF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jf18PUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBBDXmVOA44iuAAAsZ
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Yan <andy.yan@rock-chips.com>

At first we thought the half_block_en bit in AFBCD_CTRL register
only work in afbc mode. But the fact is that it control the line
buffer in all mode(afbc/tile/linear), so we need configure it in
all case.

As the cluster windows of rk3568 only supports afbc format
so is therefore not affected.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
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

