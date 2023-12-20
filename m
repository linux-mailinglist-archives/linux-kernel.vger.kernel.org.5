Return-Path: <linux-kernel+bounces-6847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5985D819E78
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E3B287FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E278C2231D;
	Wed, 20 Dec 2023 11:52:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE2322320
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1461B1FB;
	Wed, 20 Dec 2023 03:52:43 -0800 (PST)
Received: from [10.57.75.247] (unknown [10.57.75.247])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9456B3F5A1;
	Wed, 20 Dec 2023 03:51:53 -0800 (PST)
Message-ID: <ade26f27-03af-4ad7-ad81-38b482f7572c@arm.com>
Date: Wed, 20 Dec 2023 11:51:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/16] mm: Batch-copy PTE ranges during fork()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>,
 Mark Rutland <mark.rutland@arm.com>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, John Hubbard <jhubbard@nvidia.com>,
 Zi Yan <ziy@nvidia.com>, Barry Song <21cnbao@gmail.com>,
 Alistair Popple <apopple@nvidia.com>, Yang Shi <shy828301@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20231218105100.172635-1-ryan.roberts@arm.com>
 <20231218105100.172635-3-ryan.roberts@arm.com>
 <0bef5423-6eea-446b-8854-980e9c23a948@redhat.com>
 <db1be625-33e4-4d07-8500-3f7d3c8f9937@arm.com>
 <be8b5181-be2c-4800-ba53-c65a6c3ed803@redhat.com>
 <dd227e51-c4b2-420b-a92a-65da85ab4018@arm.com>
 <7c0236ad-01f3-437f-8b04-125d69e90dc0@redhat.com>
 <9a58b1a2-2c13-4fa0-8ffa-2b3d9655f1b6@arm.com>
 <28968568-f920-47ac-b6fd-87528ffd8f77@redhat.com>
 <10b0b562-c1c0-4a66-9aeb-a6bff5c218f6@arm.com>
 <8f8023cb-3c31-4ead-a9e6-03a10e9490c6@redhat.com>
 <da16a7e5-76dd-4150-9ade-54b0d227a1e1@arm.com>
 <699cb1db-51eb-460e-9ceb-1ce08ca03050@redhat.com>
 <da29a4c6-61f6-4203-9c82-9ce6e1c32552@arm.com>
 <2a8c5b6c-f5ae-43b2-99aa-6d10e79b76e1@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2a8c5b6c-f5ae-43b2-99aa-6d10e79b76e1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/12/2023 11:36, David Hildenbrand wrote:
