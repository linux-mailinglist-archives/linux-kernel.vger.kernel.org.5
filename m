Return-Path: <linux-kernel+bounces-17805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5A28252F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43251C23216
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED0828E3F;
	Fri,  5 Jan 2024 11:33:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4872C691;
	Fri,  5 Jan 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 405BXWlpC2341790, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 405BXWlpC2341790
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jan 2024 19:33:32 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 5 Jan 2024 19:33:32 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 5 Jan 2024
 19:33:32 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net-next v16 07/13] rtase: Implement a function to receive packets
Date: Fri, 5 Jan 2024 19:32:51 +0800
Message-ID: <20240105113257.381090-3-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105113257.381090-1-justinlai0215@realtek.com>
References: <20240105112811.380952-1-justinlai0215@realtek.com>
 <20240105113257.381090-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Implement rx_handler to read the information of the rx descriptor,
thereby checking the packet accordingly and storing the packet
in the socket buffer to complete the reception of the packet.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 9bbda3ad0c49..0a0b456b0f50 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -451,6 +451,150 @@ static void rtase_rx_ring_clear(struct rtase_ring *ring)
 	}
 }
 
+static int rtase_fragmented_frame(u32 status)
+{
+	return (status & (RX_FIRST_FRAG | RX_LAST_FRAG)) !=
+		(RX_FIRST_FRAG | RX_LAST_FRAG);
+}
+
+static void rtase_rx_csum(const struct rtase_private *tp, struct sk_buff *skb,
+			  const union rx_desc *desc)
+{
+	u32 opts2 = le32_to_cpu(desc->desc_status.opts2);
+
+	/* rx csum offload */
+	if (((opts2 & RX_V4F) && !(opts2 & RX_IPF)) || (opts2 & RX_V6F)) {
+		if (((opts2 & RX_TCPT) && !(opts2 & RX_TCPF)) ||
+		    ((opts2 & RX_UDPT) && !(opts2 & RX_UDPF))) {
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		} else {
+			skb->ip_summed = CHECKSUM_NONE;
+		}
+	} else {
+		skb->ip_summed = CHECKSUM_NONE;
+	}
+}
+
+static void rtase_rx_vlan_skb(union rx_desc *desc, struct sk_buff *skb)
+{
+	u32 opts2 = le32_to_cpu(desc->desc_status.opts2);
+
+	if (!(opts2 & RX_VLAN_TAG))
+		return;
+
+	__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), swab16(opts2 & VLAN_TAG_MASK));
+}
+
+static void rtase_rx_skb(const struct rtase_ring *ring, struct sk_buff *skb)
+{
+	struct rtase_int_vector *ivec = ring->ivec;
+
+	napi_gro_receive(&ivec->napi, skb);
+}
+
+static int rx_handler(struct rtase_ring *ring, int budget)
+{
+	const struct rtase_private *tp = ring->ivec->tp;
+	u32 pkt_size, cur_rx, delta, entry, status;
+	union rx_desc *desc_base = ring->desc;
+	struct net_device *dev = tp->dev;
+	struct sk_buff *skb;
+	union rx_desc *desc;
+	int workdone = 0;
+
+	cur_rx = ring->cur_idx;
+	entry = cur_rx % NUM_DESC;
+	desc = &desc_base[entry];
+
+	do {
+		/* make sure discriptor has been updated */
+		rmb();
+		status = le32_to_cpu(desc->desc_status.opts1);
+
+		if (status & DESC_OWN)
+			break;
+
+		if (unlikely(status & RX_RES)) {
+			if (net_ratelimit())
+				netdev_warn(dev, "Rx ERROR. status = %08x\n",
+					    status);
+
+			dev->stats.rx_errors++;
+
+			if (status & (RX_RWT | RX_RUNT))
+				dev->stats.rx_length_errors++;
+
+			if (status & RX_CRC)
+				dev->stats.rx_crc_errors++;
+
+			if (dev->features & NETIF_F_RXALL)
+				goto process_pkt;
+
+			rtase_mark_to_asic(desc, tp->rx_buf_sz);
+			goto skip_process_pkt;
+		}
+
+process_pkt:
+		pkt_size = status & RX_PKT_SIZE_MASK;
+		if (likely(!(dev->features & NETIF_F_RXFCS)))
+			pkt_size -= ETH_FCS_LEN;
+
+		/* the driver does not support incoming fragmented
+		 * frames. they are seen as a symptom of over-mtu
+		 * sized frames
+		 */
+		if (unlikely(rtase_fragmented_frame(status))) {
+			dev->stats.rx_dropped++;
+			dev->stats.rx_length_errors++;
+			rtase_mark_to_asic(desc, tp->rx_buf_sz);
+			continue;
+		}
+
+		skb = ring->skbuff[entry];
+		dma_sync_single_for_cpu(&tp->pdev->dev,
+					ring->mis.data_phy_addr[entry],
+					tp->rx_buf_sz, DMA_FROM_DEVICE);
+
+		ring->skbuff[entry] = NULL;
+
+		if (dev->features & NETIF_F_RXCSUM)
+			rtase_rx_csum(tp, skb, desc);
+
+		skb->dev = dev;
+		skb_put(skb, pkt_size);
+		skb_mark_for_recycle(skb);
+		skb->protocol = eth_type_trans(skb, dev);
+
+		if (skb->pkt_type == PACKET_MULTICAST)
+			dev->stats.multicast++;
+
+		rtase_rx_vlan_skb(desc, skb);
+		rtase_rx_skb(ring, skb);
+
+		dev_sw_netstats_rx_add(dev, pkt_size);
+
+skip_process_pkt:
+		workdone++;
+		cur_rx++;
+		entry = cur_rx % NUM_DESC;
+		desc = ring->desc + sizeof(union rx_desc) * entry;
+		prefetch(desc);
+	} while (workdone != budget);
+
+	ring->cur_idx = cur_rx;
+	delta = rtase_rx_ring_fill(ring, ring->dirty_idx, ring->cur_idx, 1);
+
+	if (!delta && workdone)
+		netdev_info(dev, "no Rx buffer allocated\n");
+
+	ring->dirty_idx += delta;
+
+	if ((ring->dirty_idx + NUM_DESC) == ring->cur_idx)
+		netdev_emerg(dev, "Rx buffers exhausted\n");
+
+	return workdone;
+}
+
 static void rtase_rx_desc_init(struct rtase_private *tp, u16 idx)
 {
 	struct rtase_ring *ring = &tp->rx_ring[idx];
-- 
2.34.1


