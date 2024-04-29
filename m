Return-Path: <linux-kernel+bounces-161750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3CE8B50B6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A741F21EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA469DDB2;
	Mon, 29 Apr 2024 05:26:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF3EDF43
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714368368; cv=none; b=CVhs4irIUAOo1fSGQZojvwc0yKgQi244T82MYWmdzVPz19yKGpD2dyRo1knuNJ3ptIgswCkfyxVa1+SDrBBZEVp45Ojt6Ufq7CFP12QkrBisUqxt0fzWz87xya0lJXtmSSSgbl1DpeI7LlEybaIIJ1H2CQz/LfpQ9xk9VJI61nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714368368; c=relaxed/simple;
	bh=A+FSDlLGRZjd7SpA0wOTXFNByuKGMRh+qrIIu/W0fbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JW52n7a1TN4HCHOhBKN2aVC/MXZrXm2Q/qLmQYwOi899s9YaXIiyMxG1LjfQIQiMeZ0Lyk+1a2JwwL/uTjvZ+qp06XO06qI0dyxEk1Gbtf5GLP/ozASJ7V4PEDnorn5zBWZ2rbfQbe6YBtZ7pBvdGqCgiNYmNjQfVxxUEcxQCSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 892032F4;
	Sun, 28 Apr 2024 22:26:32 -0700 (PDT)
