Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA9F76ACB2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjHAJSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjHAJRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:17:22 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B622D62;
        Tue,  1 Aug 2023 02:16:25 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3719FZvc108833;
        Tue, 1 Aug 2023 04:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690881336;
        bh=EFDFk87oVlFhcFQ+5H/WjSa49Fd1HcInG8fv/JhX5/U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fGh7ZFegKzPjzJYcIkRECLBq9gV8jJW5TLf5X5ViJshfn+PayZNmDbKFgASgSwKNh
         14xFPOKWVHQehzK53G9+bIlNOCK8zDOzlk/rVUjCZWBCSfsUfmfSEN4qZ5tnIuHi6Q
         OBlN+sTtXn3JiyLALoF4z1vj9oshvJuO2uleigwQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3719FZww111120
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 04:15:35 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 04:15:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Aug 2023 04:15:35 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3719FZ01110072;
        Tue, 1 Aug 2023 04:15:35 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3719FYDq019795;
        Tue, 1 Aug 2023 04:15:35 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v13 09/10] net: ti: icssg-prueth: Add ethtool ops for ICSSG Ethernet driver
Date:   Tue, 1 Aug 2023 14:44:27 +0530
Message-ID: <20230801091428.1359979-10-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801091428.1359979-1-danishanwar@ti.com>
References: <20230801091428.1359979-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add icssg_ethtool.c file. This file will be used for dumping statistics
via ethtool for ICSSG ethernet driver.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/Makefile              |   1 +
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 188 ++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   1 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   3 +
 4 files changed, 193 insertions(+)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_ethtool.c

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 03d9b2b36b5f..9176d79c36e1 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -37,3 +37,4 @@ icssg-prueth-y := k3-cppi-desc-pool.o \
 		  icssg/icssg_config.o \
 		  icssg/icssg_mii_cfg.o \
 		  icssg/icssg_stats.o \
