Return-Path: <linux-kernel+bounces-44433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF79842201
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BF41C2414E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E19B67739;
	Tue, 30 Jan 2024 10:53:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EE966B5E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612031; cv=none; b=RXL7Ms3bqVRK7mvY2suCKlOhhhsyvMQ/iUwV8vng5eyMTCGHQMV3wCFcH0ysc5omuBpLvh2GD75iFOLIyfgPw0lsAMjSNOz2LCtWDhGb3XlvL/41pjWxeAq+Fogd0M2oreO7gK4LNJVWY8EGHi0MjMtvUKax82pNNVZD4zZJxXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612031; c=relaxed/simple;
	bh=27i4nhu6i7bsFSvL1ft0VlIA72pCvvaWCV4D95pnWvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwqoUK9ddOgjNV0sd+VdQbj04iFw/Wv6ahrdCDK+MU53Vobbq2aVBCnpTU9OGrrbw7Mi/G/82bBwNXVpgZN71EgSmtLB95m6KE2eDmk6L09vqE23tX2euhgveH0UWCB5TquBIbHh71MG60A9MBBk1FCPY2G/BWjMbl6TozwXuxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D35BDA7;
	Tue, 30 Jan 2024 02:54:32 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 089473F5A1;
	Tue, 30 Jan 2024 02:53:47 -0800 (PST)
Date: Tue, 30 Jan 2024 10:53:42 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64/sme: Restore SMCR on exit from suspend
Message-ID: <ZbjVNggOxxoQXitV@e133380.arm.com>
References: <20240130-arm64-sme-resume-v1-0-0e60ebba18df@kernel.org>
 <20240130-arm64-sme-resume-v1-1-0e60ebba18df@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-arm64-sme-resume-v1-1-0e60ebba18df@kernel.org>

On Tue, Jan 30, 2024 at 12:02:48AM +0000, Mark Brown wrote:
> The fields in SMCR_EL1 reset to an architecturally UNKNOWN value. Since we
> do not otherwise manage the traps configured in this register at runtime we
> need to reconfigure them after a suspend in case nothing else was kind
> enough to preserve them for us.

Are any other regs affected?  

What about SMPRI_EL1?  That seems to be initialised once and for all in
cpufeatures, so I'd guess it might be affected.

Also, what about the _EL2 regs if the kernel is resuming at EL2
(without VHE -- or if SME && !VHE not a thing?)


> The vector length will be restored as part of restoring the SME state for
> the next SME using task.
> 
> Fixes: a1f4ccd25cc2 (arm64/sme: Provide Kconfig for SME)
> Reported-by: Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/fpsimd.h |  2 ++
>  arch/arm64/kernel/fpsimd.c      | 13 +++++++++++++
>  arch/arm64/kernel/suspend.c     |  3 +++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index 50e5f25d3024..7780d343ef08 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -386,6 +386,7 @@ extern void sme_alloc(struct task_struct *task, bool flush);
>  extern unsigned int sme_get_vl(void);
>  extern int sme_set_current_vl(unsigned long arg);
>  extern int sme_get_current_vl(void);
> +extern void sme_suspend_exit(void);
>  
>  /*
>   * Return how many bytes of memory are required to store the full SME
> @@ -421,6 +422,7 @@ static inline int sme_max_vl(void) { return 0; }
>  static inline int sme_max_virtualisable_vl(void) { return 0; }
>  static inline int sme_set_current_vl(unsigned long arg) { return -EINVAL; }
>  static inline int sme_get_current_vl(void) { return -EINVAL; }
> +static inline void sme_suspend_exit(void) { }
>  
>  static inline size_t sme_state_size(struct task_struct const *task)
>  {
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index a5dc6f764195..69201208bb13 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1311,6 +1311,19 @@ void __init sme_setup(void)
>  		get_sme_default_vl());
>  }
>  
> +void sme_suspend_exit(void)
> +{
> +	u64 smcr = 0;
> +
> +	if (!system_supports_sme())
> +		return;
> +
> +	if (system_supports_fa64())
> +		smcr |= SMCR_ELx_FA64;

This seems to silently duplicate logic present in cpufeatures.c.
Would it be cleaner to save/restore this register explicitly across
suspend, once cpufeatures has initialised it?

Or this could be factored somehow, but dumbly saving/restoring it is
probably simpler (?)

> +	write_sysreg_s(smcr, SYS_SMCR_EL1);

Is there an ISB or equivalent somewhere on this path?

Can we blow up when trying to restore SME state (e.g., ZT0) before we
enter userspace for the first time, if the firmware left the SME regs
inaccessible?

> +}
> +

[...]

Cheers
---Dave

