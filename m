Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8342580E9F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjLLLMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbjLLLLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:11:55 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E861136;
        Tue, 12 Dec 2023 03:10:44 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BCBAO3k031728;
        Tue, 12 Dec 2023 05:10:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702379424;
        bh=PvkANg04A2utzuZAggw+6HPpsozwSzDkEwa7BpI7mhM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ym91uVEHlmGoLgfFRoymYYV8JwoBCkTjoSt/EI8c1RgQbl45K32fRnzC4Wt0RbzDY
         KKI0drNj4qBwG608Ifbcbsyu4NAiO7htNe7dbc4hncl7ZtRXu9GC36TivlHOAPNVG2
         LAN2iXgLKFvn82rgj0y024NW87VUluaSf8xc9f54=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BCBAOHW043985
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Dec 2023 05:10:24 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Dec 2023 05:10:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Dec 2023 05:10:24 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BCBABA1088764;
        Tue, 12 Dec 2023 05:10:22 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 4/4] dmaengine: ti: k3-udma-glue: Add function to request RX channel by ID
Date:   Tue, 12 Dec 2023 16:40:11 +0530
Message-ID: <20231212111011.1401641-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212111011.1401641-1-s-vadapalli@ti.com>
References: <20231212111011.1401641-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing function k3_udma_glue_request_remote_rx_chn() supports
requesting an RX DMA channel and flow by the name of the RX DMA channel.
Add support to request RX channel by ID in the form of a new function
k3_udma_glue_request_remote_rx_chn_by_id() and export it for use by drivers
which are probed by alternate methods (non device-tree) but still wish to
make use of the existing DMA APIs. Such drivers could be informed about the
RX channel to use by RPMsg for example.

Since the implementation of k3_udma_glue_request_remote_rx_chn_by_id()
reuses most of the code in k3_udma_glue_request_remote_rx_chn(), create
a new function k3_udma_glue_request_remote_rx_chn_common() for the
common code.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
Changes since v1:
- Updated commit message indicating the use-case for which the patch is
  being added.

 drivers/dma/ti/k3-udma-glue.c    | 136 ++++++++++++++++++++++---------
 include/linux/dma/k3-udma-glue.h |   4 +
 2 files changed, 101 insertions(+), 39 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index ea5119a5e8eb..996614b60675 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -1072,52 +1072,21 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
 	return ERR_PTR(ret);
 }
 
-static struct k3_udma_glue_rx_channel *
-k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
-				   struct k3_udma_glue_rx_channel_cfg *cfg)
+static int
+k3_udma_glue_request_remote_rx_chn_common(struct k3_udma_glue_rx_channel *rx_chn,
+					  struct k3_udma_glue_rx_channel_cfg *cfg,
+					  struct device *dev)
 {
-	struct k3_udma_glue_rx_channel *rx_chn;
 	int ret, i;
 
-	if (cfg->flow_id_num <= 0 ||
-	    cfg->flow_id_use_rxchan_id ||
-	    cfg->def_flow_cfg ||
-	    cfg->flow_id_base < 0)
-		return ERR_PTR(-EINVAL);
-
-	/*
-	 * Remote RX channel is under control of Remote CPU core, so
-	 * Linux can only request and manipulate by dedicated RX flows
-	 */
-
-	rx_chn = devm_kzalloc(dev, sizeof(*rx_chn), GFP_KERNEL);
-	if (!rx_chn)
-		return ERR_PTR(-ENOMEM);
-
-	rx_chn->common.dev = dev;
-	rx_chn->common.swdata_size = cfg->swdata_size;
-	rx_chn->remote = true;
-	rx_chn->udma_rchan_id = -1;
-	rx_chn->flow_num = cfg->flow_id_num;
-	rx_chn->flow_id_base = cfg->flow_id_base;
-	rx_chn->psil_paired = false;
-
-	/* parse of udmap channel */
-	ret = of_k3_udma_glue_parse_chn(dev->of_node, name,
-					&rx_chn->common, false);
-	if (ret)
-		goto err;
-
 	rx_chn->common.hdesc_size = cppi5_hdesc_calc_size(rx_chn->common.epib,
 						rx_chn->common.psdata_size,
 						rx_chn->common.swdata_size);
 
 	rx_chn->flows = devm_kcalloc(dev, rx_chn->flow_num,
 				     sizeof(*rx_chn->flows), GFP_KERNEL);
-	if (!rx_chn->flows) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!rx_chn->flows)
+		return -ENOMEM;
 
 	rx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
 	rx_chn->common.chan_dev.parent = xudma_get_device(rx_chn->common.udmax);
@@ -1128,7 +1097,7 @@ k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
 		dev_err(dev, "Channel Device registration failed %d\n", ret);
 		put_device(&rx_chn->common.chan_dev);
 		rx_chn->common.chan_dev.parent = NULL;
