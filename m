Return-Path: <linux-kernel+bounces-146146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFC28A6150
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352D9282DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D282D1803D;
	Tue, 16 Apr 2024 03:13:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F5614A82
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237235; cv=none; b=NRSar8Fm0BdvzLYscizvNOm/x0hAdXtb0sp86XdjGsK/JgDsrol1PPVRwy7+nNsZlala0KUgEia1oQk2y7kYSx/ViUknneZbNp5sEVy01yflFhShDyHiR0qQGmhRbqMv6/sNGlgww+0YZQHLNGzRdT7/S9FP8eo+ZyYrAVmsz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237235; c=relaxed/simple;
	bh=U6p2ts7qX92k33AKHQGKDDr+K7bfe4jrt0INl11Qnwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzcdW53Ua2329baGOy7+kbU3gSGH9TNTSLEZ9+GTogUbal8/5ZdpyMzcmAQA97owYbTwCSepmSNQTdtbpQPsko0B6o3hyEXvYkVjVyD3y2MlpBmubmTCixcZvFx6YtpQxkdr4kdE/J3fA+KPNqw8XAhYt/iIk9IsaR1oAOpNkKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C442F2F4;
	Mon, 15 Apr 2024 20:14:19 -0700 (PDT)
Received: from [10.163.59.235] (unknown [10.163.59.235])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E49363F64C;
	Mon, 15 Apr 2024 20:13:46 -0700 (PDT)
Message-ID: <b63e6914-03c6-4c76-a81a-4af2fbe557e0@arm.com>
Date: Tue, 16 Apr 2024 08:43:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 8/8] arm64/hw_breakpoint: Enable FEAT_Debugv8p9
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240405080008.1225223-1-anshuman.khandual@arm.com>
 <20240405080008.1225223-9-anshuman.khandual@arm.com>
 <868r1st8an.wl-maz@kernel.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <868r1st8an.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/5/24 15:56, Marc Zyngier wrote:
