Return-Path: <linux-kernel+bounces-99962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 825FA878FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED65E1F21FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7030A77F00;
	Tue, 12 Mar 2024 08:45:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81FD76EEA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233128; cv=none; b=O3JDejSzg+c/2ZzuGU7k0klXLisowvLB4KJt1CclYIWlPAqGyUvp6v/UcXLdjLEFNSyU5MZOO70Yj/RS0dzAKfeMKM97YLJr9UfFnS4Ji8yUEF7UBxKQwT+wVV2gdGx78FSPBN/ZccaMA/VpDpp9+iAc9FGBhY6MpdXki9CocW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233128; c=relaxed/simple;
	bh=geOnI5+yro433FwcsqWEKQU6S+hcouaat93T1RGM1As=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGcZiclhiOYfLZpmnbjacBAV5DBrMn21aLI+55E+f1F8nGbIPpCvQ4MkdFyPsTpf34ZMo1zNZauK3vt1MJGR0LUolKH6cxcvgfrPPbxbTRSTr7XU2NjdW3WXq+EqlvdY/S1oL8MS2HzNVokmcq6tDMz6d7ewG98GMMsTRy2BXIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED2B11007;
	Tue, 12 Mar 2024 01:46:01 -0700 (PDT)
Received: from [10.57.68.246] (unknown [10.57.68.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81D7E3F73F;
	Tue, 12 Mar 2024 01:45:22 -0700 (PDT)
Message-ID: <f845b091-c2e6-4ee7-a736-c82dad3b51f9@arm.com>
Date: Tue, 12 Mar 2024 08:45:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] Swap-out mTHP without splitting
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>,
 Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240311150058.1122862-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/03/2024 15:00, Ryan Roberts wrote:
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

Oops, just noticed I failed to update these column headers. The baseline is
actually mm-unstable (d7182786dd0a) which is based on v6.8-rc5 and already
contains "anonfolio" - now called mTHP.


> |:-----------|--------------------:|--------------------:|
> | 4K Page    |                0.0% |                1.4% |
> | 64K THP    |              -14.6% |               44.2% |
> | 2M THP     |               87.4% |               97.7% |
> 
> So with this change, the 64K swap performance goes from a 15% regression to a
> 44% improvement. 4K and 2M swap improves slightly too.
> 
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
> 


