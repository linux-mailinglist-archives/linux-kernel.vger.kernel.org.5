Return-Path: <linux-kernel+bounces-154335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A40F8ADAE2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0441C20A92
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BDC1C8FA6;
	Mon, 22 Apr 2024 23:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2igqz22"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E241158DC6;
	Mon, 22 Apr 2024 23:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830356; cv=none; b=SJyl7O7gX/W07f2nL7yYJj/RiSItG8+NuKpZPyrBCpOu++0DOtvSxLTOVHgd06/UsAQAhkc80iyU/SmMTm+vXa+HmMc8Iy3ifzj+U/jZUs1zZ4Kg0oZlixKE3XNLCo0y9TQUBwjDqFBUXjLgktCfNYeF2OSAxSFM6nBbsEoyPwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830356; c=relaxed/simple;
	bh=2d/pUPpu0nPoQ0KqdnMyks+b9rKpBfvgrfddWyMYkWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZZaKFMZp27QhsQenYXH64s83OG76Sa4/uuafDcHJEQzsUYtS/amflAp0Lj07bkDOijqZHFZQpZnXLgQlp+SLCm8ZwBElDotfGmajQFhpS5S0wP3LA/KQtoeSs+DFdY/PSD617go0Kj7F8zm00CJAN3bLkvGLaeuirnhPkhrEaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2igqz22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31E5C3277B;
	Mon, 22 Apr 2024 23:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830355;
	bh=2d/pUPpu0nPoQ0KqdnMyks+b9rKpBfvgrfddWyMYkWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M2igqz22D/hUQznp+tW/WDe2UeIqEY44rmPo1B95q14Cm8gqgiSIX1S6UP0DRatBk
	 j2d/+dj4UQr55AkNgccnLQxmsIQ2l2V9EI4MKAEjtex2ikoFUuskHwZrrBTN3y7ZPB
	 F1Br2ws4XvkQlVK6apb6iOqTVW1cMaameDpicOis9YrjgK5UnGRoWsPKkF3gWyUwsw
	 u5qglbLdS15T+SpeiG13ZijjtjoE1hbI2yA6hMRLkZto36bOzpjiYJA3975iAnaj7J
	 QRTnoMOFiPzR3B2Ucu8xiaxE3IKZzzPGNnD14jnCf6+FrwJ27NPncsGfP5XIreL/hp
	 yVFkP5d1RO+zQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Xi Ruoyao <xry111@xry111.site>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>,
	oleg@redhat.com,
	arnd@arndb.de,
	linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 7/9] MIPS: scall: Save thread_info.syscall unconditionally on entry
Date: Mon, 22 Apr 2024 19:20:12 -0400
Message-ID: <20240422232020.1615476-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422232020.1615476-1-sashal@kernel.org>
References: <20240422232020.1615476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.274
Content-Transfer-Encoding: 8bit

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

[ Upstream commit 4370b673ccf240bf7587b0cb8e6726a5ccaf1f17 ]

thread_info.syscall is used by syscall_get_nr to supply syscall nr
over a thread stack frame.

Previously, thread_info.syscall is only saved at syscall_trace_enter
when syscall tracing is enabled. However rest of the kernel code do
expect syscall_get_nr to be available without syscall tracing. The
previous design breaks collect_syscall.

Move saving process to syscall entry to fix it.

Reported-by: Xi Ruoyao <xry111@xry111.site>
Link: https://github.com/util-linux/util-linux/issues/2867
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/ptrace.h |  2 +-
 arch/mips/kernel/asm-offsets.c |  1 +
 arch/mips/kernel/ptrace.c      | 15 ++++++---------
 arch/mips/kernel/scall32-o32.S | 23 +++++++++++++----------
 arch/mips/kernel/scall64-n32.S |  3 ++-
 arch/mips/kernel/scall64-n64.S |  3 ++-
 arch/mips/kernel/scall64-o32.S | 33 +++++++++++++++++----------------
 7 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 2849a9b65a055..ae578860f7295 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -157,7 +157,7 @@ static inline long regs_return_value(struct pt_regs *regs)
 #define instruction_pointer(regs) ((regs)->cp0_epc)
 #define profile_pc(regs) instruction_pointer(regs)
 
-extern asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall);
+extern asmlinkage long syscall_trace_enter(struct pt_regs *regs);
 extern asmlinkage void syscall_trace_leave(struct pt_regs *regs);
 
 extern void die(const char *, struct pt_regs *) __noreturn;
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index aebfda81120a1..6c5269d3aacba 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -100,6 +100,7 @@ void output_thread_info_defines(void)
 	OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
 	OFFSET(TI_ADDR_LIMIT, thread_info, addr_limit);
 	OFFSET(TI_REGS, thread_info, regs);
+	OFFSET(TI_SYSCALL, thread_info, syscall);
 	DEFINE(_THREAD_SIZE, THREAD_SIZE);
 	DEFINE(_THREAD_MASK, THREAD_MASK);
 	DEFINE(_IRQ_STACK_SIZE, IRQ_STACK_SIZE);
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 414b6e9c900b2..cfb548fd2712c 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -1399,16 +1399,13 @@ long arch_ptrace(struct task_struct *child, long request,
  * Notification of system call entry/exit
  * - triggered by current->work.syscall_trace
  */
-asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
+asmlinkage long syscall_trace_enter(struct pt_regs *regs)
 {
 	user_exit();
 
-	current_thread_info()->syscall = syscall;
-
 	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
 		if (tracehook_report_syscall_entry(regs))
 			return -1;
-		syscall = current_thread_info()->syscall;
 	}
 
 #ifdef CONFIG_SECCOMP
@@ -1417,7 +1414,7 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 		struct seccomp_data sd;
 		unsigned long args[6];
 
-		sd.nr = syscall;
+		sd.nr = current_thread_info()->syscall;
 		sd.arch = syscall_get_arch(current);
 		syscall_get_arguments(current, regs, args);
 		for (i = 0; i < 6; i++)
@@ -1427,23 +1424,23 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 		ret = __secure_computing(&sd);
 		if (ret == -1)
 			return ret;
-		syscall = current_thread_info()->syscall;
 	}
 #endif
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->regs[2]);
 
