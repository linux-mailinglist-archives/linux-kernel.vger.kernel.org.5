Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB3D7F7846
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345956AbjKXPvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345946AbjKXPu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:50:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FA01BE5;
        Fri, 24 Nov 2023 07:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700841033; x=1732377033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QB7T4VQwmQ+0xVtmW8rio/vSicVVolgZqKcd2fC6AEI=;
  b=RjRq+HLTzNJljZu0LbNO72ahJY3lHE2eUXB7xPmQkNC4zccGRG74w/43
   0/8UwhrctqOoIu+gfvNi0pghIEnuN0bLpXe5cYFwfUnQWGdT2XsgNSECh
   x/vfGc5OeALdwYAmJtlabGXnv7hJmyp2776If9hRY0v7OZf6raYlfXdqX
   fH699WGKoAA9L04oUGqk15YeISWHTOFAEy2RX3BP+g/xqPjL2FOCgmBqs
   G4i+a9L8enEwXAe70YNs1BpW0a7Az4505DKucwImlO4qOTlBubfoTm1oF
   dK2V3PxV7VuPgicONa3fUPTHFNy/YcXmWaxyXcHUaelLZn69+uDx0Mvd0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="389592560"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="389592560"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 07:50:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="15660129"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 24 Nov 2023 07:50:30 -0800
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 08/14] page_pool: add DMA-sync-for-CPU inline helpers
Date:   Fri, 24 Nov 2023 16:47:26 +0100
Message-ID: <20231124154732.1623518-9-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each driver is responsible for syncing buffers written by HW for CPU
before accessing them. Almost each PP-enabled driver uses the same
pattern, which could be shorthanded into a static inline to make driver
code a little bit more compact.
Introduce a couple such functions. The first one is sorta internal and
performs DMA synchronization unconditionally for the size passed from
the driver. The second checks whether the synchronization is needed
for this pool first and is the main one to be used by the drivers.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/helpers.h | 43 +++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 528a76c66270..797275e75d38 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -432,6 +432,49 @@ static inline bool page_pool_dma_addr_need_sync(const struct page *page)
 	return page->dma_addr & PAGE_POOL_DMA_ADDR_NEED_SYNC;
 }
 
+/**
+ * __page_pool_dma_sync_for_cpu - sync Rx page for CPU after it's written by HW
+ * @pool: &page_pool the @page belongs to
+ * @page: page to sync
+ * @offset: offset from page start to "hard" start if using frags
+ * @dma_sync_size: size of the data written to the page
+ *
+ * Can be used as a shorthand to sync Rx pages before accessing them in the
+ * driver. Caller must ensure the pool was created with ```PP_FLAG_DMA_MAP```.
+ * Note that this version performs DMA sync unconditionally, even if the
+ * associated PP doesn't perform sync-for-device. Consider the non-underscored
+ * version first if unsure.
+ */
+static inline void __page_pool_dma_sync_for_cpu(const struct page_pool *pool,
+						const struct page *page,
+						u32 offset, u32 dma_sync_size)
+{
+	dma_sync_single_range_for_cpu(pool->p.dev,
+				      page_pool_get_dma_addr(page),
+				      offset + pool->p.offset, dma_sync_size,
+				      page_pool_get_dma_dir(pool));
+}
+
+/**
+ * page_pool_dma_sync_for_cpu - sync Rx page for CPU if needed
+ * @pool: &page_pool the @page belongs to
+ * @page: page to sync
+ * @offset: offset from page start to "hard" start if using frags
+ * @dma_sync_size: size of the data written to the page
+ *
+ * Performs DMA sync for CPU, but *only* when both:
+ * 1) page_pool was created with ```PP_FLAG_DMA_SYNC_DEV``` to manage DMA sync;
+ * 2) sync shortcut is not available (IOMMU, swiotlb, non-coherent DMA, ...)
+ */
+static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
+					      const struct page *page,
+					      u32 offset, u32 dma_sync_size)
+{
+	if (page_pool_dma_addr_need_sync(page))
+		__page_pool_dma_sync_for_cpu(pool, page, offset,
+					     dma_sync_size);
+}
+
 static inline bool page_pool_put(struct page_pool *pool)
 {
 	return refcount_dec_and_test(&pool->user_cnt);
-- 
2.42.0

