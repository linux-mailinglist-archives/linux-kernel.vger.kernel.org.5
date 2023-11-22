Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ED37F471F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343960AbjKVMzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343894AbjKVMzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:55:25 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B0FF10FE;
        Wed, 22 Nov 2023 04:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=tYoJA
        rwx5aP3AfSu7ZMMs37JDWchsz6KUFhDAN1e+ZI=; b=IFd4/fQOi8uBFOx09ptdW
        mPm6tFLamHbO0JqS4j38xofVP2JobUxg5z+ezy6P8ts4NDe0UjgujJyivzk7OMTg
        fkZ0VHev90oXTUSG/JlVwwglsMjGy1I7wL/t5haxsUZibvv4tlM9sI9i0BvDuAXT
        nob9OQyNawXCnvEUnZflFE=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wBnZSoQ+l1luPr1Dg--.53824S2;
        Wed, 22 Nov 2023 20:54:44 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        s.hauer@pengutronix.de, Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 05/12] drm/rockchip: vop2: Set YUV/RGB overlay mode
Date:   Wed, 22 Nov 2023 20:54:38 +0800
Message-Id: <20231122125438.3454608-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122125316.3454268-1-andyshrk@163.com>
References: <20231122125316.3454268-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBnZSoQ+l1luPr1Dg--.53824S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF4xCFyUKw4ftw48tw1DZFb_yoW5tFW3pw
        n7ZryYgrWkKF4qgw1kJFyqvF4Skws2yay7Grn7Ca43uas0qryDW3Z8uas8AFsrXry7uryj
        yrZFkrWYyF4I9r7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jo1vsUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBnBcwXlghlh77hgAAsp
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Yan <andy.yan@rock-chips.com>

Set overlay mode register according to the
output mode is yuv or rgb.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_drv.h  |  1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 3d8ab2defa1b..7a58c5c9d4ec 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -51,6 +51,7 @@ struct rockchip_crtc_state {
 	u32 bus_format;
 	u32 bus_flags;
 	int color_space;
+	bool yuv_overlay;
 };
 #define to_rockchip_crtc_state(s) \
 		container_of(s, struct rockchip_crtc_state, base)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index a019cc9bbd54..b32a291c5caa 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1612,6 +1612,8 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vop2->enable_count++;
 
+	vcstate->yuv_overlay = is_yuv_output(vcstate->bus_format);
+
 	vop2_crtc_enable_irq(vp, VP_INT_POST_BUF_EMPTY);
 
 	polflags = 0;
@@ -1639,7 +1641,7 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 	if (vop2_output_uv_swap(vcstate->bus_format, vcstate->output_mode))
 		dsp_ctrl |= RK3568_VP_DSP_CTRL__DSP_RB_SWAP;
 
-	if (is_yuv_output(vcstate->bus_format))
+	if (vcstate->yuv_overlay)
 		dsp_ctrl |= RK3568_VP_DSP_CTRL__POST_DSP_OUT_R2Y;
 
 	vop2_dither_setup(crtc, &dsp_ctrl);
@@ -1948,10 +1950,12 @@ static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	u16 hdisplay;
 	u32 bg_dly;
 	u32 pre_scan_dly;
+	u32 ovl_ctrl;
 	int i;
 	struct vop2_video_port *vp0 = &vop2->vps[0];
 	struct vop2_video_port *vp1 = &vop2->vps[1];
 	struct vop2_video_port *vp2 = &vop2->vps[2];
+	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(vp->crtc.state);
 
 	adjusted_mode = &vp->crtc.state->adjusted_mode;
 	hsync_len = adjusted_mode->crtc_hsync_end - adjusted_mode->crtc_hsync_start;
@@ -1964,7 +1968,14 @@ static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	pre_scan_dly = ((bg_dly + (hdisplay >> 1) - 1) << 16) | hsync_len;
 	vop2_vp_write(vp, RK3568_VP_PRE_SCAN_HTIMING, pre_scan_dly);
 
-	vop2_writel(vop2, RK3568_OVL_CTRL, 0);
+	ovl_ctrl = vop2_readl(vop2, RK3568_OVL_CTRL);
+	if (vcstate->yuv_overlay)
+		ovl_ctrl |= BIT(vp->id);
+	else
+		ovl_ctrl &= ~BIT(vp->id);
+
+	vop2_writel(vop2, RK3568_OVL_CTRL, ovl_ctrl);
+
 	port_sel = vop2_readl(vop2, RK3568_OVL_PORT_SEL);
 	port_sel &= RK3568_OVL_PORT_SEL__SEL_PORT;
 
@@ -2036,9 +2047,11 @@ static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
 		layer_sel |= RK3568_OVL_LAYER_SEL__LAYER(nlayer + ofs, 5);
 	}
 
+	ovl_ctrl |= RK3568_OVL_CTRL__LAYERSEL_REGDONE_IMD;
+
 	vop2_writel(vop2, RK3568_OVL_LAYER_SEL, layer_sel);
 	vop2_writel(vop2, RK3568_OVL_PORT_SEL, port_sel);
-	vop2_writel(vop2, RK3568_OVL_CTRL, RK3568_OVL_CTRL__LAYERSEL_REGDONE_IMD);
+	vop2_writel(vop2, RK3568_OVL_CTRL, ovl_ctrl);
 }
 
 static void vop2_setup_dly_for_windows(struct vop2 *vop2)
-- 
2.34.1

