Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D537531C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbjGNGJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbjGNGJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:09:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70A02680
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:09:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43B0061C2A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3408C433CC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689314960;
        bh=slzIiL6xjyC+ErFwviINtFj+XbEUUfTGNLb5qKtDnjQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mo6SGS+I1QZh6r5JlfWB8tsP1LVnZWUvX03GzACeAIPrwGkBy51RlHoQYP28L0mc2
         WhtJLFANwEBg6C6G8KleO5499965FPWrf9KWkx645wo8QAxl2aBNmK3d5+RqkDx3aP
         wis8133MRCRDznQZlhmiobUTRF/gkmvn1n8uOxX5SxFQWu9PuiX3q6e4ho2z7bV6tb
         tRVhO3gOnW2sUaZ9Gyewo9dVbpYOM9nYz6UoUzq63bCbBBu5LsicajsEf4wynHvRAy
         uG+ehu9berGAgBYtUKCktKBzMCKJVbn8kQPTHreN6nohsWaE6yyK+kWQ3lyiKHPCDU
         CV/WnAdirZc2g==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so1799559a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:09:20 -0700 (PDT)
X-Gm-Message-State: ABy/qLbghZuPwI2o0eY8T8qWoJ+ZWSiuysuFbK5XTVbJjowstzWsZ/pk
        BkuNipEEbU+ZyMOB4KqoF6ggQ6oXjlVm0l971JU=
X-Google-Smtp-Source: APBJJlHfV5uiYflQg3lVk1S8v8wZqfsuPJV95ftgyLUWRrw1yNa2k6uF6bsu8xdjpw3t4q8w5GV5+HQYzW953OLn3I0=
X-Received: by 2002:a05:6402:2038:b0:51e:293b:e1ce with SMTP id
 ay24-20020a056402203800b0051e293be1cemr3546076edb.31.1689314958865; Thu, 13
 Jul 2023 23:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230712101344.2714626-1-chenhuacai@loongson.cn>
 <CA+fCnZd1nhG9FDzkeW42jFbPuGKZms-HzHXBiO5YTSnkmsZoZQ@mail.gmail.com>
 <CAAhV-H4nuwBJHE3VPj6yE2HUw3tDaLtgeRQ5mj0SRV6RoD8-9Q@mail.gmail.com>
 <CANpmjNM_FEpXPVgoAbUwEK+9m90X54ykWnMvpUP2ZQ8sjoSByg@mail.gmail.com>
 <CAAhV-H4WUXVYv5er7UpPHKQDdBheT-UgEsOnBmPGPJ=LKWh4PQ@mail.gmail.com> <CANpmjNN-zypOUdJ-7XW0nN+gbGFwxC-JPFs=WA8FipsKiBhbKw@mail.gmail.com>
In-Reply-To: <CANpmjNN-zypOUdJ-7XW0nN+gbGFwxC-JPFs=WA8FipsKiBhbKw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 14 Jul 2023 14:09:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7YLDQjVi8YKSv2ezz+d_wj3RPhnNchsh=HRwrf02rrCw@mail.gmail.com>
Message-ID: <CAAhV-H7YLDQjVi8YKSv2ezz+d_wj3RPhnNchsh=HRwrf02rrCw@mail.gmail.com>
Subject: Re: [PATCH] kasan: Fix tests by removing -ffreestanding
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marco,

