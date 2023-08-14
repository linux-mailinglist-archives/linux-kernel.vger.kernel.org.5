Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6EE77B611
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbjHNKJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbjHNKJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:09:45 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE0EE6E;
        Mon, 14 Aug 2023 03:09:43 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37EA9Sfo079416;
        Mon, 14 Aug 2023 05:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692007768;
        bh=iA6Uz4Oqgz9X1gDFeDPaXxk9fTRruHqI/MaGWn7FXww=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RK72CML3kmsk5H8Peyy8OwPjUc0hGe3GDZat8r3vqpDwtjUWUVXE3ClwnEo8t8wN3
         m91/wRY4j7v5JnkIVItSs2JToEhuAE3/OCu4idBF8g7ov8wtGQnJ9t16g5AxSCC0Pu
         Yiv2gQ862CsaiRnfbIDJEr1sj9tGo9Gre6NVtlYM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37EA9SXr031148
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Aug 2023 05:09:28 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Aug 2023 05:09:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Aug 2023 05:09:27 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37EA9R7a023910;
        Mon, 14 Aug 2023 05:09:28 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 37EA9R5F020145;
        Mon, 14 Aug 2023 05:09:27 -0500
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
Subject: [PATCH v4 5/5] net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support
Date:   Mon, 14 Aug 2023 15:38:47 +0530
Message-ID: <20230814100847.3531480-6-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814100847.3531480-1-danishanwar@ti.com>
References: <20230814100847.3531480-1-danishanwar@ti.com>
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

From: Grygorii Strashko <grygorii.strashko@ti.com>

For AM65x SR2.0 it's required to enable IEP1 in raw 64bit mode which is
used by PRU FW to monitor the link and apply w/a for 10M link issue.
Note. No public errata available yet.

Without this w/a the PRU FW will stuck if link state changes under TX
traffic pressure.

Hence, add support for 10M full duplex for AM65x SR2.0:
 - add new IEP API to enable IEP, but without PTP support
 - add pdata quirk_10m_link_issue to enable 10M link issue w/a.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icss_iep.c     | 26 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icss_iep.h     |  2 ++
 drivers/net/ethernet/ti/icssg/icssg_config.c |  7 +++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 27 ++++++++++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 ++
 5 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index d123b8ba3f31..0a34d42ea56d 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -709,6 +709,32 @@ void icss_iep_put(struct icss_iep *iep)
 }
 EXPORT_SYMBOL_GPL(icss_iep_put);
 
+void icss_iep_init_fw(struct icss_iep *iep)
+{
+	/* start IEP for FW use in raw 64bit mode, no PTP support */
+	iep->clk_tick_time = iep->def_inc;
+	iep->cycle_time_ns = 0;
+	iep->ops = NULL;
+	iep->clockops_data = NULL;
+	icss_iep_set_default_inc(iep, iep->def_inc);
+	icss_iep_set_compensation_inc(iep, iep->def_inc);
+	icss_iep_set_compensation_count(iep, 0);
+	regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG, iep->refclk_freq / 10); /* 100 ms pulse */
+	regmap_write(iep->map, ICSS_IEP_SYNC0_PERIOD_REG, 0);
+	if (iep->plat_data->flags & ICSS_IEP_SLOW_COMPEN_REG_SUPPORT)
+		icss_iep_set_slow_compensation_count(iep, 0);
+
+	icss_iep_enable(iep);
+	icss_iep_settime(iep, 0);
+}
+EXPORT_SYMBOL_GPL(icss_iep_init_fw);
+
+void icss_iep_exit_fw(struct icss_iep *iep)
+{
+	icss_iep_disable(iep);
+}
+EXPORT_SYMBOL_GPL(icss_iep_exit_fw);
+
 int icss_iep_init(struct icss_iep *iep, const struct icss_iep_clockops *clkops,
 		  void *clockops_data, u32 cycle_time_ns)
 {
diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.h b/drivers/net/ethernet/ti/icssg/icss_iep.h
index 9c7f4d0a0916..803a4b714893 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.h
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.h
@@ -35,5 +35,7 @@ int icss_iep_exit(struct icss_iep *iep);
 int icss_iep_get_count_low(struct icss_iep *iep);
 int icss_iep_get_count_hi(struct icss_iep *iep);
 int icss_iep_get_ptp_clock_idx(struct icss_iep *iep);
+void icss_iep_init_fw(struct icss_iep *iep);
+void icss_iep_exit_fw(struct icss_iep *iep);
 
 #endif /* __NET_TI_ICSS_IEP_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index ab648d3efe85..933b84666574 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -210,6 +210,10 @@ void icssg_config_ipg(struct prueth_emac *emac)
 	case SPEED_100:
 		icssg_mii_update_ipg(prueth->mii_rt, slice, MII_RT_TX_IPG_100M);
 		break;
+	case SPEED_10:
+		/* IPG for 10M is same as 100M */
+		icssg_mii_update_ipg(prueth->mii_rt, slice, MII_RT_TX_IPG_100M);
+		break;
 	default:
 		/* Other links speeds not supported */
 		netdev_err(emac->ndev, "Unsupported link speed\n");
@@ -440,6 +444,9 @@ void icssg_config_set_speed(struct prueth_emac *emac)
 	case SPEED_100:
 		fw_speed = FW_LINK_SPEED_100M;
 		break;
+	case SPEED_10:
+		fw_speed = FW_LINK_SPEED_10M;
+		break;
 	default:
 		/* Other links speeds not supported */
 		netdev_err(emac->ndev, "Unsupported link speed\n");
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 1bcb4e174652..410612f43cbd 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1149,7 +1149,6 @@ static int emac_phy_connect(struct prueth_emac *emac)
 
 	/* remove unsupported modes */
 	phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
-	phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_10baseT_Full_BIT);
 	phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
 	phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
 	phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_Pause_BIT);
