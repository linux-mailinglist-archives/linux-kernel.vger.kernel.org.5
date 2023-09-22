Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11DE7AB208
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjIVMUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjIVMUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:20:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E39F92
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 05:19:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFACC433C8;
        Fri, 22 Sep 2023 12:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695385194;
        bh=d390+nRjt4zscfWtuBU8BIEsPdBXvLYymLe2KGyR9y8=;
        h=From:To:Cc:Subject:Date:From;
        b=gF95SBC1H8UDsVJJAQIUojQDU1JSa6yZStDpRxgOeTnzmaqo8y9dDEeK8b/0GK96j
         TbcqROu/qRS0jQwm+bnvJexUywkeQREgYG20A6fO6qTiqSW3fw0T5iRf0Rq289eA9v
         JX+CjVlG0+SpYk3t7W1l0VLQ7REcuIZUxuxWqYhVmrb2OoAXrvFOCzycM5N11B8GTE
         Z1mWQQoeGP1pohJCyePMPFfpH43Ld+MUqLCn4VGZjYD1aShZKVeKiUmb63cCxr8JyC
         DAlNNEbZXjHVnjBMpwh0qbi3w7k+OoxPIYJZIdz2ygseHNZk6Cag8hjkW2/sN8ENjT
         rOlAwHh/OLn6g==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vladimir.oltean@nxp.com
Cc:     horms@kernel.org, s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com,
        p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, rogerq@kernel.org
Subject: [PATCH] net: ethernet: ti: am65-cpsw: add sw tx/rx irq coalescing based on hrtimers
Date:   Fri, 22 Sep 2023 15:19:47 +0300
Message-Id: <20230922121947.36403-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

Add SW IRQ coalescing based on hrtimers for TX and RX data path which
can be enabled by ethtool commands:

- RX coalescing
  ethtool -C eth1 rx-usecs 50

- TX coalescing can be enabled per TX queue

  - by default enables coalesing for TX0
  ethtool -C eth1 tx-usecs 50
  - configure TX0
  ethtool -Q eth0 queue_mask 1 --coalesce tx-usecs 100
  - configure TX1
  ethtool -Q eth0 queue_mask 2 --coalesce tx-usecs 100
  - configure TX0 and TX1
  ethtool -Q eth0 queue_mask 3 --coalesce tx-usecs 100 --coalesce tx-usecs 100

  show configuration for TX0 and TX1:
  ethtool -Q eth0 queue_mask 3 --show-coalesce

Comparing to gro_flush_timeout and napi_defer_hard_irqs, this patch
allows to enable IRQ coalesing for RX path separately.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 79 +++++++++++++++++++++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    | 59 ++++++++++++---
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |  4 ++
 3 files changed, 134 insertions(+), 8 deletions(-)

Patch depends on series [1]

[1] am65-cpsw: mqprio and Frame Pre-emption support
https://lore.kernel.org/all/20230920121530.4710-1-rogerq@kernel.org/

diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index f6b081b7e754..d53360b00e7c 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -862,6 +862,80 @@ static void am65_cpsw_get_mm_stats(struct net_device *ndev,
 	s->MACMergeHoldCount = readl(base + AM65_CPSW_STATN_IET_TX_HOLD);
 }
 
+static int am65_cpsw_get_coalesce(struct net_device *ndev, struct ethtool_coalesce *coal,
+				  struct kernel_ethtool_coalesce *kernel_coal,
+				  struct netlink_ext_ack *extack)
+{
+	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
+	struct am65_cpsw_tx_chn *tx_chn;
+
+	tx_chn = &common->tx_chns[0];
+
+	coal->rx_coalesce_usecs = common->rx_pace_timeout / 1000;
+	coal->tx_coalesce_usecs = tx_chn->tx_pace_timeout / 1000;
+
+	return 0;
+}
+
+static int am65_cpsw_get_per_queue_coalesce(struct net_device *ndev, u32 queue,
+					    struct ethtool_coalesce *coal)
+{
+	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
+	struct am65_cpsw_tx_chn *tx_chn;
+
+	if (queue >= AM65_CPSW_MAX_TX_QUEUES)
+		return -EINVAL;
+
+	tx_chn = &common->tx_chns[queue];
+
+	coal->tx_coalesce_usecs = tx_chn->tx_pace_timeout / 1000;
+
+	return 0;
+}
+
+static int am65_cpsw_set_coalesce(struct net_device *ndev, struct ethtool_coalesce *coal,
+				  struct kernel_ethtool_coalesce *kernel_coal,
+				  struct netlink_ext_ack *extack)
+{
+	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
+	struct am65_cpsw_tx_chn *tx_chn;
+
+	tx_chn = &common->tx_chns[0];
+
+	if (coal->rx_coalesce_usecs && coal->rx_coalesce_usecs < 20)
+		return -EINVAL;
+
+	if (coal->tx_coalesce_usecs && coal->tx_coalesce_usecs < 20)
+		return -EINVAL;
+
+	common->rx_pace_timeout = coal->rx_coalesce_usecs * 1000;
+	tx_chn->tx_pace_timeout = coal->tx_coalesce_usecs * 1000;
+
+	return 0;
+}
+
+static int am65_cpsw_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
+					    struct ethtool_coalesce *coal)
+{
+	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
+	struct am65_cpsw_tx_chn *tx_chn;
+
+	if (queue >= AM65_CPSW_MAX_TX_QUEUES)
+		return -EINVAL;
+
+	tx_chn = &common->tx_chns[queue];
+
+	if (coal->tx_coalesce_usecs && coal->tx_coalesce_usecs < 20) {
+		dev_info(common->dev, "defaulting to min value of 20us for tx-usecs for tx-%u\n",
+			 queue);
+		coal->tx_coalesce_usecs = 20;
+	}
+
+	tx_chn->tx_pace_timeout = coal->tx_coalesce_usecs * 1000;
+
+	return 0;
+}
+
 const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
 	.begin			= am65_cpsw_ethtool_op_begin,
 	.complete		= am65_cpsw_ethtool_op_complete,
