Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4217808265
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378059AbjLGICJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjLGICE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:02:04 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC3CE10EC;
        Thu,  7 Dec 2023 00:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=VvpYT
        W40NZ46U/uC3kxp5psTC7U46RpXFvNEExH8M2A=; b=IQ008HFp5OA3GgxNQsPyq
        hv/z0ZxaYe2bxDJCj/rqLB1bEBTCF8GJ7NqCbMbkdOZTuV4XboNI/nQz9OVFwe7c
        r0fAIKQWx32Ne4FGO1VxIztm/a28xQChjnqEilr9UvY18/g/3VXISE2kakhF414I
        ercPPE6F5ZpLu2Y1RuwykQ=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g5-4 (Coremail) with SMTP id _____wDXP+u5e3FlrnEFCg--.40966S2;
        Thu, 07 Dec 2023 16:01:01 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v4 07/17] drm/rockchip: vop2: set bg dly and prescan dly at vop2_post_config
Date:   Thu,  7 Dec 2023 16:00:55 +0800
Message-Id: <20231207080055.652230-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207075906.651771-1-andyshrk@163.com>
References: <20231207075906.651771-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXP+u5e3FlrnEFCg--.40966S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw4kZw1UJrWUtF15Ww1Utrb_yoW5Xr4rp3
        4fGry3CrWUJF4qvw1kZa4DZr4fKws7tr47JFW7Jas2yF90qr9xZwn8urn8GrWqqFy7AFy2
        9rWvgrWYgF1akr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSOJnUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBnAs-Xlghl3ZClgABs7
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Yan <andy.yan@rock-chips.com>

We need to setup background delay cycle and prescan
delay cycle when a mode is enable to avoid trigger
POST_BUF_EMPTY irq on rk3588.

Note: RK356x has no such requirement.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 26 ++++++++------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 40b5c5ca4864..d52395b6aff7 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1460,8 +1460,18 @@ static void vop2_post_config(struct drm_crtc *crtc)
 	u32 top_margin = 100, bottom_margin = 100;
 	u16 hsize = hdisplay * (left_margin + right_margin) / 200;
 	u16 vsize = vdisplay * (top_margin + bottom_margin) / 200;
+	u16 hsync_len = mode->crtc_hsync_end - mode->crtc_hsync_start;
 	u16 hact_end, vact_end;
 	u32 val;
+	u32 bg_dly;
+	u32 pre_scan_dly;
+
+	bg_dly = vp->data->pre_scan_max_dly[3];
+	vop2_writel(vp->vop2, RK3568_VP_BG_MIX_CTRL(vp->id),
+		    FIELD_PREP(RK3568_VP_BG_MIX_CTRL__BG_DLY, bg_dly));
+
+	pre_scan_dly = ((bg_dly + (hdisplay >> 1) - 1) << 16) | hsync_len;
+	vop2_vp_write(vp, RK3568_VP_PRE_SCAN_HTIMING, pre_scan_dly);
 
 	vsize = rounddown(vsize, 2);
 	hsize = rounddown(hsize, 2);
@@ -1956,11 +1966,6 @@ static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	u32 layer_sel = 0;
 	u32 port_sel;
 	unsigned int nlayer, ofs;
-	struct drm_display_mode *adjusted_mode;
-	u16 hsync_len;
-	u16 hdisplay;
-	u32 bg_dly;
-	u32 pre_scan_dly;
 	u32 ovl_ctrl;
 	int i;
 	struct vop2_video_port *vp0 = &vop2->vps[0];
@@ -1968,17 +1973,6 @@ static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	struct vop2_video_port *vp2 = &vop2->vps[2];
 	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(vp->crtc.state);
 
-	adjusted_mode = &vp->crtc.state->adjusted_mode;
-	hsync_len = adjusted_mode->crtc_hsync_end - adjusted_mode->crtc_hsync_start;
-	hdisplay = adjusted_mode->crtc_hdisplay;
-
-	bg_dly = vp->data->pre_scan_max_dly[3];
-	vop2_writel(vop2, RK3568_VP_BG_MIX_CTRL(vp->id),
-		    FIELD_PREP(RK3568_VP_BG_MIX_CTRL__BG_DLY, bg_dly));
-
-	pre_scan_dly = ((bg_dly + (hdisplay >> 1) - 1) << 16) | hsync_len;
-	vop2_vp_write(vp, RK3568_VP_PRE_SCAN_HTIMING, pre_scan_dly);
-
 	ovl_ctrl = vop2_readl(vop2, RK3568_OVL_CTRL);
 	ovl_ctrl |= RK3568_OVL_CTRL__LAYERSEL_REGDONE_IMD;
 	if (vcstate->yuv_overlay)
-- 
2.34.1

