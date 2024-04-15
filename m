Return-Path: <linux-kernel+bounces-145439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36858A5627
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A449B1C226F9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF5A77F22;
	Mon, 15 Apr 2024 15:17:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343EA76046
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194266; cv=none; b=mtorRGHS4lCwcvfn+YnrQeVNEsg3maizXbDOk5AcAlPw9TKnA6FAuW+0kZi1mfDFbVg2mMHGkGnW4/KYuEwC2WKfD+yNIAUSgRCwjJrvq499bhJbTXwD+3iPwF8GvZtTvfTKcxIkMHQb2Iid9nJ4eg9Bp5IJNyFFfwO3LdJoIq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194266; c=relaxed/simple;
	bh=lt6bltUi1FQH0s5B2Su+HqqJig5/ZCXdMqLJP1FmwYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byWyGD8QONEAb/LsHb1lGumqOGKPaHqNg8whS9Dl/t2SdNx0C1nGUHtn6GyJ8ISLF++w3tLCgghMOvDwByXFFgpCHrqebSNIh0F8MaqXzp8pAMnEM4CJohQ9n47mvrmxr2gUim5nIIEOyHUvMI6cdIize+yAbves1Sekcg3Xv+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAF4E2F4;
	Mon, 15 Apr 2024 08:18:10 -0700 (PDT)
