Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956E37BE4C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376424AbjJIPcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376478AbjJIPcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:32:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7C4A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:32:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 59C6121883;
        Mon,  9 Oct 2023 15:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696865523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d62XEW8XKPTcoU0glynyOQ05w6hdgeWLiF97a8kRHq0=;
        b=TW/9oEWKNWSna7FQsbODVfbpcaZ+ZgGnFWOBA0DmIl6p/QkhRrLM/o3qWWp5ZzcCLIMA02
        yNqJBBYy1GhSRP3yyUqGqn24HYpk/K2J44KoQkJyeB8DgDL5ArOr3bkn01neMdJsFMml+c
        PVVvbNCVY7D2t309YWxD7AYhIb9+RFw=
Received: from suse.cz (unknown [10.163.31.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D2F852C187;
        Mon,  9 Oct 2023 15:32:02 +0000 (UTC)
Date:   Mon, 9 Oct 2023 17:32:00 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: panic context: was: Re: [PATCH printk v2 04/11] printk: nbcon:
 Provide functions to mark atomic write sections
Message-ID: <ZSQc8ApLjlUpe80o@alley>
References: <ZRGvn4m2NGCn3Pef@alley>
 <87h6n5teos.fsf@jogness.linutronix.de>
 <ZSADUKp8oJ2Ws2vC@alley>
 <87il7hv2v2.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il7hv2v2.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2023-10-08 12:19:21, John Ogness wrote:
> Hi Petr,
> 
> On 2023-10-06, Petr Mladek <pmladek@suse.com> wrote:
> >> During the demo at LPC2022 we had the situation that there was a large
> >> backlog when a WARN was hit. With current mainline the first line of the
> >> WARN is put into the ringbuffer and then the entire backlog is flushed
> >> before storing the rest of the WARN into the ringbuffer. At the time it
> >> was obvious that we should finish storing the WARN message and then
> >> start flushing the backlog.
> >
> > This talks about the "emergency" context (WARN/OOPS/watchdog).
> > The system might be in big troubles but it would still try to continue.
> >
> > Do we really want to defer the flush also for panic() context?
> 
> We can start flushing right after the backtrace is in the
> ringbuffer. But flushing the backlog _before_ putting the backtrace into
> the ringbuffer was not desired because if there is a large backlog, the
> machine may not survive to get the backtrace out. And in that case it
> won't even be in the ringbuffer to be used by other debugging
> tools.

We really have to distinguish emergency and panic context!

> > I ask because I was not on LPC 2022 in person and I do not remember
> > all details.
> 
> The LPC2022 demo/talk was recorded:
> 
> https://www.youtube.com/watch?v=TVhNcKQvzxI
> 
> At 55:55 is where the situation occurred and triggered the conversation,
> ultimately leading to this new feature.

Thanks for the link. My understanding is that the following scenario
has happened:

1. System was booting and messages were being flushed using the kthread.

2. WARN() happened. It printed the 1st line, took over the per-console
   console lock and started flushing the backlog. There were still
   many pending messages from the boot.

3. NMI came and caused panic(). The panic context printed its first line,
   took over the console from the WARN context, flushed the rest
   of the backlog and continued printing/flushing more messages from
   the panic() context.


Problem:

People complained that they saw only the first line from WARN().
The related detailed info, including backtrace, was missing.

It was because panic() interrupted WARN() before it was able
to flush the backlog and print/flush all WARN() messages.


Proposed solution:

WARN()/emergency context should first store the messages and
flush them at the end.

It would increase the chance that all WARN() messages will
be stored in the ring buffer before NMI/panic() is called.

panic() would then flush all pending messages including
the stored WARN() messages.


Important:

The problem is that panic() interrupted WARN().

There is _no_ problem with interrupting panic().
Let me repeat, nested panic() is not possible!


> You may also want to reread my summary:
>
> https://lore.kernel.org/lkml/875yheqh6v.fsf@jogness.linutronix.de

Again, thanks for the pointer. Let me paste 2 paragraphs here:

<paste>
- Printing the backlog is important! If some emergency situation occurs,
  make sure the backlog gets printed.

- When an emergency occurs, put the full backtrace into the ringbuffer
  before flushing any backlog. This ensures that the backtrace makes it
  into the ringbuffer in case a panic occurs while flushing the backlog.
</paste>

My understanding is:

1st paragraph is the reason why:

   + we have three priorities: normal, emergency, panic

   + messages in normal context might be offloaded to kthread

   + emergency and panic context should try to flush the messages
     from this context.


2nd paragraph talks about that emergency context should first store
the messages and flush them later. And the important part:

     "in case a panic occurs while flushing the backlog.

     => panic might interrupt emergency

It clearly distinguishes emergency and panic context.


> as well as Linus' follow-up message:
> 
> https://lore.kernel.org/lkml/CAHk-=wieXPMGEm7E=Sz2utzZdW1d=9hJBwGYAaAipxnMXr0Hvg@mail.gmail.com

IMHO, the important part is:

<paste>
Yeah, I really liked the notion of doing the oops with just filling
the back buffer but still getting it printed out if something goes
wrong in the middle.
</paste>

He was talking about oops => emergency context

Also he wanted to get it out when something goes wrong in the middle
   => panic in the middle ?


And another paragraph:

<paste>
I doubt it ends up being an issue in practice, but basically I wanted
to just pipe up and say that the exact details of how much of the back
buffer needs to be flushed first _could_ be tweaked if it ever does
come up as an issue.
</paste>

Linus had doubts that there might be problems with too long backlog
in practice. And I have the doubts as well.

And this is my view. The deferred flush is trying to solve a corner
case and we are forgetting what blocked printk kthreads >10 years.

> > But it is tricky in panic(), see 8th patch at
> > https://lore.kernel.org/r/20230919230856.661435-9-john.ogness@linutronix.de
> >
> >    + nbcon_atomic_exit() is called only in one code path.
> 
> Correct. When panic() is complete and the machine goes into its infinite
> loop. This is also the point where it will attempt an unsafe flush, if
> it could not get the messages out yet.
> 
> >    + nbcon_atomic_flush_all() is used in other paths. It looks like
> >      a "Whack a mole" game to me.
> 
> Several different outputs occur during panic(). The flush is everywhere
> where something significant has been put into the ringbuffer and now it
> would be OK to flush it.

No, we could _never_ say that the flush is everywhere where something
important happens.

panic() might fail anywhere. The last printed message might be
an important clue. And it can be any message.


> >    + messages are never emitted by printk kthread either because
> >      CPUs are stopped or the kthread is not allowed to get the lock
> 
> Correct.
> 
> > I see only one positive of the explicit flush. The consoles would
> > not delay crash_exec() and the crash dump might be closer to
> > the point where panic() was called.
> 
> It's only about getting the critical messages into the ringbuffer before
> flushing. And since various things can go wrong during the many actions
> within panic(), it makes sense to flush in between those actions.

I am glad that we agree that "various things can go wrong during panic".

Are we sure that the patchset added the explicit flush right after
each possible problematic place? What about crash_exec(),
various kmsg dumpers, notifiers?


> > Otherwise I see only negatives => IMHO, we want to flush atomic
> > consoles synchronously from printk() in panic().
> >
> > Does anyone really want explicit flushes in panic()?
> 
> So far you are the only one speaking against it. I expect as time goes
> on it will get even more complex as it becomes tunable (also something
> we talked about during the demo).

From my POV:

1. We are just two people discussing it at the moment
      => word against word.

2. Please, try to read my reply again. I agreed with delaying the
   flush in emergency context.

   But I am strongly against explicit flushes during panic at
   least in the initial implementation.


3. IMHO, there might be a lot of misunderstanding caused by
   the word "emergency" context. Some people might see
   it as OOPs/WARN/panic and other might want to handle
   panic special way.

   I see it:

      + emergency - huge danger, medical check needed, patient might
	      survive

      + panic - patient is about to die, try to get some secrets from
	      him before he dies.

   Any sentence of the secret might be important. It would be pity
   to ignore his last A4 page just because it was not complete.


Sigh, I did my best to explain why the nesting problem is only in
the emergency context and why panic is different.

Feel free to ask if anything is still unclear.


Anyway, I am _not_ going to accept the explicit flushes in panic()
unless you show me a problem with interrupted panic() or
Linus explicitly says that the explicit flushes make sense.

Best Regards,
Petr
