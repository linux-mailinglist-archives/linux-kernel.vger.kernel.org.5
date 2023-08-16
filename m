Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA7177E48C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343928AbjHPPCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343921AbjHPPBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:01:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3987710FF;
        Wed, 16 Aug 2023 08:01:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ED5F5218FC;
        Wed, 16 Aug 2023 15:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692198105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cwYr/ImenycskpSCIbuvxpPgA8pKU0LOXJlUOQJJlZc=;
        b=BAoXAjr4dRq9QYTkYjPQ3T3bey6O/p4hgNk6aSHnyCuZaN4++Hsb7G0+qFVygkvUE+zIgP
        8Jp8g2/w4YONjyYfeGas0oTPBrHD0zfP5ikMwGNG1bj0klYLJFD+nsNenQGwWzIEHUz/Lk
        ZSg1XKUJBkBw+gkrUhoXnUw4tSibH14=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3CD052C146;
        Wed, 16 Aug 2023 15:01:45 +0000 (UTC)
Date:   Wed, 16 Aug 2023 17:01:43 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        ndesaulniers@google.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] lib: test_scanf: Add explicit type cast to result
 initialization in test_number_prefix()
Message-ID: <ZNzk1yIvCy7EF_EF@alley>
References: <20230807-test_scanf-wconstant-conversion-v2-1-839ca39083e1@kernel.org>
 <ZNysmicYHHQ3f1Ck@alley>
 <20230816140112.GA2109327@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816140112.GA2109327@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-08-16 07:01:12, Nathan Chancellor wrote:
> Hi Petr,
> 
> On Wed, Aug 16, 2023 at 01:01:46PM +0200, Petr Mladek wrote:
> > On Mon 2023-08-07 08:36:28, Nathan Chancellor wrote:
> > > A recent change in clang allows it to consider more expressions as
> > > compile time constants, which causes it to point out an implicit
> > > conversion in the scanf tests:
> > > 
> > >   lib/test_scanf.c:661:2: warning: implicit conversion from 'int' to 'unsigned char' changes value from -168 to 88 [-Wconstant-conversion]
> > >     661 |         test_number_prefix(unsigned char,       "0xA7", "%2hhx%hhx", 0, 0xa7, 2, check_uchar);
> > >         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >   lib/test_scanf.c:609:29: note: expanded from macro 'test_number_prefix'
> > >     609 |         T result[2] = {~expect[0], ~expect[1]};                                 \
> > >         |                       ~            ^~~~~~~~~~
> > >   1 warning generated.
> > > 
> > > The result of the bitwise negation is the type of the operand after
> > > going through the integer promotion rules, so this truncation is
> > > expected but harmless, as the initial values in the result array get
> > > overwritten by _test() anyways. Add an explicit cast to the expected
> > > type in test_number_prefix() to silence the warning. There is no
> > > functional change, as all the tests still pass with GCC 13.1.0 and clang
> > > 18.0.0.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Closes: https://github.com/ClangBuiltLinux/linux/issues/1899
> > 
> > "Closes:" is not a valid tag. It was proposed and rejected in the end.
> > I replaced it with "Link:" as suggested by ./scripts/checkpatch.pl/
> 
> I don't really care about "Closes:" vs. "Link:", either is fine with me,
> but checkpatch.pl did not warn me about it and I still see commit
> 44c31888098a ("checkpatch: allow Closes tags with links") in mainline
> and -next that explicitly allows this (and even requires Closes: instead
> of Link: when following Reported-by:).

Good to know. It is possible that I mixed this with another tag.
I recall that people wanted to add some new tags recently and
Linus was strongly against it. Unfortunately, I can't find
the discussion now.

It seems that the Closes: tag is acceptable. But Linus is still
going to "put my foot down" when it gets misused, see
https://lore.kernel.org/linux-doc/CAHk-=wh0v1EeDV3v8TzK81nDC40=XuTdY2MCr0xy3m3FiBV3+Q@mail.gmail.com/

I called the checkpatch.pl from printk/linux.git in a branch based on 6.4.
It did not have the commit 44c31888098a ("checkpatch: allow Closes
tags with links").

If you do not mind, I'll keep the "Link:" tag to avoid rebase in
the for-6.6 branch in printk/linug.git.


> > The patch has been pushed into printk/linux.git, branch for-6.6.
> 
> Thanks a lot for the review and acceptance!

You are welcome.

Best Regards,
Petr
