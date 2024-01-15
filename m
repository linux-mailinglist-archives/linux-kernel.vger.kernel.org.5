Return-Path: <linux-kernel+bounces-25927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8133782D864
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA621F21E10
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CD02C697;
	Mon, 15 Jan 2024 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="l/YIStRq"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9892BD00;
	Mon, 15 Jan 2024 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e8b95572b39711ee9e680517dc993faa-20240115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Reply-To:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xc7EAMbIGGsmYRLz3w7xLff0ZcSw79iBhdskRqlb92s=;
	b=l/YIStRq4cX5SbnhBWv7pb0dD0ix7eNeS061k4G/T7FtX/8jBCBHMeQ2mB4kdUrxrS+0r+OY6tXghPHN4CCWHIAbWok659sBQJhM+YH/JxhZN5qzfB3kDIFQEOOqhVy2AZL9zFwjfUr4hiH/6CKCNL/r6Du1N0nEjYGANj94mpI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:14351723-3d18-426c-a885-874746a69b83,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:01a15d7f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e8b95572b39711ee9e680517dc993faa-20240115
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <yu-chang.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 970726976; Mon, 15 Jan 2024 19:19:12 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 15 Jan 2024 19:19:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 15 Jan 2024 19:19:10 +0800
From: yu-chang.lee <yu-chang.lee@mediatek.com>
To: <msp@baylibre.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <fparent@baylibre.com>, Ben Lok
	<ben.lok@mediatek.com>, Chris-qj Chen <Chris-qj.Chen@mediatek.com>, Louis Yu
	<louis.yu@mediatek.com>, Bear Wang <bear.wang@mediatek.com>, MandyJH Liu
	<MandyJH.Liu@mediatek.com>, Fan Chen <fan.chen@mediatek.com>, Xiufeng Li
	<Xiufeng.Li@mediatek.com>, <abailon@baylibre.com>, <amergnat@baylibre.com>,
	<afgros@baylibre.com>, yu-chang.lee <yu-chang.lee@mediatek.com>
Subject: [PATCH 1/1] soc: mediatek: pm-domains: support clamp protection
Date: Mon, 15 Jan 2024 19:18:44 +0800
Message-ID: <20240115111844.22240-2-yu-chang.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240115111844.22240-1-yu-chang.lee@mediatek.com>
References: <Need help to validate power domain driver modification on mt8365>
 <20240115111844.22240-1-yu-chang.lee@mediatek.com>
Reply-To: <msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

This patch mainly do two things
1. Add smi clamp protection support
2. Force order of bus protection between infra and smi

For example: power on
"clamp protection enable" (smi, with clamp flag)
  -> regulator enable
    ...
      -> clamp protection disaled (smi, with clamp flag)
        -> bus protection disabled (smi -> infra)

For example: power off
"clamp protection enable" (smi, with clamp flag)
  -> bus protection enable (infra -> smi)

Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>
---
 drivers/pmdomain/mediatek/mt8183-pm-domains.h |  52 ++++---
 drivers/pmdomain/mediatek/mt8188-pm-domains.h |  41 +++++-
 drivers/pmdomain/mediatek/mt8365-pm-domains.h |  12 +-
 drivers/pmdomain/mediatek/mtk-pm-domains.c    | 132 +++++++++++++++---
 drivers/pmdomain/mediatek/mtk-pm-domains.h    |   2 +
 5 files changed, 189 insertions(+), 50 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mt8183-pm-domains.h b/drivers/pmdomain/mediatek/mt8183-pm-domains.h
