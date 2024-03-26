Return-Path: <linux-kernel+bounces-119855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A778B88CDCD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CA11F34004
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C316F13D28E;
	Tue, 26 Mar 2024 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QfrgKkzL"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8C13DABE1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483435; cv=none; b=Fc4pc6iT78MOsWW2yJbxQ5P9lb6pCCD0CLDKtCyUTOKrpFpNh/IKU4qDVfhc6jHusf2+AwJHYRRl/i8vitqjZk/uh59g6nHo21fKNYTKd6qadsoGKdnnBBHW/bbGeDeVdTSPOC5hmQ01BmyUlGip7405MCJnidBYQYkZxQFZdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483435; c=relaxed/simple;
	bh=MIiSoZ6mE0+FnxHUuLlWTFtl/Q3Ex3AKZHQH68vHLtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YftM3Pe0YGDGgSSbDavohiOtwc9k6s0GB+9qwiZrluQzWaR4yUND/Q92TP9IfF3/pfvfFZGRUMN0k685XthuG4NFfyYuvua7K29HE1NuRn02SPqmZ9bxTnZ6rOGIqP/Wtcs2cjUji82Souc4hHuzXP3MPKYNXDPqjQ0IR9u8AbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QfrgKkzL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YLa4HUex8/bG4yUSqFwJp3NxJNy5ji4AjU0vaS24NpE=; b=QfrgKkzLR29gB3iOewPE4iYJxs
	QtWtpERfgh33KhuP9fM4CvxU2ztdMs0g96ZTmklXK2ZqKLyb3CA8IczExZaTt8kHHTgP88bMzLb9H
	47y5gQx1FN0Pb04ji0qDxAbgQ135enJ9X6AuqtmTiRCrj4p6rV5wQxVz5utRq9d9w3uiyuEPgAOR0
	t52gkiur8X0rG2Xdcx1cKyNJMMm7iAFiCZxjyCllHEBPuAtzXv4F3N8KVPohv76VDvCmspM0eaW2e
	QOHsIjP69leW80Ur+Tn/W0BGhdB/k4o5wN0xS1GEw2YHn4Sy4QfQPgFC7oZLOU1LSCd60j0FBySXE
	WUVwbMiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpD13-000000029i7-42DQ;
	Tue, 26 Mar 2024 20:03:26 +0000
Date: Tue, 26 Mar 2024 20:03:25 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, "Huang, Ying" <ying.huang@intel.com>,
	Chris Li <chrisl@kernel.org>, Minchan Kim <minchan@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>,
	SeongJae Park <sj@kernel.org>, David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/10] mm/swap: convert swapin_readahead to return a
 folio
Message-ID: <ZgMqDWc7NrR5SIlP@casper.infradead.org>
References: <20240326185032.72159-1-ryncsn@gmail.com>
 <20240326185032.72159-4-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326185032.72159-4-ryncsn@gmail.com>

On Wed, Mar 27, 2024 at 02:50:25AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Simplify the caller code logic.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

I have this patch in my tree which is basically identical, but I think
has a slightly better commit message.  Feel free to merge the two.

From 0c17eefb4c1ca7733ca765ab2f28ee09c9110ec0 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Fri, 22 Mar 2024 13:28:33 -0400
Subject: [PATCH] mm: Return the folio from swapin_readahead

The unuse_pte_range() caller only wants the folio while do_swap_page()
wants both the page and the folio.  Since do_swap_page() already has
logic for handling both the folio and the page, move the folio-to-page
logic there.  This also lets us allocate larger folios in the
SWP_SYNCHRONOUS_IO path in future.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c     | 6 ++----
 mm/swap.h       | 6 +++---
 mm/swap_state.c | 8 +++-----
 mm/swapfile.c   | 5 +----
 4 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 40070ef01867..aedf0ee554d1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4020,7 +4020,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			/* skip swapcache */
 			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
 						vma, vmf->address, false);
-			page = &folio->page;
 			if (folio) {
 				__folio_set_locked(folio);
 				__folio_set_swapbacked(folio);
@@ -4045,10 +4044,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				folio->private = NULL;
 			}
 		} else {
-			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
+			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
 						vmf);
-			if (page)
-				folio = page_folio(page);
 			swapcache = folio;
 		}
 
@@ -4069,6 +4066,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		ret = VM_FAULT_MAJOR;
 		count_vm_event(PGMAJFAULT);
 		count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
