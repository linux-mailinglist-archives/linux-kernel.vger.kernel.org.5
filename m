Return-Path: <linux-kernel+bounces-148165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64428A7E90
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA461C21AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F296127B45;
	Wed, 17 Apr 2024 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYF+LxWE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C47C6CE;
	Wed, 17 Apr 2024 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343500; cv=none; b=uZMIgJLgYOs6uA5Rleg/pjIoZGnsCeAxTzK9BL6vq0IkZmAeHO8wGQ720d9hPeDKrhnqPJf/Fg5q+qI9kX2AH7f/vn3sKMdbrBnN0Mf1ePv5EGBgksp3h7GfhK952rM5Z5UsTJpPmvYHqANmbqCOBn9jw8AkKNO6MfOvYRW5SMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343500; c=relaxed/simple;
	bh=LUXcKiNN8sz3fVK1MvImgaE52QoDuhtTPWT1KYJlDvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kYoBKfdTgWp30tWbjSRPvJiqF9KP9qaIusBBx6zcLLXi/FSNezxjXCqDN6sfUobxNblX1s1ICG049Za69cHcUMke/9rz2APzSIC9wEdLMGSK651qqBVqR2tAUfmoTtm+DLwu8JOl3o9q3wWY30T0Q7HiM9slKb3BghiiRGjzVWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYF+LxWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E8AC072AA;
	Wed, 17 Apr 2024 08:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713343499;
	bh=LUXcKiNN8sz3fVK1MvImgaE52QoDuhtTPWT1KYJlDvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYF+LxWEL8CCOIUAxM2dfvUifQOLl4LBEJ3+dRaLKK8KDN9JnLY3hBd+HnQDBMdxI
	 tP+NjLz9yNHI/s+0gAZ/nM74nA8lLyV1ZZcLSCCVr+SAWq58YG0vJ822t5RsUtgJy8
	 cEJ6rn0X+qirTVOaoSLfgbNkXj3KTL8V+DJs2uuGEJ1lJTxyhuDrMQUup1zSPXrcGr
	 fVVyAJM2B7snzI9XEJ+fXuqwXdW5dLU3v553bz9aaNn7KNAELRv1eDyb4736nkQ3XF
	 Jc/6NSnVRmwxFpoz4ZoC4ub3GVhnPn0ii9euIk5XYdQOsLz339C8W/dQIDE9W6a64P
	 8dk/N4COgewoA==
From: Arnd Bergmann <arnd@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [PATCH 2/2] [net-next]: net: ti: icssg-prueth: split out common parts into library module
Date: Wed, 17 Apr 2024 10:43:02 +0200
Message-Id: <20240417084400.3034104-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240417084400.3034104-1-arnd@kernel.org>
References: <20240417084400.3034104-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Linking object codes multiple times causes subtle bugs and a build-time
warning:

drivers/net/ethernet/ti/Makefile: icssg/icssg_common.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
drivers/net/ethernet/ti/Makefile: icssg/icssg_classifier.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
drivers/net/ethernet/ti/Makefile: icssg/icssg_config.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
drivers/net/ethernet/ti/Makefile: icssg/icssg_mii_cfg.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
drivers/net/ethernet/ti/Makefile: icssg/icssg_stats.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
drivers/net/ethernet/ti/Makefile: icssg/icssg_ethtool.o is added to multiple modules: icssg-prueth icssg-prueth-sr1

Change the Makefile to link the common objects into a library
module that both versions of the driver then depend on. If one
of the two is built-in, the common parts will also be built-in
but still reachable through the exported symbols.

Fixes: e654b85a693e ("net: ti: icssg-prueth: Add ICSSG Ethernet driver for AM65x SR1.0 platforms")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/ti/icssg/Makefile        | 19 +++++++++++
 .../net/ethernet/ti/icssg/icssg_classifier.c  |  6 ++++
 drivers/net/ethernet/ti/icssg/icssg_common.c  | 32 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_config.c  |  5 +++
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  1 +
 drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c |  4 +++
 drivers/net/ethernet/ti/icssg/icssg_queues.c  |  2 ++
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |  1 +
 8 files changed, 70 insertions(+)
 create mode 100644 drivers/net/ethernet/ti/icssg/Makefile

