Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A5579A0F1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 03:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjIKBSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 21:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjIKBSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 21:18:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331E4FE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 18:18:12 -0700 (PDT)
X-UUID: 10f0e95c504111eea33bb35ae8d461a2-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=prYRPyTm4zGUUepD1sORlA/24bua8ojq7IlfZZI2pe8=;
        b=pt+z4Q7zK2al4TstKDIXKtBhZ1DVZ+e1X49Wb7eRv+r7Gw1/fn9kfsq24z8EQ8Mbd3Z+NIOLlH4nLtc4lOnts78GirfXH5w3ltavMMokB8qTkl+aZLlA7GQflkyxcYwjCDpQaAM+rbdsQPFQ6nT7nOD3diFVB/+C9pdaFwBMTx4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:a2a3e0de-4070-4d74-be27-ed6b1f9e6baa,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:4,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:4
X-CID-META: VersionHash:0ad78a4,CLOUDID:5bb788ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 10f0e95c504111eea33bb35ae8d461a2-20230911
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 862504465; Mon, 11 Sep 2023 09:18:08 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 09:18:07 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 09:18:06 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
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
Subject: [PATCH 1/4] iommu/mediatek: Initialise the secure bank
Date:   Mon, 11 Sep 2023 09:17:48 +0800
Message-ID: <20230911011751.29906-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911011751.29906-1-yong.wu@mediatek.com>
References: <20230911011751.29906-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The lastest IOMMU always have 5 banks, and we always use the last bank
(id:4) for the secure memory address translation. This patch add a new
flag (SECURE_BANK_ENABLE) for this feature.

For the secure bank, its kernel va "base" is not helpful since the
secure bank registers has already been protected and can only be accessed
in the secure world. But we still record its register base, because we need
use it to determine which IOMMU HW the translation fault happen in the
secure world.

Signed-off-by: Anan Sun <anan.sun@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 640275873a27..4a2cffb28c61 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -146,6 +146,7 @@
 #define TF_PORT_TO_ADDR_MT8173		BIT(18)
 #define INT_ID_PORT_WIDTH_6		BIT(19)
 #define CFG_IFA_MASTER_IN_ATF		BIT(20)
+#define SECURE_BANK_ENABLE		BIT(21)
 
 #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
 				((((pdata)->flags) & (mask)) == (_x))
@@ -162,6 +163,8 @@
 #define MTK_IOMMU_GROUP_MAX	8
 #define MTK_IOMMU_BANK_MAX	5
 
+#define MTK_IOMMU_SEC_BANKID	4
+
 enum mtk_iommu_plat {
 	M4U_MT2712,
 	M4U_MT6779,
@@ -240,9 +243,13 @@ struct mtk_iommu_plat_data {
 };
 
 struct mtk_iommu_bank_data {
-	void __iomem			*base;
+	union {
+		void __iomem		*base;
+		phys_addr_t		sec_bank_base;
+	};
 	int				irq;
 	u8				id;
+	bool				is_secure;
 	struct device			*parent_dev;
 	struct mtk_iommu_data		*parent_data;
 	spinlock_t			tlb_lock; /* lock for tlb range flush */
@@ -1309,7 +1316,15 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			continue;
 		bank = &data->bank[i];
 		bank->id = i;
-		bank->base = base + i * MTK_IOMMU_BANK_SZ;
+		if (MTK_IOMMU_HAS_FLAG(data->plat_data, SECURE_BANK_ENABLE) &&
+		    bank->id == MTK_IOMMU_SEC_BANKID) {
+			/* Record the secure bank base to indicate which iommu TF in sec world */
+			bank->sec_bank_base = res->start + i * MTK_IOMMU_BANK_SZ;
+			bank->is_secure = true;
+		} else {
+			bank->base = base + i * MTK_IOMMU_BANK_SZ;
+			bank->is_secure = false;
+		}
 		bank->m4u_dom = NULL;
 
 		bank->irq = platform_get_irq(pdev, i);
-- 
2.25.1

