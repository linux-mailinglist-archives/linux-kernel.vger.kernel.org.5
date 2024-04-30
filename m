Return-Path: <linux-kernel+bounces-164093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 388FA8B78E5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57D5BB25A37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBD717F361;
	Tue, 30 Apr 2024 14:04:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE7C17BB1E;
	Tue, 30 Apr 2024 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485877; cv=none; b=b2Q15wkVl6YNK4mqoNrz60YiCbKHt+wDAV/Ptvk5jcPYy/oquoXxOlok0e72nb1uAXtu9ig6dMFVzzSKPVTEb9joyWwlHaBA+a2cPj38Cf2KG84RIZnKW21zrfapJz3mD3GgtkPoC09xFcFhVXv5X+oe1tHnMO/STE1er+3tOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485877; c=relaxed/simple;
	bh=hIs71bhG4+cflhzz5GMNftsXvNAdBV+yukiIRd9yUsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIwTAi8hapNAN7lSmrZibv/86csh8jEMaCM5gk7/bAxA0UnqnUTDgfHWuvSox86R/QyEOYyWp5zNeAhmKrIoZLGQuiY2XCMsIaOfCBAQzoZJ13fStFBEeTdMhre9Z3ocNSpyAU7I2ZoAEkNVxmCmvAlVOnVzaIAnqFQWp2kYh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 837FC2F4;
	Tue, 30 Apr 2024 07:05:01 -0700 (PDT)
Received: from [10.1.38.140] (XHFQ2J9959.cambridge.arm.com [10.1.38.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B13F13F793;
	Tue, 30 Apr 2024 07:04:33 -0700 (PDT)
Message-ID: <41a83b7a-17e0-469d-bec4-10ebfff4ef57@arm.com>
Date: Tue, 30 Apr 2024 15:04:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64/mm: pmd_mkinvalid() must handle swap pmds
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240430133138.732088-1-ryan.roberts@arm.com>
 <20240430135534.GA14069@willie-the-truck>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240430135534.GA14069@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/04/2024 14:55, Will Deacon wrote:
> On Tue, Apr 30, 2024 at 02:31:38PM +0100, Ryan Roberts wrote:
>> __split_huge_pmd_locked() can be called for a present THP, devmap or
>> (non-present) migration entry. It calls pmdp_invalidate()
>> unconditionally on the pmdp and only determines if it is present or not
>> based on the returned old pmd.
>>
>> But arm64's pmd_mkinvalid(), called by pmdp_invalidate(),
>> unconditionally sets the PMD_PRESENT_INVALID flag, which causes future
>> pmd_present() calls to return true - even for a swap pmd. Therefore any
>> lockless pgtable walker could see the migration entry pmd in this state
>> and start interpretting the fields (e.g. pmd_pfn()) as if it were
>> present, leading to BadThings (TM). GUP-fast appears to be one such
>> lockless pgtable walker.
>>
>> While the obvious fix is for core-mm to avoid such calls for non-present
>> pmds (pmdp_invalidate() will also issue TLBI which is not necessary for
>> this case either), all other arches that implement pmd_mkinvalid() do it
>> in such a way that it is robust to being called with a non-present pmd.
>> So it is simpler and safer to make arm64 robust too. This approach means
>> we can even add tests to debug_vm_pgtable.c to validate the required
>> behaviour.
>>
>> This is a theoretical bug found during code review. I don't have any
>> test case to trigger it in practice.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 53fa117bb33c ("arm64/mm: Enable THP migration")
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>
>> Hi all,
>>
>> v1 of this fix [1] took the approach of fixing core-mm to never call
>> pmdp_invalidate() on a non-present pmd. But Zi Yan highlighted that only arm64
>> suffers this problem; all other arches are robust. So his suggestion was to
>> instead make arm64 robust in the same way and add tests to validate it. Despite
>> my stated reservations in the context of the v1 discussion, having thought on it
>> for a bit, I now agree with Zi Yan. Hence this post.
>>
>> Andrew has v1 in mm-unstable at the moment, so probably the best thing to do is
>> remove it from there and have this go in through the arm64 tree? Assuming there
>> is agreement that this approach is right one.
>>
>> This applies on top of v6.9-rc5. Passes all the mm selftests on arm64.
>>
>> [1] https://lore.kernel.org/linux-mm/20240425170704.3379492-1-ryan.roberts@arm.com/
>>
>> Thanks,
>> Ryan
>>
>>
>>  arch/arm64/include/asm/pgtable.h | 12 +++++--
>>  mm/debug_vm_pgtable.c            | 61 ++++++++++++++++++++++++++++++++
>>  2 files changed, 71 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index afdd56d26ad7..7d580271a46d 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -511,8 +511,16 @@ static inline int pmd_trans_huge(pmd_t pmd)
>>
>>  static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>>  {
>> -	pmd = set_pmd_bit(pmd, __pgprot(PMD_PRESENT_INVALID));
>> -	pmd = clear_pmd_bit(pmd, __pgprot(PMD_SECT_VALID));
>> +	/*
>> +	 * If not valid then either we are already present-invalid or we are
>> +	 * not-present (i.e. none or swap entry). We must not convert
>> +	 * not-present to present-invalid. Unbelievably, the core-mm may call
>> +	 * pmd_mkinvalid() for a swap entry and all other arches can handle it.
>> +	 */
>> +	if (pmd_valid(pmd)) {
>> +		pmd = set_pmd_bit(pmd, __pgprot(PMD_PRESENT_INVALID));
>> +		pmd = clear_pmd_bit(pmd, __pgprot(PMD_SECT_VALID));
>> +	}
>>
>>  	return pmd;
>>  }
> 
> Acked-by: Will Deacon <will@kernel.org>

Thanks

> 
> But it might be worth splitting the tests from the fix to make backporting
> easier.

Yes good point. I'll leave this hanging for today to see if any more comments
come in, and will re-post tomorrow as 2 patches. I assume we need to go fast to
catch 6.9.

> 
> Catalin -- I assume you'll pick this up, but please shout if you want me
> to take it instead.
> 
> Will


