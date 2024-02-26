Return-Path: <linux-kernel+bounces-82118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D4A867F80
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62303294AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988CE12EBD3;
	Mon, 26 Feb 2024 18:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMUpxrMa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD60E80058;
	Mon, 26 Feb 2024 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970640; cv=none; b=uH2Pk9zd/DHXBKamNGhEQS5EqYJuz7lRHfp7NGuRMFcMIXnXiLjPyXkUldVnlb+3WRM/9PtRQIKqGIh9fk+RLVeJfwwSCxeFK/tLc5j+unp+kR2EtdaJX6+QU51i4PMXIaDiexm1G81EpZk48DQuIlZL8W/P1j0KNiz7eicSm/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970640; c=relaxed/simple;
	bh=mhTJjZKQrDShxZufuClbdZ2NvX4xFGOaNZAk1lyMMes=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sh96a6Tq8B+KbX49LaG2Ua4IzKftmYNRmeVSRPWZgi5esdwQPNKta+opHGl/TgQH8AbMYe0OaO7phLfOhtsvz9YneEpDc1xaQvJ21ihqRpSDwlcquE0S5mv00VhkSq8Zp0jqasqHZMRc+ME8FzbPR88kIcr/uA+5NKP1aXk28X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMUpxrMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4638EC433C7;
	Mon, 26 Feb 2024 18:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708970640;
	bh=mhTJjZKQrDShxZufuClbdZ2NvX4xFGOaNZAk1lyMMes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tMUpxrMaTOOrwNIHmAC9slZG/+uzyxb0RcBrBMKwFGkY31+YqR6DW30ZuA0g3Koi0
	 6ShU2OWvj9006LcsGxGyzWza4USkwgnm+LvF8hvLEzHcFaWXxpGvV2cm4b6K9ECRxI
	 B0UfrNRjHUpy7qvZAvFIHmAJMXf9nZFmD74/0iXVw2S8t96fu+i0aNM0ZL4QzvG8te
	 PN7uaQQ/lX5bY+QZoDfECo5Z/yBUC1VBPNvpCbJ+5C7awfFV5bRr/PCk2qeHpfqidq
	 NrQJtByZc4XL7IykOv2zJI7fQkBZ1BF/KMHrIUFZcY7s6GZ62H8N1JDDik3Yx7K33e
	 IxAdup/oYbGaA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1refKX-006z6g-Rp;
	Mon, 26 Feb 2024 18:03:57 +0000
Date: Mon, 26 Feb 2024 18:03:57 +0000
Message-ID: <86a5nn2jci.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	suzuki.poulose@arm.com,
	acme@kernel.org,
	oliver.upton@linux.dev,
	broonie@kernel.org,
	James Morse
 <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Miguel Luis <miguel.luis@oracle.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Quentin Perret <qperret@google.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Vincent Donnefort <vdonnefort@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Jing Zhang <jingzhangos@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/8] arm64: KVM: Add iflag for FEAT_TRF
In-Reply-To: <8b9c1cce-401c-5084-ee2f-68beb03ad7a0@arm.com>
References: <20240226113044.228403-1-james.clark@arm.com>
	<20240226113044.228403-6-james.clark@arm.com>
	<86edcz2vrz.wl-maz@kernel.org>
	<8b9c1cce-401c-5084-ee2f-68beb03ad7a0@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: james.clark@arm.com, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, suzuki.poulose@arm.com, acme@kernel.org, oliver.upton@linux.dev, broonie@kernel.org, james.morse@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, mike.leach@linaro.org, alexander.shishkin@linux.intel.com, anshuman.khandual@arm.com, miguel.luis@oracle.com, joey.gouly@arm.com, ardb@kernel.org, qperret@google.com, javierm@redhat.com, mark.rutland@arm.com, arnd@arndb.de, vdonnefort@google.com, ryan.roberts@arm.com, tabba@google.com, jingzhangos@google.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 26 Feb 2024 15:41:02 +0000,
James Clark <james.clark@arm.com> wrote:
> 
> 
> 
> On 26/02/2024 13:35, Marc Zyngier wrote:
> > On Mon, 26 Feb 2024 11:30:33 +0000,
> > James Clark <james.clark@arm.com> wrote:

[...]

> >> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> >> index ce8886122ed3..49a13e72ddd2 100644
> >> --- a/arch/arm64/kvm/debug.c
> >> +++ b/arch/arm64/kvm/debug.c
> >> @@ -332,14 +332,30 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
> >>  	    !(read_sysreg_s(SYS_PMBIDR_EL1) & BIT(PMBIDR_EL1_P_SHIFT)))
> >>  		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_SPE);
> >>  
> >> -	/* Check if we have TRBE implemented and available at the host */
> >> -	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
> >> -	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
> >> -		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
> >> +	/*
> >> +	 * Set SAVE_TRFCR flag if FEAT_TRF (TraceFilt) exists. This flag
> >> +	 * signifies that the exclude_host/exclude_guest settings of any active
> >> +	 * host Perf session on a core running a VCPU can be written into
> >> +	 * TRFCR_EL1 on guest switch.
> >> +	 */
> >> +	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceFilt_SHIFT)) {
> >> +		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
> > 
> > Can we avoid doing this unconditionally? It only makes sense to save
> > the trace crud if it is going to be changed, right?
> > 
> 
> Do you mean to see if kvm_guest_trfcr was non-zero (and would have to be
> changed) at VCPU load? I assumed that it could be modified between load
> and switch. That would mean there is no way to do it conditionally.

What's the problem? If you change the value behind the vcpu's back,
you get what you deserve: garbage.

I'm baffled that you consider that randomly changing a value without
proper synchronisation (such as with an IPI) is a valid approach.
Please look at what is being done for the PMU in the same context.

> I also assumed that's the reason SPE and TRBE were implemented like
> this, with the feat check at load and the enabled check at switch. It
> doesn't feel like TRFCR is any different to those two.

Well, that' doesn't make it right. Having just looked at the debug
stuff, I'm ashamed to have let that stuff in.

> Or do you mean to only set DEBUG_STATE_SAVE_TRFCR on switch if tracing
> was enabled?

I don't think there should be any flag. The discriminant should be:

- does the HW support TRF?
- is the in-guest tracing enabled?

If both are true, and that this requires a change of configuration,
*then* you perform the change. Same thing on exit. No flag. And a
static key for TRF support, which should really be valid on all CPUs.

	M.

-- 
Without deviation from the norm, progress is not possible.

