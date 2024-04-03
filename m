Return-Path: <linux-kernel+bounces-128908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACA88961BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7691C22619
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8D101C4;
	Wed,  3 Apr 2024 01:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHMeJe/C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB1428E7;
	Wed,  3 Apr 2024 01:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712106435; cv=none; b=RgCGZFewwwJiemfQwBwIi72EwQhdgIpVm0AEhwutKM49d2qzTL/3ZjuLf4D+hPj45sow6t3wXNqTMhH9RXlutER8yiVatDal5GS8gBx1TwTXJoORffPJMEb+q96LW9/07v+cJPFH+eV8q8rtJ0Yx+83JUyLgxuXx5Pskd0/eyHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712106435; c=relaxed/simple;
	bh=EGqoTAgxVaFCAmcmZZVVakgmZFGI0OXp1KgZa2d22g0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UyWcPwd7h68lp6NeeFRUKAgqefYX2uen+EzpIap0qV8qvl225OUy89ICSAMXvPmTnw5nSEeyRnd5QPl5zGQt7wpXqnH97AddUtUEcbk87RBCRL5z4OboH+/D8xta90YF6UrKYrbmTYusaw2jMfCxCN5kmcti4wTxq63LM1MxfNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHMeJe/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296BBC433C7;
	Wed,  3 Apr 2024 01:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712106434;
	bh=EGqoTAgxVaFCAmcmZZVVakgmZFGI0OXp1KgZa2d22g0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BHMeJe/CtQBVTGvazdbr1T2yKAg/zs4zGsljzM4z8V2OCqHWhkr5FsStW7sTSfftn
	 Zs/pAslMfa9/VgBFanE1GkVDLNK5fEyflxZEUl3TTb1kf/VMsd/v6lVT31ZG227iM8
	 hDt8oCdkNvEKfcJ8mEfLuKB7U0UHxQGWNMTehPf/Uiw9R7RtY85dynswUmPnEJp/Wp
	 R/5ddOXkNiZXwOiA87fjM8vYU78NYsT4t1FsHR3XQvwq62GxR7UpZGDLSc/GTh+rbZ
	 yPuj5JZeOZQ9FymGHXNqKvJRW2bmJdkOHQNl6nDPszcstdqkq0MauS57FgeQmwqLz6
	 +3OMhGtRvePCw==
Date: Wed, 3 Apr 2024 10:07:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-Id: <20240403100708.233575a8ac2a5bac2192d180@kernel.org>
In-Reply-To: <20240402093302.2416467-2-jolsa@kernel.org>
References: <20240402093302.2416467-1-jolsa@kernel.org>
	<20240402093302.2416467-2-jolsa@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jiri,

On Tue,  2 Apr 2024 11:33:00 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Adding uretprobe syscall instead of trap to speed up return probe.

This is interesting approach. But I doubt we need to add additional
syscall just for this purpose. Can't we use another syscall or ioctl?

Also, we should run syzkaller on this syscall. And if uretprobe is
set in the user function, what happen if the user function directly
calls this syscall? (maybe it consumes shadow stack?)

Thank you,

