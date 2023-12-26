Return-Path: <linux-kernel+bounces-11231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D539B81E377
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46DB71F23F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEB85255;
	Tue, 26 Dec 2023 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvMrHV6Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F8B522A;
	Tue, 26 Dec 2023 00:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C221C433C7;
	Tue, 26 Dec 2023 00:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550134;
	bh=4V8wI0StG6wvCrqHUSVcj8ztFa80GUymxP4hspC1fAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvMrHV6QQiNBHGaBL0R4QN1kJnQFwgjqkL5QftL+w8H4zChzCsTcGAJ7jSSmzjaCr
	 8yiXouRwAZPJwqBScFBqFjLrITqxoaYk1Tj+BW1l09JT07nwkc02lD5Mq2cf8mkeWT
	 r8fdQT5AmT7GKf4zoPw191uROWjTE8BHJr1aP8M5eLgQ9Zl43FE+Ut6294LuJsEgt9
	 kekJCCjD/314fSwnJat5RaLPCtsmxgAIlG7y51d3akeQh2KPwxMMZ4GNi0JQDPrzYc
	 c6kBs5NbYxMn6WCatEpSF8YmDbKkppZSSfEJcvn4LDN8GI0VnrpmL1Fg6D26YUk6VM
	 NyG8RHT0St3ww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	kernel test robot <oliver.sang@intel.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	catalin.marinas@arm.com,
	will@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	mingo@redhat.com,
	x86@kernel.org,
	arnd@arndb.de,
	keescook@chromium.org,
	ardb@kernel.org,
	kevin.brodsky@arm.com,
	svens@linux.ibm.com,
	geert@linux-m68k.org,
	peterz@infradead.org,
	sohil.mehta@intel.com,
	nphamcs@gmail.com,
	rick.p.edgecombe@intel.com,
	akpm@linux-foundation.org,
	jannh@google.com,
	yang.lee@linux.alibaba.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 38/39] posix-timers: Get rid of [COMPAT_]SYS_NI() uses
Date: Mon, 25 Dec 2023 19:19:28 -0500
Message-ID: <20231226002021.4776-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit a4aebe936554dac6a91e5d091179c934f8325708 ]

Only the posix timer system calls use this (when the posix timer support
is disabled, which does not actually happen in any normal case), because
they had debug code to print out a warning about missing system calls.

Get rid of that special case, and just use the standard COND_SYSCALL
interface that creates weak system call stubs that return -ENOSYS for
when the system call does not exist.

This fixes a kCFI issue with the SYS_NI() hackery:

  CFI failure at int80_emulation+0x67/0xb0 (target: sys_ni_posix_timers+0x0/0x70; expected type: 0xb02b34d9)
  WARNING: CPU: 0 PID: 48 at int80_emulation+0x67/0xb0

Reported-by: kernel test robot <oliver.sang@intel.com>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Sami Tolvanen <samitolvanen@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/syscall_wrapper.h |  4 ---
 arch/riscv/include/asm/syscall_wrapper.h |  5 ---
 arch/s390/include/asm/syscall_wrapper.h  | 13 +------
 arch/x86/include/asm/syscall_wrapper.h   | 34 +++---------------
 kernel/sys_ni.c                          | 14 ++++++++
 kernel/time/posix-stubs.c                | 45 ------------------------
 6 files changed, 19 insertions(+), 96 deletions(-)

diff --git a/arch/arm64/include/asm/syscall_wrapper.h b/arch/arm64/include/asm/syscall_wrapper.h
index 17f687510c485..7a0e7b59be9b9 100644
--- a/arch/arm64/include/asm/syscall_wrapper.h
+++ b/arch/arm64/include/asm/syscall_wrapper.h
@@ -44,9 +44,6 @@
 		return sys_ni_syscall();						\
 	}
 
-#define COMPAT_SYS_NI(name) \
-	SYSCALL_ALIAS(__arm64_compat_sys_##name, sys_ni_posix_timers);
-
 #endif /* CONFIG_COMPAT */
 
 #define __SYSCALL_DEFINEx(x, name, ...)						\
@@ -82,6 +79,5 @@
 	}
 
 asmlinkage long __arm64_sys_ni_syscall(const struct pt_regs *__unused);
