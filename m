Return-Path: <linux-kernel+bounces-17867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FBE825453
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FDB1F23F8F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286C82D632;
	Fri,  5 Jan 2024 13:14:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BD52D60F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20F23C15;
	Fri,  5 Jan 2024 05:15:24 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.86.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30D123F64C;
	Fri,  5 Jan 2024 05:14:36 -0800 (PST)
Date: Fri, 5 Jan 2024 13:14:30 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Arnd Bergmann <arnd@arndb.de>, Guo Hui <guohui@uniontech.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] arm64: remove unnecessary ifdefs around
 is_compat_task()
Message-ID: <ZZgAtntCQFKbsGiW@FVFF77S0Q05N>
References: <20240105041458.126602-3-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105041458.126602-3-leobras@redhat.com>

On Fri, Jan 05, 2024 at 01:15:00AM -0300, Leonardo Bras wrote:
> Currently some parts of the codebase will test for CONFIG_COMPAT before
> testing is_compat_task().
> 
> is_compat_task() is a inlined function only present on CONFIG_COMPAT.
> On the other hand, for !CONFIG_COMPAT, we have in linux/compat.h:
> 
> #define is_compat_task() (0)
> 
> Since we have this define available in every usage of is_compat_task() for
> !CONFIG_COMPAT, it's unnecessary to keep the ifdefs, since the compiler is
> smart enough to optimize-out those snippets on CONFIG_COMPAT=n
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>

I tried this atop the arm64 for-next/core branch, using GCC 13.2.0; building
defconfig + CONFIG_COMPAT=n results in build errors:

[mark@lakrids:~/src/linux]% usekorg 13.2.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- Image
  CALL    scripts/checksyscalls.sh
  CC      arch/arm64/kernel/ptrace.o
arch/arm64/kernel/ptrace.c: In function 'task_user_regset_view':
arch/arm64/kernel/ptrace.c:2121:25: error: 'user_aarch32_view' undeclared (first use in this function); did you mean 'user_aarch64_view'?
 2121 |                 return &user_aarch32_view;
      |                         ^~~~~~~~~~~~~~~~~
      |                         user_aarch64_view
arch/arm64/kernel/ptrace.c:2121:25: note: each undeclared identifier is reported only once for each function it appears in
arch/arm64/kernel/ptrace.c:2123:25: error: 'user_aarch32_ptrace_view' undeclared (first use in this function)
 2123 |                 return &user_aarch32_ptrace_view;
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:243: arch/arm64/kernel/ptrace.o] Error 1
make[3]: *** [scripts/Makefile.build:480: arch/arm64/kernel] Error 2
make[2]: *** [scripts/Makefile.build:480: arch/arm64] Error 2
make[1]: *** [/home/mark/src/linux/Makefile:1911: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2

... and looking at the code, user_aarch32_view and user_aarch32_ptrace_view are
both defined under ifdeffery for CONFIG_COMPAT, so that's obviously not going
to work...

That aside, removing ifdeffery is generally nice, so could you please try
building with CONFIG_COMPAT=n and see where you get to?

Thanks,
Mark.

> ---
> Changes since RFCv1:
> - Removed unnecessary new inlined is_compat_task() for arm64
> - Adjusted commit text and title
> Link: https://lore.kernel.org/all/20240104192433.109983-2-leobras@redhat.com/
> 
>  arch/arm64/kernel/ptrace.c  | 6 ++----
>  arch/arm64/kernel/syscall.c | 5 +----
>  2 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 20d7ef82de90a..9f8781f1fdfda 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -173,7 +173,6 @@ static void ptrace_hbptriggered(struct perf_event *bp,
>  	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
>  	const char *desc = "Hardware breakpoint trap (ptrace)";
>  
> -#ifdef CONFIG_COMPAT
>  	if (is_compat_task()) {
>  		int si_errno = 0;
>  		int i;
> @@ -195,7 +194,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
>  						  desc);
>  		return;
>  	}
> -#endif
> +
>  	arm64_force_sig_fault(SIGTRAP, TRAP_HWBKPT, bkpt->trigger, desc);
>  }
>  
> @@ -2112,7 +2111,6 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
>  
>  const struct user_regset_view *task_user_regset_view(struct task_struct *task)
>  {
> -#ifdef CONFIG_COMPAT
>  	/*
>  	 * Core dumping of 32-bit tasks or compat ptrace requests must use the
>  	 * user_aarch32_view compatible with arm32. Native ptrace requests on
> @@ -2123,7 +2121,7 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
>  		return &user_aarch32_view;
>  	else if (is_compat_thread(task_thread_info(task)))
>  		return &user_aarch32_ptrace_view;
> -#endif
> +
>  	return &user_aarch64_view;
>  }
>  
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 9a70d9746b661..ad198262b9817 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -20,14 +20,11 @@ long sys_ni_syscall(void);
>  
>  static long do_ni_syscall(struct pt_regs *regs, int scno)
>  {
> -#ifdef CONFIG_COMPAT
> -	long ret;
>  	if (is_compat_task()) {
> -		ret = compat_arm_syscall(regs, scno);
> +		long ret = compat_arm_syscall(regs, scno);
>  		if (ret != -ENOSYS)
>  			return ret;
>  	}
> -#endif
>  
>  	return sys_ni_syscall();
>  }
> -- 
> 2.43.0
> 

