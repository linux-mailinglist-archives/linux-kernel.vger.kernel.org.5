Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5393772D3D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjHGRpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjHGRpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:45:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFBAFE74
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:45:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D3DF1FB;
        Mon,  7 Aug 2023 10:46:31 -0700 (PDT)
Received: from [10.57.77.247] (unknown [10.57.77.247])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 799C53F59C;
        Mon,  7 Aug 2023 10:45:45 -0700 (PDT)
Message-ID: <9f27bf92-baab-11e2-0618-6fc6f5da1d38@arm.com>
Date:   Mon, 7 Aug 2023 18:45:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
To:     "Yin, Fengwei" <fengwei.yin@intel.com>, Zi Yan <ziy@nvidia.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com>
 <c02a95e9-b728-ad64-6942-f23dbd66af0c@arm.com>
 <CAOUHufaHH3Ctu3JRHSbmebHJ7XPnBEWTQ4mwOo+MGXU9yKvwbA@mail.gmail.com>
 <5e595904-3dca-0e15-0769-7ed10975fd0d@arm.com>
 <b936041c-08a7-e844-19e7-eafc4ddf63b9@redhat.com>
 <CAOUHufafd4GNna2GKdSyQdW6CLVh0gxhNgeOc6t+ZOphwgw7tw@mail.gmail.com>
 <259ad8fc-c12b-69b9-ba16-adb9e3e6d672@redhat.com>
 <CAOUHufbbrDrSv2Ak0tyyaw7qrekkQ-p2vjCqWsXFG7b-+EP=5g@mail.gmail.com>
 <0d502268-ebdc-8462-d88c-e6a41578d9ae@redhat.com>
 <60070B7E-5DC2-4CE1-8089-1A05DDDABA4C@nvidia.com>
 <5781b962-9e0b-1f61-7eb7-9621ace76d90@intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <5781b962-9e0b-1f61-7eb7-9621ace76d90@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2023 03:50, Yin, Fengwei wrote:
> 
> 
> On 8/5/2023 5:58 AM, Zi Yan wrote:
>> On 4 Aug 2023, at 17:30, David Hildenbrand wrote:
>>
>>> On 04.08.23 23:26, Yu Zhao wrote:
>>>> On Fri, Aug 4, 2023 at 3:13 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 04.08.23 23:00, Yu Zhao wrote:
>>>>>> On Fri, Aug 4, 2023 at 2:23 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>
>>>>>>> On 04.08.23 10:27, Ryan Roberts wrote:
>>>>>>>> On 04/08/2023 00:50, Yu Zhao wrote:
>>>>>>>>> On Thu, Aug 3, 2023 at 6:43 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>>>>>
>>>>>>>>>> + Kirill
>>>>>>>>>>
>>>>>>>>>> On 26/07/2023 10:51, Ryan Roberts wrote:
>>>>>>>>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>>>>>>>>>> allocated in large folios of a determined order. All pages of the large
>>>>>>>>>>> folio are pte-mapped during the same page fault, significantly reducing
>>>>>>>>>>> the number of page faults. The number of per-page operations (e.g. ref
>>>>>>>>>>> counting, rmap management lru list management) are also significantly
>>>>>>>>>>> reduced since those ops now become per-folio.
>>>>>>>>>>>
>>>>>>>>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>>>>>>>>>> which defaults to disabled for now; The long term aim is for this to
>>>>>>>>>>> defaut to enabled, but there are some risks around internal
>>>>>>>>>>> fragmentation that need to be better understood first.
>>>>>>>>>>>
>>>>>>>>>>> When enabled, the folio order is determined as such: For a vma, process
>>>>>>>>>>> or system that has explicitly disabled THP, we continue to allocate
>>>>>>>>>>> order-0. THP is most likely disabled to avoid any possible internal
>>>>>>>>>>> fragmentation so we honour that request.
>>>>>>>>>>>
>>>>>>>>>>> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
>>>>>>>>>>> that have not explicitly opted-in to use transparent hugepages (e.g.
>>>>>>>>>>> where thp=madvise and the vma does not have MADV_HUGEPAGE), then
>>>>>>>>>>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
>>>>>>>>>>> bigger). This allows for a performance boost without requiring any
>>>>>>>>>>> explicit opt-in from the workload while limitting internal
>>>>>>>>>>> fragmentation.
>>>>>>>>>>>
>>>>>>>>>>> If the preferred order can't be used (e.g. because the folio would
>>>>>>>>>>> breach the bounds of the vma, or because ptes in the region are already
>>>>>>>>>>> mapped) then we fall back to a suitable lower order; first
>>>>>>>>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> ...
>>>>>>>>>>
>>>>>>>>>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>>>>>>>>>> +             (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
>>>>>>>>>>> +
>>>>>>>>>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>>>>>>>>>> +{
>>>>>>>>>>> +     int order;
>>>>>>>>>>> +
>>>>>>>>>>> +     /*
>>>>>>>>>>> +      * If THP is explicitly disabled for either the vma, the process or the
>>>>>>>>>>> +      * system, then this is very likely intended to limit internal
>>>>>>>>>>> +      * fragmentation; in this case, don't attempt to allocate a large
>>>>>>>>>>> +      * anonymous folio.
>>>>>>>>>>> +      *
>>>>>>>>>>> +      * Else, if the vma is eligible for thp, allocate a large folio of the
>>>>>>>>>>> +      * size preferred by the arch. Or if the arch requested a very small
>>>>>>>>>>> +      * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER,
>>>>>>>>>>> +      * which still meets the arch's requirements but means we still take
>>>>>>>>>>> +      * advantage of SW optimizations (e.g. fewer page faults).
>>>>>>>>>>> +      *
>>>>>>>>>>> +      * Finally if thp is enabled but the vma isn't eligible, take the
>>>>>>>>>>> +      * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHINTED.
>>>>>>>>>>> +      * This ensures workloads that have not explicitly opted-in take benefit
>>>>>>>>>>> +      * while capping the potential for internal fragmentation.
>>>>>>>>>>> +      */
>>>>>>>>>>> +
>>>>>>>>>>> +     if ((vma->vm_flags & VM_NOHUGEPAGE) ||
>>>>>>>>>>> +         test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
>>>>>>>>>>> +         !hugepage_flags_enabled())
>>>>>>>>>>> +             order = 0;
>>>>>>>>>>> +     else {
>>>>>>>>>>> +             order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>>>>>>>>>>> +
>>>>>>>>>>> +             if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>>>>>>>>>>> +                     order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>>>>>>>>>>> +     }
>>>>>>>>>>> +
>>>>>>>>>>> +     return order;
>>>>>>>>>>> +}
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Hi All,
>>>>>>>>>>
>>>>>>>>>> I'm writing up the conclusions that we arrived at during discussion in the THP
>>>>>>>>>> meeting yesterday, regarding linkage with exiting THP ABIs. It would be great if
>>>>>>>>>> I can get explicit "agree" or disagree + rationale from at least David, Yu and
>>>>>>>>>> Kirill.
>>>>>>>>>>
>>>>>>>>>> In summary; I think we are converging on the approach that is already coded, but
>>>>>>>>>> I'd like confirmation.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> The THP situation today
>>>>>>>>>> -----------------------
>>>>>>>>>>
>>>>>>>>>>     - At system level: THP can be set to "never", "madvise" or "always"
>>>>>>>>>>     - At process level: THP can be "never" or "defer to system setting"
>>>>>>>>>>     - At VMA level: no-hint, MADV_HUGEPAGE, MADV_NOHUGEPAGE
>>>>>>>>>>
>>>>>>>>>> That gives us this table to describe how a page fault is handled, according to
>>>>>>>>>> process state (columns) and vma flags (rows):
>>>>>>>>>>
>>>>>>>>>>                    | never     | madvise   | always
>>>>>>>>>> ----------------|-----------|-----------|-----------
>>>>>>>>>> no hint         | S         | S         | THP>S
>>>>>>>>>> MADV_HUGEPAGE   | S         | THP>S     | THP>S
>>>>>>>>>> MADV_NOHUGEPAGE | S         | S         | S
>>>>>>>>>>
>>>>>>>>>> Legend:
>>>>>>>>>> S       allocate single page (PTE-mapped)
>>>>>>>>>> LAF     allocate lage anon folio (PTE-mapped)
>>>>>>>>>> THP     allocate THP-sized folio (PMD-mapped)
>>>>>>>>>>>          fallback (usually because vma size/alignment insufficient for folio)
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Principles for Large Anon Folios (LAF)
>>>>>>>>>> --------------------------------------
>>>>>>>>>>
>>>>>>>>>> David tells us there are use cases today (e.g. qemu live migration) which use
>>>>>>>>>> MADV_NOHUGEPAGE to mean "don't fill any PTEs that are not explicitly faulted"
>>>>>>>>>> and these use cases will break (i.e. functionally incorrect) if this request is
>>>>>>>>>> not honoured.
>>>>>>>>>
>>>>>>>>> I don't remember David saying this. I think he was referring to UFFD,
>>>>>>>>> not MADV_NOHUGEPAGE, when discussing what we need to absolutely
>>>>>>>>> respect.
>>>>>>>>
>>>>>>>> My understanding was that MADV_NOHUGEPAGE was being applied to regions *before*
>>>>>>>> UFFD was being registered, and the app relied on MADV_NOHUGEPAGE to not back any
>>>>>>>> unfaulted pages. It's not completely clear to me how not honouring
>>>>>>>> MADV_NOHUGEPAGE would break things though. David?
>>>>>>>
>>>>>>> Sorry, I'm still lagging behind on some threads.
>>>>>>>
>>>>>>> Imagine the following for VM postcopy live migration:
>>>>>>>
>>>>>>> (1) Set MADV_NOHUGEPAGE on guest memory and discard all memory (e.g.,
>>>>>>>        MADV_DONTNEED), to start with a clean slate.
>>>>>>> (2) Migrates some pages during precopy from the source and stores them
>>>>>>>        into guest memory on the destination. Some of the memory locations
>>>>>>>        will have pages populated.
>>>>>>> (3) At some point, decide to enable postcopy: enable userfaultfd on
>>>>>>>        guest memory.
>>>>>>> (4) Discard *selected* pages again that have been dirtied in the
>>>>>>>        meantime on the source. These are pages that have been migrated
>>>>>>>        previously.
>>>>>>> (5) Start running the VM on the destination.
>>>>>>> (6) Anything that's not populated will trigger userfaultfd missing
>>>>>>>        faults. Then, you can request them from the source and place them.
>>>>>>>
>>>>>>> Assume you would populate more than required during 2), you can end up
>>>>>>> not getting userfaultfd faults during 4) and corrupt your guest state.
>>>>>>> It works if during (2) you migrated all guest memory, or if during 4)
>>>>>>> you zap everything that still needs migr
>>>>>>
>>>>>> I see what you mean now. Thanks.
>>>>>>
>>>>>> Yes, in this case we have to interpret MADV_NOHUGEPAGE as nothing >4KB.

