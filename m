Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A747F4075
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjKVIpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjKVIpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:45:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B922A1;
        Wed, 22 Nov 2023 00:44:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0DDC1595;
        Wed, 22 Nov 2023 00:45:44 -0800 (PST)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12E723F73F;
        Wed, 22 Nov 2023 00:44:54 -0800 (PST)
Message-ID: <347fc210-8c31-47be-a87a-656fa30a72ef@arm.com>
Date:   Wed, 22 Nov 2023 14:14:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] arm64: perf: Include threshold control fields in
 PMEVTYPER mask
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, suzuki.poulose@arm.com,
        will@kernel.org, mark.rutland@arm.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231113112507.917107-1-james.clark@arm.com>
 <20231113112507.917107-2-james.clark@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20231113112507.917107-2-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/23 16:55, James Clark wrote:
> FEAT_PMUv3_TH (Armv8.8) adds two new fields to PMEVTYPER, so include
> them in the mask. These aren't writable on 32 bit kernels as they are in
> the high part of the register, so only include them for arm64.
> 
> It would be difficult to do this statically in the asm header files for
> each platform without resulting in circular includes or #ifdefs inline
> in the code. For that reason the ARMV8_PMU_EVTYPE_MASK definition has
> been removed and the mask is constructed programmatically.

Agreed, and this also makes sense because there is just a single instance
for ARMV8_PMU_EVTYPE_MASK in armv8pmu_write_evtype().

> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/perf/arm_pmuv3.c       | 9 ++++++++-
>  include/linux/perf/arm_pmuv3.h | 3 ++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 6ca7be05229c..1d40d794f5e4 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -555,8 +555,15 @@ static void armv8pmu_write_counter(struct perf_event *event, u64 value)
>  static inline void armv8pmu_write_evtype(int idx, u32 val)
>  {
>  	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
> +	unsigned long mask = ARMV8_PMU_EVTYPE_EVENT |
> +			     ARMV8_PMU_INCLUDE_EL2 |
> +			     ARMV8_PMU_EXCLUDE_EL0 |
> +			     ARMV8_PMU_EXCLUDE_EL1;

At first this looks bit odd sequence - EL2, EL0, EL1 but such as these
bit positions.

#define ARMV8_PMU_EXCLUDE_EL1           (1U << 31)
#define ARMV8_PMU_EXCLUDE_EL0           (1U << 30)
#define ARMV8_PMU_INCLUDE_EL2           (1U << 27)

>  
> -	val &= ARMV8_PMU_EVTYPE_MASK;
> +	if (IS_ENABLED(CONFIG_ARM64))
> +		mask |= ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_TH;

This makes sense.

> +
> +	val &= mask;
>  	write_pmevtypern(counter, val);
>  }
>  
> diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
> index 9c226adf938a..ddd1fec86739 100644
> --- a/include/linux/perf/arm_pmuv3.h
> +++ b/include/linux/perf/arm_pmuv3.h
> @@ -228,7 +228,8 @@
>  /*
>   * PMXEVTYPER: Event selection reg
>   */
> -#define ARMV8_PMU_EVTYPE_MASK	0xc800ffff	/* Mask for writable bits */
> +#define ARMV8_PMU_EVTYPE_TH	GENMASK(43, 32)
> +#define ARMV8_PMU_EVTYPE_TC	GENMASK(63, 61)

Looks correct.

>  #define ARMV8_PMU_EVTYPE_EVENT	0xffff		/* Mask for EVENT bits */
>  
>  /*

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
