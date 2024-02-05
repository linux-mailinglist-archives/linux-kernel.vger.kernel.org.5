Return-Path: <linux-kernel+bounces-52690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB89849B74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726061F23C70
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1F61CD0B;
	Mon,  5 Feb 2024 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBdQmjDS"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AD422EF0
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138665; cv=none; b=ujPniwZX++1EeYFYEkOrY3aUJEfRY5Ct8e2A+4mh/sDh9l7AuaDIwQaXYUfDC0Gr7KQpoNe1NyWmyEwcLLUuny47y8A9GcCF4nxtp0/veqWtbd8oMGdzKQptVuVNXNFipdA5Zj7li1/6b0LJ486BhzHBUsteNM8pCBHa7wLfybw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138665; c=relaxed/simple;
	bh=8xEKAj/aIXoAnef6WCYeb1etalNTieAd05i+DkQi20o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UINsD6bdmsLTejNWZLNMyDcQhzezemkGcqaF9SDZZGEODEur0CZ0piJ1eZkj9j7KeiRN8fX0NHjILrogpxWT6QSWiGZ5KIGa+1lbQiHAto0VyIRUWe2klNfULn4i3zxT9Wx3E2VCAwCzkf7LvE+R9Id4/RuWcoPjPy/WGZB1rSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bBdQmjDS; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d5bbbe5844so1902476241.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 05:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707138663; x=1707743463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kgO66v67ga2hZ/fa1VFxPxUYTn/f70qrUJZfQyHF9yA=;
        b=bBdQmjDSnnkWD5f1QtQfnNPLrvNXSidpvjrE8+RIApgvH2HKizXXrMUh00mjc8DvCt
         0uWD3IiASEdE+OaouQPasLRBYGy7GPQS4VFIulh9aa7qBIGAlYT0lhbkaztXGVQmoi95
         nH3VQDKDQ45KtC9Q0GoNsinbGjpAIOT5KLcUVQTUSynRcODRAvBReUkh5EfK0isEGbC0
         ss1WFU3SRdB3YxF2LjxnnAbHp9a9cThGow+xNeDPZHBohqIHlQq8Ix0wlQdzjhzGOzsW
         dUSMCivz48FGXUHIAKWnF87ayITJSgWEyzxtoJwacYBDZZhKUvjPFWVpWfewdGzsh6qt
         BZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138663; x=1707743463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgO66v67ga2hZ/fa1VFxPxUYTn/f70qrUJZfQyHF9yA=;
        b=X02qpOSr9+/qBChlfcn1SI09pfnWEt9Gz2HVvwMZ2gtZwdE7nfy/Q7jxmDwyf/LSGk
         I9Thl/+CMks/Js1Rf09g0f7ayEonoMHzHhJIVKkz1R+AmrWF5/X3o6swXBGQ6CWgqGH7
         bC5MESa4ZozpHIvACV6WV3aPlnjV0n7FQB5rpaUMyF4ByuOp/sR1GbaEjd1pFqUjLYLa
         DzVqaNeSxvXIr/PeydaQQ6cvacEQvPg8tR1WVmOWWwJpdBdsYFJLHmb6vsjjL2/5psT7
         IAII6+k+U55fhYJRMZerExU6KrhuFoErSX1WPOkwXRXAuFzK7Inom0HUIY6Wqc4ZZtKE
         nsag==
X-Gm-Message-State: AOJu0YxedK65AoONSqrJRRdHEL2t/6TG+kkWZDq7xV12DEBmkK7dONTN
	fiNzJcKPho7EvcpylAKVIhW9Y+u0rpDYjust67DBgGUL08yG7iwlqlW7jI0NLsn9+7s01ORf/lW
	y63BTRJD3cOUvYUN95ctKLC2JkzcSCUAqj7c4
X-Google-Smtp-Source: AGHT+IGvWhOgVq5Sybn9CKaxdFweO8fp2yqczsb5Bclf6Z7TT13n+R/qBMPNOqS9yiUPSbnFy6IPYHjqSKy05FWL5Oc=
X-Received: by 2002:a05:6122:4d14:b0:4c0:1cc8:8819 with SMTP id
 fi20-20020a0561224d1400b004c01cc88819mr2759261vkb.5.1707138662522; Mon, 05
 Feb 2024 05:11:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205093725.make.582-kees@kernel.org> <67a842ad-b900-4c63-afcb-63455934f727@gmail.com>
 <202402050457.0B4D90B1A@keescook>
In-Reply-To: <202402050457.0B4D90B1A@keescook>
From: Marco Elver <elver@google.com>
Date: Mon, 5 Feb 2024 14:10:26 +0100
Message-ID: <CANpmjNMiMuUPPPeOvL76V9O-amx9uyKZYtOf5Q2b73v8O_xHWw@mail.gmail.com>
Subject: Re: [PATCH v3] ubsan: Reintroduce signed overflow sanitizer
To: Kees Cook <keescook@chromium.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Hao Luo <haoluo@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Nick Desaulniers <ndesaulniers@google.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 13:59, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Feb 05, 2024 at 01:54:24PM +0100, Andrey Ryabinin wrote:
> >
> >
> > On 2/5/24 10:37, Kees Cook wrote:
> >
> > > ---
> > >  include/linux/compiler_types.h |  9 ++++-
> > >  lib/Kconfig.ubsan              | 14 +++++++
> > >  lib/test_ubsan.c               | 37 ++++++++++++++++++
> > >  lib/ubsan.c                    | 68 ++++++++++++++++++++++++++++++++++
> > >  lib/ubsan.h                    |  4 ++
> > >  scripts/Makefile.lib           |  3 ++
> > >  scripts/Makefile.ubsan         |  3 ++
> > >  7 files changed, 137 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > > index 6f1ca49306d2..ee9d272008a5 100644
> > > --- a/include/linux/compiler_types.h
> > > +++ b/include/linux/compiler_types.h
> > > @@ -282,11 +282,18 @@ struct ftrace_likely_data {
> > >  #define __no_sanitize_or_inline __always_inline
> > >  #endif
> > >
> > > +/* Do not trap wrapping arithmetic within an annotated function. */
> > > +#ifdef CONFIG_UBSAN_SIGNED_WRAP
> > > +# define __signed_wrap __attribute__((no_sanitize("signed-integer-overflow")))
> > > +#else
> > > +# define __signed_wrap
> > > +#endif
> > > +
> > >  /* Section for code which can't be instrumented at all */
> > >  #define __noinstr_section(section)                                 \
> > >     noinline notrace __attribute((__section__(section)))            \
> > >     __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
> > > -   __no_sanitize_memory
> > > +   __no_sanitize_memory __signed_wrap
> > >
> >
> > Given this disables all kinds of code instrumentations,
> > shouldn't we just add __no_sanitize_undefined here?
>
> Yeah, that's a very good point.
>
> > I suspect that ubsan's instrumentation usually doesn't cause problems
> > because it calls __ubsan_* functions with all heavy stuff (printk, locks etc)
> > only if code has an UB. So the answer to the question above depends on
> > whether we want to ignore UBs in "noinstr" code or to get some weird side effect,
> > possibly without proper UBSAN report in dmesg.
>
> I think my preference would be to fail safe (i.e. leave in the
> instrumentation), but the intent of noinstr is pretty clear. :P I wonder
> if, instead, we could adjust objtool to yell about cases where calls are
> made in noinstr functions (like it does for UACCESS)... maybe it already
> does?

It already does, see CONFIG_NOINSTR_VALIDATION (yes by default on x86).

