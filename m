Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A92E78C50C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbjH2NUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbjH2NU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4EBF7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95E1463186
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0331AC433CB;
        Tue, 29 Aug 2023 13:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315224;
        bh=VmiiCQJmx/vUEhDJNuwCqJdIf0rnLGfJEi9IfqpWrHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NS5NeyHzBnEpCSp8tUcOhptK84Gn4+X+ta5XVY9kk0xU+tA6sgA9p6xWqjx/JL/nR
         fSVCOyncSFQy3jAIVO+vfbKbwmzBzfvykwgR18CuIfxtp4893xTNP/bWRXyYziGz3R
         dknzHrw6+ldB986WCqR7L0Y6hF+IlfZPrsEk3KXoz+y2a14lN8E6W2q2yymKdDLl4q
         ttO4a2hm8M9h4CXFmwHFFhAU7YspeVrR+PZntfgwPtbxvGfGAU52SzcUtBYttHSKqp
         TqBoM5xj1iHL0Ppn37bGy1ZhdqPmIBFIlh/k3NNWM2VWZ1U5Ulfj25h5Pd1YQhQ47O
         9hFiSIDrm9Dzw==
From:   Michael Walle <mwalle@kernel.org>
To:     =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     "Nancy . Lin" <nancy.lin@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Walle <mwalle@kernel.org>
Subject: [PATCH 2/2] drm/mediatek: dpi/dsi: fix possible_crtcs calculation
Date:   Tue, 29 Aug 2023 15:19:41 +0200
Message-Id: <20230829131941.3353439-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829131941.3353439-1-mwalle@kernel.org>
References: <20230829131941.3353439-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_drm_find_possible_crtc_by_comp() assumed that the main path will
always have the CRTC with id 0, the ext id 1 and the third id 2. This
is only true if the paths are all available. But paths are optional (see
also comment in mtk_drm_kms_init()), e.g. the main path might not be
enabled or available at all. Then the CRTC IDs will shift one up, e.g.
ext will be 1 and the third path will be 2.

To fix that, dynamically calculate the IDs by the precence of the paths.

Fixes: 5aa8e7647676 ("drm/mediatek: dpi/dsi: Change the getting possible_crtc way")
Suggested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 41 ++++++++++++++-------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 771f4e173353..f3064bff64e8 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -526,21 +526,34 @@ unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
 						struct device *dev)
 {
 	struct mtk_drm_private *private = drm->dev_private;
-	unsigned int ret = 0;
-
-	if (mtk_drm_find_comp_in_ddp(dev, private->data->main_path, private->data->main_len,
-				     private->ddp_comp))
-		ret = BIT(0);
-	else if (mtk_drm_find_comp_in_ddp(dev, private->data->ext_path,
-					  private->data->ext_len, private->ddp_comp))
-		ret = BIT(1);
-	else if (mtk_drm_find_comp_in_ddp(dev, private->data->third_path,
-					  private->data->third_len, private->ddp_comp))
-		ret = BIT(2);
-	else
-		DRM_INFO("Failed to find comp in ddp table\n");
+	int i = 0;
+
+	if (private->data->main_path) {
+		if (mtk_drm_find_comp_in_ddp(dev, private->data->main_path,
+					     private->data->main_len,
+					     private->ddp_comp))
+			return BIT(i);
+		i++;
+	}
+
+	if (private->data->ext_path) {
+		if (mtk_drm_find_comp_in_ddp(dev, private->data->ext_path,
+					     private->data->ext_len,
+					     private->ddp_comp))
+			return BIT(i);
+		i++;
+	}
 
-	return ret;
+	if (private->data->third_path) {
+		if (mtk_drm_find_comp_in_ddp(dev, private->data->third_path,
+					     private->data->third_len,
+					     private->ddp_comp))
+			return BIT(i);
+		i++;
+	}
+
+	DRM_INFO("Failed to find comp in ddp table\n");
+	return 0;
 }
 
 int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
-- 
2.39.2

