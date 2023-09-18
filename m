Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535FD7A41D5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbjIRHKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240092AbjIRHKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:10:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E830818D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:10:22 -0700 (PDT)
X-UUID: 6a85db5655f211eea33bb35ae8d461a2-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MI804DzGasaQoKhuNJQFOPViwmRGLb1M7P9KclzvJ38=;
        b=CsfmRpQFboU80emABMGFnTauOjQ89+4Fai7+2OGB/6lWBJI+3yjn3lQtwmRF7RqlsAvHpOGWFBdpXBnEeC0UM23H6/Jxn+j3/bAyY01fmJhx3+kGKzAy0nBuSSdyw0OkTiGTSjnysnFbNgVyBCMcEYI1XoKQkGfvJs6Vzwv4dXE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:f7ee2d2a-1cad-4517-9986-827a6589c3e5,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:0ad78a4,CLOUDID:fc3326c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6a85db5655f211eea33bb35ae8d461a2-20230918
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1993278181; Mon, 18 Sep 2023 15:10:15 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 15:10:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 15:10:14 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>
CC:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Paul <seanpaul@chromium.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH 1/1] drm/mediatek: Fix errors when reporting rotation capability
Date:   Mon, 18 Sep 2023 15:10:11 +0800
Message-ID: <20230918071011.18481-2-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230918071011.18481-1-shawn.sung@mediatek.com>
References: <20230918071011.18481-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For CRTCs that doesn't support rotation should still return
DRM_MODE_ROTATE_0. Since both OVL and OVL adaptor on MTK chip
doesn't support rotation, return the capability of the
hardware accordingly.

Fixes: df4444577118 ("drm/mediatek: Support 180 degree rotation")
Fixes: 84d805753983 ("drm/mediatek: Support reflect-y plane rotation")

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_drv.h         | 1 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c         | 8 +-------
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 5 +++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c     | 1 +
 drivers/gpu/drm/mediatek/mtk_drm_plane.c        | 2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index 2254038519e1..f4c7dba8f73d 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -120,6 +120,7 @@ void mtk_ovl_adaptor_register_vblank_cb(struct device *dev, void (*vblank_cb)(vo
 void mtk_ovl_adaptor_unregister_vblank_cb(struct device *dev);
 void mtk_ovl_adaptor_enable_vblank(struct device *dev);
 void mtk_ovl_adaptor_disable_vblank(struct device *dev);
+unsigned int mtk_ovl_adaptor_supported_rotations(struct device *dev);
 void mtk_ovl_adaptor_start(struct device *dev);
 void mtk_ovl_adaptor_stop(struct device *dev);
 unsigned int mtk_ovl_adaptor_layer_nr(struct device *dev);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 2bffe4245466..5fd1f6ae41f3 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -288,8 +288,7 @@ unsigned int mtk_ovl_layer_nr(struct device *dev)

 unsigned int mtk_ovl_supported_rotations(struct device *dev)
 {
-	return DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_180 |
-	       DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y;
+	return DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y;
 }

 int mtk_ovl_layer_check(struct device *dev, unsigned int idx,
@@ -302,11 +301,6 @@ int mtk_ovl_layer_check(struct device *dev, unsigned int idx,
 					 DRM_MODE_ROTATE_0 |
 					 DRM_MODE_REFLECT_X |
 					 DRM_MODE_REFLECT_Y);
-	rotation &= ~DRM_MODE_ROTATE_0;
-
-	/* We can only do reflection, not rotation */
-	if ((rotation & DRM_MODE_ROTATE_MASK) != 0)
-		return -EINVAL;

 	/*
 	 * TODO: Rotating/reflecting YUV buffers is not supported at this time.
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index 6bf6367853fb..922db8df572d 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -277,6 +277,11 @@ void mtk_ovl_adaptor_register_vblank_cb(struct device *dev, void (*vblank_cb)(vo
 				     vblank_cb, vblank_cb_data);
 }

+unsigned int mtk_ovl_adaptor_supported_rotations(struct device *dev)
+{
+	return DRM_MODE_ROTATE_0;
+}
+
 void mtk_ovl_adaptor_unregister_vblank_cb(struct device *dev)
 {
 	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 771f4e173353..f7f972f0d46d 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -412,6 +412,7 @@ static const struct mtk_ddp_comp_funcs ddp_ovl_adaptor = {
 	.remove = mtk_ovl_adaptor_remove_comp,
 	.get_formats = mtk_ovl_adaptor_get_formats,
 	.get_num_formats = mtk_ovl_adaptor_get_num_formats,
+	.supported_rotations = mtk_ovl_adaptor_supported_rotations,
 };

 static const char * const mtk_ddp_comp_stem[MTK_DDP_COMP_TYPE_MAX] = {
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index db2f70ae060d..371de196d400 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -315,7 +315,7 @@ int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 		return err;
 	}

-	if (supported_rotations & ~DRM_MODE_ROTATE_0) {
+	if (supported_rotations) {
 		err = drm_plane_create_rotation_property(plane,
 							 DRM_MODE_ROTATE_0,
 							 supported_rotations);
--
2.18.0