-#define SYS_NI(name) SYSCALL_ALIAS(__arm64_sys_##name, sys_ni_posix_timers);
 
 #endif /* __ASM_SYSCALL_WRAPPER_H */
diff --git a/arch/riscv/include/asm/syscall_wrapper.h b/arch/riscv/include/asm/syscall_wrapper.h
index 1d7942c8a6cba..eeec04b7dae67 100644
--- a/arch/riscv/include/asm/syscall_wrapper.h
+++ b/arch/riscv/include/asm/syscall_wrapper.h
@@ -46,9 +46,6 @@ asmlinkage long __riscv_sys_ni_syscall(const struct pt_regs *);
 		return sys_ni_syscall();						\
 	}
 
-#define COMPAT_SYS_NI(name) \
-	SYSCALL_ALIAS(__riscv_compat_sys_##name, sys_ni_posix_timers);
-
 #endif /* CONFIG_COMPAT */
 
 #define __SYSCALL_DEFINEx(x, name, ...)						\
@@ -82,6 +79,4 @@ asmlinkage long __riscv_sys_ni_syscall(const struct pt_regs *);
 		return sys_ni_syscall();					\
 	}
 
-#define SYS_NI(name) SYSCALL_ALIAS(__riscv_sys_##name, sys_ni_posix_timers);
-
 #endif /* __ASM_SYSCALL_WRAPPER_H */
