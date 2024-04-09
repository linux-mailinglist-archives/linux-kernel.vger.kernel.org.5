Return-Path: <linux-kernel+bounces-137331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 517E289E08A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B891C20DCB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A393E153575;
	Tue,  9 Apr 2024 16:35:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A30E153517
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680544; cv=none; b=cZDoxU3wlorazA9/uAlIOb7SOL67ATqGVu8E8icejQyRp+oE5U7C2uiYjfyhepyIGJx+d8r5gYoyTH8iYJu+ANgnS3PqKJNFcBsQ7CdZcg9b/909HD6BWcMkuOpgp+nZcOhhEN+bda7IKK6UPcqUVY/hs4l/kHjRGjgBx21KIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680544; c=relaxed/simple;
	bh=lYT+VYrupc6PCCtXdZsmT0J8TGKLgB4t1zGn/1iHgxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRainIJ3nJoihFFNg4XF4F1sEve4LUMvytO56suVSrvWh/BQOJc1rMsqs55yG868GVcShTz8LWJ9scshnITWkVK3PoAm6uMB2gzq1/Tw7eQtRS/JW3wkiSZmvRlN9l9RSoEX+D0cuk16xoWk1SD2T/ON2MMhFMWp11GNE3nLiHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AED2139F;
	Tue,  9 Apr 2024 09:36:11 -0700 (PDT)
Received: from [10.1.33.185] (XHFQ2J9959.cambridge.arm.com [10.1.33.185])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72A9B3F6C4;
	Tue,  9 Apr 2024 09:35:39 -0700 (PDT)
Message-ID: <4fba71aa-8a63-4a27-8eaf-92a69b2cff0d@arm.com>
Date: Tue, 9 Apr 2024 17:35:38 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <f2aad459-e19c-45e2-a7ab-35383e8c3ba5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/04/2024 09:36, David Hildenbrand wrote:
> On 03.04.24 14:59, Ryan Roberts wrote:
>> On 27/03/2024 09:34, David Hildenbrand wrote:
>>> On 26.03.24 18:51, Ryan Roberts wrote:
>>>> On 26/03/2024 17:39, David Hildenbrand wrote:
>>>>> On 26.03.24 18:32, Ryan Roberts wrote:
>>>>>> On 26/03/2024 17:04, David Hildenbrand wrote:
>>>>>>>>>>>
>>>>>>>>>>> Likely, we just want to read "the real deal" on both sides of the
>>>>>>>>>>> pte_same()
>>>>>>>>>>> handling.
>>>>>>>>>>
>>>>>>>>>> Sorry I'm not sure I understand? You mean read the full pte including
>>>>>>>>>> access/dirty? That's the same as dropping the patch, right? Of course if
>>>>>>>>>> we do
>>>>>>>>>> that, we still have to keep pte_get_lockless() around for this case.
>>>>>>>>>> In an
>>>>>>>>>> ideal
>>>>>>>>>> world we would convert everything over to
>>>>>>>>>> ptep_get_lockless_norecency() and
>>>>>>>>>> delete ptep_get_lockless() to remove the ugliness from arm64.
>>>>>>>>>
>>>>>>>>> Yes, agreed. Patch #3 does not look too crazy and it wouldn't really
>>>>>>>>> affect
>>>>>>>>> any
>>>>>>>>> architecture.
>>>>>>>>>
>>>>>>>>> I do wonder if pte_same_norecency() should be defined per architecture
>>>>>>>>> and the
>>>>>>>>> default would be pte_same(). So we could avoid the mkold etc on all other
>>>>>>>>> architectures.
>>>>>>>>
>>>>>>>> Wouldn't that break it's semantics? The "norecency" of
>>>>>>>> ptep_get_lockless_norecency() means "recency information in the returned
>>>>>>>> pte
>>>>>>>> may
>>>>>>>> be incorrect". But the "norecency" of pte_same_norecency() means "ignore
>>>>>>>> the
>>>>>>>> access and dirty bits when you do the comparison".
>>>>>>>
>>>>>>> My idea was that ptep_get_lockless_norecency() would return the actual
>>>>>>> result on
>>>>>>> these architectures. So e.g., on x86, there would be no actual change in
>>>>>>> generated code.
>>>>>>
>>>>>> I think this is a bad plan... You'll end up with subtle differences between
>>>>>> architectures.
>>>>>>
>>>>>>>
>>>>>>> But yes, the documentation of these functions would have to be improved.
>>>>>>>
>>>>>>> Now I wonder if ptep_get_lockless_norecency() should actively clear
>>>>>>> dirty/accessed bits to more easily find any actual issues where the bits
>>>>>>> still
>>>>>>> matter ...
>>>>>>
>>>>>> I did a version that took that approach. Decided it was not as good as
>>>>>> this way
>>>>>> though. Now for the life of me, I can't remember my reasoning.
>>>>>
>>>>> Maybe because there are some code paths that check accessed/dirty without
>>>>> "correctness" implications? For example, if the PTE is already dirty, no
>>>>> need to
>>>>> set it dirty etc?
>>>>
>>>> I think I decided I was penalizing the architectures that don't care because
>>>> all
>>>> their ptep_get_norecency() and ptep_get_lockless_norecency() need to explicitly
>>>> clear access/dirty. And I would have needed ptep_get_norecency() from day 1 so
>>>> that I could feed its result into pte_same().
>>>
>>> True. With ptep_get_norecency() you're also penalizing other architectures.
>>> Therefore my original thought about making the behavior arch-specific, but the
>>> arch has to make sure to get the combination of
>>> ptep_get_lockless_norecency()+ptep_same_norecency() is right.
>>>
>>> So if an arch decide to ignore bits in ptep_get_lockless_norecency(), it must
>>> make sure to also ignore them in ptep_same_norecency(), and must be able to
>>> handle access/dirty bit changes differently.
>>>
>>> Maybe one could have one variant for "hw-managed access/dirty" vs. "sw managed
>>> accessed or dirty". Only the former would end up ignoring stuff here, the latter
>>> would not.
>>>
>>> But again, just some random thoughts how this affects other architectures and
>>> how we could avoid it. The issue I describe in patch #3 would be gone if
>>> ptep_same_norecency() would just do a ptep_same() check on other architectures
>>> -- and would make it easier to sell :)
>>>
>>
>> I've been thinking some more about this. I think your proposal is the following:
>>
>>
>> // ARM64
>> ptep_get_lockless_norecency()
>> {
>>     - returned access/dirty may be incorrect
>>     - returned access/dirty may be differently incorrect between 2 calls
>> }
>> pte_same_norecency()
>> {
>>     - ignore access/dirty when doing comparison
>> }
>> ptep_set_access_flags(ptep, pte)
>> {
>>     - must not assume access/dirty in pte are "more permissive" than
>>       access/dirty in *ptep
>>     - must only set access/dirty in *ptep, never clear
>> }
>>
>>
>> // Other arches: no change to generated code
>> ptep_get_lockless_norecency()
>> {
>>     return ptep_get_lockless();
>> }
>> pte_same_norecency()
>> {
>>     return pte_same();
>> }
>> ptep_set_access_flags(ptep, pte)
>> {
>>     - may assume access/dirty in pte are "more permissive" than access/dirty
>>       in *ptep
>>     - if no HW access/dirty updates, "*ptep = pte" always results in "more
>>       permissive" change
>> }
>>
>> An arch either specializes all 3 or none of them.
>>
>> This would allow us to get rid of ptep_get_lockless().
>>
>> And it addresses the bug you found with ptep_set_access_flags().
>>
>>
>> BUT, I still have a nagging feeling that there are likely to be other similar
>> problems caused by ignoring access/dirty during pte_same_norecency(). I can't
>> convince myself that its definitely all safe and robust.
> 
> Right, we'd have to identify the other possible cases and document what an arch
> + common code must stick to to make it work.
> 
> Some rules would be: if an arch implements ptep_get_lockless_norecency():
> 
> (1) Passing the result from ptep_get_lockless_norecency() to pte_same()
>     is wrong.
> (2) Checking pte_young()/pte_old/pte_dirty()/pte_clean() after
>     ptep_get_lockless_norecency() is very likely wrong.
> 
> 
>>
>> So I'm leaning towards dropping patch 3 and therefore keeping
>> ptep_get_lockless() around.
>>
>> Let me know if you have any insight that might help me change my mind :)
> 
> I'm wondering if it would help if we could find a better name (or concept) for
> "norecency" here, that expresses that only on some archs we'd have that fuzzy
> handling.
> 
> Keeping ptep_get_lockless() around for now sounds like the best alternative.