I'm glad we have agreement on this.

In some threads Yu has been talking about this series in the short term, vs long
term roadmap; so to be clear, I interpret this as meaning we must consider that
MADV_NOHUGEPAGE means nothing bigger than order-0 both in the context of this
series and for the long term - that's behavior that user space depends upon.

I think we should also apply the same logic to system/process THP mode =
"never", even if the vma does not have MADV_NOHUGEPAGE. If the user has
explicitly set "never" on the system or process, that means "nothing bigger than
order-0". Shout if you disagree.

>>>>>
>>>>> Note that it's still even unclear to me why we want to *not* call these
>>>>> things THP. It would certainly make everything less confusing if we call
>>>>> them THP, but with additional attributes.

I think I've stated in the past that I don't have a strong opinion on what we
call them. But I do think you make a convincing argument for calling them after
THP. Regardless, I'd rather agree on a name up front, before this initial series
goes in - it's always better to be consistent across all the commit messages and
comments to make things more grepable.

The only concrete objection I remember hearing to a name with "THP" in the title
was that there are stats (meminfo, vmstats, etc) that count THPs and this
becomes confusing if those counters now only mean a subset of THPs. But that
feels like a small issue in the scheme of things.

>>>>>
>>>>> I think that is one of the first things we should figure out because it
>>>>> also indirectly tells us what all these toggles mean and how/if we
>>>>> should redefine them (and if they even apply).
>>>>>
>>>>> Currently THP == PMD size
>>>>>
>>>>> In 2016, Hugh already envisioned PUD/PGD THP (see 49920d28781d ("mm:
>>>>> make transparent hugepage size public")) when he explicitly exposed
>>>>> "hpage_pmd_size". Not "hpage_size".
>>>>>
>>>>> For hugetlb on arm64 we already support various sizes that are < PMD
>>>>> size and *not* call them differently. It's a huge(tlb) page. Sometimes
>>>>> we refer to them as cont-PTE hugetlb pages.
>>>>>
>>>>>
>>>>> So, nowadays we do have "PMD-sized THP", someday we might have
>>>>> "PUD-sized THP". Can't we come up with a name to describe sub-PMD THP?

I think one subtle difference is that these sub-PMD THPs, likely won't always
have a single size.

>>>>>
>>>>> Is it really of value if we invent a new term for them? Yes, I was not
>>>>> enjoying "Flexible THP".

How about "variable-order THP"? Or "SW THP" vs "HW THP"?

>>>>>
>>>>>
>>>>> Once we figured that out, we should figure out if MADV_HUGEPAGE meant
>>>>> "only PMD-sized THP" or anything else?
>>>>>
>>>>> Also, we can then figure out if MADV_NOHUGEPAGE meant "only PMD-sized
>>>>> THP" or anything else?

Based on the existing user space expectation that MADV_NOHUGEPAGE means "nothing
bigger than order-0" I'm not sure how we could ever decide MADV_NOHUGEPAGE means
anything different? This feels set in stone to me.

>>>>>
>>>>>
>>>>> The simplest approach to me would be "they imply any THP, and once we
>>>>> need more tunables we might add some", similar to what Kirill also raised.

Agreed.

>>>>>
>>>>>
>>>>> Again, it's all unclear to me at this point and I'm happy to hear
>>>>> opinions, because I really don't know.
>>>>
>>>> I agree these points require more discussion. But I don't think we
>>>> need to conclude them now, unless they cause correctness issues like
>>>> ignoring MADV_NOHUGEPAGE would. My concern is that if we decide to go
>>>> with "they imply any THP" and *expose this to userspace now*, we might
>>>> regret later.
>>>
>>> If we don't think they are THP, probably MADV_NOHUGEPAGE should not apply and we should be ready to find other ways to deal with the mess we eventually create. If we want to go down that path, sure.
>>>
>>> If they are THP, to me there is not really a question if MADV_NOHUGEPAGE applies to them or not. Unless we want to build a confusing piece of software ;)
>>
>> I think it is good to call them THP, since they are transparent huge (>order-0) pages.
>> But the concern is that before we have a reasonable management policy for order>0 &&
>> order<9 THPs, mixing them with existing order-9 THP might give user unexpected
>> performance outcome. Unless we are sure they will always performance improvement,
>> we might repeat the old THP path, namely users begin to disable THP by default
>> to avoid unexpected performance hiccup. That is the reason Yu wants to separate
>> LAF from THP at the moment.

(for the purposes of this; LAF="sub-PMD THP", THP="PMD-size THP", we treat them
both as forms of THP)...

How about this for a strawman:

When introducing LAF we can either use an opt-in or an opt-out model. The opt-in
model would require a new ABI from day 1 (something I think there is concensus
that we do not want to do) and would prevent apps from automatically getting
benefit. So I don't like that model.

If going with the opt-out model, we already have an opt-out mechanism
(thp="never" and MADV_NOHUGEPAGE) that we can piggyback. But that mechanism
doesn't give us all the control we would like for benchmarking/characterizing
the interactions between LAF/THP for different workloads. Ideally we need a way
to enable THP while keeping LAF disabled and enable LAF while keeping THP disabled.

Can we do this with debugfs? I think controls in there can come and go without
too much concern about back-compat?

Perhaps 2 controls:

laf_enable=0|1
  enable/disable LAF independently of THP
  default=1

laf_max_order=N
  applies to both LAF and THP
  when max_order < PMD-order, THP acts like thp="never"
  puts a ceiling on folio order allocated by LAF
  default=PMD-order

This gives:


laf_enable=1, laf_max_order=PMD-order (LAF+THP):

                | never     | madvise   | always
----------------|-----------|-----------|-----------
no hint         | S         | LAF>S     | THP>LAF>S
MADV_HUGEPAGE   | S         | THP>LAF>S | THP>LAF>S
MADV_NOHUGEPAGE | S         | S         | S


laf_enable=0, laf_max_order=PMD-order (THP only):

                | never     | madvise   | always
----------------|-----------|-----------|-----------
no hint         | S         | S         | THP>S
MADV_HUGEPAGE   | S         | THP>S     | THP>S
MADV_NOHUGEPAGE | S         | S         | S


laf_enable=1, laf_max_order=(PMD-order - 1) (LAF only):

                | never     | madvise   | always
----------------|-----------|-----------|-----------
no hint         | S         | LAF>S     | LAF>S
MADV_HUGEPAGE   | S         | LAF>S     | LAF>S
MADV_NOHUGEPAGE | S         | S         | S


This would allow us to get something into the kernel that would allow people to
more broadly characterize different workloads under THP, LAF, THP+LAF, which
would give us a better understanding of if/how we want to design ABIs for the
long term.


>>
>> Maybe call it THP (experimental) for now and merge it to THP when we have a stable
>> policy. For knobs, we might add "any-order" to the existing "never", "madvise"
>> and another interface to specify max hinted order (enforcing <9) for "any-order".
>> Later, we can allow users to specify any max hinted order, including 9. Just an
>> idea.
> I suspect that all the config knobs (enable/disable mixing mode, define "any-order"
> or "specific-order") will be exist long term. Because there are always new workloads
> need be tuned against these configs.
> 
> 
> Regards
> Yin, Fengwei
> 
>>
>>
>> --
>> Best Regards,
>> Yan, Zi

