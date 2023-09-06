Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D147942A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243598AbjIFSDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbjIFSDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:03:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86C5CE4;
        Wed,  6 Sep 2023 11:02:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F92C433C7;
        Wed,  6 Sep 2023 18:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694023376;
        bh=Rf86S0GxTyXZ08IQT9es7jcFEFfLoJuIUfMNM+bYPLc=;
        h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
        b=dVW1AL5/IjlphjmPLz01KHytT9q/aoqrNGTecd8pbLCpoCoWhpvLoY4MftEygnvrp
         /iKtee9Rm9V5gU6gNM9kYs4dQwSNDW9dceyzhzmvpcOJB6JdIcoFJby15SWszaXOUL
         hGt2tH9Szao2Ts2p5ydOtFRunLANdqAXcrhaXzZkDJbYm0XyvtRr1NVGsKV0Esu8zx
         nVK+W1RYFgdeO4FGNAvZ3LgJRHYy+KlpMj/upMH/2oa4fXGOim9bPH2a8NQhlk0twN
         D1RG0pgOizDVJynjb23riIQGMkmF1VHtmiRoOwRMzpd6OHVfrSFmnkKJVE3FdLfxhq
         d11CX9A7Jzz+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E881ACE0809; Wed,  6 Sep 2023 11:02:55 -0700 (PDT)
Date:   Wed, 6 Sep 2023 11:02:55 -0700
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
Message-ID: <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
 <20230819004356.1454718-2-Liam.Howlett@oracle.com>
 <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
 <20230906152325.dblzauybyoq5kd35@revolver>
 <ad298077-fca8-437e-b9e3-66e31424afb1@paulmck-laptop>
 <20230906172954.oq4vogeuco25zam7@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906172954.oq4vogeuco25zam7@revolver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 01:29:54PM -0400, Liam R. Howlett wrote:
