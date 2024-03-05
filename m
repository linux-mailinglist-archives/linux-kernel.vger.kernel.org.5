Return-Path: <linux-kernel+bounces-91929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF828718B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E411F22F4A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EAD4F207;
	Tue,  5 Mar 2024 08:54:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22164EB2E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628888; cv=none; b=ZUBANOSAZ3kaLwkP9IlEDr5N1dy5xemdOXvP6roZ5+8lrJ80ynN/IQUliUYmSau0rv57n/Aty+Nb7uN7fPh1B9PsLBxX/ri9nd1L8+BaYftaRCixqJ38LPnob90l0MUW3YPKiGmt1D9R5ieMM1rqebQZ5WCAobEisQf43AbrtWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628888; c=relaxed/simple;
	bh=tnNibRNRdjaA8Xi/uPjpYadktxh5V7TKOXOENJEfRQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHCVTsf6P3Sxmw7R3U87FOnlP3j4uhPEIZ/1Bkkecip1KWWesZopEHcxhlfUUuvxtikt27wkrcZ87ORNmvYvjJQx0Yra0F4r93SJJEDlPVVAZw+CA2wCjlZ+55HPO2TL9w2Lp9vZemsxLTDDO0MQFfLkdXcX1z2xeUKBFZEqqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 495B41FB;
	Tue,  5 Mar 2024 00:55:22 -0800 (PST)
Received: from [10.57.68.162] (unknown [10.57.68.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CF103F762;
	Tue,  5 Mar 2024 00:54:43 -0800 (PST)
Message-ID: <e5e14ef9-1bd2-45a8-818d-e92910e97f8f@arm.com>
Date: Tue, 5 Mar 2024 08:54:41 +0000
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4wx7oSzt4vn6B+LRoZetMhH-fDXRFrCFRyoqVOakLidjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/03/2024 21:57, Barry Song wrote:
> On Tue, Mar 5, 2024 at 1:21 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Hi Barry,
>>
>> On 04/03/2024 10:37, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> page_vma_mapped_walk() within try_to_unmap_one() races with other
>>> PTEs modification such as break-before-make, while iterating PTEs
>>> of a large folio, it will only begin to acquire PTL after it gets
>>> a valid(present) PTE. break-before-make intermediately sets PTEs
>>> to pte_none. Thus, a large folio's PTEs might be partially skipped
>>> in try_to_unmap_one().
>>
>> I just want to check my understanding here - I think the problem occurs for
>> PTE-mapped, PMD-sized folios as well as smaller-than-PMD-size large folios? Now
>> that I've had a look at the code and have a better understanding, I think that
>> must be the case? And therefore this problem exists independently of my work to
>> support swap-out of mTHP? (From your previous report I was under the impression
>> that it only affected mTHP).
> 
> I think this affects all large folios with PTEs entries more than 1. but hugeTLB
> is handled as a whole in try_to_unmap_one and its rmap is removed all
> together, i feel hugeTLB doesn't have this problem.
> 
>>
>> Its just that the problem is becoming more pronounced because with mTHP,
>> PTE-mapped large folios are much more common?
> 
> right. as now large folios become a more common case, and it is my case
> running in millions of phones.
> 
> BTW, I feel we can somehow learn from hugeTLB, for example, we can reclaim
> all PTEs all together rather than iterating PTEs one by one. This will improve
> performance. for example, a batched
> set_ptes_to_swap_entries()
> {
> }
> then we only need to loop once for a large folio, right now we are looping
> nr_pages times.

You still need a pte-pte loop somewhere. In hugetlb's case it's in the arch
implementation. HugeTLB ptes are all a fixed size for a given VMA, which makes
things a bit easier too, whereas in the regular mm, they are now a variable size.

David and I introduced folio_pte_batch() to help gather batches of ptes, and it
uses the contpte bit to avoid iterating over intermediate ptes. And I'm adding
swap_pte_batch() which does a similar thing for swap entry batching in v4 of my
swap-out series.

For your set_ptes_to_swap_entries() example, I'm not sure what it would do other
than loop over the PTEs setting an incremented swap entry to each one? How is
that more performant?

Thanks,
Ryan


