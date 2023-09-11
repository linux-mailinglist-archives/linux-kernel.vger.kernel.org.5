Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C683179A1B8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 05:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjIKDRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 23:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjIKDQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 23:16:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E9E11A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 20:16:50 -0700 (PDT)
X-UUID: a0da36f8505111eea33bb35ae8d461a2-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NuNY92TCP/+uB4pUjgYBR2ESEkqJhOX+11N3YRJ4vS4=;
        b=LphRLV6XHs9NmxbUL0k5skEKE2b9swqN/8q4bImRYFwUspwbpszzG+FUfUT9ZXt0yq5nLJvNeRAGNQHY7Dp8ltf9xyare+ZdxsruF6sYc88IIt4DdGlWtPuSsNXd4K/7sEGakIrT+zpodYvd27B2Aj7Bo7zTWnyy33N5MlucaLI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:e7a3bbb1-2c90-456c-873b-9e5418a34328,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:0e22c813-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a0da36f8505111eea33bb35ae8d461a2-20230911
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 278096606; Mon, 11 Sep 2023 11:16:41 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 11:16:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 11:16:40 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH v6 10/20] soc: mediatek: Add MT8188 VDOSYS reset bit map
Date:   Mon, 11 Sep 2023 11:16:20 +0800
Message-ID: <20230911031630.12613-11-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230911031630.12613-1-shawn.sung@mediatek.com>
References: <20230911031630.12613-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.042400-8.000000
X-TMASE-MatchedRID: 9DomuZeNnSapk9YSiEd5IufHZObG8Jso6SXuwUgGH0hbKBBN5zqG8EiO
        7+wNDdeYRHLRFcKKZXfbCHv011Gy9VSU1d+VJ4IjtG07VELUSnRfohHCqSnabgTozVi1xfq8MJK
        6qaU5tN00ULOv9iNOM0q+cX2jmfqvmxh0gY/o+VmiAZ3zAhQYgn0tCKdnhB589yM15V5aWpj6C0
        ePs7A07fyjtizU0rhjVyJ6Rrqx+FNSRMjv86A6CPVU14ep5TZkqBHnAYeJC8o=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.042400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: E82279B5A24B85249DF1994B319FCFB8048AA702ACFE1A26D5C95CD57E1CCD592000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8188 reset bit map for VDOSYS0 and VDOSYS1.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/soc/mediatek/mt8188-mmsys.h | 84 +++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c    |  7 ++-
 2 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mt8188-mmsys.h b/drivers/soc/mediatek/mt8188-mmsys.h
index a9490c3c4256..6bebf1a69fc0 100644
--- a/drivers/soc/mediatek/mt8188-mmsys.h
+++ b/drivers/soc/mediatek/mt8188-mmsys.h
@@ -3,6 +3,10 @@
 #ifndef __SOC_MEDIATEK_MT8188_MMSYS_H
 #define __SOC_MEDIATEK_MT8188_MMSYS_H
 
+#include <linux/soc/mediatek/mtk-mmsys.h>
+#include <dt-bindings/reset/mt8188-resets.h>
+
+#define MT8188_VDO0_SW0_RST_B				0x190
 #define MT8188_VDO0_OVL_MOUT_EN				0xf14
 #define MT8188_MOUT_DISP_OVL0_TO_DISP_RDMA0		BIT(0)
 #define MT8188_MOUT_DISP_OVL0_TO_DISP_WDMA0		BIT(1)
@@ -67,6 +71,7 @@
 #define MT8188_SOUT_DSC_WRAP0_OUT_TO_VPP_MERGE		BIT(18)
 #define MT8188_SOUT_DSC_WRAP0_OUT_TO_DISP_WDMA0		BIT(19)
 
+#define MT8188_VDO1_SW0_RST_B					0x1d0
 #define MT8188_VDO1_HDR_TOP_CFG					0xd00
 #define MT8188_VDO1_MIXER_IN1_ALPHA				0xd30
 #define MT8188_VDO1_MIXER_IN1_PAD				0xd40
@@ -117,6 +122,85 @@
 #define MT8188_VDO1_MIXER_SOUT_SEL_IN				0xf68
 #define MT8188_MIXER_SOUT_SEL_IN_FROM_DISP_MIXER		0
 
