Return-Path: <linux-kernel+bounces-71725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE5685A987
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A01286171
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5926446A5;
	Mon, 19 Feb 2024 17:03:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3BE446A1;
	Mon, 19 Feb 2024 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362204; cv=none; b=Hcu0m2nyow0DOCqikn6Xld+0IYMAzaWuUJWobbdYwSSg9ATyHrUu4IHnhXprsTme0aW3z7V1W4gidvZRuPJIERGrCvmsYZJidbRiz4XGkNT4qVRPGn4TaDbtT63cCtw9EhOtXUMNqvt9pmhn/YzhJOISC5L0KVKiFBUTziFbPAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362204; c=relaxed/simple;
	bh=MJvYvJVcGAJ+lPRgCUqoBB/EzpB7glN7S5T8DbEhTSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHALQbjDsld0kps5IzuuaPIz/58d3rsRqX0gPh0gb5ok/sz4jY/TV5cpsxTRru39IIPKxG8jCsoXW6QxAx00n0zckZnmyCaHY1dO3ZsCaUpBoq6iai5GvYDIsafGFDF0Zdt5G2bm7HdzDA8O4iJwxkMg7YEE/56qGERW32wncz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11670DA7;
	Mon, 19 Feb 2024 09:04:02 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.88])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4D963F7CE;
	Mon, 19 Feb 2024 09:03:20 -0800 (PST)
Date: Mon, 19 Feb 2024 17:03:18 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] overflow: Introduce wrapping_assign_add() and
 wrapping_assign_sub()
Message-ID: <ZdOJ1lEycqZsIpbJ@FVFF77S0Q05N>
References: <20240214194432.makes.837-kees@kernel.org>
 <20240214194605.602505-3-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214194605.602505-3-keescook@chromium.org>

On Wed, Feb 14, 2024 at 11:46:03AM -0800, Kees Cook wrote:
> This allows replacements of the idioms "var += offset" and "var -=
> offset" with the wrapping_assign_add() and wrapping_assign_sub() helpers
> respectively. They will avoid wrap-around sanitizer instrumentation.
> 
> Add to the selftests to validate behavior and lack of side-effects.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Marco Elver <elver@google.com>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-hardening@vger.kernel.org

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  include/linux/overflow.h | 32 ++++++++++++++++++++++++++++++
>  lib/overflow_kunit.c     | 43 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index d3ff8e2bec29..dede374832c9 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -81,6 +81,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  		__val;						\
>  	})
>  
> +/**
> + * wrapping_assign_add() - Intentionally perform a wrapping increment assignment
> + * @var: variable to be incremented
> + * @offset: amount to add
> + *
> + * Increments @var by @offset with wrap-around. Returns the resulting
> + * value of @var. Will not trip any wrap-around sanitizers.
> + *
> + * Returns the new value of @var.
> + */
> +#define wrapping_assign_add(var, offset)				\
> +	({								\
> +		typeof(var) *__ptr = &(var);				\
> +		*__ptr = wrapping_add(typeof(var), *__ptr, offset);	\
> +	})
> +
>  /**
>   * check_sub_overflow() - Calculate subtraction with overflow checking
>   * @a: minuend; value to subtract from
> @@ -111,6 +127,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  		__val;						\
>  	})
>  
> +/**
> + * wrapping_assign_sub() - Intentionally perform a wrapping decrement assign
> + * @var: variable to be decremented
> + * @offset: amount to subtract
> + *
> + * Decrements @var by @offset with wrap-around. Returns the resulting
> + * value of @var. Will not trip any wrap-around sanitizers.
> + *
> + * Returns the new value of @var.
> + */
> +#define wrapping_assign_sub(var, offset)				\
> +	({								\
> +		typeof(var) *__ptr = &(var);				\
> +		*__ptr = wrapping_sub(typeof(var), *__ptr, offset);	\
> +	})
> +
>  /**
>   * check_mul_overflow() - Calculate multiplication with overflow checking
>   * @a: first factor
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index d3fdb906d3fe..65e8a72a83bf 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -284,6 +284,45 @@ DEFINE_TEST_ARRAY(s64) = {
>  		"Unexpected wrap " #op " macro side-effect!\n");	\
>  } while (0)
>  
> +static int global_counter;
> +static void bump_counter(void)
> +{
> +	global_counter++;
> +}
> +
> +static int get_index(void)
> +{
> +	volatile int index = 0;
> +	bump_counter();
> +	return index;
> +}
> +
> +#define check_self_op(fmt, op, sym, a, b) do {				\
> +	typeof(a + 0) _a = a;						\
> +	typeof(b + 0) _b = b;						\
> +	typeof(a + 0) _a_sym = a;					\
> +	typeof(a + 0) _a_orig[1] = { a };				\
> +	typeof(b + 0) _b_orig = b;					\
> +	typeof(b + 0) _b_bump = b + 1;					\
> +	typeof(a + 0) _r;						\
> +									\
> +	_a_sym sym _b;							\
> +	_r = wrapping_ ## op(_a, _b);					\
> +	KUNIT_EXPECT_TRUE_MSG(test, _r == _a_sym,			\
> +		"expected "fmt" "#op" "fmt" == "fmt", got "fmt"\n",	\
> +		a, b, _a_sym, _r);					\
> +	KUNIT_EXPECT_TRUE_MSG(test, _a == _a_sym,			\
> +		"expected "fmt" "#op" "fmt" == "fmt", got "fmt"\n",	\
> +		a, b, _a_sym, _a);					\
> +	/* Check for internal macro side-effects. */			\
> +	global_counter = 0;						\
> +	wrapping_ ## op(_a_orig[get_index()], _b_orig++);		\
> +	KUNIT_EXPECT_EQ_MSG(test, global_counter, 1,			\
> +		"Unexpected wrapping_" #op " macro side-effect on arg1!\n"); \
> +	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump,			\
> +		"Unexpected wrapping_" #op " macro side-effect on arg2!\n"); \
> +} while (0)
> +
>  #define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
>  static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
>  {									\
> @@ -293,6 +332,10 @@ static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
>  	check_one_op(t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);	\
>  	check_one_op(t, fmt, mul, "*", p->a, p->b, p->prod, p->p_of);	\
>  	check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);	\
> +	/* wrapping_assign_{add,sub}() */				\
> +	check_self_op(fmt, assign_add, +=, p->a, p->b);			\
> +	check_self_op(fmt, assign_add, +=, p->b, p->a);			\
> +	check_self_op(fmt, assign_sub, -=, p->a, p->b);			\
>  }									\
>  									\
>  static void n ## _overflow_test(struct kunit *test) {			\
> -- 
> 2.34.1
> 

