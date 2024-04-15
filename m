Return-Path: <linux-kernel+bounces-144834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC48D8A4B71
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7C31C21123
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36EE3FB99;
	Mon, 15 Apr 2024 09:28:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949BF3BBED
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173337; cv=none; b=ODknh2qAsGPKsyfiltFspsDe4IotIcrSiBFdEF4/L+PSppQ9sE+gv50XEW50Wly9hzrs5wRizvYAAZH6z0+M7H92EMbiJTHS/E9tmjptKUecb0AUL2YpxBXt3i8qPVDxFylBRJVEbfQIomyBxji9Qc4uLF3dnrchdMOd+yZz0zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173337; c=relaxed/simple;
	bh=r/3wHMenmyMpL+3msMe6L8ryExh5W11sTxtzpaEA+eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSsB7cZlE7yllpHE3t9T5Su5rwLIVMwIgSHGBhGghRqGZH/EXApX5v8ReJB4pQMjIX+z35fWGuQSRIts0jRBP4sao0MrpJJKJWBgFnQw3SxY0KL+S9dGNrohLwQmfitUV+jF7RBiftiUAKozS40Aky04w+lTvSBl25ldgnZ3tME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D11082F4;
	Mon, 15 Apr 2024 02:29:22 -0700 (PDT)
Received: from [10.57.75.121] (unknown [10.57.75.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6E6B3F64C;
	Mon, 15 Apr 2024 02:28:52 -0700 (PDT)
Message-ID: <f13d1e4d-1eea-4379-b683-4d736ad99c2c@arm.com>
Date: Mon, 15 Apr 2024 10:28:51 +0100
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
 <81aa23ca-18b1-4430-9ad1-00a2c5af8fc2@arm.com>
 <70a36403-aefd-4311-b612-84e602465689@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <70a36403-aefd-4311-b612-84e602465689@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/04/2024 21:16, David Hildenbrand wrote:
>>
>> Yes agreed - 2 types; "lockless walkers that later recheck under PTL" and
>> "lockless walkers that never take the PTL".
>>
>> Detail: the part about disabling interrupts and TLB flush syncing is
>> arch-specifc. That's not how arm64 does it (the hw broadcasts the TLBIs). But
>> you make that clear further down.
> 
> Yes, but disabling interrupts is also required for RCU-freeing of page tables
> such that they can be walked safely. The TLB flush IPI is arch-specific and
> indeed to sync against PTE invalidation (before generic GUP-fast).
> [...]
> 
>>>>
>>>> Could it be this easy? My head is hurting...
>>>
>>> I think what has to happen is:
>>>
>>> (1) pte_get_lockless() must return the same value as ptep_get() as long as there
>>> are no races. No removal/addition of access/dirty bits etc.
>>
>> Today's arm64 ptep_get() guarantees this.
>>
>>>
>>> (2) Lockless page table walkers that later verify under the PTL can handle
>>> serious "garbage PTEs". This is our page fault handler.
>>
>> This isn't really a property of a ptep_get_lockless(); its a statement about a
>> class of users. I agree with the statement.
> 
> Yes. That's a requirement for the user of ptep_get_lockless(), such as page
> fault handlers. Well, mostly "not GUP".
> 
>>
>>>
>>> (3) Lockless page table walkers that cannot verify under PTL cannot handle
>>> arbitrary garbage PTEs. This is GUP-fast. Two options:
>>>
>>> (3a) pte_get_lockless() can atomically read the PTE: We re-check later if the
>>> atomically-read PTE is still unchanged (without PTL). No IPI for TLB flushes
>>> required. This is the common case. HW might concurrently set access/dirty bits,
>>> so we can race with that. But we don't read garbage.
>>
>> Today's arm64 ptep_get() cannot garantee that the access/dirty bits are
>> consistent for contpte ptes. That's the bit that complicates the current
>> ptep_get_lockless() implementation.
>>
>> But the point I was trying to make is that GUP-fast does not actually care about
>> *all* the fields being consistent (e.g. access/dirty). So we could spec
>> pte_get_lockless() to say that "all fields in the returned pte are guarranteed
>> to be self-consistent except for access and dirty information, which may be
>> inconsistent if a racing modification occured".
> 
> We *might* have KVM in the future want to check that a PTE is dirty, such that
> we can only allow dirty PTEs to be writable in a secondary MMU. That's not there
> yet, but one thing I was discussing on the list recently. Burried in:
> 
> https://lkml.kernel.org/r/20240320005024.3216282-1-seanjc@google.com
> 
> We wouldn't care about racing modifications, as long as MMU notifiers will
> properly notify us when the PTE would lose its dirty bits.
> 
> But getting false-positive dirty bits would be problematic.
> 
>>
>> This could mean that the access/dirty state *does* change for a given page while
>> GUP-fast is walking it, but GUP-fast *doesn't* detect that change. I *think*
>> that failing to detect this is benign.
> 
> I mean, HW could just set the dirty/access bit immediately after the check. So
> if HW concurrently sets the bit and we don't observe that change when we
> recheck, I think that would be perfectly fine.

Yes indeed; that's my point - GUP-fast doesn't care about access/dirty (or
soft-dirty or uffd-wp).

But if you don't want to change the ptep_get_lockless() spec to explicitly allow
this (because you have the KVM use case where false-positive dirty is
problematic), then I think we are stuck with ptep_get_lockless() as implemented
for arm64 today.

> 
>>
>> Aside: GUP-fast currently rechecks the pte originally obtained with
>> ptep_get_lockless(), using ptep_get(). Is that correct? ptep_get() must conform
>> to (1), so either it returns the same pte or it returns a different pte or
>> garbage. But that garbage could just happen to be the same as the originally
>> obtained pte. So in that case, it would have a false match. I think this needs
>> to be changed to ptep_get_lockless()?
> 
> I *think* it's fine, because the case where it would make a difference (x86-PAE)
> still requires the TLB flush IPI to sync against PTE changes, and that check
> would likely be wrong in one way or the other. So for x86-pae, that check is
> just moot either way.
> 
> That my theory, at least.
> 
> (but this "let's fake-read atomically although we don't, but let's do like we
> could in some specific circumstances" is really hard to get)
> 
> I was wondering a while ago if we are missing a memory barrier before the checl,
> but I think the one from obtaining the page reference gets the job done (at
> least that's what I remember).
> 


