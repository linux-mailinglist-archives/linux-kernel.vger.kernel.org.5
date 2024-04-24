Return-Path: <linux-kernel+bounces-156625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC4C8B05E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8E11C20CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4828D158D9D;
	Wed, 24 Apr 2024 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OnPUXgpm"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492A5158A2E;
	Wed, 24 Apr 2024 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950340; cv=none; b=uVp1q5Wcye/gTpQsdUx3YEFC1D+XvQqkYEH8MkmPdpOPVA63RLFTF9mgj2CNPHdlqDNFQkBW7NQKApqtOM2k7tLCBVL+sMQHuzgjgx8ueoONlAvdQhIWecDEo8PIb0yCg7dDx8TXnuoVpw0Pk5d9OwsgjkyjtfvhsST4+XwysWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950340; c=relaxed/simple;
	bh=XzPjyDYDYh/LnN9lq803nlKb22vgozayDNt08Bh7Tmk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V650+BCycM48U7G3jEqtmnen4q6tCg6vB0Lxfnkfya3FHOEBcUPRX9HtdDysn3qLRNxzeWr5KfYoUIflYue/lgARl36QD5Hin+t20mHEOqanYsvWabQIqpr2YPMuWcw0GD6aHWw9OjhhKRCKWSHmqdFmg9eC06wYiGikNmpSDXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OnPUXgpm; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43O9IQEW107625;
	Wed, 24 Apr 2024 04:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713950306;
	bh=fm92eiiohkNb05SXu2g3dO+IN7kIuwMop1jUIlFTwUI=;
	h=From:To:CC:Subject:Date;
	b=OnPUXgpmBwsCby3g41zutZAYq4pYrwSC0iCzZlIFeb4+yjFrNQyHFHP4zy5ta2ykw
	 bXi2w1PPHitKxQSL7q3AuyvnDNOxgpkh20LGWfTPcXwNZj5PqMEQLoiylFu9LS48J9
	 xny5LkgdR2J9lYNaprJEXZrTSKkQa8n+DLQk0wos=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43O9IQKf074035
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Apr 2024 04:18:26 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Apr 2024 04:18:26 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Apr 2024 04:18:26 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43O9IQvC055457;
	Wed, 24 Apr 2024 04:18:26 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 43O9IPai015060;
	Wed, 24 Apr 2024 04:18:25 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Heiner Kallweit
	<hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Jan Kiszka
	<jan.kiszka@siemens.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Paolo Abeni
	<pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH net-next] net: ti: icssg_prueth: Add SW TX / RX Coalescing based on hrtimers
Date: Wed, 24 Apr 2024 14:48:23 +0530
Message-ID: <20240424091823.1814136-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add SW IRQ coalescing based on hrtimers for RX and TX data path for ICSSG
driver, which can be enabled by ethtool commands:

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
  ethtool -Q eth0 queue_mask 3 --coalesce tx-usecs 100 --coalesce
tx-usecs 100

Minimum value for both rx-usecs and tx-usecs is 20us.

Comapared to gro_flush_timeout and napi_defer_hard_irqs this patch
allows to enable IRQ coalescing for RX path separately.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c  | 34 ++++++--
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 87 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 17 +++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  | 11 ++-
 4 files changed, 142 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 1d62c05b5f7c..1561503becc7 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -122,7 +122,7 @@ void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
 }
 
 int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
-			     int budget)
+			     int budget, bool *tdown)
 {
 	struct net_device *ndev = emac->ndev;
 	struct cppi5_host_desc_t *desc_tx;
@@ -145,6 +145,7 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 		if (cppi5_desc_is_tdcm(desc_dma)) {
 			if (atomic_dec_and_test(&emac->tdown_cnt))
 				complete(&emac->tdown_complete);
+			*tdown = true;
 			break;
 		}
 
@@ -190,19 +191,35 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 	return num_tx;
 }
 
+static enum hrtimer_restart emac_tx_timer_callback(struct hrtimer *timer)
+{
+	struct prueth_tx_chn *tx_chns =
+			container_of(timer, struct prueth_tx_chn, tx_hrtimer);
+
+	enable_irq(tx_chns->irq);
+	return HRTIMER_NORESTART;
+}
+
 static int emac_napi_tx_poll(struct napi_struct *napi_tx, int budget)
 {
 	struct prueth_tx_chn *tx_chn = prueth_napi_to_tx_chn(napi_tx);
 	struct prueth_emac *emac = tx_chn->emac;
+	bool tdown = false;
 	int num_tx_packets;
 
-	num_tx_packets = emac_tx_complete_packets(emac, tx_chn->id, budget);
+	num_tx_packets = emac_tx_complete_packets(emac, tx_chn->id, budget, &tdown);
 
 	if (num_tx_packets >= budget)
 		return budget;
 
-	if (napi_complete_done(napi_tx, num_tx_packets))
-		enable_irq(tx_chn->irq);
+	if (napi_complete_done(napi_tx, num_tx_packets)) {
+		if (unlikely(tx_chn->tx_pace_timeout_ns && !tdown))
+			hrtimer_start(&tx_chn->tx_hrtimer,
+				      ns_to_ktime(tx_chn->tx_pace_timeout_ns),
+				      HRTIMER_MODE_REL_PINNED);
+		else
+			enable_irq(tx_chn->irq);
+	}
 
 	return num_tx_packets;
 }
