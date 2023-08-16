Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0D177E335
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245760AbjHPOFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjHPOFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:05:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96E12E48;
        Wed, 16 Aug 2023 07:05:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 855F5D75;
        Wed, 16 Aug 2023 07:05:59 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED8653F762;
        Wed, 16 Aug 2023 07:05:16 -0700 (PDT)
Message-ID: <0530f1e5-7716-413d-a7cb-9378aa120c18@arm.com>
Date:   Wed, 16 Aug 2023 15:05:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 3/4] perf: arm_cspmu: Support implementation specific
 validation
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
 <20230815063526.9022-4-ilkka@os.amperecomputing.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230815063526.9022-4-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 07:35, Ilkka Koskinen wrote:
> Some platforms may use e.g. different filtering mechanism and, thus,
> may need different way to validate the events and group.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


> ---
>   drivers/perf/arm_cspmu/arm_cspmu.c | 8 +++++++-
>   drivers/perf/arm_cspmu/arm_cspmu.h | 3 +++
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 94f6856ec786..585ce96ac03f 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -572,7 +572,7 @@ static void arm_cspmu_disable(struct pmu *pmu)
>   static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
>   				struct perf_event *event)
>   {
> -	int idx;
> +	int idx, ret;
>   	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
>   
>   	if (supports_cycle_counter(cspmu)) {
> @@ -606,6 +606,12 @@ static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
>   	if (idx >= cspmu->num_logical_ctrs)
>   		return -EAGAIN;
>   
> +	if (cspmu->impl.ops.validate_event) {
> +		ret = cspmu->impl.ops.validate_event(cspmu, event);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	set_bit(idx, hw_events->used_ctrs);
>   
>   	return idx;
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index 274ca3d10578..05577f74b8a0 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -107,6 +107,9 @@ struct arm_cspmu_impl_ops {
>   	/* Set event filter */
>   	void (*set_ev_filter)(struct arm_cspmu *cspmu,
>   			      struct hw_perf_event *hwc, u32 filter);
> +	/* Implementation specific event validation */
> +	int (*validate_event)(struct arm_cspmu *cspmu,
> +			      struct perf_event *event);
>   	/* Hide/show unsupported events */
>   	umode_t (*event_attr_is_visible)(struct kobject *kobj,
>   					 struct attribute *attr, int unused);

