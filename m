Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9243E7DFF0B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 07:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjKCGJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCGJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:09:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A02CCA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:09:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75FCB2F4;
        Thu,  2 Nov 2023 23:10:25 -0700 (PDT)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 666153F67D;
        Thu,  2 Nov 2023 23:09:39 -0700 (PDT)
Message-ID: <6281f889-d665-451b-a864-e2751fce8017@arm.com>
Date:   Fri, 3 Nov 2023 11:39:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64/arm: arm_pmuv3: perf: Don't truncate 64-bit
 registers
Content-Language: en-US
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Zaid Al-Bassam <zalbassam@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231102183012.1251410-1-ilkka@os.amperecomputing.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20231102183012.1251410-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/23 00:00, Ilkka Koskinen wrote:
> The driver used to truncate several 64-bit registers such as PMCEID[n]
> registers used to describe whether architectural and microarchitectural
> events in range 0x4000-0x401f exist. Due to discarding the bits, the
> driver made the events invisible, even if they existed.
> 
> Moreover, PMCCFILTR and PMCR registers have additional bits in the upper
> 32 bits. This patch makes them available although they aren't currently
> used. Finally, functions handling PMXEVCNTR and PMXEVTYPER registers are
> removed as they not being used at all.
> 
> Fixes: df29ddf4f04b ("arm64: perf: Abstract system register accesses away")
> Reported-by: Carl Worth <carl@os.amperecomputing.com>

This needs an URL for the original bug report in the following format.

    Reported-by: Carl Worth <carl@os.amperecomputing.com>
    Closes: https://lore.kernel.org/..

