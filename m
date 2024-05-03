Return-Path: <linux-kernel+bounces-167751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 769EB8BAE9F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F30284442
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30322154BEE;
	Fri,  3 May 2024 14:14:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EBF153584
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714745695; cv=none; b=f4t3yqTgeoGI+valZ9Jw3Ce55Y5Ac0bXNHNoEP4PsxPEvGld5k52Usp8dWmIWuZMGrlsIz4AMFcGEqRuNq2QmjC7pOH/GQY9J1eSaYFcLa28hBDxq0oH7jFgZ5jleIR0O96puIlEhE0PfJjuOerd9WAEitkDnFQRxYlW4Hrp9mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714745695; c=relaxed/simple;
	bh=a0miZy6BtS8WlF2l8C6m1AYEuvdLqwVJZpR40YaIV6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEn2xA21qKGEtFk7DAIDcPCdaxwJ/gZCHw3Sg9vZFYG0GMpsM/v0WCwO9p6Z+23SPLPQBg7KA0MFijA50vrcOsmtUDT3JILULAEOA/4PZjRpYDl8c7Sjm/VUnbh2PSNgqYNecLRd7nJybfoNGxSqFTRTT/4aX6BJJM5ckK3ewTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45C7513D5;
	Fri,  3 May 2024 07:15:17 -0700 (PDT)
Received: from [10.57.67.51] (unknown [10.57.67.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B180F3F73F;
	Fri,  3 May 2024 07:14:50 -0700 (PDT)
Message-ID: <9d390017-f1c4-44db-864f-cb95b8fd3a9b@arm.com>
Date: Fri, 3 May 2024 15:14:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/vmstat: sum up all possible CPUs instead of using
 vm_events_fold_cpu
Content-Language: en-GB
To: Vlastimil Babka <vbabka@suse.cz>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: hannes@cmpxchg.org, linux-kernel@vger.kernel.org, david@redhat.com,
 v-songbaohua@oppo.com, willy@infradead.org
References: <20240503020924.208431-1-21cnbao@gmail.com>
 <c055203a-4365-4f5e-8276-5c57634abe73@arm.com>
 <d855af59-be1f-40e0-b5db-840ca1b23cdd@suse.cz>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <d855af59-be1f-40e0-b5db-840ca1b23cdd@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/05/2024 14:45, Vlastimil Babka wrote:
> On 5/3/24 11:16 AM, Ryan Roberts wrote:
>> On 03/05/2024 03:09, Barry Song wrote:
>>> @@ -83,8 +83,6 @@ static inline void count_vm_events(enum vm_event_item item, long delta)
>>>  
>>>  extern void all_vm_events(unsigned long *);
>>>  
>>> -extern void vm_events_fold_cpu(int cpu);
>>> -
>>>  #else
>>>  
>>>  /* Disable counters */
>>> @@ -103,9 +101,6 @@ static inline void __count_vm_events(enum vm_event_item item, long delta)
>>>  static inline void all_vm_events(unsigned long *ret)
>>>  {
>>>  }
>>> -static inline void vm_events_fold_cpu(int cpu)
>>> -{
>>> -}
>>>  
>>>  #endif /* CONFIG_VM_EVENT_COUNTERS */
>>>  
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index cd584aace6bf..8b56d785d587 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -5826,14 +5826,6 @@ static int page_alloc_cpu_dead(unsigned int cpu)
>>>  	mlock_drain_remote(cpu);
>>>  	drain_pages(cpu);
>>>  
>>> -	/*
>>> -	 * Spill the event counters of the dead processor
>>> -	 * into the current processors event counters.
>>> -	 * This artificially elevates the count of the current
>>> -	 * processor.
>>> -	 */
>>> -	vm_events_fold_cpu(cpu);
>>> -
>>>  	/*
>>>  	 * Zero the differential counters of the dead processor
>>>  	 * so that the vm statistics are consistent.
>>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>>> index db79935e4a54..aaa32418652e 100644
>>> --- a/mm/vmstat.c
>>> +++ b/mm/vmstat.c
>>> @@ -114,7 +114,7 @@ static void sum_vm_events(unsigned long *ret)
>>>  
>>>  	memset(ret, 0, NR_VM_EVENT_ITEMS * sizeof(unsigned long));
>>>  
>>> -	for_each_online_cpu(cpu) {
>>> +	for_each_possible_cpu(cpu) {
>>
>> One thought comes to mind (due to my lack of understanding exactly what
>> "possible" means): Linux is compiled with a max number of cpus - NR_CPUS - 512
>> for arm64's defconfig. Does all possible cpus include all 512? On an 8 CPU
>> system that would be increasing the number of loops by 64 times.
>>
>> Or perhaps possible just means CPUs that have ever been online?
> 
> IIRC on x86 it comes from some BIOS tables, and some bioses might be not
> providing very realistic numbers, so it can be unnecessary large.

OK thanks for the info.

> 
>> Either way, I guess it's not considered a performance bottleneck because, from
>> memory, the scheduler and many other places are iterating over all possible cpus.
> 
> I doubt anything does it in a fastpath. But this affects only reading
> /proc/vmstat, right? Which is not a fastpath. Also update_balloon_stats()
> which is probably ok as well?

Yep agreed.

> 
> Either way I don't see a clear advantage nor disadvantage of this.

The advantage is just that it deletes 32 lines of code and makes it easier to
understand.

> 
>>>  		struct vm_event_state *this = &per_cpu(vm_event_states, cpu);
>>>  
>>>  		for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
>>> @@ -129,29 +129,10 @@ static void sum_vm_events(unsigned long *ret)
>>>  */
>>>  void all_vm_events(unsigned long *ret)
>>>  {
>>> -	cpus_read_lock();
>>>  	sum_vm_events(ret);
>>> -	cpus_read_unlock();
>>>  }
>>>  EXPORT_SYMBOL_GPL(all_vm_events);
>>>  
>>> -/*
>>> - * Fold the foreign cpu events into our own.
>>> - *
>>> - * This is adding to the events on one processor
>>> - * but keeps the global counts constant.
>>> - */
>>> -void vm_events_fold_cpu(int cpu)
>>> -{
>>> -	struct vm_event_state *fold_state = &per_cpu(vm_event_states, cpu);
>>> -	int i;
>>> -
>>> -	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
>>> -		count_vm_events(i, fold_state->event[i]);
>>> -		fold_state->event[i] = 0;
>>> -	}
>>> -}
>>> -
>>>  #endif /* CONFIG_VM_EVENT_COUNTERS */
>>>  
>>>  /*
>>
> 


