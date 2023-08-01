Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37CD76ACBA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjHAJSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjHAJRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:17:22 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B67A2D5E;
        Tue,  1 Aug 2023 02:16:24 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3719FTHr066632;
        Tue, 1 Aug 2023 04:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690881329;
        bh=D1CcCO+65kcFZlzN7D6IREUZG8NKmZVlIsGYX6dMBMM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nzH2ESRE1l0XYWM0y1dFt54ezW2nsnrA2pW994PmBydyBR+4yiSaaF3u1Gkt3Dcii
         aHFSgMXm/fa2Hycax0AuZWRxVE9zOXFz81SAUQ4o0FXZUvuc33BllkXQEjcWlspb6g
         5JnuYznFIEDBmyUdjWwp0enF7HwFwy2cP6nG8WLg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3719FTx2086288
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 04:15:29 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 04:15:28 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Aug 2023 04:15:28 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3719FSac046457;
        Tue, 1 Aug 2023 04:15:28 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3719FSdX019784;
        Tue, 1 Aug 2023 04:15:28 -0500
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
Subject: [PATCH v13 08/10] net: ti: icssg-prueth: Add Standard network staticstics
Date:   Tue, 1 Aug 2023 14:44:26 +0530
Message-ID: <20230801091428.1359979-9-danishanwar@ti.com>
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

Implement .ndo_get_stats64 to dump standard network interface
statistics for ICSSG ethernet driver.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 22 ++++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 ++
 drivers/net/ethernet/ti/icssg/icssg_stats.c  | 13 ++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index d0bb4db11b30..e641b6ce9415 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1240,6 +1240,27 @@ static int emac_ndo_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
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
@@ -1249,6 +1270,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_tx_timeout = emac_ndo_tx_timeout,
 	.ndo_set_rx_mode = emac_ndo_set_rx_mode,
 	.ndo_eth_ioctl = emac_ndo_ioctl,
+	.ndo_get_stats64 = emac_ndo_get_stats64,
 };
 
 /* get emac_port corresponding to eth_node name */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index f13de0d2e90b..e58cd8db7ba0 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -51,6 +51,7 @@
 
 /* Number of ICSSG related stats */
 #define ICSSG_NUM_STATS 60
+#define ICSSG_NUM_STANDARD_STATS 31
 
 /* Firmware status codes */
 #define ICSS_HS_FW_READY 0x55555555
@@ -254,4 +255,5 @@ u32 icssg_queue_level(struct prueth *prueth, int queue);
 
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

