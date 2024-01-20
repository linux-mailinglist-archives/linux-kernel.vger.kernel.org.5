Return-Path: <linux-kernel+bounces-31934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4686983369F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 23:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52AC1F2195F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3155D14A86;
	Sat, 20 Jan 2024 22:05:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01859440
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705788321; cv=none; b=P0PyoWAU/nxYt9IfUG7IUbgQzuXjkSHZa4kS0MkzX0uJMO8rGjgRtmILPQB0iozWpVHflJtXgT8OFpQ60PNaMFKE2CrBGM99IFZhx7Doke4QImEkVBp8EuiQ1SduNTPd36hU97fFbYJPZOshRE8CmB836v/elSOy9SRt6cq2WoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705788321; c=relaxed/simple;
	bh=F0gspIb6UvigyxaysO+pQIQi4XUEXTveV8sIUD3eKhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNcqKllNxEUkMaNcddPf37M2dVJNpLdKZUFPGPxrt6ocKiC9Dn62+claN/0w8JMgm26tBza7mJ13VDqHdNusFgxnj/3MsitZwSx2/NDROu4kJ6P0fPp+Z+LZ8X/Z92gFP7iKY/oObx3HISn3JSHK0E+xYI8lw4pGayJFpbFaWSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A17C433F1;
	Sat, 20 Jan 2024 22:05:18 +0000 (UTC)
Date: Sat, 20 Jan 2024 17:05:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>, Jinyang
 He <hejinyang@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, "Naveen N
 . Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH -tip v2] x86/kprobes: Drop removed INT3 handling code
Message-ID: <20240120170517.5cadbc20@rorschach.local.home>
In-Reply-To: <06cb540e-34ff-4dcd-b936-19d4d14378c9@kernel.org>
References: <166981518895.1131462.4693062055762912734.stgit@devnote3>
	<06cb540e-34ff-4dcd-b936-19d4d14378c9@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jan 2024 18:44:38 +0100
Matthieu Baerts <matttbe@kernel.org> wrote:

> 
> I'm sorry to reply on a patch that is more than one year old, but in

No problem, I've done the same.

> short, it looks like it is causing a kernel panic on our side. To be
> honest, I don't understand the link, but I probably missed something.
> 
> A bit of context: for the MPTCP net subsystem, we are testing a new CI
> service to launch a VM and run our test suite (kselftests, kunit, etc.).
> This CI (Github Action) doesn't support KVM acceleration, and QEmu
> (v6.2.0) falls back to TCG ("-machine accel=kvm:tcg"). Before, we were
> always running the tests with QEmu and KVM support, and I don't think we
> had this issue before. Now, in two weeks, this new CI reported 5 kernel
> panic in ~30 runs.

I'm guessing that qemu doesn't do something that real hardware will do,
which is causing the bug.

> 
> I initially reported the issue on netdev [1], because the CI always got
> the panic when doing some pings between different netns, not using MPTCP
> yet. Eric Dumazet mentioned that it looks like it is an x86 issue, maybe
> with the jump labels. Since then, I tried to 'git bisect' the issue on
> my side, but it was not easy: hard to reproduce and unclear to me what
> is causing it.

It could possibly be due to jump_labels/static_branch as they use int3
as well.

> 
> After a few (long) sessions, 'git bisect' gave me this commit:
> 
>   8e791f7eba4c ("x86/kprobes: Drop removed INT3 handling code")
> 
> I thought it was another false positive, but I was not able to reproduce
> the issue when testing the parent commit, while I could still do that
> when validating this 8e791f7eba4c commit. I also went back to our MPTCP
> tree [2], reproduced the issue again, just to be sure. Then I tried to
> reproduce it after having reverted 8e791f7eba4c. I didn't have any
> panic, and I tried for a long time: ~2000 iterations, while I usually
> have the kernel panic after ~50 iterations.
> 
> So it looks like the modifications done by this patch is linked to the
> kernel panic we have:

Actually, I think it's possibly the other way around. The changes to
this patch actually allow the bug to be hit!

> 
> > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > index 66299682b6b7..33390ed4dcf3 100644
> > --- a/arch/x86/kernel/kprobes/core.c
> > +++ b/arch/x86/kernel/kprobes/core.c
> > @@ -986,20 +986,6 @@ int kprobe_int3_handler(struct pt_regs *regs)
> >  			kprobe_post_process(p, regs, kcb);
> >  			return 1;
> >  		}
> > -	}
> > -
> > -	if (*addr != INT3_INSN_OPCODE) {

So if *addr != INT3_INST_OPCODE, then this returns 1

 addr = (kprobe_opcode_t *)(regs->ip - sizeof(kprobe_opcode_t));

Hmm, so the int3 is removed when this is called, and in that case, this
returns 1.


> > -		/*
> > -		 * The breakpoint instruction was removed right
> > -		 * after we hit it.  Another cpu has removed
> > -		 * either a probepoint or a debugger breakpoint
> > -		 * at this address.  In either case, no further
> > -		 * handling of this interrupt is appropriate.
> > -		 * Back up over the (now missing) int3 and run
> > -		 * the original instruction.
> > -		 */
> > -		regs->ip = (unsigned long)addr;
> > -		return 1;
> >  	} /* else: not a kprobe fault; let the kernel handle it */
> >  
> >  	return 0;
> > 
> >   
> 
> 
> As far as I know, our 'mptcp_connect.c' selftest that is being used to
> reproduce the issue, is not using KProbes, tracing, dynamic debug, bpf,
> etc. It simply creates netns with IP and routes, then do some pings
> between the different IPs. Any idea why this commit could be linked to a
> kernel panic?

