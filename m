Return-Path: <linux-kernel+bounces-157608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032B68B1385
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1171F230CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CEF7604F;
	Wed, 24 Apr 2024 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/TlF1tj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8A47443E;
	Wed, 24 Apr 2024 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986815; cv=none; b=Axj5Q/S/wRQ7rnBBDgb+HOav42hozE9v4zBb3q5i4WqJoq/BVT88VtLH62ycMrlVJfw3kucfXSdmmPM0tSaV46CM6y6iKWvrEU7K6AvxVLT6PU5g93zLovM53Mjp07Hg33A5FIGh2TQUXAswlk+flq+rXb/80LUgDN1I7/1AY5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986815; c=relaxed/simple;
	bh=EW8udX9Ng9evM5jbTXaEGg0ld8CqmmVMrgh5R0QINjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7RBr8eDBpCY6OeuLp9VgPpqlr/9FMmjdh8dkxEASAbGZ3FwDgC4zXuSr3SgXgFAgnljYT2q/mF37K4xbwgUo+lyMICxrWS58FcSACmaR92DKNModzX5IoEzH+hLxFhsxVYMU4ZYd4pnl2p0+CKzfxcL/Q+OyUhvFJ6/64sOqFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/TlF1tj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341AAC113CD;
	Wed, 24 Apr 2024 19:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713986814;
	bh=EW8udX9Ng9evM5jbTXaEGg0ld8CqmmVMrgh5R0QINjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/TlF1tjeeucQdZZnUWu3Lt2Nqw/ehtB4X//jzu2ZN+FoZcb/OH8mdbYs32TLDFMJ
	 5f8xqSWt0SA4hJK90XI0dQX4nLt4evSE33DtPvlF9ZOXr9lqXTJ3ihERkaPuhq54Lg
	 mat6KQL3EF+Z6ItGqyXQap0LglfWLsTVnNSi2gnjOr/OGw9l6TwcVLMXF9HU7Mmjtc
	 ZnI29A4BZnpebvp9W6mVMCE3a7uexoD0NrMiQt8zA3siuDGM2x9jy03Xx7/p9ZmiCC
	 vf0FDIv6t9cAhUdSeFZO3H9sG3w9ZsOpYTi/V1hx0I/B3nsem3v1fdnD5KAo+N8CwA
	 PLmnDqsGv4vSw==
Date: Wed, 24 Apr 2024 12:26:52 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubsan: Avoid i386 UBSAN handler crashes with Clang
Message-ID: <20240424192652.GA3341665@dev-arch.thelio-3990X>
References: <20240424162942.work.341-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424162942.work.341-kees@kernel.org>

Hi Kees,

On Wed, Apr 24, 2024 at 09:29:43AM -0700, Kees Cook wrote:
> When generating Runtime Calls, Clang doesn't respect the -mregparm=3
> option used on i386. Hopefully this will be fixed correctly in Clang 19:
> https://github.com/llvm/llvm-project/pull/89707
> but we need to fix this for earlier Clang versions today. Force the
> calling convention to use non-register arguments.
> 
> Reported-by: ernsteiswuerfel

FWIW, I think this can be

  Reported-by: Erhard Furtner <erhard_f@mailbox.org>

since it has been used in the kernel before, the reporter is well known
:)

> Closes: https://github.com/KSPP/linux/issues/350
> Signed-off-by: Kees Cook <keescook@chromium.org>
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
> ---
>  lib/ubsan.h | 41 +++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/lib/ubsan.h b/lib/ubsan.h
> index 50ef50811b7c..978828f6099d 100644
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
> + * option used on i386. Hopefully this will be fixed correctly in Clang 19:
> + * https://github.com/llvm/llvm-project/pull/89707
> + * but we need to fix this for earlier Clang versions today. Force the

It may be better to link to the tracking issue upstream instead of the
pull request just in case someone comes up with an alternative fix (not
that I think your change is wrong or anything but it seems like that
happens every so often).

I also get leary of the version information in the comment, even though
I don't doubt this will be fixed in clang 19.

> + * calling convention to use non-register arguments.
> + */
> +#if defined(__clang__) && defined(CONFIG_X86_32)

While __clang__ is what causes CONFIG_CC_IS_CLANG to get set and there
is some existing use of it throughout the kernel, I think
CONFIG_CC_IS_CLANG makes it easier to audit the workarounds that we
have, plus this will be presumably covered to

  CONFIG_CLANG_VERSION < 190000

when the fix actually lands. This file is not expected to be used
outside of the kernel, right? That is the only thing I could think of
where this distinction would actually matter.

> +# define ubsan_linkage asmlinkage

Heh, clever...

> +#else
> +# define ubsan_linkage /**/

Why is this defined as a comment rather than just nothing?

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
> 