diff --git a/drivers/net/ethernet/ti/icssg/Makefile b/drivers/net/ethernet/ti/icssg/Makefile
new file mode 100644
index 000000000000..4382eaeb9a2e
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the TI network device drivers.
+#
+
+obj-$(CONFIG_TI_ICSSG_PRUETH) += ti-icssg-prueth.o ti-icssg.o
+obj-$(CONFIG_TI_ICSSG_PRUETH_SR1) += ti-icssg-prueth-sr1.o ti-icssg.o
+obj-$(CONFIG_TI_ICSS_IEP) += icss_iep.o
+
+ti-icssg-prueth-y := icssg_prueth.o
+ti-icssg-prueth-sr1-y := icssg_prueth_sr1.o
+
+ti-icssg-y :=	  icssg_common.o \
+		  icssg_classifier.o \
+		  icssg_queues.o \
+		  icssg_config.o \
+		  icssg_mii_cfg.o \
+		  icssg_stats.o \
+		  icssg_ethtool.o
diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
index 79ba47bb3602..72170971a063 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
@@ -297,6 +297,7 @@ void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac)
 		     mac[2] << 16 | mac[3] << 24));
 	regmap_write(miig_rt, offs[slice].mac1, (u32)(mac[4] | mac[5] << 8));
 }
+EXPORT_SYMBOL_GPL(icssg_class_set_mac_addr);
 
 static void icssg_class_ft1_add_mcast(struct regmap *miig_rt, int slice,
 				      int slot, const u8 *addr, const u8 *mask)
@@ -360,6 +361,7 @@ void icssg_class_disable(struct regmap *miig_rt, int slice)
 	/* clear CFG2 */
 	regmap_write(miig_rt, offs[slice].rx_class_cfg2, 0);
 }
+EXPORT_SYMBOL_GPL(icssg_class_disable);
 
 void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti,
 			 bool is_sr1)
@@ -390,6 +392,7 @@ void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti,
 	/* clear CFG2 */
 	regmap_write(miig_rt, offs[slice].rx_class_cfg2, 0);
 }
+EXPORT_SYMBOL_GPL(icssg_class_default);
 
 void icssg_class_promiscuous_sr1(struct regmap *miig_rt, int slice)
 {
@@ -408,6 +411,7 @@ void icssg_class_promiscuous_sr1(struct regmap *miig_rt, int slice)
 		regmap_write(miig_rt, offset, data);
 	}
 }
+EXPORT_SYMBOL_GPL(icssg_class_promiscuous_sr1);
 
 void icssg_class_add_mcast_sr1(struct regmap *miig_rt, int slice,
 			       struct net_device *ndev)
@@ -449,6 +453,7 @@ void icssg_class_add_mcast_sr1(struct regmap *miig_rt, int slice,
 		slot++;
 	}
 }
+EXPORT_SYMBOL_GPL(icssg_class_add_mcast_sr1);
 
 /* required for SAV check */
 void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr)
@@ -460,3 +465,4 @@ void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr)
 	rx_class_ft1_set_da_mask(miig_rt, slice, 0, mask_addr);
 	rx_class_ft1_cfg_set_type(miig_rt, slice, 0, FT1_CFG_TYPE_EQ);
 }
+EXPORT_SYMBOL_GPL(icssg_ft1_set_mac_addr);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 1d62c05b5f7c..1fb6f7e8a1b7 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -51,6 +51,7 @@ void prueth_cleanup_rx_chns(struct prueth_emac *emac,
 	if (rx_chn->rx_chn)
 		k3_udma_glue_release_rx_chn(rx_chn->rx_chn);
 }
+EXPORT_SYMBOL_GPL(prueth_cleanup_rx_chns);
 
 void prueth_cleanup_tx_chns(struct prueth_emac *emac)
 {
@@ -71,6 +72,7 @@ void prueth_cleanup_tx_chns(struct prueth_emac *emac)
 		memset(tx_chn, 0, sizeof(*tx_chn));
 	}
 }
+EXPORT_SYMBOL_GPL(prueth_cleanup_tx_chns);
 
 void prueth_ndev_del_tx_napi(struct prueth_emac *emac, int num)
 {
@@ -84,6 +86,7 @@ void prueth_ndev_del_tx_napi(struct prueth_emac *emac, int num)
 		netif_napi_del(&tx_chn->napi_tx);
 	}
 }
+EXPORT_SYMBOL_GPL(prueth_ndev_del_tx_napi);
 
 void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
 		      struct cppi5_host_desc_t *desc)
