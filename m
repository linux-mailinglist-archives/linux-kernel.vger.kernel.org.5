Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33C078D8EE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjH3SbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243703AbjH3LcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:32:12 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748251BB;
        Wed, 30 Aug 2023 04:32:08 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37UBVsOq066456;
        Wed, 30 Aug 2023 06:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693395114;
        bh=D3DF7bFRaHneyzCISsMhUq3IavR7ujFPxdncVi54Hus=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KoQyTC70Jl1uILsy/3o6LjgdXKliI1MXWBftIn10x/jWKY/lqOTVW4FSoQx4fPYsD
         Pst5tbYCIpBbeV7CvwgixrEK+FZwKQrBBMat7Vkf3GXzeE1nUwwT3Hl+0B/awAcJba
         bb+4slrd9ara5sd7xp1ueYxeY4hR31fLdtbADHq4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37UBVsIZ037763
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Aug 2023 06:31:54 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Aug 2023 06:31:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Aug 2023 06:31:54 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37UBVsgi073006;
        Wed, 30 Aug 2023 06:31:54 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.35])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 37UBVri9000676;
        Wed, 30 Aug 2023 06:31:54 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH net-next 2/2] net: ti: icssg-prueth: Add support for half duplex operation
Date:   Wed, 30 Aug 2023 17:01:34 +0530
Message-ID: <20230830113134.1226970-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830113134.1226970-1-danishanwar@ti.com>
References: <20230830113134.1226970-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for half duplex operation at 10M and 100M link
speeds for AM654x/AM64x devices.
- Driver configures rand_seed, a random number, in DMEM HD_RAND_SEED_OFFSET
field, which will be used by firmware for Back off time calculation.
- Driver informs FW about half duplex link operation in DMEM
PORT_LINK_SPEED_OFFSET field by setting bit 7 for 10/100M HD.

Hence, the half duplex operation depends on board design the
"ti,half-duplex-capable" property has to be enabled for ICSS-G ports if HW
is capable to perform half duplex.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_config.c | 14 ++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 17 +++++++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 ++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index 03968dbc2d62..b676d200ee90 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -540,6 +540,17 @@ int emac_set_port_state(struct prueth_emac *emac,
 	return ret;
 }
 
+void icssg_config_half_duplex(struct prueth_emac *emac)
+{
+	u32 val;
+
+	if (!emac->half_duplex)
+		return;
+
+	val = get_random_u32();
+	writel(val, emac->dram.va + HD_RAND_SEED_OFFSET);
+}
+
 void icssg_config_set_speed(struct prueth_emac *emac)
 {
 	u8 fw_speed;
@@ -560,6 +571,9 @@ void icssg_config_set_speed(struct prueth_emac *emac)
 		return;
 	}
 
+	if (emac->duplex == DUPLEX_HALF)
+		fw_speed |= FW_LINK_SPEED_HD;
+
 	writeb(fw_speed, emac->dram.va + PORT_LINK_SPEED_OFFSET);
 }
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index c2d1d0c7deb0..00e1e286e351 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1048,6 +1048,8 @@ static void emac_adjust_link(struct net_device *ndev)
 		 * values
 		 */
 		if (emac->link) {
+			if (emac->duplex == DUPLEX_HALF)
+				icssg_config_half_duplex(emac);
 			/* Set the RGMII cfg for gig en and full duplex */
 			icssg_update_rgmii_cfg(prueth->miig_rt, emac);
 
@@ -1166,9 +1168,13 @@ static int emac_phy_connect(struct prueth_emac *emac)
 		return -ENODEV;
 	}
 
+	if (!emac->half_duplex) {
+		dev_dbg(prueth->dev, "half duplex mode is not supported\n");
+		phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
+		phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
+	}
+
 	/* remove unsupported modes */
-	phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
-	phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
 	phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
 	phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_Pause_BIT);
 	phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_Asym_Pause_BIT);
@@ -2454,6 +2460,10 @@ static int prueth_probe(struct platform_device *pdev)
 				      eth0_node->name);
 			goto exit_iep;
 		}
+
+		if (of_find_property(eth0_node, "ti,half-duplex-capable", NULL))
+			prueth->emac[PRUETH_MAC0]->half_duplex = 1;
+
 		prueth->emac[PRUETH_MAC0]->iep = prueth->iep0;
 	}
 
@@ -2465,6 +2475,9 @@ static int prueth_probe(struct platform_device *pdev)
 			goto netdev_exit;
 		}
 
+		if (of_find_property(eth1_node, "ti,half-duplex-capable", NULL))
+			prueth->emac[PRUETH_MAC1]->half_duplex = 1;
+
 		prueth->emac[PRUETH_MAC1]->iep = prueth->iep0;
 	}
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 43b67213d8c7..6854ba4253c6 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -155,6 +155,7 @@ struct prueth_emac {
 	struct icss_iep *iep;
 	unsigned int rx_ts_enabled : 1;
 	unsigned int tx_ts_enabled : 1;
+	unsigned int half_duplex : 1;
 
 	/* DMA related */
 	struct prueth_tx_chn tx_chns[PRUETH_MAX_TX_QUEUES];
@@ -313,6 +314,7 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac,
 int emac_set_port_state(struct prueth_emac *emac,
 			enum icssg_port_state_cmd state);
 void icssg_config_set_speed(struct prueth_emac *emac);
+void icssg_config_half_duplex(struct prueth_emac *emac);
 
 /* Buffer queue helpers */
 int icssg_queue_pop(struct prueth *prueth, u8 queue);
-- 
2.34.1

