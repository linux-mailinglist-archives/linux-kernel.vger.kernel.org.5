Return-Path: <linux-kernel+bounces-75462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B79485E90F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B761F24D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC5D86AEE;
	Wed, 21 Feb 2024 20:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxSob6Z5"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777F186AD5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547417; cv=none; b=tIDPZ3oxIZWZRvpsT9RVbeSa3MTU5K2Ft5OzV/nxFOHUQ7KsWs1umIGJ2MMZ6VkjeF8Hrtkr+BjpGAApvWgMvnWcGF5npaVzVSrOdvPkZDNJf7dqXj+ByTmR0StUUHrpVPMOiEaOv4hXHNFvGPjcJHQ86ZzHE7PHdCEo/E+ZjDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547417; c=relaxed/simple;
	bh=bOi+E2c42NJObr0z9FwqIGRycwQ0piUWsGffVcGcaYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gv6HxrnJfBuHZVLT+KEPysjrzhuG02E820kzVwrsLVcj2Ifs2UyBvJ2OSFx6DOEuzXJ0GzkeII6kkBMcPAq3pJKQuwcSG+gEI4RHgON0RiwqDuu1WtG3JM49RsrH4n8vgzXy+xpkQW6eTc7xaD/6PxvFoS9uh6s+AxgR9mjReOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hxSob6Z5; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6083dc087b3so36690137b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708547414; x=1709152214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=66B5lNp4yjRK1cO3QunmxwT8ngO+zkQK07F7H5Y6E9A=;
        b=hxSob6Z5MuOO2A387Yo9e0BU7zWvj2VF08QllRmOY6XRZ43bCGGBhOi3q88slCbxY4
         3jDSVVWUXap5XNCnAcpZ7ZlRdKcsfSIBgK926u7tj8Qh8cqjcjxCFC6b7CSUHe864tuB
         iEfYd2kMCJ/S6gwxQjFZnk3nvSh4+3rhuzVnJIzA4RPgu2nrYNaXtdoT8cC0kv6WRvgb
         2BVLHxoCnNGBsjMgfdqGLshKG3ScO1eUhk+j4WMbktO20CxmC6J3UJoIENsE2kwHyHzF
         3uleIBEcm/H/vXKprqZIDMU+91d1sHqMaVLqLg7aj0WtRdn6C1h1ms1RmTQR1Vbq8v3W
         LsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708547414; x=1709152214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66B5lNp4yjRK1cO3QunmxwT8ngO+zkQK07F7H5Y6E9A=;
        b=r6jA5hTW6quu5ofqf58WphdMA6Pr0ug6941OkBQrHRrW71FuDzAbf60+tM8KmrMDcf
         Gb8/ghlxdo6e/T7cZsIb29D9m0fBdKbRI60XJcSd/2y5UePDxltFqqy3VJSrWS/MHDep
         fH5MLDnTfQPC9HGzvPiTT4HGJrLXzO60jDfU5cMFPWMsNMPRwS7hwApHrGmuvf3LWNXB
         i+RBKsccMO7180zlfscp8Ir1hgp4lQcxnjqx6pz+iLK++d3zVdj8gfuT0RShJWMRIglN
         83jBeunv0CZgHnltVBQewVvlrrlhZ6X0VCWaClt4RoCERoRQD1iZjPzzZq/E62LT5y4b
         +MRA==
X-Forwarded-Encrypted: i=1; AJvYcCXmYtZW74M/ACoiHocL+LL+GIDg05AWeksZYGU03Mc6/VNAV55ZCx8T58Ur3b+537NWakm9zdECI3iBHTHVE/rRdKlNKYQCjwe4/5In
X-Gm-Message-State: AOJu0YwOo4p3vd4qfRLTGW1YzBx7lM1vXBSNNWSELJDuDt1sY2Xn0Hse
	Rr3DzyuxeXZCNciNYfxDSrq0dr+5KeLonGAJ3SfIUiezXJuSjmNGOJj3Of6zBQW2zLnzPSlog1k
	0ovwlRBuHPuH2YG/l0Hp++gKVCBIVQiBTC4oMGU6zRCcOI4tjyhs=
