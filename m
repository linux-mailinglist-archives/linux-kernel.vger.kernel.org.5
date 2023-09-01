Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011FE78F9B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348699AbjIAIKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348626AbjIAIKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:10:15 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E915B10E4;
        Fri,  1 Sep 2023 01:10:04 -0700 (PDT)
X-UUID: eeae6fbc489e11eea33bb35ae8d461a2-20230901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pan37MMUAtXdTtGayZJ6AbpcFfvHsqT8tHnhc1Zmxg4=;
        b=ZTaZ8MqGNZCh4N2NQN5aI48AMRqqLJOBNTvrW/Oy04gJVg1+m/yEPIIj6lE3Swcq7KYf/OLhmQiHKU/n3ehgCYHpC0MgJkscNhTveNonevDoF7kHUWyBgps869MpRiv95xp++2f2AH9iE5oFC94H3QeY84mVE6nu4YLsUC7OFd0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:e1c33d0a-3519-4a6c-beba-d5c5d6319496,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:0ad78a4,CLOUDID:256433ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eeae6fbc489e11eea33bb35ae8d461a2-20230901
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 622437176; Fri, 01 Sep 2023 16:09:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Sep 2023 16:09:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Sep 2023 16:09:52 +0800
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
Subject: [PATCH v17 08/14] remoteproc: mediatek: Probe SCP cluster on multi-core SCP
Date:   Fri, 1 Sep 2023 16:09:29 +0800
Message-ID: <20230901080935.14571-9-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230901080935.14571-1-tinghan.shen@mediatek.com>
References: <20230901080935.14571-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
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
 drivers/remoteproc/mtk_scp.c | 123 +++++++++++++++++++++++++++++++++--
 1 file changed, 118 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index d67dcabdab9e..685e2c2bb6ee 100644
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
 
@@ -975,6 +976,107 @@ static int scp_cluster_init(struct platform_device *pdev,
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
+	/* Here we are setting the platform device for @pdev to the last @scp that was
+	 * created, which is needed because (1) scp_rproc_init() is calling
+	 * platform_set_drvdata() on the child platform devices and (2) we need a handle to
+	 * the cluster list in scp_remove().
+	 */
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
@@ -1007,6 +1109,10 @@ static int scp_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&scp_cluster->mtk_scp_list);
 
+	ret = devm_of_platform_populate(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to populate platform devices\n");
+
 	ret = scp_cluster_init(pdev, scp_cluster);
 	if (ret)
 		return ret;
@@ -1101,12 +1207,19 @@ static const struct mtk_scp_of_data mt8195_of_data_c1 = {
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

