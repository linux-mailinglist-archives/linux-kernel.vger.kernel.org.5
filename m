Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1C377E330
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245749AbjHPOEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343500AbjHPODv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:03:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0681226B2;
        Wed, 16 Aug 2023 07:03:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF7A5D75;
        Wed, 16 Aug 2023 07:04:30 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 318B43F762;
        Wed, 16 Aug 2023 07:03:48 -0700 (PDT)
Message-ID: <e51863c0-496b-9630-e61a-2faa74356118@arm.com>
Date:   Wed, 16 Aug 2023 15:03:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 2/4] perf: arm_cspmu: Support implementation specific
 filters
Content-Language: en-US
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230815063526.9022-1-ilkka@os.amperecomputing.com>
 <20230815063526.9022-3-ilkka@os.amperecomputing.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230815063526.9022-3-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 07:35, Ilkka Koskinen wrote:
> ARM Coresight PMU architecture specification [1] defines PMEVTYPER and
> PMEVFILT* registers as optional in Chapter 2.1. Moreover, implementers may
> choose to use PMIMPDEF* registers (offset: 0xD80-> 0xDFF) to filter the
> events. Add support for those by adding implementation specific filter
> callback function.
> 
> [1] https://developer.arm.com/documentation/ihi0091/latest
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
>   drivers/perf/arm_cspmu/arm_cspmu.c | 12 ++++++++----
>   drivers/perf/arm_cspmu/arm_cspmu.h |  3 +++
>   2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 6387cbad7a7d..94f6856ec786 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -116,6 +116,9 @@ static unsigned long arm_cspmu_cpuhp_state;
>   
>   static DEFINE_MUTEX(arm_cspmu_lock);
>   
> +static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
> +				    struct hw_perf_event *hwc, u32 filter);
> +
>   static struct acpi_apmt_node *arm_cspmu_apmt_node(struct device *dev)
>   {
>   	return *(struct acpi_apmt_node **)dev_get_platdata(dev);
> @@ -450,6 +453,7 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
>   	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_type);
>   	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_filter);
>   	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_attr_is_visible);
> +	CHECK_DEFAULT_IMPL_OPS(impl_ops, set_ev_filter);
>   
>   	return 0;
>   }
> @@ -811,9 +815,9 @@ static inline void arm_cspmu_set_event(struct arm_cspmu *cspmu,
>   	writel(hwc->config, cspmu->base0 + offset);
>   }
>   
> -static inline void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
> -					   struct hw_perf_event *hwc,
> -					   u32 filter)
> +static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
> +					struct hw_perf_event *hwc,
> +					u32 filter)
>   {
>   	u32 offset = PMEVFILTR + (4 * hwc->idx);
>   
> @@ -845,7 +849,7 @@ static void arm_cspmu_start(struct perf_event *event, int pmu_flags)
>   		arm_cspmu_set_cc_filter(cspmu, filter);
>   	} else {
>   		arm_cspmu_set_event(cspmu, hwc);
> -		arm_cspmu_set_ev_filter(cspmu, hwc, filter);
> +		cspmu->impl.ops.set_ev_filter(cspmu, hwc, filter);
>   	}
>   
>   	hwc->state = 0;
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index e5c6dff2ce7f..274ca3d10578 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -104,6 +104,9 @@ struct arm_cspmu_impl_ops {
>   	u32 (*event_type)(const struct perf_event *event);
>   	/* Decode filter value from configs */
>   	u32 (*event_filter)(const struct perf_event *event);
> +	/* Set event filter */
> +	void (*set_ev_filter)(struct arm_cspmu *cspmu,
> +			      struct hw_perf_event *hwc, u32 filter);
>   	/* Hide/show unsupported events */
>   	umode_t (*event_attr_is_visible)(struct kobject *kobj,
>   					 struct attribute *attr, int unused);