@@ -120,6 +123,7 @@ void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
 
 	k3_cppi_desc_pool_free(tx_chn->desc_pool, first_desc);
 }
+EXPORT_SYMBOL_GPL(prueth_xmit_free);
 
 int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 			     int budget)
@@ -242,6 +246,7 @@ int prueth_ndev_add_tx_napi(struct prueth_emac *emac)
 	prueth_ndev_del_tx_napi(emac, i);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(prueth_ndev_add_tx_napi);
 
 int prueth_init_tx_chns(struct prueth_emac *emac)
 {
@@ -322,6 +327,7 @@ int prueth_init_tx_chns(struct prueth_emac *emac)
 	prueth_cleanup_tx_chns(emac);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(prueth_init_tx_chns);
 
 int prueth_init_rx_chns(struct prueth_emac *emac,
 			struct prueth_rx_chn *rx_chn,
@@ -431,6 +437,7 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
 	prueth_cleanup_rx_chns(emac, rx_chn, max_rflows);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(prueth_init_rx_chns);
 
 int prueth_dma_rx_push(struct prueth_emac *emac,
 		       struct sk_buff *skb,
@@ -468,6 +475,7 @@ int prueth_dma_rx_push(struct prueth_emac *emac,
 	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, 0,
 					desc_rx, desc_dma);
 }
+EXPORT_SYMBOL_GPL(prueth_dma_rx_push);
 
 u64 icssg_ts_to_ns(u32 hi_sw, u32 hi, u32 lo, u32 cycle_time_ns)
 {
@@ -483,6 +491,7 @@ u64 icssg_ts_to_ns(u32 hi_sw, u32 hi, u32 lo, u32 cycle_time_ns)
 
 	return ns;
 }
+EXPORT_SYMBOL_GPL(icssg_ts_to_ns);
 
 void emac_rx_timestamp(struct prueth_emac *emac,
 		       struct sk_buff *skb, u32 *psdata)
@@ -782,6 +791,7 @@ enum netdev_tx emac_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	netif_tx_stop_queue(netif_txq);
 	return NETDEV_TX_BUSY;
 }
+EXPORT_SYMBOL_GPL(emac_ndo_start_xmit);
 
 static void prueth_tx_cleanup(void *data, dma_addr_t desc_dma)
 {
@@ -807,6 +817,7 @@ irqreturn_t prueth_rx_irq(int irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_GPL(prueth_rx_irq);
 
 void prueth_emac_stop(struct prueth_emac *emac)
 {
@@ -831,6 +842,7 @@ void prueth_emac_stop(struct prueth_emac *emac)
 	rproc_shutdown(prueth->rtu[slice]);
 	rproc_shutdown(prueth->pru[slice]);
 }
+EXPORT_SYMBOL_GPL(prueth_emac_stop);
 
 void prueth_cleanup_tx_ts(struct prueth_emac *emac)
 {
@@ -843,6 +855,7 @@ void prueth_cleanup_tx_ts(struct prueth_emac *emac)
 		}
 	}
 }
+EXPORT_SYMBOL_GPL(prueth_cleanup_tx_ts);
 
 int emac_napi_rx_poll(struct napi_struct *napi_rx, int budget)
 {
@@ -874,6 +887,7 @@ int emac_napi_rx_poll(struct napi_struct *napi_rx, int budget)
 
 	return num_rx;
 }
+EXPORT_SYMBOL_GPL(emac_napi_rx_poll);
 
 int prueth_prepare_rx_chan(struct prueth_emac *emac,
 			   struct prueth_rx_chn *chn,
@@ -899,6 +913,7 @@ int prueth_prepare_rx_chan(struct prueth_emac *emac,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(prueth_prepare_rx_chan);
 
 void prueth_reset_tx_chan(struct prueth_emac *emac, int ch_num,
 			  bool free_skb)
@@ -913,6 +928,7 @@ void prueth_reset_tx_chan(struct prueth_emac *emac, int ch_num,
 		k3_udma_glue_disable_tx_chn(emac->tx_chns[i].tx_chn);
 	}
 }
+EXPORT_SYMBOL_GPL(prueth_reset_tx_chan);
 
 void prueth_reset_rx_chan(struct prueth_rx_chn *chn,
 			  int num_flows, bool disable)
@@ -925,11 +941,13 @@ void prueth_reset_rx_chan(struct prueth_rx_chn *chn,
 	if (disable)
 		k3_udma_glue_disable_rx_chn(chn->rx_chn);
 }
+EXPORT_SYMBOL_GPL(prueth_reset_rx_chan);
 
 void emac_ndo_tx_timeout(struct net_device *ndev, unsigned int txqueue)
 {
 	ndev->stats.tx_errors++;
 }
+EXPORT_SYMBOL_GPL(emac_ndo_tx_timeout);
 
 static int emac_set_ts_config(struct net_device *ndev, struct ifreq *ifr)
 {
@@ -1006,6 +1024,7 @@ int emac_ndo_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
 
 	return phy_do_ioctl(ndev, ifr, cmd);
 }
+EXPORT_SYMBOL_GPL(emac_ndo_ioctl);
 
 void emac_ndo_get_stats64(struct net_device *ndev,
 			  struct rtnl_link_stats64 *stats)
@@ -1027,6 +1046,7 @@ void emac_ndo_get_stats64(struct net_device *ndev,
 	stats->tx_errors  = ndev->stats.tx_errors;
 	stats->tx_dropped = ndev->stats.tx_dropped;
 }
+EXPORT_SYMBOL_GPL(emac_ndo_get_stats64);
 
 int emac_ndo_get_phys_port_name(struct net_device *ndev, char *name,
 				size_t len)
@@ -1040,6 +1060,7 @@ int emac_ndo_get_phys_port_name(struct net_device *ndev, char *name,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(emac_ndo_get_phys_port_name);
 
 /* get emac_port corresponding to eth_node name */
 int prueth_node_port(struct device_node *eth_node)
@@ -1058,6 +1079,7 @@ int prueth_node_port(struct device_node *eth_node)
 	else
 		return PRUETH_PORT_INVALID;
 }
+EXPORT_SYMBOL_GPL(prueth_node_port);
 
 /* get MAC instance corresponding to eth_node name */
 int prueth_node_mac(struct device_node *eth_node)
@@ -1076,6 +1098,7 @@ int prueth_node_mac(struct device_node *eth_node)
 	else
 		return PRUETH_MAC_INVALID;
 }
+EXPORT_SYMBOL_GPL(prueth_node_mac);
 
 void prueth_netdev_exit(struct prueth *prueth,
 			struct device_node *eth_node)
@@ -1101,6 +1124,7 @@ void prueth_netdev_exit(struct prueth *prueth,
 	free_netdev(emac->ndev);
 	prueth->emac[mac] = NULL;
 }
+EXPORT_SYMBOL_GPL(prueth_netdev_exit);
 
 int prueth_get_cores(struct prueth *prueth, int slice, bool is_sr1)
 {
@@ -1151,6 +1175,7 @@ int prueth_get_cores(struct prueth *prueth, int slice, bool is_sr1)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(prueth_get_cores);
 
 void prueth_put_cores(struct prueth *prueth, int slice)
 {
@@ -1163,6 +1188,7 @@ void prueth_put_cores(struct prueth *prueth, int slice)
 	if (prueth->pru[slice])
 		pru_rproc_put(prueth->pru[slice]);
 }
+EXPORT_SYMBOL_GPL(prueth_put_cores);
 
 #ifdef CONFIG_PM_SLEEP
 static int prueth_suspend(struct device *dev)
@@ -1219,3 +1245,9 @@ static int prueth_resume(struct device *dev)
 const struct dev_pm_ops prueth_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(prueth_suspend, prueth_resume)
 };
+EXPORT_SYMBOL_GPL(prueth_dev_pm_ops);
+
+MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
+MODULE_AUTHOR("Md Danish Anwar <danishanwar@ti.com>");
+MODULE_DESCRIPTION("PRUSS ICSSG Ethernet Driver library");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index 15f2235bf90f..5b284c94a02c 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -228,6 +228,7 @@ void icssg_config_ipg(struct prueth_emac *emac)
 
 	icssg_mii_update_ipg(prueth->mii_rt, slice, ipg);
 }
