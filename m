Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF317F747B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345158AbjKXNCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjKXNC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:02:28 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4987FD71;
        Fri, 24 Nov 2023 05:02:34 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id B9DFE20B74C0; Fri, 24 Nov 2023 05:02:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B9DFE20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1700830953;
        bh=oUUcHPDbwiQWqdpjeEFamPkOoIRmJ8dJ3B1qE8X71Tw=;
        h=From:To:Cc:Subject:Date:From;
        b=KrWzD5zrra0XtuAcOwhw8Wg/wIbe78MJuHqPOdIcz/V/dLNZTuUCVsf4rjEH0ub6+
         xZ87XmwTlv7tTVw2Cbxy6NwSWRYg731Z2PKMj9xRkxzd4UpG8YKRO7Opuz02+rUx2P
         q2x/Wq6zeBG0SRAfXZ3dPrna0clE/U0vlqff8y0E=
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Cc:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Leon Romanovsky <leon@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH] net :mana :Add remaining GDMA stats for MANA to ethtool
Date:   Fri, 24 Nov 2023 05:02:30 -0800
Message-Id: <1700830950-803-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend performance counter stats in 'ethtool -S <interface>'
for MANA VF to include all GDMA stat counter.

Tested-on: Ubuntu22
Testcases:
1. LISA testcase:
PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-Synthetic
2. LISA testcase:
PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-SRIOV

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 49 ++++++++++++++++++-
 .../ethernet/microsoft/mana/mana_ethtool.c    | 40 +++++++++++++++
 include/net/mana/mana.h                       | 46 ++++++++++++-----
 3 files changed, 120 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index fc3d2903a80f..6b857188b9da 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2385,13 +2385,33 @@ void mana_query_gf_stats(struct mana_port_context *apc)
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_GF_STAT,
 			     sizeof(req), sizeof(resp));
-	req.req_stats = STATISTICS_FLAGS_HC_TX_BYTES |
+	req.req_stats = STATISTICS_FLAGS_RX_DISCARDS_NO_WQE |
+			STATISTICS_FLAGS_RX_ERRORS_VPORT_DISABLED |
+			STATISTICS_FLAGS_HC_RX_BYTES |
+			STATISTICS_FLAGS_HC_RX_UCAST_PACKETS |
+			STATISTICS_FLAGS_HC_RX_UCAST_BYTES |
+			STATISTICS_FLAGS_HC_RX_MCAST_PACKETS |
+			STATISTICS_FLAGS_HC_RX_MCAST_BYTES |
+			STATISTICS_FLAGS_HC_RX_BCAST_PACKETS |
+			STATISTICS_FLAGS_HC_RX_BCAST_BYTES |
+			STATISTICS_FLAGS_TX_ERRORS_GF_DISABLED |
+			STATISTICS_FLAGS_TX_ERRORS_VPORT_DISABLED |
+			STATISTICS_FLAGS_TX_ERRORS_INVAL_VPORT_OFFSET_PACKETS |
+			STATISTICS_FLAGS_TX_ERRORS_VLAN_ENFORCEMENT |
+			STATISTICS_FLAGS_TX_ERRORS_ETH_TYPE_ENFORCEMENT |
+			STATISTICS_FLAGS_TX_ERRORS_SA_ENFORCEMENT |
+			STATISTICS_FLAGS_TX_ERRORS_SQPDID_ENFORCEMENT |
+			STATISTICS_FLAGS_TX_ERRORS_CQPDID_ENFORCEMENT |
+			STATISTICS_FLAGS_TX_ERRORS_MTU_VIOLATION |
+			STATISTICS_FLAGS_TX_ERRORS_INVALID_OOB |
+			STATISTICS_FLAGS_HC_TX_BYTES |
 			STATISTICS_FLAGS_HC_TX_UCAST_PACKETS |
 			STATISTICS_FLAGS_HC_TX_UCAST_BYTES |
 			STATISTICS_FLAGS_HC_TX_MCAST_PACKETS |
 			STATISTICS_FLAGS_HC_TX_MCAST_BYTES |
 			STATISTICS_FLAGS_HC_TX_BCAST_PACKETS |
-			STATISTICS_FLAGS_HC_TX_BCAST_BYTES;
+			STATISTICS_FLAGS_HC_TX_BCAST_BYTES |
+			STATISTICS_FLAGS_TX_ERRORS_GDMA_ERROR;
 
 	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
 				sizeof(resp));
@@ -2407,6 +2427,30 @@ void mana_query_gf_stats(struct mana_port_context *apc)
 		return;
 	}
 
