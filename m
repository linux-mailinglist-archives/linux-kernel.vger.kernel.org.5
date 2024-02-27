Return-Path: <linux-kernel+bounces-83069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ED7868E12
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262861C219DE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E031386C1;
	Tue, 27 Feb 2024 10:53:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07E5DDB8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031190; cv=none; b=UqczvkIqQeYaZenvhAdiIMXSuwgIjVirrOUwnpq5dlNebKcJKcIdoB6OC0XsS9JoSVSq/CanmN1UZSQ4h8u55JK7C8hn1TcZDNpdlyGKGyoTkrnPSaSXUBYa7qRs9M1GLoXUvEqYXHGMZAcWguMfr93Hm2ih5C03sQAyvfIYCJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031190; c=relaxed/simple;
	bh=4173aevZicLQ7+bQhgyhKa7Q3an6+yhm2Hu3Jx4RqZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRNCGKbGE1Sz0k/6gQbiJHRhvbrWi2VkprrKtwyBV1ZSEmkDJsPiHpjzMWSzDlzsypGMnw1k1iKbkGswbBC8+6jOiOFGk40USEIxY/i2/LyljjnhV1TDBOMnXb1DxSHYkTs8WK+6oJ1EreCTTVvKfkaSxTpjp1vx/YkX5UCKT74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA6DBFEC;
	Tue, 27 Feb 2024 02:53:45 -0800 (PST)
