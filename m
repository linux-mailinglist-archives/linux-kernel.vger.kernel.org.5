Return-Path: <linux-kernel+bounces-142508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFBD8A2C93
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FB61C23A8C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2196026AF9;
	Fri, 12 Apr 2024 10:38:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0D53D0D5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918334; cv=none; b=ibe4oIMxXEe9Jo8UDVoPGQGBWGes01uW5YA8zSBmXXs9Xo/LxoZgC6Tzt8/BCBu7s6mtmPTFo8TtrHWvm384gue2MNAH2nJicQSSn73QO5mBTEn/JwvpCC0+d2XEexDRTNl6pF0cn1gcu+Ea1Im7qwa4RZp2/4mAaba7wwqxeZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918334; c=relaxed/simple;
	bh=peEh+aN2RdBWZcfilXaf9BGhJLLLLegsXHBfZPhCmlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsJldtgeaTwLCDWRSZv2/R2B2/ZiGWVZcE/rcpPaE3/VaAnAlIzxnFL2pwHf8v/4j4fsgp8X5SzxL9CwI34P7IFiQHveunFaLiULijUMiUP8/VeepOAacLVezTDgOdBgMROWuNWrLDSPGROnaVaeDqD0RDLnoxguV7ma5FJZAtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F88F113E;
	Fri, 12 Apr 2024 03:39:21 -0700 (PDT)
Received: from [10.57.73.208] (unknown [10.57.73.208])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0159D3F64C;
	Fri, 12 Apr 2024 03:38:49 -0700 (PDT)
Message-ID: <c9f425fd-285b-46b6-821e-fb758a4101e0@arm.com>
Date: Fri, 12 Apr 2024 11:38:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] mm: add per-order mTHP anon_fault_alloc and
 anon_fault_fallback counters
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, cerasuolodomenico@gmail.com,
 chrisl@kernel.org, corbet@lwn.net, david@redhat.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, peterx@redhat.com,
 surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org,
 yosryahmed@google.com, yuzhao@google.com
References: <f5d6e014-5d6b-441c-8379-252ff24e2260@arm.com>
 <20240412101756.296971-1-21cnbao@gmail.com>
 <744fc49e-d91b-4f5a-9a27-1a25c50c2154@arm.com>
 <CAGsJ_4z6B09wbRFTXXek+pNi9yCHSSF+ZS2gph+AtViMhZyN9w@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4z6B09wbRFTXXek+pNi9yCHSSF+ZS2gph+AtViMhZyN9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/04/2024 11:29, Barry Song wrote:
