Return-Path: <linux-kernel+bounces-154846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247908AE1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30FBEB215C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678FF60B9C;
	Tue, 23 Apr 2024 10:15:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943B45FB9B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867321; cv=none; b=pRIa3dc4j+6KbD/1Xcqol0tCn2KXhkfA9WHB+bG9NImqdLLD2RVktEWdoTKAnOXD1Lgjl+S94Gzz72dMt2ifdj1POwluCt/BO2YFZ1hzNdO8zQUCB0zAxbNBViWqoXNkCBUlHaCySzzpQk8HHL3XnM5436T/XLtFd8O8oOjtpFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867321; c=relaxed/simple;
	bh=uCrJn8bOdsM7zhyNnPQ0SZMDjm0WhwqebBwccqw71g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rGZAfxHwx5KKmqb+ZtUIOOUX3Mgji5vumlxtf8BsG+XQE9aM++txcHI/K79jUIno50Hn/i6yFEY1q57ELaS6APPi5SRQxfU/TDn1OTDjsNGOWr3b3+4fd+iUqJdAyDVA9UmxZ7RL+2gK/l/fu9mQVhQp7+y0u0jxjXR4BuF8b2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF97D339;
	Tue, 23 Apr 2024 03:15:46 -0700 (PDT)
Received: from [10.57.74.127] (unknown [10.57.74.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C19C3F7BD;
	Tue, 23 Apr 2024 03:15:17 -0700 (PDT)
Message-ID: <789cb7e4-8659-4244-b72e-e8fa0b26431d@arm.com>
Date: Tue, 23 Apr 2024 11:15:15 +0100
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
 <89e04df9-6a2f-409c-ae7d-af1f91d0131e@arm.com>
 <ecd6e3e5-8617-42bd-bed4-3f97577934f9@redhat.com>
 <c880ba19-93ab-492b-a720-7272a1f8756d@arm.com>
 <abc3f45e-3bb9-44b8-ac87-c988e4de706c@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <abc3f45e-3bb9-44b8-ac87-c988e4de706c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi David,

Sorry for the slow reply on this; its was due to a combination of thinking a bit
more about the options here and being out on holiday.


On 15/04/2024 17:02, David Hildenbrand wrote:
>>>> The potential problem I see with this is that the Arm ARM doesn't specify which
>>>> PTE of a contpte block the HW stores a/d in. So the HW _could_ update them
>>>> randomly and this could spuriously increase your check failure rate. In reality
>>>> I believe most implementations will update the PTE for the address that caused
>>>> the TLB to be populated. But in some cases, you could have eviction (due to
>>>> pressure or explicit invalidation) followed by re-population due to faulting on
>>>> a different page of the contpte block. In this case you would see this type of
>>>> problem too.
>>>>
>>>> But ultimately, isn't this basically equivalent to ptep_get_lockless()
>>>> returning
>>>> potentially false-negatives for access and dirty? Just with a much higher
>>>> chance
>>>> of getting a false-negative. How is this helping?
>>>
>>> You are performing an atomic read like GUP-fast wants you to. So there are no
>>> races to worry about like on other architectures: HW might *set* the dirty bit
>>> concurrently, but that's just fine.
>>
>> But you can still see false-negatives for access and dirty...
> 
> Yes.
> 
>>
>>>
>>> The whole races you describe with concurrent folding/unfolding/ ... are
>>> irrelevant.
>>
>> And I think I convinced myself that you will only see false-negatives with
>> today's arm64 ptep_get(). But an order or magnitude fewer than with your
>> proposal (assuming 16 ptes per contpte block, and the a/d bits are in one of
>> those).
>>
>>>
>>> To me that sounds ... much simpler ;) But again, just something I've been
>>> thinking about.
>>
>> OK so this approach upgrades my "I'm fairly sure we never see false-positives"
>> to "we definitely never see false-positives". But it certainly increases the
>> quantity of false-negatives.
> 
> Yes.
> 
>>
>>>
>>> The reuse of pte_get_lockless() outside GUP code might not have been the wisest
>>> choice.
>>>
>>
>> If you want to go down the ptep_get_gup_fast() route, you've still got to be
>> able to spec it, and I think it will land pretty close to my most recent stab at
>> respec'ing ptep_get_lockless() a couple of replies up on this thread.
>>
>> Where would your proposal leave the KVM use case? If you call it
>> ptep_get_gup_fast() presumably you wouldn't want to use it for KVM? So it would
>> be left with ptep_get()...
> 
> It's using GUP-fast.
> 
>>
>> Sorry this thread is getting so long. Just to summarise, I think there are
>> currently 3 solutions on the table:
>>
>>    - ptep_get_lockless() remains as is
>>    - ptep_get_lockless() wraps ptep_get()
>>    - ptep_get_lockless() wraps __ptep_get() (and gets a gup_fast rename)
>>
>> Based on discussion so far, that's also the order of my preference.
> 
> (1) seems like the easiest thing to do.

Yes, I'm very much in favour of easy.

> 
>>
>> Perhaps its useful to enumerate why we dislike the current ptep_get_lockless()?
> 
> Well, you sent that patch series with "that aims to reduce the cost and
> complexity of ptep_get_lockless() for arm64". (2) and (3) would achieve that. :)

Touche! I'd half forgotten that we were having this conversation in the context
of this series!

I guess your ptep_get_gup_fast() approach is very similar to
ptep_get_lockless_norecency()... So we are back to the beginning :)

But ultimately I've come to the conclusion that it is easy to reason about the
current arm64 ptep_get_lockless() implementation and see that its correct. The
other options both have their drawbacks.

Yes, there is a loop in the current implementation that would be nice to get rid
of, but I don't think it is really any worse than the cmpxchg loops we already
have in other helpers.

I'm not planning to persue this any further. Thanks for the useful discussion
(as always).



