Return-Path: <linux-kernel+bounces-134297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB16989B008
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5EF1F21B18
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C5918AE4;
	Sun,  7 Apr 2024 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MVvLUjIZ"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB1E182AF
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712481171; cv=none; b=WIKWFie7pIv9Ye7BRuneeLiDzlBiSNwWfhGQA5mVAiebLVKjRgxilqcs5jvIV/HwDvBqv/ZrbsEbRfjFzFKsFuXDP/ZJaRTQebN6WrQf3nIhMZRdwYC4MuEqtGYNcsiGTGjv9SN3f9qRVQfYtBpy3czKezGML6x9h1Vbg2TAoD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712481171; c=relaxed/simple;
	bh=LKm0LMutOTqq0hnmvCzgez1rhG/0GrlhQtL0cQ64pZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhGGiM/J2cO1oGjXr4PYJtpA995WX/9JveF8UJ8kM4MrAXhZCSirXUacaxDUwf58QQAFoCtxQOpaenKrIbJR9wzZEWFZZyc0B/EsQMqs+kCJBJkc9aJGEmBP9TTIgWXKWdgNHGZior6hHh8pmKkkGAZUMCC6ylyNiSUanCQHyqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MVvLUjIZ; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7d001108-157d-4139-bfa9-5b4102166f17@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712481166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9NNpLUc6dnajYrJPWgv0GAk8XCX/XzUPTDODuiC/IpM=;
	b=MVvLUjIZcLF5+LdnNKy5dKuuAqE+gNJqLgw7EW34IIU+NNITq81OqYa7dyMLQlMCMxFjx3
	jb/QIP7PgR/7XBIN+4npQMvSnJ03mM6FOB5CgV1ziDidt77TnxOcKj0yNYQIxVXhnbAIn8
	dYXpzd5egfJ1ScK6QCN9RS0dgwfb6qA=
Date: Sun, 7 Apr 2024 17:12:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] hugetlb: Convert hugetlb_wp() to use struct
 vm_fault
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 willy@infradead.org, linux-mm@kvack.org
References: <20240401202651.31440-1-vishal.moola@gmail.com>
 <20240401202651.31440-4-vishal.moola@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240401202651.31440-4-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/4/2 04:26, Vishal Moola (Oracle) wrote:
> hugetlb_wp() can use the struct vm_fault passed in from hugetlb_fault().
> This alleviates the stack by consolidating 5 variables into a single
> struct.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>   mm/hugetlb.c | 61 ++++++++++++++++++++++++++--------------------------
>   1 file changed, 30 insertions(+), 31 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index aca2f11b4138..d4f26947173e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5918,18 +5918,16 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
>    * Keep the pte_same checks anyway to make transition from the mutex easier.
>    */
>   static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
> -		       unsigned long address, pte_t *ptep, unsigned int flags,
> -		       struct folio *pagecache_folio, spinlock_t *ptl,
> +		       struct folio *pagecache_folio,

The same as comment in the previous thread.

Muchun,
Thanks.

