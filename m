Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649D77FD64B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjK2MGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjK2MGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:06:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A09C310C0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:06:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D7DB2F4;
        Wed, 29 Nov 2023 04:07:35 -0800 (PST)
Received: from [10.57.70.211] (unknown [10.57.70.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48AA93F5A1;
        Wed, 29 Nov 2023 04:06:46 -0800 (PST)
Message-ID: <db4c7beb-ed80-445f-b6f4-0c4cf3f0e6be@arm.com>
Date:   Wed, 29 Nov 2023 12:06:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Swap-out small-sized THP without splitting
Content-Language: en-GB
To:     Barry Song <21cnbao@gmail.com>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        shy828301@gmail.com, wangkefeng.wang@huawei.com,
        willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
        yuzhao@google.com, hanchuanhua@oppo.com
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20231129074741.15682-1-v-songbaohua@oppo.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231129074741.15682-1-v-songbaohua@oppo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2023 07:47, Barry Song wrote:
>> Hi All,
>>
>> This is v3 of a series to add support for swapping out small-sized THP without
>> needing to first split the large folio via __split_huge_page(). It closely
>> follows the approach already used by PMD-sized THP.
>>
>> "Small-sized THP" is an upcoming feature that enables performance improvements
>> by allocating large folios for anonymous memory, where the large folio size is
>> smaller than the traditional PMD-size. See [3].
>>
>> In some circumstances I've observed a performance regression (see patch 2 for
>> details), and this series is an attempt to fix the regression in advance of
>> merging small-sized THP support.
>>
>> I've done what I thought was the smallest change possible, and as a result, this
>> approach is only employed when the swap is backed by a non-rotating block device
>> (just as PMD-sized THP is supported today). Discussion against the RFC concluded
>> that this is probably sufficient.
>>
>> The series applies against mm-unstable (1a3c85fa684a)
>>
>>
>> Changes since v2 [2]
>> ====================
>>
>>  - Reuse scan_swap_map_try_ssd_cluster() between order-0 and order > 0
>>    allocation. This required some refactoring to make everything work nicely
>>    (new patches 2 and 3).
>>  - Fix bug where nr_swap_pages would say there are pages available but the
>>    scanner would not be able to allocate them because they were reserved for the
>>    per-cpu allocator. We now allow stealing of order-0 entries from the high
>>    order per-cpu clusters (in addition to exisiting stealing from order-0
>>    per-cpu clusters).
>>
>> Thanks to Huang, Ying for the review feedback and suggestions!
>>
>>
>> Changes since v1 [1]
>> ====================
>>
>>  - patch 1:
>>     - Use cluster_set_count() instead of cluster_set_count_flag() in
>>       swap_alloc_cluster() since we no longer have any flag to set. I was unable
>>       to kill cluster_set_count_flag() as proposed against v1 as other call
>>       sites depend explicitly setting flags to 0.
>>  - patch 2:
>>     - Moved large_next[] array into percpu_cluster to make it per-cpu
>>       (recommended by Huang, Ying).
>>     - large_next[] array is dynamically allocated because PMD_ORDER is not
>>       compile-time constant for powerpc (fixes build error).
>>
>>
>> Thanks,
>> Ryan
> 
>> P.S. I know we agreed this is not a prerequisite for merging small-sized THP,
>> but given Huang Ying had provided some review feedback, I wanted to progress it.
>> All the actual prerequisites are either complete or being worked on by others.
>>
> 
> Hi Ryan,
> 
> this is quite important to a phone and a must-have component, so is large-folio
> swapin, as i explained to you in another email. 

Yes understood; the "prerequisites" are just the things that must be merged
*before* small-sized THP to ensure we don't regress existing behaviour or to
ensure that small-size THP is correct/robust when enabled. Performance
improvements can be merged after the initial small-sized series.

> Luckily, we are having Chuanhua Han(Cc-ed) to prepare a patchset of largefolio
> swapin on top of your this patchset, probably a port and cleanup of our
> do_swap_page[1] againest yours.

That's great to hear - welcome aboard, Chuanhua Han! Feel free to reach out if
you have questions.

I would guess that any large swap-in changes would be independent of this
swap-out patch though? Wouldn't you just be looking for contiguous swap entries
in the page table to determine a suitable folio order, then swap-in each of
those entries into the folio? And if they happen to have contiguous swap offsets
(enabled by this swap-out series) then you potentially get a batched disk access
benefit.

That's just a guess though, perhaps you can describe your proposed approach?

> 
> Another concern is that swapslots can be fragmented, if we place small/large folios
> in a swap device, since large folios always require contiguous swapslot, we can
> result in failure of getting slots even we still have many free slots which are not
> contiguous.

This series tries to mitigate that problem by reserving a swap cluster per
order. That works well until we run out of swap clusters; a cluster can't be
freed until all contained swap entries are swapped back in and deallocated.

But I think we should start with the simple approach first, and only solve the
problems as they arise through real testing.

 To avoid this, [2] dynamic hugepage solution have two swap devices,
> one for basepage, the other one for CONTPTE. we have modified the priority-based
> selection of swap devices to choose swap devices based on small/large folios.
> i realize this approache is super ugly and might be very hard to find a way to
> upstream though, it seems not universal especially if you are a linux server (-_-)
> 
> two devices are not a nice approach though it works well for a real product,
> we might still need some decent way to address this problem while the problem
> is for sure not a stopper of your patchset.

I guess that approach works for your case because A) you only have 2 sizes, and
B) your swap device is zRAM, which dynamically allocate RAM as it needs it.

The upstream small-sized THP solution can support multiple sizes, so you would
need a swap device per size (I think 13 is the limit at the moment - PMD size
for 64K base page). And if your swap device is a physical block device, you
can't dynamically parition it the way you can with zRAM. Nether of those things
scale particularly well IMHO.

> 
> [1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplus/sm8550_u_14.0.0_oneplus11/mm/memory.c#L4648
> [2] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplus/sm8550_u_14.0.0_oneplus11/mm/swapfile.c#L1129
> 
>>
>> [1] https://lore.kernel.org/linux-mm/20231010142111.3997780-1-ryan.roberts@arm.com/
>> [2] https://lore.kernel.org/linux-mm/20231017161302.2518826-1-ryan.roberts@arm.com/
>> [3] https://lore.kernel.org/linux-mm/15a52c3d-9584-449b-8228-1335e0753b04@arm.com/
>>
>>
>> Ryan Roberts (4):
>>   mm: swap: Remove CLUSTER_FLAG_HUGE from swap_cluster_info:flags
>>   mm: swap: Remove struct percpu_cluster
>>   mm: swap: Simplify ssd behavior when scanner steals entry
>>   mm: swap: Swap-out small-sized THP without splitting
>>
>>  include/linux/swap.h |  31 +++---
>>  mm/huge_memory.c     |   3 -
>>  mm/swapfile.c        | 232 ++++++++++++++++++++++++-------------------
>>  mm/vmscan.c          |  10 +-
>>  4 files changed, 149 insertions(+), 127 deletions(-)
> 
> Thanks
> Barry

