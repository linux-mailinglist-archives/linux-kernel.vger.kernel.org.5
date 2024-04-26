Return-Path: <linux-kernel+bounces-160040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F9A8B382B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E56A283098
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA0D146D5A;
	Fri, 26 Apr 2024 13:17:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E685813F436
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137468; cv=none; b=dDHzkpxbzZyfNHBnOpSFtergC+BfKKC46yHYnd8tVyhNO+pc+gcSv7lva7EbxHok63lGficxNEiiuQoHIQ1wTTSgpXnLXsi1opQFx1vS2Hdok3RV85mJDyUYjCQzhc70XNFW/xaMe+qfy6ZJCJ1qXUYKoxft2n8+1RPsg5moy4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137468; c=relaxed/simple;
	bh=XAujDe9U2zoAonjlvY4B+dkOrmfQa7ff40A99FvKMFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rGRdy9y43sz2zm3eTimPN2mJIJXFQvaa7LBr0+EtqsjwDV40O3QX8B5TrKrUb07cOfj6UZVqW+n/4e/s7gdpkt07sMqyXD0gFT4WOeE5LpWIO/L/FGll2X22pT9aBNjPBZI7zmtAoqhI699tW3bH03Ph4wD0vZr1Zif9c+6NWbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEA051007;
	Fri, 26 Apr 2024 06:18:12 -0700 (PDT)
Received: from [10.57.64.176] (unknown [10.57.64.176])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 116FC3F793;
	Fri, 26 Apr 2024 06:17:42 -0700 (PDT)
Message-ID: <e0fdf7b9-39d6-4eb3-b740-9c110b75182f@arm.com>
Date: Fri, 26 Apr 2024 14:17:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] arm64/mm: Add uffd write-protect support
Content-Language: en-GB
To: Peter Xu <peterx@redhat.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>,
 Shivansh Vij <shivanshvij@outlook.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240424111017.3160195-1-ryan.roberts@arm.com>
 <20240424111017.3160195-3-ryan.roberts@arm.com> <Zijzrje2FDXsSojP@x1n>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Zijzrje2FDXsSojP@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+ Muhammad Usama Anjum <usama.anjum@collabora.com>

Hi Peter, Muhammad,


On 24/04/2024 12:57, Peter Xu wrote:
> Hi, Ryan,
> 
> On Wed, Apr 24, 2024 at 12:10:17PM +0100, Ryan Roberts wrote:
>> Let's use the newly-free PTE SW bit (58) to add support for uffd-wp.
>>
>> The standard handlers are implemented for set/test/clear for both pte
>> and pmd. Additionally we must also track the uffd-wp state as a pte swp
>> bit, so use a free swap entry pte bit (3).
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> Looks all sane here from userfault perspective, just one comment below.
> 
>> ---
>>  arch/arm64/Kconfig                    |  1 +
>>  arch/arm64/include/asm/pgtable-prot.h |  8 ++++
>>  arch/arm64/include/asm/pgtable.h      | 55 +++++++++++++++++++++++++++
>>  3 files changed, 64 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 7b11c98b3e84..763e221f2169 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -255,6 +255,7 @@ config ARM64
>>  	select SYSCTL_EXCEPTION_TRACE
>>  	select THREAD_INFO_IN_TASK
>>  	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
>> +	select HAVE_ARCH_USERFAULTFD_WP if USERFAULTFD
>>  	select TRACE_IRQFLAGS_SUPPORT
>>  	select TRACE_IRQFLAGS_NMI_SUPPORT
>>  	select HAVE_SOFTIRQ_ON_OWN_STACK
>> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
>> index ef952d69fd04..f1e1f6306e03 100644
>> --- a/arch/arm64/include/asm/pgtable-prot.h
>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>> @@ -20,6 +20,14 @@
>>  #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
>>  #define PTE_PROT_NONE		(PTE_UXN)		 /* Reuse PTE_UXN; only when !PTE_VALID */
>>  
>> +#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>> +#define PTE_UFFD_WP		(_AT(pteval_t, 1) << 58) /* uffd-wp tracking */
>> +#define PTE_SWP_UFFD_WP		(_AT(pteval_t, 1) << 3)	 /* only for swp ptes */

I've just noticed code in task_mmu.c:

static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
				  unsigned long end, struct mm_walk *walk)
{
	...

	if (!p->arg.category_anyof_mask && !p->arg.category_inverted &&
	    p->arg.category_mask == PAGE_IS_WRITTEN &&
	    p->arg.return_mask == PAGE_IS_WRITTEN) {
		for (addr = start; addr < end; pte++, addr += PAGE_SIZE) {
			unsigned long next = addr + PAGE_SIZE;

			if (pte_uffd_wp(ptep_get(pte))) <<<<<<
				continue;

			...
		}
	}
}

As far as I can see, you don't know that the pte is present when you do this. So
does this imply that the UFFD-WP bit is expected to be in the same position for
both present ptes and swap ptes? I had assumed pte_uffd_wp() was for present
ptes and pte_swp_uffd_wp() was for swap ptes.

As you can see, the way I've implemented this for arm64 the bit is in a
different position for these 2 cases. I've just done a slightly different
implementation that changes the first patch in this series quite a bit and a
bunch of pagemap_ioctl mm kselftests are now failing. I think this is the root
cause, but haven't proven it definitively yet.

I'm inclined towords thinking the above is a bug and should be fixed so that I
can store the bit in different places. What do you think?

Thanks,
Ryan

>> +#else
>> +#define PTE_UFFD_WP		(_AT(pteval_t, 0))
>> +#define PTE_SWP_UFFD_WP		(_AT(pteval_t, 0))
>> +#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
>> +
>>  /*
>>   * This bit indicates that the entry is present i.e. pmd_page()
>>   * still points to a valid huge page in memory even if the pmd
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 23aabff4fa6f..3f4748741fdb 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -271,6 +271,34 @@ static inline pte_t pte_mkdevmap(pte_t pte)
>>  	return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
>>  }
>>  
>> +#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>> +static inline int pte_uffd_wp(pte_t pte)
>> +{
>> +	bool wp = !!(pte_val(pte) & PTE_UFFD_WP);
>> +
>> +#ifdef CONFIG_DEBUG_VM
>> +	/*
>> +	 * Having write bit for wr-protect-marked present ptes is fatal, because
>> +	 * it means the uffd-wp bit will be ignored and write will just go
>> +	 * through. See comment in x86 implementation.
>> +	 */
>> +	WARN_ON_ONCE(wp && pte_write(pte));
>> +#endif
> 
> Feel free to drop this line, see:
> 
> https://lore.kernel.org/r/20240417212549.2766883-1-peterx@redhat.com
> 
> It's still in mm-unstable only.
> 
> AFAICT ARM64 also is supported by check_page_table, I also checked ARM's
> ptep_modify_prot_commit() which uses set_pte_at(), so it should cover
> everything in a superior way already.
> 
> With that dropped, feel free to add:
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> 
> Thanks,
> 