>   		       struct vm_fault *vmf)
>   {
> -	const bool unshare = flags & FAULT_FLAG_UNSHARE;
> -	pte_t pte = huge_ptep_get(ptep);
> +	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
> +	pte_t pte = huge_ptep_get(vmf->pte);
>   	struct hstate *h = hstate_vma(vma);
>   	struct folio *old_folio;
>   	struct folio *new_folio;
>   	int outside_reserve = 0;
>   	vm_fault_t ret = 0;
> -	unsigned long haddr = address & huge_page_mask(h);
>   	struct mmu_notifier_range range;
>   
>   	/*
> @@ -5952,7 +5950,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   
>   	/* Let's take out MAP_SHARED mappings first. */
>   	if (vma->vm_flags & VM_MAYSHARE) {
> -		set_huge_ptep_writable(vma, haddr, ptep);
> +		set_huge_ptep_writable(vma, vmf->address, vmf->pte);
>   		return 0;
>   	}
>   
> @@ -5971,7 +5969,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   			SetPageAnonExclusive(&old_folio->page);
>   		}
>   		if (likely(!unshare))
> -			set_huge_ptep_writable(vma, haddr, ptep);
> +			set_huge_ptep_writable(vma, vmf->address, vmf->pte);
>   
>   		delayacct_wpcopy_end();
>   		return 0;
> @@ -5998,8 +5996,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   	 * Drop page table lock as buddy allocator may be called. It will
>   	 * be acquired again before returning to the caller, as expected.
>   	 */
> -	spin_unlock(ptl);
> -	new_folio = alloc_hugetlb_folio(vma, haddr, outside_reserve);
> +	spin_unlock(vmf->ptl);
> +	new_folio = alloc_hugetlb_folio(vma, vmf->address, outside_reserve);
>   
>   	if (IS_ERR(new_folio)) {
>   		/*
> @@ -6024,19 +6022,21 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   			 *
>   			 * Reacquire both after unmap operation.
>   			 */
> -			idx = vma_hugecache_offset(h, vma, haddr);
> +			idx = vma_hugecache_offset(h, vma, vmf->address);
>   			hash = hugetlb_fault_mutex_hash(mapping, idx);
>   			hugetlb_vma_unlock_read(vma);
>   			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>   
> -			unmap_ref_private(mm, vma, &old_folio->page, haddr);
> +			unmap_ref_private(mm, vma, &old_folio->page,
> +					vmf->address);
>   
>   			mutex_lock(&hugetlb_fault_mutex_table[hash]);
>   			hugetlb_vma_lock_read(vma);
> -			spin_lock(ptl);
> -			ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
> -			if (likely(ptep &&
> -				   pte_same(huge_ptep_get(ptep), pte)))
> +			spin_lock(vmf->ptl);
> +			vmf->pte = hugetlb_walk(vma, vmf->address,
> +					huge_page_size(h));
> +			if (likely(vmf->pte &&
> +				   pte_same(huge_ptep_get(vmf->pte), pte)))
>   				goto retry_avoidcopy;
>   			/*
>   			 * race occurs while re-acquiring page table
> @@ -6058,37 +6058,38 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   	if (unlikely(ret))
>   		goto out_release_all;
>   
> -	if (copy_user_large_folio(new_folio, old_folio, address, vma)) {
> +	if (copy_user_large_folio(new_folio, old_folio, vmf->real_address, vma)) {
>   		ret = VM_FAULT_HWPOISON_LARGE;
>   		goto out_release_all;
>   	}
>   	__folio_mark_uptodate(new_folio);
>   
> -	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, haddr,
> -				haddr + huge_page_size(h));
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, vmf->address,
> +				vmf->address + huge_page_size(h));
>   	mmu_notifier_invalidate_range_start(&range);
>   
>   	/*
>   	 * Retake the page table lock to check for racing updates
>   	 * before the page tables are altered
>   	 */
> -	spin_lock(ptl);
> -	ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
> -	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
> +	spin_lock(vmf->ptl);
> +	vmf->pte = hugetlb_walk(vma, vmf->address, huge_page_size(h));
> +	if (likely(vmf->pte && pte_same(huge_ptep_get(vmf->pte), pte))) {
>   		pte_t newpte = make_huge_pte(vma, &new_folio->page, !unshare);
>   
>   		/* Break COW or unshare */
> -		huge_ptep_clear_flush(vma, haddr, ptep);
> +		huge_ptep_clear_flush(vma, vmf->address, vmf->pte);
>   		hugetlb_remove_rmap(old_folio);
> -		hugetlb_add_new_anon_rmap(new_folio, vma, haddr);
> +		hugetlb_add_new_anon_rmap(new_folio, vma, vmf->address);
>   		if (huge_pte_uffd_wp(pte))
>   			newpte = huge_pte_mkuffd_wp(newpte);
> -		set_huge_pte_at(mm, haddr, ptep, newpte, huge_page_size(h));
> +		set_huge_pte_at(mm, vmf->address, vmf->pte, newpte,
> +				huge_page_size(h));
>   		folio_set_hugetlb_migratable(new_folio);
>   		/* Make the old page be freed below */
>   		new_folio = old_folio;
>   	}
> -	spin_unlock(ptl);
> +	spin_unlock(vmf->ptl);
>   	mmu_notifier_invalidate_range_end(&range);
>   out_release_all:
>   	/*
> @@ -6096,12 +6097,12 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>   	 * unshare)
>   	 */
>   	if (new_folio != old_folio)
> -		restore_reserve_on_error(h, vma, haddr, new_folio);
> +		restore_reserve_on_error(h, vma, vmf->address, new_folio);
>   	folio_put(new_folio);
>   out_release_old:
>   	folio_put(old_folio);
>   
> -	spin_lock(ptl); /* Caller expects lock to be held */
> +	spin_lock(vmf->ptl); /* Caller expects lock to be held */
>   
>   	delayacct_wpcopy_end();
>   	return ret;
> @@ -6365,8 +6366,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>   	hugetlb_count_add(pages_per_huge_page(h), mm);
>   	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
>   		/* Optimization, do the COW without a second fault */
> -		ret = hugetlb_wp(mm, vma, vmf->real_address, vmf->pte,
> -				vmf->flags, folio, vmf->ptl, vmf);
> +		ret = hugetlb_wp(mm, vma, folio, vmf);
>   	}
>   
>   	spin_unlock(vmf->ptl);
> @@ -6579,8 +6579,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   
>   	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
>   		if (!huge_pte_write(vmf.orig_pte)) {
> -			ret = hugetlb_wp(mm, vma, address, vmf.pte, flags,
> -					 pagecache_folio, vmf.ptl, &vmf);
> +			ret = hugetlb_wp(mm, vma, pagecache_folio, &vmf);
>   			goto out_put_page;
>   		} else if (likely(flags & FAULT_FLAG_WRITE)) {
>   			vmf.orig_pte = huge_pte_mkdirty(vmf.orig_pte);