+	apc->eth_stats.hc_rx_discards_no_wqe = resp.rx_discards_nowqe;
+	apc->eth_stats.hc_rx_err_vport_disabled = resp.rx_err_vport_disabled;
+	apc->eth_stats.hc_rx_bytes = resp.hc_rx_bytes;
+	apc->eth_stats.hc_rx_ucast_pkts = resp.hc_rx_ucast_pkts;
+	apc->eth_stats.hc_rx_ucast_bytes = resp.hc_rx_ucast_bytes;
+	apc->eth_stats.hc_rx_bcast_pkts = resp.hc_rx_bcast_pkts;
+	apc->eth_stats.hc_rx_bcast_bytes = resp.hc_rx_bcast_bytes;
+	apc->eth_stats.hc_rx_mcast_pkts = resp.hc_rx_mcast_pkts;
+	apc->eth_stats.hc_rx_mcast_bytes = resp.hc_rx_mcast_bytes;
+	apc->eth_stats.hc_tx_err_gf_disabled = resp.tx_err_gf_disabled;
+	apc->eth_stats.hc_tx_err_vport_disabled = resp.tx_err_vport_disabled;
+	apc->eth_stats.hc_tx_err_inval_vportoffset_pkt =
+					     resp.tx_err_inval_vport_offset_pkt;
+	apc->eth_stats.hc_tx_err_vlan_enforcement =
+					     resp.tx_err_vlan_enforcement;
+	apc->eth_stats.hc_tx_err_eth_type_enforcement =
+					     resp.tx_err_ethtype_enforcement;
+	apc->eth_stats.hc_tx_err_sa_enforcement = resp.tx_err_SA_enforcement;
+	apc->eth_stats.hc_tx_err_sqpdid_enforecement =
+					     resp.tx_err_SQPDID_enforcement;
+	apc->eth_stats.hc_tx_err_cqpdid_enforcement =
+					     resp.tx_err_CQPDID_enforcement;
+	apc->eth_stats.hc_tx_err_mtu_violation = resp.tx_err_mtu_violation;
+	apc->eth_stats.hc_tx_err_inval_oob = resp.tx_err_inval_oob;
 	apc->eth_stats.hc_tx_bytes = resp.hc_tx_bytes;
 	apc->eth_stats.hc_tx_ucast_pkts = resp.hc_tx_ucast_pkts;
 	apc->eth_stats.hc_tx_ucast_bytes = resp.hc_tx_ucast_bytes;
@@ -2414,6 +2458,7 @@ void mana_query_gf_stats(struct mana_port_context *apc)
 	apc->eth_stats.hc_tx_bcast_bytes = resp.hc_tx_bcast_bytes;
 	apc->eth_stats.hc_tx_mcast_pkts = resp.hc_tx_mcast_pkts;
 	apc->eth_stats.hc_tx_mcast_bytes = resp.hc_tx_mcast_bytes;
