Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C1A756EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjGQU56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGQU5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:57:54 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853EB10C4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:57:52 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4039a2b71c1so27424031cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689627471; x=1692219471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1tXZwlk9ygqCJ/+6RexnIeJlSFOJ6oPHdeYsMHIUQk=;
        b=mAH1LMLXXRH7bhu3M3VDZbm/Ww9HWRiSjlX0UWA1Jd8AMMlUvfZkv0wtQu4/ki9zPr
         taNI2hpo08Ugn7AvK5D58bWbOHsiYn9742N3j4OL+jzjbQ7An+Mak1qMPD3aI3sRhfUP
         vEYkfs45wZvB/2mSUg0NZHeMmEkjPEfixNYGMb5mecnba/NHNx7d8CPWYXWdAA3vB1hq
         0OPL/ECKSITpvqBZaKKyaQ5Yo85qs7HckjmJ7Us7Z9U50Tr5bdVzdJn7SFX9mT8Qdx+w
         7bTRTRYBvWQcj8tv6bw77VxWtvVuqUcR1iWXDOj3wmy2IwZzoaoeVFiP67MB61ifTUG9
         RBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689627471; x=1692219471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1tXZwlk9ygqCJ/+6RexnIeJlSFOJ6oPHdeYsMHIUQk=;
        b=HXy7AYB77bWza32AFfVz/H+ISBCjyLwa6e2yd3HFIYxLWklzSgmqos57BD6/uzPib6
         sn9nRloaCg0bafUjb+lcZdRmDJle7/CrsAVhLhV6YE/e9lEJr4jXnZdl8FDIheNhH9hJ
         qN10aOTTYwHHeT0illPKdS1HwWNISJCzsm25DGhjPB6tpHYUcttEq7AmVmNBQYhY24W5
         W00ps1Vrdg/TQpY9cQzNI+AtApRN+26BMoKoQsiTklCD1TFxBudaq0s1KAW3ZklIszgB
         8fz9u5fPsqHKYarZHwCo/9DEt6RQ8oR2IvR5TNJ9JnCbAMEz8+SUreJVxN2LMVxUgfZT
         lwiA==
X-Gm-Message-State: ABy/qLaXRZqCr+pTyE8yFfRlmfiP7WrzkpHcR6vnsVWSA977Mwd9O0Yi
        tEuwoAJ5UUulE+D2p1x1/7Hd7DozDb0uE9bz3RdWCQ==
X-Google-Smtp-Source: APBJJlENJz22/z4X3XAJfcKSSKGZSoPuEUcd4H4zX1TMd+nSvFniCiQlFadX6iFuW9kD9eB+KEZZATddmfykzPLj07I=
X-Received: by 2002:a0c:cd0f:0:b0:632:5fb:5642 with SMTP id
 b15-20020a0ccd0f000000b0063205fb5642mr10636315qvm.12.1689627471512; Mon, 17
 Jul 2023 13:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230717195813.29059-1-yury.norov@gmail.com> <20230717203105.GA2212488@dev-arch.thelio-3990X>
In-Reply-To: <20230717203105.GA2212488@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 17 Jul 2023 13:57:40 -0700
Message-ID: <CAKwvOdmUb=JgigcHxOR2trAx+fSxsKu9nNbpAhN1hC8_RBNXeQ@mail.gmail.com>
Subject: Re: [PATCH] lib/bitmap: waive const_eval test as it breaks the build
To:     Nathan Chancellor <nathan@kernel.org>,
        Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tom Rix <trix@redhat.com>, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 1:31=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Hi Yury,
>
> On Mon, Jul 17, 2023 at 12:58:13PM -0700, Yury Norov wrote:
> > When building with clang, and when KASAN and GCOV_PROFILE_ALL are both
> > enabled, the test fails to build [1]:
> >
> > >> lib/test_bitmap.c:920:2: error: call to '__compiletime_assert_239' d=
eclared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(=
res)
> >            BUILD_BUG_ON(!__builtin_constant_p(res));
> >            ^
> >    include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG=
_ON'
> >            BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #conditi=
on)
> >            ^
> >    include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BU=
G_ON_MSG'
> >    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >                                        ^
> >    include/linux/compiler_types.h:352:2: note: expanded from macro 'com=
piletime_assert'
> >            _compiletime_assert(condition, msg, __compiletime_assert_, _=
_COUNTER__)
> >            ^
> >    include/linux/compiler_types.h:340:2: note: expanded from macro '_co=
mpiletime_assert'
> >            __compiletime_assert(condition, msg, prefix, suffix)
> >            ^
> >    include/linux/compiler_types.h:333:4: note: expanded from macro '__c=
ompiletime_assert'
> >                            prefix ## suffix();                         =
    \