@@ -226,6 +243,8 @@ int prueth_ndev_add_tx_napi(struct prueth_emac *emac)
 		struct prueth_tx_chn *tx_chn = &emac->tx_chns[i];
 
 		netif_napi_add_tx(emac->ndev, &tx_chn->napi_tx, emac_napi_tx_poll);
+		hrtimer_init(&tx_chn->tx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
+		tx_chn->tx_hrtimer.function = &emac_tx_timer_callback;
 		ret = request_irq(tx_chn->irq, prueth_tx_irq,
 				  IRQF_TRIGGER_HIGH, tx_chn->name,
 				  tx_chn);
@@ -870,7 +889,12 @@ int emac_napi_rx_poll(struct napi_struct *napi_rx, int budget)
 	}
 
 	if (num_rx < budget && napi_complete_done(napi_rx, num_rx))
-		enable_irq(emac->rx_chns.irq[rx_flow]);
+		if (unlikely(emac->rx_pace_timeout_ns))
+			hrtimer_start(&emac->rx_hrtimer,
+				      ns_to_ktime(emac->rx_pace_timeout_ns),
+				      HRTIMER_MODE_REL_PINNED);
+		else
+			enable_irq(emac->rx_chns.irq[rx_flow]);
 
 	return num_rx;
 }
diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index ca20325d4d3e..d7409d82c428 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -201,6 +201,88 @@ static void emac_get_rmon_stats(struct net_device *ndev,
 	rmon_stats->hist_tx[4] = emac_get_stat_by_name(emac, "tx_bucket5_frames");
 }
 
+static int emac_get_coalesce(struct net_device *ndev, struct ethtool_coalesce *coal,
+			     struct kernel_ethtool_coalesce *kernel_coal,
+			     struct netlink_ext_ack *extack)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_tx_chn *tx_chn;
+
+	tx_chn = &emac->tx_chns[0];
+
+	coal->rx_coalesce_usecs = emac->rx_pace_timeout_ns / 1000;
+	coal->tx_coalesce_usecs = tx_chn->tx_pace_timeout_ns / 1000;
+
+	return 0;
+}
+
+static int emac_get_per_queue_coalesce(struct net_device *ndev, u32 queue,
+				       struct ethtool_coalesce *coal)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_tx_chn *tx_chn;
+
+	if (queue >= PRUETH_MAX_TX_QUEUES)
+		return -EINVAL;
+
+	tx_chn = &emac->tx_chns[queue];
+
+	coal->tx_coalesce_usecs = tx_chn->tx_pace_timeout_ns / 1000;
+
+	return 0;
+}
+
+static int emac_set_coalesce(struct net_device *ndev, struct ethtool_coalesce *coal,
+			     struct kernel_ethtool_coalesce *kernel_coal,
+			     struct netlink_ext_ack *extack)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	struct prueth_tx_chn *tx_chn;
+
+	tx_chn = &emac->tx_chns[0];
+
+	if (coal->rx_coalesce_usecs && coal->rx_coalesce_usecs < ICSSG_MIN_COALESCE_USECS) {
+		dev_info(prueth->dev, "defaulting to min value of %dus for rx-usecs\n",
+			 ICSSG_MIN_COALESCE_USECS);
+		coal->rx_coalesce_usecs = ICSSG_MIN_COALESCE_USECS;
+	}
+
+	if (coal->tx_coalesce_usecs && coal->tx_coalesce_usecs < ICSSG_MIN_COALESCE_USECS) {
+		dev_info(prueth->dev, "defaulting to min value of %dus for tx-usecs\n",
+			 ICSSG_MIN_COALESCE_USECS);
+		coal->tx_coalesce_usecs = ICSSG_MIN_COALESCE_USECS;
+	}
+
+	emac->rx_pace_timeout_ns = coal->rx_coalesce_usecs * 1000;
+	tx_chn->tx_pace_timeout_ns = coal->tx_coalesce_usecs * 1000;
+
+	return 0;
+}
+
+static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
+				       struct ethtool_coalesce *coal)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	struct prueth_tx_chn *tx_chn;
+
+	if (queue >= PRUETH_MAX_TX_QUEUES)
+		return -EINVAL;
+
+	tx_chn = &emac->tx_chns[queue];
+
+	if (coal->tx_coalesce_usecs && coal->tx_coalesce_usecs < ICSSG_MIN_COALESCE_USECS) {
+		dev_info(prueth->dev, "defaulting to min value of %dus for tx-usecs for tx-%u\n",
+			 ICSSG_MIN_COALESCE_USECS, queue);
+		coal->tx_coalesce_usecs = ICSSG_MIN_COALESCE_USECS;
+	}
+
+	tx_chn->tx_pace_timeout_ns = coal->tx_coalesce_usecs * 1000;
+
+	return 0;
+}
+
 const struct ethtool_ops icssg_ethtool_ops = {
 	.get_drvinfo = emac_get_drvinfo,
 	.get_msglevel = emac_get_msglevel,
@@ -209,6 +291,11 @@ const struct ethtool_ops icssg_ethtool_ops = {
 	.get_ethtool_stats = emac_get_ethtool_stats,
 	.get_strings = emac_get_strings,
 	.get_ts_info = emac_get_ts_info,
+	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS | ETHTOOL_COALESCE_TX_USECS,
+	.get_coalesce = emac_get_coalesce,
+	.set_coalesce = emac_set_coalesce,
+	.get_per_queue_coalesce = emac_get_per_queue_coalesce,
+	.set_per_queue_coalesce = emac_set_per_queue_coalesce,
 	.get_channels = emac_get_channels,
 	.set_channels = emac_set_channels,
 	.get_link_ksettings = emac_get_link_ksettings,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 186b0365c2e5..d620e88493c4 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -243,6 +243,16 @@ static void emac_adjust_link(struct net_device *ndev)
 	}
 }
 