@@ -2090,13 +2089,29 @@ static int prueth_probe(struct platform_device *pdev)
 		goto free_pool;
 	}
 
+	prueth->iep1 = icss_iep_get_idx(np, 1);
+	if (IS_ERR(prueth->iep1)) {
+		ret = dev_err_probe(dev, PTR_ERR(prueth->iep1), "iep1 get failed\n");
+		icss_iep_put(prueth->iep0);
+		prueth->iep0 = NULL;
+		prueth->iep1 = NULL;
+		goto free_pool;
+	}
+
+	if (prueth->pdata.quirk_10m_link_issue) {
+		/* Enable IEP1 for FW in 64bit mode as W/A for 10M FD link detect issue under TX
+		 * traffic.
+		 */
+		icss_iep_init_fw(prueth->iep1);
+	}
+
 	/* setup netdev interfaces */
 	if (eth0_node) {
 		ret = prueth_netdev_init(prueth, eth0_node);
 		if (ret) {
 			dev_err_probe(dev, ret, "netdev init %s failed\n",
 				      eth0_node->name);
-			goto netdev_exit;
+			goto exit_iep;
 		}
 		prueth->emac[PRUETH_MAC0]->iep = prueth->iep0;
 	}
@@ -2167,6 +2182,10 @@ static int prueth_probe(struct platform_device *pdev)
 		prueth_netdev_exit(prueth, eth_node);
 	}
 
+exit_iep:
+	if (prueth->pdata.quirk_10m_link_issue)
+		icss_iep_exit_fw(prueth->iep1);
+
 free_pool:
 	gen_pool_free(prueth->sram_pool,
 		      (unsigned long)prueth->msmcram.va, msmc_ram_size);
@@ -2212,6 +2231,10 @@ static void prueth_remove(struct platform_device *pdev)
 		prueth_netdev_exit(prueth, eth_node);
 	}
 
+	if (prueth->pdata.quirk_10m_link_issue)
+		icss_iep_exit_fw(prueth->iep1);
+
+	icss_iep_put(prueth->iep1);
 	icss_iep_put(prueth->iep0);
 
 	gen_pool_free(prueth->sram_pool,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index a56ab4cdc83c..3fe80a8758d3 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -208,6 +208,7 @@ struct prueth_pdata {
  * @icssg_hwcmdseq: seq counter or HWQ messages
  * @emacs_initialized: num of EMACs/ext ports that are up/running
  * @iep0: pointer to IEP0 device
+ * @iep1: pointer to IEP1 device
  */
 struct prueth {
 	struct device *dev;
@@ -231,6 +232,7 @@ struct prueth {
 	u8 icssg_hwcmdseq;
 	int emacs_initialized;
 	struct icss_iep *iep0;
+	struct icss_iep *iep1;
 };
 
 struct emac_tx_ts_response {
-- 
2.34.1

