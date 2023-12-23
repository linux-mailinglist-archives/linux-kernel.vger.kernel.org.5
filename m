Return-Path: <linux-kernel+bounces-10250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1D381D1C1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5997A283129
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC553FB07;
	Sat, 23 Dec 2023 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJD26Wo8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E893F8D3;
	Sat, 23 Dec 2023 03:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300417; x=1734836417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B3hwJC99k6mjwP2SBzKX/gmp6IEmR5LqHfeVCYUgddI=;
  b=JJD26Wo8zJLaN5p3PfSjSGnO77Lulozu/LpPpGUpcA+L+sH6yd3bBgjE
   Ghg3cWD0qZ0YP4F2Kkd9aKC468RHQoWXuI09v7J2c1yTIrAW9OkVI9iGU
   bRTP3JwKP3J9iq3PH4YSXutjMm9IX+fPTi8yCDUHi8cV2T+kRGNeMc3GR
   +3MuNUJa/yO9IZFzWyogXOd7d44G/RmOK4eUba/9VogpFZ5TfGPpy5BFM
   4EWFYMdxMLxuYB31pjkhcRuZRGoodVUNuA16pgg+zh/RgPPUSRhkOGmoI
   Tj5fCA69m4oqUu+iipcgXk+Dn+j5Tiq20tZqeb+dw3YT64sf+BqlFmrhe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386611122"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386611122"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537692"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 19:00:13 -0800
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
Subject: [PATCH RFC net-next 34/34] idpf: enable XSk features and ndo_xsk_wakeup
Date: Sat, 23 Dec 2023 03:55:54 +0100
Message-ID: <20231223025554.2316836-35-aleksander.lobakin@intel.com>
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

Now that AF_XDP functionality is fully implemented, advertise XSk XDP
feature and add .ndo_xsk_wakeup() callback to be able to use it with
this driver.

Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c |  5 ++-
 drivers/net/ethernet/intel/idpf/idpf_xsk.c | 42 ++++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_xsk.h |  2 ++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 7c3d45f84e1b..af4f708b82f3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -3,6 +3,7 @@
 
 #include "idpf.h"
 #include "idpf_xdp.h"
+#include "idpf_xsk.h"
 
 static const struct net_device_ops idpf_netdev_ops_splitq;
 static const struct net_device_ops idpf_netdev_ops_singleq;
@@ -844,7 +845,8 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	if (idpf_is_queue_model_split(vport->rxq_model))
 		xdp_set_features_flag(netdev, NETDEV_XDP_ACT_BASIC |
 					      NETDEV_XDP_ACT_REDIRECT |
-					      NETDEV_XDP_ACT_RX_SG);
+					      NETDEV_XDP_ACT_RX_SG |
+					      NETDEV_XDP_ACT_XSK_ZEROCOPY);
 
 	idpf_set_ethtool_ops(netdev);
 	SET_NETDEV_DEV(netdev, &adapter->pdev->dev);
@@ -2452,6 +2454,7 @@ static const struct net_device_ops idpf_netdev_ops_splitq = {
 	.ndo_tx_timeout = idpf_tx_timeout,
 	.ndo_bpf = idpf_xdp,
 	.ndo_xdp_xmit = idpf_xdp_xmit,
+	.ndo_xsk_wakeup = idpf_xsk_wakeup,
 };
 
 static const struct net_device_ops idpf_netdev_ops_singleq = {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_xsk.c b/drivers/net/ethernet/intel/idpf/idpf_xsk.c
index 01231e828f6a..aff37c6a5adb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_xsk.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_xsk.c
@@ -1137,3 +1137,45 @@ bool idpf_xmit_zc(struct idpf_queue *complq)
 
 	return result;
 }
+
+/**
+ * idpf_xsk_wakeup - Implements ndo_xsk_wakeup
+ * @netdev: net_device
+ * @queue_id: queue to wake up
+ * @flags: ignored in our case, since we have Rx and Tx in the same NAPI
+ *
+ * Returns negative on error, zero otherwise.
+ */
+int idpf_xsk_wakeup(struct net_device *netdev, u32 qid, u32 flags)
+{
+	struct idpf_netdev_priv *np = netdev_priv(netdev);
+	struct idpf_vport *vport = np->vport;
+	struct idpf_q_vector *q_vector;
+	struct idpf_queue *q;
+	int idx;
+
+	if (idpf_vport_ctrl_is_locked(netdev))
+		return -EBUSY;
+
+	if (unlikely(!vport->link_up))
+		return -ENETDOWN;
+
+	if (unlikely(!idpf_xdp_is_prog_ena(vport)))
+		return -ENXIO;
+
+	idx = qid + vport->xdp_txq_offset;
+
+	if (unlikely(idx >= vport->num_txq))
+		return -ENXIO;
+
+	if (unlikely(!test_bit(__IDPF_Q_XSK, vport->txqs[idx]->flags)))
+		return -ENXIO;
+
+	q = vport->txqs[idx];
+	q_vector = q->txq_grp->complq->q_vector;
+
+	if (!napi_if_scheduled_mark_missed(&q_vector->napi))
+		idpf_trigger_sw_intr(&vport->adapter->hw, q_vector);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_xsk.h b/drivers/net/ethernet/intel/idpf/idpf_xsk.h
index 51ddf2e36577..446ca971f37e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_xsk.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_xsk.h
@@ -10,6 +10,7 @@ enum virtchnl2_queue_type;
 
 struct idpf_queue;
 struct idpf_vport;
+struct net_device;
 struct xsk_buff_pool;
 
 void idpf_xsk_setup_queue(struct idpf_queue *q, enum virtchnl2_queue_type t);
@@ -24,5 +25,6 @@ bool idpf_xmit_zc(struct idpf_queue *complq);
 
 int idpf_xsk_pool_setup(struct idpf_vport *vport, struct xsk_buff_pool *pool,
 			u32 qid);
+int idpf_xsk_wakeup(struct net_device *netdev, u32 qid, u32 flags);
 
 #endif /* !_IDPF_XSK_H_ */
-- 
2.43.0


