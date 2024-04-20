Return-Path: <linux-kernel+bounces-152203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A258ABAB0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4AEB1F22479
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 09:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DDD16415;
	Sat, 20 Apr 2024 09:14:10 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE0615E88
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604450; cv=none; b=BnpEDYNRZNC1BgEDqp769He+enl/PxQ0/fLTIcgXH5DL504L4aSdxrVYtkHD2xRPRhQpZoiR9ZfoibjdkJs0MBzjdC+00e/f2B/Ym0B5e34vGS7r3rzLq1TIxPSt+Nl7ItID2f1+ngUSX1vA4Hwf9OjD9DrnRVRhU9Vz9edISMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604450; c=relaxed/simple;
	bh=u/JrEKpD/CTyDLgORnyx5mV9c5+sehKctGwhwxhzzMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D+tD5GmS9/RMPEj5Ch4zhSQbdhNs4rDsuBd2AK36QBQrd+DeIhid1k5uhDIjHUWRIv+c//RLED53NgZKsxa9xdefosCpggxnxB/8kEAXSR232ydembCrf2UwCA+lpGSeXmkeHSuuaHxrOL859DcJWArCTO2SQJeviIPgsAeBTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VM4k82YhvzwSkd;
	Sat, 20 Apr 2024 16:41:36 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CEB018007D;
	Sat, 20 Apr 2024 16:44:42 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 20 Apr 2024 16:44:41 +0800
Message-ID: <f44fa4b9-66a3-33f3-e0dc-fdc8ab451033@huawei.com>
Date: Sat, 20 Apr 2024 16:44:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v2 2/2] mm: convert mm's rss stats to use atomic mode
Content-Language: en-US
To: Rongwei Wang <rongwei.wrw@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <akpm@linux-foundation.org>, <dennisszhou@gmail.com>,
	<shakeelb@google.com>, <jack@suse.cz>, <surenb@google.com>,
	<kent.overstreet@linux.dev>, <mhocko@suse.cz>, <vbabka@suse.cz>,
	<yuzhao@google.com>, <yu.ma@intel.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>
References: <20240418142008.2775308-1-zhangpeng362@huawei.com>
 <20240418142008.2775308-3-zhangpeng362@huawei.com>
 <ec2b110b-fb85-4af2-942b-645511a32297@gmail.com>
 <c1c79eb5-4d48-40e5-6f17-f8bc42f2d274@huawei.com>
 <6a3b8095-8f49-47e0-a347-9e4a51806bf8@gmail.com>
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <6a3b8095-8f49-47e0-a347-9e4a51806bf8@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2024/4/20 11:13, Rongwei Wang wrote:

> On 2024/4/19 11:32, zhangpeng (AS) wrote:
>> On 2024/4/19 10:30, Rongwei Wang wrote:
>>
>>> On 2024/4/18 22:20, Peng Zhang wrote:
>>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>>
>>>> Since commit f1a7941243c1 ("mm: convert mm's rss stats into
>>>> percpu_counter"), the rss_stats have converted into percpu_counter,
>>>> which convert the error margin from (nr_threads * 64) to approximately
>>>> (nr_cpus ^ 2). However, the new percpu allocation in mm_init() 
>>>> causes a
>>>> performance regression on fork/exec/shell. Even after commit 
>>>> 14ef95be6f55
>>>> ("kernel/fork: group allocation/free of per-cpu counters for mm 
>>>> struct"),
>>>> the performance of fork/exec/shell is still poor compared to previous
>>>> kernel versions.
>>>>
>>>> To mitigate performance regression, we delay the allocation of percpu
>>>> memory for rss_stats. Therefore, we convert mm's rss stats to use
>>>> percpu_counter atomic mode. For single-thread processes, rss_stat 
>>>> is in
>>>> atomic mode, which reduces the memory consumption and performance
>>>> regression caused by using percpu. For multiple-thread processes,
>>>> rss_stat is switched to the percpu mode to reduce the error margin.
>>>> We convert rss_stats from atomic mode to percpu mode only when the
>>>> second thread is created.
>>> Hi, Zhang Peng
>>>
>>> This regression we also found it in lmbench these days. I have not 
>>> test your patch, but it seems will solve a lot for it.
>>> And I see this patch not fix the regression in multi-threads, that's 
>>> because of the rss_stat switched to percpu mode?
>>> (If I'm wrong, please correct me.) And It seems percpu_counter also 
>>> has a bad effect in exit_mmap().
>>>
>>> If so, I'm wondering if we can further improving it on the 
>>> exit_mmap() path in multi-threads scenario, e.g. to determine which 
>>> CPUs the process has run on (mm_cpumask()? I'm not sure).
>>>
>> Hi, Rongwei,
>>
>> Yes, this patch only fixes the regression in single-thread processes. 
>> How
>> much bad effect does percpu_counter have in exit_mmap()? IMHO, the 
>> addition
> Actually, I not sure, just found a little free percpu hotspot in 
> exit_mmap() path when comparing 4 core vs 32 cores.
>
> I can test more next.

Thanks, it would be better if there is test data.

>> of mm counter is already in batch mode, maybe I miss something?
>>
>>>>
>>>> After lmbench test, we can get 2% ~ 4% performance improvement
>>>> for lmbench fork_proc/exec_proc/shell_proc and 6.7% performance
>>>> improvement for lmbench page_fault (before batch mode[1]).
>>>>
>>>> The test results are as follows:
>>>>
>>>>               base           base+revert        base+this patch
>>>>
>>>> fork_proc    416.3ms        400.0ms  (3.9%)    398.6ms (4.2%)
>>>> exec_proc    2095.9ms       2061.1ms (1.7%)    2047.7ms (2.3%)
>>>> shell_proc   3028.2ms       2954.7ms (2.4%)    2961.2ms (2.2%)
>>>> page_fault   0.3603ms       0.3358ms (6.8%)    0.3361ms (6.7%)
>>> I think the regression will becomes more obvious if more cores. How 
>>> about your test machine?
>>>
>> Maybe multi-core is not a factor in the performance of the lmbench 
>> test here.
>> Both of my test machines have 96 cores.
>>
>>> Thanks,
>>> -wrw
>>>>
>>>> [1] 
>>>> https://lore.kernel.org/all/20240412064751.119015-1-wangkefeng.wang@huawei.com/
>>>>
>>>> Suggested-by: Jan Kara <jack@suse.cz>
>>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> ---
>>>>   include/linux/mm.h          | 50 
>>>> +++++++++++++++++++++++++++++++------
>>>>   include/trace/events/kmem.h |  4 +--
>>>>   kernel/fork.c               | 18 +++++++------
>>>>   3 files changed, 56 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index d261e45bb29b..8f1bfbd54697 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -2631,30 +2631,66 @@ static inline bool 
>>>> get_user_page_fast_only(unsigned long addr,
>>>>    */
>>>>   static inline unsigned long get_mm_counter(struct mm_struct *mm, 
>>>> int member)
>>>>   {
>>>> -    return percpu_counter_read_positive(&mm->rss_stat[member]);
>>>> +    struct percpu_counter *fbc = &mm->rss_stat[member];
>>>> +
>>>> +    if (percpu_counter_initialized(fbc))
>>>> +        return percpu_counter_read_positive(fbc);
>>>> +
>>>> +    return percpu_counter_atomic_read(fbc);
>>>>   }
>>>>     void mm_trace_rss_stat(struct mm_struct *mm, int member);
>>>>     static inline void add_mm_counter(struct mm_struct *mm, int 
>>>> member, long value)
>>>>   {
>>>> -    percpu_counter_add(&mm->rss_stat[member], value);
>>>> +    struct percpu_counter *fbc = &mm->rss_stat[member];
>>>> +
>>>> +    if (percpu_counter_initialized(fbc))
>>>> +        percpu_counter_add(fbc, value);
>>>> +    else
>>>> +        percpu_counter_atomic_add(fbc, value);
>>>>         mm_trace_rss_stat(mm, member);
>>>>   }
>>>>     static inline void inc_mm_counter(struct mm_struct *mm, int 
>>>> member)
>>>>   {
>>>> -    percpu_counter_inc(&mm->rss_stat[member]);
>>>> -
>>>> -    mm_trace_rss_stat(mm, member);
>>>> +    add_mm_counter(mm, member, 1);
>>>>   }
>>>>     static inline void dec_mm_counter(struct mm_struct *mm, int 
>>>> member)
>>>>   {
>>>> -    percpu_counter_dec(&mm->rss_stat[member]);
>>>> +    add_mm_counter(mm, member, -1);
>>>> +}
>>>>   -    mm_trace_rss_stat(mm, member);
>>>> +static inline s64 mm_counter_sum(struct mm_struct *mm, int member)
>>>> +{
>>>> +    struct percpu_counter *fbc = &mm->rss_stat[member];
>>>> +
>>>> +    if (percpu_counter_initialized(fbc))
>>>> +        return percpu_counter_sum(fbc);
>>>> +
>>>> +    return percpu_counter_atomic_read(fbc);
>>>> +}
>>>> +
>>>> +static inline s64 mm_counter_sum_positive(struct mm_struct *mm, 
>>>> int member)
>>>> +{
>>>> +    struct percpu_counter *fbc = &mm->rss_stat[member];
>>>> +
>>>> +    if (percpu_counter_initialized(fbc))
>>>> +        return percpu_counter_sum_positive(fbc);
>>>> +
>>>> +    return percpu_counter_atomic_read(fbc);
>>>> +}
>>>> +
>>>> +static inline int mm_counter_switch_to_pcpu_many(struct mm_struct 
>>>> *mm)
>>>> +{
>>>> +    return percpu_counter_switch_to_pcpu_many(mm->rss_stat, 
>>>> NR_MM_COUNTERS);
>>>> +}
>>>> +
>>>> +static inline void mm_counter_destroy_many(struct mm_struct *mm)
>>>> +{
>>>> +    percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
>>>>   }
>>>>     /* Optimized variant when folio is already known not to be anon */
>>>> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
>>>> index 6e62cc64cd92..a4e40ae6a8c8 100644
>>>> --- a/include/trace/events/kmem.h
>>>> +++ b/include/trace/events/kmem.h
>>>> @@ -399,8 +399,8 @@ TRACE_EVENT(rss_stat,
>>>>           __entry->mm_id = mm_ptr_to_hash(mm);
>>>>           __entry->curr = !!(current->mm == mm);
>>>>           __entry->member = member;
>>>> -        __entry->size = 
>>>> (percpu_counter_sum_positive(&mm->rss_stat[member])
>>>> -                                << PAGE_SHIFT);
>>>> +        __entry->size = (mm_counter_sum_positive(mm, member)
>>>> +                            << PAGE_SHIFT);
>>>>       ),
>>>>         TP_printk("mm_id=%u curr=%d type=%s size=%ldB",
>>>> diff --git a/kernel/fork.c b/kernel/fork.c
>>>> index 99076dbe27d8..0214273798c5 100644
>>>> --- a/kernel/fork.c
>>>> +++ b/kernel/fork.c
>>>> @@ -823,7 +823,7 @@ static void check_mm(struct mm_struct *mm)
>>>>                "Please make sure 'struct resident_page_types[]' is 
>>>> updated as well");
>>>>         for (i = 0; i < NR_MM_COUNTERS; i++) {
>>>> -        long x = percpu_counter_sum(&mm->rss_stat[i]);
>>>> +        long x = mm_counter_sum(mm, i);
>>>>             if (unlikely(x))
>>>>               pr_alert("BUG: Bad rss-counter state mm:%p type:%s 
>>>> val:%ld\n",
>>>> @@ -1301,16 +1301,10 @@ static struct mm_struct *mm_init(struct 
>>>> mm_struct *mm, struct task_struct *p,
>>>>       if (mm_alloc_cid(mm))
>>>>           goto fail_cid;
>>>>   -    if (percpu_counter_init_many(mm->rss_stat, 0, 
>>>> GFP_KERNEL_ACCOUNT,
>>>> -                     NR_MM_COUNTERS))
>>>> -        goto fail_pcpu;
>>>> -
>>>>       mm->user_ns = get_user_ns(user_ns);
>>>>       lru_gen_init_mm(mm);
>>>>       return mm;
>>>>   -fail_pcpu:
>>>> -    mm_destroy_cid(mm);
>>>>   fail_cid:
>>>>       destroy_context(mm);
>>>>   fail_nocontext:
>>>> @@ -1730,6 +1724,16 @@ static int copy_mm(unsigned long 
>>>> clone_flags, struct task_struct *tsk)
>>>>       if (!oldmm)
>>>>           return 0;
>>>>   +    /*
>>>> +     * For single-thread processes, rss_stat is in atomic mode, which
>>>> +     * reduces the memory consumption and performance regression 
>>>> caused by
>>>> +     * using percpu. For multiple-thread processes, rss_stat is 
>>>> switched to
>>>> +     * the percpu mode to reduce the error margin.
>>>> +     */
>>>> +    if (clone_flags & CLONE_THREAD)
>>>> +        if (mm_counter_switch_to_pcpu_many(oldmm))
>>>> +            return -ENOMEM;
>>>> +
>>>>       if (clone_flags & CLONE_VM) {
>>>>           mmget(oldmm);
>>>>           mm = oldmm;
>>>
>>>
>
>
-- 
Best Regards,
Peng


