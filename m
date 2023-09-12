Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B774C79D45C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbjILPHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbjILPHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:07:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFF7E79;
        Tue, 12 Sep 2023 08:07:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E598C433CA;
        Tue, 12 Sep 2023 15:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694531224;
        bh=00jvBVJ7IICw3CmIKyfFR+Wl2uOtXu1lvaB5ZZUykFY=;
        h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
        b=U5WNSAk9l93CJSL2FAXWwKj6ZhXmyDbhTZwK17FVu+jkcTjlirVurAxow/oTuiiZD
         MepWvmpCQhvYMKVyOEJCK6Fjdnxn6Pfa7z17kyoZq2znxT7knPRC3Do6YcFFCeLjFO
         tZCGAX/Jsqi01diFf+IFuGMl+lIfyhuykU2FkDT+oScMh7WHVYhSX2fA1zzgdfmWFg
         Hnuh4224ob/fuHAIdxRAJQ7BdiKK99BtV6ZFx9NNpMsQx4aFW/1Ilt4Bq1A9uZI9tp
         8LX1zwUhcXWT2XdC8FtNoq9YzCvkbqN5qV5cGgkmOmdzLdxXMMhB7w9L1NtULnHTSx
         Lr2CXWPu0T7nw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 49ACFCE07C7; Tue, 12 Sep 2023 08:07:04 -0700 (PDT)
Date:   Tue, 12 Sep 2023 08:07:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Message-ID: <9e85adf9-2e1f-4bed-a58e-9ca629c03579@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ad298077-fca8-437e-b9e3-66e31424afb1@paulmck-laptop>
 <20230906172954.oq4vogeuco25zam7@revolver>
 <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
 <20230911235452.xhtnt7ply7ayr53x@revolver>
 <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
 <CAMuHMdWKwdxjRf031aD=Ko7vRdvFW-OR48QAc=ZFy=FP_LNAoA@mail.gmail.com>
 <f9b0a88c-8a64-439f-a488-85d500c9f2aa@paulmck-laptop>
 <CAMuHMdX89u6wL9W+8ZOn-OTT1FreYjEqYnvEip4Aq3k1gOP0EQ@mail.gmail.com>
 <62936d98-6353-486e-8535-86c9f90bc7f4@paulmck-laptop>
 <20230912135617.dnhyk4h5c555l2yg@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912135617.dnhyk4h5c555l2yg@revolver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:56:17AM -0400, Liam R. Howlett wrote:
