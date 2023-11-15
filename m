Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A647EC3CF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344003AbjKONf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343979AbjKONfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:35:36 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423849B;
        Wed, 15 Nov 2023 05:35:26 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AFDYplG61694172, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AFDYplG61694172
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 21:34:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 15 Nov 2023 21:34:28 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 15 Nov
 2023 21:34:27 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     <kuba@kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next v11 05/13] net:ethernet:realtek:rtase: Implement hardware configuration function
Date:   Wed, 15 Nov 2023 21:34:06 +0800
Message-ID: <20231115133414.1221480-6-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115133414.1221480-1-justinlai0215@realtek.com>
References: <20231115133414.1221480-1-justinlai0215@realtek.com>
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 .../net/ethernet/realtek/rtase/rtase_main.c   |  243 ++
 drivers/net/ethernet/realtek/rtase/tt.c       | 2542 +++++++++++++++++
 drivers/net/ethernet/realtek/rtase/tt.h       |  353 +++
 3 files changed, 3138 insertions(+)
 create mode 100644 drivers/net/ethernet/realtek/rtase/tt.c
 create mode 100644 drivers/net/ethernet/realtek/rtase/tt.h

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 46d128a68844..4e04189050cc 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -466,6 +466,25 @@ static int rtase_init_ring(const struct net_device *dev)
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
+	rtase_w32(tp, RTASE_DTCCR4, upper_32_bits(tp->tally_paddr));
+	rtase_w32(tp, RTASE_DTCCR0, lower_32_bits(tp->tally_paddr));
+}
+
 static void rtase_tally_counter_clear(const struct rtase_private *tp)
 {
 	u32 cmd = lower_32_bits(tp->tally_paddr);
@@ -474,6 +493,123 @@ static void rtase_tally_counter_clear(const struct rtase_private *tp)
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
+			  lower_32_bits(ring->phy_addr));
+		rtase_w32(tp, RTASE_TX_DESC_ADDR4,
+			  upper_32_bits(ring->phy_addr));
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
@@ -545,6 +681,113 @@ static void rtase_hw_reset(const struct net_device *dev)
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
diff --git a/drivers/net/ethernet/realtek/rtase/tt.c b/drivers/net/ethernet/realtek/rtase/tt.c
new file mode 100644
index 000000000000..5ea4d51fcc47
--- /dev/null
+++ b/drivers/net/ethernet/realtek/rtase/tt.c
@@ -0,0 +1,2542 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ *  rtase is the Linux device driver released for Realtek Automotive Switch
+ *  controllers with PCI-Express interface.
+ *
+ *  Copyright(c) 2023 Realtek Semiconductor Corp.
+ *
+ *  Below is a simplified block diagram of the chip and its relevant interfaces.
+ *
+ *               *************************
+ *               *                       *
+ *               *  CPU network device   *
+ *               *                       *
+ *               *   +-------------+     *
+ *               *   |  PCIE Host  |     *
+ *               ***********++************
+ *                          ||
+ *                         PCIE
+ *                          ||
+ *      ********************++**********************
+ *      *            | PCIE Endpoint |             *
+ *      *            +---------------+             *
+ *      *                | GMAC |                  *
+ *      *                +--++--+  Realtek         *
+ *      *                   ||     RTL90xx Series  *
+ *      *                   ||                     *
+ *      *     +-------------++----------------+    *
+ *      *     |           | MAC |             |    *
+ *      *     |           +-----+             |    *
+ *      *     |                               |    *
+ *      *     |     Ethernet Switch Core      |    *
+ *      *     |                               |    *
+ *      *     |   +-----+           +-----+   |    *
+ *      *     |   | MAC |...........| MAC |   |    *
+ *      *     +---+-----+-----------+-----+---+    *
+ *      *         | PHY |...........| PHY |        *
+ *      *         +--++-+           +--++-+        *
+ *      *************||****************||***********
+ *
+ *  The block of the Realtek RTL90xx series is our entire chip architecture,
+ *  the GMAC is connected to the switch core, and there is no PHY in between.
+ *  In addition, this driver is mainly used to control GMAC, but does not
+ *  control the switch core, so it is not the same as DSA.
+ */
+
+#include <linux/crc32.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
+#include <linux/in.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/mdio.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+#include <linux/prefetch.h>
+#include <linux/rtnetlink.h>
+#include <linux/tcp.h>
+#include <asm/irq.h>
+#include <net/ip6_checksum.h>
+#include <net/page_pool/helpers.h>
+#include <net/pkt_cls.h>
+
+#include "rtase.h"
+
+#define RTK_OPTS1_DEBUG_VALUE 0x0BADBEEF
+#define RTK_MAGIC_NUMBER      0x0BADBADBADBADBAD
+
+static const struct pci_device_id rtase_pci_tbl[] = {
+	{PCI_VDEVICE(REALTEK, 0x906A)},
+	{}
+};
+
+MODULE_DEVICE_TABLE(pci, rtase_pci_tbl);
+
+MODULE_AUTHOR("Realtek ARD Software Team");
+MODULE_DESCRIPTION("Network Driver for the PCIe interface of Realtek Automotive Ethernet Switch");
+MODULE_LICENSE("Dual BSD/GPL");
+
+struct rtase_counters {
+	__le64 tx_packets;
+	__le64 rx_packets;
+	__le64 tx_errors;
+	__le32 rx_errors;
+	__le16 rx_missed;
+	__le16 align_errors;
+	__le32 tx_one_collision;
+	__le32 tx_multi_collision;
+	__le64 rx_unicast;
+	__le64 rx_broadcast;
+	__le32 rx_multicast;
+	__le16 tx_aborted;
+	__le16 tx_underun;
+} __packed;
+
+static void rtase_w8(const struct rtase_private *tp, u16 reg, u8 val8)
+{
+	writeb(val8, tp->mmio_addr + reg);
+}
+
+static void rtase_w16(const struct rtase_private *tp, u16 reg, u16 val16)
+{
+	writew(val16, tp->mmio_addr + reg);
+}
+
+static void rtase_w32(const struct rtase_private *tp, u16 reg, u32 val32)
+{
+	writel(val32, tp->mmio_addr + reg);
+}
+
+static u8 rtase_r8(const struct rtase_private *tp, u16 reg)
+{
+	return readb(tp->mmio_addr + reg);
+}
+
+static u16 rtase_r16(const struct rtase_private *tp, u16 reg)
+{
+	return readw(tp->mmio_addr + reg);
+}
+
+static u32 rtase_r32(const struct rtase_private *tp, u16 reg)
+{
+	return readl(tp->mmio_addr + reg);
+}
+
+static void rtase_set_rxbufsize(struct rtase_private *tp)
+{
+	tp->rx_buf_sz = RX_BUF_SIZE;
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
+	struct net_device *dev = tp->dev;
+	struct tx_desc *desc_base = ring->desc;
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
+static void rtase_mark_to_asic(union rx_desc *desc, u32 rx_buf_sz)
+{
+	u32 eor = le32_to_cpu(desc->desc_cmd.opts1) & RING_END;
+
+	desc->desc_status.opts2 = 0;
+	/* force memory writes to complete before releasing descriptor */
+	dma_wmb();
+	WRITE_ONCE(desc->desc_cmd.opts1,
+		   cpu_to_le32(DESC_OWN | eor | rx_buf_sz));
+}
+
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
+static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx)
+{
+	struct rtase_ring *ring = &tp->tx_ring[idx];
+	struct tx_desc *desc;
+	u32 i;
+
+	memset(ring->desc, 0x0, RTASE_TX_RING_DESC_SIZE);
+	memset(ring->skbuff, 0x0, sizeof(ring->skbuff));
+	ring->cur_idx = 0;
+	ring->dirty_idx = 0;
+	ring->index = idx;
+
+	for (i = 0; i < NUM_DESC; i++) {
+		ring->mis.len[i] = 0;
+		if ((NUM_DESC - 1) == i) {
+			desc = ring->desc + sizeof(struct tx_desc) * i;
+			desc->opts1 = cpu_to_le32(RING_END);
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
+static void rtase_map_to_asic(union rx_desc *desc, dma_addr_t mapping,
+			      u32 rx_buf_sz)
+{
+	desc->desc_cmd.addr = cpu_to_le64(mapping);
+	/* make sure the physical address has been updated */
+	wmb();
+	rtase_mark_to_asic(desc, rx_buf_sz);
+}
+
+static void rtase_make_unusable_by_asic(union rx_desc *desc)
+{
+	desc->desc_cmd.addr = cpu_to_le64(RTK_MAGIC_NUMBER);
+	desc->desc_cmd.opts1 &= ~cpu_to_le32(DESC_OWN | RSVD_MASK);
+}
+
+static int rtase_alloc_rx_skb(const struct rtase_ring *ring,
+			      struct sk_buff **p_sk_buff, union rx_desc *desc,
+			      dma_addr_t *rx_phy_addr, u8 in_intr)
+{
+	struct rtase_int_vector *ivec = ring->ivec;
+	const struct rtase_private *tp = ivec->tp;
+	struct sk_buff *skb = NULL;
+	struct page *page;
+	dma_addr_t mapping;
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
+	union rx_desc *desc_base = ring->desc;
+	u32 cur;
+
+	for (cur = ring_start; ring_end - cur > 0; cur++) {
+		u32 i = cur % NUM_DESC;
+		union rx_desc *desc = desc_base + i;
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
+static void rtase_mark_as_last_descriptor(union rx_desc *desc)
+{
+	desc->desc_cmd.opts1 |= cpu_to_le32(RING_END);
+}
+
+static void rtase_rx_ring_clear(struct rtase_ring *ring)
+{
+	union rx_desc *desc;
+	u32 i;
+
+	for (i = 0; i < NUM_DESC; i++) {
+		desc = ring->desc + sizeof(union rx_desc) * i;
+
+		if (!ring->skbuff[i])
+			continue;
+
+		dev_kfree_skb(ring->skbuff[i]);
+
+		ring->skbuff[i] = NULL;
+
+		rtase_make_unusable_by_asic(desc);
+	}
+}
+
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
+	struct net_device *dev = tp->dev;
+	union rx_desc *desc_base = ring->desc;
+	struct sk_buff *skb;
+	union rx_desc *desc;
+	int workdone = 0;
+
+	if (!ring->desc)
+		return workdone;
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
+		dev->stats.rx_bytes += pkt_size;
+		dev->stats.rx_packets++;
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
+	for (i = 0; i < NUM_DESC; i++)
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
+	struct page_pool *page_pool;
+	struct page_pool_params pp_params = {
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.order = 0,
+		.pool_size = NUM_DESC * tp->func_rx_queue_num,
+		.nid = dev_to_node(&tp->pdev->dev),
+		.dev = &tp->pdev->dev,
+		.dma_dir = DMA_FROM_DEVICE,
+		.max_len = PAGE_SIZE,
+		.offset = 0,
+	};
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
+		num = rtase_rx_ring_fill(&tp->rx_ring[i], 0, NUM_DESC, 0);
+		if (num != NUM_DESC)
+			goto err_out;
+
+		rtase_mark_as_last_descriptor(tp->rx_ring[i].desc +
+					      sizeof(union rx_desc) *
+					      (NUM_DESC - 1));
+	}
+
+	return 0;
+
+err_out:
+	rtase_rx_clear(tp);
+	return -ENOMEM;
+}
+
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
+	rtase_w32(tp, RTASE_DTCCR4, upper_32_bits(tp->tally_paddr));
+	rtase_w32(tp, RTASE_DTCCR0, lower_32_bits(tp->tally_paddr));
+}
+
+static void rtase_tally_counter_clear(const struct rtase_private *tp)
+{
+	u32 cmd = lower_32_bits(tp->tally_paddr);
+
+	rtase_w32(tp, RTASE_DTCCR4, upper_32_bits(tp->tally_paddr));
+	rtase_w32(tp, RTASE_DTCCR0, cmd | COUNTER_RESET);
+}
+
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
+static void rtase_nic_enable(const struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 rcr = rtase_r16(tp, RTASE_RX_CONFIG_1);
+	u8 val;
+
+	/* PCIe PLA reload */
+	rtase_w16(tp, RTASE_RX_CONFIG_1, rcr & ~PCIE_RELOAD_En);
+	rtase_w16(tp, RTASE_RX_CONFIG_1, rcr | PCIE_RELOAD_En);
+
+	/* set PCIe TE & RE */
+	val = rtase_r8(tp, RTASE_CHIP_CMD);
+	rtase_w8(tp, RTASE_CHIP_CMD, val | TE | RE);
+
+	/* clear rxdv_gated_en */
+	val = rtase_r8(tp, RTASE_MISC);
+	rtase_w8(tp, RTASE_MISC, val & ~RX_DV_GATE_EN);
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
+/*  the interrupt handler does RXQ0 and TXQ0, TXQ4~7 interrutp status
+ */
+static irqreturn_t rtase_interrupt(int irq, void *dev_instance)
+{
+	const struct rtase_private *tp;
+	struct rtase_int_vector *ivec;
+	u32 status;
+
+	ivec = dev_instance;
+	tp = ivec->tp;
+	status = rtase_r32(tp, ivec->isr_addr);
+
+	rtase_w32(tp, ivec->imr_addr, 0x0);
+	rtase_w32(tp, ivec->isr_addr, status & ~FOVW);
+
+	if (napi_schedule_prep(&ivec->napi))
+		__napi_schedule(&ivec->napi);
+
+	return IRQ_HANDLED;
+}
+
+/*  the interrupt handler does RXQ1&TXQ1 or RXQ2&TXQ2 or RXQ3&TXQ3 interrupt
+ *  status according to interrupt vector
+ */
+static irqreturn_t rtase_q_interrupt(int irq, void *dev_instance)
+{
+	const struct rtase_private *tp;
+	struct rtase_int_vector *ivec;
+	u16 status;
+
+	ivec = dev_instance;
+	tp = ivec->tp;
+	status = rtase_r16(tp, ivec->isr_addr);
+
+	rtase_w16(tp, ivec->imr_addr, 0x0);
+	rtase_w16(tp, ivec->isr_addr, status);
+
+	if (napi_schedule_prep(&ivec->napi))
+		__napi_schedule(&ivec->napi);
+
+	return IRQ_HANDLED;
+}
+
+static int rtase_poll(struct napi_struct *napi, int budget)
+{
+	const struct rtase_int_vector *ivec;
+	const struct rtase_private *tp;
+	struct rtase_ring *ring;
+	int total_workdone = 0;
+
+	ivec = container_of(napi, struct rtase_int_vector, napi);
+	tp = ivec->tp;
+
+	list_for_each_entry(ring, &ivec->ring_list, ring_entry) {
+		total_workdone += ring->ring_handler(ring, budget);
+	}
+
+	if (total_workdone >= budget)
+		return budget;
+
+	if (napi_complete_done(napi, total_workdone)) {
+		if (!ivec->index)
+			rtase_w32(tp, ivec->imr_addr, ivec->imr);
+		else
+			rtase_w16(tp, ivec->imr_addr, ivec->imr);
+	}
+
+	return total_workdone;
+}
+
+static int rtase_open(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	struct rtase_int_vector *ivec = &tp->int_vector[0];
+	const struct pci_dev *pdev = tp->pdev;
+	int ret;
+	u16 i;
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
+	INIT_DELAYED_WORK(&tp->task, NULL);
+
+	rtase_hw_config(dev);
+
+	if (tp->sw_flag & SWF_MSIX_ENABLED) {
+		ret = request_irq(ivec->irq, rtase_interrupt, 0,
+				  dev->name, ivec);
+
+		/* request other interrupts to handle multiqueue */
+		for (i = 1; i < tp->int_nums; i++) {
+			if (ret)
+				continue;
+
+			ivec = &tp->int_vector[i];
+			if (ivec->status != 1)
+				continue;
+
+			snprintf(ivec->name, sizeof(ivec->name), "%s_int%i", tp->dev->name, i);
+			ret = request_irq(ivec->irq, rtase_q_interrupt, 0,
+					  ivec->name, ivec);
+		}
+	} else if (tp->sw_flag & SWF_MSI_ENABLED) {
+		ret = request_irq(pdev->irq, rtase_interrupt, 0, dev->name,
+				  ivec);
+	} else {
+		ret = request_irq(pdev->irq, rtase_interrupt, IRQF_SHARED,
+				  dev->name, ivec);
+	}
+
+	if (ret != 0) {
+		netdev_err(dev, "can't request MSIX interrupt. Error: %d\n", ret);
+		goto err_free_all_allocated_mem;
+	}
+
+	rtase_hw_start(dev);
+
+	netif_carrier_on(dev);
+	netif_wake_queue(dev);
+
+	goto out;
+
+err_free_all_allocated_mem:
+	rtase_free_desc(tp);
+
+out:
+	return ret;
+}
+
+static void rtase_down(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	u32 i;
+
+	netif_stop_queue(dev);
+
+	/* give a racing hard_start_xmit a few cycles to complete */
+	synchronize_rcu();
+
+	netif_carrier_off(dev);
+
+	rtase_hw_reset(dev);
+
+	for (i = 0; i < tp->int_nums; i++)
+		synchronize_irq(tp->int_vector[i].irq);
+
+	rtase_tx_clear(tp);
+
+	rtase_rx_clear(tp);
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
+	if (tp->sw_flag & SWF_MSIX_ENABLED) {
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
+static u32 rtase_tx_vlan_tag(const struct rtase_private *tp,
+			     const struct sk_buff *skb)
+{
+	return (skb_vlan_tag_present(skb)) ?
+		(TX_VLAN_TAG | swab16(skb_vlan_tag_get(skb))) : 0x00;
+}
+
+static u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device *dev)
+{
+	u8 ip_protocol;
+	u32 csum_cmd;
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
+	u64 pkt_len_cnt = 0;
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
+		pkt_len_cnt += len;
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
+static void rtase_set_rx_mode(struct net_device *dev)
+{
+	rtase_hw_set_rx_packet_filter(dev);
+}
+
+static void rtase_enable_eem_write(const struct rtase_private *tp)
+{
+	u8 val;
+
+	val = rtase_r8(tp, RTASE_EEM);
+	rtase_w8(tp, RTASE_EEM, val | EEM_UNLOCK);
+}
+
+static void rtase_disable_eem_write(const struct rtase_private *tp)
+{
+	u8 val;
+
+	val = rtase_r8(tp, RTASE_EEM);
+	rtase_w8(tp, RTASE_EEM, val & ~EEM_UNLOCK);
+}
+
+static void rtase_rar_set(const struct rtase_private *tp, const u8 *addr)
+{
+	u32 rar_low, rar_high;
+
+	rar_low = (u32)addr[0] | ((u32)addr[1] << 8) |
+		  ((u32)addr[2] << 16) | ((u32)addr[3] << 24);
+
+	rar_high = (u32)addr[4] | ((u32)addr[5] << 8);
+
+	rtase_enable_eem_write(tp);
+	rtase_w32(tp, RTASE_MAC0, rar_low);
+	rtase_w32(tp, RTASE_MAC4, rar_high);
+	rtase_disable_eem_write(tp);
+	rtase_w16(tp, RTASE_LBK_CTRL, LBK_ATLD | LBK_CLR);
+}
+
+static int rtase_set_mac_address(struct net_device *dev, void *p)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	int ret;
+
+	ret = eth_mac_addr(dev, p);
+	if (ret)
+		return ret;
+
+	rtase_rar_set(tp, dev->dev_addr);
+
+	return 0;
+}
+
+static int rtase_change_mtu(struct net_device *dev, int new_mtu)
+{
+	dev->mtu = new_mtu;
+
+	netdev_update_features(dev);
+
+	return 0;
+}
+
+static void rtase_wait_for_quiescence(const struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	struct rtase_int_vector *ivec;
+	u32 i;
+
+	for (i = 0; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		synchronize_irq(ivec->irq);
+		/* wait for any pending NAPI task to complete */
+		napi_disable(&ivec->napi);
+	}
+
+	rtase_irq_dis_and_clear(tp);
+
+	for (i = 0; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		napi_enable(&ivec->napi);
+	}
+}
+
+static void rtase_sw_reset(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	int ret;
+
+	netif_stop_queue(dev);
+	netif_carrier_off(dev);
+	rtase_hw_reset(dev);
+
+	/* let's wait a bit while any (async) irq lands on */
+	rtase_wait_for_quiescence(dev);
+	rtase_tx_clear(tp);
+	rtase_rx_clear(tp);
+
+	ret = rtase_init_ring(dev);
+	if (ret) {
+		netdev_err(dev, "unable to init ring\n");
+		rtase_free_desc(tp);
+		return;
+	}
+
+	rtase_hw_config(dev);
+	/* always link, so start to transmit & receive */
+	rtase_hw_start(dev);
+
+	netif_carrier_on(dev);
+	netif_wake_queue(dev);
+}
+
+static void rtase_dump_tally_counter(const struct rtase_private *tp)
+{
+	dma_addr_t paddr = tp->tally_paddr;
+	u32 cmd = lower_32_bits(paddr);
+	u32 val;
+	int err;
+
+	rtase_w32(tp, RTASE_DTCCR4, upper_32_bits(paddr));
+	rtase_w32(tp, RTASE_DTCCR0, cmd);
+	rtase_w32(tp, RTASE_DTCCR0, cmd | COUNTER_DUMP);
+
+	err = read_poll_timeout(rtase_r32, val, !(val & COUNTER_DUMP), 10, 250,
+				false, tp, RTASE_DTCCR0);
+
+	if (err == -ETIMEDOUT)
+		netdev_err(tp->dev, "error occurred in dump tally counter\n");
+}
+
+static void rtase_dump_state(const struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	const struct rtase_counters *counters;
+	int max_reg_size = RTASE_PCI_REGS_SIZE;
+	const struct rtase_ring *ring;
+	u32 dword_rd;
+	int n = 0;
+
+	ring = &tp->tx_ring[0];
+	netdev_err(dev, "Tx descriptor info:\n");
+	netdev_err(dev, "Tx curIdx = 0x%x\n", ring->cur_idx);
+	netdev_err(dev, "Tx dirtyIdx = 0x%x\n", ring->dirty_idx);
+	netdev_err(dev, "Tx phyAddr = 0x%llx\n", ring->phy_addr);
+
+	ring = &tp->rx_ring[0];
+	netdev_err(dev, "Rx descriptor info:\n");
+	netdev_err(dev, "Rx curIdx = 0x%x\n", ring->cur_idx);
+	netdev_err(dev, "Rx dirtyIdx = 0x%x\n", ring->dirty_idx);
+	netdev_err(dev, "Rx phyAddr = 0x%llx\n", ring->phy_addr);
+
+	netdev_err(dev, "Device Registers:\n");
+	netdev_err(dev, "Chip Command = 0x%02x\n", rtase_r8(tp, RTASE_CHIP_CMD));
+	netdev_err(dev, "IMR = %08x\n", rtase_r32(tp, RTASE_IMR0));
+	netdev_err(dev, "ISR = %08x\n", rtase_r32(tp, RTASE_ISR0));
+	netdev_err(dev, "Boot Ctrl Reg(0xE004) = %04x\n",
+		   rtase_r16(tp, RTASE_BOOT_CTL));
+	netdev_err(dev, "EPHY ISR(0xE014) = %04x\n",
+		   rtase_r16(tp, RTASE_EPHY_ISR));
+	netdev_err(dev, "EPHY IMR(0xE016) = %04x\n",
+		   rtase_r16(tp, RTASE_EPHY_IMR));
+	netdev_err(dev, "CLKSW SET REG(0xE018) = %04x\n",
+		   rtase_r16(tp, RTASE_CLKSW_SET));
+
+	netdev_err(dev, "Dump PCI Registers:\n");
+
+	while (n < max_reg_size) {
+		if ((n % RTASE_DWORD_MOD) == 0)
+			netdev_err(tp->dev, "0x%03x:\n", n);
+
+		pci_read_config_dword(tp->pdev, n, &dword_rd);
+		netdev_err(tp->dev, "%08x\n", dword_rd);
+		n += 4;
+	}
+
+	netdev_err(dev, "Dump tally counter:\n");
+	counters = tp->tally_vaddr;
+	rtase_dump_tally_counter(tp);
+
+	netdev_err(dev, "tx_packets %lld\n",
+		   le64_to_cpu(counters->tx_packets));
+	netdev_err(dev, "rx_packets %lld\n",
+		   le64_to_cpu(counters->rx_packets));
+	netdev_err(dev, "tx_errors %lld\n",
+		   le64_to_cpu(counters->tx_errors));
+	netdev_err(dev, "rx_missed %lld\n",
+		   le64_to_cpu(counters->rx_missed));
+	netdev_err(dev, "align_errors %lld\n",
+		   le64_to_cpu(counters->align_errors));
+	netdev_err(dev, "tx_one_collision %lld\n",
+		   le64_to_cpu(counters->tx_one_collision));
+	netdev_err(dev, "tx_multi_collision %lld\n",
+		   le64_to_cpu(counters->tx_multi_collision));
+	netdev_err(dev, "rx_unicast %lld\n",
+		   le64_to_cpu(counters->rx_unicast));
+	netdev_err(dev, "rx_broadcast %lld\n",
+		   le64_to_cpu(counters->rx_broadcast));
+	netdev_err(dev, "rx_multicast %lld\n",
+		   le64_to_cpu(counters->rx_multicast));
+	netdev_err(dev, "tx_aborted %lld\n",
+		   le64_to_cpu(counters->tx_aborted));
+	netdev_err(dev, "tx_underun %lld\n",
+		   le64_to_cpu(counters->tx_underun));
+}
+
+static void rtase_tx_timeout(struct net_device *dev, unsigned int txqueue)
+{
+	rtase_dump_state(dev);
+	rtase_sw_reset(dev);
+}
+
+static void rtase_get_stats64(struct net_device *dev,
+			      struct rtnl_link_stats64 *stats)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	const struct rtase_counters *counters = tp->tally_vaddr;
+
+	if (!counters)
+		return;
+
+	netdev_stats_to_stats64(stats, &dev->stats);
+	dev_fetch_sw_netstats(stats, dev->tstats);
+
+	/* fetch additional counter values missing in stats collected by driver
+	 * from tally counter
+	 */
+	rtase_dump_tally_counter(tp);
+
+	stats->tx_errors = le64_to_cpu(counters->tx_errors);
+	stats->collisions = le32_to_cpu(counters->tx_multi_collision);
+	stats->tx_aborted_errors = le16_to_cpu(counters->tx_aborted);
+	stats->rx_missed_errors = le16_to_cpu(counters->rx_missed);
+}
+
+static void rtase_enable_vlan_filter(const struct rtase_private *tp, bool enabled)
+{
+	u16 tmp;
+
+	if (enabled == 1) {
+		tmp = rtase_r16(tp, RTASE_FCR);
+		if (!(tmp & FCR_VLAN_FTR_EN))
+			rtase_w16(tp, RTASE_FCR, tmp | FCR_VLAN_FTR_EN);
+
+		tmp = rtase_r16(tp, RTASE_PCPR);
+		if (!(tmp & PCPR_VLAN_FTR_EN))
+			rtase_w16(tp, RTASE_PCPR, tmp | PCPR_VLAN_FTR_EN);
+	} else {
+		tmp = rtase_r16(tp, RTASE_FCR);
+		if (tmp & FCR_VLAN_FTR_EN)
+			rtase_w16(tp, RTASE_FCR, tmp & ~FCR_VLAN_FTR_EN);
+
+		tmp = rtase_r16(tp, RTASE_PCPR);
+		if (!(tmp & PCPR_VLAN_FTR_EN))
+			rtase_w16(tp, RTASE_PCPR, tmp & ~PCPR_VLAN_FTR_EN);
+	}
+}
+
+static int rtase_vlan_rx_add_vid(struct net_device *dev, __be16 protocol,
+				 u16 vid)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	u16 tmp_mem, i;
+
+	if (be16_to_cpu(protocol) != ETH_P_8021Q)
+		return -EINVAL;
+
+	for (i = 0; i < RTASE_VLAN_FILTER_ENTRY_NUM; i++) {
+		u16 addr, mask;
+
+		if (!(tp->vlan_filter_ctrl & BIT(i))) {
+			tp->vlan_filter_ctrl |= BIT(i);
+			tp->vlan_filter_vid[i] = vid;
+			rtase_w32(tp, RTASE_VLAN_ENTRY_0 + i * 4,
+				  vid | VLAN_ENTRY_CAREBIT);
+			/* each 16-bit register contains two VLAN entries */
+			addr = RTASE_VLAN_ENTRY_MEM_0 + (i & ~0x1);
+			mask = 0x1 << ((i & 0x1) * 8);
+			tmp_mem = rtase_r16(tp, addr);
+			tmp_mem |= mask;
+			rtase_w16(tp, addr, tmp_mem);
+			break;
+		}
+	}
+
+	if (i == RTASE_VLAN_FILTER_ENTRY_NUM)
+		return -ENOENT;
+
+	rtase_enable_vlan_filter(tp, true);
+
+	return 0;
+}
+
+static int rtase_vlan_rx_kill_vid(struct net_device *dev, __be16 protocol,
+				  u16 vid)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	u16 tmp_mem, i;
+
+	if (be16_to_cpu(protocol) != ETH_P_8021Q)
+		return -EINVAL;
+
+	for (i = 0; i < RTASE_VLAN_FILTER_ENTRY_NUM; i++) {
+		u16 addr, mask;
+
+		if (tp->vlan_filter_vid[i] == vid) {
+			tp->vlan_filter_ctrl &= ~BIT(i);
+			tp->vlan_filter_vid[i] = 0;
+			rtase_w32(tp, RTASE_VLAN_ENTRY_0 + i * 4, 0);
+
+			/* each 16-bit register contains two VLAN entries */
+			addr = RTASE_VLAN_ENTRY_MEM_0 + (i & ~0x1);
+			mask = ~(0x1 << ((i & 0x1) * 8));
+			tmp_mem = rtase_r16(tp, addr);
+			tmp_mem &= mask;
+			rtase_w16(tp, addr, tmp_mem);
+			break;
+		}
+	}
+
+	/* check vlan filter enabled */
+	if (!tp->vlan_filter_ctrl)
+		rtase_enable_vlan_filter(tp, false);
+
+	return 0;
+}
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+/* Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+static void rtase_netpoll(struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	const struct pci_dev *pdev = tp->pdev;
+
+	disable_irq(pdev->irq);
+	rtase_interrupt(pdev->irq, dev);
+	enable_irq(pdev->irq);
+}
+#endif
+
+static void rtase_set_hw_cbs(const struct rtase_private *tp, u32 queue)
+{
+	u32 idle = tp->tx_qos[queue].idleslope * RTASE_1T_CLOCK;
+	u32 val, i;
+
+	val = u32_encode_bits(idle / RTASE_1T_POWER, RTASE_IDLESLOPE_INT_MASK);
+	idle %= RTASE_1T_POWER;
+
+	for (i = 1; i <= RTASE_IDLESLOPE_INT_SHIFT; i++) {
+		idle *= 2;
+		if ((idle / RTASE_1T_POWER) == 1)
+			val |= BIT(RTASE_IDLESLOPE_INT_SHIFT - i);
+
+		idle %= RTASE_1T_POWER;
+	}
+	rtase_w32(tp, RTASE_TXQCRDT_0 + queue * 4, val);
+}
+
+static void rtase_setup_tc_cbs(struct rtase_private *tp,
+			       const struct tc_cbs_qopt_offload *qopt)
+{
+	u32 queue = qopt->queue;
+
+	tp->tx_qos[queue].hicredit = qopt->hicredit;
+	tp->tx_qos[queue].locredit = qopt->locredit;
+	tp->tx_qos[queue].idleslope = qopt->idleslope;
+	tp->tx_qos[queue].sendslope = qopt->sendslope;
+
+	/* set hardware cbs */
+	rtase_set_hw_cbs(tp, queue);
+}
+
+static int rtase_setup_tc(struct net_device *dev, enum tc_setup_type type,
+			  void *type_data)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+
+	switch (type) {
+	case TC_SETUP_QDISC_CBS:
+		rtase_setup_tc_cbs(tp, type_data);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static netdev_features_t rtase_fix_features(struct net_device *dev,
+					    netdev_features_t features)
+{
+	netdev_features_t features_fix = features;
+
+	if (dev->mtu > MSS_MAX)
+		features_fix &= ~NETIF_F_ALL_TSO;
+
+	if (dev->mtu > ETH_DATA_LEN)
+		features_fix &= ~NETIF_F_ALL_TSO;
+
+	return features_fix;
+}
+
+static int rtase_set_features(struct net_device *dev,
+			      netdev_features_t features)
+{
+	netdev_features_t features_set = features;
+
+	features_set &= NETIF_F_RXALL | NETIF_F_RXCSUM |
+			NETIF_F_HW_VLAN_CTAG_RX;
+
+	if (features_set ^ dev->features)
+		rtase_hw_set_features(dev, features_set);
+
+	return 0;
+}
+
+static const struct net_device_ops rtase_netdev_ops = {
+	.ndo_open = rtase_open,
+	.ndo_stop = rtase_close,
+	.ndo_start_xmit = rtase_start_xmit,
+	.ndo_set_rx_mode = rtase_set_rx_mode,
+	.ndo_set_mac_address = rtase_set_mac_address,
+	.ndo_change_mtu = rtase_change_mtu,
+	.ndo_tx_timeout = rtase_tx_timeout,
+	.ndo_get_stats64 = rtase_get_stats64,
+	.ndo_vlan_rx_add_vid = rtase_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid = rtase_vlan_rx_kill_vid,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller = rtase_netpoll,
+#endif
+	.ndo_setup_tc = rtase_setup_tc,
+	.ndo_fix_features = rtase_fix_features,
+	.ndo_set_features = rtase_set_features,
+};
+
+static void rtase_get_mac_address(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	u8 mac_addr[ETH_ALEN] __aligned(2) = {};
+	u32 i;
+
+	for (i = 0; i < ETH_ALEN; i++)
+		mac_addr[i] = rtase_r8(tp, RTASE_MAC0 + i);
+
+	if (!is_valid_ether_addr(mac_addr)) {
+		eth_random_addr(mac_addr);
+		dev->addr_assign_type = NET_ADDR_RANDOM;
+		netdev_warn(dev, "Random ether addr %pM\n", mac_addr);
+	}
+
+	eth_hw_addr_set(dev, mac_addr);
+	rtase_rar_set(tp, mac_addr);
+
+	/* keep the original MAC address */
+	ether_addr_copy(tp->org_mac_addr, dev->dev_addr);
+	ether_addr_copy(dev->perm_addr, dev->dev_addr);
+}
+
+static void rtase_get_drvinfo(struct net_device *dev,
+			      struct ethtool_drvinfo *drvinfo)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+
+	strscpy(drvinfo->driver, KBUILD_MODNAME, 32);
+	strscpy(drvinfo->bus_info, pci_name(tp->pdev), 32);
+}
+
+static int rtase_get_settings(struct net_device *dev,
+			      struct ethtool_link_ksettings *cmd)
+{
+	u32 supported = SUPPORTED_MII | SUPPORTED_Pause | SUPPORTED_Asym_Pause;
+
+	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
+						supported);
+	cmd->base.speed = SPEED_5000;
+	cmd->base.duplex = DUPLEX_FULL;
+	cmd->base.port = PORT_MII;
+	cmd->base.autoneg = AUTONEG_DISABLE;
+
+	return 0;
+}
+
+static void rtase_get_pauseparam(struct net_device *dev,
+				 struct ethtool_pauseparam *pause)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 value = rtase_r16(tp, RTASE_CPLUS_CMD);
+
+	pause->autoneg = AUTONEG_DISABLE;
+
+	if ((value & (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN)) ==
+	    (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN)) {
+		pause->rx_pause = 1;
+		pause->tx_pause = 1;
+	} else if ((value & FORCE_TXFLOW_EN)) {
+		pause->tx_pause = 1;
+	} else if ((value & FORCE_RXFLOW_EN)) {
+		pause->rx_pause = 1;
+	}
+}
+
+static int rtase_set_pauseparam(struct net_device *dev,
+				struct ethtool_pauseparam *pause)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 value = rtase_r16(tp, RTASE_CPLUS_CMD);
+
+	if (pause->autoneg)
+		return -EOPNOTSUPP;
+
+	value &= ~(FORCE_TXFLOW_EN | FORCE_RXFLOW_EN);
+
+	if (pause->tx_pause)
+		value |= FORCE_TXFLOW_EN;
+
+	if (pause->rx_pause)
+		value |= FORCE_RXFLOW_EN;
+
+	rtase_w16(tp, RTASE_CPLUS_CMD, value);
+	return 0;
+}
+
+static const char rtase_gstrings[][ETH_GSTRING_LEN] = {
+	"tx_packets",
+	"rx_packets",
+	"tx_errors",
+	"rx_errors",
+	"rx_missed",
+	"align_errors",
+	"tx_single_collisions",
+	"tx_multi_collisions",
+	"unicast",
+	"broadcast",
+	"multicast",
+	"tx_aborted",
+	"tx_underrun",
+};
+
+static void rtase_get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		memcpy(data, *rtase_gstrings, sizeof(rtase_gstrings));
+		break;
+	}
+}
+
+static int rtase_get_sset_count(struct net_device *dev, int sset)
+{
+	int ret = -EOPNOTSUPP;
+
+	switch (sset) {
+	case ETH_SS_STATS:
+		ret = ARRAY_SIZE(rtase_gstrings);
+		break;
+	}
+
+	return ret;
+}
+
+static void rtase_get_ethtool_stats(struct net_device *dev,
+				    struct ethtool_stats *stats, u64 *data)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	const struct rtase_counters *counters;
+
+	ASSERT_RTNL();
+
+	counters = tp->tally_vaddr;
+	if (!counters)
+		return;
+
+	rtase_dump_tally_counter(tp);
+
+	data[0] = le64_to_cpu(counters->tx_packets);
+	data[1] = le64_to_cpu(counters->rx_packets);
+	data[2] = le64_to_cpu(counters->tx_errors);
+	data[3] = le32_to_cpu(counters->rx_errors);
+	data[4] = le16_to_cpu(counters->rx_missed);
+	data[5] = le16_to_cpu(counters->align_errors);
+	data[6] = le32_to_cpu(counters->tx_one_collision);
+	data[7] = le32_to_cpu(counters->tx_multi_collision);
+	data[8] = le64_to_cpu(counters->rx_unicast);
+	data[9] = le64_to_cpu(counters->rx_broadcast);
+	data[10] = le32_to_cpu(counters->rx_multicast);
+	data[11] = le16_to_cpu(counters->tx_aborted);
+	data[12] = le16_to_cpu(counters->tx_underun);
+}
+
+static const struct ethtool_ops rtase_ethtool_ops = {
+	.get_drvinfo = rtase_get_drvinfo,
+	.get_link = ethtool_op_get_link,
+	.get_link_ksettings = rtase_get_settings,
+	.get_pauseparam = rtase_get_pauseparam,
+	.set_pauseparam = rtase_set_pauseparam,
+	.get_strings = rtase_get_strings,
+	.get_sset_count = rtase_get_sset_count,
+	.get_ethtool_stats = rtase_get_ethtool_stats,
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
+static void rtase_init_netdev_ops(struct net_device *dev)
+{
+	dev->netdev_ops = &rtase_netdev_ops;
+	dev->ethtool_ops = &rtase_ethtool_ops;
+}
+
+static void rtase_reset_interrupt(struct pci_dev *pdev,
+				  const struct rtase_private *tp)
+{
+	if (tp->sw_flag & SWF_MSIX_ENABLED)
+		pci_disable_msix(pdev);
+	else
+		pci_disable_msi(pdev);
+}
+
+static int rtase_alloc_msix(struct pci_dev *pdev, struct rtase_private *tp)
+{
+	int ret;
+	u16 i;
+
+	memset(tp->msix_entry, 0x0, RTASE_NUM_MSIX * sizeof(struct msix_entry));
+
+	for (i = 0; i < RTASE_NUM_MSIX; i++)
+		tp->msix_entry[i].entry = i;
+
+	ret = pci_enable_msix_range(pdev, tp->msix_entry, tp->int_nums,
+				    tp->int_nums);
+
+	if (ret == tp->int_nums) {
+		for (i = 0; i < tp->int_nums; i++) {
+			tp->int_vector[i].irq = pci_irq_vector(pdev, i);
+			tp->int_vector[i].status = 1;
+		}
+	}
+
+	return ret;
+}
+
+static int rtase_alloc_interrupt(struct pci_dev *pdev,
+				 struct rtase_private *tp)
+{
+	int ret;
+
+	ret = rtase_alloc_msix(pdev, tp);
+	if (ret != tp->int_nums) {
+		ret = pci_enable_msi(pdev);
+		if (ret)
+			dev_err(&pdev->dev,
+				"unable to alloc interrupt.(MSI)\n");
+		else
+			tp->sw_flag |= SWF_MSI_ENABLED;
+	} else {
+		tp->sw_flag |= SWF_MSIX_ENABLED;
+	}
+
+	return ret;
+}
+
+static void rtase_init_hardware(const struct rtase_private *tp)
+{
+	u16 i;
+
+	for (i = 0; i < RTASE_VLAN_FILTER_ENTRY_NUM; i++)
+		rtase_w32(tp, RTASE_VLAN_ENTRY_0 + i * 4, 0);
+}
+
+static void rtase_init_int_vector(struct rtase_private *tp)
+{
+	u16 i;
+
+	/* interrupt vector 0 */
+	tp->int_vector[0].tp = tp;
+	tp->int_vector[0].index = 0;
+	tp->int_vector[0].imr_addr = RTASE_IMR0;
+	tp->int_vector[0].isr_addr = RTASE_ISR0;
+	tp->int_vector[0].imr = ROK | RDU | TOK | TOK4 | TOK5 | TOK6 | TOK7;
+	tp->int_vector[0].poll = rtase_poll;
+
+	memset(tp->int_vector[0].name, 0x0, sizeof(tp->int_vector[0].name));
+	INIT_LIST_HEAD(&tp->int_vector[0].ring_list);
+
+	netif_napi_add(tp->dev, &tp->int_vector[0].napi,
+		       tp->int_vector[0].poll);
+	napi_enable(&tp->int_vector[0].napi);
+
+	/* interrupt vector 1 ~ 3 */
+	for (i = 1; i < tp->int_nums; i++) {
+		tp->int_vector[i].tp = tp;
+		tp->int_vector[i].index = i;
+		tp->int_vector[i].imr_addr = RTASE_IMR1 + (i - 1) * 4;
+		tp->int_vector[i].isr_addr = RTASE_ISR1 + (i - 1) * 4;
+		tp->int_vector[i].imr = Q_ROK | Q_RDU | Q_TOK;
+		tp->int_vector[i].poll = rtase_poll;
+
+		memset(tp->int_vector[i].name, 0x0, sizeof(tp->int_vector[0].name));
+		INIT_LIST_HEAD(&tp->int_vector[i].ring_list);
+
+		netif_napi_add(tp->dev, &tp->int_vector[i].napi,
+			       tp->int_vector[i].poll);
+		napi_enable(&tp->int_vector[i].napi);
+	}
+}
+
+static u16 rtase_calc_time_mitigation(u32 time_us)
+{
+	u16 int_miti;
+	u8 msb, time_count, time_unit;
+
+	time_us = min_t(int, time_us, MITI_MAX_TIME);
+
+	msb = fls(time_us);
+	if (msb >= MITI_COUNT_BIT_NUM) {
+		time_unit = msb - MITI_COUNT_BIT_NUM;
+		time_count = time_us >> (msb - MITI_COUNT_BIT_NUM);
+	} else {
+		time_unit = 0;
+		time_count = time_us;
+	}
+
+	int_miti = u16_encode_bits(time_count, MITI_TIME_COUNT_MASK) |
+		   u16_encode_bits(time_unit, MITI_TIME_UNIT_MASK);
+
+	return int_miti;
+}
+
+static u16 rtase_calc_packet_num_mitigation(u16 pkt_num)
+{
+	u16 int_miti;
+	u8 msb, pkt_num_count, pkt_num_unit;
+
+	pkt_num = min_t(int, pkt_num, MITI_MAX_PKT_NUM);
+
+	if (pkt_num > 60) {
+		pkt_num_unit = MITI_MAX_PKT_NUM_IDX;
+		pkt_num_count = pkt_num / MITI_MAX_PKT_NUM_UNIT;
+	} else {
+		msb = fls(pkt_num);
+		if (msb >= MITI_COUNT_BIT_NUM) {
+			pkt_num_unit = msb - MITI_COUNT_BIT_NUM;
+			pkt_num_count = pkt_num >> (msb - MITI_COUNT_BIT_NUM);
+		} else {
+			pkt_num_unit = 0;
+			pkt_num_count = pkt_num;
+		}
+	}
+
+	int_miti = u16_encode_bits(pkt_num_count, MITI_PKT_NUM_COUNT_MASK) |
+		   u16_encode_bits(pkt_num_unit, MITI_PKT_NUM_UNIT_MASK);
+
+	return int_miti;
+}
+
+static void rtase_init_software_variable(struct pci_dev *pdev,
+					 struct rtase_private *tp)
+{
+	u16 int_miti;
+
+	tp->tx_queue_ctrl = RTASE_TXQ_CTRL;
+	tp->func_tx_queue_num = RTASE_FUNC_TXQ_NUM;
+	tp->func_rx_queue_num = RTASE_FUNC_RXQ_NUM;
+	tp->int_nums = RTASE_INTERRUPT_NUM;
+
+	int_miti = rtase_calc_time_mitigation(MITI_DEFAULT_TIME) |
+		   rtase_calc_packet_num_mitigation(MITI_DEFAULT_PKT_NUM);
+	tp->tx_int_mit = int_miti;
+	tp->rx_int_mit = int_miti;
+
+	tp->sw_flag = 0;
+
+	rtase_init_int_vector(tp);
+
+	/* MTU range: 60 - hw-specific max */
+	tp->dev->min_mtu = ETH_ZLEN;
+	tp->dev->max_mtu = MAX_JUMBO_SIZE;
+}
+
+static bool rtase_check_mac_version_valid(struct rtase_private *tp)
+{
+	u32 hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & HW_VER_MASK;
+	bool known_ver = false;
+
+	switch (hw_ver) {
+	case 0x00800000:
+	case 0x04000000:
+	case 0x04800000:
+		known_ver = true;
+		break;
+	}
+
+	return known_ver;
+}
+
+static int rtase_init_board(struct pci_dev *pdev, struct net_device **dev_out,
+			    void __iomem **ioaddr_out)
+{
+	struct net_device *dev;
+	void __iomem *ioaddr;
+	int ret = -ENOMEM;
+
+	/* dev zeroed in alloc_etherdev */
+	dev = alloc_etherdev_mq(sizeof(struct rtase_private),
+				RTASE_FUNC_TXQ_NUM);
+	if (!dev)
+		goto err_out;
+
+	SET_NETDEV_DEV(dev, &pdev->dev);
+
+	ret = pci_enable_device(pdev);
+	if (ret < 0)
+		goto err_out_free_dev;
+
+	/* make sure PCI base addr 1 is MMIO */
+	if (!(pci_resource_flags(pdev, 2) & IORESOURCE_MEM)) {
+		ret = -ENODEV;
+		goto err_out_disable;
+	}
+
+	/* check for weird/broken PCI region reporting */
+	if (pci_resource_len(pdev, 2) < RTASE_REGS_SIZE) {
+		ret = -ENODEV;
+		goto err_out_disable;
+	}
+
+	ret = pci_request_regions(pdev, KBUILD_MODNAME);
+	if (ret < 0)
+		goto err_out_disable;
+
+	if (!dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)))
+		dev->features |= NETIF_F_HIGHDMA;
+	else if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))
+		goto err_out_free_res;
+	else
+		dev_info(&pdev->dev, "DMA_BIT_MASK: 32\n");
+
+	pci_set_master(pdev);
+
+	/* ioremap MMIO region */
+	ioaddr = ioremap(pci_resource_start(pdev, 2),
+			 pci_resource_len(pdev, 2));
+	if (!ioaddr) {
+		ret = -EIO;
+		goto err_out_free_res;
+	}
+
+	*ioaddr_out = ioaddr;
+	*dev_out = dev;
+	goto out;
+
+err_out_free_res:
+	pci_release_regions(pdev);
+
+err_out_disable:
+	pci_disable_device(pdev);
+
+err_out_free_dev:
+	free_netdev(dev);
+
+err_out:
+	*ioaddr_out = NULL;
+	*dev_out = NULL;
+
+out:
+	return ret;
+}
+
+static void rtase_release_board(struct pci_dev *pdev, struct net_device *dev,
+				void __iomem *ioaddr)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+
+	rtase_rar_set(tp, tp->org_mac_addr);
+	iounmap(ioaddr);
+
+	if ((tp->sw_flag & SWF_MSIX_ENABLED))
+		pci_disable_msix(pdev);
+	else
+		pci_disable_msi(pdev);
+
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	free_netdev(dev);
+}
+
+static int rtase_init_one(struct pci_dev *pdev,
+			  const struct pci_device_id *ent)
+{
+	struct net_device *dev = NULL;
+	void __iomem *ioaddr = NULL;
+	struct rtase_private *tp;
+	int ret;
+
+	if (!pdev->is_physfn && pdev->is_virtfn) {
+		dev_err(&pdev->dev, "This module does not support a virtual function.");
+		return -EINVAL;
+	}
+
+	dev_dbg(&pdev->dev, "Automotive Switch Ethernet driver loaded\n");
+
+	ret = rtase_init_board(pdev, &dev, &ioaddr);
+	if (ret != 0)
+		return ret;
+
+	tp = netdev_priv(dev);
+	tp->mmio_addr = ioaddr;
+	tp->dev = dev;
+	tp->pdev = pdev;
+
+	/* identify chip attached to board */
+	if (!rtase_check_mac_version_valid(tp)) {
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "unknown chip version, contact rtase maintainers (see MAINTAINERS file)\n");
+	}
+
+	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	if (!dev->tstats)
+		goto err_out_1;
+
+	rtase_init_software_variable(pdev, tp);
+	rtase_init_hardware(tp);
+
+	ret = rtase_alloc_interrupt(pdev, tp);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "unable to alloc MSIX/MSI\n");
+		goto err_out_1;
+	}
+
+	rtase_init_netdev_ops(dev);
+
+	dev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
+
+	dev->features |= NETIF_F_IP_CSUM;
+	dev->features |= NETIF_F_RXCSUM | NETIF_F_SG | NETIF_F_TSO;
+	dev->features |= NETIF_F_IPV6_CSUM | NETIF_F_TSO6;
+	dev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO |
+			   NETIF_F_RXCSUM | NETIF_F_HW_VLAN_CTAG_TX |
+			   NETIF_F_HW_VLAN_CTAG_RX;
+	dev->hw_features |= NETIF_F_RXALL;
+	dev->hw_features |= NETIF_F_RXFCS;
+	dev->hw_features |= NETIF_F_IPV6_CSUM | NETIF_F_TSO6;
+	dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO |
+			     NETIF_F_HIGHDMA;
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	netif_set_tso_max_size(dev, LSO_64K);
+	netif_set_tso_max_segs(dev, NIC_MAX_PHYS_BUF_COUNT_LSO2);
+
+	rtase_get_mac_address(dev);
+
+	tp->tally_vaddr = dma_alloc_coherent(&pdev->dev,
+					     sizeof(*tp->tally_vaddr),
+					     &tp->tally_paddr,
+					     GFP_KERNEL);
+	if (!tp->tally_vaddr) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	rtase_tally_counter_clear(tp);
+
+	pci_set_drvdata(pdev, dev);
+
+	ret = register_netdev(dev);
+	if (ret != 0)
+		goto err_out;
+
+	netdev_dbg(dev, "%pM, IRQ %d\n", dev->dev_addr, dev->irq);
+
+	netif_carrier_off(dev);
+
+	goto out;
+
+err_out:
+	if (tp->tally_vaddr) {
+		dma_free_coherent(&pdev->dev,
+				  sizeof(*tp->tally_vaddr),
+				  tp->tally_vaddr,
+				  tp->tally_paddr);
+
+		tp->tally_vaddr = NULL;
+	}
+
+err_out_1:
+	rtase_release_board(pdev, dev, ioaddr);
+
+out:
+	return ret;
+}
+
+static void rtase_remove_one(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct rtase_private *tp = netdev_priv(dev);
+	struct rtase_int_vector *ivec;
+	u32 i;
+
+	for (i = 0; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		netif_napi_del(&ivec->napi);
+	}
+
+	unregister_netdev(dev);
+	rtase_reset_interrupt(pdev, tp);
+	if (tp->tally_vaddr) {
+		dma_free_coherent(&pdev->dev,
+				  sizeof(*tp->tally_vaddr),
+				  tp->tally_vaddr,
+				  tp->tally_paddr);
+		tp->tally_vaddr = NULL;
+	}
+
+	rtase_release_board(pdev, dev, tp->mmio_addr);
+	pci_set_drvdata(pdev, NULL);
+}
+
+static void rtase_shutdown(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	const struct rtase_private *tp = netdev_priv(dev);
+
+	if (netif_running(dev))
+		rtase_close(dev);
+
+	rtase_reset_interrupt(pdev, tp);
+}
+
+#ifdef CONFIG_PM
+static int rtase_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+
+	if (!netif_running(dev))
+		goto out;
+
+	netif_stop_queue(dev);
+	netif_carrier_off(dev);
+	netif_device_detach(dev);
+	rtase_hw_reset(dev);
+
+out:
+	pci_save_state(pdev);
+
+	return 0;
+}
+
+static int rtase_resume(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct rtase_private *tp = netdev_priv(dev);
+	int ret;
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	pci_enable_wake(pdev, PCI_D0, 0);
+
+	/* restore last modified mac address */
+	rtase_rar_set(tp, dev->dev_addr);
+
+	if (!netif_running(dev))
+		goto out;
+
+	rtase_wait_for_quiescence(dev);
+
+	rtase_tx_clear(tp);
+	rtase_rx_clear(tp);
+
+	ret = rtase_init_ring(dev);
+	if (ret) {
+		netdev_err(dev, "unable to init ring\n");
+		rtase_free_desc(tp);
+		return -ENOMEM;
+	}
+
+	rtase_hw_config(dev);
+	/* always link, so start to transmit & receive */
+	rtase_hw_start(dev);
+
+	netif_carrier_on(dev);
+	netif_wake_queue(dev);
+	netif_device_attach(dev);
+
+out:
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+static struct pci_driver rtase_pci_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = rtase_pci_tbl,
+	.probe = rtase_init_one,
+	.remove = rtase_remove_one,
+	.shutdown = rtase_shutdown,
+#ifdef CONFIG_PM
+	.suspend = rtase_suspend,
+	.resume = rtase_resume,
+#endif
+};
+
+module_pci_driver(rtase_pci_driver);
diff --git a/drivers/net/ethernet/realtek/rtase/tt.h b/drivers/net/ethernet/realtek/rtase/tt.h
new file mode 100644
index 000000000000..9239c518c504
--- /dev/null
+++ b/drivers/net/ethernet/realtek/rtase/tt.h
@@ -0,0 +1,353 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ *  rtase is the Linux device driver released for Realtek Automotive Switch
+ *  controllers with PCI-Express interface.
+ *
+ *  Copyright(c) 2023 Realtek Semiconductor Corp.
+ */
+
+#ifndef _RTASE_H_
+#define _RTASE_H_
+
+/* the low 32 bit address of receive buffer must be 8-byte alignment. */
+#define RTK_RX_ALIGN 8
+
+#define HW_VER_MASK 0x7C800000
+
+#define RX_DMA_BURST_256       4
+#define TX_DMA_BURST_UNLIMITED 7
+#define RX_BUF_SIZE            (PAGE_SIZE - \
+				SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+#define MAX_JUMBO_SIZE         (RX_BUF_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN)
+
+/* 3 means InterFrameGap = the shortest one */
+#define INTERFRAMEGAP 0x03
+
+#define RTASE_REGS_SIZE     256
+#define RTASE_PCI_REGS_SIZE 0x100
+
+#define MULTICAST_FILTER_MASK  GENMASK(30, 26)
+#define MULTICAST_FILTER_LIMIT 32
+
+#define RTASE_VLAN_FILTER_ENTRY_NUM 32
+#define RTASE_NUM_TX_QUEUE 8
+#define RTASE_NUM_RX_QUEUE 4
+
+#define RTASE_TXQ_CTRL      1
+#define RTASE_FUNC_TXQ_NUM  1
+#define RTASE_FUNC_RXQ_NUM  1
+#define RTASE_INTERRUPT_NUM 1
+
+#define MITI_TIME_COUNT_MASK     GENMASK(3, 0)
+#define MITI_TIME_UNIT_MASK      GENMASK(7, 4)
+#define MITI_DEFAULT_TIME        128
+#define MITI_MAX_TIME            491520
+#define MITI_PKT_NUM_COUNT_MASK  GENMASK(11, 8)
+#define MITI_PKT_NUM_UNIT_MASK   GENMASK(13, 12)
+#define MITI_DEFAULT_PKT_NUM     64
+#define MITI_MAX_PKT_NUM_IDX     3
+#define MITI_MAX_PKT_NUM_UNIT    16
+#define MITI_MAX_PKT_NUM         240
+#define MITI_COUNT_BIT_NUM       4
+
+#define RTASE_NUM_MSIX 4
+
+#define RTASE_DWORD_MOD 16
+
+/*****************************************************************************/
+enum rtase_registers {
+	RTASE_MAC0   = 0x0000,
+	RTASE_MAC4   = 0x0004,
+	RTASE_MAR0   = 0x0008,
+	RTASE_MAR1   = 0x000C,
+	RTASE_DTCCR0 = 0x0010,
+	RTASE_DTCCR4 = 0x0014,
+#define COUNTER_RESET BIT(0)
+#define COUNTER_DUMP  BIT(3)
+
+	RTASE_FCR    = 0x0018,
+#define FCR_RXQ_MASK    GENMASK(5, 4)
+#define FCR_VLAN_FTR_EN BIT(1)
+
+	RTASE_LBK_CTRL = 0x001A,
+#define LBK_ATLD BIT(1)
+#define LBK_CLR  BIT(0)
+
+	RTASE_TX_DESC_ADDR0   = 0x0020,
+	RTASE_TX_DESC_ADDR4   = 0x0024,
+	RTASE_TX_DESC_COMMAND = 0x0028,
+#define TX_DESC_CMD_CS BIT(15)
+#define TX_DESC_CMD_WE BIT(14)
+
+	RTASE_BOOT_CTL  = 0x6004,
+	RTASE_CLKSW_SET = 0x6018,
+
+	RTASE_CHIP_CMD = 0x0037,
+#define STOP_REQ      BIT(7)
+#define STOP_REQ_DONE BIT(6)
+#define RE            BIT(3)
+#define TE            BIT(2)
+
+	RTASE_IMR0 = 0x0038,
+	RTASE_ISR0 = 0x003C,
+#define TOK7 BIT(30)
+#define TOK6 BIT(28)
+#define TOK5 BIT(26)
+#define TOK4 BIT(24)
+#define FOVW BIT(6)
+#define RDU  BIT(4)
+#define TOK  BIT(2)
+#define ROK  BIT(0)
+
+	RTASE_IMR1 = 0x0800,
+	RTASE_ISR1 = 0x0802,
+#define Q_TOK BIT(4)
+#define Q_RDU BIT(1)
+#define Q_ROK BIT(0)
+
+	RTASE_EPHY_ISR = 0x6014,
+	RTASE_EPHY_IMR = 0x6016,
+
+	RTASE_TX_CONFIG_0 = 0x0040,
+#define TX_INTER_FRAME_GAP_MASK GENMASK(25, 24)
+	/* DMA burst value (0-7) is shift this many bits */
+#define TX_DMA_MASK             GENMASK(10, 8)
+
+	RTASE_RX_CONFIG_0 = 0x0044,
+#define RX_SINGLE_FETCH  BIT(14)
+#define RX_SINGLE_TAG    BIT(13)
+#define RX_MX_DMA_MASK   GENMASK(10, 8)
+#define ACPT_FLOW        BIT(7)
+#define ACCEPT_ERR       BIT(5)
+#define ACCEPT_RUNT      BIT(4)
+#define ACCEPT_BROADCAST BIT(3)
+#define ACCEPT_MULTICAST BIT(2)
+#define ACCEPT_MYPHYS    BIT(1)
+#define ACCEPT_ALLPHYS   BIT(0)
+#define ACCEPT_MASK      (ACPT_FLOW | ACCEPT_ERR | ACCEPT_RUNT | \
+			  ACCEPT_BROADCAST | ACCEPT_MULTICAST | \
+			  ACCEPT_MYPHYS | ACCEPT_ALLPHYS)
+
+	RTASE_RX_CONFIG_1 = 0x0046,
+#define RX_MAX_FETCH_DESC_MASK  GENMASK(15, 11)
+#define RX_NEW_DESC_FORMAT_EN   BIT(8)
+#define OUTER_VLAN_DETAG_EN     BIT(7)
+#define INNER_VLAN_DETAG_EN     BIT(6)
+#define PCIE_NEW_FLOW           BIT(2)
+#define PCIE_RELOAD_En          BIT(0)
+
+	RTASE_EEM = 0x0050,
+#define EEM_UNLOCK 0xC0
+
+	RTASE_TDFNR  = 0x0057,
+	RTASE_TPPOLL = 0x0090,
+	RTASE_PDR    = 0x00B0,
+	RTASE_FIFOR  = 0x00D3,
+#define TX_FIFO_EMPTY BIT(5)
+#define RX_FIFO_EMPTY BIT(4)
+
+	RTASE_PCPR = 0x00D8,
+#define PCPR_VLAN_FTR_EN BIT(6)
+
+	RTASE_RMS       = 0x00DA,
+	RTASE_CPLUS_CMD = 0x00E0,
+#define FORCE_RXFLOW_EN BIT(11)
+#define FORCE_TXFLOW_EN BIT(10)
+#define RX_CHKSUM       BIT(5)
+
+	RTASE_Q0_RX_DESC_ADDR0 = 0x00E4,
+	RTASE_Q0_RX_DESC_ADDR4 = 0x00E8,
+	RTASE_Q1_RX_DESC_ADDR0 = 0x4000,
+	RTASE_Q1_RX_DESC_ADDR4 = 0x4004,
+	RTASE_MTPS             = 0x00EC,
+#define TAG_NUM_SEL_MASK  GENMASK(10, 8)
+
+	RTASE_MISC = 0x00F2,
+#define RX_DV_GATE_EN BIT(3)
+
+	RTASE_TFUN_CTRL = 0x0400,
+#define TX_NEW_DESC_FORMAT_EN BIT(0)
+
+	RTASE_TX_CONFIG_1 = 0x203E,
+#define TC_MODE_MASK  GENMASK(11, 10)
+
+	RTASE_TOKSEL      = 0x2046,
+	RTASE_TXQCRDT_0   = 0x2500,
+	RTASE_RFIFONFULL  = 0x4406,
+	RTASE_INT_MITI_TX = 0x0A00,
+	RTASE_INT_MITI_RX = 0x0A80,
+
+	RTASE_VLAN_ENTRY_MEM_0 = 0x7234,
+	RTASE_VLAN_ENTRY_0     = 0xAC80,
+};
+
+enum desc_status_bit {
+	DESC_OWN = BIT(31), /* Descriptor is owned by NIC */
+	RING_END = BIT(30), /* End of descriptor ring */
+};
+
+enum sw_flag_content {
+	SWF_MSI_ENABLED  = BIT(1),
+	SWF_MSIX_ENABLED = BIT(2),
+};
+
+#define RSVD_MASK 0x3FFFC000
+
+struct tx_desc {
+	__le32 opts1;
+	__le32 opts2;
+	__le64 addr;
+	__le32 opts3;
+	__le32 reserved1;
+	__le32 reserved2;
+	__le32 reserved3;
+} __packed;
+
+/*------ offset 0 of tx descriptor ------*/
+#define TX_FIRST_FRAG BIT(29) /* Tx First segment of a packet */
+#define TX_LAST_FRAG  BIT(28) /* Tx Final segment of a packet */
+#define GIANT_SEND_V4 BIT(26) /* TCP Giant Send Offload V4 (GSOv4) */
+#define GIANT_SEND_V6 BIT(25) /* TCP Giant Send Offload V6 (GSOv6) */
+#define TX_VLAN_TAG   BIT(17) /* Add VLAN tag */
+
+/*------ offset 4 of tx descriptor ------*/
+#define TX_UDPCS_C BIT(31) /* Calculate UDP/IP checksum */
+#define TX_TCPCS_C BIT(30) /* Calculate TCP/IP checksum */
+#define TX_IPCS_C  BIT(29) /* Calculate IP checksum */
+#define TX_IPV6F_C BIT(28) /* Indicate it is an IPv6 packet */
+
+union rx_desc {
+	struct {
+		__le64 header_buf_addr;
+		__le32 reserved1;
+		__le32 opts_header_len;
+		__le64 addr;
+		__le32 reserved2;
+		__le32 opts1;
+	} __packed desc_cmd;
+
+	struct {
+		__le32 reserved1;
+		__le32 reserved2;
+		__le32 rss;
+		__le32 opts4;
+		__le32 reserved3;
+		__le32 opts3;
+		__le32 opts2;
+		__le32 opts1;
+	} __packed desc_status;
+} __packed;
+
+/*------ offset 28 of rx descriptor ------*/
+#define RX_FIRST_FRAG    BIT(25) /* Rx First segment of a packet */
+#define RX_LAST_FRAG     BIT(24) /* Rx Final segment of a packet */
+#define RX_RES           BIT(20)
+#define RX_RUNT          BIT(19)
+#define RX_RWT           BIT(18)
+#define RX_CRC           BIT(16)
+#define RX_V6F           BIT(31)
+#define RX_V4F           BIT(30)
+#define RX_UDPT          BIT(29)
+#define RX_TCPT          BIT(28)
+#define RX_IPF           BIT(26) /* IP checksum failed */
+#define RX_UDPF          BIT(25) /* UDP/IP checksum failed */
+#define RX_TCPF          BIT(24) /* TCP/IP checksum failed */
+#define RX_LBK_FIFO_FULL BIT(17) /* Loopback FIFO Full */
+#define RX_VLAN_TAG      BIT(16) /* VLAN tag available */
+
+#define NUM_DESC                1024
+#define RTASE_TX_RING_DESC_SIZE (NUM_DESC * sizeof(struct tx_desc))
+#define RTASE_RX_RING_DESC_SIZE (NUM_DESC * sizeof(union rx_desc))
+#define VLAN_ENTRY_CAREBIT      0xF0000000
+#define VLAN_TAG_MASK           GENMASK(15, 0)
+#define RX_PKT_SIZE_MASK        GENMASK(13, 0)
+
+/* txqos hardware definitions */
+#define RTASE_1T_CLOCK            64
+#define RTASE_1T_POWER            10000000
+#define RTASE_IDLESLOPE_INT_SHIFT 25
+#define RTASE_IDLESLOPE_INT_MASK  GENMASK(31, 25)
+
+#define IVEC_NAME_SIZE (IFNAMSIZ + 10)
+
+struct rtase_int_vector {
+	struct rtase_private *tp;
+	unsigned int irq;
+	u8 status;
+	char name[IVEC_NAME_SIZE];
+	u16 index;
+	u16 imr_addr;
+	u16 isr_addr;
+	u32 imr;
+	struct list_head ring_list;
+	struct napi_struct napi;
+	int (*poll)(struct napi_struct *napi, int budget);
+};
+
+struct rtase_ring {
+	struct rtase_int_vector *ivec;
+	void *desc;
+	dma_addr_t phy_addr;
+	u32 cur_idx;
+	u32 dirty_idx;
+	u16 index;
+
+	struct sk_buff *skbuff[NUM_DESC];
+	union {
+		u32 len[NUM_DESC];
+		dma_addr_t data_phy_addr[NUM_DESC];
+	} mis;
+
+	struct list_head ring_entry;
+	int (*ring_handler)(struct rtase_ring *ring, int budget);
+};
+
+struct rtase_txqos {
+	int hicredit;
+	int locredit;
+	int idleslope;
+	int sendslope;
+};
+
+struct rtase_private {
+	void __iomem *mmio_addr;
+	u32 sw_flag;
+	u32 mc_filter[2];
+
+	struct pci_dev *pdev;
+	struct net_device *dev;
+	u32 rx_buf_sz;
+
+	struct page_pool *page_pool;
+	struct rtase_ring tx_ring[RTASE_NUM_TX_QUEUE];
+	struct rtase_txqos tx_qos[RTASE_NUM_TX_QUEUE];
+	struct rtase_ring rx_ring[RTASE_NUM_RX_QUEUE];
+	struct rtase_counters *tally_vaddr;
+	dma_addr_t tally_paddr;
+
+	u32 vlan_filter_ctrl;
+	u16 vlan_filter_vid[RTASE_VLAN_FILTER_ENTRY_NUM];
+
+	struct delayed_work task;
+	u8 org_mac_addr[ETH_ALEN];
+	struct msix_entry msix_entry[RTASE_NUM_MSIX];
+	struct rtase_int_vector int_vector[RTASE_NUM_MSIX];
+
+	u16 tx_queue_ctrl;
+	u16 func_tx_queue_num;
+	u16 func_rx_queue_num;
+	u16 int_nums;
+	u16 tx_int_mit;
+	u16 rx_int_mit;
+};
+
+#define LSO_64K 64000
+
+#define NIC_MAX_PHYS_BUF_COUNT_LSO2 (16 * 4)
+
+#define TCPHO_MASK GENMASK(24, 18)
+
+#define MSS_MAX  0x07FF /* MSS value */
+#define MSS_MASK GENMASK(28, 18)
+
+#endif /* _RTASE_H_ */
-- 
2.34.1

