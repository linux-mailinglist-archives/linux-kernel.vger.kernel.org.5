Return-Path: <linux-kernel+bounces-1366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C97E814E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4149B1C23ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DB845970;
	Fri, 15 Dec 2023 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Q9uXjXf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ak6k4VWR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F4A3FE3B;
	Fri, 15 Dec 2023 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702660233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5zOPCgrHdEaa1eytpo3QrYdXQW432HPXhv9pq69YVE=;
	b=2Q9uXjXfe3jw8M/VK8+ax1lt7fif689pkVxd2DnEwor434f6/JoX2unMfkagJudVMlaHu9
	OHSHEwrSDJ++81dI3RLyAw+56PQTwNl2rei4JbLgODuhIjfMBm78PZltye7BnXS/PY0r3S
	+f/jHG2mIwIj/vEHXmr9IGazfRYoG+k/gghNVqE/A7sKNNvMf18IjM/1SfeYJdV+lellcO
	1MJ499T3aDBeNZjrGiy/gJDDAt7jvx5nVqD/e34toCcnRYFi0w0NP0v4OiiJ4VOGbjzacz
	EBEfyOoyqGm+0iF+yqJqSem3aGzYMqX9eu11mp5LNeiS4HsKbSAB3SQuZh31iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5zOPCgrHdEaa1eytpo3QrYdXQW432HPXhv9pq69YVE=;
	b=ak6k4VWRIvYlPdM7jpm3B3Pt21UzdT8y+e34yf7l2u1pvWTHzccCxhsVp8/x8lQiGToHlh
	MQdt9jY4eq9HyfCA==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 04/24] net: Use nested-BH locking for napi_alloc_cache.
Date: Fri, 15 Dec 2023 18:07:23 +0100
Message-ID: <20231215171020.687342-5-bigeasy@linutronix.de>
In-Reply-To: <20231215171020.687342-1-bigeasy@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

napi_alloc_cache is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Add a local_lock_t to the data structure and use local_lock_nested_bh()
for locking. This change adds only lockdep coverage and does not alter
the functional behaviour for !PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/skbuff.c | 57 +++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index de9397e45718a..9c3073dcc80f1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -265,6 +265,7 @@ static void *page_frag_alloc_1k(struct page_frag_1k *nc=
, gfp_t gfp_mask)
 #endif
