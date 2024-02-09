Return-Path: <linux-kernel+bounces-59662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3822884FA09
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D0F1C29EFF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9111272AA;
	Fri,  9 Feb 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNmqN0I7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA545126F12
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497213; cv=none; b=MGRMvviCn/uU80U9V/Q4vJujoA4vq9AnEctlerJeOPFtFW7ujWaKkqTygz7Et30umXC5kyUisfWC51DI2t+NXtkT9wUh9xPKH1xm5P4ud2LMQfLH+FpbNIkvQ7aOSE9n+5Cq4Umiey+VI0FmEvxwqIp51wHkohxaPBvqzPy50x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497213; c=relaxed/simple;
	bh=ZDSnHoSn9j8iFecbqrhC6wjO40hzxWdBix4sKB+WfyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtid41lsbDV2ufK1ssvAXUmyJ9mNiR3mz4j4SyDbBgiYb8tO+pxrsHGYpnr8teisLNFrsLW/4vpWVWWgEAWgGDEAn2tmh9sKFMAplM2qi6R16zcau9aO7FmE02S14BTmR8zMm8NATHcsHw87NTcRfZkE7Rjq3TcV2AgslVqafc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNmqN0I7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E3DC433C7;
	Fri,  9 Feb 2024 16:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707497213;
	bh=ZDSnHoSn9j8iFecbqrhC6wjO40hzxWdBix4sKB+WfyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNmqN0I7GXcBf92PEgQT9mcgWWcnoGI1RyUVGjEmEcQMHglJAz84xS23XSTuiubj1
	 DS1JqV7nYvObNfehyrYohYW0HVBjXfegp0kR9SWTzeaRbaY2+/P0ySPUEqF3DjrW+A
	 neT8OALRnqklWmTESB/LqRlkrll3pmgWQLwtFTaEQk0CEAz+Hby61ctsfaEdipwnQ4
	 s+bi95xSILy7Nu4a5IvwlE3XJShTYwTWdTlxhcAdm8zF284KLZtOUMXMRGnRWk+34l
	 PpCRaBPaIHCEtgJE8xiaoCBlZhGNbt1Vszd4AUH0JnxJCF8GZEl6gfvxfzyyTXqXBo
	 zeN8t01FqUM7g==
Date: Fri, 9 Feb 2024 16:46:48 +0000
From: Will Deacon <will@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64/sme: Restore SMCR on exit from suspend
Message-ID: <20240209164648.GA24829@willie-the-truck>
References: <20240203-arm64-sme-resume-v2-0-a1fbaddc4425@kernel.org>
 <20240203-arm64-sme-resume-v2-1-a1fbaddc4425@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203-arm64-sme-resume-v2-1-a1fbaddc4425@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Feb 03, 2024 at 01:00:40PM +0000, Mark Brown wrote:
> The fields in SMCR_EL1 reset to an architecturally UNKNOWN value. Since we
> do not otherwise manage the traps configured in this register at runtime we
> need to reconfigure them after a suspend in case nothing else was kind
> enough to preserve them for us.
> 
> The vector length will be restored as part of restoring the SME state for
> the next SME using task.
> 
> Fixes: a1f4ccd25cc2 (arm64/sme: Provide Kconfig for SME)
> Reported-by: Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/fpsimd.h |  2 ++
>  arch/arm64/kernel/fpsimd.c      | 14 ++++++++++++++
>  arch/arm64/kernel/suspend.c     |  3 +++
>  3 files changed, 19 insertions(+)
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
> index a5dc6f764195..8d2a5824d5d3 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1311,6 +1311,20 @@ void __init sme_setup(void)
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
> +
> +	write_sysreg_s(smcr, SYS_SMCR_EL1);
> +	write_sysreg_s(0, SYS_SMPRI_EL1);
> +}

Looking at the other places where we touch SMCR_EL1, it looks like we
always use a read-modify-write sequence. However, doesn't that mean we
inherit a bunch of unknown bits on cold boot? I'm basically wondering
whether we should be initialising these registers to a well-known value
earlier in the CPU init path, a bit like we do for the EL2 variants.

Will

