Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42D17AE9C0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjIZJ5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjIZJ5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:57:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F5211D;
        Tue, 26 Sep 2023 02:57:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C838C433BC;
        Tue, 26 Sep 2023 09:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695722224;
        bh=ND4eydiA2e0LFBvGXWZsms4LsFbgkGxmN+cAduhrn5k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gIOlAu6QdCQxIlBbOYMe2uAHaTfQ37XXkLBBlFKfbIUoqHn60TN0gSD/1ypJeAmun
         oaJailwI4g/dzhGY0D9dv22VMafDkZGfgzPx7hJW4N2vs89KUKEBmWtn9cbhdcFkHv
         8kgVu1a511cnIcnTr76a+eJaPquisjf8VUn4q4JTmOi5KH+GqnGzcTZCcJP0nHwizB
         7IEDiF7aI8F6bMyWIrvEWhW6ewIcRqo8htwK7mV3728295HpsbGFvrH3GaWib8KqLZ
         sZ0c90xhtPyJrEa09SHXkEBuBi8b4BU+J2bQPOFH0pwUB3VSFYSauRulNChSWvbalI
         iCFicy2Zia2Zw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1dc9c2b2b79so3812937fac.0;
        Tue, 26 Sep 2023 02:57:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YxnQimi783vP92t0zJay2e6j32UGr7oYPgiFH1edETh6JUuteUT
        whBkR1E+EXxvBQF0kl5hXxg4qUrx38IF4N+VnpQ=
X-Google-Smtp-Source: AGHT+IF+Jy0LcJwW8uyTv5qmllzwYUpyr49pb0v0dxQxNm6LoRVJhN006IC5Kt8fPO8LcvdJVekN03Ffz+q/LYzqXGs=
X-Received: by 2002:a05:6870:d1c9:b0:1d1:425b:8026 with SMTP id
 b9-20020a056870d1c900b001d1425b8026mr9347586oac.26.1695722223382; Tue, 26 Sep
 2023 02:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230918210631.3882376-1-jbrennen@google.com> <20230925205933.2869049-1-jbrennen@google.com>
 <CAK7LNARd_pRWWso49C4MoahFAM9idyOFC+9ZFYdpS87CA4UTqQ@mail.gmail.com> <f0de36d5f8f3687c873616ac3bae698f2aa61020.camel@perches.com>
In-Reply-To: <f0de36d5f8f3687c873616ac3bae698f2aa61020.camel@perches.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 26 Sep 2023 18:56:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNASwcMf4utu238T6xtJwbnFHSvWntLenve4_KXShOJva6A@mail.gmail.com>
Message-ID: <CAK7LNASwcMf4utu238T6xtJwbnFHSvWntLenve4_KXShOJva6A@mail.gmail.com>
Subject: Re: [PATCH] modpost: Optimize symbol search from linear to binary search
To:     Joe Perches <joe@perches.com>
Cc:     Jack Brennen <jbrennen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, maskray@google.com, cleger@rivosinc.com,
        kernel-team@android.com
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

On Tue, Sep 26, 2023 at 4:24=E2=80=AFPM Joe Perches <joe@perches.com> wrote=
:
>
> On Tue, 2023-09-26 at 15:46 +0900, Masahiro Yamada wrote:
> > On Tue, Sep 26, 2023 at 5:59=E2=80=AFAM Jack Brennen <jbrennen@google.c=
om> wrote:
> >
> > > +Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
> > > +                               unsigned int secndx, bool allow_negat=
ive,
> > > +                               Elf_Addr min_distance)
> > > +{
> > > +       size_t hi =3D elf->symsearch->table_size;
> > > +       size_t lo =3D 0;
> > > +       struct syminfo *table =3D elf->symsearch->table;
> > > +       struct syminfo target;
> > > +
> > > +       target.addr =3D addr;
> > > +       target.section_index =3D secndx;
> > > +       target.symbol_index =3D ~0;  /* compares greater than any act=
ual index */
> > > +       while (hi > lo) {
> > > +               size_t mid =3D lo + (hi-lo)/2;   /* Avoids potential =
overflow */
> > > +
> > > +               if (syminfo_compare(&table[mid], &target) > 0)
> > > +                       hi =3D mid;
> > > +               else
> > > +                       lo =3D mid+1;
> >
> > My preference is "low =3D mid + 1" over "low =3D mid+1"
> >
> > Documentation/process/coding-style.rst suggests spaces
> > around binary operators.
> >
> > "
> > Use one space around (on each side of) most binary and ternary operator=
s,
> > such as any of these::
> >
> >         =3D  +  -  <  >  *  /  %  |  &  ^  <=3D  >=3D  =3D=3D  !=3D  ? =
 :
> > "
> >
> > I can see the corresponding line in the checkpatch tool:
> >
> > https://github.com/torvalds/linux/blob/v6.5/scripts/checkpatch.pl#L5330
> >
> >
> > I wonder why the checkpatch did not detect it.
> >
> > Maybe, Joe Perches may know the reason.
>
> checkpatch requires --strict to emit that message.
>




Ah, now I see it.  I learned a new thing today.



CHECK: spaces preferred around that '+' (ctx:VxV)
#466: FILE: scripts/mod/symsearch.c:172:
+ lo =3D mid+1;
          ^







--
Best Regards
Masahiro Yamada
