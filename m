Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F127C6BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378020AbjJLLLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343805AbjJLLLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:11:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 761AF90
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 04:11:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04A9113D5;
        Thu, 12 Oct 2023 04:12:09 -0700 (PDT)
Received: from [10.163.62.137] (unknown [10.163.62.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BFF93F762;
        Thu, 12 Oct 2023 04:11:25 -0700 (PDT)
Message-ID: <5eabcdf7-f88c-4c79-a5c8-0c000493d72a@arm.com>
Date:   Thu, 12 Oct 2023 16:41:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver: perf: arm_pmu: Drop some unused arguments from
 armv8_pmu_init()
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20231009035638.165270-1-anshuman.khandual@arm.com>
 <896fc51e-2c74-29f7-2c7e-f14f29c401a4@arm.com>
 <c710e88c-b5d6-402a-95d0-fb6ced726d3a@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <c710e88c-b5d6-402a-95d0-fb6ced726d3a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/23 17:29, Robin Murphy wrote:
> On 09/10/2023 10:17 am, James Clark wrote:
>>
>>
>> On 09/10/2023 04:56, Anshuman Khandual wrote:
>>> There is just a single call site remaining for armv8_pmu_init(), passing on
>>> NULL pointers for all custom 'struct attribute_group'. These arguments are
>>> not really getting used and hence can just be dropped off, thus simplifying
>>> the code further.
>>>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> This applies on v6.6-rc5.
>>>
>>>   drivers/perf/arm_pmuv3.c | 17 +++++------------
>>>   1 file changed, 5 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>>> index 8fcaa26f0f8a..fe4db1831662 100644
>>> --- a/drivers/perf/arm_pmuv3.c
>>> +++ b/drivers/perf/arm_pmuv3.c
>>> @@ -1187,10 +1187,7 @@ static void armv8_pmu_register_sysctl_table(void)
>>>   }
>>>     static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>>> -              int (*map_event)(struct perf_event *event),
>>> -              const struct attribute_group *events,
>>> -              const struct attribute_group *format,
>>> -              const struct attribute_group *caps)
>>> +              int (*map_event)(struct perf_event *event))
>>>   {
>>>       int ret = armv8pmu_probe_pmu(cpu_pmu);
>>>       if (ret)
>>> @@ -1212,13 +1209,9 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>>>         cpu_pmu->name            = name;
>>>       cpu_pmu->map_event        = map_event;
>>> -    cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = events ?
>>> -            events : &armv8_pmuv3_events_attr_group;
>>> -    cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = format ?
>>> -            format : &armv8_pmuv3_format_attr_group;
>>> -    cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_CAPS] = caps ?
>>> -            caps : &armv8_pmuv3_caps_attr_group;
>>> -
>>> +    cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &armv8_pmuv3_events_attr_group;
>>> +    cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &armv8_pmuv3_format_attr_group;
>>> +    cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_CAPS] = &armv8_pmuv3_caps_attr_group;
>>>       armv8_pmu_register_sysctl_table();
>>>       return 0;
>>>   }
>>> @@ -1226,7 +1219,7 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>>>   static int armv8_pmu_init_nogroups(struct arm_pmu *cpu_pmu, char *name,
>>>                      int (*map_event)(struct perf_event *event))
>>>   {
>>> -    return armv8_pmu_init(cpu_pmu, name, map_event, NULL, NULL, NULL);
>>> +    return armv8_pmu_init(cpu_pmu, name, map_event);
>>
>> I think the whole point of the nogroups wrapper was to add the NULLs. If
>> you remove them, then you can remove the nogroups function too and just
>> call armv8_pmu_init() directly instead.
> 
> Indeed the "nogroups" wrapper is entirely meaningless if the callee no longer accepts groups anyway.
> 
>> And as it wasn't clear why they were there in the first place, I went to
>> look and found this (e424b17) :
>>
>>    Although nobody uses non-default sysfs attributes today, there's
>>    minimal impact to preserving the notion that maybe, some day, somebody
>>    might, so we may as well keep up appearances.
>>
>> It might be worth mentioning that the decision has now been made in the
>> other way.
> 
> Right, the intent at the time was very much just a cosmetic cleanup to help readability and simplify adding new PMU names, and rather deliberately stepping around the question of making material changes to the interface itself. If we've reached the point where we're happy to agree that consistency with the PMUv2 code is no longer helpful to continuing development of the PMUv3 code, then *that* would be the fundamental point of this change.

Does the following commit message sound complete after dropping off the
armv8_pmu_init_nogroups() helper as well.

    driver: perf: arm_pmuv3: Drop some unused arguments from armv8_pmu_init()
    
    There is just a single call site remaining for armv8_pmu_init(), passing on
    NULL pointers for all custom 'struct attribute_group'. These arguments are
    not really getting used, and hence can be dropped. Afterwards the function
    armv8_pmu_init_nogroups() itself becomes redundant and can also be dropped
    as well.
    
    The commit e424b1798526 ("arm64: perf: Refactor PMU init callbacks") wanted
    to preserve the notion that non-default sysfs attributes could be used some
    time in the future and hence armv8_pmu_init_nogroups() stayed on but now it
    can be dropped to remove some redundant indirection, simplifying the code.
