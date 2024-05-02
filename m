Return-Path: <linux-kernel+bounces-166204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 815738B9787
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14A81F21524
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D5F56443;
	Thu,  2 May 2024 09:20:55 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A914537E7;
	Thu,  2 May 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641654; cv=none; b=Baegh7u+hoHRv3Q93kLWXrqXTo0Q4FxcNI+hyr410J82YdSyf0A9y82suoxY+90rxwV+IAEl9BqbXbNDNRnOuBXu8ymEnYIpGUjJG5Hw0Z2a2DTPK9KNOOxgV/U1A774eaEnEL+JIotgYcNICw7hQR1NZspKq6mD4M/+fPPpGB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641654; c=relaxed/simple;
	bh=AECjpRAA008AFUKfyXsjdMpoYmZKu9JuJ8gjrS7cVRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbPJTGPBjSU747E9x7hof0FjykbzLGkap+Vtl51N/dqqBrIsA/A5jCkc9jEI6RXgCYPMDARmB2NsIZjWgPfgSZh59FuwH94fH9iC4v9xWRPqEpwMOAwKri75HyOBfvec0MT6ezSIFIxWq3sNhw1Zrx0xjQQF3rUmfzNbjfv23e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4429KYYq82331209, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4429KYYq82331209
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 May 2024 17:20:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 17:20:34 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 2 May
 2024 17:20:34 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v17 05/13] rtase: Implement hardware configuration function
Date: Thu, 2 May 2024 17:18:39 +0800
Message-ID: <20240502091847.65181-6-justinlai0215@realtek.com>
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
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

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
 .../net/ethernet/realtek/rtase/rtase_main.c   | 235 ++++++++++++++++++
 1 file changed, 235 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index ab00811e1415..67c050cd2e3a 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -468,6 +468,23 @@ static int rtase_init_ring(const struct net_device *dev)
 	return -ENOMEM;
 }
 