Separately to this I've been playing with an idea to add support for uffd-wp and
soft-dirty SW PTE bits for arm64; it boils down to keeping the SW bits in
separate storage, linked from the ptdesc. And we have some constant HW PTE bits
that we can remove and replace with those SW bits so we can keep the pte_t the
same size and abstract it all with ptep_get() and set_ptes().

It was all looking straightforward until I got to ptep_get_lockless(). Now that
there are 2 separate locations for PTE bits, I can't read it all atomically.

So I've been looking at all this again, and getting myself even more confused.

I believe there are 2 classes of ptep_get_lockless() caller:

1) vmf->orig_pte = ptep_get_lockless(vmf->pte); in handle_pte_fault()
2) everyone else

--

(1) doesn't really care if orig_pte is consistent or not. It just wants to read
a value, do some speculative work based on that value, then lock the PTL, and
check the value hasn't changed. If it has changed, it backs out. So we don't
actually need any "lockless" guarrantees here; we could just use ptep_get().

In fact, prior to Hugh's commit 26e1a0c3277d ("mm: use pmdp_get_lockless()
without surplus barrier()"), we had this:

                vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
-               vmf->orig_pte = *vmf->pte;
+               vmf->orig_pte = ptep_get_lockless(vmf->pte);
                vmf->flags |= FAULT_FLAG_ORIG_PTE_VALID;

-               /*
-                * some architectures can have larger ptes than wordsize,
-                * e.g.ppc44x-defconfig has CONFIG_PTE_64BIT=y and
-                * CONFIG_32BIT=y, so READ_ONCE cannot guarantee atomic
-                * accesses.  The code below just needs a consistent view
-                * for the ifs and we later double check anyway with the
-                * ptl lock held. So here a barrier will do.
-                */
-               barrier();
                if (pte_none(vmf->orig_pte)) {

--

(2) All the other users require that a subset of the pte fields are
self-consistent; specifically they don't care about access, dirty, uffd-wp or
soft-dirty. arm64 can guarrantee that all the other bits are self-consistent
just by calling ptep_get().

--

So, I'm making the bold claim that it was never neccessary to specialize
pte_get_lockless() on arm64, and I *think* we could just delete it so that
ptep_get_lockless() resolves to ptep_get() on arm64. That solves the original
aim without needing to introduce "norecency" variants.

Additionally I propose documenting ptep_get_lockless() to describe the set of
fields that are guarranteed to be self-consistent and the remaining fields which
are self-consistent only with best-effort.

Could it be this easy? My head is hurting...

Thanks,
Ryan


