Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A8A770778
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjHDSGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjHDSGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:06:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFA646A8;
        Fri,  4 Aug 2023 11:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691172376; x=1722708376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ULYSDvilwFY/6INxKbphno6mzaAbIBgvgBeFj01z+4=;
  b=dAkZ6IuBky67nKU5Ug47uA8HS4a9WmD1I8ksJD+UnZdPEs5TlBKRTlGM
   Kmc3ayo7uKKCrf0dmKDUmeU2C/sQNBgisHNUVq5Cyr7KB1pn6VXtB/KCo
   W17N6RA7YYq8667n2Megs+yRk6Cv1ZOIJPNrfXp3iQTqReO7UOg91KnJ9
   2w1u2+qzCETkviP0oCuwUJFoJmXob+eJ31lhFwbxmYUQTtqSlzdM3IULz
   Tl01TjSL7HXLUpyWsrenoVNdmueHyN+Yi8Hjwphh/dGJ6cG3Ss9SgVwjC
   KOhO93I0RKweVXmOXw5GouFWE7q5bOdxUEOkIKPVgx2BhYlflFEyE4TGQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="434061633"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="434061633"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 11:06:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="759673586"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="759673586"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga008.jf.intel.com with ESMTP; 04 Aug 2023 11:06:08 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 2/6] net: skbuff: don't include <net/page_pool/types.h> to <linux/skbuff.h>
Date:   Fri,  4 Aug 2023 20:05:25 +0200
Message-ID: <20230804180529.2483231-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
References: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, touching <net/page_pool/types.h> triggers a rebuild of more
than half of the kernel. That's because it's included in
<linux/skbuff.h>. And each new include to page_pool/types.h adds more
[useless] data for the toolchain to process per each source file from
that pile.

In commit 6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB
recycling"), Matteo included it to be able to call a couple of functions
defined there. Then, in commit 57f05bc2ab24 ("page_pool: keep pp info as
long as page pool owns the page") one of the calls was removed, so only
one was left. It's the call to page_pool_return_skb_page() in
napi_frag_unref(). The function is external and doesn't have any
dependencies. Having very niche page_pool_types.h included only for that
looks like an overkill.

As %PP_SIGNATURE is not local to page_pool.c (was only in the
early submissions), nothing holds this function there. Teleport
page_pool_return_skb_page() to skbuff.c, just next to the main consumer,
skb_pp_recycle(), and rename it to napi_pp_put_page(), as it doesn't
work with skbs at all and the former name tells nothing. The #if guards
here are only to not compile and have it in the vmlinux when not needed
-- both call sites are already guarded.
Now, touching page_pool_types.h only triggers rebuilding of the drivers
using it and a couple of core networking files.

Suggested-by: Jakub Kicinski <kuba@kernel.org> # make skbuff.h less heavy
Suggested-by: Alexander Duyck <alexanderduyck@fb.com> # move to skbuff.c
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/skbuff.h        |  5 ++--
 include/net/page_pool/types.h |  2 --
 net/core/page_pool.c          | 39 ------------------------------
 net/core/skbuff.c             | 45 +++++++++++++++++++++++++++++++++--
 4 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 888e3d7e74c1..aa57e2eca33b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -32,7 +32,6 @@
 #include <linux/if_packet.h>
 #include <linux/llist.h>
 #include <net/flow.h>
-#include <net/page_pool/types.h>
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 #include <linux/netfilter/nf_conntrack_common.h>
 #endif
@@ -3421,13 +3420,15 @@ static inline void skb_frag_ref(struct sk_buff *skb, int f)
 	__skb_frag_ref(&skb_shinfo(skb)->frags[f]);
 }
 
+bool napi_pp_put_page(struct page *page, bool napi_safe);
+
 static inline void
 napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 {
 	struct page *page = skb_frag_page(frag);
 
 #ifdef CONFIG_PAGE_POOL
-	if (recycle && page_pool_return_skb_page(page, napi_safe))
+	if (recycle && napi_pp_put_page(page, napi_safe))
 		return;
 #endif
 	put_page(page);
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 9ac39191bed7..fcb846523398 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -185,8 +185,6 @@ struct page_pool {
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
 struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
 				  unsigned int size, gfp_t gfp);
-bool page_pool_return_skb_page(struct page *page, bool napi_safe);
-
 struct page_pool *page_pool_create(const struct page_pool_params *params);
 
 struct xdp_mem_info;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index cd28c1f14002..03ad74d25959 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -935,42 +935,3 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 	}
 }
 EXPORT_SYMBOL(page_pool_update_nid);