index c4c1b63d85b1..04fca4a1e8f3 100644
--- a/drivers/pmdomain/mediatek/mt8183-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8183-pm-domains.h
@@ -103,6 +103,13 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.clamp_smi = {
+			BUS_PROT_WR(SMI,
+				    MT8183_SMI_COMMON_SMI_CLAMP_DISP,
+				    MT8183_SMI_COMMON_CLAMP_EN_SET,
+				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
+				    MT8183_SMI_COMMON_CLAMP_EN),
+		},
 		.bp_cfg = {
 			BUS_PROT_WR(INFRA,
 				    MT8183_TOP_AXI_PROT_EN_1_DISP,
@@ -114,11 +121,6 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 				    MT8183_TOP_AXI_PROT_EN_SET,
 				    MT8183_TOP_AXI_PROT_EN_CLR,
 				    MT8183_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(SMI,
-				    MT8183_SMI_COMMON_SMI_CLAMP_DISP,
-				    MT8183_SMI_COMMON_CLAMP_EN_SET,
-				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
-				    MT8183_SMI_COMMON_CLAMP_EN),
 		},
 	},
 	[MT8183_POWER_DOMAIN_CAM] = {
@@ -129,6 +131,13 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(9, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.clamp_smi = {
+			BUS_PROT_WR(SMI,
+				    MT8183_SMI_COMMON_SMI_CLAMP_CAM,
+				    MT8183_SMI_COMMON_CLAMP_EN_SET,
+				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
+				    MT8183_SMI_COMMON_CLAMP_EN),
+		},
 		.bp_cfg = {
 			BUS_PROT_WR(INFRA,
 				    MT8183_TOP_AXI_PROT_EN_MM_CAM,
@@ -145,11 +154,6 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 					MT8183_TOP_AXI_PROT_EN_MM_SET,
 					MT8183_TOP_AXI_PROT_EN_MM_CLR,
 					MT8183_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(SMI,
-				    MT8183_SMI_COMMON_SMI_CLAMP_CAM,
-				    MT8183_SMI_COMMON_CLAMP_EN_SET,
-				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
-				    MT8183_SMI_COMMON_CLAMP_EN),
 		},
 	},
 	[MT8183_POWER_DOMAIN_ISP] = {
@@ -160,6 +164,13 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(9, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.clamp_smi = {
+			BUS_PROT_WR(SMI,
+				    MT8183_SMI_COMMON_SMI_CLAMP_ISP,
+				    MT8183_SMI_COMMON_CLAMP_EN_SET,
+				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
+				    MT8183_SMI_COMMON_CLAMP_EN),
+		},
 		.bp_cfg = {
 			BUS_PROT_WR(INFRA,
 				    MT8183_TOP_AXI_PROT_EN_MM_ISP,
@@ -171,11 +182,6 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 					MT8183_TOP_AXI_PROT_EN_MM_SET,
 					MT8183_TOP_AXI_PROT_EN_MM_CLR,
 					MT8183_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(SMI,
-				    MT8183_SMI_COMMON_SMI_CLAMP_ISP,
-				    MT8183_SMI_COMMON_CLAMP_EN_SET,
-				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
-				    MT8183_SMI_COMMON_CLAMP_EN),
 		},
 	},
 	[MT8183_POWER_DOMAIN_VDEC] = {
@@ -186,7 +192,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_cfg = {
+		.clamp_smi = {
 			BUS_PROT_WR(SMI,
 				    MT8183_SMI_COMMON_SMI_CLAMP_VDEC,
 				    MT8183_SMI_COMMON_CLAMP_EN_SET,
@@ -202,7 +208,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
-		.bp_cfg = {
+		.clamp_smi = {
 			BUS_PROT_WR(SMI,
 				    MT8183_SMI_COMMON_SMI_CLAMP_VENC,
 				    MT8183_SMI_COMMON_CLAMP_EN_SET,
@@ -218,6 +224,13 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.clamp_smi = {
+			BUS_PROT_WR(SMI,
+				    MT8183_SMI_COMMON_SMI_CLAMP_VPU_TOP,
+				    MT8183_SMI_COMMON_CLAMP_EN_SET,
+				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
+				    MT8183_SMI_COMMON_CLAMP_EN),
+		},
 		.bp_cfg = {
 			BUS_PROT_WR(INFRA,
 				    MT8183_TOP_AXI_PROT_EN_MM_VPU_TOP,
@@ -234,11 +247,6 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 				    MT8183_TOP_AXI_PROT_EN_MM_SET,
 				    MT8183_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8183_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(SMI,
-				    MT8183_SMI_COMMON_SMI_CLAMP_VPU_TOP,
-				    MT8183_SMI_COMMON_CLAMP_EN_SET,
-				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
-				    MT8183_SMI_COMMON_CLAMP_EN),
 		},
 	},
 	[MT8183_POWER_DOMAIN_VPU_CORE0] = {
diff --git a/drivers/pmdomain/mediatek/mt8188-pm-domains.h b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
index ade3c01149af..be2393c41f3e 100644
--- a/drivers/pmdomain/mediatek/mt8188-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
@@ -577,6 +577,18 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
+		.clamp_smi = {
+			BUS_PROT_WR(SMI,
+				    MT8188_SMI_COMMON_SMI_CLAMP_DIP_TO_VDO0,
+				    MT8188_SMI_COMMON_CLAMP_EN_SET,
+				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
+				    MT8188_SMI_COMMON_CLAMP_EN_STA),
+			BUS_PROT_WR(SMI,
+				    MT8188_SMI_COMMON_SMI_CLAMP_DIP_TO_VPP1,
+				    MT8188_SMI_COMMON_CLAMP_EN_SET,
+				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
+				    MT8188_SMI_COMMON_CLAMP_EN_STA),
+		},
 		.reset_smi = {
 			SMI_RESET_WR(MT8188_SMI_LARB10_RESET,
 				     MT8188_SMI_LARB10_RESET_ADDR),
@@ -589,7 +601,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 			SMI_RESET_WR(MT8188_SMI_LARB15_RESET,
 				     MT8188_SMI_LARB15_RESET_ADDR),
 		},
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_CLAMP_PROTECTION,
 	},
 	[MT8188_POWER_DOMAIN_IPE] = {
 		.name = "ipe",
@@ -599,11 +611,18 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
+		.clamp_smi = {
+			BUS_PROT_WR(SMI,
+				    MT8188_SMI_COMMON_SMI_CLAMP_IPE_TO_VPP1,
+				    MT8188_SMI_COMMON_CLAMP_EN_SET,
+				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
+				    MT8188_SMI_COMMON_CLAMP_EN_STA),
+		},
 		.reset_smi = {
 			SMI_RESET_WR(MT8188_SMI_LARB12_RESET,
 				     MT8188_SMI_LARB12_RESET_ADDR),
 		},
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_CLAMP_PROTECTION,
 	},
 	[MT8188_POWER_DOMAIN_CAM_VCORE] = {
 		.name = "cam_vcore",
@@ -682,13 +701,20 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
+		.clamp_smi = {
+			BUS_PROT_WR(SMI,
+				    MT8188_SMI_COMMON_SMI_CLAMP_CAM_SUBA_TO_VPP0,
+				    MT8188_SMI_COMMON_CLAMP_EN_SET,
+				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
+				    MT8188_SMI_COMMON_CLAMP_EN_STA),
+		},
 		.reset_smi = {
 			SMI_RESET_WR(MT8188_SMI_LARB16A_RESET,
 				     MT8188_SMI_LARB16A_RESET_ADDR),
 			SMI_RESET_WR(MT8188_SMI_LARB17A_RESET,
 				     MT8188_SMI_LARB17A_RESET_ADDR),
 		},
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_CLAMP_PROTECTION,
 	},
 	[MT8188_POWER_DOMAIN_CAM_SUBB] = {
 		.name = "cam_subb",
@@ -698,13 +724,20 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
+		.clamp_smi = {
+			BUS_PROT_WR(SMI,
+				    MT8188_SMI_COMMON_SMI_CLAMP_CAM_SUBB_TO_VDO0,
+				    MT8188_SMI_COMMON_CLAMP_EN_SET,
+				    MT8188_SMI_COMMON_CLAMP_EN_CLR,
+				    MT8188_SMI_COMMON_CLAMP_EN_STA),
+		},
 		.reset_smi = {
 			SMI_RESET_WR(MT8188_SMI_LARB16B_RESET,
 				     MT8188_SMI_LARB16B_RESET_ADDR),
 			SMI_RESET_WR(MT8188_SMI_LARB17B_RESET,
 				     MT8188_SMI_LARB17B_RESET_ADDR),
 		},
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_CLAMP_PROTECTION,
 	},
 };
 
diff --git a/drivers/pmdomain/mediatek/mt8365-pm-domains.h b/drivers/pmdomain/mediatek/mt8365-pm-domains.h
index 3d83d49eaa7c..f9813cdcd3aa 100644
--- a/drivers/pmdomain/mediatek/mt8365-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8365-pm-domains.h
@@ -76,7 +76,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8365[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_cfg = {
+		.clamp_smi = {
 			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(1),
 		},
 	},
@@ -138,10 +138,12 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8365[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(9, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.clamp_smi = {
+			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(2),
+		},
 		.bp_cfg = {
 			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
 				MT8365_INFRA_TOPAXI_PROTECTEN_1_CAM2MM_AXI_GALS_MST),
-			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(2),
 		},
 	},
 	[MT8365_POWER_DOMAIN_VDEC] = {
@@ -152,7 +154,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8365[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_cfg = {
+		.clamp_smi = {
 			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(3),
 		},
 	},
@@ -164,11 +166,13 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8365[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(14, 8),
 		.sram_pdn_ack_bits = GENMASK(21, 15),
+		.clamp_smi = {
+			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(4),
+		},
 		.bp_cfg = {
 			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
 				MT8365_INFRA_TOPAXI_PROTECTEN_1_APU2AP |
 				MT8365_INFRA_TOPAXI_PROTECTEN_1_APU_CBIP_GALS_MST),
-			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(4),
 		},
 	},
 	[MT8365_POWER_DOMAIN_DSP] = {
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 488920d29fbc..061296feb289 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -47,9 +47,10 @@ struct scpsys_domain {
 	struct clk_bulk_data *subsys_clks;
 	struct regmap *infracfg_nao;
 	struct regmap *infracfg;
-	struct regmap *smi;
+	struct regmap **smi;
 	struct regmap **larb;
 	int num_larb;
+	int num_smi;
 	struct regulator *supply;
 };
 
@@ -78,6 +79,71 @@ static bool scpsys_domain_is_on(struct scpsys_domain *pd)
 	return status && status2;
 }
 
+static int _scpsys_clamp_bus_protection_enable(const struct scpsys_bus_prot_data bpd,
+					       struct regmap *regmap)
+{
+	u32 val = 0, mask = bpd.bus_prot_sta_mask;
+
+	if (!mask)
+		return 0;
+
+	if (bpd.flags & BUS_PROT_REG_UPDATE)
+		regmap_set_bits(regmap, bpd.bus_prot_set, mask);
+	else
+		regmap_write(regmap, bpd.bus_prot_set, mask);
+
+	return regmap_read_poll_timeout(regmap, bpd.bus_prot_sta,
+				       val, (val & mask) == mask,
+				       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+}
+
+static int scpsys_clamp_bus_protection_enable(struct scpsys_domain *pd)
+{
+	int ret, i;
+
+	for (i = 0; i < pd->num_smi; i++) {
+		ret = _scpsys_clamp_bus_protection_enable(pd->data->clamp_smi[i], pd->smi[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int _scpsys_clamp_bus_protection_disable(const struct scpsys_bus_prot_data bpd,
+						struct regmap *regmap)
+{
+	u32 val = 0, mask = bpd.bus_prot_sta_mask;
+
+	if (!mask)
+		return 0;
+
+	if (bpd.flags & BUS_PROT_REG_UPDATE)
+		regmap_clear_bits(regmap, bpd.bus_prot_clr, mask);
+	else
+		regmap_write(regmap, bpd.bus_prot_clr, mask);
+
+	if (bpd.flags & BUS_PROT_IGNORE_CLR_ACK)
+		return 0;
+
+	return regmap_read_poll_timeout(regmap, bpd.bus_prot_sta,
+				       val, !(val & mask),
+				       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+}
+
+static int scpsys_clamp_bus_protection_disable(struct scpsys_domain *pd)
+{
+	int ret, i;
+
+	for (i = pd->num_smi - 1 ; i >= 0; i--) {
+		ret = _scpsys_clamp_bus_protection_disable(pd->data->clamp_smi[i], pd->smi[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int scpsys_sram_enable(struct scpsys_domain *pd)
 {
 	u32 pdn_ack = pd->data->sram_pdn_ack_bits;
@@ -122,14 +188,6 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
 					MTK_POLL_TIMEOUT);
 }
 
-static struct regmap *scpsys_bus_protect_get_regmap(struct scpsys_domain *pd,
-						    const struct scpsys_bus_prot_data *bpd)
-{
-	if (bpd->flags & BUS_PROT_COMPONENT_SMI)
-		return pd->smi;
-	else
-		return pd->infracfg;
-}
 
 static struct regmap *scpsys_bus_protect_get_sta_regmap(struct scpsys_domain *pd,
 							const struct scpsys_bus_prot_data *bpd)
@@ -137,14 +195,14 @@ static struct regmap *scpsys_bus_protect_get_sta_regmap(struct scpsys_domain *pd
 	if (bpd->flags & BUS_PROT_STA_COMPONENT_INFRA_NAO)
 		return pd->infracfg_nao;
 	else
-		return scpsys_bus_protect_get_regmap(pd, bpd);
+		return pd->infracfg;
 }
 
 static int scpsys_bus_protect_clear(struct scpsys_domain *pd,
 				    const struct scpsys_bus_prot_data *bpd)
 {
 	struct regmap *sta_regmap = scpsys_bus_protect_get_sta_regmap(pd, bpd);
-	struct regmap *regmap = scpsys_bus_protect_get_regmap(pd, bpd);
+	struct regmap *regmap = pd->infracfg;
 	u32 sta_mask = bpd->bus_prot_sta_mask;
 	u32 expected_ack;
 	u32 val;
@@ -168,7 +226,7 @@ static int scpsys_bus_protect_set(struct scpsys_domain *pd,
 				  const struct scpsys_bus_prot_data *bpd)
 {
 	struct regmap *sta_regmap = scpsys_bus_protect_get_sta_regmap(pd, bpd);
-	struct regmap *regmap = scpsys_bus_protect_get_regmap(pd, bpd);
+	struct regmap *regmap = pd->infracfg;
 	u32 sta_mask = bpd->bus_prot_sta_mask;
 	u32 val;
 
@@ -199,14 +257,19 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 			return ret;
 	}
 
-	return 0;
+	return scpsys_clamp_bus_protection_enable(pd);
 }
 
 static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
 {
+	int ret;
+
+	ret = scpsys_clamp_bus_protection_disable(pd);
+	if (ret)
+		return ret;
+
 	for (int i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
 		const struct scpsys_bus_prot_data *bpd = &pd->data->bp_cfg[i];
-		int ret;
 
 		if (!bpd->bus_prot_set_clr_mask)
 			continue;
@@ -272,6 +335,12 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	bool tmp;
 	int ret;
 
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_CLAMP_PROTECTION)) {
+		ret = scpsys_clamp_bus_protection_enable(pd);
+		if (ret)
+			return ret;
+	}
+
 	ret = scpsys_regulator_enable(pd->supply);
 	if (ret)
 		return ret;
@@ -318,6 +387,12 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		goto err_disable_subsys_clks;
 
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_CLAMP_PROTECTION)) {
+		ret = scpsys_clamp_bus_protection_disable(pd);
+		if (ret)
+			return ret;
+	}
+
 	ret = scpsys_bus_protect_disable(pd);
 	if (ret < 0)
 		goto err_disable_sram;
@@ -353,6 +428,12 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	bool tmp;
 	int ret;
 
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_CLAMP_PROTECTION)) {
+		ret = scpsys_clamp_bus_protection_enable(pd);
+		if (ret)
+			return ret;
+	}
+
 	ret = scpsys_bus_protect_enable(pd);
 	if (ret < 0)
 		return ret;
@@ -450,12 +531,23 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 	if (IS_ERR(pd->infracfg))
 		return ERR_CAST(pd->infracfg);
 
-	smi_node = of_parse_phandle(node, "mediatek,smi", 0);
-	if (smi_node) {
-		pd->smi = device_node_to_regmap(smi_node);
-		of_node_put(smi_node);
-		if (IS_ERR(pd->smi))
-			return ERR_CAST(pd->smi);
+	pd->num_smi = of_count_phandle_with_args(node, "mediatek,smi", NULL);
+	if (pd->num_smi > 0) {
+		pd->smi = devm_kcalloc(scpsys->dev, pd->num_smi, sizeof(*pd->smi), GFP_KERNEL);
+		if (!pd->smi)
+			return ERR_PTR(-ENOMEM);
+
+		for (i = 0; i < pd->num_smi; i++) {
+			smi_node = of_parse_phandle(node, "mediatek,smi", i);
+			if (!smi_node)
+				return ERR_PTR(-EINVAL);
+
+			pd->smi[i] = syscon_node_to_regmap(smi_node);
+			if (IS_ERR(pd->smi[i]))
+				return ERR_CAST(pd->smi[i]);
+		}
+	} else {
+		pd->num_smi = 0;
 	}
 
 	pd->num_larb = of_count_phandle_with_args(node, "mediatek,larb", NULL);
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
index 31c2a1bb500f..f903e2943f0e 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
@@ -13,6 +13,7 @@
 #define MTK_SCPD_EXT_BUCK_ISO		BIT(6)
 #define MTK_SCPD_HAS_INFRA_NAO		BIT(7)
 #define MTK_SCPD_STRICT_BUS_PROTECTION	BIT(8)
+#define MTK_SCPD_CLAMP_PROTECTION	BIT(9)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
@@ -120,6 +121,7 @@ struct scpsys_domain_data {
 	int ext_buck_iso_offs;
 	u32 ext_buck_iso_mask;
 	u16 caps;
+	const struct scpsys_bus_prot_data clamp_smi[SPM_MAX_BUS_PROT_DATA];
 	const struct scpsys_bus_prot_data bp_cfg[SPM_MAX_BUS_PROT_DATA];
 	const struct smi_reset_data reset_smi[SPM_MAX_SMI_RESET_DATA];
 	int pwr_sta_offs;
-- 
2.18.0


