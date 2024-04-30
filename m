Return-Path: <linux-kernel+bounces-163938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B478B7655
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79F2B23189
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3106317106E;
	Tue, 30 Apr 2024 12:53:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50577171099
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481617; cv=none; b=WeDewyNNArdLyrW6DgJxpypmpF0g2htxHOIs2dAKNaYqk+292zuNSEtXcMfbSVxYWUu/SJGpyEv6tR/FQMTEM6lVLghKUoe1MNYnw3WYhE5ssuQGeSZSvlJJxBFf+m4dVU6h/RGEZ7nFSVlmkF4qSmNH1Z9ILFyqhzt0WZMCfdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481617; c=relaxed/simple;
	bh=KUAYMhvovsY69EuC837OWjSCKrwjtcfZZJDSNCJrkjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQasvdUxjd5m0KBgmDq6aD/2AZFtCLvTmN/1Ib4Kus9UjNYhkhaXwUFIj2oQjpj7rb/uc9tp/1pIvhFcDa3uBlNRjR/KfYf+CsVaTiZy2hzB08YNA2lXuTX3VAtQVT7kbvgkwj8NM5PMomuNMEZJQGDDQhJKaK0San2NZ+0lm2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD7CF2F4;
	Tue, 30 Apr 2024 05:54:01 -0700 (PDT)
Received: from [10.1.38.140] (XHFQ2J9959.cambridge.arm.com [10.1.38.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E44CF3F793;
	Tue, 30 Apr 2024 05:53:33 -0700 (PDT)
Message-ID: <e842963b-e682-4923-a1cc-c8b2abd6afee@arm.com>
Date: Tue, 30 Apr 2024 13:53:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64/mm: Refactor PMD_PRESENT_INVALID and
 PTE_PROT_NONE bits
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240429140208.238056-1-ryan.roberts@arm.com>
 <20240429140208.238056-2-ryan.roberts@arm.com> <Zi_IzrfIcqWxt7cE@arm.com>
 <839d6975-ce12-4fc9-aa3b-8ec5787bf577@arm.com> <ZjDR0EIjLr9F2dWn@arm.com>
 <29fd6909-73d2-4b7e-99ef-0101cde1ba8a@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <29fd6909-73d2-4b7e-99ef-0101cde1ba8a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/04/2024 12:37, David Hildenbrand wrote:
> On 30.04.24 13:11, Catalin Marinas wrote:
>> On Mon, Apr 29, 2024 at 06:15:45PM +0100, Ryan Roberts wrote:
>>> On 29/04/2024 17:20, Catalin Marinas wrote:
>>>> On Mon, Apr 29, 2024 at 03:02:05PM +0100, Ryan Roberts wrote:
>>>>> diff --git a/arch/arm64/include/asm/pgtable-prot.h
>>>>> b/arch/arm64/include/asm/pgtable-prot.h
>>>>> index dd9ee67d1d87..de62e6881154 100644
>>>>> --- a/arch/arm64/include/asm/pgtable-prot.h
>>>>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>>>>> @@ -18,14 +18,7 @@
>>>>>   #define PTE_DIRTY        (_AT(pteval_t, 1) << 55)
>>>>>   #define PTE_SPECIAL        (_AT(pteval_t, 1) << 56)
>>>>>   #define PTE_DEVMAP        (_AT(pteval_t, 1) << 57)
>>>>> -#define PTE_PROT_NONE        (_AT(pteval_t, 1) << 58) /* only when
>>>>> !PTE_VALID */
>>>>> -
>>>>> -/*
>>>>> - * This bit indicates that the entry is present i.e. pmd_page()
>>>>> - * still points to a valid huge page in memory even if the pmd
>>>>> - * has been invalidated.
>>>>> - */
>>>>> -#define PMD_PRESENT_INVALID    (_AT(pteval_t, 1) << 59) /* only when
>>>>> !PMD_SECT_VALID */
>>>>> +#define PTE_INVALID        (_AT(pteval_t, 1) << 59) /* only when
>>>>> !PTE_VALID */
>>>>
>>>> Nitpick - I prefer the PTE_PRESENT_INVALID name as it makes it clearer
>>>> it's a present pte. We already have PTE_VALID, calling it PTE_INVALID
>>>> looks like a negation only.
>>>
>>> Meh, for me the pte can only be valid or invalid if it is present. So it's
>>> implicit. And if you have PTE_PRESENT_INVALID you should also have
>>> PTE_PRESENT_VALID.
>>>
>>> We also have pte_mkinvalid(), which is core-mm-defined. In your scheme, surely
>>> it should be pte_mkpresent_invalid()?
>>>
>>> But you're the boss, I'll change this to PTE_PRESENT_INVALID. :-(
>>
>> TBH, I don't have a strong opinion but best to avoid the bikeshedding.
>> I'll leave the decision to you ;). It would match the pmd_mkinvalid()
>> core code. But if you drop 'present' make sure you add a comment above
>> that it's meant for present ptes.
> 
> FWIW, I was confused by
> 
> present = valid | invalid

OK fair enough.

> 
> Something like
> 
> present = present_valid | present_invalid

I don't want to change pte_valid() to pte_present_valid(); that would also be a
fair bit of churn.

I'll take Catalin's suggestion and make this PTE_PRESENT_INVALID and
pte_present_invalid(). And obviously leave pmd_mkinvalid() as it is.
(Conversation in the other thread has concluded that it's ok to invalidate a
non-present pmd afterall).

> 
> would be more obvious at least to me ;)
> 


