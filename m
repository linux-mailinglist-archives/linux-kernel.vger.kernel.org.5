Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C207CCDEE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344445AbjJQUZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjJQUZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:25:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA9EF9;
        Tue, 17 Oct 2023 13:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697574335; x=1729110335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1KnITalfSoEUJepIi5EFi3cXKWjkojf3kZ3un2NNboE=;
  b=NnrPIv5fKSyMVkk67iI5ylmjTZ9cZLCTxsyMcz7w3W+yac57UxZbCmIX
   li8hOnnXqElYlefL66UjMDmAL9BXz9wMbkeqtzGGC0mS7hPPvtYN4KY5N
   NMsnGyOFV8jqqUp2kDzD6eKu8QK2Ef3jcP4SEAdct9btON3Hx8P6OvXPE
   BF64XV4nvllAmMWbmOaO15wilnoCWd1F/Yh+PnUd16MUUnS0GqJtk0jPT
   5b4JFnscG9p8hyD5C0XCcI55dO/piasSGritenD29uYugwEY9UvAZ8P58
   N6Fb9ARnOJq8sUS1/d9C1Vn4iJ7VsaiueDjwiYSRvRdS0hDmNCOv13DCm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="7429557"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="7429557"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:25:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="900040460"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="900040460"
Received: from rtdinh-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.212.150.155])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:23:31 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, kirill.shutemov@linux.intel.com,
        elena.reshetova@intel.com, isaku.yamahata@intel.com,
        seanjc@google.com, Michael Kelley <mikelley@microsoft.com>,
        thomas.lendacky@amd.com, decui@microsoft.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     rick.p.edgecombe@intel.com, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: [PATCH 06/10] dma: Use free_decrypted_pages()
Date:   Tue, 17 Oct 2023 13:25:01 -0700
Message-Id: <20231017202505.340906-7-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On TDX it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to take
care to handle these errors to avoid returning decrypted (shared) memory to
the page allocator, which could lead to functional or security issues.

DMA could free decrypted/shared pages if set_memory_decrypted() fails.
Use the recently added free_decrypted_pages() to avoid this.

Several paths also result in proper encrypted pages being freed through
the same freeing function. Rely on free_decrypted_pages() to not leak the
memory in these cases.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/dma-map-ops.h | 3 ++-
 kernel/dma/contiguous.c     | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index f2fc203fb8a1..b0800cbbc357 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -9,6 +9,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/pgtable.h>
 #include <linux/slab.h>
+#include <linux/set_memory.h>
 
 struct cma;
 
@@ -165,7 +166,7 @@ static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
 static inline void dma_free_contiguous(struct device *dev, struct page *page,
 		size_t size)
 {
-	__free_pages(page, get_order(size));
+	free_decrypted_pages((unsigned long)page_address(page), get_order(size));
 }
 #endif /* CONFIG_DMA_CMA*/
 
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index f005c66f378c..e962f1f6434e 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -429,7 +429,7 @@ void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 	}
 
 	/* not in any cma, free from buddy */
-	__free_pages(page, get_order(size));
+	free_decrypted_pages((unsigned long)page_address(page), get_order(size));
 }
 
 /*
-- 
2.34.1

