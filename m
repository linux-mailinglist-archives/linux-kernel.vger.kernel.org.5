Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76D578DE04
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245321AbjH3S4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243476AbjH3LJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:09:34 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296A5CCF;
        Wed, 30 Aug 2023 04:09:30 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37UB9F9e015796;
        Wed, 30 Aug 2023 06:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693393755;
        bh=3Kusceg2/Ak09Q+6QDm6lZZWVA+vmdFdRu73ikL0gcQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=virapTZf/yq7FXSvXo/yST6NroIpgJ6YL+jt/QaeS3Z4KUbCzacz+dfrN4JmFTcDQ
         s2EJPbl1rCIgPY1t0/mjfjfpPmfIEdoX3WNCQz6L1zbaDSRHOsi2EbUthft1WBagfr
         VZPOP59fLZAtKEc24/mcAeUfj9kL9SYVLFmUXtV8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37UB9Fh7021772
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Aug 2023 06:09:15 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Aug 2023 06:09:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Aug 2023 06:09:14 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37UB9EP6028955;
        Wed, 30 Aug 2023 06:09:14 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.35])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 37UB9Dn7006023;
        Wed, 30 Aug 2023 06:09:14 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Simon Horman <horms@kernel.org>, Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        MD Danish Anwar <danishanwar@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH net-next 3/4] net: ti: icssg-prueth: Add support for ICSSG switch firmware on AM654 PG2.0 EVM
Date:   Wed, 30 Aug 2023 16:38:46 +0530
Message-ID: <20230830110847.1219515-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830110847.1219515-1-danishanwar@ti.com>
References: <20230830110847.1219515-1-danishanwar@ti.com>
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

Add support for ICSSG switch firmware using existing Dual EMAC driver
with switchdev and devlink framework.

Limitations:
VLAN offloading is limited to 0-256 IDs.
MDB/FDB static entries are limited to 511 entries and different FDBs can
hash to same bucket and thus may not completely offloaded

Switch mode requires loading of new firmware into ICSSG cores. This
means interfaces have to taken down and then reconfigured to switch mode
using devlink.

Example assuming ETH1 and ETH2 as ICSSG2 interfaces:

Switch to ICSSG Switch mode:
 ip link set dev eth1 down
 ip link set dev eth2 down
 devlink dev param set platform/icssg2-eth name \
 switch_mode value 1 cmode runtime
 ip link add name br0 type bridge
 ip link set dev eth1 master br0
 ip link set dev eth2 master br0
 ip link set dev br0 up
 ip link set dev eth1 up
 ip link set dev eth2 up
 bridge vlan add dev br0 vid 1 pvid untagged self

Going back to Dual EMAC mode:

 ip link set dev br0 down
 ip link set dev eth1 nomaster
 ip link set dev eth2 nomaster
 ip link set dev eth1 down
 ip link set dev eth2 down
 devlink dev param set platform/icssg2-eth name \
 switch_mode value 0 cmode runtime
 ip link del name br0 type bridge
 ip link set dev eth1 up
 ip link set dev eth2 up

By default, Dual EMAC firmware is loaded, and can be changed to switch
mode by above steps

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/Kconfig               |   1 +
 drivers/net/ethernet/ti/Makefile              |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_config.c  | 129 ++++++-
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   6 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 361 +++++++++++++++++-
 .../net/ethernet/ti/icssg/icssg_switchdev.c   |   2 +-
 6 files changed, 488 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 88b5b1b47779..2e3ef9c092c8 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -188,6 +188,7 @@ config TI_ICSSG_PRUETH
 	select PHYLIB
 	select TI_ICSS_IEP
 	depends on PRU_REMOTEPROC
+	depends on NET_SWITCHDEV
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
 	help
 	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 34fd7a716ba6..3adceff760ce 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -37,5 +37,6 @@ icssg-prueth-y := k3-cppi-desc-pool.o \
 		  icssg/icssg_config.o \
 		  icssg/icssg_mii_cfg.o \
 		  icssg/icssg_stats.o \
-		  icssg/icssg_ethtool.o
+		  icssg/icssg_ethtool.o \
+		  icssg/icssg_switchdev.o
 obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index 3fccdcc20bdb..03968dbc2d62 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -105,28 +105,49 @@ static const struct map hwq_map[2][ICSSG_NUM_OTHER_QUEUES] = {
 	},
 };
 
