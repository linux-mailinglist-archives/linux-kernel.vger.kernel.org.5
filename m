Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116927D606A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 05:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjJYDQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 23:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjJYDQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 23:16:19 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCE42123
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 20:15:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vusqgjq_1698203726;
Received: from 30.97.48.63(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vusqgjq_1698203726)
          by smtp.aliyun-inc.com;
          Wed, 25 Oct 2023 11:15:26 +0800
Message-ID: <0affd3de-cf20-72a1-a800-a0cbda539667@linux.alibaba.com>
Date:   Wed, 25 Oct 2023 11:15:42 +0800
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
 <f3047412-a53c-f8ba-f8aa-4f46e04c5a31@linux.alibaba.com>
 <a4ae7473-636b-4ff3-9f66-f47dbe934593@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <a4ae7473-636b-4ff3-9f66-f47dbe934593@intel.com>
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



On 10/25/2023 11:08 AM, Yin, Fengwei wrote:
> 
> 
> On 10/25/2023 11:03 AM, Baolin Wang wrote:
>>>
>>> My understanding is that arm64 doesn't do invalidate the TLB during > context switch. The flush_tlb_page_nosync() here + DSB during context
>>
>> Yes, we only perform a TLB flush when the ASID is exhausted during context switch, and I think this is same with x86 IIUC.
> If we remove flush_tlb_page_nosync(), can we still claim TLB is flushed during
> context switch for ARM64?

To be more precise, it is necessary to add prerequisite conditions, such 
as when ASID is exhausted. I can update the comments.

>>> switch make sure the TLB is invalidated during context switch.
>>> So we can't remove flush_tlb_page_nosync() here? Or something was changed
>>> for arm64 (I have zero knowledge to TLB on arm64. So some obvious thing
>>> may be missed)? Thanks.
>>
>> IMHO, the tlb can be easily evicted or flushed if the system is under memory pressure, so like Barry said, the chance of reclaiming hot page is relatively low, at least on X86, we did not see any heavy refault issue.
>>
>> For MGLRU, it uses ptep_test_and_clear_young() instead of ptep_clear_flush_young_notify(), and we did not find any problems until now since deploying to ARM servers.