+		page = folio_file_page(folio, swp_offset(entry));
 	} else if (PageHWPoison(page)) {
 		/*
 		 * hwpoisoned dirty swapcache pages are kept for killing
diff --git a/mm/swap.h b/mm/swap.h
index fc2f6ade7f80..6661b55b2c75 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -55,8 +55,8 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_flags,
 		bool skip_if_exists);
 struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 		struct mempolicy *mpol, pgoff_t ilx);
-struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
-			      struct vm_fault *vmf);
+struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
+		struct vm_fault *vmf);
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
@@ -87,7 +87,7 @@ static inline struct folio *swap_cluster_readahead(swp_entry_t entry,
 	return NULL;
 }
 
-static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
+static inline struct folio *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
 			struct vm_fault *vmf)
 {
 	return NULL;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 2deac23633cd..f3c379e93bc6 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -885,13 +885,13 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
  * @gfp_mask: memory allocation flags
  * @vmf: fault information
  *
- * Returns the struct page for entry and addr, after queueing swapin.
+ * Returns the struct folio for entry and addr, after queueing swapin.
  *
  * It's a main entry function for swap readahead. By the configuration,
  * it will read ahead blocks by cluster-based(ie, physical disk based)
  * or vma-based(ie, virtual address based on faulty address) readahead.
  */
-struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
+struct folio *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 				struct vm_fault *vmf)
 {
 	struct mempolicy *mpol;
@@ -904,9 +904,7 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
 	mpol_cond_put(mpol);
 
-	if (!folio)
-		return NULL;
-	return folio_file_page(folio, swp_offset(entry));
+	return folio;
 }
 
 #ifdef CONFIG_SYSFS
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5e6d2304a2a4..c9d041ad8df6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1883,7 +1883,6 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 		folio = swap_cache_get_folio(entry, vma, addr);
 		if (!folio) {
-			struct page *page;
 			struct vm_fault vmf = {
 				.vma = vma,
 				.address = addr,
@@ -1891,10 +1890,8 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				.pmd = pmd,
 			};
 
-			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
+			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
 						&vmf);
-			if (page)
-				folio = page_folio(page);
 		}
 		if (!folio) {
 			swp_count = READ_ONCE(si->swap_map[offset]);
-- 
2.43.0


>  mm/memory.c     | 8 +++-----
>  mm/swap.h       | 4 ++--
>  mm/swap_state.c | 6 ++----
>  mm/swapfile.c   | 5 +----
>  4 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index e42fadc25268..dfdb620a9123 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4005,12 +4005,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  			if (PTR_ERR(folio) == -EBUSY)
>  				goto out;
>  			need_clear_cache = true;
> -			page = &folio->page;
>  		} else {
> -			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
> -						vmf);
> -			if (page)
> -				folio = page_folio(page);
> +			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, vmf);
>  			swapcache = folio;
>  		}
>  
> @@ -4027,6 +4023,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  			goto unlock;
>  		}
>  
> +		page = folio_file_page(folio, swp_offset(entry));
> +
>  		/* Had to read the page from swap area: Major fault */
>  		ret = VM_FAULT_MAJOR;
>  		count_vm_event(PGMAJFAULT);
> diff --git a/mm/swap.h b/mm/swap.h
> index 40e902812cc5..aee134907a70 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -57,7 +57,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
>  		struct mempolicy *mpol, pgoff_t ilx);
>  struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
>  			    struct vm_fault *vmf);
> -struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
> +struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
>  			      struct vm_fault *vmf);
>  
>  static inline unsigned int folio_swap_flags(struct folio *folio)
> @@ -95,7 +95,7 @@ static inline struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
>  	return NULL;
>  }
>  
> -static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
> +static inline struct folio *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
>  			struct vm_fault *vmf)
>  {
>  	return NULL;
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 0a3fa48b3893..2a9c6bdff5ea 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -951,7 +951,7 @@ struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
>   * it will read ahead blocks by cluster-based(ie, physical disk based)
>   * or vma-based(ie, virtual address based on faulty address) readahead.
>   */
> -struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
> +struct folio *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  				struct vm_fault *vmf)
>  {
>  	struct mempolicy *mpol;
> @@ -964,9 +964,7 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  		swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
>  	mpol_cond_put(mpol);
>  
> -	if (!folio)
> -		return NULL;
> -	return folio_file_page(folio, swp_offset(entry));
> +	return folio;
>  }
>  
>  #ifdef CONFIG_SYSFS
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4919423cce76..4dd894395a0f 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1883,7 +1883,6 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  
>  		folio = swap_cache_get_folio(entry, vma, addr);
>  		if (!folio) {
> -			struct page *page;
>  			struct vm_fault vmf = {
>  				.vma = vma,
>  				.address = addr,
> @@ -1891,10 +1890,8 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  				.pmd = pmd,
>  			};
>  
> -			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
> +			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
>  						&vmf);
> -			if (page)
> -				folio = page_folio(page);
>  		}
>  		if (!folio) {
>  			swp_count = READ_ONCE(si->swap_map[offset]);
> -- 
> 2.43.0
> 

