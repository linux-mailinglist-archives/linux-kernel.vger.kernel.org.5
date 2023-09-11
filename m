Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB8F79A340
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjIKGDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbjIKGDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:03:34 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C1C1B8;
        Sun, 10 Sep 2023 23:02:48 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38B62MV3032449;
        Mon, 11 Sep 2023 01:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694412142;
        bh=PqCk36zd1ArgBmbJorVXLrlQP4/2RI28rsxTy1PC71k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZrXZQ0XY0uOvkyws4MC9H9YpJjPr53n2pow6E4U5CR/yZt6cb9Cf5c1rC7p3N1EV3
         enDQJyeeUOTTjGLNEwpvrhtiLq7O9HXToN1jF64QE+Je7mHiyl/JyR3uI6UaxZudjZ
         smZmVr2HQhS5SzjcDHIKlnFeHFFzkhqcMiujNutY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38B62MqY013088
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 01:02:22 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 01:02:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 01:02:22 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38B62M5u037605;
        Mon, 11 Sep 2023 01:02:22 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.199])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 38B62LkV000534;
        Mon, 11 Sep 2023 01:02:22 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Simon Horman <horms@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net-next v2 2/2] net: ti: icssg-prueth: Add support for half duplex operation
Date:   Mon, 11 Sep 2023 11:32:00 +0530
Message-ID: <20230911060200.2164771-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911060200.2164771-1-danishanwar@ti.com>
References: <20230911060200.2164771-1-danishanwar@ti.com>
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_config.c | 14 ++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 17 +++++++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 ++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index 933b84666574..c1da70f247d4 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -433,6 +433,17 @@ int emac_set_port_state(struct prueth_emac *emac,
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
@@ -453,5 +464,8 @@ void icssg_config_set_speed(struct prueth_emac *emac)
 		return;
 	}
 
+	if (emac->duplex == DUPLEX_HALF)
+		fw_speed |= FW_LINK_SPEED_HD;
+
 	writeb(fw_speed, emac->dram.va + PORT_LINK_SPEED_OFFSET);
 }
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 410612f43cbd..e736652567cd 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1029,6 +1029,8 @@ static void emac_adjust_link(struct net_device *ndev)
 		 * values
 		 */
 		if (emac->link) {
+			if (emac->duplex == DUPLEX_HALF)
+				icssg_config_half_duplex(emac);
 			/* Set the RGMII cfg for gig en and full duplex */
 			icssg_update_rgmii_cfg(prueth->miig_rt, emac);
 
@@ -1147,9 +1149,13 @@ static int emac_phy_connect(struct prueth_emac *emac)
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
@@ -2113,6 +2119,10 @@ static int prueth_probe(struct platform_device *pdev)
 				      eth0_node->name);
 			goto exit_iep;
 		}
+
+		if (of_find_property(eth0_node, "ti,half-duplex-capable", NULL))
+			prueth->emac[PRUETH_MAC0]->half_duplex = 1;
+
 		prueth->emac[PRUETH_MAC0]->iep = prueth->iep0;
 	}
 
@@ -2124,6 +2134,9 @@ static int prueth_probe(struct platform_device *pdev)
 			goto netdev_exit;
 		}
 
+		if (of_find_property(eth1_node, "ti,half-duplex-capable", NULL))
+			prueth->emac[PRUETH_MAC1]->half_duplex = 1;
+
 		prueth->emac[PRUETH_MAC1]->iep = prueth->iep0;
 	}
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 3fe80a8758d3..8b6d6b497010 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -145,6 +145,7 @@ struct prueth_emac {
 	struct icss_iep *iep;
 	unsigned int rx_ts_enabled : 1;
 	unsigned int tx_ts_enabled : 1;
+	unsigned int half_duplex : 1;
 
 	/* DMA related */
 	struct prueth_tx_chn tx_chns[PRUETH_MAX_TX_QUEUES];
@@ -271,6 +272,7 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac,
 int emac_set_port_state(struct prueth_emac *emac,
 			enum icssg_port_state_cmd state);
 void icssg_config_set_speed(struct prueth_emac *emac);
+void icssg_config_half_duplex(struct prueth_emac *emac);
 
 /* Buffer queue helpers */
 int icssg_queue_pop(struct prueth *prueth, u8 queue);
-- 
2.34.1

