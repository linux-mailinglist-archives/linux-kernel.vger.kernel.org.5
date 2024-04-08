Return-Path: <linux-kernel+bounces-135228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A789BD66
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096451F22FFF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A845F869;
	Mon,  8 Apr 2024 10:39:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D465BAF0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572795; cv=none; b=LWhNIhkl1SLuwgrkk0UnNY148S0Gcatih2uO0LYlScP2nQBfeJT+2rLSWRvRwjKFV8aGXGCXXdp2c+Mbg9XJ12YDPYp+6tuBiY7nc4P9Kjn2+sN/0xZatuuiSOgsdIro2QY6v5dOTgyOoc6BIFqb4l5oo8LQr9ddKh31XQjULjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572795; c=relaxed/simple;
	bh=wnpjNJOqGzajWt8u60sOMKSAdNdCOnqF12paHhfdpqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqte1y45ASr+7KwqAnlUVw3rbh8P1OrbEN9RWnNa2LpSH8r4DFpFjIzeHCfw1kjR6VybaTIMpmTnRyjFQmrH+ce3/QIRiDtqX9uUBgQvOK33x7KKjObh3STKIf9VMdrDakAco1DZhbF3RQ7MQ0/g3ZAahmtOQP72Yoi7dLpU3u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2031F339;
	Mon,  8 Apr 2024 03:40:23 -0700 (PDT)
Received: from [10.57.73.169] (unknown [10.57.73.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA9FC3F766;
	Mon,  8 Apr 2024 03:39:50 -0700 (PDT)
Message-ID: <de232093-cf9b-4321-a350-e6407dd7a1da@arm.com>
Date: Mon, 8 Apr 2024 11:39:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] mm: swap: free_swap_and_cache_nr() as batched
 free_swap_and_cache()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240403114032.1162100-1-ryan.roberts@arm.com>
 <20240403114032.1162100-3-ryan.roberts@arm.com>
 <051052af-3b56-4290-98d3-fd5a1eb11ce1@redhat.com>
 <73adae65-4429-41d7-bbb6-4c58156060d3@arm.com>
 <7d3d3c58-1bb1-4d70-9ae3-fa96f6d624d8@redhat.com>
 <e8dfe18d-d3fe-47a8-88b6-d0145895d7af@arm.com>
 <79c5513b-b3f2-4fbb-a3c7-a09894d54d22@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <79c5513b-b3f2-4fbb-a3c7-a09894d54d22@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2024 11:24, David Hildenbrand wrote:
> On 08.04.24 12:07, Ryan Roberts wrote:
>> On 08/04/2024 10:43, David Hildenbrand wrote:
>>>
>>>>>> +
>>>>>> +/**
>>>>>> + * swap_pte_batch - detect a PTE batch for a set of contiguous swap entries
>>>>>> + * @start_ptep: Page table pointer for the first entry.
>>>>>> + * @max_nr: The maximum number of table entries to consider.
>>>>>> + * @entry: Swap entry recovered from the first table entry.
>>>>>> + *
>>>>>> + * Detect a batch of contiguous swap entries: consecutive (non-present) PTEs
>>>>>> + * containing swap entries all with consecutive offsets and targeting the
>>>>>> same
>>>>>> + * swap type.
>>>>>> + *
>>>>>
>>>>> Likely you should document that any swp pte bits are ignored? ()
>>>>
>>>> Sorry I don't understand this comment. I thought any non-none, non-present PTE
>>>> was always considered to contain only a "swap entry" and a swap entry consists
>>>> of a "type" and an "offset" only. (and its a special "non-swap" swap entry if
>>>> type > SOME_CONSTANT) Are you saying there are additional fields in the PTE
>>>> that
>>>> are not part of the swap entry?
>>>
>>>
>>> pte_swp_soft_dirty()
>>> pte_swp_clear_exclusive()
>>> pte_swp_uffd_wp()
>>>
>>> Are PTE bits used for swp PTE.
>>
>> Ahh wow. mind blown. Looks like a massive hack... why not store them in the
>> arch-independent swap entry, rather than have them squat independently in the
>> PTE?
> 
> I think that was discussed at some point, but it not only requires quite some
> churn to change it (all that swp entry code is a mess), these bits are
> conceptually really per PTE and not something you would want to pass into actual
> swap handling code that couldn't care less about all of these.
> 
> I looked at this when I added SWP exclusive, but accidentally losing the SWP
> exclusive marker when converting back and forth made me go the PTE route instead.
> 
> Then, the available PTE bits are a bit scattered on some architectures, and
> converting entry<->PTE gets even uglier if we don't want to "lose" available bits.
> 
> Probably the whole "unsigned long swp_entry" stuff should be replaced by a
> proper struct where we could more easily add flags and have the arch code handle
> the conversion to the PTE just once. The arch-specific swp_entry stuff is
> another nasty thing IMHO.

Yep understood. I'll file this under "there be dragons". Thanks for the explanation.

> 
>>
>> OK, my implementation is buggy. I'll re-spin to fix this.
>>
>>
>>>
>>> There is also dirty/young for migration entries, but that's not of a concern
>>> here, because we stop for non_swap_entry().
>>
>> Looks like these are part of the offset field in the arch-independent swap entry
>> - much cleaner ;-).
> 
> Note that it only applies to migration entries, and only when we have some spare
> bits due to PFN < offset.

Yep got it. Thanks!


