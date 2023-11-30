Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255C67FEE29
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbjK3LoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjK3LoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:44:00 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C7E10C9;
        Thu, 30 Nov 2023 03:44:04 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AUBhggZ73495119, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AUBhggZ73495119
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Nov 2023 19:43:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 30 Nov 2023 19:43:42 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 30 Nov
 2023 19:43:42 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     <kuba@kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next v13 06/13] rtase: Implement .ndo_start_xmit function
Date:   Thu, 30 Nov 2023 19:43:20 +0800
Message-ID: <20231130114327.1530225-7-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130114327.1530225-1-justinlai0215@realtek.com>
References: <20231130114327.1530225-1-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.210.160]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement .ndo_start_xmit function to fill the information of the packet
to be transmitted into the tx descriptor, and then the hardware will
transmit the packet using the information in the tx descriptor.
In addition, we also implemented the tx_handler function to enable the
tx descriptor to be reused.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 286 ++++++++++++++++++
 1 file changed, 286 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 4279c1e82cde..00eb2e7dc7ba 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -252,6 +252,68 @@ static void rtase_mark_to_asic(union rx_desc *desc, u32 rx_buf_sz)
 		   cpu_to_le32(DESC_OWN | eor | rx_buf_sz));
 }
 
+static bool rtase_tx_avail(struct rtase_ring *ring)
+{
+	u32 avail_num = READ_ONCE(ring->dirty_idx) + NUM_DESC -
+			READ_ONCE(ring->cur_idx);
+
+	return avail_num > MAX_SKB_FRAGS;
+}
+
+static int tx_handler(struct rtase_ring *ring, int budget)
+{
+	const struct rtase_private *tp = ring->ivec->tp;
+	struct net_device *dev = tp->dev;
+	int workdone = 0;
+	u32 dirty_tx;
+	u32 tx_left;
+
+	dirty_tx = ring->dirty_idx;
+	tx_left = READ_ONCE(ring->cur_idx) - dirty_tx;
+
+	while (tx_left > 0) {
+		u32 entry = dirty_tx % NUM_DESC;
+		struct tx_desc *desc = ring->desc +
+				       sizeof(struct tx_desc) * entry;
+		u32 len = ring->mis.len[entry];
+		u32 status;
+
+		status = le32_to_cpu(desc->opts1);
+
+		if (status & DESC_OWN)
+			break;
+
+		rtase_unmap_tx_skb(tp->pdev, len, desc);
+		ring->mis.len[entry] = 0;
+		if (ring->skbuff[entry]) {
+			dev_consume_skb_any(ring->skbuff[entry]);
+			ring->skbuff[entry] = NULL;
+		}
+
+		dev->stats.tx_bytes += len;
+		dev->stats.tx_packets++;
+		dirty_tx++;
+		tx_left--;
+		workdone++;
+
+		if (workdone == budget)
+			break;
+	}
+
+	if (ring->dirty_idx != dirty_tx) {
+		WRITE_ONCE(ring->dirty_idx, dirty_tx);
+
+		if (__netif_subqueue_stopped(dev, ring->index) &&
+		    rtase_tx_avail(ring))
+			netif_start_subqueue(dev, ring->index);
+
+		if (ring->cur_idx != dirty_tx)
+			rtase_w8(tp, RTASE_TPPOLL, BIT(ring->index));
+	}
+
+	return workdone;
+}
+
 static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx)
 {
 	struct rtase_ring *ring = &tp->tx_ring[idx];
@@ -987,6 +1049,229 @@ static int rtase_close(struct net_device *dev)
 	return 0;
 }
 
