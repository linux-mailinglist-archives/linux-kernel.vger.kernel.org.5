Return-Path: <linux-kernel+bounces-17709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5767682516C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708A91C22BB8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD08025116;
	Fri,  5 Jan 2024 10:05:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA6B24B59
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BAA8FEC;
	Fri,  5 Jan 2024 02:05:56 -0800 (PST)
Received: from [192.168.32.22] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DF423F64C;
	Fri,  5 Jan 2024 02:05:02 -0800 (PST)
Message-ID: <ea427dbc-a1ec-9461-9f39-992d5b22e83e@arm.com>
Date: Fri, 5 Jan 2024 10:05:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 6/7] arm64: KVM: Write TRFCR value on guest switch with
 nVHE
Content-Language: en-US
To: Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 broonie@kernel.org, maz@kernel.org, acme@kernel.org
Cc: Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Rob Herring
 <robh@kernel.org>, Miguel Luis <miguel.luis@oracle.com>,
 Jintack Lim <jintack.lim@linaro.org>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Helge Deller <deller@gmx.de>,
 Arnd Bergmann <arnd@arndb.de>, Kalesh Singh <kaleshsingh@google.com>,
 Quentin Perret <qperret@google.com>,
 Vincent Donnefort <vdonnefort@google.com>, Fuad Tabba <tabba@google.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Joey Gouly <joey.gouly@arm.com>,
 Jing Zhang <jingzhangos@google.com>, linux-kernel@vger.kernel.org
References: <20240104162714.1062610-1-james.clark@arm.com>
 <20240104162714.1062610-7-james.clark@arm.com>
 <8ba4d3dd-6ab2-49e3-9d25-d742e4958afc@arm.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <8ba4d3dd-6ab2-49e3-9d25-d742e4958afc@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/01/2024 09:50, Suzuki K Poulose wrote:
> On 04/01/2024 16:27, James Clark wrote:
>> The guest value for TRFCR requested by the Coresight driver is saved in
>> kvm_host_global_state. On guest switch this value needs to be written to
>> the register. Currently TRFCR is only modified when we want to disable
>> trace completely in guests due to an issue with TRBE. Expand the
>> __debug_save_trace() function to always write to the register if a
>> different value for guests is required, but also keep the existing TRBE
>> disable behavior if that's required.
>>
>> The TRFCR restore function remains functionally the same, except a value
>> of 0 doesn't mean "don't restore" anymore. Now that we save both guest
>> and host values the register is restored any time the guest and host
>> values differ.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   arch/arm64/kvm/hyp/nvhe/debug-sr.c | 55 ++++++++++++++++++------------
>>   1 file changed, 34 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> index 4558c02eb352..7fd876d4f034 100644
>> --- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> +++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
>> @@ -51,32 +51,45 @@ static void __debug_restore_spe(u64 pmscr_el1)
>>       write_sysreg_s(pmscr_el1, SYS_PMSCR_EL1);
>>   }
>>   -static void __debug_save_trace(u64 *trfcr_el1)
>> +/*
>> + * Save TRFCR and disable trace completely if TRBE is being used,
>> otherwise
>> + * apply required guest TRFCR value.
>> + */
>> +static void __debug_save_trace(struct kvm_vcpu *vcpu)
>>   {
>> -    *trfcr_el1 = 0;
>> +    u64 host_trfcr_el1 = read_sysreg_s(SYS_TRFCR_EL1);
>> +    u64 guest_trfcr_el1;
>> +
>> +    vcpu->arch.host_debug_state.trfcr_el1 = host_trfcr_el1;
>>         /* Check if the TRBE is enabled */
>> -    if (!(read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_E))
>> -        return;
>> -    /*
>> -     * Prohibit trace generation while we are in guest.
>> -     * Since access to TRFCR_EL1 is trapped, the guest can't
>> -     * modify the filtering set by the host.
>> -     */
>> -    *trfcr_el1 = read_sysreg_s(SYS_TRFCR_EL1);
>> -    write_sysreg_s(0, SYS_TRFCR_EL1);
>> -    isb();
>> -    /* Drain the trace buffer to memory */
>> -    tsb_csync();
>> +    if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE) &&
>> +        (read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_E)) {
>> +        /*
>> +         * Prohibit trace generation while we are in guest. Since access
>> +         * to TRFCR_EL1 is trapped, the guest can't modify the filtering
>> +         * set by the host.
>> +         */
>> +        write_sysreg_s(0, SYS_TRFCR_EL1);
>> +        isb();
>> +        /* Drain the trace buffer to memory */
>> +        tsb_csync();
>> +    } else {
>> +        /*
>> +         * Not using TRBE, so guest trace works. Apply the guest filters
>> +         * provided by the Coresight driver, if different.
>> +         */
>> +        guest_trfcr_el1 =
>> kvm_host_global_state[vcpu->cpu].guest_trfcr_el1;
>> +        if (host_trfcr_el1 != guest_trfcr_el1)
>> +            write_sysreg_s(guest_trfcr_el1, SYS_TRFCR_EL1);
>> +    }
>>   }
>>     static void __debug_restore_trace(u64 trfcr_el1)
>>   {
>> -    if (!trfcr_el1)
>> -        return;
>> -
>>       /* Restore trace filter controls */
>> -    write_sysreg_s(trfcr_el1, SYS_TRFCR_EL1);
>> +    if (trfcr_el1 != read_sysreg_s(SYS_TRFCR_EL1))
>> +        write_sysreg_s(trfcr_el1, SYS_TRFCR_EL1);
> 
> Could we not write it unconditionally here ? In the saving step, we have
> to save the host setting. But while restoring, we could skip the check.
> A read and write is probably the same cost, as the value is implicitly
> synchronized by a later ISB.
> 
> Eitherways,
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> 

I did also wonder if it was better to just do it unconditionally. I'll
update it in the next version.

>>   }
>>     void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
>> @@ -85,8 +98,8 @@ void __debug_save_host_buffers_nvhe(struct kvm_vcpu
>> *vcpu)
>>       if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
>>           __debug_save_spe(&vcpu->arch.host_debug_state.pmscr_el1);
>>       /* Disable and flush Self-Hosted Trace generation */
>> -    if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
>> -        __debug_save_trace(&vcpu->arch.host_debug_state.trfcr_el1);
>> +    if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))
>> +        __debug_save_trace(vcpu);
>>   }
>>     void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
>> @@ -98,7 +111,7 @@ void __debug_restore_host_buffers_nvhe(struct
>> kvm_vcpu *vcpu)
>>   {
>>       if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
>>           __debug_restore_spe(vcpu->arch.host_debug_state.pmscr_el1);
>> -    if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
>> +    if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))
>>           __debug_restore_trace(vcpu->arch.host_debug_state.trfcr_el1);
>>   }
>>   
> 

