Return-Path: <linux-kernel+bounces-163896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF498B756A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1398C28535F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE4014038E;
	Tue, 30 Apr 2024 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AoXsyqUy"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B941813D618;
	Tue, 30 Apr 2024 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478822; cv=none; b=eTV/DwsddQf7l0d3xr8W0dlQmxw5WOw/AhqRYnDDLiIzmiJqFNL4tVel6+iMMsmZq2izANjVEke+TwGcIRF+uRS3xJTBnP8Rmiq4wkhC3xFgr0tz0RMljicjDSeiii5DvIFqKBn1kd6dMfLFCZxAHMNIeNQCtzpPstSgpUwGm6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478822; c=relaxed/simple;
	bh=ElzSrTKOj6zwtSbpZR2Y47gK3jz3hIX2JxW3yJpVA3Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MrR8lIMMlOGtIZwyBc58micDKd4sLyqTRwBRd71xvyr/p1Naz3oEPpVE7ghC6iFjbbdrpkhNyzRf9P0ncYwQXI9Uf1LjYTiV50JMAChmR0eB3WGAPTHYxzXylBOgXlK68FONH13yp0owrPP9DsRPsGzh6Jhaj05upMb0RWeKXNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AoXsyqUy; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43UC6c2S019884;
	Tue, 30 Apr 2024 07:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714478798;
	bh=tcUCvNxzuyXMP7T6wVE8YtL/6igb/ha5hCDb+AUyyKQ=;
	h=From:To:CC:Subject:Date;
	b=AoXsyqUymYdSpWu16DC54hITwlfo6UjAOxsrf9HyXGq7LTVbVucJxU3bC4BBfHjxo
	 1pC1W6+o5TcIH5MKHEznAvrfEy7JH91KppACGFJ19pdHVkb5r5ElETe3jQ7zkA2YXT
	 RGTG5MhyzAFHVQGILH7dy6Kr5b4kLvFaA7gq3gLU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43UC6cPt082146
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Apr 2024 07:06:38 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 07:06:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 07:06:37 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43UC6bhf043702;
	Tue, 30 Apr 2024 07:06:37 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 43UC6a7C024808;
	Tue, 30 Apr 2024 07:06:36 -0500
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
        Roger Quadros <rogerq@kernel.org>, Simon Horman <horms@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH net-next v3] net: ti: icssg_prueth: Add SW TX / RX Coalescing based on hrtimers
Date: Tue, 30 Apr 2024 17:36:34 +0530
Message-ID: <20240430120634.1558998-1-danishanwar@ti.com>
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

  - by default enables coalescing for TX0
  ethtool -C eth1 tx-usecs 50
  - configure TX0
  ethtool -Q eth0 queue_mask 1 --coalesce tx-usecs 100
  - configure TX1
  ethtool -Q eth0 queue_mask 2 --coalesce tx-usecs 100
  - configure TX0 and TX1
  ethtool -Q eth0 queue_mask 3 --coalesce tx-usecs 100 --coalesce
tx-usecs 100

Minimum value for both rx-usecs and tx-usecs is 20us.

Compared to gro_flush_timeout and napi_defer_hard_irqs this patch allows
to enable IRQ coalescing for RX path separately.

Benchmarking numbers:
 ===============================================================
| Method                  | Tput_TX | CPU_TX | Tput_RX | CPU_RX |
| ==============================================================
| Default Driver           943 Mbps    31%      517 Mbps  38%   |
| IRQ Coalescing (Patch)   943 Mbps    28%      518 Mbps  25%   |
 ===============================================================

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes from v2 [2] to v3:
*) Collected RB tag from Andrew Lunn <andrew@lunn.ch>
*) Fixed warning caused by {} missing for outer if conditions in
   emac_napi_tx_poll() and emac_napi_rx_poll() APIs.
*) Fixed spelling mistake.

Changes from v1 [1] to v2:
*) Added Benchmarking numbers in the commit message as suggested by
   Andrew Lunn <andrew@lunn.ch>. Full logs [3]
*) Addressed comments given by Simon Horman <horms@kernel.org> in v1.

[1] https://lore.kernel.org/all/20240424091823.1814136-1-danishanwar@ti.com/
[2] https://lore.kernel.org/all/20240429071501.547680-1-danishanwar@ti.com/
[3] https://gist.githubusercontent.com/danish-ti/47855631be9f3635cee994693662a988/raw/94b4eb86b42fe243ab03186a88a314e0cb272fd0/gistfile1.txt

 drivers/net/ethernet/ti/icssg/icssg_common.c  | 41 ++++++--
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 93 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 18 +++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  | 11 ++-
 4 files changed, 155 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 284f97876054..088ab8076db4 100644
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
 
@@ -190,19 +191,37 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
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
+	num_tx_packets = emac_tx_complete_packets(emac, tx_chn->id, budget,
+						  &tdown);
 
 	if (num_tx_packets >= budget)
 		return budget;
 
