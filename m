Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2ED7A450A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241036AbjIRInR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240755AbjIRImb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:42:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BD8D1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 01:42:21 -0700 (PDT)
X-UUID: 432f38f655ff11eea33bb35ae8d461a2-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2FmL+tmhWGFQcrwwwy2xFlnk4sPriKRNmcjNvLKxuIk=;
        b=XtYHvi6LM/Qr2+ikCHEEYsK6og1hX+Hqv4AFlPQaYAoR1s/jWiWUSAYwR1HCMSxSPs4CBm5LREBexF8lkT/TvQnJX+QgYTVZUvQ+qxKsW3pekKrOwnreTOILIGzl/y/DiAn5FBPZhSN5Zoiicr1P+JV0g+kAfn0EexjYiHeAwfQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:8c65be78-9937-49aa-be6a-10a41575df23,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:c9c91014-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 432f38f655ff11eea33bb35ae8d461a2-20230918
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1268704023; Mon, 18 Sep 2023 16:42:12 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 16:42:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 16:42:11 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Chen-Yu Tsai <wenst@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH v2 06/11] drm/mediatek: Support alpha blending in display driver
Date:   Mon, 18 Sep 2023 16:42:02 +0800
Message-ID: <20230918084207.23604-7-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230918084207.23604-1-shawn.sung@mediatek.com>
References: <20230918084207.23604-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.435800-8.000000
X-TMASE-MatchedRID: 61l6kdP/ldn2fv0LTPfvM6MVgdN9w+TCWjWsWQUWzVr/evmlVf9xZkN+
        V6ZFLcNd6rlI+AD5R5wSqo3ZUfrHh25/NyTKlG69DB+ErBr0bAOuiRuR9mCautchlMhSt6FeQHf
        bKe/4YJLlpBcKhHrskTLaKLaWub4PHxPMjOKY7A8LbigRnpKlKSPzRlrdFGDwU+2vIzDCyqmf+Q
        y/rKrINsCo2Oi+tjk+FpltkTCMnT3Dhj6t95pUrg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.435800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 428F88119AF2C6E762C3F1B230F9FA71349FB6689841C1FBE17B295B794B9CE12000:8
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

Support alpha blending by adding correct blend mode and
alpha property in plane initialization.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_plane.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index db2f70ae060d..f87cf56fb846 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -301,6 +301,9 @@ int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 		   size_t num_formats)
 {
 	int err;
+	u32 blend_mode = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+			 BIT(DRM_MODE_BLEND_PREMULTI)   |
+			 BIT(DRM_MODE_BLEND_COVERAGE);
 
 	if (!formats || !num_formats) {
 		DRM_ERROR("no formats for plane\n");
@@ -323,6 +326,14 @@ int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 			DRM_INFO("Create rotation property failed\n");
 	}
 
+	err = drm_plane_create_alpha_property(plane);
+	if (err)
+		DRM_ERROR("failed to create property: alpha\n");
+
+	err = drm_plane_create_blend_mode_property(plane, blend_mode);
+	if (err)
+		DRM_ERROR("failed to create property: blend_mode\n");
+
 	drm_plane_helper_add(plane, &mtk_plane_helper_funcs);
 
 	return 0;
-- 
2.18.0

