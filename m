Return-Path: <linux-kernel+bounces-82778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1410868993
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296F41C215CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B25C53E06;
	Tue, 27 Feb 2024 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t6qRFGpN"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A8E41C6A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017686; cv=none; b=LN/JxTacegGeoz8m+aOwvdE7wMsmC2CxwwUpvHdjVOflqJ7pX7E/hp/7NHLTL486oyMp7TVVsWRF5SU6Op0DXt38+0vkXwogA4T3uosGAMr26LLf+CfeNgT6ST2HPjjFxjbftiMm8Sn81+mfNgCE9aH7OEBdultmHw+kdjkV/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017686; c=relaxed/simple;
	bh=fwBRjuCr3JpgfnGrhfys5gOWrHYFqrCZMdw6LwmbLXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VP1CXafCn3hA6flqjJtMUwJRkClsB8thTcj8yUrg+VI2pUSrlJ5KEoI/ZML0IBL9+ALgGYrv7UVmyUV6V8aCXujc06VvFYkF643rQfus8iexqTF3pBubztMrUJMcoo2HL9JzsdNgVeD6uSYVF1Gmko4Et037b3zNGlVcpEZcScs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t6qRFGpN; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Feb 2024 23:07:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709017680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LPLqxZBWlu+avdMKPH1o/8nV2jfbJWdh4RS5gf3tDfw=;
	b=t6qRFGpNTM6C2DPPOJQwPcC4rjR9I/gJr4xWRyhUVIpcp505iBo/6wLCnpWkefLbuY9jtO
	8pkfqhLTG11PvWfgGVsgwNrYaLX4D3A+IaPI2PP/Bj2uFX2LdSPEJazDn/HZIxLTgOvIQ4
	oRFiiQqEQ71JFmL+IO3dnFJYTnOKhqk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: arm64: Reuse struct cpu_fp_state to track the
 guest FP state
Message-ID: <Zd2KS3sVI-vPxurg@linux.dev>
References: <20240226-kvm-arm64-group-fp-data-v1-0-07d13759517e@kernel.org>
 <20240226-kvm-arm64-group-fp-data-v1-2-07d13759517e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-kvm-arm64-group-fp-data-v1-2-07d13759517e@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hey broonie,

On Mon, Feb 26, 2024 at 08:44:11PM +0000, Mark Brown wrote:
> At present we store the various bits of floating point state individually
> in struct kvm_vpcu_arch and construct a struct cpu_fp_state to share with

typo: kvm_vcpu_arch

> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index a2cba18effb2..84cc0dbd9b14 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -379,6 +379,18 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  	 */
>  	vcpu->arch.fp_owner = FP_STATE_FREE;
>  
> +	/*
> +	 * Initial setup for FP state for sharing with host, if SVE is
> +	 * enabled additional configuration will be done.
> +	 *
> +	 * Currently we do not support SME guests so SVCR is always 0
> +	 * and we just need a variable to point to.
> +	 */
> +	vcpu->arch.fp_state.st = &vcpu->arch.ctxt.fp_regs;
> +	vcpu->arch.fp_state.fp_type = &vcpu->arch.fp_type;
> +	vcpu->arch.fp_state.svcr = &vcpu->arch.svcr;
> +	vcpu->arch.fp_state.to_save = FP_STATE_FPSIMD;
> +

I'm not too big of a fan of scattering the initialization in various
places... Why can't we have a unified helper for priming cpu_fp_state once
we know what we're dealing with?

That can be called from either kvm_setup_vcpu() or kvm_vcpu_finalize_sve()
depending on whether userspace signed up for SVE or not.

>  	/* Set up the timer */
>  	kvm_timer_vcpu_init(vcpu);
>  
> diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> index 8dbd62d1e677..45fe4a942992 100644
> --- a/arch/arm64/kvm/fpsimd.c
> +++ b/arch/arm64/kvm/fpsimd.c
> @@ -143,24 +143,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
>  	WARN_ON_ONCE(!irqs_disabled());
>  
>  	if (vcpu->arch.fp_owner == FP_STATE_GUEST_OWNED) {
> -
> -		/*
> -		 * Currently we do not support SME guests so SVCR is
> -		 * always 0 and we just need a variable to point to.
> -		 */
> -		fp_state.st = &vcpu->arch.ctxt.fp_regs;
> -		fp_state.sve_state = vcpu->arch.sve_state;
> -		fp_state.sve_vl = vcpu->arch.sve_max_vl;
> -		fp_state.sme_state = NULL;
> -		fp_state.svcr = &vcpu->arch.svcr;
> -		fp_state.fp_type = &vcpu->arch.fp_type;
> -
> -		if (vcpu_has_sve(vcpu))
> -			fp_state.to_save = FP_STATE_SVE;
> -		else
> -			fp_state.to_save = FP_STATE_FPSIMD;
> -
> -		fpsimd_bind_state_to_cpu(&fp_state);
> +		fpsimd_bind_state_to_cpu(&vcpu->arch.fp_state);

Shouldn't we get rid of the fp_state local at this point? I'm pretty
sure a compiler would emit a warning here...

-- 
Thanks,
Oliver

