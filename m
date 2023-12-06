Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266278069D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377226AbjLFIiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377152AbjLFIiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:38:17 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D385B2;
        Wed,  6 Dec 2023 00:38:22 -0800 (PST)
X-UUID: ccdf95b8941211ee8051498923ad61e6-20231206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Puf7aC0ffFLVShQcmurGizt78XgjK4174KnsBpyQSTM=;
        b=PivA16kKDMDhx/7yTa44YOGVn3hOXaNyg0cxvUz52nIvzWHynV2RQfJGPbVMm2eeIR+MSveM8wpbr+vPiHTnE4P4laiyHuyGsObE7TAv7zQ8HJM4ipCJIQ8BnBPw+2AFKdfqeg3uQWZ+6lctIDF+PlTNS/WGSDdmlut0fd0b4f8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:18d2ae4b-1439-4431-926f-d83db1323c85,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:abefa75,CLOUDID:df7459fd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ccdf95b8941211ee8051498923ad61e6-20231206
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 95441290; Wed, 06 Dec 2023 16:38:16 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 6 Dec 2023 16:38:14 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 6 Dec 2023 16:38:14 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jieyy.yang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <jian.yang@mediatek.com>, <jianguo.zhang@mediatek.com>
Subject: [PATCH 2/2] PCI: mediatek-gen3: Allocate MSI address with dmam_alloc_coherent
Date:   Wed, 6 Dec 2023 16:37:53 +0800
Message-ID: <20231206083753.18186-3-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206083753.18186-1-jianjun.wang@mediatek.com>
References: <20231206083753.18186-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.386500-8.000000
X-TMASE-MatchedRID: tSW7VXhmRxioft0ZW3r/iRn0UD4GU5IqTJDl9FKHbrk0TnKEqFpI6pG/
        qoYvgCpn/VuBejcr7X5fpDE3h+Imb4HcC7KYYAdES3OTftLNfg3bKTxp3+WtICS30GKAkBxWUAt
        gPdAuvr3jNluKaKW/VO7tPpbCinSKSU4HY/UZD6STd7CJ8bYw0/W9apciTRhdmyiLZetSf8mfop
        0ytGwvXiq2rl3dzGQ1s1Sz8fruYFIcLc7jOSzYvDVa+W8cdRzgCLBbEQ2WdHayszz+BMY72cC+k
        sT6a9fy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.386500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 4F95061B8ACB20A07432462435BA010075248B0BDDE7C2BEFA8E9091C21592402000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'dmam_alloc_coherent' to allocate the MSI address, instead of using
static physical address.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 30 +++++++++++----------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index e0e27645fdf4..0b1b5c8e5288 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -108,7 +108,7 @@
  */
 struct mtk_msi_set {
 	void __iomem *base;
-	phys_addr_t msg_addr;
+	dma_addr_t msg_addr;
 	u32 saved_irq_state;
 };
 
@@ -116,7 +116,6 @@ struct mtk_msi_set {
  * struct mtk_gen3_pcie - PCIe port information
  * @dev: pointer to PCIe device
  * @base: IO mapped register base
- * @reg_base: physical register base
  * @mac_reset: MAC reset control
  * @phy_reset: PHY reset control
  * @phy: PHY controller block
@@ -135,7 +134,6 @@ struct mtk_msi_set {
 struct mtk_gen3_pcie {
 	struct device *dev;
 	void __iomem *base;
-	phys_addr_t reg_base;
 	struct reset_control *mac_reset;
 	struct reset_control *phy_reset;
 	struct phy *phy;
@@ -278,18 +276,24 @@ static int mtk_pcie_set_trans_table(struct mtk_gen3_pcie *pcie,
 	return 0;
 }
 
-static void mtk_pcie_enable_msi(struct mtk_gen3_pcie *pcie)
+static int mtk_pcie_enable_msi(struct mtk_gen3_pcie *pcie)
 {
 	int i;
 	u32 val;
+	void *msi_vaddr;
 
 	for (i = 0; i < PCIE_MSI_SET_NUM; i++) {
 		struct mtk_msi_set *msi_set = &pcie->msi_sets[i];
 
 		msi_set->base = pcie->base + PCIE_MSI_SET_BASE_REG +
 				i * PCIE_MSI_SET_OFFSET;
-		msi_set->msg_addr = pcie->reg_base + PCIE_MSI_SET_BASE_REG +
-				    i * PCIE_MSI_SET_OFFSET;
+
+		msi_vaddr = dmam_alloc_coherent(pcie->dev, sizeof(dma_addr_t), &msi_set->msg_addr,
+						GFP_KERNEL);
+		if (!msi_vaddr) {
+			dev_err(pcie->dev, "failed to alloc and map MSI data for set %d\n", i);
+			return -ENOMEM;
+		}
 
 		/* Configure the MSI capture address */
 		writel_relaxed(lower_32_bits(msi_set->msg_addr), msi_set->base);
@@ -305,6 +309,8 @@ static void mtk_pcie_enable_msi(struct mtk_gen3_pcie *pcie)
 	val = readl_relaxed(pcie->base + PCIE_INT_ENABLE_REG);
 	val |= PCIE_MSI_ENABLE;
 	writel_relaxed(val, pcie->base + PCIE_INT_ENABLE_REG);
+
+	return 0;
 }
 
 static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
@@ -371,7 +377,9 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 		return err;
 	}
 
-	mtk_pcie_enable_msi(pcie);
+	err = mtk_pcie_enable_msi(pcie);
+	if (err)
+		return err;
 
 	/* Set PCIe translation windows */
 	resource_list_for_each_entry(entry, &host->windows) {
@@ -762,20 +770,14 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	struct resource *regs;
 	int ret;
 
-	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
-	if (!regs)
-		return -EINVAL;
-	pcie->base = devm_ioremap_resource(dev, regs);
+	pcie->base = devm_platform_ioremap_resource_byname(pdev, "pcie-mac");
 	if (IS_ERR(pcie->base)) {
 		dev_err(dev, "failed to map register base\n");
 		return PTR_ERR(pcie->base);
 	}
 
-	pcie->reg_base = regs->start;
-
 	pcie->phy_reset = devm_reset_control_get_optional_exclusive(dev, "phy");
 	if (IS_ERR(pcie->phy_reset)) {
 		ret = PTR_ERR(pcie->phy_reset);
-- 
2.18.0

