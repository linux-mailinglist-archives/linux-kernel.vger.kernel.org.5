Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0BC8108E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 04:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378412AbjLMDz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 22:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbjLMDz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 22:55:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1041E99;
        Tue, 12 Dec 2023 19:56:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D25A6C15;
        Tue, 12 Dec 2023 19:56:47 -0800 (PST)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEADB3F5A1;
        Tue, 12 Dec 2023 19:55:55 -0800 (PST)
Message-ID: <b319f8ed-5848-4663-bc1b-7afe160bbcd3@arm.com>
Date:   Wed, 13 Dec 2023 09:25:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V15 2/8] KVM: arm64: Prevent guest accesses into BRBE
 system registers/instructions
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev
References: <20231201053906.1261704-1-anshuman.khandual@arm.com>
 <20231201053906.1261704-3-anshuman.khandual@arm.com>
 <86v89ebcn2.wl-maz@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <86v89ebcn2.wl-maz@kernel.org>
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



On 12/4/23 13:52, Marc Zyngier wrote:
> On Fri, 01 Dec 2023 05:39:00 +0000,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>> Currently BRBE feature is not supported in a guest environment. This hides
>> BRBE feature availability via masking ID_AA64DFR0_EL1.BRBE field. This also
>> blocks guest accesses into BRBE system registers and instructions as if the
>> underlying hardware never implemented FEAT_BRBE feature.
>>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Oliver Upton <oliver.upton@linux.dev>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: kvmarm@lists.linux.dev
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/kvm/sys_regs.c | 130 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 130 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 4735e1b37fb3..42701065b3cd 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1583,6 +1583,9 @@ static u64 read_sanitised_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
>>  	/* Hide SPE from guests */
>>  	val &= ~ID_AA64DFR0_EL1_PMSVer_MASK;
>>  
>> +	/* Hide BRBE from guests */
>> +	val &= ~ID_AA64DFR0_EL1_BRBE_MASK;
>> +
>>  	return val;
>>  }
>>  
>> @@ -2042,6 +2045,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>>  	{ SYS_DESC(SYS_DC_CISW), access_dcsw },
>>  	{ SYS_DESC(SYS_DC_CIGSW), access_dcgsw },
>>  	{ SYS_DESC(SYS_DC_CIGDSW), access_dcgsw },
>> +	{ SYS_DESC(OP_BRB_IALL), undef_access },
>> +	{ SYS_DESC(OP_BRB_INJ), undef_access },
>>  
>>  	DBG_BCR_BVR_WCR_WVR_EL1(0),
>>  	DBG_BCR_BVR_WCR_WVR_EL1(1),
>> @@ -2072,6 +2077,131 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>>  	{ SYS_DESC(SYS_DBGCLAIMCLR_EL1), trap_raz_wi },
>>  	{ SYS_DESC(SYS_DBGAUTHSTATUS_EL1), trap_dbgauthstatus_el1 },
>>  
>> +	/*
>> +	 * BRBE branch record sysreg address space is interleaved between
>> +	 * corresponding BRBINF<N>_EL1, BRBSRC<N>_EL1, and BRBTGT<N>_EL1.
>> +	 */
>> +	{ SYS_DESC(SYS_BRBINF0_EL1), undef_access },
>> +	{ SYS_DESC(SYS_BRBSRC0_EL1), undef_access },
>> +	{ SYS_DESC(SYS_BRBTGT0_EL1), undef_access },
>> +	{ SYS_DESC(SYS_BRBINF16_EL1), undef_access },
>> +	{ SYS_DESC(SYS_BRBSRC16_EL1), undef_access },
>> +	{ SYS_DESC(SYS_BRBTGT16_EL1), undef_access },
> Surely we can do better than this wall of text. Please look at what we
> do for the debug registers, and adopt a similar pattern. This should
> result in one line per group of 3 registers.
> 
> What is the plan for KVM support beyond this?
We are planning to add support for simultaneous and independent branch record
tracing via perf branch stack sampling inside the guest and the host. But will
prevent tracing of the guest execution from the host.