> * Paul E. McKenney <paulmck@kernel.org> [230906 13:24]:
> > On Wed, Sep 06, 2023 at 11:23:25AM -0400, Liam R. Howlett wrote:
> > > (Adding Paul & Shanker to Cc list.. please see below for why)
> > > 
> > > Apologies on the late response, I was away and have been struggling to
> > > get a working PPC32 test environment.
> > > 
> > > * Geert Uytterhoeven <geert@linux-m68k.org> [230829 12:42]:
> > > > 	Hi Liam,
> > > > 
> > > > On Fri, 18 Aug 2023, Liam R. Howlett wrote:
> > > > > The current implementation of append may cause duplicate data and/or
> > > > > incorrect ranges to be returned to a reader during an update.  Although
> > > > > this has not been reported or seen, disable the append write operation
> > > > > while the tree is in rcu mode out of an abundance of caution.
> > > 
> > > ...
> > > > > 
> > > > > Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > > 
> > > > Thanks for your patch, which is now commit cfeb6ae8bcb96ccf
> > > > ("maple_tree: disable mas_wr_append() when other readers are
> > > > possible") in v6.5, and is being backported to stable.
> > > > 
> > > > On Renesas RZ/A1 and RZ/A2 (single-core Cortex-A9), this causes the
> > > > following warning:
> > > > 
> > > >      clocksource: timer@e803b000: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 28958491609 ns
> > > >      sched_clock: 32 bits at 66MHz, resolution 15ns, wraps every 32537631224ns
> > > >      /soc/timer@e803b000: used for clocksource
> > > >      /soc/timer@e803c000: used for clock events
> > > >     +------------[ cut here ]------------
> > > >     +WARNING: CPU: 0 PID: 0 at init/main.c:992 start_kernel+0x2f0/0x480
> > > >     +Interrupts were enabled early
> > > 
> > > Note that the maple tree is involved in tracking the interrupts, see
> > > kernel/irq/irqdesc.c irq_insert_desc(), etc.
> > > 
> > > >     +CPU: 0 PID: 0 Comm: swapper Not tainted 6.5.0-rza2mevb-10197-g99b80d6b92b5 #237
> > > 
> > > I cannot find commit id 99b80d6b92b5.
> > > 
> > > >     +Hardware name: Generic R7S9210 (Flattened Device Tree)
> > > >     + unwind_backtrace from show_stack+0x10/0x14
> > > >     + show_stack from dump_stack_lvl+0x24/0x3c
> > > >     + dump_stack_lvl from __warn+0x74/0xb8
> > > >     + __warn from warn_slowpath_fmt+0x78/0xb0
> > > >     + warn_slowpath_fmt from start_kernel+0x2f0/0x480
> > > >     + start_kernel from 0x0
> > > >     +---[ end trace 0000000000000000 ]---
> > > >      Console: colour dummy device 80x30
> > > >      printk: console [tty0] enabled
> > > >      Calibrating delay loop (skipped) preset value.. 1056.00 BogoMIPS (lpj=5280000)
> > > > 
> > > > Reverting this commit fixes the issue.
> > > 
> > > I have set up testing with qemu for powerpc 32b, and reverting this
> > > patch does not fix it for me.  Did you revert the patch or bisect to the
> > > issue?
> > > 
> > > It also happens on 0e0e9bd5f7b9 (I ran git checkout cfeb6ae8bcb96ccf^ to
> > > get the commit immediately before cfeb6ae8bcb96ccf).  My qemu command is
> > > as follows:
> > > 
> > > qemu-system-ppc -L pc-bios -boot c -prom-env "boot-device=hd:,\yaboot"
> > > -prom-env "boot-args=conf=hd:,\yaboot.conf" -M mac99,via=pmu -m 2048
> > > -hda powerpc32.img -nographic -kernel <file>
> > > 
> > > 
> > > > 
> > > > RCU-related configs:
> > > > 
> > > >     $ grep RCU .config
> > > >     # RCU Subsystem
> > > >     CONFIG_TINY_RCU=y
> > > >     # CONFIG_RCU_EXPERT is not set
> > > >     CONFIG_TINY_SRCU=y
> > > >     # end of RCU Subsystem
> > > >     # RCU Debugging
> > > >     # CONFIG_RCU_SCALE_TEST is not set
> > > >     # CONFIG_RCU_TORTURE_TEST is not set
> > > >     # CONFIG_RCU_REF_SCALE_TEST is not set
> > > >     # CONFIG_RCU_TRACE is not set
> > > >     # CONFIG_RCU_EQS_DEBUG is not set
> > > >     # end of RCU Debugging
> > > 
> > > I used the configuration from debian 8 and ran 'make oldconfig' to build
> > > my kernel.  I have attached the configuration.
> > > 
> > > > 
> > > > CONFIG_MAPLE_RCU_DISABLED is not defined (and should BTW be renamed,
> > > > as CONFIG_* is reserved for kernel configuration options).
> > > 
> > > Thanks, I'll add it to my list of work.
> > > 
> > > > 
> > > > I do not see this issue on any other platform
> > > > (arm/arm64/risc-v/mips/sh/m68k), several of them use the same
> > > > RCU configuration.
> > > > 
> > > > Do you have a clue?
> > > 
> > > It appears to be something to do with struct maple_tree sparse_irqs.  If
> > > you drop the rcu flag from that maple tree, then my configuration boots
> > > without the warning.
> > > 
> > > I *think* this is because we will reuse a lot more nodes.  And I *think*
> > > the rcu flag is not needed, since there is a comment about reading the
> > > tree being protected by the mutex sparse_irq_lock within the
> > > kernel/irq/irqdesc.c file.  Shanker, can you comment on that?
> > > 
> > > I wonder if there is a limit to the number of RCU free events before
> > > something is triggered to flush them out which could trigger IRQ
> > > enabling? Paul, could this be the case?
> > 
> > Are you asking if call_rcu() will re-enable interrupts in the following
> > use case?
> > 
> > 	local_irq_disable();
> > 	call_rcu(&p->rh, my_cb_func);
> > 	local_irq_enable();
> > 
> > If so, the answer is "no" (and yes, there might be a bug, but then again
> > I just double-checked).  However, if interrupts are enabled across a
> > call_rcu() invocation, it will do some additional work to encourage
> > the grace period.  Even if interrupts are disabled across a call_rcu()
> > invocation, it will still do either a raise_softirq() or a wakeup,
> > depending on configuration, to encourage the grace period.  And in
> > the case of call_rcu() from an interrupt handler, that raise_softirq()
> > could result in the RCU_SOFTIRQ handler running upon return from that
> > interrupt, and if there are a great many callbacks ready to invoke,
> > this RCU_SOFTIRQ handler might take quite some time.  Plus that
> > handler could itself be interrupted.
> > 
> > If long-running RCU_SOFTIRQ handlers are a problem, you can boot with
> > rcutree.use_softirq=0, which puts that handler into a kthread, which
> > in turn give the scheduler more control.  However, this will also turn
> > a lightweight raise_softirq() into a rather heavier weight wakeup.
> > Choose wisely!  ;-)
> > 
> > Or am I missing your point?
> 
> This is very early in the boot sequence when interrupts have not been
> enabled.  What we are seeing is a WARN_ON() that is triggered by
> interrupts being enabled before they should be enabled.
> 
> I was wondering if, for example, I called call_rcu() a lot *before*
> interrupts were enabled, that something could trigger that would either
> enable interrupts or indicate the task needs rescheduling?

You aren't doing call_rcu() enough to hit OOM, are you?  The actual RCU
callback invocations won't happen until some time after the scheduler
starts up.

> Specifically the rescheduling part is suspect.  I tracked down the call
> to a mutex_lock() which calls cond_resched(), so could rcu be
> 'encouraging' the rcu window by a reschedule request?

During boot before interrupts are enabled, RCU has not yet spawned any of
its kthreads.  Therefore, all of its attempts to do wakeups would notice
a NULL task_struct pointer and refrain from actually doing the wakeup.
If it did do the wakeup, you would see a NULL-pointer exception.  See
for example, invoke_rcu_core_kthread(), though that won't happen unless
you booted with rcutree.use_softirq=0.

Besides, since when did doing a wakeup enable interrupts?  That would
make it hard to do wakeups from hardware interrupt handlers, not?

But why not put some WARN_ON_ONCE(!irqs_disabled()) calls in the areas
of greatest suspicion, starting from the stack trace generated by that
mutex_lock()?  A stray interrupt-enable could be pretty much anywhere.

But where are those call_rcu() invocations?  Before rcu_init()?
Presumably before init is spawned and the early_init() calls.

And what is the RCU-related Kconfig and boot-parameter setup?

							Thanx, Paul
