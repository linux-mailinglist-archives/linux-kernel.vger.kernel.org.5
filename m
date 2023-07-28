Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A36766202
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjG1Ck5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjG1CkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:40:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E990230FA;
        Thu, 27 Jul 2023 19:40:10 -0700 (PDT)
X-UUID: 0deb3eac2cf011ee9cb5633481061a41-20230728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=E1I4y94JpFrj/cyXGPiYmWNT42ZTv2aJPznnViXrh1Y=;
        b=StoA8QgtoZKgwkJUOCH0fqM9Iy8YTv3436f7lL3e85J4jP9cH+dz5rjTSZFEurmWM1ut1tlHsiztRbv24FPpe+Bu2GUxI7GFb2316L0hC/oCFMOMC/lipQIUk2NVQIB8MQfDQcS4nggL2JEUGBHsZGg8oL5Mqau8nqKtq11C0fk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:0468e4d0-fd81-4888-b5b7-d9237dd0a596,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:3af78a42-d291-4e62-b539-43d7d78362ba,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0deb3eac2cf011ee9cb5633481061a41-20230728
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 813667608; Fri, 28 Jul 2023 10:40:03 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 28 Jul 2023 10:40:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 28 Jul 2023 10:40:02 +0800
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
Subject: [PATCH v16 07/14] remoteproc: mediatek: Probe SCP cluster on single-core SCP
Date:   Fri, 28 Jul 2023 10:39:52 +0800
Message-ID: <20230728023959.12293-8-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230728023959.12293-1-tinghan.shen@mediatek.com>
References: <20230728023959.12293-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 3rd preliminary step for probing multi-core SCP.
Rewrite the probing flow of single-core SCP to adapt with the 'cluster'
concept needed by the multi-core SCP. The SCP core object(s)
is maintained at the cluster list.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_common.h |  2 +
 drivers/remoteproc/mtk_scp.c    | 86 +++++++++++++++++++++++----------
 2 files changed, 63 insertions(+), 25 deletions(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index b04d71277c1f..1438159ae736 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -105,6 +105,7 @@ struct mtk_scp_of_cluster {
 	void __iomem *l1tcm_base;
 	size_t l1tcm_size;
 	phys_addr_t l1tcm_phys;
+	struct list_head mtk_scp_list;
 };
 
 struct mtk_scp {
@@ -132,6 +133,7 @@ struct mtk_scp {
 
 	struct rproc_subdev *rpmsg_subdev;
 
+	struct list_head elem;
 	struct mtk_scp_of_cluster *cluster;
 };
 
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 7a2ba1e1e95a..d67dcabdab9e 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -854,8 +854,8 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
 	}
 }
 
