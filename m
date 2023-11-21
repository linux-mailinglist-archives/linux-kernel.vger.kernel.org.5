Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18F37F29EA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjKUKPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjKUKPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:15:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7E37A2;
        Tue, 21 Nov 2023 02:15:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EE661FB;
        Tue, 21 Nov 2023 02:15:52 -0800 (PST)
Received: from [10.57.42.32] (unknown [10.57.42.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A3833F73F;
        Tue, 21 Nov 2023 02:15:04 -0800 (PST)
Message-ID: <ce58fda9-e666-4298-a996-eb0cff6b41a6@arm.com>
Date:   Tue, 21 Nov 2023 10:15:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] arm64: perf: Include threshold control fields in
 PMEVTYPER mask
Content-Language: en-GB
To:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, will@kernel.org,
        mark.rutland@arm.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231113112507.917107-1-james.clark@arm.com>
 <20231113112507.917107-2-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20231113112507.917107-2-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2023 11:25, James Clark wrote:
> FEAT_PMUv3_TH (Armv8.8) adds two new fields to PMEVTYPER, so include
> them in the mask. These aren't writable on 32 bit kernels as they are in
> the high part of the register, so only include them for arm64.
> 
> It would be difficult to do this statically in the asm header files for
> each platform without resulting in circular includes or #ifdefs inline
> in the code. For that reason the ARMV8_PMU_EVTYPE_MASK definition has
> been removed and the mask is constructed programmatically.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


> ---
>   drivers/perf/arm_pmuv3.c       | 9 ++++++++-
>   include/linux/perf/arm_pmuv3.h | 3 ++-
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 6ca7be05229c..1d40d794f5e4 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -555,8 +555,15 @@ static void armv8pmu_write_counter(struct perf_event *event, u64 value)
>   static inline void armv8pmu_write_evtype(int idx, u32 val)
>   {
>   	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
> +	unsigned long mask = ARMV8_PMU_EVTYPE_EVENT |
> +			     ARMV8_PMU_INCLUDE_EL2 |
> +			     ARMV8_PMU_EXCLUDE_EL0 |
> +			     ARMV8_PMU_EXCLUDE_EL1;
>   
> -	val &= ARMV8_PMU_EVTYPE_MASK;
> +	if (IS_ENABLED(CONFIG_ARM64))
> +		mask |= ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_TH;
> +
> +	val &= mask;
>   	write_pmevtypern(counter, val);
>   }
>   
> diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
> index 9c226adf938a..ddd1fec86739 100644
> --- a/include/linux/perf/arm_pmuv3.h
> +++ b/include/linux/perf/arm_pmuv3.h
> @@ -228,7 +228,8 @@
>   /*
>    * PMXEVTYPER: Event selection reg
>    */
> -#define ARMV8_PMU_EVTYPE_MASK	0xc800ffff	/* Mask for writable bits */
> +#define ARMV8_PMU_EVTYPE_TH	GENMASK(43, 32)
> +#define ARMV8_PMU_EVTYPE_TC	GENMASK(63, 61)
>   #define ARMV8_PMU_EVTYPE_EVENT	0xffff		/* Mask for EVENT bits */
>   
>   /*

