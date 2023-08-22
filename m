Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48206783819
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjHVCmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHVCl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:41:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F8DDB;
        Mon, 21 Aug 2023 19:41:53 -0700 (PDT)
X-UUID: 7048fdce409511ee9cb5633481061a41-20230822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eOrdcnuGe4/hAXzd++9zHwHIQaLHDsl7GzbuSDMoYqU=;
        b=hz+H+JtHazTUMyy0+pHLiEJzP65DBu+a9zTHqRS1nS4AUgan63pxhRWbpAaXG/0n0srVuVVSNc00M/1KS9GNz0Z29QEf5xrKUDHkW9BqGEDDpxnKJW2Zs3v5wZNeaxLA/RQK4XqMrwkptnlMPfpsDAE0pojBF/8dvu4v8EMLTt0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:21663232-6829-40fb-8053-c81b8477da6e,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:0ad78a4,CLOUDID:619ccaee-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7048fdce409511ee9cb5633481061a41-20230822
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <shuijing.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 363952081; Tue, 22 Aug 2023 10:41:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 22 Aug 2023 10:41:46 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 22 Aug 2023 10:41:46 +0800
From:   Shuijing Li <shuijing.li@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <jitao.shi@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Shuijing Li <shuijing.li@mediatek.com>
Subject: [PATCH v6,4/4] drm/mediatek: dp: Add support MT8188 dp/edp function
Date:   Tue, 22 Aug 2023 10:41:55 +0800
Message-ID: <20230822024155.26670-5-shuijing.li@mediatek.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822024155.26670-1-shuijing.li@mediatek.com>
References: <20230822024155.26670-1-shuijing.li@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support MT8188 dp/edp function

Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
---
Changes in v6:
Move audio function to patch [2/4].
per suggestion from the previous thread:
https://lore.kernel.org/all/1d41747060c613ca0ae8e3b6395cc33bfa4d9056.camel@mediatek.com/
Changes in v5:
Separate mt8188 related code into mtk_dp_data structure and mt8188 dp/edp function
per suggestion from the previous thread:
https://lore.kernel.org/lkml/c1c84616f3da83a8a2bc245b0d3c7697153cd81a.camel@mediatek.com/
---
 drivers/gpu/drm/mediatek/mtk_dp.c     | 17 +++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dp_reg.h |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 0ba9a4fdf839..67986dd7c9d7 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2631,6 +2631,15 @@ static int mtk_dp_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(mtk_dp_pm_ops, mtk_dp_suspend, mtk_dp_resume);
 
+static const struct mtk_dp_data mt8188_dp_data = {
+	.bridge_type = DRM_MODE_CONNECTOR_DisplayPort,
+	.smc_cmd = MTK_DP_SIP_ATF_VIDEO_UNMUTE,
+	.efuse_fmt = mt8195_dp_efuse_fmt,
+	.audio_supported = true,
+	.audio_pkt_in_hblank_area = true,
+	.audio_m_div2_bit = MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,
+};
+
 static const struct mtk_dp_data mt8195_edp_data = {
 	.bridge_type = DRM_MODE_CONNECTOR_eDP,
 	.smc_cmd = MTK_DP_SIP_ATF_EDP_VIDEO_UNMUTE,
@@ -2648,6 +2657,14 @@ static const struct mtk_dp_data mt8195_dp_data = {
 };
 
 static const struct of_device_id mtk_dp_of_match[] = {
+	{
+		.compatible = "mediatek,mt8188-edp-tx",
+		.data = &mt8195_edp_data,
+	},
+	{
+		.compatible = "mediatek,mt8188-dp-tx",
+		.data = &mt8188_dp_data,
+	},
 	{
 		.compatible = "mediatek,mt8195-edp-tx",
 		.data = &mt8195_edp_data,
diff --git a/drivers/gpu/drm/mediatek/mtk_dp_reg.h b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
index b9859ef067ce..709b79480693 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
+++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
@@ -165,6 +165,12 @@
 #define MT8195_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2	(5 << 8)
 #define MT8195_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_4	(6 << 8)
 #define MT8195_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_8	(7 << 8)
+#define MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_2	(1 << 8)
+#define MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_4	(2 << 8)
+#define MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_8	(3 << 8)
+#define MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2	(4 << 8)
+#define MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_4	(5 << 8)
+#define MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_8	(7 << 8)
 #define MTK_DP_ENC0_P0_30D8			0x30d8
 #define MTK_DP_ENC0_P0_312C			0x312c
 #define ASP_HB2_DP_ENC0_P0_MASK				GENMASK(7, 0)
-- 
2.40.1

