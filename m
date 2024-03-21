Return-Path: <linux-kernel+bounces-110217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FBA885B97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EDD028599C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1618664F;
	Thu, 21 Mar 2024 15:24:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311DB86265
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034680; cv=none; b=LSJx6QxBAsddo6Yj53YpOGpaJkiDQBJX6hzrJNbGGDSDWfOL/oP1/0+N2bVuG6Np6kii2fWyP1kwCr1g9Kg2r32hGqv8qhM9QtWAXbzACcITuLOLNiWmxz2/bbDSffPgMNRGR0NIZOKgFCFKSGlbUXuzP8w/ldAv1k+MwFkRMIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034680; c=relaxed/simple;
	bh=3NKkuWB79YkKuLoJUAirLEYClaABoW8s3EVR+Opt7N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuQ58ByIoDafTntI6JWNq6oln2vrQiadAg8GnpfbNcoLzzAP5MkJOZ5Co7yVnP5OcKDadi54dSUbOnZ6Yzt8nhkslpw1LyxHDmPrNhyp8sa8CWV9iFIAn2tgf7jrlEVyJG7ij4eOeoOYvYauk74/RXcjJxZqMLQDNYI7/XLTNyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCFFE1007;
	Thu, 21 Mar 2024 08:25:11 -0700 (PDT)