> On Fri, 05 Apr 2024 09:00:08 +0100,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>> Currently there can be maximum 16 breakpoints, and 16 watchpoints available
>> on a given platform - as detected from ID_AA64DFR0_EL1.[BRPs|WRPs] register
>> fields. But these breakpoint, and watchpoints can be extended further up to
>> 64 via a new arch feature FEAT_Debugv8p9.
>>
>> This first enables banked access for the breakpoint and watchpoint register
>> set via MDSELR_EL1, extended exceptions via MDSCR_EL1.EMBWE and determining
>> available breakpoints and watchpoints in the platform from ID_AA64DFR1_EL1,
>> when FEAT_Debugv8p9 is enabled.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/debug-monitors.h |  2 +-
>>  arch/arm64/include/asm/hw_breakpoint.h  | 46 +++++++++++++++++++------
>>  arch/arm64/kernel/debug-monitors.c      | 16 ++++++---
>>  arch/arm64/kernel/hw_breakpoint.c       | 33 ++++++++++++++++++
>>  4 files changed, 82 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
>> index 13d437bcbf58..75eedba2abbe 100644
>> --- a/arch/arm64/include/asm/debug-monitors.h
>> +++ b/arch/arm64/include/asm/debug-monitors.h
>> @@ -19,7 +19,7 @@
>>  /* MDSCR_EL1 enabling bits */
>>  #define DBG_MDSCR_KDE		(1 << 13)
>>  #define DBG_MDSCR_MDE		(1 << 15)
>> -#define DBG_MDSCR_MASK		~(DBG_MDSCR_KDE | DBG_MDSCR_MDE)
>> +#define DBG_MDSCR_EMBWE		(1UL << 32)
>>  
>>  #define	DBG_ESR_EVT(x)		(((x) >> 27) & 0x7)
>>  
>> diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
>> index bd81cf17744a..6b9822140f71 100644
>> --- a/arch/arm64/include/asm/hw_breakpoint.h
>> +++ b/arch/arm64/include/asm/hw_breakpoint.h
>> @@ -79,8 +79,8 @@ static inline void decode_ctrl_reg(u32 reg,
>>   * Limits.
>>   * Changing these will require modifications to the register accessors.
>>   */
>> -#define ARM_MAX_BRP		16
>> -#define ARM_MAX_WRP		16
>> +#define ARM_MAX_BRP		64
>> +#define ARM_MAX_WRP		64
>>  
>>  /* Virtual debug register bases. */
>>  #define AARCH64_DBG_REG_BVR	0
>> @@ -135,22 +135,48 @@ static inline void ptrace_hw_copy_thread(struct task_struct *task)
>>  }
>>  #endif
>>  
>> +static inline bool is_debug_v8p9_enabled(void)
>> +{
>> +	u64 dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
>> +	int dver = cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_DebugVer_SHIFT);
>> +
>> +	return dver == ID_AA64DFR0_EL1_DebugVer_V8P9;
>> +}
>> +
>>  /* Determine number of BRP registers available. */
>>  static inline int get_num_brps(void)
>>  {
>> -	u64 dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
>> -	return 1 +
>> -		cpuid_feature_extract_unsigned_field(dfr0,
>> -						ID_AA64DFR0_EL1_BRPs_SHIFT);
>> +	u64 dfr0, dfr1;
>> +	int dver, brps;
>> +
>> +	dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
>> +	dver = cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_DebugVer_SHIFT);
>> +	if (dver == ID_AA64DFR0_EL1_DebugVer_V8P9) {
>> +		dfr1 = read_sanitised_ftr_reg(SYS_ID_AA64DFR1_EL1);
>> +		brps = cpuid_feature_extract_unsigned_field_width(dfr1,
>> +								  ID_AA64DFR1_EL1_BRPs_SHIFT, 8);
>> +	} else {
>> +		brps = cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_BRPs_SHIFT);
>> +	}
>> +	return 1 + brps;
>>  }
>>  
>>  /* Determine number of WRP registers available. */
>>  static inline int get_num_wrps(void)
>>  {
>> -	u64 dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
>> -	return 1 +
>> -		cpuid_feature_extract_unsigned_field(dfr0,
>> -						ID_AA64DFR0_EL1_WRPs_SHIFT);
>> +	u64 dfr0, dfr1;
>> +	int dver, wrps;
>> +
>> +	dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
>> +	dver = cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_DebugVer_SHIFT);
>> +	if (dver == ID_AA64DFR0_EL1_DebugVer_V8P9) {
>> +		dfr1 = read_sanitised_ftr_reg(SYS_ID_AA64DFR1_EL1);
>> +		wrps = cpuid_feature_extract_unsigned_field_width(dfr1,
>> +								  ID_AA64DFR1_EL1_WRPs_SHIFT, 8);
>> +	} else {
>> +		wrps = cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_WRPs_SHIFT);
>> +	}
>> +	return 1 + wrps;
>>  }
>>  
>>  #ifdef CONFIG_CPU_PM
>> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
>> index 64f2ecbdfe5c..3299d1e8dc61 100644
>> --- a/arch/arm64/kernel/debug-monitors.c
>> +++ b/arch/arm64/kernel/debug-monitors.c
>> @@ -23,6 +23,7 @@
>>  #include <asm/debug-monitors.h>
>>  #include <asm/system_misc.h>
>>  #include <asm/traps.h>
>> +#include <asm/hw_breakpoint.h>
> 
> include order.

Sure, will fix the order here.

