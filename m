Return-Path: <linux-kernel+bounces-120204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5293788D466
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768521C244C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48E320323;
	Wed, 27 Mar 2024 02:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlR9Uo3h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3583821345
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711505211; cv=none; b=ETy8gLg2IyKNOtK4CYU9GfFLNypHbuP/6TATmbHdwb5zlm6zRI1RpUusHF6KSk1uz4sa4yYgOxuFPzgM5vlj+ypigvFgxPCYovcWqcAEIE7CCXO5kamuVtrVUbVrEeMgJnyzbQrsS1n/lXTmRvuEjB/Z1XqcQGARGXSOtj0mHZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711505211; c=relaxed/simple;
	bh=3gnnr3PK6ah6ZPYmN8IAeDIVM2VGJfLz3txD1AY2Uiw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OkP5FNQXHmvCCZh1IT1jYQLK/QLhsa6NowtdnD9baxHl57/y+pPyzqKIhoqubb+kTBeuA9jCb/tfmOPSUHZaY/Uen1pPUljTzkv7P2IVjlRcrvbc6dGViEZG6K2//7SjjIwm8Cr4iQOoQglihM0vl2TQILRc+EA/0B3WDBFyM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlR9Uo3h; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711505210; x=1743041210;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=3gnnr3PK6ah6ZPYmN8IAeDIVM2VGJfLz3txD1AY2Uiw=;
  b=FlR9Uo3hRCbr72zeOOXbX5UsibIodcohjg9Hk5jv6NdtXyFAcggCkyF/
   eFvFweMtrKfMmxh0V4SF1HzknI7ISUWe7Q89IaNqpkxygvabmCHPkce7A
   ubSVXpXyrHCftxNZneUf3oT0O1OQk6Aa4NmfgopxsJ7oYRVbwas6Gb5Ky
   2E8rHluZ3Fks9UxqhGuNqP4b9hrVK3YGtHTb7lRAPYh0YsjwKjZXHVANc
   moBmA4oaG0Xv9H9SokVwXab9oHG89Cjytj9DhtTSfNttIqVDq/vB5VRtn
   TQlboCvePUwjEpybm4yU/XPziKcNPujRtib/TjbLRRnRndjscA6cfvuwJ
   A==;
X-CSE-ConnectionGUID: iSjTBqPsQkOjhtsI/IUOAw==
X-CSE-MsgGUID: ua6QyllJQy+wPkhEYN9EMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24077170"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="24077170"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 19:06:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="16797573"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 19:06:46 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org,  <david@redhat.com>,
  <mgorman@techsingularity.net>,  <wangkefeng.wang@huawei.com>,
  <jhubbard@nvidia.com>,  <21cnbao@gmail.com>,  <ryan.roberts@arm.com>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: support multi-size THP numa balancing
In-Reply-To: <dee4268f1797f31c6bb6bdab30f8ad3df9053d3d.1711453317.git.baolin.wang@linux.alibaba.com>
	(Baolin Wang's message of "Tue, 26 Mar 2024 19:51:25 +0800")
References: <cover.1711453317.git.baolin.wang@linux.alibaba.com>
	<dee4268f1797f31c6bb6bdab30f8ad3df9053d3d.1711453317.git.baolin.wang@linux.alibaba.com>
Date: Wed, 27 Mar 2024 10:04:52 +0800
Message-ID: <87cyrgo2ez.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Because now we can deal with shared mTHP, it appears even possible to
remove folio_likely_mapped_shared() check?

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
> 224.70				137.23
> numa01_THREAD_ALLOC		numa01_THREAD_ALLOC
> 118.05				50.57
> numa02				numa02
> 13.45				9.30
> numa02_SMT			numa02_SMT
> 14.80				7.43
>
> mTHP:64K
> Base				Patched
> numa01				numa01
> 216.15				135.20
> numa01_THREAD_ALLOC		numa01_THREAD_ALLOC
> 115.35				46.93
> numa02				numa02
> 13.24				9.24
> numa02_SMT			numa02_SMT
> 14.67				7.31
>
> mTHP:128K
> Base				Patched
> numa01				numa01
> 205.13				140.41
> numa01_THREAD_ALLOC		numa01_THREAD_ALLOC
> 112.93				44.78
> numa02				numa02
> 13.16				9.19
> numa02_SMT			numa02_SMT
> 14.81				7.39
>
> [1] https://lore.kernel.org/all/20231117100745.fnpijbk4xgmals3k@techsingularity.net/
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/memory.c   | 56 +++++++++++++++++++++++++++++++++++++++++++--------
>  mm/mprotect.c |  3 ++-
>  2 files changed, 50 insertions(+), 9 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index c30fb4b95e15..36191a9c799c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5068,16 +5068,55 @@ static void numa_rebuild_single_mapping(struct vm_fault *vmf, struct vm_area_str
>  	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
>  }
>  
> +static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct vm_area_struct *vma,
> +				       struct folio *folio, pte_t fault_pte, bool ignore_writable)
> +{
> +	int nr = pte_pfn(fault_pte) - folio_pfn(folio);
> +	unsigned long start = max(vmf->address - nr * PAGE_SIZE, vma->vm_start);
> +	unsigned long end = min(start + folio_nr_pages(folio) * PAGE_SIZE, vma->vm_end);

If start is in the middle of folio, it's possible for end to go beyond
the end of folio.  So, should be something like below?

	unsigned long end = min(vmf->address + (folio_nr_pages(folio) - nr) * PAGE_SIZE, vma->vm_end);

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
> +		if (vm_normal_folio(vma, addr, ptent) != folio)
> +			continue;
> +
> +		if (!ignore_writable) {
> +			writable = pte_write(pte);
> +			if (!writable && pte_write_upgrade &&
> +			    can_change_pte_writable(vma, addr, pte))
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

Can this be batched for the whole folio?

> +	}
> +}
> +

[snip]

--
Best Regards,
Huang, Ying