+EXPORT_SYMBOL_GPL(icssg_config_ipg);
 
 static void emac_r30_cmd_init(struct prueth_emac *emac)
 {
@@ -384,6 +385,7 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(icssg_config);
 
 /* Bitmask for ICSSG r30 commands */
 static const struct icssg_r30_cmd emac_r32_bitmask[] = {
@@ -440,6 +442,7 @@ int emac_set_port_state(struct prueth_emac *emac,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(emac_set_port_state);
 
 void icssg_config_half_duplex(struct prueth_emac *emac)
 {
@@ -451,6 +454,7 @@ void icssg_config_half_duplex(struct prueth_emac *emac)
 	val = get_random_u32();
 	writel(val, emac->dram.va + HD_RAND_SEED_OFFSET);
 }
+EXPORT_SYMBOL_GPL(icssg_config_half_duplex);
 
 void icssg_config_set_speed(struct prueth_emac *emac)
 {
@@ -477,3 +481,4 @@ void icssg_config_set_speed(struct prueth_emac *emac)
 
 	writeb(fw_speed, emac->dram.va + PORT_LINK_SPEED_OFFSET);
 }
+EXPORT_SYMBOL_GPL(icssg_config_set_speed);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index ca20325d4d3e..0659a7e2f494 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -219,3 +219,4 @@ const struct ethtool_ops icssg_ethtool_ops = {
 	.nway_reset = emac_nway_reset,
 	.get_rmon_stats = emac_get_rmon_stats,
 };
+EXPORT_SYMBOL_GPL(icssg_ethtool_ops);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c b/drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c
index 92718ae40d7e..b64955438bb2 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c
@@ -40,6 +40,7 @@ void icssg_mii_update_mtu(struct regmap *mii_rt, int mii, int mtu)
 				   (mtu - 1) << PRUSS_MII_RT_RX_FRMS_MAX_FRM_SHIFT);
 	}
 }