> 
>>  
>>  /* Determine debug architecture. */
>>  u8 debug_monitors_arch(void)
>> @@ -34,7 +35,7 @@ u8 debug_monitors_arch(void)
>>  /*
>>   * MDSCR access routines.
>>   */
>> -static void mdscr_write(u32 mdscr)
>> +static void mdscr_write(u64 mdscr)
>>  {
>>  	unsigned long flags;
>>  	flags = local_daif_save();
>> @@ -43,7 +44,7 @@ static void mdscr_write(u32 mdscr)
>>  }
>>  NOKPROBE_SYMBOL(mdscr_write);
>>  
>> -static u32 mdscr_read(void)
>> +static u64 mdscr_read(void)
>>  {
>>  	return read_sysreg(mdscr_el1);
>>  }
>> @@ -76,10 +77,11 @@ early_param("nodebugmon", early_debug_disable);
>>   */
>>  static DEFINE_PER_CPU(int, mde_ref_count);
>>  static DEFINE_PER_CPU(int, kde_ref_count);
>> +static DEFINE_PER_CPU(int, embwe_ref_count);
>>  
>>  void enable_debug_monitors(enum dbg_active_el el)
>>  {
>> -	u32 mdscr, enable = 0;
>> +	u64 mdscr, enable = 0;
>>  
>>  	WARN_ON(preemptible());
>>  
>> @@ -90,6 +92,9 @@ void enable_debug_monitors(enum dbg_active_el el)
>>  	    this_cpu_inc_return(kde_ref_count) == 1)
>>  		enable |= DBG_MDSCR_KDE;
>>  
>> +	if (is_debug_v8p9_enabled() && this_cpu_inc_return(embwe_ref_count) == 1)
>> +		enable |= DBG_MDSCR_EMBWE;
>> +
>>  	if (enable && debug_enabled) {
>>  		mdscr = mdscr_read();
>>  		mdscr |= enable;
>> @@ -100,7 +105,7 @@ NOKPROBE_SYMBOL(enable_debug_monitors);
>>  
>>  void disable_debug_monitors(enum dbg_active_el el)
>>  {
>> -	u32 mdscr, disable = 0;
>> +	u64 mdscr, disable = 0;
>>  
>>  	WARN_ON(preemptible());
>>  
>> @@ -111,6 +116,9 @@ void disable_debug_monitors(enum dbg_active_el el)
>>  	    this_cpu_dec_return(kde_ref_count) == 0)
>>  		disable &= ~DBG_MDSCR_KDE;
>>  
>> +	if (is_debug_v8p9_enabled() && this_cpu_dec_return(embwe_ref_count) == 0)
>> +		disable &= ~DBG_MDSCR_EMBWE;
>> +
>>  	if (disable) {
>>  		mdscr = mdscr_read();
>>  		mdscr &= disable;
>> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
>> index 2f5755192c2b..7b9169535b76 100644
>> --- a/arch/arm64/kernel/hw_breakpoint.c
>> +++ b/arch/arm64/kernel/hw_breakpoint.c
>> @@ -103,10 +103,40 @@ int hw_breakpoint_slots(int type)
>>  	WRITE_WB_REG_CASE(OFF, 14, REG, VAL);	\
>>  	WRITE_WB_REG_CASE(OFF, 15, REG, VAL)
>>  
>> +static int set_bank_index(int n)
>> +{
>> +	int mdsel_bank;
>> +	int bank = n / 16, index = n % 16;
>> +
>> +	switch (bank) {
>> +	case 0:
>> +		mdsel_bank = MDSELR_EL1_BANK_BANK_0;
>> +		break;
>> +	case 1:
>> +		mdsel_bank = MDSELR_EL1_BANK_BANK_1;
>> +		break;
>> +	case 2:
>> +		mdsel_bank = MDSELR_EL1_BANK_BANK_2;
>> +		break;
>> +	case 3:
>> +		mdsel_bank = MDSELR_EL1_BANK_BANK_3;
>> +		break;
>> +	default:
>> +		pr_warn("Unknown register bank %d\n", bank);
>> +		return -EINVAL;
>> +	}
>> +	write_sysreg_s(mdsel_bank << MDSELR_EL1_BANK_SHIFT, SYS_MDSELR_EL1);
>> +	isb();
>> +	return index;
>> +}
>> +
>>  static u64 read_wb_reg(int reg, int n)
>>  {
>>  	u64 val = 0;
>>  
>> +	if (is_debug_v8p9_enabled())
>> +		n = set_bank_index(n);
>> +
>>  	switch (reg + n) {
>>  	GEN_READ_WB_REG_CASES(AARCH64_DBG_REG_BVR, AARCH64_DBG_REG_NAME_BVR, val);
>>  	GEN_READ_WB_REG_CASES(AARCH64_DBG_REG_BCR, AARCH64_DBG_REG_NAME_BCR, val);
>> @@ -122,6 +152,9 @@ NOKPROBE_SYMBOL(read_wb_reg);
>>  
>>  static void write_wb_reg(int reg, int n, u64 val)
>>  {
>> +	if (is_debug_v8p9_enabled())
>> +		n = set_bank_index(n);
>> +
>>  	switch (reg + n) {
>>  	GEN_WRITE_WB_REG_CASES(AARCH64_DBG_REG_BVR, AARCH64_DBG_REG_NAME_BVR, val);
>>  	GEN_WRITE_WB_REG_CASES(AARCH64_DBG_REG_BCR, AARCH64_DBG_REG_NAME_BCR, val);
> 
> Are these things guaranteed to be only used in contexts where there
> can be no interleaving of such operations? If any interleaving can
> occur, this is broken.

That is a valid concern, breakpoints and watchpoints get used in multiple
code paths such perf, ptrace etc, where preemption might cause wrong bank
to be selected before the breakpoint-watchpoint registers being read thus
impacting the state. I guess preemption should be disabled between those
two operations i.e selection of the bank and reading its registers

> 
> 	M.
> 

