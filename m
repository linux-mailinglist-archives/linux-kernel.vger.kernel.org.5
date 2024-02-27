Return-Path: <linux-kernel+bounces-83684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A8A869D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A7C2906FC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB264E1CB;
	Tue, 27 Feb 2024 17:10:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB1D3D541
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053819; cv=none; b=El4x15H0kCCQnualIzektRJUJoIr0MeVZ1v+5K76UspGbLzuwqnTa+lKpnnWAFHR87IMN0fMkYfgtoxkk6DniwL9hiFO/d0i7MGtx4XVUT79EX5DH7kJ6kE4jC587HwXw9SKcR0HmdfsETB+6qSJ/2gsAHI/HVCToUmOBeFTLhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053819; c=relaxed/simple;
	bh=UwCsJIOu2M88+tQt4C/s+QljzIQ4grBXWdEF0+KLMh4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GlwHA13PjsewwlJ1CNI1+yLLgvAX9AJoj0GfyBg8/FRtoaNJpWq5nZPkK3TAb0qOfSWUiA9dYTmYLWT2KxY2fscDWg797xPvQyglFTUE2BEzv/TTAWvzwTN7LTKoX2kyh2V2egwcpwGIwUphWGFQ7GuNTmy0cHNoXksh6I/OU90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF400DA7;
	Tue, 27 Feb 2024 09:10:47 -0800 (PST)
Received: from [10.1.30.188] (XHFQ2J9959.cambridge.arm.com [10.1.30.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB6C93F73F;
	Tue, 27 Feb 2024 09:10:07 -0800 (PST)
Message-ID: <ba9101ae-a618-4afc-9515-a61f25376390@arm.com>
Date: Tue, 27 Feb 2024 17:10:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20231025144546.577640-2-ryan.roberts@arm.com>
 <d108bd79-086b-4564-838b-d41afa055137@redhat.com>
 <6541e29b-f25a-48b8-a553-fd8febe85e5a@redhat.com>
 <ee760679-7e3c-4a35-ad53-ca98b598ead5@arm.com>
In-Reply-To: <ee760679-7e3c-4a35-ad53-ca98b598ead5@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi David,

On 26/02/2024 17:41, Ryan Roberts wrote:
> On 22/02/2024 10:20, David Hildenbrand wrote:
>> On 22.02.24 11:19, David Hildenbrand wrote:
>>> On 25.10.23 16:45, Ryan Roberts wrote:
>>>> As preparation for supporting small-sized THP in the swap-out path,
>>>> without first needing to split to order-0, Remove the CLUSTER_FLAG_HUGE,
>>>> which, when present, always implies PMD-sized THP, which is the same as
>>>> the cluster size.
>>>>
>>>> The only use of the flag was to determine whether a swap entry refers to
>>>> a single page or a PMD-sized THP in swap_page_trans_huge_swapped().
>>>> Instead of relying on the flag, we now pass in nr_pages, which
>>>> originates from the folio's number of pages. This allows the logic to
>>>> work for folios of any order.
>>>>
>>>> The one snag is that one of the swap_page_trans_huge_swapped() call
>>>> sites does not have the folio. But it was only being called there to
>>>> avoid bothering to call __try_to_reclaim_swap() in some cases.
>>>> __try_to_reclaim_swap() gets the folio and (via some other functions)
>>>> calls swap_page_trans_huge_swapped(). So I've removed the problematic
>>>> call site and believe the new logic should be equivalent.
>>>
>>> That is the  __try_to_reclaim_swap() -> folio_free_swap() ->
>>> folio_swapped() -> swap_page_trans_huge_swapped() call chain I assume.
>>>
>>> The "difference" is that you will now (1) get another temporary
>>> reference on the folio and (2) (try)lock the folio every time you
>>> discard a single PTE of a (possibly) large THP.
>>>
>>
>> Thinking about it, your change will not only affect THP, but any call to
>> free_swap_and_cache().
>>
>> Likely that's not what we want. :/
>>
> 
> Is folio_trylock() really that expensive given the code path is already locking
> multiple spinlocks, and I don't think we would expect the folio lock to be very
> contended?
> 
> I guess filemap_get_folio() could be a bit more expensive, but again, is this
> really a deal-breaker?
> 
> 
> I'm just trying to refamiliarize myself with this series, but I think I ended up
> allocating a cluster per cpu per order. So one potential solution would be to
> turn the flag into a size and store it in the cluster info. (In fact I think I
> was doing that in an early version of this series - will have to look at why I
> got rid of that). Then we could avoid needing to figure out nr_pages from the folio.

I ran some microbenchmarks to see if these extra operations cause a performance
issue - it all looks OK to me.

I modified your "pte-mapped-folio-benchmarks" to add a "munmap-swapped-forked"
mode, which prepares the 1G memory mapping by first paging it out with
MADV_PAGEOUT, then it forks a child (and keeps that child alive) so that the
swap slots have 2 references, then it measures the duration of munmap() in the
parent on the entire range. The idea is that free_swap_and_cache() is called for
each PTE during munmap(). Prior to my change, swap_page_trans_huge_swapped()
will return true, due to the child's references, and __try_to_reclaim_swap() is
not called. After my change, we no longer have this short cut.

In both cases the results are within 1% (confirmed across multiple runs of 20
seconds each):

mm-stable: Average: 0.004997
 + change: Average: 0.005037

(these numbers are for Ampere Altra. I also tested on M2 VM - no regression
their either).

Do you still have a concern about this change?

An alternative is to store the folio size in the cluster, but that won't be
accurate if the folio is later split or if an entry within the cluster is later
stolen for an order-0 entry. I think it would still work though; it just means
that you might get a false positive in those circumstances, which means taking
the "slow" path. But this is a rare event.

Regardless, I prefer not to do this, since it adds complexity and doesn't
benefit performance.

Thanks,
Ryan


