Return-Path: <linux-kernel+bounces-121459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF2388E9B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D75EB2A572
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2BA13B7AC;
	Wed, 27 Mar 2024 14:45:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E81213B5A3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550752; cv=none; b=D1GzORHCaNKo1yyNNJjRrosvqIWPmBmhWmC7G2EyIf7jBjOE5to/iIxhCv92sOyN1Jw09ew7FQ2+jC9a/0fUvOkZ9bip/s659qt0ZSjOlYq5CTmsC2QPgt6WwlDZzpULFH3DSl6Lidymt3aGr+KwcXtofJ2CrUgd2+e46Dh+VA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550752; c=relaxed/simple;
	bh=3iKYsObEjvapYvWdaa2NRufgr79oAXIg+M7pfKmVkhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r23Ki3uROCefutQTIHK6Ug7I0xzU9ccKjozkbOgVUkn8QvOcjmB5JIOOv29dRFcNgRAghIXz28WAMKH5XDwfWSZoCkzlY3g1jLUaYAqbQYuMJ84XePx9rbsqvp7CERIgRFmezk9WJdoTAeIDHKCnUbXkHM9XzXsVmAV+4TdLpMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BA2C2F4;
	Wed, 27 Mar 2024 07:46:22 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 703203F64C;
	Wed, 27 Mar 2024 07:45:46 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Gao Xiang <xiang@kernel.org>,
	Yu Zhao <yuzhao@google.com>,
	Yang Shi <shy828301@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Chris Li <chrisl@kernel.org>,
	Lance Yang <ioworker0@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/6] Swap-out mTHP without splitting
Date: Wed, 27 Mar 2024 14:45:31 +0000
Message-Id: <20240327144537.4165578-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series adds support for swapping out multi-size THP (mTHP) without needing
to first split the large folio via split_huge_page_to_list_to_order(). It
closely follows the approach already used to swap-out PMD-sized THP.

There are a couple of reasons for swapping out mTHP without splitting:

  - Performance: It is expensive to split a large folio and under extreme memory
    pressure some workloads regressed performance when using 64K mTHP vs 4K
    small folios because of this extra cost in the swap-out path. This series
    not only eliminates the regression but makes it faster to swap out 64K mTHP
    vs 4K small folios.

  - Memory fragmentation avoidance: If we can avoid splitting a large folio
    memory is less likely to become fragmented, making it easier to re-allocate
    a large folio in future.

  - Performance: Enables a separate series [5] to swap-in whole mTHPs, which
    means we won't lose the TLB-efficiency benefits of mTHP once the memory has
    been through a swap cycle.

I've done what I thought was the smallest change possible, and as a result, this
approach is only employed when the swap is backed by a non-rotating block device
(just as PMD-sized THP is supported today). Discussion against the RFC concluded
that this is sufficient.


Performance Testing
===================

I've run some swap performance tests on Ampere Altra VM (arm64) with 8 CPUs. The
VM is set up with a 35G block ram device as the swap device and the test is run
from inside a memcg limited to 40G memory. I've then run `usemem` from
vm-scalability with 70 processes, each allocating and writing 1G of memory. I've
repeated everything 6 times and taken the mean performance improvement relative
to 4K page baseline:

| alloc size |                baseline |           + this series |
|            | mm-unstable (~v6.9-rc1) |                         |
|:-----------|------------------------:|------------------------:|
| 4K Page    |                    0.0% |                    1.3% |
| 64K THP    |                  -13.6% |                   46.3% |
| 2M THP     |                   91.4% |                   89.6% |

So with this change, the 64K swap performance goes from a 14% regression to a
46% improvement. While 2M shows a small regression I'm confident that this is
just noise.

---
The series applies against mm-unstable (4e567abb6482) with the addition of a
small fix for an arm64 build break (reported at [6]).


