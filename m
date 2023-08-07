Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8A0773021
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjHGUGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjHGUGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:06:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44CC173D;
        Mon,  7 Aug 2023 13:06:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 909B9621DB;
        Mon,  7 Aug 2023 20:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044ADC433C8;
        Mon,  7 Aug 2023 20:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691438806;
        bh=jbCLcqbpDdyiXp4kREB9DClxxzHA3QSW5siXV+Xh+80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C5Y762mIWx2L8dYncsMaAWOQJZzZ9OL8U319scvzvbRy6JNzBJFQ8HbhBQXvqcfwf
         73d6GxUvUQ68ObtLksBTQrPTtSLBR6BwxuO3CSAD7csG3lbzObpPj+HcKPXKcIG8iw
         EOJE5/eO4ZFeFgqVfMGyVqWtR09+6k4+eED/LTbI/ONT4YyhtUTm9cIAEmiVLJ67qA
         THRHUPPlwXWaLZFFsafqVm4tTw+bbLF8iGWLKm5lz6gJRFd0wyXgBQaE/S0ZXClX/R
         lg0XzhhQw7okbNhxULExRhx3OAcZCG4R+tcyXBwMhf7EW07WyjnAe1ejhG2NG8PGsa
         6UDppXL6AQHng==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1bb7a1c2fe5so3655381fac.2;
        Mon, 07 Aug 2023 13:06:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YxT48eJmUS2LpAfwbqKJmSg1ZTdMY9g8ooEzkGaWdZ7E2w/ylP7
        ikQkan1n8C8TcY+N2/j/46pqDEMaGbC/iAcFVvs=
X-Google-Smtp-Source: AGHT+IGH3JbOMI6wsepizL5FX1FIVyEXCskFrCuKwxyl3olYukKYpi00FSoBq9cE125gdYhALtLllFSb6PDVC0398Fk=
X-Received: by 2002:a05:6870:ecaa:b0:1bb:6133:fb07 with SMTP id
 eo42-20020a056870ecaa00b001bb6133fb07mr12866882oab.3.1691438805199; Mon, 07
 Aug 2023 13:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230728113415.21067-1-will@kernel.org> <20230728113415.21067-4-will@kernel.org>
 <CAK7LNARnOUbySnnqOpP-3KBQTT-WvUHfnjV_sVTKe+faB8=86g@mail.gmail.com> <20230804143019.GA30486@willie-the-truck>
In-Reply-To: <20230804143019.GA30486@willie-the-truck>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 8 Aug 2023 05:06:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNATAyCUNkWv+NqKz7HZGRsjByZYsADf=d9-JT_QAh56S3Q@mail.gmail.com>
Message-ID: <CAK7LNATAyCUNkWv+NqKz7HZGRsjByZYsADf=d9-JT_QAh56S3Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] scripts/faddr2line: Constrain readelf output to
 symbols from System.map
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 11:30=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Thu, Aug 03, 2023 at 04:54:37AM +0900, Masahiro Yamada wrote:
> > On Fri, Jul 28, 2023 at 8:34=E2=80=AFPM Will Deacon <will@kernel.org> w=
rote:
> > >
> > > Some symbols emitted in the readelf output but filtered from System.m=
ap
> > > can confuse the 'faddr2line' symbol size calculation, resulting in th=
e
> > > erroneous rejection of valid offsets. This is especially prevalent wh=
en
> > > building an arm64 kernel with CONFIG_CFI_CLANG=3Dy, where most functi=
ons
> > > are prefixed with a 32-bit data value in a '$d.n' section. For exampl=
e:
> > >
> > > 447538: ffff800080014b80   548 FUNC    GLOBAL DEFAULT    2 do_one_ini=
tcall
> > >    104: ffff800080014c74     0 NOTYPE  LOCAL  DEFAULT    2 $x.73
> > >    106: ffff800080014d30     0 NOTYPE  LOCAL  DEFAULT    2 $x.75
> > >    111: ffff800080014da4     0 NOTYPE  LOCAL  DEFAULT    2 $d.78
> > >    112: ffff800080014da8     0 NOTYPE  LOCAL  DEFAULT    2 $x.79
> > >     36: ffff800080014de0   200 FUNC    LOCAL  DEFAULT    2 run_init_p=
rocess
> > >
> > > Adding a warning to do_one_initcall() results in:
> > >
> > >   | WARNING: CPU: 0 PID: 1 at init/main.c:1236 do_one_initcall+0xf4/0=
x260
> > >
> > > Which 'faddr2line' refuses to accept:
> > >
> > > $ ./scripts/faddr2line vmlinux do_one_initcall+0xf4/0x260
> > > skipping do_one_initcall address at 0xffff800080014c74 due to size mi=
smatch (0x260 !=3D 0x224)
> > > no match for do_one_initcall+0xf4/0x260
> > >
> > > Filter out entries from readelf using the 'sysmap-ignored-syms.sed'
> > > script used to construct System.map, so that the size of a symbol is
> > > calculated as a delta to the next symbol present in ksymtab.
> >
> >
> > I do not think this patch set is the right approach.
> >
> > I assume faddr2line is meant to work with both vmlinux
> > and modules.
>
> Huh, it seems to be busted for modules :/ I get:
>
>  | error: unknown argument '--section=3D.text'
>
> with llvm and:
>
>  | addr2line: DWARF error: invalid or unhandled FORM value: 0x25
>
> with binutils.
>
> I'll look into this, as I don't think it's related to symbol filtering.
>
> > A problem is that we have different filtering policies wrt kallsyms.
> >
> > scripts/mksysmap filters symbols in vmlinux,
> > while kernel/module/kallsyms.c filters ones in modules.
>
> I don't understand why we need two different ways of filtering out
> symbols, but it appears that the module case only filters out local
> labels and mapping symbols, both of which are filtered out of vmlinux
> as well. Is that right?


