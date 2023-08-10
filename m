Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AD3776F59
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjHJFFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjHJFFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:05:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A75B210E0;
        Wed,  9 Aug 2023 22:05:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89704D75;
        Wed,  9 Aug 2023 22:06:32 -0700 (PDT)
Received: from [10.162.42.7] (unknown [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8FF33F64C;
        Wed,  9 Aug 2023 22:05:45 -0700 (PDT)
Message-ID: <0ed54ef6-e502-7c33-6e3f-08de76786245@arm.com>
Date:   Thu, 10 Aug 2023 10:35:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V13 - RESEND 01/10] drivers: perf: arm_pmu: Add new
 sched_task() callback
Content-Language: en-US
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
 <20230711082455.215983-2-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230711082455.215983-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Will,

I am just wondering - would it be possible for you to take this pre-requisite
patch stand alone for the upcoming merge window. This has been acked by Mark
earlier. Besides, I am also working on your other suggestions on the series,
and will respond soon. Thank you.

- Anshuman

On 7/11/23 13:54, Anshuman Khandual wrote:
> This adds armpmu_sched_task(), as generic pmu's sched_task() override which
> in turn can utilize a new arm_pmu.sched_task() callback when available from
> the arm_pmu instance. This new callback will be used while enabling BRBE in
> ARMV8 PMU.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Tested-by: James Clark <james.clark@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/perf/arm_pmu.c       | 9 +++++++++
>  include/linux/perf/arm_pmu.h | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index f6ccb2cd4dfc..c0475a96c2a0 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -519,6 +519,14 @@ static int armpmu_event_init(struct perf_event *event)
>  	return __hw_perf_event_init(event);
>  }
>  
> +static void armpmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
> +{
> +	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
> +
> +	if (armpmu->sched_task)
> +		armpmu->sched_task(pmu_ctx, sched_in);
> +}
> +
>  static void armpmu_enable(struct pmu *pmu)
>  {
>  	struct arm_pmu *armpmu = to_arm_pmu(pmu);
> @@ -865,6 +873,7 @@ struct arm_pmu *armpmu_alloc(void)
>  	}
>  
>  	pmu->pmu = (struct pmu) {
> +		.sched_task	= armpmu_sched_task,
>  		.pmu_enable	= armpmu_enable,
>  		.pmu_disable	= armpmu_disable,
>  		.event_init	= armpmu_event_init,
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index a0801f68762b..3d3bd944d630 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -102,6 +102,7 @@ struct arm_pmu {
>  	void		(*stop)(struct arm_pmu *);
>  	void		(*reset)(void *);
>  	int		(*map_event)(struct perf_event *event);
> +	void		(*sched_task)(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
>  	int		num_events;
>  	bool		secure_access; /* 32-bit ARM only */
>  #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
