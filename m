Return-Path: <linux-kernel+bounces-31955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C76835433
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 03:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21C31C21750
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 02:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574A536125;
	Sun, 21 Jan 2024 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhu8jITM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5543610A
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705804138; cv=none; b=DqBfYeXaJFa3jA84wVD1i3lqjohbUDWMZXpAVXRYq3UhnC8SlPVDjroB2sWDtNfn1svraTrk3DtPlna6fZ+z+h3i7vAWcNQgiXqEBFUYSA/50m7bnbpKpkB1QUJPUuoHfvQaewP9ggQ6gh+EEV0rGQrcIa9iMSXIBXylrWpDAEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705804138; c=relaxed/simple;
	bh=ONtAEoLwZNtfPZ3gK/rST8nv7mAqEo3TtAJWrztyAEM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Aqo2Y9hLnL0KGtA5vcsMh6S7wNRcd97dBrQEK6zo1xIDVWFxbV6fKa5CdFNJIzOURkzTq2rXS5rQ9atnnGx3wgD+o32XMvLXaFoNSHWWrrpGrZCKtXnqpT8j5X+dorzPxeN/eTQCrg1OTL5QSHFm93PnLG4KxBXJGov8Dz2DuXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhu8jITM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7845C433F1;
	Sun, 21 Jan 2024 02:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705804137;
	bh=ONtAEoLwZNtfPZ3gK/rST8nv7mAqEo3TtAJWrztyAEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qhu8jITMBSYDHrsu6Mk9Z/ukUZ+E6Kd7n/+im5IHGsT5v+h6j+KZP35ddpwtUmfsc
	 VMgvNyUANE3SQjjei1LCkXU59ohyAYxMRMG+rkzNxTFzeY3HeD2XYzTwNuBvoysoNK
	 9/zB3jG3UrDbBZOkZzuQYKX3cn0JOuMBBli7PhMPLG+7Yg+MNtQ0bz1gRRinnvF6wQ
	 ZtG0QuTinHCt2jpOhuXZt5JZYpCpTQZ5g/+QLP63cvz527oB5h7uKQiF6iDEh9U4lJ
	 0+QfnUBjgKt42Z2kbYZNjGL8ufiqllLYrMwLts7Zt71o+HHOIjKR7TKgNRC7htc3TM
	 DsfYwPlLhd7/A==
Date: Sun, 21 Jan 2024 11:28:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, x86@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>, Jinyang
 He <hejinyang@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH -tip v2] x86/kprobes: Drop removed INT3 handling code
Message-Id: <20240121112852.381ebd7bf37ea6d2236db9f2@kernel.org>
In-Reply-To: <20240120170517.5cadbc20@rorschach.local.home>
References: <166981518895.1131462.4693062055762912734.stgit@devnote3>
	<06cb540e-34ff-4dcd-b936-19d4d14378c9@kernel.org>
	<20240120170517.5cadbc20@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jan 2024 17:05:17 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 20 Jan 2024 18:44:38 +0100
> Matthieu Baerts <matttbe@kernel.org> wrote:
> 
> > 
> > I'm sorry to reply on a patch that is more than one year old, but in
> 
> No problem, I've done the same.

Yeah, thanks for reporting! I realized the problem.

> 
> > short, it looks like it is causing a kernel panic on our side. To be
> > honest, I don't understand the link, but I probably missed something.
> > 
> > A bit of context: for the MPTCP net subsystem, we are testing a new CI
> > service to launch a VM and run our test suite (kselftests, kunit, etc.).
> > This CI (Github Action) doesn't support KVM acceleration, and QEmu
> > (v6.2.0) falls back to TCG ("-machine accel=kvm:tcg"). Before, we were
> > always running the tests with QEmu and KVM support, and I don't think we
> > had this issue before. Now, in two weeks, this new CI reported 5 kernel
> > panic in ~30 runs.
> 
> I'm guessing that qemu doesn't do something that real hardware will do,
> which is causing the bug.

If this is the timing bug, it is not qemu's issue, but ours.

> > I initially reported the issue on netdev [1], because the CI always got
> > the panic when doing some pings between different netns, not using MPTCP
> > yet. Eric Dumazet mentioned that it looks like it is an x86 issue, maybe
> > with the jump labels. Since then, I tried to 'git bisect' the issue on
> > my side, but it was not easy: hard to reproduce and unclear to me what
> > is causing it.
> 
> It could possibly be due to jump_labels/static_branch as they use int3
> as well.

