Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAE07FB557
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjK1JOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjK1JOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:14:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 202D2AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:14:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57CBBC15;
        Tue, 28 Nov 2023 01:15:11 -0800 (PST)
Received: from [10.57.73.192] (unknown [10.57.73.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33A823F73F;
        Tue, 28 Nov 2023 01:14:19 -0800 (PST)
Message-ID: <7c4c8ab2-8eb2-472d-ad8d-9d6c20b2191c@arm.com>
Date:   Tue, 28 Nov 2023 09:14:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
Content-Language: en-GB
To:     Barry Song <21cnbao@gmail.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, andreyknvl@gmail.com,
        anshuman.khandual@arm.com, ardb@kernel.org,
        catalin.marinas@arm.com, dvyukov@google.com, glider@google.com,
        james.morse@arm.com, jhubbard@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mark.rutland@arm.com, maz@kernel.org,
        oliver.upton@linux.dev, ryabinin.a.a@gmail.com,
        suzuki.poulose@arm.com, vincenzo.frascino@arm.com,
        wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
        yuzenghui@huawei.com, yuzhao@google.com, ziy@nvidia.com
References: <271f1e98-6217-4b40-bae0-0ac9fe5851cb@redhat.com>
 <20231127084217.13110-1-v-songbaohua@oppo.com>
 <bfebd80b-b60d-48e2-b350-7c0ac0299cda@arm.com>
 <CAGsJ_4zMwxNw76bweq-23x5ibpWnERCCwg_kz3zn1pjzeY0qXw@mail.gmail.com>
 <c359a8a6-8221-4d83-a945-580039042056@arm.com>
 <CAGsJ_4zbB5QHu=x9U2-QNFi7SPJkw0hTE+jQoLPcq2rCMC9ArA@mail.gmail.com>
 <d55e534d-c822-448e-92e0-a4e43122ce88@arm.com>
 <CAGsJ_4yto+q=PmzOVTu=ELPQjMAcjVi3qvg=1K3++nbSpcK+XQ@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4yto+q=PmzOVTu=ELPQjMAcjVi3qvg=1K3++nbSpcK+XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2023 20:34, Barry Song wrote:
> On Tue, Nov 28, 2023 at 12:07 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 27/11/2023 10:28, Barry Song wrote:
>>> On Mon, Nov 27, 2023 at 11:11 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> On 27/11/2023 09:59, Barry Song wrote:
>>>>> On Mon, Nov 27, 2023 at 10:35 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>
>>>>>> On 27/11/2023 08:42, Barry Song wrote:
>>>>>>>>> +           for (i = 0; i < nr; i++, page++) {
>>>>>>>>> +                   if (anon) {
>>>>>>>>> +                           /*
>>>>>>>>> +                            * If this page may have been pinned by the
>>>>>>>>> +                            * parent process, copy the page immediately for
>>>>>>>>> +                            * the child so that we'll always guarantee the
>>>>>>>>> +                            * pinned page won't be randomly replaced in the
>>>>>>>>> +                            * future.
>>>>>>>>> +                            */
>>>>>>>>> +                           if (unlikely(page_try_dup_anon_rmap(
>>>>>>>>> +                                           page, false, src_vma))) {
>>>>>>>>> +                                   if (i != 0)
>>>>>>>>> +                                           break;
>>>>>>>>> +                                   /* Page may be pinned, we have to copy. */
>>>>>>>>> +                                   return copy_present_page(
>>>>>>>>> +                                           dst_vma, src_vma, dst_pte,
>>>>>>>>> +                                           src_pte, addr, rss, prealloc,
>>>>>>>>> +                                           page);
>>>>>>>>> +                           }
>>>>>>>>> +                           rss[MM_ANONPAGES]++;
>>>>>>>>> +                           VM_BUG_ON(PageAnonExclusive(page));
>>>>>>>>> +                   } else {
>>>>>>>>> +                           page_dup_file_rmap(page, false);
>>>>>>>>> +                           rss[mm_counter_file(page)]++;
>>>>>>>>> +                   }
>>>>>>>>>             }
>>>>>>>>> -           rss[MM_ANONPAGES]++;
>>>>>>>>> -   } else if (page) {
>>>>>>>>> -           folio_get(folio);
>>>>>>>>> -           page_dup_file_rmap(page, false);
>>>>>>>>> -           rss[mm_counter_file(page)]++;
>>>>>>>>> +
>>>>>>>>> +           nr = i;
>>>>>>>>> +           folio_ref_add(folio, nr);
>>>>>>>>
>>>>>>>> You're changing the order of mapcount vs. refcount increment. Don't.
>>>>>>>> Make sure your refcount >= mapcount.
>>>>>>>>
>>>>>>>> You can do that easily by doing the folio_ref_add(folio, nr) first and
>>>>>>>> then decrementing in case of error accordingly. Errors due to pinned
>>>>>>>> pages are the corner case.
>>>>>>>>
>>>>>>>> I'll note that it will make a lot of sense to have batch variants of
>>>>>>>> page_try_dup_anon_rmap() and page_dup_file_rmap().
>>>>>>>>
>>>>>>>
>>>>>>> i still don't understand why it is not a entire map+1, but an increment
>>>>>>> in each basepage.
>>>>>>
>>>>>> Because we are PTE-mapping the folio, we have to account each individual page.
>>>>>> If we accounted the entire folio, where would we unaccount it? Each page can be
>>>>>> unmapped individually (e.g. munmap() part of the folio) so need to account each
>>>>>> page. When PMD mapping, the whole thing is either mapped or unmapped, and its
>>>>>> atomic, so we can account the entire thing.
>>>>>
>>>>> Hi Ryan,
>>>>>
>>>>> There is no problem. for example, a large folio is entirely mapped in
>>>>> process A with CONPTE,
>>>>> and only page2 is mapped in process B.
>>>>> then we will have
>>>>>
>>>>> entire_map = 0
>>>>> page0.map = -1
>>>>> page1.map = -1
>>>>> page2.map = 0
>>>>> page3.map = -1
>>>>> ....
>>>>>
>>>>>>
>>>>>>>
>>>>>>> as long as it is a CONTPTE large folio, there is no much difference with
>>>>>>> PMD-mapped large folio. it has all the chance to be DoubleMap and need
>>>>>>> split.
>>>>>>>
>>>>>>> When A and B share a CONTPTE large folio, we do madvise(DONTNEED) or any
>>>>>>> similar things on a part of the large folio in process A,
>>>>>>>
>>>>>>> this large folio will have partially mapped subpage in A (all CONTPE bits
>>>>>>> in all subpages need to be removed though we only unmap a part of the
>>>>>>> large folioas HW requires consistent CONTPTEs); and it has entire map in
>>>>>>> process B(all PTEs are still CONPTES in process B).
>>>>>>>
>>>>>>> isn't it more sensible for this large folios to have entire_map = 0(for
>>>>>>> process B), and subpages which are still mapped in process A has map_count
>>>>>>> =0? (start from -1).
>>>>>>>
>>>>>>>> Especially, the batch variant of page_try_dup_anon_rmap() would only
>>>>>>>> check once if the folio maybe pinned, and in that case, you can simply
>>>>>>>> drop all references again. So you either have all or no ptes to process,
>>>>>>>> which makes that code easier.
>>>>>>
>>>>>> I'm afraid this doesn't make sense to me. Perhaps I've misunderstood. But
>>>>>> fundamentally you can only use entire_mapcount if its only possible to map and
>>>>>> unmap the whole folio atomically.
>>>>>
>>>>>
>>>>>
>>>>> My point is that CONTPEs should either all-set in all 16 PTEs or all are dropped
>>>>> in 16 PTEs. if all PTEs have CONT, it is entirely mapped; otherwise,
>>>>> it is partially
>>>>> mapped. if a large folio is mapped in one processes with all CONTPTEs
>>>>> and meanwhile in another process with partial mapping(w/o CONTPTE), it is
>>>>> DoubleMapped.
>>>>
>>>> There are 2 problems with your proposal, as I see it;
>>>>
>>>> 1) the core-mm is not enlightened for CONTPTE mappings. As far as it is
>>>> concerned, its just mapping a bunch of PTEs. So it has no hook to inc/dec
>>>> entire_mapcount. The arch code is opportunistically and *transparently* managing
>>>> the CONT_PTE bit.
>>>>
>>>> 2) There is nothing to say a folio isn't *bigger* than the contpte block; it may
>>>> be 128K and be mapped with 2 contpte blocks. Or even a PTE-mapped THP (2M) and
>>>> be mapped with 32 contpte blocks. So you can't say it is entirely mapped
>>>> unless/until ALL of those blocks are set up. And then of course each block could
>>>> be unmapped unatomically.
>>>>
>>>> For the PMD case there are actually 2 properties that allow using the
>>>> entire_mapcount optimization; It's atomically mapped/unmapped through the PMD
>>>> and we know that the folio is exactly PMD sized (since it must be at least PMD
>>>> sized to be able to map it with the PMD, and we don't allocate THPs any bigger
>>>> than PMD size). So one PMD map or unmap operation corresponds to exactly one
>>>> *entire* map or unmap. That is not true when we are PTE mapping.
>>>
>>> well. Thanks for clarification. based on the above description, i agree the
>>> current code might make more sense by always using mapcount in subpage.
>>>
>>> I gave my proposals as  I thought we were always CONTPTE size for small-THP
>>> then we could drop the loop to iterate 16 times rmap. if we do it
>>> entirely, we only
>>> need to do dup rmap once for all 16 PTEs by increasing entire_map.
>>
>> Well its always good to have the discussion - so thanks for the ideas. I think
>> there is a bigger question lurking here; should we be exposing the concept of
>> contpte mappings to the core-mm rather than burying it in the arm64 arch code?
>> I'm confident that would be a huge amount of effort and the end result would be
>> similar performace to what this approach gives. One potential benefit of letting
>> core-mm control it is that it would also give control to core-mm over the
>> granularity of access/dirty reporting (my approach implicitly ties it to the
>> folio). Having sub-folio access tracking _could_ potentially help with future
>> work to make THP size selection automatic, but we are not there yet, and I think
>> there are other (simpler) ways to achieve the same thing. So my view is that
>> _not_ exposing it to core-mm is the right way for now.
> 
> Hi Ryan,
> 
> We(OPPO) started a similar project like you even before folio was imported to
> mainline, we have deployed the dynamic hugepage(that is how we name it)
> on millions of mobile phones on real products and kernels before 5.16,  making
> a huge success on performance improvement. for example, you may
> find the out-of-tree 5.15 source code here