-static int scp_rproc_init(struct platform_device *pdev,
-			  struct mtk_scp_of_cluster *scp_cluster)
+static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
+				      struct mtk_scp_of_cluster *scp_cluster)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -867,11 +867,13 @@ static int scp_rproc_init(struct platform_device *pdev,
 
 	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
 	if (ret < 0 && ret != -EINVAL)
-		return ret;
+		return ERR_PTR(ret);
 
 	rproc = devm_rproc_alloc(dev, np->name, &scp_ops, fw_name, sizeof(*scp));
-	if (!rproc)
-		return dev_err_probe(dev, -ENOMEM, "unable to allocate remoteproc\n");
+	if (!rproc) {
+		dev_err(dev, "unable to allocate remoteproc\n");
+		return ERR_PTR(-ENOMEM);
+	}
 
 	scp = rproc->priv;
 	scp->rproc = rproc;
@@ -882,20 +884,21 @@ static int scp_rproc_init(struct platform_device *pdev,
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
 	scp->sram_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(scp->sram_base))
-		return dev_err_probe(dev, PTR_ERR(scp->sram_base),
-				     "Failed to parse and map sram memory\n");
+	if (IS_ERR(scp->sram_base)) {
+		dev_err(dev, "Failed to parse and map sram memory\n");
+		return ERR_CAST(scp->sram_base);
+	}
 
 	scp->sram_size = resource_size(res);
 	scp->sram_phys = res->start;
 
 	ret = scp->data->scp_clk_get(scp);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
 
 	ret = scp_map_memory_region(scp);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
 
 	mutex_init(&scp->send_lock);
 	for (i = 0; i < SCP_IPI_MAX; i++)
@@ -922,11 +925,7 @@ static int scp_rproc_init(struct platform_device *pdev,
 		goto remove_subdev;
 	}
 
-	ret = rproc_add(rproc);
-	if (ret)
-		goto remove_subdev;
-
-	return 0;
+	return scp;
 
 remove_subdev:
 	scp_remove_rpmsg_subdev(scp);
@@ -937,7 +936,43 @@ static int scp_rproc_init(struct platform_device *pdev,
 		mutex_destroy(&scp->ipi_desc[i].lock);
 	mutex_destroy(&scp->send_lock);
 
-	return ret;
+	return ERR_PTR(ret);
+}
+
+static void scp_free(struct mtk_scp *scp)
+{
+	int i;
+
+	scp_remove_rpmsg_subdev(scp);
+	scp_ipi_unregister(scp, SCP_IPI_INIT);
+	scp_unmap_memory_region(scp);
+	for (i = 0; i < SCP_IPI_MAX; i++)
+		mutex_destroy(&scp->ipi_desc[i].lock);
+	mutex_destroy(&scp->send_lock);
+}
+
+static int scp_cluster_init(struct platform_device *pdev,
+			    struct mtk_scp_of_cluster *scp_cluster)
+{
+	struct device *dev = &pdev->dev;
+	struct list_head *scp_list = &scp_cluster->mtk_scp_list;
+	struct mtk_scp *scp;
+	int ret;
+
+	scp = scp_rproc_init(pdev, scp_cluster);
+	if (IS_ERR(scp))
+		return PTR_ERR(scp);
+
+	ret = rproc_add(scp->rproc);
+	if (ret) {
+		dev_err(dev, "Failed to add rproc\n");
+		scp_free(scp);
+		return ret;
+	}
+
+	list_add_tail(&scp->elem, scp_list);
+
+	return 0;
 }
 
 static int scp_probe(struct platform_device *pdev)
@@ -970,7 +1005,9 @@ static int scp_probe(struct platform_device *pdev)
 		scp_cluster->l1tcm_phys = res->start;
 	}
 
-	ret = scp_rproc_init(pdev, scp_cluster);
+	INIT_LIST_HEAD(&scp_cluster->mtk_scp_list);
+
+	ret = scp_cluster_init(pdev, scp_cluster);
 	if (ret)
 		return ret;
 
@@ -980,15 +1017,14 @@ static int scp_probe(struct platform_device *pdev)
 static void scp_remove(struct platform_device *pdev)
 {
 	struct mtk_scp *scp = platform_get_drvdata(pdev);
-	int i;
+	struct mtk_scp_of_cluster *scp_cluster = scp->cluster;
+	struct mtk_scp *temp;
 
-	rproc_del(scp->rproc);
-	scp_remove_rpmsg_subdev(scp);
-	scp_ipi_unregister(scp, SCP_IPI_INIT);
-	scp_unmap_memory_region(scp);
-	for (i = 0; i < SCP_IPI_MAX; i++)
-		mutex_destroy(&scp->ipi_desc[i].lock);
-	mutex_destroy(&scp->send_lock);
+	list_for_each_entry_safe_reverse(scp, temp, &scp_cluster->mtk_scp_list, elem) {
+		list_del(&scp->elem);
+		rproc_del(scp->rproc);
+		scp_free(scp);
+	}
 }
 
 static const struct mtk_scp_of_data mt8183_of_data = {
-- 
2.18.0