+static enum hrtimer_restart emac_rx_timer_callback(struct hrtimer *timer)
+{
+	struct prueth_emac *emac =
+			container_of(timer, struct prueth_emac, rx_hrtimer);
+	int rx_flow = PRUETH_RX_FLOW_DATA;
+
+	enable_irq(emac->rx_chns.irq[rx_flow]);
+	return HRTIMER_NORESTART;
+}
+
 static int emac_phy_connect(struct prueth_emac *emac)
 {
 	struct prueth *prueth = emac->prueth;
@@ -582,8 +592,10 @@ static int emac_ndo_stop(struct net_device *ndev)
 		netdev_err(ndev, "tx teardown timeout\n");
 
 	prueth_reset_tx_chan(emac, emac->tx_ch_num, true);
-	for (i = 0; i < emac->tx_ch_num; i++)
+	for (i = 0; i < emac->tx_ch_num; i++) {
 		napi_disable(&emac->tx_chns[i].napi_tx);
+		hrtimer_cancel(&emac->tx_chns[i].tx_hrtimer);
+	}
 
 	max_rx_flows = PRUETH_MAX_RX_FLOWS;
 	k3_udma_glue_tdown_rx_chn(emac->rx_chns.rx_chn, true);
@@ -591,6 +603,7 @@ static int emac_ndo_stop(struct net_device *ndev)
 	prueth_reset_rx_chan(&emac->rx_chns, max_rx_flows, true);
 
 	napi_disable(&emac->napi_rx);
+	hrtimer_cancel(&emac->rx_hrtimer);
 
 	cancel_work_sync(&emac->rx_mode_work);
 
@@ -801,6 +814,8 @@ static int prueth_netdev_init(struct prueth *prueth,
 	ndev->features = ndev->hw_features;
 
 	netif_napi_add(ndev, &emac->napi_rx, emac_napi_rx_poll);
+	hrtimer_init(&emac->rx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
+	emac->rx_hrtimer.function = &emac_rx_timer_callback;
 	prueth->emac[mac] = emac;
 
 	return 0;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 82e38ef5635b..a78c5eb75fb8 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -108,6 +108,8 @@ struct prueth_tx_chn {
 	u32 descs_num;
 	unsigned int irq;
 	char name[32];
+	struct hrtimer tx_hrtimer;
+	unsigned long tx_pace_timeout_ns;
 };
 
 struct prueth_rx_chn {
@@ -127,6 +129,9 @@ struct prueth_rx_chn {
 
 #define PRUETH_MAX_TX_TS_REQUESTS	50 /* Max simultaneous TX_TS requests */
 
+/* Minimum coalesce time in usecs for both Tx and Rx */
+#define ICSSG_MIN_COALESCE_USECS 20
+
 /* data for each emac port */
 struct prueth_emac {
 	bool is_sr1;
@@ -183,6 +188,10 @@ struct prueth_emac {
 
 	struct delayed_work stats_work;
 	u64 stats[ICSSG_NUM_STATS];
+
+	/* RX IRQ Coalescing Related */
+	struct hrtimer rx_hrtimer;
+	unsigned long rx_pace_timeout_ns;
 };
 
 /**
@@ -320,7 +329,7 @@ void prueth_ndev_del_tx_napi(struct prueth_emac *emac, int num);
 void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
 		      struct cppi5_host_desc_t *desc);
 int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
-			     int budget);
+			     int budget, bool *tdown);
 int prueth_ndev_add_tx_napi(struct prueth_emac *emac);
 int prueth_init_tx_chns(struct prueth_emac *emac);
 int prueth_init_rx_chns(struct prueth_emac *emac,

base-commit: 1c04b46cbdddc7882eeb671521035ea884245b9f
-- 
2.34.1


