Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090777892A4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 02:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjHZAJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 20:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjHZAJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 20:09:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E0B26AD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 17:09:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so2554a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 17:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693008554; x=1693613354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUk3uUdXKs7+gMswma28tK7skGdlo6kxLEqcZ8WRqnQ=;
        b=mrn6PoxWdSeDC6uvzb8XBnTntfjWhrF40nXCB4FTap+iDuaA6jZ1yWD23GZ5rIWpgm
         P9isM5FCEhyPsUztOrTrhTBTvDQUcHVH0TWWlAFUlHdioHWw6VBwa2rGpLH6OnEZZqwV
         frdoQX2ULVimqWmzGODXfYvMARhTc9E5XeXh6snHUu2xE6MPU1I4id9r7cYZqfAmhSDb
         XTc6P+UzI2WzeTkAaeIMio/dL4qCaNShMX3240zZFs8YSwvYCywmc+7JljRn0H/QVvHk
         QXW2bjJq+jgiEUhv+8bQBczwkg75jvw0v21zhZBTCUo8c9mdodMZyOmuQkrpfco3m1Un
         YUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693008554; x=1693613354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUk3uUdXKs7+gMswma28tK7skGdlo6kxLEqcZ8WRqnQ=;
        b=eX/0lC+VfICPrl0Isfb587Zj/32KZUnVPbYLAkC3UWhm1Cg0ln+XvU/WmNr8Icb6Fg
         roFGQ7oBDLgi1o60fqIgU4cjqaCAKIhsH344+/fDcfPepTHhPHGWfhDA6OIWhtD+oFMZ
         fMdZJ8Jmc4qPeLi7niz5Wkhkna8z5yKNVRmfNgAJ8TNMFNcd8NS6f6c0d5dp0kBKWf/A
         bTV3JOatHUGyS/qfhhqIgpLk2tFaHRXU3QV5tWv1FeWWrTKLxT3FK459kPjneZF0o9XQ
         v7UKv3LBVP+RYe1OzVcD3ZldmJpzqMX6zx5nboOq1uHy9Yp55wRKlXfCss7QsTQzvY/2
         3peQ==
X-Gm-Message-State: AOJu0YwqYy3FnvgphWGK3kdelq59mFAprpzjuNvcyBa8j39QkEunMwrL
        aA6fEZv5qqfl/wUeQwdyvhEr3hYwQhV8vtl9trUZ
X-Google-Smtp-Source: AGHT+IGtWbkJwcLQ/ocO4eGbqywH04d66oLtkjo3mbgDLG8roDA2WIsW7oZLbmk5ITMurK3TQtNFqD/8fMM4VgjiUhY=
X-Received: by 2002:a50:9ec4:0:b0:528:ef2:7613 with SMTP id
 a62-20020a509ec4000000b005280ef27613mr44216edf.7.1693008554394; Fri, 25 Aug
 2023 17:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <ZOkGCSNr0VN2VIJJ@p100> <CAHk-=wjZwSymfuGvf7TX3UQLU1OMN1FZMnEA-Hja0ruqyhMK4A@mail.gmail.com>
 <CAHk-=whVvD05T0yD5DQj803uETLD6qDq-Vx-SiLPcrL=eO77LQ@mail.gmail.com>
 <CAKwvOdnYauyrzz7-ceH-MP_KZ5ED8oYxjRx_Xei68=tUOSeKyA@mail.gmail.com>
 <CAGG=3QWcZPYqHMcjwuYDz1+OQhzS40hmhdOvSBZBQOkhs8YAQQ@mail.gmail.com>
 <CAGG=3QX8AaTedPy-joWm6yp+TFHBVXm59OcvxkdLGsSuDjem5g@mail.gmail.com> <CAHk-=wjQpXpnGAwvv-oBi+cQ0g+D9rTK5STkXSSV4a90FPR+EQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjQpXpnGAwvv-oBi+cQ0g+D9rTK5STkXSSV4a90FPR+EQ@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Fri, 25 Aug 2023 17:08:57 -0700
Message-ID: <CAGG=3QU7kvKTJf7M5x_QR_HrYJCz=tWnCNMg4OCw9_oChEuPPw@mail.gmail.com>
Subject: Re: [PATCH] lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Helge Deller <deller@gmx.de>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Chanho Min <chanho.min@lge.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 4:35=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 25 Aug 2023 at 15:57, Bill Wendling <morbo@google.com> wrote:
> > >
> > Another idea is that there are __builtin_* functions for a lot of
> > functions that are currently in inline asm
>
> No. We've been through this before. The builtins are almost entirely
> untested, and often undocumented and buggy.
>
> > The major issue with the
> > `__builtin_ia32_readeflags_*` was its inability to take unrelated MSRs
> > into account during code motion. That may not be the same worry here?
>
> No, the problem with __builtin_ia32_readeflags_*() was that it was
> literally completely buggy and generated entirely broken code:
>
>     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D104971
>
> but that's really more of a symptom than anything else.
>
> It's a symptom of the fact that unlike inline asm's, those builtins
> are often undocumented in what compiler version they appeared, and are
> of very questionable quality. They often don't have many users, and
> the test suites are non-existent.
>
> For example, we *do* use __builtin_ffs() on x86 for constant values,
> because the compiler does the right thing.
>
> But for non-constant ones, the inline asm actually generates better
> code: gcc generatea some disgusting mess with a 'bsf' followed by a
> 'cmov' for the zero case, when we know better.
>
> See for example
>
>    https://godbolt.org/z/jKKf48Wsf
>
Ew...gross.

> I don't understand why compiler people prefer a builtin that is an
> untested special case that assumes that the compiler knows what is
> going on (and often doesn't), over a generic escape facility that is
> supported and needed anyway (inline asm).
>
> In other words: the statement "builtins generate better code" is
> simply PROVABLY NOT TRUE.
>
> Builtins have often generated *worse* code than using inline asms, to
> the point where "worse" is actively buggy crap.
>
> At least inline asms are reliable. That's a *big* deal.
>
There are a couple of reasons why compiler writers (at least I) prefer
builtins to inline asm. Inline asm takes control away from the
compiler, which makes it harder for the compiler to perform normal
optimizations. It's more portable. As for better code, it won't
generate it in all situations, as you pointed out, but can typically
generate as good code.

Inline asm has its own issues---portability, difficult to use
constraints (the EFLAGS asms went back and forth on its constraints
over the years), and, from what I remember, GNU's inline asm is
closely tied to its register allocator, making it hard to support in
other compilers. Plus, there's not guarantee that an inline asm won't
be moved. (It's been discussed before, and I also believe that the
current Linux inline asm "barriers" should prevent this. I just vastly
prefer guaranteed behavior over "it works now". I've migrated many
systems to new compilers (and even compiler versions) and have seen
"well, it worked for the previous compiler" types of bugs that were
actual bugs in the programmer's code.)

Okay, none of what I said is going to convince you to use builtins,
and I'm not suggesting we do. It's just a few of the reasons why we
tend to prefer them to other methods. Just take this as an FYI. :-)

-bw
