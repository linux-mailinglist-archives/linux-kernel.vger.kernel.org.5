Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2A17D6033
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 05:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjJYDDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 23:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJYDC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 23:02:58 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FA7116
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 20:02:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VusnLLH_1698202969;
Received: from 30.97.48.63(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VusnLLH_1698202969)
          by smtp.aliyun-inc.com;
          Wed, 25 Oct 2023 11:02:50 +0800
Message-ID: <f3047412-a53c-f8ba-f8aa-4f46e04c5a31@linux.alibaba.com>
Date:   Wed, 25 Oct 2023 11:03:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
To:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Barry Song <21cnbao@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, v-songbaohua@oppo.com,
        yuzhao@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
 <44e32b0e-0e41-4055-bdb9-15bc7d47197c@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <44e32b0e-0e41-4055-bdb9-15bc7d47197c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2023 9:39 AM, Yin, Fengwei wrote:
> 
>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>> index 0bd18de9fd97..2979d796ba9d 100644
>>> --- a/arch/arm64/include/asm/pgtable.h
>>> +++ b/arch/arm64/include/asm/pgtable.h
>>> @@ -905,21 +905,22 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>>>   static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>>>                                           unsigned long address, pte_t *ptep)
>>>   {
>>> -       int young = ptep_test_and_clear_young(vma, address, ptep);
>>> -
>>> -       if (young) {
>>> -               /*
>>> -                * We can elide the trailing DSB here since the worst that can
>>> -                * happen is that a CPU continues to use the young entry in its
>>> -                * TLB and we mistakenly reclaim the associated page. The
>>> -                * window for such an event is bounded by the next
>>> -                * context-switch, which provides a DSB to complete the TLB
>>> -                * invalidation.
>>> -                */
>>> -               flush_tlb_page_nosync(vma, address);
>>> -       }
>>> -
>>> -       return young;
>>> +       /*
>>> +        * This comment is borrowed from x86, but applies equally to ARM64:
>>> +        *
>>> +        * Clearing the accessed bit without a TLB flush doesn't cause
>>> +        * data corruption. [ It could cause incorrect page aging and
>>> +        * the (mistaken) reclaim of hot pages, but the chance of that
>>> +        * should be relatively low. ]
>>> +        *
>>> +        * So as a performance optimization don't flush the TLB when
>>> +        * clearing the accessed bit, it will eventually be flushed by
>>> +        * a context switch or a VM operation anyway. [ In the rare
>>> +        * event of it not getting flushed for a long time the delay
>>> +        * shouldn't really matter because there's no real memory
>>> +        * pressure for swapout to react to. ]
>>> +        */
>>> +       return ptep_test_and_clear_young(vma, address, ptep);
>>>   }
>  From https://lore.kernel.org/lkml/20181029105515.GD14127@arm.com/:
> 
> This is blindly copied from x86 and isn't true for us: we don't invalidate
> the TLB on context switch. That means our window for keeping the stale
> entries around is potentially much bigger and might not be a great idea.
> 
> 
> My understanding is that arm64 doesn't do invalidate the TLB during > context switch. The flush_tlb_page_nosync() here + DSB during context

Yes, we only perform a TLB flush when the ASID is exhausted during 
context switch, and I think this is same with x86 IIUC.

> switch make sure the TLB is invalidated during context switch.
> So we can't remove flush_tlb_page_nosync() here? Or something was changed
> for arm64 (I have zero knowledge to TLB on arm64. So some obvious thing
> may be missed)? Thanks.

IMHO, the tlb can be easily evicted or flushed if the system is under 
memory pressure, so like Barry said, the chance of reclaiming hot page 
is relatively low, at least on X86, we did not see any heavy refault issue.

For MGLRU, it uses ptep_test_and_clear_young() instead of 
ptep_clear_flush_young_notify(), and we did not find any problems until 
now since deploying to ARM servers.
