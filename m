Return-Path: <linux-kernel+bounces-95898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5C08754B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B5528464C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDA1130AC9;
	Thu,  7 Mar 2024 16:57:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0238712E1FA;
	Thu,  7 Mar 2024 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830664; cv=none; b=G5NOOItGr8sdR4e7j2ZuVNfi2BsxNwuXdp762MwSiq8qkhKi84VgtlR4rzb18CjZDr/uD0ERBYLFBKgSK+d4K/aSAztt+4Q01dXfTFrGCeVokHyURhCP5CrLge+ZXCh9ddFHcqmsFeGvxfHc5+eOL3NXC9Fdae9ddkbFi8LNvjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830664; c=relaxed/simple;
	bh=goo3FVyY36ig5uMczNcvj6Gd4GG0DZk63fp6Q8ZrGXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFDjkSk/XxDF0OGkS2i3eitL5H31S07SdyXxl104kiZIyKMeBePOvIPJsuxVozIRq1/c8LlwUkOoviuudhTPo+kV8H3WtWuodi2NpgWt//IjZ1gQg0RWmuBbKBHIq0cCswFlRp8jqmLO0eI6jkGUGjIBKkBMtKei5Q/PVh0Bl80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 532101FB;
	Thu,  7 Mar 2024 08:58:18 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.69.155])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 081E63F762;
	Thu,  7 Mar 2024 08:57:39 -0800 (PST)
Date: Thu, 7 Mar 2024 16:57:33 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Network Development <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Message-ID: <Zenx_Q0UiwMbSAdP@FVFF77S0Q05N>
References: <55900c6a-f181-4c5c-8de2-bca640c4af3e@paulmck-laptop>
 <10FC3F5F-AA33-4F81-9EB6-87EB2D41F3EE@joelfernandes.org>
 <99b2ccae-07f6-4350-9c55-25ec7ae065c0@paulmck-laptop>
 <CAEXW_YQ+40a1-hk5ZP+QJ54xniSutosC7MjMscJJy8fen-gU9Q@mail.gmail.com>
 <f1e77cd2-18b2-4ab1-8ce3-da2c6babbd53@paulmck-laptop>
 <CAEXW_YRDiTXJ_GwK5soSVno73yN9FUA5GjLYAOcCTtqQvPGcFA@mail.gmail.com>
 <fcaf6cad-9959-4b6d-a6e4-05ae1b2fabdc@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcaf6cad-9959-4b6d-a6e4-05ae1b2fabdc@joelfernandes.org>

Hi Joel, Paul, Steve,

On Mon, Mar 04, 2024 at 04:16:01AM -0500, Joel Fernandes wrote:
> Hi Paul,
> 
> On 3/2/2024 8:01 PM, Joel Fernandes wrote:
> >> As you noted, one thing that Ankur's series changes is that preemption
> >> can occur anywhere that it is not specifically disabled in kernels
> >> built with CONFIG_PREEMPT_NONE=y or CONFIG_PREEMPT_VOLUNTARY=y.  This in
> >> turn changes Tasks Rude RCU's definition of a quiescent state for these
> >> kernels, adding all code regions where preemption is not specifically
> >> disabled to the list of such quiescent states.
> >>
> >> Although from what I know, this is OK, it would be good to check the
> >> calls to call_rcu_tasks_rude() or synchronize_rcu_tasks_rude() are set
> >> up so as to expect these new quiescent states.  One example where it
> >> would definitely be OK is if there was a call to synchronize_rcu_tasks()
> >> right before or after that call to synchronize_rcu_tasks_rude().
> >>
> >> Would you be willing to check the call sites to verify that they
> >> are OK with this change in 
> > Yes, I will analyze and make sure those users did not unexpectedly
> > assume something about AUTO (i.e. preempt enabled sections using
> > readers).
> 
> Other than RCU test code, there are just 3 call sites for RUDE right now, all in
> ftrace.c.
> 
> (Long story short, PREEMPT_AUTO should not cause wreckage in TASKS_RCU_RUDE
> other than any preexisting wreckage that !PREEMPT_AUTO already had. Steve is on
> CC as well to CMIIW).
> 
> Case 1: For !CONFIG_DYNAMIC_FTRACE update of ftrace_trace_function
> 
> This config is itself expected to be slow. However seeing what it does, it is
> trying to make sure the global function pointer "ftrace_trace_function" is
> updated and any readers of that pointers would have finished reading it. I don't
> personally think preemption has to be disabled across the entirety of the
> section that calls into this function. So sensitivity to preempt disabling
> should not be relevant for this case IMO, but lets see if ftrace folks disagree
> (on CC). It has more to do with, any callers of this function pointer are no
> longer calling into the old function.

