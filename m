Return-Path: <linux-kernel+bounces-10229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7352D81D197
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D521C22A7C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F39224DC;
	Sat, 23 Dec 2023 02:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aomeJIhD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDDA241FC;
	Sat, 23 Dec 2023 02:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300335; x=1734836335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w7O2LkdFgRPFTPe5I5rq1IJGyzwbW3hKjP3uSaNFJgU=;
  b=aomeJIhDMWUS19petCbIpHh2n5/LzFo5q7N6LgbxFWfx77iGJZNdLHSE
   6nKxXK8uf1R9iz2OAsCRcRhQn0JYdJaB21WirdocXB2Ec3KkCi7sc74SG
   HrPPUFqMjTt7hRQBmoffxWdRr1uRloHM87BsknrM0QOfMyqYoHUTvV7VH
   Yr/3aMnsgLQ2FFsMQk6KdexehADQ4ydMqqgcDIR3ECMy0xr7Z200R03lj
   YZTzya8BGUzLOlSX/4a7DsU6UpULHjNMjoj+Z8qR3BF3R3z9CKfra0/d7
   Sg52WDcwC7xJ2YKKXMLnKV/wvAjQ1s0YlkFuTS9y1mzqJKmWy++4fyIsR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386610873"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386610873"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:58:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537497"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:58:50 -0800
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
Subject: [PATCH RFC net-next 13/34] xdp: add generic xdp_build_skb_from_buff()
Date: Sat, 23 Dec 2023 03:55:33 +0100
Message-ID: <20231223025554.2316836-14-aleksander.lobakin@intel.com>
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

The code which builds an skb from an &xdp_buff keeps multiplying itself
around the drivers with almost no changes. Let's try to stop that by
adding a generic function.
There's __xdp_build_skb_from_frame() already, so just convert it to take
&xdp_buff instead, while making the original one a wrapper. The original
one always took an already allocated skb, allow both variants here -- if
no skb passed, which is expected when calling from a driver, pick one via
napi_build_skb().

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp.h |  4 +++
 net/core/xdp.c    | 89 +++++++++++++++++++++++++++++++----------------
 2 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index a3dc0f39b437..4fcf0ac48345 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -276,6 +276,10 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
 void xdp_warn(const char *msg, const char *func, const int line);
 #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
 
+struct sk_buff *__xdp_build_skb_from_buff(struct sk_buff *skb,
+					  const struct xdp_buff *xdp);
+#define xdp_build_skb_from_buff(xdp) __xdp_build_skb_from_buff(NULL, xdp)
+
 struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct sk_buff *skb,
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 03ebdb21ea62..ed73b97472b4 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -609,45 +609,77 @@ int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(xdp_alloc_skb_bulk);
 
-struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
-					   struct sk_buff *skb,
-					   struct net_device *dev)
+struct sk_buff *__xdp_build_skb_from_buff(struct sk_buff *skb,
+					  const struct xdp_buff *xdp)
 {
-	struct skb_shared_info *sinfo = xdp_get_shared_info_from_frame(xdpf);
-	unsigned int headroom, frame_size;
-	void *hard_start;
-	u8 nr_frags;
+	const struct xdp_rxq_info *rxq = xdp->rxq;
+	const struct skb_shared_info *sinfo;
+	u32 nr_frags = 0;
 
 	/* xdp frags frame */
-	if (unlikely(xdp_frame_has_frags(xdpf)))
+	if (unlikely(xdp_buff_has_frags(xdp))) {
+		sinfo = xdp_get_shared_info_from_buff(xdp);
 		nr_frags = sinfo->nr_frags;
+	}
 
-	/* Part of headroom was reserved to xdpf */
-	headroom = sizeof(*xdpf) + xdpf->headroom;
+	net_prefetch(xdp->data_meta);
 
-	/* Memory size backing xdp_frame data already have reserved
-	 * room for build_skb to place skb_shared_info in tailroom.
-	 */
-	frame_size = xdpf->frame_sz;
+	if (!skb) {
+		skb = napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
+		if (unlikely(!skb))
+			return NULL;
+	} else {
+		/* build_skb_around() can return NULL only when !skb, which
+		 * is impossible here.
+		 */
+		build_skb_around(skb, xdp->data_hard_start, xdp->frame_sz);
+	}
 
-	hard_start = xdpf->data - headroom;
-	skb = build_skb_around(skb, hard_start, frame_size);
-	if (unlikely(!skb))
-		return NULL;
+	skb_reserve(skb, xdp->data - xdp->data_hard_start);
+	__skb_put(skb, xdp->data_end - xdp->data);
+	if (xdp->data > xdp->data_meta)
+		skb_metadata_set(skb, xdp->data - xdp->data_meta);
+
+	if (rxq->mem.type == MEM_TYPE_PAGE_POOL)
+		skb_mark_for_recycle(skb);
 
-	skb_reserve(skb, headroom);
-	__skb_put(skb, xdpf->len);
-	if (xdpf->metasize)
-		skb_metadata_set(skb, xdpf->metasize);
+	/* __xdp_rxq_info_reg() sets these two together */
+	if (rxq->reg_state == REG_STATE_REGISTERED)
+		skb_record_rx_queue(skb, rxq->queue_index);
+
+	if (unlikely(nr_frags)) {
+		u32 truesize = sinfo->xdp_frags_truesize ? :
+			       nr_frags * xdp->frame_sz;
 
-	if (unlikely(xdp_frame_has_frags(xdpf)))
 		xdp_update_skb_shared_info(skb, nr_frags,
-					   sinfo->xdp_frags_size,
-					   nr_frags * xdpf->frame_sz,
-					   xdp_frame_is_frag_pfmemalloc(xdpf));
+					   sinfo->xdp_frags_size, truesize,
+					   xdp_buff_is_frag_pfmemalloc(xdp));
+	}
 
 	/* Essential SKB info: protocol and skb->dev */
-	skb->protocol = eth_type_trans(skb, dev);
+	skb->protocol = eth_type_trans(skb, rxq->dev);
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(__xdp_build_skb_from_buff);
+
+struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
+					   struct sk_buff *skb,
+					   struct net_device *dev)
+{
+	struct xdp_rxq_info rxq = {
+		.dev		= dev,
+		.mem		= xdpf->mem,
+	};
+	struct xdp_buff xdp;
+
+	/* Check early instead of delegating it to build_skb_around() */
+	if (unlikely(!skb))
+		return NULL;
+
+	xdp.rxq = &rxq;
+	xdp_convert_frame_to_buff(xdpf, &xdp);
+	__xdp_build_skb_from_buff(skb, &xdp);
 
 	/* Optional SKB info, currently missing:
 	 * - HW checksum info		(skb->ip_summed)
@@ -655,9 +687,6 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 	 * - RX ring dev queue index	(skb_record_rx_queue)
 	 */
 
-	if (xdpf->mem.type == MEM_TYPE_PAGE_POOL)
-		skb_mark_for_recycle(skb);
-
 	/* Allow SKB to reuse area used by xdp_frame */
 	xdp_scrub_frame(xdpf);
 
-- 
2.43.0