> On 20.12.23 12:28, Ryan Roberts wrote:
>> On 20/12/2023 10:56, David Hildenbrand wrote:
>>> On 20.12.23 11:41, Ryan Roberts wrote:
>>>> On 20/12/2023 10:16, David Hildenbrand wrote:
>>>>> On 20.12.23 11:11, Ryan Roberts wrote:
>>>>>> On 20/12/2023 09:54, David Hildenbrand wrote:
>>>>>>> On 20.12.23 10:51, Ryan Roberts wrote:
>>>>>>>> On 20/12/2023 09:17, David Hildenbrand wrote:
>>>>>>>>> On 19.12.23 18:42, Ryan Roberts wrote:
>>>>>>>>>> On 19/12/2023 17:22, David Hildenbrand wrote:
>>>>>>>>>>> On 19.12.23 09:30, Ryan Roberts wrote:
>>>>>>>>>>>> On 18/12/2023 17:47, David Hildenbrand wrote:
>>>>>>>>>>>>> On 18.12.23 11:50, Ryan Roberts wrote:
>>>>>>>>>>>>>> Convert copy_pte_range() to copy a batch of ptes in one go. A given
>>>>>>>>>>>>>> batch is determined by the architecture with the new helper,
>>>>>>>>>>>>>> pte_batch_remaining(), and maps a physically contiguous block of
>>>>>>>>>>>>>> memory,
>>>>>>>>>>>>>> all belonging to the same folio. A pte batch is then
>>>>>>>>>>>>>> write-protected in
>>>>>>>>>>>>>> one go in the parent using the new helper, ptep_set_wrprotects()
>>>>>>>>>>>>>> and is
>>>>>>>>>>>>>> set in one go in the child using the new helper, set_ptes_full().
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The primary motivation for this change is to reduce the number of tlb
>>>>>>>>>>>>>> maintenance operations that the arm64 backend has to perform during
>>>>>>>>>>>>>> fork, as it is about to add transparent support for the "contiguous
>>>>>>>>>>>>>> bit"
>>>>>>>>>>>>>> in its ptes. By write-protecting the parent using the new
>>>>>>>>>>>>>> ptep_set_wrprotects() (note the 's' at the end) function, the backend
>>>>>>>>>>>>>> can avoid having to unfold contig ranges of PTEs, which is expensive,
>>>>>>>>>>>>>> when all ptes in the range are being write-protected. Similarly, by
>>>>>>>>>>>>>> using set_ptes_full() rather than set_pte_at() to set up ptes in the
>>>>>>>>>>>>>> child, the backend does not need to fold a contiguous range once they
>>>>>>>>>>>>>> are all populated - they can be initially populated as a contiguous
>>>>>>>>>>>>>> range in the first place.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This code is very performance sensitive, and a significant amount of
>>>>>>>>>>>>>> effort has been put into not regressing performance for the order-0
>>>>>>>>>>>>>> folio case. By default, pte_batch_remaining() is compile constant 1,
>>>>>>>>>>>>>> which enables the compiler to simplify the extra loops that are added
>>>>>>>>>>>>>> for batching and produce code that is equivalent (and equally
>>>>>>>>>>>>>> performant) as the previous implementation.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This change addresses the core-mm refactoring only and a separate
>>>>>>>>>>>>>> change
>>>>>>>>>>>>>> will implement pte_batch_remaining(), ptep_set_wrprotects() and
>>>>>>>>>>>>>> set_ptes_full() in the arm64 backend to realize the performance
>>>>>>>>>>>>>> improvement as part of the work to enable contpte mappings.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> To ensure the arm64 is performant once implemented, this change is
>>>>>>>>>>>>>> very
>>>>>>>>>>>>>> careful to only call ptep_get() once per pte batch.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The following microbenchmark results demonstate that there is no
>>>>>>>>>>>>>> significant performance change after this patch. Fork is called in a
>>>>>>>>>>>>>> tight loop in a process with 1G of populated memory and the time for
>>>>>>>>>>>>>> the
>>>>>>>>>>>>>> function to execute is measured. 100 iterations per run, 8 runs
>>>>>>>>>>>>>> performed on both Apple M2 (VM) and Ampere Altra (bare metal). Tests
>>>>>>>>>>>>>> performed for case where 1G memory is comprised of order-0 folios and
>>>>>>>>>>>>>> case where comprised of pte-mapped order-9 folios. Negative is
>>>>>>>>>>>>>> faster,
>>>>>>>>>>>>>> positive is slower, compared to baseline upon which the series is
>>>>>>>>>>>>>> based:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> | Apple M2 VM   | order-0 (pte-map) | order-9 (pte-map) |
>>>>>>>>>>>>>> | fork          |-------------------|-------------------|
>>>>>>>>>>>>>> | microbench    |    mean |   stdev |    mean |   stdev |
>>>>>>>>>>>>>> |---------------|---------|---------|---------|---------|
>>>>>>>>>>>>>> | baseline      |    0.0% |    1.1% |    0.0% |    1.2% |
>>>>>>>>>>>>>> | after-change  |   -1.0% |    2.0% |   -0.1% |    1.1% |
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> | Ampere Altra  | order-0 (pte-map) | order-9 (pte-map) |
>>>>>>>>>>>>>> | fork          |-------------------|-------------------|
>>>>>>>>>>>>>> | microbench    |    mean |   stdev |    mean |   stdev |
>>>>>>>>>>>>>> |---------------|---------|---------|---------|---------|
>>>>>>>>>>>>>> | baseline      |    0.0% |    1.0% |    0.0% |    0.1% |
>>>>>>>>>>>>>> | after-change  |   -0.1% |    1.2% |   -0.1% |    0.1% |
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Tested-by: John Hubbard <jhubbard@nvidia.com>
>>>>>>>>>>>>>> Reviewed-by: Alistair Popple <apopple@nvidia.com>
>>>>>>>>>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>         include/linux/pgtable.h | 80
>>>>>>>>>>>>>> +++++++++++++++++++++++++++++++++++
>>>>>>>>>>>>>>         mm/memory.c             | 92
>>>>>>>>>>>>>> ++++++++++++++++++++++++++---------------
>>>>>>>>>>>>>>         2 files changed, 139 insertions(+), 33 deletions(-)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>>>>>>>>>>>> index af7639c3b0a3..db93fb81465a 100644
>>>>>>>>>>>>>> --- a/include/linux/pgtable.h
>>>>>>>>>>>>>> +++ b/include/linux/pgtable.h
>>>>>>>>>>>>>> @@ -205,6 +205,27 @@ static inline int pmd_young(pmd_t pmd)
>>>>>>>>>>>>>>         #define arch_flush_lazy_mmu_mode()    do {} while (0)
>>>>>>>>>>>>>>         #endif
>>>>>>>>>>>>>>         +#ifndef pte_batch_remaining
>>>>>>>>>>>>>> +/**
>>>>>>>>>>>>>> + * pte_batch_remaining - Number of pages from addr to next batch
>>>>>>>>>>>>>> boundary.
>>>>>>>>>>>>>> + * @pte: Page table entry for the first page.
>>>>>>>>>>>>>> + * @addr: Address of the first page.
>>>>>>>>>>>>>> + * @end: Batch ceiling (e.g. end of vma).
>>>>>>>>>>>>>> + *
>>>>>>>>>>>>>> + * Some architectures (arm64) can efficiently modify a contiguous
>>>>>>>>>>>>>> batch of
>>>>>>>>>>>>>> ptes.
>>>>>>>>>>>>>> + * In such cases, this function returns the remaining number of
>>>>>>>>>>>>>> pages to
>>>>>>>>>>>>>> the end
>>>>>>>>>>>>>> + * of the current batch, as defined by addr. This can be useful when
>>>>>>>>>>>>>> iterating
>>>>>>>>>>>>>> + * over ptes.
>>>>>>>>>>>>>> + *
>>>>>>>>>>>>>> + * May be overridden by the architecture, else batch size is
>>>>>>>>>>>>>> always 1.
>>>>>>>>>>>>>> + */
>>>>>>>>>>>>>> +static inline unsigned int pte_batch_remaining(pte_t pte, unsigned
>>>>>>>>>>>>>> long
>>>>>>>>>>>>>> addr,
>>>>>>>>>>>>>> +                        unsigned long end)
>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>> +    return 1;
>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>> +#endif
>>>>>>>>>>>>>
>>>>>>>>>>>>> It's a shame we now lose the optimization for all other archtiectures.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Was there no way to have some basic batching mechanism that doesn't
>>>>>>>>>>>>> require
>>>>>>>>>>>>> arch
>>>>>>>>>>>>> specifics?
>>>>>>>>>>>>
>>>>>>>>>>>> I tried a bunch of things but ultimately the way I've done it was the
>>>>>>>>>>>> only
>>>>>>>>>>>> way
>>>>>>>>>>>> to reduce the order-0 fork regression to 0.
>>>>>>>>>>>>
>>>>>>>>>>>> My original v3 posting was costing 5% extra and even my first attempt
>>>>>>>>>>>> at an
>>>>>>>>>>>> arch-specific version that didn't resolve to a compile-time constant 1
>>>>>>>>>>>> still
>>>>>>>>>>>> cost an extra 3%.
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> I'd have thought that something very basic would have worked like:
>>>>>>>>>>>>>
>>>>>>>>>>>>> * Check if PTE is the same when setting the PFN to 0.
>>>>>>>>>>>>> * Check that PFN is consecutive
>>>>>>>>>>>>> * Check that all PFNs belong to the same folio
>>>>>>>>>>>>
>>>>>>>>>>>> I haven't tried this exact approach, but I'd be surprised if I can get
>>>>>>>>>>>> the
>>>>>>>>>>>> regression under 4% with this. Further along the series I spent a
>>>>>>>>>>>> lot of
>>>>>>>>>>>> time
>>>>>>>>>>>> having to fiddle with the arm64 implementation; every conditional and
>>>>>>>>>>>> every
>>>>>>>>>>>> memory read (even when in cache) was a problem. There is just so
>>>>>>>>>>>> little in
>>>>>>>>>>>> the
>>>>>>>>>>>> inner loop that every instruction matters. (At least on Ampere Altra
>>>>>>>>>>>> and
>>>>>>>>>>>> Apple
>>>>>>>>>>>> M2).
>>>>>>>>>>>>
>>>>>>>>>>>> Of course if you're willing to pay that 4-5% for order-0 then the
>>>>>>>>>>>> benefit to
>>>>>>>>>>>> order-9 is around 10% in my measurements. Personally though, I'd
>>>>>>>>>>>> prefer to
>>>>>>>>>>>> play
>>>>>>>>>>>> safe and ensure the common order-0 case doesn't regress, as you
>>>>>>>>>>>> previously
>>>>>>>>>>>> suggested.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I just hacked something up, on top of my beloved rmap cleanup/batching
>>>>>>>>>>> series. I
>>>>>>>>>>> implemented very generic and simple batching for large folios (all PTE
>>>>>>>>>>> bits
>>>>>>>>>>> except the PFN have to match).
>>>>>>>>>>>
>>>>>>>>>>> Some very quick testing (don't trust each last % ) on Intel(R) Xeon(R)
>>>>>>>>>>> Silver
>>>>>>>>>>> 4210R CPU.
>>>>>>>>>>>
>>>>>>>>>>> order-0: 0.014210 -> 0.013969
>>>>>>>>>>>
>>>>>>>>>>> -> Around 1.7 % faster
>>>>>>>>>>>
>>>>>>>>>>> order-9: 0.014373 -> 0.009149
>>>>>>>>>>>
>>>>>>>>>>> -> Around 36.3 % faster
>>>>>>>>>>
>>>>>>>>>> Well I guess that shows me :)
>>>>>>>>>>
>>>>>>>>>> I'll do a review and run the tests on my HW to see if it concurs.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I pushed a simple compile fixup (we need pte_next_pfn()).
>>>>>>>>
>>>>>>>> I've just been trying to compile and noticed this. Will take a look at your
>>>>>>>> update.
>>>>>>>>
>>>>>>>> But upon review, I've noticed the part that I think makes this difficult
>>>>>>>> for
>>>>>>>> arm64 with the contpte optimization; You are calling ptep_get() for every
>>>>>>>> pte in
>>>>>>>> the batch. While this is functionally correct, once arm64 has the contpte
>>>>>>>> changes, its ptep_get() has to read every pte in the contpte block in
>>>>>>>> order to
>>>>>>>> gather the access and dirty bits. So if your batching function ends up
>>>>>>>> wealking
>>>>>>>> a 16 entry contpte block, that will cause 16 x 16 reads, which kills
>>>>>>>> performance. That's why I added the arch-specific pte_batch_remaining()
>>>>>>>> function; this allows the core-mm to skip to the end of the contpte
>>>>>>>> block and
>>>>>>>> avoid ptep_get() for the 15 tail ptes. So we end up with 16 READ_ONCE()s
>>>>>>>> instead
>>>>>>>> of 256.
>>>>>>>>
>>>>>>>> I considered making a ptep_get_noyoungdirty() variant, which would avoid
>>>>>>>> the
>>>>>>>> bit
>>>>>>>> gathering. But we have a similar problem in zap_pte_range() and that
>>>>>>>> function
>>>>>>>> needs the dirty bit to update the folio. So it doesn't work there. (see
>>>>>>>> patch 3
>>>>>>>> in my series).
>>>>>>>>
>>>>>>>> I guess you are going to say that we should combine both approaches, so
>>>>>>>> that
>>>>>>>> your batching loop can skip forward an arch-provided number of ptes? That
>>>>>>>> would
>>>>>>>> certainly work, but feels like an orthogonal change to what I'm trying to
>>>>>>>> achieve :). Anyway, I'll spend some time playing with it today.
>>>>>>>
>>>>>>> You can overwrite the function or add special-casing internally, yes.
>>>>>>>
>>>>>>> Right now, your patch is called "mm: Batch-copy PTE ranges during fork()"
>>>>>>> and it
>>>>>>> doesn't do any of that besides preparing for some arm64 work.
>>>>>>>
>>>>>>
>>>>>> Well it allows an arch to opt-in to batching. But I see your point.
>>>>>>
>>>>>> How do you want to handle your patches? Do you want to clean them up and I'll
>>>>>> base my stuff on top? Or do you want me to take them and sort it all out?
>>>>>
>>>>> Whatever you prefer, it was mostly a quick prototype to see if we can achieve
>>>>> decent performance.
>>>>
>>>> I'm about to run it on Altra and M2. But I assume it will show similar results.
>>
>> OK results in, not looking great, which aligns with my previous experience. That
>> said, I'm seeing some "BUG: Bad page state in process gmain  pfn:12a094" so
>> perhaps these results are not valid...
> 
> I didn't see that so far on x86, maybe related to the PFN fixup?

