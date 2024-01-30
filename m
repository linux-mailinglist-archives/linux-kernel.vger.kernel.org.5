Return-Path: <linux-kernel+bounces-43910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D87841AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F461C23677
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC89374FB;
	Tue, 30 Jan 2024 03:40:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43999381A4;
	Tue, 30 Jan 2024 03:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706586036; cv=none; b=JfMIq89r9vBDjNB62v9HFZvTl8IIYEWIMokzyDICaYyPO7jRHPWwyqB3cpZlyDCx5ZG7135Q8eBGElX9Tdd3/htXMbdDq05VZhZczU+vDcrLDfsB7OY5fRRWui1bkbInNO8AQAdlxF6QTmfJ/bAXJSMTvgZkogcBfjI9R8G6IPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706586036; c=relaxed/simple;
	bh=88yvcbbXHbF7fdecKCydk6ptKkEXS1qcAAJXLr19C58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Abxej4P3x1z33MOXQxLRQ+C7+ACUTojMIIgfPa7Kg46vLuU/65qp06FmZ6vT86qDvDA6gnbi4PzNoX+0jCic2zxdehHaKPtOBxDkn0sNjsrz1WBqR3AJHOSnoy5CSP2hrTngPBEICVDmnib0UPchRDg6gaqKHtrlc33B1KyNUJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67797DA7;
	Mon, 29 Jan 2024 19:41:16 -0800 (PST)
Received: from [10.163.41.110] (unknown [10.163.41.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CB0C3F738;
	Mon, 29 Jan 2024 19:40:26 -0800 (PST)
Message-ID: <4395415b-dfb1-4dd1-9dfd-181f0549be7c@arm.com>
Date: Tue, 30 Jan 2024 09:10:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V16 2/8] KVM: arm64: Prevent guest accesses into BRBE
 system registers/instructions
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc: Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
 Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-perf-users@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
 <20240125094119.2542332-3-anshuman.khandual@arm.com>
 <95d829b3-d30e-4dcd-a7ca-69d80b9be418@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <95d829b3-d30e-4dcd-a7ca-69d80b9be418@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/29/24 17:45, Suzuki K Poulose wrote:
> On 25/01/2024 09:41, Anshuman Khandual wrote:
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
>> Changes in V16:
>>
>> - Added BRB_INF_SRC_TGT_EL1 macro for corresponding BRB_[INF|SRC|TGT] expansion
>>
>>   arch/arm64/kvm/sys_regs.c | 56 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 56 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 30253bd19917..6a06dc2f0c06 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1304,6 +1304,11 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
>>       return 0;
>>   }
>>   +#define BRB_INF_SRC_TGT_EL1(n)                    \
>> +    { SYS_DESC(SYS_BRBINF##n##_EL1), undef_access },    \
>> +    { SYS_DESC(SYS_BRBSRC##n##_EL1), undef_access },    \
>> +    { SYS_DESC(SYS_BRBTGT##n##_EL1), undef_access }        \
>> +
>>   /* Silly macro to expand the DBG{BCR,BVR,WVR,WCR}n_EL1 registers in one go */
>>   #define DBG_BCR_BVR_WCR_WVR_EL1(n)                    \
>>       { SYS_DESC(SYS_DBGBVRn_EL1(n)),                    \
>> @@ -1707,6 +1712,9 @@ static u64 read_sanitised_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
>>       /* Hide SPE from guests */
>>       val &= ~ID_AA64DFR0_EL1_PMSVer_MASK;
>>   +    /* Hide BRBE from guests */
>> +    val &= ~ID_AA64DFR0_EL1_BRBE_MASK;
>> +
>>       return val;
>>   }
>>   @@ -2195,6 +2203,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>>       { SYS_DESC(SYS_DC_CISW), access_dcsw },
>>       { SYS_DESC(SYS_DC_CIGSW), access_dcgsw },
>>       { SYS_DESC(SYS_DC_CIGDSW), access_dcgsw },
>> +    { SYS_DESC(OP_BRB_IALL), undef_access },
>> +    { SYS_DESC(OP_BRB_INJ), undef_access },
>>   
> 
> heads up: This may conflict with Marc's patches to move the sys instructions to a separate table. But otherwise, looks good to me.

Sure, will rebase this on recent changes.

