Return-Path: <linux-kernel+bounces-65169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BF18548D3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC311F227AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C843D1AADF;
	Wed, 14 Feb 2024 11:58:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDDD1A58B;
	Wed, 14 Feb 2024 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707911923; cv=none; b=WUncYCfHg2R04binjPXiGoHUmZ4ISRrBrfXPvXoBUktKW6xZF8TDNAMzZ9toAyWSxG5n5DtWU9n/3TFFKWideH1yrwb9dnLZA7N/pN5QR3glOOmpeWYK6MVGBRR1eco2kwu3LGE8A2m6nFz/EFHOpqHg8jcVha5uhghblVQ7Gd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707911923; c=relaxed/simple;
	bh=VBdo7FmBsvmExzN2EusyOJyNOd8g7kFQT7CX30Alb/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKkrgiJ/XLP47KB5jVx1yrdw09EQ8lsceLdT6GsR/YQm88trTOS3UdkKMznzAvPngICcrdAIGGSqlAJyqvoS0zhO8b6AZrwxWh+q5HlwKle7GjwhaUlLDDt9UIn5pZe0uDnMHFZsPOMgcx74qelMbVS1uTxCL3hyyJ1fbXknYho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CF7A1FB;
	Wed, 14 Feb 2024 03:59:21 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.64.145])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C1C33F5A1;
	Wed, 14 Feb 2024 03:58:37 -0800 (PST)
Date: Wed, 14 Feb 2024 11:58:35 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
	linux-hardening@vger.kernel.org,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] overflow: Introduce wrapping_add(),
 wrapping_sub(), and wrapping_mul()
Message-ID: <Zcyq6_Eh6excL4RB@FVFF77S0Q05N>
References: <20240213220844.it.345-kees@kernel.org>
 <20240213221100.3556356-2-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213221100.3556356-2-keescook@chromium.org>

On Tue, Feb 13, 2024 at 02:10:58PM -0800, Kees Cook wrote:
> Provide helpers that will perform wrapping addition, subtraction, or
> multiplication without tripping the arithmetic wrap-around sanitizers. The
> first argument is the type under which the wrap-around should happen
> with. In other words, these two calls will get very different results:
> 
> 	wrapping_mul(int, 50, 50) == 2500
> 	wrapping_mul(u8,  50, 50) ==  196
> 
> Add to the selftests to validate behavior and lack of side-effects.
> 
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Marco Elver <elver@google.com>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-hardening@vger.kernel.org
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  include/linux/overflow.h | 48 ++++++++++++++++++++++++++++++++++++++++
>  lib/overflow_kunit.c     | 24 ++++++++++++++++----
>  2 files changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 4e741ebb8005..849a49fb496e 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -64,6 +64,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  #define check_add_overflow(a, b, d)	\
>  	__must_check_overflow(__builtin_add_overflow(a, b, d))
>  
> +/**
> + * wrapping_add() - Intentionally perform a wrapping addition
> + * @type: type for result of calculation
> + * @a: first addend
> + * @b: second addend
> + *
> + * Return the potentially wrapped-around addition without
> + * tripping any wrap-around sanitizers that may be enabled.
> + */
> +#define wrapping_add(type, a, b)				\
> +	({							\
> +		type __val;					\
> +		__builtin_add_overflow(a, b, &__val);		\
> +		__val;						\
> +	})
> +
>  /**
>   * check_sub_overflow() - Calculate subtraction with overflow checking
>   * @a: minuend; value to subtract from
> @@ -77,6 +93,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  #define check_sub_overflow(a, b, d)	\
>  	__must_check_overflow(__builtin_sub_overflow(a, b, d))
>  
> +/**
> + * wrapping_sub() - Intentionally perform a wrapping subtraction
> + * @type: type for result of calculation
> + * @a: minuend; value to subtract from
> + * @b: subtrahend; value to subtract from @a
> + *
> + * Return the potentially wrapped-around subtraction without
> + * tripping any wrap-around sanitizers that may be enabled.
> + */
> +#define wrapping_sub(type, a, b)				\
> +	({							\
> +		type __val;					\
> +		__builtin_sub_overflow(a, b, &__val);		\
> +		__val;						\
> +	})
> +
>  /**
>   * check_mul_overflow() - Calculate multiplication with overflow checking
>   * @a: first factor
> @@ -90,6 +122,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  #define check_mul_overflow(a, b, d)	\
>  	__must_check_overflow(__builtin_mul_overflow(a, b, d))
>  
> +/**
> + * wrapping_mul() - Intentionally perform a wrapping multiplication
> + * @type: type for result of calculation
> + * @a: first factor
> + * @b: second factor
> + *
> + * Return the potentially wrapped-around multiplication without
> + * tripping any wrap-around sanitizers that may be enabled.
> + */
> +#define wrapping_mul(type, a, b)				\
> +	({							\
> +		type __val;					\
> +		__builtin_mul_overflow(a, b, &__val);		\
> +		__val;						\
> +	})
> +
>  /**
>   * check_shl_overflow() - Calculate a left-shifted value and check overflow
>   * @a: Value to be shifted
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index c527f6b75789..d3fdb906d3fe 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -258,20 +258,36 @@ DEFINE_TEST_ARRAY(s64) = {
>  									\
>  	_of = check_ ## op ## _overflow(a, b, &_r);			\
>  	KUNIT_EXPECT_EQ_MSG(test, _of, of,				\
> -		"expected "fmt" "sym" "fmt" to%s overflow (type %s)\n",	\
> +		"expected check "fmt" "sym" "fmt" to%s overflow (type %s)\n",	\
>  		a, b, of ? "" : " not", #t);				\
>  	KUNIT_EXPECT_EQ_MSG(test, _r, r,				\
> -		"expected "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
> +		"expected check "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
>  		a, b, r, _r, #t);					\
>  	/* Check for internal macro side-effects. */			\
>  	_of = check_ ## op ## _overflow(_a_orig++, _b_orig++, &_r);	\
> -	KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump, "Unexpected " #op " macro side-effect!\n"); \
> -	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump, "Unexpected " #op " macro side-effect!\n"); \
> +	KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump,			\
> +		"Unexpected check " #op " macro side-effect!\n");	\
> +	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump,			\
> +		"Unexpected check " #op " macro side-effect!\n");	\
> +									\
> +	_r = wrapping_ ## op(t, a, b);					\
> +	KUNIT_EXPECT_TRUE_MSG(test, _r == r,				\
> +		"expected wrap "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
> +		a, b, r, _r, #t);					\
> +	/* Check for internal macro side-effects. */			\
> +	_a_orig = a;							\
> +	_b_orig = b;							\
> +	_r = wrapping_ ## op(t, _a_orig++, _b_orig++);			\
> +	KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump,			\
> +		"Unexpected wrap " #op " macro side-effect!\n");	\
> +	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump,			\
> +		"Unexpected wrap " #op " macro side-effect!\n");	\
>  } while (0)
>  
>  #define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
>  static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
>  {									\
> +	/* check_{add,sub,mul}_overflow() and wrapping_{add,sub,mul} */	\
>  	check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);	\
>  	check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);	\
>  	check_one_op(t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);	\
> -- 
> 2.34.1
> 