+static void icssg_config_mii_init_switch(struct prueth_emac *emac)
+{
+	struct prueth *prueth = emac->prueth;
+	int mii = prueth_emac_slice(emac);
+	u32 txcfg_reg, pcnt_reg, txcfg;
+	struct regmap *mii_rt;
+
+	mii_rt = prueth->mii_rt;
+
+	txcfg_reg = (mii == ICSS_MII0) ? PRUSS_MII_RT_TXCFG0 :
+				       PRUSS_MII_RT_TXCFG1;
+	pcnt_reg = (mii == ICSS_MII0) ? PRUSS_MII_RT_RX_PCNT0 :
+				       PRUSS_MII_RT_RX_PCNT1;
+
+	txcfg = PRUSS_MII_RT_TXCFG_TX_ENABLE |
+		PRUSS_MII_RT_TXCFG_TX_AUTO_PREAMBLE |
+		PRUSS_MII_RT_TXCFG_TX_IPG_WIRE_CLK_EN;
+
+	if (emac->phy_if == PHY_INTERFACE_MODE_MII && mii == ICSS_MII1)
+		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
+	else if (emac->phy_if != PHY_INTERFACE_MODE_MII && mii == ICSS_MII0)
+		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
+
+	regmap_write(mii_rt, txcfg_reg, txcfg);
+	regmap_write(mii_rt, pcnt_reg, 0x1);
+}
+
 static void icssg_config_mii_init(struct prueth_emac *emac)
 {
-	u32 rxcfg, txcfg, rxcfg_reg, txcfg_reg, pcnt_reg;
 	struct prueth *prueth = emac->prueth;
 	int slice = prueth_emac_slice(emac);
+	u32 txcfg, txcfg_reg, pcnt_reg;
 	struct regmap *mii_rt;
 
 	mii_rt = prueth->mii_rt;
 
-	rxcfg_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_RXCFG0 :
-				       PRUSS_MII_RT_RXCFG1;
 	txcfg_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_TXCFG0 :
 				       PRUSS_MII_RT_TXCFG1;
 	pcnt_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_RX_PCNT0 :
 				       PRUSS_MII_RT_RX_PCNT1;
 
-	rxcfg = MII_RXCFG_DEFAULT;
 	txcfg = MII_TXCFG_DEFAULT;
 
-	if (slice == ICSS_MII1)
-		rxcfg |= PRUSS_MII_RT_RXCFG_RX_MUX_SEL;
-
 	/* In MII mode TX lines swapped inside ICSSG, so TX_MUX_SEL cfg need
 	 * to be swapped also comparing to RGMII mode.
 	 */
@@ -135,7 +156,6 @@ static void icssg_config_mii_init(struct prueth_emac *emac)
 	else if (emac->phy_if != PHY_INTERFACE_MODE_MII && slice == ICSS_MII1)
 		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
 
-	regmap_write(mii_rt, rxcfg_reg, rxcfg);
 	regmap_write(mii_rt, txcfg_reg, txcfg);
 	regmap_write(mii_rt, pcnt_reg, 0x1);
 }
@@ -249,6 +269,60 @@ static int emac_r30_is_done(struct prueth_emac *emac)
 	return 1;
 }
 