-		goto err;
+		return ret;
 	}
 
 	if (xudma_is_pktdma(rx_chn->common.udmax)) {
@@ -1140,19 +1109,108 @@ k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
 
 	ret = k3_udma_glue_allocate_rx_flows(rx_chn, cfg);
 	if (ret)
-		goto err;
+		return ret;
 
 	for (i = 0; i < rx_chn->flow_num; i++)
 		rx_chn->flows[i].udma_rflow_id = rx_chn->flow_id_base + i;
 
 	k3_udma_glue_dump_rx_chn(rx_chn);
 
+	return 0;
+}
+
+static struct k3_udma_glue_rx_channel *
+k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
+				   struct k3_udma_glue_rx_channel_cfg *cfg)
+{
+	struct k3_udma_glue_rx_channel *rx_chn;
+	int ret;
+
+	if (cfg->flow_id_num <= 0 ||
+	    cfg->flow_id_use_rxchan_id ||
+	    cfg->def_flow_cfg ||
+	    cfg->flow_id_base < 0)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Remote RX channel is under control of Remote CPU core, so
+	 * Linux can only request and manipulate by dedicated RX flows
+	 */
+
+	rx_chn = devm_kzalloc(dev, sizeof(*rx_chn), GFP_KERNEL);
+	if (!rx_chn)
+		return ERR_PTR(-ENOMEM);
+
+	rx_chn->common.dev = dev;
+	rx_chn->common.swdata_size = cfg->swdata_size;
+	rx_chn->remote = true;
+	rx_chn->udma_rchan_id = -1;
+	rx_chn->flow_num = cfg->flow_id_num;
+	rx_chn->flow_id_base = cfg->flow_id_base;
+	rx_chn->psil_paired = false;
+
+	/* parse of udmap channel */
+	ret = of_k3_udma_glue_parse_chn(dev->of_node, name,
+					&rx_chn->common, false);
+	if (ret)
+		goto err;
+
+	ret = k3_udma_glue_request_remote_rx_chn_common(rx_chn, cfg, dev);
+	if (ret)
+		goto err;
+
+	return rx_chn;
+
+err:
+	k3_udma_glue_release_rx_chn(rx_chn);
+	return ERR_PTR(ret);
+}
+
+struct k3_udma_glue_rx_channel *
+k3_udma_glue_request_remote_rx_chn_by_id(struct device *dev, struct device_node *udmax_np,
+					 struct k3_udma_glue_rx_channel_cfg *cfg, u32 thread_id)
+{
+	struct k3_udma_glue_rx_channel *rx_chn;
+	int ret;
+
+	if (cfg->flow_id_num <= 0 ||
+	    cfg->flow_id_use_rxchan_id ||
+	    cfg->def_flow_cfg ||
+	    cfg->flow_id_base < 0)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Remote RX channel is under control of Remote CPU core, so
+	 * Linux can only request and manipulate by dedicated RX flows
+	 */
+
+	rx_chn = devm_kzalloc(dev, sizeof(*rx_chn), GFP_KERNEL);
+	if (!rx_chn)
+		return ERR_PTR(-ENOMEM);
+
+	rx_chn->common.dev = dev;
+	rx_chn->common.swdata_size = cfg->swdata_size;
+	rx_chn->remote = true;
+	rx_chn->udma_rchan_id = -1;
+	rx_chn->flow_num = cfg->flow_id_num;
+	rx_chn->flow_id_base = cfg->flow_id_base;
+	rx_chn->psil_paired = false;
+
+	ret = of_k3_udma_glue_parse_chn_by_id(udmax_np, &rx_chn->common, false, thread_id);
+	if (ret)
+		goto err;
+
+	ret = k3_udma_glue_request_remote_rx_chn_common(rx_chn, cfg, dev);
+	if (ret)
+		goto err;
+
 	return rx_chn;
 
 err:
 	k3_udma_glue_release_rx_chn(rx_chn);
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(k3_udma_glue_request_remote_rx_chn_by_id);
 
 struct k3_udma_glue_rx_channel *
 k3_udma_glue_request_rx_chn(struct device *dev, const char *name,
diff --git a/include/linux/dma/k3-udma-glue.h b/include/linux/dma/k3-udma-glue.h
index 6205d84430ca..89dc59d7c5e2 100644
--- a/include/linux/dma/k3-udma-glue.h
+++ b/include/linux/dma/k3-udma-glue.h
@@ -113,6 +113,10 @@ struct k3_udma_glue_rx_channel *k3_udma_glue_request_rx_chn(
 		const char *name,
 		struct k3_udma_glue_rx_channel_cfg *cfg);
 
+struct k3_udma_glue_rx_channel *
+k3_udma_glue_request_remote_rx_chn_by_id(struct device *dev, struct device_node *udmax_np,
+					 struct k3_udma_glue_rx_channel_cfg *cfg, u32 thread_id);
+
 void k3_udma_glue_release_rx_chn(struct k3_udma_glue_rx_channel *rx_chn);
 int k3_udma_glue_enable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn);
 void k3_udma_glue_disable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn);
-- 
2.34.1

