Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF46C7D82B1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344924AbjJZMch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjJZMcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:32:35 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4A493
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:32:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VuxqP9._1698323546;
Received: from 30.97.48.63(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VuxqP9._1698323546)
          by smtp.aliyun-inc.com;
          Thu, 26 Oct 2023 20:32:27 +0800
Message-ID: <37a3e0d0-329f-576f-2498-986ff260c07a@linux.alibaba.com>
Date:   Thu, 26 Oct 2023 20:32:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Barry Song <21cnbao@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, v-songbaohua@oppo.com,
        yuzhao@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <2f55f62b-cae2-4eee-8572-1b662a170880@arm.com>
 <CAGsJ_4xuH_mftf_8fV12o_Xuvp9gG8ySQq_P0JAyZH=6c66hEA@mail.gmail.com>
 <b4e80296-c541-43f5-b7ad-f80fb34fb1f3@arm.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <b4e80296-c541-43f5-b7ad-f80fb34fb1f3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/2023 2:01 PM, Anshuman Khandual wrote:
> 
> 
> On 10/26/23 11:24, Barry Song wrote:
>> On Thu, Oct 26, 2023 at 12:55 PM Anshuman Khandual
>> <anshuman.khandual@arm.com> wrote:
>>>
>>>
>>>
>>> On 10/24/23 18:26, Baolin Wang wrote:
>>>> Now ptep_clear_flush_young() is only called by folio_referenced() to
>>>> check if the folio was referenced, and now it will call a tlb flush on
>>>> ARM64 architecture. However the tlb flush can be expensive on ARM64
>>>> servers, especially for the systems with a large CPU numbers.
>>>
>>> TLB flush would be expensive on *any* platform with large CPU numbers ?

Perhaps yes, but did not measure it on other platforms.

>>>> Similar to the x86 architecture, below comments also apply equally to
>>>> ARM64 architecture. So we can drop the tlb flush operation in
>>>> ptep_clear_flush_young() on ARM64 architecture to improve the performance.
>>>> "
>>>> /* Clearing the accessed bit without a TLB flush
>>>>   * doesn't cause data corruption. [ It could cause incorrect
>>>>   * page aging and the (mistaken) reclaim of hot pages, but the
>>>>   * chance of that should be relatively low. ]
>>>>   *
>>>>   * So as a performance optimization don't flush the TLB when
>>>>   * clearing the accessed bit, it will eventually be flushed by
>>>>   * a context switch or a VM operation anyway. [ In the rare
>>>>   * event of it not getting flushed for a long time the delay
>>>>   * shouldn't really matter because there's no real memory
>>>>   * pressure for swapout to react to. ]
>>>>   */
>>>
>>> If always true, this sounds generic enough for all platforms, why only
>>> x86 and arm64 ?

I am not sure this is always true for every architectures.

>>>> "
>>>> Running the thpscale to show some obvious improvements for compaction
>>>> latency with this patch:
>>>>                               base                   patched
>>>> Amean     fault-both-1      1093.19 (   0.00%)     1084.57 *   0.79%*
>>>> Amean     fault-both-3      2566.22 (   0.00%)     2228.45 *  13.16%*
>>>> Amean     fault-both-5      3591.22 (   0.00%)     3146.73 *  12.38%*
>>>> Amean     fault-both-7      4157.26 (   0.00%)     4113.67 *   1.05%*
>>>> Amean     fault-both-12     6184.79 (   0.00%)     5218.70 *  15.62%*
>>>> Amean     fault-both-18     9103.70 (   0.00%)     7739.71 *  14.98%*
>>>> Amean     fault-both-24    12341.73 (   0.00%)    10684.23 *  13.43%*
>>>> Amean     fault-both-30    15519.00 (   0.00%)    13695.14 *  11.75%*
>>>> Amean     fault-both-32    16189.15 (   0.00%)    14365.73 *  11.26%*
>>>>                         base       patched
>>>> Duration User         167.78      161.03
>>>> Duration System      1836.66     1673.01
>>>> Duration Elapsed     2074.58     2059.75
>>>
>>> Could you please point to the test repo you are running ?

The test is based on v6.5 kernel.

>>>> Barry Song submitted a similar patch [1] before, that replaces the
>>>> ptep_clear_flush_young_notify() with ptep_clear_young_notify() in
>>>> folio_referenced_one(). However, I'm not sure if removing the tlb flush
>>>> operation is applicable to every architecture in kernel, so dropping
>>>> the tlb flush for ARM64 seems a sensible change.
>>>
>>> The reasoning provided here sounds generic when true, hence there seems
>>> to be no justification to keep it limited just for arm64 and x86. Also

