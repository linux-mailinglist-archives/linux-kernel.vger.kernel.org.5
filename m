Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E47E7D0D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376775AbjJTKYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376776AbjJTKYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:24:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA019B3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:24:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0A1D2F4;
        Fri, 20 Oct 2023 03:25:11 -0700 (PDT)
Received: from [10.1.25.10] (e127643.arm.com [10.1.25.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C1193F5A1;
        Fri, 20 Oct 2023 03:24:29 -0700 (PDT)
Message-ID: <85b3750b-fd3b-f2af-307f-03b9b2d36966@arm.com>
Date:   Fri, 20 Oct 2023 11:24:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2] drivers: perf: arm_pmuv3: Add new macro
 PMUV3_INIT_MAP_EVENT()
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20231020051543.2818951-1-anshuman.khandual@arm.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20231020051543.2818951-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/10/2023 06:15, Anshuman Khandual wrote:
> This further compacts all remaining PMU init procedures requiring specific
> map_event functions via a new macro PMUV3_INIT_MAP_EVENT(). While here, it
> also changes generated init function names to match to those generated via
> the other macro PMUV3_INIT_SIMPLE(). This does not cause functional change.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.6-rc6 with dependent patch applied, and also on
> will/for-next/perf without it.

Just in case anyone is wondering, I think the dependent patch is:
https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=for-next/perf&id=3b9a22d345ff89232227b2449a311bf3f910f5f2

Otherwise, looks ok:

Reviewed-by: James Clark <james.clark@arm.com>

> 
> Changes in V2:
> 
> - Updated the commit message
> - Rebased the patch after the following change
>   https://lore.kernel.org/all/20231016025436.1368945-1-anshuman.khandual@arm.com/
> 
> Changes in V1:
> 
> https://lore.kernel.org/all/20231009064714.186770-1-anshuman.khandual@arm.com/
> 
>  drivers/perf/arm_pmuv3.c | 61 +++++++++++++---------------------------
>  1 file changed, 20 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 4f6923ad4589..92fefc1bc7f6 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -1222,6 +1222,12 @@ static int name##_pmu_init(struct arm_pmu *cpu_pmu)			\
>  	return armv8_pmu_init(cpu_pmu, #name, armv8_pmuv3_map_event);	\
>  }
>  
> +#define PMUV3_INIT_MAP_EVENT(name, map_event)				\
> +static int name##_pmu_init(struct arm_pmu *cpu_pmu)			\
> +{									\
> +	return armv8_pmu_init(cpu_pmu, #name, map_event);		\
> +}
> +
>  PMUV3_INIT_SIMPLE(armv8_pmuv3)
>  
>  PMUV3_INIT_SIMPLE(armv8_cortex_a34)
> @@ -1248,51 +1254,24 @@ PMUV3_INIT_SIMPLE(armv8_neoverse_v1)
>  PMUV3_INIT_SIMPLE(armv8_nvidia_carmel)
>  PMUV3_INIT_SIMPLE(armv8_nvidia_denver)
>  
> -static int armv8_a35_pmu_init(struct arm_pmu *cpu_pmu)
> -{
> -	return armv8_pmu_init(cpu_pmu, "armv8_cortex_a35", armv8_a53_map_event);
> -}
> -
> -static int armv8_a53_pmu_init(struct arm_pmu *cpu_pmu)
> -{
> -	return armv8_pmu_init(cpu_pmu, "armv8_cortex_a53", armv8_a53_map_event);
> -}
> -
> -static int armv8_a57_pmu_init(struct arm_pmu *cpu_pmu)
> -{
> -	return armv8_pmu_init(cpu_pmu, "armv8_cortex_a57", armv8_a57_map_event);
> -}
> -
> -static int armv8_a72_pmu_init(struct arm_pmu *cpu_pmu)
> -{
> -	return armv8_pmu_init(cpu_pmu, "armv8_cortex_a72", armv8_a57_map_event);
> -}
> -
> -static int armv8_a73_pmu_init(struct arm_pmu *cpu_pmu)
> -{
> -	return armv8_pmu_init(cpu_pmu, "armv8_cortex_a73", armv8_a73_map_event);
> -}
> -
> -static int armv8_thunder_pmu_init(struct arm_pmu *cpu_pmu)
> -{
> -	return armv8_pmu_init(cpu_pmu, "armv8_cavium_thunder", armv8_thunder_map_event);
> -}
> -
> -static int armv8_vulcan_pmu_init(struct arm_pmu *cpu_pmu)
> -{
> -	return armv8_pmu_init(cpu_pmu, "armv8_brcm_vulcan", armv8_vulcan_map_event);
> -}
> +PMUV3_INIT_MAP_EVENT(armv8_cortex_a35, armv8_a53_map_event)
> +PMUV3_INIT_MAP_EVENT(armv8_cortex_a53, armv8_a53_map_event)
> +PMUV3_INIT_MAP_EVENT(armv8_cortex_a57, armv8_a57_map_event)
> +PMUV3_INIT_MAP_EVENT(armv8_cortex_a72, armv8_a57_map_event)
> +PMUV3_INIT_MAP_EVENT(armv8_cortex_a73, armv8_a73_map_event)
> +PMUV3_INIT_MAP_EVENT(armv8_cavium_thunder, armv8_thunder_map_event)
> +PMUV3_INIT_MAP_EVENT(armv8_brcm_vulcan, armv8_vulcan_map_event)
>  
>  static const struct of_device_id armv8_pmu_of_device_ids[] = {
>  	{.compatible = "arm,armv8-pmuv3",	.data = armv8_pmuv3_pmu_init},
>  	{.compatible = "arm,cortex-a34-pmu",	.data = armv8_cortex_a34_pmu_init},
> -	{.compatible = "arm,cortex-a35-pmu",	.data = armv8_a35_pmu_init},
> -	{.compatible = "arm,cortex-a53-pmu",	.data = armv8_a53_pmu_init},
> +	{.compatible = "arm,cortex-a35-pmu",	.data = armv8_cortex_a35_pmu_init},
> +	{.compatible = "arm,cortex-a53-pmu",	.data = armv8_cortex_a53_pmu_init},
>  	{.compatible = "arm,cortex-a55-pmu",	.data = armv8_cortex_a55_pmu_init},
> -	{.compatible = "arm,cortex-a57-pmu",	.data = armv8_a57_pmu_init},
> +	{.compatible = "arm,cortex-a57-pmu",	.data = armv8_cortex_a57_pmu_init},
>  	{.compatible = "arm,cortex-a65-pmu",	.data = armv8_cortex_a65_pmu_init},
> -	{.compatible = "arm,cortex-a72-pmu",	.data = armv8_a72_pmu_init},
> -	{.compatible = "arm,cortex-a73-pmu",	.data = armv8_a73_pmu_init},
> +	{.compatible = "arm,cortex-a72-pmu",	.data = armv8_cortex_a72_pmu_init},
> +	{.compatible = "arm,cortex-a73-pmu",	.data = armv8_cortex_a73_pmu_init},
>  	{.compatible = "arm,cortex-a75-pmu",	.data = armv8_cortex_a75_pmu_init},
>  	{.compatible = "arm,cortex-a76-pmu",	.data = armv8_cortex_a76_pmu_init},
>  	{.compatible = "arm,cortex-a77-pmu",	.data = armv8_cortex_a77_pmu_init},
> @@ -1310,8 +1289,8 @@ static const struct of_device_id armv8_pmu_of_device_ids[] = {
>  	{.compatible = "arm,neoverse-n1-pmu",	.data = armv8_neoverse_n1_pmu_init},
>  	{.compatible = "arm,neoverse-n2-pmu",	.data = armv9_neoverse_n2_pmu_init},
>  	{.compatible = "arm,neoverse-v1-pmu",	.data = armv8_neoverse_v1_pmu_init},
> -	{.compatible = "cavium,thunder-pmu",	.data = armv8_thunder_pmu_init},
> -	{.compatible = "brcm,vulcan-pmu",	.data = armv8_vulcan_pmu_init},
> +	{.compatible = "cavium,thunder-pmu",	.data = armv8_cavium_thunder_pmu_init},
> +	{.compatible = "brcm,vulcan-pmu",	.data = armv8_brcm_vulcan_pmu_init},
>  	{.compatible = "nvidia,carmel-pmu",	.data = armv8_nvidia_carmel_pmu_init},
>  	{.compatible = "nvidia,denver-pmu",	.data = armv8_nvidia_denver_pmu_init},
>  	{},
