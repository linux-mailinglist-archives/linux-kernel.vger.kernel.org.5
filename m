Return-Path: <linux-kernel+bounces-81141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C440867283
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6C7AB23B93
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB925FEF1;
	Mon, 26 Feb 2024 10:15:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338845FEE9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942505; cv=none; b=e4oSTtWTvxEcP+zKZc8h+iKeIe+BjvMBO6Crf3ngPyUcKpJAaLD+1GIPtdBwP/vzj9KOzRxQlkXZU+XqqBdaFHWmfu+7pViioB7k42Y6jixcYX6KOa9Vyg/OaimGykXengxGfyGB6Bb6wp4+j2RR22CUNS86QNUVRsMVeeplhyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942505; c=relaxed/simple;
	bh=6GQ4h/oDGendPMzWfxwIWWvA/xDItW3TKyAauSavtv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKpn4j35r551D2cUNs7M3lssn5saBPZYSR6pE97hksf9+tK+gZYDmkM5UkjmVpSRQphpxheIoO3CeeQFVeS9n06R3vRd4aqDxXp6pqHE65Z+zTvr4jvcjxtAOQ7PzgYDDLlitVNhnPaNd0W5okhPg3t0pZOe238gDHBUN6cPVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E695DA7;
	Mon, 26 Feb 2024 02:15:41 -0800 (PST)
Received: from [10.57.50.187] (unknown [10.57.50.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A5613F6C4;
	Mon, 26 Feb 2024 02:14:58 -0800 (PST)
Message-ID: <1d2a6c09-6892-48fc-a7fb-e171c7fbd814@arm.com>
Date: Mon, 26 Feb 2024 10:14:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] arm64: KVM: Write TRFCR value on guest switch with
 nVHE
Content-Language: en-GB
To: James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 maz@kernel.org, acme@kernel.org, oliver.upton@linux.dev, broonie@kernel.org
Cc: James Morse <james.morse@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Miguel Luis <miguel.luis@oracle.com>, Joey Gouly <joey.gouly@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Helge Deller <deller@gmx.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>,
 Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Vincent Donnefort <vdonnefort@google.com>, Fuad Tabba <tabba@google.com>,
 Jing Zhang <jingzhangos@google.com>, linux-kernel@vger.kernel.org
References: <20240220100924.2761706-1-james.clark@arm.com>
 <20240220100924.2761706-7-james.clark@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240220100924.2761706-7-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/02/2024 10:09, James Clark wrote:
> The guest value for TRFCR requested by the Coresight driver is saved in
> kvm_guest_trfcr. On guest switch this value needs to be written to
> the register. Currently TRFCR is only modified when we want to disable
> trace completely in guests due to an issue with TRBE. Expand the
> __debug_save_trace() function to always write to the register if a
> different value for guests is required, but also keep the existing TRBE
> disable behavior if that's required.
> 
> In pKVM, the kvm_guest_trfcr can't be read and the host isn't trusted,
> so always disable trace.
> 
> __debug_restore_trace() now has to restore unconditionally, because even
> a value of 0 needs to be written to overwrite whatever was set for the
> guest.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


> ---
>   arch/arm64/kvm/hyp/nvhe/debug-sr.c | 53 +++++++++++++++++-------------
>   1 file changed, 31 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
> index 4558c02eb352..3adac2e01908 100644
> --- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
> +++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
> @@ -51,30 +51,39 @@ static void __debug_restore_spe(u64 pmscr_el1)
>   	write_sysreg_s(pmscr_el1, SYS_PMSCR_EL1);
>   }
>   
> -static void __debug_save_trace(u64 *trfcr_el1)
> +static void __debug_save_trace(struct kvm_vcpu *vcpu)
>   {
> -	*trfcr_el1 = 0;
> -
> -	/* Check if the TRBE is enabled */
> -	if (!(read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_E))
> -		return;
> -	/*
> -	 * Prohibit trace generation while we are in guest.
> -	 * Since access to TRFCR_EL1 is trapped, the guest can't
> -	 * modify the filtering set by the host.
> -	 */
> -	*trfcr_el1 = read_sysreg_s(SYS_TRFCR_EL1);
> -	write_sysreg_s(0, SYS_TRFCR_EL1);
> -	isb();
> -	/* Drain the trace buffer to memory */
> -	tsb_csync();
> +	u64 host_trfcr_el1 = read_sysreg_s(SYS_TRFCR_EL1);
> +	u64 guest_trfcr_el1;
> +
> +	vcpu->arch.host_debug_state.trfcr_el1 = host_trfcr_el1;
> +
> +	/* Check if the TRBE buffer or pKVM is enabled */
> +	if (is_protected_kvm_enabled() ||
> +	    (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE) &&
> +	     read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_E)) {
> +		/*
> +		 * Prohibit trace generation while we are in guest. Since access
> +		 * to TRFCR_EL1 is trapped, the guest can't modify the filtering
> +		 * set by the host.
> +		 */
> +		write_sysreg_s(0, SYS_TRFCR_EL1);
> +		isb();
> +		/* Drain the trace buffer to memory */
> +		tsb_csync();
> +	} else {
> +		/*
> +		 * Tracing is allowed, apply the filters provided by the
> +		 * Coresight driver.
> +		 */
> +		guest_trfcr_el1 = kvm_guest_trfcr[vcpu->cpu];
> +		if (host_trfcr_el1 != guest_trfcr_el1)
> +			write_sysreg_s(guest_trfcr_el1, SYS_TRFCR_EL1);
> +	}
>   }
>   
>   static void __debug_restore_trace(u64 trfcr_el1)
>   {
> -	if (!trfcr_el1)
> -		return;
> -
>   	/* Restore trace filter controls */
>   	write_sysreg_s(trfcr_el1, SYS_TRFCR_EL1);
>   }
> @@ -85,8 +94,8 @@ void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
>   	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
>   		__debug_save_spe(&vcpu->arch.host_debug_state.pmscr_el1);
>   	/* Disable and flush Self-Hosted Trace generation */
> -	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
> -		__debug_save_trace(&vcpu->arch.host_debug_state.trfcr_el1);
> +	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))
> +		__debug_save_trace(vcpu);
>   }
>   
>   void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
> @@ -98,7 +107,7 @@ void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu)
>   {
>   	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
>   		__debug_restore_spe(vcpu->arch.host_debug_state.pmscr_el1);
> -	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
> +	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))
>   		__debug_restore_trace(vcpu->arch.host_debug_state.trfcr_el1);
>   }
>   