All I've done is define PFN_PTE_SHIFT for arm64 on top of your latest patch:

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b19a8aee684c..9eb0fd693df9 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -359,6 +359,8 @@ static inline void set_ptes(struct mm_struct *mm,
 }
 #define set_ptes set_ptes
 
+#define PFN_PTE_SHIFT          PAGE_SHIFT
+
 /*
  * Huge pte definitions.
  */


As an aside, I think there is a bug in arm64's set_ptes() for PA > 48-bit case. But that won't affect this.


With VM_DEBUG on, this is the first warning I see during boot:


[    0.278110] page:00000000c7ced4e8 refcount:12 mapcount:0 mapping:00000000b2f9739b index:0x1a8 pfn:0x1bff30
[    0.278742] head:00000000c7ced4e8 order:2 entire_mapcount:0 nr_pages_mapped:2 pincount:0
[    0.279247] memcg:ffff1a678008a000
[    0.279518] aops:xfs_address_space_operations ino:b0f70c dentry name:"systemd"
[    0.279746] flags: 0xbfffc0000008068(uptodate|lru|private|head|node=0|zone=2|lastcpupid=0xffff)
[    0.280003] page_type: 0xffffffff()
[    0.280110] raw: 0bfffc0000008068 fffffc699effcb08 fffffc699effcd08 ffff1a678980a6b0
[    0.280338] raw: 00000000000001a8 ffff1a678a0f0200 0000000cffffffff ffff1a678008a000
[    0.280564] page dumped because: VM_WARN_ON_FOLIO((_Generic((page + nr_pages - 1), const struct page *: (const struct folio *)_compound_head(page + nr_pages - 1), struct page *: (struct folio *)_compound_head(page + nr_pages - 1))) != folio)
[    0.281196] ------------[ cut here ]------------
[    0.281349] WARNING: CPU: 2 PID: 1 at include/linux/rmap.h:208 __folio_rmap_sanity_checks.constprop.0+0x168/0x188
[    0.281650] Modules linked in:
[    0.281752] CPU: 2 PID: 1 Comm: systemd Not tainted 6.7.0-rc4-00345-gdb45492bba9d #7
[    0.281959] Hardware name: linux,dummy-virt (DT)
[    0.282079] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    0.282260] pc : __folio_rmap_sanity_checks.constprop.0+0x168/0x188
[    0.282421] lr : __folio_rmap_sanity_checks.constprop.0+0x168/0x188
[    0.282583] sp : ffff80008007b9e0
[    0.282670] x29: ffff80008007b9e0 x28: 0000aaaacbecb000 x27: fffffc699effccc0
[    0.282872] x26: 00600001bff33fc3 x25: 0000000000000001 x24: ffff1a678a302228
[    0.283062] x23: ffff1a678a326658 x22: 0000000000000000 x21: 0000000000000004
[    0.283246] x20: fffffc699effccc0 x19: fffffc699effcc00 x18: 0000000000000000
[    0.283435] x17: 3736613166666666 x16: 2066666666666666 x15: 0720072007200720
[    0.283679] x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
[    0.283933] x11: 0720072007200720 x10: ffffa89ecd79ba50 x9 : ffffa89ecab23054
[    0.284214] x8 : ffffa89ecd743a50 x7 : ffffa89ecd79ba50 x6 : 0000000000000000
[    0.284545] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
[    0.284875] x2 : 0000000000000000 x1 : ffff1a6781420000 x0 : 00000000000000e5
[    0.285205] Call trace:
[    0.285320]  __folio_rmap_sanity_checks.constprop.0+0x168/0x188
[    0.285594]  copy_page_range+0x1180/0x1328
[    0.285788]  copy_process+0x1b04/0x1db8
[    0.285933]  kernel_clone+0x94/0x3f8
[    0.286078]  __do_sys_clone+0x58/0x88
[    0.286247]  __arm64_sys_clone+0x28/0x40
[    0.286430]  invoke_syscall+0x50/0x128
[    0.286607]  el0_svc_common.constprop.0+0x48/0xf0
[    0.286826]  do_el0_svc+0x24/0x38
[    0.286983]  el0_svc+0x34/0xb8
[    0.287142]  el0t_64_sync_handler+0xc0/0xc8
[    0.287339]  el0t_64_sync+0x190/0x198
[    0.287514] ---[ end trace 0000000000000000 ]---


