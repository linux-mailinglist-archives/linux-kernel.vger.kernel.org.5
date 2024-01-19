Return-Path: <linux-kernel+bounces-31360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05214832D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26861B24788
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4251DFCE;
	Fri, 19 Jan 2024 16:31:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2C51E4B7;
	Fri, 19 Jan 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705681882; cv=none; b=E3F2Oo1gM6hO+Jc6n3bW5a+F03mi3BE537ZUUn4IN0TqmhnEqybaL/zKzk8naXAA73e6nuPDungYJTJa3cjY3OVKaThgT1ol0wrIPLXrSh3YsbibNvruXQVIBY2L/vXQ2DhOZJ9Yzj4d082cf0wvwt87pKLuIwlYzG7dJSosZIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705681882; c=relaxed/simple;
	bh=lRwabzVftGLpsi+k+i2VzLkFu7Spmkw28FM5/97rVFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmR40jUEgFgCtJHB9+0qTDi3GFBFE2a7JRF0y1/oaf8+y7bxJuSKO2UwX3/iNkCT/tk+Vgr0tmWBdcZDuHBA+QyE19Q7L6lT/5/1YahMdb9GjQE/LM2wgrcpAEf6mS5TSO/CbK/U6YS6igxNpmq4nVD2yjO1dRTuyBI+4GJHOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD3F51042;
	Fri, 19 Jan 2024 08:32:03 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78F583F73F;
	Fri, 19 Jan 2024 08:31:16 -0800 (PST)
Date: Fri, 19 Jan 2024 16:31:13 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] arm64/signal: Don't assume that TIF_SVE means we saved
 SVE state
Message-ID: <Zaqj0V82LD8wu6g+@e133380.arm.com>
References: <20240119-arm64-sve-signal-regs-v1-1-b9fd61b0289a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119-arm64-sve-signal-regs-v1-1-b9fd61b0289a@kernel.org>

On Fri, Jan 19, 2024 at 12:29:13PM +0000, Mark Brown wrote:
> When we are in a syscall we will only save the FPSIMD subset even though
> the task still has access to the full register set, and on context switch

(Pedantic nit: "A even if B" (= "A applies even in that subset of cases
where B"), instead of "A even though B" (= "A applies notwithstanding
that it is always the case that B") (?)  If the SVE trapping were
ripped out altogether, it would be a different and rather simpler
story...)

> we will only remove TIF_SVE when loading the register state. This means
> that the signal handling code should not assume that TIF_SVE means that
> the register state is stored in SVE format, it should instead check the
> format that was recorded during save.
> 
> Fixes: 8c845e273104 ("arm64/sve: Leave SVE enabled on syscall if we don't context switch")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc:  <stable@vger.kernel.org>
> ---
>  arch/arm64/kernel/fpsimd.c | 2 +-
>  arch/arm64/kernel/signal.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 1559c706d32d..80133c190136 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1626,7 +1626,7 @@ void fpsimd_preserve_current_state(void)
>  void fpsimd_signal_preserve_current_state(void)
>  {
>  	fpsimd_preserve_current_state();
> -	if (test_thread_flag(TIF_SVE))
> +	if (current->thread.fp_type == FP_STATE_SVE)
>  		sve_to_fpsimd(current);
>  }
>  
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 0e8beb3349ea..425b1bc17a3f 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -242,7 +242,7 @@ static int preserve_sve_context(struct sve_context __user *ctx)
>  		vl = task_get_sme_vl(current);
>  		vq = sve_vq_from_vl(vl);
>  		flags |= SVE_SIG_FLAG_SM;
> -	} else if (test_thread_flag(TIF_SVE)) {
> +	} else if (current->thread.fp_type == FP_STATE_SVE) {
>  		vq = sve_vq_from_vl(vl);
>  	}
>  
> @@ -878,7 +878,7 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
>  	if (system_supports_sve() || system_supports_sme()) {
>  		unsigned int vq = 0;
>  
> -		if (add_all || test_thread_flag(TIF_SVE) ||
> +		if (add_all || current->thread.fp_type == FP_STATE_SVE ||
>  		    thread_sm_enabled(&current->thread)) {
>  			int vl = max(sve_max_vl(), sme_max_vl());
>  
> 
> ---
> base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> change-id: 20240118-arm64-sve-signal-regs-5711e0d10425
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 

[...]

If the historical meanings of TIF_SVE have been split up (which seems a
good idea), does that resolve all of the "bare"
test_thread_flag(TIF_SVE) that were still there?

If there are any others remaining, they may need looking at if there is
any question over what condition they are trying to test for...

Cheers
---Dave

