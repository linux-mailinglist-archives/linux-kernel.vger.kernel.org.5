Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3407F2AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjKUKrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKUKrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:47:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E42495;
        Tue, 21 Nov 2023 02:47:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8D37FEC;
        Tue, 21 Nov 2023 02:48:02 -0800 (PST)
Received: from [10.163.36.237] (unknown [10.163.36.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EB713F6C4;
        Tue, 21 Nov 2023 02:47:11 -0800 (PST)
Message-ID: <616bed59-d3c5-4d33-aae7-ea93f63743d3@arm.com>
Date:   Tue, 21 Nov 2023 16:17:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V14 4/8] drivers: perf: arm_pmuv3: Enable branch stack sampling
 via FEAT_BRBE
Content-Language: en-US
To:     James Clark <james.clark@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
References: <20231114051329.327572-1-anshuman.khandual@arm.com>
 <20231114051329.327572-5-anshuman.khandual@arm.com>
 <00f05970-c793-242e-485a-f987201651ad@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <00f05970-c793-242e-485a-f987201651ad@arm.com>
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



On 11/14/23 17:41, James Clark wrote:
> 
> 
> On 14/11/2023 05:13, Anshuman Khandual wrote:
> [...]
> 
>> +/*
>> + * BRBE supports the following functional branch type filters while
>> + * generating branch records. These branch filters can be enabled,
>> + * either individually or as a group i.e ORing multiple filters
>> + * with each other.
>> + *
>> + * BRBFCR_EL1_CONDDIR  - Conditional direct branch
>> + * BRBFCR_EL1_DIRCALL  - Direct call
>> + * BRBFCR_EL1_INDCALL  - Indirect call
>> + * BRBFCR_EL1_INDIRECT - Indirect branch
>> + * BRBFCR_EL1_DIRECT   - Direct branch
>> + * BRBFCR_EL1_RTN      - Subroutine return
>> + */
>> +static u64 branch_type_to_brbfcr(int branch_type)
>> +{
>> +	u64 brbfcr = 0;
>> +
>> +	if (branch_type & PERF_SAMPLE_BRANCH_ANY) {
>> +		brbfcr |= BRBFCR_EL1_BRANCH_FILTERS;
>> +		return brbfcr;
>> +	}
>> +
>> +	if (branch_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
>> +		brbfcr |= BRBFCR_EL1_INDCALL;
>> +		brbfcr |= BRBFCR_EL1_DIRCALL;
>> +	}
>> +
>> +	if (branch_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
>> +		brbfcr |= BRBFCR_EL1_RTN;
>> +
>> +	if (branch_type & PERF_SAMPLE_BRANCH_IND_CALL)
>> +		brbfcr |= BRBFCR_EL1_INDCALL;
>> +
>> +	if (branch_type & PERF_SAMPLE_BRANCH_COND)
>> +		brbfcr |= BRBFCR_EL1_CONDDIR;
>> +
>> +	if (branch_type & PERF_SAMPLE_BRANCH_IND_JUMP)
>> +		brbfcr |= BRBFCR_EL1_INDIRECT;
>> +
>> +	if (branch_type & PERF_SAMPLE_BRANCH_CALL)
>> +		brbfcr |= BRBFCR_EL1_DIRCALL;
>> +
>> +	return brbfcr;
>> +}
>> +
>> +/*
>> + * BRBE supports the following privilege mode filters while generating
>> + * branch records.
>> + *
>> + * BRBCR_ELx_E0BRE - EL0 branch records
>> + * BRBCR_ELx_ExBRE - EL1/EL2 branch records
>> + *
>> + * BRBE also supports the following additional functional branch type
>> + * filters while generating branch records.
>> + *
>> + * BRBCR_ELx_EXCEPTION - Exception
>> + * BRBCR_ELx_ERTN     -  Exception return
>> + */
>> +static u64 branch_type_to_brbcr(int branch_type)
>> +{
>> +	u64 brbcr = BRBCR_ELx_DEFAULT_TS;
>> +
>> +	/*
>> +	 * BRBE should be paused on PMU interrupt while tracing kernel
>> +	 * space to stop capturing further branch records. Otherwise
>> +	 * interrupt handler branch records might get into the samples
>> +	 * which is not desired.
>> +	 *
>> +	 * BRBE need not be paused on PMU interrupt while tracing only
>> +	 * the user space, because it will automatically be inside the
>> +	 * prohibited region. But even after PMU overflow occurs, the
>> +	 * interrupt could still take much more cycles, before it can
>> +	 * be taken and by that time BRBE will have been overwritten.
>> +	 * Hence enable pause on PMU interrupt mechanism even for user
>> +	 * only traces as well.
>> +	 */
>> +	brbcr |= BRBCR_ELx_FZP;
>> +
>> +	if (branch_type & PERF_SAMPLE_BRANCH_USER)
>> +		brbcr |= BRBCR_ELx_E0BRE;
>> +
>> +	/*
>> +	 * When running in the hyp mode, writing into BRBCR_EL1
>> +	 * actually writes into BRBCR_EL2 instead. Field E2BRE
>> +	 * is also at the same position as E1BRE.
>> +	 */
>> +	if (branch_type & PERF_SAMPLE_BRANCH_KERNEL)
>> +		brbcr |= BRBCR_ELx_ExBRE;
>> +
>> +	if (branch_type & PERF_SAMPLE_BRANCH_HV) {
>> +		if (is_kernel_in_hyp_mode())
>> +			brbcr |= BRBCR_ELx_ExBRE;
>> +	}
>> +
>> +	if (!(branch_type & PERF_SAMPLE_BRANCH_NO_CYCLES))
>> +		brbcr |= BRBCR_ELx_CC;
>> +
>> +	if (!(branch_type & PERF_SAMPLE_BRANCH_NO_FLAGS))
>> +		brbcr |= BRBCR_ELx_MPRED;
>> +
>> +	/*
>> +	 * The exception and exception return branches could be
>> +	 * captured, irrespective of the perf event's privilege.
>> +	 * If the perf event does not have enough privilege for
>> +	 * a given exception level, then addresses which falls
>> +	 * under that exception level will be reported as zero
>> +	 * for the captured branch record, creating source only
>> +	 * or target only records.
>> +	 */
>> +	if (branch_type & PERF_SAMPLE_BRANCH_ANY) {
>> +		brbcr |= BRBCR_ELx_EXCEPTION;
>> +		brbcr |= BRBCR_ELx_ERTN;
>> +	}
>> +
>> +	if (branch_type & PERF_SAMPLE_BRANCH_ANY_CALL)
>> +		brbcr |= BRBCR_ELx_EXCEPTION;
>> +
>> +	if (branch_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
>> +		brbcr |= BRBCR_ELx_ERTN;
>> +
>> +	return brbcr & BRBCR_ELx_CONFIG_MASK;
>> +}
>> +
>> +void armv8pmu_branch_enable(struct arm_pmu *arm_pmu)
>> +{
>> +	struct pmu_hw_events *cpuc = this_cpu_ptr(arm_pmu->hw_events);
>> +	u64 brbfcr, brbcr;
>> +
>> +	if (!(cpuc->brbe_sample_type && cpuc->brbe_users))
>> +		return;
>> +
>> +	/*
>> +	 * BRBE gets configured with a new mismatched branch sample
>> +	 * type request, overriding any previous branch filters.
>> +	 */
>> +	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>> +	brbfcr &= ~BRBFCR_EL1_DEFAULT_CONFIG;
> 
> This is called default_config, but is being used semantically the same
> way as BRBCR_ELx_CONFIG_MASK below to clear out the fields. Doesn't that
> mean that it's a mask rather than a default config? It's only ever used
> in this way. default_config implies it's written or used as an
> initialiser at some point.

Sure, will rename BRBFCR_EL1_DEFAULT_CONFIG as BRBFCR_EL1_CONFIG_MASK
making it similar to BRBCR_ELx_CONFIG_MASK.

> 
>> +	brbfcr |= branch_type_to_brbfcr(cpuc->brbe_sample_type);
>> +	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
>> +	isb();
>> +
>> +	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
>> +	brbcr &= ~BRBCR_ELx_CONFIG_MASK;
>> +	brbcr |= branch_type_to_brbcr(cpuc->brbe_sample_type);
> 
> BRBCR_ELx_CONFIG_MASK is already &'d at the end of
> branch_type_to_brbcr(), so isn't it easier and equivalent to just do the
> following instead of the read(), &= and then |= ?
> 
>   write_sysreg_s(branch_type_to_brbcr(...), SYS_BRBCR_EL1);
> 
> Or at least make branch_type_to_brbfcr() consistent and &
> BRBFCR_EL1_DEFAULT_CONFIG at the end of that function too.

This sounds better I guess, will '&' BRBFCR_EL1_CONFIG_MASK at the end
of branch_type_to_brbfcr().

> 
>> +	write_sysreg_s(brbcr, SYS_BRBCR_EL1);
>> +	isb();
>> +}
>> +
