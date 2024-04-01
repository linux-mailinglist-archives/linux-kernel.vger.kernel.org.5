Return-Path: <linux-kernel+bounces-126417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8CC893780
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 04:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686BA1C209FE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 02:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A265C138C;
	Mon,  1 Apr 2024 02:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3pGBVJg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9850A7F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 02:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711939956; cv=none; b=MoI6Pwc48pRBHH9OS8Uc59wIeqr31FslH3lwhJz2pvjoXtrDeeSiUSzNuO/MG8iGmYCXsVYUH1WUAT+24ckYm0VgMFEQN6dqTls6s8O9uOw6IFg2t8d7iWyMKf0e4/8x/7CLbXoa/fZhqO+cF0kYd8asCMPaDcLSS+uBApngoRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711939956; c=relaxed/simple;
	bh=vGA7sDQYoQv858YvmllNKPFLnGAF5d3t65jAh5FdeHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ShtaVkiK0oEdM2gNxJsADCB7XTYY5e/X+XMCrfmk9iuusrYPRtavMk+A1U5WhYmRgdF7EYPoLG12iPRbSe4Deg2qy0EKcnKBRGFljgoH90iWm3z2b/U9dEtpn8xeiCiF9vtnjc/C93Pv9s89mbNAs0lO37abWgYN1UqFFaqvAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3pGBVJg; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711939953; x=1743475953;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=vGA7sDQYoQv858YvmllNKPFLnGAF5d3t65jAh5FdeHo=;
  b=Y3pGBVJgugYjPbHJaVgQyX0o/mT9eYYFYhaJ0thimx2a8/AplGlz+isJ
   VCSz+lBu9Dep+EpCNwepVCs0eTeV1AyD/iZE/B+3TjqiqmDaku97kZjUI
   rB0msDv9hzViFUjb/d8FAlF5qzcihX5LlHWd4ZJ33rqe68H2W4NlR+jzl
   L9eTm/sevefiA3ROqVSQunmL6T1vqXQIRxaWI8V7FWCBZyLphrRrCj0Gl
   IAWTYGKOmPCpA9qydEc9Wc7Vsbhm9r/u/TMWco0hUCtBtjHaVdRgflEvb
   I32e6RsJCwHJX986vxzo2r9RyAaLidUbeJn/P3Aj7T8OJUtanbgXoGECl
   g==;
X-CSE-ConnectionGUID: K8+s4+9OQ9WQ9waNk2vaPg==
X-CSE-MsgGUID: gYhF0d0ASreBObhmvCVtBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="7269481"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="7269481"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 19:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="17652282"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 19:52:29 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org,  <david@redhat.com>,
  <mgorman@techsingularity.net>,  <wangkefeng.wang@huawei.com>,
  <jhubbard@nvidia.com>,  <21cnbao@gmail.com>,  <ryan.roberts@arm.com>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mm: support multi-size THP numa balancing
