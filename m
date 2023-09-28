Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4009E7B1894
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjI1KuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjI1KuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:50:03 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B2F195;
        Thu, 28 Sep 2023 03:49:58 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38SAnZn153692468, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38SAnZn153692468
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 18:49:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 28 Sep 2023 18:49:34 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 28 Sep
 2023 18:49:33 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     <kuba@kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next v9 05/13] net:ethernet:realtek:rtase: Implement hardware configuration function
Date:   Thu, 28 Sep 2023 18:49:12 +0800
Message-ID: <20230928104920.113511-6-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928104920.113511-1-justinlai0215@realtek.com>
References: <20230928104920.113511-1-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.210.160]
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement rtase_hw_config to set default hardware settings, including
setting interrupt mitigation, tx/rx DMA burst, interframe gap time,
rx packet filter, near fifo threshold and fill descriptor ring and
tally counter address, and enable flow control. When filling the
rx descriptor ring, the first group of queues needs to be processed
separately because the positions of the first group of queues are not
regular with other subsequent groups. The other queues are all newly
added features, but we want to retain the original design. So they were
not put together.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 245 ++++++++++++++++++
 1 file changed, 245 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 8cca6fae2f38..d2a5463b52f9 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -456,6 +456,25 @@ static int rtase_init_ring(const struct net_device *dev)
 	return -ENOMEM;
 }
 
+static void rtase_interrupt_mitigation(const struct rtase_private *tp)
+{
+	u32 i;
+
+	/* tx interrupt mitigation */
+	for (i = 0; i < tp->func_tx_queue_num; i++)
+		rtase_w16(tp, RTASE_INT_MITI_TX + i * 2, tp->tx_int_mit);
+
+	/* rx interrupt mitigation */
+	for (i = 0; i < tp->func_rx_queue_num; i++)
+		rtase_w16(tp, RTASE_INT_MITI_RX + i * 2, tp->rx_int_mit);
+}
+
+static void rtase_tally_counter_addr_fill(const struct rtase_private *tp)
+{
+	rtase_w32(tp, RTASE_DTCCR4, upper_32_bits(le64_to_cpu(tp->tally_paddr)));
+	rtase_w32(tp, RTASE_DTCCR0, lower_32_bits(le64_to_cpu(tp->tally_paddr)));
+}
+
 static void rtase_tally_counter_clear(const struct rtase_private *tp)
 {
 	u32 cmd = lower_32_bits(le64_to_cpu(tp->tally_paddr));
@@ -464,6 +483,125 @@ static void rtase_tally_counter_clear(const struct rtase_private *tp)
 	rtase_w32(tp, RTASE_DTCCR0, cmd | COUNTER_RESET);
 }
 
