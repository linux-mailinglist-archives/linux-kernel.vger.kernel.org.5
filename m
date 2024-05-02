Return-Path: <linux-kernel+bounces-166059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 615268B9560
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88BC0B2159E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD6E225DD;
	Thu,  2 May 2024 07:37:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EB211CBD;
	Thu,  2 May 2024 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714635463; cv=none; b=mN1FYSIS4vFTkfwcRU4Nrhlbysts7U3E1YdC+jP+Fn8pPlJTjXhEsbpiuM56drbJU2I/UwIpbRx5SzQEzxqWk2Cb/xuqba9OF6EMPSDIpOQHjjat5PG+HIaNc245oYpXZmzllKIi154a/XigzPsomnYd2HgOzb24SpJZ28jsr5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714635463; c=relaxed/simple;
	bh=WHuU3zHOX/nlbJCB/E010DMEXCC+Z08QFsdptTXy4OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrMMwpkbQUcHawlY9qK2KYBpx7c+Zlbw6vIBZ8NyxgfxUeeo7l42Rxr1stFAk2Ezw4lGIaBxJYon5liMVEZPcvmfRQt9mGefD2VJEQ9x2J/QFOFjrVbP7oMobusvo10STTQykRZfRyVi1ekhG0FInHeZR+8zzVasTcedwJSSR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8934E2F4;
	Thu,  2 May 2024 00:38:05 -0700 (PDT)
