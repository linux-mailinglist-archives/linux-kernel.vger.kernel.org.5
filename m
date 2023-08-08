Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C20677368D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjHHCZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjHHCZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:25:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AED3170B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:25:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8DED6237D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 02:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A04C433C7;
        Tue,  8 Aug 2023 02:24:58 +0000 (UTC)
Date:   Mon, 7 Aug 2023 22:24:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Split out sprintf() and friends
Message-ID: <20230807222455.27874f80@gandalf.local.home>
In-Reply-To: <ZNEJQkDV81KHsJq/@smile.fi.intel.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
        <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
        <ZNEHt564a8RCLWon@alley>
        <ZNEJQkDV81KHsJq/@smile.fi.intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2023 18:09:54 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Aug 07, 2023 at 05:03:19PM +0200, Petr Mladek wrote:
> > On Sat 2023-08-05 20:50:26, Andy Shevchenko wrote:  
> > > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > > sprintf() and friends are used in many drivers without need of the full
> > > kernel.h dependency train with it.
> > > 
> > > Here is the attempt on cleaning it up by splitting out sprintf() and
> > > friends.  
> 
> ...
> 
> > I agree that kernel.h is not the right place. But are there any
> > numbers how much separate sprintf.h might safe?
> > Maybe, we should not reinvent the wheel and get inspired by
> > userspace.
> > 
> > sprintf() and friends are basic functions which most people know
> > from userspace. And it is pretty handy that the kernel variants
> > are are mostly compatible as well.
> > 
> > IMHO, it might be handful when they are also included similar way
> > as in userspace. From my POV printk.h is like stdio.h. And we already
> > have include/linux/stdarg.h where the v*print*() function might
> > fit nicely.
> > 
> > How does this sound, please?  
> 
> Not every user (especially _header_) wants to have printk.h included just for
> sprintf.h that may have nothing to do with real output. So, same reasoning
> from me as keeping that in kernel.h, i.e. printk.h no better.
> 

If you separate out the sprintf() into its own header and still include
that in kernel.h, then for what you said in the other email:

> What to do with _headers_ that include kernel.h for no reason other than
> sprintf.h (as an example)? Your suggestion, please?

It can include sprintf.h (or printk.h or stdio.h, whatever) instead of kernel.h.

What's the issue?

-- Steve
