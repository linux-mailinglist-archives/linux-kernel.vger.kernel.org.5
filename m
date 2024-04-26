Return-Path: <linux-kernel+bounces-159497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D958B2F66
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603271C211FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5906F8249F;
	Fri, 26 Apr 2024 04:20:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A182A1B8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 04:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714105202; cv=none; b=LYqYN6fZPArT2V5YLrrn2OkVcRc5rMTuCW7tbGon/KXdXaMVCnk5CxeMMWXWKKUjokAY9/KPPFyEU70oJQyf/KRu98MZNEXQIGlcRDydAGytg9gwMSIMcC2ID6c2+Wn2hPhluV3RMV/75tyKWGFLfJmiQbSk2vIsuS3Y9YSFmug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714105202; c=relaxed/simple;
	bh=KBYDDni2ds5f5iEZVUCZEFfFYg3cu4lWDGAJMTJ7cPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dj0ocKEaR1Qnu5iq/Hgow73TIz4D7TmhmieOW1eKTewoan4CPhD11/jYP1G23+nUv24jwKjFXabvuiP4YO6SqiZgE0bV4Ph8tM5Zqdy7xjU/b86XTIsUyf45lES8/RszKV71TnYl2eG4xnHH0KIvrZW8LvYww5JDagWn/i1ZwGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C14C11007;
	Thu, 25 Apr 2024 21:20:27 -0700 (PDT)
Received: from [10.163.32.46] (unknown [10.163.32.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67D2A3F64C;
	Thu, 25 Apr 2024 21:19:57 -0700 (PDT)
Message-ID: <39d0236c-4297-4001-bc7e-f516bc674f7b@arm.com>
Date: Fri, 26 Apr 2024 09:49:53 +0530
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
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240425170704.3379492-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/24 22:37, Ryan Roberts wrote:
> __split_huge_pmd_locked() can be called for a present THP, devmap or
> (non-present) migration entry. It calls pmdp_invalidate()
> unconditionally on the pmdp and only determines if it is present or not
> based on the returned old pmd. This is a problem for the migration entry
> case because pmd_mkinvalid(), called by pmdp_invalidate() must only be
> called for a present pmd.

pmdp_invalidate() must be called only for present PMD - is this expected
by core MM ? Does this cause any problem otherwise ?

> 
> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
> future call to pmd_present() will return true. And therefore any

IIRC the following semantics needs to be followed as expected by core MM.

-------------------------------------------------------------------------
|	PMD states	|	pmd_present	|	pmd_trans_huge	|
-------------------------------------------------------------------------
|	Mapped		|	Yes		|	Yes		|
-------------------------------------------------------------------------
|	Splitting	|	Yes		|	Yes		|
-------------------------------------------------------------------------
|	Migration/Swap	|	No		|	No		|
-------------------------------------------------------------------------


> lockless pgtable walker could see the migration entry pmd in this state
> and start interpretting the fields as if it were present, leading to
> BadThings (TM). GUP-fast appears to be one such lockless pgtable walker.

Could you please explain how bad things might happen ?
 
> I suspect the same is possible on other architectures.
> 
> Fix this by only calling pmdp_invalidate() for a present pmd. And for
> good measure let's add a warning to the generic implementation of
> pmdp_invalidate(). I've manually reviewed all other
> pmdp_invalidate[_ad]() call sites and believe all others to be
> conformant.
> 
> This is a theoretical bug found during code review. I don't have any
> test case to trigger it in practice.
> 
> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> Applies on top of v6.9-rc5. Passes all the mm selftests on arm64.
> 
> Thanks,
> Ryan
> 
> 
>  mm/huge_memory.c     | 5 +++--
>  mm/pgtable-generic.c | 2 ++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 89f58c7603b2..80939ad00718 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2513,12 +2513,12 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  	 * for this pmd), then we flush the SMP TLB and finally we write the
>  	 * non-huge version of the pmd entry with pmd_populate.
>  	 */
> -	old_pmd = pmdp_invalidate(vma, haddr, pmd);
> 
> -	pmd_migration = is_pmd_migration_entry(old_pmd);
> +	pmd_migration = is_pmd_migration_entry(*pmd);
>  	if (unlikely(pmd_migration)) {
>  		swp_entry_t entry;
> 
> +		old_pmd = *pmd;
>  		entry = pmd_to_swp_entry(old_pmd);
>  		page = pfn_swap_entry_to_page(entry);
>  		write = is_writable_migration_entry(entry);
> @@ -2529,6 +2529,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  		soft_dirty = pmd_swp_soft_dirty(old_pmd);
>  		uffd_wp = pmd_swp_uffd_wp(old_pmd);
>  	} else {
> +		old_pmd = pmdp_invalidate(vma, haddr, pmd);
>  		page = pmd_page(old_pmd);
>  		folio = page_folio(page);
>  		if (pmd_dirty(old_pmd)) {
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index 4fcd959dcc4d..74e34ea90656 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -198,6 +198,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
>  pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>  		     pmd_t *pmdp)
>  {
> +	VM_WARN_ON(!pmd_present(*pmdp));
>  	pmd_t old = pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp));
>  	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>  	return old;
> @@ -208,6 +209,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>  pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
>  			 pmd_t *pmdp)
>  {
> +	VM_WARN_ON(!pmd_present(*pmdp));
>  	return pmdp_invalidate(vma, address, pmdp);
>  }
>  #endif
> --
> 2.25.1
> 
> 

