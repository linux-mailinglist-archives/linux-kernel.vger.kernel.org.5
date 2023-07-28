Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522E3766201
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjG1Ckw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjG1CkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:40:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD0D3580;
        Thu, 27 Jul 2023 19:40:14 -0700 (PDT)
X-UUID: 0daaad6a2cf011eeb20a276fd37b9834-20230728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3pZFqE2y9D9PRaM6rQ4fkTK3Ruxj+t8ui38IWeqFk8Y=;
        b=FGv61PCu9JAI3s4l3Y2kWtXjoq1U/lUAGSIdwRhgZB2ubgijTurNAt8nvmRoj9WBPizvtezm98KppPkmYFfaIfqGcUtk7xqMwzg2EufBD8SjkSQekD7R/luvS55lXsYRjk2bcrmKnsHWCNMNgGfgYxaym8JIctEN9NSS9Qy3vX8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:42bc4ecd-4bda-4a42-94fd-8288b20d8fb8,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:1fcc6f8,CLOUDID:2ff78a42-d291-4e62-b539-43d7d78362ba,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0daaad6a2cf011eeb20a276fd37b9834-20230728
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 237579189; Fri, 28 Jul 2023 10:40:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 28 Jul 2023 10:40:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 28 Jul 2023 10:40:01 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v16 06/14] remoteproc: mediatek: Revise SCP rproc initialization flow for multi-core SCP
Date:   Fri, 28 Jul 2023 10:39:51 +0800
Message-ID: <20230728023959.12293-7-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230728023959.12293-1-tinghan.shen@mediatek.com>
References: <20230728023959.12293-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 2nd preliminary step for probing multi-core SCP.
Initialization of configuration and L1TCM registers is extracted
to only performed once on multi-core SCP. The rest of remoteproc
initialization procedure is similar for both single and multi-core
SCP and is applied to each core.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_scp.c | 63 ++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index f88e60e4bc21..7a2ba1e1e95a 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -854,21 +854,17 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
 	}
 }
 
-static int scp_probe(struct platform_device *pdev)
+static int scp_rproc_init(struct platform_device *pdev,
+			  struct mtk_scp_of_cluster *scp_cluster)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct mtk_scp *scp;
-	struct mtk_scp_of_cluster *scp_cluster;
 	struct rproc *rproc;
 	struct resource *res;
 	const char *fw_name = "scp.img";
 	int ret, i;
 
-	scp_cluster = devm_kzalloc(dev, sizeof(*scp_cluster), GFP_KERNEL);
-	if (!scp_cluster)
-		return -ENOMEM;
-
 	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
 	if (ret < 0 && ret != -EINVAL)
 		return ret;
@@ -893,24 +889,6 @@ static int scp_probe(struct platform_device *pdev)
 	scp->sram_size = resource_size(res);
 	scp->sram_phys = res->start;
 
-	/* l1tcm is an optional memory region */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "l1tcm");
-	scp->cluster->l1tcm_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(scp->cluster->l1tcm_base)) {
-		ret = PTR_ERR(scp->cluster->l1tcm_base);
-		if (ret != -EINVAL) {
-			return dev_err_probe(dev, ret, "Failed to map l1tcm memory\n");
-		}
-	} else {
-		scp->cluster->l1tcm_size = resource_size(res);
-		scp->cluster->l1tcm_phys = res->start;
-	}
-
-	scp->cluster->reg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
-	if (IS_ERR(scp->cluster->reg_base))
-		return dev_err_probe(dev, PTR_ERR(scp->cluster->reg_base),
-				     "Failed to parse and map cfg memory\n");
-
 	ret = scp->data->scp_clk_get(scp);
 	if (ret)
 		return ret;
@@ -962,6 +940,43 @@ static int scp_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int scp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_scp_of_cluster *scp_cluster;
+	struct resource *res;
+	int ret;
+
+	scp_cluster = devm_kzalloc(dev, sizeof(*scp_cluster), GFP_KERNEL);
+	if (!scp_cluster)
+		return -ENOMEM;
+
+	scp_cluster->reg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
+	if (IS_ERR(scp_cluster->reg_base))
+		return dev_err_probe(dev, PTR_ERR(scp_cluster->reg_base),
+				     "Failed to parse and map cfg memory\n");
+
+	/* l1tcm is an optional memory region */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "l1tcm");
+	scp_cluster->l1tcm_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(scp_cluster->l1tcm_base)) {
+		ret = PTR_ERR(scp_cluster->l1tcm_base);
+		if (ret != -EINVAL)
+			return dev_err_probe(dev, ret, "Failed to map l1tcm memory\n");
+
+		scp_cluster->l1tcm_base = NULL;
+	} else {
+		scp_cluster->l1tcm_size = resource_size(res);
+		scp_cluster->l1tcm_phys = res->start;
+	}
+
+	ret = scp_rproc_init(pdev, scp_cluster);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static void scp_remove(struct platform_device *pdev)
 {
 	struct mtk_scp *scp = platform_get_drvdata(pdev);
-- 
2.18.0