+		  icssg/icssg_ethtool.o
diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
new file mode 100644
index 000000000000..02c312f01d10
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments ICSSG Ethernet driver
+ *
+ * Copyright (C) 2018-2022 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#include "icssg_prueth.h"
+#include "icssg_stats.h"
+
+static void emac_get_drvinfo(struct net_device *ndev,
+			     struct ethtool_drvinfo *info)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+
+	strscpy(info->driver, dev_driver_string(prueth->dev),
+		sizeof(info->driver));
+	strscpy(info->bus_info, dev_name(prueth->dev), sizeof(info->bus_info));
+}
+
+static u32 emac_get_msglevel(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	return emac->msg_enable;
+}
+
+static void emac_set_msglevel(struct net_device *ndev, u32 value)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	emac->msg_enable = value;
+}
+
+static int emac_get_link_ksettings(struct net_device *ndev,
+				   struct ethtool_link_ksettings *ecmd)
+{
+	return phy_ethtool_get_link_ksettings(ndev, ecmd);
+}
+
+static int emac_set_link_ksettings(struct net_device *ndev,
+				   const struct ethtool_link_ksettings *ecmd)
+{
+	return phy_ethtool_set_link_ksettings(ndev, ecmd);
+}
+
+static int emac_get_eee(struct net_device *ndev, struct ethtool_eee *edata)
+{
+	if (!ndev->phydev)
+		return -EOPNOTSUPP;
+
+	return phy_ethtool_get_eee(ndev->phydev, edata);
+}
+
+static int emac_set_eee(struct net_device *ndev, struct ethtool_eee *edata)
+{
+	if (!ndev->phydev)
+		return -EOPNOTSUPP;
+
+	return phy_ethtool_set_eee(ndev->phydev, edata);
+}
+
+static int emac_nway_reset(struct net_device *ndev)
+{
+	return phy_ethtool_nway_reset(ndev);
+}
+
+static int emac_get_sset_count(struct net_device *ndev, int stringset)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		return ICSSG_NUM_ETHTOOL_STATS;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void emac_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
+{
+	u8 *p = data;
+	int i;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++) {
+			if (!icssg_all_stats[i].standard_stats) {
+				memcpy(p, icssg_all_stats[i].name,
+				       ETH_GSTRING_LEN);
+				p += ETH_GSTRING_LEN;
+			}
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+static void emac_get_ethtool_stats(struct net_device *ndev,
+				   struct ethtool_stats *stats, u64 *data)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int i;
+
+	emac_update_hardware_stats(emac);
+
+	for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++)
+		if (!icssg_all_stats[i].standard_stats)
+			*(data++) = emac->stats[i];
+}
+
+static int emac_set_channels(struct net_device *ndev,
+			     struct ethtool_channels *ch)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	/* Check if interface is up. Can change the num queues when
+	 * the interface is down.
+	 */
+	if (netif_running(emac->ndev))
+		return -EBUSY;
+
+	emac->tx_ch_num = ch->tx_count;
+
+	return 0;
+}
+
+static void emac_get_channels(struct net_device *ndev,
+			      struct ethtool_channels *ch)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	ch->max_rx = 1;
+	ch->max_tx = PRUETH_MAX_TX_QUEUES;
+	ch->rx_count = 1;
+	ch->tx_count = emac->tx_ch_num;
+}
+
+static const struct ethtool_rmon_hist_range emac_rmon_ranges[] = {
+	{    0,   64},
+	{   65,  128},
+	{  129,  256},
+	{  257,  512},
+	{  513, PRUETH_MAX_PKT_SIZE},
+	{}
+};
+
+static void emac_get_rmon_stats(struct net_device *ndev,
+				struct ethtool_rmon_stats *rmon_stats,
+				const struct ethtool_rmon_hist_range **ranges)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	*ranges = emac_rmon_ranges;
+
+	rmon_stats->undersize_pkts = emac_get_stat_by_name(emac, "rx_bucket1_frames") -
+				     emac_get_stat_by_name(emac, "rx_64B_frames");
+
+	rmon_stats->hist[0] = emac_get_stat_by_name(emac, "rx_bucket1_frames");
+	rmon_stats->hist[1] = emac_get_stat_by_name(emac, "rx_bucket2_frames");
+	rmon_stats->hist[2] = emac_get_stat_by_name(emac, "rx_bucket3_frames");
+	rmon_stats->hist[3] = emac_get_stat_by_name(emac, "rx_bucket4_frames");
+	rmon_stats->hist[4] = emac_get_stat_by_name(emac, "rx_bucket5_frames");
+
+	rmon_stats->hist_tx[0] = emac_get_stat_by_name(emac, "tx_bucket1_frames");
+	rmon_stats->hist_tx[1] = emac_get_stat_by_name(emac, "tx_bucket2_frames");
+	rmon_stats->hist_tx[2] = emac_get_stat_by_name(emac, "tx_bucket3_frames");
+	rmon_stats->hist_tx[3] = emac_get_stat_by_name(emac, "tx_bucket4_frames");
+	rmon_stats->hist_tx[4] = emac_get_stat_by_name(emac, "tx_bucket5_frames");
+}
+
+const struct ethtool_ops icssg_ethtool_ops = {
+	.get_drvinfo = emac_get_drvinfo,
+	.get_msglevel = emac_get_msglevel,
+	.set_msglevel = emac_set_msglevel,
+	.get_sset_count = emac_get_sset_count,
+	.get_ethtool_stats = emac_get_ethtool_stats,
+	.get_strings = emac_get_strings,
+	.get_channels = emac_get_channels,
+	.set_channels = emac_set_channels,
+	.get_link_ksettings = emac_get_link_ksettings,
+	.set_link_ksettings = emac_set_link_ksettings,
+	.get_link = ethtool_op_get_link,
+	.get_eee = emac_get_eee,
+	.set_eee = emac_set_eee,
+	.nway_reset = emac_nway_reset,
+	.get_rmon_stats = emac_get_rmon_stats,
+};
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index e641b6ce9415..80721d82f6c5 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1421,6 +1421,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 	ndev->min_mtu = PRUETH_MIN_PKT_SIZE;
 	ndev->max_mtu = PRUETH_MAX_MTU;
 	ndev->netdev_ops = &emac_netdev_ops;
+	ndev->ethtool_ops = &icssg_ethtool_ops;
 	ndev->hw_features = NETIF_F_SG;
 	ndev->features = ndev->hw_features;
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index e58cd8db7ba0..a8ce4d01ef16 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -52,6 +52,7 @@
 /* Number of ICSSG related stats */
 #define ICSSG_NUM_STATS 60
 #define ICSSG_NUM_STANDARD_STATS 31
+#define ICSSG_NUM_ETHTOOL_STATS (ICSSG_NUM_STATS - ICSSG_NUM_STANDARD_STATS)
 
 /* Firmware status codes */
 #define ICSS_HS_FW_READY 0x55555555
@@ -230,6 +231,8 @@ static inline int prueth_emac_slice(struct prueth_emac *emac)
 	}
 }
 
+extern const struct ethtool_ops icssg_ethtool_ops;
+
 /* Classifier helpers */
 void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac);
 void icssg_class_set_host_mac_addr(struct regmap *miig_rt, const u8 *mac);
-- 
2.34.1

