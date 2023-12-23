Return-Path: <linux-kernel+bounces-10242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0358C81D1B1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB71B23C09
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B48839AE5;
	Sat, 23 Dec 2023 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dxWSx7yi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6535839FD9;
	Sat, 23 Dec 2023 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300386; x=1734836386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yxZYHXhn633FddOUdDcraFQxZakRgJVpB7yodhsBcbU=;
  b=dxWSx7yi1SeULGUBhFjT876DsNvVTOtyQQ0dAZrFGCzV8CIySEA+W1+v
   wHMA+yazUMdCFC4jxyMK9IdGbwyCzXglg3xQvNr6U5icLLTvlJoCV56Zm
   ncLvEAegztKXObmFAdup6YWfp/B+CkwxPX+w624azzvf6/Ez09rXEXjmH
   2n1vUumI9Y4lledZ8vRdvlCsZGMKnTemvArEt4prEjzBlY50DvbbnVBgH
   2J88DeMpAXXZK59Uk2jpMM85TjWuQsY/2x7SR7tFY6bC4VoeJd4GVLQzq
   EzOb3Iol/4GAX93zQ8uxpcVN5Idxt+9DWwSgJ0eLHSqi228iTld6Hn9EK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386611043"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386611043"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:59:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537644"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:59:42 -0800
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
Subject: [PATCH RFC net-next 26/34] xdp: add generic XSk xdp_buff -> skb conversion
Date: Sat, 23 Dec 2023 03:55:46 +0100
Message-ID: <20231223025554.2316836-27-aleksander.lobakin@intel.com>
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

Same as with converting &xdp_buff to skb on Rx, the code which allocates
a new skb and copies the XSk frame there is identical across the
drivers, so make it generic.
Note that this time skb_record_rx_queue() is called unconditionally, as
it's not intended to call this function with a non-registered RxQ info.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp.h | 11 ++++++++++-
 net/core/xdp.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 66854b755b58..23ada4bb0e69 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -273,7 +273,16 @@ void xdp_warn(const char *msg, const char *func, const int line);
 
 struct sk_buff *__xdp_build_skb_from_buff(struct sk_buff *skb,
 					  const struct xdp_buff *xdp);
-#define xdp_build_skb_from_buff(xdp) __xdp_build_skb_from_buff(NULL, xdp)
+struct sk_buff *xdp_build_skb_from_zc(struct napi_struct *napi,
+				      struct xdp_buff *xdp);
+
+static inline struct sk_buff *xdp_build_skb_from_buff(struct xdp_buff *xdp)
+{
+	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
+		return xdp_build_skb_from_zc(NULL, xdp);
+
+	return __xdp_build_skb_from_buff(NULL, xdp);
+}
 
 struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 8ef1d735a7eb..2bdb1fb8a9b8 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -21,6 +21,8 @@
 #include <trace/events/xdp.h>
 #include <net/xdp_sock_drv.h>
 
+#include "dev.h"
+
 #define REG_STATE_NEW		0x0
 #define REG_STATE_REGISTERED	0x1
 #define REG_STATE_UNREGISTERED	0x2
@@ -647,6 +649,45 @@ struct sk_buff *__xdp_build_skb_from_buff(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(__xdp_build_skb_from_buff);
 
+struct sk_buff *xdp_build_skb_from_zc(struct napi_struct *napi,
+				      struct xdp_buff *xdp)
+{
+	const struct xdp_rxq_info *rxq = xdp->rxq;
+	u32 totalsize, metasize;
+	struct sk_buff *skb;
+
+	if (!napi) {
+		napi = napi_by_id(rxq->napi_id);
+		if (unlikely(!napi))
+			return NULL;
+	}
+
+	totalsize = xdp->data_end - xdp->data_meta;
+
+	skb = __napi_alloc_skb(napi, totalsize, GFP_ATOMIC | __GFP_NOWARN);
+	if (unlikely(!skb))
+		return NULL;
+
+	net_prefetch(xdp->data_meta);
+
+	memcpy(__skb_put(skb, totalsize), xdp->data_meta,
+	       ALIGN(totalsize, sizeof(long)));
+
+	metasize = xdp->data - xdp->data_meta;
+	if (metasize) {
+		skb_metadata_set(skb, metasize);
+		__skb_pull(skb, metasize);
+	}
+
+	skb_record_rx_queue(skb, rxq->queue_index);
+	skb->protocol = eth_type_trans(skb, rxq->dev);
+
+	xsk_buff_free(xdp);
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(xdp_build_skb_from_zc);
+
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct sk_buff *skb,
 					   struct net_device *dev)
-- 
2.43.0


