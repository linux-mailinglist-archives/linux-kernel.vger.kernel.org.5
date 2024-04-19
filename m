Return-Path: <linux-kernel+bounces-151085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81D48AA8E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48729282F01
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E053FBB1;
	Fri, 19 Apr 2024 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qxj03nwZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E253EA68
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510635; cv=none; b=LKUY7VbeadX2ZjFoQVk2O8gw+9H2GIEy4E6rY+3ttBlU3mCyBg+oGFo4vi70l6u1AV3KN1MYiz0G21C5KhDS/4Ry3ByjQu8xRxV3+By7PM/Xgrl6igXVAe5Cem5uJEfHoJ4PsnWdO7bUbW829LIROYWwEUFMU2K+WhtSLoDe5i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510635; c=relaxed/simple;
	bh=kHuRjliUSEjrm2Gq+10yzLgwTgMxPwFdU0vM8Kttfcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNWfuBlHnvyI6vdPdecTvxJCUS8EPzwtxnrEASHlQ2RWSElxChQCHvqCSEce6m98ovDrQWVGOa8h/FHRq1rV+fx+RzlYUyaFf056l7CUxJ3+bb2cqjRXk/xNDgZtuHZcbFobMVCEurj+wNHjEpbuR3ULSC1er3FLMgZ4fRPn0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qxj03nwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A578DC072AA;
	Fri, 19 Apr 2024 07:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713510635;
	bh=kHuRjliUSEjrm2Gq+10yzLgwTgMxPwFdU0vM8Kttfcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qxj03nwZncBf21FGHCZT17xkosrf6PbpvJT0iYk7g/GPt7GNZaYvqdxD1Zy5Jqmo4
	 HoOpQFqAETmGwgeFZ3NgKBCxnWvU/OZhpSajb0Uw1VFtMhFDTM+W+QaQV/EFITQXcA
	 Lz5G57oF9qOwlPANUEybCd9axh+Ugd+nzUZx18nGnACsidX1MMgS/5wkkTVwcFjnrH
	 nHjVD2CS8jjFBFAOh1RFVjD+jRF9COz6hudqaAnu90yYkFv+gymgB20ce6D9bnQ7RC
	 9GEMUhxHBiDiaNlIAbDZXM+pgTK4TXC5WWbmNpUvmEObaripsywQYj14urq15WCX4C
	 Vwtulg8+jP9ag==
Date: Fri, 19 Apr 2024 00:10:33 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [BUG] objtool complains about missing __noreturn__ on
 x64_sys_call() and ia32_sys_call()
Message-ID: <20240419071033.rqfhkyd2iae5qwte@treble>
References: <6dba9b32-db2c-4e6d-9500-7a08852f17a3@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6dba9b32-db2c-4e6d-9500-7a08852f17a3@paulmck-laptop>

On Thu, Apr 18, 2024 at 05:22:26PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> Recent -next kernels, including next-20240418, get the following objtool
> build errors:
> 
> vmlinux.o: warning: objtool: x64_sys_call+0x2804: __x64_sys_exit() is missing a __noreturn annotation
> vmlinux.o: warning: objtool: ia32_sys_call+0x29b6: __ia32_sys_exit_group() is missing a __noreturn annotation
> 
> These functions appear to have been added to -next and mainline by
> commit 1e3ad78334a6 ("x86/syscall: Don't force use of indirect calls
> for system calls").  But the diagnostic does not make much sense because
> both functions always return unless the system call itself doesn't return.

These warnings are (perhaps confusingly yet still correctly) calling out
the fact that the exit syscalls __x64_sys_exit() and
__ia32_sys_exit_group() don't return but are not annotated as such.

It probably doesn't matter much for syscalls and I could get objtool to
just ignore such scenarios.

Or we could actually annotate them as __noreturn.  Does this fix it?


diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 96ea1f8a1d3f..ff36a993a07e 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -8,9 +8,13 @@
 #include <asm/syscall.h>
 
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
+#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL
 
+#undef __SYSCALL_NORETURN
+#define __SYSCALL_NORETURN __SYSCALL
+
 #define __SYSCALL(nr, sym) __x64_##sym,
 const sys_call_ptr_t sys_call_table[] = {
 #include <asm/syscalls_64.h>
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 5aef4230faca..4221ecce6e68 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -8,9 +8,13 @@
 #include <asm/syscall.h>
 
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
+#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_x32.h>
 #undef __SYSCALL
 
+#undef __SYSCALL_NORETURN
+#define __SYSCALL_NORETURN __SYSCALL
+
 #define __SYSCALL(nr, sym) __x64_##sym,
 const sys_call_ptr_t x32_sys_call_table[] = {
 #include <asm/syscalls_x32.h>
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7e8d46f4147f..f99e9e4ad671 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -68,7 +68,7 @@
 57	common	fork			sys_fork
 58	common	vfork			sys_vfork
 59	64	execve			sys_execve
-60	common	exit			sys_exit
+60	common	exit			sys_exit	0	noreturn
 61	common	wait4			sys_wait4
 62	common	kill			sys_kill
 63	common	uname			sys_newuname
@@ -239,7 +239,7 @@
 228	common	clock_gettime		sys_clock_gettime
 229	common	clock_getres		sys_clock_getres
 230	common	clock_nanosleep		sys_clock_nanosleep
-231	common	exit_group		sys_exit_group
+231	common	exit_group		sys_exit_group		0	noreturn
 232	common	epoll_wait		sys_epoll_wait
 233	common	epoll_ctl		sys_epoll_ctl
 234	common	tgkill			sys_tgkill
diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
index 6abe143889ef..16487d47e06a 100755
--- a/scripts/syscalltbl.sh
+++ b/scripts/syscalltbl.sh
@@ -54,7 +54,7 @@ nxt=0
 
 grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
 
-	while read nr abi name native compat ; do
+	while read nr abi name native compat noreturn; do
 
 		if [ $nxt -gt $nr ]; then
 			echo "error: $infile: syscall table is not sorted or duplicates the same syscall number" >&2
@@ -66,7 +66,9 @@ grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
 			nxt=$((nxt + 1))
 		done
 
-		if [ -n "$compat" ]; then
+		if [ -n "$noreturn" ]; then
+			echo "__SYSCALL_NORETURN($nr, $native)"
+		elif [ -n "$compat" ]; then
 			echo "__SYSCALL_WITH_COMPAT($nr, $native, $compat)"
 		elif [ -n "$native" ]; then
 			echo "__SYSCALL($nr, $native)"
diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index 7ebf29c91184..1e8141ef1b15 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -7,12 +7,16 @@
  * Yes, this is unfortunate.  A better solution is in the works.
  */
 NORETURN(__fortify_panic)
+NORETURN(__ia32_sys_exit)
+NORETURN(__ia32_sys_exit_group)
 NORETURN(__kunit_abort)
 NORETURN(__module_put_and_kthread_exit)
 NORETURN(__reiserfs_panic)
 NORETURN(__stack_chk_fail)
 NORETURN(__tdx_hypercall_failed)
 NORETURN(__ubsan_handle_builtin_unreachable)
+NORETURN(__x64_sys_exit)
+NORETURN(__x64_sys_exit_group)
 NORETURN(arch_cpu_idle_dead)
 NORETURN(bch2_trans_in_restart_error)
 NORETURN(bch2_trans_restart_error)

