Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6FC7BF0FC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441897AbjJJCgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441879AbjJJCgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:36:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 218429C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 19:36:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C95F1FB;
        Mon,  9 Oct 2023 19:36:53 -0700 (PDT)
Received: from [10.163.61.202] (unknown [10.163.61.202])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADAE53F7A6;
        Mon,  9 Oct 2023 19:36:10 -0700 (PDT)
Message-ID: <2ec03606-af40-48eb-81dd-963dfd4af704@arm.com>
Date:   Tue, 10 Oct 2023 08:06:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver: perf: arm_pmu: Drop some unused arguments from
 armv8_pmu_init()
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Robin Murphy <Robin.Murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20231009035638.165270-1-anshuman.khandual@arm.com>
 <896fc51e-2c74-29f7-2c7e-f14f29c401a4@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <896fc51e-2c74-29f7-2c7e-f14f29c401a4@arm.com>
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

On 10/9/23 14:47, James Clark wrote:
> 
> 
> On 09/10/2023 04:56, Anshuman Khandual wrote:
>> There is just a single call site remaining for armv8_pmu_init(), passing on
>> NULL pointers for all custom 'struct attribute_group'. These arguments are
>> not really getting used and hence can just be dropped off, thus simplifying
>> the code further.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on v6.6-rc5.
>>
>>  drivers/perf/arm_pmuv3.c | 17 +++++------------
>>  1 file changed, 5 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>> index 8fcaa26f0f8a..fe4db1831662 100644
>> --- a/drivers/perf/arm_pmuv3.c
>> +++ b/drivers/perf/arm_pmuv3.c
>> @@ -1187,10 +1187,7 @@ static void armv8_pmu_register_sysctl_table(void)
>>  }
>>  
>>  static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>> -			  int (*map_event)(struct perf_event *event),
>> -			  const struct attribute_group *events,
>> -			  const struct attribute_group *format,
>> -			  const struct attribute_group *caps)
>> +			  int (*map_event)(struct perf_event *event))
>>  {
>>  	int ret = armv8pmu_probe_pmu(cpu_pmu);
>>  	if (ret)
>> @@ -1212,13 +1209,9 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>>  
>>  	cpu_pmu->name			= name;
>>  	cpu_pmu->map_event		= map_event;
>> -	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = events ?
>> -			events : &armv8_pmuv3_events_attr_group;
>> -	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = format ?
>> -			format : &armv8_pmuv3_format_attr_group;
>> -	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_CAPS] = caps ?
>> -			caps : &armv8_pmuv3_caps_attr_group;
>> -
>> +	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &armv8_pmuv3_events_attr_group;
>> +	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &armv8_pmuv3_format_attr_group;
>> +	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_CAPS] = &armv8_pmuv3_caps_attr_group;
>>  	armv8_pmu_register_sysctl_table();
>>  	return 0;
>>  }
>> @@ -1226,7 +1219,7 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>>  static int armv8_pmu_init_nogroups(struct arm_pmu *cpu_pmu, char *name,
>>  				   int (*map_event)(struct perf_event *event))
>>  {
>> -	return armv8_pmu_init(cpu_pmu, name, map_event, NULL, NULL, NULL);
>> +	return armv8_pmu_init(cpu_pmu, name, map_event);
> 
> I think the whole point of the nogroups wrapper was to add the NULLs. If
> you remove them, then you can remove the nogroups function too and just
> call armv8_pmu_init() directly instead.

Sounds reasonable. Will change all the relevant functions to just call
armv8_pmu_init() directly.

> 
> And as it wasn't clear why they were there in the first place, I went to
> look and found this (e424b17) :
> 
>   Although nobody uses non-default sysfs attributes today, there's
>   minimal impact to preserving the notion that maybe, some day, somebody
>   might, so we may as well keep up appearances.
> 
> It might be worth mentioning that the decision has now been made in the
> other way.

Sure, will update the commit message to include this.

> 
> 
>>  }
>>  
>>  #define PMUV3_INIT_SIMPLE(name)						\
