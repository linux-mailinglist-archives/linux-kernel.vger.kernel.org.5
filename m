Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39E2751785
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjGMEd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbjGMEdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65CC19BE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:33:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E42B61A0F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3619C433CD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689222827;
        bh=+kTyiAGba3mSR5djKFqg01Udpt0rBTFCzthMvoEcpms=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a7llqEy2HskttNfrPgpsHDzKi4l7zaqRp+j1s58C8FUTggYKpnqSZi9ZZUfxMbOTX
         sdCWlDAxxbZ1GIWygWrRsTXMlyVrxfIZ9eDsVrFiiK68/WoeKf3q60fKBlJ3UE/L1Z
         IiHjQeJoWm2rP/DONXCYzKOC0MLZM7jaI055Sie4y8+sbn6ELvc8u/zbS6/doHEtN6
         bv0pCFriPc8fpzPSwATRjMqUlYBQ9JJu9U2Axe38zjerYL7NgP24vimn6KjNQKbY9y
         knDc56xdu5RLc0dMxfJAFp4lTM88cHwH8jGdQQFHPbV2u5gz9pI3fTJ8deGa+XPNj2
         GkJtVkPH0lbxw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso246415a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:33:47 -0700 (PDT)
X-Gm-Message-State: ABy/qLaehk5nVJDCs4gpFWQ+G5T9NrVfOUu00VW/64dYl/dMiLSWn5gM
        Lr7aRNBUf0ctIk1MRAUoFFDs/WCE2kqYHRdhjtg=
X-Google-Smtp-Source: APBJJlEgbwJZ2VhU0QdQ+9cp7Qhd5M5V/j96iwJAwEctUoFZkSVLvhgLsDd0AwvpvnG+v2B724bGeqx69KAaGt0W/+c=
X-Received: by 2002:aa7:d34a:0:b0:51d:9ec4:9616 with SMTP id
 m10-20020aa7d34a000000b0051d9ec49616mr597329edr.28.1689222825887; Wed, 12 Jul
 2023 21:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230712101344.2714626-1-chenhuacai@loongson.cn> <CA+fCnZd1nhG9FDzkeW42jFbPuGKZms-HzHXBiO5YTSnkmsZoZQ@mail.gmail.com>
In-Reply-To: <CA+fCnZd1nhG9FDzkeW42jFbPuGKZms-HzHXBiO5YTSnkmsZoZQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 13 Jul 2023 12:33:33 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4nuwBJHE3VPj6yE2HUw3tDaLtgeRQ5mj0SRV6RoD8-9Q@mail.gmail.com>
Message-ID: <CAAhV-H4nuwBJHE3VPj6yE2HUw3tDaLtgeRQ5mj0SRV6RoD8-9Q@mail.gmail.com>
Subject: Re: [PATCH] kasan: Fix tests by removing -ffreestanding
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Marco Elver <elver@google.com>,
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

Hi, Andrey,

On Thu, Jul 13, 2023 at 12:12=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail=
.com> wrote:
>
> On Wed, Jul 12, 2023 at 12:14=E2=80=AFPM Huacai Chen <chenhuacai@loongson=
.cn> wrote:
> >
> > CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX hopes -fbuiltin for memset()/
> > memcpy()/memmove() if instrumentation is needed. This is the default
> > behavior but some archs pass -ffreestanding which implies -fno-builtin,
> > and then causes some kasan tests fail. So we remove -ffreestanding for
> > kasan tests.
>
> Could you clarify on which architecture you observed tests failures?
Observed on LoongArch [1], KASAN for LoongArch was planned to be
merged in 6.5, but at the last minute I found some tests fail with
GCC14 (CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) so the patches are
dropped. After some debugging we found the root cause is
-ffreestanding.

[1] https://github.com/chenhuacai/linux/commit/af2da91541a8899b502bece9b1fd=
e225b71f37a8

Huacai
>
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  mm/kasan/Makefile | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> > index 7634dd2a6128..edd1977a6b88 100644
> > --- a/mm/kasan/Makefile
> > +++ b/mm/kasan/Makefile
> > @@ -45,7 +45,9 @@ CFLAGS_KASAN_TEST +=3D -fno-builtin
> >  endif
> >
> >  CFLAGS_kasan_test.o :=3D $(CFLAGS_KASAN_TEST)
> > +CFLAGS_REMOVE_kasan_test.o :=3D -ffreestanding
> >  CFLAGS_kasan_test_module.o :=3D $(CFLAGS_KASAN_TEST)
> > +CFLAGS_REMOVE_kasan_test_module.o :=3D -ffreestanding
> >
> >  obj-y :=3D common.o report.o
> >  obj-$(CONFIG_KASAN_GENERIC) +=3D init.o generic.o report_generic.o sha=
dow.o quarantine.o
> > --
> > 2.39.3
>
> +Marco