Yeah, it seems like. Does jump_labels/static_branch wait until all interrupts
exit before removing their object from the "active list"?

kprobes does this but I found it might be *not enough*.
When removing a kprobe, we do

 1. disarm int3
 2. remove kprobe from hlist ("active list") by hlist_del_rcu()
 3. wait for rcu
 4. free kprobe's trampoline

The possible scenario is

          CPU0                      CPU1
                                 0. hit int3
 1. disarm int3
 2. remove kprobe from hlist
                                2.1 run do_int3()
                                2.2 kprobe_int3_handler() failed (*)
                                2.3 notify_die() failed
                                2.4 kernel panic
 3. wait for rcu
 4. free kprobe's trampoline

(*) because the corresponding kprobe is already removed from the
    active list.

Thus exc_int3() needs a check whether the int3 is already removed or not
before it decides that int3 is a stray int3 (== returning false).

Or, another possible solution is to add another synchronize_rcu()
or sync_core() right after disarming int3 so that we ensure all
int3 handler at that point are finished.

> 
> > 
> > After a few (long) sessions, 'git bisect' gave me this commit:
> > 
> >   8e791f7eba4c ("x86/kprobes: Drop removed INT3 handling code")
> > 
> > I thought it was another false positive, but I was not able to reproduce
> > the issue when testing the parent commit, while I could still do that
> > when validating this 8e791f7eba4c commit. I also went back to our MPTCP
> > tree [2], reproduced the issue again, just to be sure. Then I tried to
> > reproduce it after having reverted 8e791f7eba4c. I didn't have any
> > panic, and I tried for a long time: ~2000 iterations, while I usually
> > have the kernel panic after ~50 iterations.
> > 
> > So it looks like the modifications done by this patch is linked to the
> > kernel panic we have:
> 
> Actually, I think it's possibly the other way around. The changes to
> this patch actually allow the bug to be hit!
> 
> > 
> > > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > > index 66299682b6b7..33390ed4dcf3 100644
> > > --- a/arch/x86/kernel/kprobes/core.c
> > > +++ b/arch/x86/kernel/kprobes/core.c
> > > @@ -986,20 +986,6 @@ int kprobe_int3_handler(struct pt_regs *regs)
> > >  			kprobe_post_process(p, regs, kcb);
> > >  			return 1;
> > >  		}
> > > -	}
> > > -
> > > -	if (*addr != INT3_INSN_OPCODE) {
> 
> So if *addr != INT3_INST_OPCODE, then this returns 1
> 
>  addr = (kprobe_opcode_t *)(regs->ip - sizeof(kprobe_opcode_t));
> 
> Hmm, so the int3 is removed when this is called, and in that case, this
> returns 1.

Yes, this is a kind of "fixup" path.

> 
> 
> > > -		/*
> > > -		 * The breakpoint instruction was removed right
> > > -		 * after we hit it.  Another cpu has removed
> > > -		 * either a probepoint or a debugger breakpoint
> > > -		 * at this address.  In either case, no further
> > > -		 * handling of this interrupt is appropriate.
> > > -		 * Back up over the (now missing) int3 and run
> > > -		 * the original instruction.
> > > -		 */
> > > -		regs->ip = (unsigned long)addr;
> > > -		return 1;
> > >  	} /* else: not a kprobe fault; let the kernel handle it */
> > >  
> > >  	return 0;
> > > 
> > >   
> > 
> > 
> > As far as I know, our 'mptcp_connect.c' selftest that is being used to
> > reproduce the issue, is not using KProbes, tracing, dynamic debug, bpf,
> > etc. It simply creates netns with IP and routes, then do some pings
> > between the different IPs. Any idea why this commit could be linked to a
> > kernel panic?
> 
> The above function is called in traps.c:
> 
> static bool do_int3(struct pt_regs *regs)
> {
>         int res;
> 
> #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
>         if (kgdb_ll_trap(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
>                          SIGTRAP) == NOTIFY_STOP)
>                 return true;
> #endif /* CONFIG_KGDB_LOW_LEVEL_TRAP */
> 
> #ifdef CONFIG_KPROBES
>         if (kprobe_int3_handler(regs))
>                 return true;
> #endif
>         res = notify_die(DIE_INT3, "int3", regs, 0, X86_TRAP_BP, SIGTRAP);
> 
>         return res == NOTIFY_STOP;
> }
> 
> If the kprobe_int3_handler() returns 1 it shortcuts the do_int3()
> function and it never gets to the notify_die() call.
> 
> If something called into this and that notify_die() causes the panic,
> the kprobe patch prevented that by sheer luck.

