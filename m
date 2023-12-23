Return-Path: <linux-kernel+bounces-10241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C47981D1AF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DD0CB244E8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101FB38DCC;
	Sat, 23 Dec 2023 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KgpMNTpM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AC2381D9;
	Sat, 23 Dec 2023 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300381; x=1734836381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vBLq+bSc90hU1HHgtTujEszVAfYomJgRRmZIp5oafNw=;
  b=KgpMNTpMHEveGBfy/CV+TPZH3CG5dMunsdBMtmT+eLHkOU1DEGDqparU
   4Bt/dxr9FdhIUwOowWK9VcqVmHtiLbHCTqCrqyOUBbcYhy9zC8hCcWUps
   X3Zn4l1ElI8vsRM7KSvuQqpnLQ/slNkXc8+byLRaYbPLOrmxKIhhPI4gv
   y3b7Kem20FJT5AO9GO1JtT3zaq/0IqTrJDYGjkXFd3jygyfX4LzUjn6cZ
   Ij2x2Bs0hSZ7vANq4L7/LqsfvPQASEn1y6EWPh1W8jvCdSVRj6gz4xFt/
   IksZy8iAynQg/1PJlcr2EQMwo/7+XbYC3weTTbnTF+hHfiODW3Y2Hf/Ig
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386611034"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386611034"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:59:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537631"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:59:38 -0800
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
Subject: [PATCH RFC net-next 25/34] idpf: add support for .ndo_xdp_xmit()
Date: Sat, 23 Dec 2023 03:55:45 +0100
Message-ID: <20231223025554.2316836-26-aleksander.lobakin@intel.com>
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

Use libie XDP infra to implement .ndo_xdp_xmit() in idpf.
The Tx callbacks are reused from XDP_TX code. XDP redirect target
feature is set/cleared depending on the XDP prog presence, as for now
we still don't allocate XDP Tx queues when there's no program.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c |  1 +
 drivers/net/ethernet/intel/idpf/idpf_xdp.c | 34 ++++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_xdp.h |  2 ++
 3 files changed, 37 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index a19704c4c421..7c3d45f84e1b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2451,6 +2451,7 @@ static const struct net_device_ops idpf_netdev_ops_splitq = {
 	.ndo_set_features = idpf_set_features,
 	.ndo_tx_timeout = idpf_tx_timeout,
 	.ndo_bpf = idpf_xdp,
+	.ndo_xdp_xmit = idpf_xdp_xmit,
 };
 
 static const struct net_device_ops idpf_netdev_ops_singleq = {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_xdp.c b/drivers/net/ethernet/intel/idpf/idpf_xdp.c
index b9952ebda4fb..b4f096186302 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_xdp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_xdp.c
@@ -313,6 +313,35 @@ bool __idpf_xdp_run_prog(struct xdp_buff *xdp, struct libie_xdp_tx_bulk *bq)
 	return libie_xdp_run_prog(xdp, bq, idpf_xdp_tx_flush_bulk);
 }
 
+/**
+ * idpf_xdp_xmit - submit packets to xdp ring for transmission
+ * @dev: netdev
+ * @n: number of xdp frames to be transmitted
+ * @frames: xdp frames to be transmitted
+ * @flags: transmit flags
+ *
+ * Returns number of frames successfully sent. Frames that fail are
+ * free'ed via XDP return API.
+ * For error cases, a negative errno code is returned and no-frames
+ * are transmitted (caller must handle freeing frames).
+ */
+int idpf_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
+		  u32 flags)
+{
+	struct idpf_netdev_priv *np = netdev_priv(dev);
+	struct idpf_vport *vport = np->vport;
+
+	if (unlikely(!netif_carrier_ok(dev) || !vport->link_up))
+		return -ENETDOWN;
+	if (unlikely(!idpf_xdp_is_prog_ena(vport)))
+		return -ENXIO;
+
+	return libie_xdp_xmit_do_bulk(dev, n, frames, flags,
+				      &vport->txqs[vport->xdp_txq_offset],
+				      vport->num_xdp_txq, idpf_xdp_tx_prep,
+				      idpf_xdp_tx_xmit, idpf_xdp_tx_finalize);
+}
+
 /**
  * idpf_xdp_reconfig_queues - reconfigure queues after the XDP setup
  * @vport: vport to load or unload XDP for
@@ -410,6 +439,11 @@ idpf_xdp_setup_prog(struct idpf_vport *vport, struct bpf_prog *prog,
 		return err;
 	}
 
+	if (prog)
+		xdp_features_set_redirect_target(vport->netdev, false);
+	else
+		xdp_features_clear_redirect_target(vport->netdev);
+
 	if (vport_is_up) {
 		err = idpf_vport_open(vport, false);
 		if (err) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_xdp.h b/drivers/net/ethernet/intel/idpf/idpf_xdp.h
index 1f299c268ca5..f1444482f69d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_xdp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_xdp.h
@@ -31,6 +31,8 @@ static inline void idpf_xdp_finalize_rx(struct libie_xdp_tx_bulk *bq)
 		__idpf_xdp_finalize_rx(bq);
 }
 
+int idpf_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
+		  u32 flags);
 int idpf_xdp(struct net_device *netdev, struct netdev_bpf *xdp);
 
 #endif /* _IDPF_XDP_H_ */
-- 
2.43.0