+static int prueth_switch_buffer_setup(struct prueth_emac *emac)
+{
+	struct icssg_buffer_pool_cfg __iomem *bpool_cfg;
+	struct icssg_rxq_ctx __iomem *rxq_ctx;
+	struct prueth *prueth = emac->prueth;
+	int slice = prueth_emac_slice(emac);
+	u32 addr;
+	int i;
+
+	addr = lower_32_bits(prueth->msmcram.pa);
+	if (slice)
+		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
+
+	if (addr % SZ_64K) {
+		dev_warn(prueth->dev, "buffer pool needs to be 64KB aligned\n");
+		return -EINVAL;
+	}
+
+	bpool_cfg = emac->dram.va + BUFFER_POOL_0_ADDR_OFFSET;
+	/* workaround for f/w bug. bpool 0 needs to be initilalized */
+	for (i = 0; i <  PRUETH_NUM_BUF_POOLS; i++) {
+		writel(addr, &bpool_cfg[i].addr);
+		writel(PRUETH_EMAC_BUF_POOL_SIZE, &bpool_cfg[i].len);
+		addr += PRUETH_EMAC_BUF_POOL_SIZE;
+	}
+
+	if (!slice)
+		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
+	else
+		addr += PRUETH_SW_NUM_BUF_POOLS_HOST * PRUETH_SW_BUF_POOL_SIZE_HOST;
+
+	for (i = PRUETH_NUM_BUF_POOLS;
+	     i <  PRUETH_SW_NUM_BUF_POOLS_HOST + PRUETH_NUM_BUF_POOLS;
+	     i++) {
+		writel(addr, &bpool_cfg[i].addr);
+		writel(PRUETH_SW_BUF_POOL_SIZE_HOST, &bpool_cfg[i].len);
+		addr += PRUETH_SW_BUF_POOL_SIZE_HOST;
+	}
+
+	if (!slice)
+		addr += PRUETH_SW_NUM_BUF_POOLS_HOST * PRUETH_SW_BUF_POOL_SIZE_HOST;
+	else
+		addr += PRUETH_EMAC_RX_CTX_BUF_SIZE;
+
+	rxq_ctx = emac->dram.va + HOST_RX_Q_PRE_CONTEXT_OFFSET;
+	for (i = 0; i < 3; i++)
+		writel(addr, &rxq_ctx->start[i]);
+
+	addr += PRUETH_EMAC_RX_CTX_BUF_SIZE;
+	writel(addr - SZ_2K, &rxq_ctx->end);
+
+	return 0;
+}
+
 static int prueth_emac_buffer_setup(struct prueth_emac *emac)
 {
 	struct icssg_buffer_pool_cfg __iomem *bpool_cfg;
@@ -325,13 +399,40 @@ static void icssg_init_emac_mode(struct prueth *prueth)
 	icssg_class_set_host_mac_addr(prueth->miig_rt, mac);
 }
 
