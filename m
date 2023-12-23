Return-Path: <linux-kernel+bounces-10244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B62081D1B5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7B41C22ADA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E003B290;
	Sat, 23 Dec 2023 02:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7U6cbn7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461603A8EF;
	Sat, 23 Dec 2023 02:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300393; x=1734836393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iIBWKyIWEBkirTUyFRzlT8kDZ54sFD3qq2HToLFVqMI=;
  b=Z7U6cbn73RX3JgTSbztC91KjkplTW/3AIFA3gepFZNeXLjZZKdMTduGU
   hmqgCLQksrK6QPCnpkUnhd65jZwoCSEf0n1+mAFvg3mA6MiEePWXRILf1
   zmcPkKCeFYrn6P2NFQ2VAaCpJ+GyIQqRiAspLujdyQbtdg89ObayxBM6T
   suL0snSROuhvBN2GkeGfRe05Q9r2alR6oVks4+mkKE1KATZ44QMVYstkG
   MPT1Bi7kQUfDQ8r4akxTxJWE8oFRyMeM+6lnroGNHLWAz3IPhhNcjIgIh
   Pk60YPK7RHu6gIuyUDlXUCdfB1nZkhKDGSKYLsFnYNx3L5foufAb7t0IA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386611059"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386611059"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:59:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537655"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:59:50 -0800
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
Subject: [PATCH RFC net-next 28/34] idpf: add relative queue id member to idpf_queue
Date: Sat, 23 Dec 2023 03:55:48 +0100
Message-ID: <20231223025554.2316836-29-aleksander.lobakin@intel.com>
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

Relative queue id is one of the required fields of the Tx queue
description in VC 2.0 for splitq mode.
In the current VC implementation all Tx queues are configured
together, so the relative queue id (the index of the Tx queue
in the queue group) can be computed on the fly.

However, such a solution is not flexible because it is not easy to
configure a single Tx queue. So, instead, introduce a new structure
member in 'idpf_queue' dedicated to storing the relative queue id.
Then send that value over the VC.

This patch is the first step in making the existing VC API more flexible
to allow configuration of single queues.

Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c     | 1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.h     | 2 ++
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 99c9b889507b..3dc21731df2f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1276,6 +1276,7 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
 			q->tx_min_pkt_len = idpf_get_min_tx_pkt_len(adapter);
 			q->vport = vport;
 			q->txq_grp = tx_qgrp;
+			q->relative_q_id = j;
 
 			if (!flow_sch_en)
 				continue;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index fa21feddd204..f32d854fe850 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -665,6 +665,8 @@ struct idpf_queue {
 
 	dma_addr_t dma;
 	unsigned int size;
+
+	u32 relative_q_id;
 } ____cacheline_internodealigned_in_smp;
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 59b8bbebead7..49a96af52343 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1491,7 +1491,8 @@ static int idpf_send_config_tx_queues_msg(struct idpf_vport *vport)
 
 				qi[k].tx_compl_queue_id =
 					cpu_to_le16(tx_qgrp->complq->q_id);
-				qi[k].relative_queue_id = cpu_to_le16(j);
+				qi[k].relative_queue_id =
+					cpu_to_le16(q->relative_q_id);
 
 				if (test_bit(__IDPF_Q_FLOW_SCH_EN, q->flags))
 					qi[k].sched_mode =
-- 
2.43.0


