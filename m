Return-Path: <linux-kernel+bounces-91968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC2487192D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0591C213A6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC6F5026E;
	Tue,  5 Mar 2024 09:11:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031924DA1F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629876; cv=none; b=sdY0l84D9667+2vvQTcpRnjXlMmEMz2zM8Z4/P/Dvd+eryl8T4n8wJt8xUUmJFx57+X1dAbczrt3oC9HdxpbrR9VA4nXSTA4pfqNefxk4vThZ5ydxTDPKzfy4dL3IzA9CSTDTlIkDBmVJggbtK63pwRduA3OuFnzpn3Xs2RrPBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629876; c=relaxed/simple;
	bh=LWb4xFlvZM/PMrK9B+lfdajQrEyZarnZ/3xa3Zq4WPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtwNXUMhoyV1avLXJ6cfU0GrtY4LaSFkVskCTsfOnmONoH3H+gJBPqHuk4/uT+nXHmI97zuBQD8uVUhSfRzRxKT6ILtDBBPxsCfj6uBTbXUtoifvq7O715BjEAsutMQnX5twmwpNgdbUOaAPvvVMKd8Eoc3EcLs6HyXG1WkV1pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D70E51FB;
	Tue,  5 Mar 2024 01:11:50 -0800 (PST)
Received: from [10.57.68.162] (unknown [10.57.68.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E45F63F762;
	Tue,  5 Mar 2024 01:11:11 -0800 (PST)
Message-ID: <0a644230-f7a8-4091-9d00-ded6c8c3fc19@arm.com>
Date: Tue, 5 Mar 2024 09:11:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a
 large folio
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@redhat.com,
 chrisl@kernel.org, yuzhao@google.com, hanchuanhua@oppo.com,
 linux-kernel@vger.kernel.org, willy@infradead.org, ying.huang@intel.com,
 xiang@kernel.org, mhocko@suse.com, shy828301@gmail.com,
 wangkefeng.wang@huawei.com, Barry Song <v-songbaohua@oppo.com>,
 Hugh Dickins <hughd@google.com>
References: <20240304103757.235352-1-21cnbao@gmail.com>
 <706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
 <CAGsJ_4wx7oSzt4vn6B+LRoZetMhH-fDXRFrCFRyoqVOakLidjg@mail.gmail.com>
 <e5e14ef9-1bd2-45a8-818d-e92910e97f8f@arm.com>
 <CAGsJ_4xtVhka9J3c6zDySBEJ34+mn9OLiuP0JJ+Ag+p9n9K5EA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4xtVhka9J3c6zDySBEJ34+mn9OLiuP0JJ+Ag+p9n9K5EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/03/2024 09:08, Barry Song wrote:
> On Tue, Mar 5, 2024 at 9:54 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 04/03/2024 21:57, Barry Song wrote:
>>> On Tue, Mar 5, 2024 at 1:21 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> Hi Barry,
>>>>
>>>> On 04/03/2024 10:37, Barry Song wrote:
>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>
>>>>> page_vma_mapped_walk() within try_to_unmap_one() races with other
>>>>> PTEs modification such as break-before-make, while iterating PTEs
>>>>> of a large folio, it will only begin to acquire PTL after it gets
>>>>> a valid(present) PTE. break-before-make intermediately sets PTEs
>>>>> to pte_none. Thus, a large folio's PTEs might be partially skipped
>>>>> in try_to_unmap_one().
>>>>
>>>> I just want to check my understanding here - I think the problem occurs for
>>>> PTE-mapped, PMD-sized folios as well as smaller-than-PMD-size large folios? Now
>>>> that I've had a look at the code and have a better understanding, I think that
>>>> must be the case? And therefore this problem exists independently of my work to
>>>> support swap-out of mTHP? (From your previous report I was under the impression
>>>> that it only affected mTHP).
>>>
>>> I think this affects all large folios with PTEs entries more than 1. but hugeTLB
>>> is handled as a whole in try_to_unmap_one and its rmap is removed all
>>> together, i feel hugeTLB doesn't have this problem.
>>>
>>>>
>>>> Its just that the problem is becoming more pronounced because with mTHP,
>>>> PTE-mapped large folios are much more common?
>>>
>>> right. as now large folios become a more common case, and it is my case
>>> running in millions of phones.
>>>
>>> BTW, I feel we can somehow learn from hugeTLB, for example, we can reclaim
>>> all PTEs all together rather than iterating PTEs one by one. This will improve
>>> performance. for example, a batched
>>> set_ptes_to_swap_entries()
>>> {
>>> }
>>> then we only need to loop once for a large folio, right now we are looping
>>> nr_pages times.
>>
>> You still need a pte-pte loop somewhere. In hugetlb's case it's in the arch
>> implementation. HugeTLB ptes are all a fixed size for a given VMA, which makes
>> things a bit easier too, whereas in the regular mm, they are now a variable size.
>>
>> David and I introduced folio_pte_batch() to help gather batches of ptes, and it
>> uses the contpte bit to avoid iterating over intermediate ptes. And I'm adding
>> swap_pte_batch() which does a similar thing for swap entry batching in v4 of my
>> swap-out series.
>>
>> For your set_ptes_to_swap_entries() example, I'm not sure what it would do other
>> than loop over the PTEs setting an incremented swap entry to each one? How is
>> that more performant?
> 
> right now, while (page_vma_mapped_walk(&pvmw)) will loop nr_pages for each
> PTE, if each PTE, we do lots of checks within the loop.
> 
> by implementing set_ptes_to_swap_entries(), we can iterate once for
> page_vma_mapped_walk(), after folio_pte_batch() has confirmed
> the large folio is completely mapped, we set nr_pages swap entries
> all together.
> 
> we are replacing
> 
> for(i=0;i<nr_pages;i++)     /* page_vma_mapped_walk */
> {
>         lots of checks;
>         clear PTEn
>         set PTEn to swap
> }

OK so you are effectively hoisting "lots of checks" out of the loop?

> 
> by
> 
> if (large folio && folio_pte_batch() == nr_pages)
>     set_ptes_to_swap_entries().
> 
>>
> 
> Thanks,
> Ryan


