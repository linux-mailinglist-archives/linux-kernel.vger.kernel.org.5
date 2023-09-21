Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A277A98A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjIURuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjIURuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:50:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45F9472AA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:22:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA0FF16F2;
        Thu, 21 Sep 2023 09:04:01 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.36.171])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF1B23F59C;
        Thu, 21 Sep 2023 09:03:23 -0700 (PDT)
Date:   Thu, 21 Sep 2023 17:03:18 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        sumit.garg@linaro.org, swboyd@chromium.org
Subject: Re: [PATCH] lkdtm/bugs: add test for panic() with stuck secondary
 CPUs
Message-ID: <ZQxpRj2ZayFSIZSo@FVFF77S0Q05N>
References: <20230831101026.3122590-1-mark.rutland@arm.com>
 <CAD=FV=Wb0TRE1AEr=f7f-iGWrnF=Wabdde5XJW2XNjMpy+uJGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Wb0TRE1AEr=f7f-iGWrnF=Wabdde5XJW2XNjMpy+uJGQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 09:16:31AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Aug 31, 2023 at 3:10 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > Upon a panic() the kernel will use either smp_send_stop() or
> > crash_smp_send_stop() to attempt to stop secondary CPUs via an IPI,
> > which may or may not be an NMI. Generally it's preferable that this is an
> > NMI so that CPUs can be stopped in as many situations as possible, but
> > it's not always possible to provide an NMI, and there are cases where
> > CPUs may be unable to handle the NMI regardless.
> >
> > This patch adds a test for panic() where all other CPUs are stuck with
> > interrupts disabled, which can be used to check whether the kernel
> > gracefully handles CPUs failing to respond to a stop, and whe NMIs stops
> > work.
> >
> > For example, on arm64 *without* an NMI, this results in:
> >
> > | # echo PANIC_STOP_IRQOFF > /sys/kernel/debug/provoke-crash/DIRECT
> > | lkdtm: Performing direct entry PANIC_STOP_IRQOFF
> > | Kernel panic - not syncing: panic stop irqoff test
> > | CPU: 2 PID: 24 Comm: migration/2 Not tainted 6.5.0-rc3-00077-ge6c782389895-dirty #4
> > | Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> > | Stopper: multi_cpu_stop+0x0/0x1a0 <- stop_machine_cpuslocked+0x158/0x1a4
> > | Call trace:
> > |  dump_backtrace+0x94/0xec
> > |  show_stack+0x18/0x24
> > |  dump_stack_lvl+0x74/0xc0
> > |  dump_stack+0x18/0x24
> > |  panic+0x358/0x3e8
> > |  lkdtm_PANIC+0x0/0x18
> > |  multi_cpu_stop+0x9c/0x1a0
> > |  cpu_stopper_thread+0x84/0x118
> > |  smpboot_thread_fn+0x224/0x248
> > |  kthread+0x114/0x118
> > |  ret_from_fork+0x10/0x20
> > | SMP: stopping secondary CPUs
> > | SMP: failed to stop secondary CPUs 0-3
> > | Kernel Offset: 0x401cf3490000 from 0xffff800080000000
> > | PHYS_OFFSET: 0x40000000
> > | CPU features: 0x00000000,68c167a1,cce6773f
> > | Memory Limit: none
> > | ---[ end Kernel panic - not syncing: panic stop irqoff test ]---
> >
> > On arm64 *with* an NMI, this results in:
> >
> > | # echo PANIC_STOP_IRQOFF > /sys/kernel/debug/provoke-crash/DIRECT
> > | lkdtm: Performing direct entry PANIC_STOP_IRQOFF
> > | Kernel panic - not syncing: panic stop irqoff test
> > | CPU: 1 PID: 19 Comm: migration/1 Not tainted 6.5.0-rc3-00077-ge6c782389895-dirty #4
> > | Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> > | Stopper: multi_cpu_stop+0x0/0x1a0 <- stop_machine_cpuslocked+0x158/0x1a4
> > | Call trace:
> > |  dump_backtrace+0x94/0xec
> > |  show_stack+0x18/0x24
> > |  dump_stack_lvl+0x74/0xc0
> > |  dump_stack+0x18/0x24
> > |  panic+0x358/0x3e8
> > |  lkdtm_PANIC+0x0/0x18
> > |  multi_cpu_stop+0x9c/0x1a0
> > |  cpu_stopper_thread+0x84/0x118
> > |  smpboot_thread_fn+0x224/0x248
> > |  kthread+0x114/0x118
> > |  ret_from_fork+0x10/0x20
> > | SMP: stopping secondary CPUs
> > | Kernel Offset: 0x55a9c0bc0000 from 0xffff800080000000
> > | PHYS_OFFSET: 0x40000000
> > | CPU features: 0x00000000,68c167a1,fce6773f
> > | Memory Limit: none
> > | ---[ end Kernel panic - not syncing: panic stop irqoff test ]---
> 
> Since Sumit didn't notice it and I had to use a "diff" tool to help me
> spot the difference in your two examples, maybe telegraph for the
> reader of the commit message that the important thing is the lack of
> "SMP: failed to stop secondary CPUs" in your example.

Sure; I've added explicit "note" lines to v2 for that.

> > +static void lkdtm_PANIC_STOP_IRQOFF(void)
> > +{
> > +       atomic_t v = ATOMIC_INIT(0);
> > +
> > +       cpus_read_lock();
> > +       stop_machine(panic_stop_irqoff_fn, &v, cpu_online_mask);
> 
> It broke my brain just a little bit that stop_machine() isn't backed
> by "IPI_CPU_STOP" since the point of this was to test the patch
> modifying how "IPI_CPU_STOP" worked. ;-) Assuming I didn't mess up, I
> guess stop_machine() is just used to get all the CPUs running with
> interrupts disabled and then the last CPU does a panic. The _panic_
> then tests "IPI_CPU_STOP" / "IPI_CPU_CRASH_STOP".

Yup; I had hoped that the comment within panic_stop_irqoff_fn() was sufficient
for that:

	/*
	 * Trigger the panic after all other CPUs have entered this function,
	 * so that they are guaranteed to have IRQs disabled.
	 */

I've made that a bit more explicit now:

	/*
	 * As stop_machine() disables interrupts, all CPUs within this function
	 * have interrupts disabled and cannot take a regular IPI.
	 *
	 * The last CPU which enters here will trigger a panic, and as all CPUs
	 * cannot take a regular IPI, we'll only be able to stop secondaries if
	 * smp_send_stop() or crash_smp_send_stop() uses an NMI.
	 */ 

> Probably this is obvious to everyone but me, so no action is needed
> unless you agree that it's confusing and can think of a good comment /
> commit message addition to help.

Hopefully the above is good enough?

I agree the stop_machine() naming is also somewhat confusing here, but I can't
do much about that.

> In any case, after Sumit's feedback is addressed:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks!

Mark.