-	audit_syscall_entry(syscall, regs->regs[4], regs->regs[5],
+	audit_syscall_entry(current_thread_info()->syscall,
+			    regs->regs[4], regs->regs[5],
 			    regs->regs[6], regs->regs[7]);
 
 	/*
 	 * Negative syscall numbers are mistaken for rejected syscalls, but
 	 * won't have had the return value set appropriately, so we do so now.
 	 */
-	if (syscall < 0)
+	if (current_thread_info()->syscall < 0)
 		syscall_set_return_value(current, regs, -ENOSYS, 0);
-	return syscall;
+	return current_thread_info()->syscall;
 }
 
 /*
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index b449b68662a9a..80747719a35ca 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -80,6 +80,18 @@ loads_done:
 	PTR	load_a7, bad_stack_a7
 	.previous
 
+	/*
+	 * syscall number is in v0 unless we called syscall(__NR_###)
+	 * where the real syscall number is in a0
+	 */
+	subu	t2, v0,  __NR_O32_Linux
+	bnez	t2, 1f /* __NR_syscall at offset 0 */
+	LONG_S	a0, TI_SYSCALL($28)	# Save a0 as syscall number
+	b	2f
+1:
+	LONG_S	v0, TI_SYSCALL($28)	# Save v0 as syscall number
+2:
+
 	lw	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
 	and	t0, t1
@@ -117,16 +129,7 @@ syscall_trace_entry:
 	SAVE_STATIC
 	move	a0, sp
 
-	/*
-	 * syscall number is in v0 unless we called syscall(__NR_###)
-	 * where the real syscall number is in a0
-	 */
-	move	a1, v0
-	subu	t2, v0,  __NR_O32_Linux
-	bnez	t2, 1f /* __NR_syscall at offset 0 */
-	lw	a1, PT_R4(sp)
-
-1:	jal	syscall_trace_enter
+	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
 
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 35d8c86b160ea..a8679e34c95e3 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -44,6 +44,8 @@ NESTED(handle_sysn32, PT_SIZE, sp)
 
 	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
 
+	LONG_S	v0, TI_SYSCALL($28)     # Store syscall number
+
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	and	t0, t1, t0
@@ -72,7 +74,6 @@ syscall_common:
 n32_syscall_trace_entry:
 	SAVE_STATIC
 	move	a0, sp
-	move	a1, v0
 	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall64-n64.S
index 23b2e2b1609cf..a3b5ab509b412 100644
--- a/arch/mips/kernel/scall64-n64.S
+++ b/arch/mips/kernel/scall64-n64.S
@@ -47,6 +47,8 @@ NESTED(handle_sys64, PT_SIZE, sp)
 
 	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
 
+	LONG_S	v0, TI_SYSCALL($28)     # Store syscall number
+
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	and	t0, t1, t0
@@ -83,7 +85,6 @@ n64_syscall_exit:
 syscall_trace_entry:
 	SAVE_STATIC
 	move	a0, sp
-	move	a1, v0
 	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 41df8221bb8fd..d8f41e919c171 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -79,6 +79,22 @@ loads_done:
 	PTR	load_a7, bad_stack_a7
 	.previous
 
+	/*
+	 * absolute syscall number is in v0 unless we called syscall(__NR_###)
+	 * where the real syscall number is in a0
+	 * note: NR_syscall is the first O32 syscall but the macro is
+	 * only defined when compiling with -mabi=32 (CONFIG_32BIT)
+	 * therefore __NR_O32_Linux is used (4000)
+	 */
+
+	subu	t2, v0,  __NR_O32_Linux
+	bnez	t2, 1f /* __NR_syscall at offset 0 */
+	LONG_S	a0, TI_SYSCALL($28)	# Save a0 as syscall number
+	b	2f
+1:
+	LONG_S	v0, TI_SYSCALL($28)	# Save v0 as syscall number
+2:
+
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	and	t0, t1, t0
@@ -113,22 +129,7 @@ trace_a_syscall:
 	sd	a7, PT_R11(sp)		# For indirect syscalls
 
 	move	a0, sp
-	/*
-	 * absolute syscall number is in v0 unless we called syscall(__NR_###)
-	 * where the real syscall number is in a0
-	 * note: NR_syscall is the first O32 syscall but the macro is
-	 * only defined when compiling with -mabi=32 (CONFIG_32BIT)
-	 * therefore __NR_O32_Linux is used (4000)
-	 */
-	.set	push
-	.set	reorder
-	subu	t1, v0,  __NR_O32_Linux
-	move	a1, v0
-	bnez	t1, 1f /* __NR_syscall at offset 0 */
-	ld	a1, PT_R4(sp) /* Arg1 for __NR_syscall case */
-	.set	pop
-
-1:	jal	syscall_trace_enter
+	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
 
-- 
2.43.0


