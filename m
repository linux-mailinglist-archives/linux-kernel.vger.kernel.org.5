Return-Path: <linux-kernel+bounces-166199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFDE8B9779
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAAB1F24D48
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C1A5646D;
	Thu,  2 May 2024 09:19:59 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233A253E2D;
	Thu,  2 May 2024 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641598; cv=none; b=iU6EY/+QXSk8r1EymkVsGtYjLO3djRTmGGuWvDdjdrpWTHS9mvLh0hjj9N+pBsM3q/M1WZuikzxaphKhttP8W+f8HXRQcPEA9GxAQCESWMNKwR+wMR3AwsXSCkLU+oPEknJzT7gPb3nO5PFPa9gfK/2YYMf3/vGN9RE1W9CaPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641598; c=relaxed/simple;
	bh=UECnQi9gKu3OGhZG2MeIFl5+yiLiLp7UmmXHpVnYGJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2nnT0u1lpsn40JB+zF2SPj/Xktxj5gCMfGDiP0D8qIxRfmCVr1zaXQAEXVBY3e6V3xXLG6U4XFufFK6OgBBL3Dhkppw8VrPjwgRYWB4oalVC/fSaSFWLVItpsrlpzT3mKssULBhiiCwfM6HwST+9euLz6FUI0KXLgH4L4pK0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4429JZlX42331019, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4429JZlX42331019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 May 2024 17:19:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 17:19:36 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 2 May
 2024 17:19:35 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v17 02/13] rtase: Implement the .ndo_open function
Date: Thu, 2 May 2024 17:18:36 +0800
Message-ID: <20240502091847.65181-3-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502091847.65181-1-justinlai0215@realtek.com>
References: <20240502091847.65181-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Implement the .ndo_open function to set default hardware settings
and initialize the descriptor ring and interrupts. Among them,
when requesting irq, because the first group of interrupts needs to
process more events, the overall structure will be different from
other groups of interrupts, so it needs to be processed separately.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 419 ++++++++++++++++++
 1 file changed, 419 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 5ddb5f7abfe9..b286aac1eedc 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -130,6 +130,293 @@ static u32 rtase_r32(const struct rtase_private *tp, u16 reg)
 	return readl(tp->mmio_addr + reg);
 }
 