> 
> At the moment the uretprobe setup/path is:
> 
>   - install entry uprobe
> 
>   - when the uprobe is hit, it overwrites probed function's return address
>     on stack with address of the trampoline that contains breakpoint
>     instruction
> 
>   - the breakpoint trap code handles the uretprobe consumers execution and
>     jumps back to original return address
> 
> This patch replaces the above trampoline's breakpoint instruction with new
> ureprobe syscall call. This syscall does exactly the same job as the trap
> with some more extra work:
> 
>   - syscall trampoline must save original value for rax/r11/rcx registers
>     on stack - rax is set to syscall number and r11/rcx are changed and
>     used by syscall instruction
> 
>   - the syscall code reads the original values of those registers and
>     restore those values in task's pt_regs area
> 
> Even with the extra registers handling code the having uretprobes handled
> by syscalls shows speed improvement.
> 
>   On Intel (11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz)
> 
>   current:
> 
>     base           :   15.888 ± 0.033M/s
>     uprobe-nop     :    3.016 ± 0.000M/s
>     uprobe-push    :    2.832 ± 0.005M/s
>     uprobe-ret     :    1.104 ± 0.000M/s
>     uretprobe-nop  :    1.487 ± 0.000M/s
>     uretprobe-push :    1.456 ± 0.000M/s
>     uretprobe-ret  :    0.816 ± 0.001M/s
> 
>   with the fix:
> 
>     base           :   15.116 ± 0.045M/s
>     uprobe-nop     :    3.001 ± 0.045M/s
>     uprobe-push    :    2.831 ± 0.004M/s
>     uprobe-ret     :    1.102 ± 0.001M/s
>     uretprobe-nop  :    1.969 ± 0.001M/s  < 32% speedup
>     uretprobe-push :    1.905 ± 0.004M/s  < 30% speedup
>     uretprobe-ret  :    0.933 ± 0.002M/s  < 14% speedup
> 
>   On Amd (AMD Ryzen 7 5700U)
> 
>   current:
> 
>     base           :    5.105 ± 0.003M/s
>     uprobe-nop     :    1.552 ± 0.002M/s
>     uprobe-push    :    1.408 ± 0.003M/s
>     uprobe-ret     :    0.827 ± 0.001M/s
>     uretprobe-nop  :    0.779 ± 0.001M/s
>     uretprobe-push :    0.750 ± 0.001M/s
>     uretprobe-ret  :    0.539 ± 0.001M/s
> 
>   with the fix:
> 
>     base           :    5.119 ± 0.002M/s
>     uprobe-nop     :    1.523 ± 0.003M/s
>     uprobe-push    :    1.384 ± 0.003M/s
>     uprobe-ret     :    0.826 ± 0.002M/s
>     uretprobe-nop  :    0.866 ± 0.002M/s  < 11% speedup
>     uretprobe-push :    0.826 ± 0.002M/s  < 10% speedup
>     uretprobe-ret  :    0.581 ± 0.001M/s  <  7% speedup
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>  arch/x86/kernel/uprobes.c              | 83 ++++++++++++++++++++++++++
>  include/linux/syscalls.h               |  2 +
>  include/linux/uprobes.h                |  2 +
>  include/uapi/asm-generic/unistd.h      |  5 +-
>  kernel/events/uprobes.c                | 18 ++++--
>  kernel/sys_ni.c                        |  2 +
>  7 files changed, 108 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 7e8d46f4147f..af0a33ab06ee 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -383,6 +383,7 @@
>  459	common	lsm_get_self_attr	sys_lsm_get_self_attr
>  460	common	lsm_set_self_attr	sys_lsm_set_self_attr
>  461	common	lsm_list_modules	sys_lsm_list_modules
> +462	64	uretprobe		sys_uretprobe
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 6c07f6daaa22..6fc5d16f6c17 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -12,6 +12,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/uprobes.h>
>  #include <linux/uaccess.h>
> +#include <linux/syscalls.h>
>  
>  #include <linux/kdebug.h>
>  #include <asm/processor.h>
> @@ -308,6 +309,88 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
>  }
>  
>  #ifdef CONFIG_X86_64
> +
> +asm (
> +	".pushsection .rodata\n"
> +	".global uretprobe_syscall_entry\n"
> +	"uretprobe_syscall_entry:\n"
> +	"pushq %rax\n"
> +	"pushq %rcx\n"
> +	"pushq %r11\n"
> +	"movq $" __stringify(__NR_uretprobe) ", %rax\n"
> +	"syscall\n"
> +	"popq %r11\n"
> +	"popq %rcx\n"
> +
> +	/* The uretprobe syscall replaces stored %rax value with final
> +	 * return address, so we don't restore %rax in here and just
> +	 * call ret.
> +	 */
> +	"retq\n"
> +	".global uretprobe_syscall_end\n"
> +	"uretprobe_syscall_end:\n"
> +	".popsection\n"
> +);
> +
> +extern u8 uretprobe_syscall_entry[];
> +extern u8 uretprobe_syscall_end[];
> +
> +void *arch_uprobe_trampoline(unsigned long *psize)
> +{
> +	*psize = uretprobe_syscall_end - uretprobe_syscall_entry;
> +	return uretprobe_syscall_entry;
> +}
> +
> +SYSCALL_DEFINE0(uretprobe)
> +{
> +	struct pt_regs *regs = task_pt_regs(current);
> +	unsigned long err, ip, sp, r11_cx_ax[3];
> +
> +	err = copy_from_user(r11_cx_ax, (void __user *)regs->sp, sizeof(r11_cx_ax));
> +	WARN_ON_ONCE(err);
> +
> +	/* expose the "right" values of r11/cx/ax/sp to uprobe_consumer/s */
> +	regs->r11 = r11_cx_ax[0];
> +	regs->cx  = r11_cx_ax[1];
> +	regs->ax  = r11_cx_ax[2];
> +	regs->sp += sizeof(r11_cx_ax);
> +	regs->orig_ax = -1;
> +
> +	ip = regs->ip;
> +	sp = regs->sp;
> +
> +	uprobe_handle_trampoline(regs);
> +
> +	/*
> +	 * uprobe_consumer has changed sp, we can do nothing,
> +	 * just return via iret
> +	 */
> +	if (regs->sp != sp)
> +		return regs->ax;
> +	regs->sp -= sizeof(r11_cx_ax);
> +
> +	/* for the case uprobe_consumer has changed r11/cx */
> +	r11_cx_ax[0] = regs->r11;
> +	r11_cx_ax[1] = regs->cx;
> +
> +	/*
> +	 * ax register is passed through as return value, so we can use
> +	 * its space on stack for ip value and jump to it through the
> +	 * trampoline's ret instruction
> +	 */
> +	r11_cx_ax[2] = regs->ip;
> +	regs->ip = ip;
> +
> +	err = copy_to_user((void __user *)regs->sp, r11_cx_ax, sizeof(r11_cx_ax));
> +	WARN_ON_ONCE(err);
> +
> +	/* ensure sysret, see do_syscall_64() */
> +	regs->r11 = regs->flags;
> +	regs->cx  = regs->ip;
> +
> +	return regs->ax;
> +}
> +
>  /*
>   * If arch_uprobe->insn doesn't use rip-relative addressing, return
>   * immediately.  Otherwise, rewrite the instruction so that it accesses
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 77eb9b0e7685..db150794f89d 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -972,6 +972,8 @@ asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 flags);
>  /* x86 */
>  asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
>  
> +asmlinkage long sys_uretprobe(void);
> +
>  /* pciconfig: alpha, arm, arm64, ia64, sparc */
>  asmlinkage long sys_pciconfig_read(unsigned long bus, unsigned long dfn,
>  				unsigned long off, unsigned long len,
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index f46e0ca0169c..a490146ad89d 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -138,6 +138,8 @@ extern bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check c
>  extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
>  extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>  					 void *src, unsigned long len);
> +extern void uprobe_handle_trampoline(struct pt_regs *regs);
> +extern void *arch_uprobe_trampoline(unsigned long *psize);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 75f00965ab15..8a747cd1d735 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -842,8 +842,11 @@ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
>  #define __NR_lsm_list_modules 461
>  __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
>  
> +#define __NR_uretprobe 462
> +__SYSCALL(__NR_uretprobe, sys_uretprobe)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 462
> +#define __NR_syscalls 463
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 929e98c62965..90395b16bde0 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1474,11 +1474,20 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
>  	return ret;
>  }
>  
> +void * __weak arch_uprobe_trampoline(unsigned long *psize)
> +{
> +	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
> +
> +	*psize = UPROBE_SWBP_INSN_SIZE;
> +	return &insn;
> +}
> +
>  static struct xol_area *__create_xol_area(unsigned long vaddr)
>  {
>  	struct mm_struct *mm = current->mm;
> -	uprobe_opcode_t insn = UPROBE_SWBP_INSN;
> +	unsigned long insns_size;
>  	struct xol_area *area;
> +	void *insns;
>  
>  	area = kmalloc(sizeof(*area), GFP_KERNEL);
>  	if (unlikely(!area))
> @@ -1502,7 +1511,8 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
>  	/* Reserve the 1st slot for get_trampoline_vaddr() */
>  	set_bit(0, area->bitmap);
>  	atomic_set(&area->slot_count, 1);
> -	arch_uprobe_copy_ixol(area->pages[0], 0, &insn, UPROBE_SWBP_INSN_SIZE);
> +	insns = arch_uprobe_trampoline(&insns_size);
> +	arch_uprobe_copy_ixol(area->pages[0], 0, insns, insns_size);
>  
>  	if (!xol_add_vma(mm, area))
>  		return area;
> @@ -2123,7 +2133,7 @@ static struct return_instance *find_next_ret_chain(struct return_instance *ri)
>  	return ri;
>  }
>  
> -static void handle_trampoline(struct pt_regs *regs)
> +void uprobe_handle_trampoline(struct pt_regs *regs)
>  {
>  	struct uprobe_task *utask;
>  	struct return_instance *ri, *next;
> @@ -2188,7 +2198,7 @@ static void handle_swbp(struct pt_regs *regs)
>  
>  	bp_vaddr = uprobe_get_swbp_addr(regs);
>  	if (bp_vaddr == get_trampoline_vaddr())
> -		return handle_trampoline(regs);
> +		return uprobe_handle_trampoline(regs);
>  
>  	uprobe = find_active_uprobe(bp_vaddr, &is_swbp);
>  	if (!uprobe) {
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index faad00cce269..be6195e0d078 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -391,3 +391,5 @@ COND_SYSCALL(setuid16);
>  
>  /* restartable sequence */
>  COND_SYSCALL(rseq);
> +
> +COND_SYSCALL(uretprobe);
> -- 
> 2.44.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

