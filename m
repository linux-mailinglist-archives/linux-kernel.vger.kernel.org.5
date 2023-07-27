Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C25C765263
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjG0Lae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjG0LaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:30:23 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F1D35BF;
        Thu, 27 Jul 2023 04:30:02 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36RBTS2q119183;
        Thu, 27 Jul 2023 06:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690457368;
        bh=7Utm4F15aZgg90XqeSzYnnyLrRWHIRnHF8JlWQv6/rI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AebL+SFIBFiUjyK3sNmOvKZsi08Fu7ovIdtBkDHfh5jyeRFoN3bXaIZY5xYM9Gg9/
         zSVNtQX7OwVMlM/FXcD+2d+bvcYqpPNcQwTvCWx2OqTM0JgqVS+wXB13nH4hvG3MZY
         T8j6VlCYvF95W+bZ4OjiQ+Bd0SYziK37atagO3W4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36RBTSIt105260
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jul 2023 06:29:28 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jul 2023 06:29:27 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jul 2023 06:29:27 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36RBTR4G094410;
        Thu, 27 Jul 2023 06:29:27 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 36RBTQ9a001439;
        Thu, 27 Jul 2023 06:29:27 -0500
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
Subject: [PATCH v12 08/10] net: ti: icssg-prueth: Add Standard network staticstics
Date:   Thu, 27 Jul 2023 16:58:25 +0530
Message-ID: <20230727112827.3977534-9-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727112827.3977534-1-danishanwar@ti.com>
References: <20230727112827.3977534-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement .ndo_get_stats64 to dump standard network interface
statistics for ICSSG ethernet driver.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 22 ++++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 ++
 drivers/net/ethernet/ti/icssg/icssg_stats.c  | 13 ++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 3d36f2a79fc8..8a12d3b1ac1f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1244,6 +1244,27 @@ static int emac_ndo_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
 	return phy_do_ioctl(ndev, ifr, cmd);
 }
 
+static void emac_ndo_get_stats64(struct net_device *ndev,
+				 struct rtnl_link_stats64 *stats)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	emac_update_hardware_stats(emac);
+
+	stats->rx_packets     = emac_get_stat_by_name(emac, "rx_packets");
+	stats->rx_bytes       = emac_get_stat_by_name(emac, "rx_bytes");
+	stats->tx_packets     = emac_get_stat_by_name(emac, "tx_packets");
+	stats->tx_bytes       = emac_get_stat_by_name(emac, "tx_bytes");
+	stats->rx_crc_errors  = emac_get_stat_by_name(emac, "rx_crc_errors");
+	stats->rx_over_errors = emac_get_stat_by_name(emac, "rx_over_errors");
+	stats->multicast      = emac_get_stat_by_name(emac, "rx_multicast_frames");
+
+	stats->rx_errors  = ndev->stats.rx_errors;
+	stats->rx_dropped = ndev->stats.rx_dropped;
+	stats->tx_errors  = ndev->stats.tx_errors;
+	stats->tx_dropped = ndev->stats.tx_dropped;
+}
+
 static const struct net_device_ops emac_netdev_ops = {
 	.ndo_open = emac_ndo_open,
 	.ndo_stop = emac_ndo_stop,
@@ -1253,6 +1274,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_tx_timeout = emac_ndo_tx_timeout,
 	.ndo_set_rx_mode = emac_ndo_set_rx_mode,
 	.ndo_eth_ioctl = emac_ndo_ioctl,
+	.ndo_get_stats64 = emac_ndo_get_stats64,
 };
 
 /* get emac_port corresponding to eth_node name */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index bbde423ec51d..f0db3558b7a8 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -51,6 +51,7 @@
 
 /* Number of ICSSG related stats */
 #define ICSSG_NUM_STATS 60
+#define ICSSG_NUM_STANDARD_STATS 31
 
 /* Firmware status codes */
 #define ICSS_HS_FW_READY 0x55555555
@@ -254,4 +255,5 @@ void icssg_config_set_speed(struct prueth_emac *emac);
 
 void emac_stats_work_handler(struct work_struct *work);
 void emac_update_hardware_stats(struct prueth_emac *emac);
+int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
 #endif /* __NET_TI_ICSSG_PRUETH_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 25deb368a3f0..bb0b33927e3b 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -42,3 +42,16 @@ void emac_stats_work_handler(struct work_struct *work)
 	queue_delayed_work(system_long_wq, &emac->stats_work,
 			   msecs_to_jiffies((STATS_TIME_LIMIT_1G_MS * 1000) / emac->speed));
 }
+
+int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++) {
+		if (!strcmp(icssg_all_stats[i].name, stat_name))
+			return emac->stats[icssg_all_stats[i].offset / sizeof(u32)];
+	}
+
+	netdev_err(emac->ndev, "Invalid stats %s\n", stat_name);
+	return -EINVAL;
+}
-- 
2.34.1

