Return-Path: <linux-kernel+bounces-10225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A3E81D18F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6B21F23FBC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424BB125A9;
	Sat, 23 Dec 2023 02:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AYGmb5al"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A34C12E61;
	Sat, 23 Dec 2023 02:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300319; x=1734836319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CVCGYVKSl7Vfqncoy/Waq/QssSuuqYKEhaeBYUs9+Xs=;
  b=AYGmb5al0KIxoibuo6E6Zee8nx04wgXaIJ2cAaqVoDWsEf0LUbte6y2C
   xGw1PGjE3JAiBrB0NLIIIIW/9NGhP9vsQRUS+yTs1+waugOiFEr6ydwu2
   r+vG8JEata4hiajireR8TFRds/Ii3vyr9uWCtKZ2YYHMxGL7NstcKaNV0
   5Vl7cDkIqmJBYqW/wiLuCHfbBcscq5AZCrCfVj4xgQRpOzh5T++AJ8rB6
   4/WcQKa+/6m6rpJbqxsjRP6O6aXS/bGhF9TBPqSv2oZm52Aimi9ZEKC0K
   xPh5rqAHOvJJBSreM8nbB1AOgS32g0e9sRCxwgON0Fa5SzqTi6MR+GEIL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386610841"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386610841"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:58:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537475"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:58:35 -0800
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
Subject: [PATCH RFC net-next 09/34] bpf, xdp: constify some bpf_prog * function arguments
Date: Sat, 23 Dec 2023 03:55:29 +0100
Message-ID: <20231223025554.2316836-10-aleksander.lobakin@intel.com>
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

In lots of places, bpf_prog pointer is used only for tracing or other
stuff that doesn't modify the structure itself. Same for net_device.
Address at least some of them and add `const` attributes there. The
object code didn't change, but that may prevent unwanted data
modifications and also allow more helpers to have const arguments.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/bpf.h       | 12 ++++++------
 include/linux/filter.h    |  9 +++++----
 include/linux/netdevice.h |  6 +++---
 kernel/bpf/devmap.c       |  8 ++++----
 net/core/dev.c            |  8 ++++----
 net/core/filter.c         | 25 ++++++++++++++-----------
 6 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7a8d4c81a39a..53ccac0f0d64 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2384,10 +2384,10 @@ int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_frame *xdpf,
 int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 			  struct bpf_map *map, bool exclude_ingress);
 int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
-			     struct bpf_prog *xdp_prog);
+			     const struct bpf_prog *xdp_prog);
 int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
-			   struct bpf_prog *xdp_prog, struct bpf_map *map,
-			   bool exclude_ingress);
+			   const struct bpf_prog *xdp_prog,
+			   struct bpf_map *map, bool exclude_ingress);
 
 void __cpu_map_flush(void);
 int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf,
@@ -2632,15 +2632,15 @@ struct sk_buff;
 
 static inline int dev_map_generic_redirect(struct bpf_dtab_netdev *dst,
 					   struct sk_buff *skb,
-					   struct bpf_prog *xdp_prog)
+					   const struct bpf_prog *xdp_prog)
 {
 	return 0;
 }
 
 static inline
 int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
-			   struct bpf_prog *xdp_prog, struct bpf_map *map,
-			   bool exclude_ingress)
+			   const struct bpf_prog *xdp_prog,
+			   struct bpf_map *map, bool exclude_ingress)
 {
 	return 0;
 }
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 68fb6c8142fe..34c9e2a4cc01 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1015,17 +1015,18 @@ static inline int xdp_ok_fwd_dev(const struct net_device *fwd,
  * This does not appear to be a real limitation for existing software.
  */
 int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
-			    struct xdp_buff *xdp, struct bpf_prog *prog);
+			    struct xdp_buff *xdp, const struct bpf_prog *prog);
 int xdp_do_redirect(struct net_device *dev,
 		    struct xdp_buff *xdp,
-		    struct bpf_prog *prog);
+		    const struct bpf_prog *prog);
 int xdp_do_redirect_frame(struct net_device *dev,
 			  struct xdp_buff *xdp,
 			  struct xdp_frame *xdpf,
-			  struct bpf_prog *prog);
+			  const struct bpf_prog *prog);
 void xdp_do_flush(void);
 
-void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog, u32 act);
+void bpf_warn_invalid_xdp_action(const struct net_device *dev,
+				 const struct bpf_prog *prog, u32 act);
 
 #ifdef CONFIG_INET
 struct sock *bpf_run_sk_reuseport(struct sock_reuseport *reuse, struct sock *sk,
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 75c7725e5e4f..7bb8324a4ebe 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3956,9 +3956,9 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
 }
 
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
-			     struct bpf_prog *xdp_prog);
-void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog);
-int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb);
+			     const struct bpf_prog *xdp_prog);
+void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog);
+int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff *skb);
 int netif_rx(struct sk_buff *skb);
 int __netif_rx(struct sk_buff *skb);
 
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index a936c704d4e7..5ad73ef21da2 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -673,7 +673,7 @@ int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 }
 
 int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