Received: from [10.1.30.188] (XHFQ2J9959.cambridge.arm.com [10.1.30.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8F5F3F6C4;
	Tue, 27 Feb 2024 02:53:05 -0800 (PST)
Message-ID: <dc2ac3e5-a354-4447-a7da-26cae0c57b0d@arm.com>
Date: Tue, 27 Feb 2024 10:53:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: export folio_pte_batch as a couple of modules might
 need it
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>, Yin Fengwei <fengwei.yin@intel.com>
References: <20240227024050.244567-1-21cnbao@gmail.com>
 <61b9dfc9-5522-44fd-89a4-140833ede8af@arm.com>
 <c95215b2-6ec5-4efb-a73b-7be92cda1c83@redhat.com>
 <CAK1f24mOc+Y_UCA2nSC7VbNQMy0DahULz-6JsEPMqTyoAA+MoA@mail.gmail.com>
 <dbce43b4-cf69-41d0-af6c-fdfc3032fedb@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <dbce43b4-cf69-41d0-af6c-fdfc3032fedb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/02/2024 10:30, David Hildenbrand wrote:
> On 27.02.24 11:21, Lance Yang wrote:
>> On Tue, Feb 27, 2024 at 5:14 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 27.02.24 10:07, Ryan Roberts wrote:
>>>> On 27/02/2024 02:40, Barry Song wrote:
>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>
>>>>> madvise and some others might need folio_pte_batch to check if a range
>>>>> of PTEs are completely mapped to a large folio with contiguous physcial
>>>>> addresses. Let's export it for others to use.
>>>>>
>>>>> Cc: Lance Yang <ioworker0@gmail.com>
>>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>> Cc: Yin Fengwei <fengwei.yin@intel.com>
>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>>> ---
>>>>>    -v1:
>>>>>    at least two jobs madv_free and madv_pageout depend on it. To avoid
>>>>>    conflicts and dependencies, after discussing with Lance, we prefer
>>>>>    this one can land earlier.
>>>>
>>>> I think this will also ultimately be useful for mprotect too, though I haven't
>>>> looked at it properly yet.
>>>>
>>>
>>> Yes, I think we briefly discussed that.
>>>
>>>>>
>>>>>    mm/internal.h | 13 +++++++++++++
>>>>>    mm/memory.c   | 11 +----------
>>>>>    2 files changed, 14 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>>> index 13b59d384845..8e2bc304f671 100644
>>>>> --- a/mm/internal.h
>>>>> +++ b/mm/internal.h
>>>>> @@ -83,6 +83,19 @@ static inline void *folio_raw_mapping(struct folio *folio)
>>>>>       return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
>>>>>    }
>>>>>
>>>>> +/* Flags for folio_pte_batch(). */
>>>>> +typedef int __bitwise fpb_t;
>>>>> +
>>>>> +/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
>>>>> +#define FPB_IGNORE_DIRTY            ((__force fpb_t)BIT(0))
>>>>> +
>>>>> +/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
>>>>> +#define FPB_IGNORE_SOFT_DIRTY               ((__force fpb_t)BIT(1))
>>>>> +
>>>>> +extern int folio_pte_batch(struct folio *folio, unsigned long addr,
>>>>> +            pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
>>>>> +            bool *any_writable);
>>>>> +
>>>>>    void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
>>>>>                                               int nr_throttled);
>>>>>    static inline void acct_reclaim_writeback(struct folio *folio)
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index 1c45b6a42a1b..319b3be05e75 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -953,15 +953,6 @@ static __always_inline void __copy_present_ptes(struct
>>>>> vm_area_struct *dst_vma,
>>>>>       set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
>>>>>    }
>>>>>
>>>>> -/* Flags for folio_pte_batch(). */
>>>>> -typedef int __bitwise fpb_t;
>>>>> -
>>>>> -/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
>>>>> -#define FPB_IGNORE_DIRTY            ((__force fpb_t)BIT(0))
>>>>> -
>>>>> -/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
>>>>> -#define FPB_IGNORE_SOFT_DIRTY               ((__force fpb_t)BIT(1))
>>>>> -
>>>>>    static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>>>>>    {
>>>>>       if (flags & FPB_IGNORE_DIRTY)
>>>>> @@ -982,7 +973,7 @@ static inline pte_t __pte_batch_clear_ignored(pte_t
>>>>> pte, fpb_t flags)
>>>>>     * If "any_writable" is set, it will indicate if any other PTE besides the
>>>>>     * first (given) PTE is writable.
>>>>>     */
>>>>
>>>> David was talking in Lance's patch thread, about improving the docs for this
>>>> function now that its exported. Might be worth syncing on that.
>>>
>>> Here is my take:
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>    mm/memory.c | 22 ++++++++++++++++++----
>>>    1 file changed, 18 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index d0b855a1837a8..098356b8805ae 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -971,16 +971,28 @@ static inline pte_t __pte_batch_clear_ignored(pte_t
>>> pte, fpb_t flags)
>>>          return pte_wrprotect(pte_mkold(pte));
>>>    }
>>>
>>> -/*
>>> +/**
>>> + * folio_pte_batch - detect a PTE batch for a large folio
>>> + * @folio: The large folio to detect a PTE batch for.
>>> + * @addr: The user virtual address the first page is mapped at.
>>> + * @start_ptep: Page table pointer for the first entry.
>>> + * @pte: Page table entry for the first page.
>>
>> Nit:
>>
>> - * @pte: Page table entry for the first page.
>> + * @pte: Page table entry for the first page that must be the first subpage of
>> + *               the folio excluding arm64 for now.
>>
>> IIUC, pte_batch_hint is always 1 excluding arm64 for now.
>> I'm not sure if this modification will be helpful?
> 
> IIRC, Ryan made sure that this also works when passing another subpage, after
> when cont-pte is set. Otherwise this would already be broken for fork/zap.
> 
> So I don't think this comment would actually be correct.

Indeed, the spec for the function is exactly the same for arm64 as for other
arches. It's just that arm64 can accelerate the implementation by skipping
forward to the next contpte boundary when the current pte is part of a contpte
block.

There is no requirement for pte (or addr or start_ptep) to point to the first
subpage of a folio - they can point to any subpage.

pte, addr and start_ptep must all refer to the same entry, but I think that's
clear from the existing text.