Yes, it prevents the panic unexpectedly :)

> 
> That is, the patch prevented whatever is not working from calling the
> notify_die() as it should have happened, and the panic was avoided. By
> adding this commit, it allowed the bug to trigger the panic. The crash
> has nothing to do with kporbes, it was just that the kprobe handler was
> incorrectly short-cutting the do_in3() function and preventing the
> panic.

Yeah, but this should not be done in the kprobe_int3_handler() but
exc_int3() should do.

Thank you,

> 
> > 
> > 
> > Here is the last call trace I had:
> > 
> > > # INFO: validating network environment with pings
> > > [ 1985.073189] int3: 0000 [#1] PREEMPT SMP NOPTI
> > > [ 1985.073246] CPU: 0 PID: 3203 Comm: ping Not tainted 6.7.0-113761-g5e006770879c-dirty #250
> > > [ 1985.073246] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> > > [ 1985.073246] RIP: 0010:netif_rx_internal (arch/x86/include/asm/jump_label.h:27)
> 
> Yep, definitely a jump_label issue.
> 
> > > [ 1985.073246] Code: 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 55 48 89 fd 48 83 ec 20 65 48 8b 04 25 28 00 00 00 48 89 44 24 18 31 c0 e9 <c9> 00 00 00 66 90 66 90 48 8d 54 24 10 48 89 ef 65 8b 35 67 48 d0
> > > All code
> > > ========
> > >    0:   0f 1f 84 00 00 00 00    nopl   0x0(%rax,%rax,1)
> > >    7:   00
> > >    8:   0f 1f 40 00             nopl   0x0(%rax)
> > >    c:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> > >   11:   55                      push   %rbp
> > >   12:   48 89 fd                mov    %rdi,%rbp
> > >   15:   48 83 ec 20             sub    $0x20,%rsp
> > >   19:   65 48 8b 04 25 28 00    mov    %gs:0x28,%rax
> > >   20:   00 00
> > >   22:   48 89 44 24 18          mov    %rax,0x18(%rsp)
> > >   27:   31 c0                   xor    %eax,%eax
> > >   29:*  e9 c9 00 00 00          jmp    0xf7             <-- trapping instruction
> > >   2e:   66 90                   xchg   %ax,%ax
> > >   30:   66 90                   xchg   %ax,%ax
> > >   32:   48 8d 54 24 10          lea    0x10(%rsp),%rdx
> > >   37:   48 89 ef                mov    %rbp,%rdi
> > >   3a:   65                      gs
> > >   3b:   8b                      .byte 0x8b
> > >   3c:   35                      .byte 0x35
> > >   3d:   67                      addr32
> > >   3e:   48                      rex.W
> > >   3f:   d0                      .byte 0xd0
> > > 
> 
> [..]
> 
> > 
> > I reported the tests I did, userspace commands before triggering the
> > bug, call traces, kernel config, vmlinux files, etc. on a ticket that is
> > publicly accessible [4].
> > 
> > 
> > Do you mind having a look at this issue, and tell me what you think
> > about it, please?
> 
> Just did ;-)
> 
> So for some reason, jump labels is causing a crash. I can try to look
> more into this on Monday.
> 
> -- Steve
> 
> 
> > 
> > I can run more tests and debug patches if it can help. Please note that
> > it looks like it is even harder to reproduce the kernel panic when added
> > more debug mechanisms, but I can always try.
> > 
> > 
> > [1]
> > https://lore.kernel.org/netdev/98724dcd-ddf3-4f78-a386-f966ffbc9528@kernel.org/T/
> > [2] on top of Linus' tree from 2 days ago: 736b5545d39c ("Merge tag
> > 'net-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> > [3] https://github.com/multipath-tcp/mptcp_net-next/files/13998625/config.gz
> > [4] https://github.com/multipath-tcp/mptcp_net-next/issues/471
> > 
> > 
> > Cheers,
> > Matt
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

