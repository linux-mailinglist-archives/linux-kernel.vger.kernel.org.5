Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125CD7814E9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241023AbjHRVwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240595AbjHRVvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:51:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61813C2D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AC2560AF4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 21:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AB0C433C7;
        Fri, 18 Aug 2023 21:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692395506;
        bh=+SAT99L6p9qOrwwqGuKFzj5xcLxv7JFhB1+eCLgFZuU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dbh5QhQmBygkxwdLjiMPu2w5pXn7CeOAFhdOUPFyLloz6pyREQZO4qeRwk8861+dB
         48k/D47ll89A2sUHd/iWhG9S9WorqufA78zTZNHnFVVphmJuclIFJVs0zvoHujLgmb
         c354+FtvkYl9dlDJnGillRdR3rmp8l770u2PHKMJ8NazQFBM6Cz+z2/7/HsLv+W39i
         OrB70Piv040gv7C2LMixbmAEAejRrsf9lO0J12pN/DfZNoouSYCnjvOCBZbsaGw3q6
         6n32LWPpjJnEAos48GCHC2oVmrhuM0G1l/1HCH1jK5UY2dXtfv18z+jxq2/M8r3caG
         FAMxTr0urLxzw==
Date:   Fri, 18 Aug 2023 14:51:45 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
Message-ID: <20230818145145.4b357c89@kernel.org>
In-Reply-To: <CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
References: <20230816100113.41034-1-linyunsheng@huawei.com>
        <20230816100113.41034-2-linyunsheng@huawei.com>
        <CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
        <20230817091554.31bb3600@kernel.org>
        <CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
        <20230817165744.73d61fb6@kernel.org>
        <CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 09:12:09 +0300 Ilias Apalodimas wrote:
> > Right, IIUC we don't have enough space to fit dma_addr_t and the
> > refcount, but if we store the dma addr on a shifted u32 instead
> > of using dma_addr_t explicitly - the refcount should fit?  
> 
> struct page looks like this:
> 
> unsigned long dma_addr;
> union {
>       unsigned long dma_addr_upper;
>       atomic_long_t pp_frag_count;
> };

I could be completely misunderstanding the problem.
Let me show you the diff of what I was thinking more or less.

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5e74ce4a28cd..58ffa8dc745f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -126,11 +126,6 @@ struct page {
 			unsigned long _pp_mapping_pad;
 			unsigned long dma_addr;
 			union {
-				/**
-				 * dma_addr_upper: might require a 64-bit
-				 * value on 32-bit architectures.
-				 */
-				unsigned long dma_addr_upper;
 				/**
 				 * For frag page support, not supported in
 				 * 32-bit architectures with 64-bit DMA.
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 94231533a369..6f87a0fa2178 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -212,16 +212,24 @@ static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
 	dma_addr_t ret = page->dma_addr;
 
 	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
-		ret |= (dma_addr_t)page->dma_addr_upper << 16 << 16;
+		ret <<= PAGE_SHIFT;
 
 	return ret;
 }
 
-static inline void page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
+static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
 {
+	bool failed = false;
+
 	page->dma_addr = addr;
-	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
-		page->dma_addr_upper = upper_32_bits(addr);
+	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT) {
+		page->dma_addr >>= PAGE_SHIFT;
+		/* We assume page alignment to shave off bottom bits,
+		 * if this "compression" doesn't work we need to drop.
+		 */
+		failed = addr != page->dma_addr << PAGE_SHIFT;
+	}
+	return failed;
 }
 
 static inline bool page_pool_put(struct page_pool *pool)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 77cb75e63aca..9ea42e242a89 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -211,10 +211,6 @@ static int page_pool_init(struct page_pool *pool,
 		 */
 	}
 
-	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
-	    pool->p.flags & PP_FLAG_PAGE_FRAG)
-		return -EINVAL;
-
 #ifdef CONFIG_PAGE_POOL_STATS
 	pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
 	if (!pool->recycle_stats)
@@ -359,12 +355,19 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 	if (dma_mapping_error(pool->p.dev, dma))
 		return false;
 
-	page_pool_set_dma_addr(page, dma);
+	if (page_pool_set_dma_addr(page, dma))
+		goto unmap_failed;
 
 	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
 		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
 
 	return true;
+
+unmap_failed:
+	dma_unmap_page_attrs(pool->p.dev, dma,
+			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
+			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
+	return false;
 }
 
 static void page_pool_set_pp_info(struct page_pool *pool,
