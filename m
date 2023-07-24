Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B4B75F518
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjGXLcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjGXLbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:31:43 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46B919AB;
        Mon, 24 Jul 2023 04:31:09 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36OBUb9Q072080;
        Mon, 24 Jul 2023 06:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690198237;
        bh=4VlwOUd0+FkSANQ+QF8KHv0L0Q9NfaBIxt05nQpl3bM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uqj/ICk6AyIaVTsW+dBnb/OmawBoliwatmjhEoICNBl9XyXBa6GHl+XBnoh+xt506
         tmF9YayDJ4j5uRbBW4+Nie1hZ+k+/slE6hwDpycVyw1p59ZnW4TrZhjDpYIcwEmUDC
         vFmkdnxDsxMsarqsFHIq1HrOzVtRsg63nLAjTlPs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36OBUbuv023352
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jul 2023 06:30:37 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jul 2023 06:30:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jul 2023 06:30:37 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36OBUbkc018935;
        Mon, 24 Jul 2023 06:30:37 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 36OBUaKc007675;
        Mon, 24 Jul 2023 06:30:36 -0500
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
Subject: [PATCH v11 08/10] net: ti: icssg-prueth: Add Standard network staticstics
Date:   Mon, 24 Jul 2023 16:59:32 +0530
Message-ID: <20230724112934.2637802-9-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724112934.2637802-1-danishanwar@ti.com>
References: <20230724112934.2637802-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement .ndo_get_stats64 to dump standard network interface
statistics for ICSSG ethernet driver.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg_prueth.c | 21 +++++++++++++++++++++
 drivers/net/ethernet/ti/icssg_prueth.h |  2 ++
 drivers/net/ethernet/ti/icssg_stats.c  | 13 +++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg_prueth.c b/drivers/net/ethernet/ti/icssg_prueth.c
index a60e0f98f425..45fa271dd014 100644
--- a/drivers/net/ethernet/ti/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg_prueth.c
@@ -1260,6 +1260,26 @@ static int emac_ndo_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
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
@@ -1269,6 +1289,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_tx_timeout = emac_ndo_tx_timeout,
 	.ndo_set_rx_mode = emac_ndo_set_rx_mode,
 	.ndo_eth_ioctl = emac_ndo_ioctl,
+	.ndo_get_stats64 = emac_ndo_get_stats64,
 };
 
 /* get emac_port corresponding to eth_node name */
diff --git a/drivers/net/ethernet/ti/icssg_prueth.h b/drivers/net/ethernet/ti/icssg_prueth.h
index 355bbbbd6888..b3c7b4e0b2b7 100644
--- a/drivers/net/ethernet/ti/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg_prueth.h
@@ -47,6 +47,7 @@
 
 /* Number of ICSSG related stats */
 #define ICSSG_NUM_STATS 60
+#define ICSSG_NUM_STANDARD_STATS 6
 
 /* Firmware status codes */
 #define ICSS_HS_FW_READY 0x55555555
@@ -251,4 +252,5 @@ void icssg_config_set_speed(struct prueth_emac *emac);
 
 void emac_stats_work_handler(struct work_struct *work);
 void emac_update_hardware_stats(struct prueth_emac *emac);
+int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
 #endif /* __NET_TI_ICSSG_PRUETH_H */
diff --git a/drivers/net/ethernet/ti/icssg_stats.c b/drivers/net/ethernet/ti/icssg_stats.c
index 25deb368a3f0..bb0b33927e3b 100644
--- a/drivers/net/ethernet/ti/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg_stats.c
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

