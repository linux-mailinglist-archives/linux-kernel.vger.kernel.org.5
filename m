Return-Path: <linux-kernel+bounces-49725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E837A846E95
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5261F24DEE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F58113D4EE;
	Fri,  2 Feb 2024 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRLrVqNU"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D5D7C0B9
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871757; cv=none; b=DbP233LaL1py4AEZX1UrsCo8Zrpr2HT6dORNtG2knjAOsixsCc4w1GzK2indDLDdYob/XmcUhcnxBzC5dCkt63mRRFYlTP0cFb7HAwlvrhs3rNXawGNttJDGYeJlQlKLf35KXTvxiDVlaoZCPdYivrSEtL8ZEycy+VPS6O1juRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871757; c=relaxed/simple;
	bh=D74xUy1ymoMyy6G89fvtRm0D45tUlhGfHmdtylAdP74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwIeo4y/6Iu6wag5/MggeUTNFrZyJhpaHxgzmN6uBKnY/IAtdsZW/hCithNCZdVRDpeFozrg7rhPLVximcjFAQCxCLvtbOVyQqcx5wM7u4kW4ptYNeqjgfyEUDvWzvF3Ex7om8pWjC/VI9qsMP0cHsuNNJK8uT/I+fMbxZps5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mRLrVqNU; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3beb1d4d872so993499b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 03:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706871754; x=1707476554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AKvTOkMfs92gzE0M+TFiSJEhkCKRpJTzmpH7agAwUHE=;
        b=mRLrVqNUC0+K74GLOl3vqaKFfnZylYJ9FexXfOF7UWpR79qSkQVkNE7M3Dd3TeVLhb
         PhrYT0Eam/JvsohsUplCZo2sC80k7JA38WiRwJR/Tiyzu/netZn4T1zXO+n3szutFE73
         AYobjBPAq6heSsJap54Cc/4cOZ8dsmtVBSb6YNXMp+K+Jr4A2Z1ZH9RdF9OcyE2iAv6G
         Nvgx8OhKbCbIVM0OPBdwcEm0cU9+gsvREElE+bIRwnrDrW9OsJ3y2hB0935KlI0qV1vb
         EmXVwTpkOERbd8aEchG0ttIRworAU5vnn5ah8i+faa84zzD9AT9VD008Sx+sdyvHnbPE
         OCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871754; x=1707476554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKvTOkMfs92gzE0M+TFiSJEhkCKRpJTzmpH7agAwUHE=;
        b=U7xUkzs3YTiE1CD1VTgMB7mrpA6tXatrSQOvGozDKO4SolCFFiBjDTedNB/9UmkXlg
         UNZ2QhLsNdQ3vsUBzZAII8nNMRfFA/8nXd0nTs9keQwRLyseGnVYWfSLPeD5EBaEGrxZ
         JglINQtbkBvEP3qbwqgXRR+2x+USgbe1B8S1rY/V6hxlzcC0Ks/sj3EcXwk9QPM1fxn/
         P1MuDW8a0IQlva/MycG/Gyqt+Wj50I2IN+kYKhKBkQcAyp9ZE5wJILpljmNPliFC/t5b
         aK95qNJ7yaaavR2Lfx/mJhinDfG/i7dLi4dty4oQQNbo1HQFXd3pBIqhi4ifqQX+WYpf
         cmxg==
X-Gm-Message-State: AOJu0Yyx2xj1Z8Ia4Kz5a++ydWXlI8yRhdCEFAIrXhacrNLZAvnlFkn3
	EKayvUTfS+VVX3Oq/jieVztCVV4uZaBCas5hPdvgUf9Q41VocKvWi5U4uAlGtUotL76GPI0p9BD
	ulNqJNBVWqE6P12F9PDMBnMk7JtswiotUuZqB
X-Google-Smtp-Source: AGHT+IFRpqtiZKVAmnfyGxbOhfn+Xv95kz9Cj0dh1dh0pmbX0ph2z2DTZnuR3soBcYzNT173zBRShjkf603kulKsELQ=
X-Received: by 2002:a05:6808:10c3:b0:3bf:80de:9831 with SMTP id
 s3-20020a05680810c300b003bf80de9831mr1988318ois.10.1706871754161; Fri, 02 Feb
 2024 03:02:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202101311.it.893-kees@kernel.org> <20240202101642.156588-2-keescook@chromium.org>
