Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4741E813707
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjLNQz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLNQzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:55:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D901118
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:55:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA510C433C8;
        Thu, 14 Dec 2023 16:55:28 +0000 (UTC)
Date:   Thu, 14 Dec 2023 11:56:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Remove 32bit timestamp logic
Message-ID: <20231214115614.2cf5a40e@gandalf.local.home>
In-Reply-To: <CAHk-=whESMW2v0cd0Ye+AnV0Hp9j+Mm4BO2xJo93eQcC1xghUA@mail.gmail.com>
References: <20231213211126.24f8c1dd@gandalf.local.home>
        <20231213214632.15047c40@gandalf.local.home>
        <CAHk-=whESMW2v0cd0Ye+AnV0Hp9j+Mm4BO2xJo93eQcC1xghUA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 22:53:19 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 13 Dec 2023 at 18:45, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > tl;dr;  The ring-buffer timestamp requires a 64-bit cmpxchg to keep the
> > timestamps in sync (only in the slow paths). I was told that 64-bit cmpxchg
> > can be extremely slow on 32-bit architectures. So I created a rb_time_t
> > that on 64-bit was a normal local64_t type, and on 32-bit it's represented
> > by 3 32-bit words and a counter for synchronization. But this now requires
> > three 32-bit cmpxchgs for where one simple 64-bit cmpxchg would do.  
> 
> It's not that a 64-bit cmpxchg is even slow. It doesn't EXIST AT ALL
> on older 32-bit x86 machines.
> 
> Which is why we have
> 
>     arch/x86/lib/cmpxchg8b_emu.S
> 
> which emulates it on machines that don't have the CX8 capability
> ("CX8" being the x86 capability flag name for the cmpxchg8b
> instruction, aka 64-bit cmpxchg).
> 
> Which only works because those older 32-bit cpu's also don't do SMP,
> so there are no SMP cache coherency issues, only interrupt atomicity
> issues.
> 
> IOW, the way to do an atomic 64-bit cmpxchg on the affected hardware
> is to simply disable interrupts.
> 
> In other words - it's not just slow.  It's *really* slow. As in 10x
> slower, not "slightly slower".

Ah, I'm starting to remember this for the rationale in doing it.

I should have read up on the LWN article I even wrote about it!

  https://lwn.net/Articles/831892/

  "I mentioned that I used the local64 variants of operations like
   local_read/cmpxchg/etc. operations. Desnoyers went on to argue that the
   local64 operations on 32-bit machines were horrible in performance, and
   worse, some require that interrupts be disabled, meaning that they could
   not be used in NMI context."

And yes, this does get called in NMI context.

> 
> > We started discussing how much time this is actually saving to be worth the
> > complexity, and actually found some hardware to test. One Atom processor.  
> 
> That atom processor won't actually show the issue. It's much too
> recent. So your "test" is actually worthless.
> 
> And you probably did this all with a kernel config that had
> CONFIG_X86_CMPXCHG64 set anyway, which wouldn't even boot on a i486
> machine.
> 
> So in fact your test was probably doubly broken, in that not only
> didn't you test the slow case, you tested something that wouldn't even
> have worked in the environment where the slow case happened.
> 
> Now, the real question is if anybody cares about CPUs that don't have
> cmpxchg8b support.
> 
> IBecause in practice, it's really just old 486-class machines (and a
> couple of clone manufacturers who _claimed_ to be Pentium class, but
> weren't - there was also some odd thing with Windows breaking if you
> had CPUID claiming to support CX8
> 
> We dropped support for the original 80386 some time ago. I'd actually
> be willing to drop support for ll pre-cmpxchg8b machines, and get rid
> of the emulation.
> 
> I also suspect that from a perf angle, none of this matters. The
> emulation being slow probably is a non-issue, simply because even if
> you run on an old i486 machine, you probably won't be doing perf or
> tracing on it.

Thanks for the background.

I had a patch that added:

+       /* ring buffer does cmpxchg, make sure it is safe in NMI context */
+       if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) &&
+           (unlikely(in_nmi()))) {
+               return NULL;
+       }

But for ripping out this code, I should probably change that to:

       if ((!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) ||
	    (IS_ENABLED(X86_32) && !IS_ENABLED(X86_CMPXCHG64))) &&
           unlikely(in_nmi())) {
               return NULL;
       }

Not sure if there's other architectures that are affected by this (hence
why I Cc'd linux-arch).

I don't think anyone actually cares about the performance overhead of 486
doing 64-bit cmpxchg by disabling interrupts. Especially since this only
happens in the slow path (if an event interrupts the processing of another
event). If someone complains, we can always add back this code.

Now back to my original question. Are you OK with me sending this to you
now, or should I send you just the subtle fixes to the 32-bit rb_time_*
code and keep this patch for the merge window?

My preference is to get it in now and label it as stable, but I'm fine
either way.

-- Steve
