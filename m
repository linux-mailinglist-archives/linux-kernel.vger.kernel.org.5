Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9BD7CFC69
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345647AbjJSOZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjJSOZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:25:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8752B0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:25:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 659A62F4;
        Thu, 19 Oct 2023 07:26:23 -0700 (PDT)
Received: from [10.57.68.54] (unknown [10.57.68.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2F723F762;
        Thu, 19 Oct 2023 07:25:40 -0700 (PDT)
Message-ID: <4b351eaa-c2db-408b-9ce2-4b12e3d6b30a@arm.com>
Date:   Thu, 19 Oct 2023 15:25:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm: swap: Swap-out small-sized THP without
 splitting
Content-Language: en-GB
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <20231017161302.2518826-1-ryan.roberts@arm.com>
 <20231017161302.2518826-3-ryan.roberts@arm.com>
 <87r0ls773p.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <c1c5881c-f00d-4302-a305-fbd6a9998b22@arm.com>
 <87mswfuppr.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87mswfuppr.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

On 19/10/2023 06:49, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> On 18/10/2023 07:55, Huang, Ying wrote:
>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>
> 
> [snip]
> 
>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>> index a073366a227c..35cbbe6509a9 100644
>>>> --- a/include/linux/swap.h
>>>> +++ b/include/linux/swap.h
>>>> @@ -268,6 +268,12 @@ struct swap_cluster_info {
>>>>  struct percpu_cluster {
>>>>  	struct swap_cluster_info index; /* Current cluster index */
>>>>  	unsigned int next; /* Likely next allocation offset */
>>>> +	unsigned int large_next[];	/*
>>>> +					 * next free offset within current
>>>> +					 * allocation cluster for large folios,
>>>> +					 * or UINT_MAX if no current cluster.
>>>> +					 * Index is (order - 1).
>>>> +					 */
>>>>  };
>>>>
>>>>  struct swap_cluster_list {
>>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>>> index b83ad77e04c0..625964e53c22 100644
>>>> --- a/mm/swapfile.c
>>>> +++ b/mm/swapfile.c
>>>> @@ -987,35 +987,70 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>>>  	return n_ret;
>>>>  }
>>>>
>>>> -static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
>>>> +static int swap_alloc_large(struct swap_info_struct *si, swp_entry_t *slot,
>>>> +			    unsigned int nr_pages)
>>>
>>> This looks hacky.  IMO, we should put the allocation logic inside
>>> percpu_cluster framework.  If percpu_cluster framework doesn't work for
>>> you, just refactor it firstly.
>>
>> I'm not sure I really understand what you are suggesting - could you elaborate?
>> What "framework"? I only see a per-cpu data structure and
>> scan_swap_map_try_ssd_cluster(), which is very much geared towards order-0
>> allocations.
> 
> I suggest to share as much code as possible between order-0 and order >
> 0 swap entry allocation.  I think that we can make
> scan_swap_map_try_ssd_cluster() works for order > 0 swap entry allocation.
> 

[...]

>>>> +		/*
>>>> +		 * If scan_swap_map_slots() can't find a free cluster, it will
>>>> +		 * check si->swap_map directly. To make sure this standby
>>>> +		 * cluster isn't taken by scan_swap_map_slots(), mark the swap
>>>> +		 * entries bad (occupied). (same approach as discard).
>>>> +		 */
>>>> +		memset(si->swap_map + offset + nr_pages, SWAP_MAP_BAD,
>>>> +			SWAPFILE_CLUSTER - nr_pages);
>>>
>>> There's an issue with this solution.  If the free space of swap device
>>> runs low, it's possible that
>>>
>>> - some cluster are put in the percpu_cluster of some CPUs
>>>   the swap entries there are marked as used
>>>
>>> - no free swap entries elsewhere
>>>
>>> - nr_swap_pages isn't 0
>>>
>>> So, we will still scan LRU, but swap allocation fails, although there's
>>> still free swap space.

I'd like to decide how best to solve this problem before I can figure out how
much code sharing I can do for the order-0 vs order > 0 allocators.

I see a couple of potential options:

1) Manipulate nr_swap_pages to include the entries that are marked SWAP_MAP_BAD,
so when reserving a new per-order/per-cpu cluster, subtract SWAPFILE_CLUSTER,
and then add nr_pages for each allocation from that cluster.

2) Don't mark the entries in the reserved cluster as SWAP_MAP_BAD, which would
allow the scanner to steal (order-0) entries. The scanner could set a flag in
the cluster info to mark it as having been allocated from by the scanner, so the
next attempt to allocate a high order from it would cause discarding it as the
cpu's current cluster and trying to get a fresh cluster from the free list.

While option 2 is a bit more complex, I prefer it as a solution. What do you think?
