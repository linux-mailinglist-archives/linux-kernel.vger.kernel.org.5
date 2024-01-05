Return-Path: <linux-kernel+bounces-17799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C422A8252E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5278E283347
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B797F2D797;
	Fri,  5 Jan 2024 11:29:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7952D787;
	Fri,  5 Jan 2024 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 405BSmtlE2336532, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 405BSmtlE2336532
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jan 2024 19:28:48 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 5 Jan 2024 19:28:48 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 5 Jan 2024
 19:28:47 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net-next v16 03/13] rtase: Implement the rtase_down function
Date: Fri, 5 Jan 2024 19:28:01 +0800
Message-ID: <20240105112811.380952-4-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105112811.380952-1-justinlai0215@realtek.com>
References: <20240105112811.380952-1-justinlai0215@realtek.com>
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

Implement the rtase_down function to disable hardware setting
and interrupt and clear descriptor ring.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 148 ++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 3c9905f81f6e..9c7b27744d37 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -190,6 +190,57 @@ static void rtase_free_desc(struct rtase_private *tp)
 	}
 }
 
+static void rtase_unmap_tx_skb(struct pci_dev *pdev, u32 len,
+			       struct tx_desc *desc)
+{
+	dma_unmap_single(&pdev->dev, le64_to_cpu(desc->addr), len,
+			 DMA_TO_DEVICE);
+	desc->opts1 = cpu_to_le32(RTK_OPTS1_DEBUG_VALUE);
+	desc->opts2 = 0x00;
+	desc->addr = cpu_to_le64(RTK_MAGIC_NUMBER);
+}
+
+static void rtase_tx_clear_range(struct rtase_ring *ring, u32 start, u32 n)
+{
+	const struct rtase_private *tp = ring->ivec->tp;
+	struct tx_desc *desc_base = ring->desc;
+	struct net_device *dev = tp->dev;
+	u32 i;
+
+	for (i = 0; i < n; i++) {
+		u32 entry = (start + i) % NUM_DESC;
+		struct tx_desc *desc = desc_base + entry;
+		u32 len = ring->mis.len[entry];
+		struct sk_buff *skb;
+
+		if (len == 0)
+			continue;
+
+		rtase_unmap_tx_skb(tp->pdev, len, desc);
+		ring->mis.len[entry] = 0;
+		skb = ring->skbuff[entry];
+		if (!skb)
+			continue;
+
+		dev->stats.tx_dropped++;
+		dev_kfree_skb_any(skb);
+		ring->skbuff[entry] = NULL;
+	}
+}
+
+static void rtase_tx_clear(struct rtase_private *tp)
+{
+	struct rtase_ring *ring;
+	u16 i;
+
+	for (i = 0; i < tp->func_tx_queue_num; i++) {
+		ring = &tp->tx_ring[i];
+		rtase_tx_clear_range(ring, ring->dirty_idx, NUM_DESC);
+		ring->cur_idx = 0;
+		ring->dirty_idx = 0;
+	}
+}
+
 static void rtase_mark_to_asic(union rx_desc *desc, u32 rx_buf_sz)
 {
 	u32 eor = le32_to_cpu(desc->desc_cmd.opts1) & RING_END;
@@ -423,6 +474,77 @@ static void rtase_tally_counter_clear(const struct rtase_private *tp)
 	rtase_w32(tp, RTASE_DTCCR0, cmd | COUNTER_RESET);
 }
 
+static void rtase_irq_dis_and_clear(const struct rtase_private *tp)
+{
+	const struct rtase_int_vector *ivec = &tp->int_vector[0];
+	u32 val1;
+	u16 val2;
+	u8 i;
+
+	rtase_w32(tp, ivec->imr_addr, 0);
+	val1 = rtase_r32(tp, ivec->isr_addr);
+	rtase_w32(tp, ivec->isr_addr, val1);
+
+	for (i = 1; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		rtase_w16(tp, ivec->imr_addr, 0);
+		val2 = rtase_r16(tp, ivec->isr_addr);
+		rtase_w16(tp, ivec->isr_addr, val2);
+	}
+}
+
+static void rtase_poll_timeout(const struct rtase_private *tp, u32 cond,
+			       u32 sleep_us, u64 timeout_us, u16 reg)
+{
+	int err;
+	u8 val;
+
+	err = read_poll_timeout(rtase_r8, val, val & cond, sleep_us, timeout_us,
+				false, tp, reg);
+
+	if (err == -ETIMEDOUT)
+		netdev_err(tp->dev, "poll reg 0x00%x timeout\n", reg);
+}
+
+static void rtase_nic_reset(const struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 rx_config;
+	u8 val;
+
+	rx_config = rtase_r16(tp, RTASE_RX_CONFIG_0);
+	rtase_w16(tp, RTASE_RX_CONFIG_0, rx_config & ~ACCEPT_MASK);
+
+	val = rtase_r8(tp, RTASE_MISC);
+	rtase_w8(tp, RTASE_MISC, val | RX_DV_GATE_EN);
+
+	val = rtase_r8(tp, RTASE_CHIP_CMD);
+	rtase_w8(tp, RTASE_CHIP_CMD, val | STOP_REQ);
+	mdelay(2);
+
+	rtase_poll_timeout(tp, STOP_REQ_DONE, 100, 150000, RTASE_CHIP_CMD);
+
+	rtase_poll_timeout(tp, TX_FIFO_EMPTY, 100, 100000, RTASE_FIFOR);
+
+	rtase_poll_timeout(tp, RX_FIFO_EMPTY, 100, 100000, RTASE_FIFOR);
+
+	val = rtase_r8(tp, RTASE_CHIP_CMD);
+	rtase_w8(tp, RTASE_CHIP_CMD, val & ~(TE | RE));
+	val = rtase_r8(tp, RTASE_CHIP_CMD);
+	rtase_w8(tp, RTASE_CHIP_CMD, val & ~STOP_REQ);
+
+	rtase_w16(tp, RTASE_RX_CONFIG_0, rx_config);
+}
+
+static void rtase_hw_reset(const struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+
+	rtase_irq_dis_and_clear(tp);
+
+	rtase_nic_reset(dev);
+}
+
 static void rtase_nic_enable(const struct net_device *dev)
 {
 	const struct rtase_private *tp = netdev_priv(dev);
@@ -524,6 +646,32 @@ static int rtase_open(struct net_device *dev)
 	return ret;
 }
 
+static void rtase_down(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	struct rtase_int_vector *ivec;
+	struct rtase_ring *ring, *tmp;
+	u32 i;
+
+	for (i = 0; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		napi_disable(&ivec->napi);
+		list_for_each_entry_safe(ring, tmp, &ivec->ring_list, ring_entry) {
+			list_del(&ring->ring_entry);
+		}
+	}
+
+	netif_tx_disable(dev);
+
+	netif_carrier_off(dev);
+
+	rtase_hw_reset(dev);
+
+	rtase_tx_clear(tp);
+
+	rtase_rx_clear(tp);
+}
+
 static int rtase_close(struct net_device *dev)
 {
 	struct rtase_private *tp = netdev_priv(dev);
-- 
2.34.1


