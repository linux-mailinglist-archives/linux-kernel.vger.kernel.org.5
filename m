Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5E67A0BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbjINRZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240675AbjINRZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:25:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36A646BA;
        Thu, 14 Sep 2023 10:24:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80430C433CA;
        Thu, 14 Sep 2023 17:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694712242;
        bh=ZhpxjopJ3z7akt/jZEVl/F9TEAnY0hg7X8xCLV/k4O4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wqui1O5qsQOM/LFdsntH0+UWUe/39BdypVs0luN1i69deScv28jm3hrnsmhl23i1k
         7viCHzhArkfZxTF7+1SzNq0Ah82tRT1enVRzTj4NO1lX2YhLNbkyY+2PuaZoOQf38c
         kqwaSQflYbmRzOrJyMd93qebTd+AF89+YVrObDprNnleECdpVXtIO8UEb9OIdzQeKl
         seZ5vZwS4VjuUlZjEqD40C7kzblInnLqNWwymqnuOnaBUB5OCagNHapwfb8QRc5pGW
         KV/X0vYq79lXvsg6YpahUg+Q8/jse6tl2TjmDGJuD3MM0K8C1RDMqYzxNllZ3MVTVw
         iq6bYM+2zmRSQ==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-570e63f5224so1252278eaf.0;
        Thu, 14 Sep 2023 10:24:02 -0700 (PDT)
X-Gm-Message-State: AOJu0YytmxBJIvVzljYUiQqEc02RzSef2UDIdAhXsqNGLLo/pICfWwJL
        svZyxg4BdrNl9yC+o9dWMSUCM1Fpqbw1Uwq20BY=
X-Google-Smtp-Source: AGHT+IEO0pCi2Heoq31RzLUH6a3auyQTpjglealoYA8QM+kxLMPJWJszSOXGY1R4oz8Es4NeOaAF6lXfBGI8KPhP+PY=
X-Received: by 2002:a05:6870:9691:b0:1a6:cfcc:befd with SMTP id
 o17-20020a056870969100b001a6cfccbefdmr1544368oaq.5.1694712241904; Thu, 14 Sep
 2023 10:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230913113801.1901152-1-arnd@kernel.org> <874jjwx44g.fsf@intel.com>
 <b2723c56-e2b0-4871-afbc-73cf6335ddca@app.fastmail.com>
In-Reply-To: <b2723c56-e2b0-4871-afbc-73cf6335ddca@app.fastmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 15 Sep 2023 02:23:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR9Jt0FQNRidcxY-OxMh7N238Xs33Tyj+dpTZ5wGow0wQ@mail.gmail.com>
Message-ID: <CAK7LNAR9Jt0FQNRidcxY-OxMh7N238Xs33Tyj+dpTZ5wGow0wQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kbuild: explain handling optional dependencies
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 11:57=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Thu, Sep 14, 2023, at 15:42, Jani Nikula wrote:
> > On Wed, 13 Sep 2023, Arnd Bergmann <arnd@kernel.org> wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> +Optional dependencies
> >> +~~~~~~~~~~~~~~~~~~~~~
> >> +
> >> +Some drivers are able to optionally use a feature from another module
> >> +or build cleanly with that module disabled, but cause a link failure
> >> +when trying to use that loadable module from a built-in driver.
> >> +
> >> +The most common way to express this optional dependency in Kconfig lo=
gic
> >> +uses the slighly counterintuitive
> >> +
> >> +  config FOO
> >> +    bool "Support for foo hardware"
> >> +    depends on BAR || !BAR
> >
> >       depends on BAR || BAR=3Dn
> >
> > seems to be an alternative that's about as common:
> >
> > $ git grep "depends on \([A-Z0-9_]\+\) || \!\1" | wc -l
> > 109
> > $ git grep "depends on \([A-Z0-9_]\+\) || \1=3Dn" | wc -l
> > 107
> >
> > Maybe worth mentioning both?
>
> I fear that would add more confusion than it avoids:
> "!BAR" is actually different from "BAR=3Dn", but
> "BAR || !BAR" is the same as "BAR || BAR=3Dn" here, and
> trying to explain this in the documentation would either
> make it incorrect or unhelpfully complicated.



The rules are already explained in line 231-278
of Documentation/kbuild/kconfig-language.rst


y, m, n are internally 2, 1, 0.

!A returns (2 - A).
A=3DB returns 2 if the equation is true, 0 otherwise.
A||B returns max(A,B)


Given those in my mind, this is simple math.

For each case of BAR=3Dy, =3Dm, =3Dn,

BAR               2       1       0
!BAR              0       1       2
BAR=3Dn             0       0       2
BAR||!BAR         2       1       2
BAR||BAR=3Dn        2       1       2
BAR!=3Dm||m         2       1       2


So, the last three are equivalent.
They are equally complicated and confusing, though.


After all, what we are doing is to create this matrix:

          |   WIREGUARD
          |   y     m     n
----------------------------
        y |   O     O     O
IPV6    m |   X     O     O
        n |   O     O     O



It is unclear why WIREGUARD must be entirely disabled
just because of the optional feature being modular.



My preference is to use IS_REACHABLE(CONFIG_IPV6)
instead of IS_ENABLED(CONFIG_IPV6)
under drivers/net/wireguard, then
get rid of "depends on IPV6 || !IPV6)




If you want to make it clearer on the Kconfig level,
perhaps the following is also possible.


config WIREGUARD
       tristate "WireGuard"

config WIREGUARD_IPV6
       def_bool y
       depends on WIREGUARD
       depends on IPV6 >=3D WIREGUARD

config IPV6
       tristate "IPV6"



--=20
Best Regards
Masahiro Yamada