+static void rtase_desc_addr_fill(const struct rtase_private *tp)
+{
+	const struct rtase_ring *ring;
+	u16 i, cmd, val;
+	int err;
+
+	for (i = 0; i < tp->func_tx_queue_num; i++) {
+		ring = &tp->tx_ring[i];
+
+		rtase_w32(tp, RTASE_TX_DESC_ADDR0,
+			  lower_32_bits(le64_to_cpu(ring->phy_addr)));
+		rtase_w32(tp, RTASE_TX_DESC_ADDR4,
+			  upper_32_bits(le64_to_cpu(ring->phy_addr)));
+
+		cmd = i | TX_DESC_CMD_WE | TX_DESC_CMD_CS;
+		rtase_w16(tp, RTASE_TX_DESC_COMMAND, cmd);
+
+		err = read_poll_timeout(rtase_r16, val, !(val & TX_DESC_CMD_CS),
+					10, 1000, false, tp, RTASE_TX_DESC_COMMAND);
+
+		if (err == -ETIMEDOUT)
+			netdev_err(tp->dev, "error occurred in fill tx descriptor\n");
+	}
+
+	for (i = 0; i < tp->func_rx_queue_num; i++) {
+		ring = &tp->rx_ring[i];
+
+		if (i == 0) {
+			rtase_w32(tp, RTASE_Q0_RX_DESC_ADDR0,
+				  lower_32_bits(le64_to_cpu(ring->phy_addr)));
+			rtase_w32(tp, RTASE_Q0_RX_DESC_ADDR4,
+				  upper_32_bits(le64_to_cpu(ring->phy_addr)));
+		} else {
+			rtase_w32(tp, (RTASE_Q1_RX_DESC_ADDR0 + ((i - 1) * 8)),
+				  lower_32_bits(le64_to_cpu(ring->phy_addr)));
+			rtase_w32(tp, (RTASE_Q1_RX_DESC_ADDR4 + ((i - 1) * 8)),
+				  upper_32_bits(le64_to_cpu(ring->phy_addr)));
+		}
+	}
+}
+
+static int rtase_hw_set_features(const struct net_device *dev,
+				 netdev_features_t features)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 rx_config, val;
+
+	rx_config = rtase_r16(tp, RTASE_RX_CONFIG_0);
+	if (features & NETIF_F_RXALL)
+		rx_config |= (ACCEPT_ERR | ACCEPT_RUNT);
+	else
+		rx_config &= ~(ACCEPT_ERR | ACCEPT_RUNT);
+
+	rtase_w16(tp, RTASE_RX_CONFIG_0, rx_config);
+
+	val = rtase_r16(tp, RTASE_CPLUS_CMD);
+	if (features & NETIF_F_RXCSUM)
+		rtase_w16(tp, RTASE_CPLUS_CMD, val | RX_CHKSUM);
+	else
+		rtase_w16(tp, RTASE_CPLUS_CMD, val & ~RX_CHKSUM);
+
+	rx_config = rtase_r16(tp, RTASE_RX_CONFIG_1);
+	if (dev->features & NETIF_F_HW_VLAN_CTAG_RX)
+		rx_config |= (INNER_VLAN_DETAG_EN | OUTER_VLAN_DETAG_EN);
+	else
+		rx_config &= ~(INNER_VLAN_DETAG_EN | OUTER_VLAN_DETAG_EN);
+
+	rtase_w16(tp, RTASE_RX_CONFIG_1, rx_config);
+
+	return 0;
+}
+
+static void rtase_set_mar(const struct rtase_private *tp)
+{
+	rtase_w32(tp, RTASE_MAR0, tp->mc_filter[0]);
+	rtase_w32(tp, RTASE_MAR1, tp->mc_filter[1]);
+}
+
+static void rtase_hw_set_rx_packet_filter(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	u32 mc_filter[2] = { 0xFFFFFFFF, 0xFFFFFFFF };
+	u16 rx_mode;
+
+	rx_mode = rtase_r16(tp, RTASE_RX_CONFIG_0) & ~ACCEPT_MASK;
+	rx_mode |= ACCEPT_BROADCAST | ACCEPT_MYPHYS;
+
+	if (dev->flags & IFF_PROMISC) {
+		rx_mode |= ACCEPT_MULTICAST | ACCEPT_ALLPHYS;
+	} else if ((netdev_mc_count(dev) > MULTICAST_FILTER_LIMIT) ||
+		   (dev->flags & IFF_ALLMULTI)) {
+		/* too many to filter perfectly -- accept all multicasts */
+		rx_mode |= ACCEPT_MULTICAST;
+	} else {
+		struct netdev_hw_addr *hw_addr;
+
+		mc_filter[0] = 0;
+		mc_filter[1] = 0;
+
+		netdev_for_each_mc_addr(hw_addr, dev) {
+			u32 bit_nr = eth_hw_addr_crc(hw_addr);
+			u32 idx = u32_get_bits(bit_nr, BIT(31));
+			u32 bit = u32_get_bits(bit_nr, MULTICAST_FILTER_MASK);
+
+			mc_filter[idx] |= BIT(bit);
+			rx_mode |= ACCEPT_MULTICAST;
+		}
+	}
+
+	if (dev->features & NETIF_F_RXALL)
+		rx_mode |= ACCEPT_ERR | ACCEPT_RUNT;
+
+	tp->mc_filter[0] = swab32(mc_filter[1]);
+	tp->mc_filter[1] = swab32(mc_filter[0]);
+
+	rtase_set_mar(tp);
+	rtase_w16(tp, RTASE_RX_CONFIG_0, rx_mode);
+}
+
 static void rtase_irq_dis_and_clear(const struct rtase_private *tp)
 {
 	const struct rtase_int_vector *ivec = &tp->int_vector[0];
@@ -535,6 +673,113 @@ static void rtase_hw_reset(const struct net_device *dev)
 	rtase_nic_reset(dev);
 }
 
