Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C546280559A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345393AbjLENOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345392AbjLENOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:14:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E791A19F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:14:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7784AC433C8;
        Tue,  5 Dec 2023 13:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701782061;
        bh=O5GNZpS56vTlAeb2QJ111xlz1pBCEgIU0ujdWUZFmpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XG1QSHPUMz2FdfO4n6ey+JrYawyIPlw9UzKgbVQiZwcmALK4NrjWj3tPzg4Y5TDXw
         JzPs4x4iB1rDKTm9DiM5ClZgJMnoAdDlMj3tO550OgAQpvx3rOY6+O12icd+nDg4tD
         Hx11t6Nb0xybNvMBB1pFuHhE52yoIzHBUjNq7JIJ1RyOJyWXFK10fMGf6/eqv4t2CU
         hA1kLdtNprpW1oKEWHFPihWaAZOrepmA7QAy+7hhJTo2MhfjjVYm9NgjbgDOSecP+k
         mMt1N5Nj8XNMPIrEIsehcYcKwRI0yNNnK94Hpze0BauiN+pYbWzXWvl9s6ZTzliJap
         Xw65GcoiGpp+A==
Date:   Tue, 5 Dec 2023 13:14:14 +0000
From:   Will Deacon <will@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, suzuki.poulose@arm.com,
        mark.rutland@arm.com, anshuman.khandual@arm.com,
        namhyung@gmail.com, Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] arm64: perf: Add support for event counting
 threshold
Message-ID: <20231205131414.GA18119@willie-the-truck>
References: <20231124102857.1106453-1-james.clark@arm.com>
 <20231124102857.1106453-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124102857.1106453-3-james.clark@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 10:28:56AM +0000, James Clark wrote:
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 1d40d794f5e4..eb1ef84e1dbb 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -15,6 +15,7 @@
>  #include <clocksource/arm_arch_timer.h>
>  
>  #include <linux/acpi.h>
> +#include <linux/bitfield.h>
>  #include <linux/clocksource.h>
>  #include <linux/of.h>
>  #include <linux/perf/arm_pmu.h>
> @@ -294,9 +295,20 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
>  	.is_visible = armv8pmu_event_attr_is_visible,
>  };
>  
> +#define THRESHOLD_LOW		2
> +#define THRESHOLD_HIGH		13
> +#define THRESHOLD_CNT		14
> +#define THRESHOLD_CMP_LO	15
> +#define THRESHOLD_CMP_HI	16

Do you think THWIDTH might extend beyond 12 bits in future? If so, it might
be worth juggling these bits around a bit so it's not sandwiched between
'rdpmc' and 'threshold_compare'. I defer to your judgement, however.

>  PMU_FORMAT_ATTR(event, "config:0-15");
>  PMU_FORMAT_ATTR(long, "config1:0");
>  PMU_FORMAT_ATTR(rdpmc, "config1:1");
> +PMU_FORMAT_ATTR(threshold, "config1:" __stringify(THRESHOLD_LOW) "-"
> +				      __stringify(THRESHOLD_HIGH));
> +PMU_FORMAT_ATTR(threshold_compare, "config1:" __stringify(THRESHOLD_CMP_LO) "-"
> +					      __stringify(THRESHOLD_CMP_HI));
> +PMU_FORMAT_ATTR(threshold_count, "config1:" __stringify(THRESHOLD_CNT));
>  
>  static int sysctl_perf_user_access __read_mostly;
>  
> @@ -310,10 +322,33 @@ static inline bool armv8pmu_event_want_user_access(struct perf_event *event)
>  	return event->attr.config1 & 0x2;
>  }
>  
> +static inline u32 armv8pmu_event_threshold(struct perf_event_attr *attr)
> +{
> +	return FIELD_GET(GENMASK(THRESHOLD_HIGH, THRESHOLD_LOW), attr->config1);
> +}
> +
> +static inline u8 armv8pmu_event_threshold_control(struct perf_event_attr *attr)

You can drop the 'inline's for these functions (and, in fact, this whole
file could do with that cleanup :)

