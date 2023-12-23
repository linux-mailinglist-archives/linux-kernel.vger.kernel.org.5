Return-Path: <linux-kernel+bounces-10216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F5A81D161
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18084B230A8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A445664;
	Sat, 23 Dec 2023 02:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBYUJ1wJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E3B4A0C;
	Sat, 23 Dec 2023 02:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300288; x=1734836288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eweqS73/c+soJ6sj/huSb8cCmNIOhaPJnf1IhKvPICk=;
  b=XBYUJ1wJ8OSiO9+iza/euAg5xszdMdasrzK03x5BT3rETAFepRSG+cBh
   PrDYt60EGV9fNlWfgIj0OfUB3rq5BZ47Blsyzm/vIOvOpYFhriuCuYp93
   4fu2jp2xtz2N6/tujTRJhsdtstjpuG5acW4hjEbmR/l8+Tfcu1V0175QF
   setA7p7VofbvB19R41h/iGy9cqxKyW9CT7fRf11uPWzFMv/HSCJgxV4gV
   pf2ZqyM2pAOG/s3gZ4OattXN+WtRUNi907GPbEJPA93Qh3Ez6VhB+bHPa
   uvcw0HleGVJBUmgDCT3sZLzxhqbmHb8jncnd0HTAkXtKBygK6eq42wm/8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386610766"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386610766"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:58:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537383"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:58:03 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next 01/34] idpf: reuse libie's definitions of parsed ptype structures
Date: Sat, 23 Dec 2023 03:55:21 +0100
Message-ID: <20231223025554.2316836-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
References: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

