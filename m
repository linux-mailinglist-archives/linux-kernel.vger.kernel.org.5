Return-Path: <linux-kernel+bounces-167539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A968BAB0C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E9C1F230BF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5292152160;
	Fri,  3 May 2024 10:53:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5348F14A4E9
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733583; cv=none; b=iGE7EqP9H6oSj+IRzqokTLsfHvbn7D5Q7QZW+/xseKKyTxVYDVABE5LCZkhGVQ9eFNAloEBUxDcf2osCe7Wl7kqj2WalFCbk8GELztBt7V7Z2tnlWPNesjJW3iYD+SzZtAzrrsX6mMwZG1P0YOogOmUkvc47QiEN4tV83Za3qm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733583; c=relaxed/simple;
	bh=NgMaqI6q4AcKMSywvcduooCSP9pu49qYYUpG30BH8pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o81K//h27NTfhNeyWEtyHAXUUZbe2iAiPnsheUrabiuX+3uUtcyILoblg4+A0m5esSK4UyxTX7Rv/U39YSGVE0IukBR+qUNVYQfC2iOmOv35oLtbFjxMokNtAKe7uJvpgDmY/8+J6XjRaF4lYjotwrYeQw7KG1n1L24Ue+Nnfbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 008CC2F4;
	Fri,  3 May 2024 03:53:26 -0700 (PDT)