In-Reply-To: <20240202101642.156588-2-keescook@chromium.org>
From: Marco Elver <elver@google.com>
Date: Fri, 2 Feb 2024 12:01:55 +0100
Message-ID: <CANpmjNPPbTNPJfM5MNE6tW-jCse+u_RB8bqGLT3cTxgCsL+x-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ubsan: Reintroduce signed and unsigned overflow sanitizers
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Hao Luo <haoluo@google.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Fangrui Song <maskray@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Bill Wendling <morbo@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	llvm@lists.linux.dev, linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 11:16, Kees Cook <keescook@chromium.org> wrote:
>
> Effectively revert commit 6aaa31aeb9cf ("ubsan: remove overflow
> checks"), to allow the kernel to be built with the "overflow"
> sanitizers again. This gives developers a chance to experiment[1][2][3]
> with the instrumentation again, while compilers adjust their sanitizers
> to deal with the impact of -fno-strict-oveflow (i.e. moving from
> "overflow" checking to "wrap-around" checking).
>
> Notably, the naming of the options is adjusted to use the name "WRAP"
> instead of "OVERFLOW". In the strictest sense, arithmetic "overflow"
> happens when a result exceeds the storage of the type, and is considered
> by the C standard and compilers to be undefined behavior for signed
> and pointer types (without -fno-strict-overflow). Unsigned arithmetic
> overflow is defined as always wrapping around.
>
> Because the kernel is built with -fno-strict-overflow, signed and pointer
> arithmetic is defined to always wrap around instead of "overflowing"
> (which could either be elided due to being undefined behavior or would
> wrap around, which led to very weird bugs in the kernel).
>
> So, the config options are added back as CONFIG_UBSAN_SIGNED_WRAP and
> CONFIG_UBSAN_UNSIGNED_WRAP. Since the kernel has several places that
> explicitly depend on wrap-around behavior (e.g. counters, atomics, crypto,
> etc), also introduce the __signed_wrap and __unsigned_wrap function
> attributes for annotating functions where wrapping is expected and should
> not be instrumented. This will allow us to distinguish in the kernel
> between intentional and unintentional cases of arithmetic wrap-around.
>
> Additionally keep these disabled under CONFIG_COMPILE_TEST for now.
>
> Link: https://github.com/KSPP/linux/issues/26 [1]
> Link: https://github.com/KSPP/linux/issues/27 [2]
> Link: https://github.com/KSPP/linux/issues/344 [3]
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/compiler_types.h | 14 ++++++-
>  lib/Kconfig.ubsan              | 19 ++++++++++
>  lib/test_ubsan.c               | 49 ++++++++++++++++++++++++
>  lib/ubsan.c                    | 68 ++++++++++++++++++++++++++++++++++
>  lib/ubsan.h                    |  4 ++
>  scripts/Makefile.ubsan         |  2 +
>  6 files changed, 155 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 6f1ca49306d2..e585614f3152 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -282,11 +282,23 @@ struct ftrace_likely_data {
>  #define __no_sanitize_or_inline __always_inline
>  #endif
>
> +/* Allow wrapping arithmetic within an annotated function. */
> +#ifdef CONFIG_UBSAN_SIGNED_WRAP
> +# define __signed_wrap __attribute__((no_sanitize("signed-integer-overflow")))
> +#else
> +# define __signed_wrap
> +#endif
> +#ifdef CONFIG_UBSAN_UNSIGNED_WRAP
> +# define __unsigned_wrap __attribute__((no_sanitize("unsigned-integer-overflow")))
> +#else
> +# define __unsigned_wrap
> +#endif
> +
>  /* Section for code which can't be instrumented at all */
>  #define __noinstr_section(section)                                     \
>         noinline notrace __attribute((__section__(section)))            \
>         __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
> -       __no_sanitize_memory
> +       __no_sanitize_memory __signed_wrap __unsigned_wrap
>
>  #define noinstr __noinstr_section(".noinstr.text")
>
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 59e21bfec188..a7003e5bd2a1 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -116,6 +116,25 @@ config UBSAN_UNREACHABLE
>           This option enables -fsanitize=unreachable which checks for control
>           flow reaching an expected-to-be-unreachable position.
>
> +config UBSAN_SIGNED_WRAP
> +       bool "Perform checking for signed arithmetic wrap-around"
> +       default UBSAN
> +       depends on !COMPILE_TEST
> +       depends on $(cc-option,-fsanitize=signed-integer-overflow)
> +       help
> +         This option enables -fsanitize=signed-integer-overflow which checks
> +         for wrap-around of any arithmetic operations with signed integers.
> +
> +config UBSAN_UNSIGNED_WRAP
> +       bool "Perform checking for unsigned arithmetic wrap-around"
> +       depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
> +       depends on !X86_32 # avoid excessive stack usage on x86-32/clang
> +       depends on !COMPILE_TEST
> +       help
> +         This option enables -fsanitize=unsigned-integer-overflow which checks
> +         for wrap-around of any arithmetic operations with unsigned integers. This
> +         currently causes x86 to fail to boot.

My hypothesis is that these options will quickly be enabled by various
test and fuzzing setups, to the detriment of kernel developers. While
the commit message states that these are for experimentation, I do not
think it is at all clear from the Kconfig options.

Unsigned integer wrap-around is relatively common (it is _not_ UB
after all). While I can appreciate that in some cases wrap around is a
genuine semantic bug, and that's what we want to find with these
changes, ultimately marking all semantically valid wrap arounds to
catch the unmarked ones. Given these patterns are so common, and C
programmers are used to them, it will take a lot of effort to mark all
the intentional cases. But I fear that even if we get to that place,
_unmarked_  but semantically valid unsigned wrap around will keep
popping up again and again.

What is the long-term vision to minimize the additional churn this may
introduce?

I think the problem reminds me a little of the data race problem,
although I suspect unsigned integer wraparound is much more common
than data races (which unlike unsigned wrap around is actually UB) -
so chasing all intentional unsigned integer wrap arounds and marking
will take even more effort than marking all intentional data races
(which we're still slowly, but steadily, making progress towards).

At the very least, these options should 'depends on EXPERT' or even
'depends on BROKEN' while the story is still being worked out.

Thanks,
-- Marco

