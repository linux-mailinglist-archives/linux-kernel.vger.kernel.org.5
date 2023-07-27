Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEE5765633
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjG0Ops (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjG0Opk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:45:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C765930D8;
        Thu, 27 Jul 2023 07:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690469139; x=1722005139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bfJssYGznC4Y168BbqD0WxjJ4ba14FCskmkH0A8esDA=;
  b=B2PYvzOuA3qphg0obtMDa9dKkepBqSdweqHo+OsoJRKostS+c8LXA0NQ
   43aY0rFDaFdIB1sDkVKkViS2cT7wUO8lHLjlq1Ws8XOP4w9Ep3Daec9VB
   ho5zWKGGCg4zxDp81VTB34JfEVuZOdJnE9SViLEKbncDq2TOHJf6Rxe+q
   w7/T8cC0ink5MWa210F7XOfMZOhuml8L9VoAlfH81r8m9M8tS0NVBSGKD
   TiTQx4dUHD+pYblkuQW6gkF/pnrWt0xrYdbYLWG6V68q/LGEisOmUqGGt
   R8g5wmLDvp868rwEw2rFZ/Xvbk388o5l92sN9v2miRJvs3u86Ht83okW3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432139693"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="432139693"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 07:45:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817119884"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="817119884"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2023 07:45:35 -0700
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
Subject: [PATCH net-next 2/9] net: skbuff: don't include <net/page_pool/types.h> to <linux/skbuff.h>
Date:   Thu, 27 Jul 2023 16:43:29 +0200
Message-ID: <20230727144336.1646454-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
page_pool_return_skb_page() to skbuff.c, just next to the main
consumer, skb_pp_recycle(). It's used also in napi_frag_unref() ->
{__,}skb_frag_unref(), so no `static` unfortunately. Maybe next time.
Now, touching page_pool_types.h only triggers rebuilding of the drivers
using it and a couple of core networking files.

Suggested-by: Jakub Kicinski <kuba@kernel.org> # make skbuff.h less heavy
Suggested-by: Alexander Duyck <alexanderduyck@fb.com> # move to skbuff.c
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/skbuff.h        |  3 ++-
 include/net/page_pool/types.h |  2 --
 net/core/page_pool.c          | 39 ---------------------------------
 net/core/skbuff.c             | 41 ++++++++++++++++++++++++++++++++++-
 4 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 888e3d7e74c1..7effd94efd6c 100644
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
@@ -3421,6 +3420,8 @@ static inline void skb_frag_ref(struct sk_buff *skb, int f)
 	__skb_frag_ref(&skb_shinfo(skb)->frags[f]);
 }
 
+bool page_pool_return_skb_page(struct page *page, bool napi_safe);
+
 static inline void
 napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 {
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 4a0270291deb..c7aef6c75935 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -156,8 +156,6 @@ struct page_pool {
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
 struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
 				  unsigned int size, gfp_t gfp);
-bool page_pool_return_skb_page(struct page *page, bool napi_safe);
-
 struct page_pool *page_pool_create(const struct page_pool_params *params);
 
 struct xdp_mem_info;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 2a75f61264c5..7a23ca6b1124 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -906,42 +906,3 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
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
index ac8f421f8ab3..3084ef59400b 100644
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
@@ -879,6 +879,45 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
+bool page_pool_return_skb_page(struct page *page, bool napi_safe)
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
+EXPORT_SYMBOL(page_pool_return_skb_page);
+
 static bool skb_pp_recycle(struct sk_buff *skb, void *data, bool napi_safe)
 {
 	if (!IS_ENABLED(CONFIG_PAGE_POOL) || !skb->pp_recycle)
-- 
2.41.0