Received: from [10.57.67.51] (unknown [10.57.67.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B2213F793;
	Fri,  3 May 2024 03:52:59 -0700 (PDT)
Message-ID: <31740cc9-aa0d-4060-a32d-74cb110b8672@arm.com>
Date: Fri, 3 May 2024 11:52:58 +0100
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
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, david@redhat.com, v-songbaohua@oppo.com,
 vbabka@suse.cz, willy@infradead.org
References: <20240503020924.208431-1-21cnbao@gmail.com>
 <c055203a-4365-4f5e-8276-5c57634abe73@arm.com>
 <CAGsJ_4zurpmR6bdOR+RtwZaV1CS49yiQ03+gQ4y2wVgnEQpoyw@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4zurpmR6bdOR+RtwZaV1CS49yiQ03+gQ4y2wVgnEQpoyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/05/2024 11:17, Barry Song wrote:
> On Fri, May 3, 2024 at 5:16 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 03/05/2024 03:09, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> When unplugging a CPU, the current code merges its vm_events
>>> with an online CPU. Because, during summation, it only considers
>>> online CPUs, which is a crude workaround. By transitioning to
>>> summing up all possible CPUs, we can eliminate the need for
>>> vm_events_fold_cpu.
>>>
>>> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>> ---
>>>  originally suggested by Ryan while he reviewed mTHP counters
>>>  patchset[1]; I am also applying this suggestion to vm_events
>>>
>>>  -v2:
>>>  also drop cpus_read_lock() as we don't care about cpu hotplug any more;
>>>  -v1:
>>>  https://lore.kernel.org/linux-mm/20240412123039.442743-1-21cnbao@gmail.com/
>>>
>>>  [1] https://lore.kernel.org/linux-mm/ca73cbf1-8304-4790-a721-3c3a42f9d293@arm.com/
>>>
>>>  include/linux/vmstat.h |  5 -----
>>>  mm/page_alloc.c        |  8 --------
>>>  mm/vmstat.c            | 21 +--------------------
>>>  3 files changed, 1 insertion(+), 33 deletions(-)
>>>
>>> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
>>> index 735eae6e272c..f7eaeb8bfa47 100644
>>> --- a/include/linux/vmstat.h
>>> +++ b/include/linux/vmstat.h
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
>>>       mlock_drain_remote(cpu);
>>>       drain_pages(cpu);
>>>
>>> -     /*
>>> -      * Spill the event counters of the dead processor
>>> -      * into the current processors event counters.
>>> -      * This artificially elevates the count of the current
>>> -      * processor.
>>> -      */
>>> -     vm_events_fold_cpu(cpu);
>>> -
>>>       /*
>>>        * Zero the differential counters of the dead processor
>>>        * so that the vm statistics are consistent.
>>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>>> index db79935e4a54..aaa32418652e 100644
>>> --- a/mm/vmstat.c
>>> +++ b/mm/vmstat.c
>>> @@ -114,7 +114,7 @@ static void sum_vm_events(unsigned long *ret)
>>>
>>>       memset(ret, 0, NR_VM_EVENT_ITEMS * sizeof(unsigned long));
>>>
>>> -     for_each_online_cpu(cpu) {
>>> +     for_each_possible_cpu(cpu) {
>>
>> One thought comes to mind (due to my lack of understanding exactly what
>> "possible" means): Linux is compiled with a max number of cpus - NR_CPUS - 512
>> for arm64's defconfig. Does all possible cpus include all 512? On an 8 CPU
>> system that would be increasing the number of loops by 64 times.
>>
>> Or perhaps possible just means CPUs that have ever been online?
> 
> Hi Ryan,
> 
> On arm64, we get possible CPUs either from device tree or ACPI. they are both
> much less than NR_CPUS.

Ahh great. In that case, this patch seems good to me, although I'm not too
familiar with the code.

> 
> /*
>  * Enumerate the possible CPU set from the device tree or ACPI and build the
>  * cpu logical map array containing MPIDR values related to logical
>  * cpus. Assumes that cpu_logical_map(0) has already been initialized.
>  */
> void __init smp_init_cpus(void)
> 
> for device tree case, it is,
> 
> /*
>  * Enumerate the possible CPU set from the device tree and build the
>  * cpu logical map array containing MPIDR values related to logical
>  * cpus. Assumes that cpu_logical_map(0) has already been initialized.
>  */
> static void __init of_parse_and_init_cpus(void)
> {
>         struct device_node *dn;
> 
>         for_each_of_cpu_node(dn) {
>                 u64 hwid = of_get_cpu_hwid(dn, 0);
> 
>                 if (hwid & ~MPIDR_HWID_BITMASK)
>                         goto next;
> 
>                 if (is_mpidr_duplicate(cpu_count, hwid)) {
>                         pr_err("%pOF: duplicate cpu reg properties in the DT\n",
>                                 dn);
>                         goto next;
>                 }
> 
>                 /*
>                  * The numbering scheme requires that the boot CPU
>                  * must be assigned logical id 0. Record it so that
>                  * the logical map built from DT is validated and can
>                  * be used.
>                  */
>                 if (hwid == cpu_logical_map(0)) {
>                         if (bootcpu_valid) {
>                                 pr_err("%pOF: duplicate boot cpu reg
> property in DT\n",
>                                         dn);
>                                 goto next;
>                         }
> 
>                         bootcpu_valid = true;
>                         early_map_cpu_to_node(0, of_node_to_nid(dn));
> 
>                         /*
>                          * cpu_logical_map has already been
>                          * initialized and the boot cpu doesn't need
>                          * the enable-method so continue without
>                          * incrementing cpu.
>                          */
>                         continue;
>                 }
> 
>                 if (cpu_count >= NR_CPUS)
>                         goto next;
> 
>                 pr_debug("cpu logical map 0x%llx\n", hwid);
>                 set_cpu_logical_map(cpu_count, hwid);
> 
>                 early_map_cpu_to_node(cpu_count, of_node_to_nid(dn));
> next:
>                 cpu_count++;
>         }
> }
> 
> even for ARM32, we get that sometimes from scu_get_core_count(),
> eg.
> static void __init omap4_smp_init_cpus(void)
> {
>         unsigned int i = 0, ncores = 1, cpu_id;
> 
>         /* Use ARM cpuid check here, as SoC detection will not work so early */
>         cpu_id = read_cpuid_id() & CPU_MASK;
>         if (cpu_id == CPU_CORTEX_A9) {
>                 /*
>                  * Currently we can't call ioremap here because
>                  * SoC detection won't work until after init_early.
>                  */
>                 cfg.scu_base =  OMAP2_L4_IO_ADDRESS(scu_a9_get_base());
>                 BUG_ON(!cfg.scu_base);
>                 ncores = scu_get_core_count(cfg.scu_base);
>         } else if (cpu_id == CPU_CORTEX_A15) {
>                 ncores = OMAP5_CORE_COUNT;
>         }
> 
>         /* sanity check */
>         if (ncores > nr_cpu_ids) {
>                 pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
>                         ncores, nr_cpu_ids);
>                 ncores = nr_cpu_ids;
>         }
> 
>         for (i = 0; i < ncores; i++)
>                 set_cpu_possible(i, true);
> }
> 
> Other architectures do exactly the same jobs.
> 
> 
> 
>>
>> Either way, I guess it's not considered a performance bottleneck because, from
>> memory, the scheduler and many other places are iterating over all possible cpus.
>>
>>>               struct vm_event_state *this = &per_cpu(vm_event_states, cpu);
>>>
>>>               for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
>>> @@ -129,29 +129,10 @@ static void sum_vm_events(unsigned long *ret)
>>>  */
>>>  void all_vm_events(unsigned long *ret)
>>>  {
>>> -     cpus_read_lock();
>>>       sum_vm_events(ret);
>>> -     cpus_read_unlock();
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
>>> -     struct vm_event_state *fold_state = &per_cpu(vm_event_states, cpu);
>>> -     int i;
>>> -
>>> -     for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
>>> -             count_vm_events(i, fold_state->event[i]);
>>> -             fold_state->event[i] = 0;
>>> -     }
>>> -}
>>> -
>>>  #endif /* CONFIG_VM_EVENT_COUNTERS */
>>>
>>>  /*
>>
> 
> Thanks
> Barry


