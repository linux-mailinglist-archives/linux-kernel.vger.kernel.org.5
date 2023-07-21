Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7AD75CA03
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjGUO20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGUO2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:28:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9CFE68;
        Fri, 21 Jul 2023 07:28:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D85EC61CB8;
        Fri, 21 Jul 2023 14:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB84C433CA;
        Fri, 21 Jul 2023 14:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689949702;
        bh=jFC4uO+SoEFg6fMBatOpafybt9O/eA/aXgnox0sXwsg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=giZqR0dckrxJGrv0GAeSdqNtZ0FjShQdmze5IXx/8ChwNzW/enjsdlFafn6eKxXkp
         USO2VBT/XZw4KwpqMzzykxi6+xU6NLz1eQCvOTTUs3s2GxSswC6RZGUfP7FtAfHqBx
         YjapxDBohJ/MIprTfVp6CPCSZW7Fdu74T3LkYmBRFmRTGo1ciPZBPyu3CKCy/1+OGO
         RXeQk2QnHusDN82dq9lp24CCU7dt3M1XaiA9cSUNAqpCzZ7gMV7M40GXX7TyNsBlC2
         Gpbul5C+6WPOy9fL44LNbRgpsaIdEtWGeg5ZsV7Bn1RZMEXz8ZkAboJ1jM1yRqKdLX
         KG9fCysowgCEw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1b3c503af99so1487602fac.0;
        Fri, 21 Jul 2023 07:28:22 -0700 (PDT)
X-Gm-Message-State: ABy/qLalqhCYA242ZZVYfkw8LuYPF23CP5LB9n3/urFyK/RcpDNOkcVy
        cLJCB/vWtEaZY4RPVG+ezggiFLGkpONw2K/5EBY=
X-Google-Smtp-Source: APBJJlF+sVhobbUf9rz2ZFy72uhXOOKvl7kQX4yfqoYx14HS05Fs+/XRHKh1ky00HF9rgc6k03Gavm9OHVnwr17/Pf4=
X-Received: by 2002:a05:6870:65ac:b0:1b8:5d9e:638b with SMTP id
 fp44-20020a05687065ac00b001b85d9e638bmr2405624oab.43.1689949701604; Fri, 21
 Jul 2023 07:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <4f414a87-0c54-44bd-b218-f6f0b22c57ef@p183> <ZLEmgxm73zzmffWD@fjasle.eu>
 <4dc7e56c-6692-4d4c-a8d2-05abe4501e66@p183>
In-Reply-To: <4dc7e56c-6692-4d4c-a8d2-05abe4501e66@p183>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 21 Jul 2023 23:27:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNATPM=NhVnHnoyKv=kUEmNru7-Z9oNKMe7MChidRJfECvQ@mail.gmail.com>
Message-ID: <CAK7LNATPM=NhVnHnoyKv=kUEmNru7-Z9oNKMe7MChidRJfECvQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: flatten KBUILD_CFLAGS
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Nicolas Schier <nicolas@fjasle.eu>, akpm@linux-foundation.org,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 2:45=E2=80=AFAM Alexey Dobriyan <adobriyan@gmail.co=
m> wrote:
>
> On Fri, Jul 14, 2023 at 12:42:11PM +0200, Nicolas Schier wrote:
> > On Thu, Jul 13, 2023 at 09:52:28PM +0300, Alexey Dobriyan wrote:
> > > Make it slightly easier to see which compiler options are added and
> > > removed (and not worry about column limit too!).
> > >
> > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > > ---
> > >
> > >  Makefile |   22 +++++++++++++++++-----
> > >  1 file changed, 17 insertions(+), 5 deletions(-)
> > >
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -555,11 +555,23 @@ LINUXINCLUDE    :=3D \
> > >             $(USERINCLUDE)
> > >
> > >  KBUILD_AFLAGS   :=3D -D__ASSEMBLY__ -fno-PIE
> > > -KBUILD_CFLAGS   :=3D -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-=
trigraphs \
> > > -              -fno-strict-aliasing -fno-common -fshort-wchar -fno-PI=
E \
> > > -              -Werror=3Dimplicit-function-declaration -Werror=3Dimpl=
icit-int \
> > > -              -Werror=3Dreturn-type -Wno-format-security -funsigned-=
char \
> > > -              -std=3Dgnu11
> > > +
> > > +KBUILD_CFLAGS :=3D
> > > +KBUILD_CFLAGS +=3D -std=3Dgnu11
> >
> > If you want to put -std at top, on contrast to the sorted options below=
,
> > you could also merge the two lines above.
>
> I don't know. Standard choice is arguably the most important option
> so I put it first.
>
> > > +KBUILD_CFLAGS +=3D -fshort-wchar
> > > +KBUILD_CFLAGS +=3D -funsigned-char
> > > +KBUILD_CFLAGS +=3D -fno-common
> > > +KBUILD_CFLAGS +=3D -fno-PIE
> > > +KBUILD_CFLAGS +=3D -fno-strict-aliasing
> > > +KBUILD_CFLAGS +=3D -Wall
> > > +KBUILD_CFLAGS +=3D -Wundef
> > > +KBUILD_CFLAGS +=3D -Werror=3Dimplicit-function-declaration
> > > +KBUILD_CFLAGS +=3D -Werror=3Dimplicit-int
> > > +KBUILD_CFLAGS +=3D -Werror=3Dreturn-type
> > > +KBUILD_CFLAGS +=3D -Werror=3Dstrict-prototypes
> > > +KBUILD_CFLAGS +=3D -Wno-format-security
> > > +KBUILD_CFLAGS +=3D -Wno-trigraphs


Applied to linux-kbuild.
Thanks.


--=20
Best Regards
Masahiro Yamada
