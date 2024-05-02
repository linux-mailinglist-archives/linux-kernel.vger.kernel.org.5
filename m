Return-Path: <linux-kernel+bounces-166056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8108B9554
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE9428334E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A8522EE4;
	Thu,  2 May 2024 07:34:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC2711CBD;
	Thu,  2 May 2024 07:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714635241; cv=none; b=BaPVN7xi8NoXd7HKS5Hworj9aeENsr1LAyYJ12VKKxqSfeBxFspn9qCNSnZkW0rgYnx8AVqai3xI2matTfog/CEEf05aodCcc9toBzcdqRmR4Ea8enIbDwIFZUNWNUpm69vZHaJ7AFIHzOl9IgwBFEaR5fU+OsRyyQPPSa3UQXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714635241; c=relaxed/simple;
	bh=nzHjSpd8+W02xgf8ahrvOyl1Ep8nUr+vSRw6zY0Paag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thdh11N7J3uSfyyIO13BYV2iByocx7S2hGu6jrXB8XgJ5PdDEN3ookM1Hqxa+9vmt+ihUDZOTuQSZwOKRGbTwhzlOFkZl/fFLQ2XpIrtltsXj5Hm09rai9Vy3XZHTJim5fhXH+2eNGy0fIsAG4cb+fWPpfBWEZ4jcLKxhkuKesk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DDB52F4;
	Thu,  2 May 2024 00:34:22 -0700 (PDT)
Received: from [10.57.65.146] (unknown [10.57.65.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 388F43F71E;
	Thu,  2 May 2024 00:33:53 -0700 (PDT)
Message-ID: <2f95dac3-51cc-474d-8ef0-7af9dd09784b@arm.com>
Date: Thu, 2 May 2024 08:33:51 +0100
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
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
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
 Borislav Petkov <bp@alien8.de>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240501143310.1381675-1-ryan.roberts@arm.com>
 <4992C22D-D7B7-4B6F-8A50-E084163BEF42@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <4992C22D-D7B7-4B6F-8A50-E084163BEF42@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/05/2024 02:27, Zi Yan wrote:
> On 1 May 2024, at 10:33, Ryan Roberts wrote:
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
> 
> The changes in Documentation/mm and mm/* look good to me. Thanks.
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks!

> 
> I wonder if making Documentation/mm and mm/* changes in a separate patch
> would be better, since you will not need acks from arch maintainers and
> get the patch in quicker.

Yeah maybe - I considered that, but then decided I'm literally just adding a
debug warning to the arch code so it shouldn't be too controversial. Perhaps
wait a few days for acks and if nothing turns up then I'll re-post with it split?

> 
> 
> --
> Best Regards,
> Yan, Zi


