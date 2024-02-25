Return-Path: <linux-kernel+bounces-80260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDBF862CAD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F7F1F210AF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 19:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E06C19BBA;
	Sun, 25 Feb 2024 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxOV0CVh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E36D134BD;
	Sun, 25 Feb 2024 19:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708890882; cv=none; b=MRRlna99Aa7G450BZA4mEe7iN062g/+mcxpOC4pTBuZP7Y6LoJhHWLSPC05vRRcCJ/b7SMStzvFoTb2A23vQPYUxk86DVOVYeAHRytKAtZ2TDRmO3JaYZBL61xYPQASmfWtAjiH4yYpxVEtoQpc1cJmlg8gq1pEUwGO1L1ieRJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708890882; c=relaxed/simple;
	bh=jf0UlHRKNCBdXsziVCahtzI/35nK15+b3hcYV4uM4/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQyX8HnIEkq/pFOQV/PcD6LaICvs1xr2X9/ptXgUyidWFvtosvTOAPwgDTHLbO2EmxVLhpoqsYf6KzA44sNGqtksMJiqDxO/nxxjjvB3DVupCGqFQgJizNyCFbwYKU38nNlOHVuGFDnHGU0a8lWoF69uu5QNcwskE3USzyInI8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxOV0CVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D496C433C7;
	Sun, 25 Feb 2024 19:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708890881;
	bh=jf0UlHRKNCBdXsziVCahtzI/35nK15+b3hcYV4uM4/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxOV0CVhGndDjFDCod/+PSyPMXk6964dD6uDEMkTCMW9uwD88Ct03Ec6947ToevlF
	 aZ5FSjf+i/vP+O0b7dC+7qLsZqNZzm8U0366rqWls7Dg4LLHN9BZRW6e7LHtWcYvdO
	 g0XsXgFr+MglFksGClgh2w81zeH2kos0BS6q49TQclnxnXqbpTDE+hEZe7ISN4Koez
	 dBr/rvCm2TJBJLaXze2k6QNXquspKKOaYaPvnGaiaEcbKLDotHo6hUyCJaTn8f0grX
	 vXMxIpeyxSvSw0qfdcwSmSNMp0g8csgzrptw1k6lXk9YLNr1hDmUG0iV/Mqw+y9xy5
	 Ec0kzN0UTTgBw==
Date: Sun, 25 Feb 2024 12:54:39 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Jason Ling <jasonling@chromium.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev
Subject: Re: [PATCH] arm64: ftrace: Don't forbid
 CALL_OPS+CC_OPTIMIZE_FOR_SIZE with Clang
Message-ID: <20240225195439.GA2972471@dev-arch.thelio-3990X>
References: <20240223064032.3463229-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223064032.3463229-1-swboyd@chromium.org>

On Thu, Feb 22, 2024 at 10:40:29PM -0800, Stephen Boyd wrote:
> Per commit b3f11af9b2ce ("arm64: ftrace: forbid CALL_OPS with
> CC_OPTIMIZE_FOR_SIZE"), GCC is silently ignoring `-falign-functions=N`
> when passed `-Os`, causing functions to be improperly aligned. This
> doesn't seem to be a problem with Clang though, where enabling CALL_OPS
> with CC_OPTIMIZE_FOR_SIZE doesn't spit out any warnings at boot about
> misaligned patch-sites. Only forbid CALL_OPS if GCC is used and we're
> optimizing for size so that CALL_OPS can be used with clang optimizing
> for size.
> 
> Cc: Jason Ling <jasonling@chromium.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: <llvm@lists.linux.dev>
> Fixes: b3f11af9b2ce ("arm64: ftrace: forbid CALL_OPS with CC_OPTIMIZE_FOR_SIZE")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Seems reasonable to me.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

I wonder if that GCC issue is resolved with '-fmin-function-alignment'
that is being introduced in GCC 14 [1]. If it is, I suspect this
conditional could actually be CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT
instead of CONFIG_CC_IS_CLANG, but that can obviously happen as a clean
up later down the road (more just food for thought for the arm64 folks,
not sure how much '-Os' is used in general)

[1]: https://git.kernel.org/masahiroy/linux-kbuild/c/5270316c9fec8cc99aa0e0a258509c5c7f789d12


> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index aa7c1d435139..6b96d75a3a3d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -198,7 +198,7 @@ config ARM64
>  		if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_OPS
>  	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
>  		if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG && \
> -		    !CC_OPTIMIZE_FOR_SIZE)
> +		    (CC_IS_CLANG || !CC_OPTIMIZE_FOR_SIZE))
>  	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
>  		if DYNAMIC_FTRACE_WITH_ARGS
>  	select HAVE_SAMPLE_FTRACE_DIRECT
> 
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> -- 
> https://chromeos.dev
> 

