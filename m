Return-Path: <linux-kernel+bounces-81824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA16867A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE4F3B21952
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D492912C52A;
	Mon, 26 Feb 2024 15:41:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518FC12BF21
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962071; cv=none; b=XcD/A7dDoEIC69flFrsOvrel8RdX0AdrxUy9bW5jN3edmTD0kFTsXQNLp1AeX0l+xyTcIBNHzKIeVUKEvAJUSMpoyWfApkmrmBNHm5EWMsCgTNc/JBfuM8NXZKQGJauw8M+aetdsRNV/brYAbOTFu6Wvy0pwiZFKS1PbynH3xC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962071; c=relaxed/simple;
	bh=eP49OFEMvhH3M/3LwOB217nVAZoA5vsSqN74iTTOMKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N78BfPr8Ss1dVYI/KXsVXjnA0Ht2y6YPyX2FpfJl5QO8LcfNoBVyTPaolVg5u0j8xgTaacod3oJmo8TMo39Jlq3prnLk9XLrWYiVeFYXW+7Ti06ivmbQzPGYqt+Wr7b47+rQ1mYze/0RgJN/72JEz9O4LpRlDdVvh6wATW9ug/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56106DA7;
	Mon, 26 Feb 2024 07:41:46 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B25C43F762;
	Mon, 26 Feb 2024 07:41:03 -0800 (PST)
Message-ID: <8b9c1cce-401c-5084-ee2f-68beb03ad7a0@arm.com>
Date: Mon, 26 Feb 2024 15:41:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 5/8] arm64: KVM: Add iflag for FEAT_TRF
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, suzuki.poulose@arm.com, acme@kernel.org,
 oliver.upton@linux.dev, broonie@kernel.org, James Morse
 <james.morse@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Miguel Luis <miguel.luis@oracle.com>, Joey Gouly <joey.gouly@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Quentin Perret <qperret@google.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Vincent Donnefort <vdonnefort@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>,
 Jing Zhang <jingzhangos@google.com>, linux-kernel@vger.kernel.org
References: <20240226113044.228403-1-james.clark@arm.com>
 <20240226113044.228403-6-james.clark@arm.com> <86edcz2vrz.wl-maz@kernel.org>
