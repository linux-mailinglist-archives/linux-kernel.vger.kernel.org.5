Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E57E7D5F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 03:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJYBoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 21:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJYBoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 21:44:24 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6A4186
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 18:44:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VusiUBA_1698198257;
Received: from 30.97.48.63(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VusiUBA_1698198257)
          by smtp.aliyun-inc.com;
          Wed, 25 Oct 2023 09:44:18 +0800
Message-ID: <e818ef93-49f6-47c8-0d89-6330bf6687f8@linux.alibaba.com>
Date:   Wed, 25 Oct 2023 09:44:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org
Cc:     akpm@linux-foundation.org, v-songbaohua@oppo.com,
        yuzhao@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <e0b65883-18fa-40c8-a61a-bebcfee109a4@huawei.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <e0b65883-18fa-40c8-a61a-bebcfee109a4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2023 9:48 PM, Kefeng Wang wrote:
> 
> 
> On 2023/10/24 20:56, Baolin Wang wrote:
>> Now ptep_clear_flush_young() is only called by folio_referenced() to
>> check if the folio was referenced, and now it will call a tlb flush on
>> ARM64 architecture. However the tlb flush can be expensive on ARM64
>> servers, especially for the systems with a large CPU numbers.
>>
>> Similar to the x86 architecture, below comments also apply equally to
>> ARM64 architecture. So we can drop the tlb flush operation in
>> ptep_clear_flush_young() on ARM64 architecture to improve the 
>> performance.
>> "
>> /* Clearing the accessed bit without a TLB flush
>>   * doesn't cause data corruption. [ It could cause incorrect
>>   * page aging and the (mistaken) reclaim of hot pages, but the
>>   * chance of that should be relatively low. ]
>>   *
>>   * So as a performance optimization don't flush the TLB when
>>   * clearing the accessed bit, it will eventually be flushed by
>>   * a context switch or a VM operation anyway. [ In the rare
>>   * event of it not getting flushed for a long time the delay
>>   * shouldn't really matter because there's no real memory
>>   * pressure for swapout to react to. ]
>>   */
>> "
>> Running the thpscale to show some obvious improvements for compaction
>> latency with this patch:
>>                               base                   patched
>> Amean     fault-both-1      1093.19 (   0.00%)     1084.57 *   0.79%*
>> Amean     fault-both-3      2566.22 (   0.00%)     2228.45 *  13.16%*
>> Amean     fault-both-5      3591.22 (   0.00%)     3146.73 *  12.38%*
>> Amean     fault-both-7      4157.26 (   0.00%)     4113.67 *   1.05%*
>> Amean     fault-both-12     6184.79 (   0.00%)     5218.70 *  15.62%*
>> Amean     fault-both-18     9103.70 (   0.00%)     7739.71 *  14.98%*
>> Amean     fault-both-24    12341.73 (   0.00%)    10684.23 *  13.43%*
>> Amean     fault-both-30    15519.00 (   0.00%)    13695.14 *  11.75%*
>> Amean     fault-both-32    16189.15 (   0.00%)    14365.73 *  11.26%*
>>                         base       patched
>> Duration User         167.78      161.03
>> Duration System      1836.66     1673.01
>> Duration Elapsed     2074.58     2059.75
>>
>> Barry Song submitted a similar patch [1] before, that replaces the
>> ptep_clear_flush_young_notify() with ptep_clear_young_notify() in
>> folio_referenced_one(). However, I'm not sure if removing the tlb flush
>> operation is applicable to every architecture in kernel, so dropping
>> the tlb flush for ARM64 seems a sensible change.
> 
> At least x86/s390/riscv/powerpc already do it, also I think we could

Right.

> change pmdp_clear_flush_young_notify() too, since it is same with
> ptep_clear_flush_young_notify(),

Perhaps yes, but I'm still unsure if removing tlb flush for PMD entry is 
applicable to all architectures. Let's see the discussion in this 
thread. Thanks.
