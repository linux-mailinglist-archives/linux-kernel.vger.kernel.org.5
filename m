Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2557CBA51
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjJQFq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbjJQFqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:46:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932B7E6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 22:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697521582; x=1729057582;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Skzu2i18rf7U9pK7ZpFgTgdCvKn/xYSqDDxJzL2toyE=;
  b=YTnLIZiSlUnicCZ8Q2ENSXDAPUitBoU9lPikWLcBmEWFBaebk7fS2wO0
   IRLxiLBSOywwowuH+6CL6fkoiukaazlAU6Gy+0htyj5tdvKwoYQa3D9+L
   5ck60ZF6LdaNtQrXzY3RmpJXxMq3ux/9Tvf9awoxyNDD9cbh1FV+woW5d
   MfnCEXisoQ0DPZizNqeO6ZztCNjvHS20Hz4s+UY326iIwU5PN0nlmVq0E
   aDw4GOQiYQTKWcZj58PK3OTjv4+7g1MBDOAfehiUMBC9QHcffEapHY7wV
   BXzh0yWjTS4ssR3zy0zmTDehJzUDJdIufn8SCHI/QptQBufe3WTFrasym
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365056679"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="365056679"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 22:46:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1087364829"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="1087364829"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 22:46:19 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v1 2/2] mm: swap: Swap-out small-sized THP without
 splitting
In-Reply-To: <f9265349-3199-44b7-81b1-802c50e95713@arm.com> (Ryan Roberts's
        message of "Mon, 16 Oct 2023 13:10:21 +0100")
References: <20231010142111.3997780-1-ryan.roberts@arm.com>
        <20231010142111.3997780-3-ryan.roberts@arm.com>
        <87r0m1ftvu.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <f1446ef6-3e29-4ce0-866e-c522931ae364@arm.com>
        <1ccde143-18a7-483b-a9a4-fff07b0edc72@arm.com>
        <87ttqrm6pk.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <f9265349-3199-44b7-81b1-802c50e95713@arm.com>