Oh wow, thanks for reaching out and explaining this - I have to admit I feel
embarrassed that I clearly didn't do enough research on the prior art because I
wasn't aware of your work. So sorry about that.

I sensed that you had a different model for how this should work vs what I've
implemented and now I understand why :). I'll review your stuff and I'm sure
I'll have questions. I'm sure each solution has pros and cons.


> 
> https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/tree/oneplus/sm8550_u_14.0.0_oneplus11
> 
> Our modification might not be so clean and has lots of workarounds
> just for the stability of products
> 
> We mainly have
> 
> 1. https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplus/sm8550_u_14.0.0_oneplus11/mm/cont_pte_hugepage.c
> 
> some CONTPTE helpers
> 
> 2.https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplus/sm8550_u_14.0.0_oneplus11/include/linux/mm.h
> 
> some Dynamic Hugepage APIs
> 
> 3. https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplus/sm8550_u_14.0.0_oneplus11/mm/memory.c
> 
> modified all page faults to support
>      (1). allocation of hugepage of 64KB in do_anon_page

My Small-Sized THP patch set is handling the equivalent of this.

>      (2). CoW hugepage in do_wp_page

This isn't handled yet in my patch set; the original RFC implemented it but I
removed it in order to strip back to the essential complexity for the initial
submission. DavidH has been working on a precise shared vs exclusive map
tracking mechanism - if that goes in, it will make CoWing large folios simpler.
Out of interest, what workloads benefit most from this?

