Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6E77C9386
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 10:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjJNImG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 04:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjJNImE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 04:42:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EF8CF;
        Sat, 14 Oct 2023 01:42:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D53C433CC;
        Sat, 14 Oct 2023 08:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697272921;
        bh=G4Swg/OELkKA5zlwNUrWJdm9EBLT0JpHuSiYFDVKAVw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K+yp/KOZHEM3arVfGghtli0iELZWZqeBdZQjVLVWAUiNiyjaLooZNU+qmDCQBd7ul
         wJaBzeZOVlPFEUG5h5tlObcnYkX0avwfR0zxFXrVQEiQDnBc/Lml9dt/p9dThylmIB
         6dy7VAWjVXsKM31JLEaZWzS991xED7EXyxYEqup8PHhHUWT6i4XXZP3blNDWD9gE4P
         HBZnzVjpf+964c0m1gsJz512u75AQxj5sGo0kVtbsfwjz6xNJ/scm1p3BONbVF4ExA
         K1tnbxCnRJlB0L9unW/GUHbyPmh79PM5kqNhJnIfBbfDsshHj4MN11rBcR3rT09vWo
         iM+Y47HqeqnfA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1e12f41e496so1689244fac.3;
        Sat, 14 Oct 2023 01:42:01 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz4FCxjo8rnzI9SUZWLZiNWUksnpsU8wpWJrHegCFqAKgy8qbpN
        b6VpC3Sujat6zTsBAlc5WTJ1PeSa0Fe2M75/tcU=
X-Google-Smtp-Source: AGHT+IEDHn8hDctpEgrOdAxDg4ZGS+fyZbcsCWC8+bRNQUrpKMWoTdaHrZNdtFPEOiGiKHQudHJYv6z04ih1iicSLkY=
X-Received: by 2002:a05:6870:7687:b0:1e9:d6c8:d031 with SMTP id
 dx7-20020a056870768700b001e9d6c8d031mr4746345oab.26.1697272921007; Sat, 14
 Oct 2023 01:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231009124210.1064021-1-masahiroy@kernel.org>
 <20231009124210.1064021-5-masahiroy@kernel.org> <20231009164424.GB1153868@dev-arch.thelio-3990X>
In-Reply-To: <20231009164424.GB1153868@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 14 Oct 2023 17:41:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNASZ78NX13cfGiCeXGxB7A_2CasuAgNv-XzyWM79PD2NwA@mail.gmail.com>
Message-ID: <CAK7LNASZ78NX13cfGiCeXGxB7A_2CasuAgNv-XzyWM79PD2NwA@mail.gmail.com>
Subject: Re: [PATCH 5/5] kbuild: unify no-compiler-targets and no-sync-config-targets
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        x86@kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 1:44=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Mon, Oct 09, 2023 at 09:42:10PM +0900, Masahiro Yamada wrote:
> > Now that vdso_install does not depend on any in-tree build artifact,
> > it no longer invokes a compiler, making no-compiler-targets the same
> > as no-sync-config-targets.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  Makefile | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 2170d56630e8..982b1ad33287 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -277,10 +277,6 @@ no-dot-config-targets :=3D $(clean-targets) \
> >                        $(version_h) headers headers_% archheaders archs=
cripts \
> >                        %asm-generic kernelversion %src-pkg dt_binding_c=
heck \
> >                        outputmakefile rustavailable rustfmt rustfmtchec=
k
> > -# Installation targets should not require compiler. Unfortunately, vds=
o_install
> > -# is an exception where build artifacts may be updated. This must be f=
ixed.
> > -no-compiler-targets :=3D $(no-dot-config-targets) install dtbs_install=
 \
> > -                     headers_install modules_install modules_sign kern=
elrelease image_name
> >  no-sync-config-targets :=3D $(no-dot-config-targets) %install modules_=
sign kernelrelease \
> >                         image_name
> >  single-targets :=3D %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rsi %.s =
%.symtypes %/
> > @@ -288,7 +284,6 @@ single-targets :=3D %.a %.i %.ko %.lds %.ll %.lst %=
.mod %.o %.rsi %.s %.symtypes %
> >  config-build :=3D
> >  mixed-build  :=3D
> >  need-config  :=3D 1
> > -need-compiler        :=3D 1
> >  may-sync-config      :=3D 1
> >  single-build :=3D
> >
> > @@ -298,12 +293,6 @@ ifneq ($(filter $(no-dot-config-targets), $(MAKECM=
DGOALS)),)
> >       endif
> >  endif
> >
> > -ifneq ($(filter $(no-compiler-targets), $(MAKECMDGOALS)),)
> > -     ifeq ($(filter-out $(no-compiler-targets), $(MAKECMDGOALS)),)
> > -             need-compiler :=3D
> > -     endif
> > -endif
> > -
>
> MIPS and LoongArch seem to have grown a usage of need-compiler in
> 4fe4a6374c4d ("MIPS: Only fiddle with CHECKFLAGS if `need-compiler'")
> and 54c2c9df083f ("LoongArch: Only fiddle with CHECKFLAGS if
> `need-compiler'"). With this removal, should those be updated as well?


Right, but may-sync-config and need-compiler are not
interchangeable due to the following code.

ifneq ($(KBUILD_EXTMOD),)
        may-sync-config :=3D
endif


I will keep both.


--=20
Best Regards
Masahiro Yamada
