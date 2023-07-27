Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4AB76564B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjG0Oq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjG0OqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:46:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F513592;
        Thu, 27 Jul 2023 07:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690469151; x=1722005151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rXg0fjSPcukCgI8rvn6/BURKoRJDLNE56JJQvNgZt28=;
  b=niqM5UzIfKyOlPuLyVIxnK7ECzCCpVK5ALYUdrapFK5VtqNQ9guLZRbZ
   tYAQblKHYRT6kO9diepxWbiFHRKnZBJ10Qa43LiipUK1MchVb44Ht6ATW
   5nLRZZQQfkFYmBe2BckijfUi8GWP43AgV3cGu+zBpDBFMDuvOQ3WUXhMV
   lDxlkxnq9frAa/hdhO+xrSm8uhb7s7dwHoyA5YBZiBUNVHaYYWDDdQoGP
   8mu48CstiyIxu2plBP9CL+KBASYY46/R9q5t+GTzzmQFRronDvCUNQfyc
   d1IiOyG1nXkL2bJin6Nso/m56c+qTlBs0dSfCSi9IH5wMqATWjduP4+72
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432139796"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="432139796"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 07:45:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817119940"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="817119940"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2023 07:45:48 -0700
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
Subject: [PATCH net-next 6/9] page_pool: avoid calling no-op externals when possible
Date:   Thu, 27 Jul 2023 16:43:33 +0200
Message-ID: <20230727144336.1646454-7-aleksander.lobakin@intel.com>
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

Turned out page_pool_put{,_full}_page() can burn quite a bunch of cycles
even when on DMA-coherent platforms (like x86) with no active IOMMU or
swiotlb, just for the call ladder.
Indeed, it's

page_pool_put_page()
  page_pool_put_defragged_page()                  <- external
    __page_pool_put_page()
      page_pool_dma_sync_for_device()             <- non-inline
        dma_sync_single_range_for_device()
          dma_sync_single_for_device()            <- external
            dma_direct_sync_single_for_device()
              dev_is_dma_coherent()               <- exit

For the inline functions, no guarantees the compiler won't uninline them
(they're clearly not one-liners and sometimes compilers uninline even
2 + 2). The first external call is necessary, but the rest 2+ are done
for nothing each time, plus a bunch of checks here and there.
Since Page Pool mappings are long-term and for one "device + addr" pair
dma_need_sync() will always return the same value (basically, whether it
belongs to an swiotlb pool), addresses can be tested once right after
they're obtained and the result can be reused until the page is unmapped.
Define the new PP DMA sync operation type, which will mean "do DMA syncs
for the device, but only when needed" and turn it on by default when the
driver asks to sync pages. When a page is mapped, check whether it needs
syncs and if so, replace that "sync when needed" back to "always do
syncs" globally for the whole pool (better safe than sorry). As long as
the pool has no pages requiring DMA syncs, this cuts off a good piece
of calls and checks. When at least one page required it, the pool
conservatively falls back to "always call sync functions", no per-page
verdicts. It's a fairly rare case anyway that only a few pages would
require syncing.
On my x86_64, this gives from 2% to 5% performance benefit with no
negative impact for cases when IOMMU is on and the shortcut can't be
used.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/types.h | 3 ++-
 net/core/page_pool.c          | 7 ++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index dd26f4b2b66c..9134fb458cb2 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -97,8 +97,9 @@ struct page_pool {
 	bool dma_map:1;				/* Perform DMA mapping */
 	enum {
 		PP_DMA_SYNC_ACT_DISABLED = 0,	/* Driver didn't ask to sync */
+		PP_DMA_SYNC_ACT_SKIP,		/* Syncs can be skipped */
 		PP_DMA_SYNC_ACT_DO,		/* Perform DMA sync ops */
-	} dma_sync_act:1;
+	} dma_sync_act:2;
 	bool page_frag:1;			/* Allow page fragments */
 
 	long frag_users;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 6a8f105e2df5..529e4b41e9eb 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -197,7 +197,8 @@ static int page_pool_init(struct page_pool *pool,
 		if (!pool->p.max_len)
 			return -EINVAL;
 
-		pool->dma_sync_act = PP_DMA_SYNC_ACT_DO;
+		/* Try to avoid calling no-op syncs */
+		pool->dma_sync_act = PP_DMA_SYNC_ACT_SKIP;
 
 		/* pool->p.offset has to be set according to the address
 		 * offset used by the DMA engine to start copying rx data
@@ -350,6 +351,10 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 
 	page_pool_set_dma_addr(page, dma);
 
+	if (pool->dma_sync_act == PP_DMA_SYNC_ACT_SKIP &&
+	    dma_need_sync(pool->p.dev, dma))
+		pool->dma_sync_act = PP_DMA_SYNC_ACT_DO;
+
 	if (pool->dma_sync_act == PP_DMA_SYNC_ACT_DO)
 		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
 
-- 
2.41.0

