Return-Path: <linux-kernel+bounces-151958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61A08AB643
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99761C213D2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED23413D28A;
	Fri, 19 Apr 2024 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvfY8y3Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1325013D251
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713560998; cv=none; b=f2dSZeeW0yOVyTYsLfJYVbQhPAv6uBxoqMT8c+vKCF5M2l5sLO9rvqyx3Gw8hBaGHOKJVW77xy4WQsJhty71JQ3rqejLzEWJDuiAQmltkieTDfkTf6WBtE5hC2ASiKkMkkDyastO2Nu7else0sxckdR7vbAi+rhP+1liY0UzkQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713560998; c=relaxed/simple;
	bh=3HfFNpMh38u6tNfkl1sY16DLcqQDUNbs5WtxOZ1u2pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZqdMat+kMJO/q37FU/tFsVLCPwcLR9XDy4EdqhP8atnZ3OLP9oRI2R6OjL757zrJl1eqsCivgQJTaxwAtN2iVh0LlNK4M/p8EFfV9GJiW9MTPfzPUw7b2cDtw9942xitQyrOYtgTgHwLp1Znpam0QR+hDlf9nYcDA8fd4D1dDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvfY8y3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3C5C4AF0C;
	Fri, 19 Apr 2024 21:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713560997;
	bh=3HfFNpMh38u6tNfkl1sY16DLcqQDUNbs5WtxOZ1u2pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YvfY8y3YODcm6/zagVWjuAvq15waPSHLKyobh9RQr07HUqKem0W4UPjqW1MhGXjg8
	 cXF8pTo9Ru4Hn8mFN1lOjJdK3LNE7phzqa7pc/B8wwdiCidzK4dew+ELaMKa5FQDKJ
	 WLvbzSEMLcIwJHDFEQceLdGPmL85BMvigUlxfqMdA/fudfFD4JOIhsEFDk5ja1q72A
	 T7FIBAHWpc+YoEAfXkn+yxKBnbSQdEXoY69RthBU9Djaz61X187SgGOEfEaF/WY4w6
	 WSH/G0p9u1cwGfLTz++BkDI64P7fcDandIIcyfqzrCgYsCa6QGjsLCr9vJ9mlTrNei
	 aipi5maqVm/qw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
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
	KP Singh <kpsingh@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 3/5] x86/syscall: Mark exit[_group] syscall handlers __noreturn
Date: Fri, 19 Apr 2024 14:09:49 -0700
Message-ID: <3b99cb2919c88ab3d353337423b2f0f1b9173f0a.1713559768.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713559768.git.jpoimboe@kernel.org>
References: <cover.1713559768.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The direct-call syscall dispatch functions don't know that the exit()
and exit_group() syscall handlers don't return.  As a result the call
sites aren't optimized accordingly.

Fix that by marking those exit syscall declarations as __noreturn.

Fixes the following warnings:

  vmlinux.o: warning: objtool: x64_sys_call+0x2804: __x64_sys_exit() is missing a __noreturn annotation
  vmlinux.o: warning: objtool: ia32_sys_call+0x29b6: __ia32_sys_exit_group() is missing a __noreturn annotation

Fixes: 7390db8aea0d ("x86/bhi: Add support for clearing branch history at syscall entry")
Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
Closes: https://lkml.kernel.org/lkml/6dba9b32-db2c-4e6d-9500-7a08852f17a3@paulmck-laptop
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/entry/syscall_64.c            | 4 ++++
 arch/x86/entry/syscall_x32.c           | 4 ++++
 arch/x86/entry/syscalls/syscall_64.tbl | 6 +++---
 arch/x86/um/sys_call_table_32.c        | 1 +
 arch/x86/um/sys_call_table_64.c        | 1 +
 scripts/syscalltbl.sh                  | 6 ++++--
 tools/objtool/noreturns.h              | 4 ++++
 7 files changed, 21 insertions(+), 5 deletions(-)

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
index 7e8d46f4147f..6695105d21b5 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -2,7 +2,7 @@
 # 64-bit system call numbers and entry vectors
 #
 # The format is:
-# <number> <abi> <name> <entry point>
+# <number> <abi> <name> <entry point> [0 noreturn]
 #
 # The __x64_sys_*() stubs are created on-the-fly for sys_*() system calls
 #
@@ -68,7 +68,7 @@
 57	common	fork			sys_fork
 58	common	vfork			sys_vfork
 59	64	execve			sys_execve
-60	common	exit			sys_exit
+60	common	exit			sys_exit		0	noreturn
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
diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
index 89df5d89d664..c7d4bf955d2b 100644
--- a/arch/x86/um/sys_call_table_32.c
+++ b/arch/x86/um/sys_call_table_32.c
@@ -24,6 +24,7 @@
 #define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
 
 #define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
+#define __SYSCALL_NORETURN __SYSCALL
 #include <asm/syscalls_32.h>
 
 #undef __SYSCALL
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index b0b4cfd2308c..4760c40ae5cd 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -19,6 +19,7 @@
 #define sys_ioperm sys_ni_syscall
 
 #define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
+#define __SYSCALL_NORETURN __SYSCALL
 #include <asm/syscalls_64.h>
 
 #undef __SYSCALL
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
-- 
2.44.0