> >                            ^
> >    <scratch space>:185:1: note: expanded from here
> >    __compiletime_assert_239
> >
> > Originally it was attributed to s390, which now looks seemingly wrong. =
The
> > issue is also not related to bitmap code itself, but it breaks build fo=
r
> > a given configuration. So, disabling the test unless the compiler will
> > get fixed.
> >
> > [1] https://github.com/ClangBuiltLinux/linux/issues/1874
> >
> > Fixes: dc34d5036692 ("lib: test_bitmap: add compile-time optimization/e=
valuations assertions")
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  lib/test_bitmap.c | 17 +++++------------
> >  1 file changed, 5 insertions(+), 12 deletions(-)
> >
> > diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> > index 187f5b2db4cf..a791fdb7a8c9 100644
> > --- a/lib/test_bitmap.c
> > +++ b/lib/test_bitmap.c
> > @@ -1163,6 +1163,9 @@ static void __init test_bitmap_print_buf(void)
> >
> >  static void __init test_bitmap_const_eval(void)
> >  {
> > +#if defined(CONFIG_CC_IS_CLANG) && defined(CONFIG_KASAN) && defined(CO=
NFIG_GCOV_PROFILE_ALL)
> > +#warning "FIXME: Clang breaks compile time evaluations when KASAN and =
GCOV are enabled"
>
> Making this a '#warning' will basically just replace the current error
> with a different one in the face of CONFIG_WERROR, which seems pointless
> to me:
>
>   lib/test_bitmap.c:1167:2: error: "FIXME: Clang breaks compile time eval=
uations when KASAN and GCOV are enabled" [-Werror,-W#warnings]
>    1167 | #warning "FIXME: Clang breaks compile time evaluations when KAS=
AN and GCOV are enabled"
>         |  ^
>   1 error generated.
>
> Could we just opt out of GCOV for test_bitmap.c if KASAN is enabled with
> clang? That does not seem too bad of a workaround. I highly doubt there
> are many people who are interested in debugging test_bitmap.c with KASAN
> while profiling it with GCOV when building with clang, since they would
> have hit this already and reported it already; as far as I can tell,
> only the Intel robot has reported this with a randconfig.

Yury, Nathan,
Thanks for the patches and discussion.  Yes, I think a combo of:

1. Nathan's lib/Makefile change plus
2. Yury's removal of the current preprocessor guards in lib/test_bitmap.c

make most sense.


>
> diff --git a/lib/Makefile b/lib/Makefile
> index 42d307ade225..c6f60ae42769 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -83,6 +83,10 @@ obj-$(CONFIG_TEST_DYNAMIC_DEBUG) +=3D test_dynamic_deb=
ug.o
>  obj-$(CONFIG_TEST_PRINTF) +=3D test_printf.o
>  obj-$(CONFIG_TEST_SCANF) +=3D test_scanf.o
>  obj-$(CONFIG_TEST_BITMAP) +=3D test_bitmap.o
> +# https://github.com/ClangBuiltLinux/linux/issues/1874
> +ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
> +GCOV_PROFILE_test_bitmap.o :=3D n
> +endif
>  obj-$(CONFIG_TEST_UUID) +=3D test_uuid.o
>  obj-$(CONFIG_TEST_XARRAY) +=3D test_xarray.o
>  obj-$(CONFIG_TEST_MAPLE_TREE) +=3D test_maple_tree.o
>
> Cheers,
> Nathan
>
> > +#else
> >       DECLARE_BITMAP(bitmap, BITS_PER_LONG);
> >       unsigned long initvar =3D BIT(2);
> >       unsigned long bitopvar =3D 0;
> > @@ -1177,20 +1180,9 @@ static void __init test_bitmap_const_eval(void)
> >        * in runtime.
> >        */
> >
> > -     /*
> > -      * Equals to `unsigned long bitmap[1] =3D { GENMASK(6, 5), }`.
> > -      * Clang on s390 optimizes bitops at compile-time as intended, bu=
t at
> > -      * the same time stops treating @bitmap and @bitopvar as compile-=
time
> > -      * constants after regular test_bit() is executed, thus triggerin=
g the
> > -      * build bugs below. So, call const_test_bit() there directly unt=
il
> > -      * the compiler is fixed.
> > -      */
> > +     /* Equals to `unsigned long bitmap[1] =3D { GENMASK(6, 5), }` */
> >       bitmap_clear(bitmap, 0, BITS_PER_LONG);
> > -#if defined(__s390__) && defined(__clang__)
> > -     if (!const_test_bit(7, bitmap))
> > -#else
> >       if (!test_bit(7, bitmap))
> > -#endif
> >               bitmap_set(bitmap, 5, 2);
> >
> >       /* Equals to `unsigned long bitopvar =3D BIT(20)` */
> > @@ -1220,6 +1212,7 @@ static void __init test_bitmap_const_eval(void)
> >       /* ~BIT(25) */
> >       BUILD_BUG_ON(!__builtin_constant_p(~var));
> >       BUILD_BUG_ON(~var !=3D ~BIT(25));
> > +#endif
> >  }
> >
> >  static void __init selftest(void)
> > --
> > 2.39.2
> >
>


--=20
Thanks,
~Nick Desaulniers