+static const u8 mmsys_mt8188_vdo0_rst_tb[] = {
+	[MT8188_VDO0_RST_DISP_OVL0]	= MMSYS_RST_NR(0, 0),
+	[MT8188_VDO0_RST_FAKE_ENG0]	= MMSYS_RST_NR(0, 2),
+	[MT8188_VDO0_RST_DISP_CCORR0]	= MMSYS_RST_NR(0, 4),
+	[MT8188_VDO0_RST_DISP_MUTEX0]	= MMSYS_RST_NR(0, 6),
+	[MT8188_VDO0_RST_DISP_GAMMA0]	= MMSYS_RST_NR(0, 8),
+	[MT8188_VDO0_RST_DISP_DITHER0]	= MMSYS_RST_NR(0, 10),
+	[MT8188_VDO0_RST_DISP_WDMA0]	= MMSYS_RST_NR(0, 17),
+	[MT8188_VDO0_RST_DISP_RDMA0]	= MMSYS_RST_NR(0, 19),
+	[MT8188_VDO0_RST_DSI0]		= MMSYS_RST_NR(0, 21),
+	[MT8188_VDO0_RST_DSI1]		= MMSYS_RST_NR(0, 22),
+	[MT8188_VDO0_RST_DSC_WRAP0]	= MMSYS_RST_NR(0, 23),
+	[MT8188_VDO0_RST_VPP_MERGE0]	= MMSYS_RST_NR(0, 24),
+	[MT8188_VDO0_RST_DP_INTF0]	= MMSYS_RST_NR(0, 25),
+	[MT8188_VDO0_RST_DISP_AAL0]	= MMSYS_RST_NR(0, 26),
+	[MT8188_VDO0_RST_INLINEROT0]	= MMSYS_RST_NR(0, 27),
+	[MT8188_VDO0_RST_APB_BUS]	= MMSYS_RST_NR(0, 28),
+	[MT8188_VDO0_RST_DISP_COLOR0]	= MMSYS_RST_NR(0, 29),
+	[MT8188_VDO0_RST_MDP_WROT0]	= MMSYS_RST_NR(0, 30),
+	[MT8188_VDO0_RST_DISP_RSZ0]	= MMSYS_RST_NR(0, 31),
+};
+
+static const u8 mmsys_mt8188_vdo1_rst_tb[] = {
+	[MT8188_VDO1_RST_SMI_LARB2]			= MMSYS_RST_NR(0, 0),
+	[MT8188_VDO1_RST_SMI_LARB3]			= MMSYS_RST_NR(0, 1),
+	[MT8188_VDO1_RST_GALS]				= MMSYS_RST_NR(0, 2),
+	[MT8188_VDO1_RST_FAKE_ENG0]			= MMSYS_RST_NR(0, 3),
+	[MT8188_VDO1_RST_FAKE_ENG1]			= MMSYS_RST_NR(0, 4),
+	[MT8188_VDO1_RST_MDP_RDMA0]			= MMSYS_RST_NR(0, 5),
+	[MT8188_VDO1_RST_MDP_RDMA1]			= MMSYS_RST_NR(0, 6),
+	[MT8188_VDO1_RST_MDP_RDMA2]			= MMSYS_RST_NR(0, 7),
+	[MT8188_VDO1_RST_MDP_RDMA3]			= MMSYS_RST_NR(0, 8),
+	[MT8188_VDO1_RST_VPP_MERGE0]			= MMSYS_RST_NR(0, 9),
+	[MT8188_VDO1_RST_VPP_MERGE1]			= MMSYS_RST_NR(0, 10),
+	[MT8188_VDO1_RST_VPP_MERGE2]			= MMSYS_RST_NR(0, 11),
+	[MT8188_VDO1_RST_VPP_MERGE3]			= MMSYS_RST_NR(1, 0),
+	[MT8188_VDO1_RST_VPP_MERGE4]			= MMSYS_RST_NR(1, 1),
+	[MT8188_VDO1_RST_VPP2_TO_VDO1_DL_ASYNC]		= MMSYS_RST_NR(1, 2),
+	[MT8188_VDO1_RST_VPP3_TO_VDO1_DL_ASYNC]		= MMSYS_RST_NR(1, 3),
+	[MT8188_VDO1_RST_DISP_MUTEX]			= MMSYS_RST_NR(1, 4),
+	[MT8188_VDO1_RST_MDP_RDMA4]			= MMSYS_RST_NR(1, 5),
+	[MT8188_VDO1_RST_MDP_RDMA5]			= MMSYS_RST_NR(1, 6),
+	[MT8188_VDO1_RST_MDP_RDMA6]			= MMSYS_RST_NR(1, 7),
+	[MT8188_VDO1_RST_MDP_RDMA7]			= MMSYS_RST_NR(1, 8),
+	[MT8188_VDO1_RST_DP_INTF1_MMCK]			= MMSYS_RST_NR(1, 9),
+	[MT8188_VDO1_RST_DPI0_MM_CK]			= MMSYS_RST_NR(1, 10),
+	[MT8188_VDO1_RST_DPI1_MM_CK]			= MMSYS_RST_NR(1, 11),
+	[MT8188_VDO1_RST_MERGE0_DL_ASYNC]		= MMSYS_RST_NR(1, 13),
+	[MT8188_VDO1_RST_MERGE1_DL_ASYNC]		= MMSYS_RST_NR(1, 14),
+	[MT8188_VDO1_RST_MERGE2_DL_ASYNC]		= MMSYS_RST_NR(1, 15),
+	[MT8188_VDO1_RST_MERGE3_DL_ASYNC]		= MMSYS_RST_NR(1, 16),
+	[MT8188_VDO1_RST_MERGE4_DL_ASYNC]		= MMSYS_RST_NR(1, 17),
+	[MT8188_VDO1_RST_VDO0_DSC_TO_VDO1_DL_ASYNC]	= MMSYS_RST_NR(1, 18),
+	[MT8188_VDO1_RST_VDO0_MERGE_TO_VDO1_DL_ASYNC]	= MMSYS_RST_NR(1, 19),
+	[MT8188_VDO1_RST_PADDING0]			= MMSYS_RST_NR(1, 20),
+	[MT8188_VDO1_RST_PADDING1]			= MMSYS_RST_NR(1, 21),
+	[MT8188_VDO1_RST_PADDING2]			= MMSYS_RST_NR(1, 22),
+	[MT8188_VDO1_RST_PADDING3]			= MMSYS_RST_NR(1, 23),
+	[MT8188_VDO1_RST_PADDING4]			= MMSYS_RST_NR(1, 24),
+	[MT8188_VDO1_RST_PADDING5]			= MMSYS_RST_NR(1, 25),
+	[MT8188_VDO1_RST_PADDING6]			= MMSYS_RST_NR(1, 26),
+	[MT8188_VDO1_RST_PADDING7]			= MMSYS_RST_NR(1, 27),
+	[MT8188_VDO1_RST_DISP_RSZ0]			= MMSYS_RST_NR(1, 28),
+	[MT8188_VDO1_RST_DISP_RSZ1]			= MMSYS_RST_NR(1, 29),
+	[MT8188_VDO1_RST_DISP_RSZ2]			= MMSYS_RST_NR(1, 30),
+	[MT8188_VDO1_RST_DISP_RSZ3]			= MMSYS_RST_NR(1, 31),
+	[MT8188_VDO1_RST_HDR_VDO_FE0]			= MMSYS_RST_NR(2, 0),
+	[MT8188_VDO1_RST_HDR_GFX_FE0]			= MMSYS_RST_NR(2, 1),
+	[MT8188_VDO1_RST_HDR_VDO_BE]			= MMSYS_RST_NR(2, 2),
+	[MT8188_VDO1_RST_HDR_VDO_FE1]			= MMSYS_RST_NR(2, 16),
+	[MT8188_VDO1_RST_HDR_GFX_FE1]			= MMSYS_RST_NR(2, 17),
+	[MT8188_VDO1_RST_DISP_MIXER]			= MMSYS_RST_NR(2, 18),
+	[MT8188_VDO1_RST_HDR_VDO_FE0_DL_ASYNC]		= MMSYS_RST_NR(2, 19),
+	[MT8188_VDO1_RST_HDR_VDO_FE1_DL_ASYNC]		= MMSYS_RST_NR(2, 20),
+	[MT8188_VDO1_RST_HDR_GFX_FE0_DL_ASYNC]		= MMSYS_RST_NR(2, 21),
+	[MT8188_VDO1_RST_HDR_GFX_FE1_DL_ASYNC]		= MMSYS_RST_NR(2, 22),
+	[MT8188_VDO1_RST_HDR_VDO_BE_DL_ASYNC]		= MMSYS_RST_NR(2, 23),
+};
+
 static const struct mtk_mmsys_routes mmsys_mt8188_routing_table[] = {
 	{
 		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 6fc59f85f4fa..f89ece6739ce 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -87,13 +87,18 @@ static const struct mtk_mmsys_driver_data mt8188_vdosys0_driver_data = {
 	.clk_driver = "clk-mt8188-vdo0",
 	.routes = mmsys_mt8188_routing_table,
 	.num_routes = ARRAY_SIZE(mmsys_mt8188_routing_table),
+	.sw0_rst_offset = MT8188_VDO0_SW0_RST_B,
+	.rst_tb = mmsys_mt8188_vdo0_rst_tb,
+	.num_resets = ARRAY_SIZE(mmsys_mt8188_vdo0_rst_tb),
 };
 
 static const struct mtk_mmsys_driver_data mt8188_vdosys1_driver_data = {
 	.clk_driver = "clk-mt8188-vdo1",
 	.routes = mmsys_mt8188_vdo1_routing_table,
 	.num_routes = ARRAY_SIZE(mmsys_mt8188_vdo1_routing_table),
-	.num_resets = 96,
+	.sw0_rst_offset = MT8188_VDO1_SW0_RST_B,
+	.rst_tb = mmsys_mt8188_vdo1_rst_tb,
+	.num_resets = ARRAY_SIZE(mmsys_mt8188_vdo1_rst_tb),
 	.vsync_len = 1,
 };
 
-- 
2.18.0