+static u32 rtase_tx_vlan_tag(const struct rtase_private *tp,
+			     const struct sk_buff *skb)
+{
+	return (skb_vlan_tag_present(skb)) ?
+		(TX_VLAN_TAG | swab16(skb_vlan_tag_get(skb))) : 0x00;
+}
+
+static u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device *dev)
+{
+	u32 csum_cmd = 0;
+	u8 ip_protocol;
+
+	switch (vlan_get_protocol(skb)) {
+	case htons(ETH_P_IP):
+		csum_cmd = TX_IPCS_C;
+		ip_protocol = ip_hdr(skb)->protocol;
+		break;
+
+	case htons(ETH_P_IPV6):
+		csum_cmd = TX_IPV6F_C;
+		ip_protocol = ipv6_hdr(skb)->nexthdr;
+		break;
+
+	default:
+		ip_protocol = IPPROTO_RAW;
+		break;
+	}
+
+	if (ip_protocol == IPPROTO_TCP)
+		csum_cmd |= TX_TCPCS_C;
+	else if (ip_protocol == IPPROTO_UDP)
+		csum_cmd |= TX_UDPCS_C;
+	else
+		WARN_ON_ONCE(1);
+
+	csum_cmd |= u32_encode_bits(skb_transport_offset(skb), TCPHO_MASK);
+
+	return csum_cmd;
+}
+
+static int rtase_xmit_frags(struct rtase_ring *ring, struct sk_buff *skb,
+			    u32 opts1, u32 opts2)
+{
+	const struct skb_shared_info *info = skb_shinfo(skb);
+	const struct rtase_private *tp = ring->ivec->tp;
+	const u8 nr_frags = info->nr_frags;
+	struct tx_desc *txd = NULL;
+	u32 cur_frag, entry;
+
+	entry = ring->cur_idx;
+	for (cur_frag = 0; cur_frag < nr_frags; cur_frag++) {
+		const skb_frag_t *frag = &info->frags[cur_frag];
+		dma_addr_t mapping;
+		u32 status, len;
+		void *addr;
+
+		entry = (entry + 1) % NUM_DESC;
+
+		txd = ring->desc + sizeof(struct tx_desc) * entry;
+		len = skb_frag_size(frag);
+		addr = skb_frag_address(frag);
+		mapping = dma_map_single(&tp->pdev->dev, addr, len,
+					 DMA_TO_DEVICE);
+
+		if (unlikely(dma_mapping_error(&tp->pdev->dev, mapping))) {
+			if (unlikely(net_ratelimit()))
+				netdev_err(tp->dev,
+					   "Failed to map TX fragments DMA!\n");
+
+			goto err_out;
+		}
+
+		if (((entry + 1) % NUM_DESC) == 0)
+			status = (opts1 | len | RING_END);
+		else
+			status = opts1 | len;
+
+		if (cur_frag == (nr_frags - 1)) {
+			ring->skbuff[entry] = skb;
+			status |= TX_LAST_FRAG;
+		}
+
+		ring->mis.len[entry] = len;
+		txd->addr = cpu_to_le64(mapping);
+		txd->opts2 = cpu_to_le32(opts2);
+
+		/* make sure the operating fields have been updated */
+		wmb();
+		txd->opts1 = cpu_to_le32(status);
+	}
+
+	return cur_frag;
+
+err_out:
+	rtase_tx_clear_range(ring, ring->cur_idx + 1, cur_frag);
+	return -EIO;
+}
+
+static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
+				    struct net_device *dev)
+{
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	struct rtase_private *tp = netdev_priv(dev);
+	u32 q_idx, entry, len, opts1, opts2;
+	u32 mss = shinfo->gso_size;
+	struct rtase_ring *ring;
+	struct tx_desc *txd;
+	dma_addr_t mapping;
+	bool stop_queue;
+	int frags;
+
+	/* multiqueues */
+	q_idx = skb_get_queue_mapping(skb);
+	ring = &tp->tx_ring[q_idx];
+
+	if (unlikely(!rtase_tx_avail(ring))) {
+		if (net_ratelimit())
+			netdev_err(dev, "BUG! Tx Ring full when queue awake!\n");
+		goto err_stop;
+	}
+
+	entry = ring->cur_idx % NUM_DESC;
+	txd = ring->desc + sizeof(struct tx_desc) * entry;
+
+	opts1 = DESC_OWN;
+	opts2 = rtase_tx_vlan_tag(tp, skb);
+
+	/* tcp segmentation offload (or tcp large send) */
+	if (mss) {
+		if (shinfo->gso_type & SKB_GSO_TCPV4) {
+			opts1 |= GIANT_SEND_V4;
+		} else if (shinfo->gso_type & SKB_GSO_TCPV6) {
+			if (skb_cow_head(skb, 0))
+				goto err_dma_0;
+
+			tcp_v6_gso_csum_prep(skb);
+			opts1 |= GIANT_SEND_V6;
+		} else {
+			WARN_ON_ONCE(1);
+		}
+
+		opts1 |= u32_encode_bits(skb_transport_offset(skb), TCPHO_MASK);
+		opts2 |= u32_encode_bits(mss, MSS_MASK);
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		opts2 |= rtase_tx_csum(skb, dev);
+	}
+
+	frags = rtase_xmit_frags(ring, skb, opts1, opts2);
+	if (unlikely(frags < 0))
+		goto err_dma_0;
+
+	if (frags) {
+		len = skb_headlen(skb);
+		opts1 |= TX_FIRST_FRAG;
+	} else {
+		len = skb->len;
+		ring->skbuff[entry] = skb;
+		opts1 |= TX_FIRST_FRAG | TX_LAST_FRAG;
+	}
+
+	if (((entry + 1) % NUM_DESC) == 0)
+		opts1 |= (len | RING_END);
+	else
+		opts1 |= len;
+
+	mapping = dma_map_single(&tp->pdev->dev, skb->data, len,
+				 DMA_TO_DEVICE);
+
+	if (unlikely(dma_mapping_error(&tp->pdev->dev, mapping))) {
+		if (unlikely(net_ratelimit()))
+			netdev_err(dev, "Failed to map TX DMA!\n");
+
+		goto err_dma_1;
+	}
+
+	ring->mis.len[entry] = len;
+	txd->addr = cpu_to_le64(mapping);
+	txd->opts2 = cpu_to_le32(opts2);
+	txd->opts1 = cpu_to_le32(opts1 & ~DESC_OWN);
+
+	/* make sure the operating fields have been updated */
+	wmb();
+
+	txd->opts1 = cpu_to_le32(opts1);
+
+	skb_tx_timestamp(skb);
+
+	/* tx needs to see descriptor changes before updated cur_idx */
+	smp_wmb();
+
+	WRITE_ONCE(ring->cur_idx, ring->cur_idx + frags + 1);
+
+	stop_queue = !rtase_tx_avail(ring);
+	if (unlikely(stop_queue))
+		netif_stop_subqueue(dev, q_idx);
+
+	/* set polling bit */
+	rtase_w8(tp, RTASE_TPPOLL, BIT(ring->index));
+
+	if (unlikely(stop_queue)) {
+		/* make sure cur_idx and dirty_idx have been updated */
+		smp_rmb();
+		if (rtase_tx_avail(ring))
+			netif_start_subqueue(dev, q_idx);
+	}
+
+	return NETDEV_TX_OK;
+
+err_dma_1:
+	ring->skbuff[entry] = NULL;
+	rtase_tx_clear_range(ring, ring->cur_idx + 1, frags);
+
+err_dma_0:
+	dev->stats.tx_dropped++;
+	dev_kfree_skb_any(skb);
+	return NETDEV_TX_OK;
+
+err_stop:
+	netif_stop_queue(dev);
+	dev->stats.tx_dropped++;
+	return NETDEV_TX_BUSY;
+}
+
 static void rtase_enable_eem_write(const struct rtase_private *tp)
 {
 	u8 val;
@@ -1038,6 +1323,7 @@ static void rtase_netpoll(struct net_device *dev)
 static const struct net_device_ops rtase_netdev_ops = {
 	.ndo_open = rtase_open,
 	.ndo_stop = rtase_close,
+	.ndo_start_xmit = rtase_start_xmit,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller = rtase_netpoll,
 #endif
-- 
2.34.1

