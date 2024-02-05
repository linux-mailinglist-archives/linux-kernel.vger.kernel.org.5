Return-Path: <linux-kernel+bounces-52583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA3B8499E8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DC61F27DE4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698091BDD8;
	Mon,  5 Feb 2024 12:17:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E9D1BDCB
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707135429; cv=none; b=Y2T3x2nA7fAKLbjojxFTjGLThedan4oYiHkeN2pUpS/KTyR8qS80NIpzsj1GXr/PwMoGS+Pv8W/MvDN9brR3xgl3ddjtGx7/5x0nZCp0cGsC7zocX/AsnLVOXu+9KuNHoaFow/GAJ4Qr/W7YGZqvwijtxp3MRRvsGXhmbOBk2cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707135429; c=relaxed/simple;
	bh=VYK5g/0R2/Z5x6Dsj2RZevVNWOR5dKFVJQ16sbAiQAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chYq7UKHEh+nN+1DnrklrPVUBubMMvnMcaVcoJUZbRJqFR3y5RoGPC+X7shdMNIX1COMNQXtdcuCp9f8XkB3BgGQPSEwfbvYp+aJgKSGubG4yZvib5lyk+pfba+w+suarvo442TZw69uByx2jVFqnGNz+Me7LJrn3YpYDjhc/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC3101FB;
	Mon,  5 Feb 2024 04:17:47 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 112433F762;
	Mon,  5 Feb 2024 04:16:58 -0800 (PST)
Message-ID: <8a908ee8-620a-d9c2-734b-5a6402950072@arm.com>
Date: Mon, 5 Feb 2024 12:16:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 2/7] arm64: KVM: Use shared area to pass PMU event
 state to hypervisor
Content-Language: en-US
To: Oliver Upton <oliver.upton@linux.dev>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, broonie@kernel.org, maz@kernel.org,
 suzuki.poulose@arm.com, acme@kernel.org, James Morse <james.morse@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Rob Herring
 <robh@kernel.org>, Miguel Luis <miguel.luis@oracle.com>,
 Jintack Lim <jintack.lim@linaro.org>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Vincent Donnefort <vdonnefort@google.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jing Zhang
 <jingzhangos@google.com>, linux-kernel@vger.kernel.org
References: <20240104162714.1062610-1-james.clark@arm.com>
 <20240104162714.1062610-3-james.clark@arm.com> <Zb1mCCi13AJ_YjFZ@linux.dev>
From: James Clark <james.clark@arm.com>
In-Reply-To: <Zb1mCCi13AJ_YjFZ@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02/02/2024 22:00, Oliver Upton wrote:
> On Thu, Jan 04, 2024 at 04:27:02PM +0000, James Clark wrote:
> 
> [...]
> 
>> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
>> index c50f8459e4fc..89147a9dc38c 100644
>> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
>> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
>> @@ -130,13 +130,18 @@ static void __hyp_vgic_restore_state(struct kvm_vcpu *vcpu)
>>  	}
>>  }
>>  
>> +static struct kvm_pmu_events *kvm_nvhe_get_pmu_events(struct kvm_vcpu *vcpu)
>> +{
>> +	return &kvm_host_global_state[vcpu->cpu].pmu_events;
>> +}
>> +
>>  /*
>>   * Disable host events, enable guest events
>>   */
>>  #ifdef CONFIG_HW_PERF_EVENTS
>>  static bool __pmu_switch_to_guest(struct kvm_vcpu *vcpu)
>>  {
>> -	struct kvm_pmu_events *pmu = &vcpu->arch.pmu.events;
>> +	struct kvm_pmu_events *pmu = kvm_nvhe_get_pmu_events(vcpu);
>>  
>>  	if (pmu->events_host)
>>  		write_sysreg(pmu->events_host, pmcntenclr_el0);
>> @@ -152,7 +157,7 @@ static bool __pmu_switch_to_guest(struct kvm_vcpu *vcpu)
>>   */
>>  static void __pmu_switch_to_host(struct kvm_vcpu *vcpu)
>>  {
>> -	struct kvm_pmu_events *pmu = &vcpu->arch.pmu.events;
>> +	struct kvm_pmu_events *pmu = kvm_nvhe_get_pmu_events(vcpu);
>>  
>>  	if (pmu->events_guest)
>>  		write_sysreg(pmu->events_guest, pmcntenclr_el0);
> 
> This now allows the host to program event counters for a protected
> guest. That _might_ be a useful feature behind some debug option, but is
> most definitely *not* something we want to do for pVMs generally.

Unless I'm missing something, using PMUs on protected guests was added
by 722625c6f4c5b ("KVM: arm64: Reenable pmu in Protected Mode"). This
change is just a refactor that will allow us to add the same behavior
for a similar feature (tracing) without adding yet another copy of some
state before the guest switch.

> 
> Do we even need to make this shared data work at all for pKVM? The rest
> of the shared data between pKVM and the kernel is system information,
> which (importantly) doesn't have any guest context in it.
> 

Probably not, Marc actually mentioned on one of the first versions of
that this could be hidden behind a debug flag. To be honest one of the
reasons I didn't do that was because I wasn't sure what the appropriate
debug setting was. NVHE_EL2_DEBUG didn't seem quite right. DEBUG_KERNEL
maybe? Or a new one?

And then I suppose I got distracted by trying to make it have feature
parity with PMUs and forgot about the debug only thing.


> I'm perfectly happy leaving these sorts of features broken for pKVM and
> using the 'normal' way of getting percpu data to the nVHE hypervisor
> otherwise.
> 

I can do that. But do I also disable PMU at the same time in a new
commit? Now that both PMU and tracing is working maybe it would be a
waste to throw that away and hiding it behind an option is better. Or I
can leave the PMU as it is and just keep tracing disabled in pKVM.

I don't mind either way, my main goal was to get exclude/include guest
tracing working for normal VMs. For pKVM I don't have a strong opinion.

