Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3257661FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjG1Ckk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjG1CkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:40:15 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C5130FF;
        Thu, 27 Jul 2023 19:40:11 -0700 (PDT)
X-UUID: 0db9fe822cf011ee9cb5633481061a41-20230728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+GXt8jmWHmrhF+YOsFQA1GoRdRli810ZAUyhLYF+wvg=;
        b=WETkpkE627GlhT2C7xvnzQX00vIdmYR9NMAlzBmEjBRmaWfTPB20LO5QrV4+MbWIePPYRTOFlDAZHboMcIvzfjz/hp9moyIn4tjGBJb/ocXx8IL1dF2Hgt5kpYU8M4aA2mJ3diU6TiUMompvwi2S0CZb25OLIVztoGk9zSymKFk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:2e7ef571-f305-4cc6-b6ec-6914cb8d960d,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:1fcc6f8,CLOUDID:c2759ea0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0db9fe822cf011ee9cb5633481061a41-20230728
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 395300271; Fri, 28 Jul 2023 10:40:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
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
Subject: [PATCH v16 08/14] remoteproc: mediatek: Probe SCP cluster on multi-core SCP
Date:   Fri, 28 Jul 2023 10:39:53 +0800
Message-ID: <20230728023959.12293-9-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230728023959.12293-1-tinghan.shen@mediatek.com>
References: <20230728023959.12293-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The difference of single-core SCP and multi-core SCP device tree is
the presence of child device nodes described SCP cores. The SCP
driver populates the platform device and checks the child nodes
to identify whether it's a single-core SCP or a multi-core SCP.

Add the remoteproc instances of multi-core SCP to the SCP cluster list.
When the SCP driver is removed, it cleanup resources by walking
through the cluster list.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/remoteproc/mtk_scp.c | 118 +++++++++++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index d67dcabdab9e..d9242c3eb0d7 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -855,7 +855,8 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
 }
 
 static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
-				      struct mtk_scp_of_cluster *scp_cluster)
+				      struct mtk_scp_of_cluster *scp_cluster,
+				      const struct mtk_scp_of_data *of_data)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -878,7 +879,7 @@ static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
 	scp = rproc->priv;
 	scp->rproc = rproc;
 	scp->dev = dev;
-	scp->data = of_device_get_match_data(dev);
+	scp->data = of_data;
 	scp->cluster = scp_cluster;
 	platform_set_drvdata(pdev, scp);
 
@@ -951,15 +952,15 @@ static void scp_free(struct mtk_scp *scp)
 	mutex_destroy(&scp->send_lock);
 }
 
-static int scp_cluster_init(struct platform_device *pdev,
-			    struct mtk_scp_of_cluster *scp_cluster)
+static int scp_add_single_core(struct platform_device *pdev,
+			       struct mtk_scp_of_cluster *scp_cluster)
 {
 	struct device *dev = &pdev->dev;
 	struct list_head *scp_list = &scp_cluster->mtk_scp_list;
 	struct mtk_scp *scp;
 	int ret;
 
-	scp = scp_rproc_init(pdev, scp_cluster);
+	scp = scp_rproc_init(pdev, scp_cluster, of_device_get_match_data(dev));
 	if (IS_ERR(scp))
 		return PTR_ERR(scp);
 
@@ -975,6 +976,102 @@ static int scp_cluster_init(struct platform_device *pdev,
 	return 0;
 }
 
+static int scp_add_multi_core(struct platform_device *pdev,
+			      struct mtk_scp_of_cluster *scp_cluster)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev_of_node(dev);
+	struct platform_device *cpdev;
+	struct device_node *child;
+	struct list_head *scp_list = &scp_cluster->mtk_scp_list;
+	const struct mtk_scp_of_data **cluster_of_data;
+	struct mtk_scp *scp, *temp;
+	int core_id = 0;
+	int ret;
+
+	cluster_of_data = (const struct mtk_scp_of_data **)of_device_get_match_data(dev);
+
+	for_each_available_child_of_node(np, child) {
+		if (!cluster_of_data[core_id]) {
+			ret = -EINVAL;
+			dev_err(dev, "Not support core %d\n", core_id);
+			of_node_put(child);
+			goto init_fail;
+		}
+
+		cpdev = of_find_device_by_node(child);
+		if (!cpdev) {
+			ret = -ENODEV;
+			dev_err(dev, "Not found platform device for core %d\n", core_id);
+			of_node_put(child);
+			goto init_fail;
+		}
+
+		scp = scp_rproc_init(cpdev, scp_cluster, cluster_of_data[core_id]);
+		put_device(&cpdev->dev);
+		if (IS_ERR(scp)) {
+			ret = PTR_ERR(scp);
+			dev_err(dev, "Failed to initialize core %d rproc\n", core_id);
+			of_node_put(child);
+			goto init_fail;
+		}
+
+		ret = rproc_add(scp->rproc);
+		if (ret) {
+			dev_err(dev, "Failed to add rproc of core %d\n", core_id);
+			of_node_put(child);
+			scp_free(scp);
+			goto init_fail;
+		}
+
+		list_add_tail(&scp->elem, scp_list);
+		core_id++;
+	}
+
+	platform_set_drvdata(pdev, scp);
+
+	return 0;
+
+init_fail:
+	list_for_each_entry_safe_reverse(scp, temp, scp_list, elem) {
+		list_del(&scp->elem);
+		rproc_del(scp->rproc);
+		scp_free(scp);
+	}
+
+	return ret;
+}
+
+static int scp_is_single_core(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev_of_node(dev);
+	struct device_node *child;
+
+	child = of_get_next_available_child(np, NULL);
+	if (!child)
+		return dev_err_probe(dev, -ENODEV, "No child node\n");
+
+	of_node_put(child);
+	return of_node_name_eq(child, "cros-ec-rpmsg");
+}
+
+static int scp_cluster_init(struct platform_device *pdev, struct mtk_scp_of_cluster *scp_cluster)
+{
+	int ret;
+
+	ret = scp_is_single_core(pdev);
+	if (ret < 0)
+		return ret;
+
+	if (ret)
+		ret = scp_add_single_core(pdev, scp_cluster);
+	else
+		ret = scp_add_multi_core(pdev, scp_cluster);
+
+	return ret;
+}
+
 static int scp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1007,6 +1104,10 @@ static int scp_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&scp_cluster->mtk_scp_list);
 
+	ret = devm_of_platform_populate(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to populate platform devices\n");
+
 	ret = scp_cluster_init(pdev, scp_cluster);
 	if (ret)
 		return ret;
@@ -1101,12 +1202,19 @@ static const struct mtk_scp_of_data mt8195_of_data_c1 = {
 	.host_to_scp_int_bit = MT8195_CORE1_HOST_IPC_INT_BIT,
 };
 
+static const struct mtk_scp_of_data *mt8195_of_data_cores[] = {
+	&mt8195_of_data,
+	&mt8195_of_data_c1,
+	NULL
+};
+
 static const struct of_device_id mtk_scp_of_match[] = {
 	{ .compatible = "mediatek,mt8183-scp", .data = &mt8183_of_data },
 	{ .compatible = "mediatek,mt8186-scp", .data = &mt8186_of_data },
 	{ .compatible = "mediatek,mt8188-scp", .data = &mt8188_of_data },
 	{ .compatible = "mediatek,mt8192-scp", .data = &mt8192_of_data },
 	{ .compatible = "mediatek,mt8195-scp", .data = &mt8195_of_data },
+	{ .compatible = "mediatek,mt8195-scp-dual", .data = &mt8195_of_data_cores },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_scp_of_match);
-- 
2.18.0

