Return-Path: <linux-kernel+bounces-36126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DCE839BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958081C2576D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410CB4EB52;
	Tue, 23 Jan 2024 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YL8sxtqb"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584154F614
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048281; cv=none; b=oQ5qNoPCV9G0Y9nIV7BHOG1R3FfvBaxJC2/9YS+FkO++YAYylWAG5GIH/FJyW3iOQ6BRUWKb5H4gQ2xtoFjKGjIo+oQ/ZCFb7xpezyZakPYwC51mmkIRE3a3ee3MejI1wxdli9Koy95Xw4iOLTivmmbw9NvRUEmc3Ra4oRM8gaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048281; c=relaxed/simple;
	bh=bPYInUrJbx3vaccTXvngVZ4XSF0X2OBJbKqHeTmr8bg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RIMObMdq6WRtqbYir+L3EjqmuPrjUDzcHfT+h0+vrBt73AjhDHFZ29pv+g+l0rxHw0gp2ck0QLcxmn+u1EqFmxylI8wTXiBMBlhA/IP7cScBAFHZydsBle4i9Si36lhpMh8NAKto6HingSC3Muc6NbOqCyRH/ePDo7Zi6k/Rdys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YL8sxtqb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f874219ff9so66192837b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706048278; x=1706653078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DG8n/4xX8724j2bfPJayGJM6rCsGGHElPdEgTxPb0tY=;
        b=YL8sxtqbE8HBE0CCJ7ZJ4ecBxf4lAM2NCguq5UuSUxbaCg9RtS5UTlqs+fRoMpPaFt
         HsqvetwdjJVRSV9NxCiMtZjDyEgkDiRI3QfgEGnC9f9DBzipIGt6mppfosqhWkyHxNtr
         9umsZhtraUX6TUehlqID21aH+1C/Q3UnS/qgFfoIKXmwMb47QkFfxSi1C5IfgIR2Rjh0
         A/hEsKmGUwUjUcKDMta/8So4rtE3QfDho1cWKj+BYWntY97QmGHRjo42bKTpaX2SkcTG
         xAG8QZoMrJwIH9M/iv8LuSzCvvU6nMW51xLQ2LBxjbQ3ecMTKB8fckGPO7vKsAYr1LST
         ruRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706048278; x=1706653078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DG8n/4xX8724j2bfPJayGJM6rCsGGHElPdEgTxPb0tY=;
        b=mylYi2spCUuC50tCcRwQ7MTQuy7meSz+d/L3ZJ5KB8MtuzRZcOsFyNa7Del7/1oWFK
         ufPcFU65vg+alSyn2iimVS3/bCYaWmzO9aiUqdgSHdUcX9T9HqRg4pnwaa8jWlFHGWIp
         GlqTiT7yDQ/7tsTqi4vDHf49xkc8FyFfkdNeiSEQkL7Uq6WhhJosGlgB2blihnYrUNCp
         SYWR8lfB0Wg8YrUXEM7D346AyfjkZqWYgdGcDbovlj7JdA+UAWb7pjE9oT84iMhXQPow
         SA+GnaWjwuMzPc0il5zbNF7jAKjadU9kbr+uZ1N1zpkwB8eSXH3AZdX8weiieqczxwIp
         fM1Q==
X-Gm-Message-State: AOJu0Yy8yrNRWBvv9WC/tN3GVUOpaIYTU1eciY7nNTLDUmdhPJuwdL8O
	lxY2PMsXAFZ8cOP+3UyfnZlD6LcBTx6YWkFywdrDg90UjalslEPuzt0Y1oCUDLkM/xb33x7xqhB
	R2WTbhq+wqlWdp7zYR9YxWLFsoTrIljnxmIqL+GcDvX4gQmfLW7inIYG6nlT3TXDnw1kJlMfaLY
	m+1eLfJ+HnIJnnaS41KIArD/nKMg0Bz66eASVVGEryDgRXdPve/CqKvAwrG1aXKhEelUA=
X-Google-Smtp-Source: AGHT+IFxdTi5d2mV6jO+Hwu8DtrvtPI3d9YN8RAZp3eNiYS6QoIJD4to3QNLXSmACIMirYYx2DjIcJlLIQDZmjgQEw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:3608:aa16:52d:3594])
 (user=almasrymina job=sendgmr) by 2002:a0d:ca0f:0:b0:5ff:5d80:ba1 with SMTP
 id m15-20020a0dca0f000000b005ff5d800ba1mr121315ywd.4.1706048278230; Tue, 23
 Jan 2024 14:17:58 -0800 (PST)
Date: Tue, 23 Jan 2024 14:17:46 -0800
In-Reply-To: <20240123221749.793069-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123221749.793069-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123221749.793069-3-almasrymina@google.com>
Subject: [PATCH net-next v6 2/2] net: add netmem to skb_frag_t
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Use struct netmem* instead of page in skb_frag_t. Currently struct
netmem* is always a struct page underneath, but the abstraction
allows efforts to add support for skb frags not backed by pages.

