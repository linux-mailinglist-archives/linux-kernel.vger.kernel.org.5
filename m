Return-Path: <linux-kernel+bounces-73120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DCD85BDDA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9CB2885CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0046A8D9;
	Tue, 20 Feb 2024 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3n507ENq"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670396A8D3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437236; cv=none; b=Oa3kOcphyRRUSUVIebYl6rzT72gGYTn0aB6pGYwo7caoKvP3JRDh9xzGKTs2lzT0n4a+HgiY8M9TaTwE2O01llEbInYW0IjRcmnWmqg2L0kfE7+sTWO/dyhIqSdqDC4lvyhXLpCALxtsS8lF5dzZLUs8sWozE0hJEPHFGgmW+jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437236; c=relaxed/simple;
	bh=kJZI3FK4QZU+Di6fh4itqdl7ucWmclUlXqxApwi7+SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHaer45MFD8F/HhF92qEJtx603M+if/23QwB+Ny8x7rAdBy1Cz7gzefv2CV9JIlPAoA1NJ/tiZUajXkKU+v/sbzrtYm98iJwgfy1OvJJY0OJXOTmPtzVJkl3smOuXx8cgCDih/6B0mGW5mDAiro9erndviVr0pswUFszOqE1LoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3n507ENq; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563dd5bd382so28749a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708437233; x=1709042033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=spBbznPNh4TAfNFhlhyDDg2OGTaBiEYUcTEdGHDr3/k=;
        b=3n507ENqZfKUnpFFPBtBxRV6pODf4Drb+pZ6ZxF3d6PVkRZ15zz8lFBIcv+WOx4xdo
         YNxbDpUvE9VTW8brE7qZD+AEW8bkwI5rpPs9amWtzaJRaeR4iCwobZnKsW/p/EYFfD+G
         R/kCjPL7rhjHo/b+b6tB3rQF/gsY6lvrSEMxuPpRjqJ7nBI+msoD6brsmrhauZz2pPK+
         3LE3RyX+exs9RIMNVIsL9cM7pSh7ugaUwVRTAZ+QewMBK7xaMweztmnhaDCDnCXPRnux
         5vr/w2P0XWzkwDsIEZGprVTqjYwL9ePwFQXUV1e8EALl0lN5S6+Vhhu0xKG5IOlv0u5u
         MYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708437233; x=1709042033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spBbznPNh4TAfNFhlhyDDg2OGTaBiEYUcTEdGHDr3/k=;
        b=LXwFWokGJ7pgMQRqCfmAwo2AdnvRu817+8N13amUkETmFRarBfthrRa0lN0KY2EuJh
         asq1AL+tlEfGMUfasfWcNscROaaqEsyBSMbJy94+aF38gPN+/DlwXwnYR+Ehyl9s9tT7
         nODfBpfLYRFpscXwyiSW1LiH/XaRw0jrf0pjXdngSx09Us/IrKnqM7JLs9anqFkO/7tR
         pvEIxmgwoplMsq5gfuI6K3lLV/DsDwuvvNyaixPssKYHvkRsQ5cwMetogDORyDsfDKHM
         jw+wlUwtu3WpFuuVB2oNbavEAIkYmA6GmmLw6s5ZE8lSXJD2GK11yqTspSYLoXOHQtd0
         /JnA==
X-Gm-Message-State: AOJu0Yxuh+hMcBNIj83BawhK/iCYt5+aSeJaPP3I5WxKoDDWauvO+WNQ
	GF2hgN2r4tmf5IRcG0eXEWnD8Z3bnfja6AW3RVNqAHp5VzEbSv+1SGqNGHrdo+wfe7p4zt6Zqm3
	XavU1dEBqPJG2NPj5Tk6fshY3PwPO5S0FIccU
