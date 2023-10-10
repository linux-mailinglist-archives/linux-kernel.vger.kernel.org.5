Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340A67BF133
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441904AbjJJDDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378482AbjJJDDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:03:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D9059E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 20:03:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C901C1FB;
        Mon,  9 Oct 2023 20:04:21 -0700 (PDT)
Received: from [10.163.61.202] (unknown [10.163.61.202])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2AF93F762;
        Mon,  9 Oct 2023 20:03:38 -0700 (PDT)
Message-ID: <8a5d2411-3fab-4f21-adb5-f99a2d4b3bee@arm.com>
Date:   Tue, 10 Oct 2023 08:33:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: perf: arm_pmuv3: Update 'pmc_width' based on
 actual HW event width
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, raphael.gault@arm.com
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20231009043724.175100-1-anshuman.khandual@arm.com>
 <66125bc2-ff2a-a209-a753-c2e3d8310a45@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <66125bc2-ff2a-a209-a753-c2e3d8310a45@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/9/23 15:13, James Clark wrote:
> 
> 
> On 09/10/2023 05:37, Anshuman Khandual wrote:
>> This updates 'perf_event_mmap_page->pmc_width' based on actual HW event's
>> width that are currently missing i.e ARMPMU_EVT_63BIT and ARMPMU_EVT_47BIT.
>>
> 
> Might be worth adding why this is needed or what the actual effect is.

To have correct 'pmc_width' visible to the user space ?

> 
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on v6.6-rc5.
>>
>>  drivers/perf/arm_pmuv3.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>> index fe4db1831662..94723d00548e 100644
>> --- a/drivers/perf/arm_pmuv3.c
>> +++ b/drivers/perf/arm_pmuv3.c
>> @@ -1375,6 +1375,10 @@ void arch_perf_update_userpage(struct perf_event *event,
>>  	if (userpg->cap_user_rdpmc) {
>>  		if (event->hw.flags & ARMPMU_EVT_64BIT)
>>  			userpg->pmc_width = 64;
>> +		else if (event->hw.flags & ARMPMU_EVT_63BIT)
>> +			userpg->pmc_width = 63;
>> +		else if (event->hw.flags & ARMPMU_EVT_47BIT)
>> +			userpg->pmc_width = 47;
> 
> Although it doesn't explicitly say it, the bit of the docs about
> pmc_width in Documentation/arch/arm64/perf.rst loosely implies that this
> is always either 64 or 32. Now that this isn't the case it could mislead
> someone in userspace that they don't have to handle the now arbitrary
> bit widths rather than just whole bytes/ints.

Are you suggesting that the user space would not handle pmc_width correctly
, once it deviates from a whole bytes/ints format ? In that case user space
handling might need some fixing.

> 
> I think the fix is as simple as adding something like "the width may not
> match the requested value or necessarily be a multiple of 8". Unless we
> think this is already widely known and I suppose we could leave it as
> is. (The existing bit in perf that uses it already handles it correctly).

This is from perf_event_mmap_page definition where it does not assert the
width to be multiple of bytes or ints. Hence the assumption should not be
made into the user space tools.

        /*
         * If cap_user_rdpmc this field provides the bit-width of the value
         * read using the rdpmc() or equivalent instruction. This can be used
         * to sign extend the result like:
         *
         *   pmc <<= 64 - width;
         *   pmc >>= 64 - width; // signed shift right
         *   count += pmc;
         */
        __u16   pmc_width;

Moreover, on x86 too 'userpg->pmc_width' gets assigned to different values
although multiple of 8.

userpg->pmc_width = x86_pmu.cntval_bits
arch/x86/events/amd/core.c:     .cntval_bits            = 48
arch/x86/events/intel/knc.c:    .cntval_bits            = 40
arch/x86/events/intel/p6.c:     .cntval_bits            = 32

> 
>>  		else
>>  			userpg->pmc_width = 32;
>>  	}