+static void rtase_interrupt_mitigation(const struct rtase_private *tp)
+{
+	u32 i;
+
+	for (i = 0; i < tp->func_tx_queue_num; i++)
+		rtase_w16(tp, RTASE_INT_MITI_TX + i * 2, tp->tx_int_mit);
+
+	for (i = 0; i < tp->func_rx_queue_num; i++)
+		rtase_w16(tp, RTASE_INT_MITI_RX + i * 2, tp->rx_int_mit);
+}
+
+static void rtase_tally_counter_addr_fill(const struct rtase_private *tp)
+{
+	rtase_w32(tp, RTASE_DTCCR4, upper_32_bits(tp->tally_paddr));
+	rtase_w32(tp, RTASE_DTCCR0, lower_32_bits(tp->tally_paddr));
+}
+
 static void rtase_tally_counter_clear(const struct rtase_private *tp)
 {
 	u32 cmd = lower_32_bits(tp->tally_paddr);
@@ -476,6 +493,117 @@ static void rtase_tally_counter_clear(const struct rtase_private *tp)
 	rtase_w32(tp, RTASE_DTCCR0, cmd | RTASE_COUNTER_RESET);
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
+			  lower_32_bits(ring->phy_addr));
+		rtase_w32(tp, RTASE_TX_DESC_ADDR4,
+			  upper_32_bits(ring->phy_addr));
+
+		cmd = i | RTASE_TX_DESC_CMD_WE | RTASE_TX_DESC_CMD_CS;
+		rtase_w16(tp, RTASE_TX_DESC_COMMAND, cmd);
+
+		err = read_poll_timeout(rtase_r16, val,
+					!(val & RTASE_TX_DESC_CMD_CS), 10,
+					1000, false, tp, RTASE_TX_DESC_COMMAND);
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
+				  lower_32_bits(ring->phy_addr));
+			rtase_w32(tp, RTASE_Q0_RX_DESC_ADDR4,
+				  upper_32_bits(ring->phy_addr));
+		} else {
+			rtase_w32(tp, (RTASE_Q1_RX_DESC_ADDR0 + ((i - 1) * 8)),
+				  lower_32_bits(ring->phy_addr));
+			rtase_w32(tp, (RTASE_Q1_RX_DESC_ADDR4 + ((i - 1) * 8)),
+				  upper_32_bits(ring->phy_addr));
+		}
+	}
+}
+
+static void rtase_hw_set_features(const struct net_device *dev,
+				  netdev_features_t features)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 rx_config, val;
+
+	rx_config = rtase_r16(tp, RTASE_RX_CONFIG_0);
+	if (features & NETIF_F_RXALL)
+		rx_config |= (RTASE_ACCEPT_ERR | RTASE_ACCEPT_RUNT);
+	else
+		rx_config &= ~(RTASE_ACCEPT_ERR | RTASE_ACCEPT_RUNT);
+
+	rtase_w16(tp, RTASE_RX_CONFIG_0, rx_config);
+
+	val = rtase_r16(tp, RTASE_CPLUS_CMD);
+	if (features & NETIF_F_RXCSUM)
+		rtase_w16(tp, RTASE_CPLUS_CMD, val | RTASE_RX_CHKSUM);
+	else
+		rtase_w16(tp, RTASE_CPLUS_CMD, val & ~RTASE_RX_CHKSUM);
+
+	rx_config = rtase_r16(tp, RTASE_RX_CONFIG_1);
+	if (dev->features & NETIF_F_HW_VLAN_CTAG_RX)
+		rx_config |= (RTASE_INNER_VLAN_DETAG_EN |
+			      RTASE_OUTER_VLAN_DETAG_EN);
+	else
+		rx_config &= ~(RTASE_INNER_VLAN_DETAG_EN |
+			       RTASE_OUTER_VLAN_DETAG_EN);
+
+	rtase_w16(tp, RTASE_RX_CONFIG_1, rx_config);
+}
+
+static void rtase_hw_set_rx_packet_filter(struct net_device *dev)
+{
+	u32 mc_filter[2] = { 0xFFFFFFFF, 0xFFFFFFFF };
+	struct rtase_private *tp = netdev_priv(dev);
+	u16 rx_mode;
+
+	rx_mode = rtase_r16(tp, RTASE_RX_CONFIG_0) & ~RTASE_ACCEPT_MASK;
+	rx_mode |= RTASE_ACCEPT_BROADCAST | RTASE_ACCEPT_MYPHYS;
+
+	if (dev->flags & IFF_PROMISC) {
+		rx_mode |= RTASE_ACCEPT_MULTICAST | RTASE_ACCEPT_ALLPHYS;
+	} else if (dev->flags & IFF_ALLMULTI) {
+		rx_mode |= RTASE_ACCEPT_MULTICAST;
+	} else {
+		struct netdev_hw_addr *hw_addr;
+
+		mc_filter[0] = 0;
+		mc_filter[1] = 0;
+
+		netdev_for_each_mc_addr(hw_addr, dev) {
+			u32 bit_nr = eth_hw_addr_crc(hw_addr);
+			u32 idx = u32_get_bits(bit_nr, BIT(31));
+			u32 bit = u32_get_bits(bit_nr,
+					       RTASE_MULTICAST_FILTER_MASK);
+
+			mc_filter[idx] |= BIT(bit);
+			rx_mode |= RTASE_ACCEPT_MULTICAST;
+		}
+	}
+
+	if (dev->features & NETIF_F_RXALL)
+		rx_mode |= RTASE_ACCEPT_ERR | RTASE_ACCEPT_RUNT;
+
+	rtase_w32(tp, RTASE_MAR0, swab32(mc_filter[1]));
+	rtase_w32(tp, RTASE_MAR1, swab32(mc_filter[0]));
+	rtase_w16(tp, RTASE_RX_CONFIG_0, rx_mode);
+}
+
 static void rtase_irq_dis_and_clear(const struct rtase_private *tp)
 {
 	const struct rtase_int_vector *ivec = &tp->int_vector[0];
@@ -547,6 +675,113 @@ static void rtase_hw_reset(const struct net_device *dev)
 	rtase_nic_reset(dev);
 }
 
