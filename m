Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56867A292C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbjIOVOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238128AbjIOVNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:13:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8DF1727
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:13:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B3FC433C9;
        Fri, 15 Sep 2023 21:13:09 +0000 (UTC)
Date:   Fri, 15 Sep 2023 17:13:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [GIT PULL] tracing: Add eventfs file to help with debugging any
 more issues
Message-ID: <20230915171334.5c231ca7@gandalf.local.home>
In-Reply-To: <CAHk-=whNU3JaPMq_E7mwVGpTKxxeQxV=13o84u-tTeqfB_t05g@mail.gmail.com>
References: <20230913192905.0a92bcab@gandalf.local.home>
        <CAHk-=whAkgy10YVwjQGn1AO=1ZFc193ujvMXwmDOJAc=Jaeg5A@mail.gmail.com>
        <20230915163637.77c673a6@gandalf.local.home>
        <CAHk-=whNU3JaPMq_E7mwVGpTKxxeQxV=13o84u-tTeqfB_t05g@mail.gmail.com>
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

On Fri, 15 Sep 2023 13:50:17 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 15 Sept 2023 at 13:36, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I'm OK with it not going in now, but instead I'll wrap an ifdef around it
> > and move it to my queue for the next merge window. I still would like to
> > keep these "what's going on internally" available, as I'll ask people to
> > enable them when they report an issue.  
> 
> Honestly, you copied the pattern from the /proc filesystem.

I didn't actually copy it, even though the /proc filesystem does something
similar (I didn't even know that it did until I presented this idea for
eventfs in LSFMM, and someone told me that /proc did so too).

I tried to look at how /proc does things and I couldn't really use it as
easily, because proc uses its own set of "proc_ops", and I had some
different requirements.

> 
> The /proc filesyustem is widely used and has never had this kind of
> random debugging code in mainline.

Again, it is implemented differently.

> 
> Seriously, that eventfs_file thing is not worthy of this kind of
> special debug code.
> 
> That debug code seems to be approaching the same order of size as all
> the code evetfs_file code itself is.

You mean the event_show.c code?

> 
> There's a point where this kind of stuff just becomes ridiculous. At
> least wait until there's a *reason* to debug a simple linked list of
> objects.
> 
> If you have a hard time figuring out what the eventfs entries are,
> maybe you should just have made "iterate_shared" show them, and then
> you could use fancy tools like "ls" to see what the heck is up in that
> directory?
> 

I was more interested in what did not exist than what existed. I wanted to
make sure that things were cleaned up properly. One of my tests that I used
was to do a: find /sys/kernel/tracing/events, and then run my ring_buffer
memory size stress test (that keeps increasing the size of the ring buffer
to make sure it fails safely when it runs out of memory). Then I check to make
sure all the unused dentries and inodes were reclaimed nicely, as they hang
around until a reclaim is made.

It did prove useful for the initial debugging, but it also helped a lot for
the new code I have saved for the next merge window. That code changes the
internal interface quite drastically.

The current code has meta data for every file in the eventfs (defined by the
eventfs_file structure). The new code has meta data only for the events
themselves (which map to the directories) and I remove the eventfs_file
entirely. It uses a callback from the eventfs code to create the dentries
and inodes of the files on the fly (there's no meta data representing the
individual files).

  https://lore.kernel.org/linux-trace-kernel/20230914163535.269645249@goodmis.org/

Now I use this debug file to know what files are added, and more
importantly, not added.

Are you entirely against this file, or is it fine if it's just wrapped
around an CONFIG_EVENTFS_DEBUG?

-- Steve