On Thu, Jul 13, 2023 at 6:09=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Thu, 13 Jul 2023 at 11:58, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Marco,
> >
> > On Thu, Jul 13, 2023 at 4:12=E2=80=AFPM Marco Elver <elver@google.com> =
wrote:
> > >
> > > On Thu, 13 Jul 2023 at 06:33, Huacai Chen <chenhuacai@kernel.org> wro=
te:
> > > >
> > > > Hi, Andrey,
> > > >
> > > > On Thu, Jul 13, 2023 at 12:12=E2=80=AFAM Andrey Konovalov <andreykn=
vl@gmail.com> wrote:
> > > > > On Wed, Jul 12, 2023 at 12:14=E2=80=AFPM Huacai Chen <chenhuacai@=
loongson.cn> wrote:
> > > > > >
> > > > > > CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX hopes -fbuiltin for mem=
set()/
> > > > > > memcpy()/memmove() if instrumentation is needed. This is the de=
fault
> > > > > > behavior but some archs pass -ffreestanding which implies -fno-=
builtin,
> > > > > > and then causes some kasan tests fail. So we remove -ffreestand=
ing for
> > > > > > kasan tests.
> > > > >
> > > > > Could you clarify on which architecture you observed tests failur=
es?
> > > > Observed on LoongArch [1], KASAN for LoongArch was planned to be
> > > > merged in 6.5, but at the last minute I found some tests fail with
> > > > GCC14 (CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) so the patches are
> > > > dropped. After some debugging we found the root cause is
> > > > -ffreestanding.
> > > [...]
> > > > > >  CFLAGS_kasan_test.o :=3D $(CFLAGS_KASAN_TEST)
> > > > > > +CFLAGS_REMOVE_kasan_test.o :=3D -ffreestanding
> > > > > >  CFLAGS_kasan_test_module.o :=3D $(CFLAGS_KASAN_TEST)
> > > > > > +CFLAGS_REMOVE_kasan_test_module.o :=3D -ffreestanding
> > >
> > > It makes sense that if -ffreestanding is added everywhere, that this
> > > patch fixes the test. Also see:
> > > https://lkml.kernel.org/r/20230224085942.1791837-3-elver@google.com
> > >
> > > -ffreestanding implies -fno-builtin, which used to be added to the
> > > test where !CC_HAS_KASAN_MEMINTRINSIC_PREFIX (old compilers).
> > >
> > > But ideally, the test doesn't have any special flags to make it pass,
> > > because ultimately we want the test setup to be as close to other
> > > normal kernel code.
> > >
> > > What this means for LoongArch, is that the test legitimately is
> > > pointing out an issue: namely that with newer compilers, your current
> > > KASAN support for LoongArch is failing to detect bad accesses within
> > > mem*() functions.
> > >
> > > The reason newer compilers should emit __asan_mem*() functions and
> > > replace normal mem*() functions, is that making mem*() functions
> > > always instrumented is not safe when e.g. called from uninstrumented
> > > code. One problem is that compilers will happily generate
> > > memcpy/memset calls themselves for e.g. variable initialization or
> > > struct copies - and unfortunately -ffreestanding does _not_ prohibit
> > > compilers from doing so: https://godbolt.org/z/hxGvdo4P9
> > >
> > > I would propose 2 options:
> > >
> > > 1. Removing -ffreestanding from LoongArch. It is unclear to me why
> > > this is required. As said above, -ffreestanding does not actually
> > > prohibit the compiler from generating implicit memset/memcpy. It
> > > prohibits some other optimizations, but in the kernel, you might even
> > > want those optimizations if common libcalls are already implemented
> > > (which they should be?).
> > >
> > > 2. If KASAN is enabled on LoongArch, make memset/memcpy/memmove
> > > aliases to __asan_memset/__asan_memcpy/__asan_memmove. That means
> > > you'd have to invert how you currently set up __mem and mem functions=
:
> > > the implementation is in __mem*, and mem* functions alias __mem* -or-
> > > if KASAN is enabled __asan_mem* functions (ifdef
> > > CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX to make old compilers work as
> > > well).
> > >
> > > If you go with option #2 you are accepting the risk of using
> > > instrumented mem* functions from uninstrumented files/functions. This
> > > has been an issue for other architectures. In many cases you might ge=
t
> > > lucky enough that it doesn't cause issues, but that's not guaranteed.
> > Thank you for your advice, but we should keep -ffreestanding for
> > LoongArch, even if it may cause failing to detect bad accesses.
> > Because now the __builtin_memset() assumes hardware supports unaligned
> > access, which is not the case for Loongson-2K series. If removing
> > -ffreestanding, Loongson-2K gets a poor performance.
> >
> > On the other hand, LoongArch is not the only architecture use
> > -ffreestanding, e.g., MIPS, X86_32, M68K and Xtensa also use, so the
> > tests should get fixed.
>
> That's fair - in which case, I would recommend option #2 or some
> variant of it. Because fixing the test by removing -ffreestanding is
> just hiding that there's a real issue that needs to be fixed to have
> properly working KASAN on LoongArch.
After some thinking, I found we can remove -ffreestanding in the arch
Makefile when KASAN is enabled -- because it is not the performance
critical configuration. And then, this patch can be dropped, thank
you.

Huacai
