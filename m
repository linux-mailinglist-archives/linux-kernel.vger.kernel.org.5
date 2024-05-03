Return-Path: <linux-kernel+bounces-167840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4EF8BB023
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65B1284EC4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36128154441;
	Fri,  3 May 2024 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElaEb/0r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E9D1BF31
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750721; cv=none; b=mf1u2/sETpVvEcq1KHPaM7rwPXUnao2Nmzbk8CV1hKGa+WdaOO/KXRGTCh/3+kngBhbwmxhAQuGTyJzunvBpxBkbTEJdeYOb1jXTMOInrQ5t3+wIuXtgE44hWXagEShMb/0Xwj8nu+ash9S0Pz8DKaUl0OspniFU64AQtm9yJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750721; c=relaxed/simple;
	bh=d+1hj+KtolyClSgAn/aaA7UuMqZuu3CIQzON9Od1rac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1LXCschjsHOKqPje0vqQPt7ezmuwHAtdYp1EMolKsnLnj3FCuSa2qlWBo7aUH/k4+bk6lPhwph7xNca+dep/LYLEfqgmp0Ca/ML4+oWWIGh2zJK+yfrfk217RG7EkRy080zzakuhrWF7P8OOEHeBHlN+iQJcvei7becDulrEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElaEb/0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71346C116B1;
	Fri,  3 May 2024 15:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714750720;
	bh=d+1hj+KtolyClSgAn/aaA7UuMqZuu3CIQzON9Od1rac=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ElaEb/0rYGv83b5Ow2uJIH0YREDs7PKx2/ArLfXiEgS4C27d6R39w6YGU3RpdaWiL
	 7hedzZiynNe4Ok9N2kkMdWOaVT+nOREb7GT0gLy9VK8YDPmvpfqCyFqdAO759aky4R
	 ftN8CO8sJ+GnGPAJI3QhRpsEQXqyEoLv0qsBBSLvK0pMIou37Y4vEu0nr8j+dQdb/Z
	 Qci7i5cd/1jPfBCQAa8eSSdEgYEA/qns7CIEb5bKHY0shglekrqDBu6kw54kJNTINz
	 IAWiVR2jy/Mb4MVLlQq+dJlUI5oPTaMCkY6fi1fE8MGfpz2kcV6imol9Q4V+xc9Vbw
	 32dk6aps6ljIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1737DCE098A; Fri,  3 May 2024 08:38:40 -0700 (PDT)
Date: Fri, 3 May 2024 08:38:40 -0700
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
Message-ID: <539fc0d0-eb4f-4403-8385-ecdbefa6ca44@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cover.1713559768.git.jpoimboe@kernel.org>
 <3b99cb2919c88ab3d353337423b2f0f1b9173f0a.1713559768.git.jpoimboe@kernel.org>
 <0c410ba5-0e42-43b6-80b8-a69c5419a97d@paulmck-laptop>
 <20240421052540.w7gtahoko2qerhqq@treble>
 <CAJzB8QF_+51+rrJmq3iXkaAbmbbyKYVf0m_LpQCRSLS_FgHUMQ@mail.gmail.com>
 <CAJzB8QFx344hSSYy4jigtmQX+KfSpFOn+18WAfZAeym5LUMoKg@mail.gmail.com>
 <CAJzB8QFxfCCYTMfEYidB+PYvDV5J2zbdsnpyQR-gS-D-0y2gEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJzB8QFxfCCYTMfEYidB+PYvDV5J2zbdsnpyQR-gS-D-0y2gEA@mail.gmail.com>

On Thu, May 02, 2024 at 04:48:13PM -0700, Paul McKenney wrote:
> On Sun, Apr 21, 2024 at 2:47 PM Paul McKenney <paulmckrcu@gmail.com> wrote:
> >
> > And this definitely helped, thank you!
> >
> > However, this one still remains:
> >
> > vmlinux.o: warning: objtool: ia32_sys_call+0x29b6:
> > __ia32_sys_exit_group() is missing a __noreturn annotation
> 
> And looking at the patched code, this function looks to me to be
> correctly marked.
> 
> No idea...  :-/