@@ -879,6 +953,11 @@ const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
 	.get_ts_info		= am65_cpsw_get_ethtool_ts_info,
 	.get_priv_flags		= am65_cpsw_get_ethtool_priv_flags,
 	.set_priv_flags		= am65_cpsw_set_ethtool_priv_flags,
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
+	.get_coalesce           = am65_cpsw_get_coalesce,
+	.set_coalesce           = am65_cpsw_set_coalesce,
+	.get_per_queue_coalesce = am65_cpsw_get_per_queue_coalesce,
+	.set_per_queue_coalesce = am65_cpsw_set_per_queue_coalesce,
 
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= am65_cpsw_get_link_ksettings,
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 2004f6a020d3..5a35269e2bbe 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -496,8 +496,10 @@ static int am65_cpsw_nuss_common_stop(struct am65_cpsw_common *common)
 					msecs_to_jiffies(1000));
 	if (!i)
 		dev_err(common->dev, "tx timeout\n");
-	for (i = 0; i < common->tx_ch_num; i++)
+	for (i = 0; i < common->tx_ch_num; i++) {
 		napi_disable(&common->tx_chns[i].napi_tx);
+		hrtimer_cancel(&common->tx_chns[i].tx_hrtimer);
+	}
 
 	for (i = 0; i < common->tx_ch_num; i++) {
 		k3_udma_glue_reset_tx_chn(common->tx_chns[i].tx_chn,
@@ -516,6 +518,7 @@ static int am65_cpsw_nuss_common_stop(struct am65_cpsw_common *common)
 	}
 
 	napi_disable(&common->napi_rx);
+	hrtimer_cancel(&common->rx_hrtimer);
 
 	for (i = 0; i < AM65_CPSW_MAX_RX_FLOWS; i++)
 		k3_udma_glue_reset_rx_chn(common->rx_chns.rx_chn, i,
@@ -806,6 +809,15 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
 	return ret;
 }
 
+static enum hrtimer_restart am65_cpsw_nuss_rx_timer_callback(struct hrtimer *timer)
+{
+	struct am65_cpsw_common *common =
+			container_of(timer, struct am65_cpsw_common, rx_hrtimer);
+
+	enable_irq(common->rx_chns.irq);
+	return HRTIMER_NORESTART;
+}
+
 static int am65_cpsw_nuss_rx_poll(struct napi_struct *napi_rx, int budget)
 {
 	struct am65_cpsw_common *common = am65_cpsw_napi_to_common(napi_rx);
@@ -833,7 +845,13 @@ static int am65_cpsw_nuss_rx_poll(struct napi_struct *napi_rx, int budget)
 	if (num_rx < budget && napi_complete_done(napi_rx, num_rx)) {
 		if (common->rx_irq_disabled) {
 			common->rx_irq_disabled = false;
-			enable_irq(common->rx_chns.irq);
+			if (unlikely(common->rx_pace_timeout)) {
+				hrtimer_start(&common->rx_hrtimer,
+					      ns_to_ktime(common->rx_pace_timeout),
+					      HRTIMER_MODE_REL_PINNED);
+			} else {
+				enable_irq(common->rx_chns.irq);
+			}
 		}
 	}
 
@@ -939,7 +957,7 @@ static void am65_cpsw_nuss_tx_wake(struct am65_cpsw_tx_chn *tx_chn, struct net_d
 }
 
 static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
-					   int chn, unsigned int budget)
+					   int chn, unsigned int budget, bool *tdown)
 {
 	struct device *dev = common->dev;
 	struct am65_cpsw_tx_chn *tx_chn;
@@ -962,6 +980,7 @@ static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
 		if (cppi5_desc_is_tdcm(desc_dma)) {
 			if (atomic_dec_and_test(&common->tdown_cnt))
 				complete(&common->tdown_complete);
+			*tdown = true;
 			break;
 		}
 
@@ -984,7 +1003,7 @@ static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
 }
 
 static int am65_cpsw_nuss_tx_compl_packets_2g(struct am65_cpsw_common *common,
-					      int chn, unsigned int budget)
+					      int chn, unsigned int budget, bool *tdown)
 {
 	struct device *dev = common->dev;
 	struct am65_cpsw_tx_chn *tx_chn;
@@ -1005,6 +1024,7 @@ static int am65_cpsw_nuss_tx_compl_packets_2g(struct am65_cpsw_common *common,
 		if (cppi5_desc_is_tdcm(desc_dma)) {
 			if (atomic_dec_and_test(&common->tdown_cnt))
 				complete(&common->tdown_complete);
+			*tdown = true;
 			break;
 		}
 
@@ -1030,21 +1050,40 @@ static int am65_cpsw_nuss_tx_compl_packets_2g(struct am65_cpsw_common *common,
 	return num_tx;
 }
 
+static enum hrtimer_restart am65_cpsw_nuss_tx_timer_callback(struct hrtimer *timer)
+{
+	struct am65_cpsw_tx_chn *tx_chns =
+			container_of(timer, struct am65_cpsw_tx_chn, tx_hrtimer);
+
+	enable_irq(tx_chns->irq);
+	return HRTIMER_NORESTART;
+}
+
 static int am65_cpsw_nuss_tx_poll(struct napi_struct *napi_tx, int budget)
 {
 	struct am65_cpsw_tx_chn *tx_chn = am65_cpsw_napi_to_tx_chn(napi_tx);
+	bool tdown = false;
 	int num_tx;
 
 	if (AM65_CPSW_IS_CPSW2G(tx_chn->common))
-		num_tx = am65_cpsw_nuss_tx_compl_packets_2g(tx_chn->common, tx_chn->id, budget);
+		num_tx = am65_cpsw_nuss_tx_compl_packets_2g(tx_chn->common, tx_chn->id,
+							    budget, &tdown);
 	else
-		num_tx = am65_cpsw_nuss_tx_compl_packets(tx_chn->common, tx_chn->id, budget);
+		num_tx = am65_cpsw_nuss_tx_compl_packets(tx_chn->common,
+							 tx_chn->id, budget, &tdown);
 
 	if (num_tx >= budget)
 		return budget;
 
-	if (napi_complete_done(napi_tx, num_tx))
-		enable_irq(tx_chn->irq);
+	if (napi_complete_done(napi_tx, num_tx)) {
+		if (unlikely(tx_chn->tx_pace_timeout && !tdown)) {
+			hrtimer_start(&tx_chn->tx_hrtimer,
+				      ns_to_ktime(tx_chn->tx_pace_timeout),
+				      HRTIMER_MODE_REL_PINNED);
+		} else {
+			enable_irq(tx_chn->irq);
+		}
+	}
 
 	return 0;
 }
@@ -1676,6 +1715,8 @@ static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
 
 		netif_napi_add_tx(common->dma_ndev, &tx_chn->napi_tx,
 				  am65_cpsw_nuss_tx_poll);
+		hrtimer_init(&tx_chn->tx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
+		tx_chn->tx_hrtimer.function = &am65_cpsw_nuss_tx_timer_callback;
 
 		ret = devm_request_irq(dev, tx_chn->irq,
 				       am65_cpsw_nuss_tx_irq,
@@ -1900,6 +1941,8 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 
 	netif_napi_add(common->dma_ndev, &common->napi_rx,
 		       am65_cpsw_nuss_rx_poll);
+	hrtimer_init(&common->rx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
+	common->rx_hrtimer.function = &am65_cpsw_nuss_rx_timer_callback;
 
 	ret = devm_request_irq(dev, rx_chn->irq,
 			       am65_cpsw_nuss_rx_irq,
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
index 1e4a045057fc..7da0492dc091 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
@@ -75,6 +75,8 @@ struct am65_cpsw_tx_chn {
 	struct k3_cppi_desc_pool *desc_pool;
 	struct k3_udma_glue_tx_channel *tx_chn;
 	spinlock_t lock; /* protect TX rings in multi-port mode */
+	struct hrtimer tx_hrtimer;
+	unsigned long tx_pace_timeout;
 	int irq;
 	u32 id;
 	u32 descs_num;
@@ -138,6 +140,8 @@ struct am65_cpsw_common {
 	struct napi_struct	napi_rx;
 
 	bool			rx_irq_disabled;
+	struct hrtimer		rx_hrtimer;
+	unsigned long		rx_pace_timeout;
 
 	u32			nuss_ver;
 	u32			cpsw_ver;

base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
prerequisite-patch-id: 281ee877d949be7a0c0d4460281c7c6a356cffdf
prerequisite-patch-id: 2633189c7e9e0d30c8d5b8edc2468b2475e42816
prerequisite-patch-id: 656c6308f2b6782a43371ef66a9f1bfa8177b1cf
-- 
2.34.1