-
-bool page_pool_return_skb_page(struct page *page, bool napi_safe)
-{
-	struct napi_struct *napi;
-	struct page_pool *pp;
-	bool allow_direct;
-
-	page = compound_head(page);
-
-	/* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
-	 * in order to preserve any existing bits, such as bit 0 for the
-	 * head page of compound page and bit 1 for pfmemalloc page, so
-	 * mask those bits for freeing side when doing below checking,
-	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
-	 * to avoid recycling the pfmemalloc page.
-	 */
-	if (unlikely((page->pp_magic & ~0x3UL) != PP_SIGNATURE))
-		return false;
-
-	pp = page->pp;
-
-	/* Allow direct recycle if we have reasons to believe that we are
-	 * in the same context as the consumer would run, so there's
-	 * no possible race.
-	 */
-	napi = READ_ONCE(pp->p.napi);
-	allow_direct = napi_safe && napi &&
-		READ_ONCE(napi->list_owner) == smp_processor_id();
-
-	/* Driver set this to memory recycling info. Reset it on recycle.
-	 * This will *not* work for NIC using a split-page memory model.
-	 * The page will be returned to the pool here regardless of the
-	 * 'flipped' fragment being in use or not.
-	 */
-	page_pool_put_full_page(pp, page, allow_direct);
-
-	return true;
-}
-EXPORT_SYMBOL(page_pool_return_skb_page);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d3bed964123c..acc5844a0de1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -73,7 +73,7 @@
 #include <net/mpls.h>
 #include <net/mptcp.h>
 #include <net/mctp.h>
-#include <net/page_pool/types.h>
+#include <net/page_pool/helpers.h>
 #include <net/dropreason.h>
 
 #include <linux/uaccess.h>
@@ -879,11 +879,52 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
+#if IS_ENABLED(CONFIG_PAGE_POOL)
+bool napi_pp_put_page(struct page *page, bool napi_safe)
+{
+	struct napi_struct *napi;
+	struct page_pool *pp;
+	bool allow_direct;
+
+	page = compound_head(page);
+
+	/* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
+	 * in order to preserve any existing bits, such as bit 0 for the
+	 * head page of compound page and bit 1 for pfmemalloc page, so
+	 * mask those bits for freeing side when doing below checking,
+	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
+	 * to avoid recycling the pfmemalloc page.
+	 */
+	if (unlikely((page->pp_magic & ~0x3UL) != PP_SIGNATURE))
+		return false;
+
+	pp = page->pp;
+
+	/* Allow direct recycle if we have reasons to believe that we are
+	 * in the same context as the consumer would run, so there's
+	 * no possible race.
+	 */
+	napi = READ_ONCE(pp->p.napi);
+	allow_direct = napi_safe && napi &&
+		READ_ONCE(napi->list_owner) == smp_processor_id();
+
+	/* Driver set this to memory recycling info. Reset it on recycle.
+	 * This will *not* work for NIC using a split-page memory model.
+	 * The page will be returned to the pool here regardless of the
+	 * 'flipped' fragment being in use or not.
+	 */
+	page_pool_put_full_page(pp, page, allow_direct);
+
+	return true;
+}
+EXPORT_SYMBOL(napi_pp_put_page);
+#endif
+
 static bool skb_pp_recycle(struct sk_buff *skb, void *data, bool napi_safe)
 {
 	if (!IS_ENABLED(CONFIG_PAGE_POOL) || !skb->pp_recycle)
 		return false;
-	return page_pool_return_skb_page(virt_to_page(data), napi_safe);
+	return napi_pp_put_page(virt_to_page(data), napi_safe);
 }
 
 static void skb_kfree_head(void *head, unsigned int end_offset)
-- 
2.41.0

