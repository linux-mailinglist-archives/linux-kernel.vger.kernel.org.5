Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E82E7D8902
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjJZTgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjJZTgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:36:40 -0400
X-Greylist: delayed 652 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 12:36:37 PDT
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3A8121
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1698348995;
 bh=H5xROb9Mq7jaJ0zsDNHjRXkPAmzwRa/v5qsxfjL/qww=;
 b=POM6mqM7qlNC3MLnjaGw7voec3OKp5nDEb3R/KN1i+PwynTHF0dyWPlF1p/C04FESVi462gUr
 Uggf/CrGpOKpfDqvyQbKqW0hsHqO/fIVFVGhe7qE3/GcOvX9xQpiJ9IbPK/comawHDvXSdZH2uQ
 yL8lMxixjEmPwfyMRzrpJ5+M/Jo647WDueY4lJ6zzgZGROCtGE2pPTPJCqIPgjoN4ZopgArrpqC
 6QFvG3K5C42pH8QdLu/VZwUN/YLYGdxLuMDMH+9VOiHtCFHPrvrkHz4V5drDwGIGpvjA4USoPFn
 LBpDdwEEWZ2gH/BobIAz/r1nyByMrr3zOC4RE40Qu3dw==
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomasz Figa <tfiga@chromium.org>
Cc:     Christopher Obbard <chris.obbard@collabora.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/rockchip: vop: Fix color for RGB888/BGR888 format on VOP full
Date:   Thu, 26 Oct 2023 19:14:58 +0000
Message-ID: <20231026191500.2994225-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 653ababbbb49096ed18860ca
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of DRM_FORMAT_RGB888 and DRM_FORMAT_BGR888 on e.g. RK3288, RK3328
and RK3399 result in wrong colors being displayed.

The issue can be observed using modetest:

  modetest -s <connector_id>@<crtc_id>:1920x1080-60@RG24
  modetest -s <connector_id>@<crtc_id>:1920x1080-60@BG24

Vendor 4.4 kernel apply an inverted rb swap for these formats on VOP
full framework (IP version 3.x) compared to VOP little framework (2.x).

Fix colors by applying different rb swap for VOP full framework (3.x)
and VOP little framework (2.x) similar to vendor 4.4 kernel.

Fixes: 85a359f25388 ("drm/rockchip: Add BGR formats to VOP")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Add comment about different rb swap for IP version 3.x and 2.x
- Add fixes tag

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index b3d0b6ae9294..ed2ed25959a2 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -247,14 +247,22 @@ static inline void vop_cfg_done(struct vop *vop)
 	VOP_REG_SET(vop, common, cfg_done, 1);
 }
 
-static bool has_rb_swapped(uint32_t format)
+static bool has_rb_swapped(uint32_t version, uint32_t format)
 {
 	switch (format) {
 	case DRM_FORMAT_XBGR8888:
 	case DRM_FORMAT_ABGR8888:
-	case DRM_FORMAT_BGR888:
 	case DRM_FORMAT_BGR565:
 		return true;
+	/*
+	 * full framework (IP version 3.x) only need rb swapped for RGB888 and
+	 * little framework (IP version 2.x) only need rb swapped for BGR888,
+	 * check for 3.x to also only rb swap BGR888 for unknown vop version
+	 */
+	case DRM_FORMAT_RGB888:
+		return VOP_MAJOR(version) == 3;
+	case DRM_FORMAT_BGR888:
+		return VOP_MAJOR(version) != 3;
 	default:
 		return false;
 	}
@@ -1035,7 +1043,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	VOP_WIN_SET(vop, win, dsp_info, dsp_info);
 	VOP_WIN_SET(vop, win, dsp_st, dsp_st);
 
-	rb_swap = has_rb_swapped(fb->format->format);
+	rb_swap = has_rb_swapped(vop->data->version, fb->format->format);
 	VOP_WIN_SET(vop, win, rb_swap, rb_swap);
 
 	/*
-- 
2.42.0