>      (3). copy CONPTEs in copy_pte_range

As discussed this is done as part of the contpte patch set, but its not just a
simple copy; the arch code will notice and set the CONT_PTE bit as needed.

>      (4). allocate and swap-in Hugepage as a whole in do_swap_page

This is going to be a problem but I haven't even looked at this properly yet.
The advice so far has been to continue to swap-in small pages only, but improve
khugepaged to collapse to small-sized THP. I'll take a look at your code to
understand how you did this.

> 
> 4. https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplus/sm8550_u_14.0.0_oneplus11/mm/vmscan.c
> https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplus/sm8550_u_14.0.0_oneplus11/mm/rmap.c
> 
> reclaim hugepage as a whole and LRU optimization for 64KB dynamic hugepage.

I think this is all naturally handled by the folio code that exists in modern
kernels?

> 
> So we are 100% interested in your patchset and hope it can find a way
> to land on the
> mainline, thus decreasing all the cost we have to maintain out-of-tree
> code from a
> kernel to another kernel version which we have done on a couple of
> kernel versions
> before 5.16. Firmly, we are 100% supportive of large anon folios
> things you are leading.

That's great to hear! Of course Reviewed-By's and Tested-By's will all help move
it closer :). If you had any ability to do any A/B performance testing, it would
be very interesting to see how this stacks up against your solution - if there
are gaps it would be good to know where and develop a plan to plug the gap.

