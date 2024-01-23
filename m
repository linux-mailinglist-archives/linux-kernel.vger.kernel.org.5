Return-Path: <linux-kernel+bounces-35246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D7A838E85
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851731F251E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99CD5EE60;
	Tue, 23 Jan 2024 12:28:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395035DF00;
	Tue, 23 Jan 2024 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012913; cv=none; b=oROpqbZ6X1L24CEYgKnfGYp5TM03EBy/TvdJH1+fX+8ZAJQA8vXqxlQI7cVvEjkrAE38FQxQTGwnGK51Pcls4GdBeiEqwRVhi3CAhkGRixg7+w6KL5jDF0Yu2mE+ueeTtBw+LfVqk3ZQqCnRA7qGdxDOYvqTGEB+aF20HGua2b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012913; c=relaxed/simple;
	bh=U1Wm9oAyEK9SoZyY9g3iPj8Ybyi1tRDJeV2UVkh7Wvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4+yHgJ9xwtqFBQ1i1v6YgZhuTSlfMAoo0qWkgbLuaqWjQt44lvhwX6CPdunqmAbiZ6cqlfEZ42+zhU7nr2fpFPPhs/D1eBiNA6mMfGyM19X4IA4TWAJJ/qkJA7Hs45j0MIwxBr2z84A2u7iykEdm4HLclY4hn/Ifzmd4T2tkT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B0011FB;
	Tue, 23 Jan 2024 04:29:15 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6882C3F762;
	Tue, 23 Jan 2024 04:28:26 -0800 (PST)
Message-ID: <40112a27-eddb-4c1a-a859-a34e202e6564@arm.com>
Date: Tue, 23 Jan 2024 12:28:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/11] mm/memory: optimize fork() with PTE-mapped THP
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
 <20240122194200.381241-10-david@redhat.com>
 <63be0c3c-bf34-4cbb-b47b-7c9be0e65058@arm.com>
 <31a0661e-fa69-419c-9936-98bfe168d5a7@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <31a0661e-fa69-419c-9936-98bfe168d5a7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/01/2024 12:19, David Hildenbrand wrote:
> [...]
> 
>>
>> I wrote some documentation for this (based on Matthew's docs for set_ptes() in
>> my version. Perhaps it makes sense to add it here, given this is overridable by
>> the arch.
>>
>> /**
>>   * wrprotect_ptes - Write protect a consecutive set of pages.
>>   * @mm: Address space that the pages are mapped into.
>>   * @addr: Address of first page to write protect.
>>   * @ptep: Page table pointer for the first entry.
>>   * @nr: Number of pages to write protect.
>>   *
>>   * May be overridden by the architecture, else implemented as a loop over
>>   * ptep_set_wrprotect().
>>   *
>>   * Context: The caller holds the page table lock. The PTEs are all in the same
>>   * PMD.
>>   */
>>
> 
> I could have sworn I had a documentation at some point. Let me add some, thanks.
> 
> [...]
> 
>>> +
>>> +    /*
>>> +     * If we likely have to copy, just don't bother with batching. Make
>>> +     * sure that the common "small folio" case stays as fast as possible
>>> +     * by keeping the batching logic separate.
>>> +     */
>>> +    if (unlikely(!*prealloc && folio_test_large(folio) && max_nr != 1)) {
>>> +        nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr);
>>> +        if (folio_test_anon(folio)) {
>>> +            folio_ref_add(folio, nr);
>>> +            if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page,
>>> +                                  nr, src_vma))) {
>>
>> What happens if its not the first page of the batch that fails here? Aren't you
>> signalling that you need a prealloc'ed page for the wrong pte? Shouldn't you
>> still batch copy all the way up to the failing page first? Perhaps it all comes
>> out in the wash and these events are so infrequent that we don't care about the
>> lost batching opportunity?
> 
> I assume you mean the weird corner case that some folio pages in the range have
> PAE set, others don't -- and the folio maybe pinned.
> 
> In that case, we fallback to individual pages, and might have preallocated a
> page although we wouldn't have to preallocate one for processing the next page
> (that doesn't have PAE set).
> 
> It should all work, although not optimized to the extreme, and as it's a corner
> case, we don't particularly care. Hopefully, in the future we'll only have a
> single PAE flag per folio.
> 
> Or am I missing something?

No, your explanation makes sense. Just wanted to check this all definitely
worked, because the flow is slightly different to my previous version that was
doing try_dup_rmap page-by-page.

> 
>>
>>> +                folio_ref_sub(folio, nr);
>>> +                return -EAGAIN;
>>> +            }
>>> +            rss[MM_ANONPAGES] += nr;
>>> +            VM_WARN_ON_FOLIO(PageAnonExclusive(page), folio);
>>> +        } else {
>>> +            folio_ref_add(folio, nr);
>>
>> Perhaps hoist this out to immediately after folio_pte_batch() since you're
>> calling it on both branches?
> 
> Makes sense, thanks.
> 