In-Reply-To: <d28d276d599c26df7f38c9de8446f60e22dd1950.1711683069.git.baolin.wang@linux.alibaba.com>
	(Baolin Wang's message of "Fri, 29 Mar 2024 14:56:46 +0800")
References: <cover.1711683069.git.baolin.wang@linux.alibaba.com>
	<d28d276d599c26df7f38c9de8446f60e22dd1950.1711683069.git.baolin.wang@linux.alibaba.com>
Date: Mon, 01 Apr 2024 10:50:36 +0800
Message-ID: <87sf05kd8j.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> Now the anonymous page allocation already supports multi-size THP (mTHP),
> but the numa balancing still prohibits mTHP migration even though it is an
> exclusive mapping, which is unreasonable.
>
> Allow scanning mTHP:
> Commit 859d4adc3415 ("mm: numa: do not trap faults on shared data section
> pages") skips shared CoW pages' NUMA page migration to avoid shared data
> segment migration. In addition, commit 80d47f5de5e3 ("mm: don't try to
> NUMA-migrate COW pages that have other uses") change to use page_count()
> to avoid GUP pages migration, that will also skip the mTHP numa scaning.
> Theoretically, we can use folio_maybe_dma_pinned() to detect the GUP
> issue, although there is still a GUP race, the issue seems to have been
> resolved by commit 80d47f5de5e3. Meanwhile, use the folio_likely_mapped_shared()
> to skip shared CoW pages though this is not a precise sharers count. To
> check if the folio is shared, ideally we want to make sure every page is
> mapped to the same process, but doing that seems expensive and using
> the estimated mapcount seems can work when running autonuma benchmark.
>
> Allow migrating mTHP:
> As mentioned in the previous thread[1], large folios (including THP) are
> more susceptible to false sharing issues among threads than 4K base page,
> leading to pages ping-pong back and forth during numa balancing, which is
> currently not easy to resolve. Therefore, as a start to support mTHP numa
> balancing, we can follow the PMD mapped THP's strategy, that means we can
> reuse the 2-stage filter in should_numa_migrate_memory() to check if the
> mTHP is being heavily contended among threads (through checking the CPU id
> and pid of the last access) to avoid false sharing at some degree. Thus,
> we can restore all PTE maps upon the first hint page fault of a large folio
> to follow the PMD mapped THP's strategy. In the future, we can continue to
> optimize the NUMA balancing algorithm to avoid the false sharing issue with
> large folios as much as possible.
>
> Performance data:
> Machine environment: 2 nodes, 128 cores Intel(R) Xeon(R) Platinum
> Base: 2024-03-25 mm-unstable branch
> Enable mTHP to run autonuma-benchmark
>
> mTHP:16K
> Base				Patched
> numa01				numa01
> 224.70				143.48
> numa01_THREAD_ALLOC		numa01_THREAD_ALLOC
> 118.05				47.43
> numa02				numa02
> 13.45				9.29
> numa02_SMT			numa02_SMT
> 14.80				7.50
>
> mTHP:64K
> Base				Patched
> numa01				numa01
> 216.15				114.40
> numa01_THREAD_ALLOC		numa01_THREAD_ALLOC
> 115.35				47.41
> numa02				numa02
> 13.24				9.25
> numa02_SMT			numa02_SMT
> 14.67				7.34
>
> mTHP:128K
> Base				Patched
> numa01				numa01
> 205.13				144.45
> numa01_THREAD_ALLOC		numa01_THREAD_ALLOC
> 112.93				41.88
> numa02				numa02
> 13.16				9.18
> numa02_SMT			numa02_SMT
> 14.81				7.49
>
> [1] https://lore.kernel.org/all/20231117100745.fnpijbk4xgmals3k@techsingularity.net/
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/memory.c   | 57 +++++++++++++++++++++++++++++++++++++++++++--------
>  mm/mprotect.c |  3 ++-
>  2 files changed, 51 insertions(+), 9 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index c30fb4b95e15..2aca19e4fbd8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5068,16 +5068,56 @@ static void numa_rebuild_single_mapping(struct vm_fault *vmf, struct vm_area_str
>  	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
>  }
>  
> +static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct vm_area_struct *vma,
> +				       struct folio *folio, pte_t fault_pte, bool ignore_writable)
> +{
> +	int nr = pte_pfn(fault_pte) - folio_pfn(folio);
> +	unsigned long start = max(vmf->address - nr * PAGE_SIZE, vma->vm_start);
> +	unsigned long end = min(vmf->address + (folio_nr_pages(folio) - nr) * PAGE_SIZE, vma->vm_end);
> +	pte_t *start_ptep = vmf->pte - (vmf->address - start) / PAGE_SIZE;
> +	bool pte_write_upgrade = vma_wants_manual_pte_write_upgrade(vma);

We call vma_wants_manual_pte_write_upgrade() in do_numa_page() already.
It seems that we can make "ignore_writable = true" if
"vma_wants_manual_pte_write_upgrade() == false" in do_numa_page() to
remove one call.

Otherwise, the patchset LGTM, feel free to add

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

in the future versions.

--
Best Regards,
Huang, Ying


> +	unsigned long addr;
> +
> +	/* Restore all PTEs' mapping of the large folio */
> +	for (addr = start; addr != end; start_ptep++, addr += PAGE_SIZE) {
> +		pte_t pte, old_pte;
> +		pte_t ptent = ptep_get(start_ptep);
> +		bool writable = false;
> +
> +		if (!pte_present(ptent) || !pte_protnone(ptent))
> +			continue;
> +
> +		if (pfn_folio(pte_pfn(ptent)) != folio)
> +			continue;
> +
> +		if (!ignore_writable) {
> +			ptent = pte_modify(ptent, vma->vm_page_prot);
> +			writable = pte_write(ptent);
> +			if (!writable && pte_write_upgrade &&
> +			    can_change_pte_writable(vma, addr, ptent))
> +				writable = true;
> +		}
> +
> +		old_pte = ptep_modify_prot_start(vma, addr, start_ptep);
> +		pte = pte_modify(old_pte, vma->vm_page_prot);
> +		pte = pte_mkyoung(pte);
> +		if (writable)
> +			pte = pte_mkwrite(pte, vma);
> +		ptep_modify_prot_commit(vma, addr, start_ptep, old_pte, pte);
> +		update_mmu_cache_range(vmf, vma, addr, start_ptep, 1);
> +	}
> +}
> +
>  static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct folio *folio = NULL;
>  	int nid = NUMA_NO_NODE;
> -	bool writable = false;
> +	bool writable = false, ignore_writable = false;
>  	int last_cpupid;
>  	int target_nid;
>  	pte_t pte, old_pte;
> -	int flags = 0;
> +	int flags = 0, nr_pages;
>  
>  	/*
>  	 * The pte cannot be used safely until we verify, while holding the page
> @@ -5107,10 +5147,6 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	if (!folio || folio_is_zone_device(folio))
>  		goto out_map;
>  
> -	/* TODO: handle PTE-mapped THP */
> -	if (folio_test_large(folio))
> -		goto out_map;
> -
>  	/*
>  	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
>  	 * much anyway since they can be in shared cache state. This misses
> @@ -5130,6 +5166,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  		flags |= TNF_SHARED;
>  
>  	nid = folio_nid(folio);
> +	nr_pages = folio_nr_pages(folio);
>  	/*
>  	 * For memory tiering mode, cpupid of slow memory page is used
>  	 * to record page access time.  So use default value.
> @@ -5146,6 +5183,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	}
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
>  	writable = false;
> +	ignore_writable = true;
>  
>  	/* Migrate to the requested node */
>  	if (migrate_misplaced_folio(folio, vma, target_nid)) {
> @@ -5166,14 +5204,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  
>  out:
>  	if (nid != NUMA_NO_NODE)
> -		task_numa_fault(last_cpupid, nid, 1, flags);
> +		task_numa_fault(last_cpupid, nid, nr_pages, flags);
>  	return 0;
>  out_map:
>  	/*
>  	 * Make it present again, depending on how arch implements
>  	 * non-accessible ptes, some can allow access by kernel mode.
>  	 */
> -	numa_rebuild_single_mapping(vmf, vma, writable);
> +	if (folio && folio_test_large(folio))
> +		numa_rebuild_large_mapping(vmf, vma, folio, pte, ignore_writable);
> +	else
> +		numa_rebuild_single_mapping(vmf, vma, writable);
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
>  	goto out;
>  }
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index f8a4544b4601..94878c39ee32 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -129,7 +129,8 @@ static long change_pte_range(struct mmu_gather *tlb,
>  
>  				/* Also skip shared copy-on-write pages */
>  				if (is_cow_mapping(vma->vm_flags) &&
> -				    folio_ref_count(folio) != 1)
> +				    (folio_maybe_dma_pinned(folio) ||
> +				     folio_likely_mapped_shared(folio)))
>  					continue;
>  
>  				/*

