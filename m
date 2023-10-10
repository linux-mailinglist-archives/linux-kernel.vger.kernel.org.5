Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1C97BF5D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442640AbjJJI2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442726AbjJJI2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:28:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FDD09F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:28:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC73F1FB;
        Tue, 10 Oct 2023 01:29:11 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC76A3F7A6;
        Tue, 10 Oct 2023 01:28:29 -0700 (PDT)
Message-ID: <948c6cdd-5a46-6b4b-37a9-9f971a4853a8@arm.com>
Date:   Tue, 10 Oct 2023 09:28:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drivers: perf: arm_pmuv3: Update 'pmc_width' based on
 actual HW event width
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, raphael.gault@arm.com
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20231009043724.175100-1-anshuman.khandual@arm.com>
 <66125bc2-ff2a-a209-a753-c2e3d8310a45@arm.com>
 <8a5d2411-3fab-4f21-adb5-f99a2d4b3bee@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <8a5d2411-3fab-4f21-adb5-f99a2d4b3bee@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2023 04:03, Anshuman Khandual wrote:
> Hi James,
> 
> On 10/9/23 15:13, James Clark wrote:
>>
>>
>> On 09/10/2023 05:37, Anshuman Khandual wrote:
>>> This updates 'perf_event_mmap_page->pmc_width' based on actual HW event's
>>> width that are currently missing i.e ARMPMU_EVT_63BIT and ARMPMU_EVT_47BIT.
>>>
>>
>> Might be worth adding why this is needed or what the actual effect is.
> 
> To have correct 'pmc_width' visible to the user space ?

Well yeah, but for example I didn't know what that was. And it's not
clear why it needs updating at this point in time without a link to any
other commit or relevant section from the Arm ARM. So I had a kind of a
"why now" question.

"To have correct 'pmc_width' visible to the user space" is definitely
more of a what than a why.

> 
>>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> This applies on v6.6-rc5.
>>>
>>>  drivers/perf/arm_pmuv3.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>>> index fe4db1831662..94723d00548e 100644
>>> --- a/drivers/perf/arm_pmuv3.c
>>> +++ b/drivers/perf/arm_pmuv3.c
>>> @@ -1375,6 +1375,10 @@ void arch_perf_update_userpage(struct perf_event *event,
>>>  	if (userpg->cap_user_rdpmc) {
>>>  		if (event->hw.flags & ARMPMU_EVT_64BIT)
>>>  			userpg->pmc_width = 64;
>>> +		else if (event->hw.flags & ARMPMU_EVT_63BIT)
>>> +			userpg->pmc_width = 63;
>>> +		else if (event->hw.flags & ARMPMU_EVT_47BIT)
>>> +			userpg->pmc_width = 47;
>>
>> Although it doesn't explicitly say it, the bit of the docs about
>> pmc_width in Documentation/arch/arm64/perf.rst loosely implies that this
>> is always either 64 or 32. Now that this isn't the case it could mislead
>> someone in userspace that they don't have to handle the now arbitrary
>> bit widths rather than just whole bytes/ints.
> 
> Are you suggesting that the user space would not handle pmc_width correctly
> , once it deviates from a whole bytes/ints format ? In that case user space
> handling might need some fixing.
> 

Not really, I'm just suggesting that anyone writing a new tool and only
reading the docs could make that assumption. Seeing as only 32 and 64
bit options are mentioned. So it's more to avoid misleading someone in
the future than about fixing any existing code, as updating the docs
wouldn't have that effect.

>>
>> I think the fix is as simple as adding something like "the width may not
>> match the requested value or necessarily be a multiple of 8". Unless we
>> think this is already widely known and I suppose we could leave it as
>> is. (The existing bit in perf that uses it already handles it correctly).
> 
> This is from perf_event_mmap_page definition where it does not assert the
> width to be multiple of bytes or ints. Hence the assumption should not be
> made into the user space tools.
> 

Yeah I know its already ok for Perf which is why I mentioned it. But
there are more tools out there than Perf, and ones that don't even exist
yet, which people would normally read the documentation before writing.

>         /*
>          * If cap_user_rdpmc this field provides the bit-width of the value
>          * read using the rdpmc() or equivalent instruction. This can be used
>          * to sign extend the result like:
>          *
>          *   pmc <<= 64 - width;
>          *   pmc >>= 64 - width; // signed shift right
>          *   count += pmc;
>          */
>         __u16   pmc_width;
> 
> Moreover, on x86 too 'userpg->pmc_width' gets assigned to different values
> although multiple of 8.
> 
> userpg->pmc_width = x86_pmu.cntval_bits
> arch/x86/events/amd/core.c:     .cntval_bits            = 48
> arch/x86/events/intel/knc.c:    .cntval_bits            = 40
> arch/x86/events/intel/p6.c:     .cntval_bits            = 32
> 
>>
>>>  		else
>>>  			userpg->pmc_width = 32;
>>>  	}
