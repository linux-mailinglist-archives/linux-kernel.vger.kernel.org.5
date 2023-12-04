Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7D38029C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 02:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjLDBPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 20:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbjLDBPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 20:15:31 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AEEE8;
        Sun,  3 Dec 2023 17:15:36 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Sk5Gt5fflz1P956;
        Mon,  4 Dec 2023 09:11:50 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 09:15:34 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 1/2] net: hns: fix wrong head when modify the tx feature when sending packets
Date:   Mon, 4 Dec 2023 09:10:50 +0800
Message-ID: <20231204011051.4055031-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231204011051.4055031-1-shaojijie@huawei.com>
References: <20231204011051.4055031-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

When modify the tx feature, the hns driver will modify the
maybe_stop_tx() and fill_desc() functions, if the modify happens
during packet sending, will cause the hardware and software
pointers do not match, and the port can not work anymore.

This patch deletes the maybe_stop_tx() and fill_desc() functions
modification when setting tx feature, and use the skb_is_gro()
to determine use tso functions or non-tso functions when packets
sending.

Fixes: 38f616da1c28 ("net:hns: Add support of ethtool TSO set option for Hip06 in HNS")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 53 +++++++++++--------
 drivers/net/ethernet/hisilicon/hns/hns_enet.h |  3 +-
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 0900abf5c508..8a713eed4465 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -142,7 +142,8 @@ MODULE_DEVICE_TABLE(acpi, hns_enet_acpi_match);
 
 static void fill_desc(struct hnae_ring *ring, void *priv,
 		      int size, dma_addr_t dma, int frag_end,
-		      int buf_num, enum hns_desc_type type, int mtu)
+		      int buf_num, enum hns_desc_type type, int mtu,
+		      bool is_gso)
 {
 	struct hnae_desc *desc = &ring->desc[ring->next_to_use];
 	struct hnae_desc_cb *desc_cb = &ring->desc_cb[ring->next_to_use];
@@ -275,6 +276,15 @@ static int hns_nic_maybe_stop_tso(
 	return 0;
 }
 
+static int hns_nic_maybe_stop_tx_v2(struct sk_buff **out_skb, int *bnum,
+				    struct hnae_ring *ring)
+{
+	if (skb_is_gso(*out_skb))
+		return hns_nic_maybe_stop_tso(out_skb, bnum, ring);
+	else
+		return hns_nic_maybe_stop_tx(out_skb, bnum, ring);
+}
+
 static void fill_tso_desc(struct hnae_ring *ring, void *priv,
 			  int size, dma_addr_t dma, int frag_end,
 			  int buf_num, enum hns_desc_type type, int mtu)
@@ -300,6 +310,19 @@ static void fill_tso_desc(struct hnae_ring *ring, void *priv,
 				mtu);
 }
 
+static void fill_desc_v2(struct hnae_ring *ring, void *priv,
+			 int size, dma_addr_t dma, int frag_end,
+			 int buf_num, enum hns_desc_type type, int mtu,
+			 bool is_gso)
+{
+	if (is_gso)
+		fill_tso_desc(ring, priv, size, dma, frag_end, buf_num, type,
+			      mtu);
+	else
+		fill_v2_desc(ring, priv, size, dma, frag_end, buf_num, type,
+			     mtu);
+}
+
 netdev_tx_t hns_nic_net_xmit_hw(struct net_device *ndev,
 				struct sk_buff *skb,
 				struct hns_nic_ring_data *ring_data)
@@ -313,6 +336,7 @@ netdev_tx_t hns_nic_net_xmit_hw(struct net_device *ndev,
 	int seg_num;
 	dma_addr_t dma;
 	int size, next_to_use;
+	bool is_gso;
 	int i;
 
 	switch (priv->ops.maybe_stop_tx(&skb, &buf_num, ring)) {
@@ -339,8 +363,9 @@ netdev_tx_t hns_nic_net_xmit_hw(struct net_device *ndev,
 		ring->stats.sw_err_cnt++;
 		goto out_err_tx_ok;
 	}
+	is_gso = skb_is_gso(skb);
 	priv->ops.fill_desc(ring, skb, size, dma, seg_num == 1 ? 1 : 0,
-			    buf_num, DESC_TYPE_SKB, ndev->mtu);
+			    buf_num, DESC_TYPE_SKB, ndev->mtu, is_gso);
 
 	/* fill the fragments */
 	for (i = 1; i < seg_num; i++) {
@@ -354,7 +379,7 @@ netdev_tx_t hns_nic_net_xmit_hw(struct net_device *ndev,
 		}
 		priv->ops.fill_desc(ring, skb_frag_page(frag), size, dma,
 				    seg_num - 1 == i ? 1 : 0, buf_num,
-				    DESC_TYPE_PAGE, ndev->mtu);
+				    DESC_TYPE_PAGE, ndev->mtu, is_gso);
 	}
 
 	/*complete translate all packets*/
@@ -1776,15 +1801,6 @@ static int hns_nic_set_features(struct net_device *netdev,
 			netdev_info(netdev, "enet v1 do not support tso!\n");
 		break;
 	default:
-		if (features & (NETIF_F_TSO | NETIF_F_TSO6)) {
-			priv->ops.fill_desc = fill_tso_desc;
-			priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tso;
-			/* The chip only support 7*4096 */
-			netif_set_tso_max_size(netdev, 7 * 4096);
-		} else {
-			priv->ops.fill_desc = fill_v2_desc;
-			priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tx;
-		}
 		break;
 	}
 	netdev->features = features;
@@ -2159,16 +2175,9 @@ static void hns_nic_set_priv_ops(struct net_device *netdev)
 		priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tx;
 	} else {
 		priv->ops.get_rxd_bnum = get_v2rx_desc_bnum;
-		if ((netdev->features & NETIF_F_TSO) ||
-		    (netdev->features & NETIF_F_TSO6)) {
-			priv->ops.fill_desc = fill_tso_desc;
-			priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tso;
-			/* This chip only support 7*4096 */
-			netif_set_tso_max_size(netdev, 7 * 4096);
-		} else {
-			priv->ops.fill_desc = fill_v2_desc;
-			priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tx;
-		}
+		priv->ops.fill_desc = fill_desc_v2;
+		priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tx_v2;
+		netif_set_tso_max_size(netdev, 7 * 4096);
 		/* enable tso when init
 		 * control tso on/off through TSE bit in bd
 		 */
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.h b/drivers/net/ethernet/hisilicon/hns/hns_enet.h
index ffa9d6573f54..3f3ee032f631 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.h
@@ -44,7 +44,8 @@ struct hns_nic_ring_data {
 struct hns_nic_ops {
 	void (*fill_desc)(struct hnae_ring *ring, void *priv,
 			  int size, dma_addr_t dma, int frag_end,
-			  int buf_num, enum hns_desc_type type, int mtu);
+			  int buf_num, enum hns_desc_type type, int mtu,
+			  bool is_gso);
 	int (*maybe_stop_tx)(struct sk_buff **out_skb,
 			     int *bnum, struct hnae_ring *ring);
 	void (*get_rxd_bnum)(u32 bnum_flag, int *out_bnum);
-- 
2.30.0