There is unfortunately 1 instance where the skb_frag_t is assumed to be
a exactly a bio_vec in kcm. For this case, WARN_ON_ONCE and return error
before doing a cast.

Add skb[_frag]_fill_netmem_*() and skb_add_rx_frag_netmem() helpers so
that the API can be used to create netmem skbs.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v6:
- Add static_asserts to validate skb_frag_t to bio_vec cast in
  kcm_write_msg (Yunsheng)

v4:
- Handle error in kcm_write_msgs() instead of only warning (Willem)

v3:
- Renamed the fields in skb_frag_t.

v2:
- Add skb frag filling helpers.

---
 include/linux/skbuff.h | 90 +++++++++++++++++++++++++++++-------------
 net/core/skbuff.c      | 40 ++++++++++++++++---
 net/kcm/kcmsock.c      |  9 ++++-
 3 files changed, 104 insertions(+), 35 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2dde34c29203..196b9b6e6ece 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -37,6 +37,7 @@
 #endif
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
+#include <net/netmem.h>
 
 /**
  * DOC: skb checksums
@@ -359,7 +360,11 @@ extern int sysctl_max_skb_frags;
  */
 #define GSO_BY_FRAGS	0xFFFF
 
-typedef struct bio_vec skb_frag_t;
+typedef struct skb_frag {
+	netmem_ref netmem;
+	unsigned int len;
+	unsigned int offset;
+} skb_frag_t;
 
 /**
  * skb_frag_size() - Returns the size of a skb fragment
@@ -367,7 +372,7 @@ typedef struct bio_vec skb_frag_t;
  */
 static inline unsigned int skb_frag_size(const skb_frag_t *frag)
 {
-	return frag->bv_len;
+	return frag->len;
 }
 
 /**
@@ -377,7 +382,7 @@ static inline unsigned int skb_frag_size(const skb_frag_t *frag)
  */
 static inline void skb_frag_size_set(skb_frag_t *frag, unsigned int size)
 {
-	frag->bv_len = size;
+	frag->len = size;
 }
 
 /**
@@ -387,7 +392,7 @@ static inline void skb_frag_size_set(skb_frag_t *frag, unsigned int size)
  */
 static inline void skb_frag_size_add(skb_frag_t *frag, int delta)
 {
-	frag->bv_len += delta;
+	frag->len += delta;
 }
 
 /**
@@ -397,7 +402,7 @@ static inline void skb_frag_size_add(skb_frag_t *frag, int delta)
  */
 static inline void skb_frag_size_sub(skb_frag_t *frag, int delta)
 {
-	frag->bv_len -= delta;
+	frag->len -= delta;
 }
 
 /**
@@ -417,7 +422,7 @@ static inline bool skb_frag_must_loop(struct page *p)
  *	skb_frag_foreach_page - loop over pages in a fragment
  *
  *	@f:		skb frag to operate on
- *	@f_off:		offset from start of f->bv_page
+ *	@f_off:		offset from start of f->netmem
  *	@f_len:		length from f_off to loop over
  *	@p:		(temp var) current page
  *	@p_off:		(temp var) offset from start of current page,
@@ -2429,22 +2434,37 @@ static inline unsigned int skb_pagelen(const struct sk_buff *skb)
 	return skb_headlen(skb) + __skb_pagelen(skb);
 }
 
+static inline void skb_frag_fill_netmem_desc(skb_frag_t *frag,
+					     netmem_ref netmem, int off,
+					     int size)
+{
+	frag->netmem = netmem;
+	frag->offset = off;
+	skb_frag_size_set(frag, size);
+}
+
 static inline void skb_frag_fill_page_desc(skb_frag_t *frag,
 					   struct page *page,
 					   int off, int size)
 {
-	frag->bv_page = page;
-	frag->bv_offset = off;
-	skb_frag_size_set(frag, size);
+	skb_frag_fill_netmem_desc(frag, page_to_netmem(page), off, size);
+}
+
+static inline void __skb_fill_netmem_desc_noacc(struct skb_shared_info *shinfo,
+						int i, netmem_ref netmem,
+						int off, int size)
+{
+	skb_frag_t *frag = &shinfo->frags[i];
+
+	skb_frag_fill_netmem_desc(frag, netmem, off, size);
 }
 
 static inline void __skb_fill_page_desc_noacc(struct skb_shared_info *shinfo,
 					      int i, struct page *page,
 					      int off, int size)
 {
-	skb_frag_t *frag = &shinfo->frags[i];
-
-	skb_frag_fill_page_desc(frag, page, off, size);
+	__skb_fill_netmem_desc_noacc(shinfo, i, page_to_netmem(page), off,
+				     size);
 }
 
 /**
@@ -2460,10 +2480,10 @@ static inline void skb_len_add(struct sk_buff *skb, int delta)
 }
 
 /**
- * __skb_fill_page_desc - initialise a paged fragment in an skb
+ * __skb_fill_netmem_desc - initialise a fragment in an skb
  * @skb: buffer containing fragment to be initialised
- * @i: paged fragment index to initialise
- * @page: the page to use for this fragment
+ * @i: fragment index to initialise
+ * @netmem: the netmem to use for this fragment
  * @off: the offset to the data with @page
  * @size: the length of the data
  *
@@ -2472,10 +2492,12 @@ static inline void skb_len_add(struct sk_buff *skb, int delta)
  *
  * Does not take any additional reference on the fragment.
  */
