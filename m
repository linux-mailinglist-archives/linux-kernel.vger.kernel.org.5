Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA8F7797C2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbjHKT2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjHKT2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:28:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702D130E6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 12:28:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E3BC67961
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 19:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C71C433C7;
        Fri, 11 Aug 2023 19:28:19 +0000 (UTC)
Date:   Fri, 11 Aug 2023 15:28:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Split out sprintf() and friends
Message-ID: <20230811152817.010e1da3@gandalf.local.home>
In-Reply-To: <37faa9c7-94a3-3ea1-f116-6ff5cdf021cd@rasmusvillemoes.dk>
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
        <ZNTjbtNhWts5i8Q0@smile.fi.intel.com>
        <37faa9c7-94a3-3ea1-f116-6ff5cdf021cd@rasmusvillemoes.dk>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 16:17:57 +0200
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> > Btw, it's easy to enforce IIUC, i.e. by dropping
> > 
> >   #ifndef _FOO_H
> >   #define _FOO_H
> >   #endif
> > 
> > mantra from the headers.
> >   
> 
> No, you can't do that, because some headers legitimately include other
> headers, often for type definitions. Say some struct definition where
> one of the members is another struct (struct list_head being an obvious
> example). Or a static inline function.
> 
> We _also_ don't want to force everybody who includes a.h to ensure that
> they first include b.h because something in a.h needs stuff from b.h.
> 
> So include guards must be used. They are a so well-known idiom that gcc
> even has special code for handling them: If everything in a foo.h file
> except comments is inside an ifndef/define/endif, gcc remembers that
> that foo.h file has such an include guard, so when gcc then encounters
> some #include directive that would again resolve to that same foo.h, and
> the include guard hasn't been #undef'ed, it doesn't even do the syscalls
> to open/read/close the file again.

I hope Andy was just joking with that recommendation.

-- Steve
