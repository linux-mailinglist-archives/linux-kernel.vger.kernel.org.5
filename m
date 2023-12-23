Return-Path: <linux-kernel+bounces-10246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F8C81D1B9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C3C28609A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1A23C491;
	Sat, 23 Dec 2023 03:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHpdwHDj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136383C06A;
	Sat, 23 Dec 2023 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300401; x=1734836401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aYQdHCgMRF5nMXbGmL6Lo6tQCKIRvL6ThHkKSgt1nOY=;
  b=fHpdwHDjMTWRltW1AYtolldYXWoTuvBaHC5VTWLetpe15sr/aAXzKoFu
   U6WUcCRz6CL1OB43hwHqYM3FoeFx2wdcQBhKIMZAGiTLTMH9qNvXF8eeM
   n7FM1hy4N9Z1Kv+TNeS34IiM54AE8JpKJ9YG1znhguAAes74nKsDcfb2+
   a4SAyTQ/pmc0zBfCFVegcFxi6jmpqaZnuQ1vCLaENLz3XQnx7AVjYvzO+
   13J7RHETJjbqK/UNRpoVYhL1c8Z92DFhMrSY84B58HliiewILgQIiLTFz
   IfJeUZyygqdAap4aJWUlFrSBSCXW9wvGCtxkfqdJifvA6trxujcwGGYYI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386611078"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386611078"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:00:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537663"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:59:57 -0800
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
Subject: [PATCH RFC net-next 30/34] idpf: move search rx and tx queues to header
Date: Sat, 23 Dec 2023 03:55:50 +0100
Message-ID: <20231223025554.2316836-31-aleksander.lobakin@intel.com>
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

From: Michal Kubiak <michal.kubiak@intel.com>

Move Rx and Tx queue lookup functions from the ethtool implementation to
the idpf header.
Now, those functions can be used globally, including XDP configuration.

Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        | 41 +++++++++++++++++++
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 39 ------------------
 2 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index a12c56f9f2ef..d99ebd045c4e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -696,6 +696,47 @@ static inline int idpf_is_queue_model_split(u16 q_model)
 	return q_model == VIRTCHNL2_QUEUE_MODEL_SPLIT;
 }
 
+/**
+ * idpf_find_rxq - find rxq from q index
+ * @vport: virtual port associated to queue
+ * @q_num: q index used to find queue
+ *
+ * returns pointer to rx queue
+ */
+static inline struct idpf_queue *
+idpf_find_rxq(struct idpf_vport *vport, int q_num)
+{
+	int q_grp, q_idx;
+
+	if (!idpf_is_queue_model_split(vport->rxq_model))
+		return vport->rxq_grps->singleq.rxqs[q_num];
+
+	q_grp = q_num / IDPF_DFLT_SPLITQ_RXQ_PER_GROUP;
+	q_idx = q_num % IDPF_DFLT_SPLITQ_RXQ_PER_GROUP;
+
+	return &vport->rxq_grps[q_grp].splitq.rxq_sets[q_idx]->rxq;
+}
+
+/**
+ * idpf_find_txq - find txq from q index
+ * @vport: virtual port associated to queue
+ * @q_num: q index used to find queue
+ *
+ * returns pointer to tx queue
+ */
+static inline struct idpf_queue *
+idpf_find_txq(struct idpf_vport *vport, int q_num)
+{
+	int q_grp;
+
+	if (!idpf_is_queue_model_split(vport->txq_model))
+		return vport->txqs[q_num];
+
+	q_grp = q_num / IDPF_DFLT_SPLITQ_TXQ_PER_GROUP;
+
+	return vport->txq_grps[q_grp].complq;
+}
+
 /**
  * idpf_xdp_is_prog_ena - check if there is an XDP program on adapter
  * @vport: vport to check
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 0d192417205d..f7ec679c9b16 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -953,45 +953,6 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 	idpf_vport_ctrl_unlock(netdev);
 }
 
-/**
- * idpf_find_rxq - find rxq from q index
- * @vport: virtual port associated to queue
- * @q_num: q index used to find queue
- *
- * returns pointer to rx queue
- */
-static struct idpf_queue *idpf_find_rxq(struct idpf_vport *vport, int q_num)
-{
-	int q_grp, q_idx;
-
-	if (!idpf_is_queue_model_split(vport->rxq_model))
-		return vport->rxq_grps->singleq.rxqs[q_num];
-
-	q_grp = q_num / IDPF_DFLT_SPLITQ_RXQ_PER_GROUP;
-	q_idx = q_num % IDPF_DFLT_SPLITQ_RXQ_PER_GROUP;
-
-	return &vport->rxq_grps[q_grp].splitq.rxq_sets[q_idx]->rxq;
-}
-
-/**
- * idpf_find_txq - find txq from q index
- * @vport: virtual port associated to queue
- * @q_num: q index used to find queue
- *
- * returns pointer to tx queue
- */
-static struct idpf_queue *idpf_find_txq(struct idpf_vport *vport, int q_num)
-{
-	int q_grp;
-
-	if (!idpf_is_queue_model_split(vport->txq_model))
-		return vport->txqs[q_num];
-
-	q_grp = q_num / IDPF_DFLT_SPLITQ_TXQ_PER_GROUP;
-
-	return vport->txq_grps[q_grp].complq;
-}
-
 /**
  * __idpf_get_q_coalesce - get ITR values for specific queue
  * @ec: ethtool structure to fill with driver's coalesce settings
-- 
2.43.0


