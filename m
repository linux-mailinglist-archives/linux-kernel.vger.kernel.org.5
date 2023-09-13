Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A43479E118
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbjIMHqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238665AbjIMHqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:46:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31E8A1988
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694591143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJ0/lr6QXBbD+gn1JCIJap3j3vOzhQGe1bIXF/sS6z4=;
        b=D9+/J/ncdnU8dfeRXKyT7XW+UW31mtQEoLv4FdIEKz1CVZ45fsk9U4emZ2LSt3+2PBdrOZ
        kdpNZEB8/rYnUl/bME1r3XaHfrIJV/BuZTayNf4ilgpNCJlkEyNxGfjlJ79A8lHuC4bylQ
        JKCzQW3WNXIRVe66pqoA1/N2UkIM1V4=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-Fs_boNnpMLadyL3FL3iTcw-1; Wed, 13 Sep 2023 03:45:41 -0400
X-MC-Unique: Fs_boNnpMLadyL3FL3iTcw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1bf00f8cf77so7718111fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694591141; x=1695195941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ0/lr6QXBbD+gn1JCIJap3j3vOzhQGe1bIXF/sS6z4=;
        b=UZGhe8qJJJ8kb3KJJtg0lv2Zsmc7OILxyXnCyh6H+2vH0g1PzdJMAKeIlfG1Yk261I
         XOEPXCv8Fn0HknzQrgYJ6JD1IAB/2FaEqL7A/LYpFgBkU/2RUIlaDy+GDUZdUypfrFJb
         +TvDr3ufwGXa0F24Qiw0Wj62j9w1ydR+2aPwIHujHveMYEQ5ZbsH/nnr8OmpDyLD1Gga
         uRXhNMQ0jYBNJYF2w1YBgJ7hQAhbODFZUoOBaoENUUU11B87UgPPO3tmHxNgOtlc5Tmh
         OWFSNNrJ/ERqeE/wEGeWDlFfQpfCkDYuDHCOKFTaVQbC606wc5iIQrwzZ47IQUZm6SOT
         NKaw==
X-Gm-Message-State: AOJu0YzvprZf7uNUf3eY1z5wWiZUqzXlWAItDPFc6pYWU85UvwfTU71K
        7gARuhQ/3HkmdOqe0AVY2hZ/3reHPmYEqUrYXzrXtcDjiKVOZvNHR6buiBZqFY7VZb+t4f1f41G
        wjmLv4AH9M9RDTmR6u86fYal5
X-Received: by 2002:a05:6870:e98b:b0:1d5:8f05:39c1 with SMTP id r11-20020a056870e98b00b001d58f0539c1mr2039665oao.15.1694591141216;
        Wed, 13 Sep 2023 00:45:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq8Lnne3IyJgFJWzrWZ6/OQe1dp29IRH2vaaJwx7ZjyfYwFrE7TjkodPbmU9Bpk4yual7i8A==
X-Received: by 2002:a05:6870:e98b:b0:1d5:8f05:39c1 with SMTP id r11-20020a056870e98b00b001d58f0539c1mr2039652oao.15.1694591140894;
        Wed, 13 Sep 2023 00:45:40 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id ee43-20020a056870c82b00b001bbeef974aesm5964353oab.20.2023.09.13.00.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:45:40 -0700 (PDT)
Date:   Wed, 13 Sep 2023 04:45:35 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/1] scripts: Introduce a default git.orderFile
Message-ID: <ZQFon3WMmnKeTxRS@redhat.com>
References: <20230911234418.38154-2-leobras@redhat.com>
 <CAK7LNASKRoxLwz1jvsbbxv0=JQtySG4O7eN2+_PT6q20G7YT9g@mail.gmail.com>
 <ZQDBU7BcIe7XKWGz@redhat.com>
 <ZQFnHC2ApnUVFrXO@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQFnHC2ApnUVFrXO@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 04:39:08AM -0300, Leonardo Bras wrote:
> On Tue, Sep 12, 2023 at 04:51:47PM -0300, Leonardo Bras wrote:
> > On Tue, Sep 12, 2023 at 04:53:11PM +0900, Masahiro Yamada wrote:
> > > On Tue, Sep 12, 2023 at 8:45 AM Leonardo Bras <leobras@redhat.com> wrote:
> > > >
> > > > When reviewing patches, it looks much nicer to have some changes shown
> > > > before others, which allow better understanding of the patch before the
> > > > the .c files reviewing.
> > > >
> > > > Introduce a default git.orderFile, in order to help developers getting the
> > > > best ordering easier.
> > > >
> > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > ---
> > > >
> > > > Please provide feedback on what else to add / remove / reorder here!
> > > >
> > > > Changes since RFCv1:
> > > > - Added Kconfig* (thanks Randy Dunlap!)
> > > > - Changed Kbuild to Kbuild* (improve matching)
> > > >
> > > >  scripts/git.orderFile | 32 ++++++++++++++++++++++++++++++++
> > > >  1 file changed, 32 insertions(+)
> > > >  create mode 100644 scripts/git.orderFile
> > > >
> > > > diff --git a/scripts/git.orderFile b/scripts/git.orderFile
> > > > new file mode 100644
> > > > index 000000000000..819f0a957fe3
> > > > --- /dev/null
> > > > +++ b/scripts/git.orderFile
> > > > @@ -0,0 +1,32 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +
> > > 
> > > 
> > > Please use "# SPDX-License-Identifier: GPL-2.0".
> > > 
> > > /* ... */ is not a valid comment style for the orderfile.
> > 
> > Oh, you are right.
> > My bad, it was a last minute change.
> > 
> > > 
> > > 
> > > 
> > > 
> > > > +# order file for git, to produce patches which are easier to review
> > > > +# by diffing the important stuff like header changes first.
> > > > +#
> > > > +# one-off usage:
> > > > +#   git diff -O scripts/git.orderfile ...
> > > > +#
> > > > +# add to git config:
> > > > +#   git config diff.orderFile scripts/git.orderfile
> > > 
> > > 
> > > These comments are bogus.
> > > 
> > > 
> > > I guess this comment header was copied from QEMU,
> > 
> > Yes, I tried to adapt it from QEMU to kernel needs.
> > 
> > 
> > > but you changed the file path
> > > from scripts/git.orderfile to scripts/git.orderFile.
> > > 
> > > 
> > > You need to adjust the comment lines to
> > > 
> > > 
> > >     git diff -O scripts/git.orderFile ...
> > > 
> > >     git config diff.orderFile scripts/git.orderFile
> > > 
> > >
> > 
> > Adjusted, thanks!
> >  
> > > 
> > > Or, you need to get the file path back to scripts/git.orderfile
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > > +#
> > > > +
> > > > +MAINTAINERS
> > > > +
> > > > +# Documentation
> > > > +Documentation/*
> > > > +*.rst
> > > > +
> > > > +# build system
> > > > +Kbuild*
> > > > +Kconfig*
> > > > +Makefile*
> > > 
> > > 
> > > Kbuild* and Makefile* are interchangeable.
> > > (both are for GNU Make)
> > > 
> > > Kconfig* are different types.
> > > 
> > > 
> > > Better to arrange the order to
> > > 
> > > Kconfig*
> > > Kbuild*
> > > Makefile*
> > > 
> > > 
> > 
> > Oh, that makes sense.
> > Done!
> > 
> > > 
> > > 
> > > 
> > > > +*.mak
> > > 
> > > QEMU consistently uses only *.mak.
> > > 
> > > I just realized the kernel tree uses both *.mak and *.mk
> > > 
> > > masahiro@zoe:~/ref/linux(master)$ find .  -name '*.mak'
> > > ./tools/scripts/utilities.mak
> > > masahiro@zoe:~/ref/linux(master)$ find .  -name '*.mk'
> > > ./tools/testing/selftests/lib.mk
> > > ./tools/testing/selftests/ptp/testptp.mk
> > 
> > Sure, I will add '*.mk' after '*.mak', getting:
> > 
> > # build system
> > Kconfig*
> > Kbuild*
> > Makefile*
> > *.mak
> > *.mk
> > 
> > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > BTW, I quickly tested this, but
> > > it did not work as I expected.
> > > 
> > > 
> > > 
> > > 
> > > 
> > > masahiro@zoe:~/ref/linux(aaa)$ git diff --name-only d34599b^..d34599b
> > > MAINTAINERS
> > > drivers/Kconfig
> > > drivers/Makefile
> > > drivers/cache/Kconfig
> > > drivers/cache/Makefile
> > > drivers/cache/ax45mp_cache.c
> > > 
> > > masahiro@zoe:~/ref/linux(aaa)$ git diff --name-only -O
> > > scripts/git.orderFile d34599b^..d34599b
> > > MAINTAINERS
> > > drivers/cache/ax45mp_cache.c
> > > drivers/Kconfig
> > > drivers/Makefile
> > > drivers/cache/Kconfig
> > > drivers/cache/Makefile
> > > 
> > > masahiro@zoe:~/ref/linux(aaa)$ git diff --name-only -O
> > > scripts/git.orderFile d34599b..d34599b^
> > > MAINTAINERS
> > > drivers/cache/ax45mp_cache.c
> > > drivers/Kconfig
> > > drivers/Makefile
> > > drivers/cache/Kconfig
> > > drivers/cache/Makefile
> > > 
> > > 
> > > 
> > > 
> > > 
> > > My expectation was the following:
> > > 
> > > MAINTAINERS
> > > drivers/Kconfig
> > > drivers/cache/Kconfig
> > > drivers/Makefile
> > > drivers/cache/Makefile
> > > drivers/cache/ax45mp_cache.c
> > > 
> > > 
> > > It did not work like that.
> > > Am I missing something?
> > 
> > I can reproduce this same behavior for this commit list, and this is odd.
> > 
> > When I added a line-end at the .c extension, it works as expected:
> > 
> > *.c$
> > 
> > I think this makes sense. 
> > Just to make sure, I will add an line-end at every pattern with extension:
> > 
> > *.h$
> > *.c$
> > *.mk$
> 
> Oh, nevermind. This breaks the matching, and results are crazy.
> I will revert it on a v4.
> 
> The real solver is:
> */Kconfig*
> */Kbuild*
> */Makefile*

