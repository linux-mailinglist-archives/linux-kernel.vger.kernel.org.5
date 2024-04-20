Return-Path: <linux-kernel+bounces-152285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFD98ABBE1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916691C209F0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948F420DC5;
	Sat, 20 Apr 2024 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9K5YyC+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A4117C72
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713621540; cv=none; b=mFyrs98G9wtUG+PRihQxGPDQwUxJTISIsU1MGl4E+DAhCFstJHKxkrAE2BdA6ac9N107XDni0UDCqnftxW2dyA2n844Inv0Z1EHJ4Ly8Tbl6zm5HUpaeWMg+Z8TNFjjtnuJo0cp/SgcLFL00Kqfs5gJRi4luK8TzdBKIMuElo7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713621540; c=relaxed/simple;
	bh=SF4UXNVWu1RLkZCz/bnUpg3jscYlA1SI43W14Rk3tpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2wYHjc66j+FU1JOiJGtDjwTUqUj+R+kRITDZMcu97hCW0KuKRyRFEAusFIFqvN3aCPtb8km9KjdI7KK6FYOXZuc5mj3iTk7yxtlU/nRM7n54ZG5xaZE/Ktr1zuIFMN+YgvScmZIr3NSzicIu7hsqDQbk9TCvBb8/CUomvO/cvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9K5YyC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B9EC072AA;
	Sat, 20 Apr 2024 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713621540;
	bh=SF4UXNVWu1RLkZCz/bnUpg3jscYlA1SI43W14Rk3tpQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=r9K5YyC+cm5iYdLcRLgLYdkeC7VvqzeaS9p6zk4+0e+06RtbFNTYJoOVyQ4Vfxy8L
	 VzYPwNYzBInX+9b8yNQoZld8fEhxPGZzESQsmxGUHFGu+DyWIxc1q2F1Hg2GZb9E52
	 rOGT4ZppX63LetRtRvLCEguBX2IgUbp5SoXW36rkeY/fLd/Cs0Srhm+8MlP2fbTJBF
	 ywVquBSc6hAFstgAeSvtbK4tHaZMyrhaso6mfMIJbbtlewAELnfue/+Gvl8u52K0os
	 /LkYdwawzsK9i1/j39188wCm2KYEJB56B6SlVWhUxzvUtgYQW++6DM9wENd7C16Q2n
	 ZnMvmPR6Rq1ig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 75A12CE0D6F; Sat, 20 Apr 2024 06:58:58 -0700 (PDT)
Date: Sat, 20 Apr 2024 06:58:58 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 3/5] x86/syscall: Mark exit[_group] syscall handlers
 __noreturn
Message-ID: <0c410ba5-0e42-43b6-80b8-a69c5419a97d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cover.1713559768.git.jpoimboe@kernel.org>
 <3b99cb2919c88ab3d353337423b2f0f1b9173f0a.1713559768.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b99cb2919c88ab3d353337423b2f0f1b9173f0a.1713559768.git.jpoimboe@kernel.org>

On Fri, Apr 19, 2024 at 02:09:49PM -0700, Josh Poimboeuf wrote:
> The direct-call syscall dispatch functions don't know that the exit()
> and exit_group() syscall handlers don't return.  As a result the call
> sites aren't optimized accordingly.
> 
> Fix that by marking those exit syscall declarations as __noreturn.
> 
> Fixes the following warnings:
> 
>   vmlinux.o: warning: objtool: x64_sys_call+0x2804: __x64_sys_exit() is missing a __noreturn annotation
>   vmlinux.o: warning: objtool: ia32_sys_call+0x29b6: __ia32_sys_exit_group() is missing a __noreturn annotation
> 
> Fixes: 7390db8aea0d ("x86/bhi: Add support for clearing branch history at syscall entry")
> Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> Closes: https://lkml.kernel.org/lkml/6dba9b32-db2c-4e6d-9500-7a08852f17a3@paulmck-laptop
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Looks good, but it does not apply on top of current -next and I don't
trust myself to hand-apply it (something about having just got off of
a flight across the big pond).

Could you please let me know what else do I need to pull in to be able
to cleanly apply this one?

							Thanx, Paul

