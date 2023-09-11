Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730E779A0F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 03:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjIKBSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 21:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjIKBSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 21:18:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2E4E65
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 18:18:34 -0700 (PDT)
X-UUID: 1d60a61e504111ee8051498923ad61e6-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=im0q8ClCjXD2mvVerYz5I3/8z9Q0AW/ovNXXUp9V+iY=;
        b=XFrx3yOU2YRryg3Ovz2IveZUrsgtW9oD+cXJwS6OjpghnNgPq0mXVtAFodFEzQwUomZSxav53upWZWxJqm5RkVQ2e3VA/Mqgd/JA2Ne+VHKRJUZ9I1JpFEvqDhqY8gWoME4lOI63ds2LOeZ0Kx9yckB/4JU3lk4LiwYfPYgvWJ8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:fbcc377f-84bc-4949-929a-dbe87507d299,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:a311ddc2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1d60a61e504111ee8051498923ad61e6-20230911
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 80653923; Mon, 11 Sep 2023 09:18:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 09:18:27 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 09:18:26 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <iommu@lists.linux.dev>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <anan.sun@mediatek.com>,
        <yf.wang@mediatek.com>, <mingyuan.ma@mediatek.com>,
        "T . J . Mercier" <tjmercier@google.com>
Subject: [PATCH 4/4] iommu/mediatek: mt8188: Enable secure bank for MM IOMMU
Date:   Mon, 11 Sep 2023 09:17:51 +0800
Message-ID: <20230911011751.29906-5-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911011751.29906-1-yong.wu@mediatek.com>
References: <20230911011751.29906-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.598800-8.000000
X-TMASE-MatchedRID: B3Nm01t+RNhCFB88XbRv2bEKX02srTXIecN1rDssvvDfUZT83lbkEN6M
        yUV+2+DZGlJMOm/5VnDPKWCeeNrZI1xxDx5qbkR9FEUknJ/kEl4YSQiB0ZTudfoLR4+zsDTt+GY
        UedkXNWqL/HZHDiyt++LzVTV0D0HpQEFsbYa5mcq99t6fBcMggP3DHWJiJx+xOZ4YLhUX84hl1c
        /Yz0rsldD5p8F+rstIdazI6Mv0D0LyNp7g4PXe0BXsxz6ujBxUq1f8XSkHBUmNJXmEMVvLtmcjF
        nImzvyS
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.598800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: A88BD7686A6A1EF7415F10E6A74A8CDC5FA3F3BCB510FDC2C554BB6F39BEFA0D2000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable secure bank for MT8188 VDO IOMMU and VPP IOMMU to support
secure video path (SVP) feature. The last bank is the secure bank.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 24d7f5138f7b..f17046157c79 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1667,11 +1667,11 @@ static const struct mtk_iommu_plat_data mt8188_data_vdo = {
 	.m4u_plat       = M4U_MT8188,
 	.flags          = HAS_BCLK | HAS_SUB_COMM_3BITS | OUT_ORDER_WR_EN |
 			  WR_THROT_EN | IOVA_34_EN | SHARE_PGTABLE |
-			  PGTABLE_PA_35_EN | MTK_IOMMU_TYPE_MM,
+			  PGTABLE_PA_35_EN | MTK_IOMMU_TYPE_MM | SECURE_BANK_ENABLE,
 	.hw_list        = &m4ulist,
 	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
-	.banks_num      = 1,
-	.banks_enable   = {true},
+	.banks_num      = 5,
+	.banks_enable   = {true, false, false, false, true},
 	.iova_region    = mt8192_multi_dom,
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
 	.iova_region_larb_msk = mt8188_larb_region_msk,
@@ -1684,11 +1684,11 @@ static const struct mtk_iommu_plat_data mt8188_data_vpp = {
 	.m4u_plat       = M4U_MT8188,
 	.flags          = HAS_BCLK | HAS_SUB_COMM_3BITS | OUT_ORDER_WR_EN |
 			  WR_THROT_EN | IOVA_34_EN | SHARE_PGTABLE |
-			  PGTABLE_PA_35_EN | MTK_IOMMU_TYPE_MM,
+			  PGTABLE_PA_35_EN | MTK_IOMMU_TYPE_MM | SECURE_BANK_ENABLE,
 	.hw_list        = &m4ulist,
 	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
-	.banks_num      = 1,
-	.banks_enable   = {true},
+	.banks_num      = 5,
+	.banks_enable   = {true, false, false, false, true},
 	.iova_region    = mt8192_multi_dom,
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
 	.iova_region_larb_msk = mt8188_larb_region_msk,
-- 
2.25.1

