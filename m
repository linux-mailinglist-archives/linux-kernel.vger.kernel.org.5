Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1627BF0E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441867AbjJJC1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379403AbjJJC1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:27:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62E31A4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 19:27:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D172B1FB;
        Mon,  9 Oct 2023 19:28:30 -0700 (PDT)
Received: from [10.163.61.202] (unknown [10.163.61.202])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEF673F7A6;
        Mon,  9 Oct 2023 19:27:47 -0700 (PDT)
Message-ID: <09877594-7d03-4f30-aec8-a0573bf295b8@arm.com>
Date:   Tue, 10 Oct 2023 07:57:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver: perf: arm_pmuv3: Read PMMIR_EL1 unconditionally
To:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, zhangshaokun@hisilicon.com
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20231009075631.193208-1-anshuman.khandual@arm.com>
 <ffb41c00-1df8-e4bb-deff-c2d1cfb15ec0@arm.com>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ffb41c00-1df8-e4bb-deff-c2d1cfb15ec0@arm.com>
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

On 10/9/23 14:29, James Clark wrote:
> 
> 
> On 09/10/2023 08:56, Anshuman Khandual wrote:
>> PMMIR_EL1 needs to be captured in 'armpmu->reg_pmmir', for all appropriate
>> PMU version implementations where the register is available and reading it
>> is valid . Hence checking for bus slot event presence is redundant and can
>> be dropped.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on v6.6-rc5.
>>  
>>  drivers/perf/arm_pmuv3.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>> index 1e72b486c033..9fc1b6da5106 100644
>> --- a/drivers/perf/arm_pmuv3.c
>> +++ b/drivers/perf/arm_pmuv3.c
>> @@ -1129,7 +1129,7 @@ static void __armv8pmu_probe_pmu(void *info)
>>  			     pmceid, ARMV8_PMUV3_MAX_COMMON_EVENTS);
>>  
>>  	/* store PMMIR register for sysfs */
>> -	if (is_pmuv3p4(pmuver) && (pmceid_raw[1] & BIT(31)))
>> +	if (is_pmuv3p4(pmuver))
>>  		cpu_pmu->reg_pmmir = read_pmmir();
>>  	else
>>  		cpu_pmu->reg_pmmir = 0;
> 
> 
> This does have the side effect of showing non-zero values in caps/slots
> even when the STALL_SLOT event isn't implemented. I think that's the
> scenario that the original commit (f5be3a61fd) was trying to avoid:

But the the sysfs interface is supposed to show all the PMMIR_EL1 based
HW attributes as captured irrespective of bus slots event's presence as
the register could be read on ARMv8.4-PMU without additional conditions
imposed upon from the architecture.

> 
>   /sys/bus/event_source/devices/armv8_pmuv3_0/caps/slots is exposed
>   under sysfs. [If] Both ARMv8.4-PMU and STALL_SLOT event are
>   implemented, it returns the slots from PMMIR_EL1, otherwise it will
>   return 0.

But that additional requirement of STALL_SLOT event is just SW mandated
without any architectural backing.

> 
> I can't really think of a scenario where that would be an issue, and the
> availability of the STALL_SLOT event is already discoverable from
> userspace through the events folder, so it's probably fine.

Absolutely.

> 
> Adding the original author just in case. But otherwise:
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks !
