Return-Path: <linux-kernel+bounces-110102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EDC885A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70AE02827AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53C684A51;
	Thu, 21 Mar 2024 13:38:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E9483CD3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711028299; cv=none; b=gYPl/ac7oOGhucb+hKThUKokcLxZlNgxywEgilVtrDwBqlp//ZSEVC3+JFNfG2sKylGBORKjGORFH//e6ZKE7lL5aihlFCZsq8Kf0T8iD4PCqNgvzWw3+T6sQxoWybIQ8vTknJFQMhT2ukEaEpNmk/L3ql1KcTrIEm46233j3qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711028299; c=relaxed/simple;
	bh=TWJQxY+j2mAIaRDlwSC5ezu/pA9voP7ZHB2o2Cs0mxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nf/WYIW5DjeWDDQSUAkqzAoyt+Bb+9KsNIW/nMLfuEAbLsbejY4F7QNqik4BmxtFKKX1KNvw6Z/LW8o1Mx6EgTIsaEexBaP+E7UJxJzBfit7GoeqIsx81QLVC8EwcUmegQ9tD04WTKRYDH1BNOV0Im00CcYOAIQAo8ZcbOHPryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A66FD1007;
	Thu, 21 Mar 2024 06:38:49 -0700 (PDT)
Received: from [10.1.33.177] (XHFQ2J9959.cambridge.arm.com [10.1.33.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 464183F762;
	Thu, 21 Mar 2024 06:38:13 -0700 (PDT)
Message-ID: <269375a4-78a3-4c22-8e6e-570368a2c053@arm.com>
Date: Thu, 21 Mar 2024 13:38:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] mm: madvise: Avoid split during MADV_PAGEOUT and
 MADV_COLD
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-7-ryan.roberts@arm.com>
 <CAGsJ_4wpjqRsn7ouO=Ut9oMBLSh803=XuSPX6gJ5nQ3jyqh3hQ@mail.gmail.com>
 <a75ec640-d025-45ee-b74d-305aaa3cc1ce@arm.com>
 <CAK1f24k1AuHDdrLFNLvwdoOy=xJTVkVdfY4+SN+KW5-EiMSa9Q@mail.gmail.com>
 <7ba06704-2090-4eb2-9534-c4d467cc085a@arm.com>
 <CAK1f24=yDVwOC31sNMaoZ6K2q1X8vA7p4CtS7nW5WXCm19iEdg@mail.gmail.com>
 <add3b9fc-f08a-4bd4-b01e-4409e81d5a2d@arm.com>
 <CAK1f24kRXZtKckRFxJfQCNSHJOHy4_nv67T+BfWeWyVtEggdNQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAK1f24kRXZtKckRFxJfQCNSHJOHy4_nv67T+BfWeWyVtEggdNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>>>>>>>> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>>>>>>>> -
>>>>>>>> -               if (!pageout && pte_young(ptent)) {
>>>>>>>> -                       ptent = ptep_get_and_clear_full(mm, addr, pte,
>>>>>>>> -                                                       tlb->fullmm);
>>>>>>>> -                       ptent = pte_mkold(ptent);
>>>>>>>> -                       set_pte_at(mm, addr, pte, ptent);
>>>>>>>> -                       tlb_remove_tlb_entry(tlb, pte, addr);
>>>>>>>> +               if (!pageout) {
>>>>>>>> +                       for (; nr != 0; nr--, pte++, addr += PAGE_SIZE) {
>>>>>>>> +                               if (ptep_test_and_clear_young(vma, addr, pte))
>>>>>>>> +                                       tlb_remove_tlb_entry(tlb, pte, addr);
>>>>>
>>>>> IIRC, some of the architecture(ex, PPC) don't update TLB with set_pte_at and
>>>>> tlb_remove_tlb_entry. So, didn't we consider remapping the PTE with old after
>>>>> pte clearing?
>>>>
>>>> Sorry Lance, I don't understand this question, can you rephrase? Are you saying
>>>> there is a good reason to do the original clear-mkold-set for some arches?
>>>
>>> IIRC, some of the architecture(ex, PPC)  don't update TLB with
>>> ptep_test_and_clear_young()
>>> and tlb_remove_tlb_entry().

Afraid I'm still struggling with this comment. Do you mean to say that powerpc
invalidates the TLB entry as part of the call to ptep_test_and_clear_young()? So
tlb_remove_tlb_entry() would be redundant here, and likely cause performance
degradation on that architecture?

IMHO, ptep_test_and_clear_young() really shouldn't be invalidating the TLB
entry, that's what ptep_clear_flush_young() is for.

But I do see that for some cases of the 32-bit ppc, there appears to be a flush:

#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
					      unsigned long addr, pte_t *ptep)
{
	unsigned long old;
	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
	if (old & _PAGE_HASHPTE)
		flush_hash_entry(mm, ptep, addr);   <<<<<<<<

	return (old & _PAGE_ACCESSED) != 0;
}
#define ptep_test_and_clear_young(__vma, __addr, __ptep) \
	__ptep_test_and_clear_young((__vma)->vm_mm, __addr, __ptep)

Is that what you are describing? Does any anyone know why flush_hash_entry() is
called? I'd say that's a bug in ppc and not a reason not to use
ptep_test_and_clear_young() in the common code!

Thanks,
Ryan


>>
>> Err, I assumed tlb_remove_tlb_entry() meant "invalidate the TLB entry for this
>> address please" - albeit its deferred and batched. I'll look into this.
>>
>>>
>>> In my new patch[1], I use refresh_full_ptes() and
>>> tlb_remove_tlb_entries() to batch-update the
>>> access and dirty bits.
>>
>> I want to avoid the per-pte clear-modify-set approach, because this doesn't
>> perform well on arm64 when using contpte mappings; it will cause the contpe
>> mapping to be unfolded by the first clear that touches the contpte block, then
>> refolded by the last set to touch the block. That's expensive.
>> ptep_test_and_clear_young() doesn't suffer that problem.
> 
> Thanks for explaining. I got it.
> 
> I think that other architectures will benefit from the per-pte clear-modify-set
> approach. IMO, refresh_full_ptes() can be overridden by arm64.
> 
> Thanks,
> Lance
>>
>>>
>>> [1] https://lore.kernel.org/linux-mm/20240316102952.39233-1-ioworker0@gmail.com
>>>
>>> Thanks,
>>> Lance
>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>> Lance
>>>>>
>>>>>
>>>>>
>>>>>>>> +                       }
>>>>>>>
>>>>>>> This looks so smart. if it is not pageout, we have increased pte
>>>>>>> and addr here; so nr is 0 and we don't need to increase again in
>>>>>>> for (; addr < end; pte += nr, addr += nr * PAGE_SIZE)
>>>>>>>
>>>>>>> otherwise, nr won't be 0. so we will increase addr and
>>>>>>> pte by nr.
>>>>>>
>>>>>> Indeed. I'm hoping that Lance is able to follow a similar pattern for
>>>>>> madvise_free_pte_range().
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>                 }
>>>>>>>>
>>>>>>>>                 /*
>>>>>>>> --
>>>>>>>> 2.25.1
>>>>>>>>
>>>>>>>
>>>>>>> Overall, LGTM,
>>>>>>>
>>>>>>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
>>>>>>
>>>>>> Thanks!
>>>>>>
>>>>>>
>>>>
>>