diff --git a/arch/s390/include/asm/syscall_wrapper.h b/arch/s390/include/asm/syscall_wrapper.h
index 9286430fe7290..35c1d1b860d88 100644
--- a/arch/s390/include/asm/syscall_wrapper.h
+++ b/arch/s390/include/asm/syscall_wrapper.h
@@ -63,10 +63,6 @@
 	cond_syscall(__s390x_sys_##name);				\
 	cond_syscall(__s390_sys_##name)
 
-#define SYS_NI(name)							\
-	SYSCALL_ALIAS(__s390x_sys_##name, sys_ni_posix_timers);		\
-	SYSCALL_ALIAS(__s390_sys_##name, sys_ni_posix_timers)
-
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)						\
 	long __s390_compat_sys##name(struct pt_regs *regs);				\
 	ALLOW_ERROR_INJECTION(__s390_compat_sys##name, ERRNO);				\
@@ -85,15 +81,11 @@
 
 /*
  * As some compat syscalls may not be implemented, we need to expand
- * COND_SYSCALL_COMPAT in kernel/sys_ni.c and COMPAT_SYS_NI in
- * kernel/time/posix-stubs.c to cover this case as well.
+ * COND_SYSCALL_COMPAT in kernel/sys_ni.c to cover this case as well.
  */
 #define COND_SYSCALL_COMPAT(name)					\
 	cond_syscall(__s390_compat_sys_##name)
 
-#define COMPAT_SYS_NI(name)						\
-	SYSCALL_ALIAS(__s390_compat_sys_##name, sys_ni_posix_timers)
-
 #define __S390_SYS_STUBx(x, name, ...)						\
 	long __s390_sys##name(struct pt_regs *regs);				\
 	ALLOW_ERROR_INJECTION(__s390_sys##name, ERRNO);				\
@@ -124,9 +116,6 @@
 #define COND_SYSCALL(name)						\
 	cond_syscall(__s390x_sys_##name)
 
-#define SYS_NI(name)							\
-	SYSCALL_ALIAS(__s390x_sys_##name, sys_ni_posix_timers)
-
 #define __S390_SYS_STUBx(x, fullname, name, ...)
 
 #endif /* CONFIG_COMPAT */
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index fd2669b1cb2d9..21f9407be5d35 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -86,9 +86,6 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 		return sys_ni_syscall();				\
 	}
 
-#define __SYS_NI(abi, name)						\
-	SYSCALL_ALIAS(__##abi##_##name, sys_ni_posix_timers);
-
 #ifdef CONFIG_X86_64
 #define __X64_SYS_STUB0(name)						\
 	__SYS_STUB0(x64, sys_##name)
@@ -100,13 +97,10 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 #define __X64_COND_SYSCALL(name)					\
 	__COND_SYSCALL(x64, sys_##name)
 
-#define __X64_SYS_NI(name)						\
-	__SYS_NI(x64, sys_##name)
 #else /* CONFIG_X86_64 */
 #define __X64_SYS_STUB0(name)
 #define __X64_SYS_STUBx(x, name, ...)
 #define __X64_COND_SYSCALL(name)
-#define __X64_SYS_NI(name)
 #endif /* CONFIG_X86_64 */
 
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
@@ -120,13 +114,10 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 #define __IA32_COND_SYSCALL(name)					\
 	__COND_SYSCALL(ia32, sys_##name)
 
-#define __IA32_SYS_NI(name)						\
-	__SYS_NI(ia32, sys_##name)
 #else /* CONFIG_X86_32 || CONFIG_IA32_EMULATION */
 #define __IA32_SYS_STUB0(name)
 #define __IA32_SYS_STUBx(x, name, ...)
 #define __IA32_COND_SYSCALL(name)
-#define __IA32_SYS_NI(name)
 #endif /* CONFIG_X86_32 || CONFIG_IA32_EMULATION */
 
 #ifdef CONFIG_IA32_EMULATION
@@ -135,8 +126,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * additional wrappers (aptly named __ia32_sys_xyzzy) which decode the
  * ia32 regs in the proper order for shared or "common" syscalls. As some
  * syscalls may not be implemented, we need to expand COND_SYSCALL in
- * kernel/sys_ni.c and SYS_NI in kernel/time/posix-stubs.c to cover this
- * case as well.
+ * kernel/sys_ni.c to cover this case as well.
  */
 #define __IA32_COMPAT_SYS_STUB0(name)					\
 	__SYS_STUB0(ia32, compat_sys_##name)
@@ -148,14 +138,10 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 #define __IA32_COMPAT_COND_SYSCALL(name)				\
 	__COND_SYSCALL(ia32, compat_sys_##name)
 
-#define __IA32_COMPAT_SYS_NI(name)					\
-	__SYS_NI(ia32, compat_sys_##name)
-
 #else /* CONFIG_IA32_EMULATION */
 #define __IA32_COMPAT_SYS_STUB0(name)
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)
 #define __IA32_COMPAT_COND_SYSCALL(name)
-#define __IA32_COMPAT_SYS_NI(name)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -175,13 +161,10 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 #define __X32_COMPAT_COND_SYSCALL(name)					\
 	__COND_SYSCALL(x64, compat_sys_##name)
 
-#define __X32_COMPAT_SYS_NI(name)					\
-	__SYS_NI(x64, compat_sys_##name)
 #else /* CONFIG_X86_X32_ABI */
 #define __X32_COMPAT_SYS_STUB0(name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
 #define __X32_COMPAT_COND_SYSCALL(name)
-#define __X32_COMPAT_SYS_NI(name)
 #endif /* CONFIG_X86_X32_ABI */
 
 
@@ -212,17 +195,12 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 
 /*
  * As some compat syscalls may not be implemented, we need to expand
- * COND_SYSCALL_COMPAT in kernel/sys_ni.c and COMPAT_SYS_NI in
- * kernel/time/posix-stubs.c to cover this case as well.
+ * COND_SYSCALL_COMPAT in kernel/sys_ni.c to cover this case as well.
  */
 #define COND_SYSCALL_COMPAT(name) 					\
 	__IA32_COMPAT_COND_SYSCALL(name)				\
 	__X32_COMPAT_COND_SYSCALL(name)
 
-#define COMPAT_SYS_NI(name)						\
-	__IA32_COMPAT_SYS_NI(name)					\
-	__X32_COMPAT_SYS_NI(name)
-
 #endif /* CONFIG_COMPAT */
 
 #define __SYSCALL_DEFINEx(x, name, ...)					\
@@ -243,8 +221,8 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * As the generic SYSCALL_DEFINE0() macro does not decode any parameters for
  * obvious reasons, and passing struct pt_regs *regs to it in %rdi does not
  * hurt, we only need to re-define it here to keep the naming congruent to
- * SYSCALL_DEFINEx() -- which is essential for the COND_SYSCALL() and SYS_NI()
- * macros to work correctly.
+ * SYSCALL_DEFINEx() -- which is essential for the COND_SYSCALL() macro
+ * to work correctly.
  */
 #define SYSCALL_DEFINE0(sname)						\
 	SYSCALL_METADATA(_##sname, 0);					\
@@ -257,10 +235,6 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 	__X64_COND_SYSCALL(name)					\
 	__IA32_COND_SYSCALL(name)
 
-#define SYS_NI(name)							\
-	__X64_SYS_NI(name)						\
-	__IA32_SYS_NI(name)
-
 
 /*
  * For VSYSCALLS, we need to declare these three syscalls with the new
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index e137c1385c569..11c55593a2e91 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -200,6 +200,20 @@ COND_SYSCALL(recvmmsg_time32);
 COND_SYSCALL_COMPAT(recvmmsg_time32);
 COND_SYSCALL_COMPAT(recvmmsg_time64);
 
+/* Posix timer syscalls may be configured out */
+COND_SYSCALL(timer_create);
+COND_SYSCALL(timer_gettime);
+COND_SYSCALL(timer_getoverrun);
+COND_SYSCALL(timer_settime);
+COND_SYSCALL(timer_delete);
+COND_SYSCALL(clock_adjtime);
+COND_SYSCALL(getitimer);
+COND_SYSCALL(setitimer);
+COND_SYSCALL(alarm);
+COND_SYSCALL_COMPAT(timer_create);
+COND_SYSCALL_COMPAT(getitimer);
+COND_SYSCALL_COMPAT(setitimer);
+
 /*
  * Architecture specific syscalls: see further below
  */
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 828aeecbd1e8a..9b6fcb8d85e78 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -17,40 +17,6 @@
 #include <linux/time_namespace.h>
 #include <linux/compat.h>
 
-#ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
-/* Architectures may override SYS_NI and COMPAT_SYS_NI */
-#include <asm/syscall_wrapper.h>
-#endif
-
-asmlinkage long sys_ni_posix_timers(void)
-{
-	pr_err_once("process %d (%s) attempted a POSIX timer syscall "
-		    "while CONFIG_POSIX_TIMERS is not set\n",
-		    current->pid, current->comm);
-	return -ENOSYS;
-}
-
-#ifndef SYS_NI
-#define SYS_NI(name)  SYSCALL_ALIAS(sys_##name, sys_ni_posix_timers)
-#endif
-
-#ifndef COMPAT_SYS_NI
-#define COMPAT_SYS_NI(name)  SYSCALL_ALIAS(compat_sys_##name, sys_ni_posix_timers)
-#endif
-
-SYS_NI(timer_create);
-SYS_NI(timer_gettime);
-SYS_NI(timer_getoverrun);
-SYS_NI(timer_settime);
-SYS_NI(timer_delete);
-SYS_NI(clock_adjtime);
-SYS_NI(getitimer);
-SYS_NI(setitimer);
-SYS_NI(clock_adjtime32);
-#ifdef __ARCH_WANT_SYS_ALARM
-SYS_NI(alarm);
-#endif
-
 /*
  * We preserve minimal support for CLOCK_REALTIME and CLOCK_MONOTONIC
  * as it is easy to remain compatible with little code. CLOCK_BOOTTIME
@@ -158,18 +124,7 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 				 which_clock);
 }
 
-#ifdef CONFIG_COMPAT
-COMPAT_SYS_NI(timer_create);
-#endif
-
-#if defined(CONFIG_COMPAT) || defined(CONFIG_ALPHA)
-COMPAT_SYS_NI(getitimer);
-COMPAT_SYS_NI(setitimer);
-#endif
-
 #ifdef CONFIG_COMPAT_32BIT_TIME
-SYS_NI(timer_settime32);
-SYS_NI(timer_gettime32);
 
 SYSCALL_DEFINE2(clock_settime32, const clockid_t, which_clock,
 		struct old_timespec32 __user *, tp)
-- 
2.43.0


