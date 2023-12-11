Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDF680CA98
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343592AbjLKNOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKNOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:14:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500E4C4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702300449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TGpqgCQoHA7gfzhcNnMoEqvxE+usWH3FO302tA/0S5M=;
        b=hrqiR4jJTa8jkcQsfpBiQD8Wf+Y+ibxpkIzKCgYgnaasUWHFNWoX9P7BMK5ijck4DYm6p9
        2KtBIUVZJDsIZJtMom0PhEK+mzSS6IfjW6tXpmhwtj6pPVx01/lNwhyxhuRfSXZnIxGa3q
        slNoAAnXxIkum7xNo0SHELJKKCA4V7w=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-t1hT2rKKMtSAMxaSpC0q1Q-1; Mon, 11 Dec 2023 08:14:07 -0500
X-MC-Unique: t1hT2rKKMtSAMxaSpC0q1Q-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c641d55e27so2762190a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702300446; x=1702905246;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGpqgCQoHA7gfzhcNnMoEqvxE+usWH3FO302tA/0S5M=;
        b=WGVjPoLHsGI1KksOxHBonon7SxApfIXFysvVVQr5tC8uv3Nbd51LmyqOAFxqmQLTKA
         mFKvIgAmWwu+5RCdcmWHLhYJfORIs9tqWrwtw5zOquI6TrlJD/UvEcIxGrtlMbAAd9T9
         ELswGjpTPP+Vt9RnEspv21D7Vks0RJiBjgHhn4i4UZ6JI+B0jDUXqHpWD294VLiVZhXv
         QWkrQd0Cyl/LwQZ96g/ZZLwKaXxkeQ3MvLqQQiHYZ6PM0xr2CfeQ+GjhCqPX8M7cZiY3
         rP4eTDS20ttb5z0UNkjTiKqQt/Wse7uClBgMhJgP7jYxu8UVb4DKrTllhnd08bab/v1r
         u3qA==
X-Gm-Message-State: AOJu0Yz6Vea8OV2TwvuJxaG3HDGwAM2dbdnZNTPVm7Y2ujJxIfE9I170
        HjEPI3D40nj6PfcHOAtAvL7gLM554ZlmnpNjRB8Apm7yo2miL4kPutxVA1RiFD1uvzGlyAspvT0
        dMgwCr6HcRqnR6C1xpQNisgoT
X-Received: by 2002:a05:6a20:da8b:b0:18f:cbdd:3244 with SMTP id iy11-20020a056a20da8b00b0018fcbdd3244mr5741495pzb.47.1702300446351;
        Mon, 11 Dec 2023 05:14:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYDcYxzezUOmmhjHqlN4rLUWgtQEen04kcE0D4OK/TFGjbw/Oh2gm3pI95zLhzVQRBecYWIQ==
X-Received: by 2002:a05:6a20:da8b:b0:18f:cbdd:3244 with SMTP id iy11-20020a056a20da8b00b0018fcbdd3244mr5741484pzb.47.1702300445976;
        Mon, 11 Dec 2023 05:14:05 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a802:3102:945e:6f76:fb73:6512])
        by smtp.gmail.com with ESMTPSA id s16-20020a62e710000000b006ce3bf7acc7sm6177155pfh.113.2023.12.11.05.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 05:14:05 -0800 (PST)
From:   lsoaresp@redhat.com
X-Google-Original-From: masahiroy@kernel.org
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Leonardo Bras <leobras@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [RFC PATCH v5 1/1] scripts: Introduce a default git.orderFile
Date:   Mon, 11 Dec 2023 10:13:52 -0300
Message-ID: <ZXcLEKSBg9Bd1qEu@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAK7LNAQk3Nm53qf95p7yQbSQ_M3phD_n5OMGxFWorGg_4fpQZg@mail.gmail.com>
References: <20231208181802.88528-3-leobras@redhat.com> <CAK7LNAQk3Nm53qf95p7yQbSQ_M3phD_n5OMGxFWorGg_4fpQZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonardo Bras <masahiroy@kernel.org>

On Sun, Dec 10, 2023 at 04:13:54AM +0900, Masahiro Yamada wrote:
> On Sat, Dec 9, 2023 at 3:19 AM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > When reviewing patches, it looks much nicer to have some changes shown
> > before others, which allow better understanding of the patch before the
> > the .c files reviewing.
> >
> > Introduce a default git.orderFile, in order to help developers getting the
> > best ordering easier.
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> >
> > ---
> > Changes since RFCv4:
> > - Added scripts/* into "build system" section
> > - Added "git-specific" section with this script and .gitignore
> > - Thanks for this feedback Nicolas!
> >
> > Changes since RFCv3:
> > - Added "*types.h" matching so type headers appear before regular headers
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
> >  scripts/git.orderFile | 39 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644 scripts/git.orderFile
> >
> > diff --git a/scripts/git.orderFile b/scripts/git.orderFile
> > new file mode 100644
> > index 0000000000000..31649ff53d22c
> > --- /dev/null
> > +++ b/scripts/git.orderFile
> > @@ -0,0 +1,39 @@
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
> > +# git-specific
> > +.gitignore
> > +scripts/git.orderFile
> 

Hello Masahiro, thanks for the feedback!

> 
> 
> I think scripts/git.orderFile should be part of
> "scripts/*" below.
> 
> 
> 
> 
> 
> 
> > +
> > +# build system
> > +*Kconfig*
> > +*Kbuild*
> > +*Makefile*
> 
> I do not like this because "foo-Makefile-bar"
> is not a Makefile, but would match "*Makefile*".

That makes sense.

> 
> 
> If you do not use wildcard at all, 'Makefile'
> will match to the root-dir and sub-directories.

I tried a quick test here changing an mm/*.c file and mm/Makefile, and the 
above will print the .c file changes first in any situation here, so it 
won't have the desired behavior.

But if we want to achieve the above we can do so with a slight change in 
the suggestion:

> 
> 
> Kconfig
> */Kconfig*
> Kbuild
> Makefile
*/Makefile
> *.mak
> *.mk
> scripts/*
> 
> 
> may satisfy your needs mostly.
> 

I have tried the following in the Kernel root:

$ find . |grep Makefile |grep -v Makefile$
./arch/arm/mach-s3c/Makefile.s3c64xx
./arch/mips/Makefile.postlink
./arch/powerpc/Makefile.postlink
./arch/um/Makefile-os-Linux
./arch/um/Makefile-skas
./arch/um/scripts/Makefile.rules
./arch/x86/Makefile_32.cpu
./arch/x86/Makefile.um
./arch/x86/Makefile.postlink
./arch/riscv/Makefile.postlink
./drivers/firmware/efi/libstub/Makefile.zboot
./drivers/usb/serial/Makefile-keyspan_pda_fw
[...]

$ find . |grep Kbuild |grep -v Kbuild$
./arch/mips/Kbuild.platforms
./scripts/Kbuild.include

Which leads to an honest question: 
Don't we want to show changes on those files before C files, for example?

If so, we need something like:

# build system
Kconfig*
*/Kconfig*
Kbuild*
*/Kbuild*
Makefile*
*/Makefile*
*.mak
*.mk
scripts/*

It would get rid of "foo-Makefile-bar" case but still match 
"Makefile-bar" case, which seems to be used around.

Is that ok?

Thanks!
Leo

