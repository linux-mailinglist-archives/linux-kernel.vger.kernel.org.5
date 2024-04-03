Return-Path: <linux-kernel+bounces-129764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA1C896FAC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B79B1F2A1EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF3A146D53;
	Wed,  3 Apr 2024 12:59:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DEF13775D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149154; cv=none; b=abTfhifli+pSZ18/+uyxc/RF4Hwsya6vSQ7v9dpwTJnXDXSCuOwYADqKVzcWvIdLoCxTHO0ZMKVolOJNUymX1+bIrs1NBgdnp5Ff4YtQDG99268YJnyMMguG8j2204V4bnMRSDdegUf+DuiKS41bsbN/5NcntQHnPQKWd1eWCug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149154; c=relaxed/simple;
	bh=irgCMffmOmwQWHOOHIcD87QVwVYpJ1zi4B6EebujLwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pe9kXnG58zjcTfE34a/q8iExvvze8zNCwsGOATF3Bkxt2lKUlOHeBHPsT11Z4tm7PLbuMygGau1155b1mGalRoIJIqGA/RRh1eOuejWwUYECYUTFxXDmbtFAe9WZ1MGCyON2TOgWcmjGiwdDnOsJhvEcA7xXb8Q79qvqFvHXI/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C265B1007;
	Wed,  3 Apr 2024 05:59:43 -0700 (PDT)
Received: from [10.57.72.245] (unknown [10.57.72.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1AA53F7B4;
	Wed,  3 Apr 2024 05:59:10 -0700 (PDT)
Message-ID: <dbc5083b-bf8c-4869-8dc7-5fbf2c88cce8@arm.com>
Date: Wed, 3 Apr 2024 13:59:09 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <35236bbf-3d9a-40e9-84b5-e10e10295c0c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 09:34, David Hildenbrand wrote:
> On 26.03.24 18:51, Ryan Roberts wrote:
>> On 26/03/2024 17:39, David Hildenbrand wrote:
>>> On 26.03.24 18:32, Ryan Roberts wrote:
>>>> On 26/03/2024 17:04, David Hildenbrand wrote:
>>>>>>>>>
>>>>>>>>> Likely, we just want to read "the real deal" on both sides of the
>>>>>>>>> pte_same()
>>>>>>>>> handling.
>>>>>>>>
>>>>>>>> Sorry I'm not sure I understand? You mean read the full pte including
>>>>>>>> access/dirty? That's the same as dropping the patch, right? Of course if
>>>>>>>> we do
>>>>>>>> that, we still have to keep pte_get_lockless() around for this case. In an
>>>>>>>> ideal
>>>>>>>> world we would convert everything over to ptep_get_lockless_norecency() and
>>>>>>>> delete ptep_get_lockless() to remove the ugliness from arm64.
>>>>>>>
>>>>>>> Yes, agreed. Patch #3 does not look too crazy and it wouldn't really affect
>>>>>>> any
>>>>>>> architecture.
>>>>>>>
>>>>>>> I do wonder if pte_same_norecency() should be defined per architecture
>>>>>>> and the
>>>>>>> default would be pte_same(). So we could avoid the mkold etc on all other
>>>>>>> architectures.
>>>>>>
>>>>>> Wouldn't that break it's semantics? The "norecency" of
>>>>>> ptep_get_lockless_norecency() means "recency information in the returned pte
>>>>>> may
>>>>>> be incorrect". But the "norecency" of pte_same_norecency() means "ignore the
>>>>>> access and dirty bits when you do the comparison".
>>>>>
>>>>> My idea was that ptep_get_lockless_norecency() would return the actual
>>>>> result on
>>>>> these architectures. So e.g., on x86, there would be no actual change in
>>>>> generated code.
>>>>
>>>> I think this is a bad plan... You'll end up with subtle differences between
>>>> architectures.
>>>>
>>>>>
>>>>> But yes, the documentation of these functions would have to be improved.
>>>>>
>>>>> Now I wonder if ptep_get_lockless_norecency() should actively clear
>>>>> dirty/accessed bits to more easily find any actual issues where the bits still
>>>>> matter ...
>>>>
>>>> I did a version that took that approach. Decided it was not as good as this way
>>>> though. Now for the life of me, I can't remember my reasoning.
>>>
>>> Maybe because there are some code paths that check accessed/dirty without
>>> "correctness" implications? For example, if the PTE is already dirty, no need to
>>> set it dirty etc?
>>
>> I think I decided I was penalizing the architectures that don't care because all
>> their ptep_get_norecency() and ptep_get_lockless_norecency() need to explicitly
>> clear access/dirty. And I would have needed ptep_get_norecency() from day 1 so
>> that I could feed its result into pte_same().
> 
> True. With ptep_get_norecency() you're also penalizing other architectures.
> Therefore my original thought about making the behavior arch-specific, but the
> arch has to make sure to get the combination of
> ptep_get_lockless_norecency()+ptep_same_norecency() is right.
> 
> So if an arch decide to ignore bits in ptep_get_lockless_norecency(), it must
> make sure to also ignore them in ptep_same_norecency(), and must be able to
> handle access/dirty bit changes differently.
> 
> Maybe one could have one variant for "hw-managed access/dirty" vs. "sw managed
> accessed or dirty". Only the former would end up ignoring stuff here, the latter
> would not.
> 
> But again, just some random thoughts how this affects other architectures and
> how we could avoid it. The issue I describe in patch #3 would be gone if
> ptep_same_norecency() would just do a ptep_same() check on other architectures
> -- and would make it easier to sell :)
> 

I've been thinking some more about this. I think your proposal is the following:


// ARM64
ptep_get_lockless_norecency()
{
	- returned access/dirty may be incorrect
	- returned access/dirty may be differently incorrect between 2 calls
}
pte_same_norecency()
{
	- ignore access/dirty when doing comparison
}
ptep_set_access_flags(ptep, pte)
{
	- must not assume access/dirty in pte are "more permissive" than
	  access/dirty in *ptep
	- must only set access/dirty in *ptep, never clear
}


// Other arches: no change to generated code
ptep_get_lockless_norecency()
{
	return ptep_get_lockless();
}
pte_same_norecency()
{
	return pte_same();
}
ptep_set_access_flags(ptep, pte)
{
	- may assume access/dirty in pte are "more permissive" than access/dirty
	  in *ptep
	- if no HW access/dirty updates, "*ptep = pte" always results in "more
	  permissive" change
}

An arch either specializes all 3 or none of them.

This would allow us to get rid of ptep_get_lockless().

And it addresses the bug you found with ptep_set_access_flags().


BUT, I still have a nagging feeling that there are likely to be other similar
problems caused by ignoring access/dirty during pte_same_norecency(). I can't
convince myself that its definitely all safe and robust.

So I'm leaning towards dropping patch 3 and therefore keeping
ptep_get_lockless() around.

Let me know if you have any insight that might help me change my mind :)

Thanks,
Ryan