> 
>>
>> 100 iterations per run, 8 runs over 2 reboots. Positive is slower than baseline,
>> negative is faster:
>>
>> Fork, order-0, Apple M2 VM:
>> | kernel                |   mean_rel |   std_rel |
>> |:----------------------|-----------:|----------:|
>> | mm-unstable           |       0.0% |      0.8% |
>> | hugetlb-rmap-cleanups |       1.3% |      2.0% |
>> | fork-batching         |       3.5% |      1.2% |
>>
>> Fork, order-9, Apple M2 VM:
>> | kernel                |   mean_rel |   std_rel |
>> |:----------------------|-----------:|----------:|
>> | mm-unstable           |       0.0% |      0.8% |
>> | hugetlb-rmap-cleanups |       0.9% |      0.9% |
>> | fork-batching         |     -35.6% |      2.0% |
>>
>> Fork, order-0, Ampere Altra:
>> | kernel                |   mean_rel |   std_rel |
>> |:----------------------|-----------:|----------:|
>> | mm-unstable           |       0.0% |      0.7% |
>> | hugetlb-rmap-cleanups |       3.2% |      0.7% |
>> | fork-batching         |       5.5% |      1.1% |
>>
>> Fork, order-9, Ampere Altra:
>> | kernel                |   mean_rel |   std_rel |
>> |:----------------------|-----------:|----------:|
>> | mm-unstable           |       0.0% |      0.1% |
>> | hugetlb-rmap-cleanups |       0.5% |      0.1% |
>> | fork-batching         |     -10.3% |      0.1% |
> 
> It's weird that an effective folio_test_large() should affect performance that
> much. So far I haven't seen that behavior on x86, I wodner why arm64 should
> behave here differently (also for the rmap cleanups). Code layout/size?
> 
> I'll dig it up again and test on x86 once more.
> 
> [...]
> 
>>
>> Yeah that would probably work. But we need to be careful for the case where
>> start_ptep is in the middle of a contpte block (which can happen - due to some
>> vma splitting operations, we can have a contpte block that spans 2 vmas). So
>> nr_cont_ptes() needs to either be spec'ed to only return the contpte size if
>> start_ptep is pointing to the front of the block, and all other times, return 1,
>> or it needs to return the number of ptes remaining to the end of the block (as
>> it does in my v4).
>>
>> But I guess we need to get to the bottom of my arm64 perf numbers first... I'll
>> debug those bugs and rerun.
> 
> Yes, I'll dig into it on x86 once more.
> 


