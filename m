Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDA0756FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjGQWSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjGQWSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:18:07 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92897B2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:18:06 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-768197bad1cso232409085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689632285; x=1692224285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0nRdgPIxPY9h+6ob+XM6W1276R2kR6LVZcGXL+V7xQ=;
        b=S2DUQ4oHtpsxG9NzvglBSXoaL0mMF9/6onvQd/rprjmlG4A110LPmzn4x57zH0j4cv
         wFWOxPjsT2lIU8hdbOFj3MGp5vBHpoX3t8W8HEYf1fa1CITtlCYQcwLKVT4Tqsna8QDZ
         8340z+Kj7hkU3dhoASUDr/BUPdCoMdHYrAEczd9KlNCVDnpltv3fJ79lLNQjbWdVFV4g
         2Tvg/nH3szhBjxkSgyRhS2p/GyCUatgbxGzdowZL9DcLBVeX7XtXZxByu3UBoLuFKSe2
         ifwLSg9wA1quMluShQUZhz9yBq3IbJ+f1GrQvRpXlTbRmqohIoF8P78eABb2veT4GnRD
         KAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689632285; x=1692224285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0nRdgPIxPY9h+6ob+XM6W1276R2kR6LVZcGXL+V7xQ=;
        b=FqNNcgqxOcyKTE6Ye801XNv2wCx2EIM0WQbHLOAWIVfPwobWvkWBTICl74JOQ96xox
         NkkKSxbkOxvme5FbMGuAJp3+8DfX8sR47WlzGeaguGcoRqvlOQRqdQHNzld9h8m5C4RD
         grXQbipv/DFl234/rTWo4x8mZHbxcn97pmh75qvX/aZ6n56bOE+SMNJNqHwz/GF2A7Xn
         gov3OgCxMeXaPbUDkyJCWtSeOnKowBQK9ajHnNv/CG+wtB4mahjnT1pFkW1fE4JiioZ2
         LV8q/wHRuG4OYBw4Sw3mSgx/Z9uYc2EAHHNMGA6afM/YDQGBSCdvo3+JuH0OC8IEEbf8
         YFFw==
X-Gm-Message-State: ABy/qLb8yT0zppQWEi69nBcKs7BOQ16DdwGR1Hvdn3/0BWgd11oVa3Fo
        qQbzHgGz5K1oQYGPdSaRreFt5QALeK0LnFEAbOjHZQ==
X-Google-Smtp-Source: APBJJlHLjslVGLXCTSMLhtM9+72/787CaZvR5j2s8OxhxBKqBWudKCsp5r2ZmQyeVGJ+ejaoxMp6fyzM26CzICuIjK4=
X-Received: by 2002:a05:620a:410:b0:766:fd2c:fca1 with SMTP id
 16-20020a05620a041000b00766fd2cfca1mr16751394qkp.75.1689632285573; Mon, 17
 Jul 2023 15:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230717220435.57640-1-yury.norov@gmail.com>
In-Reply-To: <20230717220435.57640-1-yury.norov@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 17 Jul 2023 15:17:54 -0700
Message-ID: <CAKwvOdnOBYvLfv9+1pZ6medrPS0+V1yZ8tcSbW466Rqxv+qSng@mail.gmail.com>
Subject: Re: [PATCH v2] lib/bitmap: workaround const_eval test build failure
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, oe-kbuild-all@lists.linux.dev,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 3:04=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> When building with Clang, and when KASAN and GCOV_PROFILE_ALL are both
> enabled, the test fails to build [1]:
>
> >> lib/test_bitmap.c:920:2: error: call to '__compiletime_assert_239' dec=
lared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(re=
s)
>            BUILD_BUG_ON(!__builtin_constant_p(res));
>            ^
>    include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_O=
N'
>            BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition=
)
>            ^
>    include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_=
ON_MSG'
>    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                        ^
>    include/linux/compiler_types.h:352:2: note: expanded from macro 'compi=
letime_assert'
>            _compiletime_assert(condition, msg, __compiletime_assert_, __C=
OUNTER__)
>            ^
>    include/linux/compiler_types.h:340:2: note: expanded from macro '_comp=
iletime_assert'
>            __compiletime_assert(condition, msg, prefix, suffix)
>            ^
>    include/linux/compiler_types.h:333:4: note: expanded from macro '__com=
piletime_assert'
>                            prefix ## suffix();                           =
  \
>                            ^
>    <scratch space>:185:1: note: expanded from here
>    __compiletime_assert_239
>
> Originally it was attributed to s390, which now looks seemingly wrong. Th=
e
> issue is not related to bitmap code itself, but it breaks build for a giv=
en
> configuration.
>
> Disabling the const_eval test under that config may potentially hide othe=
r
> bugs. Instead, workaround it by disabling GCOV for the test_bitmap unless
> the compiler will get fixed.
>
> [1] https://github.com/ClangBuiltLinux/linux/issues/1874
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307171254.yFcH97ej-lkp@i=
ntel.com/
> Fixes: dc34d5036692 ("lib: test_bitmap: add compile-time optimization/eva=
luations assertions")
> Co-developed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Thanks for the patch.  I hope to see if this is fixable in the
compiler soon, so that we can replace this with a compiler version
check should this be fixable (and then fixed) in the compiler.  For
now, we will track this in the above github link.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  lib/Makefile      | 6 ++++++
>  lib/test_bitmap.c | 8 ++++----
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/lib/Makefile b/lib/Makefile
> index 42d307ade225..1ffae65bb7ee 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -82,7 +82,13 @@ obj-$(CONFIG_TEST_STATIC_KEYS) +=3D test_static_key_ba=
se.o
>  obj-$(CONFIG_TEST_DYNAMIC_DEBUG) +=3D test_dynamic_debug.o
>  obj-$(CONFIG_TEST_PRINTF) +=3D test_printf.o
>  obj-$(CONFIG_TEST_SCANF) +=3D test_scanf.o
> +
>  obj-$(CONFIG_TEST_BITMAP) +=3D test_bitmap.o
> +ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
> +# FIXME: Clang breaks test_bitmap_const_eval when KASAN and GCOV are ena=
bled
> +GCOV_PROFILE_test_bitmap.o :=3D n
> +endif
> +
>  obj-$(CONFIG_TEST_UUID) +=3D test_uuid.o
>  obj-$(CONFIG_TEST_XARRAY) +=3D test_xarray.o
>  obj-$(CONFIG_TEST_MAPLE_TREE) +=3D test_maple_tree.o
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 187f5b2db4cf..4a678de9c350 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -1161,6 +1161,10 @@ static void __init test_bitmap_print_buf(void)
>         }
>  }
>
> +/*
> + * FIXME: Clang breaks compile-time evaluations when KASAN and GCOV are =
enabled.
> + * To workaround it, GCOV is force-disabled in Makefile for this configu=
ration.
> + */
>  static void __init test_bitmap_const_eval(void)
>  {
>         DECLARE_BITMAP(bitmap, BITS_PER_LONG);
> @@ -1186,11 +1190,7 @@ static void __init test_bitmap_const_eval(void)
>          * the compiler is fixed.
>          */
>         bitmap_clear(bitmap, 0, BITS_PER_LONG);
> -#if defined(__s390__) && defined(__clang__)
> -       if (!const_test_bit(7, bitmap))
> -#else
>         if (!test_bit(7, bitmap))
> -#endif
>                 bitmap_set(bitmap, 5, 2);
>
>         /* Equals to `unsigned long bitopvar =3D BIT(20)` */
> --
> 2.39.2
>
>


--=20
Thanks,
~Nick Desaulniers
