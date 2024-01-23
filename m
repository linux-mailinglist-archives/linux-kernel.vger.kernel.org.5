Return-Path: <linux-kernel+bounces-35206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FB0838D90
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9875BB20C31
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E225D8E9;
	Tue, 23 Jan 2024 11:38:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02EB5D73B;
	Tue, 23 Jan 2024 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706009919; cv=none; b=BuyzzhN/WL9qpoMW+5OEkeKqBCjfSkDqikeiD5kW30SL1Q/g9v1fSrxPz/zFJBT7E2bQ9qZ/Pw+5h1j3S7T1qPQaQ2w/rOYk7Hrw35ipLAftxost+ESf2GCKhaIJdChxyMChSuY9BIpYi2Dr2ZJkPR/YjIby6oJzebaU0WjffVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706009919; c=relaxed/simple;
	bh=u85z0+EkXSihYcPlh67W1ZAfDWr2Xo68u058sMn4H5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GztOfFG35oBsbNjEgWWeyawonJzw/46wXg8xRI4OStYN4xJUl2RB5UwBICmdJjca7hVq/33aV/Qmr2x2lEhZreRo0JWbpkQ0r1GvpMZbfa7qi9rq4Cq/jhhgQYVwkEIuDDtWwlr5l+1Fmy6siySbxNIB8pvF4aEu9XlN66Qk50E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 345D81FB;
	Tue, 23 Jan 2024 03:39:22 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A33F3F762;
	Tue, 23 Jan 2024 03:38:31 -0800 (PST)
Message-ID: <e0d9caab-39c7-446a-aeef-5d914d321c72@arm.com>
Date: Tue, 23 Jan 2024 11:38:30 +0000
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
To: David Hildenbrand <david@redhat.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
References: <20240122194200.381241-1-david@redhat.com>
 <20240122194200.381241-2-david@redhat.com>
 <fdaeb9a5-d890-499a-92c8-d171df43ad01@arm.com>
 <46080ac1-7789-499b-b7f3-0231d7bd6de7@redhat.com>
 <6703b648-10ab-4fea-b7f1-75421319465b@arm.com>
 <ae3d826f-758f-4738-b72a-e99f098bb2b3@csgroup.eu>
 <3a970289-a72f-418e-b43c-89f67f0d5283@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <3a970289-a72f-418e-b43c-89f67f0d5283@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/01/2024 11:31, David Hildenbrand wrote:
>>>
>>>> If high bits are used for
>>>> something else, then we might produce a garbage PTE on overflow, but that
>>>> shouldn't really matter I concluded for folio_pte_batch() purposes, we'd not
>>>> detect "belongs to this folio batch" either way.
>>>
>>> Exactly.
>>>
>>>>
>>>> Maybe it's likely cleaner to also have a custom pte_next_pfn() on ppc, I just
>>>> hope that we don't lose any other arbitrary PTE bits by doing the pte_pgprot().
>>>
>>> I don't see the need for ppc to implement pte_next_pfn().
>>
>> Agreed.
> 
> So likely we should then do on top for powerpc (whitespace damage):
> 
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index a04ae4449a025..549a440ed7f65 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -220,10 +220,7 @@ void set_ptes(struct mm_struct *mm, unsigned long addr,
> pte_t *ptep,
>                         break;
>                 ptep++;
>                 addr += PAGE_SIZE;
> -               /*
> -                * increment the pfn.
> -                */
> -               pte = pfn_pte(pte_pfn(pte) + 1, pte_pgprot((pte)));
> +               pte = pte_next_pfn(pte);
>         }
>  }

Looks like commit 47b8def9358c ("powerpc/mm: Avoid calling
arch_enter/leave_lazy_mmu() in set_ptes") changed from doing the simple
increment to this more complex approach, but the log doesn't say why.

>  
> 
> 