> * Paul E. McKenney <paulmck@kernel.org> [230912 06:00]:
> > On Tue, Sep 12, 2023 at 10:34:44AM +0200, Geert Uytterhoeven wrote:
> > > Hi Paul,
> > > 
> > > On Tue, Sep 12, 2023 at 10:30 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > On Tue, Sep 12, 2023 at 10:23:37AM +0200, Geert Uytterhoeven wrote:
> > > > > On Tue, Sep 12, 2023 at 10:14 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > On Mon, Sep 11, 2023 at 07:54:52PM -0400, Liam R. Howlett wrote:
> > > > > > > * Paul E. McKenney <paulmck@kernel.org> [230906 14:03]:
> > > > > > > > On Wed, Sep 06, 2023 at 01:29:54PM -0400, Liam R. Howlett wrote:
> > > > > > > > > * Paul E. McKenney <paulmck@kernel.org> [230906 13:24]:
> > > > > > > > > > On Wed, Sep 06, 2023 at 11:23:25AM -0400, Liam R. Howlett wrote:
> > > > > > > > > > > (Adding Paul & Shanker to Cc list.. please see below for why)
> > > > > > > > > > >
> > > > > > > > > > > Apologies on the late response, I was away and have been struggling to
> > > > > > > > > > > get a working PPC32 test environment.
> > > > > > > > > > >
> > > > > > > > > > > * Geert Uytterhoeven <geert@linux-m68k.org> [230829 12:42]:
> > > > > > > > > > > >     Hi Liam,
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, 18 Aug 2023, Liam R. Howlett wrote:
> > > > > > > > > > > > > The current implementation of append may cause duplicate data and/or
> > > > > > > > > > > > > incorrect ranges to be returned to a reader during an update.  Although
> > > > > > > > > > > > > this has not been reported or seen, disable the append write operation
> > > > > > > > > > > > > while the tree is in rcu mode out of an abundance of caution.
> > > > > > > > > > >
> > > > > > > > > > > ...
> > > > > > > > > > > > >
> > > > > > >
> > > > > > > ...
> > > > > > >
> > > > > > > > > > > > RCU-related configs:
> > > > > > > > > > > >
> > > > > > > > > > > >     $ grep RCU .config
> > > > > > > > > > > >     # RCU Subsystem
> > > > > > > > > > > >     CONFIG_TINY_RCU=y
> > > > > >
> > > > > > I must have been asleep last time I looked at this.  I was looking at
> > > > > > Tree RCU.  Please accept my apologies for my lapse.  :-/
> > > > > >
> > > > > > However, Tiny RCU's call_rcu() also avoids enabling IRQs, so I would
> > > > > > have said the same thing, albeit after looking at a lot less RCU code.
> > > > > >
> > > > > > TL;DR:
> > > > > >
> > > > > > 1.      Try making the __setup_irq() function's call to mutex_lock()
> > > > > >         instead be as follows:
> > > > > >
> > > > > >         if (!mutex_trylock(&desc->request_mutex))
> > > > > >                 mutex_lock(&desc->request_mutex);
> > > > > >
> > > > > >         This might fail if __setup_irq() has other dependencies on a
> > > > > >         fully operational scheduler.
> > > > > >
> > > > > > 2.      Move that ppc32 call to __setup_irq() much later, most definitely
> > > > > >         after interrupts have been enabled and the scheduler is fully
> > > > > >         operational.  Invoking mutex_lock() before that time is not a
> > > > > >         good idea.  ;-)
> > > > >
> > > > > There is no call to __setup_irq() from arch/powerpc/?
> > > >
> > > > Glad it is not just me, given that I didn't see a direct call, either.  So
> > > > later in this email, I asked Liam to put a WARN_ON_ONCE(irqs_disabled())
> > > > just before that mutex_lock() in __setup_irq().
> 
> I had already found that this is the mutex lock that is enabling them.
> I surrounded the mutex lock to ensure it was not enabled before, but was
> after.  Here is the findings:
> 
> kernel/irq/manage.c:1587 __setup_irq:
> [    0.000000] [c0e65ec0] [c00e9b00] __setup_irq+0x6c4/0x840 (unreliable)
> [    0.000000] [c0e65ef0] [c00e9d74] request_threaded_irq+0xf8/0x1f4
> [    0.000000] [c0e65f20] [c0c27168] pmac_pic_init+0x204/0x5f8
> [    0.000000] [c0e65f80] [c0c1f544] init_IRQ+0xac/0x12c
> [    0.000000] [c0e65fa0] [c0c1cad0] start_kernel+0x544/0x6d4
> 
> Note your line number will be slightly different due to my debug.  This
> is the WARN _after_ the mutex lock.
> 
> > > >
> > > > Either way, invoking mutex_lock() early in boot before interrupts have
> > > > been enabled is a bad idea.  ;-)
> > > 
> > > I'll add that WARN_ON_ONCE() too, and will report back later today...
> > 
> > Thank you, looking forward to hearing the outcome!
> > 
> > > > > Note that there are (possibly different) issues seen on ppc32 and on arm32
> > > > > (Renesas RZ/A in particular, but not on other Renesas ARM systems).
> > > > >
> > > > > I saw an issue on arm32 with cfeb6ae8bcb96ccf, but not with cfeb6ae8bcb96ccf^.
> > > > > Other people saw an issue on ppc32 with both cfeb6ae8bcb96ccf and
> > > > > cfeb6ae8bcb96ccf^.
> > > >
> > > > I look forward to hearing what is the issue in both cases.
> > > 
> > > For RZ/A, my problem report is
> > > https://lore.kernel.org/all/3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org/
> > 
> > Thank you, Geert!
> > 
> > Huh.  Is that patch you reverted causing Maple Tree or related code
> > to attempt to acquire mutexes in early boot before interrupts have
> > been enabled?
> > 
> > If that added WARN_ON_ONCE() doesn't trigger early, another approach
> > would be to put it at the beginning of mutex_lock().  Or for that matter
> > at the beginning of might_sleep().
> 
> Yeah, I put many WARN() calls through the code as well as tracking down
> where TIF_NEED_RESCHED was set; the tiny.c call_rcu().
> 
> 
> So my findings summarized:
> 
> 1. My change to the maple tree makes call_rcu() more likely on early boot.
> 2. The initial thread setup is always set to idle state
> 3. call_rcu() tiny sets TIF_NEED_RESCHED since is_idle_task(current)
> 4. init_IRQ() takes a mutex lock which will enable the interrupts since
> TIF_NEED_RESCHED is set.
> 
> I don't know which of these things is "wrong".

Doing early-boot call_rcu() is OK.

The initial thread eventually becomes the idle thread for the boot CPU.
See rest_init() in init/main.c.

I can certainly make Tiny call_rcu() refrain from invoking resched_cpu()
during boot, as shown in the (untested) patch below.  This might result in
boot-time hangs, though.

The thought of doing mutex_lock() before interrupts are enabled on the
boot CPU strikes me as very wrong.  Others might argue that the fact
that __might_resched() explicitly avoids complaining when system_state
is equal to SYSTEM_BOOTING constitutes evidence that such calls are OK.
(Which might be why enabling debug suppressed the problem.)  Except that
if you actually try sleeping at that time, nothing good can possibly
happen.

So my question is why is it useful to setup interrupts that early, given
that interrupts cannot possibly happen until the boot CPU enables them?

> I also looked into the mtmsr register but decided to consult you lot
> about my findings in hopes that someone with more knowledge of the
> platform or early boot would alleviate the pain so that I could context
> switch or sleep :)  I mean, an mtmsr bug seems like a leap even for the
> issues I create..

Stranger things have happened, but I agree that this would indeed be
quite strange!  ;-)

						Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index fec804b79080..f00fb0855e4b 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -192,7 +192,7 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 	rcu_ctrlblk.curtail = &head->next;
 	local_irq_restore(flags);
 
-	if (unlikely(is_idle_task(current))) {
+	if (unlikely(is_idle_task(current)) && system_state > SYSTEM_BOOTING) {
 		/* force scheduling for rcu_qs() */
 		resched_cpu(0);
 	}
