Return-Path: <linux-kernel+bounces-31987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E1A8354F3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9091D1F2247D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE8222622;
	Sun, 21 Jan 2024 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRZnycON"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDD61E4AC
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705827951; cv=none; b=pLRnKaqXepcdwH2jp+zzVWZUHqSPpmA+3hAlA/yHwTKUU5VF+1ZvrZwuv9GZd1IAKe8DvR/TIQlhT/DM72z77xhd/EK4RMQvwT8vkHyZpbnTpmylCfXY7NGRr8LogmGUynId+UkkhlhddHl9l+7Lv7v8vCnrSAUBxTz7NCYchbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705827951; c=relaxed/simple;
	bh=2QFNQK4ULpJg36zoGi+Yk/5YUMnauOdTJ6dEmOXhlrU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Vp1bBPJLiVho/BY0pQHF/TBZ07S2kIsrJKJsJr86xc64zfBguqRH/t9qTZg8/Qt6qWbeYRNqYDsvwLmnMT9V85cfzXM7x5+zGa3hXwX6dv9Cb41dagcMKzy9sSvMy/7l5/Y434u1q3OKwWaSlhq+BPPjQs+Gj5HA470yWgFAsa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRZnycON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DBBC433C7;
	Sun, 21 Jan 2024 09:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705827950;
	bh=2QFNQK4ULpJg36zoGi+Yk/5YUMnauOdTJ6dEmOXhlrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nRZnycONi1kUhpmWX5dwu3RUC31GiTtqosaNEJoGtGaGKwQ99elgZRP2yFFLSFoZb
	 eb4+8l0zcSn2hmQV1LJdLy2KsTDua+FPSyIvbWAi0cPjiQE1ykkfysF9MjMRWFzCT8
	 rXnmS6ggCzwZLnuH3jqYbNKjqLQqR4DCC4C5GSuzVYH5CVNvmu0mFTgcaGh8QmPpFQ
	 fs/6RpN6o2b75fVKUWrv1x3tHBtHBatm5MGR7iwFgKNE5D1CmwbJVaB9s17qFuVhmE
	 iVrT9hPLJG5L0gG8KkL8Dn1wtOvDOwzTEEFzvROd/Nr4ac0qYw7pYPVBnPCvKJlop+
	 R2a5onDR9CpUg==
Date: Sun, 21 Jan 2024 18:05:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Matthieu Baerts
 <matttbe@kernel.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter
 Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Huacai Chen
 <chenhuacai@loongson.cn>, Jinyang He <hejinyang@loongson.cn>, Tiezhu Yang
 <yangtiezhu@loongson.cn>, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH -tip v2] x86/kprobes: Drop removed INT3 handling code
Message-Id: <20240121180544.8c663977651d2a18291318d5@kernel.org>
In-Reply-To: <20240121112852.381ebd7bf37ea6d2236db9f2@kernel.org>
References: <166981518895.1131462.4693062055762912734.stgit@devnote3>
	<06cb540e-34ff-4dcd-b936-19d4d14378c9@kernel.org>
	<20240120170517.5cadbc20@rorschach.local.home>
	<20240121112852.381ebd7bf37ea6d2236db9f2@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jan 2024 11:28:52 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Sat, 20 Jan 2024 17:05:17 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sat, 20 Jan 2024 18:44:38 +0100
> > Matthieu Baerts <matttbe@kernel.org> wrote:
> > 
> > > 
> > > I'm sorry to reply on a patch that is more than one year old, but in
> > 
> > No problem, I've done the same.
> 
> Yeah, thanks for reporting! I realized the problem.
> 
> > 
> > > short, it looks like it is causing a kernel panic on our side. To be
> > > honest, I don't understand the link, but I probably missed something.
> > > 
> > > A bit of context: for the MPTCP net subsystem, we are testing a new CI
> > > service to launch a VM and run our test suite (kselftests, kunit, etc.).
> > > This CI (Github Action) doesn't support KVM acceleration, and QEmu
> > > (v6.2.0) falls back to TCG ("-machine accel=kvm:tcg"). Before, we were
> > > always running the tests with QEmu and KVM support, and I don't think we
> > > had this issue before. Now, in two weeks, this new CI reported 5 kernel
> > > panic in ~30 runs.
> > 
> > I'm guessing that qemu doesn't do something that real hardware will do,
> > which is causing the bug.
> 
> If this is the timing bug, it is not qemu's issue, but ours.

Hmm, as far as I can see, the jump_label uses text_poke_bp(_batch) which
send IPI for sync_core() on each core, after replacing INT3 with other opcode.

void text_poke_sync(void)
{
        on_each_cpu(do_sync_core, NULL, 1);
}

