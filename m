Return-Path: <linux-kernel+bounces-167438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1798BA99B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFC31C2204B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E73114F127;
	Fri,  3 May 2024 09:16:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2444D14F11C
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727766; cv=none; b=WnELheP2BS4aT0MmZ2J2QKky37/Sr1nN1NqN1mG19bYKtZGMSUlSBMgjXefmpLRGmtLDJ+ZJPH2K6ctxASpszXq0UFQmbw+yiGO9Oge8XdY5yohsoKsYzc8T6tbukfm/47F9Cb9jS53gLFBrPHQ8uZb1PCFdSoZYfQtleowW6aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727766; c=relaxed/simple;
	bh=aelgRfspWaMgu0/2pO/QEbzUGa7UaCw97qQ0qgyd5O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYiyjiSuT6/l/xaOUq4KTLXpCzYHMib9piLEXgSFk2qcMw6AokZrVyiuLj0qqgVox4kcvLpHpSfOm8OJd85ofbzIZZ8YuS1au6ud8sFrWi+I5LjZrSjTvvy1z5WQbiiF4kpmJuD2nESC3yMl7NPydwjH7uTKL2FuwDxkz1iYkMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A22CA2F4;
	Fri,  3 May 2024 02:16:29 -0700 (PDT)
Received: from [10.57.67.51] (unknown [10.57.67.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16A913F73F;
	Fri,  3 May 2024 02:16:02 -0700 (PDT)
Message-ID: <c055203a-4365-4f5e-8276-5c57634abe73@arm.com>
Date: Fri, 3 May 2024 10:16:01 +0100
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
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, linux-kernel@vger.kernel.org, david@redhat.com,
 v-songbaohua@oppo.com, vbabka@suse.cz, willy@infradead.org
References: <20240503020924.208431-1-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240503020924.208431-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/05/2024 03:09, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> When unplugging a CPU, the current code merges its vm_events
> with an online CPU. Because, during summation, it only considers
> online CPUs, which is a crude workaround. By transitioning to
> summing up all possible CPUs, we can eliminate the need for
> vm_events_fold_cpu.
> 
> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  originally suggested by Ryan while he reviewed mTHP counters
>  patchset[1]; I am also applying this suggestion to vm_events
> 
>  -v2:
>  also drop cpus_read_lock() as we don't care about cpu hotplug any more;
>  -v1:
>  https://lore.kernel.org/linux-mm/20240412123039.442743-1-21cnbao@gmail.com/
> 
>  [1] https://lore.kernel.org/linux-mm/ca73cbf1-8304-4790-a721-3c3a42f9d293@arm.com/
> 
>  include/linux/vmstat.h |  5 -----
>  mm/page_alloc.c        |  8 --------
>  mm/vmstat.c            | 21 +--------------------
>  3 files changed, 1 insertion(+), 33 deletions(-)
> 
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index 735eae6e272c..f7eaeb8bfa47 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -83,8 +83,6 @@ static inline void count_vm_events(enum vm_event_item item, long delta)
>  
>  extern void all_vm_events(unsigned long *);
>  
> -extern void vm_events_fold_cpu(int cpu);
> -
>  #else
>  
>  /* Disable counters */
> @@ -103,9 +101,6 @@ static inline void __count_vm_events(enum vm_event_item item, long delta)
>  static inline void all_vm_events(unsigned long *ret)
>  {
>  }
> -static inline void vm_events_fold_cpu(int cpu)
> -{
> -}
>  
>  #endif /* CONFIG_VM_EVENT_COUNTERS */
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cd584aace6bf..8b56d785d587 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5826,14 +5826,6 @@ static int page_alloc_cpu_dead(unsigned int cpu)
>  	mlock_drain_remote(cpu);
>  	drain_pages(cpu);
>  
> -	/*
> -	 * Spill the event counters of the dead processor
> -	 * into the current processors event counters.
> -	 * This artificially elevates the count of the current
> -	 * processor.
> -	 */
> -	vm_events_fold_cpu(cpu);
> -
>  	/*
>  	 * Zero the differential counters of the dead processor
>  	 * so that the vm statistics are consistent.
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index db79935e4a54..aaa32418652e 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -114,7 +114,7 @@ static void sum_vm_events(unsigned long *ret)
>  
>  	memset(ret, 0, NR_VM_EVENT_ITEMS * sizeof(unsigned long));
>  
> -	for_each_online_cpu(cpu) {
> +	for_each_possible_cpu(cpu) {

One thought comes to mind (due to my lack of understanding exactly what
"possible" means): Linux is compiled with a max number of cpus - NR_CPUS - 512
for arm64's defconfig. Does all possible cpus include all 512? On an 8 CPU
system that would be increasing the number of loops by 64 times.

Or perhaps possible just means CPUs that have ever been online?

Either way, I guess it's not considered a performance bottleneck because, from
memory, the scheduler and many other places are iterating over all possible cpus.

>  		struct vm_event_state *this = &per_cpu(vm_event_states, cpu);
>  
>  		for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
> @@ -129,29 +129,10 @@ static void sum_vm_events(unsigned long *ret)
>  */
>  void all_vm_events(unsigned long *ret)
>  {
> -	cpus_read_lock();
>  	sum_vm_events(ret);
> -	cpus_read_unlock();
>  }
>  EXPORT_SYMBOL_GPL(all_vm_events);
>  
> -/*
> - * Fold the foreign cpu events into our own.
> - *
> - * This is adding to the events on one processor
> - * but keeps the global counts constant.
> - */
> -void vm_events_fold_cpu(int cpu)
> -{
> -	struct vm_event_state *fold_state = &per_cpu(vm_event_states, cpu);
> -	int i;
> -
> -	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
> -		count_vm_events(i, fold_state->event[i]);
> -		fold_state->event[i] = 0;
> -	}
> -}
> -
>  #endif /* CONFIG_VM_EVENT_COUNTERS */
>  
>  /*