Received: from [10.162.42.72] (a077893.blr.arm.com [10.162.42.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C7CA3F793;
	Sun, 28 Apr 2024 22:26:03 -0700 (PDT)
Message-ID: <dde544c2-5b57-4863-ae2d-c66016e0d635@arm.com>
Date: Mon, 29 Apr 2024 10:55:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
 <39d0236c-4297-4001-bc7e-f516bc674f7b@arm.com>
 <87df74b7-2352-4ad6-b9f9-baed9291cbed@arm.com>
 <80148272-208A-4306-A8EC-98C79BBBDCA0@nvidia.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <80148272-208A-4306-A8EC-98C79BBBDCA0@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/26/24 20:19, Zi Yan wrote:
> On 26 Apr 2024, at 3:43, Ryan Roberts wrote:
> 
>> On 26/04/2024 05:19, Anshuman Khandual wrote:
>>> On 4/25/24 22:37, Ryan Roberts wrote:
>>>> __split_huge_pmd_locked() can be called for a present THP, devmap or
>>>> (non-present) migration entry. It calls pmdp_invalidate()
>>>> unconditionally on the pmdp and only determines if it is present or not
>>>> based on the returned old pmd. This is a problem for the migration entry
>>>> case because pmd_mkinvalid(), called by pmdp_invalidate() must only be
>>>> called for a present pmd.
>>>
>>> pmdp_invalidate() must be called only for present PMD - is this expected
>>> by core MM ? Does this cause any problem otherwise ?
>>
>> I'm saying that only calling pmdp_invalidate() on a pte_present()==true pte is
>> the only semantic that makes sense. And, yes, it causes a problem if called on a
>> pte_present()==false pte - that's exactly what I'm describing in this commit log.
>>
>> To labour the point, this is the logical type hierachy of PTEs (and block-mapped
>> PMDs) as I see it:
>>
>> ---8<----
>>
>> pte
>>  |- present
>>  |   |- valid
>>  |   |- invalid
>>  |
>>  |- not_present
>>      |- none
>>      |- swap_pte
>>
>> present: All fields must be interpretted the way the HW sees them. e.g.
>>          pte_pfn(), pte_write(), pte_dirty(), pte_young(), pte_mkwrite(),
>>          pte_mkold() can all be legitimately used to query and modify the pte.
>>
>>   valid: The HW may access the pte, interpret the fields and create a TLB entry,
>>          etc.
>>
>>   invalid: The HW will never access the pte or create a TLB entry for it.
>>
>> not_present: The fields are SW-defined. HW never accesses the PTE.
>>
>>   none: Unused; represents a hole
>>
>>   swap_pte: Contains a swap entry and swap pte bits. The contained swap entry
>>             may 1 of a few different types e.g. actual swap entry, migration
>>             entry, hw poison, etc.
>>
>> ---8<----
>>
>> We test present vs not_present with pte_present()
>>
>> We test none vs swap_pte with pte_none()
>>
>> valid vs invalid is slightly more vague. The core-mm can move a PMD from valid
>> -> invalid by calling pmd_mkinvalid(). But it can't query the state. And it
>> can't do this generically for a PTE.
>>
>>
>> Based on that lot, it makes no sense to me that we should permit calling
>> pmd_mkinvalid() on a non-present pte. Indeed, we don't permit calling
>> pte_mkwrite() etc on a non-present pte. And those functions are not defensive;
>> they don't check that the pte is present before making the change. They just
>> trust that the core-mm will not call them for non-present ptes.
> 
> I am OK with disallowing to call pmd_mkinvalid() on a non-present entry, but
> would like to know how to enforce it or document it. Because x86, risc-v, mips,
> and loongarch can call pmd_mkinvalid() on a non-present entry without causing
> any issue, any developer who work on these arches but arm64 can use pmd_mkinvalid()
> improperly until someone else tests it on arm64. You will need to add VM_WARM_ON()
> to all arch versions of pmd_mkinvalid().

Adding VM_WARM_ON() to all arch versions of pmd_mkinvalid() or returning the old
pmd back unchanged when not present are stable solutions.

> 
>>
>> The alternative approach would be to make pmdp_invalidate() defensive so that it
>> checks the pmd is present before making any changes. But it doesn't semantically
>> make sense to invalidate a non-present pmd in the first place so why call it
>> under these circumstances? There is also a practical problem in that some arches
>> implement their own pmdp_invalidate() so you would want to make all those
>> defensive too, which would grow the size of the change.
> 
> Like I said above, if you do not do this, other arches developers can break arm64
> without knowing it, since their pmd_mkinvalid() do not change a non-present
> PMD to a present one.

Unlike other PMD helpers pmdp_invalidate() is bit non-trivial and hence can be made
bit more defensive.

> 
>>>
>>>>
>>>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
>>>> future call to pmd_present() will return true. And therefore any
>>>
>>> IIRC the following semantics needs to be followed as expected by core MM.
>>>
>>> -------------------------------------------------------------------------
>>> |	PMD states	|	pmd_present	|	pmd_trans_huge	|
>>> -------------------------------------------------------------------------
>>> |	Mapped		|	Yes		|	Yes		|
>>> -------------------------------------------------------------------------
>>> |	Splitting	|	Yes		|	Yes		|
>>> -------------------------------------------------------------------------
>>> |	Migration/Swap	|	No		|	No		|
>>> -------------------------------------------------------------------------
>>
>> Indeed, the problem, as I see it, is if pmd_mkinvalid() is called on a
>> "Migration/Swap" pmd, then a future call to pmd_present() will return Yes, which
>> is clearly wrong. pmd_trans_huge() will also return Yes due to:
>>
>> static inline int pmd_trans_huge(pmd_t pmd)
>> {
>> 	return pmd_val(pmd) && pmd_present(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
>> }
>>
>> At least this happens for arm64. Although Zi suggests other arches look like
>> they will do this too in the other email.
>>
>> The reason is that arm64's pmd_mkinvalid() unconditionally sets
>> PMD_PRESENT_INVALID (bit 59) and clears PMD_SECT_VALID (bit 0) in the pte. So
>> next time pmd_present() is called it will see PMD_PRESENT_INVALID is set and
>> return true.
>>
>>>
>>>
>>>> lockless pgtable walker could see the migration entry pmd in this state
>>>> and start interpretting the fields as if it were present, leading to
>>>> BadThings (TM). GUP-fast appears to be one such lockless pgtable walker.
>>>
>>> Could you please explain how bad things might happen ?
>>
>> See 2 places where pmdp_get_lockless() is called in gup.c, without the PTL.
>> These could both return the swap pte for which pmd_mkinvalid() has been called.
>> In both cases, this would lead to the pmd_present() check eroneously returning
>> true, eventually causing incorrect interpretation of the pte fields. e.g.:
>>
>> gup_pmd_range()
>>   pmd_t pmd = pmdp_get_lockless(pmdp);
>>   gup_huge_pmd(pmd, ...)
>>     page = nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SHIFT);
>>
>> page is guff.
>>
>> Let me know what you think!
>>
>> Thanks,
>> Ryan
>>
>>
>>>
>>>> I suspect the same is possible on other architectures.
>>>>
>>>> Fix this by only calling pmdp_invalidate() for a present pmd. And for
>>>> good measure let's add a warning to the generic implementation of
>>>> pmdp_invalidate(). I've manually reviewed all other
>>>> pmdp_invalidate[_ad]() call sites and believe all others to be
>>>> conformant.
>>>>
>>>> This is a theoretical bug found during code review. I don't have any
>>>> test case to trigger it in practice.
>>>>
>>>> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>
>>>> Applies on top of v6.9-rc5. Passes all the mm selftests on arm64.
>>>>
>>>> Thanks,
>>>> Ryan
>>>>
>>>>
>>>>  mm/huge_memory.c     | 5 +++--
>>>>  mm/pgtable-generic.c | 2 ++
>>>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 89f58c7603b2..80939ad00718 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -2513,12 +2513,12 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>>>  	 * for this pmd), then we flush the SMP TLB and finally we write the
>>>>  	 * non-huge version of the pmd entry with pmd_populate.
>>>>  	 */
>>>> -	old_pmd = pmdp_invalidate(vma, haddr, pmd);
>>>>
>>>> -	pmd_migration = is_pmd_migration_entry(old_pmd);
>>>> +	pmd_migration = is_pmd_migration_entry(*pmd);
>>>>  	if (unlikely(pmd_migration)) {
>>>>  		swp_entry_t entry;
>>>>
>>>> +		old_pmd = *pmd;
>>>>  		entry = pmd_to_swp_entry(old_pmd);
>>>>  		page = pfn_swap_entry_to_page(entry);
>>>>  		write = is_writable_migration_entry(entry);
>>>> @@ -2529,6 +2529,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>>>  		soft_dirty = pmd_swp_soft_dirty(old_pmd);
>>>>  		uffd_wp = pmd_swp_uffd_wp(old_pmd);
>>>>  	} else {
>>>> +		old_pmd = pmdp_invalidate(vma, haddr, pmd);
>>>>  		page = pmd_page(old_pmd);
>>>>  		folio = page_folio(page);
>>>>  		if (pmd_dirty(old_pmd)) {
>>>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>>>> index 4fcd959dcc4d..74e34ea90656 100644
>>>> --- a/mm/pgtable-generic.c
>>>> +++ b/mm/pgtable-generic.c
>>>> @@ -198,6 +198,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
>>>>  pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>>>>  		     pmd_t *pmdp)
>>>>  {
>>>> +	VM_WARN_ON(!pmd_present(*pmdp));
>>>>  	pmd_t old = pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp));
>>>>  	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>>>>  	return old;
>>>> @@ -208,6 +209,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>>>>  pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
>>>>  			 pmd_t *pmdp)
>>>>  {
>>>> +	VM_WARN_ON(!pmd_present(*pmdp));
>>>>  	return pmdp_invalidate(vma, address, pmdp);
>>>>  }
>>>>  #endif
>>>> --
>>>> 2.25.1
>>>>
>>>>
> 
> 
> --
> Best Regards,
> Yan, Zi