+	apc->eth_stats.hc_tx_err_gdma = resp.tx_err_gdma;
 }
 
 static int mana_init_port(struct net_device *ndev)
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 607150165ab4..7077d647d99a 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -13,6 +13,46 @@ static const struct {
 } mana_eth_stats[] = {
 	{"stop_queue", offsetof(struct mana_ethtool_stats, stop_queue)},
 	{"wake_queue", offsetof(struct mana_ethtool_stats, wake_queue)},
+	{"hc_rx_discards_no_wqe", offsetof(struct mana_ethtool_stats,
+					   hc_rx_discards_no_wqe)},
+	{"hc_rx_err_vport_disabled", offsetof(struct mana_ethtool_stats,
+					      hc_rx_err_vport_disabled)},
+	{"hc_rx_bytes", offsetof(struct mana_ethtool_stats, hc_rx_bytes)},
+	{"hc_rx_ucast_pkts", offsetof(struct mana_ethtool_stats,
+				      hc_rx_ucast_pkts)},
+	{"hc_rx_ucast_bytes", offsetof(struct mana_ethtool_stats,
+				       hc_rx_ucast_bytes)},
+	{"hc_rx_bcast_pkts", offsetof(struct mana_ethtool_stats,
+				      hc_rx_bcast_pkts)},
+	{"hc_rx_bcast_bytes", offsetof(struct mana_ethtool_stats,
+				       hc_rx_bcast_bytes)},
+	{"hc_rx_mcast_pkts", offsetof(struct mana_ethtool_stats,
+			hc_rx_mcast_pkts)},
+	{"hc_rx_mcast_bytes", offsetof(struct mana_ethtool_stats,
+				       hc_rx_mcast_bytes)},
+	{"hc_tx_err_gf_disabled", offsetof(struct mana_ethtool_stats,
+					   hc_tx_err_gf_disabled)},
+	{"hc_tx_err_vport_disabled", offsetof(struct mana_ethtool_stats,
+					      hc_tx_err_vport_disabled)},
+	{"hc_tx_err_inval_vportoffset_pkt",
+	 offsetof(struct mana_ethtool_stats,
+		  hc_tx_err_inval_vportoffset_pkt)},
+	{"hc_tx_err_vlan_enforcement", offsetof(struct mana_ethtool_stats,
+						hc_tx_err_vlan_enforcement)},
+	{"hc_tx_err_eth_type_enforcement",
+	 offsetof(struct mana_ethtool_stats, hc_tx_err_eth_type_enforcement)},
+	{"hc_tx_err_sa_enforcement", offsetof(struct mana_ethtool_stats,
+					      hc_tx_err_sa_enforcement)},
+	{"hc_tx_err_sqpdid_enforecement",
+	 offsetof(struct mana_ethtool_stats, hc_tx_err_sqpdid_enforecement)},
+	{"hc_tx_err_cqpdid_enforcement",
+	 offsetof(struct mana_ethtool_stats, hc_tx_err_cqpdid_enforcement)},
+	{"hc_tx_err_mtu_violation", offsetof(struct mana_ethtool_stats,
+					     hc_tx_err_mtu_violation)},
+	{"hc_tx_err_inval_oob", offsetof(struct mana_ethtool_stats,
+					 hc_tx_err_inval_oob)},
+	{"hc_tx_err_gdma", offsetof(struct mana_ethtool_stats,
+				    hc_tx_err_gdma)},
 	{"hc_tx_bytes", offsetof(struct mana_ethtool_stats, hc_tx_bytes)},
 	{"hc_tx_ucast_pkts", offsetof(struct mana_ethtool_stats,
 					hc_tx_ucast_pkts)},
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 6e3e9c1363db..5567f5bc8eb6 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -353,6 +353,25 @@ struct mana_tx_qp {
 struct mana_ethtool_stats {
 	u64 stop_queue;
 	u64 wake_queue;
+	u64 hc_rx_discards_no_wqe;
+	u64 hc_rx_err_vport_disabled;
+	u64 hc_rx_bytes;
+	u64 hc_rx_ucast_pkts;
+	u64 hc_rx_ucast_bytes;
+	u64 hc_rx_bcast_pkts;
+	u64 hc_rx_bcast_bytes;
+	u64 hc_rx_mcast_pkts;
+	u64 hc_rx_mcast_bytes;
+	u64 hc_tx_err_gf_disabled;
+	u64 hc_tx_err_vport_disabled;
+	u64 hc_tx_err_inval_vportoffset_pkt;
+	u64 hc_tx_err_vlan_enforcement;
+	u64 hc_tx_err_eth_type_enforcement;
+	u64 hc_tx_err_sa_enforcement;
+	u64 hc_tx_err_sqpdid_enforecement;
+	u64 hc_tx_err_cqpdid_enforcement;
+	u64 hc_tx_err_mtu_violation;
+	u64 hc_tx_err_inval_oob;
 	u64 hc_tx_bytes;
 	u64 hc_tx_ucast_pkts;
 	u64 hc_tx_ucast_bytes;
@@ -360,6 +379,7 @@ struct mana_ethtool_stats {
 	u64 hc_tx_bcast_bytes;
 	u64 hc_tx_mcast_pkts;
 	u64 hc_tx_mcast_bytes;
+	u64 hc_tx_err_gdma;
 	u64 tx_cqe_err;
 	u64 tx_cqe_unknown_type;
 	u64 rx_coalesced_err;
@@ -602,8 +622,8 @@ struct mana_query_gf_stat_resp {
 	struct gdma_resp_hdr hdr;
 	u64 reported_stats;
 	/* rx errors/discards */
-	u64 discard_rx_nowqe;
-	u64 err_rx_vport_disabled;
+	u64 rx_discards_nowqe;
+	u64 rx_err_vport_disabled;
 	/* rx bytes/packets */
 	u64 hc_rx_bytes;
 	u64 hc_rx_ucast_pkts;
@@ -613,16 +633,16 @@ struct mana_query_gf_stat_resp {
 	u64 hc_rx_mcast_pkts;
 	u64 hc_rx_mcast_bytes;
 	/* tx errors */
-	u64 err_tx_gf_disabled;
-	u64 err_tx_vport_disabled;
-	u64 err_tx_inval_vport_offset_pkt;
-	u64 err_tx_vlan_enforcement;
-	u64 err_tx_ethtype_enforcement;
-	u64 err_tx_SA_enforecement;
-	u64 err_tx_SQPDID_enforcement;
-	u64 err_tx_CQPDID_enforcement;
-	u64 err_tx_mtu_violation;
-	u64 err_tx_inval_oob;
+	u64 tx_err_gf_disabled;
+	u64 tx_err_vport_disabled;
+	u64 tx_err_inval_vport_offset_pkt;
+	u64 tx_err_vlan_enforcement;
+	u64 tx_err_ethtype_enforcement;
+	u64 tx_err_SA_enforcement;
+	u64 tx_err_SQPDID_enforcement;
+	u64 tx_err_CQPDID_enforcement;
+	u64 tx_err_mtu_violation;
+	u64 tx_err_inval_oob;
 	/* tx bytes/packets */
 	u64 hc_tx_bytes;
 	u64 hc_tx_ucast_pkts;
@@ -632,7 +652,7 @@ struct mana_query_gf_stat_resp {
 	u64 hc_tx_mcast_pkts;
 	u64 hc_tx_mcast_bytes;
 	/* tx error */
-	u64 err_tx_gdma;
+	u64 tx_err_gdma;
 }; /* HW DATA */
 
 /* Configure vPort Rx Steering */
-- 
2.34.1