Received: from [10.57.65.146] (unknown [10.57.65.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52E303F71E;
	Thu,  2 May 2024 00:37:36 -0700 (PDT)
Message-ID: <d72a3496-b7a5-43ce-a099-e2fef75dd84a@arm.com>
Date: Thu, 2 May 2024 08:37:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Zi Yan <zi.yan@cs.rutgers.edu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240501143310.1381675-1-ryan.roberts@arm.com>
 <d274b296-9892-49fa-95d1-56ff862a2933@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <d274b296-9892-49fa-95d1-56ff862a2933@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/05/2024 04:03, Anshuman Khandual wrote:
> 
> 
> On 5/1/24 20:03, Ryan Roberts wrote:
>> __split_huge_pmd_locked() can be called for a present THP, devmap or
>> (non-present) migration entry. It calls pmdp_invalidate()
>> unconditionally on the pmdp and only determines if it is present or not
>> based on the returned old pmd. This is a problem for the migration entry
>> case because pmd_mkinvalid(), called by pmdp_invalidate() must only be
>> called for a present pmd.
>>
>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
>> future call to pmd_present() will return true. And therefore any
>> lockless pgtable walker could see the migration entry pmd in this state
>> and start interpretting the fields as if it were present, leading to
>> BadThings (TM). GUP-fast appears to be one such lockless pgtable walker.
>>
>> x86 does not suffer the above problem, but instead pmd_mkinvalid() will
>> corrupt the offset field of the swap entry within the swap pte. See link
>> below for discussion of that problem.
>>
>> Fix all of this by only calling pmdp_invalidate() for a present pmd. And
>> for good measure let's add a warning to all implementations of
>> pmdp_invalidate[_ad](). I've manually reviewed all other
>> pmdp_invalidate[_ad]() call sites and believe all others to be
>> conformant.
>>
>> This is a theoretical bug found during code review. I don't have any
>> test case to trigger it in practice.
>>
>> Cc: stable@vger.kernel.org
>> Link: https://lore.kernel.org/all/0dd7827a-6334-439a-8fd0-43c98e6af22b@arm.com/
>> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>
>> Right v3; this goes back to the original approach in v1 to fix core-mm rather
>> than push the fix into arm64, since we discovered that x86 can't handle
>> pmd_mkinvalid() being called for non-present pmds either.
> 
> This is a better approach indeed.
> 
>>
>> I'm pulling in more arch maintainers because this version adds some warnings in
>> arch code to help spot incorrect usage.
>>
>> Although Catalin had already accepted v2 (fixing arm64) [2] into for-next/fixes,
>> he's agreed to either remove or revert it.
>>
>>
>> Changes since v1 [1]
>> ====================
>>
>>   - Improve pmdp_mkinvalid() docs to make it clear it can only be called for
>>     present pmd (per JohnH, Zi Yan)
>>   - Added warnings to arch overrides of pmdp_invalidate[_ad]() (per Zi Yan)
>>   - Moved comment next to new location of pmpd_invalidate() (per Zi Yan)
>>
>>
>> [1] https://lore.kernel.org/linux-mm/20240425170704.3379492-1-ryan.roberts@arm.com/
>> [2] https://lore.kernel.org/all/20240430133138.732088-1-ryan.roberts@arm.com/
>>
>> Thanks,
>> Ryan
>>
>>
>>  Documentation/mm/arch_pgtable_helpers.rst |  6 ++-
>>  arch/powerpc/mm/book3s64/pgtable.c        |  1 +
>>  arch/s390/include/asm/pgtable.h           |  4 +-
>>  arch/sparc/mm/tlb.c                       |  1 +
>>  arch/x86/mm/pgtable.c                     |  2 +
>>  mm/huge_memory.c                          | 49 ++++++++++++-----------
>>  mm/pgtable-generic.c                      |  2 +
>>  7 files changed, 39 insertions(+), 26 deletions(-)
>>
>> diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
>> index 2466d3363af7..ad50ca6f495e 100644
>> --- a/Documentation/mm/arch_pgtable_helpers.rst
>> +++ b/Documentation/mm/arch_pgtable_helpers.rst
>> @@ -140,7 +140,8 @@ PMD Page Table Helpers
>>  +---------------------------+--------------------------------------------------+
>>  | pmd_swp_clear_soft_dirty  | Clears a soft dirty swapped PMD                  |
>>  +---------------------------+--------------------------------------------------+
>> -| pmd_mkinvalid             | Invalidates a mapped PMD [1]                     |
>> +| pmd_mkinvalid             | Invalidates a present PMD; do not call for       |
>> +|                           | non-present PMD [1]                              |
>>  +---------------------------+--------------------------------------------------+
>>  | pmd_set_huge              | Creates a PMD huge mapping                       |
>>  +---------------------------+--------------------------------------------------+
>> @@ -196,7 +197,8 @@ PUD Page Table Helpers
>>  +---------------------------+--------------------------------------------------+
>>  | pud_mkdevmap              | Creates a ZONE_DEVICE mapped PUD                 |
>>  +---------------------------+--------------------------------------------------+
>> -| pud_mkinvalid             | Invalidates a mapped PUD [1]                     |
>> +| pud_mkinvalid             | Invalidates a present PUD; do not call for       |
>> +|                           | non-present PUD [1]                              |
>>  +---------------------------+--------------------------------------------------+
>>  | pud_set_huge              | Creates a PUD huge mapping                       |
>>  +---------------------------+--------------------------------------------------+
> 
> LGTM but guess this will conflict with your other patch for mm/debug_vm_pgtable.c
> if you choose to update pud_mkinvalid() description for pmd_leaf().
> 
> https://lore.kernel.org/all/20240501144439.1389048-1-ryan.roberts@arm.com/

Indeed, a reason to avoid adding docs to that patch :)

> 
>> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
>> index 83823db3488b..2975ea0841ba 100644
>> --- a/arch/powerpc/mm/book3s64/pgtable.c
>> +++ b/arch/powerpc/mm/book3s64/pgtable.c
>> @@ -170,6 +170,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>>  {
>>  	unsigned long old_pmd;
>>
>> +	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
>>  	old_pmd = pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, _PAGE_INVALID);
>>  	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>>  	return __pmd(old_pmd);
>> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
>> index 60950e7a25f5..480bea44559d 100644
>> --- a/arch/s390/include/asm/pgtable.h
>> +++ b/arch/s390/include/asm/pgtable.h
>> @@ -1768,8 +1768,10 @@ static inline pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma,
>>  static inline pmd_t pmdp_invalidate(struct vm_area_struct *vma,
>>  				   unsigned long addr, pmd_t *pmdp)
>>  {
>> -	pmd_t pmd = __pmd(pmd_val(*pmdp) | _SEGMENT_ENTRY_INVALID);
>> +	pmd_t pmd;
>>
>> +	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
>> +	pmd = __pmd(pmd_val(*pmdp) | _SEGMENT_ENTRY_INVALID);
>>  	return pmdp_xchg_direct(vma->vm_mm, addr, pmdp, pmd);
>>  }
>>
>> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
>> index b44d79d778c7..ef69127d7e5e 100644
>> --- a/arch/sparc/mm/tlb.c
>> +++ b/arch/sparc/mm/tlb.c
>> @@ -249,6 +249,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>>  {
>>  	pmd_t old, entry;
>>
>> +	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
>>  	entry = __pmd(pmd_val(*pmdp) & ~_PAGE_VALID);
>>  	old = pmdp_establish(vma, address, pmdp, entry);
>>  	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> index d007591b8059..103cbccf1d7d 100644
>> --- a/arch/x86/mm/pgtable.c
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -631,6 +631,8 @@ int pmdp_clear_flush_young(struct vm_area_struct *vma,
>>  pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
>>  			 pmd_t *pmdp)
>>  {
>> +	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
>> +
>>  	/*
>>  	 * No flush is necessary. Once an invalid PTE is established, the PTE's
>>  	 * access and dirty bits cannot be updated.
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 89f58c7603b2..dd1fc105f70b 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2493,32 +2493,11 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>  		return __split_huge_zero_page_pmd(vma, haddr, pmd);
>>  	}
>>
>> -	/*
>> -	 * Up to this point the pmd is present and huge and userland has the
>> -	 * whole access to the hugepage during the split (which happens in
>> -	 * place). If we overwrite the pmd with the not-huge version pointing
>> -	 * to the pte here (which of course we could if all CPUs were bug
>> -	 * free), userland could trigger a small page size TLB miss on the
>> -	 * small sized TLB while the hugepage TLB entry is still established in
>> -	 * the huge TLB. Some CPU doesn't like that.
>> -	 * See http://support.amd.com/TechDocs/41322_10h_Rev_Gd.pdf, Erratum
>> -	 * 383 on page 105. Intel should be safe but is also warns that it's
>> -	 * only safe if the permission and cache attributes of the two entries
>> -	 * loaded in the two TLB is identical (which should be the case here).
>> -	 * But it is generally safer to never allow small and huge TLB entries
>> -	 * for the same virtual address to be loaded simultaneously. So instead
>> -	 * of doing "pmd_populate(); flush_pmd_tlb_range();" we first mark the
>> -	 * current pmd notpresent (atomically because here the pmd_trans_huge
>> -	 * must remain set at all times on the pmd until the split is complete
>> -	 * for this pmd), then we flush the SMP TLB and finally we write the
>> -	 * non-huge version of the pmd entry with pmd_populate.
>> -	 */
>> -	old_pmd = pmdp_invalidate(vma, haddr, pmd);
>> -
>> -	pmd_migration = is_pmd_migration_entry(old_pmd);
>> +	pmd_migration = is_pmd_migration_entry(*pmd);
>>  	if (unlikely(pmd_migration)) {
>>  		swp_entry_t entry;
>>
>> +		old_pmd = *pmd;
>>  		entry = pmd_to_swp_entry(old_pmd);
>>  		page = pfn_swap_entry_to_page(entry);
>>  		write = is_writable_migration_entry(entry);
>> @@ -2529,6 +2508,30 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>  		soft_dirty = pmd_swp_soft_dirty(old_pmd);
>>  		uffd_wp = pmd_swp_uffd_wp(old_pmd);
>>  	} else {
>> +		/*
>> +		 * Up to this point the pmd is present and huge and userland has
>> +		 * the whole access to the hugepage during the split (which
>> +		 * happens in place). If we overwrite the pmd with the not-huge
>> +		 * version pointing to the pte here (which of course we could if
>> +		 * all CPUs were bug free), userland could trigger a small page
>> +		 * size TLB miss on the small sized TLB while the hugepage TLB
>> +		 * entry is still established in the huge TLB. Some CPU doesn't
>> +		 * like that. See
>> +		 * http://support.amd.com/TechDocs/41322_10h_Rev_Gd.pdf, Erratum
>> +		 * 383 on page 105. Intel should be safe but is also warns that
>> +		 * it's only safe if the permission and cache attributes of the
>> +		 * two entries loaded in the two TLB is identical (which should
>> +		 * be the case here). But it is generally safer to never allow
>> +		 * small and huge TLB entries for the same virtual address to be
>> +		 * loaded simultaneously. So instead of doing "pmd_populate();
>> +		 * flush_pmd_tlb_range();" we first mark the current pmd
>> +		 * notpresent (atomically because here the pmd_trans_huge must
>> +		 * remain set at all times on the pmd until the split is
>> +		 * complete for this pmd), then we flush the SMP TLB and finally
>> +		 * we write the non-huge version of the pmd entry with
>> +		 * pmd_populate.
>> +		 */
>> +		old_pmd = pmdp_invalidate(vma, haddr, pmd);
>>  		page = pmd_page(old_pmd);
>>  		folio = page_folio(page);
>>  		if (pmd_dirty(old_pmd)) {
>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>> index 4fcd959dcc4d..a78a4adf711a 100644
>> --- a/mm/pgtable-generic.c
>> +++ b/mm/pgtable-generic.c
>> @@ -198,6 +198,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
>>  pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>>  		     pmd_t *pmdp)
>>  {
>> +	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
>>  	pmd_t old = pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp));
>>  	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>>  	return old;
>> @@ -208,6 +209,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>>  pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
>>  			 pmd_t *pmdp)
>>  {
>> +	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
>>  	return pmdp_invalidate(vma, address, pmdp);
>>  }
>>  #endif
> 
> Rest LGTM but let's wait for this to run on multiple platforms.
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks!


