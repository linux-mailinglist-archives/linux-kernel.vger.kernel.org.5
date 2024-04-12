Return-Path: <linux-kernel+bounces-142367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 300A38A2ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6422283E62
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8CA51C27;
	Fri, 12 Apr 2024 09:16:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762313A1DE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913400; cv=none; b=QThLnqLnMhtxi5g5+2ZYIcMcqwYZqwesDzWvS+abKp+7lt8yaEpnI/TIpmEPv2jEdt11YA8CVZGsbYilAUKu9DY5HppPnEJ/P9tCQ4gtsqDrXmBd0glKSAO/jJpCsnAZXkXXrn5RgRWWI7wRATMUGDDpY9Ej1infOBLlKTLoMsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913400; c=relaxed/simple;
	bh=m8wmhttkjegEb0znpFbKxkpl/f5l/RZypCQy8XbVBkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxaUFRExYrC3LeEqw/50oToyDRnHRZZVuEd7IQDlaihZgLonxXxbP9h7Wfwdj6uiZyZ5yX0+V23XR+1SBggIgSolnrrAClf6yjPn/XaAiJtG9Gv/3wp9LZDzCLDkArRWb/s9u5DVlpTjB/rpkM1b1ZOGqK3TkeLWNL4v+i45Whk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9514B339;
	Fri, 12 Apr 2024 02:17:01 -0700 (PDT)
Received: from [10.57.73.208] (unknown [10.57.73.208])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A8033F64C;
	Fri, 12 Apr 2024 02:16:30 -0700 (PDT)
Message-ID: <cc9a3d6b-4979-4635-a51a-2edf07853ec6@arm.com>
Date: Fri, 12 Apr 2024 10:16:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] mm: add per-order mTHP anon_alloc and
 anon_alloc_fallback counters
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: david@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 cerasuolodomenico@gmail.com, chrisl@kernel.org, kasong@tencent.com,
 peterx@redhat.com, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, yosryahmed@google.com, yuzhao@google.com,
 linux-kernel@vger.kernel.org
References: <20240405102704.77559-1-21cnbao@gmail.com>
 <20240405102704.77559-2-21cnbao@gmail.com>
 <7cf0a47b-0347-4e81-956f-34bef4ef794a@arm.com>
 <CAGsJ_4zWiYguj1y6Q7Ls41yFkuL5=-ii7pY=rYHg1AZeXe4uTQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4zWiYguj1y6Q7Ls41yFkuL5=-ii7pY=rYHg1AZeXe4uTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/04/2024 23:40, Barry Song wrote:
> On Fri, Apr 12, 2024 at 4:38 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 05/04/2024 11:27, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> Profiling a system blindly with mTHP has become challenging due to the
>>> lack of visibility into its operations. Presenting the success rate of
>>> mTHP allocations appears to be pressing need.
>>>
>>> Recently, I've been experiencing significant difficulty debugging
>>> performance improvements and regressions without these figures.
>>> It's crucial for us to understand the true effectiveness of mTHP in
>>> real-world scenarios, especially in systems with fragmented memory.
>>>
>>> This patch sets up the framework for per-order mTHP counters, starting
>>> with the introduction of anon_alloc and anon_alloc_fallback counters.
>>> Incorporating additional counters should now be straightforward as well.
>>>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>> ---
>>>  include/linux/huge_mm.h | 19 ++++++++++++++++
>>>  mm/huge_memory.c        | 48 +++++++++++++++++++++++++++++++++++++++++
>>>  mm/memory.c             |  2 ++
>>>  3 files changed, 69 insertions(+)
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index e896ca4760f6..c5d33017a4dd 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -264,6 +264,25 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>>>                                         enforce_sysfs, orders);
>>>  }
>>>
>>> +enum mthp_stat_item {
>>> +     MTHP_STAT_ANON_ALLOC,
>>> +     MTHP_STAT_ANON_ALLOC_FALLBACK,
>>> +     __MTHP_STAT_COUNT
>>> +};
>>> +
>>> +struct mthp_stat {
>>> +     unsigned long stats[PMD_ORDER + 1][__MTHP_STAT_COUNT];
>>
>> I saw a fix for this allocation dynamically due to powerpc PMD_ORDER not being
>> constant. I wonder if ilog2(MAX_PTRS_PER_PTE) would help here?
>>
> 
> It's a possibility. However, since we've passed all the build tests
> using dynamic
> allocation, it might not be worth the effort to attempt static
> allocation again. Who
> knows what will happen next :-)

If the dynamic version is clear and obvious then fair enough. I tried doing
something similar for the swap-out series but it turned out a mess, so ended up
falling back to static allocation which was much easier to understand.