From: James Clark <james.clark@arm.com>
In-Reply-To: <86edcz2vrz.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/02/2024 13:35, Marc Zyngier wrote:
> On Mon, 26 Feb 2024 11:30:33 +0000,
> James Clark <james.clark@arm.com> wrote:
>>
>> Add an extra iflag to signify if the TRFCR register is accessible.
> 
> That's not what this flag means: it indicates whether TRFCR needs to
> be saved. At lease that's what the name suggests.
> 
>> Because TRBE requires FEAT_TRF, DEBUG_STATE_SAVE_TRBE still has the same
>> behavior even though it's only set when FEAT_TRF is present.
> 
> This sentence seems completely out of context, because you didn't
> explain that you were making TRBE *conditional* on TRF being
> implemented, as per the architecture requirements.
> 
>>
>> The following holes are left in struct kvm_vcpu_arch, but there aren't
>> enough other 8 bit fields to rearrange it to leave any hole smaller than
>> 7 bytes:
>>
>>   u8                         cflags;               /*  2292     1 */
>>   /* XXX 1 byte hole, try to pack */
>>   u16                        iflags;               /*  2294     2 */
>>   u8                         sflags;               /*  2296     1 */
>>   bool                       pause;                /*  2297     1 */
>>   /* XXX 6 bytes hole, try to pack */
> 
> I don't think that's particularly useful in a commit message, but more
> relevant to the cover letter. However, see below.
> 
>>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  arch/arm64/include/asm/kvm_host.h |  4 +++-
>>  arch/arm64/kvm/debug.c            | 24 ++++++++++++++++++++----
>>  2 files changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 21c57b812569..85b5477bd1b4 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -569,7 +569,7 @@ struct kvm_vcpu_arch {
>>  	u8 cflags;
>>  
>>  	/* Input flags to the hypervisor code, potentially cleared after use */
>> -	u8 iflags;
>> +	u16 iflags;
>>  
>>  	/* State flags for kernel bookkeeping, unused by the hypervisor code */
>>  	u8 sflags;
>> @@ -779,6 +779,8 @@ struct kvm_vcpu_arch {
>>  #define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
>>  /* vcpu running in HYP context */
>>  #define VCPU_HYP_CONTEXT	__vcpu_single_flag(iflags, BIT(7))
>> +/* Save trace filter controls */
>> +#define DEBUG_STATE_SAVE_TRFCR	__vcpu_single_flag(iflags, BIT(8))
> 
> I'd rather you cherry-pick [1] and avoid expanding the iflags.
> 
> [1] https://lore.kernel.org/r/20240226100601.2379693-4-maz@kernel.org
> 
> Now, I think the whole SPE/TRBE/TRCR flag management should be
> improved, see below.
> 
>>
>>  /* SVE enabled for host EL0 */
>>  #define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>> index ce8886122ed3..49a13e72ddd2 100644
>> --- a/arch/arm64/kvm/debug.c
>> +++ b/arch/arm64/kvm/debug.c
>> @@ -332,14 +332,30 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
>>  	    !(read_sysreg_s(SYS_PMBIDR_EL1) & BIT(PMBIDR_EL1_P_SHIFT)))
>>  		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_SPE);
>>  
>> -	/* Check if we have TRBE implemented and available at the host */
>> -	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
>> -	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
>> -		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>> +	/*
>> +	 * Set SAVE_TRFCR flag if FEAT_TRF (TraceFilt) exists. This flag
>> +	 * signifies that the exclude_host/exclude_guest settings of any active
>> +	 * host Perf session on a core running a VCPU can be written into
>> +	 * TRFCR_EL1 on guest switch.
>> +	 */
>> +	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceFilt_SHIFT)) {
>> +		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
> 
> Can we avoid doing this unconditionally? It only makes sense to save
> the trace crud if it is going to be changed, right?
> 

Do you mean to see if kvm_guest_trfcr was non-zero (and would have to be
changed) at VCPU load? I assumed that it could be modified between load
and switch. That would mean there is no way to do it conditionally.

I also assumed that's the reason SPE and TRBE were implemented like
this, with the feat check at load and the enabled check at switch. It
doesn't feel like TRFCR is any different to those two.

Or do you mean to only set DEBUG_STATE_SAVE_TRFCR on switch if tracing
was enabled?

I suppose the names DEBUG_STATE_SAVE_SPE and DEBUG_STATE_SAVE_TRBE are
slightly misleading because neither are actually saved if they weren't
enabled. They're more like DEBUG_STATE_HAS_SPE and DEBUG_STATE_HAS_TRBE.

>> +		/*
>> +		 * Check if we have TRBE implemented and available at the host.
>> +		 * If it's in use at the time of guest switch then trace will
>> +		 * need to be completely disabled. The architecture mandates
>> +		 * FEAT_TRF with TRBE, so we only need to check for TRBE after
>> +		 * TRF.
>> +		 */
>> +		if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
>> +		    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
>> +			vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>> +	}
>>  }
>>  
>>  void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>>  {
>>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
>>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>> +	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
>>  }
> 
> Dealing with flags that are strongly coupled in a disjoined way a
> pretty bad idea. Look at the generated code, and realise we flip the
> preempt flag on each access.
> 
> Can we do better? You bet. The vcpu_{set,clear}_flags infrastructure
> is capable of dealing with multiple flags at once, as demonstrated by
> the way we deal with exception encoding.
> 

Oops yeah I didn't realize that this was more than a bit set/clear. I
will combine them. I think I could probably combine the TRBE/TRF set as
well.

Agree with the rest of the comments too.

Thanks
James

> Something like:
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index addf79ba8fa0..3e50e535fdd4 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -885,6 +885,10 @@ struct kvm_vcpu_arch {
>  #define DEBUG_STATE_SAVE_SPE	__vcpu_single_flag(iflags, BIT(5))
>  /* Save TRBE context if active  */
>  #define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
> +/* Save Trace Filter Controls  */
> +#define DEBUG_STATE_SAVE_TRFCR	__vcpu_single_flag(iflags, BIT(7))
> +/* Global debug mask */
> +#define DEBUG_STATE_SAVE_MASK	__vcpu_single_flag(iflags, GENMASK(7, 5))
>  
>  /* SVE enabled for host EL0 */
>  #define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index 8725291cb00a..f9b197a00582 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -339,6 +339,6 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
>  
>  void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>  {
> -	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
> -	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
> +	if (!has_vhe())
> +	    vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_MASK);
>  }
> 
> Thanks,
> 
> 	M.
> 

