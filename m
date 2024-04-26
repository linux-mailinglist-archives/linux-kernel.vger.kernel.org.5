Return-Path: <linux-kernel+bounces-160507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7772B8B3E61
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F5B1B22BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6E115B99D;
	Fri, 26 Apr 2024 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3MiS9GB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8311C145B0F;
	Fri, 26 Apr 2024 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714153120; cv=none; b=QNdbrQ0TJKQkpTb2y1JSKp8GKW6duRZB/o8pBmvJVp/A/tLl8Q6VQInG5B53CMiSML+4m5fyUhIWdVxnb5wO6FshD0vTr1j8M0jFIFYx70MAT2ANCjXYpmR1WKGp6lqDf1btkNR1lzCue9N5k3IZzMfS/YEY7q4CzawEyjZ5SjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714153120; c=relaxed/simple;
	bh=9dYAdp7FYAzvqo+YtXaejtQOOLyFel2BTjwOXrzYgIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQSibZ66ciQAilhFvuY7ufDmGH6N6grlNT4Szej1MdOeB1BVVzNqEo+XIU3yzG62FWt9IIqz4XQRvnJM9fvKsGLPcVwhLnMGid/1R4CUgcNsUdinBjrr+odtAQzTSyxZn8XBXlg1Zl3cvaLAzuk6J2+moRyG6BfZjQSr0nnmBQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3MiS9GB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFB6C113CD;
	Fri, 26 Apr 2024 17:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714153120;
	bh=9dYAdp7FYAzvqo+YtXaejtQOOLyFel2BTjwOXrzYgIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3MiS9GBcE02pQF/hUdEhcY8Jrd3HjPDJRoRZYM6P24EiFsuIAlMOpyye+SRee4Ww
	 mSziF0M5DhgCyyzXRVUSVPAWnWpelqzXho4mmPWelGSkT3dDNGSNo9/UW9P8/KASl6
	 jpnXzHmxxWNMqFobWEa51GqcyCOVyiT4dGpw1fqVEyDGn+HFeTylDNX03aodoKyjga
	 YHetRVFCnjAPx5TnX2qspH6JwukVUsje2SucvO/9eh499tT5uwfdz49o5oXuBufQVI
	 V/O9+R7BBMX7iBbT0AizMdVQUG+/85y0RrS2o2Zs59BXis/FYbD1SHXJPhFh3NdJkJ
	 EgF6ntP1Q3lhA==
Date: Fri, 26 Apr 2024 10:38:37 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Marco Elver <elver@google.com>, Erhard Furtner <erhard_f@mailbox.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ubsan: Avoid i386 UBSAN handler crashes with Clang
Message-ID: <20240426173837.GA2744190@dev-arch.thelio-3990X>
References: <20240424224026.it.216-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424224026.it.216-kees@kernel.org>

On Wed, Apr 24, 2024 at 03:40:29PM -0700, Kees Cook wrote:
> When generating Runtime Calls, Clang doesn't respect the -mregparm=3
> option used on i386. Hopefully this will be fixed correctly in Clang 19:
> https://github.com/llvm/llvm-project/pull/89707
> but we need to fix this for earlier Clang versions today. Force the
> calling convention to use non-register arguments.
> 
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Closes: https://github.com/KSPP/linux/issues/350
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: llvm@lists.linux.dev
> Cc: kasan-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
>  v2:
>    - use email address in Reported-by
>    - link to upstream llvm bug in ubsan.h comment
>    - drop needless /**/
>    - explicitly test Clang version
>  v1: https://lore.kernel.org/lkml/20240424162942.work.341-kees@kernel.org/
> ---
>  lib/ubsan.h | 41 +++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/lib/ubsan.h b/lib/ubsan.h
> index 50ef50811b7c..07e37d4429b4 100644
> --- a/lib/ubsan.h
> +++ b/lib/ubsan.h
> @@ -124,19 +124,32 @@ typedef s64 s_max;
>  typedef u64 u_max;
>  #endif
>  
> -void __ubsan_handle_add_overflow(void *data, void *lhs, void *rhs);
> -void __ubsan_handle_sub_overflow(void *data, void *lhs, void *rhs);
> -void __ubsan_handle_mul_overflow(void *data, void *lhs, void *rhs);
> -void __ubsan_handle_negate_overflow(void *_data, void *old_val);
> -void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs);
> -void __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr);
> -void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr);
> -void __ubsan_handle_out_of_bounds(void *_data, void *index);
> -void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs);
> -void __ubsan_handle_builtin_unreachable(void *_data);
> -void __ubsan_handle_load_invalid_value(void *_data, void *val);
> -void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
> -					 unsigned long align,
> -					 unsigned long offset);
> +/*
> + * When generating Runtime Calls, Clang doesn't respect the -mregparm=3
> + * option used on i386: https://github.com/llvm/llvm-project/issues/89670
> + * Fix this for earlier Clang versions by forcing the calling convention
> + * to use non-register arguments.
> + */
> +#if defined(CONFIG_X86_32) && \
> +    defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 190000
> +# define ubsan_linkage asmlinkage
> +#else
> +# define ubsan_linkage
> +#endif
> +
> +void ubsan_linkage __ubsan_handle_add_overflow(void *data, void *lhs, void *rhs);
> +void ubsan_linkage __ubsan_handle_sub_overflow(void *data, void *lhs, void *rhs);
> +void ubsan_linkage __ubsan_handle_mul_overflow(void *data, void *lhs, void *rhs);
> +void ubsan_linkage __ubsan_handle_negate_overflow(void *_data, void *old_val);
> +void ubsan_linkage __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs);
> +void ubsan_linkage __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr);
> +void ubsan_linkage __ubsan_handle_type_mismatch_v1(void *_data, void *ptr);
> +void ubsan_linkage __ubsan_handle_out_of_bounds(void *_data, void *index);
> +void ubsan_linkage __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs);
> +void ubsan_linkage __ubsan_handle_builtin_unreachable(void *_data);
> +void ubsan_linkage __ubsan_handle_load_invalid_value(void *_data, void *val);
> +void ubsan_linkage __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
> +						       unsigned long align,
> +						       unsigned long offset);
>  
>  #endif
> -- 
> 2.34.1
> 