> 
> A big pain was we found lots of races especially on CONTPTE unfolding
> and especially a part
> of basepages ran away from the 16 CONPTEs group since userspace is
> always working
> on basepages, having no idea of small-THP.  We ran our code on millions of
> real phones, and now we have got them fixed (or maybe "can't reproduce"),
> no outstanding issue.

I'm going to be brave and say that my solution shouldn't suffer from these
problems; but of course the proof is only in the testing. I did a lot of work
with our architecture group and micro architects to determine exactly what is
and isn't safe; We even tightened the Arm ARM spec very subtlely to allow the
optimization in patch 13 (see the commit log for details). Of course this has
all been checked with partners and we are confident that all existing
implementations conform to the modified wording.

> 
> Particularly for the rmap issue we are discussing, our out-of-tree is
> using the entire_map for
> CONTPTE in the way I sent to you. But I guess we can learn from you to decouple
> CONTPTE from mm-core.
> 
> We are doing this in mm/memory.c
> 
> copy_present_cont_pte(struct vm_area_struct *dst_vma, struct
> vm_area_struct *src_vma,
> pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
> struct page **prealloc)
> {
>       struct mm_struct *src_mm = src_vma->vm_mm;
>       unsigned long vm_flags = src_vma->vm_flags;
>       pte_t pte = *src_pte;
>       struct page *page;
> 
>        page = vm_normal_page(src_vma, addr, pte);
>       ...
> 
>      get_page(page);
>      page_dup_rmap(page, true);   // an entire dup_rmap as you can
> see.............
>      rss[mm_counter(page)] += HPAGE_CONT_PTE_NR;
> }
> 
> and we have a split in mm/cont_pte_hugepage.c to handle partially unmap,
> 
> static void __split_huge_cont_pte_locked(struct vm_area_struct *vma, pte_t *pte,
> unsigned long haddr, bool freeze)
> {
> ...
>            if (compound_mapcount(head) > 1 && !TestSetPageDoubleMap(head)) {
>                   for (i = 0; i < HPAGE_CONT_PTE_NR; i++)
>                            atomic_inc(&head[i]._mapcount);
>                  atomic_long_inc(&cont_pte_double_map_count);
>            }
> 
> 
>             if (atomic_add_negative(-1, compound_mapcount_ptr(head))) {
>               ...
> }
> 
> I am not selling our solution any more, but just showing you some differences we
> have :-)

