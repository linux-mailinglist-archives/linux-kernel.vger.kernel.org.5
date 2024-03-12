Return-Path: <linux-kernel+bounces-99933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6648878F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A64B281B68
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C504069979;
	Tue, 12 Mar 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDY+Vgzq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A466996F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230595; cv=none; b=FXvbI9ApL3HaW7b5EX2k5JbsQ2kO4Uei1g8UvRsrUElXqwl5gJigVPxcLP5bkRLyarR5ThQx6aMyQHkdiGBLQO7Pv26QZG85eQLFK5B9zbjB8usZB5xezES5Xxib97UH5Tm2oYcbcTk8Y6oDF1RckSc0ghtCXIj1Mrq8sdIkb+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230595; c=relaxed/simple;
	bh=hUuRCZbJAfCL6ahmXMw92X3zLMAmqys0a5FggAtZv+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L9bY5+n8lGUS8tc+fMZjH2D509Qp6hH64UubN77RbRe8XL2kNNsducrnhdSI5ZR48641yitOfnQa42Pz6v5WiPag65lU3PAguElEc7/hTaU/R9IOq0p74JftTorBWJt2fXHMC3SfZKEw4rbISS+86f8+o6JHAdoauZy7ykiIg50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDY+Vgzq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710230593; x=1741766593;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=hUuRCZbJAfCL6ahmXMw92X3zLMAmqys0a5FggAtZv+g=;
  b=CDY+VgzqpVjcpU47cV6E7p51qfClf1jFuks90iPJyr8hXJ5IMbn9YTqA
   kESfkjbIeeGuUQb80RadHNlDHyJV98/WcTawbJpTmb3H/lAsT3GJ63bGN
   sCHVFDVsspaGqMcyBEKWnCoDRMFWk/QPRMv4sl0f2CK9Km81tNGxipNUW
   yejWzWindPmV9F9w2/NCrPWRhBdzYf535pKHMss/mo7pIZvz/suWWIRB1
   4BhTeoG2Qizxtl0rV7mTvUsGmCjMDGB2aSWxoxgN89+6zoAlunpS5VbVc
   YkmGJkhNCXCB3/bxsivk/0fPOcPJbTE7x2cg+E0l/lKZam6OgEGspq2Qo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="22444293"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="22444293"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 01:03:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="11364384"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 01:03:08 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@redhat.com>,  Matthew Wilcox <willy@infradead.org>,  Gao Xiang
 <xiang@kernel.org>,  Yu Zhao <yuzhao@google.com>,  Yang Shi
 <shy828301@gmail.com>,  Michal Hocko <mhocko@suse.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  Barry Song <21cnbao@gmail.com>,  Chris Li
 <chrisl@kernel.org>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/6] Swap-out mTHP without splitting
In-Reply-To: <20240311150058.1122862-1-ryan.roberts@arm.com> (Ryan Roberts's
	message of "Mon, 11 Mar 2024 15:00:52 +0000")
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
Date: Tue, 12 Mar 2024 16:01:15 +0800
Message-ID: <878r2n516c.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

> Hi All,
>
> This series adds support for swapping out multi-size THP (mTHP) without needing
> to first split the large folio via split_huge_page_to_list_to_order(). It
> closely follows the approach already used to swap-out PMD-sized THP.
>
> There are a couple of reasons for swapping out mTHP without splitting:
>
>   - Performance: It is expensive to split a large folio and under extreme memory
>     pressure some workloads regressed performance when using 64K mTHP vs 4K
>     small folios because of this extra cost in the swap-out path. This series
>     not only eliminates the regression but makes it faster to swap out 64K mTHP
>     vs 4K small folios.
>
>   - Memory fragmentation avoidance: If we can avoid splitting a large folio
>     memory is less likely to become fragmented, making it easier to re-allocate
>     a large folio in future.
>
>   - Performance: Enables a separate series [4] to swap-in whole mTHPs, which
>     means we won't lose the TLB-efficiency benefits of mTHP once the memory has
>     been through a swap cycle.
>
> I've done what I thought was the smallest change possible, and as a result, this
> approach is only employed when the swap is backed by a non-rotating block device
> (just as PMD-sized THP is supported today). Discussion against the RFC concluded
> that this is sufficient.
>
>
> Performance Testing
> ===================
>
> I've run some swap performance tests on Ampere Altra VM (arm64) with 8 CPUs. The
> VM is set up with a 35G block ram device as the swap device and the test is run
> from inside a memcg limited to 40G memory. I've then run `usemem` from
> vm-scalability with 70 processes, each allocating and writing 1G of memory. I've
> repeated everything 6 times and taken the mean performance improvement relative
> to 4K page baseline:
>
> | alloc size |            baseline |       + this series |
> |            |  v6.6-rc4+anonfolio |                     |
> |:-----------|--------------------:|--------------------:|
> | 4K Page    |                0.0% |                1.4% |
> | 64K THP    |              -14.6% |               44.2% |
> | 2M THP     |               87.4% |               97.7% |
>
> So with this change, the 64K swap performance goes from a 15% regression to a
> 44% improvement. 4K and 2M swap improves slightly too.

