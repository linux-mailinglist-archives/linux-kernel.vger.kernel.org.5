Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69AB7EC3DB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbjKONgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344059AbjKONgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:36:25 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AF819AF;
        Wed, 15 Nov 2023 05:36:09 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AFDZnUfA1694208, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AFDZnUfA1694208
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 21:35:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 15 Nov 2023 21:34:30 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 15 Nov
 2023 21:34:29 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     <kuba@kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next v11 08/13] net:ethernet:realtek:rtase: Implement net_device_ops
Date:   Wed, 15 Nov 2023 21:34:09 +0800
Message-ID: <20231115133414.1221480-9-justinlai0215@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Implement .ndo_set_rx_mode so that the device can change address
list filtering.
2. Implement .ndo_set_mac_address so that mac address can be changed.
3. Implement .ndo_change_mtu so that mtu can be changed.
4. Implement .ndo_tx_timeout to perform related processing when the
transmitter does not make any progress.
5. Implement .ndo_get_stats64 to provide statistics that are called
when the user wants to get network device usage.
6. Implement .ndo_vlan_rx_add_vid to register VLAN ID when the device
supports VLAN filtering.
7. Implement .ndo_vlan_rx_kill_vid to unregister VLAN ID when the device
supports VLAN filtering.
8. Implement the .ndo_setup_tc to enable setting any "tc" scheduler,
classifier or action on dev.
9. Implement .ndo_fix_features enables adjusting requested feature flags
based on device-specific constraints.
10. Implement .ndo_set_features enables updating device configuration to
new features.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 378 ++++++++++++++++++
 1 file changed, 378 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 5c03d9abaa26..12607663dd72 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1442,6 +1442,11 @@ static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_BUSY;
 }
 
+static void rtase_set_rx_mode(struct net_device *dev)
+{
+	rtase_hw_set_rx_packet_filter(dev);
+}
+
 static void rtase_enable_eem_write(const struct rtase_private *tp)
 {
 	u8 val;
@@ -1474,6 +1479,293 @@ static void rtase_rar_set(const struct rtase_private *tp, const u8 *addr)
 	rtase_w16(tp, RTASE_LBK_CTRL, LBK_ATLD | LBK_CLR);
 }
 
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
 #ifdef CONFIG_NET_POLL_CONTROLLER
 /* Polling 'interrupt' - used by things like netconsole to send skbs
  * without having to re-enable interrupts. It's not called while
@@ -1490,13 +1782,99 @@ static void rtase_netpoll(struct net_device *dev)
 }
 #endif
 
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
 static const struct net_device_ops rtase_netdev_ops = {
 	.ndo_open = rtase_open,
 	.ndo_stop = rtase_close,
 	.ndo_start_xmit = rtase_start_xmit,
+	.ndo_set_rx_mode = rtase_set_rx_mode,
+	.ndo_set_mac_address = rtase_set_mac_address,
+	.ndo_change_mtu = rtase_change_mtu,
+	.ndo_tx_timeout = rtase_tx_timeout,
+	.ndo_get_stats64 = rtase_get_stats64,
+	.ndo_vlan_rx_add_vid = rtase_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid = rtase_vlan_rx_kill_vid,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller = rtase_netpoll,
 #endif
+	.ndo_setup_tc = rtase_setup_tc,
+	.ndo_fix_features = rtase_fix_features,
+	.ndo_set_features = rtase_set_features,
 };
 
 static void rtase_get_mac_address(struct net_device *dev)
-- 
2.34.1