+static void rtase_set_rx_queue(const struct rtase_private *tp)
+{
+	u16 reg_data;
+
+	reg_data = rtase_r16(tp, RTASE_FCR);
+	switch (tp->func_rx_queue_num) {
+	case 1:
+		u16p_replace_bits(&reg_data, 0x1, FCR_RXQ_MASK);
+		break;
+	case 2:
+		u16p_replace_bits(&reg_data, 0x2, FCR_RXQ_MASK);
+		break;
+	case 4:
+		u16p_replace_bits(&reg_data, 0x3, FCR_RXQ_MASK);
+		break;
+	}
+	rtase_w16(tp, RTASE_FCR, reg_data);
+}
+
+static void rtase_set_tx_queue(const struct rtase_private *tp)
+{
+	u16 reg_data;
+
+	reg_data = rtase_r16(tp, RTASE_TX_CONFIG_1);
+	switch (tp->tx_queue_ctrl) {
+	case 1:
+		u16p_replace_bits(&reg_data, 0x0, TC_MODE_MASK);
+		break;
+	case 2:
+		u16p_replace_bits(&reg_data, 0x1, TC_MODE_MASK);
+		break;
+	case 3:
+	case 4:
+		u16p_replace_bits(&reg_data, 0x2, TC_MODE_MASK);
+		break;
+	default:
+		u16p_replace_bits(&reg_data, 0x3, TC_MODE_MASK);
+		break;
+	}
+	rtase_w16(tp, RTASE_TX_CONFIG_1, reg_data);
+}
+
+static void rtase_hw_config(struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u32 reg_data32;
+	u16 reg_data16;
+
+	rtase_hw_reset(dev);
+
+	/* Set Rx DMA burst */
+	reg_data16 = rtase_r16(tp, RTASE_RX_CONFIG_0);
+	reg_data16 &= ~(RX_SINGLE_TAG | RX_SINGLE_FETCH);
+	u16p_replace_bits(&reg_data16, RX_DMA_BURST_256, RX_MX_DMA_MASK);
+	rtase_w16(tp, RTASE_RX_CONFIG_0, reg_data16);
+
+	/* New Rx Descritpor */
+	reg_data16 = rtase_r16(tp, RTASE_RX_CONFIG_1);
+	reg_data16 |= RX_NEW_DESC_FORMAT_EN | PCIE_NEW_FLOW;
+	u16p_replace_bits(&reg_data16, 0xF, RX_MAX_FETCH_DESC_MASK);
+	rtase_w16(tp, RTASE_RX_CONFIG_1, reg_data16);
+
+	rtase_set_rx_queue(tp);
+
+	/* interrupt mitigation */
+	rtase_interrupt_mitigation(tp);
+
+	/* set tx DMA burst size and interframe gap time */
+	reg_data32 = rtase_r32(tp, RTASE_TX_CONFIG_0);
+	u32p_replace_bits(&reg_data32, TX_DMA_BURST_UNLIMITED, TX_DMA_MASK);
+	u32p_replace_bits(&reg_data32, INTERFRAMEGAP, TX_INTER_FRAME_GAP_MASK);
+	rtase_w32(tp, RTASE_TX_CONFIG_0, reg_data32);
+
+	/* new tx Descriptor */
+	reg_data16 = rtase_r16(tp, RTASE_TFUN_CTRL);
+	rtase_w16(tp, RTASE_TFUN_CTRL, reg_data16 | TX_NEW_DESC_FORMAT_EN);
+
+	/* tx Fetch Desc Number */
+	rtase_w8(tp, RTASE_TDFNR, 0x10);
+
+	/* tag num select */
+	reg_data16 = rtase_r16(tp, RTASE_MTPS);
+	u16p_replace_bits(&reg_data16, 0x4, TAG_NUM_SEL_MASK);
+	rtase_w16(tp, RTASE_MTPS, reg_data16);
+
+	rtase_set_tx_queue(tp);
+
+	/* TOK condition */
+	rtase_w16(tp, RTASE_TOKSEL, 0x5555);
+
+	rtase_tally_counter_addr_fill(tp);
+	rtase_desc_addr_fill(tp);
+	rtase_hw_set_features(dev, dev->features);
+
+	/* enable flow control */
+	reg_data16 = rtase_r16(tp, RTASE_CPLUS_CMD);
+	reg_data16 |= (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN);
+	rtase_w16(tp, RTASE_CPLUS_CMD, reg_data16);
+	/* set Near FIFO Threshold - rx missed issue. */
+	rtase_w16(tp, RTASE_RFIFONFULL, 0x190);
+
+	rtase_w16(tp, RTASE_RMS, tp->rx_buf_sz);
+
+	/* set Rx packet filter */
+	rtase_hw_set_rx_packet_filter(dev);
+}
+
 static void rtase_nic_enable(const struct net_device *dev)
 {
 	const struct rtase_private *tp = netdev_priv(dev);
-- 
2.34.1