X-Google-Smtp-Source: AGHT+IEKAtHicKOoEx0Jg0gKmaOHpOZTxdYbilWRQkEuKn8HSulbu0wo4VaGO+BR1K5BnT4XXuiTDbO/AV7mYFvsB6Q=
X-Received: by 2002:aa7:d848:0:b0:564:5c91:10be with SMTP id
 f8-20020aa7d848000000b005645c9110bemr291420eds.4.1708437232547; Tue, 20 Feb
 2024 05:53:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215191402.681674-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20240215191402.681674-1-mathieu.desnoyers@efficios.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 20 Feb 2024 14:53:37 +0100
Message-ID: <CACT4Y+YFQJE8tvHxXmJcd8Mr8NY2AYnYvQ1ZBxQQrN522KEbrg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] sched/rseq: Consider rseq abort in page fault handler
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, Peter Oskolkov <posk@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Chris Kennelly <ckennelly@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 20:14, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Consider rseq abort before emitting the SIGSEGV or SIGBUS signals from
> the page fault handler.
>
> This allows using membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
> to abort rseq critical sections which include memory accesses to
> memory which mapping can be munmap'd or mprotect'd after the
> membarrier "rseq fence" without causing SIGSEGV or SIGBUS when the page
> fault handler triggered by a faulting memory access within a rseq
> critical section is preempted before handling the page fault.
>
> The problematic scenario is:
>
> CPU 0                          CPU 1
> ------------------------------------------------------------------
>                                old_p = P
>                                P = NULL
> - rseq c.s. begins
> - x = P
> - if (x != NULL)
>   - v = *x
>     - page fault
>     - preempted
>                                membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ)
>                                munmap(old_p) (or mprotect(old_p))
>     - handle page fault
>     - force_sig_fault(SIGSEGV)
>     - rseq resume notifier
>       - move IP to abort IP
>   -> SIGSEGV handler runs.
>
> This is solved by postponing the force_sig_fault() to return to
> user-space when the page fault handler detects that rseq events will
> cause the thread to call the rseq resume notifier before going back to
> user-space. This allows the rseq resume notifier to load the userspace
> memory pointed by rseq->rseq_cs to compare the IP with the rseq c.s.
> range before either moving the IP to the abort handler or calling
> force_sig_fault() with the parameters previously saved by the page fault
> handler.
>
> Add a new AT_RSEQ_FEATURE_FLAGS getauxval(3) to allow user-space to
> query whether the kernel implements this behavior (flag:
> RSEQ_FEATURE_PAGE_FAULT_ABORT).
>
> Untested implementation submitted for early feedback.
>
> Only x86 is implemented in this PoC.
>
> Link: https://lore.kernel.org/lkml/CACT4Y+bXfekygoyhO7pCctjnL15=E=Zs31BUGXU0dk8d4rc1Cw@mail.gmail.com/
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Peter Oskolkov <posk@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Chris Kennelly <ckennelly@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-mm@kvack.org

Hi Mathieu,

Thanks for the quick fix.
I can try to test this, but I can't apply this.
What's the base commit for the patch?

On top of latest upstream head v6.8-rc5:

$ patch -p1 < /tmp/patch
patching file arch/x86/mm/fault.c
patching file fs/binfmt_elf.c
patching file include/linux/sched.h
Hunk #1 succeeded at 745 (offset 2 lines).
Hunk #2 succeeded at 1329 (offset 3 lines).
Hunk #3 succeeded at 2143 with fuzz 2 (offset -197 lines).
Hunk #4 FAILED at 2402.
Hunk #5 FAILED at 2417.
2 out of 5 hunks FAILED -- saving rejects to file include/linux/sched.h.rej
patching file include/linux/sched/signal.h
Hunk #1 succeeded at 784 (offset 3 lines).
patching file include/uapi/linux/auxvec.h
patching file include/uapi/linux/rseq.h
patching file kernel/rseq.c
Hunk #2 succeeded at 299 with fuzz 1.