Received: from [10.1.33.177] (XHFQ2J9959.cambridge.arm.com [10.1.33.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6428B3F67D;
	Thu, 21 Mar 2024 08:24:35 -0700 (PDT)
Message-ID: <9930c86a-c0c8-4112-9122-0e4faca475f5@arm.com>
Date: Thu, 21 Mar 2024 15:24:33 +0000
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
 <269375a4-78a3-4c22-8e6e-570368a2c053@arm.com>
 <CAK1f24m+oQgBYdxUaTASMtJpnUEQvWh-t_kVw7CJzVM4Siddcg@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAK1f24m+oQgBYdxUaTASMtJpnUEQvWh-t_kVw7CJzVM4Siddcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/03/2024 14:55, Lance Yang wrote:
> On Thu, Mar 21, 2024 at 9:38 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>>>>>>>>>> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>>>>>>>>>> -
>>>>>>>>>> -               if (!pageout && pte_young(ptent)) {
>>>>>>>>>> -                       ptent = ptep_get_and_clear_full(mm, addr, pte,
>>>>>>>>>> -                                                       tlb->fullmm);
>>>>>>>>>> -                       ptent = pte_mkold(ptent);
>>>>>>>>>> -                       set_pte_at(mm, addr, pte, ptent);
>>>>>>>>>> -                       tlb_remove_tlb_entry(tlb, pte, addr);
>>>>>>>>>> +               if (!pageout) {
>>>>>>>>>> +                       for (; nr != 0; nr--, pte++, addr += PAGE_SIZE) {
>>>>>>>>>> +                               if (ptep_test_and_clear_young(vma, addr, pte))
>>>>>>>>>> +                                       tlb_remove_tlb_entry(tlb, pte, addr);
>>>>>>>
>>>>>>> IIRC, some of the architecture(ex, PPC) don't update TLB with set_pte_at and
>>>>>>> tlb_remove_tlb_entry. So, didn't we consider remapping the PTE with old after
>>>>>>> pte clearing?
>>>>>>
>>>>>> Sorry Lance, I don't understand this question, can you rephrase? Are you saying
>>>>>> there is a good reason to do the original clear-mkold-set for some arches?
>>>>>
>>>>> IIRC, some of the architecture(ex, PPC)  don't update TLB with
>>>>> ptep_test_and_clear_young()
>>>>> and tlb_remove_tlb_entry().
>>
>> Afraid I'm still struggling with this comment. Do you mean to say that powerpc
>> invalidates the TLB entry as part of the call to ptep_test_and_clear_young()? So
>> tlb_remove_tlb_entry() would be redundant here, and likely cause performance
>> degradation on that architecture?
> 
> I just thought that using ptep_test_and_clear_young() instead of
> ptep_get_and_clear_full() + pte_mkold() might not be correct.
> However, it's most likely that I was mistaken :(

OK, I'm pretty confident that my usage is correct.

> 
> I also have a question. Why aren't we using ptep_test_and_clear_young() in
> madvise_cold_or_pageout_pte_range(), but instead
> ptep_get_and_clear_full() + pte_mkold() as we did previously.
> 
> /*
> * Some of architecture(ex, PPC) don't update TLB
> * with set_pte_at and tlb_remove_tlb_entry so for
> * the portability, remap the pte with old|clean
> * after pte clearing.
> */

Ahh, I see; this is a comment from madvise_free_pte_range() I don't quite
understand that comment. I suspect it might be out of date, or saying that doing
set_pte_at(pte_mkold(ptep_get(ptent))) is not correct because it is not atomic
and the HW could set the dirty bit between the get and the set. Doing the atomic
ptep_get_and_clear_full() means you go via a pte_none() state, so if the TLB is
racing it will see the entry isn't valid and fault.

Note that madvise_free_pte_range() is trying to clear both the access and dirty
bits, whereas madvise_cold_or_pageout_pte_range() is only trying to clear the
access bit. There is a special helper to clear the access bit atomically -
ptep_test_and_clear_young() - but there is no helper to clear the access *and*
dirty bit, I don't believe. There is ptep_set_access_flags(), but that sets
flags to a "more permissive setting" (i.e. allows setting the flags, not
clearing them). Perhaps this constraint can be relaxed given we will follow up
with an explicit TLBI - it would require auditing all the implementations.

> 
> According to this comment from madvise_free_pte_range. IIUC, we need to
> call ptep_get_and_clear_full() to clear the PTE, and then remap the
> PTE with old|clean.
> 
> Thanks,
> Lance
> 
>>
>> IMHO, ptep_test_and_clear_young() really shouldn't be invalidating the TLB
>> entry, that's what ptep_clear_flush_young() is for.
>>
>> But I do see that for some cases of the 32-bit ppc, there appears to be a flush:
>>
>> #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
>> static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
>>                                               unsigned long addr, pte_t *ptep)
>> {
>>         unsigned long old;
>>         old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
>>         if (old & _PAGE_HASHPTE)
>>                 flush_hash_entry(mm, ptep, addr);   <<<<<<<<
>>
>>         return (old & _PAGE_ACCESSED) != 0;
>> }
>> #define ptep_test_and_clear_young(__vma, __addr, __ptep) \
>>         __ptep_test_and_clear_young((__vma)->vm_mm, __addr, __ptep)
>>
>> Is that what you are describing? Does any anyone know why flush_hash_entry() is
>> called? I'd say that's a bug in ppc and not a reason not to use
>> ptep_test_and_clear_young() in the common code!
>>
>> Thanks,
>> Ryan
>>
>>
>>>>
>>>> Err, I assumed tlb_remove_tlb_entry() meant "invalidate the TLB entry for this
>>>> address please" - albeit its deferred and batched. I'll look into this.
>>>>
>>>>>
>>>>> In my new patch[1], I use refresh_full_ptes() and
>>>>> tlb_remove_tlb_entries() to batch-update the
>>>>> access and dirty bits.
>>>>
>>>> I want to avoid the per-pte clear-modify-set approach, because this doesn't
>>>> perform well on arm64 when using contpte mappings; it will cause the contpe
>>>> mapping to be unfolded by the first clear that touches the contpte block, then
>>>> refolded by the last set to touch the block. That's expensive.
>>>> ptep_test_and_clear_young() doesn't suffer that problem.
>>>
>>> Thanks for explaining. I got it.
>>>
>>> I think that other architectures will benefit from the per-pte clear-modify-set
>>> approach. IMO, refresh_full_ptes() can be overridden by arm64.
>>>
>>> Thanks,
>>> Lance
>>>>
>>>>>
>>>>> [1] https://lore.kernel.org/linux-mm/20240316102952.39233-1-ioworker0@gmail.com
>>>>>
>>>>> Thanks,
>>>>> Lance
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Lance
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>>> +                       }
>>>>>>>>>
>>>>>>>>> This looks so smart. if it is not pageout, we have increased pte
>>>>>>>>> and addr here; so nr is 0 and we don't need to increase again in
>>>>>>>>> for (; addr < end; pte += nr, addr += nr * PAGE_SIZE)
>>>>>>>>>
>>>>>>>>> otherwise, nr won't be 0. so we will increase addr and
>>>>>>>>> pte by nr.
>>>>>>>>
>>>>>>>> Indeed. I'm hoping that Lance is able to follow a similar pattern for
>>>>>>>> madvise_free_pte_range().
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>                 }
>>>>>>>>>>
>>>>>>>>>>                 /*
>>>>>>>>>> --
>>>>>>>>>> 2.25.1
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Overall, LGTM,
>>>>>>>>>
>>>>>>>>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
>>>>>>>>
>>>>>>>> Thanks!
>>>>>>>>
>>>>>>>>
>>>>>>
>>>>
>>


