Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C2878184B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 10:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjHSIQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 04:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHSIPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 04:15:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AF62701
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 01:15:04 -0700 (PDT)
X-UUID: 7bd5c0023e6811eeb20a276fd37b9834-20230819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Ls0IdxKcV0zs2a86C/WRgplohD3oAveG5LkpKErqf4o=;
        b=e25wXzzMCPCZMMVxd37r0srcZinKRp3OFHRaHxHKzOz8ExRI3vqn5FLGWRK0Llz4a4t0Geo/BdTFOYxABj2If6aVplRAWUtLEo85GnAgIP5dG677+haYd7Y6wc8mgtzrFwn9tzESq6ntz7IOkJFsYf9WAmaGsaqqKa43OB22dYw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:fffad3fa-33d9-483c-8b01-7f56a007f487,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:6ff0811f-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 7bd5c0023e6811eeb20a276fd37b9834-20230819
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 815612229; Sat, 19 Aug 2023 16:14:57 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 19 Aug 2023 16:14:55 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 19 Aug 2023 16:14:55 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yong Wu <yong.wu@mediatek.com>, <iommu@lists.linux.dev>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Laura Nao <laura.nao@collabora.com>
Subject: [PATCH] iommu/mediatek: Fix share pgtable for iova over 4GB
Date:   Sat, 19 Aug 2023 16:14:43 +0800
Message-ID: <20230819081443.8333-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mt8192/mt8186, there is only one MM IOMMU that supports 16GB iova
space, which is shared by display, vcodec and camera. These two SoC use
one pgtable and have not the flag SHARE_PGTABLE, we should also keep
share pgtable for this case.

In mtk_iommu_domain_finalise, MM IOMMU always share pgtable, thus remove
the flag SHARE_PGTABLE checking. Infra IOMMU always uses independent
pgtable.

Fixes: cf69ef46dbd9 ("iommu/mediatek: Fix two IOMMU share pagetable issue")
Reported-by: Laura Nao <laura.nao@collabora.com>
Closes: https://lore.kernel.org/linux-iommu/20230818154156.314742-1-laura.nao@collabora.com/
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
Base on next-20230818.
---
 drivers/iommu/mtk_iommu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b17d3e7288a7..b5fcba305d2a 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -262,7 +262,7 @@ struct mtk_iommu_data {
 	struct device			*smicomm_dev;
 
 	struct mtk_iommu_bank_data	*bank;
-	struct mtk_iommu_domain		*share_dom; /* For 2 HWs share pgtable */
+	struct mtk_iommu_domain		*share_dom;
 
 	struct regmap			*pericfg;
 	struct mutex			mutex; /* Protect m4u_group/m4u_dom above */
@@ -643,8 +643,8 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
 	struct mtk_iommu_domain	*share_dom = data->share_dom;
 	const struct mtk_iommu_iova_region *region;
 
-	/* Always use share domain in sharing pgtable case */
-	if (MTK_IOMMU_HAS_FLAG(data->plat_data, SHARE_PGTABLE) && share_dom) {
+	/* Share pgtable when 2 MM IOMMU share the pgtable or one IOMMU use multiple iova ranges */
+	if (share_dom) {
 		dom->iop = share_dom->iop;
 		dom->cfg = share_dom->cfg;
 		dom->domain.pgsize_bitmap = share_dom->cfg.pgsize_bitmap;
@@ -677,8 +677,7 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
 	/* Update our support page sizes bitmap */
 	dom->domain.pgsize_bitmap = dom->cfg.pgsize_bitmap;
 
-	if (MTK_IOMMU_HAS_FLAG(data->plat_data, SHARE_PGTABLE))
-		data->share_dom = dom;
+	data->share_dom = dom;
 
 update_iova_region:
 	/* Update the iova region for this domain */
-- 
2.25.1

