Return-Path: <linux-kernel+bounces-44551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7657884241D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31250284AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E6D679F0;
	Tue, 30 Jan 2024 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU/5/7L5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41B46773C;
	Tue, 30 Jan 2024 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615473; cv=none; b=n27x13tc7+wGm5lS11v5pcQh1Vs1INAlea0pbsf34gOw6Tp+r1L/Q8ErfNMAKJOYVOKQbQaAmQDjN+znnzZkq3FewEQJ0Tyd2NraOvUwDDco5nI055vGOpDy5+533CdjHiWstwwEbka60TB+fvT0wgtBdCvQ009ZuYuw+Bk6Ivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615473; c=relaxed/simple;
	bh=GzyZ6i9wOU8mgt3dmogPm1nmvgCFBIMDOc3j03O/1Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRZNIMdCRqpLmwbxygbEVAIIIK/7+l2949z9C+WT0z54LpBEPt740iaV1Op0gD1xTrYP/m82T8xrR1sAKkNMEcAiAVFMRxhFWh95XjS/eJVAtKvfJi84vjyx45iYJ1ul6/HAmWZi93J8IlndykCJ1IixrcxOlPdmBcqZeF0IQL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU/5/7L5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4DCC433F1;
	Tue, 30 Jan 2024 11:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706615472;
	bh=GzyZ6i9wOU8mgt3dmogPm1nmvgCFBIMDOc3j03O/1Fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bU/5/7L5ypIxbzkvi0inJ1C5X4qPFJfwKdrZzUOJji+S1+afxqmJzhU4alZpNhViW
	 FcA5tW2WIhot2EU6cKqqW+U/rTk4XWia54IOfaTJXPgendq7QPWuAV4i9fBee3vwJ8
	 VjE2oW6jtOXTklX7ZHhERJb1NnVLqYM6kct0RlkNogydWacV0R9q1Ulirb6JmyJbGK
	 d3EBfIklvWgqtfTKbVNS320tT1QMzDfq/apJBsmTTUZz6mBC8wP24+LDCMtgvcUtrm
	 ChoGH0Ra9h/O3vYbakSoQM6jbj+MXLxQKmMK1so6JoXR1qy53kBwuZy8x+8duGQMeq
	 t3jaw7+3NrlkA==
Date: Tue, 30 Jan 2024 11:51:07 +0000
From: Will Deacon <will@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Dave Martin <dave.martin@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/signal: Don't assume that TIF_SVE means we saved
 SVE state
Message-ID: <20240130115107.GB13551@willie-the-truck>
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
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jan 19, 2024 at 12:29:13PM +0000, Mark Brown wrote:
> When we are in a syscall we will only save the FPSIMD subset even though
> the task still has access to the full register set, and on context switch
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

I don't think this hunk applies on -rc2 ^^.

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

I think this code is preemptible, so I'm struggling to understand what
happens if the fp_type changes under our feet as a result of a context
switch.

Will

