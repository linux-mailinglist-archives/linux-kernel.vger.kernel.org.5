Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A87077BCCE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjHNPRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjHNPQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:16:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193E110FA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:16:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 81B9321905;
        Mon, 14 Aug 2023 15:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692026173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EW4Ch8A2iSc+Cjz4p0CqaXWCxLaA43Mv5OGHJCgj2xA=;
        b=ezgzhu83p6oWGk71Fx1X1G7X543PTAjkBRQovadZLFfAmMPsJEYWpGhnxC1WMNnUrFm6cQ
        OvBJzkEA9BgIb3X/N75LyJl5OYunfLALUbPt3WRkMlkxcl27SA6VGGY/OODgoXKj1ylPBi
        LoGZ/MkyB3n4yNLkEi+qQR9aghpZVKc=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D31712C143;
        Mon, 14 Aug 2023 15:16:12 +0000 (UTC)
Date:   Mon, 14 Aug 2023 17:16:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Split out sprintf() and friends
Message-ID: <ZNpFO38u9zfPRHvf@alley>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
 <ZNEHt564a8RCLWon@alley>
 <ZNEJQkDV81KHsJq/@smile.fi.intel.com>
 <ZNEJm3Mv0QqIv43y@smile.fi.intel.com>
 <ZNEKNWJGnksCNJnZ@smile.fi.intel.com>
 <ZNHjrW8y_FXfA7N_@alley>
 <ZNI5f+5Akd0nwssv@smile.fi.intel.com>
 <ZNScla_5FXc28k32@alley>
 <67ddbcec-b96f-582c-a38c-259234c3f301@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ddbcec-b96f-582c-a38c-259234c3f301@rasmusvillemoes.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-08-10 11:09:20, Rasmus Villemoes wrote:
> On 10/08/2023 10.15, Petr Mladek wrote:
> 
> > Everyone agrees that kernel.h should be removed. But there are always
> > more possibilities where to move the definitions. For this, the use
> > in C files must be considered. Otherwise, it is just a try&hope approach.
> > 
> >> Also, please, go through all of them and tell, how many of them are using
> >> stuff from kernel.h besides sprintf.h and ARRAY_SIZE() (which I plan
> >> for a long time to split from kernel.h)?
> > 
> > I am all for removing vsprintf declarations from linux.h.
> > 
> > I provided the above numbers to support the idea of moving them
> > into printk.h.
> > 
> > The numbers show that the vsprintf function famility is used
> > quite frequently. IMHO, creating an extra tiny include file
> > will create more harm then good. By the harm I mean:
> > 
> >     + churn when updating 1/6 of source files
> 
> Well, we probably shouldn't do 5000 single-line patches to add that
> sprintf.h include, and another 10000 to add an array-macros.h include
> (just as an example). Some tooling and reasonable batching would
> probably be required. Churn it will be, but how many thousands of
> patches were done to make i2c drivers' probe methods lose a parameter
> (first converting them all to .probe_new, then another round to again
> assign to .probe when that prototype was changed). That's just the cost
> of any tree-wide change in a tree our size.

OK.

> >     + prolonging the list of #include lines in .c file. It will
> >       not help with maintainability which was one of the motivation
> >       in this patchset.
> 
> We really have to stop pretending it's ok to rely on header a.h
> automatically pulling in b.h, if a .c file actually uses something
> declared in b.h.

Yes, we need to find some ballance.

> >     + an extra work for people using vsprintf function family in
> >       new .c files. People are used to get them for free,
> >       together with printk().
> 
> This is flawed. Not every C source file does a printk, or uses anything
> else from printk.h. E.g. a lot of drivers only do the dev_err() family,
> some subsystems have their own wrappers, etc. So by moving the
> declarations to printk.h you just replace the kernel.h with something
> equally bad (essentially all existing headers are bad because they all
> include each other recursively). Also, by not moving the declarations to
> a separate header, you're ignoring the fact that your own numbers show
> that 5/6 of the kernel's TUs would become _smaller_ by not having to
> parse those declarations. And the 1/6 that do use sprintf() may become
> smaller by thousands of lines once they can avoid kernel.h and all that
> that includes recursively.

OK, I did some grepping:

## total number of .c files
pmladek@alley:/prace/kernel/linux> find . -name *.c | wc -l
32319

# printk() usage:

## .c files with printk() calls:
$> git grep  "printk(\|pr_\(emerg\|alert\|crit\|err\|warn\|notice\|info\|cont\|debug\)(" | cut -d ":" -f 1 | uniq | grep "\.c$" | wc -l
8966

    => 28% .c files use printk() directly

## .h files with printk() calls:
$> git grep  "printk(\|pr_\(emerg\|alert\|crit\|err\|warn\|notice\|info\|cont\|debug\)(" | cut -d ":" -f 1 | uniq | grep "\.h$" | wc -l
1006

   => the number is probably much higher because it is also used
      in 1000+ header files.


# vprintf() usage:

## .c files where printk() functions are use without vprintf() functions
$> grep -f printf.list -v  printk.list | wc -l
6725

  => 21% .c files use vprintf() functions directly


# unique usage:

## .c files where vprintf() family functions are used directly
$> git grep sc*n*printf | cut -d : -f1 | uniq | grep "\.c$" | wc -l
5254

  => 75% .c of files using printk() are not using vprintf()

## .c files where vprintf() functions are use without printk() functions
$> grep -f printk.list -v  printf.list | wc -l
3045

  => 45% .c of files using vprintf() are not using printk()


My view:

The overlap will likely be bigger because vprintk() family is often
used directly in .c files but printk() is quite frequently used
indirectly via .h files.

But still, there seems to be non-trivial number of .c files which use
vprintf() and not printk().

=> The split might help after all.

In each case, I do not want to discuss this to the death. And will
not block this patch.

Best Regards,
Petr
