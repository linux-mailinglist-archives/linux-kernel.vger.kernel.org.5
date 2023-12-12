Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D315180EB71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346484AbjLLMUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346433AbjLLMUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:20:08 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EAA100;
        Tue, 12 Dec 2023 04:20:13 -0800 (PST)
X-UUID: c769729098e811eea5db2bebc7c28f94-20231212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IAFUH+3gSqbAwKcAHXzJYY6xSL7PZ4g2dbK5i8/Gisk=;
        b=egry8NBqoq/JdsPporF0mSAiIRklAfLVWEuNlUVZf8Y7+LOBzksKkdoW7IejUIJITvOedY7/U60S0wmAoFwNgCw3mqnU8iWsWZmOuSsiF0+PQFjRPGbmtb/FkXJRTt6E1EFqub6eEMEp7b9jv6SK2OaQ7JXSPHs3VO/PZFxilpE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:c5c9e319-8802-46be-9fcc-f5f9f09ed292,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:26fd94fd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c769729098e811eea5db2bebc7c28f94-20231212
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 408150858; Tue, 12 Dec 2023 20:20:04 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Dec 2023 20:20:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Dec 2023 20:20:02 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        CK Hu <ck.hu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>, Sean Paul <sean@poorly.run>,
        Fei Shao <fshao@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH v4 16/17] drm/mediatek: Fix errors when reporting rotation capability
Date:   Tue, 12 Dec 2023 20:19:56 +0800
Message-ID: <20231212121957.19231-17-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231212121957.19231-1-shawn.sung@mediatek.com>
References: <20231212121957.19231-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create rotation property according to the hardware capability.
Since currently OVL of all chips support same rotation,
no need to define it in the driver data.

Fixes: 84d805753983 ("drm/mediatek: Support reflect-y plane rotation")

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_drv.h        |  1 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c        | 18 ++++++------------
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c    |  9 +++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c    |  1 +
 drivers/gpu/drm/mediatek/mtk_drm_plane.c       |  2 +-
 5 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index 4d6e8b667bc3..c5afeb7c5527 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -127,6 +127,7 @@ void mtk_ovl_adaptor_register_vblank_cb(struct device *dev, void (*vblank_cb)(vo
 void mtk_ovl_adaptor_unregister_vblank_cb(struct device *dev);
 void mtk_ovl_adaptor_enable_vblank(struct device *dev);
 void mtk_ovl_adaptor_disable_vblank(struct device *dev);
+unsigned int mtk_ovl_adaptor_supported_rotations(struct device *dev);
 void mtk_ovl_adaptor_start(struct device *dev);
 void mtk_ovl_adaptor_stop(struct device *dev);
 unsigned int mtk_ovl_adaptor_layer_nr(struct device *dev);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 78749dabeb43..f019737078f6 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -399,6 +399,10 @@ unsigned int mtk_ovl_layer_nr(struct device *dev)
 
 unsigned int mtk_ovl_supported_rotations(struct device *dev)
 {
+	/*
+	 * although currently OVL can only do reflection,
+	 * reflect x + reflect y = rotate 180
+	 */
 	return DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_180 |
 	       DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y;
 }
@@ -407,27 +411,17 @@ int mtk_ovl_layer_check(struct device *dev, unsigned int idx,
 			struct mtk_plane_state *mtk_state)
 {
 	struct drm_plane_state *state = &mtk_state->base;
-	unsigned int rotation = 0;
 
-	rotation = drm_rotation_simplify(state->rotation,
-					 DRM_MODE_ROTATE_0 |
-					 DRM_MODE_REFLECT_X |
-					 DRM_MODE_REFLECT_Y);
-	rotation &= ~DRM_MODE_ROTATE_0;
-
-	/* We can only do reflection, not rotation */
-	if ((rotation & DRM_MODE_ROTATE_MASK) != 0)
+	if (state->rotation & ~mtk_ovl_supported_rotations(dev))
 		return -EINVAL;
 
 	/*
 	 * TODO: Rotating/reflecting YUV buffers is not supported at this time.
 	 *	 Only RGB[AX] variants are supported.
 	 */
-	if (state->fb->format->is_yuv && rotation != 0)
+	if (state->fb->format->is_yuv && (state->rotation & ~DRM_MODE_ROTATE_0))
 		return -EINVAL;
 
-	state->rotation = rotation;
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index 4398db9a6276..273c79d37bef 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -383,6 +383,15 @@ void mtk_ovl_adaptor_register_vblank_cb(struct device *dev, void (*vblank_cb)(vo
 				     vblank_cb, vblank_cb_data);
 }
 
+unsigned int mtk_ovl_adaptor_supported_rotations(struct device *dev)
+{
+	/*
+	 * should still return DRM_MODE_ROTATE_0 if rotation is not supported,
+	 * or IGT will fail.
+	 */
+	return DRM_MODE_ROTATE_0;
+}
+
 void mtk_ovl_adaptor_unregister_vblank_cb(struct device *dev)
 {
 	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index ffa4868b1222..206dd6f6f99e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -422,6 +422,7 @@ static const struct mtk_ddp_comp_funcs ddp_ovl_adaptor = {
 	.remove = mtk_ovl_adaptor_remove_comp,
 	.get_formats = mtk_ovl_adaptor_get_formats,
 	.get_num_formats = mtk_ovl_adaptor_get_num_formats,
+	.supported_rotations = mtk_ovl_adaptor_supported_rotations,
 };
 
 static const char * const mtk_ddp_comp_stem[MTK_DDP_COMP_TYPE_MAX] = {
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index ff300426b590..e73b9793dee2 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -343,7 +343,7 @@ int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 		return err;
 	}
 
-	if (supported_rotations & ~DRM_MODE_ROTATE_0) {
+	if (supported_rotations) {
 		err = drm_plane_create_rotation_property(plane,
 							 DRM_MODE_ROTATE_0,
 							 supported_rotations);
-- 
2.18.0