Right, but I can not ensure if this will break other architectures.

>>> what about pmdp_clear_flush_young_notify() when THP is enabled. Should
>>> that also not do a TLB flush after clearing access bit ? Although arm64

Yes, I think so.

>>> does not enable __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH, rather depends on
>>> the generic pmdp_clear_flush_young() which also does a TLB flush via
>>> flush_pmd_tlb_range() while clearing the access bit.
>>>
>>>>
>>>> Note: I am okay for both approach, if someone can help to ensure that
>>>> all architectures do not need the tlb flush when clearing the accessed
>>>> bit, then I also think Barry's patch is better (hope Barry can resend
>>>> his patch).
>>>
>>> This paragraph belongs after the '----' below and not part of the commit
>>> message.

OK.

>>>> [1] https://lore.kernel.org/lkml/20220617070555.344368-1-21cnbao@gmail.com/
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>>   arch/arm64/include/asm/pgtable.h | 31 ++++++++++++++++---------------
>>>>   1 file changed, 16 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>>> index 0bd18de9fd97..2979d796ba9d 100644
>>>> --- a/arch/arm64/include/asm/pgtable.h
>>>> +++ b/arch/arm64/include/asm/pgtable.h
>>>> @@ -905,21 +905,22 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>>>>   static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>>>>                                         unsigned long address, pte_t *ptep)
>>>>   {
>>>> -     int young = ptep_test_and_clear_young(vma, address, ptep);
>>>> -
>>>> -     if (young) {
>>>> -             /*
>>>> -              * We can elide the trailing DSB here since the worst that can
>>>> -              * happen is that a CPU continues to use the young entry in its
>>>> -              * TLB and we mistakenly reclaim the associated page. The
>>>> -              * window for such an event is bounded by the next
>>>> -              * context-switch, which provides a DSB to complete the TLB
>>>> -              * invalidation.
>>>> -              */
>>>> -             flush_tlb_page_nosync(vma, address);
>>>> -     }
>>>> -
>>>> -     return young;
>>>> +     /*
>>>> +      * This comment is borrowed from x86, but applies equally to ARM64:
>>>> +      *
>>>> +      * Clearing the accessed bit without a TLB flush doesn't cause
>>>> +      * data corruption. [ It could cause incorrect page aging and
>>>> +      * the (mistaken) reclaim of hot pages, but the chance of that
>>>> +      * should be relatively low. ]
>>>> +      *
>>>> +      * So as a performance optimization don't flush the TLB when
>>>> +      * clearing the accessed bit, it will eventually be flushed by
>>>> +      * a context switch or a VM operation anyway. [ In the rare
>>>> +      * event of it not getting flushed for a long time the delay
>>>> +      * shouldn't really matter because there's no real memory
>>>> +      * pressure for swapout to react to. ]
>>>> +      */
>>>> +     return ptep_test_and_clear_young(vma, address, ptep);
>>>>   }
>>>>
>>>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>
>>> There are three distinct concerns here
>>>
>>> 1) What are the chances of this misleading existing hot page reclaim process
>>> 2) How secondary MMU such as SMMU adapt to change in mappings without a flush
>>> 3) Could this break the architecture rule requiring a TLB flush after access
>>>     bit clear on a page table entry
>>
>> In terms of all of above concerns,  though 2 is different, which is an
>> issue between
>> cpu and non-cpu,
>> i feel kernel has actually dropped tlb flush at least for mglru, there
>> is no flush in
>> lru_gen_look_around(),
>>
>> static bool folio_referenced_one(struct folio *folio,
>>                  struct vm_area_struct *vma, unsigned long address, void *arg)
>> {
>>          ...
>>
>>                  if (pvmw.pte) {
>>                          if (lru_gen_enabled() &&
>>                              pte_young(ptep_get(pvmw.pte))) {
>>                                  lru_gen_look_around(&pvmw);
>>                                  referenced++;
>>                          }
>>
>>                          if (ptep_clear_flush_young_notify(vma, address,
>>                                                  pvmw.pte))
>>                                  referenced++;
>>                  }
>>
>>          return true;
>> }
>>
>> and so is in walk_pte_range() of vmscan.  linux has been surviving with
>> all above concerns for a while, believing it or not :-)
> 
> Although the first two concerns could be worked upon in the SW, kernel surviving
> after breaking arch rules explicitly is not a correct state to be in IMHO.

Not sure what's the meaning of "not a correct state", at least we 
(Alibaba) have not found this can cause any issues until now when using 
MGLRU on x86 and ARM64 platforms.
