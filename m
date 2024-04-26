Return-Path: <linux-kernel+bounces-159508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517F18B2F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7603B1C21F26
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5803E13A240;
	Fri, 26 Apr 2024 04:50:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AA843ADC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 04:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714107012; cv=none; b=mQ/pSAX11bvdoaQ1qfowtgbTatDez4yfjb9MiWfOSmUmhF3FKHPLcKwZhtLLEPuadRc3y3BDi+0aBDCRbh2aqYF3t9ecBRP+8f4EyLgNN4zkZVU1EM7/V5Qbk31AcZbcsr0IC8lchDeU21m9+66SuSSBdioN3azWhqckPtzgetA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714107012; c=relaxed/simple;
	bh=o1B9VTxPjXjdbUIobbBd/Pctal/CdRVokR1c5SGFju4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOi/ybSSNXVvhePtDsqeXXkukDL552qqy6B8KGR1JEnSw/pIYZ0JraxO4k7APyW9x7so164w23OPf0shTP6Dyu3UvOUOTFbq54mWM2nHpJulVNLf1PEFoaP11DA5NELMGHbUjrio13NTv+oPFbAse6DmbcFdsx8Q9IjfB00uOYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD3FB2F;
	Thu, 25 Apr 2024 21:50:37 -0700 (PDT)
Received: from [10.163.32.46] (unknown [10.163.32.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1A6F3F64C;
	Thu, 25 Apr 2024 21:50:06 -0700 (PDT)
Message-ID: <af20fd17-1e31-4e28-8773-1298aa799aec@arm.com>
Date: Fri, 26 Apr 2024 10:20:03 +0530
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
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
 <922F6794-1C32-4862-8A67-90D4F7DBC474@nvidia.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <922F6794-1C32-4862-8A67-90D4F7DBC474@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/26/24 00:28, Zi Yan wrote:
> +Anshuman, who changed pmd_present() semantics. See:
> https://lore.kernel.org/all/1599627183-14453-2-git-send-email-anshuman.khandual@arm.com/ and commit b65399f6111b ("arm64/mm: Change
> THP helpers to comply with generic MM semantics")
> 
> On 25 Apr 2024, at 13:07, Ryan Roberts wrote:
> 
>> __split_huge_pmd_locked() can be called for a present THP, devmap or
>> (non-present) migration entry. It calls pmdp_invalidate()
>> unconditionally on the pmdp and only determines if it is present or not
>> based on the returned old pmd. This is a problem for the migration entry
>> case because pmd_mkinvalid(), called by pmdp_invalidate() must only be
>> called for a present pmd.
>>
>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
>> future call to pmd_present() will return true. And therefore any
> 
> But pmd_mkinvalid() on x86 does not behave so. Maybe we should fix
> pmd_mkinvalid() on arm64 by not setting PMD_PRESENT_INVALID when the
> entry is invalid already. And add a test in mm/debug_vm_pgtable.c.
> 
> I notice that x86, risc-v, mips behave the same. loongarch also
> has _PAGE_PRESENT_INVALID bit set during pmd_mkinvalid(), but its
> pmd_present() makes sure _PAGE_HUEG is set before checks _PAGE_PRESENT_INVALID.
> So it is not a problem for loongarch. Add Huacai to confirm this.
> 
> Maybe pmd_present() on arm64 can do that too?

pmd_present() should return true even for a splitting PMD which is not
currently mapped. IIRC in all other architectures, there is a distinct
identification bit for huge page which stays back, even when the entry
becomes unmapped. That bit helps pmd_present() return true, during PMD
splitting process.

But on arm64 platform

#define PTE_VALID                (_AT(pteval_t, 1) << 0)
#define PMD_SECT_VALID           (_AT(pmdval_t, 1) << 0)
#define PMD_TABLE_BIT            (_AT(pmdval_t, 1) << 1)

When the PMD entry becomes unmapped, PTE_VALID gets cleared, so does the
PMD_SECT_VALID, thus erasing its identity as a huge mapping. A software
bit PMD_PRESENT_INVALID was added which helps in preserving that cleared
huge page mapping identity once it becomes unmapped.

> 
>> lockless pgtable walker could see the migration entry pmd in this state
>> and start interpretting the fields as if it were present, leading to
>> BadThings (TM). GUP-fast appears to be one such lockless pgtable walker.
>> I suspect the same is possible on other architectures.
>>
>> Fix this by only calling pmdp_invalidate() for a present pmd. And for
>> good measure let's add a warning to the generic implementation of
>> pmdp_invalidate(). I've manually reviewed all other
>> pmdp_invalidate[_ad]() call sites and believe all others to be
>> conformant.
>>
>> This is a theoretical bug found during code review. I don't have any
>> test case to trigger it in practice.
>>
>> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>
>> Applies on top of v6.9-rc5. Passes all the mm selftests on arm64.
>>
>> Thanks,
>> Ryan
>>
>>
>>  mm/huge_memory.c     | 5 +++--
>>  mm/pgtable-generic.c | 2 ++
>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 89f58c7603b2..80939ad00718 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2513,12 +2513,12 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>  	 * for this pmd), then we flush the SMP TLB and finally we write the
>>  	 * non-huge version of the pmd entry with pmd_populate.
>>  	 */
>> -	old_pmd = pmdp_invalidate(vma, haddr, pmd);
>>
>> -	pmd_migration = is_pmd_migration_entry(old_pmd);
>> +	pmd_migration = is_pmd_migration_entry(*pmd);
>>  	if (unlikely(pmd_migration)) {
>>  		swp_entry_t entry;
>>
>> +		old_pmd = *pmd;
>>  		entry = pmd_to_swp_entry(old_pmd);
>>  		page = pfn_swap_entry_to_page(entry);
>>  		write = is_writable_migration_entry(entry);
>> @@ -2529,6 +2529,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>  		soft_dirty = pmd_swp_soft_dirty(old_pmd);
>>  		uffd_wp = pmd_swp_uffd_wp(old_pmd);
>>  	} else {
>> +		old_pmd = pmdp_invalidate(vma, haddr, pmd);
>>  		page = pmd_page(old_pmd);
>>  		folio = page_folio(page);
>>  		if (pmd_dirty(old_pmd)) {
>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>> index 4fcd959dcc4d..74e34ea90656 100644
>> --- a/mm/pgtable-generic.c
>> +++ b/mm/pgtable-generic.c
>> @@ -198,6 +198,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
>>  pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>>  		     pmd_t *pmdp)
>>  {
>> +	VM_WARN_ON(!pmd_present(*pmdp));
>>  	pmd_t old = pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp));
>>  	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>>  	return old;
>> @@ -208,6 +209,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>>  pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
>>  			 pmd_t *pmdp)
>>  {
>> +	VM_WARN_ON(!pmd_present(*pmdp));  	return pmdp_invalidate(vma, address, pmdp);
>>  }
>>  #endif
>> --
>> 2.25.1
> 
> 
> --
> Best Regards,
> Yan, Zi