OK, I understand what you were saying now. I'm currently struggling to see how
this could fit into my model. Do you have any workloads and numbers on perf
improvement of using entire_mapcount?

> 
>>
>>>
>>> BTW, I have concerns that a variable small-THP size will really work
>>> as userspace
>>> is probably friendly to only one fixed size. for example, userspace
>>> heap management
>>> might be optimized to a size for freeing memory to the kernel. it is
>>> very difficult
>>> for the heap to adapt to various sizes at the same time. frequent unmap/free
>>> size not equal with, and particularly smaller than small-THP size will
>>> defeat all
>>> efforts to use small-THP.
>>
>> I'll admit to not knowing a huge amount about user space allocators. But I will
>> say that as currently defined, the small-sized THP interface to user space
>> allows a sysadmin to specifically enable the set of sizes that they want; so a
>> single size can be enabled. I'm diliberately punting that decision away from the
>> kernel for now.
> 
> Basically, userspace heap library has a PAGESIZE setting and allows users
> to allocate/free all kinds of small objects such as 16,32,64,128,256,512 etc.
> The default size is for sure equal to the basepage SIZE. once some objects are
> freed by free() and libc get a free "page", userspace heap libraries might free
> the PAGESIZE page to kernel by things like MADV_DONTNEED, then zap_pte_range().
> it is quite similar with kernel slab.
> 
> so imagine we have small-THP now, but userspace libraries have *NO*
> idea at all,  so it can frequently cause unfolding.
> 
>>
>> FWIW, My experience with the Speedometer/JavaScript use case is that performance
>> is a little bit better when enabling 64+32+16K vs just 64K THP.
>>
>> Functionally, it will not matter if the allocator is not enlightened for the THP
>> size; it can continue to free, and if a partial folio is unmapped it is put on
>> the deferred split list, then under memory pressure it is split and the unused
>> pages are reclaimed. I guess this is the bit you are concerned about having a
>> performance impact?
> 
> right. If this is happening on the majority of small-THP folios, we
> don't have performance
> improvement, and probably regression instead. This is really true on
> real workloads!!
> 
> So that is why we really love a per-VMA hint to enable small-THP but
> obviously you
> have already supported it now by
> mm: thp: Introduce per-size thp sysfs interface
> https://lore.kernel.org/linux-mm/20231122162950.3854897-4-ryan.roberts@arm.com/
> 
> we can use MADVISE rather than ALWAYS and set fixed size like 64KB, so userspace
> can set the VMA flag when it is quite sure this VMA is working with
> the alignment
> of 64KB?

Yes, that all exists in the series today. We have also discussed the possibility
of adding a new madvise_process() call that would take the set of THP sizes that
should be considered. Then you can set different VMAs to use different sizes;
the plan was to layer that on top if/when a workload was identified. Sounds like
you might be able to help there?

> 
>>
>> Regardless, it would be good to move this conversation to the small-sized THP
>> patch series since this is all independent of contpte mappings.
>>
>>>
>>>>
>>>>>
>>>>> Since we always hold ptl to set or drop CONTPTE bits, set/drop is
>>>>> still atomic in a
>>>>> spinlock area.
>>>>>
>>>>>>
>>>>>>>>
>>>>>>>> But that can be added on top, and I'll happily do that.
>>>>>>>>
>>>>>>>> --
>>>>>>>> Cheers,
>>>>>>>>
>>>>>>>> David / dhildenb
>>>>>>>
>>>>>
>>>
> 
> Thanks
> Barry