The above function is called in traps.c:

static bool do_int3(struct pt_regs *regs)
{
        int res;

#ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
        if (kgdb_ll_trap(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
                         SIGTRAP) == NOTIFY_STOP)
                return true;
#endif /* CONFIG_KGDB_LOW_LEVEL_TRAP */

#ifdef CONFIG_KPROBES
        if (kprobe_int3_handler(regs))
                return true;
#endif
        res = notify_die(DIE_INT3, "int3", regs, 0, X86_TRAP_BP, SIGTRAP);

        return res == NOTIFY_STOP;
}

If the kprobe_int3_handler() returns 1 it shortcuts the do_int3()
function and it never gets to the notify_die() call.

If something called into this and that notify_die() causes the panic,
the kprobe patch prevented that by sheer luck.

That is, the patch prevented whatever is not working from calling the
notify_die() as it should have happened, and the panic was avoided. By
adding this commit, it allowed the bug to trigger the panic. The crash
has nothing to do with kporbes, it was just that the kprobe handler was
incorrectly short-cutting the do_in3() function and preventing the
panic.

> 
> 
> Here is the last call trace I had:
> 
> > # INFO: validating network environment with pings
> > [ 1985.073189] int3: 0000 [#1] PREEMPT SMP NOPTI
> > [ 1985.073246] CPU: 0 PID: 3203 Comm: ping Not tainted 6.7.0-113761-g5e006770879c-dirty #250
> > [ 1985.073246] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> > [ 1985.073246] RIP: 0010:netif_rx_internal (arch/x86/include/asm/jump_label.h:27)

Yep, definitely a jump_label issue.

> > [ 1985.073246] Code: 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 55 48 89 fd 48 83 ec 20 65 48 8b 04 25 28 00 00 00 48 89 44 24 18 31 c0 e9 <c9> 00 00 00 66 90 66 90 48 8d 54 24 10 48 89 ef 65 8b 35 67 48 d0
> > All code
> > ========
> >    0:   0f 1f 84 00 00 00 00    nopl   0x0(%rax,%rax,1)
> >    7:   00
> >    8:   0f 1f 40 00             nopl   0x0(%rax)
> >    c:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> >   11:   55                      push   %rbp
> >   12:   48 89 fd                mov    %rdi,%rbp
> >   15:   48 83 ec 20             sub    $0x20,%rsp
> >   19:   65 48 8b 04 25 28 00    mov    %gs:0x28,%rax
> >   20:   00 00
> >   22:   48 89 44 24 18          mov    %rax,0x18(%rsp)
> >   27:   31 c0                   xor    %eax,%eax
> >   29:*  e9 c9 00 00 00          jmp    0xf7             <-- trapping instruction
> >   2e:   66 90                   xchg   %ax,%ax
> >   30:   66 90                   xchg   %ax,%ax
> >   32:   48 8d 54 24 10          lea    0x10(%rsp),%rdx
> >   37:   48 89 ef                mov    %rbp,%rdi
> >   3a:   65                      gs
> >   3b:   8b                      .byte 0x8b
> >   3c:   35                      .byte 0x35
> >   3d:   67                      addr32
> >   3e:   48                      rex.W
> >   3f:   d0                      .byte 0xd0
> > 

[..]

> 
> I reported the tests I did, userspace commands before triggering the
> bug, call traces, kernel config, vmlinux files, etc. on a ticket that is
> publicly accessible [4].
> 
> 
> Do you mind having a look at this issue, and tell me what you think
> about it, please?

Just did ;-)

So for some reason, jump labels is causing a crash. I can try to look
more into this on Monday.

-- Steve


> 
> I can run more tests and debug patches if it can help. Please note that
> it looks like it is even harder to reproduce the kernel panic when added
> more debug mechanisms, but I can always try.
> 
> 
> [1]
> https://lore.kernel.org/netdev/98724dcd-ddf3-4f78-a386-f966ffbc9528@kernel.org/T/
> [2] on top of Linus' tree from 2 days ago: 736b5545d39c ("Merge tag
> 'net-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> [3] https://github.com/multipath-tcp/mptcp_net-next/files/13998625/config.gz
> [4] https://github.com/multipath-tcp/mptcp_net-next/issues/471
> 
> 
> Cheers,
> Matt