+static void rtase_set_rxbufsize(struct rtase_private *tp)
+{
+	tp->rx_buf_sz = RTASE_RX_BUF_SIZE;
+}
+
+static int rtase_alloc_desc(struct rtase_private *tp)
+{
+	struct pci_dev *pdev = tp->pdev;
+	u32 i;
+
+	/* rx and tx descriptors needs 256 bytes alignment.
+	 * dma_alloc_coherent provides more.
+	 */
+	for (i = 0; i < tp->func_tx_queue_num; i++) {
+		tp->tx_ring[i].desc = dma_alloc_coherent(&pdev->dev,
+							 RTASE_TX_RING_DESC_SIZE,
+							 &tp->tx_ring[i].phy_addr,
+							 GFP_KERNEL);
+		if (!tp->tx_ring[i].desc)
+			return -ENOMEM;
+	}
+
+	for (i = 0; i < tp->func_rx_queue_num; i++) {
+		tp->rx_ring[i].desc =
+			dma_alloc_coherent(&pdev->dev, RTASE_RX_RING_DESC_SIZE,
+					   &tp->rx_ring[i].phy_addr,
+					   GFP_KERNEL);
+		if (!tp->rx_ring[i].desc)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void rtase_free_desc(struct rtase_private *tp)
+{
+	struct pci_dev *pdev = tp->pdev;
+	u32 i;
+
+	for (i = 0; i < tp->func_tx_queue_num; i++) {
+		if (!tp->tx_ring[i].desc)
+			continue;
+
+		dma_free_coherent(&pdev->dev, RTASE_TX_RING_DESC_SIZE,
+				  tp->tx_ring[i].desc,
+				  tp->tx_ring[i].phy_addr);
+		tp->tx_ring[i].desc = NULL;
+	}
+
+	for (i = 0; i < tp->func_rx_queue_num; i++) {
+		if (!tp->rx_ring[i].desc)
+			continue;
+
+		dma_free_coherent(&pdev->dev, RTASE_RX_RING_DESC_SIZE,
+				  tp->rx_ring[i].desc,
+				  tp->rx_ring[i].phy_addr);
+		tp->rx_ring[i].desc = NULL;
+	}
+}
+
+static void rtase_mark_to_asic(union rtase_rx_desc *desc, u32 rx_buf_sz)
+{
+	u32 eor = le32_to_cpu(desc->desc_cmd.opts1) & RTASE_RING_END;
+
+	desc->desc_status.opts2 = 0;
+	/* force memory writes to complete before releasing descriptor */
+	dma_wmb();
+	WRITE_ONCE(desc->desc_cmd.opts1,
+		   cpu_to_le32(RTASE_DESC_OWN | eor | rx_buf_sz));
+}
+
+static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx)
+{
+	struct rtase_ring *ring = &tp->tx_ring[idx];
+	struct rtase_tx_desc *desc;
+	u32 i;
+
+	memset(ring->desc, 0x0, RTASE_TX_RING_DESC_SIZE);
+	memset(ring->skbuff, 0x0, sizeof(ring->skbuff));
+	ring->cur_idx = 0;
+	ring->dirty_idx = 0;
+	ring->index = idx;
+
+	for (i = 0; i < RTASE_NUM_DESC; i++) {
+		ring->mis.len[i] = 0;
+		if ((RTASE_NUM_DESC - 1) == i) {
+			desc = ring->desc + sizeof(struct rtase_tx_desc) * i;
+			desc->opts1 = cpu_to_le32(RTASE_RING_END);
+		}
+	}
+
+	ring->ring_handler = tx_handler;
+	if (idx < 4) {
+		ring->ivec = &tp->int_vector[idx];
+		list_add_tail(&ring->ring_entry,
+			      &tp->int_vector[idx].ring_list);
+	} else {
+		ring->ivec = &tp->int_vector[0];
+		list_add_tail(&ring->ring_entry, &tp->int_vector[0].ring_list);
+	}
+}
+
+static void rtase_map_to_asic(union rtase_rx_desc *desc, dma_addr_t mapping,
+			      u32 rx_buf_sz)
+{
+	desc->desc_cmd.addr = cpu_to_le64(mapping);
+	/* make sure the physical address has been updated */
+	wmb();
+	rtase_mark_to_asic(desc, rx_buf_sz);
+}
+
+static void rtase_make_unusable_by_asic(union rtase_rx_desc *desc)
+{
+	desc->desc_cmd.addr = cpu_to_le64(RTK_MAGIC_NUMBER);
+	desc->desc_cmd.opts1 &= ~cpu_to_le32(RTASE_DESC_OWN | RSVD_MASK);
+}
+
+static int rtase_alloc_rx_skb(const struct rtase_ring *ring,
+			      struct sk_buff **p_sk_buff, union rtase_rx_desc *desc,
+			      dma_addr_t *rx_phy_addr, u8 in_intr)
+{
+	struct rtase_int_vector *ivec = ring->ivec;
+	const struct rtase_private *tp = ivec->tp;
+	struct sk_buff *skb = NULL;
+	dma_addr_t mapping;
+	struct page *page;
+	void *buf_addr;
+	int ret = 0;
+
+	page = page_pool_dev_alloc_pages(tp->page_pool);
+	if (!page) {
+		netdev_err(tp->dev, "failed to alloc page\n");
+		goto err_out;
+	}
+
+	buf_addr = page_address(page);
+	mapping = page_pool_get_dma_addr(page);
+
+	skb = build_skb(buf_addr, PAGE_SIZE);
+	if (!skb) {
+		page_pool_put_full_page(tp->page_pool, page, true);
+		netdev_err(tp->dev, "failed to build skb\n");
+		goto err_out;
+	}
+
+	*p_sk_buff = skb;
+	*rx_phy_addr = mapping;
+	rtase_map_to_asic(desc, mapping, tp->rx_buf_sz);
+
+	return ret;
+
+err_out:
+	if (skb)
+		dev_kfree_skb(skb);
+
+	ret = -ENOMEM;
+	rtase_make_unusable_by_asic(desc);
+
+	return ret;
+}
+
+static u32 rtase_rx_ring_fill(struct rtase_ring *ring, u32 ring_start,
+			      u32 ring_end, u8 in_intr)
+{
+	union rtase_rx_desc *desc_base = ring->desc;
+	u32 cur;
+
+	for (cur = ring_start; ring_end - cur > 0; cur++) {
+		u32 i = cur % RTASE_NUM_DESC;
+		union rtase_rx_desc *desc = desc_base + i;
+		int ret;
+
+		if (ring->skbuff[i])
+			continue;
+
+		ret = rtase_alloc_rx_skb(ring, &ring->skbuff[i], desc,
+					 &ring->mis.data_phy_addr[i],
+					 in_intr);
+		if (ret)
+			break;
+	}
+
+	return cur - ring_start;
+}
+
+static void rtase_mark_as_last_descriptor(union rtase_rx_desc *desc)
+{
+	desc->desc_cmd.opts1 |= cpu_to_le32(RTASE_RING_END);
+}
+
+static void rtase_rx_ring_clear(struct rtase_ring *ring)
+{
+	union rtase_rx_desc *desc;
+	u32 i;
+
+	for (i = 0; i < RTASE_NUM_DESC; i++) {
+		desc = ring->desc + sizeof(union rtase_rx_desc) * i;
+
+		if (!ring->skbuff[i])
+			continue;
+
+		skb_mark_for_recycle(ring->skbuff[i]);
+
+		dev_kfree_skb(ring->skbuff[i]);
+
+		ring->skbuff[i] = NULL;
+
+		rtase_make_unusable_by_asic(desc);
+	}
+}
+
+static void rtase_rx_desc_init(struct rtase_private *tp, u16 idx)
+{
+	struct rtase_ring *ring = &tp->rx_ring[idx];
+	u16 i;
+
+	memset(ring->desc, 0x0, RTASE_RX_RING_DESC_SIZE);
+	memset(ring->skbuff, 0x0, sizeof(ring->skbuff));
+	ring->cur_idx = 0;
+	ring->dirty_idx = 0;
+	ring->index = idx;
+
+	for (i = 0; i < RTASE_NUM_DESC; i++)
+		ring->mis.data_phy_addr[i] = 0;
+
+	ring->ring_handler = rx_handler;
+	ring->ivec = &tp->int_vector[idx];
+	list_add_tail(&ring->ring_entry, &tp->int_vector[idx].ring_list);
+}
+
+static void rtase_rx_clear(struct rtase_private *tp)
+{
+	u32 i;
+
+	for (i = 0; i < tp->func_rx_queue_num; i++)
+		rtase_rx_ring_clear(&tp->rx_ring[i]);
+
+	page_pool_destroy(tp->page_pool);
+	tp->page_pool = NULL;
+}
+
+static int rtase_init_ring(const struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	struct page_pool_params pp_params = {
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.order = 0,
+		.pool_size = RTASE_NUM_DESC * tp->func_rx_queue_num,
+		.nid = dev_to_node(&tp->pdev->dev),
+		.dev = &tp->pdev->dev,
+		.dma_dir = DMA_FROM_DEVICE,
+		.max_len = PAGE_SIZE,
+		.offset = 0,
+	};
+	struct page_pool *page_pool;
+	u32 num;
+	u16 i;
+
+	page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(page_pool)) {
+		netdev_err(tp->dev, "failed to create page pool\n");
+		return -ENOMEM;
+	}
+
+	tp->page_pool = page_pool;
+
+	for (i = 0; i < tp->func_tx_queue_num; i++)
+		rtase_tx_desc_init(tp, i);
+
+	for (i = 0; i < tp->func_rx_queue_num; i++) {
+		rtase_rx_desc_init(tp, i);
+		num = rtase_rx_ring_fill(&tp->rx_ring[i], 0, RTASE_NUM_DESC, 0);
+		if (num != RTASE_NUM_DESC)
+			goto err_out;
+
+		rtase_mark_as_last_descriptor(tp->rx_ring[i].desc +
+					      sizeof(union rtase_rx_desc) *
+					      (RTASE_NUM_DESC - 1));
+	}
+
+	return 0;
+
+err_out:
+	rtase_rx_clear(tp);
+	return -ENOMEM;
+}
+
 static void rtase_tally_counter_clear(const struct rtase_private *tp)
 {
 	u32 cmd = lower_32_bits(tp->tally_paddr);
@@ -138,6 +425,128 @@ static void rtase_tally_counter_clear(const struct rtase_private *tp)
 	rtase_w32(tp, RTASE_DTCCR0, cmd | RTASE_COUNTER_RESET);
 }
 