+static void icssg_init_switch_mode(struct prueth *prueth)
+{
+	u32 addr = prueth->shram.pa + EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET;
+	int i;
+
+	if (prueth->emacs_initialized)
+		return;
+
+	/* Set VLAN TABLE address base */
+	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSET_MASK,
+			   addr <<  SMEM_VLAN_OFFSET);
+	/* Set enable VLAN aware mode, and FDBs for all PRUs */
+	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, FDB_EN_ALL);
+	prueth->vlan_tbl = (struct prueth_vlan_tbl __force *)prueth->shram.va +
+			    EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET;
+	for (i = 0; i < SZ_4K - 1; i++) {
+		prueth->vlan_tbl[i].fid = i;
+		prueth->vlan_tbl[i].fid_c1 = 0;
+	}
+
+	icssg_class_set_host_mac_addr(prueth->miig_rt, prueth->hw_bridge_dev->dev_addr);
+	icssg_set_pvid(prueth, prueth->default_vlan, PRUETH_PORT_HOST);
+}
+
 int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 {
 	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
 	struct icssg_flow_cfg __iomem *flow_cfg;
 	int ret;
 
-	icssg_init_emac_mode(prueth);
+	if (prueth->is_switch_mode)
+		icssg_init_switch_mode(prueth);
+	else
+		icssg_init_emac_mode(prueth);
 
 	memset_io(config, 0, TAS_GATE_MASK_LIST0);
 	icssg_miig_queues_init(prueth, slice);
@@ -345,7 +446,10 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 	regmap_update_bits(prueth->miig_rt, ICSSG_CFG_OFFSET,
 			   ICSSG_CFG_DEFAULT, ICSSG_CFG_DEFAULT);
 	icssg_miig_set_interface_mode(prueth->miig_rt, slice, emac->phy_if);
-	icssg_config_mii_init(emac);
+	if (prueth->is_switch_mode)
+		icssg_config_mii_init_switch(emac);
+	else
+		icssg_config_mii_init(emac);
 	icssg_config_ipg(emac);
 	icssg_update_rgmii_cfg(prueth->miig_rt, emac);
 
@@ -368,7 +472,10 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 	writeb(0, config + SPL_PKT_DEFAULT_PRIORITY);
 	writeb(0, config + QUEUE_NUM_UNTAGGED);
 
-	ret = prueth_emac_buffer_setup(emac);
+	if (prueth->is_switch_mode)
+		ret = prueth_switch_buffer_setup(emac);
+	else
+		ret = prueth_emac_buffer_setup(emac);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index 0d5d5d253b7a..09a021078ff5 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -35,6 +35,12 @@ struct icssg_flow_cfg {
 	(2 * (PRUETH_EMAC_BUF_POOL_SIZE * PRUETH_NUM_BUF_POOLS + \
 	 PRUETH_EMAC_RX_CTX_BUF_SIZE * 2))
 
+#define PRUETH_SW_BUF_POOL_SIZE_HOST	SZ_2K
+#define PRUETH_SW_NUM_BUF_POOLS_HOST	16
+#define MSMC_RAM_SIZE_SWITCH_MODE \
+	(MSMC_RAM_SIZE + \
+	(2 * PRUETH_SW_BUF_POOL_SIZE_HOST * PRUETH_SW_NUM_BUF_POOLS_HOST))
+
 #define PRUETH_SWITCH_FDB_MASK ((SIZE_OF_FDB / NUMBER_OF_FDB_BUCKET_ENTRIES) - 1)
 
 struct icssg_rxq_ctx {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index c35fb51f08af..5b7e7297ce23 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -558,6 +558,8 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
 	} else {
 		/* send the filled skb up the n/w stack */
 		skb_put(skb, pkt_len);
+		if (emac->prueth->is_switch_mode)
+			skb->offload_fwd_mark = emac->offload_fwd_mark;
 		skb->protocol = eth_type_trans(skb, ndev);
 		napi_gro_receive(&emac->napi_rx, skb);
 		ndev->stats.rx_bytes += pkt_len;
@@ -890,6 +892,19 @@ struct icssg_firmwares {
 	char *txpru;
 };
 
+static struct icssg_firmwares icssg_switch_firmwares[] = {
+	{
+		.pru = "ti-pruss/am65x-sr2-pru0-prusw-fw.elf",
+		.rtu = "ti-pruss/am65x-sr2-rtu0-prusw-fw.elf",
+		.txpru = "ti-pruss/am65x-sr2-txpru0-prusw-fw.elf",
+	},
+	{
+		.pru = "ti-pruss/am65x-sr2-pru1-prusw-fw.elf",
+		.rtu = "ti-pruss/am65x-sr2-rtu1-prusw-fw.elf",
+		.txpru = "ti-pruss/am65x-sr2-txpru1-prusw-fw.elf",
+	}
+};
+
 static struct icssg_firmwares icssg_emac_firmwares[] = {
 	{
 		.pru = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
@@ -909,7 +924,10 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
 	struct device *dev = prueth->dev;
 	int slice, ret;
 
-	firmwares = icssg_emac_firmwares;
+	if (prueth->is_switch_mode)
+		firmwares = icssg_switch_firmwares;
+	else
+		firmwares = icssg_emac_firmwares;
 
 	slice = prueth_emac_slice(emac);
 	if (slice < 0) {
@@ -1405,6 +1423,19 @@ static int emac_ndo_open(struct net_device *ndev)
 
 	queue_work(system_long_wq, &emac->stats_work.work);
 
+	if (prueth->is_switch_mode) {
+		icssg_fdb_add_del(emac, eth_stp_addr, prueth->default_vlan,
+				  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
+				  ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
+				  ICSSG_FDB_ENTRY_P2_MEMBERSHIP |
+				  ICSSG_FDB_ENTRY_BLOCK,
+				  true);
+		icssg_vtbl_modify(emac, emac->port_vlan, BIT(emac->port_id),
+				  BIT(emac->port_id), true);
+		icssg_set_pvid(emac->prueth, emac->port_vlan, emac->port_id);
+		emac_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
+	}
+
 	return 0;
 
 reset_tx_chan:
@@ -1929,6 +1960,308 @@ static void prueth_put_cores(struct prueth *prueth, int slice)
 		pru_rproc_put(prueth->pru[slice]);
 }
 
+static void prueth_offload_fwd_mark_update(struct prueth *prueth)
+{
+	int set_val = 0;
+	int i;
+
+	if (prueth->br_members == (PRUETH_PORT_MII0 | PRUETH_PORT_MII1))
+		set_val = 1;
+
+	dev_dbg(prueth->dev, "set offload_fwd_mark %d\n", set_val);
+
+	for (i = PRUETH_MAC0; i < PRUETH_NUM_MACS; i++) {
+		struct prueth_emac *emac = prueth->emac[i];
+
+		if (!emac || !emac->ndev)
+			continue;
+
+		emac->offload_fwd_mark = set_val;
+	}
+}
+
+bool prueth_dev_check(const struct net_device *ndev)
+{
+	if (ndev->netdev_ops == &emac_netdev_ops && netif_running(ndev)) {
+		struct prueth_emac *emac = netdev_priv(ndev);
+
+		return emac->prueth->is_switch_mode;
+	}
+
+	return false;
+}
+
+static int prueth_netdevice_port_link(struct net_device *ndev, struct net_device *br_ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+
+	if (!prueth->is_switch_mode)
+		return NOTIFY_DONE;
+
+	if (!prueth->br_members) {
+		prueth->hw_bridge_dev = br_ndev;
+	} else {
+		/* This is adding the port to a second bridge, this is
+		 * unsupported
+		 */
+		if (prueth->hw_bridge_dev != br_ndev)
+			return -EOPNOTSUPP;
+	}
+
+	prueth->br_members |= BIT(emac->port_id);
+
+	prueth_offload_fwd_mark_update(prueth);
+
+	return NOTIFY_DONE;
+}
+
+static void prueth_netdevice_port_unlink(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+
+	prueth->br_members &= ~BIT(emac->port_id);
+
+	prueth_offload_fwd_mark_update(prueth);
+
+	if (!prueth->br_members)
+		prueth->hw_bridge_dev = NULL;
+}
+
+/* netdev notifier */
+static int prueth_netdevice_event(struct notifier_block *unused,
+				  unsigned long event, void *ptr)
+{
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_notifier_changeupper_info *info;
+	int ret = NOTIFY_DONE;
+
+	if (ndev->netdev_ops != &emac_netdev_ops)
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case NETDEV_CHANGEUPPER:
+		info = ptr;
+
+		if (netif_is_bridge_master(info->upper_dev)) {
+			if (info->linking)
+				ret = prueth_netdevice_port_link(ndev, info->upper_dev);
+			else
+				prueth_netdevice_port_unlink(ndev);
+		}
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return notifier_from_errno(ret);
+}
+
+static int prueth_register_notifiers(struct prueth *prueth)
+{
+	int ret = 0;
+
+	prueth->prueth_netdevice_nb.notifier_call = &prueth_netdevice_event;
+	ret = register_netdevice_notifier(&prueth->prueth_netdevice_nb);
+	if (ret) {
+		dev_err(prueth->dev, "can't register netdevice notifier\n");
+		return ret;
+	}
+
+	ret = prueth_switchdev_register_notifiers(prueth);
+	if (ret)
+		unregister_netdevice_notifier(&prueth->prueth_netdevice_nb);
+
+	return ret;
+}
+
+static void prueth_unregister_notifiers(struct prueth *prueth)
+{
+	prueth_switchdev_unregister_notifiers(prueth);
+	unregister_netdevice_notifier(&prueth->prueth_netdevice_nb);
+}
+
+static const struct devlink_ops prueth_devlink_ops = {};
+
+static int prueth_dl_switch_mode_get(struct devlink *dl, u32 id,
+				     struct devlink_param_gset_ctx *ctx)
+{
+	struct prueth_devlink *dl_priv = devlink_priv(dl);
+	struct prueth *prueth = dl_priv->prueth;
+
+	dev_dbg(prueth->dev, "%s id:%u\n", __func__, id);
+
+	if (id != PRUETH_DL_PARAM_SWITCH_MODE)
+		return -EOPNOTSUPP;
+
+	ctx->val.vbool = prueth->is_switch_mode;
+
+	return 0;
+}
+
+static int prueth_dl_switch_mode_set(struct devlink *dl, u32 id,
+				     struct devlink_param_gset_ctx *ctx)
+{
+	struct prueth_devlink *dl_priv = devlink_priv(dl);
+	struct prueth *prueth = dl_priv->prueth;
+	bool switch_en = ctx->val.vbool;
+	int i;
+
+	dev_dbg(prueth->dev, "%s id:%u\n", __func__, id);
+
+	if (id != PRUETH_DL_PARAM_SWITCH_MODE)
+		return -EOPNOTSUPP;
+
+	if (switch_en == prueth->is_switch_mode)
+		return 0;
+
+	if (!switch_en && prueth->br_members) {
+		dev_err(prueth->dev, "Remove ports from bridge before disabling switch mode\n");
+		return -EINVAL;
+	}
+
+	rtnl_lock();
+
+	prueth->default_vlan = 1;
+	prueth->is_switch_mode = switch_en;
+
+	for (i = PRUETH_MAC0; i < PRUETH_NUM_MACS; i++) {
+		struct net_device *sl_ndev = prueth->emac[i]->ndev;
+
+		if (!sl_ndev || !netif_running(sl_ndev))
+			continue;
+
+		dev_err(prueth->dev, "Cannot switch modes when i/f are up\n");
+		goto exit;
+	}
+
+	for (i = PRUETH_MAC0; i < PRUETH_NUM_MACS; i++) {
+		struct net_device *sl_ndev = prueth->emac[i]->ndev;
+		struct prueth_emac *emac;
+
+		if (!sl_ndev)
+			continue;
+
+		emac = netdev_priv(sl_ndev);
+		if (switch_en)
+			emac->port_vlan = prueth->default_vlan;
+		else
+			emac->port_vlan = 0;
+	}
+
+	dev_info(prueth->dev, "Enabling %s mode\n",
+		 switch_en ? "switch" : "Dual EMAC");
+
+exit:
+	rtnl_unlock();
+
+	return 0;
+}
+
+static const struct devlink_param prueth_devlink_params[] = {
+	DEVLINK_PARAM_DRIVER(PRUETH_DL_PARAM_SWITCH_MODE, "switch_mode",
+			     DEVLINK_PARAM_TYPE_BOOL,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     prueth_dl_switch_mode_get,
+			     prueth_dl_switch_mode_set, NULL),
+};
+
+static void prueth_unregister_devlink_ports(struct prueth *prueth)
+{
+	struct devlink_port *dl_port;
+	struct prueth_emac *emac;
+	int i;
+
+	for (i = PRUETH_MAC0; i < PRUETH_NUM_MACS; i++) {
+		emac = prueth->emac[i];
+		if (!emac)
+			continue;
+
+		dl_port = &emac->devlink_port;
+
+		if (dl_port->registered)
+			devlink_port_unregister(dl_port);
+	}
+}
+
+static int prueth_register_devlink(struct prueth *prueth)
+{
+	struct devlink_port_attrs attrs = {};
+	struct device *dev = prueth->dev;
+	struct prueth_devlink *dl_priv;
+	struct devlink_port *dl_port;
+	struct prueth_emac *emac;
+	int ret = 0;
+	int i;
+
+	prueth->devlink =
+		devlink_alloc(&prueth_devlink_ops, sizeof(*dl_priv), dev);
+	if (!prueth->devlink)
+		return -ENOMEM;
+
+	dl_priv = devlink_priv(prueth->devlink);
+	dl_priv->prueth = prueth;
+
+	/* Provide devlink hook to switch mode when multiple external ports
+	 * are present NUSS switchdev driver is enabled.
+	 */
+	if (prueth->is_switchmode_supported) {
+		ret = devlink_params_register(prueth->devlink,
+					      prueth_devlink_params,
+					      ARRAY_SIZE(prueth_devlink_params));
+		if (ret) {
+			dev_err(dev, "devlink params reg fail ret:%d\n", ret);
+			goto dl_unreg;
+		}
+	}
+
+	for (i = PRUETH_MAC0; i < PRUETH_NUM_MACS; i++) {
+		emac = prueth->emac[i];
+		if (!emac)
+			continue;
+
+		dl_port = &emac->devlink_port;
+
+		attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
+		attrs.phys.port_number = emac->port_id;
+		attrs.switch_id.id_len = sizeof(resource_size_t);
+		memcpy(attrs.switch_id.id, prueth->switch_id, attrs.switch_id.id_len);
+		devlink_port_attrs_set(dl_port, &attrs);
+
+		ret = devlink_port_register(prueth->devlink, dl_port, emac->port_id);
+		if (ret) {
+			dev_err(dev, "devlink_port reg fail for port %d, ret:%d\n",
+				emac->port_id, ret);
+			goto dl_port_unreg;
+		}
+	}
+
+	devlink_register(prueth->devlink);
+	return ret;
+
+dl_port_unreg:
+	prueth_unregister_devlink_ports(prueth);
+dl_unreg:
+	devlink_free(prueth->devlink);
+
+	return ret;
+}
+
+static void prueth_unregister_devlink(struct prueth *prueth)
+{
+	devlink_unregister(prueth->devlink);
+
+	if (prueth->is_switchmode_supported) {
+		devlink_params_unregister(prueth->devlink, prueth_devlink_params,
+					  ARRAY_SIZE(prueth_devlink_params));
+	}
+
+	prueth_unregister_devlink_ports(prueth);
+	devlink_unregister(prueth->devlink);
+	devlink_free(prueth->devlink);
+}
+
 static const struct of_device_id prueth_dt_match[];
 
 static int prueth_probe(struct platform_device *pdev)
@@ -2063,6 +2396,10 @@ static int prueth_probe(struct platform_device *pdev)
 	}
 
 	msmc_ram_size = MSMC_RAM_SIZE;
+	prueth->is_switchmode_supported = prueth->pdata.switch_mode;
+	if (prueth->is_switchmode_supported)
+		msmc_ram_size = MSMC_RAM_SIZE_SWITCH_MODE;
+
 
 	/* NOTE: FW bug needs buffer base to be 64KB aligned */
 	prueth->msmcram.va =
@@ -2128,8 +2465,15 @@ static int prueth_probe(struct platform_device *pdev)
 		prueth->emac[PRUETH_MAC1]->iep = prueth->iep0;
 	}
 
+	ret = prueth_register_devlink(prueth);
+	if (ret)
+		goto netdev_exit;
+
 	/* register the network devices */
 	if (eth0_node) {
+		SET_NETDEV_DEVLINK_PORT(prueth->emac[PRUETH_MAC0]->ndev,
+					&prueth->emac[PRUETH_MAC0]->devlink_port);
+
 		ret = register_netdev(prueth->emac[PRUETH_MAC0]->ndev);
 		if (ret) {
 			dev_err(dev, "can't register netdev for port MII0");
@@ -2143,6 +2487,9 @@ static int prueth_probe(struct platform_device *pdev)
 	}
 
 	if (eth1_node) {
+		SET_NETDEV_DEVLINK_PORT(prueth->emac[PRUETH_MAC1]->ndev,
+					&prueth->emac[PRUETH_MAC1]->devlink_port);
+
 		ret = register_netdev(prueth->emac[PRUETH_MAC1]->ndev);
 		if (ret) {
 			dev_err(dev, "can't register netdev for port MII1");
@@ -2154,6 +2501,14 @@ static int prueth_probe(struct platform_device *pdev)
 		phy_attached_info(prueth->emac[PRUETH_MAC1]->ndev->phydev);
 	}
 
+	if (prueth->is_switchmode_supported) {
+		ret = prueth_register_notifiers(prueth);
+		if (ret)
+			goto netdev_unregister;
+
+		sprintf(prueth->switch_id, "%s", dev_name(dev));
+	}
+
 	dev_info(dev, "TI PRU ethernet driver initialized: %s EMAC mode\n",
 		 (!eth0_node || !eth1_node) ? "single" : "dual");
 
@@ -2215,6 +2570,8 @@ static void prueth_remove(struct platform_device *pdev)
 	struct device_node *eth_node;
 	int i;
 
+	prueth_unregister_notifiers(prueth);
+
 	for (i = 0; i < PRUETH_NUM_MACS; i++) {
 		if (!prueth->registered_netdevs[i])
 			continue;
@@ -2223,6 +2580,7 @@ static void prueth_remove(struct platform_device *pdev)
 		prueth->emac[i]->ndev->phydev = NULL;
 		unregister_netdev(prueth->registered_netdevs[i]);
 	}
+	prueth_unregister_devlink(prueth);
 
 	for (i = 0; i < PRUETH_NUM_MACS; i++) {
 		eth_node = prueth->eth_node[i];
@@ -2312,6 +2670,7 @@ static const struct dev_pm_ops prueth_dev_pm_ops = {
 static const struct prueth_pdata am654_icssg_pdata = {
 	.fdqring_mode = K3_RINGACC_RING_MODE_MESSAGE,
 	.quirk_10m_link_issue = 1,
+	.switch_mode = 1,
 };
 
 static const struct of_device_id prueth_dt_match[] = {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switchdev.c b/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
index 48d8ed4fa7a8..90d0d98e0ef9 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
@@ -14,7 +14,7 @@
 
 #include "icssg_prueth.h"
 #include "icssg_switchdev.h"
-#include "icss_mii_rt.h"
+#include "icssg_mii_rt.h"
 
 struct prueth_switchdev_event_work {
 	struct work_struct work;
-- 
2.34.1

