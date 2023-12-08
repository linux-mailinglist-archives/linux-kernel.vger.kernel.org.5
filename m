Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D25F80AB96
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574611AbjLHSEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbjLHSE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:04:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801DE10D8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702058674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZQgPsmonl7Wi7hg4g+zI/qzT5CWeAjHhow4pzmW6d4=;
        b=e1nkeHN3rxldvn6BtaVEEmalXMy/h1SLAA5eZv2CGLyUm3OhLjLXNJrSXGkLsXAIn1eh12
        rnt3HCM8ireXtTdxRNbhPdxGROXsjRMhT74lEwQz+z3VRV5FRic6FRYKrcSsdMblO0UH9z
        /GStxonRUs38WpIoHl5/EBXOGS2D3hw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-zi2y-Qi-Ok2-d_rMfNPhQg-1; Fri, 08 Dec 2023 13:04:33 -0500
X-MC-Unique: zi2y-Qi-Ok2-d_rMfNPhQg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4259975e20dso14320671cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 10:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702058673; x=1702663473;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZQgPsmonl7Wi7hg4g+zI/qzT5CWeAjHhow4pzmW6d4=;
        b=DddQcc3iLk1bbErYplokTln0tIJHfE70642H31YydYvcqz6hxQxIkjiZ2TDVH9BV2z
         Kdk/Z0ojfs4YOgN+G1ELFHCezKMsja6D2T1THohsiZpoGtxSgBv2LOxR+/Fq51bBYW/H
         Ce6iTjZT0GPJ7QJHpjJ3nuuYdsCN4LBpHPu735Dba2GSYGOcPSYMDvjmIuLt61M/E4g1
         NyPTA5AH3qVhdR1ngkuswdCbsGwPg4OBqsV6rNHQgt60vZJjR5SHouy9FJBuxbToX+e0
         gabgshp2gwfu96AyJpsaaHNuuNylHoQ4Pk85EMnqvX2mxm0UoK1tXGouWcrppPFaBfo1
         Pigw==
X-Gm-Message-State: AOJu0Ywip4edmiqnrCZ0CORQa48I7sv1nE5/W7tWoAc8OJehZfx0iEPR
        3RPHGkvsCCryxbyvRooVZEDKBelqOrGLFpCvOK0mbL1Zq0WQ8QUvGZYD51tdvmXVuBmvdxoHDMz
        pqWTNyGFMq4ywRUHpUvbND5QxkcdcqtxVSxgD/b9j
X-Received: by 2002:ac8:57c3:0:b0:425:4043:8d3c with SMTP id w3-20020ac857c3000000b0042540438d3cmr493110qta.87.1702058672798;
        Fri, 08 Dec 2023 10:04:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcQR0AzrXqX8g8QkJ9bHKVbYFY+AcmSXI0mII0WLkYN3Ixd7BiYzX6ZGozilt9HvxSt3eT1+HOAIIlVMeL7L8=
X-Received: by 2002:ac8:57c3:0:b0:425:4043:8d3c with SMTP id
 w3-20020ac857c3000000b0042540438d3cmr493094qta.87.1702058672516; Fri, 08 Dec
 2023 10:04:32 -0800 (PST)
MIME-Version: 1.0
References: <20231205182853.40627-1-leobras.c@gmail.com> <ZXMXOPxyx7YGB43l@buildd.core.avm.de>
In-Reply-To: <ZXMXOPxyx7YGB43l@buildd.core.avm.de>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Fri, 8 Dec 2023 15:04:16 -0300
Message-ID: <CAJ6HWG6AvwAA0e3J=oSXmjYbzqwidsPRD9SrDL==TAuONh5oWg@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH v4 1/1] scripts: Introduce a default git.orderFile
To:     Leonardo Bras <leobras.c@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 10:25=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu> =
wrote:
>
> On Tue, Dec 05, 2023 at 03:28:51PM -0300, Leonardo Bras wrote:
> > From: Leonardo Bras <leobras@redhat.com>
> >
> > When reviewing patches, it looks much nicer to have some changes shown
> > before others, which allow better understanding of the patch before the
> > the .c files reviewing.
> >
> > Introduce a default git.orderFile, in order to help developers getting =
the
> > best ordering easier.
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
> >
> > Please provide feedback on what else to add / remove / reorder here!
> >
> > Changes since RFCv3:
> > - Added "*types.h" matching so type headers appear before regular heade=
rs
> > - Removed line ends ($) in patterns: they previously provided a
> >   false-positive
> > - Fixed build patterns to allow matching Kconfig, Kbuild & Makefile
> >   in any subdirectory
> >
> > Changes since RFCv2:
> > - Fixed licence comment to from /**/ to #
> > - Fixed filename in how-to comment
> > - Fix build order: Kconfig -> Kbuild -> Makefile
> > - Add *.mk extension
> > - Add line-ends ($) to make sure and get the correct extensions
> > - Thanks Masahiro Yamada for above suggestions!
> > - 1 Ack, thanks Randy!
> >
> > Changes since RFCv1:
> > - Added Kconfig* (thanks Randy Dunlap!)
> > - Changed Kbuild to Kbuild* (improve matching)
> >
> >
> >  scripts/git.orderFile | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >  create mode 100644 scripts/git.orderFile
> >
> > diff --git a/scripts/git.orderFile b/scripts/git.orderFile
> > new file mode 100644
> > index 000000000000..7cef02cbba3c
> > --- /dev/null
> > +++ b/scripts/git.orderFile
> > @@ -0,0 +1,34 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# order file for git, to produce patches which are easier to review
> > +# by diffing the important stuff like header changes first.
> > +#
> > +# one-off usage:
> > +#   git diff -O scripts/git.orderFile ...
> > +#
> > +# add to git config:
> > +#   git config diff.orderFile scripts/git.orderFile
> > +#
> > +
> > +MAINTAINERS
> > +
> > +# Documentation
> > +Documentation/*
> > +*.rst
> > +
> > +# build system
> > +*Kconfig*
> > +*Kbuild*
> > +*Makefile*
> > +*.mak
> > +*.mk
>
> I'd like to see 'scripts/*' here, too, to have the build system stuff
> together.  Possibly it makes sense to add .gitignore files here too.
>
> Kind regards,
> Nicolas

Sure, I will add it and send a v5 soon.

Thanks!

>
>
> > +
> > +# semantic patches
> > +*.cocci
> > +
> > +# headers
> > +*types.h
> > +*.h
> > +
> > +# code
> > +*.c
> > --
> > 2.42.0
> >
>