+static void rtase_nic_enable(const struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 rcr = rtase_r16(tp, RTASE_RX_CONFIG_1);
+	u8 val;
+
+	rtase_w16(tp, RTASE_RX_CONFIG_1, rcr & ~RTASE_PCIE_RELOAD_EN);
+	rtase_w16(tp, RTASE_RX_CONFIG_1, rcr | RTASE_PCIE_RELOAD_EN);
+
+	val = rtase_r8(tp, RTASE_CHIP_CMD);
+	rtase_w8(tp, RTASE_CHIP_CMD, val | RTASE_TE | RTASE_RE);
+
+	val = rtase_r8(tp, RTASE_MISC);
+	rtase_w8(tp, RTASE_MISC, val & ~RTASE_RX_DV_GATE_EN);
+}
+
+static void rtase_enable_hw_interrupt(const struct rtase_private *tp)
+{
+	const struct rtase_int_vector *ivec = &tp->int_vector[0];
+	u32 i;
+
+	rtase_w32(tp, ivec->imr_addr, ivec->imr);
+
+	for (i = 1; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		rtase_w16(tp, ivec->imr_addr, ivec->imr);
+	}
+}
+
+static void rtase_hw_start(const struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+
+	rtase_nic_enable(dev);
+	rtase_enable_hw_interrupt(tp);
+}
+
+static int rtase_open(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	struct rtase_int_vector *ivec = &tp->int_vector[0];
+	const struct pci_dev *pdev = tp->pdev;
+	u16 i, j;
+	int ret;
+
+	rtase_set_rxbufsize(tp);
+
+	ret = rtase_alloc_desc(tp);
+	if (ret)
+		goto err_free_all_allocated_mem;
+
+	ret = rtase_init_ring(dev);
+	if (ret)
+		goto err_free_all_allocated_mem;
+
+	rtase_hw_config(dev);
+
+	if (tp->sw_flag & RTASE_SWF_MSIX_ENABLED) {
+		ret = request_irq(ivec->irq, rtase_interrupt, 0,
+				  dev->name, ivec);
+		if (ret)
+			goto err_free_all_allocated_irq;
+
+		/* request other interrupts to handle multiqueue */
+		for (i = 1; i < tp->int_nums; i++) {
+			ivec = &tp->int_vector[i];
+			snprintf(ivec->name, sizeof(ivec->name), "%s_int%i", tp->dev->name, i);
+			ret = request_irq(ivec->irq, rtase_q_interrupt, 0,
+					  ivec->name, ivec);
+			if (ret)
+				goto err_free_all_allocated_irq;
+		}
+	} else {
+		ret = request_irq(pdev->irq, rtase_interrupt, 0, dev->name,
+				  ivec);
+		if (ret)
+			goto err_free_all_allocated_mem;
+	}
+
+	rtase_hw_start(dev);
+
+	for (i = 0; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		napi_enable(&ivec->napi);
+	}
+
+	netif_carrier_on(dev);
+	netif_wake_queue(dev);
+
+	return 0;
+
+err_free_all_allocated_irq:
+	for (j = 0; j < i; j++)
+		free_irq(tp->int_vector[j].irq, &tp->int_vector[j]);
+
+err_free_all_allocated_mem:
+	rtase_free_desc(tp);
+
+	return ret;
+}
+
+static int rtase_close(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	const struct pci_dev *pdev = tp->pdev;
+	u32 i;
+
+	rtase_down(dev);
+
+	if (tp->sw_flag & RTASE_SWF_MSIX_ENABLED) {
+		for (i = 0; i < tp->int_nums; i++)
+			free_irq(tp->int_vector[i].irq, &tp->int_vector[i]);
+
+	} else {
+		free_irq(pdev->irq, &tp->int_vector[0]);
+	}
+
+	rtase_free_desc(tp);
+
+	return 0;
+}
+
 static void rtase_enable_eem_write(const struct rtase_private *tp)
 {
 	u8 val;
@@ -170,6 +579,11 @@ static void rtase_rar_set(const struct rtase_private *tp, const u8 *addr)
 	rtase_w16(tp, RTASE_LBK_CTRL, RTASE_LBK_ATLD | RTASE_LBK_CLR);
 }
 
+static const struct net_device_ops rtase_netdev_ops = {
+	.ndo_open = rtase_open,
+	.ndo_stop = rtase_close,
+};
+
 static void rtase_get_mac_address(struct net_device *dev)
 {
 	struct rtase_private *tp = netdev_priv(dev);
@@ -190,6 +604,11 @@ static void rtase_get_mac_address(struct net_device *dev)
 	rtase_rar_set(tp, dev->dev_addr);
 }
 
+static void rtase_init_netdev_ops(struct net_device *dev)
+{
+	dev->netdev_ops = &rtase_netdev_ops;
+}
+
 static void rtase_reset_interrupt(struct pci_dev *pdev,
 				  const struct rtase_private *tp)
 {
-- 
2.34.1


