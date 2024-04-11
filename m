Return-Path: <linux-kernel+bounces-140196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB03B8A0CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F59E283E30
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4CD145338;
	Thu, 11 Apr 2024 09:45:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB6E13E405
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828744; cv=none; b=E/8eIkqv6xJ8JZQMiJPZcI6B8Fezx0rr7u2Ys+H8moJnfKdJEquz2JZ+MCtkQ8DB5ND/AZyIRxAWwSOZeIOg7rCxhrQRSVKITtwRRCRxi/vUIyz5Jc1pglEnSgLdFj1ltJd9PM0MEOIWzSEce0pklx0TBIxOlsaJx/1feIcHHkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828744; c=relaxed/simple;
	bh=Bi/fJqFvGRxtWWjvwqkhfk1lGaMlLX8qDKfFGy9HJxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FezMACkZi6I1qDht8r3tL7SXViSko1T5R5/jXf0TspIABdqjd/bAkJ4mw71j/9K6JVj6eQj77B/SDm2JYlcnYCY//PsWJdDjieRvOj1KeiXvtr3ePZnGrb2ie4OPltQglgI0MfIgS6gP96rjP463G38lnBQmCpIkkMtlbP9AFcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AB9E113E;
	Thu, 11 Apr 2024 02:46:11 -0700 (PDT)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AF703F6C4;
	Thu, 11 Apr 2024 02:45:40 -0700 (PDT)
Message-ID: <81aa23ca-18b1-4430-9ad1-00a2c5af8fc2@arm.com>
Date: Thu, 11 Apr 2024 10:45:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] Reduce cost of ptep_get_lockless on arm64
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Mark Rutland
 <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240215121756.2734131-1-ryan.roberts@arm.com>
 <0ae22147-e1a1-4bcb-8a4c-f900f3f8c39e@redhat.com>
 <d8b3bcf2-495f-42bd-b114-6e3a010644d8@arm.com>
 <de143212-49ce-4c30-8bfa-4c0ff613f107@redhat.com>
 <374d8500-4625-4bff-a934-77b5f34cf2ec@arm.com>
 <c1218cdb-905b-4896-8e17-109700577cec@redhat.com>
 <a41b0534-b841-42c2-8c06-41337c35347d@arm.com>
 <8bd9e136-8575-4c40-bae2-9b015d823916@redhat.com>
 <86680856-2532-495b-951a-ea7b2b93872f@arm.com>
 <35236bbf-3d9a-40e9-84b5-e10e10295c0c@redhat.com>
 <dbc5083b-bf8c-4869-8dc7-5fbf2c88cce8@arm.com>
 <f2aad459-e19c-45e2-a7ab-35383e8c3ba5@redhat.com>
 <4fba71aa-8a63-4a27-8eaf-92a69b2cff0d@arm.com>
 <5a23518b-7974-4b03-bd6e-80ecf6c39484@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <5a23518b-7974-4b03-bd6e-80ecf6c39484@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/04/2024 21:09, David Hildenbrand wrote:
> [...]
> 
> Skipping the ptdesc stuff we discussed offline, to not get distracted. :)
> 
> This stuff is killing me, sorry for the lengthy reply ...

No problem - thanks for taking the time to think it through and reply with such
clarity. :)

> 
>>
>> So I've been looking at all this again, and getting myself even more confused.
>>
>> I believe there are 2 classes of ptep_get_lockless() caller:
>>
>> 1) vmf->orig_pte = ptep_get_lockless(vmf->pte); in handle_pte_fault()
>> 2) everyone else
> 
> Likely only completely lockless page table walkers where we *cannot* recheck
> under PTL is special. Essentially where we disable interrupts and rely on TLB
> flushes to sync against concurrent changes.

Yes agreed - 2 types; "lockless walkers that later recheck under PTL" and
"lockless walkers that never take the PTL".

Detail: the part about disabling interrupts and TLB flush syncing is
arch-specifc. That's not how arm64 does it (the hw broadcasts the TLBIs). But
you make that clear further down.