I've been looking into this case for the last couple of days, and the short
story is that the existing code is broken today for PREEMPT_FULL, and the code
for CONFIG_DYNAMIC_FTRACE=y is similarly broken. A number of architectures have
also implemented the entry assembly incorrectly...

The !CONFIG_DYNAMIC_FTRACE code in update_ftrace_function() is intended to
ensure that 'ftrace_trace_function' and 'function_trace_op' are used as a
consistent pair; i.e. for a given 'op', op->func() should be called with that
specific 'op' as an argument. That was introduced back in commit:

  405e1d834807e51b ("ftrace: Synchronize setting function_trace_op with ftrace_trace_function")

.. and subsequently reworked to use synchronize_rcu_tasks_rude() in commit:

  e5a971d76d701dbf ("ftrace: Use synchronize_rcu_tasks_rude() instead of ftrace_sync())"

The key detail is that the ftrace entry code doesn't disable preemption, and so
when full preemption is used the entry code can be preempted between loading
'ftrace_trace_function' and 'function_trace_op', and there's a race of the
form:

	Thread A				Thread B

	// in ftrace entry asm			// in update_ftrace_function()

	tmp_func = ftrace_trace_function;
	< preempted >

						ftrace_trace_function = ftrace_ops_list_func;
						/*   
						 * Make sure all CPUs see this. Yes this is slow, but static
						 * tracing is slow and nasty to have enabled.
						 */
						synchronize_rcu_tasks_rude();
						/* Now all cpus are using the list ops. */
						function_trace_op = set_function_trace_op;

	< restored > 
	tmp_ops = function_trace_op;

	tmp_func(..., tmp_ops, ...);

.. and so we can end up using the old func with the new ops.



For static ftrace, this is only a problem when full preemption is used *and*
the architecture defines ARCH_SUPPORTS_FTRACE_OPS=1. Otherwise architecture
code isn't expected to provide the ops, and core code forces the use of the
list func, which iterates over all the ops to call them, e.g.

	do_for_each_ftrace_op(op, ftrace_ops_list) {
		...
		op->func(ip, parent_ip, op, fregs);
	} while_for_each_ftrace_op(op);

For static ftrace, a simple fix would be to force the use of the list func, and
not support static ftrace && ARCH_SUPPORTS_FTRACE_OPS=1. That's what x86 does today.

Another option is to follow the example of DYNAMIC_FTRACE_WITH_CALL_OPS,
and rewrite all the static ftrace asm to load the 'ops' pointer, and then load
'ops->func' from that, which would ensure the two are always in sync.

As an aside, a few architectures which unconditionally define
ARCH_SUPPORTS_FTRACE_OPS=1 fail to pass the 'fregs' argument; that'll need
cleaning up too...



For dynamic ftrace, there's a similar problem between the ftrace entry assembly and
ftrace_modify_all_code(), which looks like:

	Thread A				Thread B

	// in ftrace entry asm			// in ftrace_modify_all_code()

	tmp_ops = function_trace_op;
	< preempted (or stalled) >

						if (update) {
							update_ftrace_func(ftrace_ops_list_func);
							...
						}

						...

						if (update && ftrace_trace_function != ftrace_ops_list_func) {
							function_trace_op = set_function_trace_op;
							smp_wmb();
							smp_call_function(ftrace_sync_ipi, NULL, 1);
							update_ftrace_func(ftrace_trace_function);
						}

	< restored (or stopped stalling) >
	patched_func_call(tmp_ops);
				
.. and so we can use the ops ops with the new func.

It's worth noting that (currently) trampolines don't save us here, as we can have a sequence:

	register_ftrace_function(ops_a)

	// callsites call trampoline for ops_a
	// ftrace_caller points at ops_a and calls ops_a->func

	register_ftrace_function(ops_b);

	// callsites call common ftrace_caller
	// ftrace_caller points to ops_a and calls arch_ftrace_ops_list_func

	unregister_ftrace_function(ops_a)

	// callsites call trampoline for ops_b
	// ftrace_caller points at ops_a and calls ops_b->func
	// threads already in ftrace_caller might have stale pointer to ops_a

.. and I have a test (included at the end of this mail) which demonstrates
this for x86_64 defconfig + DYNAMIC_FTRACE + preempt=full:

| Kernel panic - not syncing: trace_func_c(tracee+0x4/0x10, fstress_tracee_thread+0x22/0x40, ops_b+0x0/0xc0, 0xffff9000c01dfe38) expected ops ops_c+0x0/0xc0
| CPU: 0 PID: 57 Comm: fstress_18 Not tainted 6.8.0-rc7-00001-ga4fa96d75cf9 #1
| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
| Call Trace:
|  <TASK>
|  dump_stack_lvl+0x36/0x50
|  panic+0x317/0x340
|  ? tracee+0x4/0x10
|  ? tracee+0x4/0x10
|  ? fstress_tracee_thread+0x22/0x40
|  ? __pfx_fstress_tracee_thread+0x10/0x10
|  trace_func_c+0x3b/0x40
|  ftrace_call+0x5/0x44
|  ? __pfx_fstress_tracee_thread+0x10/0x10
|  ? tracee+0x9/0x10
|  tracee+0x9/0x10
|  fstress_tracee_thread+0x22/0x40
|  kthread+0xd7/0x100
|  ? __pfx_kthread+0x10/0x10
|  ret_from_fork+0x34/0x50
|  ? __pfx_kthread+0x10/0x10
|  ret_from_fork_asm+0x1b/0x30
|  </TASK>
| Kernel Offset: 0x2ba00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
| ---[ end Kernel panic - not syncing: trace_func_c(tracee+0x4/0x10, fstress_tracee_thread+0x22/0x40, ops_b+0x0/0xc0, 0xffff9000c01dfe38) expected ops ops_c+0x0/0xc0 ]---

On arm64, when using CALL_OPS we avoid the problem by construction.

On arm64 without CALL_OPS, the race is possible but *very* difficult to hit as
the load of 'function_trace_op' and the patched branch are back-to-back. With a
delay hacked in that explodes similarly:

| Kernel panic - not syncing: trace_func_b(tracee+0x4/0xc, fstress_tracee_thread+0x28/0x4c, ops_d+0x0/0xb8, 0xffff800083443dc0) expected ops ops_b+0x0/0xb8
| CPU: 0 PID: 60 Comm: fstress_16 Not tainted 6.8.0-rc7-00001-gc8e32c288657-dirty #5
| Hardware name: linux,dummy-virt (DT)
| Call trace:
|  dump_backtrace+0x98/0xf0
|  show_stack+0x20/0x2c
|  dump_stack_lvl+0x48/0x60
|  dump_stack+0x18/0x24
|  panic+0x39c/0x3d0
|  trace_func_c+0x0/0x54
|  ftrace_call+0x4/0x2c
|  tracee+0x8/0xc
|  fstress_tracee_thread+0x28/0x4c
|  kthread+0x118/0x11c
|  ret_from_fork+0x10/0x20
| Kernel Offset: disabled
| CPU features: 0x0,01000000,14020148,21004203
| Memory Limit: none

I believe our options are:

* Avoid the mismatch by construction:

  - On architectures with trampolines, we could ensure that the list_ops gets
    its own trampoline and that we *always* use a trampoline, never using a
    common ftrace_caller. When we switch callers from one trampoline to another
    they'd atomically get the new func+ops.

    I reckon that might be a good option for x86-64?

  - On architectures without trampolines we could 
    require that that the ftrace_caller 
    loads ops->func from the ops pointer.
    
    That'd mean removing the 'ftrace_trace_function' pointer and removing
    patching of the call to the trace function (but the actual tracee callsites
    would still be patched).

    I'd be in favour of this for arm64 since that matches the way CALL_OPS
    works; the only difference is we'd load a global ops pointer rather than a
    per-callsite ops pointer.

* Use rcu_tasks_trace to synchronize updates?

* Something else?

I've included my test case below. Beware that you might need to play with
NR_TRACEE_THREADS vs the number of CPUs you have, and since it uses
ftrace_set_filter_ip() it won't currently work for !DYNAMIC_FTRACE, but that
can easily be hacked around.

Mark.

---->8----
From a4fa96d75cf9eda7c4b1b936dd331e14153385c8 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 6 Mar 2024 13:23:47 +0000
Subject: [PATCH] HACK: ftrace stress test

Try to check that ops->func() is called with the correct ops.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 lib/Makefile  |   3 +
 lib/fstress.c | 158 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100644 lib/fstress.c

diff --git a/lib/Makefile b/lib/Makefile
index 6b09731d8e619..678a916d4f0a0 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -36,6 +36,9 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 nmi_backtrace.o win_minmax.o memcat_p.o \
 	 buildid.o objpool.o
 
+obj-y += fstress.o
+CFLAGS_fstress.o += $(CC_FLAGS_FTRACE)
+
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_SMP) += cpumask.o
 
