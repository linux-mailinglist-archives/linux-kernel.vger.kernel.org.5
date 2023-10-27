Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACA77D957A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjJ0Kq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345488AbjJ0Kq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:46:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAC5F18A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:46:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2480DA7;
        Fri, 27 Oct 2023 03:47:35 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.67.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3DD73F738;
        Fri, 27 Oct 2023 03:46:52 -0700 (PDT)
Date:   Fri, 27 Oct 2023 11:46:41 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Zaid Al-Bassam <zalbassam@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/arm: perf: Don't discard upper 32 bits from
 PMCEID0/1 registers
Message-ID: <ZTuVEXnvqfIPMtmF@FVFF77S0Q05N>
References: <20231027012243.111070-1-ilkka@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027012243.111070-1-ilkka@os.amperecomputing.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 06:22:43PM -0700, Ilkka Koskinen wrote:
> The upper 32 bits of PMCEID[n] registers are used to describe whether
> architectural and microarchitectural events in range 0x4000-0x401f
> exist. Due to discarding the bits, the driver made the events invisible,
> even if they existed.
> 
> Fixes: df29ddf4f04b ("arm64: perf: Abstract system register accesses away")

Hmm... are we silently truncating anything else?

I see that read_pmxevcntr() and write_pmxevcntr() treat PMXEVCNTR_EL0 as 32-bit
despite it being 64-bit with PMUv3.5, but it doesn't matter as those functions
are never used, and should just be deleted.

Similarly PMCR_EL0 is 64-bit, with bit 32 bit FZS when FEAT_SPEv1p2 is
implemented. That doesn't matter to us right now as we don't use FZS, but it's
something that could catch us out in future if new bitss get added.

Could we please go check all the accessors added in df29ddf4f04b, and fix those
in one go?

Mark.

> Reported-by: Carl Worth <carl@os.amperecomputing.com>
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
> 
> Changes since v1:
> 
>   * Took arm32 specific code from Marc Zyngier's review comment
>   * Fixed a couple of typos in the commit message
> 
> I have tested the patch on Arm64. However, what comes to Arm32 part, I have
> only compared the code with Arm32 specification and cross compiled it.
> 
> v1: https://lore.kernel.org/all/20231025200815.104017-1-ilkka@os.amperecomputing.com/
> 
> ---
> 
>  arch/arm/include/asm/arm_pmuv3.h   | 33 +++++++++++++++++++++---------
>  arch/arm64/include/asm/arm_pmuv3.h |  4 ++--
>  2 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
> index 72529f5e2bed..90841cb7ce43 100644
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
> @@ -205,16 +207,6 @@ static inline void write_pmuserenr(u32 val)
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
> @@ -231,6 +223,7 @@ static inline void kvm_vcpu_pmu_resync_el0(void) {}
>  
>  /* PMU Version in DFR Register */
>  #define ARMV8_PMU_DFR_VER_NI        0
> +#define ARMV8_PMU_DFR_VER_V3P1      0x4
>  #define ARMV8_PMU_DFR_VER_V3P4      0x5
>  #define ARMV8_PMU_DFR_VER_V3P5      0x6
>  #define ARMV8_PMU_DFR_VER_IMP_DEF   0xF
> @@ -251,4 +244,24 @@ static inline bool is_pmuv3p5(int pmuver)
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
> index 18dc2fb3d7b7..3e92b7cb57a4 100644
> --- a/arch/arm64/include/asm/arm_pmuv3.h
> +++ b/arch/arm64/include/asm/arm_pmuv3.h
> @@ -126,12 +126,12 @@ static inline void write_pmuserenr(u32 val)
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
> -- 
> 2.41.0
> 
