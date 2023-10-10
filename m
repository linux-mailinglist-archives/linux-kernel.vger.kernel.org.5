Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C3C7C013B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjJJQJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjJJQI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:08:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53813E9;
        Tue, 10 Oct 2023 09:08:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCA74C15;
        Tue, 10 Oct 2023 09:09:33 -0700 (PDT)
Received: from [10.57.3.103] (unknown [10.57.3.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B788C3F7A6;
        Tue, 10 Oct 2023 09:08:50 -0700 (PDT)
Message-ID: <c0e2fafd-08af-c0db-bfec-74a4d2457050@arm.com>
Date:   Tue, 10 Oct 2023 17:08:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] arm64: perf: Add support for event counting
 threshold
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Reiji Watanabe <reijiw@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Zaid Al-Bassam <zalbassam@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
References: <20231010104048.1923484-1-james.clark@arm.com>
 <20231010104048.1923484-3-james.clark@arm.com>
 <c978b02b-2c82-06a6-f63a-67729524bf6c@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <c978b02b-2c82-06a6-f63a-67729524bf6c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2023 16:00, Suzuki K Poulose wrote:
> On 10/10/2023 11:40, James Clark wrote:
>> FEAT_PMUv3_TH (Armv8.8) permits a PMU counter to increment only on
>> events whose count meets a specified threshold condition. For example if
>> PMEVTYPERn.TC (Threshold Control) is set to 0b101 (Greater than or
>> equal, count), and the threshold is set to 2, then the PMU counter will
>> now only increment by 1 when an event would have previously incremented
>> the PMU counter by 2 or more on a single processor cycle.
>>
>> Two new Perf event config fields, 'threshold' and 'threshold_control'
>> have been added for controlling the feature:
>>
>>    $ perf stat -e stall_slot/threshold=2,threshold_control=5/
>>
>> A new capability for reading out the maximum supported threshold value
>> has also been added:
>>
>>    $ cat /sys/bus/event_source/devices/armv8_pmuv3/caps/threshold_max
>>
>>    0x000000ff
>>
>> If a threshold higher than threshold_max is provided, then no error is
>> generated but the threshold is clamped to the max value. If
>> FEAT_PMUv3_TH isn't implemented or a 32 bit kernel is running, then
>> threshold_max reads zero, and neither the 'threshold' nor
>> 'threshold_control' parameters will be used.
>>
>> The threshold is per PMU counter, and there are potentially different
>> threshold_max values per PMU type on heterogeneous systems.
>>
>> Bits higher than 32 now need to be written into PMEVTYPER, so
>> armv8pmu_write_evtype() has to be updated to take an unsigned long value
>> rather than u32 which gives the correct behavior on both aarch32 and 64.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   drivers/perf/arm_pmuv3.c       | 67 +++++++++++++++++++++++++++++++++-
>>   include/linux/perf/arm_pmuv3.h |  1 +
>>   2 files changed, 67 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>> index 8fcaa26f0f8a..6d669b16a2bc 100644
>> --- a/drivers/perf/arm_pmuv3.c
>> +++ b/drivers/perf/arm_pmuv3.c
>> @@ -15,6 +15,7 @@
>>   #include <clocksource/arm_arch_timer.h>
>>     #include <linux/acpi.h>
>> +#include <linux/bitfield.h>
>>   #include <linux/clocksource.h>
>>   #include <linux/of.h>
>>   #include <linux/perf/arm_pmu.h>
>> @@ -294,9 +295,16 @@ static const struct attribute_group
>> armv8_pmuv3_events_attr_group = {
>>       .is_visible = armv8pmu_event_attr_is_visible,
>>   };
>>   +#define TH_LO    2
>> +#define TH_HI    13
>> +#define TH_CNTL_LO    14
>> +#define TH_CNTL_HI    16
>> +
>>   PMU_FORMAT_ATTR(event, "config:0-15");
>>   PMU_FORMAT_ATTR(long, "config1:0");
>>   PMU_FORMAT_ATTR(rdpmc, "config1:1");
>> +PMU_FORMAT_ATTR(threshold, "config1:" __stringify(TH_LO) "-"
>> __stringify(TH_HI));
>> +PMU_FORMAT_ATTR(threshold_control, "config1:" __stringify(TH_CNTL_LO)
>> "-" __stringify(TH_CNTL_HI));
> 
> 
>>     static int sysctl_perf_user_access __read_mostly;
>>   @@ -310,10 +318,22 @@ static inline bool
>> armv8pmu_event_want_user_access(struct perf_event *event)
>>       return event->attr.config1 & 0x2;
>>   }
>>   +static inline u32 armv8pmu_event_threshold(struct perf_event_attr
>> *attr)
>> +{
>> +    return FIELD_GET(GENMASK(TH_HI, TH_LO), attr->config1);
>> +}
>> +
>> +static inline u8 armv8pmu_event_threshold_control(struct
>> perf_event_attr *attr)
>> +{
>> +    return FIELD_GET(GENMASK(TH_CNTL_HI, TH_CNTL_LO), attr->config1);
>> +}
>> +
>>   static struct attribute *armv8_pmuv3_format_attrs[] = {
>>       &format_attr_event.attr,
>>       &format_attr_long.attr,
>>       &format_attr_rdpmc.attr,
> 
>> +    &format_attr_threshold.attr,
>> +    &format_attr_threshold_control.attr,
> 
> Given this is not supported for !CONFIG_ARM64, does it make sense to
> remove them for that case, given we already take care of this in
> the code using IS_ENABLED(CONFIG_ARM64) ? The nice part is that
> the arm32 doesn't see something that is never usable. I understand
> the maxthreshold=0 already gives out the hint.

I thought about it, but wouldn't it just move the IS_ENABLED somewhere
else? I think it's messier on the kernel side to conditionally show or
hide these files.

From the userspace side, they already have to handle both cases of the
missing file (old kernels) and a zero value. So I can't really see a
difference that makes it worthwhile to change.

Unless there is some kind of precedent to hiding sysfs files for
unavailable features? I mean maybe in that case you would also say to
hide the files if max width was 0 even on aarch64? If we don't want to
show things that aren't usable?

One other note that may not be obvious: the IS_ENABLED(CONFIG_ARM64) is
only needed to make the build succeed by not shifting things above 32
bits. Because the compiler couldn't see that threshold_max() always
returns 0 on aarch32. If it could then only one IS_ENABLED(CONFIG_ARM)
would be needed in threshold_max(). Although that's not really related
to showing or hiding the files.

> 
> Rest looks fine to me.
> 
>>       NULL,
>>   };
>>   @@ -365,10 +385,38 @@ static ssize_t bus_width_show(struct device
>> *dev, struct device_attribute *attr,
>>     static DEVICE_ATTR_RO(bus_width);
>>   +static u32 threshold_max(struct arm_pmu *cpu_pmu)
>> +{
>> +    /*
>> +     * PMMIR.WIDTH is readable and non-zero on aarch32, but it would be
>> +     * impossible to write the threshold in the upper 32 bits of
>> PMEVTYPER.
>> +     */
>> +    if (IS_ENABLED(CONFIG_ARM))
>> +        return 0;
>> +
>> +    /*
>> +     * The largest value that can be written to PMEVTYPER<n>_EL0.TH is
>> +     * (2 ^ PMMIR.THWIDTH) - 1.
>> +     */
>> +    return (1 << FIELD_GET(ARMV8_PMU_THWIDTH, cpu_pmu->reg_pmmir)) - 1;
>> +}
>> +
>> +static ssize_t threshold_max_show(struct device *dev,
>> +                  struct device_attribute *attr, char *page)
>> +{
>> +    struct pmu *pmu = dev_get_drvdata(dev);
>> +    struct arm_pmu *cpu_pmu = container_of(pmu, struct arm_pmu, pmu);
>> +
>> +    return sysfs_emit(page, "0x%08x\n", threshold_max(cpu_pmu));
>> +}
>> +
>> +static DEVICE_ATTR_RO(threshold_max);
>> +
>>   static struct attribute *armv8_pmuv3_caps_attrs[] = {
>>       &dev_attr_slots.attr,
>>       &dev_attr_bus_slots.attr,
>>       &dev_attr_bus_width.attr,
>> +    &dev_attr_threshold_max.attr,
> 
> Similarly here and could avoid the IS_ENABLED(CONFIG_ARM) above.

I don't think it can be avoided entirely, just moved somewhere else.

> 
> Suzuki
> 
> 
>>       NULL,
>>   };
>>   @@ -552,7 +600,7 @@ static void armv8pmu_write_counter(struct
>> perf_event *event, u64 value)
>>           armv8pmu_write_hw_counter(event, value);
>>   }
>>   -static inline void armv8pmu_write_evtype(int idx, u32 val)
>> +static inline void armv8pmu_write_evtype(int idx, unsigned long val)
>>   {
>>       u32 counter = ARMV8_IDX_TO_COUNTER(idx);
>>   @@ -914,6 +962,10 @@ static int armv8pmu_set_event_filter(struct
>> hw_perf_event *event,
>>                        struct perf_event_attr *attr)
>>   {
>>       unsigned long config_base = 0;
>> +    struct perf_event *perf_event = container_of(attr, struct
>> perf_event,
>> +                             attr);
>> +    struct arm_pmu *cpu_pmu = to_arm_pmu(perf_event->pmu);
>> +    u32 th, th_max;
>>         if (attr->exclude_idle)
>>           return -EPERM;
>> @@ -945,6 +997,19 @@ static int armv8pmu_set_event_filter(struct
>> hw_perf_event *event,
>>       if (attr->exclude_user)
>>           config_base |= ARMV8_PMU_EXCLUDE_EL0;
>>   +    /*
>> +     * Insert event counting threshold (FEAT_PMUv3_TH) values. If
>> +     * FEAT_PMUv3_TH isn't implemented, then THWIDTH (threshold_max)
>> will be
>> +     * 0 and no values will be written.
>> +     */
>> +    th_max = threshold_max(cpu_pmu);
>> +    if (IS_ENABLED(CONFIG_ARM64) && th_max) {
>> +        th = min(armv8pmu_event_threshold(attr), th_max);
>> +        config_base |= FIELD_PREP(ARMV8_PMU_EVTYPE_TH, th);
>> +        config_base |= FIELD_PREP(ARMV8_PMU_EVTYPE_TC,
>> +                      armv8pmu_event_threshold_control(attr));
>> +    }
>> +
>>       /*
>>        * Install the filter into config_base as this is used to
>>        * construct the event type.
>> diff --git a/include/linux/perf/arm_pmuv3.h
>> b/include/linux/perf/arm_pmuv3.h
>> index ec3a01502e7c..753f8dbd9d10 100644
>> --- a/include/linux/perf/arm_pmuv3.h
>> +++ b/include/linux/perf/arm_pmuv3.h
>> @@ -255,6 +255,7 @@
>>   #define ARMV8_PMU_BUS_SLOTS_MASK 0xff
>>   #define ARMV8_PMU_BUS_WIDTH_SHIFT 16
>>   #define ARMV8_PMU_BUS_WIDTH_MASK 0xf
>> +#define ARMV8_PMU_THWIDTH GENMASK(23, 20)
>>     /*
>>    * This code is really good
> 
