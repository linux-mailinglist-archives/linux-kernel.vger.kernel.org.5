Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FD07F6079
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345618AbjKWNiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345567AbjKWNiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:38:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025DFD7E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:38:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F67C433C9;
        Thu, 23 Nov 2023 13:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700746700;
        bh=yp3tKEvY3IVCFEhD0Bxg/Hw6hTrEBgQxqiXCTK5PONg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iI/CzRx+LbYWI9WFQv0WzBDR0lAxkkzVvtOC7DAQgaylWVB0Kb9xobuPy+A/9V4ys
         6EslE2vM1ydHw9XSW/FFipkTg5V7FHnrQ8hXY0FQmsfiw/DCnn+sxbq4jQDfh3NGQZ
         FfZIzYVSg6nfy8/MYy4wpZT/XpLDcGftkMMaI7NtZDw7O6uqShHYJi8m+B1H7QbZ/g
         4EN6pgFy2ZjJ50Hb89pELrKVU9RH+xLr7c4AyeilrWYswiHLSHySDwRMk/b6RTClXO
         GF5KDC6eMbJ29r+vPueyY2a0DTT8oR3aKBDczeLj7/BRLSQCqj5w8upiJRaVbsIxN6
         4M9pqlxxp0tLA==
From:   Michael Walle <mwalle@kernel.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, Michael Walle <mwalle@kernel.org>
Subject: [PATCH 4/4] drm/mediatek: support the DSI0 output on the MT8195 VDOSYS0
Date:   Thu, 23 Nov 2023 14:37:49 +0100
Message-Id: <20231123133749.2030661-5-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123133749.2030661-1-mwalle@kernel.org>
References: <20231123133749.2030661-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the latest dynamic selection of the output component, we can now
support different outputs. Move current output component into the
dynamic routes array and add the new DSI0 output.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 2b0c35cacbc6..6fa88976376e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -222,7 +222,11 @@ static const unsigned int mt8195_mtk_ddp_main[] = {
 	DDP_COMPONENT_DITHER0,
 	DDP_COMPONENT_DSC0,
 	DDP_COMPONENT_MERGE0,
-	DDP_COMPONENT_DP_INTF0,
+};
+
+static const struct mtk_drm_route mt8195_mtk_ddp_main_routes[] = {
+	{ 0, DDP_COMPONENT_DP_INTF0 },
+	{ 0, DDP_COMPONENT_DSI0 },
 };
 
 static const unsigned int mt8195_mtk_ddp_ext[] = {
@@ -308,6 +312,8 @@ static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
 static const struct mtk_mmsys_driver_data mt8195_vdosys0_driver_data = {
 	.main_path = mt8195_mtk_ddp_main,
 	.main_len = ARRAY_SIZE(mt8195_mtk_ddp_main),
+	.conn_routes = mt8195_mtk_ddp_main_routes,
+	.num_conn_routes = ARRAY_SIZE(mt8195_mtk_ddp_main_routes),
 	.mmsys_dev_num = 2,
 };
 
-- 
2.39.2