> 
>>> +};
>>> +
>>> +DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
>>> +
>>> +static inline void count_mthp_stat(int order, enum mthp_stat_item item)
>>
>> I thought we were going to call this always counting up type of stat and event?
>> "count_mthp_event"? But I'm happy with it as is, personally.
>>
>>> +{
>>> +     if (unlikely(order > PMD_ORDER))
>>> +             return;
>>
>> I'm wondering if it also makes sense to ignore order == 0? Although I guess if
>> called for order-0 its safe since the storage exists and sum_mthp_stat() is
>> never be called for 0. Ignore this comment :)
> 
> Agreed. I'd like to change it to ignore oder 0;
> 
>>
>>> +     this_cpu_inc(mthp_stats.stats[order][item]);
>>> +}
>>> +
>>>  #define transparent_hugepage_use_zero_page()                         \
>>>       (transparent_hugepage_flags &                                   \
>>>        (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 9d4b2fbf6872..5b875f0fc923 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -526,6 +526,46 @@ static const struct kobj_type thpsize_ktype = {
>>>       .sysfs_ops = &kobj_sysfs_ops,
>>>  };
>>>
>>> +DEFINE_PER_CPU(struct mthp_stat, mthp_stats) = {{{0}}};
>>> +
>>> +static unsigned long sum_mthp_stat(int order, enum mthp_stat_item item)
>>> +{
>>> +     unsigned long sum = 0;
>>> +     int cpu;
>>> +
>>> +     for_each_online_cpu(cpu) {
>>
>> What happens if a cpu that was online and collected a bunch of stats gets
>> offlined? The user will see stats get smaller?
>>
>> Perhaps this should be for_each_possible_cpu()? Although I'm not sure what
>> happens to percpu data when a cpu goes offline? Is the data preserved? Or wiped,
>> or unmapped? dunno. Might we need to rescue stats into a global counter at
>> offline-time?
> 
> Good catch. I see /proc/vmstat is always using the  for_each_online_cpu() but it
> doesn't have the issue, but mTHP counters do have the problem.
> 
> * step 1: cat  the current thp_swpout value before running a test
> program which does
> swpout;
> 
> / # cat /proc/vmstat | grep thp_swpout
> thp_swpout 0
> / # cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/anon_swpout
> 0
> 
> * step 2: run the test program on cpu2;
> 
> / # taskset -c 2 /home/barry/develop/linux/swpcache-2m
> 
> * step 3: cat the current thp_swpout value after running a test
> program which does
> swpout;
> 
> / # cat /proc/vmstat | grep thp_swpout
> thp_swpout 98
> / # cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/anon_swpout
> 98
> 
> *step 4: offline cpu2 and read thp_swpout;
> 
> / # echo 0 > /sys/devices/system/cpu/cpu2/online
> [  339.058661] psci: CPU2 killed (polled 0 ms)
> 
> / # cat /proc/vmstat | grep thp_swpout
> thp_swpout 98
> / # cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/anon_swpout
> 0
> 
> *step 5: online cpu2 and read thp_swpout
> 
> / # echo 1 > /sys/devices/system/cpu/cpu2/online
> [  791.642058] CPU2: Booted secondary processor 0x0000000002 [0x000f0510]
> 
> / # cat /proc/vmstat | grep thp_swpout
> thp_swpout 98
> / # cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/anon_swpout
> 98
> 
> 
> 
> As you can see, in step 4, /proc/vmstat is all good but mTHP counters become
> zero.
> 
> The reason is /proc/vmstat will fold the offline cpu to an online cpu
> but mthp counters lack
> it:
> 
> /*
>  * Fold the foreign cpu events into our own.
>  *
>  * This is adding to the events on one processor
>  * but keeps the global counts constant.
>  */
> void vm_events_fold_cpu(int cpu)
> {
>         struct vm_event_state *fold_state = &per_cpu(vm_event_states, cpu);
>         int i;
> 
>         for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
>                 count_vm_events(i, fold_state->event[i]);
>                 fold_state->event[i] = 0;
>         }
> }
> 
> static int page_alloc_cpu_dead(unsigned int cpu)
> {
>         ...
>         /*
>          * Spill the event counters of the dead processor
>          * into the current processors event counters.
>          * This artificially elevates the count of the current
>          * processor.
>          */
>         vm_events_fold_cpu(cpu);
>         ...
> 
>         return 0;
> }
> 
> So I will do the same thing for mTHP counters - fold offline cpu
> counters to online one.

That all looks like a complete mess - better avoided if possible! A quick search
for "for_each_possible_cpu" shows loads of places where code is iterating over
all *possible* cpus and grabbing its per-cpu data. So the data definitely
remains accessible when the cpu is offline. Looks like it doesn't get wiped either.

So can't you just change your sum function to iterate over all possible cpus?

> 
>>
>>> +             struct mthp_stat *this = &per_cpu(mthp_stats, cpu);
>>> +
>>> +             sum += this->stats[order][item];
>>> +     }
>>> +
>>> +     return sum;
>>> +}
>>> +
>>> +#define DEFINE_MTHP_STAT_ATTR(_name, _index)                                 \
>>> +static ssize_t _name##_show(struct kobject *kobj,                    \
>>> +                     struct kobj_attribute *attr, char *buf)         \
>>> +{                                                                    \
>>> +     int order = to_thpsize(kobj)->order;                            \
>>> +                                                                     \
>>> +     return sysfs_emit(buf, "%lu\n", sum_mthp_stat(order, _index));  \
>>> +}                                                                    \
>>> +static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
>>
>> Very nice!
> 
> Right. I got duplicated copy-paste and bad small in code so I wrote this macro.
> 
>>
>>> +
>>> +DEFINE_MTHP_STAT_ATTR(anon_alloc, MTHP_STAT_ANON_ALLOC);
>>> +DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_ANON_ALLOC_FALLBACK);
>>> +
>>> +static struct attribute *stats_attrs[] = {
>>> +     &anon_alloc_attr.attr,
>>> +     &anon_alloc_fallback_attr.attr,
>>> +     NULL,
>>> +};
>>> +
>>> +static struct attribute_group stats_attr_group = {
>>> +     .name = "stats",
>>> +     .attrs = stats_attrs,
>>> +};
>>> +
>>>  static struct thpsize *thpsize_create(int order, struct kobject *parent)
>>>  {
>>>       unsigned long size = (PAGE_SIZE << order) / SZ_1K;
>>> @@ -549,6 +589,12 @@ static struct thpsize *thpsize_create(int order, struct kobject *parent)
>>>               return ERR_PTR(ret);
>>>       }
>>>
>>> +     ret = sysfs_create_group(&thpsize->kobj, &stats_attr_group);
>>> +     if (ret) {
>>> +             kobject_put(&thpsize->kobj);
>>> +             return ERR_PTR(ret);
>>> +     }
>>> +
>>>       thpsize->order = order;
>>>       return thpsize;
>>>  }
>>> @@ -1050,8 +1096,10 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>>>       folio = vma_alloc_folio(gfp, HPAGE_PMD_ORDER, vma, haddr, true);
>>>       if (unlikely(!folio)) {
>>>               count_vm_event(THP_FAULT_FALLBACK);
>>> +             count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_ALLOC_FALLBACK);
>>
>> I think we should aim for the PMD-oder MTHP_STAT_ANON_ALLOC and
>> MTHP_STAT_ANON_ALLOC_FALLBACK to match THP_FAULT_ALLOC and THP_FAULT_FALLBACK.
>> Its not currently setup this way...
> 
> right. I also realized this and asked for your comments on this in another
> thread.

