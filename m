Return-Path: <linux-kernel+bounces-140337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA78A12EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30641B24BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40A6149C75;
	Thu, 11 Apr 2024 11:27:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6918213D258
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834874; cv=none; b=FKAjjRU8khb1kB5ru2Vh1ZD+rs92i7TMTVYEPIKMcYIPbIYy92NkvZGjWmIibX/O/qaUjk6ZkmWCG9z/q8kBKkuvhtTcXqr09IcjN2HYGAgFY+fY2KOM+cEEgGQFdxhOr+tcbfUI2cyICew9M3sxLVDS0sOf0U7YNkCmHn74l/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834874; c=relaxed/simple;
	bh=9zkVJL8zRVuR9kRv+VB0FpDhOZ3XwqRKYTV5gfmfVMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qs6LiQGzYMIuFIlMHKNR0AkmEehwy9ODgmtyFo2Nd6A3/hPBs+WF7cHcf4k6hjcsKTPA6VSXZdYZRTAb2VmKS3u1/zh1ZW2uLcqamhDizet9B8wVtjGsqJDcmUjzo1X0gmNkhjCEFmY94wiTWxwfpyRP5H1YUslPg/zgJ9kQ8k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56423113E;
	Thu, 11 Apr 2024 04:28:21 -0700 (PDT)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 229323F64C;
	Thu, 11 Apr 2024 04:27:49 -0700 (PDT)
Message-ID: <a59496b6-ffdf-40ce-b030-283cc911203e@arm.com>
Date: Thu, 11 Apr 2024 12:27:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] mm/madvise: optimize lazyfreeing with mTHP in
 madvise_free
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>,
 akpm@linux-foundation.org
Cc: 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com,
 minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240408042437.10951-1-ioworker0@gmail.com>
 <20240408042437.10951-2-ioworker0@gmail.com>
 <38c4add8-53a2-49ca-9f1b-f62c2ee3e764@arm.com>
 <013334d5-62d2-4256-8045-168893a0a0cf@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <013334d5-62d2-4256-8045-168893a0a0cf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/04/2024 12:20, David Hildenbrand wrote:
> On 11.04.24 13:11, Ryan Roberts wrote:
>> On 08/04/2024 05:24, Lance Yang wrote:
>>> This patch optimizes lazyfreeing with PTE-mapped mTHP[1]
>>> (Inspired by David Hildenbrand[2]). We aim to avoid unnecessary folio
>>> splitting if the large folio is fully mapped within the target range.
>>>
>>> If a large folio is locked or shared, or if we fail to split it, we just
>>> leave it in place and advance to the next PTE in the range. But note that
>>> the behavior is changed; previously, any failure of this sort would cause
>>> the entire operation to give up. As large folios become more common,
>>> sticking to the old way could result in wasted opportunities.
>>>
>>> On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by PTE-mapped folios of
>>> the same size results in the following runtimes for madvise(MADV_FREE) in
>>> seconds (shorter is better):
>>>
>>> Folio Size |   Old    |   New    | Change
>>> ------------------------------------------
>>>        4KiB | 0.590251 | 0.590259 |    0%
>>>       16KiB | 2.990447 | 0.185655 |  -94%
>>>       32KiB | 2.547831 | 0.104870 |  -95%
>>>       64KiB | 2.457796 | 0.052812 |  -97%
>>>      128KiB | 2.281034 | 0.032777 |  -99%
>>>      256KiB | 2.230387 | 0.017496 |  -99%
>>>      512KiB | 2.189106 | 0.010781 |  -99%
>>>     1024KiB | 2.183949 | 0.007753 |  -99%
>>>     2048KiB | 0.002799 | 0.002804 |    0%
>>>
>>> [1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@arm.com
>>> [2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redhat.com
>>>
>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>>> ---
>>>   include/linux/pgtable.h |  34 +++++++++
>>>   mm/internal.h           |  12 +++-
>>>   mm/madvise.c            | 149 ++++++++++++++++++++++------------------
>>>   mm/memory.c             |   4 +-
>>>   4 files changed, 129 insertions(+), 70 deletions(-)
>>>
>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>> index 0f4b2faa1d71..4dd442787420 100644
>>> --- a/include/linux/pgtable.h
>>> +++ b/include/linux/pgtable.h
>>> @@ -489,6 +489,40 @@ static inline pte_t ptep_get_and_clear(struct mm_struct
>>> *mm,
>>>   }
>>>   #endif
>>>   +#ifndef mkold_clean_ptes
>>> +/**
>>> + * mkold_clean_ptes - Mark PTEs that map consecutive pages of the same folio
>>> + *        as old and clean.
>>> + * @mm: Address space the pages are mapped into.
>>> + * @addr: Address the first page is mapped at.
>>> + * @ptep: Page table pointer for the first entry.
>>> + * @nr: Number of entries to mark old and clean.
>>> + *
>>> + * May be overridden by the architecture; otherwise, implemented by
>>> + * get_and_clear/modify/set for each pte in the range.
>>> + *
>>> + * Note that PTE bits in the PTE range besides the PFN can differ. For example,
>>> + * some PTEs might be write-protected.
>>> + *
>>> + * Context: The caller holds the page table lock.  The PTEs map consecutive
>>> + * pages that belong to the same folio.  The PTEs are all in the same PMD.
>>> + */
>>> +static inline void mkold_clean_ptes(struct mm_struct *mm, unsigned long addr,
>>> +                    pte_t *ptep, unsigned int nr)
>>
>> Just thinking out loud, I wonder if it would be cleaner to convert mkold_ptes()
>> (which I added as part of swap-out) to something like:
>>
>> clear_young_dirty_ptes(struct mm_struct *mm, unsigned long addr,
>>                pte_t *ptep, unsigned int nr,
>>                bool clear_young, bool clear_dirty);
>>
>> Then we can use the same function for both use cases and also have the ability
>> to only clear dirty in future if we ever need it. The other advantage is that we
>> only need to plumb a single function down the arm64 arch code. As it currently
>> stands, those 2 functions would be duplicating most of their code.
> 
> Yes. Maybe better use proper __bitwise flags, the compiler should be smart
> enough to optimize either way.

Agreed. I was also thinking perhaps it makes sense to start using output bitwise
flags for folio_pte_batch() since this patch set takes us up to 3 optional bool
pointers for different things. Might be cleaner to have input flags to tell it
what we care about and output flags to highlight those things. I guess the
compiler should be able to optimize in the same way.


