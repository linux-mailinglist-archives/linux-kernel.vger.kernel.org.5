Return-Path: <linux-kernel+bounces-145717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467CB8A59F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A415283646
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EA1154BE5;
	Mon, 15 Apr 2024 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kx9jaLbp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F546CDAD;
	Mon, 15 Apr 2024 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206097; cv=none; b=b6YAQ6C57U5KSY5j3gNr9NRXHLVpbqG4mzoOv+WTq9ke7w3xF/g0j6yBJDB2EsG6M/vga9m5Z7ikJ2b4yUSMQvXS/ykKUcZdDXz0qiNySzWKnU8lZ9N8rTDcHLF0Wfc6iGsYdadZ0DBahcQwr8LZVpf8z9X+hrTd1+F+g7igtZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206097; c=relaxed/simple;
	bh=YZH/atVIAYwOgZAv0EyU2gQHng+Fq0POPGoznJw55LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rC/tdCfHjYfM9LOBrYvNa/TXQ4OsM0i6FJRKwE+yA9jYcBkKhD7n+ud8ddp5shPTQzKKDrDsvkQX967mtN9BuWsde8B0Ru1mqJ08Wm1q3eRdo+McSXlk5k5z7+qAshshD/8fjpUyZzDaWhxBXr++Wafmy1LK6oGQTvGsvgHJE+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kx9jaLbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BBEC113CC;
	Mon, 15 Apr 2024 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713206097;
	bh=YZH/atVIAYwOgZAv0EyU2gQHng+Fq0POPGoznJw55LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kx9jaLbpgTmXlDRddFpH5Cqez/VbrskyTYinmQ6kzQl1Yt1UbPLMYCtAYmNiu6+OK
	 fvtEd3RpFM2tua6vm7bMbwnoUSYuxJq51uEvllGSUuXbX47VtFbjJAUPRuIiHwI6E1
	 g+hcntAT6c5nHMJEcy0Y40tmKSa8wN748M5SwIiplQjTgeGtSRc1wDMiLnfQDlrSGX
	 3NlTZVUSUt/pExK17d1NgtsZGLN+szbIXsxc+f8QkfsM2IukKblooLx6OedYnW1jrZ
	 ghDjnaN9donwfKk7UGkeEo7MGg8lkLWHSvcUDvRGGwfSEo4QzcyQvkHdFdggDo4MSq
	 /AxJtyAJP8gWw==
Date: Mon, 15 Apr 2024 11:34:54 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Marco Elver <elver@google.com>, Justin Stitt <justinstitt@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] ubsan: Add awareness of signed integer overflow traps
Message-ID: <20240415183454.GB1011455@dev-arch.thelio-3990X>
References: <20240415182832.work.932-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415182832.work.932-kees@kernel.org>

On Mon, Apr 15, 2024 at 11:28:35AM -0700, Kees Cook wrote:
> On arm64, UBSAN traps can be decoded from the trap instruction. Add the
> add, sub, and mul overflow trap codes now that CONFIG_UBSAN_SIGNED_WRAP
> exists. Seen under clang 19:
> 
>   Internal error: UBSAN: unrecognized failure code: 00000000f2005515 [#1] PREEMPT SMP
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/lkml/20240411-fix-ubsan-in-hardening-config-v1-0-e0177c80ffaa@kernel.org
> Fixes: 557f8c582a9b ("ubsan: Reintroduce signed overflow sanitizer")
> Signed-off-by: Kees Cook <keescook@chromium.org>

As I mentioned, CONFIG_UBSAN_SIGNED_INTEGER_WRAP needs to be
CONFIG_UBSAN_SIGNED_WRAP. I applied this change with that fix up and the
warning now becomes:

  Internal error: UBSAN: integer subtraction overflow: 00000000f2005515 [#1] PREEMPT SMP

So:

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Cc: Marco Elver <elver@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> ---
>  lib/ubsan.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index 5fc107f61934..ad32beb8c058 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -44,9 +44,10 @@ const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
>  	case ubsan_shift_out_of_bounds:
>  		return "UBSAN: shift out of bounds";
>  #endif
> -#ifdef CONFIG_UBSAN_DIV_ZERO
> +#if defined(CONFIG_UBSAN_DIV_ZERO) || defined(CONFIG_UBSAN_SIGNED_INTEGER_WRAP)
>  	/*
> -	 * SanitizerKind::IntegerDivideByZero emits
> +	 * SanitizerKind::IntegerDivideByZero and
> +	 * SanitizerKind::SignedIntegerOverflow emit
>  	 * SanitizerHandler::DivremOverflow.
>  	 */
>  	case ubsan_divrem_overflow:
> @@ -77,6 +78,19 @@ const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
>  		return "UBSAN: alignment assumption";
>  	case ubsan_type_mismatch:
>  		return "UBSAN: type mismatch";
> +#endif
> +#ifdef CONFIG_UBSAN_SIGNED_INTEGER_WRAP
> +	/*
> +	 * SanitizerKind::SignedIntegerOverflow emits
> +	 * SanitizerHandler::AddOverflow, SanitizerHandler::SubOverflow,
> +	 * or SanitizerHandler::MulOverflow.
> +	 */
> +	case ubsan_add_overflow:
> +		return "UBSAN: integer addition overflow";
> +	case ubsan_sub_overflow:
> +		return "UBSAN: integer subtraction overflow";
> +	case ubsan_mul_overflow:
> +		return "UBSAN: integer multiplication overflow";
>  #endif
>  	default:
>  		return "UBSAN: unrecognized failure code";
> -- 
> 2.34.1
> 

