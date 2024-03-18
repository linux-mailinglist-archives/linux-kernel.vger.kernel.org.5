Return-Path: <linux-kernel+bounces-105735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D22787E3A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE901F20F75
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D3F22325;
	Mon, 18 Mar 2024 06:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lF4EyoHd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735AB21101
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710742739; cv=none; b=TX68yA3FgQ8aFofQfN05ZTNrm607HAZ+gjIjoJ8UeQqIr8rE6eqQ/iNCsgENKfVvoTtM9QOeDyBbUTdmGmPHEod7m1M/oftyrxnE7s0yGthOngWffKTM+aDpRz9S0js5vFj5+dgRAK3bF5tOJawyHvBt9Uf4e+YVc/uxAUa3zso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710742739; c=relaxed/simple;
	bh=/uxO/1t0VF+da2zFcsIPhImm0cli6tNt05gP60hyl1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hGOqFeESJEy2IXkGr2i6tMHmbCtuSptWR9qRNo8l+dwPzDFP4sYO9sfCXeML42enEp/Ri4z4rREIlRV7kH/cyDSCUB+gGWjUz0xkLpuHOrta9H+BL5gUdzaQ4RLva8Kmr/LMFwL1Rkoag35vvqTBei0TL73gByVvqRDr+9BRIGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lF4EyoHd; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710742737; x=1742278737;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/uxO/1t0VF+da2zFcsIPhImm0cli6tNt05gP60hyl1k=;
  b=lF4EyoHde5pvqd0Fj5M74OkvFzHdoYSoPs7GRFFTqlfptppNIO835HL9
   FcVyNplf05h0Mat4pDdjkkj363gQ/r2CMtt5ZtqshxpHX0wIdl/GPiwAh
   c1dpon0VlA8AxLgTCcHDhA1k68WU98S6ebfXH+IkzMW+DZjBoaYWL+fRP
   bQcjAX7/dyxqTsah8yyWjPMFLCymlRfT7Q6SWl2vLBCPBiioIwEl7o/Td
   i85Bv3cNYAsJwg0bxM3g3o3eWTk6wS4Ms/lyx506sT956GcchBw6USCFe
   VQVTGj69brtcJoaKvW5SP5KRYnvIO6746D4zn7otpSkhh85N/bkoKr0Q4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="16087119"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="16087119"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 23:18:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13754252"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 23:18:53 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org,  <david@redhat.com>,
  <mgorman@techsingularity.net>,  <wangkefeng.wang@huawei.com>,
  <jhubbard@nvidia.com>,  <21cnbao@gmail.com>,  <ryan.roberts@arm.com>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] mm: support multi-size THP numa balancing
