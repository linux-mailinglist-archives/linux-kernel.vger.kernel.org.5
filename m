Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FC475402A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbjGNRKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbjGNRKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:10:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38B91BC9;
        Fri, 14 Jul 2023 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689354630; x=1720890630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kiTsYEioJ7izscrRx7tHPX34fIZaR/ELFwfI0aW1H/A=;
  b=Nv9GglZ+1vkYSOR3AELnrpuv5j9Hv1nAWPzhWeQDnpV/JuYiHXNckP0h
   Q7NvFei7PmLQ5ASQlvXuvxuVgsEEhxzxBPH0N5kE4/e8uboVtHrX7q7WI
   CKD7LIepZgE1sS1856V1Ab8VwHghMNSos0o1ibKY2kmluoJtD3GtIgiik
   2/W6sHGJ/2zF0zXxEfGyQE9uCgE5tBbJb0gBn1vA3kOg4tPGve/W4Yf5X
   /WFPpyQiXmL/qftTll4YyCKz4Z+e11F7fVMyL7rQP5jvfXQbr7hGKl5I6
   YvnKf89jRe1Lzlh4aA/Sp5/A1n02gsT8DYC5K9MvrFxZjGZscggT8K25M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="451891862"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="451891862"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 10:10:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="787907020"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="787907020"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2023 10:10:27 -0700
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
Subject: [PATCH RFC net-next v2 2/7] net: page_pool: shrink &page_pool_params a tiny bit
Date:   Fri, 14 Jul 2023 19:08:46 +0200
Message-ID: <20230714170853.866018-4-aleksander.lobakin@intel.com>
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

For now, this structure takes a whole 64-byte cacheline on x86_64.
But in fact, it has a 4-byte hole before ::init_callback() (yet not
sufficient to change its sizeof()).
::dma_dir is whole 4 bytes, although its values can only be 0 and 2.
Merge it with ::flags and, so that its slot gets freed and reduces
structure's size to 56 bytes. This adds an instruction when reading
that field, but the upcoming change will make those reads happen way
less often.
Pad the freed slot explicitly in &page_pool to not alter cacheline
layout while it's not used.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 829dc1f8ba6b..69e822021d95 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -51,13 +51,13 @@ struct pp_alloc_cache {
 };
 
 struct page_pool_params {
-	unsigned int	flags;
+	unsigned int	flags:30;
+	enum dma_data_direction dma_dir:2; /* DMA mapping direction */
 	unsigned int	order;
 	unsigned int	pool_size;
 	int		nid;  /* Numa node id to allocate from pages from */
 	struct device	*dev; /* device, for DMA pre-mapping purposes */
 	struct napi_struct *napi; /* Sole consumer of pages, otherwise NULL */
-	enum dma_data_direction dma_dir; /* DMA mapping direction */
 	unsigned int	max_len; /* max DMA sync memory size */
 	unsigned int	offset;  /* DMA addr offset */
 	void (*init_callback)(struct page *page, void *arg);
@@ -129,6 +129,7 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
 
 struct page_pool {
 	struct page_pool_params p;
+	long pad;
 
 	struct delayed_work release_dw;
 	void (*disconnect)(void *);
-- 
2.41.0

