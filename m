Return-Path: <linux-kernel+bounces-56890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C792184D0E8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374B51F28618
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5FD129A78;
	Wed,  7 Feb 2024 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRxaaOxO"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E383A83CBE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329257; cv=none; b=XG99jpj/y24hLI9QOtPn6pUoDRMQAXS6Ss1BMTmobxz6Y3dCpFv3DG0sFeMEe6LF6CG5s3BSS7hy6g7JoSgT9Z8OFfMkcn49WnAVt+GZF3Ycl1BOr/4ZQdWUUJwoWLP07E4FM0eq+7ICiTZ9dVV6I/hJiYu2v1u9NLEwsM2b4m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329257; c=relaxed/simple;
	bh=u7Y5hwCXANmeUzrEMrdhHd6/7MdWaER9imC3jVr9EaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhExO6YFq1xpcJp6CiouZbpNZ//OAXXE8v67hZj0ZbPWGTHn6YIG6ueCYuaWsSOvSlBjP9UdwU1kpBePkIrXz/tREj//nke9jAh9aN73fiwU3dTMzKdn2bed4pgxmpJ2I7ZFBYtIbFMQniXvmh4X5j3pzL/rys1v/MtxKJ15l6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kRxaaOxO; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4c02af5c0b6so307750e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 10:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707329253; x=1707934053; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LVOYHlYDXobk/Y8KugAL3FuLhZWY4+w3iqY9MiF2FJs=;
        b=kRxaaOxOCWJaH9Jp0d/Eg7SLUsrMa2kc3uZAmByQ+R3PUDS4KNIO9SmsZLwFl0PadF
         98f5UbmrVtVEM/OX4kM5j9vm6H2QJaR7frddmlbhC3VHtf59gLAcM2wuoSCcRBaLs9xq
         pZSlomwEHvUENNBVkatCrhLBufeBqaXAF2U5N5XieiZX8mnoEx6fZpOmSyhrya47wdTQ
         vureIfT+6GNavkV6kXVQlDMAFldPDjFAFoXIzvdpenBoD3St9ashIYDGUrvjbAXRwen/
         x6K2171YR2egEps4etdhguYqOcXkEIXplro1YunXSFHto+TGmlMLn6Q4Wq8ZjSUIznh+
         9ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707329253; x=1707934053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVOYHlYDXobk/Y8KugAL3FuLhZWY4+w3iqY9MiF2FJs=;
        b=oXZ+iXvqSsVmn5SZX084FXSMkgfkL/dHHmkcHi0Ybb5KoIhbHlfgvIuMGNTaUEK60v
         nL4uE2Hj8ji0+f0wuU9YEdtGVia5W1HaDDsiTOuT7rPG+uPDlBlmWXu4ZqVMU3a/U9ix
         AjPfTM6dI/HMW/O0h1lbO7/KAL19vzM6D3DrA6etQhlJENPg32xKqAC1HEGN5pE6P6m1
         yfVqA950v9NqVsiwIyc2iPty0b01z+6Vu3vpoqO8mizZxjlctqRDci3k1tIN2ivld69T
         QovBiWOBJbPaz+TKkF2dDqpca3uZANarafFTOd9/y+j0zI5GVgZcBuHZRbmIpQB3wKCF
         HbEg==
X-Gm-Message-State: AOJu0YyuPBqppPgv8X7SoS24WyN4OQTFuYk/P4ZNF/g+VQ38Jil2gw9P
	abP+cP0VqdUBjmkvbD3QwgnudV3FGHaVaOsiZuWHbZimfbkzgoKT822lfM8oE0Kxk2I/z8H9cb/
	U/bZVPua4FjwsSpdI+PpbuL1egaw9Te4g/u/e
X-Google-Smtp-Source: AGHT+IHz+Did1YIVlgFZdIA9Q6NNbhm71ujzSU2yJhLyQepRz+bsAlyib5OqNWg5CK3Gb6A8dpBE4ExpwfNLpLV5pqY=
X-Received: by 2002:a05:6122:90f:b0:4c0:1918:27de with SMTP id
 j15-20020a056122090f00b004c0191827demr3588823vka.16.1707329253341; Wed, 07
 Feb 2024 10:07:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207152317.do.560-kees@kernel.org> <20240207152422.3855315-2-keescook@chromium.org>
In-Reply-To: <20240207152422.3855315-2-keescook@chromium.org>
From: Marco Elver <elver@google.com>
Date: Wed, 7 Feb 2024 19:06:57 +0100
Message-ID: <CANpmjNOQVfp_=DB1NjJz=+6DxgbjfYuK19nSs8fd+kZJR-VRmA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] overflow: Introduce wrapping_add(),
 wrapping_sub(), and wrapping_mul()
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
	Eric Biggers <ebiggers@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-hardening@vger.kernel.org, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 16:24, Kees Cook <keescook@chromium.org> wrote:
>
> Provide helpers that will perform wrapping addition, subtraction, or
> multiplication without tripping the arithmetic wrap-around sanitizers. The
> first argument is the type under which the wrap-around should happen
> with. In other words, these two calls will get very different results:
>
>         wrapping_mul(int, 50, 50) == 2500
>         wrapping_mul(u8,  50, 50) ==  196
>
> Add to the selftests to validate behavior and lack of side-effects.
>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Marco Elver <elver@google.com>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-hardening@vger.kernel.org
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Marco Elver <elver@google.com>

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
>  #define check_add_overflow(a, b, d)    \
>         __must_check_overflow(__builtin_add_overflow(a, b, d))
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
> +#define wrapping_add(type, a, b)                               \
> +       ({                                                      \
> +               type __val;                                     \
> +               __builtin_add_overflow(a, b, &__val);           \
> +               __val;                                          \
> +       })
> +
>  /**
>   * check_sub_overflow() - Calculate subtraction with overflow checking
>   * @a: minuend; value to subtract from
> @@ -77,6 +93,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  #define check_sub_overflow(a, b, d)    \
>         __must_check_overflow(__builtin_sub_overflow(a, b, d))
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
> +#define wrapping_sub(type, a, b)                               \
> +       ({                                                      \
> +               type __val;                                     \
> +               __builtin_sub_overflow(a, b, &__val);           \
> +               __val;                                          \
> +       })
> +
>  /**
>   * check_mul_overflow() - Calculate multiplication with overflow checking
>   * @a: first factor
> @@ -90,6 +122,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  #define check_mul_overflow(a, b, d)    \
>         __must_check_overflow(__builtin_mul_overflow(a, b, d))
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
> +#define wrapping_mul(type, a, b)                               \
> +       ({                                                      \
> +               type __val;                                     \
> +               __builtin_mul_overflow(a, b, &__val);           \
> +               __val;                                          \
> +       })
> +
>  /**
>   * check_shl_overflow() - Calculate a left-shifted value and check overflow
>   * @a: Value to be shifted
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index c527f6b75789..d3fdb906d3fe 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -258,20 +258,36 @@ DEFINE_TEST_ARRAY(s64) = {
>                                                                         \
>         _of = check_ ## op ## _overflow(a, b, &_r);                     \
>         KUNIT_EXPECT_EQ_MSG(test, _of, of,                              \
> -               "expected "fmt" "sym" "fmt" to%s overflow (type %s)\n", \
> +               "expected check "fmt" "sym" "fmt" to%s overflow (type %s)\n",   \
>                 a, b, of ? "" : " not", #t);                            \
>         KUNIT_EXPECT_EQ_MSG(test, _r, r,                                \
> -               "expected "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
> +               "expected check "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
>                 a, b, r, _r, #t);                                       \
>         /* Check for internal macro side-effects. */                    \
>         _of = check_ ## op ## _overflow(_a_orig++, _b_orig++, &_r);     \
> -       KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump, "Unexpected " #op " macro side-effect!\n"); \
> -       KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump, "Unexpected " #op " macro side-effect!\n"); \
> +       KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump,                     \
> +               "Unexpected check " #op " macro side-effect!\n");       \
> +       KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump,                     \
> +               "Unexpected check " #op " macro side-effect!\n");       \
> +                                                                       \
> +       _r = wrapping_ ## op(t, a, b);                                  \
> +       KUNIT_EXPECT_TRUE_MSG(test, _r == r,                            \
> +               "expected wrap "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
> +               a, b, r, _r, #t);                                       \
> +       /* Check for internal macro side-effects. */                    \
> +       _a_orig = a;                                                    \
> +       _b_orig = b;                                                    \
> +       _r = wrapping_ ## op(t, _a_orig++, _b_orig++);                  \
> +       KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump,                     \
> +               "Unexpected wrap " #op " macro side-effect!\n");        \
> +       KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump,                     \
> +               "Unexpected wrap " #op " macro side-effect!\n");        \
>  } while (0)
>
>  #define DEFINE_TEST_FUNC_TYPED(n, t, fmt)                              \
>  static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
>  {                                                                      \
> +       /* check_{add,sub,mul}_overflow() and wrapping_{add,sub,mul} */ \
>         check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);    \
>         check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);    \
>         check_one_op(t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);   \
> --
> 2.34.1
>