Date:   Tue, 17 Oct 2023 13:44:18 +0800
Message-ID: <87a5shajm5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 16/10/2023 07:17, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> 
>>> On 11/10/2023 11:36, Ryan Roberts wrote:
>>>> On 11/10/2023 09:25, Huang, Ying wrote:
>>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>>
>>>>>> The upcoming anonymous small-sized THP feature enables performance
>>>>>> improvements by allocating large folios for anonymous memory. However
>>>>>> I've observed that on an arm64 system running a parallel workload (e.g.
>>>>>> kernel compilation) across many cores, under high memory pressure, the
>>>>>> speed regresses. This is due to bottlenecking on the increased number of
>>>>>> TLBIs added due to all the extra folio splitting.
>>>>>>
>>>>>> Therefore, solve this regression by adding support for swapping out
>>>>>> small-sized THP without needing to split the folio, just like is already
>>>>>> done for PMD-sized THP. This change only applies when CONFIG_THP_SWAP is
>>>>>> enabled, and when the swap backing store is a non-rotating block device
>>>>>> - these are the same constraints as for the existing PMD-sized THP
>>>>>> swap-out support.
>>>>>>
>>>>>> Note that no attempt is made to swap-in THP here - this is still done
>>>>>> page-by-page, like for PMD-sized THP.
>>>>>>
>>>>>> The main change here is to improve the swap entry allocator so that it
>>>>>> can allocate any power-of-2 number of contiguous entries between [4, (1
>>>>>> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
>>>>>> order and allocating sequentially from it until the cluster is full.
>>>>>> This ensures that we don't need to search the map and we get no
>>>>>> fragmentation due to alignment padding for different orders in the
>>>>>> cluster. If there is no current cluster for a given order, we attempt to
>>>>>> allocate a free cluster from the list. If there are no free clusters, we
>>>>>> fail the allocation and the caller falls back to splitting the folio and
>>>>>> allocates individual entries (as per existing PMD-sized THP fallback).
>>>>>>
>>>>>> As far as I can tell, this should not cause any extra fragmentation
>>>>>> concerns, given how similar it is to the existing PMD-sized THP
>>>>>> allocation mechanism. There will be up to (PMD_ORDER-1) clusters in
>>>>>> concurrent use though. In practice, the number of orders in use will be
>>>>>> small though.
>>>>>>
>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>> ---
>>>>>>  include/linux/swap.h |  7 ++++++
>>>>>>  mm/swapfile.c        | 60 +++++++++++++++++++++++++++++++++-----------
>>>>>>  mm/vmscan.c          | 10 +++++---
>>>>>>  3 files changed, 59 insertions(+), 18 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>>>> index a073366a227c..fc55b760aeff 100644
>>>>>> --- a/include/linux/swap.h
>>>>>> +++ b/include/linux/swap.h
>>>>>> @@ -320,6 +320,13 @@ struct swap_info_struct {
>>>>>>  					 */
>>>>>>  	struct work_struct discard_work; /* discard worker */
>>>>>>  	struct swap_cluster_list discard_clusters; /* discard clusters list */
>>>>>> +	unsigned int large_next[PMD_ORDER]; /*
>>>>>> +					     * next free offset within current
>>>>>> +					     * allocation cluster for large
>>>>>> +					     * folios, or UINT_MAX if no current
>>>>>> +					     * cluster. Index is (order - 1).
>>>>>> +					     * Only when cluster_info is used.
>>>>>> +					     */
>>>>>
>>>>> I think that it is better to make this per-CPU.  That is, extend the
>>>>> percpu_cluster mechanism.  Otherwise, we may have scalability issue.
>>>>
>>>> Is your concern that the swap_info spinlock will get too contended as its
>>>> currently written? From briefly looking at percpu_cluster, it looks like that
>>>> spinlock is always held when accessing the per-cpu structures - presumably
>>>> that's what's disabling preemption and making sure the thread is not migrated?
>>>> So I'm not sure what the benefit is currently? Surely you want to just disable
>>>> preemption but not hold the lock? I'm sure I've missed something crucial...
>>>
>>> I looked a bit further at how to implement what you are suggesting.
>>> get_swap_pages() is currently taking the swap_info lock which it needs to check
>>> and update some other parts of the swap_info - I'm not sure that part can be
>>> removed. swap_alloc_large() (my new function) is not doing an awful lot of work,
>>> so I'm not convinced that you would save too much by releasing the lock for that
>>> part. In contrast there is a lot more going on in scan_swap_map_slots() so there
>>> is more benefit to releasing the lock and using the percpu stuff - correct me if
>>> I've missunderstood.
>>>
>>> As an alternative approach, perhaps it makes more sense to beef up the caching
>>> layer in swap_slots.c to handle large folios too? Then you avoid taking the
>>> swap_info lock at all most of the time, like you currently do for single entry
>>> allocations.
>>>
>>> What do you think?
>> 
>> Sorry for late reply.
>> 
>> percpu_cluster is introduced in commit ebc2a1a69111 ("swap: make cluster
>> allocation per-cpu").  Please check the changelog for why it's
>> introduced.  Sorry about my incorrect memory about scalability.
>> percpu_cluster is introduced for disk performance mainly instead of
>> scalability.
>
> Thanks for the pointer. I'm not sure if you are still suggesting that I make my
> small-sized THP allocation mechanism per-cpu though?

Yes.  I think that the reason for that we introduced percpu_cluster
still applies now.

> I anticipate that by virtue of allocating multiple contiguous swap entries for a
> small-sized THP we already get a lot of the benefits that percpu_cluster gives
> order-0 allocations. (Although obviously it will only give contiguity matching
> the size of the THP rather than a full cluster).

I think that you will still introduce "interleave disk access" when
multiple CPU allocate from and write to swap device simultaneously.
Right?  Yes, 16KB block is better than 4KB block, but I don't think it
solves the problem.

> The downside of making this percpu would be keeping more free clusters
> tied up in the percpu caches, potentially causing a need to scan for
> free entries more often.

Yes.  We may waste several MB swap space per-CPU.  Is this a practical
issue given the swap device capacity becomes larger and larger?

--
Best Regards,
Huang, Ying