-	if (napi_complete_done(napi_tx, num_tx_packets))
-		enable_irq(tx_chn->irq);
+	if (napi_complete_done(napi_tx, num_tx_packets)) {
+		if (unlikely(tx_chn->tx_pace_timeout_ns && !tdown)) {
+			hrtimer_start(&tx_chn->tx_hrtimer,
+				      ns_to_ktime(tx_chn->tx_pace_timeout_ns),
+				      HRTIMER_MODE_REL_PINNED);
+		} else {
+			enable_irq(tx_chn->irq);
+		}
+	}
 
 	return num_tx_packets;
 }
@@ -226,6 +245,9 @@ int prueth_ndev_add_tx_napi(struct prueth_emac *emac)
 		struct prueth_tx_chn *tx_chn = &emac->tx_chns[i];
 
 		netif_napi_add_tx(emac->ndev, &tx_chn->napi_tx, emac_napi_tx_poll);
+		hrtimer_init(&tx_chn->tx_hrtimer, CLOCK_MONOTONIC,
+			     HRTIMER_MODE_REL_PINNED);
+		tx_chn->tx_hrtimer.function = &emac_tx_timer_callback;
 		ret = request_irq(tx_chn->irq, prueth_tx_irq,
 				  IRQF_TRIGGER_HIGH, tx_chn->name,
 				  tx_chn);
@@ -871,8 +893,15 @@ int emac_napi_rx_poll(struct napi_struct *napi_rx, int budget)
 			break;
 	}
 
-	if (num_rx < budget && napi_complete_done(napi_rx, num_rx))
-		enable_irq(emac->rx_chns.irq[rx_flow]);
+	if (num_rx < budget && napi_complete_done(napi_rx, num_rx)) {
+		if (unlikely(emac->rx_pace_timeout_ns)) {
+			hrtimer_start(&emac->rx_hrtimer,
+				      ns_to_ktime(emac->rx_pace_timeout_ns),
+				      HRTIMER_MODE_REL_PINNED);
+		} else {
+			enable_irq(emac->rx_chns.irq[rx_flow]);
+		}
+	}
 
 	return num_rx;
 }
diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index ca20325d4d3e..c8d0f45cc5b1 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -201,6 +201,93 @@ static void emac_get_rmon_stats(struct net_device *ndev,
 	rmon_stats->hist_tx[4] = emac_get_stat_by_name(emac, "tx_bucket5_frames");
 }
 
+static int emac_get_coalesce(struct net_device *ndev,
+			     struct ethtool_coalesce *coal,
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
+static int emac_set_coalesce(struct net_device *ndev,
+			     struct ethtool_coalesce *coal,
+			     struct kernel_ethtool_coalesce *kernel_coal,
+			     struct netlink_ext_ack *extack)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	struct prueth_tx_chn *tx_chn;
+
+	tx_chn = &emac->tx_chns[0];
+
+	if (coal->rx_coalesce_usecs &&
+	    coal->rx_coalesce_usecs < ICSSG_MIN_COALESCE_USECS) {
+		dev_info(prueth->dev, "defaulting to min value of %dus for rx-usecs\n",
+			 ICSSG_MIN_COALESCE_USECS);
+		coal->rx_coalesce_usecs = ICSSG_MIN_COALESCE_USECS;
+	}
+
+	if (coal->tx_coalesce_usecs &&
+	    coal->tx_coalesce_usecs < ICSSG_MIN_COALESCE_USECS) {
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
+	if (coal->tx_coalesce_usecs &&
+	    coal->tx_coalesce_usecs < ICSSG_MIN_COALESCE_USECS) {
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
@@ -209,6 +296,12 @@ const struct ethtool_ops icssg_ethtool_ops = {
 	.get_ethtool_stats = emac_get_ethtool_stats,
 	.get_strings = emac_get_strings,
 	.get_ts_info = emac_get_ts_info,
+	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
+				     ETHTOOL_COALESCE_TX_USECS,
+	.get_coalesce = emac_get_coalesce,
+	.set_coalesce = emac_set_coalesce,
+	.get_per_queue_coalesce = emac_get_per_queue_coalesce,
+	.set_per_queue_coalesce = emac_set_per_queue_coalesce,
 	.get_channels = emac_get_channels,
 	.set_channels = emac_set_channels,
 	.get_link_ksettings = emac_get_link_ksettings,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 186b0365c2e5..7c9e9518f555 100644
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
 
@@ -801,6 +814,9 @@ static int prueth_netdev_init(struct prueth *prueth,
 	ndev->features = ndev->hw_features;
 
 	netif_napi_add(ndev, &emac->napi_rx, emac_napi_rx_poll);
+	hrtimer_init(&emac->rx_hrtimer, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_REL_PINNED);
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

base-commit: 9f02bb6d7a229058ffaba4f6dd78e0f7b06b799c
-- 
2.34.1


