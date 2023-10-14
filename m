Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543A27C94D7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 16:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjJNORP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 10:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJNORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 10:17:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E04BF;
        Sat, 14 Oct 2023 07:17:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8CAC433CA;
        Sat, 14 Oct 2023 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697293029;
        bh=oY4N7B1cssGb//2bLUaPZGK5pA0Y2aIN4WuHi9fFUOw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fx2gYUINh29tf2PMvvVM7XoJINXX3Y+gTKFc4yszNgplRDfOraI7Y3+BWwCUvnZEj
         /RyQ+zMdN9tNVhql1ijYLaM0f8/IclhEmjIVuH4XkuTw/qL/T0bgRXp/FPVLMkeWZe
         RqmhtiiTPTLCScYMdyLmtTk3etzaTMP+kuAScXxdhxw+/5PNFhK3AkNT1jXb1XwM5T
         mO4Kme4TLx0PDmqazNlCferEgyvMymm8auYVIiyPrpHDueLuk4AyOJiIdtFhUYa3qJ
         +6zjrI2EbC+oVcH7vbNHWEUvaSdoRHPUaoUvq9dCSXRFGld88LRRAKQd3D5RuSi5Nc
         8mxKWzWQwM0qg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1e98e97c824so2056854fac.1;
        Sat, 14 Oct 2023 07:17:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YyTNTQbsDJTg1gs6nAI7RpM2RwGbgD9mPDG6Kz4JAkQELaE4oKf
        0fYoiKzCpMzflnRgphcCHawN3Kdk7dkRDiRXc9o=
X-Google-Smtp-Source: AGHT+IFXCxu/CU1SV8NNu5ZJSS834nwPpqJ5oCItROyNMTkseFN6/zARmvcCXIDPTTgmZWbhUXeQwz93GSsQc7uj1yY=
X-Received: by 2002:a05:6870:1256:b0:1d5:8d6a:18f0 with SMTP id
 22-20020a056870125600b001d58d6a18f0mr1537561oao.27.1697293028476; Sat, 14 Oct
 2023 07:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231007170448.505487-1-masahiroy@kernel.org> <20231007170448.505487-3-masahiroy@kernel.org>
 <CAKwvOdkP-28Z51UZcDL4434Uns9pb0kYYFwzHmQCg7x2V0E_TQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkP-28Z51UZcDL4434Uns9pb0kYYFwzHmQCg7x2V0E_TQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 14 Oct 2023 23:16:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNARwDqb4hTLLNPZ1sG_CYGWHF7y88LRhaeS0BKkaancX8w@mail.gmail.com>
Message-ID: <CAK7LNARwDqb4hTLLNPZ1sG_CYGWHF7y88LRhaeS0BKkaancX8w@mail.gmail.com>
Subject: Re: [PATCH 3/5] modpost: define TO_NATIVE() using bswap_* functions
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
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

On Tue, Oct 10, 2023 at 2:44=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sat, Oct 7, 2023 at 10:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > The current TO_NATIVE() has some limitations:
> >
> >  1) You cannot cast the argument.
> >
> >  2) You cannot pass a variable marked as 'const'.
> >
> >  3) Passing an array is a bug, but it is not detected.
> >
> > Impelement TO_NATIVE() using bswap_*() functions. These are GNU
> > extensions. If we face portability issues, we can port the code from
> > include/uapi/linux/swab.h.
> >
> > With this change, get_rel_type_and_sym() can be simplified by casting
> > the arguments directly.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/mod/modpost.c | 13 ++++---------
> >  scripts/mod/modpost.h | 25 ++++++++++++-------------
> >  2 files changed, 16 insertions(+), 22 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 2f3b0fe6f68d..99476a9695c5 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -1410,15 +1410,10 @@ static void get_rel_type_and_sym(struct elf_inf=
o *elf, uint64_t r_info,
> >                 return;
> >         }
> >
> > -       if (is_64bit) {
> > -               Elf64_Xword r_info64 =3D r_info;
> > -
> > -               r_info =3D TO_NATIVE(r_info64);
> > -       } else {
> > -               Elf32_Word r_info32 =3D r_info;
> > -
> > -               r_info =3D TO_NATIVE(r_info32);
> > -       }
> > +       if (is_64bit)
> > +               r_info =3D TO_NATIVE((Elf64_Xword)r_info);
> > +       else
> > +               r_info =3D TO_NATIVE((Elf32_Word)r_info);
> >
> >         *r_type =3D ELF_R_TYPE(r_info);
> >         *r_sym =3D ELF_R_SYM(r_info);
> > diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> > index 6413f26fcb6b..1392afec118c 100644
> > --- a/scripts/mod/modpost.h
> > +++ b/scripts/mod/modpost.h
> > @@ -1,4 +1,5 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > +#include <byteswap.h>
> >  #include <stdbool.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > @@ -51,21 +52,19 @@
> >  #define ELF_R_TYPE  ELF64_R_TYPE
> >  #endif
> >
> > +#define bswap(x) \
> > +({ \
> > +       _Static_assert(sizeof(x) =3D=3D 1 || sizeof(x) =3D=3D 2 || \
>
> Seems fine, but do we need to support folks trying to swap 1B values?
> i.e. is someone calling TO_NATIVE with 1B values?



Yes.

In scripts/mod/file2alias.c,
DEF_FIELD() calls TO_NATIVE().

DEF_FIELD() is also used to get access to 1-byte fields.
So, TO_NATIVE() needs to accept sizeof(x)=3D=3D1.



>  Seems silly unless
> one of these types is variable length dependent on the target machine
> type?


You can use DEF_FIELD() without knowing the
field width. This is good.





--=20
Best Regards
Masahiro Yamada
