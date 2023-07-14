Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB05754036
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbjGNRK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbjGNRKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:10:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9DC35A9;
        Fri, 14 Jul 2023 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689354643; x=1720890643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0cjmwAPzX05MPogT7th10UjSW/BOs61e1u7pspt8ffY=;
  b=hfNbHbc7oQrnvg+hMX/NosMuAv3hvP5MnQ1O1wCHSodtuj3osRivS6nR
   kuQzm91WIpuGyXqZcJSYzfEeY/NSkXoqzAhYO1TXsTFgI2nCUspS9uR6B
   23kaCf49pBr3wCMuVOuzwtcbIUKxKFX/tBp/x2nT0bcYXLpd+ovKCDg2F
   OZSg8xUiue7J0Od2aA3g+mbxn5x+Jlj9NT3thvTG9/68N6ohmcq9a6SaR
   SmH0gTbO2Ot1EWMMkjyTsAqat+fZsx1k+dmqD1sZIk3gdOYZuOa1sgFaU
   NVS/JNH1/J89pN4x+Es7Us3YI4IISmC2hv/fNqySAwuRVIw8Myyf2MhKk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="451891921"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="451891921"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 10:10:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="787907073"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="787907073"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2023 10:10:38 -0700
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
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next v2 5/7] net: page_pool: avoid calling no-op externals when possible
Date:   Fri, 14 Jul 2023 19:08:50 +0200
Message-ID: <20230714170853.866018-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714170853.866018-1-aleksander.lobakin@intel.com>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 include/net/page_pool.h | 1 +
 net/core/page_pool.c    | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index aefcb76baf0e..3a2e1b29ff3e 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -133,6 +133,7 @@ struct page_pool {
 	bool dma_map:1;				/* Perform DMA mapping */
 	enum {
 		PP_DMA_SYNC_ACT_DISABLED = 0,	/* Driver didn't ask to sync */
+		PP_DMA_SYNC_ACT_SKIP,		/* Syncs can be skipped */
 		PP_DMA_SYNC_ACT_DO,		/* Perform DMA sync ops */
 	} dma_sync_act:2;
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 67957e74e1f5..ee6ce6786e29 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -196,7 +196,8 @@ static int page_pool_init(struct page_pool *pool,
 		if (!pool->p.max_len)
 			return -EINVAL;
 
-		pool->dma_sync_act = PP_DMA_SYNC_ACT_DO;
+		/* Try to avoid calling no-op syncs */
+		pool->dma_sync_act = PP_DMA_SYNC_ACT_SKIP;
 
 		/* pool->p.offset has to be set according to the address
 		 * offset used by the DMA engine to start copying rx data
@@ -345,6 +346,10 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 
 	page_pool_set_dma_addr(page, dma);
 
+	if (pool->dma_sync_act == PP_DMA_SYNC_ACT_SKIP &&
+	    dma_need_sync(pool->p.dev, dma))
+		pool->dma_sync_act = PP_DMA_SYNC_ACT_DO;
+
 	if (pool->dma_sync_act == PP_DMA_SYNC_ACT_DO)
 		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
 
-- 
2.41.0

