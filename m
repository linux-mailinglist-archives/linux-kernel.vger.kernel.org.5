Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A977D76FD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjJYVni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJYVnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:43:37 -0400
X-Greylist: delayed 629 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 14:43:33 PDT
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A47132
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1698270211;
 bh=PSE4xeckRKb3xz86Jk8z81faXilq5QfiYs9qzrlEBgs=;
 b=GDYEI/m1CUdpu3BWilvchZCojANJJCajL1UyT9c8Yxf+a4cBzXM8CuOgczhK4B5jwkV84eE8p
 lvzVw+yNCvjw6tWNpmcKVaoLAllhBWLPN8B49xtkY1ExJouB9sASZx+tQIzgfxBynqP3zoH7cMv
 x6zrPiKPRHvSGfdBNpbZfgbqyaDNoZMRNYs/joL+WT1jVLMCx2CJnchu/lIFabLJ6eEs3fTtm1a
 rrKVg+2O/3vhlqBd3rkLe+gS3ZPw8N1U5vs1Oc7ZiFlKztYqMIOa0nAYRlVR6r0mserBJxnB7sS
 EKfr/gxmFIIlbDRo7d+lWhJ+o0IYL3ceUzyc4HBsACwA==
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Andy Yan <andy.yan@rock-chips.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: vop2: Add NV20 and NV30 support
Date:   Wed, 25 Oct 2023 21:32:46 +0000
Message-ID: <20231025213248.2641962-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65398986da73b54fc2dc42e3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the 10-bit 4:2:2 and 4:4:4 formats NV20 and NV30.

These formats can be tested using modetest [1]:

  modetest -P <plane_id>@<crtc_id>:1920x1080@<format>

e.g. on a ROCK 3 Model A (rk3568):

  modetest -P 43@67:1920x1080@NV20 -F tiles,tiles
  modetest -P 43@67:1920x1080@NV30 -F smpte,smpte

[1] https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/329

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 5 +++++
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index ab944010fe14..592f9d726f2e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -326,11 +326,14 @@ static enum vop2_data_format vop2_convert_format(u32 format)
 	case DRM_FORMAT_NV16:
 	case DRM_FORMAT_NV61:
 		return VOP2_FMT_YUV422SP;
+	case DRM_FORMAT_NV20:
 	case DRM_FORMAT_Y210:
 		return VOP2_FMT_YUV422SP_10;
 	case DRM_FORMAT_NV24:
 	case DRM_FORMAT_NV42:
 		return VOP2_FMT_YUV444SP;
+	case DRM_FORMAT_NV30:
+		return VOP2_FMT_YUV444SP_10;
 	case DRM_FORMAT_YUYV:
 	case DRM_FORMAT_YVYU:
 		return VOP2_FMT_VYUY422;
@@ -415,6 +418,8 @@ static bool vop2_win_uv_swap(u32 format)
 	case DRM_FORMAT_NV16:
 	case DRM_FORMAT_NV24:
 	case DRM_FORMAT_NV15:
+	case DRM_FORMAT_NV20:
+	case DRM_FORMAT_NV30:
 	case DRM_FORMAT_YUYV:
 	case DRM_FORMAT_UYVY:
 		return true;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index fdb48571efce..0b4280218a59 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -48,8 +48,10 @@ static const uint32_t formats_rk356x_esmart[] = {
 	DRM_FORMAT_NV15, /* yuv420_10bit linear mode, 2 plane, no padding */
 	DRM_FORMAT_NV16, /* yuv422_8bit linear mode, 2 plane */
 	DRM_FORMAT_NV61, /* yuv422_8bit linear mode, 2 plane */
+	DRM_FORMAT_NV20, /* yuv422_10bit linear mode, 2 plane, no padding */
 	DRM_FORMAT_NV24, /* yuv444_8bit linear mode, 2 plane */
 	DRM_FORMAT_NV42, /* yuv444_8bit linear mode, 2 plane */
+	DRM_FORMAT_NV30, /* yuv444_10bit linear mode, 2 plane, no padding */
 	DRM_FORMAT_YVYU, /* yuv422_8bit[YVYU] linear mode */
 	DRM_FORMAT_VYUY, /* yuv422_8bit[VYUY] linear mode */
 };
-- 
2.42.0