> On Fri, Apr 12, 2024 at 10:25 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 12/04/2024 11:17, Barry Song wrote:
>>> On Fri, Apr 12, 2024 at 9:56 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> On 12/04/2024 10:43, Barry Song wrote:
>>>>> On Fri, Apr 12, 2024 at 9:27 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>
>>>>>> Hi Barry,
>>>>>>
>>>>>> 2 remaining comments - otherwise looks good. (same comments I just made in the
>>>>>> v4 conversation).
>>>>>>
>>>>>> On 12/04/2024 08:37, Barry Song wrote:
>>>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>>>
>>>>>>> Profiling a system blindly with mTHP has become challenging due to the
>>>>>>> lack of visibility into its operations.  Presenting the success rate of
>>>>>>> mTHP allocations appears to be pressing need.
>>>>>>>
>>>>>>> Recently, I've been experiencing significant difficulty debugging
>>>>>>> performance improvements and regressions without these figures.  It's
>>>>>>> crucial for us to understand the true effectiveness of mTHP in real-world
>>>>>>> scenarios, especially in systems with fragmented memory.
>>>>>>>
>>>>>>> This patch establishes the framework for per-order mTHP
>>>>>>> counters. It begins by introducing the anon_fault_alloc and
>>>>>>> anon_fault_fallback counters. Additionally, to maintain consistency
>>>>>>> with thp_fault_fallback_charge in /proc/vmstat, this patch also tracks
>>>>>>> anon_fault_fallback_charge when mem_cgroup_charge fails for mTHP.
>>>>>>> Incorporating additional counters should now be straightforward as well.
>>>>>>>
>>>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>>>>> Cc: Chris Li <chrisl@kernel.org>
>>>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>>>> Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
>>>>>>> Cc: Kairui Song <kasong@tencent.com>
>>>>>>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>>>>>>> Cc: Peter Xu <peterx@redhat.com>
>>>>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>> Cc: Suren Baghdasaryan <surenb@google.com>
>>>>>>> Cc: Yosry Ahmed <yosryahmed@google.com>
>>>>>>> Cc: Yu Zhao <yuzhao@google.com>
>>>>>>> ---
>>>>>>>  include/linux/huge_mm.h | 51 ++++++++++++++++++++++++++++++++++
>>>>>>>  mm/huge_memory.c        | 61 +++++++++++++++++++++++++++++++++++++++++
>>>>>>>  mm/memory.c             |  3 ++
>>>>>>>  mm/page_alloc.c         |  4 +++
>>>>>>>  4 files changed, 119 insertions(+)
>>>>>>>
>>>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>>>> index e896ca4760f6..c5beb54b97cb 100644
>>>>>>> --- a/include/linux/huge_mm.h
>>>>>>> +++ b/include/linux/huge_mm.h
>>>>>>> @@ -264,6 +264,57 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>>>>>>>                                         enforce_sysfs, orders);
>>>>>>>  }
>>>>>>>
>>>>>>> +enum mthp_stat_item {
>>>>>>> +     MTHP_STAT_ANON_FAULT_ALLOC,
>>>>>>> +     MTHP_STAT_ANON_FAULT_FALLBACK,
>>>>>>> +     MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>>>>>>> +     __MTHP_STAT_COUNT
>>>>>>> +};
>>>>>>> +
>>>>>>> +struct mthp_stat {
>>>>>>> +     unsigned long stats[0][__MTHP_STAT_COUNT];
>>>>>>> +};
>>>>>>> +
>>>>>>> +extern struct mthp_stat __percpu *mthp_stats;
>>>>>>> +
>>>>>>> +static inline void count_mthp_stat(int order, enum mthp_stat_item item)
>>>>>>> +{
>>>>>>> +     if (order <= 0 || order > PMD_ORDER || !mthp_stats)
>>>>>>> +             return;
>>>>>>> +
>>>>>>> +     this_cpu_inc(mthp_stats->stats[order][item]);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline void count_mthp_stats(int order, enum mthp_stat_item item, long delta)
>>>>>>> +{
>>>>>>> +     if (order <= 0 || order > PMD_ORDER || !mthp_stats)
>>>>>>> +             return;
>>>>>>> +
>>>>>>> +     this_cpu_add(mthp_stats->stats[order][item], delta);
>>>>>>> +}
>>>>>>> +
>>>>>>> +/*
>>>>>>> + * Fold the foreign cpu mthp stats into our own.
>>>>>>> + *
>>>>>>> + * This is adding to the stats on one processor
>>>>>>> + * but keeps the global counts constant.
>>>>>>> + */
>>>>>>> +static inline void mthp_stats_fold_cpu(int cpu)
>>>>>>> +{
>>>>>>> +     struct mthp_stat *fold_stat;
>>>>>>> +     int i, j;
>>>>>>> +
>>>>>>> +     if (!mthp_stats)
>>>>>>> +             return;
>>>>>>> +     fold_stat = per_cpu_ptr(mthp_stats, cpu);
>>>>>>> +     for (i = 1; i <= PMD_ORDER; i++) {
>>>>>>> +             for (j = 0; j < __MTHP_STAT_COUNT; j++) {
>>>>>>> +                     count_mthp_stats(i, j, fold_stat->stats[i][j]);
>>>>>>> +                     fold_stat->stats[i][j] = 0;
>>>>>>> +             }
>>>>>>> +     }
>>>>>>> +}
>>>>>>
>>>>>> This is a pretty horrible hack; I'm pretty sure just summing for all *possible*
>>>>>> cpus should work.
>>>>>>
>>>>>>> +
>>>>>>>  #define transparent_hugepage_use_zero_page()                         \
>>>>>>>       (transparent_hugepage_flags &                                   \
>>>>>>>        (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
>>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>>> index dc30139590e6..21c4ac74b484 100644
>>>>>>> --- a/mm/huge_memory.c
>>>>>>> +++ b/mm/huge_memory.c
>>>>>>> @@ -526,6 +526,50 @@ static const struct kobj_type thpsize_ktype = {
>>>>>>>       .sysfs_ops = &kobj_sysfs_ops,
>>>>>>>  };
>>>>>>>
>>>>>>> +struct mthp_stat __percpu *mthp_stats;
>>>>>>> +
>>>>>>> +static unsigned long sum_mthp_stat(int order, enum mthp_stat_item item)
>>>>>>> +{
>>>>>>> +     unsigned long sum = 0;
>>>>>>> +     int cpu;
>>>>>>> +
>>>>>>> +     cpus_read_lock();
>>>>>>> +     for_each_online_cpu(cpu) {
>>>>>>> +             struct mthp_stat *this = per_cpu_ptr(mthp_stats, cpu);
>>>>>>> +
>>>>>>> +             sum += this->stats[order][item];
>>>>>>> +     }
>>>>>>> +     cpus_read_unlock();
>>>>>>> +
>>>>>>> +     return sum;
>>>>>>> +}
>>>>>>> +
>>>>>>> +#define DEFINE_MTHP_STAT_ATTR(_name, _index)                                 \
>>>>>>> +static ssize_t _name##_show(struct kobject *kobj,                    \
>>>>>>> +                     struct kobj_attribute *attr, char *buf)         \
>>>>>>> +{                                                                    \
>>>>>>> +     int order = to_thpsize(kobj)->order;                            \
>>>>>>> +                                                                     \
>>>>>>> +     return sysfs_emit(buf, "%lu\n", sum_mthp_stat(order, _index));  \
>>>>>>> +}                                                                    \
>>>>>>> +static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
>>>>>>> +
>>>>>>> +DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
>>>>>>> +DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>>>>>>> +DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>>>>>>> +
>>>>>>> +static struct attribute *stats_attrs[] = {
>>>>>>> +     &anon_fault_alloc_attr.attr,
>>>>>>> +     &anon_fault_fallback_attr.attr,
>>>>>>> +     &anon_fault_fallback_charge_attr.attr,
>>>>>>> +     NULL,
>>>>>>> +};
>>>>>>> +
>>>>>>> +static struct attribute_group stats_attr_group = {
>>>>>>> +     .name = "stats",
>>>>>>> +     .attrs = stats_attrs,
>>>>>>> +};
>>>>>>> +
>>>>>>>  static struct thpsize *thpsize_create(int order, struct kobject *parent)
>>>>>>>  {
>>>>>>>       unsigned long size = (PAGE_SIZE << order) / SZ_1K;
>>>>>>> @@ -549,6 +593,12 @@ static struct thpsize *thpsize_create(int order, struct kobject *parent)
>>>>>>>               return ERR_PTR(ret);
>>>>>>>       }
>>>>>>>
>>>>>>> +     ret = sysfs_create_group(&thpsize->kobj, &stats_attr_group);
>>>>>>> +     if (ret) {
>>>>>>> +             kobject_put(&thpsize->kobj);
>>>>>>> +             return ERR_PTR(ret);
>>>>>>> +     }
>>>>>>> +
>>>>>>>       thpsize->order = order;
>>>>>>>       return thpsize;
>>>>>>>  }
>>>>>>> @@ -691,6 +741,11 @@ static int __init hugepage_init(void)
>>>>>>>        */
>>>>>>>       MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER < 2);
>>>>>>>
>>>>>>> +     mthp_stats = __alloc_percpu((PMD_ORDER + 1) * sizeof(mthp_stats->stats[0]),
>>>>>>> +                     sizeof(unsigned long));
>>>>>>
>>>>>> Personally I think it would be cleaner to allocate statically using
>>>>>> ilog2(MAX_PTRS_PER_PTE) instead of PMD_ORDER.
>>>>>
>>>>> Hi Ryan,
>>>>>
>>>>> I don't understand why MAX_PTRS_PER_PTE is the correct size. For ARM64,
>>>>>
>>>>> #define PMD_ORDER       (PMD_SHIFT - PAGE_SHIFT)
>>>>>
>>>>> #define MAX_PTRS_PER_PTE PTRS_PER_PTE
>>>>>
>>>>> #define PTRS_PER_PTE            (1 << (PAGE_SHIFT - 3))
>>>>>
>>>>> while PAGE_SIZE is 16KiB or 64KiB, PTRS_PER_PTE can be a huge number?
>>>>>
>>>>>
>>>>> Am I missing something?
>>>>
>>>> PTRS_PER_PTE is the number of PTE entries in a PTE table. On arm64 its as follows:
>>>>
>>>> PAGE_SIZE       PAGE_SHIFT      PTRS_PER_PTE
>>>> 4K              12              512
>>>> 16K             14              2048
>>>> 64K             16              8192
>>>>
>>>> So (PTRS_PER_PTE * PAGE_SIZE) = PMD_SIZE
>>>>
>>>> PMD_ORDER is ilog2(PMD_SIZE / PAGE_SIZE) = ilog2(PTRS_PER_PTE)
>>>>
>>>> MAX_PTRS_PER_PTE is just the maximum value that PTRS_PER_PTE will ever have,
>>>> (and its equal to PTRS_PER_PTE except for powerpc).
>>>>
>>>> Pretty sure the math is correct?
>>>
>>> I am not convinced the math is correct :-)
>>>
>>> while page size is 64KiB, the page table is as below,
>>> PMD_ORDER = L2 index bits = [41:29] = 13 != ilog2(8192)
>>
>> 1 << 13 = 8192
>>
>> Right? So:
>>
>> ilog2(8192) = 13
>>
>> What's wrong with that?
>>
>> I even checked in Python to make sure I'm not going mad:
>>
>>>>> import math
>>>>> math.log2(8192)
>> 13.0
> 
> You're correct. My mind fixated on the '16' in the line '64K 16 8192'.
> I mistakenly thought ilog2(8192) equals 16. Apologies for the confusion.

