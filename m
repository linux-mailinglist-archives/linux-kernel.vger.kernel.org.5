Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C6E7D5FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjJYCCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYCCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:02:43 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7502610D4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 19:02:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VusYSvA_1698199355;
Received: from 30.97.48.63(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VusYSvA_1698199355)
          by smtp.aliyun-inc.com;
          Wed, 25 Oct 2023 10:02:36 +0800
Message-ID: <d1d64d07-57ce-c941-6a9f-463685d0c446@linux.alibaba.com>
Date:   Wed, 25 Oct 2023 10:02:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
To:     Barry Song <21cnbao@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, v-songbaohua@oppo.com,
        yuzhao@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
 <CAGsJ_4z1u4-_JXUM9GG2cqc4Nwrx1v69uHsbff5jDQZHQgWP+w@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4z1u4-_JXUM9GG2cqc4Nwrx1v69uHsbff5jDQZHQgWP+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2023 7:31 AM, Barry Song wrote:
> On Wed, Oct 25, 2023 at 7:16 AM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Tue, Oct 24, 2023 at 8:57 PM Baolin Wang
>> <baolin.wang@linux.alibaba.com> wrote:
>>>
>>> Now ptep_clear_flush_young() is only called by folio_referenced() to
>>> check if the folio was referenced, and now it will call a tlb flush on
>>> ARM64 architecture. However the tlb flush can be expensive on ARM64
>>> servers, especially for the systems with a large CPU numbers.
>>>
>>> Similar to the x86 architecture, below comments also apply equally to
>>> ARM64 architecture. So we can drop the tlb flush operation in
>>> ptep_clear_flush_young() on ARM64 architecture to improve the performance.
>>> "
>>> /* Clearing the accessed bit without a TLB flush
>>>   * doesn't cause data corruption. [ It could cause incorrect
>>>   * page aging and the (mistaken) reclaim of hot pages, but the
>>>   * chance of that should be relatively low. ]
>>>   *
>>>   * So as a performance optimization don't flush the TLB when
>>>   * clearing the accessed bit, it will eventually be flushed by
>>>   * a context switch or a VM operation anyway. [ In the rare
>>>   * event of it not getting flushed for a long time the delay
>>>   * shouldn't really matter because there's no real memory
>>>   * pressure for swapout to react to. ]
>>>   */
>>> "
>>> Running the thpscale to show some obvious improvements for compaction
>>> latency with this patch:
>>>                               base                   patched
>>> Amean     fault-both-1      1093.19 (   0.00%)     1084.57 *   0.79%*
>>> Amean     fault-both-3      2566.22 (   0.00%)     2228.45 *  13.16%*
>>> Amean     fault-both-5      3591.22 (   0.00%)     3146.73 *  12.38%*
>>> Amean     fault-both-7      4157.26 (   0.00%)     4113.67 *   1.05%*
>>> Amean     fault-both-12     6184.79 (   0.00%)     5218.70 *  15.62%*
>>> Amean     fault-both-18     9103.70 (   0.00%)     7739.71 *  14.98%*
>>> Amean     fault-both-24    12341.73 (   0.00%)    10684.23 *  13.43%*
>>> Amean     fault-both-30    15519.00 (   0.00%)    13695.14 *  11.75%*
>>> Amean     fault-both-32    16189.15 (   0.00%)    14365.73 *  11.26%*
>>>                         base       patched
>>> Duration User         167.78      161.03
>>> Duration System      1836.66     1673.01
>>> Duration Elapsed     2074.58     2059.75
>>>
>>> Barry Song submitted a similar patch [1] before, that replaces the
>>> ptep_clear_flush_young_notify() with ptep_clear_young_notify() in
>>> folio_referenced_one(). However, I'm not sure if removing the tlb flush
>>> operation is applicable to every architecture in kernel, so dropping
>>> the tlb flush for ARM64 seems a sensible change.
>>>
>>> Note: I am okay for both approach, if someone can help to ensure that
>>> all architectures do not need the tlb flush when clearing the accessed
>>> bit, then I also think Barry's patch is better (hope Barry can resend
>>> his patch).
>>>
>>
>> Thanks!
>>
>> ptep_clear_flush_young() with "flush" in its name clearly says it needs a
>> flush. but it happens in arm64, all other code which needs a flush has
>> called other variants, for example __flush_tlb_page_nosync():
>>
>> static inline void arch_tlbbatch_add_pending(struct
>> arch_tlbflush_unmap_batch *batch,
>>   struct mm_struct *mm, unsigned long uaddr)
>> {
>>   __flush_tlb_page_nosync(mm, uaddr);
>> }
>>
>> so it seems folio_referenced is the only left user of this
>> ptep_clear_flush_young().
>> The fact makes Baolin's patch look safe now.
>>
>> but this function still has "flush" in its name, so one day, one person might
>> call it with the understanding that it will flush tlb but actually it
>> won't. This is
>> bad smell in code.

Agree. I think this is jsut a start, we can replace 
ptep_clear_flush_young() once other architectures have completed the 
conversion, if we can confirm that other architectures also do not 
require tlb flush when clearing the accessed bit.

>> I guess one side effect of not flushing tlb while clearing the access
>> flag is that
>> hardware won't see this cleared flag in the tlb, so it might not set this bit in
>> memory even though the bit has been cleared before in memory(but not in tlb)
>> while the page is accessed *again*. >>
>> next time, someone reads the access flag in memory again by folio_referenced,
>> he/she will see the page is cold as hardware has lost a chance to set
>> the bit again
>> since it finds tlb already has a true access flag.
>>
>> But anyway, tlb is so small, it will be flushed by context switch and
>> other running
>> code soon. so it seems we don't actually require the access flag being instantly
>> updated. the time gap, in which access flag might lose the new set by hardware,
>> seems to be too short to really affect the accuracy of page reclamation. but its
>> cost is large.
>>
>> (A). Constant flush cost vs. (B). very very occasional reclaimed hot
>> page,  B might
>> be a correct choice.
> 
> Plus, I doubt B is really going to happen. as after a page is promoted to
> the head of lru list or new generation, it needs a long time to slide back
> to the inactive list tail or to the candidate generation of mglru. the time
> should have been large enough for tlb to be flushed. If the page is really
> hot, the hardware will get second, third, fourth etc opportunity to set an
> access flag in the long time in which the page is re-moved to the tail
> as the page can be accessed multiple times if it is really hot.

Thanks Barry, that's also what I thought. On the other hand, even if 
there is no tlb flush for a long time, I think the system is not under 
memory pressure at that time, so the incorrect page aging would not have 
much impact.