> ---
>  arch/x86/entry/syscall_64.c            | 4 ++++
>  arch/x86/entry/syscall_x32.c           | 4 ++++
>  arch/x86/entry/syscalls/syscall_64.tbl | 6 +++---
>  arch/x86/um/sys_call_table_32.c        | 1 +
>  arch/x86/um/sys_call_table_64.c        | 1 +
>  scripts/syscalltbl.sh                  | 6 ++++--
>  tools/objtool/noreturns.h              | 4 ++++
>  7 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
> index 96ea1f8a1d3f..ff36a993a07e 100644
> --- a/arch/x86/entry/syscall_64.c
> +++ b/arch/x86/entry/syscall_64.c
> @@ -8,9 +8,13 @@
>  #include <asm/syscall.h>
>  
>  #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
> +#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __x64_##sym(const struct pt_regs *);
>  #include <asm/syscalls_64.h>
>  #undef __SYSCALL
>  
> +#undef __SYSCALL_NORETURN
> +#define __SYSCALL_NORETURN __SYSCALL
> +
>  #define __SYSCALL(nr, sym) __x64_##sym,
>  const sys_call_ptr_t sys_call_table[] = {
>  #include <asm/syscalls_64.h>
> diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
> index 5aef4230faca..4221ecce6e68 100644
> --- a/arch/x86/entry/syscall_x32.c
> +++ b/arch/x86/entry/syscall_x32.c
> @@ -8,9 +8,13 @@
>  #include <asm/syscall.h>
>  
>  #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
> +#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __x64_##sym(const struct pt_regs *);
>  #include <asm/syscalls_x32.h>
>  #undef __SYSCALL
>  
> +#undef __SYSCALL_NORETURN
> +#define __SYSCALL_NORETURN __SYSCALL
> +
>  #define __SYSCALL(nr, sym) __x64_##sym,
>  const sys_call_ptr_t x32_sys_call_table[] = {
>  #include <asm/syscalls_x32.h>
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 7e8d46f4147f..6695105d21b5 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -2,7 +2,7 @@
>  # 64-bit system call numbers and entry vectors
>  #
>  # The format is:
> -# <number> <abi> <name> <entry point>
> +# <number> <abi> <name> <entry point> [0 noreturn]
>  #
>  # The __x64_sys_*() stubs are created on-the-fly for sys_*() system calls
>  #
> @@ -68,7 +68,7 @@
>  57	common	fork			sys_fork
>  58	common	vfork			sys_vfork
>  59	64	execve			sys_execve
> -60	common	exit			sys_exit
> +60	common	exit			sys_exit		0	noreturn
>  61	common	wait4			sys_wait4
>  62	common	kill			sys_kill
>  63	common	uname			sys_newuname
> @@ -239,7 +239,7 @@
>  228	common	clock_gettime		sys_clock_gettime
>  229	common	clock_getres		sys_clock_getres
>  230	common	clock_nanosleep		sys_clock_nanosleep
> -231	common	exit_group		sys_exit_group
> +231	common	exit_group		sys_exit_group		0	noreturn
>  232	common	epoll_wait		sys_epoll_wait
>  233	common	epoll_ctl		sys_epoll_ctl
>  234	common	tgkill			sys_tgkill
> diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
> index 89df5d89d664..c7d4bf955d2b 100644
> --- a/arch/x86/um/sys_call_table_32.c
> +++ b/arch/x86/um/sys_call_table_32.c
> @@ -24,6 +24,7 @@
>  #define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
>  
>  #define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
> +#define __SYSCALL_NORETURN __SYSCALL
>  #include <asm/syscalls_32.h>
>  
>  #undef __SYSCALL
> diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
> index b0b4cfd2308c..4760c40ae5cd 100644
> --- a/arch/x86/um/sys_call_table_64.c
> +++ b/arch/x86/um/sys_call_table_64.c
> @@ -19,6 +19,7 @@
>  #define sys_ioperm sys_ni_syscall
>  
>  #define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
> +#define __SYSCALL_NORETURN __SYSCALL
>  #include <asm/syscalls_64.h>
>  
>  #undef __SYSCALL
> diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
> index 6abe143889ef..16487d47e06a 100755
> --- a/scripts/syscalltbl.sh
> +++ b/scripts/syscalltbl.sh
> @@ -54,7 +54,7 @@ nxt=0
>  
>  grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
>  
> -	while read nr abi name native compat ; do
> +	while read nr abi name native compat noreturn; do
>  
>  		if [ $nxt -gt $nr ]; then
>  			echo "error: $infile: syscall table is not sorted or duplicates the same syscall number" >&2
> @@ -66,7 +66,9 @@ grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
>  			nxt=$((nxt + 1))
>  		done
>  
> -		if [ -n "$compat" ]; then
> +		if [ -n "$noreturn" ]; then
> +			echo "__SYSCALL_NORETURN($nr, $native)"
> +		elif [ -n "$compat" ]; then
>  			echo "__SYSCALL_WITH_COMPAT($nr, $native, $compat)"
>  		elif [ -n "$native" ]; then
>  			echo "__SYSCALL($nr, $native)"
> diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
> index 7ebf29c91184..1e8141ef1b15 100644
> --- a/tools/objtool/noreturns.h
> +++ b/tools/objtool/noreturns.h
> @@ -7,12 +7,16 @@
>   * Yes, this is unfortunate.  A better solution is in the works.
>   */
>  NORETURN(__fortify_panic)
> +NORETURN(__ia32_sys_exit)
> +NORETURN(__ia32_sys_exit_group)
>  NORETURN(__kunit_abort)
>  NORETURN(__module_put_and_kthread_exit)
>  NORETURN(__reiserfs_panic)
>  NORETURN(__stack_chk_fail)
>  NORETURN(__tdx_hypercall_failed)
>  NORETURN(__ubsan_handle_builtin_unreachable)
> +NORETURN(__x64_sys_exit)
> +NORETURN(__x64_sys_exit_group)
>  NORETURN(arch_cpu_idle_dead)
>  NORETURN(bch2_trans_in_restart_error)
>  NORETURN(bch2_trans_restart_error)
> -- 
> 2.44.0
> 

