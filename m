Return-Path: <linux-kernel+bounces-240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 572A2813E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB731F214EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAFF6C6DA;
	Thu, 14 Dec 2023 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="amm0jq7w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764A76C6DF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZpX9OyVmsooR71iBff+A80aL9guypQAVqM/obfLf98M=; b=amm0jq7wabv6SCHJhqIwRv3xPy
	EhUiM5cB2+Mjp9HMu+G06vCXsQd+tfcx1bcc5YchcZUIx4FAVV0VzJgtdOyF7nFY4RBoXHfETMalt
	szimEYe3iSqfh18Z3K6MQUeC7xw8/TMbgkaCoAkbcNgzFKsCmTdFAMm1242vXq7KG0jckxr+OFecQ
	0SCv+yThDYGMAeJwV8aVJI291SXmmnOOOX1SfRoOBi6e58aRNjHxJ9KafSsxGlxsM6nHptHuGAIoA
	mxgOMDplG5KBG5Pj7lz5E5Twy0ZMVZ92+3q7Eee/CbeZNJDbEfx2+C1gYASFKeqNK+VJMPUir0zpu
	A5Fb++zQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rDuhM-00B27e-Vk; Thu, 14 Dec 2023 23:00:57 +0000
Date: Thu, 14 Dec 2023 23:00:56 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
Cc: akpm@linux-foundation.org, tim.c.chen@linux.intel.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: remove redundant lru_add_drain() prior to
 unmapping pages
Message-ID: <ZXuJKAInbgtuSU9b@casper.infradead.org>
References: <20231214222717.50277-1-jianfeng.w.wang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214222717.50277-1-jianfeng.w.wang@oracle.com>

On Thu, Dec 14, 2023 at 02:27:17PM -0800, Jianfeng Wang wrote:
> When unmapping VMA pages, pages will be gathered in batch and released by
> tlb_finish_mmu() if CONFIG_MMU_GATHER_NO_GATHER is not set. The function
> tlb_finish_mmu() is responsible for calling free_pages_and_swap_cache(),
> which calls lru_add_drain() to drain cached pages in folio_batch before
> releasing gathered pages. Thus, it is redundant to call lru_add_drain()
> before gathering pages, if CONFIG_MMU_GATHER_NO_GATHER is not set.
> 
> Remove lru_add_drain() prior to gathering and unmapping pages in
> exit_mmap() and unmap_region() if CONFIG_MMU_GATHER_NO_GATHER is not set.
> 
> Note that the page unmapping process in oom_killer (e.g., in
> __oom_reap_task_mm()) also uses tlb_finish_mmu() and does not have
> redundant lru_add_drain(). So, this commit makes the code more consistent.

Shouldn't we put this in __tlb_gather_mmu() which already has the
CONFIG_MMU_GATHER_NO_GATHER ifdefs?  That would presuambly help with, eg
zap_page_range_single() too.

> Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
> ---
>  mm/mmap.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 1971bfffcc03..da0308eef435 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2330,7 +2330,10 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
>  	struct mmu_gather tlb;
>  	unsigned long mt_start = mas->index;
>  
> +	/* Defer lru_add_drain() to tlb_finish_mmu() for the ifndef case. */
> +#ifdef CONFIG_MMU_GATHER_NO_GATHER
>  	lru_add_drain();
> +#endif
>  	tlb_gather_mmu(&tlb, mm);
>  	update_hiwater_rss(mm);
>  	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
> @@ -3300,7 +3303,10 @@ void exit_mmap(struct mm_struct *mm)
>  		return;
>  	}
>  
> +	/* Defer lru_add_drain() to tlb_finish_mmu() for the ifndef case. */
> +#ifdef CONFIG_MMU_GATHER_NO_GATHER
>  	lru_add_drain();
> +#endif
>  	flush_cache_mm(mm);
>  	tlb_gather_mmu_fullmm(&tlb, mm);
>  	/* update_hiwater_rss(mm) here? but nobody should be looking */
> -- 
> 2.42.1
> 
> 