static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
{
[...]
        /*
         * Third step: replace the first byte (int3) by the first byte of
         * replacing opcode.
         */
        for (do_sync = 0, i = 0; i < nr_entries; i++) {
                u8 byte = tp[i].text[0];

                if (tp[i].len == 6)
                        byte = 0x0f;

                if (byte == INT3_INSN_OPCODE)
                        continue;

                text_poke(text_poke_addr(&tp[i]), &byte, INT3_INSN_SIZE);
                do_sync++;
        }

        if (do_sync)
                text_poke_sync();
[...]

This must ensure those processor should finish running INT3 exception
handlers because the IPI is handled outside of the INT3 exception.

However, if the I-cache entry servives text_poke() and sync_core(), this
problem may happen.
The text_poke() flushes TLB but for the local (!global) PTE, and sync_core()
just serialize (!= cache flushing?). Thus the other CPUs can still see the
INT3 after text_poke_sync()? If so, on such CPU, removed INT3 is still
alive on the I-cache and hit it after text_poke_sync().
This will be a ghost INT3...


> 
> > > I initially reported the issue on netdev [1], because the CI always got
> > > the panic when doing some pings between different netns, not using MPTCP
> > > yet. Eric Dumazet mentioned that it looks like it is an x86 issue, maybe
> > > with the jump labels. Since then, I tried to 'git bisect' the issue on
> > > my side, but it was not easy: hard to reproduce and unclear to me what
> > > is causing it.
> > 
> > It could possibly be due to jump_labels/static_branch as they use int3
> > as well.
> 
> Yeah, it seems like. Does jump_labels/static_branch wait until all interrupts
> exit before removing their object from the "active list"?
> 
> kprobes does this but I found it might be *not enough*.
> When removing a kprobe, we do
> 
>  1. disarm int3
>  2. remove kprobe from hlist ("active list") by hlist_del_rcu()
>  3. wait for rcu
>  4. free kprobe's trampoline
> 
> The possible scenario is
> 
>           CPU0                      CPU1
>                                  0. hit int3
>  1. disarm int3
>  2. remove kprobe from hlist
>                                 2.1 run do_int3()
>                                 2.2 kprobe_int3_handler() failed (*)
>                                 2.3 notify_die() failed
>                                 2.4 kernel panic
>  3. wait for rcu
>  4. free kprobe's trampoline
> 
> (*) because the corresponding kprobe is already removed from the
>     active list.
> 
> Thus exc_int3() needs a check whether the int3 is already removed or not
> before it decides that int3 is a stray int3 (== returning false).
> 
> Or, another possible solution is to add another synchronize_rcu()
> or sync_core() right after disarming int3 so that we ensure all
> int3 handler at that point are finished.

So this another solution is already done. I think we need to add the
ghost INT3 check in the exc_int3() as follows;

Thank you,

From add8cf7da99cdb096a0d6765b3dc5de9a3ea3019 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Sun, 21 Jan 2024 17:16:50 +0900
Subject: [PATCH] x86: Fixup from the removed INT3 if it is unhandled

INT3 is used not only for software breakpoint, but also self modifying
code on x86 in the kernel. For example, jump_label, function tracer etc.
Those may not handle INT3 after removing it but not waiting for
synchronizing CPUs enough. Since such 'ghost' INT3 is not handled by
anyone because they think it has been removed already.
Recheck there is INT3 on the exception address and if not, ignore it.

Note that previously kprobes does the same thing by itself, but that is
not a good location to do that because INT3 is commonly used. Do it at
the common place so that it can handle all 'ghost' INT3.

Reported-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: 8e791f7eba4c ("x86/kprobes: Drop removed INT3 handling code")
---
 arch/x86/kernel/traps.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c876f1d36a81..f3e7a99c21fe 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -720,6 +720,25 @@ static bool do_int3(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(do_int3);
 
+static bool fixup_int3(struct pt_regs *regs)
+{
+	unsigned long addr = instruction_pointer(regs) - INT3_INSN_SIZE;
+
+	if (*(u8 *)addr != INT3_INSN_OPCODE) {
+		/*
+		 * The breakpoint instruction was removed right
+		 * after we hit it.  Another cpu has removed it
+		 * from this address.  In this case, no further
+		 * handling of this interrupt is appropriate.
+		 * Back up over the (now missing) int3 and run
+		 * the original instruction.
+		 */
+		instruction_pointer_set(regs, (unsigned long)addr);
+		return true;
+	}
+	return false;
+}
+
 static void do_int3_user(struct pt_regs *regs)
 {
 	if (do_int3(regs))
@@ -757,7 +776,7 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 		irqentry_state_t irq_state = irqentry_nmi_enter(regs);
 
 		instrumentation_begin();
-		if (!do_int3(regs))
+		if (!do_int3(regs) && !fixup_int3(regs))
 			die("int3", regs, 0);
 		instrumentation_end();
 		irqentry_nmi_exit(regs, irq_state);
-- 
2.34.1



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