-			     struct bpf_prog *xdp_prog)
+			     const struct bpf_prog *xdp_prog)
 {
 	int err;
 
@@ -696,7 +696,7 @@ int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
 
 static int dev_map_redirect_clone(struct bpf_dtab_netdev *dst,
 				  struct sk_buff *skb,
-				  struct bpf_prog *xdp_prog)
+				  const struct bpf_prog *xdp_prog)
 {
 	struct sk_buff *nskb;
 	int err;
@@ -715,8 +715,8 @@ static int dev_map_redirect_clone(struct bpf_dtab_netdev *dst,
 }
 
 int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
-			   struct bpf_prog *xdp_prog, struct bpf_map *map,
-			   bool exclude_ingress)
+			   const struct bpf_prog *xdp_prog,
+			   struct bpf_map *map, bool exclude_ingress)
 {
 	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
 	struct bpf_dtab_netdev *dst, *last_dst = NULL;
diff --git a/net/core/dev.c b/net/core/dev.c
index f9d4b550ef4b..b2a9839dd18e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4833,7 +4833,7 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
 }
 
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
-			     struct bpf_prog *xdp_prog)
+			     const struct bpf_prog *xdp_prog)
 {
 	void *orig_data, *orig_data_end, *hard_start;
 	struct netdev_rx_queue *rxqueue;
@@ -4922,7 +4922,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 
 static u32 netif_receive_generic_xdp(struct sk_buff *skb,
 				     struct xdp_buff *xdp,
-				     struct bpf_prog *xdp_prog)
+				     const struct bpf_prog *xdp_prog)
 {
 	u32 act = XDP_DROP;
 
@@ -4979,7 +4979,7 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
  * and DDOS attacks will be more effective. In-driver-XDP use dedicated TX
  * queues, so they do not have this starvation issue.
  */
-void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog)
+void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog)
 {
 	struct net_device *dev = skb->dev;
 	struct netdev_queue *txq;
@@ -5004,7 +5004,7 @@ void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog)
 
 static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
 
-int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
+int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff *skb)
 {
 	if (xdp_prog) {
 		struct xdp_buff xdp;
diff --git a/net/core/filter.c b/net/core/filter.c
index 24061f29c9dd..4ace1edc4de1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4297,9 +4297,9 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
 EXPORT_SYMBOL_GPL(xdp_master_redirect);
 
 static inline int __xdp_do_redirect_xsk(struct bpf_redirect_info *ri,
-					struct net_device *dev,
+					const struct net_device *dev,
 					struct xdp_buff *xdp,
-					struct bpf_prog *xdp_prog)
+					const struct bpf_prog *xdp_prog)
 {
 	enum bpf_map_type map_type = ri->map_type;
 	void *fwd = ri->tgt_value;
@@ -4320,10 +4320,10 @@ static inline int __xdp_do_redirect_xsk(struct bpf_redirect_info *ri,
 	return err;
 }
 
-static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
-						   struct net_device *dev,
-						   struct xdp_frame *xdpf,
-						   struct bpf_prog *xdp_prog)
+static __always_inline int
+__xdp_do_redirect_frame(struct bpf_redirect_info *ri, struct net_device *dev,
+			struct xdp_frame *xdpf,
+			const struct bpf_prog *xdp_prog)
 {
 	enum bpf_map_type map_type = ri->map_type;
 	void *fwd = ri->tgt_value;
@@ -4381,7 +4381,7 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
 }
 
 int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
-		    struct bpf_prog *xdp_prog)
+		    const struct bpf_prog *xdp_prog)
 {
 	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
 	enum bpf_map_type map_type = ri->map_type;
@@ -4395,7 +4395,8 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 EXPORT_SYMBOL_GPL(xdp_do_redirect);
 
 int xdp_do_redirect_frame(struct net_device *dev, struct xdp_buff *xdp,
-			  struct xdp_frame *xdpf, struct bpf_prog *xdp_prog)
+			  struct xdp_frame *xdpf,
+			  const struct bpf_prog *xdp_prog)
 {
 	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
 	enum bpf_map_type map_type = ri->map_type;
@@ -4410,7 +4411,7 @@ EXPORT_SYMBOL_GPL(xdp_do_redirect_frame);
 static int xdp_do_generic_redirect_map(struct net_device *dev,
 				       struct sk_buff *skb,
 				       struct xdp_buff *xdp,
-				       struct bpf_prog *xdp_prog,
+				       const struct bpf_prog *xdp_prog,
 				       void *fwd,
 				       enum bpf_map_type map_type, u32 map_id)
 {
@@ -4457,7 +4458,8 @@ static int xdp_do_generic_redirect_map(struct net_device *dev,
 }
 
 int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
-			    struct xdp_buff *xdp, struct bpf_prog *xdp_prog)
+			    struct xdp_buff *xdp,
+			    const struct bpf_prog *xdp_prog)
 {
 	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
 	enum bpf_map_type map_type = ri->map_type;
@@ -8961,7 +8963,8 @@ static bool xdp_is_valid_access(int off, int size,
 	return __is_valid_xdp_access(off, size);
 }
 
-void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog, u32 act)
+void bpf_warn_invalid_xdp_action(const struct net_device *dev,
+				 const struct bpf_prog *prog, u32 act)
 {
 	const u32 act_max = XDP_REDIRECT;
 
-- 
2.43.0