> ---
>  arch/x86/mm/fault.c          |  4 ++--
>  fs/binfmt_elf.c              |  1 +
>  include/linux/sched.h        | 16 ++++++++++++++++
>  include/linux/sched/signal.h | 24 ++++++++++++++++++++++++
>  include/uapi/linux/auxvec.h  |  1 +
>  include/uapi/linux/rseq.h    |  7 +++++++
>  kernel/rseq.c                | 36 +++++++++++++++++++++++++++++++-----
>  7 files changed, 82 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 679b09cfe241..42ac39680cb6 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -854,7 +854,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>         if (si_code == SEGV_PKUERR)
>                 force_sig_pkuerr((void __user *)address, pkey);
>         else
> -               force_sig_fault(SIGSEGV, si_code, (void __user *)address);
> +               rseq_lazy_force_sig_fault(SIGSEGV, si_code, (void __user *)address);
>
>         local_irq_disable();
>  }
> @@ -973,7 +973,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
>                 return;
>         }
>  #endif
> -       force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
> +       rseq_lazy_force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
>  }
>
>  static int spurious_kernel_fault_check(unsigned long error_code, pte_t *pte)
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 5397b552fbeb..8fece0911c7d 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -273,6 +273,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>  #ifdef CONFIG_RSEQ
>         NEW_AUX_ENT(AT_RSEQ_FEATURE_SIZE, offsetof(struct rseq, end));
>         NEW_AUX_ENT(AT_RSEQ_ALIGN, __alignof__(struct rseq));
> +       NEW_AUX_ENT(AT_RSEQ_FEATURE_FLAGS, RSEQ_FEATURE_FLAGS);
>  #endif
>  #undef NEW_AUX_ENT
>         /* AT_NULL is zero; clear the rest too */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 292c31697248..39aa585ba2a3 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -743,6 +743,15 @@ struct kmap_ctrl {
>  #endif
>  };
>
> +#ifdef CONFIG_RSEQ
> +struct rseq_lazy_sig {
> +       bool pending;
> +       int sig;
> +       int code;
> +       void __user *addr;
> +};
> +#endif
> +
>  struct task_struct {
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>         /*
> @@ -1317,6 +1326,7 @@ struct task_struct {
>          * with respect to preemption.
>          */
>         unsigned long rseq_event_mask;
> +       struct rseq_lazy_sig rseq_lazy_sig;
>  #endif
>
>  #ifdef CONFIG_SCHED_MM_CID
> @@ -2330,6 +2340,8 @@ unsigned long sched_cpu_util(int cpu);
>
>  #ifdef CONFIG_RSEQ
>
> +#define RSEQ_FEATURE_FLAGS     RSEQ_FEATURE_PAGE_FAULT_ABORT
> +
>  /*
>   * Map the event mask on the user-space ABI enum rseq_cs_flags
>   * for direct mask checks.
> @@ -2390,6 +2402,8 @@ static inline void rseq_migrate(struct task_struct *t)
>   */
>  static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
>  {
> +       WARN_ON_ONCE(current->rseq_lazy_sig.pending);
> +
>         if (clone_flags & CLONE_VM) {
>                 t->rseq = NULL;
>                 t->rseq_len = 0;
> @@ -2405,6 +2419,8 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
>
>  static inline void rseq_execve(struct task_struct *t)
>  {
> +       WARN_ON_ONCE(current->rseq_lazy_sig.pending);
> +
>         t->rseq = NULL;
>         t->rseq_len = 0;
>         t->rseq_sig = 0;
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 3499c1a8b929..0d75dfde2f9b 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -781,4 +781,28 @@ static inline unsigned long rlimit_max(unsigned int limit)
>         return task_rlimit_max(current, limit);
>  }
>
> +#ifdef CONFIG_RSEQ
> +
> +static inline int rseq_lazy_force_sig_fault(int sig, int code, void __user *addr)
> +{
> +       struct task_struct *t = current;
> +
> +       if (!t->rseq_event_mask)
> +               return force_sig_fault(sig, code, addr);
> +       t->rseq_lazy_sig.pending = true;
> +       t->rseq_lazy_sig.sig = sig;
> +       t->rseq_lazy_sig.code = code;
> +       t->rseq_lazy_sig.addr = addr;
> +       return 0;
> +}
> +
> +#else
> +
> +static inline int rseq_lazy_force_sig_fault(int sig, int code, void __user *addr)
> +{
> +       return force_sig_fault(sig, code, addr);
> +}
> +
> +#endif
> +
>  #endif /* _LINUX_SCHED_SIGNAL_H */
> diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
> index 6991c4b8ab18..5044f367a219 100644
> --- a/include/uapi/linux/auxvec.h
> +++ b/include/uapi/linux/auxvec.h
> @@ -32,6 +32,7 @@
>  #define AT_HWCAP2 26   /* extension of AT_HWCAP */
>  #define AT_RSEQ_FEATURE_SIZE   27      /* rseq supported feature size */
>  #define AT_RSEQ_ALIGN          28      /* rseq allocation alignment */
> +#define AT_RSEQ_FEATURE_FLAGS  29      /* rseq feature flags */
>
>  #define AT_EXECFN  31  /* filename of program */
>
> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
> index c233aae5eac9..0fdb192e3cd3 100644
> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -37,6 +37,13 @@ enum rseq_cs_flags {
>                 (1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
>  };
>
> +/*
> + * rseq feature flags. Query with getauxval(AT_RSEQ_FEATURE_FLAGS).
> + */
> +enum rseq_feature_flags {
> +       RSEQ_FEATURE_PAGE_FAULT_ABORT = (1U << 0),
> +};
> +
>  /*
>   * struct rseq_cs is aligned on 4 * 8 bytes to ensure it is always
>   * contained within a single cache-line. It is usually declared as
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 9de6e35fe679..f686a97abb45 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -271,6 +271,25 @@ static bool in_rseq_cs(unsigned long ip, struct rseq_cs *rseq_cs)
>         return ip - rseq_cs->start_ip < rseq_cs->post_commit_offset;
>  }
>
> +static void rseq_clear_lazy_sig_fault(struct task_struct *t)
> +{
> +       if (!t->rseq_lazy_sig.pending)
> +               return;
> +       t->rseq_lazy_sig.pending = false;
> +       t->rseq_lazy_sig.sig = 0;
> +       t->rseq_lazy_sig.code = 0;
> +       t->rseq_lazy_sig.addr = NULL;
> +}
> +
> +static void rseq_force_lazy_sig_fault(struct task_struct *t)
> +{
> +       if (!t->rseq_lazy_sig.pending)
> +               return;
> +       force_sig_fault(t->rseq_lazy_sig.sig, t->rseq_lazy_sig.code,
> +                       t->rseq_lazy_sig.addr);
> +       rseq_clear_lazy_sig_fault(t);
> +}
> +
>  static int rseq_ip_fixup(struct pt_regs *regs)
>  {
>         unsigned long ip = instruction_pointer(regs);
> @@ -280,25 +299,32 @@ static int rseq_ip_fixup(struct pt_regs *regs)
>
>         ret = rseq_get_rseq_cs(t, &rseq_cs);
>         if (ret)
> -               return ret;
> +               goto nofixup;
>
>         /*
>          * Handle potentially not being within a critical section.
>          * If not nested over a rseq critical section, restart is useless.
>          * Clear the rseq_cs pointer and return.
>          */
> -       if (!in_rseq_cs(ip, &rseq_cs))
> -               return clear_rseq_cs(t);
> +       if (!in_rseq_cs(ip, &rseq_cs)) {
> +               ret = clear_rseq_cs(t);
> +               goto nofixup;
> +       }
>         ret = rseq_need_restart(t, rseq_cs.flags);
>         if (ret <= 0)
> -               return ret;
> +               goto nofixup;
>         ret = clear_rseq_cs(t);
>         if (ret)
> -               return ret;
> +               goto nofixup;
> +       rseq_clear_lazy_sig_fault(t);
>         trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
>                             rseq_cs.abort_ip);
>         instruction_pointer_set(regs, (unsigned long)rseq_cs.abort_ip);
>         return 0;
> +
> +nofixup:
> +       rseq_force_lazy_sig_fault(t);
> +       return ret;
>  }
>
>  /*
> --
> 2.39.2
>

