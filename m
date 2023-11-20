Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DA87F15AF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjKTO3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbjKTO33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:29:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D486AED
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:29:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACF25FEC;
        Mon, 20 Nov 2023 06:30:09 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.25.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82A383F6C4;
        Mon, 20 Nov 2023 06:29:22 -0800 (PST)
Date:   Mon, 20 Nov 2023 14:29:17 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     qiwuchen55@gmail.com
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenqiwu <qiwu.chen@transsion.com>
Subject: Re: [PATCH] arm64: Add user stacktrace support
Message-ID: <ZVttPU64cCem6szI@FVFF77S0Q05N.cambridge.arm.com>
References: <20231118134504.154842-1-qiwu.chen@transsion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118134504.154842-1-qiwu.chen@transsion.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 09:45:04PM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <qiwu.chen@transsion.com>
> 
> 1. Introduce and export arch_dump_user_stacktrace() API to support
> user stacktrace dump for a user task (both current and non-current task).
> A example test about the log format of user stacktrace as shown below:
> [test-515] Dump user backtrace:
> <0xffffb0c1a750> in /lib/aarch64-linux-gnu/libc-2.32.so[ffffb0b53000-ffffb0cb1000]
> <0xaaaacbf8097c> in /mnt/test[aaaacbf80000-aaaacbf81000]
> <0xffffb0b778b8> in /lib/aarch64-linux-gnu/libc-2.32.so[ffffb0b53000-ffffb0cb1000]
> <0xaaaacbf80834> in /mnt/test[aaaacbf80000-aaaacbf81000]

Where is this used?

We already have user stacktracing code in arch/arm64/kernel/perf_callchain.c
which doesn't depend on this API. What does this API enable that we don't
support today?

> 2. Add arch_stack_walk_user() implementation to support userstacktrace transsionce option.

What is this 'userstacktrace transsionce option' ?

> A example test about the output format of ftrace userstacktrace as shown below:
>     bash-489     [000] .....  2167.660775: sched_process_fork: comm=bash pid=489 child_comm=bash child_pid=596
>     bash-489     [000] .....  2167.660787: <user stack trace>
>  => /lib/aarch64-linux-gnu/libc-2.32.so[+0xa76d8]
>  => /bin/bash[+0x5f354]
>  => /bin/bash[+0x4876c]
>  => /bin/bash[+0x4aec4]
>  => /bin/bash[+0x4da48]
>  => /bin/bash[+0x4b710]
>  => /bin/bash[+0x4c31c]
>  => /bin/bash[+0x339b0]
> 
> Tested-by-by: chenqiwu <qiwu.chen@transsion.com>
> Signed-off-by: chenqiwu <qiwu.chen@transsion.com>
> ---
>  arch/arm64/Kconfig             |   1 +
>  arch/arm64/kernel/stacktrace.c | 208 +++++++++++++++++++++++++++++++++
>  include/linux/stacktrace.h     |  10 ++
>  3 files changed, 219 insertions(+)

As above, we already have user stacktracing code, and we shouldn't add
*distinct* unwinders. Either that code should be factored out and reused, or
this code should replace it.

> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7b071a004..4c5066f88 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -255,6 +255,7 @@ config ARM64
>  	select TRACE_IRQFLAGS_SUPPORT
>  	select TRACE_IRQFLAGS_NMI_SUPPORT
>  	select HAVE_SOFTIRQ_ON_OWN_STACK
> +	select USER_STACKTRACE_SUPPORT
>  	help
>  	  ARM 64-bit (AArch64) Linux support.
>  
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 17f66a74c..4e7bf2922 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -215,6 +215,214 @@ static bool dump_backtrace_entry(void *arg, unsigned long where)
>  	return true;
>  }
>  
> +/* The struct defined for AArch64 userspace stack frame */
> +struct stack_frame_user {
> +	unsigned long fp;
> +	unsigned long sp;
> +	unsigned long pc;
> +};
> +
> +/*
> + * The function of AArch64 userspace stack frame unwind method.
> + * Note: If the caller is not current task, it's supposed to call
> + * access_process_vm() to access another task' address space.
> + */
> +static int arch_unwind_user_frame(struct task_struct *tsk, unsigned long high,
> +				struct stack_frame_user *frame)
> +{
> +	int ret = 0;
> +	unsigned long fp = frame->fp;
> +	unsigned long low = frame->sp;
> +
> +	if (fp < low || fp > high || fp & 0xf)
> +		return -EFAULT;
> +
> +	frame->sp = fp + 0x10;

Given you always set frame->sp as fp + 0x10, why does frame->sp need to exist
at all?

Per AAPCS64, the frame record only conatins a copy of the FP and LR, and is
*not* directly associated with the SP, so I don't think we should pretend it
is.

> +	/* Disable page fault to make sure get_user going on wheels */

I have no idea what this comment is trying to say.

Why exactly you you think we need to disable page faults? Isn't that going to
make this fail arbitrarily when we *can* fault pages in? I know that the
existing perf unwinder does this, but that's a design problem we'd like to
solve (e.g. by deferring the unwind until return to userspace).

> +	pagefault_disable();
> +	if (tsk == current) {
> +		if (get_user(frame->fp, (unsigned long __user *)fp) ||
> +			get_user(frame->pc, (unsigned long __user *)(fp + 8)))
> +			ret = -EFAULT;
> +	} else {
> +		if (access_process_vm(tsk, fp, &frame->fp,
> +			sizeof(unsigned long), 0) != sizeof(unsigned long) ||
> +			access_process_vm(tsk, fp + 0x08, &frame->pc,
> +			sizeof(unsigned long), 0) != sizeof(unsigned long))
> +			ret = -EFAULT;
> +	}
> +	pagefault_enable();

If task isn't current, userspace could be running and this will be racy and
unreliable.

Where is this used with task != current? Why do we need to support that case at
all?

What does this do for COMPAT tasks?

> +
> +	return ret;
> +}
> +
> +/*
> + * Print the executable address and corresponding VMA info.
> + */
> +static void print_vma_addr_info(char *prefix, struct task_struct *task,
> +				unsigned long ip, const char *loglvl)
> +{
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;
> +
> +	if (task != current)
> +		mm = get_task_mm(task);
> +	else
> +		mm = task->mm;

Why can't we always use get_task_mm(), even for task == current?

> +
> +	if (!mm)
> +		return;
> +	/*
> +	 * we might be running from an atomic context so we cannot sleep
> +	 */
> +	if (!mmap_read_trylock(mm)) {
> +		mmput(mm);
> +		return;
> +	}

When is this called from an atomic context?

> +
> +	vma = find_vma(mm, ip);
> +	if (vma && vma->vm_file) {
> +		struct file *f = vma->vm_file;
> +		char *buf = (char *)__get_free_page(GFP_NOWAIT);
> +
> +		if (buf) {
> +			char *p;
> +
> +			p = file_path(f, buf, PAGE_SIZE);
> +			if (IS_ERR(p))
> +				p = "?";
> +			printk("%s%s%s[%lx-%lx]\n", loglvl, prefix, p,
> +					vma->vm_start,
> +					vma->vm_end);
> +			free_page((unsigned long)buf);
> +		}
> +	}
> +	mmap_read_unlock(mm);
> +	if (task != current)
> +		mmput(mm);
> +}
> +
> +static struct vm_area_struct *find_user_stack_vma(struct task_struct *task, unsigned long sp)
> +{
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;
> +
> +	if (task != current)
> +		mm = get_task_mm(task);
> +	else
> +		mm = task->mm;
> +
> +	if (!mm)
> +		return NULL;
> +	/*
> +	 * we might be running from an atomic context so we cannot sleep
> +	 */
> +	if (!mmap_read_trylock(mm)) {
> +		mmput(mm);
> +		return NULL;
> +	}
> +	vma = find_vma(mm, sp);
> +	mmap_read_unlock(mm);
> +	if (task != current)
> +		mmput(mm);

What guarantees the VMA is safe to use after this? What ensures that it won't
be freed? What ensures that it is still valid and not subject to concurrent
modification?

> +
> +	return vma;
> +}
> +
> +static void dump_user_backtrace_entry(struct task_struct *tsk,
> +				unsigned long where, const char *loglvl)
> +{
> +	char prefix[64];
> +
> +	snprintf(prefix, sizeof(prefix), "<0x%lx> in ", where);
> +	print_vma_addr_info(prefix, tsk, where, loglvl);
> +}
> +
> +void arch_dump_user_stacktrace(struct pt_regs *regs, struct task_struct *tsk,
> +								const char *loglvl)
> +{
> +	struct stack_frame_user frame;
> +	struct vm_area_struct *vma;
> +	unsigned long userstack_start, userstack_end;
> +
> +	if (!tsk)
> +		tsk = current;
> +
> +	/*
> +	 * If @regs is not specified or caller is not current task,.
> +	 * @regs is supposed to get from @tsk.
> +	 */
> +	if (!regs || tsk != current)
> +		regs = task_pt_regs(tsk);

The user state is *always* in task_pt_regs(tsk), even when tsk == current.

Why does this function take the regs as an argument at all?

> +
> +	/* TODO: support stack unwind for compat user mode */
> +	if (compat_user_mode(regs))
> +		return;
> +
> +	userstack_start = regs->user_regs.sp;
> +	vma = find_user_stack_vma(tsk, userstack_start);
> +	if (!vma)
> +		return;
> +
> +	userstack_end = vma->vm_end;
> +	frame.fp = regs->user_regs.regs[29];
> +	frame.sp = userstack_start;
> +	frame.pc = regs->user_regs.pc;
> +
> +	printk("%s[%s-%d] Dump user backtrace:\n", loglvl, tsk->comm, tsk->pid);
> +	while (1) {
> +		unsigned long where = frame.pc;
> +
> +		if (!where || where & 0x3)
> +			break;
> +		dump_user_backtrace_entry(tsk, where, loglvl);
> +		if (arch_unwind_user_frame(tsk, userstack_end, &frame) < 0)
> +			break;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(arch_dump_user_stacktrace);

Where is this used from?

Why should it be exported?

> +
> +/**
> + * stack_trace_save_user - Save user space stack traces into a storage array
> + * @consume_entry: Callback for save a user space stack trace
> + * @cookie:	Caller supplied pointer handed back by arch_stack_walk()
> + * @regs: The pt_regs pointer of current task
> + */
> +void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
> +			  const struct pt_regs *regs)
> +{
> +	struct stack_frame_user frame;
> +	struct vm_area_struct *vma;
> +	unsigned long userstack_start, userstack_end;
> +	struct task_struct *tsk = current;
> +
> +	/* TODO: support stack unwind for compat user mode */
> +	if (!regs || !user_mode(regs) || compat_user_mode(regs))
> +		return;
> +
> +	userstack_start = regs->user_regs.sp;
> +	vma = find_user_stack_vma(tsk, userstack_start);
> +	if (!vma)

Yet again this duplicates the code above.

If we really need this, then arch_stack_walk_user() should be the real
unwinder, and the caes above should be built atop arch_stack_walk_user().

> +		return;
> +
> +	userstack_end = vma->vm_end;
> +	frame.fp = regs->user_regs.regs[29];
> +	frame.sp = userstack_start;
> +	frame.pc = regs->user_regs.pc;
> +
> +	while (1) {
> +		unsigned long where = frame.pc;
> +
> +		/* Sanity check: ABI requires pc to be aligned 4 bytes. */
> +		if (!where || where & 0x3)
> +			break;

Why do we care whether the PC is valid?

There are plenty of other things that we could check (e.g. whether this points
to executable memory), but it seems kinda pointless to care beyond whether we
can unwind the frame.

Note that we're missing the LR anyway, so this *isn't* a reliable unwind.

Thanks,
Mark.

> +		if (!consume_entry(cookie, where))
> +			break;
> +		if (arch_unwind_user_frame(tsk, userstack_end, &frame) < 0)
> +			break;
> +	}
> +}
> +
>  void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
>  		    const char *loglvl)
>  {
> diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
> index 97455880a..bc5a7bf56 100644
> --- a/include/linux/stacktrace.h
> +++ b/include/linux/stacktrace.h
> @@ -60,6 +60,16 @@ int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry, void *cookie,
>  
>  void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
>  			  const struct pt_regs *regs);
> +
> +/**
> + * arch_dump_user_stacktrace - Architecture specific function to dump the
> + *			       stack trace for user process
> + * @regs: Pointer to the pt_regs of user process
> + * @tsk: Pointer to the task_struct of user process
> + * @loglvl: Log level
> + */
> +void arch_dump_user_stacktrace(struct pt_regs *regs, struct task_struct *tsk,
> +			       const char *loglvl);
>  #endif /* CONFIG_ARCH_STACKWALK */
>  
>  #ifdef CONFIG_STACKTRACE
> -- 
> 2.25.1
> 
