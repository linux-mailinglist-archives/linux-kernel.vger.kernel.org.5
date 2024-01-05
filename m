Return-Path: <linux-kernel+bounces-17808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0C58252FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41F81F22278
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9282C688;
	Fri,  5 Jan 2024 11:37:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A422C6A3;
	Fri,  5 Jan 2024 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 405Bb5i552341943, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 405Bb5i552341943
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jan 2024 19:37:05 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 5 Jan 2024 19:37:05 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 5 Jan 2024
 19:37:05 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net-next v16 10/13] rtase: Implement ethtool function
Date: Fri, 5 Jan 2024 19:32:54 +0800
Message-ID: <20240105113257.381090-6-justinlai0215@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Implement the ethtool function to support users to obtain network card
information, including obtaining various device settings, Report whether
physical link is up, Report pause parameters, Set pause parameters,
Return a set of strings that describe the requested objects, Get number
of strings that @get_strings will write, Return extended statistics
about the device.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index b8e5ef489b0c..0fec6e48caaa 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1727,9 +1727,113 @@ static void rtase_get_mac_address(struct net_device *dev)
 	rtase_rar_set(tp, dev->dev_addr);
 }
 
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
+	.get_ethtool_stats = rtase_get_ethtool_stats,
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static void rtase_init_netdev_ops(struct net_device *dev)
 {
 	dev->netdev_ops = &rtase_netdev_ops;
+	dev->ethtool_ops = &rtase_ethtool_ops;
 }
 
 static void rtase_reset_interrupt(struct pci_dev *pdev,
-- 
2.34.1