I don't understand why the performance of 2M THP improves.  The swap
entry allocation becomes a little slower.  Can you provide some
perf-profile to root cause it?

--
Best Regards,
Huang, Ying

> This test also acts as a good stress test for swap and, more generally mm. A
> couple of existing bugs were found as a result [5] [6].
>
>
> ---
> The series applies against mm-unstable (d7182786dd0a). Although I've
> additionally been running with a couple of extra fixes to avoid the issues at
> [6].
>
>
> Changes since v3 [3]
> ====================
>
>  - Renamed SWAP_NEXT_NULL -> SWAP_NEXT_INVALID (per Huang, Ying)
>  - Simplified max offset calculation (per Huang, Ying)
>  - Reinstated struct percpu_cluster to contain per-cluster, per-order `next`
>    offset (per Huang, Ying)
>  - Removed swap_alloc_large() and merged its functionality into
>    scan_swap_map_slots() (per Huang, Ying)
>  - Avoid extra cost of folio ref and lock due to removal of CLUSTER_FLAG_HUGE
>    by freeing swap entries in batches (see patch 2) (per DavidH)
>  - vmscan splits folio if its partially mapped (per Barry Song, DavidH)
>  - Avoid splitting in MADV_PAGEOUT path (per Barry Song)
>  - Dropped "mm: swap: Simplify ssd behavior when scanner steals entry" patch
>    since it's not actually a problem for THP as I first thought.
>
>
> Changes since v2 [2]
> ====================
>
>  - Reuse scan_swap_map_try_ssd_cluster() between order-0 and order > 0
>    allocation. This required some refactoring to make everything work nicely
>    (new patches 2 and 3).
>  - Fix bug where nr_swap_pages would say there are pages available but the
>    scanner would not be able to allocate them because they were reserved for the
>    per-cpu allocator. We now allow stealing of order-0 entries from the high
>    order per-cpu clusters (in addition to exisiting stealing from order-0
>    per-cpu clusters).
>
>
> Changes since v1 [1]
> ====================
>
>  - patch 1:
>     - Use cluster_set_count() instead of cluster_set_count_flag() in
>       swap_alloc_cluster() since we no longer have any flag to set. I was unable
>       to kill cluster_set_count_flag() as proposed against v1 as other call
>       sites depend explicitly setting flags to 0.
>  - patch 2:
>     - Moved large_next[] array into percpu_cluster to make it per-cpu
>       (recommended by Huang, Ying).
>     - large_next[] array is dynamically allocated because PMD_ORDER is not
>       compile-time constant for powerpc (fixes build error).
>
>
> [1] https://lore.kernel.org/linux-mm/20231010142111.3997780-1-ryan.roberts@arm.com/
> [2] https://lore.kernel.org/linux-mm/20231017161302.2518826-1-ryan.roberts@arm.com/
> [3] https://lore.kernel.org/linux-mm/20231025144546.577640-1-ryan.roberts@arm.com/
> [4] https://lore.kernel.org/linux-mm/20240304081348.197341-1-21cnbao@gmail.com/
> [5] https://lore.kernel.org/linux-mm/20240311084426.447164-1-ying.huang@intel.com/
> [6] https://lore.kernel.org/linux-mm/79dad067-1d26-4867-8eb1-941277b9a77b@arm.com/
>
> Thanks,
> Ryan
>
>
> Ryan Roberts (6):
>   mm: swap: Remove CLUSTER_FLAG_HUGE from swap_cluster_info:flags
>   mm: swap: free_swap_and_cache_nr() as batched free_swap_and_cache()
>   mm: swap: Simplify struct percpu_cluster
>   mm: swap: Allow storage of all mTHP orders
>   mm: vmscan: Avoid split during shrink_folio_list()
>   mm: madvise: Avoid split during MADV_PAGEOUT and MADV_COLD
>
>  include/linux/pgtable.h |  28 ++++
>  include/linux/swap.h    |  33 +++--
>  mm/huge_memory.c        |   3 -
>  mm/internal.h           |  48 +++++++
>  mm/madvise.c            | 101 ++++++++------
>  mm/memory.c             |  13 +-
>  mm/swapfile.c           | 298 ++++++++++++++++++++++------------------
>  mm/vmscan.c             |   9 +-
>  8 files changed, 332 insertions(+), 201 deletions(-)
>
> --
> 2.25.1