> +{
> +	u8 th_compare = FIELD_GET(GENMASK(THRESHOLD_CMP_HI, THRESHOLD_CMP_LO),
> +				  attr->config1);
> +	u8 th_count = FIELD_GET(BIT(THRESHOLD_CNT), attr->config1);

I think this is correct, but you might want to look at how we handle this
in the SPE driver as I think it ends up looking cleaner and makes it pretty
obvious which bits correspond to the user ABI (i.e. config fields) and which
bits are part of architectural registers. I'm not saying you have to do it
that way, but please take a look if you haven't already.

> +	/*
> +	 * The count bit is always the bottom bit of the full control field, and
> +	 * the comparison is the upper two bits, but it's not explicitly
> +	 * labelled in the Arm ARM. For the Perf interface we split it into two
> +	 * fields, so reconstruct it here.
> +	 */
> +	return (th_compare << 1) | th_count;
> +}
> +
>  static struct attribute *armv8_pmuv3_format_attrs[] = {
>  	&format_attr_event.attr,
>  	&format_attr_long.attr,
>  	&format_attr_rdpmc.attr,
> +	&format_attr_threshold.attr,
> +	&format_attr_threshold_compare.attr,
> +	&format_attr_threshold_count.attr,
>  	NULL,
>  };
>  
> @@ -365,10 +400,38 @@ static ssize_t bus_width_show(struct device *dev, struct device_attribute *attr,
>  
>  static DEVICE_ATTR_RO(bus_width);
>  
> +static u32 threshold_max(struct arm_pmu *cpu_pmu)
> +{
> +	/*
> +	 * PMMIR.THWIDTH is readable and non-zero on aarch32, but it would be
> +	 * impossible to write the threshold in the upper 32 bits of PMEVTYPER.
> +	 */
> +	if (IS_ENABLED(CONFIG_ARM))
> +		return 0;
> +
> +	/*
> +	 * The largest value that can be written to PMEVTYPER<n>_EL0.TH is
> +	 * (2 ^ PMMIR.THWIDTH) - 1.
> +	 */
> +	return (1 << FIELD_GET(ARMV8_PMU_THWIDTH, cpu_pmu->reg_pmmir)) - 1;
> +}
> +
> +static ssize_t threshold_max_show(struct device *dev,
> +				  struct device_attribute *attr, char *page)
> +{
> +	struct pmu *pmu = dev_get_drvdata(dev);
> +	struct arm_pmu *cpu_pmu = container_of(pmu, struct arm_pmu, pmu);
> +
> +	return sysfs_emit(page, "0x%08x\n", threshold_max(cpu_pmu));
> +}
> +
> +static DEVICE_ATTR_RO(threshold_max);
> +
>  static struct attribute *armv8_pmuv3_caps_attrs[] = {
>  	&dev_attr_slots.attr,
>  	&dev_attr_bus_slots.attr,
>  	&dev_attr_bus_width.attr,
> +	&dev_attr_threshold_max.attr,
>  	NULL,
>  };
>  
> @@ -552,7 +615,7 @@ static void armv8pmu_write_counter(struct perf_event *event, u64 value)
>  		armv8pmu_write_hw_counter(event, value);
>  }
>  
> -static inline void armv8pmu_write_evtype(int idx, u32 val)
> +static inline void armv8pmu_write_evtype(int idx, unsigned long val)
>  {
>  	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
>  	unsigned long mask = ARMV8_PMU_EVTYPE_EVENT |
> @@ -921,6 +984,10 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>  				     struct perf_event_attr *attr)
>  {
>  	unsigned long config_base = 0;
> +	struct perf_event *perf_event = container_of(attr, struct perf_event,
> +						     attr);
> +	struct arm_pmu *cpu_pmu = to_arm_pmu(perf_event->pmu);
> +	u32 th, th_max;
>  
>  	if (attr->exclude_idle)
>  		return -EPERM;
> @@ -952,6 +1019,21 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>  	if (attr->exclude_user)
>  		config_base |= ARMV8_PMU_EXCLUDE_EL0;
>  
> +	/*
> +	 * Insert event counting threshold (FEAT_PMUv3_TH) values. If
> +	 * FEAT_PMUv3_TH isn't implemented, then THWIDTH (threshold_max) will be
> +	 * 0 and no values will be written.
> +	 */
> +	th_max = threshold_max(cpu_pmu);
> +	if (IS_ENABLED(CONFIG_ARM64) && th_max) {

Why is the IS_ENABLED() check needed here?

> +		th = min(armv8pmu_event_threshold(attr), th_max);
> +		if (th) {

Why is it useful to take the minimum here? If userspace asks for a value
bigger than the maximum support threshold, shouldn't we return an error
rather than silently clamp it?

> +			config_base |= FIELD_PREP(ARMV8_PMU_EVTYPE_TH, th);
> +			config_base |= FIELD_PREP(ARMV8_PMU_EVTYPE_TC,
> +						  armv8pmu_event_threshold_control(attr));
> +		}
> +	}
> +
>  	/*
>  	 * Install the filter into config_base as this is used to
>  	 * construct the event type.
> diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
> index ddd1fec86739..ccbc0f9a74d8 100644
> --- a/include/linux/perf/arm_pmuv3.h
> +++ b/include/linux/perf/arm_pmuv3.h
> @@ -258,6 +258,7 @@
>  #define ARMV8_PMU_BUS_SLOTS_MASK 0xff
>  #define ARMV8_PMU_BUS_WIDTH_SHIFT 16
>  #define ARMV8_PMU_BUS_WIDTH_MASK 0xf
> +#define ARMV8_PMU_THWIDTH GENMASK(23, 20)

It's a bit messy having a mixture of GENMASK and MASK/SHIFT pairs. Please
can you either update what's there to use GENMASK, or use SHIFT/MASK for the
new addition?

Will
