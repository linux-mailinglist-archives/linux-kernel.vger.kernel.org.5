Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D281789705
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 15:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjHZNu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 09:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjHZNun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 09:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AC8196;
        Sat, 26 Aug 2023 06:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48A2761C4E;
        Sat, 26 Aug 2023 13:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C8BC433C9;
        Sat, 26 Aug 2023 13:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693057839;
        bh=Fx0ykHx0pNDD6niOOrl/sUxUuuQvr/tZR+BnAAo15pE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sVWksqEXMcOZHqAzP3hwx55a4FWSXBrtQM4h9F13aAQTvoa0rvIoPATu5gD9OQieY
         FoYG5ziwaHcpEViM2bkKLJXViWtldKs/ochrhENAf5qWYSf/KgGnCKsO+n20t/7ZFb
         ivbhm+wfYyHpJrsMdXYxZIcf8tjWJ+ttQhqvFEiDIA722Jcsexkx0hQu3ICSYDpZIT
         nMXyg2j605Ol1Fy9M243y2dIroGotP/YVzTmA6L+U3AXsTR20LDE9wH44/2Z8h+quf
         o0Be6iEJciebsD+2Wr275qA9viHMal82jNf2clSQu9Wt2bVLyTuhOb6HIBqgwTJ08u
         lZ/9Yqt012ZKw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1c4de3b9072so1235471fac.3;
        Sat, 26 Aug 2023 06:50:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YzlkGUlPvohBKCNhL355/OZYbIDd8yVz1Yw/D4Egdf3sS1VhiSD
        rZsvlnYIcn4H+kWfkSNTg+I16F3dCH98rktwXs8=
X-Google-Smtp-Source: AGHT+IHHPY9IRXlBGirs7lut2lBPwktP6EwURIokVBDmgUIv1M4UrdgI+HYxT+L4ICOlTdMYJ6Rgj3aoGq+81wK+cEw=
X-Received: by 2002:a05:6870:d18a:b0:1c8:bf19:e1df with SMTP id
 a10-20020a056870d18a00b001c8bf19e1dfmr7298050oac.13.1693057838939; Sat, 26
 Aug 2023 06:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230823115048.823011-1-masahiroy@kernel.org> <20230823115048.823011-3-masahiroy@kernel.org>
 <ZOZjq4dl0hthWaVT@bergen.fjasle.eu>
In-Reply-To: <ZOZjq4dl0hthWaVT@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 26 Aug 2023 22:50:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNASK9cHsf2qPpFKzQ+dMyucF9xR7V2xd3HwLeffmEJn+og@mail.gmail.com>
Message-ID: <CAK7LNASK9cHsf2qPpFKzQ+dMyucF9xR7V2xd3HwLeffmEJn+og@mail.gmail.com>
Subject: Re: [PATCH 3/8] kbuild: move depmod rule to scripts/Makefile.modinst
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Thu, Aug 24, 2023 at 8:30=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu> =
wrote:
>
> On Wed 23 Aug 2023 20:50:43 GMT, Masahiro Yamada wrote:
> > depmod is a part of the module installation.
> >
> > scripts/Makefile.modinst is a better place to run it.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  Makefile                 |  8 --------
> >  scripts/Makefile.modinst |  9 +++++++++
> >  scripts/depmod.sh        | 10 ++++++----
> >  3 files changed, 15 insertions(+), 12 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index e2dfa3b994f7..c9c8019e4720 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -509,7 +509,6 @@ LEX               =3D flex
> >  YACC         =3D bison
> >  AWK          =3D awk
> >  INSTALLKERNEL  :=3D installkernel
> > -DEPMOD               =3D depmod
> >  PERL         =3D perl
> >  PYTHON3              =3D python3
> >  CHECK                =3D sparse
> > @@ -1871,15 +1870,8 @@ PHONY +=3D modules_check
> >  modules_check: $(MODORDER)
> >       $(Q)$(CONFIG_SHELL) $(srctree)/scripts/modules-check.sh $<
> >
> > -quiet_cmd_depmod =3D DEPMOD  $(MODLIB)
> > -      cmd_depmod =3D $(CONFIG_SHELL) $(srctree)/scripts/depmod.sh $(DE=
PMOD) \
> > -                   $(KERNELRELEASE)
> > -
> >  modules_install:
> >       $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
> > -ifndef modules_sign_only
> > -     $(call cmd,depmod)
> > -endif
> >
> >  else # CONFIG_MODULES
> >
> > diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> > index ab0c5bd1a60f..7a64ece9b826 100644
> > --- a/scripts/Makefile.modinst
> > +++ b/scripts/Makefile.modinst
> > @@ -86,6 +86,15 @@ $(dst)/%.ko: $(extmod_prefix)%.ko FORCE
> >       $(call cmd,strip)
> >       $(call cmd,sign)
> >
> > +__modinst: depmod
> > +
> > +PHONY +=3D depmod
> > +depmod: $(modules)
> > +     $(call cmd,depmod)
> > +
> > +quiet_cmd_depmod =3D DEPMOD  $(MODLIB)
> > +      cmd_depmod =3D $(srctree)/scripts/depmod.sh $(KERNELRELEASE)
>
> Did you remove the $(CONFIG_SHELL) by intention?


Yes.
I do not know why $(CONFIG_SHELL) is needed.

I remove $(CONFIG_SHELL) when I have a chance to touch the line.


> > +
> >  else
> >
> >  $(dst)/%.ko: FORCE
> > diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> > index fca689ba4f21..ee771ccb1f9c 100755
> > --- a/scripts/depmod.sh
> > +++ b/scripts/depmod.sh
> > @@ -3,12 +3,14 @@
> >  #
> >  # A depmod wrapper used by the toplevel Makefile
>
> toplevel Makefile -> scripts/Makefile.modinst


Good catch.
I will fix it.


> >
> > -if test $# -ne 2; then
> > -     echo "Usage: $0 /sbin/depmod <kernelrelease>" >&2
> > +if test $# -ne 1; then
> > +     echo "Usage: $0 <kernelrelease>" >&2
> >       exit 1
> >  fi
> > -DEPMOD=3D$1
> > -KERNELRELEASE=3D$2
> > +
> > +KERNELRELEASE=3D$1
> > +
> > +: ${DEPMOD:=3Ddepmod}
> >
> >  if ! test -r System.map ; then
> >       echo "Warning: modules_install: missing 'System.map' file. Skippi=
ng depmod." >&2
> > --
> > 2.39.2
>
> A minor observation: with this patch, the "quiet_cmd_*" examples in
> Makefile and in Documentation/kbuild/makefiles.rst become out-dated.


I was opposed to eb38f37c3cee08a0197bdc7bbb9b4e02e40e2300

The section "Script invocation" is not what I ack'ed.

That is what Kees Cook and Andrew Morton did.









>
> But technically, it looks good to me, thus:
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>



--
Best Regards
Masahiro Yamada
