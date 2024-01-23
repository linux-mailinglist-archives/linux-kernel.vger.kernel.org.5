Return-Path: <linux-kernel+bounces-35166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 748FC838D02
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4331F23DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC725F55A;
	Tue, 23 Jan 2024 11:08:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4535C915;
	Tue, 23 Jan 2024 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008126; cv=none; b=mlaH8dhPKPPirkPUJvjAN8meHQ/ViZ5ejQ4ANCEB6MEvd8X+FloZYe4JqdyNXVb0iO7aG9kEr97UQidCytzfo4HrmaT4OU8s8BSNFzxODrPzGfMoUzrKFwflZjzxEZSN1+xwl4Fj6ZPLqAOpvI/asHVYTcBExwiGweSKL9aAHtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008126; c=relaxed/simple;
	bh=IEDrR/qz7Pwhp6nM55h9cFxHdv2zsdeuJaKINfhH6jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7bsKclblzHV0zju/5Y3Z2Bq9LeCe2esfvH1bGCUB5s2ZY4m9oY1lsHDVgr5SbW3qkp2ScV6DkUhoffRShFeZ5mzlM6vlGLa55s/l+L/l2bjeY5fmACzdYjpIqZjEF0djjsk6nvvYAd7p9Ucylyhub2oWTC3bn+sdmcbgcYW37Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AADC1FB;
	Tue, 23 Jan 2024 03:09:26 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DDC23F762;
	Tue, 23 Jan 2024 03:08:35 -0800 (PST)
Message-ID: <6703b648-10ab-4fea-b7f1-75421319465b@arm.com>
Date: Tue, 23 Jan 2024 11:08:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/11] arm/pgtable: define PFN_PTE_SHIFT on arm and
 arm64
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
References: <20240122194200.381241-1-david@redhat.com>
 <20240122194200.381241-2-david@redhat.com>
 <fdaeb9a5-d890-499a-92c8-d171df43ad01@arm.com>
 <46080ac1-7789-499b-b7f3-0231d7bd6de7@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <46080ac1-7789-499b-b7f3-0231d7bd6de7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/01/2024 10:48, David Hildenbrand wrote:
> On 23.01.24 11:34, Ryan Roberts wrote:
>> On 22/01/2024 19:41, David Hildenbrand wrote:
>>> We want to make use of pte_next_pfn() outside of set_ptes(). Let's
>>> simpliy define PFN_PTE_SHIFT, required by pte_next_pfn().
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   arch/arm/include/asm/pgtable.h   | 2 ++
>>>   arch/arm64/include/asm/pgtable.h | 2 ++
>>>   2 files changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
>>> index d657b84b6bf70..be91e376df79e 100644
>>> --- a/arch/arm/include/asm/pgtable.h
>>> +++ b/arch/arm/include/asm/pgtable.h
>>> @@ -209,6 +209,8 @@ static inline void __sync_icache_dcache(pte_t pteval)
>>>   extern void __sync_icache_dcache(pte_t pteval);
>>>   #endif
>>>   +#define PFN_PTE_SHIFT        PAGE_SHIFT
>>> +
>>>   void set_ptes(struct mm_struct *mm, unsigned long addr,
>>>                 pte_t *ptep, pte_t pteval, unsigned int nr);
>>>   #define set_ptes set_ptes
>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>> index 79ce70fbb751c..d4b3bd96e3304 100644
>>> --- a/arch/arm64/include/asm/pgtable.h
>>> +++ b/arch/arm64/include/asm/pgtable.h
>>> @@ -341,6 +341,8 @@ static inline void __sync_cache_and_tags(pte_t pte,
>>> unsigned int nr_pages)
>>>           mte_sync_tags(pte, nr_pages);
>>>   }
>>>   +#define PFN_PTE_SHIFT        PAGE_SHIFT
>>
>> I think this is buggy. And so is the arm64 implementation of set_ptes(). It
>> works fine for 48-bit output address, but for 52-bit OAs, the high bits are not
>> kept contigously, so if you happen to be setting a mapping for which the
>> physical memory block straddles bit 48, this won't work.
> 
> Right, as soon as the PTE bits are not contiguous, this stops working, just like
> set_ptes() would, which I used as orientation.
> 
>>
>> Today, only the 64K base page config can support 52 bits, and for this,
>> OA[51:48] are stored in PTE[15:12]. But 52 bits for 4K and 16K base pages is
>> coming (hopefully v6.9) and in this case OA[51:50] are stored in PTE[9:8].
>> Fortunately we already have helpers in arm64 to abstract this.
>>
>> So I think arm64 will want to define its own pte_next_pfn():
>>
>> #define pte_next_pfn pte_next_pfn
>> static inline pte_t pte_next_pfn(pte_t pte)
>> {
>>     return pfn_pte(pte_pfn(pte) + 1, pte_pgprot(pte));
>> }
>>
>> I'll do a separate patch to fix the already broken arm64 set_ptes()
>> implementation.
> 
> Make sense.
> 
>>
>> I'm not sure if this type of problem might also apply to other arches?
> 
> I saw similar handling in the PPC implementation of set_ptes, but was not able
> to convince me that it is actually required there.
> 
> pte_pfn on ppc does:
> 
> static inline unsigned long pte_pfn(pte_t pte)
> {
>     return (pte_val(pte) & PTE_RPN_MASK) >> PTE_RPN_SHIFT;
> }
> 
> But that means that the PFNs *are* contiguous.

all the ppc pfn_pte() implementations also only shift the pfn, so I think ppc is
safe to just define PFN_PTE_SHIFT. Although 2 of the 3 implementations shift by
PTE_RPN_SHIFT and the other shifts by PAGE_SIZE, so you might want to define
PFN_PTE_SHIFT separately for all 3 configs?

> If high bits are used for
> something else, then we might produce a garbage PTE on overflow, but that
> shouldn't really matter I concluded for folio_pte_batch() purposes, we'd not
> detect "belongs to this folio batch" either way.

Exactly.

> 
> Maybe it's likely cleaner to also have a custom pte_next_pfn() on ppc, I just
> hope that we don't lose any other arbitrary PTE bits by doing the pte_pgprot().

I don't see the need for ppc to implement pte_next_pfn().

pte_pgprot() is not a "proper" arch interface (its only required by the core-mm
if the arch implements a certain Kconfig IIRC). For arm64, all bits that are not
pfn are pgprot, so there are no bits lost.

> 
> 
> I guess pte_pfn() implementations should tell us if anything special needs to
> happen.
> 


