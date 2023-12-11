Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A85880DDF2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345506AbjLKWEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345291AbjLKWEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:04:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE76CA1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702332252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FCxm2ZNk4xG6rdSANJGBUV8Z7ODrKWPtn4AqES4irEA=;
        b=K5uaWQmvfNDeOfyyS03m06gIuq73TKyC6kwWSJbTSBCZCguXXSk3O2x9SNqlT5sE/W3/wk
        T61Ki9A0WVxEBnccpUzv15abwGT+0RTfJTFzfjKtSM2qoR0VtXzoPIjKWLIEhOYSbn5uUK
        xHWt1OZXUqgMd+8hFG5fQPi44fe2wAE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-MEG2z7eMM2CRr9nNwpZJwQ-1; Mon, 11 Dec 2023 17:04:10 -0500
X-MC-Unique: MEG2z7eMM2CRr9nNwpZJwQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d03b873765so34613225ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702332249; x=1702937049;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FCxm2ZNk4xG6rdSANJGBUV8Z7ODrKWPtn4AqES4irEA=;
        b=OHXHxEbWE6K0g/C1WN+5xZpFDzDqJuWiWGpTbIogoXLb1ednO/bhW4lwbyuQxstQei
         nZbIel58U7l/+9GvRWJrAY4Rb4BMUDC5F3oJUlv5U3pYW5jizO8tQskccdk+3zvR8R6v
         w2sVYLPekUQ0MVLZlxP82IIJcrwItI10QGaV48OecfBVHErd0Z3ZkQ77Q+b8eNAtF8c1
         qHstEaSl4Cr7WqZCyfauiLkB5iulcuPeb+loKVtgE9LYIAdufnWobIt7C8j/h9RGEdfT
         52ln9glBX9xYvqiUsZcqLYDrkRhJlrSJpia5jSzdVuk1bJn9whu2z38+tOWzC7EYZQlJ
         IL9Q==
X-Gm-Message-State: AOJu0YxMI//muEjGoiHflvvARe0YR7Bn7aba3/x6ImUzdhQf5PXhjO2R
        t8FjtP863pbgt0xp6kKZ/PJ7GII+HuSrBkl66n2Q5XMBf+0h4qbTVucJADENm9x+59eZfFLbmEo
        FtNFikN5EkWP8zXTXfjzqH6KB
X-Received: by 2002:a17:903:22ca:b0:1d0:700b:3f7b with SMTP id y10-20020a17090322ca00b001d0700b3f7bmr7952129plg.53.1702332249188;
        Mon, 11 Dec 2023 14:04:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEukaZOlkPqR1TXFO85wGFwXddVUVGVhPviVyN2FuBWvTB40MsESc1PRlfh8WNSzgylWaLcog==
X-Received: by 2002:a17:903:22ca:b0:1d0:700b:3f7b with SMTP id y10-20020a17090322ca00b001d0700b3f7bmr7952106plg.53.1702332248841;
        Mon, 11 Dec 2023 14:04:08 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:3102:945e:6f76:fb73:6512])
        by smtp.gmail.com with ESMTPSA id c21-20020a170902b69500b001d1d1ef8be6sm7133768pls.267.2023.12.11.14.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:04:08 -0800 (PST)
From:   lsoaresp@redhat.com
X-Google-Original-From: masahiroy@kernel.org
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Leonardo Bras <leobras@redhat.com>, lsoaresp@redhat.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [RFC PATCH v5 1/1] scripts: Introduce a default git.orderFile
Date:   Mon, 11 Dec 2023 19:03:50 -0300
Message-ID: <ZXeHRmTIMmIqeNxn@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAK7LNARUYBS3Nd83M7uEtPt_GjUGK2jDGEJk9SBBedUKgb911g@mail.gmail.com>
References: <20231208181802.88528-3-leobras@redhat.com> <CAK7LNAQk3Nm53qf95p7yQbSQ_M3phD_n5OMGxFWorGg_4fpQZg@mail.gmail.com> <ZXcLEKSBg9Bd1qEu@LeoBras> <CAK7LNARUYBS3Nd83M7uEtPt_GjUGK2jDGEJk9SBBedUKgb911g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonardo Bras <leobras@redhat.com>