-static inline void __skb_fill_page_desc(struct sk_buff *skb, int i,
-					struct page *page, int off, int size)
+static inline void __skb_fill_netmem_desc(struct sk_buff *skb, int i,
+					  netmem_ref netmem, int off, int size)
 {
-	__skb_fill_page_desc_noacc(skb_shinfo(skb), i, page, off, size);
+	struct page *page = netmem_to_page(netmem);
+
+	__skb_fill_netmem_desc_noacc(skb_shinfo(skb), i, netmem, off, size);
 
 	/* Propagate page pfmemalloc to the skb if we can. The problem is
 	 * that not all callers have unique ownership of the page but rely
@@ -2483,7 +2505,20 @@ static inline void __skb_fill_page_desc(struct sk_buff *skb, int i,
 	 */
 	page = compound_head(page);
 	if (page_is_pfmemalloc(page))
-		skb->pfmemalloc	= true;
+		skb->pfmemalloc = true;
+}
+
+static inline void __skb_fill_page_desc(struct sk_buff *skb, int i,
+					struct page *page, int off, int size)
+{
+	__skb_fill_netmem_desc(skb, i, page_to_netmem(page), off, size);
+}
+
+static inline void skb_fill_netmem_desc(struct sk_buff *skb, int i,
+					netmem_ref netmem, int off, int size)
+{
+	__skb_fill_netmem_desc(skb, i, netmem, off, size);
+	skb_shinfo(skb)->nr_frags = i + 1;
 }
 
 /**
@@ -2503,8 +2538,7 @@ static inline void __skb_fill_page_desc(struct sk_buff *skb, int i,
 static inline void skb_fill_page_desc(struct sk_buff *skb, int i,
 				      struct page *page, int off, int size)
 {
-	__skb_fill_page_desc(skb, i, page, off, size);
-	skb_shinfo(skb)->nr_frags = i + 1;
+	skb_fill_netmem_desc(skb, i, page_to_netmem(page), off, size);
 }
 
 /**
@@ -2530,6 +2564,8 @@ static inline void skb_fill_page_desc_noacc(struct sk_buff *skb, int i,
 
 void skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page, int off,
 		     int size, unsigned int truesize);
+void skb_add_rx_frag_netmem(struct sk_buff *skb, int i, netmem_ref netmem,
+			    int off, int size, unsigned int truesize);
 
 void skb_coalesce_rx_frag(struct sk_buff *skb, int i, int size,
 			  unsigned int truesize);
@@ -3378,7 +3414,7 @@ static inline void skb_propagate_pfmemalloc(const struct page *page,
  */
 static inline unsigned int skb_frag_off(const skb_frag_t *frag)
 {
-	return frag->bv_offset;
+	return frag->offset;
 }
 
 /**
@@ -3388,7 +3424,7 @@ static inline unsigned int skb_frag_off(const skb_frag_t *frag)
  */
 static inline void skb_frag_off_add(skb_frag_t *frag, int delta)
 {
-	frag->bv_offset += delta;
+	frag->offset += delta;
 }
 
 /**
@@ -3398,7 +3434,7 @@ static inline void skb_frag_off_add(skb_frag_t *frag, int delta)
  */
 static inline void skb_frag_off_set(skb_frag_t *frag, unsigned int offset)
 {
-	frag->bv_offset = offset;
+	frag->offset = offset;
 }
 
 /**
@@ -3409,7 +3445,7 @@ static inline void skb_frag_off_set(skb_frag_t *frag, unsigned int offset)
 static inline void skb_frag_off_copy(skb_frag_t *fragto,
 				     const skb_frag_t *fragfrom)
 {
-	fragto->bv_offset = fragfrom->bv_offset;
+	fragto->offset = fragfrom->offset;
 }
 
 /**
@@ -3420,7 +3456,7 @@ static inline void skb_frag_off_copy(skb_frag_t *fragto,
  */
 static inline struct page *skb_frag_page(const skb_frag_t *frag)
 {
-	return frag->bv_page;
+	return netmem_to_page(frag->netmem);
 }
 
 /**
@@ -3524,7 +3560,7 @@ static inline void *skb_frag_address_safe(const skb_frag_t *frag)
 static inline void skb_frag_page_copy(skb_frag_t *fragto,
 				      const skb_frag_t *fragfrom)
 {
-	fragto->bv_page = fragfrom->bv_page;
+	fragto->netmem = fragfrom->netmem;
 }
 
 bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index edbbef563d4d..b930de02e2ed 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -115,6 +115,24 @@ static struct kmem_cache *skb_small_head_cache __ro_after_init;
 int sysctl_max_skb_frags __read_mostly = MAX_SKB_FRAGS;
 EXPORT_SYMBOL(sysctl_max_skb_frags);
 
+/* kcm_write_msgs() relies on casting paged frags to bio_vec to use
+ * iov_iter_bvec(). These static asserts ensure the cast is valid is long as the
+ * netmem is a page.
+ */
+static_assert(offsetof(struct bio_vec, bv_page) ==
+	      offsetof(skb_frag_t, netmem));
+static_assert(sizeof_field(struct bio_vec, bv_page) ==
+	      sizeof_field(skb_frag_t, netmem));
+
+static_assert(offsetof(struct bio_vec, bv_len) == offsetof(skb_frag_t, len));
+static_assert(sizeof_field(struct bio_vec, bv_len) ==
+	      sizeof_field(skb_frag_t, len));
+
+static_assert(offsetof(struct bio_vec, bv_offset) ==
+	      offsetof(skb_frag_t, offset));
+static_assert(sizeof_field(struct bio_vec, bv_offset) ==
+	      sizeof_field(skb_frag_t, offset));
+
 #undef FN
 #define FN(reason) [SKB_DROP_REASON_##reason] = #reason,
 static const char * const drop_reasons[] = {
@@ -845,16 +863,24 @@ struct sk_buff *__napi_alloc_skb(struct napi_struct *napi, unsigned int len,
 }
 EXPORT_SYMBOL(__napi_alloc_skb);
 
-void skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page, int off,
-		     int size, unsigned int truesize)
+void skb_add_rx_frag_netmem(struct sk_buff *skb, int i, netmem_ref netmem,
+			    int off, int size, unsigned int truesize)
 {
 	DEBUG_NET_WARN_ON_ONCE(size > truesize);
 
-	skb_fill_page_desc(skb, i, page, off, size);
+	skb_fill_netmem_desc(skb, i, netmem, off, size);
 	skb->len += size;
 	skb->data_len += size;
 	skb->truesize += truesize;
 }
