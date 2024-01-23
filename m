Return-Path: <linux-kernel+bounces-35395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9EF839056
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4B3286DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367765F54A;
	Tue, 23 Jan 2024 13:42:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997B25F542;
	Tue, 23 Jan 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017357; cv=none; b=jGBUy1xufhgc7//h6zETeWYq9PFsLrCASE1EFMNK8fvXz6+d6QE+OlmUg8+NiqtJQh2bGsoaLywttHmp2aQmPXgwjzMisp8x0zofBRBK5q+vP5GYU3erPFsx6yk/J+dHPjKAkjC9ivpNVB9oOFsKH0lY8FqL/RuSUvMhKcGV794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017357; c=relaxed/simple;
	bh=uUJ2HO+3UqHTTrvrYPI/QJXNZTXarf00MBuJxNlTReI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIE5RD/2XfE6wfD1em51zp9HV9D1+EnBEkx2ektx7dWcQb8hfDQd61iE/vQpFyxmz7ZfpgY0XhoCa4k9hrLu9TzOjioiX0d4TQNcc1eOx1Y+y6RbyAITLSaLh8rFr2BWbnhZzJfPIUCy6Vz8tIw7CUM+2yu+iQSH/xjnDAfGAic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D631FEC;
	Tue, 23 Jan 2024 05:43:20 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8BB63F762;
	Tue, 23 Jan 2024 05:42:30 -0800 (PST)
Message-ID: <94d33a07-c59a-4315-9c64-8b4d959ca1f4@arm.com>
Date: Tue, 23 Jan 2024 13:42:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/11] mm/memory: ignore dirty/accessed/soft-dirty bits
 in folio_pte_batch()
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
 <20240122194200.381241-11-david@redhat.com>
 <59592b50-fe89-4b32-8490-2e6c296f972f@arm.com>
 <76740e33-9b52-4e23-b407-8ae38bac15ec@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <76740e33-9b52-4e23-b407-8ae38bac15ec@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/01/2024 13:06, David Hildenbrand wrote:
> On 23.01.24 13:25, Ryan Roberts wrote:
>> On 22/01/2024 19:41, David Hildenbrand wrote:
>>> Let's ignore these bits: they are irrelevant for fork, and will likely
>>> be irrelevant for upcoming users such as page unmapping.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   mm/memory.c | 10 ++++++++--
>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index f563aec85b2a8..341b2be845b6e 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -953,24 +953,30 @@ static __always_inline void __copy_present_ptes(struct
>>> vm_area_struct *dst_vma,
>>>       set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
>>>   }
>>>   +static inline pte_t __pte_batch_clear_ignored(pte_t pte)
>>> +{
>>> +    return pte_clear_soft_dirty(pte_mkclean(pte_mkold(pte)));
>>> +}
>>> +
>>>   /*
>>>    * Detect a PTE batch: consecutive (present) PTEs that map consecutive
>>>    * pages of the same folio.
>>>    *
>>>    * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN.
>>
>> nit: last char should be a comma (,) not a full stop (.)
>>
>>> + * the accessed bit, dirty bit and soft-dirty bit.
>>>    */
>>>   static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>>>           pte_t *start_ptep, pte_t pte, int max_nr)
>>>   {
>>>       unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
>>>       const pte_t *end_ptep = start_ptep + max_nr;
>>> -    pte_t expected_pte = pte_next_pfn(pte);
>>> +    pte_t expected_pte = __pte_batch_clear_ignored(pte_next_pfn(pte));
>>>       pte_t *ptep = start_ptep + 1;
>>>         VM_WARN_ON_FOLIO(!pte_present(pte), folio);
>>>         while (ptep != end_ptep) {
>>> -        pte = ptep_get(ptep);
>>> +        pte = __pte_batch_clear_ignored(ptep_get(ptep));
>>>             if (!pte_same(pte, expected_pte))
>>>               break;
>>
>> I think you'll lose dirty information in the child for private mappings? If the
>> first pte in a batch is clean, but a subsequent page is dirty, you will end up
>> setting all the pages in the batch as clean in the child. Previous behavior
>> would preserve dirty bit for private mappings.
>>
>> In my version (v3) that did arbitrary batching, I had some fun and games
>> tracking dirty, write and uffd_wp:
>> https://lore.kernel.org/linux-arm-kernel/20231204105440.61448-2-ryan.roberts@arm.com/
>>
>> Also, I think you will currently either set soft dirty on all or none of the
>> pages in the batch, depending on the value of the first. I previously convinced
>> myself that the state was unimportant so always cleared it in the child to
>> provide consistency.
> 
> Good points regarding dirty and soft-dirty. I wanted to avoid passing flags to
> folio_pte_batch(), but maybe that's just what we need to not change behavior.

I think you could not bother with the enforce_uffd_wp - just always enforce
uffd-wp. So that's one simplification vs mine. Then you just need an any_dirty
flag following the same pattern as your any_writable. Then just set dirty on the
whole batch in the child if any were dirty in the parent.

Although now I'm wondering if there is a race here... What happens if a page in
the parent becomes dirty after you have checked it but before you write protect
it? Isn't that already a problem with the current non-batched version? Why do we
even to preserve dirty in the child for private mappings?