Ahh sorry - must have missed that.

> 
>>
>>
>>>               return VM_FAULT_FALLBACK;
>>>       }
>>> +     count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_ALLOC);
>>>       return __do_huge_pmd_anonymous_page(vmf, &folio->page, gfp);
>>>  }
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 649e3ed94487..1723c8ddf9cb 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -4374,8 +4374,10 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>>>                       }
>>>                       folio_throttle_swaprate(folio, gfp);
>>>                       clear_huge_page(&folio->page, vmf->address, 1 << order);
>>> +                     count_mthp_stat(order, MTHP_STAT_ANON_ALLOC);
>>>                       return folio;
>>>               }
>>> +             count_mthp_stat(order, MTHP_STAT_ANON_ALLOC_FALLBACK);
>>
>> ...And we should follow the usage same pattern for the smaller mTHP here too.
>> Which means MTHP_STAT_ANON_ALLOC_FALLBACK should be after the next: label. We
> 
> The only difference is the case
> 
> if (mem_cgroup_charge(folio, vma->vm_mm, gfp))
>       goto next;
> 
> but vmstat is counting this as fallback so i feel good to move after next,
> 
>         if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
>                 folio_put(folio);
>                 count_vm_event(THP_FAULT_FALLBACK);
>                 count_vm_event(THP_FAULT_FALLBACK_CHARGE);
>                 return VM_FAULT_FALLBACK;
>         }
> 
>> could introduce a MTHP_STAT_ANON_ALLOC_FALLBACK_CHARGE which would only trigger
>> on a fallback due to charge failure, just like THP_FAULT_FALLBACK_CHARGE?
> 
> it is fine to add this THP_FAULT_FALLBACK_CHARGE though it is not that
> useful for profiling buddy fragmentation.

Well I thought you were interested in isolating fallback due to fragmentation
only. You would get that with (FAULT_FALLBACK - FAULT_FALLBACK_CHARGE)? But if
you think the latter will be relatively small/unimportant for now, and therefore
FAULT_FALLBACK will give good enough approximation on its own, then I'm happy
not to add FAULT_FALLBACK_CHARGE for now.

> 
>>
>>>  next:
>>>               order = next_order(&orders, order);
>>>       }
>>
> 
> Thanks
> Barry