X-Google-Smtp-Source: AGHT+IEBJ9EDSOCDzcvz7VBrxp74vTA+LiZnGpzF2He2gzOhDMIin/sW0TGoX6jQApCBgxyOafwrV0IfLSI9PYFqSYU=
X-Received: by 2002:a0d:d88b:0:b0:604:92e1:14fd with SMTP id
 a133-20020a0dd88b000000b0060492e114fdmr17320806ywe.45.1708547414408; Wed, 21
 Feb 2024 12:30:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208074521.577076-1-lucas.demarchi@intel.com> <20240208074521.577076-2-lucas.demarchi@intel.com>
In-Reply-To: <20240208074521.577076-2-lucas.demarchi@intel.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 21 Feb 2024 22:30:02 +0200
Message-ID: <CAA8EJpprfrtOjNzT6TFhV1n6MXzLdTahanfxcRW4uVjeHaBduA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] bits: introduce fixed-type genmasks
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, intel-xe@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 09:45, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> From: Yury Norov <yury.norov@gmail.com>
>
> Generalize __GENMASK() to support different types, and implement
> fixed-types versions of GENMASK() based on it. The fixed-type version
> allows more strict checks to the min/max values accepted, which is
> useful for defining registers like implemented by i915 and xe drivers
> with their REG_GENMASK*() macros.
>
> The strict checks rely on shift-count-overflow compiler check to
> fail the build if a number outside of the range allowed is passed.
> Example:
>
>         #define FOO_MASK GENMASK_U32(33, 4)
>
> will generate a warning like:
>
>         ../include/linux/bits.h:41:31: error: left shift count >= width of type [-Werror=shift-count-overflow]
>            41 |          (((t)~0ULL - ((t)(1) << (l)) + 1) & \
>               |                               ^~
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  include/linux/bitops.h |  1 -
>  include/linux/bits.h   | 32 ++++++++++++++++++++++----------
>  2 files changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 2ba557e067fe..1db50c69cfdb 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -15,7 +15,6 @@
>  #  define aligned_byte_mask(n) (~0xffUL << (BITS_PER_LONG - 8 - 8*(n)))
>  #endif
>
> -#define BITS_PER_TYPE(type)    (sizeof(type) * BITS_PER_BYTE)
>  #define BITS_TO_LONGS(nr)      __KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
>  #define BITS_TO_U64(nr)                __KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
>  #define BITS_TO_U32(nr)                __KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 7c0cf5031abe..bd56f32de44e 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -6,6 +6,8 @@
>  #include <vdso/bits.h>
>  #include <asm/bitsperlong.h>
>
> +#define BITS_PER_TYPE(type)    (sizeof(type) * BITS_PER_BYTE)
> +
>  #define BIT_MASK(nr)           (UL(1) << ((nr) % BITS_PER_LONG))
>  #define BIT_WORD(nr)           ((nr) / BITS_PER_LONG)
>  #define BIT_ULL_MASK(nr)       (ULL(1) << ((nr) % BITS_PER_LONG_LONG))
> @@ -30,16 +32,26 @@
>  #define GENMASK_INPUT_CHECK(h, l) 0
>  #endif
>
> -#define __GENMASK(h, l) \
> -       (((~UL(0)) - (UL(1) << (l)) + 1) & \
> -        (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> -#define GENMASK(h, l) \
> -       (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> +/*
> + * Generate a mask for the specified type @t. Additional checks are made to
> + * guarantee the value returned fits in that type, relying on
> + * shift-count-overflow compiler check to detect incompatible arguments.
> + * For example, all these create build errors or warnings:
> + *
> + * - GENMASK(15, 20): wrong argument order
> + * - GENMASK(72, 15): doesn't fit unsigned long
> + * - GENMASK_U32(33, 15): doesn't fit in a u32
> + */
> +#define __GENMASK(t, h, l) \
> +       (GENMASK_INPUT_CHECK(h, l) + \
> +        (((t)~0ULL - ((t)(1) << (l)) + 1) & \
> +        ((t)~0ULL >> (BITS_PER_TYPE(t) - 1 - (h)))))
>
> -#define __GENMASK_ULL(h, l) \
> -       (((~ULL(0)) - (ULL(1) << (l)) + 1) & \
> -        (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
> -#define GENMASK_ULL(h, l) \
> -       (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
> +#define GENMASK(h, l)          __GENMASK(unsigned long,  h, l)
> +#define GENMASK_ULL(h, l)      __GENMASK(unsigned long long, h, l)
> +#define GENMASK_U8(h, l)       __GENMASK(u8,  h, l)
> +#define GENMASK_U16(h, l)      __GENMASK(u16, h, l)
> +#define GENMASK_U32(h, l)      __GENMASK(u32, h, l)
> +#define GENMASK_U64(h, l)      __GENMASK(u64, h, l)

This breaks drm-tip on arm64 architecture:

arch/arm64/kernel/entry-fpsimd.S: Assembler messages:
465arch/arm64/kernel/entry-fpsimd.S:271: Error: found 'l', expected: ')'
466arch/arm64/kernel/entry-fpsimd.S:66: Info: macro invoked from here
467arch/arm64/kernel/entry-fpsimd.S:271: Error: found 'l', expected: ')'
468arch/arm64/kernel/entry-fpsimd.S:66: Info: macro invoked from here
469arch/arm64/kernel/entry-fpsimd.S:271: Error: found 'l', expected: ')'
470arch/arm64/kernel/entry-fpsimd.S:66: Info: macro invoked from here
471arch/arm64/kernel/entry-fpsimd.S:271: Error: found 'l', expected: ')'
472arch/arm64/kernel/entry-fpsimd.S:66: Info: macro invoked from here
473arch/arm64/kernel/entry-fpsimd.S:271: Error: unexpected characters
following instruction at operand 3 -- `bic x2,x1,(0+(((unsigned
long)~0ULL-((unsigned long)(1)<<(0))+1)&((unsigned
long)~0ULL>>((sizeof(unsigned long)*8)-1-(3)))))'
474arch/arm64/kernel/entry-fpsimd.S:66: Info: macro invoked from here
475arch/arm64/kernel/entry-fpsimd.S:282: Error: found 'l', expected: ')'
476arch/arm64/kernel/entry-fpsimd.S:98: Info: macro invoked from here
477arch/arm64/kernel/entry-fpsimd.S:282: Error: found 'l', expected: ')'
478arch/arm64/kernel/entry-fpsimd.S:98: Info: macro invoked from here
479arch/arm64/kernel/entry-fpsimd.S:282: Error: found 'l', expected: ')'
480arch/arm64/kernel/entry-fpsimd.S:98: Info: macro invoked from here
481arch/arm64/kernel/entry-fpsimd.S:282: Error: found 'l', expected: ')'
482arch/arm64/kernel/entry-fpsimd.S:98: Info: macro invoked from here
483arch/arm64/kernel/entry-fpsimd.S:282: Error: unexpected characters
following instruction at operand 3 -- `bic x2,x1,(0+(((unsigned
long)~0ULL-((unsigned long)(1)<<(0))+1)&((unsigned
long)~0ULL>>((sizeof(unsigned long)*8)-1-(3)))))'
484arch/arm64/kernel/entry-fpsimd.S:98: Info: macro invoked from here

>
>  #endif /* __LINUX_BITS_H */
> --
> 2.43.0
>


-- 
With best wishes
Dmitry