Received: from [10.57.75.121] (unknown [10.57.75.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 980233F64C;
	Mon, 15 Apr 2024 08:17:40 -0700 (PDT)
Message-ID: <89e04df9-6a2f-409c-ae7d-af1f91d0131e@arm.com>
Date: Mon, 15 Apr 2024 16:17:34 +0100
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
 <81aa23ca-18b1-4430-9ad1-00a2c5af8fc2@arm.com>
 <70a36403-aefd-4311-b612-84e602465689@redhat.com>
 <f13d1e4d-1eea-4379-b683-4d736ad99c2c@arm.com>
 <3e50030d-2289-4470-a727-a293baa21618@redhat.com>
 <772de69a-27fa-4d39-a75d-54600d767ad1@arm.com>
 <969dc6c3-2764-4a35-9fa6-7596832fb2a3@redhat.com>
 <e0b34a1f-ef2e-484e-8d56-4901101dbdbf@arm.com>
 <11b1c25b-3e20-4acf-9be5-57b508266c5b@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <11b1c25b-3e20-4acf-9be5-57b508266c5b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/04/2024 15:58, David Hildenbrand wrote:
> On 15.04.24 16:34, Ryan Roberts wrote:
>> On 15/04/2024 15:23, David Hildenbrand wrote:
>>> On 15.04.24 15:30, Ryan Roberts wrote:
>>>> On 15/04/2024 11:57, David Hildenbrand wrote:
>>>>> On 15.04.24 11:28, Ryan Roberts wrote:
>>>>>> On 12/04/2024 21:16, David Hildenbrand wrote:
>>>>>>>>
>>>>>>>> Yes agreed - 2 types; "lockless walkers that later recheck under PTL" and
>>>>>>>> "lockless walkers that never take the PTL".
>>>>>>>>
>>>>>>>> Detail: the part about disabling interrupts and TLB flush syncing is
>>>>>>>> arch-specifc. That's not how arm64 does it (the hw broadcasts the
>>>>>>>> TLBIs). But
>>>>>>>> you make that clear further down.
>>>>>>>
>>>>>>> Yes, but disabling interrupts is also required for RCU-freeing of page
>>>>>>> tables
>>>>>>> such that they can be walked safely. The TLB flush IPI is arch-specific and
>>>>>>> indeed to sync against PTE invalidation (before generic GUP-fast).
>>>>>>> [...]
>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Could it be this easy? My head is hurting...
>>>>>>>>>
>>>>>>>>> I think what has to happen is:
>>>>>>>>>
>>>>>>>>> (1) pte_get_lockless() must return the same value as ptep_get() as long as
>>>>>>>>> there
>>>>>>>>> are no races. No removal/addition of access/dirty bits etc.
>>>>>>>>
>>>>>>>> Today's arm64 ptep_get() guarantees this.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> (2) Lockless page table walkers that later verify under the PTL can handle
>>>>>>>>> serious "garbage PTEs". This is our page fault handler.
>>>>>>>>
>>>>>>>> This isn't really a property of a ptep_get_lockless(); its a statement
>>>>>>>> about a
>>>>>>>> class of users. I agree with the statement.
>>>>>>>
>>>>>>> Yes. That's a requirement for the user of ptep_get_lockless(), such as page
>>>>>>> fault handlers. Well, mostly "not GUP".
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> (3) Lockless page table walkers that cannot verify under PTL cannot handle
>>>>>>>>> arbitrary garbage PTEs. This is GUP-fast. Two options:
>>>>>>>>>
>>>>>>>>> (3a) pte_get_lockless() can atomically read the PTE: We re-check later if
>>>>>>>>> the
>>>>>>>>> atomically-read PTE is still unchanged (without PTL). No IPI for TLB
>>>>>>>>> flushes
>>>>>>>>> required. This is the common case. HW might concurrently set access/dirty
>>>>>>>>> bits,
>>>>>>>>> so we can race with that. But we don't read garbage.
>>>>>>>>
>>>>>>>> Today's arm64 ptep_get() cannot garantee that the access/dirty bits are
>>>>>>>> consistent for contpte ptes. That's the bit that complicates the current
>>>>>>>> ptep_get_lockless() implementation.
>>>>>>>>
>>>>>>>> But the point I was trying to make is that GUP-fast does not actually care
>>>>>>>> about
>>>>>>>> *all* the fields being consistent (e.g. access/dirty). So we could spec
>>>>>>>> pte_get_lockless() to say that "all fields in the returned pte are
>>>>>>>> guarranteed
>>>>>>>> to be self-consistent except for access and dirty information, which may be
>>>>>>>> inconsistent if a racing modification occured".
>>>>>>>
>>>>>>> We *might* have KVM in the future want to check that a PTE is dirty, such
>>>>>>> that
>>>>>>> we can only allow dirty PTEs to be writable in a secondary MMU. That's not
>>>>>>> there
>>>>>>> yet, but one thing I was discussing on the list recently. Burried in:
>>>>>>>
>>>>>>> https://lkml.kernel.org/r/20240320005024.3216282-1-seanjc@google.com
>>>>>>>
>>>>>>> We wouldn't care about racing modifications, as long as MMU notifiers will
>>>>>>> properly notify us when the PTE would lose its dirty bits.
>>>>>>>
>>>>>>> But getting false-positive dirty bits would be problematic.
>>>>>>>
>>>>>>>>
>>>>>>>> This could mean that the access/dirty state *does* change for a given page
>>>>>>>> while
>>>>>>>> GUP-fast is walking it, but GUP-fast *doesn't* detect that change. I
>>>>>>>> *think*
>>>>>>>> that failing to detect this is benign.
>>>>>>>
>>>>>>> I mean, HW could just set the dirty/access bit immediately after the
>>>>>>> check. So
>>>>>>> if HW concurrently sets the bit and we don't observe that change when we
>>>>>>> recheck, I think that would be perfectly fine.
>>>>>>
>>>>>> Yes indeed; that's my point - GUP-fast doesn't care about access/dirty (or
>>>>>> soft-dirty or uffd-wp).
>>>>>>
>>>>>> But if you don't want to change the ptep_get_lockless() spec to explicitly
>>>>>> allow
>>>>>> this (because you have the KVM use case where false-positive dirty is
>>>>>> problematic), then I think we are stuck with ptep_get_lockless() as
>>>>>> implemented
>>>>>> for arm64 today.
>>>>>
>>>>> At least regarding the dirty bit, we'd have to guarantee that if
>>>>> ptep_get_lockless() returns a false-positive dirty bit, that the PTE recheck
>>>>> would be able to catch that.
>>>>>
>>>>> Would that be possible?
>>>>
>>>> Hmm maybe. My head hurts. Let me try to work through some examples...
>>>>
>>>>
>>>> Let's imagine for this example, a contpte block is 4 PTEs. Lat's say PTEs 0, 1,
>>>> 2 and 3 initially contpte-map order-2 mTHP, FolioA. The dirty state is
>>>> stored in
>>>> PTE0 for the contpte block, and it is dirty.
>>>>
>>>> Now let's say there are 2 racing threads:
>>>>
>>>>     - ThreadA is doing a GUP-fast for PTE3
>>>>     - ThreadB is remapping order-0 FolioB at PTE0
>>>>
>>>> (ptep_get_lockless() below is actaully arm64's ptep_get() for the sake of the
>>>> example - today's arm64 ptep_get_lockless() can handle the below correctly).
>>>>
>>>> ThreadA                    ThreadB
>>>> =======                    =======
>>>>
>>>> gup_pte_range()
>>>>     pte1 = ptep_get_lockless(PTE3)
>>>>       READ_ONCE(PTE3)
>>>>                      mmap(PTE0)
>>>>                        clear_pte(PTE0)
>>>>                          unfold(PTE0 - PTE3)
>>>>                            WRITE_ONCE(PTE0, 0)
>>>>                            WRITE_ONCE(PTE1, 0)
>>>>                            WRITE_ONCE(PTE2, 0)
>>>>       READ_ONCE(PTE0) (for a/d) << CLEAN!!
>>>>       READ_ONCE(PTE1) (for a/d)
>>>>       READ_ONCE(PTE2) (for a/d)
>>>>       READ_ONCE(PTE3) (for a/d)
>>>>     <do speculative work with pte1 content>
>>>>     pte2 = ptep_get_lockless(PTE3)
>>>>       READ_ONCE(PTE3)
>>>>       READ_ONCE(PTE0) (for a/d)
>>>>       READ_ONCE(PTE1) (for a/d)
>>>>       READ_ONCE(PTE2) (for a/d)
>>>>       READ_ONCE(PTE3) (for a/d)
>>>>     true = pte_same(pte1, pte2)
>>>>                            WRITE_ONCE(PTE3, 0)
>>>>                            TLBI
>>>>                            WRITE_ONCE(PTE0, <orig & ~CONT>)
>>>>                            WRITE_ONCE(PTE1, <orig & ~CONT>)
>>>>                            WRITE_ONCE(PTE2, <orig & ~CONT>)
>>>>                            WRITE_ONCE(PTE3, <orig & ~CONT>)
>>>>                          WRITE_ONCE(PTE0, 0)
>>>>                        set_pte_at(PTE0, <new>)
>>>>
>>>> This example shows how a *false-negative* can be returned for the dirty state,
>>>> which isn't detected by the check.
>>>>
>>>> I've been unable to come up with an example where a *false-positive* can be
>>>> returned for dirty state without the second ptep_get_lockless() noticing. In
>>>> this second example, let's assume everything is the same execpt FolioA is
>>>> initially clean:
>>>>
>>>> ThreadA                    ThreadB
>>>> =======                    =======
>>>>
>>>> gup_pte_range()
>>>>     pte1 = ptep_get_lockless(PTE3)
>>>>       READ_ONCE(PTE3)
>>>>                      mmap(PTE0)
>>>>                        clear_pte(PTE0)
>>>>                          unfold(PTE0 - PTE3)
>>>>                            WRITE_ONCE(PTE0, 0)
>>>>                            WRITE_ONCE(PTE1, 0)
>>>>                            WRITE_ONCE(PTE2, 0)
>>>>                            WRITE_ONCE(PTE3, 0)
>>>>                            TLBI
>>>>                            WRITE_ONCE(PTE0, <orig & ~CONT>)
>>>>                            WRITE_ONCE(PTE1, <orig & ~CONT>)
>>>>                            WRITE_ONCE(PTE2, <orig & ~CONT>)
>>>>                            WRITE_ONCE(PTE3, <orig & ~CONT>)
>>>>                          WRITE_ONCE(PTE0, 0)
>>>>                        set_pte_at(PTE0, <new>)
>>>>                      write to FolioB - HW sets PTE0's dirty
>>>>       READ_ONCE(PTE0) (for a/d) << DIRTY!!
>>>>       READ_ONCE(PTE1) (for a/d)
>>>>       READ_ONCE(PTE2) (for a/d)
>>>>       READ_ONCE(PTE3) (for a/d)
>>>>     <do speculative work with pte1 content>
>>>>     pte2 = ptep_get_lockless(PTE3)
>>>>       READ_ONCE(PTE3)           << BUT THIS IS FOR FolioB
>>>>       READ_ONCE(PTE0) (for a/d)
>>>>       READ_ONCE(PTE1) (for a/d)
>>>>       READ_ONCE(PTE2) (for a/d)
>>>>       READ_ONCE(PTE3) (for a/d)
>>>>     false = pte_same(pte1, pte2) << So this fails
>>>>
>>>> The only way I can see false-positive not being caught in the second example is
>>>> if ThreadB subseuently remaps the original folio, so you have an ABA scenario.
>>>> But these lockless table walkers are already suseptible to that.
>>>>
>>>> I think all the same arguments can be extended to the access bit.
>>>>
>>>>
>>>> For me this is all getting rather subtle and difficult to reason about and even
>>>> harder to spec in a comprehensible way. The best I could come up with is:
>>>>
>>>> "All fields in the returned pte are guarranteed to be self-consistent except
>>>> for
>>>> access and dirty information, which may be inconsistent if a racing
>>>> modification
>>>> occured. Additionally it is guranteed that false-positive access and/or dirty
>>>> information is not possible if 2 calls are made and both ptes are the same.
>>>> Only
>>>> false-negative access and/or dirty information is possible in this scenario."
>>>>
>>>> which is starting to sound bonkers. Personally I think we are better off at
>>>> this
>>>> point, just keeping today's arm64 ptep_get_lockless().
>>>
>>> Remind me again, does arm64 perform an IPI broadcast during a TLB flush that
>>> would sync against GUP-fast?
>>
>> No, the broadcast is in HW. There is no IPI.
> 
> Okay ...
> 
> I agree that the semantics are a bit weird, but if we could get rid of
> ptep_get_lockless() on arm64, that would also be nice.
> 
> 
> Something I've been thinking of ... just to share what I've had in mind. The two
> types of users we currently have are:
> 
> (1) ptep_get_lockless() followed by ptep_get() check under PTL.
> 
> (2) ptep_get_lockless() followed by ptep_get() check without PTL.
> 
> What if we had the following instead:
> 
> (1) ptep_get_lockless() followed by ptep_get() check under PTL.
> 
> (2) ptep_get_gup_fast() followed by ptep_get_gup_fast() check without
>     PTL.
> 
> And on arm64 let
> 
> (1) ptep_get_lockless() be ptep_get()
> 
> (2) ptep_get_gup_fast() be __ptep_get().
> 
> That would mean, that (2) would not care if another cont-pte is dirty, because
> we don't collect access+dirty bits. That way, we avoid any races with concurrent
> unfolding etc. The only "problamtic" thing is that pte_mkdirty() -> set_ptes()
> would have to set all cont-PTEs dirty, even if any of these already is dirty.

I don't think the "problematic" thing is actually a problem; set_ptes() will
always set the dirty bit to the same value for all ptes it covers (and if you do
set_ptes() on a partial contpte block, it will be unfolded first). Although I
suspect I've misunderstood what you meant there...

The potential problem I see with this is that the Arm ARM doesn't specify which
PTE of a contpte block the HW stores a/d in. So the HW _could_ update them
randomly and this could spuriously increase your check failure rate. In reality
I believe most implementations will update the PTE for the address that caused
the TLB to be populated. But in some cases, you could have eviction (due to
pressure or explicit invalidation) followed by re-population due to faulting on
a different page of the contpte block. In this case you would see this type of
problem too.

But ultimately, isn't this basically equivalent to ptep_get_lockless() returning
potentially false-negatives for access and dirty? Just with a much higher chance
of getting a false-negative. How is this helping?