+EXPORT_SYMBOL(skb_add_rx_frag_netmem);
+
+void skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page, int off,
+		     int size, unsigned int truesize)
+{
+	skb_add_rx_frag_netmem(skb, i, page_to_netmem(page), off, size,
+			       truesize);
+}
 EXPORT_SYMBOL(skb_add_rx_frag);
 
 void skb_coalesce_rx_frag(struct sk_buff *skb, int i, int size,
@@ -1906,10 +1932,11 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 
 	/* skb frags point to kernel buffers */
 	for (i = 0; i < new_frags - 1; i++) {
-		__skb_fill_page_desc(skb, i, head, 0, psize);
+		__skb_fill_netmem_desc(skb, i, page_to_netmem(head), 0, psize);
 		head = (struct page *)page_private(head);
 	}
-	__skb_fill_page_desc(skb, new_frags - 1, head, 0, d_off);
+	__skb_fill_netmem_desc(skb, new_frags - 1, page_to_netmem(head), 0,
+			       d_off);
 	skb_shinfo(skb)->nr_frags = new_frags;
 
 release:
@@ -3647,7 +3674,8 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 		if (plen) {
 			page = virt_to_head_page(from->head);
 			offset = from->data - (unsigned char *)page_address(page);
-			__skb_fill_page_desc(to, 0, page, offset, plen);
+			__skb_fill_netmem_desc(to, 0, page_to_netmem(page),
+					       offset, plen);
 			get_page(page);
 			j = 1;
 			len -= plen;
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 1184d40167b8..145ef22b2b35 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -636,9 +636,14 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
 			msize += skb_frag_size(&skb_shinfo(skb)->frags[i]);
 
+		if (WARN_ON_ONCE(!skb_frag_page(&skb_shinfo(skb)->frags[0]))) {
+			ret = -EINVAL;
+			goto out;
+		}
+
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE,
-			      skb_shinfo(skb)->frags, skb_shinfo(skb)->nr_frags,
-			      msize);
+			      (const struct bio_vec *)skb_shinfo(skb)->frags,
+			      skb_shinfo(skb)->nr_frags, msize);
 		iov_iter_advance(&msg.msg_iter, txm->frag_offset);
 
 		do {
-- 
2.43.0.429.g432eaa2c6b-goog