> 
> Let's take a look where ptep_get_lockless() comes from:
> 
> commit 2a4a06da8a4b93dd189171eed7a99fffd38f42f3
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Fri Nov 13 11:41:40 2020 +0100
> 
>     mm/gup: Provide gup_get_pte() more generic
> 
>     In order to write another lockless page-table walker, we need
>     gup_get_pte() exposed. While doing that, rename it to
>     ptep_get_lockless() to match the existing ptep_get() naming.
> 
> 
> GUP-fast, when we were still relying on TLB flushes to sync against GUP-fast.
> 
> "With get_user_pages_fast(), we walk down the pagetables without taking any
> locks.  For this we would like to load the pointers atomically, but sometimes
> that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What we
> do have is the guarantee that a PTE will only either go from not present to
> present, or present to not present or both -- it will not switch to a completely
> different present page without a TLB flush in between; something hat we are
> blocking by holding interrupts off."
> 
> Later, we added support for GUP-fast that introduced the !TLB variant:
> 
> commit 2667f50e8b81457fcb4a3dbe6aff3e81ea009e13
> Author: Steve Capper <steve.capper@linaro.org>
> Date:   Thu Oct 9 15:29:14 2014 -0700
> 
>     mm: introduce a general RCU get_user_pages_fast()
> 
> With the pattern
> 
> /*
>  * In the line below we are assuming that the pte can be read
>  * atomically. If this is not the case for your architecture,
>  * please wrap this in a helper function!
>  *
>  * for an example see gup_get_pte in arch/x86/mm/gup.c
>  */
> pte_t pte = ACCESS_ONCE(*ptep);
> ...
> if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> ...
> 
> 
> Whereby the mentioned arch/x86/mm/gup.c code did a straight pte_t pte =
> gup_get_pte(ptep) without any re-reading of PTEs. The PTE that was read was
> required to be sane, this the lengthy comment above ptep_get_lockless() that
> talks about TLB flushes.
> 
> The comment above ptep_get_lockless() for CONFIG_GUP_GET_PXX_LOW_HIGH is still
> full of details about TLB flushes syncing against GUP-fast. But as you note, we
> use it even in contexts where we don't disable interrupts and the TLB flush
> can't help.
> 
> We don't disable interrupts during page faults ... so most of the things
> described in ptep_get_lockless() don't really apply.
> 
> That's also the reason why ...
>>
>>                  vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
>> -               vmf->orig_pte = *vmf->pte;
>> +               vmf->orig_pte = ptep_get_lockless(vmf->pte);
>>                  vmf->flags |= FAULT_FLAG_ORIG_PTE_VALID;
>>
>> -               /*
>> -                * some architectures can have larger ptes than wordsize,
>> -                * e.g.ppc44x-defconfig has CONFIG_PTE_64BIT=y and
>> -                * CONFIG_32BIT=y, so READ_ONCE cannot guarantee atomic
>> -                * accesses.  The code below just needs a consistent view
>> -                * for the ifs and we later double check anyway with the
>> -                * ptl lock held. So here a barrier will do.
>> -                */
>> -               barrier();
>>                  if (pte_none(vmf->orig_pte)) {
> 
> ... that code was in place. We would possibly read garbage PTEs, but would
> recheck *under PTL* (where the PTE can no longer change) that what we read
> wasn't garbage and didn't change.

Agreed.

> 
>>
>> -- 
>>
>> (2) All the other users require that a subset of the pte fields are
>> self-consistent; specifically they don't care about access, dirty, uffd-wp or
>> soft-dirty. arm64 can guarrantee that all the other bits are self-consistent
>> just by calling ptep_get().
> 
> Let's focus on access+dirty for now ;)
> 
>>
>> -- 
>>
>> So, I'm making the bold claim that it was never neccessary to specialize
>> pte_get_lockless() on arm64, and I *think* we could just delete it so that
>> ptep_get_lockless() resolves to ptep_get() on arm64. That solves the original
>> aim without needing to introduce "norecency" variants.
>>
>> Additionally I propose documenting ptep_get_lockless() to describe the set of
>> fields that are guarranteed to be self-consistent and the remaining fields which
>> are self-consistent only with best-effort.
>>
>> Could it be this easy? My head is hurting...
> 
> I think what has to happen is:
> 
> (1) pte_get_lockless() must return the same value as ptep_get() as long as there
> are no races. No removal/addition of access/dirty bits etc.

Today's arm64 ptep_get() guarantees this.

> 
> (2) Lockless page table walkers that later verify under the PTL can handle
> serious "garbage PTEs". This is our page fault handler.

This isn't really a property of a ptep_get_lockless(); its a statement about a
class of users. I agree with the statement.

> 
> (3) Lockless page table walkers that cannot verify under PTL cannot handle
> arbitrary garbage PTEs. This is GUP-fast. Two options:
> 
> (3a) pte_get_lockless() can atomically read the PTE: We re-check later if the
> atomically-read PTE is still unchanged (without PTL). No IPI for TLB flushes
> required. This is the common case. HW might concurrently set access/dirty bits,
> so we can race with that. But we don't read garbage.

Today's arm64 ptep_get() cannot garantee that the access/dirty bits are
consistent for contpte ptes. That's the bit that complicates the current
ptep_get_lockless() implementation.

But the point I was trying to make is that GUP-fast does not actually care about
*all* the fields being consistent (e.g. access/dirty). So we could spec
pte_get_lockless() to say that "all fields in the returned pte are guarranteed
to be self-consistent except for access and dirty information, which may be
inconsistent if a racing modification occured".

This could mean that the access/dirty state *does* change for a given page while
GUP-fast is walking it, but GUP-fast *doesn't* detect that change. I *think*
that failing to detect this is benign.

Aside: GUP-fast currently rechecks the pte originally obtained with
ptep_get_lockless(), using ptep_get(). Is that correct? ptep_get() must conform
to (1), so either it returns the same pte or it returns a different pte or
garbage. But that garbage could just happen to be the same as the originally
obtained pte. So in that case, it would have a false match. I think this needs
to be changed to ptep_get_lockless()?

> 
> (3b) pte_get_lockless() cannot atomically read the PTE: We need special magic to
> read somewhat-sane PTEs and need IPIs during TLB flushes to sync against serious
> PTE changes (e.g., present -> present). This is weird x86-PAE.
> 
> 
> If ptep_get() on arm64 can do (1), (2) and (3a), we might be good.
> 
> My head is hurting ...
> 


