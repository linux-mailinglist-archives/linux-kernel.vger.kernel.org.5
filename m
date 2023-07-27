Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A81765643
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjG0OqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbjG0Op5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:45:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACB130E3;
        Thu, 27 Jul 2023 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690469146; x=1722005146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2UbKf7v2UR/BH4b/sLY6ZcXfEMndoDL0gkvxE3Ft3Vg=;
  b=WGsoPrkCUaCL2T8DvRzS42o1JA+UajI5CE95h0D8H09MOuhuLF1tb6c+
   1tnMNJSD3JXe9eTIN3pmjVFq+DJzisp+ZuzKvSSkrqWFMrxrefNA7TAD5
   YLmLeQGEkMGBtwqn3IIpyW4R7sB2F6eWL30mm1JjoJ76iMigxgkokSUOJ
   xx7RT4ZlDKW4IwFsJsgjyRUtyiLwUrcpag7Vj9J3QMj6jDfeXMXTTyAB2
   yW96b1Wpv/A1ffysmOcp6xcK4mLVh5ypqeSo5rQ/dlmW5REc1gmLktyid
   K3nxbP8ZiOscdVQ5rclPtGiRUQmVpvSPEuREYhbCZojgtgvc+NFt4vxFI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432139738"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="432139738"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 07:45:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817119912"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="817119912"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2023 07:45:42 -0700
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
Subject: [PATCH net-next 4/9] page_pool: shrink &page_pool_params a tiny bit
Date:   Thu, 27 Jul 2023 16:43:31 +0200
Message-ID: <20230727144336.1646454-5-aleksander.lobakin@intel.com>
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

For now, this structure takes a whole 64-byte cacheline on x86_64.
But in fact, it has a 4-byte hole before ::init_callback() (yet not
sufficient to change its sizeof()).
::dma_dir is whole 4 bytes, although its values can only be 0 and 2.
Merge it with ::flags and, so that its slot gets freed and reduces
the structure's size to 56 bytes. This adds instruction when reading
that field, but the upcoming change will make those reads happen way
less often.
Pad the freed slot explicitly in &page_pool to not alter cacheline
layout while it's not used.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/types.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 664a787948e1..c86f65e57614 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -44,13 +44,13 @@ struct pp_alloc_cache {
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
@@ -93,6 +93,7 @@ struct page_pool_stats {
 
 struct page_pool {
 	struct page_pool_params p;
+	long pad;
 
 	long frag_users;
 	struct page *frag_page;
-- 
2.41.0