idpf's in-kernel parsed ptype structure is almost identical to the one
used in the previous Intel drivers, which means it can be converted to
use libie's definitions and even helpers. The only difference is that
it doesn't use a constant table, rather than one obtained from the
device.
Remove the driver counterpart and use libie's helpers for hashes and
checksums. This slightly optimizes skb fields processing due to faster
checks.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   1 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  87 +++++++--------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 101 ++++++------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  88 +--------------
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  54 ++++++----
 7 files changed, 110 insertions(+), 224 deletions(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index c7da7d05d93e..0db1aa36866e 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -378,6 +378,7 @@ config IDPF
 	tristate "Intel(R) Infrastructure Data Path Function Support"
 	depends on PCI_MSI
 	select DIMLIB
+	select LIBIE
 	select PAGE_POOL
 	select PAGE_POOL_STATS
 	help
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 0acc125decb3..8342df0f4f3d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -385,7 +385,7 @@ struct idpf_vport {
 	u16 num_rxq_grp;
 	struct idpf_rxq_group *rxq_grps;
 	u32 rxq_model;
-	struct idpf_rx_ptype_decoded rx_ptype_lkup[IDPF_RX_MAX_PTYPE];
+	struct libie_rx_ptype_parsed rx_ptype_lkup[IDPF_RX_MAX_PTYPE];
 
 	struct idpf_adapter *adapter;
 	struct net_device *netdev;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index e1febc74cefd..6471158e6f6b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -7,6 +7,7 @@
 #define DRV_SUMMARY	"Intel(R) Infrastructure Data Path Function Linux Driver"
 
 MODULE_DESCRIPTION(DRV_SUMMARY);
+MODULE_IMPORT_NS(LIBIE);
 MODULE_LICENSE("GPL");
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 8122a0cc97de..e58e08c9997d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -636,75 +636,64 @@ static bool idpf_rx_singleq_is_non_eop(struct idpf_queue *rxq,
  * @rxq: Rx ring being processed
  * @skb: skb currently being received and modified
  * @csum_bits: checksum bits from descriptor
- * @ptype: the packet type decoded by hardware
+ * @parsed: the packet type parsed by hardware
  *
  * skb->protocol must be set before this function is called
  */
 static void idpf_rx_singleq_csum(struct idpf_queue *rxq, struct sk_buff *skb,
-				 struct idpf_rx_csum_decoded *csum_bits,
-				 u16 ptype)
+				 struct idpf_rx_csum_decoded csum_bits,
+				 struct libie_rx_ptype_parsed parsed)
 {
-	struct idpf_rx_ptype_decoded decoded;
 	bool ipv4, ipv6;
 
 	/* check if Rx checksum is enabled */
-	if (unlikely(!(rxq->vport->netdev->features & NETIF_F_RXCSUM)))
+	if (!libie_has_rx_checksum(rxq->vport->netdev, parsed))
 		return;
 
 	/* check if HW has decoded the packet and checksum */
-	if (unlikely(!(csum_bits->l3l4p)))
+	if (unlikely(!csum_bits.l3l4p))
 		return;
 
-	decoded = rxq->vport->rx_ptype_lkup[ptype];
-	if (unlikely(!(decoded.known && decoded.outer_ip)))
+	if (unlikely(parsed.outer_ip == LIBIE_RX_PTYPE_OUTER_L2))
 		return;
 
-	ipv4 = IDPF_RX_PTYPE_TO_IPV(&decoded, IDPF_RX_PTYPE_OUTER_IPV4);
-	ipv6 = IDPF_RX_PTYPE_TO_IPV(&decoded, IDPF_RX_PTYPE_OUTER_IPV6);
+	ipv4 = parsed.outer_ip == LIBIE_RX_PTYPE_OUTER_IPV4;
+	ipv6 = parsed.outer_ip == LIBIE_RX_PTYPE_OUTER_IPV6;
 
 	/* Check if there were any checksum errors */
-	if (unlikely(ipv4 && (csum_bits->ipe || csum_bits->eipe)))
+	if (unlikely(ipv4 && (csum_bits.ipe || csum_bits.eipe)))
 		goto checksum_fail;
 
 	/* Device could not do any checksum offload for certain extension
 	 * headers as indicated by setting IPV6EXADD bit
 	 */
-	if (unlikely(ipv6 && csum_bits->ipv6exadd))
+	if (unlikely(ipv6 && csum_bits.ipv6exadd))
 		return;
 
 	/* check for L4 errors and handle packets that were not able to be
 	 * checksummed due to arrival speed
 	 */
-	if (unlikely(csum_bits->l4e))
+	if (unlikely(csum_bits.l4e))
 		goto checksum_fail;
 
-	if (unlikely(csum_bits->nat && csum_bits->eudpe))
+	if (unlikely(csum_bits.nat && csum_bits.eudpe))
 		goto checksum_fail;
 
 	/* Handle packets that were not able to be checksummed due to arrival
 	 * speed, in this case the stack can compute the csum.
 	 */
-	if (unlikely(csum_bits->pprs))
+	if (unlikely(csum_bits.pprs))
 		return;
 
 	/* If there is an outer header present that might contain a checksum
 	 * we need to bump the checksum level by 1 to reflect the fact that
 	 * we are indicating we validated the inner checksum.
 	 */
-	if (decoded.tunnel_type >= IDPF_RX_PTYPE_TUNNEL_IP_GRENAT)
+	if (parsed.tunnel_type >= LIBIE_RX_PTYPE_TUNNEL_IP_GRENAT)
 		skb->csum_level = 1;
 
-	/* Only report checksum unnecessary for ICMP, TCP, UDP, or SCTP */
-	switch (decoded.inner_prot) {
-	case IDPF_RX_PTYPE_INNER_PROT_ICMP:
-	case IDPF_RX_PTYPE_INNER_PROT_TCP:
-	case IDPF_RX_PTYPE_INNER_PROT_UDP:
-	case IDPF_RX_PTYPE_INNER_PROT_SCTP:
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-		return;
-	default:
-		return;
-	}
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	return;
 
 checksum_fail:
 	u64_stats_update_begin(&rxq->stats_sync);
@@ -717,7 +706,7 @@ static void idpf_rx_singleq_csum(struct idpf_queue *rxq, struct sk_buff *skb,
  * @rx_q: Rx completion queue
  * @skb: skb currently being received and modified
  * @rx_desc: the receive descriptor
- * @ptype: Rx packet type
+ * @parsed: Rx packet type parsed by hardware
  *
  * This function only operates on the VIRTCHNL2_RXDID_1_32B_BASE_M base 32byte
  * descriptor writeback format.
@@ -725,7 +714,7 @@ static void idpf_rx_singleq_csum(struct idpf_queue *rxq, struct sk_buff *skb,
 static void idpf_rx_singleq_base_csum(struct idpf_queue *rx_q,
 				      struct sk_buff *skb,
 				      union virtchnl2_rx_desc *rx_desc,
-				      u16 ptype)
+				      struct libie_rx_ptype_parsed parsed)
 {
 	struct idpf_rx_csum_decoded csum_bits;
 	u32 rx_error, rx_status;
@@ -749,7 +738,7 @@ static void idpf_rx_singleq_base_csum(struct idpf_queue *rx_q,
 	csum_bits.nat = 0;
 	csum_bits.eudpe = 0;
 
-	idpf_rx_singleq_csum(rx_q, skb, &csum_bits, ptype);
+	idpf_rx_singleq_csum(rx_q, skb, csum_bits, parsed);
 }
 
 /**
@@ -757,7 +746,7 @@ static void idpf_rx_singleq_base_csum(struct idpf_queue *rx_q,
  * @rx_q: Rx completion queue
  * @skb: skb currently being received and modified
  * @rx_desc: the receive descriptor
- * @ptype: Rx packet type
+ * @parsed: Rx packet type parsed by hardware
  *
  * This function only operates on the VIRTCHNL2_RXDID_2_FLEX_SQ_NIC flexible
  * descriptor writeback format.
@@ -765,7 +754,7 @@ static void idpf_rx_singleq_base_csum(struct idpf_queue *rx_q,
 static void idpf_rx_singleq_flex_csum(struct idpf_queue *rx_q,
 				      struct sk_buff *skb,
 				      union virtchnl2_rx_desc *rx_desc,
-				      u16 ptype)
+				      struct libie_rx_ptype_parsed parsed)
 {
 	struct idpf_rx_csum_decoded csum_bits;
 	u16 rx_status0, rx_status1;
@@ -789,7 +778,7 @@ static void idpf_rx_singleq_flex_csum(struct idpf_queue *rx_q,
 				  rx_status1);
 	csum_bits.pprs = 0;
 
-	idpf_rx_singleq_csum(rx_q, skb, &csum_bits, ptype);
+	idpf_rx_singleq_csum(rx_q, skb, csum_bits, parsed);
 }
 
 /**
@@ -797,7 +786,7 @@ static void idpf_rx_singleq_flex_csum(struct idpf_queue *rx_q,
  * @rx_q: Rx completion queue
  * @skb: skb currently being received and modified
  * @rx_desc: specific descriptor
- * @decoded: Decoded Rx packet type related fields
+ * @parsed: parsed Rx packet type related fields
  *
  * This function only operates on the VIRTCHNL2_RXDID_1_32B_BASE_M base 32byte
  * descriptor writeback format.
@@ -805,11 +794,11 @@ static void idpf_rx_singleq_flex_csum(struct idpf_queue *rx_q,
 static void idpf_rx_singleq_base_hash(struct idpf_queue *rx_q,
 				      struct sk_buff *skb,
 				      union virtchnl2_rx_desc *rx_desc,
-				      struct idpf_rx_ptype_decoded *decoded)
+				      struct libie_rx_ptype_parsed parsed)
 {
 	u64 mask, qw1;
 
-	if (unlikely(!(rx_q->vport->netdev->features & NETIF_F_RXHASH)))
+	if (!libie_has_rx_hash(rx_q->vport->netdev, parsed))
 		return;
 
 	mask = VIRTCHNL2_RX_BASE_DESC_FLTSTAT_RSS_HASH_M;
@@ -818,7 +807,7 @@ static void idpf_rx_singleq_base_hash(struct idpf_queue *rx_q,
 	if (FIELD_GET(mask, qw1) == mask) {
 		u32 hash = le32_to_cpu(rx_desc->base_wb.qword0.hi_dword.rss);
 
-		skb_set_hash(skb, hash, idpf_ptype_to_htype(decoded));
+		libie_skb_set_hash(skb, hash, parsed);
 	}
 }
 
@@ -827,7 +816,7 @@ static void idpf_rx_singleq_base_hash(struct idpf_queue *rx_q,
  * @rx_q: Rx completion queue
  * @skb: skb currently being received and modified
  * @rx_desc: specific descriptor
- * @decoded: Decoded Rx packet type related fields
+ * @parsed: parsed Rx packet type related fields
  *
  * This function only operates on the VIRTCHNL2_RXDID_2_FLEX_SQ_NIC flexible
  * descriptor writeback format.
@@ -835,15 +824,17 @@ static void idpf_rx_singleq_base_hash(struct idpf_queue *rx_q,
 static void idpf_rx_singleq_flex_hash(struct idpf_queue *rx_q,
 				      struct sk_buff *skb,
 				      union virtchnl2_rx_desc *rx_desc,
-				      struct idpf_rx_ptype_decoded *decoded)
+				      struct libie_rx_ptype_parsed parsed)
 {
-	if (unlikely(!(rx_q->vport->netdev->features & NETIF_F_RXHASH)))
+	if (!libie_has_rx_hash(rx_q->vport->netdev, parsed))
 		return;
 
 	if (FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_STATUS0_RSS_VALID_M,
-		      le16_to_cpu(rx_desc->flex_nic_wb.status_error0)))
-		skb_set_hash(skb, le32_to_cpu(rx_desc->flex_nic_wb.rss_hash),
-			     idpf_ptype_to_htype(decoded));
+		      le16_to_cpu(rx_desc->flex_nic_wb.status_error0))) {
+		u32 hash = le32_to_cpu(rx_desc->flex_nic_wb.rss_hash);
+
+		libie_skb_set_hash(skb, hash, parsed);
+	}
 }
 
 /**
@@ -863,7 +854,7 @@ static void idpf_rx_singleq_process_skb_fields(struct idpf_queue *rx_q,
 					       union virtchnl2_rx_desc *rx_desc,
 					       u16 ptype)
 {
-	struct idpf_rx_ptype_decoded decoded =
+	struct libie_rx_ptype_parsed parsed =
 					rx_q->vport->rx_ptype_lkup[ptype];
 
 	/* modifies the skb - consumes the enet header */
@@ -871,11 +862,11 @@ static void idpf_rx_singleq_process_skb_fields(struct idpf_queue *rx_q,
 
 	/* Check if we're using base mode descriptor IDs */
 	if (rx_q->rxdids == VIRTCHNL2_RXDID_1_32B_BASE_M) {
-		idpf_rx_singleq_base_hash(rx_q, skb, rx_desc, &decoded);
-		idpf_rx_singleq_base_csum(rx_q, skb, rx_desc, ptype);
+		idpf_rx_singleq_base_hash(rx_q, skb, rx_desc, parsed);
+		idpf_rx_singleq_base_csum(rx_q, skb, rx_desc, parsed);
 	} else {
-		idpf_rx_singleq_flex_hash(rx_q, skb, rx_desc, &decoded);
-		idpf_rx_singleq_flex_csum(rx_q, skb, rx_desc, ptype);
+		idpf_rx_singleq_flex_hash(rx_q, skb, rx_desc, parsed);
+		idpf_rx_singleq_flex_csum(rx_q, skb, rx_desc, parsed);
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 610841dc4512..70785f9afadd 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2705,51 +2705,27 @@ netdev_tx_t idpf_tx_splitq_start(struct sk_buff *skb,
 	return idpf_tx_splitq_frame(skb, tx_q);
 }
 
-/**
- * idpf_ptype_to_htype - get a hash type
- * @decoded: Decoded Rx packet type related fields
- *
- * Returns appropriate hash type (such as PKT_HASH_TYPE_L2/L3/L4) to be used by
- * skb_set_hash based on PTYPE as parsed by HW Rx pipeline and is part of
- * Rx desc.
- */
-enum pkt_hash_types idpf_ptype_to_htype(const struct idpf_rx_ptype_decoded *decoded)
-{
-	if (!decoded->known)
-		return PKT_HASH_TYPE_NONE;
-	if (decoded->payload_layer == IDPF_RX_PTYPE_PAYLOAD_LAYER_PAY2 &&
-	    decoded->inner_prot)
-		return PKT_HASH_TYPE_L4;
-	if (decoded->payload_layer == IDPF_RX_PTYPE_PAYLOAD_LAYER_PAY2 &&
-	    decoded->outer_ip)
-		return PKT_HASH_TYPE_L3;
-	if (decoded->outer_ip == IDPF_RX_PTYPE_OUTER_L2)
-		return PKT_HASH_TYPE_L2;
-
-	return PKT_HASH_TYPE_NONE;
-}
-
 /**
  * idpf_rx_hash - set the hash value in the skb
  * @rxq: Rx descriptor ring packet is being transacted on
  * @skb: pointer to current skb being populated
  * @rx_desc: Receive descriptor
- * @decoded: Decoded Rx packet type related fields
+ * @parsed: parsed Rx packet type related fields
  */
 static void idpf_rx_hash(struct idpf_queue *rxq, struct sk_buff *skb,
 			 struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc,
-			 struct idpf_rx_ptype_decoded *decoded)
+			 struct libie_rx_ptype_parsed parsed)
 {
 	u32 hash;
 
-	if (unlikely(!idpf_is_feature_ena(rxq->vport, NETIF_F_RXHASH)))
+	if (!libie_has_rx_hash(rxq->vport->netdev, parsed))
 		return;
 
 	hash = le16_to_cpu(rx_desc->hash1) |
 	       (rx_desc->ff2_mirrid_hash2.hash2 << 16) |
 	       (rx_desc->hash3 << 24);
 
-	skb_set_hash(skb, hash, idpf_ptype_to_htype(decoded));
+	libie_skb_set_hash(skb, hash, parsed);
 }
 
 /**
@@ -2757,60 +2733,48 @@ static void idpf_rx_hash(struct idpf_queue *rxq, struct sk_buff *skb,
  * @rxq: Rx descriptor ring packet is being transacted on
  * @skb: pointer to current skb being populated
  * @csum_bits: checksum fields extracted from the descriptor
- * @decoded: Decoded Rx packet type related fields
+ * @parsed: parsed Rx packet type related fields
  *
  * skb->protocol must be set before this function is called
  */
 static void idpf_rx_csum(struct idpf_queue *rxq, struct sk_buff *skb,
-			 struct idpf_rx_csum_decoded *csum_bits,
-			 struct idpf_rx_ptype_decoded *decoded)
+			 struct idpf_rx_csum_decoded csum_bits,
+			 struct libie_rx_ptype_parsed parsed)
 {
 	bool ipv4, ipv6;
 
 	/* check if Rx checksum is enabled */
-	if (unlikely(!idpf_is_feature_ena(rxq->vport, NETIF_F_RXCSUM)))
+	if (!libie_has_rx_checksum(rxq->vport->netdev, parsed))
 		return;
 
 	/* check if HW has decoded the packet and checksum */
-	if (!(csum_bits->l3l4p))
+	if (!csum_bits.l3l4p)
 		return;
 
-	ipv4 = IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV4);
-	ipv6 = IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV6);
+	ipv4 = parsed.outer_ip == LIBIE_RX_PTYPE_OUTER_IPV4;
+	ipv6 = parsed.outer_ip == LIBIE_RX_PTYPE_OUTER_IPV6;
 
-	if (ipv4 && (csum_bits->ipe || csum_bits->eipe))
+	if (ipv4 && (csum_bits.ipe || csum_bits.eipe))
 		goto checksum_fail;
 
-	if (ipv6 && csum_bits->ipv6exadd)
+	if (ipv6 && csum_bits.ipv6exadd)
 		return;
 
 	/* check for L4 errors and handle packets that were not able to be
 	 * checksummed
 	 */
-	if (csum_bits->l4e)
+	if (csum_bits.l4e)
 		goto checksum_fail;
 
-	/* Only report checksum unnecessary for ICMP, TCP, UDP, or SCTP */
-	switch (decoded->inner_prot) {
-	case IDPF_RX_PTYPE_INNER_PROT_ICMP:
-	case IDPF_RX_PTYPE_INNER_PROT_TCP:
-	case IDPF_RX_PTYPE_INNER_PROT_UDP:
-		if (!csum_bits->raw_csum_inv) {
-			u16 csum = csum_bits->raw_csum;
-
-			skb->csum = csum_unfold((__force __sum16)~swab16(csum));
-			skb->ip_summed = CHECKSUM_COMPLETE;
-		} else {
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
-		}
-		break;
-	case IDPF_RX_PTYPE_INNER_PROT_SCTP:
+	if (csum_bits.raw_csum_inv ||
+	    parsed.inner_prot == LIBIE_RX_PTYPE_INNER_SCTP) {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
-		break;
-	default:
-		break;
+		return;
 	}
 
+	skb->csum = csum_unfold((__force __sum16)~swab16(csum_bits.raw_csum));
+	skb->ip_summed = CHECKSUM_COMPLETE;
+
 	return;
 
 checksum_fail:
@@ -2853,7 +2817,7 @@ static void idpf_rx_splitq_extract_csum_bits(struct virtchnl2_rx_flex_desc_adv_n
  * @rxq : Rx descriptor ring packet is being transacted on
  * @skb : pointer to current skb being populated
  * @rx_desc: Receive descriptor
- * @decoded: Decoded Rx packet type related fields
+ * @parsed: parsed Rx packet type related fields
  *
  * Return 0 on success and error code on failure
  *
@@ -2862,21 +2826,21 @@ static void idpf_rx_splitq_extract_csum_bits(struct virtchnl2_rx_flex_desc_adv_n
  */
 static int idpf_rx_rsc(struct idpf_queue *rxq, struct sk_buff *skb,
 		       struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc,
-		       struct idpf_rx_ptype_decoded *decoded)
+		       struct libie_rx_ptype_parsed parsed)
 {
 	u16 rsc_segments, rsc_seg_len;
 	bool ipv4, ipv6;
 	int len;
 
-	if (unlikely(!decoded->outer_ip))
+	if (unlikely(parsed.outer_ip == LIBIE_RX_PTYPE_OUTER_L2))
 		return -EINVAL;
 
 	rsc_seg_len = le16_to_cpu(rx_desc->misc.rscseglen);
 	if (unlikely(!rsc_seg_len))
 		return -EINVAL;
 
-	ipv4 = IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV4);
-	ipv6 = IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV6);
+	ipv4 = parsed.outer_ip == LIBIE_RX_PTYPE_OUTER_IPV4;
+	ipv6 = parsed.outer_ip == LIBIE_RX_PTYPE_OUTER_IPV6;
 
 	if (unlikely(!(ipv4 ^ ipv6)))
 		return -EINVAL;
@@ -2935,30 +2899,25 @@ static int idpf_rx_process_skb_fields(struct idpf_queue *rxq,
 				      struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc)
 {
 	struct idpf_rx_csum_decoded csum_bits = { };
-	struct idpf_rx_ptype_decoded decoded;
+	struct libie_rx_ptype_parsed parsed;
 	u16 rx_ptype;
 
 	rx_ptype = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_PTYPE_M,
 			     le16_to_cpu(rx_desc->ptype_err_fflags0));
 
-	decoded = rxq->vport->rx_ptype_lkup[rx_ptype];
-	/* If we don't know the ptype we can't do anything else with it. Just
-	 * pass it up the stack as-is.
-	 */
-	if (!decoded.known)
-		return 0;
+	parsed = rxq->vport->rx_ptype_lkup[rx_ptype];
 
 	/* process RSS/hash */
-	idpf_rx_hash(rxq, skb, rx_desc, &decoded);
+	idpf_rx_hash(rxq, skb, rx_desc, parsed);
 
 	skb->protocol = eth_type_trans(skb, rxq->vport->netdev);
 
 	if (FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_RSC_M,
 		      le16_to_cpu(rx_desc->hdrlen_flags)))
-		return idpf_rx_rsc(rxq, skb, rx_desc, &decoded);
+		return idpf_rx_rsc(rxq, skb, rx_desc, parsed);
 
 	idpf_rx_splitq_extract_csum_bits(rx_desc, &csum_bits);
-	idpf_rx_csum(rxq, skb, &csum_bits, &decoded);
+	idpf_rx_csum(rxq, skb, csum_bits, parsed);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index e0660ede58ff..f082d3edeb9c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -4,6 +4,8 @@
 #ifndef _IDPF_TXRX_H_
 #define _IDPF_TXRX_H_
 
+#include <linux/net/intel/libie/rx.h>
+
 #include <net/page_pool/helpers.h>
 #include <net/tcp.h>
 #include <net/netdev_queues.h>
@@ -346,72 +348,6 @@ struct idpf_rx_buf {
 #define IDPF_RX_MAX_BASE_PTYPE	256
 #define IDPF_INVALID_PTYPE_ID	0xFFFF
 
-/* Packet type non-ip values */
-enum idpf_rx_ptype_l2 {
-	IDPF_RX_PTYPE_L2_RESERVED	= 0,
-	IDPF_RX_PTYPE_L2_MAC_PAY2	= 1,
-	IDPF_RX_PTYPE_L2_TIMESYNC_PAY2	= 2,
-	IDPF_RX_PTYPE_L2_FIP_PAY2	= 3,
-	IDPF_RX_PTYPE_L2_OUI_PAY2	= 4,
-	IDPF_RX_PTYPE_L2_MACCNTRL_PAY2	= 5,
-	IDPF_RX_PTYPE_L2_LLDP_PAY2	= 6,
-	IDPF_RX_PTYPE_L2_ECP_PAY2	= 7,
-	IDPF_RX_PTYPE_L2_EVB_PAY2	= 8,
-	IDPF_RX_PTYPE_L2_QCN_PAY2	= 9,
-	IDPF_RX_PTYPE_L2_EAPOL_PAY2	= 10,
-	IDPF_RX_PTYPE_L2_ARP		= 11,
-};
-
-enum idpf_rx_ptype_outer_ip {
-	IDPF_RX_PTYPE_OUTER_L2	= 0,
-	IDPF_RX_PTYPE_OUTER_IP	= 1,
-};
-
-#define IDPF_RX_PTYPE_TO_IPV(ptype, ipv)			\
-	(((ptype)->outer_ip == IDPF_RX_PTYPE_OUTER_IP) &&	\
-	 ((ptype)->outer_ip_ver == (ipv)))
-
-enum idpf_rx_ptype_outer_ip_ver {
-	IDPF_RX_PTYPE_OUTER_NONE	= 0,
-	IDPF_RX_PTYPE_OUTER_IPV4	= 1,
-	IDPF_RX_PTYPE_OUTER_IPV6	= 2,
-};
-
-enum idpf_rx_ptype_outer_fragmented {
-	IDPF_RX_PTYPE_NOT_FRAG	= 0,
-	IDPF_RX_PTYPE_FRAG	= 1,
-};
-
-enum idpf_rx_ptype_tunnel_type {
-	IDPF_RX_PTYPE_TUNNEL_NONE		= 0,
-	IDPF_RX_PTYPE_TUNNEL_IP_IP		= 1,
-	IDPF_RX_PTYPE_TUNNEL_IP_GRENAT		= 2,
-	IDPF_RX_PTYPE_TUNNEL_IP_GRENAT_MAC	= 3,
-	IDPF_RX_PTYPE_TUNNEL_IP_GRENAT_MAC_VLAN	= 4,
-};
-
-enum idpf_rx_ptype_tunnel_end_prot {
-	IDPF_RX_PTYPE_TUNNEL_END_NONE	= 0,
-	IDPF_RX_PTYPE_TUNNEL_END_IPV4	= 1,
-	IDPF_RX_PTYPE_TUNNEL_END_IPV6	= 2,
-};
-
-enum idpf_rx_ptype_inner_prot {
-	IDPF_RX_PTYPE_INNER_PROT_NONE		= 0,
-	IDPF_RX_PTYPE_INNER_PROT_UDP		= 1,
-	IDPF_RX_PTYPE_INNER_PROT_TCP		= 2,
-	IDPF_RX_PTYPE_INNER_PROT_SCTP		= 3,
-	IDPF_RX_PTYPE_INNER_PROT_ICMP		= 4,
-	IDPF_RX_PTYPE_INNER_PROT_TIMESYNC	= 5,
-};
-
-enum idpf_rx_ptype_payload_layer {
-	IDPF_RX_PTYPE_PAYLOAD_LAYER_NONE	= 0,
-	IDPF_RX_PTYPE_PAYLOAD_LAYER_PAY2	= 1,
-	IDPF_RX_PTYPE_PAYLOAD_LAYER_PAY3	= 2,
-	IDPF_RX_PTYPE_PAYLOAD_LAYER_PAY4	= 3,
-};
-
 enum idpf_tunnel_state {
 	IDPF_PTYPE_TUNNEL_IP                    = BIT(0),
 	IDPF_PTYPE_TUNNEL_IP_GRENAT             = BIT(1),
@@ -419,22 +355,9 @@ enum idpf_tunnel_state {
 };
 
 struct idpf_ptype_state {
-	bool outer_ip;
-	bool outer_frag;
-	u8 tunnel_state;
-};
-
-struct idpf_rx_ptype_decoded {
-	u32 ptype:10;
-	u32 known:1;
-	u32 outer_ip:1;
-	u32 outer_ip_ver:2;
-	u32 outer_frag:1;
-	u32 tunnel_type:3;
-	u32 tunnel_end_prot:2;
-	u32 tunnel_end_frag:1;
-	u32 inner_prot:4;
-	u32 payload_layer:3;
+	bool outer_ip:1;
+	bool outer_frag:1;
+	u8 tunnel_state:6;
 };
 
 /**
@@ -1014,7 +937,6 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport);
 void idpf_vport_intr_update_itr_ena_irq(struct idpf_q_vector *q_vector);
 void idpf_vport_intr_deinit(struct idpf_vport *vport);
 int idpf_vport_intr_init(struct idpf_vport *vport);
-enum pkt_hash_types idpf_ptype_to_htype(const struct idpf_rx_ptype_decoded *decoded);
 int idpf_config_rss(struct idpf_vport *vport);
 int idpf_init_rss(struct idpf_vport *vport);
 void idpf_deinit_rss(struct idpf_vport *vport);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d0cdd63b3d5b..98c904f4dcf5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2614,39 +2614,52 @@ int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport, bool get)
  * @frag: fragmentation allowed
  *
  */
-static void idpf_fill_ptype_lookup(struct idpf_rx_ptype_decoded *ptype,
+static void idpf_fill_ptype_lookup(struct libie_rx_ptype_parsed *ptype,
 				   struct idpf_ptype_state *pstate,
 				   bool ipv4, bool frag)
 {
 	if (!pstate->outer_ip || !pstate->outer_frag) {
-		ptype->outer_ip = IDPF_RX_PTYPE_OUTER_IP;
 		pstate->outer_ip = true;
 
 		if (ipv4)
-			ptype->outer_ip_ver = IDPF_RX_PTYPE_OUTER_IPV4;
+			ptype->outer_ip = LIBIE_RX_PTYPE_OUTER_IPV4;
 		else
-			ptype->outer_ip_ver = IDPF_RX_PTYPE_OUTER_IPV6;
+			ptype->outer_ip = LIBIE_RX_PTYPE_OUTER_IPV6;
 
 		if (frag) {
-			ptype->outer_frag = IDPF_RX_PTYPE_FRAG;
+			ptype->outer_frag = LIBIE_RX_PTYPE_FRAG;
 			pstate->outer_frag = true;
 		}
 	} else {
-		ptype->tunnel_type = IDPF_RX_PTYPE_TUNNEL_IP_IP;
+		ptype->tunnel_type = LIBIE_RX_PTYPE_TUNNEL_IP_IP;
 		pstate->tunnel_state = IDPF_PTYPE_TUNNEL_IP;
 
 		if (ipv4)
 			ptype->tunnel_end_prot =
-					IDPF_RX_PTYPE_TUNNEL_END_IPV4;
+					LIBIE_RX_PTYPE_TUNNEL_END_IPV4;
 		else
 			ptype->tunnel_end_prot =
-					IDPF_RX_PTYPE_TUNNEL_END_IPV6;
+					LIBIE_RX_PTYPE_TUNNEL_END_IPV6;
 
 		if (frag)
-			ptype->tunnel_end_frag = IDPF_RX_PTYPE_FRAG;
+			ptype->tunnel_end_frag = LIBIE_RX_PTYPE_FRAG;
 	}
 }
 
+static void idpf_finalize_ptype_lookup(struct libie_rx_ptype_parsed *ptype)
+{
+	if (ptype->payload_layer == LIBIE_RX_PTYPE_PAYLOAD_L2 &&
+	    ptype->inner_prot)
+		ptype->payload_layer = LIBIE_RX_PTYPE_PAYLOAD_L4;
+	else if (ptype->payload_layer == LIBIE_RX_PTYPE_PAYLOAD_L2 &&
+		 ptype->outer_ip)
+		ptype->payload_layer = LIBIE_RX_PTYPE_PAYLOAD_L3;
+	else if (ptype->outer_ip == LIBIE_RX_PTYPE_OUTER_L2)
+		ptype->payload_layer = LIBIE_RX_PTYPE_PAYLOAD_L2;
+	else
+		ptype->payload_layer = LIBIE_RX_PTYPE_PAYLOAD_NONE;
+}
+
 /**
  * idpf_send_get_rx_ptype_msg - Send virtchnl for ptype info
  * @vport: virtual port data structure
@@ -2655,7 +2668,7 @@ static void idpf_fill_ptype_lookup(struct idpf_rx_ptype_decoded *ptype,
  */
 int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport)
 {
-	struct idpf_rx_ptype_decoded *ptype_lkup = vport->rx_ptype_lkup;
+	struct libie_rx_ptype_parsed *ptype_lkup = vport->rx_ptype_lkup;
 	struct virtchnl2_get_ptype_info get_ptype_info;
 	int max_ptype, ptypes_recvd = 0, ptype_offset;
 	struct idpf_adapter *adapter = vport->adapter;
@@ -2736,9 +2749,6 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport)
 			else
 				k = ptype->ptype_id_8;
 
-			if (ptype->proto_id_count)
-				ptype_lkup[k].known = 1;
-
 			for (j = 0; j < ptype->proto_id_count; j++) {
 				id = le16_to_cpu(ptype->proto_id[j]);
 				switch (id) {
@@ -2746,18 +2756,18 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport)
 					if (pstate.tunnel_state ==
 							IDPF_PTYPE_TUNNEL_IP) {
 						ptype_lkup[k].tunnel_type =
-						IDPF_RX_PTYPE_TUNNEL_IP_GRENAT;
+						LIBIE_RX_PTYPE_TUNNEL_IP_GRENAT;
 						pstate.tunnel_state |=
 						IDPF_PTYPE_TUNNEL_IP_GRENAT;
 					}
 					break;
 				case VIRTCHNL2_PROTO_HDR_MAC:
 					ptype_lkup[k].outer_ip =
-						IDPF_RX_PTYPE_OUTER_L2;
+						LIBIE_RX_PTYPE_OUTER_L2;
 					if (pstate.tunnel_state ==
 							IDPF_TUN_IP_GRE) {
 						ptype_lkup[k].tunnel_type =
-						IDPF_RX_PTYPE_TUNNEL_IP_GRENAT_MAC;
+						LIBIE_RX_PTYPE_TUNNEL_IP_GRENAT_MAC;
 						pstate.tunnel_state |=
 						IDPF_PTYPE_TUNNEL_IP_GRENAT_MAC;
 					}
@@ -2784,23 +2794,23 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport)
 					break;
 				case VIRTCHNL2_PROTO_HDR_UDP:
 					ptype_lkup[k].inner_prot =
-					IDPF_RX_PTYPE_INNER_PROT_UDP;
+					LIBIE_RX_PTYPE_INNER_UDP;
 					break;
 				case VIRTCHNL2_PROTO_HDR_TCP:
 					ptype_lkup[k].inner_prot =
-					IDPF_RX_PTYPE_INNER_PROT_TCP;
+					LIBIE_RX_PTYPE_INNER_TCP;
 					break;
 				case VIRTCHNL2_PROTO_HDR_SCTP:
 					ptype_lkup[k].inner_prot =
-					IDPF_RX_PTYPE_INNER_PROT_SCTP;
+					LIBIE_RX_PTYPE_INNER_SCTP;
 					break;
 				case VIRTCHNL2_PROTO_HDR_ICMP:
 					ptype_lkup[k].inner_prot =
-					IDPF_RX_PTYPE_INNER_PROT_ICMP;
+					LIBIE_RX_PTYPE_INNER_ICMP;
 					break;
 				case VIRTCHNL2_PROTO_HDR_PAY:
 					ptype_lkup[k].payload_layer =
-						IDPF_RX_PTYPE_PAYLOAD_LAYER_PAY2;
+						LIBIE_RX_PTYPE_PAYLOAD_L2;
 					break;
 				case VIRTCHNL2_PROTO_HDR_ICMPV6:
 				case VIRTCHNL2_PROTO_HDR_IPV6_EH:
@@ -2854,6 +2864,8 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport)
 					break;
 				}
 			}
+
+			idpf_finalize_ptype_lookup(&ptype_lkup[k]);
 		}
 	}
 
-- 
2.43.0


