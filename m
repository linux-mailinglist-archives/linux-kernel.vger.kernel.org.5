Return-Path: <linux-kernel+bounces-156897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FEA8B0A08
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A60A1C21513
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8AE15ADA6;
	Wed, 24 Apr 2024 12:51:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15961142E70
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963066; cv=none; b=q2nQjrUxNN3LyAFhysFQ8zuxsyFs1Gsw1hjGHceWfhug45px0Utbq3xDK+TQBYMGHTqqJLW7C58NFGhfHC/Brdulgsr6KSt8DWMYNEUXTZmTAhiVC7CD8XqbrhjDj8cnDp22Lozm5dYps7FCSu9j3l1znFxTH2R2mcQiTaFzGJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963066; c=relaxed/simple;
	bh=NOwW3MgYsf5xxcX3LQ1KN0/iiQwL52NsEkwLHO90zLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UeImaoZP8wb8Y2sKcUJGPtbc+PB/+kZuVVPHVv+/mqC1ki4Q5YFfhWNMHAPJV6qYqbFbMsPu3PV1JGFdJZ1O9MBcWxX/RZ+c2LuCOFiaMOLYRj+lFUKoPwdT3ZTcQBXPG6t70+FXetdnKo7euNvfXghnfFkRhEEQLTeOHVVp12E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A95A1516;
	Wed, 24 Apr 2024 05:51:32 -0700 (PDT)
Received: from [10.1.25.156] (XHFQ2J9959.cambridge.arm.com [10.1.25.156])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C951A3F64C;
	Wed, 24 Apr 2024 05:51:02 -0700 (PDT)
Message-ID: <6d8392e5-7f12-43e5-9631-d1fdc4bf1025@arm.com>
Date: Wed, 24 Apr 2024 13:51:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] arm64/mm: Add uffd write-protect support
Content-Language: en-GB
To: Peter Xu <peterx@redhat.com>
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

Ahh nice! In that case, I'm going to convert this to a macro, which is the arm64
style for these getters (for some reason...):

#define pte_uffd_wp(pte_t pte) (!!(pte_val(pte) & PTE_UFFD_WP))

Will send out a v2 once others have had time to comment.


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

Thanks!

> 
> Thanks,
> 