No worries! We got there in the end :)

Of course my suggestion relies on being able to get a compile-time constant from
ilog2(MAX_PTRS_PER_PTE). I think that should work, right?

> 
>>
>>>
>>>
>>> +--------+--------+--------+--------+--------+--------+--------+--------+
>>> |63    56|55    48|47    40|39    32|31    24|23    16|15     8|7      0|
>>> +--------+--------+--------+--------+--------+--------+--------+--------+
>>>  |                 |    |               |              |
>>>  |                 |    |               |              v
>>>  |                 |    |               |            [15:0]  in-page offset
>>>  |                 |    |               +----------> [28:16] L3 index
>>>  |                 |    +--------------------------> [41:29] L2 index
>>>  |                 +-------------------------------> [47:42] L1 index (48-bit)
>>>  |                                                   [51:42] L1 index (52-bit)
>>>  +-------------------------------------------------> [63] TTBR0/1
>>>
>>> while page size is 4KiB, the page table is as below,
>>>
>>> +--------+--------+--------+--------+--------+--------+--------+--------+
>>> |63    56|55    48|47    40|39    32|31    24|23    16|15     8|7      0|
>>> +--------+--------+--------+--------+--------+--------+--------+--------+
>>>  |                 |         |         |         |         |
>>>  |                 |         |         |         |         v
>>>  |                 |         |         |         |   [11:0]  in-page offset
>>>  |                 |         |         |         +-> [20:12] L3 index
>>>  |                 |         |         +-----------> [29:21] L2 index
>>>  |                 |         +---------------------> [38:30] L1 index
>>>  |                 +-------------------------------> [47:39] L0 index
>>>  +-------------------------------------------------> [63] TTBR0/1
>>>
>>> PMD_ORDER = L2 index bits = [29:21] = 9 = ilog2(512).
>>>
>>> You are only correct while page size = 4KiB.
>>>
>>>
>>>
>>>
>>


