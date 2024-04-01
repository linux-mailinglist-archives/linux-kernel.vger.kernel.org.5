Return-Path: <linux-kernel+bounces-126432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 642598937DE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 05:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B0728151A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59E3539A;
	Mon,  1 Apr 2024 03:47:34 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AD51C2D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 03:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711943254; cv=none; b=cjOYHIWnLYq8OUFT11lO8WaYj5lzDKEbi1Xa6o9VP7G5OpY6gBkr7382EEQWQWa7rwfqmvU0DNITaGsA5gLjzqqFPlZZqH1iX4cBGysz9X5Y8ZEaabTkdl7MNKIsTv3mwXQSeSf6Y4Lvk/2AnO5ACUU3loejGxOhtH8GUn6C7sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711943254; c=relaxed/simple;
	bh=hKvYqKD8DWFNFLgkZXl8enqUTOM4i9FWTNgYn0TN31E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RFg2wpy+6wMHfLrZVYrFISkfNMui9ipPRk2waciiMGxJ3GiEysFFUXH7EaWltVy2IdcX8DgybEyDmhAB8xRbgrRMqqarSe0wKHX8S/sfvyWTVmcH62Jw1txXrIw9gQKceDWNOFX/bkicKBVuPHjL2N5bAXm6Ym7aApn7rPha9Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V7H2P6NSnz1h50d;
	Mon,  1 Apr 2024 11:44:45 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 66D81180060;
	Mon,  1 Apr 2024 11:47:29 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 11:47:28 +0800
Message-ID: <86236280-a811-4d5a-a480-5006226ae379@huawei.com>
Date: Mon, 1 Apr 2024 11:47:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm: support multi-size THP numa balancing
Content-Language: en-US
To: Baolin Wang <baolin.wang@linux.alibaba.com>, <akpm@linux-foundation.org>
CC: <david@redhat.com>, <mgorman@techsingularity.net>, <jhubbard@nvidia.com>,
	<ying.huang@intel.com>, <21cnbao@gmail.com>, <ryan.roberts@arm.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <cover.1711683069.git.baolin.wang@linux.alibaba.com>
 <d28d276d599c26df7f38c9de8446f60e22dd1950.1711683069.git.baolin.wang@linux.alibaba.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <d28d276d599c26df7f38c9de8446f60e22dd1950.1711683069.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/3/29 14:56, Baolin Wang wrote:
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
>   mm/memory.c   | 57 +++++++++++++++++++++++++++++++++++++++++++--------
>   mm/mprotect.c |  3 ++-
>   2 files changed, 51 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c30fb4b95e15..2aca19e4fbd8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5068,16 +5068,56 @@ static void numa_rebuild_single_mapping(struct vm_fault *vmf, struct vm_area_str
>   	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
>   }
>   
> +static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct vm_area_struct *vma,
> +				       struct folio *folio, pte_t fault_pte, bool ignore_writable)
> +{
> +	int nr = pte_pfn(fault_pte) - folio_pfn(folio);
> +	unsigned long start = max(vmf->address - nr * PAGE_SIZE, vma->vm_start);
> +	unsigned long end = min(vmf->address + (folio_nr_pages(folio) - nr) * PAGE_SIZE, vma->vm_end);
> +	pte_t *start_ptep = vmf->pte - (vmf->address - start) / PAGE_SIZE;
> +	bool pte_write_upgrade = vma_wants_manual_pte_write_upgrade(vma);
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

Maybe pass "unsigned long address, pte_t *ptep" to 
numa_rebuild_single_mapping(),
then, just call it here.

> +	}
> +}
> +
>   static vm_fault_t do_numa_page(struct vm_fault *vmf)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   	struct folio *folio = NULL;
>   	int nid = NUMA_NO_NODE;
> -	bool writable = false;
> +	bool writable = false, ignore_writable = false;
>   	int last_cpupid;
>   	int target_nid;
>   	pte_t pte, old_pte;
> -	int flags = 0;
> +	int flags = 0, nr_pages;
>   
>   	/*
>   	 * The pte cannot be used safely until we verify, while holding the page
> @@ -5107,10 +5147,6 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>   	if (!folio || folio_is_zone_device(folio))
>   		goto out_map;
>   
> -	/* TODO: handle PTE-mapped THP */
> -	if (folio_test_large(folio))
> -		goto out_map;
> -
>   	/*
>   	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
>   	 * much anyway since they can be in shared cache state. This misses
> @@ -5130,6 +5166,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>   		flags |= TNF_SHARED;
>   
>   	nid = folio_nid(folio);
> +	nr_pages = folio_nr_pages(folio);
>   	/*
>   	 * For memory tiering mode, cpupid of slow memory page is used
>   	 * to record page access time.  So use default value.
> @@ -5146,6 +5183,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>   	}
>   	pte_unmap_unlock(vmf->pte, vmf->ptl);
>   	writable = false;
> +	ignore_writable = true;
>   
>   	/* Migrate to the requested node */
>   	if (migrate_misplaced_folio(folio, vma, target_nid)) {
> @@ -5166,14 +5204,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>   
>   out:
>   	if (nid != NUMA_NO_NODE)
> -		task_numa_fault(last_cpupid, nid, 1, flags);
> +		task_numa_fault(last_cpupid, nid, nr_pages, flags);
>   	return 0;
>   out_map:
>   	/*
>   	 * Make it present again, depending on how arch implements
>   	 * non-accessible ptes, some can allow access by kernel mode.
>   	 */
> -	numa_rebuild_single_mapping(vmf, vma, writable);
> +	if (folio && folio_test_large(folio))
initialize nr_pages and then call

	if (nr_pages > 1)

> +		numa_rebuild_large_mapping(vmf, vma, folio, pte, ignore_writable);
> +	else
> +		numa_rebuild_single_mapping(vmf, vma, writable);
>   	pte_unmap_unlock(vmf->pte, vmf->ptl);
>   	goto out;
>   }
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index f8a4544b4601..94878c39ee32 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -129,7 +129,8 @@ static long change_pte_range(struct mmu_gather *tlb,
>   
>   				/* Also skip shared copy-on-write pages */
>   				if (is_cow_mapping(vma->vm_flags) &&
> -				    folio_ref_count(folio) != 1)
> +				    (folio_maybe_dma_pinned(folio) ||
> +				     folio_likely_mapped_shared(folio)))
>   					continue;
>   
>   				/*