On Tue, Dec 12, 2023 at 03:05:38AM +0900, Masahiro Yamada wrote:
> On Mon, Dec 11, 2023 at 10:14 PM <lsoaresp@redhat.com> wrote:
> >
> > From: Leonardo Bras <masahiroy@kernel.org>
> >
> > On Sun, Dec 10, 2023 at 04:13:54AM +0900, Masahiro Yamada wrote:
> > > On Sat, Dec 9, 2023 at 3:19 AM Leonardo Bras <leobras@redhat.com> wrote:
> > > >
> > > > When reviewing patches, it looks much nicer to have some changes shown
> > > > before others, which allow better understanding of the patch before the
> > > > the .c files reviewing.
> > > >
> > > > Introduce a default git.orderFile, in order to help developers getting the
> > > > best ordering easier.
> > > >
> > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > > >
> > > > ---
> > > > Changes since RFCv4:
> > > > - Added scripts/* into "build system" section
> > > > - Added "git-specific" section with this script and .gitignore
> > > > - Thanks for this feedback Nicolas!
> > > >
> > > > Changes since RFCv3:
> > > > - Added "*types.h" matching so type headers appear before regular headers
> > > > - Removed line ends ($) in patterns: they previously provided a
> > > >   false-positive
> > > > - Fixed build patterns to allow matching Kconfig, Kbuild & Makefile
> > > >   in any subdirectory
> > > >
> > > > Changes since RFCv2:
> > > > - Fixed licence comment to from /**/ to #
> > > > - Fixed filename in how-to comment
> > > > - Fix build order: Kconfig -> Kbuild -> Makefile
> > > > - Add *.mk extension
> > > > - Add line-ends ($) to make sure and get the correct extensions
> > > > - Thanks Masahiro Yamada for above suggestions!
> > > > - 1 Ack, thanks Randy!
> > > >
> > > > Changes since RFCv1:
> > > > - Added Kconfig* (thanks Randy Dunlap!)
> > > > - Changed Kbuild to Kbuild* (improve matching)
> > > >
> > > >
> > > >  scripts/git.orderFile | 39 +++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 39 insertions(+)
> > > >  create mode 100644 scripts/git.orderFile
> > > >
> > > > diff --git a/scripts/git.orderFile b/scripts/git.orderFile
> > > > new file mode 100644
> > > > index 0000000000000..31649ff53d22c
> > > > --- /dev/null
> > > > +++ b/scripts/git.orderFile
> > > > @@ -0,0 +1,39 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +# order file for git, to produce patches which are easier to review
> > > > +# by diffing the important stuff like header changes first.
> > > > +#
> > > > +# one-off usage:
> > > > +#   git diff -O scripts/git.orderFile ...
> > > > +#
> > > > +# add to git config:
> > > > +#   git config diff.orderFile scripts/git.orderFile
> > > > +#
> > > > +
> > > > +MAINTAINERS
> > > > +
> > > > +# Documentation
> > > > +Documentation/*
> > > > +*.rst
> > > > +
> > > > +# git-specific
> > > > +.gitignore
> > > > +scripts/git.orderFile
> > >
> >
> > Hello Masahiro, thanks for the feedback!
> >
> > >
> > >
> > > I think scripts/git.orderFile should be part of
> > > "scripts/*" below.
> > >
> > >
> > >
> > >
> > >
> > >
> > > > +
> > > > +# build system
> > > > +*Kconfig*
> > > > +*Kbuild*
> > > > +*Makefile*
> > >
> > > I do not like this because "foo-Makefile-bar"
> > > is not a Makefile, but would match "*Makefile*".
> >
> > That makes sense.
> >
> > >
> > >
> > > If you do not use wildcard at all, 'Makefile'
> > > will match to the root-dir and sub-directories.
> >
> > I tried a quick test here changing an mm/*.c file and mm/Makefile, and the
> > above will print the .c file changes first in any situation here, so it
> > won't have the desired behavior.
> 
> 
> 
> Hmm, you are right.
> 
> 
> OK, your suggestion below looks good.
> 
> 
> Thanks.

Thank you for this feedback!

I will send a v6 shortly.

Thank you!
Leo

> 
> 
> 
> 
> 
> 
> >
> > But if we want to achieve the above we can do so with a slight change in
> > the suggestion:
> >
> > >
> >>
> > > Kconfig
> > > */Kconfig*
> > > Kbuild
> > > Makefile
> > */Makefile
> > > *.mak
> > > *.mk
> > > scripts/*
> > >
> > >
> > > may satisfy your needs mostly.
> > >
> >
> > I have tried the following in the Kernel root:
> >
> > $ find . |grep Makefile |grep -v Makefile$
> > ./arch/arm/mach-s3c/Makefile.s3c64xx
> > ./arch/mips/Makefile.postlink
> > ./arch/powerpc/Makefile.postlink
> > ./arch/um/Makefile-os-Linux
> > ./arch/um/Makefile-skas
> > ./arch/um/scripts/Makefile.rules
> > ./arch/x86/Makefile_32.cpu
> > ./arch/x86/Makefile.um
> > ./arch/x86/Makefile.postlink
> > ./arch/riscv/Makefile.postlink
> > ./drivers/firmware/efi/libstub/Makefile.zboot
> > ./drivers/usb/serial/Makefile-keyspan_pda_fw
> > [...]
> >
> > $ find . |grep Kbuild |grep -v Kbuild$
> > ./arch/mips/Kbuild.platforms
> > ./scripts/Kbuild.include
> >
> > Which leads to an honest question:
> > Don't we want to show changes on those files before C files, for example?
> >
> > If so, we need something like:
> >
> > # build system
> > Kconfig*
> > */Kconfig*
> > Kbuild*
> > */Kbuild*
> > Makefile*
> > */Makefile*
> > *.mak
> > *.mk
> > scripts/*
> >
> > It would get rid of "foo-Makefile-bar" case but still match
> > "Makefile-bar" case, which seems to be used around.
> >
> > Is that ok?
> >
> > Thanks!
> > Leo
> >
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
> 

