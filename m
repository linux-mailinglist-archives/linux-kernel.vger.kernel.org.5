Return-Path: <linux-kernel+bounces-67517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC52C856CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CD629005E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14B9136999;
	Thu, 15 Feb 2024 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ltWU3OnK"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646FA2595
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022008; cv=none; b=MqjWHIaBHBzxjn8VdUurXAuco9tvHqGVEcuqS3IUXE7MPabtbfV4dWahOsH7lj8/mC6Rf/Kz5we9JG7YsJcCMwiOkgO523000Cy8njen7U5n/hWeprxFCoaEXc4+Ge0ishH9R/ka56t7boUxz5pjn6KK5s1dP3vGIM5sKXjZWAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022008; c=relaxed/simple;
	bh=h7H4FBwDjtFZTfSMi65y7rCAC7HWqJMf/6EX7pmmTNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ol4epbY9vy3KPT8wea5az9ATQrgpzF0O5xXtnVBUlE2JFEh0mgun0oqyLUv1WRCAamnC9T2Hz6TVvSRi4w/3DsRU80rriGM0vNsnQcSFpeEj+/8NPJdTu2UT0yCFSyvcx0ZleohTvpT9vud74d6saqm42zIogacimBTQwB3uNeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ltWU3OnK; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4b7fc7642fcso431111e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708022005; x=1708626805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Cgjd8j0lGhuZAEPZiz3aSk342Nhzq+fv9nQyppW3Ak=;
        b=ltWU3OnKp4/3lUfq6gbTRBraf4nlO/dJ3zuK0NlTz4xkaBR9tb1WRSLg0yccEyxjby
         6j+lWkZrmghJ7PQcL6JXjy5pGoVRBQdhmLD5cujYHx6LYK2yE0gSojPIJ/R2Qa6MLZi6
         j2DRSww6Vm8EmMIrV3bU/756w9kH5FqmM1px2WhH7fGQAQuVI7wvDrv6FbBJWbbVzXJn
         CvAbCzNF5lQJ4PaGhTVmQS5j3R5gvIlY9uFCYdXB+2OeNlXZ9UabbjY1zu8hlYAMol8R
         AqZcyx00V5hTkkbyivnb3t/vHNXWpcRUmJw6gJq+Rd/hV0G9pWGoPoCQTxgw9BJ/0o3T
         leKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708022005; x=1708626805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Cgjd8j0lGhuZAEPZiz3aSk342Nhzq+fv9nQyppW3Ak=;
        b=YSfMEz+W7Z5N/t2zmT6C4tfecM0eLEzbG16LZSlrxolcxqqKrWmd6sGuyn+4YtU1w8
         ZdUk9DcHQcwdPUVKkcjBD22V9TW27iSoScw6+QKdSozGaUWjySgvnGmW83ypoS+jATvC
         Q/a1mdPiI2QCZsWo+opDOpQ/DJudY1hR2/xMyeCWBSkBLfgomnw37QLT0dbUWUSNzBLQ
         q+jjS91ncCybJBtUAQLhaKN8b9vN0xykSoCId9KtBfFeLv7N0eXMAoxIBNDsbc6Qsq9t
         3zbKPOI3gEm7oeSUJtrhZBihd8GAxUALBA3ClA/pc7I/B/GHi2/2JXD4mfTN0jaogI5M
         RwOA==
X-Forwarded-Encrypted: i=1; AJvYcCWY/B97QFVkcRv5Oe54xLUKNC8N8CooKsQRiK3FitfjGxqdsSWm1IqOoOm85Rbb92TkAI4PacsSRa85JWdDMjUtIINWCtTWYaYtfc1f
X-Gm-Message-State: AOJu0YwAKA+3yet7cTjR7vjvMfE/0QG3lq3lGlIkkP0znnIajUTmdaUB
	CoxIUjWEfcrBx1Evlt0LNfsrwMbcoevxFIuGyaC+lWpE/bBQg97a+PrGRUqkS3/lF4tIG5u6iMw
	pKbwOMMmxX5Oudtwg5fTuSzFia4Fiu4AD8ZKY
X-Google-Smtp-Source: AGHT+IFZ4HJEjg3Vz6yIN4Fq5nuDkARCsLfavxqSX51nzgIKhdpi/duElUIGLxNB4uANcUpSVO57gRQ5qWXvql+avEI=
X-Received: by 2002:a1f:4fc5:0:b0:4c0:1cc8:8821 with SMTP id
 d188-20020a1f4fc5000000b004c01cc88821mr2433933vkb.9.1708022003768; Thu, 15
 Feb 2024 10:33:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214194432.makes.837-kees@kernel.org> <20240214194605.602505-3-keescook@chromium.org>
In-Reply-To: <20240214194605.602505-3-keescook@chromium.org>
From: Marco Elver <elver@google.com>
Date: Thu, 15 Feb 2024 19:32:45 +0100
Message-ID: <CANpmjNOf-+YH2qZPMQuLT5TigY4u41E+uw1XeqRMT8mHqFTn1w@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] overflow: Introduce wrapping_assign_add() and wrapping_assign_sub()
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
	Eric Biggers <ebiggers@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 20:46, Kees Cook <keescook@chromium.org> wrote:
>
> This allows replacements of the idioms "var += offset" and "var -=
> offset" with the wrapping_assign_add() and wrapping_assign_sub() helpers
> respectively. They will avoid wrap-around sanitizer instrumentation.
>
> Add to the selftests to validate behavior and lack of side-effects.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Marco Elver <elver@google.com>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-hardening@vger.kernel.org
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
>                 __val;                                          \
>         })
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
> +#define wrapping_assign_add(var, offset)                               \
> +       ({                                                              \
> +               typeof(var) *__ptr = &(var);                            \
> +               *__ptr = wrapping_add(typeof(var), *__ptr, offset);     \
> +       })
> +
>  /**
>   * check_sub_overflow() - Calculate subtraction with overflow checking
>   * @a: minuend; value to subtract from
> @@ -111,6 +127,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>                 __val;                                          \
>         })
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
> +#define wrapping_assign_sub(var, offset)                               \
> +       ({                                                              \
> +               typeof(var) *__ptr = &(var);                            \
> +               *__ptr = wrapping_sub(typeof(var), *__ptr, offset);     \
> +       })
> +
>  /**
>   * check_mul_overflow() - Calculate multiplication with overflow checking
>   * @a: first factor
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index d3fdb906d3fe..65e8a72a83bf 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
[...]
> +       /* wrapping_assign_{add,sub}() */                               \
> +       check_self_op(fmt, assign_add, +=, p->a, p->b);                 \
> +       check_self_op(fmt, assign_add, +=, p->b, p->a);                 \
> +       check_self_op(fmt, assign_sub, -=, p->a, p->b);                 \
>  }                                                                      \

Merely a curiosity, and am not suggesting this for this patch: I
wonder how much of this could be tested at compile-time. These are
very primitive operations, so I suspect the compiler could either
check these in a static_assert(), or if some of it isn't
constexpr-friendly, after optimizations with a BUILD_BUG.