But thank you for getting rid of the other warning:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> > Please see below for my diffs against next-20240419, in case I messed
> > something up.
> >
> > I attached a copy as well, given that I am away from mutt, hence using
> > gmail directly.
> >
> >                                                 Thanx, Paul
> >
> > -----------------------------------------------------
> >
> > diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> > index 6de50b80702e6..9810ba2857a5c 100644
> > --- a/arch/x86/entry/common.c
> > +++ b/arch/x86/entry/common.c
> > @@ -49,7 +49,10 @@ static __always_inline bool do_syscall_x64(struct
> > pt_regs *regs, int nr)
> >
> >   if (likely(unr < NR_syscalls)) {
> >   unr = array_index_nospec(unr, NR_syscalls);
> > - regs->ax = x64_sys_call(regs, unr);
> > + if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_BRANCH_OK)))
> > + regs->ax = sys_call_table[unr](regs);
> > + else
> > + regs->ax = x64_sys_call(regs, unr);
> >   return true;
> >   }
> >   return false;
> > @@ -66,7 +69,10 @@ static __always_inline bool do_syscall_x32(struct
> > pt_regs *regs, int nr)
> >
> >   if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(xnr < X32_NR_syscalls)) {
> >   xnr = array_index_nospec(xnr, X32_NR_syscalls);
> > - regs->ax = x32_sys_call(regs, xnr);
> > + if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_BRANCH_OK)))
> > + regs->ax = x32_sys_call_table[xnr](regs);
> > + else
> > + regs->ax = x32_sys_call(regs, xnr);
> >   return true;
> >   }
> >   return false;
> > @@ -162,7 +168,10 @@ static __always_inline void
> > do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
> >
> >   if (likely(unr < IA32_NR_syscalls)) {
> >   unr = array_index_nospec(unr, IA32_NR_syscalls);
> > - regs->ax = ia32_sys_call(regs, unr);
> > + if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_BRANCH_OK)))
> > + regs->ax = ia32_sys_call_table[unr](regs);
> > + else
> > + regs->ax = ia32_sys_call(regs, unr);
> >   } else if (nr != -1) {
> >   regs->ax = __ia32_sys_ni_syscall(regs);
> >   }
> > diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> > index c2235bae17ef6..aab31760b4e3e 100644
> > --- a/arch/x86/entry/syscall_32.c
> > +++ b/arch/x86/entry/syscall_32.c
> > @@ -14,25 +14,16 @@
> >  #endif
> >
> >  #define __SYSCALL(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
> > -
> >  #include <asm/syscalls_32.h>
> >  #undef __SYSCALL
> >
> > -/*
> > - * The sys_call_table[] is no longer used for system calls, but
> > - * kernel/trace/trace_syscalls.c still wants to know the system
> > - * call address.
> > - */
> > -#ifdef CONFIG_X86_32
> >  #define __SYSCALL(nr, sym) __ia32_##sym,
> > -const sys_call_ptr_t sys_call_table[] = {
> > +const sys_call_ptr_t ia32_sys_call_table[] = {
> >  #include <asm/syscalls_32.h>
> >  };
> >  #undef __SYSCALL
> > -#endif
> >
> >  #define __SYSCALL(nr, sym) case nr: return __ia32_##sym(regs);
> > -
> >  long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
> >  {
> >   switch (nr) {
> > diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
> > index 33b3f09e6f151..ff36a993a07e0 100644
> > --- a/arch/x86/entry/syscall_64.c
> > +++ b/arch/x86/entry/syscall_64.c
> > @@ -8,14 +8,13 @@
> >  #include <asm/syscall.h>
> >
> >  #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
> > +#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn
> > __x64_##sym(const struct pt_regs *);
> >  #include <asm/syscalls_64.h>
> >  #undef __SYSCALL
> >
> > -/*
> > - * The sys_call_table[] is no longer used for system calls, but
> > - * kernel/trace/trace_syscalls.c still wants to know the system
> > - * call address.
> > - */
> > +#undef __SYSCALL_NORETURN
> > +#define __SYSCALL_NORETURN __SYSCALL
> > +
> >  #define __SYSCALL(nr, sym) __x64_##sym,
> >  const sys_call_ptr_t sys_call_table[] = {
> >  #include <asm/syscalls_64.h>
> > @@ -23,7 +22,6 @@ const sys_call_ptr_t sys_call_table[] = {
> >  #undef __SYSCALL
> >
> >  #define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
> > -
> >  long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
> >  {
> >   switch (nr) {
> > diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
> > index 03de4a9321318..4221ecce6e689 100644
> > --- a/arch/x86/entry/syscall_x32.c
> > +++ b/arch/x86/entry/syscall_x32.c
> > @@ -8,11 +8,20 @@
> >  #include <asm/syscall.h>
> >
> >  #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
> > +#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn
> > __x64_##sym(const struct pt_regs *);
> >  #include <asm/syscalls_x32.h>
> >  #undef __SYSCALL
> >
> > -#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
> > +#undef __SYSCALL_NORETURN
> > +#define __SYSCALL_NORETURN __SYSCALL
> > +
> > +#define __SYSCALL(nr, sym) __x64_##sym,
> > +const sys_call_ptr_t x32_sys_call_table[] = {
> > +#include <asm/syscalls_x32.h>
> > +};
> > +#undef __SYSCALL
> >
> > +#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
> >  long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
> >  {
> >   switch (nr) {
> > diff --git a/arch/x86/entry/syscalls/syscall_64.tbl
> > b/arch/x86/entry/syscalls/syscall_64.tbl
> > index a396f6e6ab5bf..7ec68d94eb593 100644
> > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > @@ -2,7 +2,7 @@
> >  # 64-bit system call numbers and entry vectors
> >  #
> >  # The format is:
> > -# <number> <abi> <name> <entry point>
> > +# <number> <abi> <name> <entry point> [0 noreturn]
> >  #
> >  # The __x64_sys_*() stubs are created on-the-fly for sys_*() system calls
> >  #
> > @@ -68,7 +68,7 @@
> >  57 common fork sys_fork
> >  58 common vfork sys_vfork
> >  59 64 execve sys_execve
> > -60 common exit sys_exit
> > +60 common exit sys_exit 0 noreturn
> >  61 common wait4 sys_wait4
> >  62 common kill sys_kill
> >  63 common uname sys_newuname
> > @@ -239,7 +239,7 @@
> >  228 common clock_gettime sys_clock_gettime
> >  229 common clock_getres sys_clock_getres
> >  230 common clock_nanosleep sys_clock_nanosleep
> > -231 common exit_group sys_exit_group
> > +231 common exit_group sys_exit_group 0 noreturn
> >  232 common epoll_wait sys_epoll_wait
> >  233 common epoll_ctl sys_epoll_ctl
> >  234 common tgkill sys_tgkill
> > diff --git a/arch/x86/include/asm/cpufeatures.h
> > b/arch/x86/include/asm/cpufeatures.h
> > index 3c7434329661c..d64b0a5291f10 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -470,6 +470,7 @@
> >  #define X86_FEATURE_BHI_CTRL (21*32+ 2) /* "" BHI_DIS_S HW control available */
> >  #define X86_FEATURE_CLEAR_BHB_HW (21*32+ 3) /* "" BHI_DIS_S HW
> > control enabled */
> >  #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear
> > branch history at vmexit using SW loop */
> > +#define X86_FEATURE_INDIRECT_BRANCH_OK (21*32+ 5) /* "" It's OK to
> > use indirect branches */
> >
> >  /*
> >   * BUG word(s)
> > diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
> > index 2fc7bc3863ff6..dfb59521244c2 100644
> > --- a/arch/x86/include/asm/syscall.h
> > +++ b/arch/x86/include/asm/syscall.h
> > @@ -16,14 +16,20 @@
> >  #include <asm/thread_info.h> /* for TS_COMPAT */
> >  #include <asm/unistd.h>
> >
> > -/* This is used purely for kernel/trace/trace_syscalls.c */
> >  typedef long (*sys_call_ptr_t)(const struct pt_regs *);
> >  extern const sys_call_ptr_t sys_call_table[];
> >
> > +#if defined(CONFIG_X86_32)
> > +#define ia32_sys_call_table sys_call_table
> > +#else
> >  /*
> >   * These may not exist, but still put the prototypes in so we
> >   * can use IS_ENABLED().
> >   */
> > +extern const sys_call_ptr_t ia32_sys_call_table[];
> > +extern const sys_call_ptr_t x32_sys_call_table[];
> > +#endif
> > +
> >  extern long ia32_sys_call(const struct pt_regs *, unsigned int nr);
> >  extern long x32_sys_call(const struct pt_regs *, unsigned int nr);
> >  extern long x64_sys_call(const struct pt_regs *, unsigned int nr);
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index ab18185894dfd..5fca46c78daf2 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -1665,6 +1665,12 @@ static void __init bhi_select_mitigation(void)
> >   if (!IS_ENABLED(CONFIG_X86_64))
> >   return;
> >
> > + /*
> > + * There's no HW mitigation in place.  Mark indirect branches as
> > + * "not OK".
> > + */
> > + setup_clear_cpu_cap(X86_FEATURE_INDIRECT_BRANCH_OK);
> > +
> >   /* Mitigate KVM by default */
> >   setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
> >   pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
> > @@ -1679,6 +1685,28 @@ static void __init spectre_v2_select_mitigation(void)
> >   enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
> >   enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
> >
> > + /*
> > + * X86_FEATURE_INDIRECT_BRANCH_OK indicates that indirect calls are
> > + * "OK" to use due to (at least) one of the following being true:
> > + *
> > + *   - the CPU isn't vulnerable to Spectre v2, BHI, etc;
> > + *
> > + *   - a HW mitigation is in place (e.g., IBRS, eIBRS+BHI_DIS_S); or
> > + *
> > + *   - the user disabled mitigations.
> > + *
> > + * Clearing the bit enables certain indirect branch "easy targets" [*]
> > + * to be converted to a series of direct branches.
> > + *
> > + * Assume innocence until proven guilty: set it now and clear it later
> > + * if/when needed.
> > + *
> > + * [*] The closer the indirect branch is to kernel entry, and the more
> > + *     user-controlled registers there are, the easier target it may be
> > + *     for future Spectre v2 variants.
> > + */
> > + setup_force_cpu_cap(X86_FEATURE_INDIRECT_BRANCH_OK);
> > +
> >   /*
> >   * If the CPU is not affected and the command line mode is NONE or AUTO
> >   * then nothing to do.
> > @@ -1765,11 +1793,16 @@ static void __init spectre_v2_select_mitigation(void)
> >   break;
> >
> >   case SPECTRE_V2_LFENCE:
> > + setup_clear_cpu_cap(X86_FEATURE_INDIRECT_BRANCH_OK);
> > + fallthrough;
> >   case SPECTRE_V2_EIBRS_LFENCE:
> >   setup_force_cpu_cap(X86_FEATURE_RETPOLINE_LFENCE);
> > - fallthrough;
> > + setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
> > + break;
> >
> >   case SPECTRE_V2_RETPOLINE:
> > + setup_clear_cpu_cap(X86_FEATURE_INDIRECT_BRANCH_OK);
> > + fallthrough;
> >   case SPECTRE_V2_EIBRS_RETPOLINE:
> >   setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
> >   break;
> > diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
> > index 89df5d89d6640..c7d4bf955d2ba 100644
> > --- a/arch/x86/um/sys_call_table_32.c
> > +++ b/arch/x86/um/sys_call_table_32.c
> > @@ -24,6 +24,7 @@
> >  #define __SYSCALL_WITH_COMPAT(nr, native, compat) __SYSCALL(nr, native)
> >
> >  #define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long,
> > unsigned long, unsigned long, unsigned long, unsigned long, unsigned
> > long);
> > +#define __SYSCALL_NORETURN __SYSCALL
> >  #include <asm/syscalls_32.h>
> >
> >  #undef __SYSCALL
> > diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
> > index b0b4cfd2308c8..4760c40ae5cd0 100644
> > --- a/arch/x86/um/sys_call_table_64.c
> > +++ b/arch/x86/um/sys_call_table_64.c
> > @@ -19,6 +19,7 @@
> >  #define sys_ioperm sys_ni_syscall
> >
> >  #define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long,
> > unsigned long, unsigned long, unsigned long, unsigned long, unsigned
> > long);
> > +#define __SYSCALL_NORETURN __SYSCALL
> >  #include <asm/syscalls_64.h>
> >
> >  #undef __SYSCALL
> > diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
> > index 6abe143889ef6..16487d47e06a3 100755
> > --- a/scripts/syscalltbl.sh
> > +++ b/scripts/syscalltbl.sh
> > @@ -54,7 +54,7 @@ nxt=0
> >
> >  grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
> >
> > - while read nr abi name native compat ; do
> > + while read nr abi name native compat noreturn; do
> >
> >   if [ $nxt -gt $nr ]; then
> >   echo "error: $infile: syscall table is not sorted or duplicates the
> > same syscall number" >&2
> > @@ -66,7 +66,9 @@ grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
> >   nxt=$((nxt + 1))
> >   done
> >
> > - if [ -n "$compat" ]; then
> > + if [ -n "$noreturn" ]; then
> > + echo "__SYSCALL_NORETURN($nr, $native)"
> > + elif [ -n "$compat" ]; then
> >   echo "__SYSCALL_WITH_COMPAT($nr, $native, $compat)"
> >   elif [ -n "$native" ]; then
> >   echo "__SYSCALL($nr, $native)"
> > diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
> > index 7ebf29c911849..1e8141ef1b15d 100644
> > --- a/tools/objtool/noreturns.h
> > +++ b/tools/objtool/noreturns.h
> > @@ -7,12 +7,16 @@
> >   * Yes, this is unfortunate.  A better solution is in the works.
> >   */
> >  NORETURN(__fortify_panic)
> > +NORETURN(__ia32_sys_exit)
> > +NORETURN(__ia32_sys_exit_group)
> >  NORETURN(__kunit_abort)
> >  NORETURN(__module_put_and_kthread_exit)
> >  NORETURN(__reiserfs_panic)
> >  NORETURN(__stack_chk_fail)
> >  NORETURN(__tdx_hypercall_failed)
> >  NORETURN(__ubsan_handle_builtin_unreachable)
> > +NORETURN(__x64_sys_exit)
> > +NORETURN(__x64_sys_exit_group)
> >  NORETURN(arch_cpu_idle_dead)
> >  NORETURN(bch2_trans_in_restart_error)
> >  NORETURN(bch2_trans_restart_error)
> >
> > On Sun, Apr 21, 2024 at 1:40 PM Paul McKenney <paulmckrcu@gmail.com> wrote:
> > >
> > > They apply fine as is, so I have started tests with that pair of patches.
> > >
> > >                                               Thanx, Paul
> > >
> > > On Sat, Apr 20, 2024 at 10:25 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > > >
> > > > On Sat, Apr 20, 2024 at 06:58:58AM -0700, Paul E. McKenney wrote:
> > > > > On Fri, Apr 19, 2024 at 02:09:49PM -0700, Josh Poimboeuf wrote:
> > > > > > The direct-call syscall dispatch functions don't know that the exit()
> > > > > > and exit_group() syscall handlers don't return.  As a result the call
> > > > > > sites aren't optimized accordingly.
> > > > > >
> > > > > > Fix that by marking those exit syscall declarations as __noreturn.
> > > > > >
> > > > > > Fixes the following warnings:
> > > > > >
> > > > > >   vmlinux.o: warning: objtool: x64_sys_call+0x2804: __x64_sys_exit() is missing a __noreturn annotation
> > > > > >   vmlinux.o: warning: objtool: ia32_sys_call+0x29b6: __ia32_sys_exit_group() is missing a __noreturn annotation
> > > > > >
> > > > > > Fixes: 7390db8aea0d ("x86/bhi: Add support for clearing branch history at syscall entry")
> > > > > > Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > Closes: https://lkml.kernel.org/lkml/6dba9b32-db2c-4e6d-9500-7a08852f17a3@paulmck-laptop
> > > > > > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > > > >
> > > > > Looks good, but it does not apply on top of current -next and I don't
> > > > > trust myself to hand-apply it (something about having just got off of
> > > > > a flight across the big pond).
> > > > >
> > > > > Could you please let me know what else do I need to pull in to be able
> > > > > to cleanly apply this one?
> > > >
> > > > This patch has a dependency on an earlier patch in the set:
> > > >
> > > >   https://lkml.kernel.org/lkml/982d05a2f669140f26500bee643011896d661094.1713559768.git.jpoimboe@kernel.org
> > > >
> > > > Though I think it's not a hard dependency and I could reverse the order
> > > > of the patches if needed.
> > > >
> > > > --
> > > > Josh