Otherwise, the following checkpatch warning shows up.

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#17: 
Reported-by: Carl Worth <carl@os.amperecomputing.com>
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
> 
> v2:
> 
>   * Took arm32 specific code from Marc Zyngier's review comment
>     * Fixed a couple of typos in the commit message
> 
>     I have tested the patch on Arm64. However, what comes to Arm32 part, I have
>     only compared the code with Arm32 specification and cross compiled it.
> 
>   * https://lore.kernel.org/all/20231027012243.111070-1-ilkka@os.amperecomputing.com/
> 
> v3:
> 
>   * Removed read/write_pmxevcntr() and read/write_pmxevtyper() as suggested
>     by Mark Rutland
>   * Changed handling of PMCCFILTR and PMCR to 64-bit on Aarch64. Aarch32 doesn't
>     seem to use the upper 32 bits.
>     
> 
> Tested the patch on Arm64. Arm32 version was only built and not tested on actual
> hardware.
> 
> ---
> 
> arch/arm/include/asm/arm_pmuv3.h   | 48 ++++++++++++++----------------
>  arch/arm64/include/asm/arm_pmuv3.h | 25 ++++------------
>  drivers/perf/arm_pmuv3.c           |  6 ++--
>  3 files changed, 31 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
> index 72529f5e2bed..a41b503b7dcd 100644
> --- a/arch/arm/include/asm/arm_pmuv3.h
> +++ b/arch/arm/include/asm/arm_pmuv3.h
> @@ -23,6 +23,8 @@
>  #define PMUSERENR		__ACCESS_CP15(c9,  0, c14, 0)
>  #define PMINTENSET		__ACCESS_CP15(c9,  0, c14, 1)
>  #define PMINTENCLR		__ACCESS_CP15(c9,  0, c14, 2)
> +#define PMCEID2			__ACCESS_CP15(c9,  0, c14, 4)
> +#define PMCEID3			__ACCESS_CP15(c9,  0, c14, 5)
>  #define PMMIR			__ACCESS_CP15(c9,  0, c14, 6)
>  #define PMCCFILTR		__ACCESS_CP15(c14, 0, c15, 7)
>  
> @@ -150,21 +152,6 @@ static inline u64 read_pmccntr(void)
>  	return read_sysreg(PMCCNTR);
>  }
>  
> -static inline void write_pmxevcntr(u32 val)
> -{
> -	write_sysreg(val, PMXEVCNTR);
> -}
> -
> -static inline u32 read_pmxevcntr(void)
> -{
> -	return read_sysreg(PMXEVCNTR);
> -}
> -
> -static inline void write_pmxevtyper(u32 val)
> -{
> -	write_sysreg(val, PMXEVTYPER);
> -}
> -
>  static inline void write_pmcntenset(u32 val)
>  {
>  	write_sysreg(val, PMCNTENSET);
> @@ -205,16 +192,6 @@ static inline void write_pmuserenr(u32 val)
>  	write_sysreg(val, PMUSERENR);
>  }
>  
> -static inline u32 read_pmceid0(void)
> -{
> -	return read_sysreg(PMCEID0);
> -}
> -
> -static inline u32 read_pmceid1(void)
> -{
> -	return read_sysreg(PMCEID1);
> -}
> -
>  static inline void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr) {}
>  static inline void kvm_clr_pmu_events(u32 clr) {}
>  static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
> @@ -231,6 +208,7 @@ static inline void kvm_vcpu_pmu_resync_el0(void) {}
>  
>  /* PMU Version in DFR Register */
>  #define ARMV8_PMU_DFR_VER_NI        0
> +#define ARMV8_PMU_DFR_VER_V3P1      0x4
>  #define ARMV8_PMU_DFR_VER_V3P4      0x5
>  #define ARMV8_PMU_DFR_VER_V3P5      0x6
>  #define ARMV8_PMU_DFR_VER_IMP_DEF   0xF
> @@ -251,4 +229,24 @@ static inline bool is_pmuv3p5(int pmuver)
>  	return pmuver >= ARMV8_PMU_DFR_VER_V3P5;
>  }
>  
> +static inline u64 read_pmceid0(void)
> +{
> +	u64 val = read_sysreg(PMCEID0);
> +
> +	if (read_pmuver() >= ARMV8_PMU_DFR_VER_V3P1)
> +		val |= (u64)read_sysreg(PMCEID2) << 32;
> +
> +	return val;
> +}
> +
> +static inline u64 read_pmceid1(void)
> +{
> +	u64 val = read_sysreg(PMCEID1);
> +
> +	if (read_pmuver() >= ARMV8_PMU_DFR_VER_V3P1)
> +		val |= (u64)read_sysreg(PMCEID3) << 32;
> +
> +	return val;
> +}
> +
>  #endif
> diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
> index 18dc2fb3d7b7..c27404fa4418 100644
> --- a/arch/arm64/include/asm/arm_pmuv3.h
> +++ b/arch/arm64/include/asm/arm_pmuv3.h
> @@ -46,12 +46,12 @@ static inline u32 read_pmuver(void)
>  			ID_AA64DFR0_EL1_PMUVer_SHIFT);
>  }
>  
> -static inline void write_pmcr(u32 val)
> +static inline void write_pmcr(u64 val)
>  {
>  	write_sysreg(val, pmcr_el0);
>  }
>  
> -static inline u32 read_pmcr(void)
> +static inline u64 read_pmcr(void)
>  {
>  	return read_sysreg(pmcr_el0);
>  }
> @@ -71,21 +71,6 @@ static inline u64 read_pmccntr(void)
>  	return read_sysreg(pmccntr_el0);
>  }
>  
> -static inline void write_pmxevcntr(u32 val)
> -{
> -	write_sysreg(val, pmxevcntr_el0);
> -}
> -
> -static inline u32 read_pmxevcntr(void)
> -{
> -	return read_sysreg(pmxevcntr_el0);
> -}
> -
> -static inline void write_pmxevtyper(u32 val)
> -{
> -	write_sysreg(val, pmxevtyper_el0);
> -}
> -
>  static inline void write_pmcntenset(u32 val)
>  {
>  	write_sysreg(val, pmcntenset_el0);
> @@ -106,7 +91,7 @@ static inline void write_pmintenclr(u32 val)
>  	write_sysreg(val, pmintenclr_el1);
>  }
>  
> -static inline void write_pmccfiltr(u32 val)
> +static inline void write_pmccfiltr(u64 val)
>  {
>  	write_sysreg(val, pmccfiltr_el0);
>  }
> @@ -126,12 +111,12 @@ static inline void write_pmuserenr(u32 val)
>  	write_sysreg(val, pmuserenr_el0);
>  }
>  
> -static inline u32 read_pmceid0(void)
> +static inline u64 read_pmceid0(void)
>  {
>  	return read_sysreg(pmceid0_el0);
>  }
>  
> -static inline u32 read_pmceid1(void)
> +static inline u64 read_pmceid1(void)
>  {
>  	return read_sysreg(pmceid1_el0);
>  }
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 18b91b56af1d..6ca7be05229c 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -428,12 +428,12 @@ static inline bool armv8pmu_event_is_chained(struct perf_event *event)
>  #define	ARMV8_IDX_TO_COUNTER(x)	\
>  	(((x) - ARMV8_IDX_COUNTER0) & ARMV8_PMU_COUNTER_MASK)
>  
> -static inline u32 armv8pmu_pmcr_read(void)
> +static inline u64 armv8pmu_pmcr_read(void)
>  {
>  	return read_pmcr();
>  }
>  
> -static inline void armv8pmu_pmcr_write(u32 val)
> +static inline void armv8pmu_pmcr_write(u64 val)
>  {
>  	val &= ARMV8_PMU_PMCR_MASK;
>  	isb();
> @@ -957,7 +957,7 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>  static void armv8pmu_reset(void *info)
>  {
>  	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
> -	u32 pmcr;
> +	u64 pmcr;
>  
>  	/* The counter and interrupt enable registers are unknown at reset. */
>  	armv8pmu_disable_counter(U32_MAX);

Otherwise, this LGTM.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