+static void rtase_set_rx_queue(const struct rtase_private *tp)
+{
+	u16 reg_data;
+
+	reg_data = rtase_r16(tp, RTASE_FCR);
+	switch (tp->func_rx_queue_num) {
+	case 1:
+		u16p_replace_bits(&reg_data, 0x1, RTASE_FCR_RXQ_MASK);
+		break;
+	case 2:
+		u16p_replace_bits(&reg_data, 0x2, RTASE_FCR_RXQ_MASK);
+		break;
+	case 4:
+		u16p_replace_bits(&reg_data, 0x3, RTASE_FCR_RXQ_MASK);
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
+		u16p_replace_bits(&reg_data, 0x0, RTASE_TC_MODE_MASK);
+		break;
+	case 2:
+		u16p_replace_bits(&reg_data, 0x1, RTASE_TC_MODE_MASK);
+		break;
+	case 3:
+	case 4:
+		u16p_replace_bits(&reg_data, 0x2, RTASE_TC_MODE_MASK);
+		break;
+	default:
+		u16p_replace_bits(&reg_data, 0x3, RTASE_TC_MODE_MASK);
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
+	/* set rx dma burst */
+	reg_data16 = rtase_r16(tp, RTASE_RX_CONFIG_0);
+	reg_data16 &= ~(RTASE_RX_SINGLE_TAG | RTASE_RX_SINGLE_FETCH);
+	u16p_replace_bits(&reg_data16, RTASE_RX_DMA_BURST_256,
+			  RTASE_RX_MX_DMA_MASK);
+	rtase_w16(tp, RTASE_RX_CONFIG_0, reg_data16);
+
+	/* new rx descritpor */
+	reg_data16 = rtase_r16(tp, RTASE_RX_CONFIG_1);
+	reg_data16 |= RTASE_RX_NEW_DESC_FORMAT_EN | RTASE_PCIE_NEW_FLOW;
+	u16p_replace_bits(&reg_data16, 0xF, RTASE_RX_MAX_FETCH_DESC_MASK);
+	rtase_w16(tp, RTASE_RX_CONFIG_1, reg_data16);
+
+	rtase_set_rx_queue(tp);
+
+	rtase_interrupt_mitigation(tp);
+
+	/* set tx dma burst size and interframe gap time */
+	reg_data32 = rtase_r32(tp, RTASE_TX_CONFIG_0);
+	u32p_replace_bits(&reg_data32, RTASE_TX_DMA_BURST_UNLIMITED,
+			  RTASE_TX_DMA_MASK);
+	u32p_replace_bits(&reg_data32, RTASE_INTERFRAMEGAP,
+			  RTASE_TX_INTER_FRAME_GAP_MASK);
+	rtase_w32(tp, RTASE_TX_CONFIG_0, reg_data32);
+
+	/* new tx descriptor */
+	reg_data16 = rtase_r16(tp, RTASE_TFUN_CTRL);
+	rtase_w16(tp, RTASE_TFUN_CTRL, reg_data16 | RTASE_TX_NEW_DESC_FORMAT_EN);
+
+	/* tx fetch desc number */
+	rtase_w8(tp, RTASE_TDFNR, 0x10);
+
+	/* tag num select */
+	reg_data16 = rtase_r16(tp, RTASE_MTPS);
+	u16p_replace_bits(&reg_data16, 0x4, RTASE_TAG_NUM_SEL_MASK);
+	rtase_w16(tp, RTASE_MTPS, reg_data16);
+
+	rtase_set_tx_queue(tp);
+
+	rtase_w16(tp, RTASE_TOKSEL, 0x5555);
+
+	rtase_tally_counter_addr_fill(tp);
+	rtase_desc_addr_fill(tp);
+	rtase_hw_set_features(dev, dev->features);
+
+	/* enable flow control */
+	reg_data16 = rtase_r16(tp, RTASE_CPLUS_CMD);
+	reg_data16 |= (RTASE_FORCE_TXFLOW_EN | RTASE_FORCE_RXFLOW_EN);
+	rtase_w16(tp, RTASE_CPLUS_CMD, reg_data16);
+	/* set near fifo threshold - rx missed issue. */
+	rtase_w16(tp, RTASE_RFIFONFULL, 0x190);
+
+	rtase_w16(tp, RTASE_RMS, tp->rx_buf_sz);
+
+	rtase_hw_set_rx_packet_filter(dev);
+}
+
 static void rtase_nic_enable(const struct net_device *dev)
 {
 	const struct rtase_private *tp = netdev_priv(dev);
-- 
2.34.1


