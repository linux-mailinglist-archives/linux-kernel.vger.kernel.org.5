Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C18877E4BB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344021AbjHPPKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344081AbjHPPKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:10:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 289C8198C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:10:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E50A6D75;
        Wed, 16 Aug 2023 08:10:50 -0700 (PDT)
Received: from [10.57.90.114] (unknown [10.57.90.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A89DB3F762;
        Wed, 16 Aug 2023 08:10:08 -0700 (PDT)
Message-ID: <d0fe22e2-dea9-123c-6c8b-d89fe31b6592@arm.com>
Date:   Wed, 16 Aug 2023 16:10:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/2] iommu/iova: Make the rcache depot properly flexible
To:     John Garry <john.g.garry@oracle.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, zhangzekun11@huawei.com
References: <cover.1692033783.git.robin.murphy@arm.com>
 <80fb865a-eb45-e783-277d-0d2e044c28f5@oracle.com>
 <b9bda816-612c-b646-63e7-54cb3fedf1f4@arm.com>
 <1aa1ecad-bdf0-84c8-a37f-94e1d0fb8a03@oracle.com>
Content-Language: en-GB
In-Reply-To: <1aa1ecad-bdf0-84c8-a37f-94e1d0fb8a03@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 2:35 pm, John Garry wrote:
> On 15/08/2023 12:11, Robin Murphy wrote:
>>>
>>> This threshold is the number of online CPUs, right?
>>
>> Yes, that's nominally half of the current fixed size (based on all the 
>> performance figures from the original series seemingly coming from a 
>> 16-thread machine, 
> 
> If you are talking about 
> https://lore.kernel.org/linux-iommu/20230811130246.42719-1-zhangzekun11@huawei.com/,

No, I mean the *original* rcache patch submission, and its associated paper:

https://lore.kernel.org/linux-iommu/cover.1461135861.git.mad@cs.technion.ac.il/

> then I think it's a 256-CPU system and the DMA controller has 16 HW queues. The 16 HW queues are relevant as the per-completion queue interrupt handler runs on a fixed CPU from the set of 16 CPUs in the HW queue interrupt handler affinity mask. And what this means is while any CPU may alloc an IOVA, only those 16 CPUs handling each HW queue interrupt will be free'ing IOVAs.
> 
>> but seemed like a fair compromise. I am of course keen to see how 
>> real-world testing actually pans out.
>>
>>>> it's enough of a challenge to get my 4-core dev board with spinning 
>>>> disk
>>>> and gigabit ethernet to push anything into a depot at all 😄
>>>>
>>>
>>> I have to admit that I was hoping to also see a more aggressive 
>>> reclaim strategy, where we also trim the per-CPU rcaches when not in 
>>> use. Leizhen proposed something like this a long time ago.
>>
>> Don't think I haven't been having various elaborate ideas for making 
>> it cleverer with multiple thresholds and self-tuning, however I have 
>> managed to restrain myself 😉
>>
> 
> OK, understood. My main issue WRT scalability is that the total 
> cacheable IOVAs (CPU and depot rcache) scales up with the number of 
> CPUs, but many DMA controllers have a fixed number of max in-flight 
> requests.
> 
> Consider a SCSI storage controller on a 256-CPU system. The in-flight 
> limit for this example controller is 4096, which would typically never 
> be even used up or may not be even usable.
> 
> For this device, we need 4096 * 6 [IOVA rcache range] = ~24K cached 
> IOVAs if we were to pre-allocate them all - obviously I am ignoring that 
> we have the per-CPU rcache for speed and it would not make sense to 
> share one set. However, according to current IOVA driver, we can in 
> theory cache upto ((256 [CPUs] * 2 [loaded + prev]) + 32 [depot size]) * 
> 6 [rcache range] * 128 (IOVA per mag) = ~420K IOVAs. That's ~17x what we 
> would ever need.
> 
> Something like NVMe is different, as its total requests can scale up 
> with the CPU count, but only to a limit. I am not sure about network 
> controllers.

Remember that this threshold only represents a point at which we 
consider the cache to have grown "big enough" to start background 
reclaim - over the short term it is neither an upper nor a lower limit 
on the cache capacity itself. Indeed it will be larger than the working 
set of some workloads, but then it still wants to be enough of a buffer 
to be useful for others which do make big bursts of allocations only 
periodically.

> Anyway, this is just something which I think should be considered - 
> which I guess already has been.

Indeed, I would tend to assume that machines with hundreds of CPUs are 
less likely to be constrained on overall memory and/or IOVA space, so 
tuning for a more responsive cache should be more beneficial than any 
potential wastage is detrimental.

Cheers,
Robin.