=20
 struct napi_alloc_cache {
+	local_lock_t bh_lock;
 	struct page_frag_cache page;
 	struct page_frag_1k page_small;
 	unsigned int skb_count;
@@ -272,7 +273,9 @@ struct napi_alloc_cache {
 };
=20
 static DEFINE_PER_CPU(struct page_frag_cache, netdev_alloc_cache);
-static DEFINE_PER_CPU(struct napi_alloc_cache, napi_alloc_cache);
+static DEFINE_PER_CPU(struct napi_alloc_cache, napi_alloc_cache) =3D {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
=20
 /* Double check that napi_get_frags() allocates skbs with
  * skb->head being backed by slab, not a page fragment.
@@ -296,6 +299,7 @@ void *__napi_alloc_frag_align(unsigned int fragsz, unsi=
gned int align_mask)
 	struct napi_alloc_cache *nc =3D this_cpu_ptr(&napi_alloc_cache);
=20
 	fragsz =3D SKB_DATA_ALIGN(fragsz);
+	guard(local_lock_nested_bh)(&napi_alloc_cache.bh_lock);
=20
 	return page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align_mask);
 }
@@ -324,6 +328,7 @@ static struct sk_buff *napi_skb_cache_get(void)
 	struct napi_alloc_cache *nc =3D this_cpu_ptr(&napi_alloc_cache);
 	struct sk_buff *skb;
=20
+	guard(local_lock_nested_bh)(&napi_alloc_cache.bh_lock);
 	if (unlikely(!nc->skb_count)) {
 		nc->skb_count =3D kmem_cache_alloc_bulk(skbuff_cache,
 						      GFP_ATOMIC,
@@ -726,9 +731,11 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *=
dev, unsigned int len,
 		pfmemalloc =3D nc->pfmemalloc;
 	} else {
 		local_bh_disable();
-		nc =3D this_cpu_ptr(&napi_alloc_cache.page);
-		data =3D page_frag_alloc(nc, len, gfp_mask);
-		pfmemalloc =3D nc->pfmemalloc;
+		scoped_guard(local_lock_nested_bh, &napi_alloc_cache.bh_lock) {
+			nc =3D this_cpu_ptr(&napi_alloc_cache.page);
+			data =3D page_frag_alloc(nc, len, gfp_mask);
+			pfmemalloc =3D nc->pfmemalloc;
+		}
 		local_bh_enable();
 	}
=20
@@ -793,31 +800,32 @@ struct sk_buff *__napi_alloc_skb(struct napi_struct *=
napi, unsigned int len,
 		goto skb_success;
 	}
=20
-	nc =3D this_cpu_ptr(&napi_alloc_cache);
-
 	if (sk_memalloc_socks())
 		gfp_mask |=3D __GFP_MEMALLOC;
=20
-	if (NAPI_HAS_SMALL_PAGE_FRAG && len <=3D SKB_WITH_OVERHEAD(1024)) {
-		/* we are artificially inflating the allocation size, but
-		 * that is not as bad as it may look like, as:
-		 * - 'len' less than GRO_MAX_HEAD makes little sense
-		 * - On most systems, larger 'len' values lead to fragment
-		 *   size above 512 bytes
-		 * - kmalloc would use the kmalloc-1k slab for such values
-		 * - Builds with smaller GRO_MAX_HEAD will very likely do
-		 *   little networking, as that implies no WiFi and no
-		 *   tunnels support, and 32 bits arches.
-		 */
-		len =3D SZ_1K;
+	scoped_guard(local_lock_nested_bh, &napi_alloc_cache.bh_lock) {
+		nc =3D this_cpu_ptr(&napi_alloc_cache);
+		if (NAPI_HAS_SMALL_PAGE_FRAG && len <=3D SKB_WITH_OVERHEAD(1024)) {
+			/* we are artificially inflating the allocation size, but
+			 * that is not as bad as it may look like, as:
+			 * - 'len' less than GRO_MAX_HEAD makes little sense
+			 * - On most systems, larger 'len' values lead to fragment
+			 *   size above 512 bytes
+			 * - kmalloc would use the kmalloc-1k slab for such values
+			 * - Builds with smaller GRO_MAX_HEAD will very likely do
+			 *   little networking, as that implies no WiFi and no
+			 *   tunnels support, and 32 bits arches.
+			 */
+			len =3D SZ_1K;
=20
-		data =3D page_frag_alloc_1k(&nc->page_small, gfp_mask);
-		pfmemalloc =3D NAPI_SMALL_PAGE_PFMEMALLOC(nc->page_small);
-	} else {
-		len =3D SKB_HEAD_ALIGN(len);
+			data =3D page_frag_alloc_1k(&nc->page_small, gfp_mask);
+			pfmemalloc =3D NAPI_SMALL_PAGE_PFMEMALLOC(nc->page_small);
+		} else {
+			len =3D SKB_HEAD_ALIGN(len);
=20
-		data =3D page_frag_alloc(&nc->page, len, gfp_mask);
-		pfmemalloc =3D nc->page.pfmemalloc;
+			data =3D page_frag_alloc(&nc->page, len, gfp_mask);
+			pfmemalloc =3D nc->page.pfmemalloc;
+		}
 	}
=20
 	if (unlikely(!data))
@@ -1306,6 +1314,7 @@ static void napi_skb_cache_put(struct sk_buff *skb)
 	struct napi_alloc_cache *nc =3D this_cpu_ptr(&napi_alloc_cache);
 	u32 i;
=20
+	guard(local_lock_nested_bh)(&napi_alloc_cache.bh_lock);
 	kasan_poison_object_data(skbuff_cache, skb);
 	nc->skb_cache[nc->skb_count++] =3D skb;
=20
--=20
2.43.0


