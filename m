Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E647E62D0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 05:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjKIE1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 23:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjKIE05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 23:26:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285D12698;
        Wed,  8 Nov 2023 20:26:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C43C433D9;
        Thu,  9 Nov 2023 04:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699504014;
        bh=fYQ8cjKX+19C1ihpDV96mhTpvzL7G65cypI0SSFKxGw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j2CZ2TTrhO1fN0g5hgbqiKYkiAChrvPzbRi0YXwmLxeJ85FkuLLZXsvWx67JMKycP
         nZcjh2r9FD3kaoAHvI+SLnyzcoHAm5mXLJV75PfQDgzq0ayGLS50EnX50ymi3ltSNv
         WlM7C2tuLfk1Yq8syDyxY+EAoNnyFMdT/8K3dv8vgutniLt+VcWEbo9WYIRVfv37FP
         AqanfMFmxRiIbIl15n5chg/ETDNGvTkvk4TuGEt6vOCE4KlN93cWwp9vcrAnzf7cNH
         T7CCZL2M/06KNcPl9/sJr9q+4SztmKBtM9pN9yUp1pHCF6OsUdjD/18ZMWTfxmS2An
         5vmqPyiNBCPQw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1f0f94a08a0so252518fac.2;
        Wed, 08 Nov 2023 20:26:54 -0800 (PST)
X-Gm-Message-State: AOJu0YxXm5OZ2KjQdQwon1bKcr3E+6rWoVjz7hoUF4XOYJMGMZXT+R9T
        yesiZdXJcg53HVCbO2OhTBjbtBHvqHNMs7ZhlVE=
X-Google-Smtp-Source: AGHT+IH8ctNVx9dH7eRJZUdvO7bLpKn+oyNzQkQPB6hniLZVGLKtruPtho9VRjW/UrUxb5JWngllKNeyw+bzhVQX4Uc=
X-Received: by 2002:a05:6870:6586:b0:1f0:aff:333c with SMTP id
 fp6-20020a056870658600b001f00aff333cmr4924051oab.46.1699504013905; Wed, 08
 Nov 2023 20:26:53 -0800 (PST)
MIME-Version: 1.0
References: <20231104222715.3967791-1-yoann.congal@smile.fr>
 <CAK7LNAS6J5Nh8nOUHbaf123yd1Z-1q--FvB1ok8GQcoNorAROw@mail.gmail.com> <20231107210004.GA2065849@dev-arch.thelio-3990X>
In-Reply-To: <20231107210004.GA2065849@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 9 Nov 2023 06:26:16 +0200
X-Gmail-Original-Message-ID: <CAK7LNARpJ9huseh-Ro9v8W_tabMof9cuUZO43gi-hfEnXG4FYA@mail.gmail.com>
Message-ID: <CAK7LNARpJ9huseh-Ro9v8W_tabMof9cuUZO43gi-hfEnXG4FYA@mail.gmail.com>
Subject: Re: [PATCH v5] kconfig: avoid an infinite loop in oldconfig/syncconfig
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Yoann Congal <yoann.congal@smile.fr>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Brandon Maier <brandon.maier@collins.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 11:00=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Sun, Nov 05, 2023 at 04:55:57PM +0900, Masahiro Yamada wrote:
> > On Sun, Nov 5, 2023 at 7:27=E2=80=AFAM Yoann Congal <yoann.congal@smile=
.fr> wrote:
> > >
> > > Exit on error when asking for value and reading stdin returns an erro=
r
> > > (mainly if it has reached EOF or is closed).
> > >
> > > This infinite loop happens in particular for hex/int configs without =
an
> > > explicit default value.
> > >
> > > Previously, this case would loop:
> > > * oldconfig prompts for the value but stdin has reached EOF
> > > * It gets the global default value : an empty string
> > > * This is not a valid hex/int value so it prompts again, hence the
> > >   infinite loop.
> > >
> > > This case happens with a configuration like this (a hex config withou=
t a
> > > valid default value):
> > >   config TEST_KCONFIG
> > >        hex "Test KConfig"
> > >        # default 0x0
> > >
> > > And using:
> > >   make oldconfig < /dev/null
> > >
> > > This was discovered when working on Yocto bug[0] on a downstream
> > > kconfig user (U-boot)
> > >
> > > [0]: https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14136
> > >
> > > CC: Brandon Maier <brandon.maier@collins.com>
> > > Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> >
> > Applied to linux-kbuild.
> > Thanks.
>
> For what it's worth, this change breaks our continuous integration [1]
> because tuxmake explicitly uses /dev/null as stdin to make for
> non-interactive commands (I think it does this as basically the
> equivalent of "yes '' | make" in Python), so the error will always
> occur.
>
> Before:
>
> $ curl -LSso .config https://gitlab.archlinux.org/archlinux/packaging/pac=
kages/linux/-/raw/main/config
>
> # Same as 'make < /dev/null' but still
> $ python3 -c "import subprocess; subprocess.run(['make', '-j128'], stdin=
=3Dsubprocess.DEVNULL)"
>   SYNC    include/config/auto.conf
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/confdata.o
>   HOSTCC  scripts/kconfig/expr.o
>   LEX     scripts/kconfig/lexer.lex.c
>   YACC    scripts/kconfig/parser.tab.[ch]
>   HOSTCC  scripts/kconfig/menu.o
>   HOSTCC  scripts/kconfig/preprocess.o
>   HOSTCC  scripts/kconfig/symbol.o
>   HOSTCC  scripts/kconfig/util.o
>   HOSTCC  scripts/kconfig/lexer.lex.o
>   HOSTCC  scripts/kconfig/parser.tab.o
>   HOSTLD  scripts/kconfig/conf
> *
> * Restart config...
> *
> ...
> Error in reading or end of file.
>
>   GEN     arch/x86/include/generated/asm/orc_hash.h
>   WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
>   WRAP    arch/x86/include/generated/uapi/asm/errno.h
> ...
>
> After:
>
> $ curl -LSso .config https://gitlab.archlinux.org/archlinux/packaging/pac=
kages/linux/-/raw/main/config
>
> $ python3 -c "import subprocess; subprocess.run(['make', '-j128'], stdin=
=3Dsubprocess.DEVNULL)"
>   SYNC    include/config/auto.conf
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/confdata.o
>   HOSTCC  scripts/kconfig/expr.o
>   LEX     scripts/kconfig/lexer.lex.c
>   YACC    scripts/kconfig/parser.tab.[ch]
>   HOSTCC  scripts/kconfig/menu.o
>   HOSTCC  scripts/kconfig/preprocess.o
>   HOSTCC  scripts/kconfig/symbol.o
>   HOSTCC  scripts/kconfig/util.o
>   HOSTCC  scripts/kconfig/lexer.lex.o
>   HOSTCC  scripts/kconfig/parser.tab.o
>   HOSTLD  scripts/kconfig/conf
> *
> * Restart config...
> *
> ...
> Error in reading or end of file.
> make[3]: *** [scripts/kconfig/Makefile:77: syncconfig] Error 1
> ...
>
> We have been doing this for some time and never run across an infinite
> loop in syncconfig. Can this be improved?



In Linux, most int/hex entries have a default,
hence there is no practical issue.

I will drop this for now.

I will send an alternative solution.








--
Best Regards
Masahiro Yamada