For vmlinux kallsyms, the reason is the annoyance in the build process.
kallsyms requires linking vmlinux three times.
(see scripts/link-vmlinux.sh if you are interested)


[1a] link vmlinux without symbol table
[1b] Generate symbol list from [1a]
[2a] link vmlinux, embedding the temp kallsyms created by [1b]
[2b] Generate symbol list from [2a]
[3a] link vmlinux, embedding the final kallsyms created by [2b]


Our assumption is that [1b] and [2b] have the same number of
symbols, so that [2a] and [3a] can embed the same size kallsyms.


However, the process [2a] inserts the kallsyms table
in the middle of vmlinux.
It may cause the compiler to emit additional symbols
(e.g. ARM veneers) due to the inserted kallsyms.


So, we filter out all compiler-generated symbols so that
[1b] and [2b] have the same number of symbols.


If we do not do it,
we may have more and more kallsyms steps.

Emitted veneers increase kallsyms size
-> Increased kallsyms causes more veneers
-> The new veneers increase kallsyms size
-> Increased kallsyms causes yet more veneers
-> The new veneers increase kallsyms size again
-> (this cycle may continue again and again)






> > This patch tries to get aligned with the stacktrace of vmlinux,
> > but that does not seem optimal to the stacktrace of modules.
> >
> >
> > I have not checked the details, but I guess
> > the module kallsyms filters less symbols.
> >
> > https://github.com/torvalds/linux/blob/v6.5-rc4/kernel/module/kallsyms.=
c#L288
> >
> > I prefer filtering symbols in the intersection of vmlinux and modules.
>
> I think mksysmap filters out a superset of the symbols which are filtered
> for modules, so why is the intersection the right thing to do? That will
> mean that faddr2line considers a whole bunch of symbols that aren't in
> the ksymtab of vmlinux.



If A is a subset of B,
(A & B) =3D=3D A.


I meant "the intersection of the filtering rules of vmlinux and modules"
=3D=3D "the filtering rule of modules".







>
> > is_mapping_symbol() filters symbols you are addressing.
>
> That's a C function and faddr2line is a shell script. What exactly do
> you want me to do? My first hack just matched on symbols starting with
> '$' but I ended up with this after other review feedback.


In linux-next, I see this:

static inline int is_mapping_symbol(const char *str)
{
        if (str[0] =3D=3D '.' && str[1] =3D=3D 'L')
                return true;
        if (str[0] =3D=3D 'L' && str[1] =3D=3D '0')
                return true;
        return str[0] =3D=3D '$';
}


It is pretty easy to write a sed script to do the same thing.





Another possibility is to use different filtering rules
between vmlinux and modules.
(but I do not know if this complexity is worthwhile)



[pseudo code]


get_symbol_list () {

    if [ "${is_vmlinux}" =3D 1 ]; then
            {READELF} --symbols --wide $objfile | sed -f
scripts/sysmap-ignored-syms.sed
    else
            {READELF} --symbols --wide $objfile | sed  'remove ".L", 'L0", =
"^$"'
    fi
}




>
> Josh -- how do you want to proceed here?
>
> Will



--=20
Best Regards
Masahiro Yamada
