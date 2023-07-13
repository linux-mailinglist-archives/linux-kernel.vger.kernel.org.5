Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEFC751E07
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjGMJ7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjGMJ7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:59:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F50C30C3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:58:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3170C61A05
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CFAC433BC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689242325;
        bh=JIJ/9YHPQSlo5la7w4FYkpy5Ibfiu9+7giinJsFip2I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jHBvHW91DfKvky6JFiLNads9D0QxSX9lrnVCHpEmtrnT+l8qggtgSKBzAAWIcsbml
         tRnJIb0yKoWU3Nnv1+08a8Ky9DPKCJkDSygsrmcUiQvkltaMyc0V2+GewVnctQukGB
         96n6zc33bP28r/B0KQIQOx9LcB7poDjkXehqll+gtukHHjLZN/yXD/MekZ4b34KyRp
         Q8hj0frhVWzqUE00kxqqaHT+YcArMEDgfbD392jEeZgI3b0SRNp/Mi1cEjqoQpBLTm
         DuPQQZd29x4/2vl9tQzw9EFAKtr8G4yDpYArOwBu0NsxdSoaB73pANiEA3JxCuiscC
         WMuKm6UajByWw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so3798521a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:58:45 -0700 (PDT)
X-Gm-Message-State: ABy/qLY57vCzxdCw3EZ9ER6/7ezJ39wHo/sH+PCKTYbwELqgo8KjyIri
        OXlcGeHEkcdtSfe6zvyp81aHqQgADr0h0dVPkys=
X-Google-Smtp-Source: APBJJlFyrPseymmZLIMqNt4kBW/MVZjrm/+kxY2e618SNJrmD0Q1rapfUgryDMj5TBW6wQKniTYe0ulItjlSTlCgIKE=
X-Received: by 2002:a17:907:2d23:b0:993:22a2:9234 with SMTP id
 gs35-20020a1709072d2300b0099322a29234mr7118875ejc.31.1689242323659; Thu, 13
 Jul 2023 02:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230712101344.2714626-1-chenhuacai@loongson.cn>
 <CA+fCnZd1nhG9FDzkeW42jFbPuGKZms-HzHXBiO5YTSnkmsZoZQ@mail.gmail.com>
 <CAAhV-H4nuwBJHE3VPj6yE2HUw3tDaLtgeRQ5mj0SRV6RoD8-9Q@mail.gmail.com> <CANpmjNM_FEpXPVgoAbUwEK+9m90X54ykWnMvpUP2ZQ8sjoSByg@mail.gmail.com>
In-Reply-To: <CANpmjNM_FEpXPVgoAbUwEK+9m90X54ykWnMvpUP2ZQ8sjoSByg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 13 Jul 2023 17:58:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4WUXVYv5er7UpPHKQDdBheT-UgEsOnBmPGPJ=LKWh4PQ@mail.gmail.com>
Message-ID: <CAAhV-H4WUXVYv5er7UpPHKQDdBheT-UgEsOnBmPGPJ=LKWh4PQ@mail.gmail.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marco,

On Thu, Jul 13, 2023 at 4:12=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Thu, 13 Jul 2023 at 06:33, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Andrey,
> >
> > On Thu, Jul 13, 2023 at 12:12=E2=80=AFAM Andrey Konovalov <andreyknvl@g=
mail.com> wrote:
> > > On Wed, Jul 12, 2023 at 12:14=E2=80=AFPM Huacai Chen <chenhuacai@loon=
gson.cn> wrote:
> > > >
> > > > CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX hopes -fbuiltin for memset(=
)/
> > > > memcpy()/memmove() if instrumentation is needed. This is the defaul=
t
> > > > behavior but some archs pass -ffreestanding which implies -fno-buil=
tin,
> > > > and then causes some kasan tests fail. So we remove -ffreestanding =
for
> > > > kasan tests.
> > >
> > > Could you clarify on which architecture you observed tests failures?
> > Observed on LoongArch [1], KASAN for LoongArch was planned to be
> > merged in 6.5, but at the last minute I found some tests fail with
> > GCC14 (CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) so the patches are
> > dropped. After some debugging we found the root cause is
> > -ffreestanding.
> [...]
> > > >  CFLAGS_kasan_test.o :=3D $(CFLAGS_KASAN_TEST)
> > > > +CFLAGS_REMOVE_kasan_test.o :=3D -ffreestanding
> > > >  CFLAGS_kasan_test_module.o :=3D $(CFLAGS_KASAN_TEST)
> > > > +CFLAGS_REMOVE_kasan_test_module.o :=3D -ffreestanding
>
> It makes sense that if -ffreestanding is added everywhere, that this
> patch fixes the test. Also see:
> https://lkml.kernel.org/r/20230224085942.1791837-3-elver@google.com
>
> -ffreestanding implies -fno-builtin, which used to be added to the
> test where !CC_HAS_KASAN_MEMINTRINSIC_PREFIX (old compilers).
>
> But ideally, the test doesn't have any special flags to make it pass,
> because ultimately we want the test setup to be as close to other
> normal kernel code.
>
> What this means for LoongArch, is that the test legitimately is
> pointing out an issue: namely that with newer compilers, your current
> KASAN support for LoongArch is failing to detect bad accesses within
> mem*() functions.
>
> The reason newer compilers should emit __asan_mem*() functions and
> replace normal mem*() functions, is that making mem*() functions
> always instrumented is not safe when e.g. called from uninstrumented
> code. One problem is that compilers will happily generate
> memcpy/memset calls themselves for e.g. variable initialization or
> struct copies - and unfortunately -ffreestanding does _not_ prohibit
> compilers from doing so: https://godbolt.org/z/hxGvdo4P9
>
> I would propose 2 options:
>
> 1. Removing -ffreestanding from LoongArch. It is unclear to me why
> this is required. As said above, -ffreestanding does not actually
> prohibit the compiler from generating implicit memset/memcpy. It
> prohibits some other optimizations, but in the kernel, you might even
> want those optimizations if common libcalls are already implemented
> (which they should be?).
>
> 2. If KASAN is enabled on LoongArch, make memset/memcpy/memmove
> aliases to __asan_memset/__asan_memcpy/__asan_memmove. That means
> you'd have to invert how you currently set up __mem and mem functions:
> the implementation is in __mem*, and mem* functions alias __mem* -or-
> if KASAN is enabled __asan_mem* functions (ifdef
> CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX to make old compilers work as
> well).
>
> If you go with option #2 you are accepting the risk of using
> instrumented mem* functions from uninstrumented files/functions. This
> has been an issue for other architectures. In many cases you might get
> lucky enough that it doesn't cause issues, but that's not guaranteed.
Thank you for your advice, but we should keep -ffreestanding for
LoongArch, even if it may cause failing to detect bad accesses.
Because now the __builtin_memset() assumes hardware supports unaligned
access, which is not the case for Loongson-2K series. If removing
-ffreestanding, Loongson-2K gets a poor performance.

On the other hand, LoongArch is not the only architecture use
-ffreestanding, e.g., MIPS, X86_32, M68K and Xtensa also use, so the
tests should get fixed.

Huacai
