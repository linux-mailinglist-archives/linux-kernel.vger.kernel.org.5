Return-Path: <linux-kernel+bounces-110023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F404A885901
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7759281709
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F71762D6;
	Thu, 21 Mar 2024 12:21:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6069A75802
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023713; cv=none; b=mpgtDgvpQpfaYsbR6UIDBvZH6DwouGL0LAtl4x0CE91Zf+FWbvtfEbWGEKNWunOSBnXdvd7iyccHFKDEJZoaeRL5GQtvMDyLe9AQMS3ZgR4Z9oHyaa5rZZmHkosxRxKtN9V9/5cL5aKAEGPZN1HwYk/1PTI3R/p3O+FPYC7OtPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023713; c=relaxed/simple;
	bh=mV4Xl2jjTaaJlI5+F4YYCSAISA4g4bwCAklA1AlaAMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYYPbI/m+f64ah1HMnwV34fvkSOv3hbTKcHkbdQ5usuWCAGsQt7dM0S4keHtHtPPXUHmWTfzvqevaRJScwChN1ZNok4HDPtI4OGvacdHKtAHe6M/Z0wOOgE1ehq731b2xMKTSmgBVSPaufoAe0J7oXeN6H5vx7sPXfbd/qw89zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBC721007;
	Thu, 21 Mar 2024 05:22:23 -0700 (PDT)
Received: from [10.1.33.177] (XHFQ2J9959.cambridge.arm.com [10.1.33.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB6E83F762;
	Thu, 21 Mar 2024 05:21:47 -0700 (PDT)
Message-ID: <b22a222b-7fd8-4648-84a7-21d35f529f27@arm.com>
Date: Thu, 21 Mar 2024 12:21:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] mm: swap: Allow storage of all mTHP orders
Content-Language: en-GB
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-5-ryan.roberts@arm.com>
 <87jzm751n3.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <d6ac1097-2ca3-4e6d-902d-1b942cacf0fb@arm.com>
 <8734skryev.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <8734skryev.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 04:39, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> Hi Huang, Ying,
>>
>>
>> On 12/03/2024 07:51, Huang, Ying wrote:
>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>
>>>> Multi-size THP enables performance improvements by allocating large,
>>>> pte-mapped folios for anonymous memory. However I've observed that on an
>>>> arm64 system running a parallel workload (e.g. kernel compilation)
>>>> across many cores, under high memory pressure, the speed regresses. This
>>>> is due to bottlenecking on the increased number of TLBIs added due to
>>>> all the extra folio splitting when the large folios are swapped out.
>>>>
>>>> Therefore, solve this regression by adding support for swapping out mTHP
>>>> without needing to split the folio, just like is already done for
>>>> PMD-sized THP. This change only applies when CONFIG_THP_SWAP is enabled,
>>>> and when the swap backing store is a non-rotating block device. These
>>>> are the same constraints as for the existing PMD-sized THP swap-out
>>>> support.
>>>>
>>>> Note that no attempt is made to swap-in (m)THP here - this is still done
>>>> page-by-page, like for PMD-sized THP. But swapping-out mTHP is a
>>>> prerequisite for swapping-in mTHP.
>>>>
>>>> The main change here is to improve the swap entry allocator so that it
>>>> can allocate any power-of-2 number of contiguous entries between [1, (1
>>>> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
>>>> order and allocating sequentially from it until the cluster is full.
>>>> This ensures that we don't need to search the map and we get no
>>>> fragmentation due to alignment padding for different orders in the
>>>> cluster. If there is no current cluster for a given order, we attempt to
>>>> allocate a free cluster from the list. If there are no free clusters, we
>>>> fail the allocation and the caller can fall back to splitting the folio
>>>> and allocates individual entries (as per existing PMD-sized THP
>>>> fallback).
>>>>
>>>> The per-order current clusters are maintained per-cpu using the existing
>>>> infrastructure. This is done to avoid interleving pages from different
>>>> tasks, which would prevent IO being batched. This is already done for
>>>> the order-0 allocations so we follow the same pattern.
>>>>
>>>> As is done for order-0 per-cpu clusters, the scanner now can steal
>>>> order-0 entries from any per-cpu-per-order reserved cluster. This
>>>> ensures that when the swap file is getting full, space doesn't get tied
>>>> up in the per-cpu reserves.
>>>>
>>>> This change only modifies swap to be able to accept any order mTHP. It
>>>> doesn't change the callers to elide doing the actual split. That will be
>>>> done in separate changes.
>>
>> [...]
>>
>>>> @@ -905,17 +961,18 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>>>  	}
>>>>  
>>>>  	if (si->swap_map[offset]) {
>>>> +		VM_WARN_ON(order > 0);
>>>>  		unlock_cluster(ci);
>>>>  		if (!n_ret)
>>>>  			goto scan;
>>>>  		else
>>>>  			goto done;
>>>>  	}
>>>> -	WRITE_ONCE(si->swap_map[offset], usage);
>>>> -	inc_cluster_info_page(si, si->cluster_info, offset);
>>>> +	memset(si->swap_map + offset, usage, nr_pages);
>>>
>>> Add barrier() here corresponds to original WRITE_ONCE()?
>>> unlock_cluster(ci) may be NOP for some swap devices.
>>
>> Looking at this a bit more closely, I'm not sure this is needed. Even if there
>> is no cluster, the swap_info is still locked, so unlocking that will act as a
>> barrier. There are a number of other callsites that memset(si->swap_map) without
>> an explicit barrier and with the swap_info locked.
>>
>> Looking at the original commit that added the WRITE_ONCE() it was worried about
>> a race with reading swap_map in _swap_info_get(). But that site is now annotated
>> with a data_race(), which will suppress the warning. And I don't believe there
>> are any places that read swap_map locklessly and depend upon observing ordering
>> between it and other state? So I think the si unlock is sufficient?
>>
>> I'm not planning to add barrier() here. Let me know if you disagree.
> 
> swap_map[] may be read locklessly in swap_offset_available_and_locked()
> in parallel.  IIUC, WRITE_ONCE() here is to make the writing take effect
> as early as possible there.

Afraid I'm not convinced by that argument; if it's racing, it's racing - the
lockless side needs to be robust (it is). Adding the compiler barrier limits the
compiler's options which could lead to slower code in this path. If your
argument is that you want to reduce the window where
swap_offset_available_and_locked() could observe a free swap slot but then see
that its taken after it gets the si lock, that seems like a micro-optimization
to me, which we should avoid if we can.

By remnoving the WRITE_ONCE() and using memset, the lockless reader could
observe tearing though. I don't think that should cause a problem (because
everything is rechecked with under the lock), but if we want to avoid it, then
perhaps we just need to loop over WRITE_ONCE() here instead of using memset?


> 
>>
>>>
>>>> +	add_cluster_info_page(si, si->cluster_info, offset, nr_pages);
>>>>  	unlock_cluster(ci);
> 
> --
> Best Regards,
> Huang, Ying