Changes since v4 [4]
====================

  - patch #3:
    - Added R-B from Huang, Ying - thanks!
  - patch #4:
    - get_swap_pages() now takes order instead of nr_pages (per Huang, Ying)
    - Removed WARN_ON_ONCE() from get_swap_pages()
    - Reworded comment for scan_swap_map_try_ssd_cluster() (per Huang, Ying)
    - Unified VM_WARN_ON()s in scan_swap_map_slots() to scan: (per Huang, Ying)
    - Removed redundant "order == 0" check (per Huang, Ying)
  - patch #5:
    - Marked list_empty() check with data_race() (per David)
    - Added R-B from Barry and David - thanks!
  - patch #6:
    - Implemented mkold_ptes() generic helper (pre David)
    - Enhanced folio_pte_batch() to report any_young (per David)
    - madvise_cold_or_pageout_pte_range() sets old in batch (per David)
    - Added R-B from Barry - thanks!


Changes since v3 [3]
====================

 - Renamed SWAP_NEXT_NULL -> SWAP_NEXT_INVALID (per Huang, Ying)
 - Simplified max offset calculation (per Huang, Ying)
 - Reinstated struct percpu_cluster to contain per-cluster, per-order `next`
   offset (per Huang, Ying)
 - Removed swap_alloc_large() and merged its functionality into
   scan_swap_map_slots() (per Huang, Ying)
 - Avoid extra cost of folio ref and lock due to removal of CLUSTER_FLAG_HUGE
   by freeing swap entries in batches (see patch 2) (per DavidH)
 - vmscan splits folio if its partially mapped (per Barry Song, DavidH)
 - Avoid splitting in MADV_PAGEOUT path (per Barry Song)
 - Dropped "mm: swap: Simplify ssd behavior when scanner steals entry" patch
   since it's not actually a problem for THP as I first thought.


Changes since v2 [2]
====================

 - Reuse scan_swap_map_try_ssd_cluster() between order-0 and order > 0
   allocation. This required some refactoring to make everything work nicely
   (new patches 2 and 3).
 - Fix bug where nr_swap_pages would say there are pages available but the
   scanner would not be able to allocate them because they were reserved for the
   per-cpu allocator. We now allow stealing of order-0 entries from the high
   order per-cpu clusters (in addition to exisiting stealing from order-0
   per-cpu clusters).


Changes since v1 [1]
====================

 - patch 1:
    - Use cluster_set_count() instead of cluster_set_count_flag() in
      swap_alloc_cluster() since we no longer have any flag to set. I was unable
      to kill cluster_set_count_flag() as proposed against v1 as other call
      sites depend explicitly setting flags to 0.
 - patch 2:
    - Moved large_next[] array into percpu_cluster to make it per-cpu
      (recommended by Huang, Ying).
    - large_next[] array is dynamically allocated because PMD_ORDER is not
      compile-time constant for powerpc (fixes build error).


[1] https://lore.kernel.org/linux-mm/20231010142111.3997780-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/20231017161302.2518826-1-ryan.roberts@arm.com/
[3] https://lore.kernel.org/linux-mm/20231025144546.577640-1-ryan.roberts@arm.com/
[4] https://lore.kernel.org/all/20240311150058.1122862-1-ryan.roberts@arm.com/
[5] https://lore.kernel.org/linux-mm/20240304081348.197341-1-21cnbao@gmail.com/
[6] https://lore.kernel.org/all/b9944ac1-3919-4bb2-8b65-f3e5c52bc2aa@arm.com/

Thanks,
Ryan

Ryan Roberts (6):
  mm: swap: Remove CLUSTER_FLAG_HUGE from swap_cluster_info:flags
  mm: swap: free_swap_and_cache_nr() as batched free_swap_and_cache()
  mm: swap: Simplify struct percpu_cluster
  mm: swap: Allow storage of all mTHP orders
  mm: vmscan: Avoid split during shrink_folio_list()
  mm: madvise: Avoid split during MADV_PAGEOUT and MADV_COLD

 include/linux/pgtable.h |  58 ++++++++
 include/linux/swap.h    |  35 +++--
 mm/huge_memory.c        |   3 -
 mm/internal.h           |  60 +++++++-
 mm/madvise.c            | 100 +++++++------
 mm/memory.c             |  17 +--
 mm/swap_slots.c         |   6 +-
 mm/swapfile.c           | 306 ++++++++++++++++++++++------------------
 mm/vmscan.c             |   9 +-
 9 files changed, 380 insertions(+), 214 deletions(-)

--
2.25.1