actually, to match root dir:

*Kconfig*
*Kbuild*
*Makefile*

> 
> The thing is that if I add just "Kconfig*" it only matches a Kconfig* in
> the root dir.
> 
> 
> > 
> > and so on.
> > Does that work for you?
> > 
> > 
> > I will send a v3 soon.
> > Thanks!
> > Leo
> > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > > +
> > > > +# semantic patches
> > > > +*.cocci
> > > > +
> > > > +# headers
> > > > +*.h
> 
> I was talking on a previous thread, and it would probably be interesting
> to add "*types.h" before *.h.
> 
> I need to think about a way to filter them out when matching "*.h", or it
> won't work because of:
> 
> Git doc:
> "The output order is determined by the order of glob patterns in <orderfile>.
> All files with pathnames that match the first pattern are output first, all
> files with pathnames that match the second pattern (but not the first) are
> output next, and so on."
> 
> i.e. the file will be put in the category of the last pattern it matches,
> and it makes harder to get "*types.h" before "*.h".
> 
> Trying to think on some solution.

Arg, nevermind. The matching failure caused a lot of confusion in my mind.

It works fine if we do:

*types.h
*.h
*.c

Will send a v4 soon.

> 
> > > > +
> > > > +# code
> > > > +*.c
> > > > --
> > > > 2.42.0
> > > >
> > > 
> > > 
> > > 
> > > 
> > > 
> > > -- 
> > > Best Regards
> > > Masahiro Yamada
> > > 