+EXPORT_SYMBOL_GPL(icssg_mii_update_mtu);
 
 void icssg_update_rgmii_cfg(struct regmap *miig_rt, struct prueth_emac *emac)
 {
@@ -66,6 +67,7 @@ void icssg_update_rgmii_cfg(struct regmap *miig_rt, struct prueth_emac *emac)
 	regmap_update_bits(miig_rt, RGMII_CFG_OFFSET, full_duplex_mask,
 			   full_duplex_val);
 }
+EXPORT_SYMBOL_GPL(icssg_update_rgmii_cfg);
 
 void icssg_miig_set_interface_mode(struct regmap *miig_rt, int mii, phy_interface_t phy_if)
 {
@@ -105,6 +107,7 @@ u32 icssg_rgmii_get_speed(struct regmap *miig_rt, int mii)
 
 	return icssg_rgmii_cfg_get_bitfield(miig_rt, mask, shift);
 }
+EXPORT_SYMBOL_GPL(icssg_rgmii_get_speed);
 
 u32 icssg_rgmii_get_fullduplex(struct regmap *miig_rt, int mii)
 {
@@ -118,3 +121,4 @@ u32 icssg_rgmii_get_fullduplex(struct regmap *miig_rt, int mii)
 
 	return icssg_rgmii_cfg_get_bitfield(miig_rt, mask, shift);
 }
+EXPORT_SYMBOL_GPL(icssg_rgmii_get_fullduplex);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_queues.c b/drivers/net/ethernet/ti/icssg/icssg_queues.c
index 3c34f61ad40b..e5052d9e7807 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_queues.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_queues.c
@@ -28,6 +28,7 @@ int icssg_queue_pop(struct prueth *prueth, u8 queue)
 
 	return val;
 }
+EXPORT_SYMBOL_GPL(icssg_queue_pop);
 
 void icssg_queue_push(struct prueth *prueth, int queue, u16 addr)
 {
@@ -36,6 +37,7 @@ void icssg_queue_push(struct prueth *prueth, int queue, u16 addr)
 
 	regmap_write(prueth->miig_rt, ICSSG_QUEUE_OFFSET + 4 * queue, addr);
 }
+EXPORT_SYMBOL_GPL(icssg_queue_push);
 
 u32 icssg_queue_level(struct prueth *prueth, int queue)
 {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 3dbadddd7e35..fa071b4b27c5 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -51,6 +51,7 @@ void emac_stats_work_handler(struct work_struct *work)
 	queue_delayed_work(system_long_wq, &emac->stats_work,
 			   msecs_to_jiffies((STATS_TIME_LIMIT_1G_MS * 1000) / emac->speed));
 }
+EXPORT_SYMBOL_GPL(emac_stats_work_handler);
 
 int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
 {
-- 
2.39.2