In-Reply-To: <903bf13fc3e68b8dc1f256570d78b55b2dd9c96f.1710493587.git.baolin.wang@linux.alibaba.com>
	(Baolin Wang's message of "Fri, 15 Mar 2024 17:18:14 +0800")
References: <903bf13fc3e68b8dc1f256570d78b55b2dd9c96f.1710493587.git.baolin.wang@linux.alibaba.com>
Date: Mon, 18 Mar 2024 14:16:59 +0800
Message-ID: <871q88vzc4.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> exclusive mapping, which is unreasonable. Thus let's support the exclusive
> mTHP numa balancing firstly.
>
> Allow scanning mTHP:
> Commit 859d4adc3415 ("mm: numa: do not trap faults on shared data section
> pages") skips shared CoW pages' NUMA page migration to avoid shared data
> segment migration. In addition, commit 80d47f5de5e3 ("mm: don't try to
> NUMA-migrate COW pages that have other uses") change to use page_count()
> to avoid GUP pages migration, that will also skip the mTHP numa scaning.
> Theoretically, we can use folio_maybe_dma_pinned() to detect the GUP
> issue, although there is still a GUP race, the issue seems to have been
> resolved by commit 80d47f5de5e3. Meanwhile, use the folio_estimated_sharers()
> to skip shared CoW pages though this is not a precise sharers count. To
> check if the folio is shared, ideally we want to make sure every page is
> mapped to the same process, but doing that seems expensive and using
> the estimated mapcount seems can work when running autonuma benchmark.
>
> Allow migrating mTHP:
> As mentioned in the previous thread[1], large folios are more susceptible
> to false sharing issues, leading to pages ping-pong back and forth during
> numa balancing, which is currently hard to resolve. Therefore, as a start to
> support mTHP numa balancing, only exclusive mappings are allowed to perform
> numa migration to avoid the false sharing issues with large folios. Similarly,
> use the estimated mapcount to skip shared mappings, which seems can work
> in most cases (?), and we've used folio_estimated_sharers() to skip shared
> mappings in migrate_misplaced_folio() for numa balancing, seems no real
> complaints.

IIUC, folio_estimated_sharers() cannot identify multi-thread
applications.  If some mTHP is shared by multiple threads in one
process, how to deal with that?

For example, I think that we should avoid to migrate on the first fault
for mTHP in should_numa_migrate_memory().

More thoughts?  Can we add a field in struct folio for mTHP to count
hint page faults from the same node?

--
Best Regards,
Huang, Ying

> Performance data:
> Machine environment: 2 nodes, 128 cores Intel(R) Xeon(R) Platinum
> Base: 2024-3-15 mm-unstable branch
> Enable mTHP=64K to run autonuma-benchmark
>
> Base without the patch:
> numa01
> 222.97
> numa01_THREAD_ALLOC
> 115.78
> numa02
> 13.04
> numa02_SMT
> 14.69
>
> Base with the patch:
> numa01
> 125.36
> numa01_THREAD_ALLOC
> 44.58
> numa02
> 9.22
> numa02_SMT
> 7.46
>
> [1] https://lore.kernel.org/all/20231117100745.fnpijbk4xgmals3k@techsingularity.net/
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Changes from RFC v1:
>  - Add some preformance data per Huang, Ying.
>  - Allow mTHP scanning per David Hildenbrand.
>  - Avoid sharing mapping for numa balancing to avoid false sharing.
>  - Add more commit message.
> ---
>  mm/memory.c   | 9 +++++----
>  mm/mprotect.c | 3 ++-
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index f2bc6dd15eb8..b9d5d88c5a76 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5059,7 +5059,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	int last_cpupid;
>  	int target_nid;
>  	pte_t pte, old_pte;
> -	int flags = 0;
> +	int flags = 0, nr_pages = 0;
>  
>  	/*
>  	 * The pte cannot be used safely until we verify, while holding the page
> @@ -5089,8 +5089,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	if (!folio || folio_is_zone_device(folio))
>  		goto out_map;
>  
> -	/* TODO: handle PTE-mapped THP */
> -	if (folio_test_large(folio))
> +	/* Avoid large folio false sharing */
> +	if (folio_test_large(folio) && folio_estimated_sharers(folio) > 1)
>  		goto out_map;
>  
>  	/*
> @@ -5112,6 +5112,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  		flags |= TNF_SHARED;
>  
>  	nid = folio_nid(folio);
> +	nr_pages = folio_nr_pages(folio);
>  	/*
>  	 * For memory tiering mode, cpupid of slow memory page is used
>  	 * to record page access time.  So use default value.
> @@ -5148,7 +5149,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  
>  out:
>  	if (nid != NUMA_NO_NODE)
> -		task_numa_fault(last_cpupid, nid, 1, flags);
> +		task_numa_fault(last_cpupid, nid, nr_pages, flags);
>  	return 0;
>  out_map:
>  	/*
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index f8a4544b4601..f0b9c974aaae 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -129,7 +129,8 @@ static long change_pte_range(struct mmu_gather *tlb,
>  
>  				/* Also skip shared copy-on-write pages */
>  				if (is_cow_mapping(vma->vm_flags) &&
> -				    folio_ref_count(folio) != 1)
> +				    (folio_maybe_dma_pinned(folio) ||
> +				     folio_estimated_sharers(folio) > 1))
>  					continue;
>  
>  				/*

