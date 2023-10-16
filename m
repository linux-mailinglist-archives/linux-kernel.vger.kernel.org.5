Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6466C7CA7C4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjJPMK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJPMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:10:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 220C1E1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:10:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 661C81FB;
        Mon, 16 Oct 2023 05:11:04 -0700 (PDT)
Received: from [10.57.66.151] (unknown [10.57.66.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 813763F5A1;
        Mon, 16 Oct 2023 05:10:22 -0700 (PDT)
Message-ID: <f9265349-3199-44b7-81b1-802c50e95713@arm.com>
Date:   Mon, 16 Oct 2023 13:10:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/2] mm: swap: Swap-out small-sized THP without
 splitting
Content-Language: en-GB
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231010142111.3997780-1-ryan.roberts@arm.com>
 <20231010142111.3997780-3-ryan.roberts@arm.com>
 <87r0m1ftvu.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <f1446ef6-3e29-4ce0-866e-c522931ae364@arm.com>
 <1ccde143-18a7-483b-a9a4-fff07b0edc72@arm.com>
 <87ttqrm6pk.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87ttqrm6pk.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2023 07:17, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> On 11/10/2023 11:36, Ryan Roberts wrote:
>>> On 11/10/2023 09:25, Huang, Ying wrote:
>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>
>>>>> The upcoming anonymous small-sized THP feature enables performance
>>>>> improvements by allocating large folios for anonymous memory. However
>>>>> I've observed that on an arm64 system running a parallel workload (e.g.
>>>>> kernel compilation) across many cores, under high memory pressure, the
>>>>> speed regresses. This is due to bottlenecking on the increased number of
>>>>> TLBIs added due to all the extra folio splitting.
>>>>>
>>>>> Therefore, solve this regression by adding support for swapping out
>>>>> small-sized THP without needing to split the folio, just like is already
>>>>> done for PMD-sized THP. This change only applies when CONFIG_THP_SWAP is
>>>>> enabled, and when the swap backing store is a non-rotating block device
>>>>> - these are the same constraints as for the existing PMD-sized THP
>>>>> swap-out support.
>>>>>
>>>>> Note that no attempt is made to swap-in THP here - this is still done
>>>>> page-by-page, like for PMD-sized THP.
>>>>>
>>>>> The main change here is to improve the swap entry allocator so that it
>>>>> can allocate any power-of-2 number of contiguous entries between [4, (1
>>>>> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
>>>>> order and allocating sequentially from it until the cluster is full.
>>>>> This ensures that we don't need to search the map and we get no
>>>>> fragmentation due to alignment padding for different orders in the
>>>>> cluster. If there is no current cluster for a given order, we attempt to
>>>>> allocate a free cluster from the list. If there are no free clusters, we
>>>>> fail the allocation and the caller falls back to splitting the folio and
>>>>> allocates individual entries (as per existing PMD-sized THP fallback).
>>>>>
>>>>> As far as I can tell, this should not cause any extra fragmentation
>>>>> concerns, given how similar it is to the existing PMD-sized THP
>>>>> allocation mechanism. There will be up to (PMD_ORDER-1) clusters in
>>>>> concurrent use though. In practice, the number of orders in use will be
>>>>> small though.
>>>>>
>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>> ---
>>>>>  include/linux/swap.h |  7 ++++++
>>>>>  mm/swapfile.c        | 60 +++++++++++++++++++++++++++++++++-----------
>>>>>  mm/vmscan.c          | 10 +++++---
>>>>>  3 files changed, 59 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>>> index a073366a227c..fc55b760aeff 100644
>>>>> --- a/include/linux/swap.h
>>>>> +++ b/include/linux/swap.h
>>>>> @@ -320,6 +320,13 @@ struct swap_info_struct {
>>>>>  					 */
>>>>>  	struct work_struct discard_work; /* discard worker */
>>>>>  	struct swap_cluster_list discard_clusters; /* discard clusters list */
>>>>> +	unsigned int large_next[PMD_ORDER]; /*
>>>>> +					     * next free offset within current
>>>>> +					     * allocation cluster for large
>>>>> +					     * folios, or UINT_MAX if no current
>>>>> +					     * cluster. Index is (order - 1).
>>>>> +					     * Only when cluster_info is used.
>>>>> +					     */
>>>>
>>>> I think that it is better to make this per-CPU.  That is, extend the
>>>> percpu_cluster mechanism.  Otherwise, we may have scalability issue.
>>>
>>> Is your concern that the swap_info spinlock will get too contended as its
>>> currently written? From briefly looking at percpu_cluster, it looks like that
>>> spinlock is always held when accessing the per-cpu structures - presumably
>>> that's what's disabling preemption and making sure the thread is not migrated?
>>> So I'm not sure what the benefit is currently? Surely you want to just disable
>>> preemption but not hold the lock? I'm sure I've missed something crucial...
>>
>> I looked a bit further at how to implement what you are suggesting.
>> get_swap_pages() is currently taking the swap_info lock which it needs to check
>> and update some other parts of the swap_info - I'm not sure that part can be
>> removed. swap_alloc_large() (my new function) is not doing an awful lot of work,
>> so I'm not convinced that you would save too much by releasing the lock for that
>> part. In contrast there is a lot more going on in scan_swap_map_slots() so there
>> is more benefit to releasing the lock and using the percpu stuff - correct me if
>> I've missunderstood.
>>
>> As an alternative approach, perhaps it makes more sense to beef up the caching
>> layer in swap_slots.c to handle large folios too? Then you avoid taking the
>> swap_info lock at all most of the time, like you currently do for single entry
>> allocations.
>>
>> What do you think?
> 
> Sorry for late reply.
> 
> percpu_cluster is introduced in commit ebc2a1a69111 ("swap: make cluster
> allocation per-cpu").  Please check the changelog for why it's
> introduced.  Sorry about my incorrect memory about scalability.
> percpu_cluster is introduced for disk performance mainly instead of
> scalability.

Thanks for the pointer. I'm not sure if you are still suggesting that I make my
small-sized THP allocation mechanism per-cpu though?

I anticipate that by virtue of allocating multiple contiguous swap entries for a
small-sized THP we already get a lot of the benefits that percpu_cluster gives
order-0 allocations. (Although obviously it will only give contiguity matching
the size of the THP rather than a full cluster). The downside of making this
percpu would be keeping more free clusters tied up in the percpu caches,
potentially causing a need to scan for free entries more often.

What's your view?

Thanks,
Ryan



> 
> --
> Best Regards,
> Huang, Ying
> 
>>>
>>>>
>>>> And this should be enclosed in CONFIG_THP_SWAP.
>>>
>>> Yes, I'll fix this in the next version.
>>>
>>> Thanks for the review!
>>>
>>>>
>>>>>  	struct plist_node avail_lists[]; /*
>>>>>  					   * entries in swap_avail_heads, one
>>>>>  					   * entry per node.