diff --git a/lib/fstress.c b/lib/fstress.c
new file mode 100644
index 0000000000000..1ec2303f67f6f
--- /dev/null
+++ b/lib/fstress.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt)	"fstress: " fmt
+
+#include <linux/bug.h>
+#include <linux/errno.h>
+#include <linux/ftrace.h>
+#include <linux/init.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+
+#define DEFINE_OPS(x)							\
+	static void trace_func_##x(unsigned long ip,			\
+				   unsigned long parent_ip,		\
+				   struct ftrace_ops *op,		\
+				   struct ftrace_regs *fregs);		\
+									\
+	struct ftrace_ops ops_##x =  {					\
+		.func = trace_func_##x,					\
+	};								\
+									\
+	static void trace_func_##x(unsigned long ip,			\
+				   unsigned long parent_ip,		\
+				   struct ftrace_ops *op,		\
+				   struct ftrace_regs *fregs)		\
+	{								\
+		struct ftrace_ops *expected = &ops_##x;			\
+		if (op == expected)					\
+			return;						\
+		panic("%s(%pS, %pS, %pS, %pS) expected ops %pS\n",	\
+		      __func__, (void *)ip, (void *)parent_ip,		\
+		      op, fregs, expected);				\
+	}
+
+DEFINE_OPS(a);
+DEFINE_OPS(b);
+DEFINE_OPS(c);
+DEFINE_OPS(d);
+
+static struct ftrace_ops *fstress_ops[] = {
+	&ops_a,
+	&ops_b,
+	&ops_c,
+	&ops_d,
+};
+
+static noinline void tracee(void)
+{
+	/*
+	 * Do nothing, but prevent compiler from eliding calls to this
+	 * function.
+	 */
+	barrier();
+}
+
+static noinline int fstress_tracee_thread(void *unused)
+{
+	while (!kthread_should_stop()) {
+		for (int i = 0; i < 100; i++)
+			tracee();
+		cond_resched();
+	}
+
+	return 0;
+}
+
+static int fstress_manager_thread(void *unused)
+{
+	while (!kthread_should_stop()) {
+		int nr_ops = ARRAY_SIZE(fstress_ops);
+
+		for (int i = 0; i <= nr_ops; i++) {
+			if (i < nr_ops)
+				WARN_ON_ONCE(register_ftrace_function(fstress_ops[i]));
+			if (i > 0)
+				WARN_ON_ONCE(unregister_ftrace_function(fstress_ops[i - 1]));
+
+			/*
+			 * TODO: introduce some delay here, so that we spent
+			 * more time with a single tracer enabled (rather than
+			 * the list func).
+			 */
+		}
+
+		cond_resched();
+	}
+
+	return 0;
+}
+
+#define NR_TRACEE_THREADS	25
+
+struct task_struct *tracee_threads[NR_TRACEE_THREADS];
+struct task_struct *manager_thread;
+
+static __init int fstress_init(void)
+{
+	int ret;
+
+	pr_info("Initializing ops\n");
+	for (int i = 0; i < ARRAY_SIZE(fstress_ops); i++) {
+		ret = ftrace_set_filter_ip(fstress_ops[i], (unsigned long)tracee, 0, 0);
+		ret = 0;
+		if (ret) {
+			pr_err("Cannot set filter: %d\n", ret);
+			goto out_free_filters;
+		}
+	}
+
+	pr_info("Creating tracee threads\n");
+	for (int i = 0; i < NR_TRACEE_THREADS; i++) {
+		tracee_threads[i] = kthread_create(fstress_tracee_thread, NULL, "fstress_%d", i);
+		if (!tracee_threads[i]) {
+			pr_err("Cannot create tracee thread %d\n", i);
+			goto out_free_tracees;
+		}
+	}
+
+	pr_info("Creating manager thread\n");
+	manager_thread = kthread_create(fstress_manager_thread, NULL, "fstress_manager");
+	if (!manager_thread) {
+		pr_err("Cannot create manager thread\n");
+		goto out_free_tracees;
+	}
+
+	pr_info("Starting threads\n");
+	for (int i = 0; i < NR_TRACEE_THREADS; i++)
+		wake_up_process(tracee_threads[i]);
+	wake_up_process(manager_thread);
+
+	return 0;
+
+out_free_tracees:
+	for (int i = 0; i < NR_TRACEE_THREADS; i++) {
+		if (tracee_threads[i])
+			kthread_stop(tracee_threads[i]);
+	}
+out_free_filters:
+	for (int i = 0; i < ARRAY_SIZE(fstress_ops); i++)
+		ftrace_free_filter(fstress_ops[i]);
+
+	return -EAGAIN;
+}
+
+static __exit void fstress_exit(void)
+{
+	kthread_stop(manager_thread);
+
+	for (int i = 0; i < NR_TRACEE_THREADS; i++)
+		kthread_stop(tracee_threads[i]);
+
+	for (int i = 0; i < ARRAY_SIZE(fstress_ops); i++)
+		ftrace_free_filter(fstress_ops[i]);
+}
+
+module_init(fstress_init);
+module_exit(fstress_exit);
+MODULE_LICENSE("GPL");
-- 
2.30.2


