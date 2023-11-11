Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BEE7E8AD9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 13:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjKKMQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 07:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjKKMQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 07:16:19 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A623AA7;
        Sat, 11 Nov 2023 04:16:15 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ABCG63E085235;
        Sat, 11 Nov 2023 06:16:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699704966;
        bh=VPVOyYGUIuFjbpFVz4WDtMguuciLFwkUVgaypjccsg0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ieWhQyFxSW/6mi9DeB+HPtmerWC5vXi83Qi/fPlUkwuQKYoYnGesY9bG9bao9mHQf
         tF6xV5xBKEueRE2cszsgwEVI89lEW/3sjbzja0eDY4jDr85aP1Zkhyiuom/YzL5zQG
         R3MzCHtRT9cS4DKxAeTV+FIahP65+JMHDNXYAjD4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ABCG6VN081761
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 11 Nov 2023 06:16:06 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 11
 Nov 2023 06:16:06 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 11 Nov 2023 06:16:06 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ABCFtVY100939;
        Sat, 11 Nov 2023 06:16:04 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [RFC PATCH 3/3] dmaengine: ti: k3-udma-glue: Add function to request RX channel by ID
Date:   Sat, 11 Nov 2023 17:45:55 +0530
Message-ID: <20231111121555.2656760-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111121555.2656760-1-s-vadapalli@ti.com>
References: <20231111121555.2656760-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing function k3_udma_glue_request_remote_rx_chn() supports
requesting an RX DMA channel and flow by the name of the RX DMA channel.
Add support to request RX channel by ID in the form of a new function
k3_udma_glue_request_remote_rx_chn_by_id() and export it.

Since the implementation of k3_udma_glue_request_remote_rx_chn_by_id()
reuses most of the code in k3_udma_glue_request_remote_rx_chn(), create
a new function k3_udma_glue_request_remote_rx_chn_common() for the
common code.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/dma/ti/k3-udma-glue.c    | 140 ++++++++++++++++++++++---------
 include/linux/dma/k3-udma-glue.h |   4 +
 2 files changed, 103 insertions(+), 41 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index d3f04d446c4e..167fe77de71e 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -1076,52 +1076,21 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
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
-						rx_chn->common.psdata_size,
-						rx_chn->common.swdata_size);
+							  rx_chn->common.psdata_size,
+							  rx_chn->common.swdata_size);
 
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
@@ -1132,7 +1101,7 @@ k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
 		dev_err(dev, "Channel Device registration failed %d\n", ret);
 		put_device(&rx_chn->common.chan_dev);
 		rx_chn->common.chan_dev.parent = NULL;
-		goto err;
+		return ret;
 	}
 
 	if (xudma_is_pktdma(rx_chn->common.udmax)) {
@@ -1144,19 +1113,108 @@ k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
 
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
index 6205d84430ca..a81d1b8f889c 100644
--- a/include/linux/dma/k3-udma-glue.h
+++ b/include/linux/dma/k3-udma-glue.h
@@ -108,6 +108,10 @@ struct k3_udma_glue_rx_channel_cfg {
 
 struct k3_udma_glue_rx_channel;
 
+struct k3_udma_glue_rx_channel *
+k3_udma_glue_request_remote_rx_chn_by_id(struct device *dev, struct device_node *udmax_np,
+					 struct k3_udma_glue_rx_channel_cfg *cfg, u32 thread_id);
+
 struct k3_udma_glue_rx_channel *k3_udma_glue_request_rx_chn(
 		struct device *dev,
 		const char *name,
-- 
2.34.1

