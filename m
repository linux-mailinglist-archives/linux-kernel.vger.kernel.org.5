Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5831D7E8ECB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjKLGTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjKLGTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:19:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC66A3C3C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:18:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2612FC433D9;
        Sun, 12 Nov 2023 06:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769916;
        bh=Yd1se3YAvTpm3f6jR2T3YyxOy5a1aI13dnazTuxGpzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cib6Q1ZUgS2FaDH4BWH6sy+4T4ju7sE9ZqI/4WjqXf+/9wNUzo1g8Lh7AhURej2Dh
         ds3OmIJ7NuwdMMJsmhVV83diwJFb4ycXr8DHEmtqAnEscuSNMaLmi6COUnDsGdvZNC
         48epOdk0lVec54vwPX4+oawPbEHxi7LHNgplAYP+u7R6EFMpgZlqI1hKTTZyPAKqH+
         FbHpWR6QnaaAFEwD1RB2SVt5Cs4BLe56fLDphnZjefH6nFyOwP6hZcQCB4hlMpIXU1
         RPi2nAz7rtuiPBvt9l9ks0tz4U2y6cbPVa68u0jPbUIJk397571LXKTfGGugR1SMPJ
         X+3T30N4ldZ7A==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, conor.dooley@microchip.com, heiko@sntech.de,
        apatel@ventanamicro.com, atishp@atishpatra.org, bjorn@kernel.org,
        paul.walmsley@sifive.com, anup@brainfault.org, jiawei@iscas.ac.cn,
        liweiwei@iscas.ac.cn, wefu@redhat.com, U2FsdGVkX1@gmail.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, wuwei2016@iscas.ac.cn, jrtc27@jrtc27.com,
        luto@kernel.org, fweimer@redhat.com, catalin.marinas@arm.com,
        hjl.tools@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 31/38] riscv: s64ilp32: Add u32ilp32 signal support
Date:   Sun, 12 Nov 2023 01:15:07 -0500
Message-Id: <20231112061514.2306187-32-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The u32ilp32 uses the compat_pt_regs instead of the native pt_regs, so
we borrow the compat code to support the u32ilp32 signal procedure in
the s64ilp32 kernel.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/signal32.h |  2 +-
 arch/riscv/kernel/Makefile        |  1 +
 arch/riscv/kernel/signal.c        |  5 ++++-
 kernel/signal.c                   | 24 ++++++++++++++----------
 4 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/signal32.h b/arch/riscv/include/asm/signal32.h
index cda62d7eb0a5..e47bb739e61a 100644
--- a/arch/riscv/include/asm/signal32.h
+++ b/arch/riscv/include/asm/signal32.h
@@ -3,7 +3,7 @@
 #ifndef __ASM_SIGNAL32_H
 #define __ASM_SIGNAL32_H
 
-#if IS_ENABLED(CONFIG_COMPAT)
+#if IS_ENABLED(CONFIG_COMPAT) || IS_ENABLED(CONFIG_ARCH_RV64ILP32)
 int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 			  struct pt_regs *regs);
 long __riscv_compat_rt_sigreturn(void);
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index a4583a29b28b..e8af95298e98 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_EFI)		+= efi.o
 obj-$(CONFIG_COMPAT)		+= compat_syscall_table.o
 obj-$(CONFIG_COMPAT)		+= compat_signal.o
+obj-$(CONFIG_ARCH_RV64ILP32)	+= compat_signal.o
 
 obj-$(CONFIG_64BIT)		+= pi/
 obj-$(CONFIG_ACPI)		+= acpi.o
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 1c51a6783c98..95512af927dd 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -277,7 +277,10 @@ static long __riscv_rt_sigreturn(void)
 
 SYSCALL_DEFINE0(rt_sigreturn)
 {
-	return __riscv_rt_sigreturn();
+	if (test_thread_flag(TIF_32BIT) && !test_thread_flag(TIF_64ILP32))
+		return __riscv_compat_rt_sigreturn();
+	else
+		return __riscv_rt_sigreturn();
 }
 
 #ifdef CONFIG_COMPAT
diff --git a/kernel/signal.c b/kernel/signal.c
index b5370fe5c198..3ac7fa4f1761 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3390,7 +3390,7 @@ int copy_siginfo_from_user(kernel_siginfo_t *to, const siginfo_t __user *from)
 	return post_copy_siginfo_from_user(to, from);
 }
 
-#ifdef CONFIG_COMPAT
+#if IS_ENABLED(CONFIG_COMPAT) || IS_ENABLED(CONFIG_ARCH_RV64ILP32)
 /**
  * copy_siginfo_to_external32 - copy a kernel siginfo into a compat user siginfo
  * @to: compat siginfo destination
@@ -3556,6 +3556,7 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
 	return 0;
 }
 
+#ifdef CONFIG_COMPAT
 static int __copy_siginfo_from_user32(int signo, struct kernel_siginfo *to,
 				      const struct compat_siginfo __user *ufrom)
 {
@@ -3567,6 +3568,7 @@ static int __copy_siginfo_from_user32(int signo, struct kernel_siginfo *to,
 	from.si_signo = signo;
 	return post_copy_siginfo_from_user32(to, &from);
 }
+#endif /* CONFIG_COMPAT */
 
 int copy_siginfo_from_user32(struct kernel_siginfo *to,
 			     const struct compat_siginfo __user *ufrom)
@@ -3578,7 +3580,7 @@ int copy_siginfo_from_user32(struct kernel_siginfo *to,
 
 	return post_copy_siginfo_from_user32(to, &from);
 }
-#endif /* CONFIG_COMPAT */
+#endif
 
 /**
  *  do_sigtimedwait - wait for queued signals specified in @which
@@ -4279,7 +4281,7 @@ int __save_altstack(stack_t __user *uss, unsigned long sp)
 	return err;
 }
 
-#ifdef CONFIG_COMPAT
+#if IS_ENABLED(CONFIG_COMPAT) || IS_ENABLED(CONFIG_ARCH_HAS_64ILP32_KERNEL)
 static int do_compat_sigaltstack(const compat_stack_t __user *uss_ptr,
 				 compat_stack_t __user *uoss_ptr)
 {
@@ -4309,13 +4311,6 @@ static int do_compat_sigaltstack(const compat_stack_t __user *uss_ptr,
 	return ret;
 }
 
-COMPAT_SYSCALL_DEFINE2(sigaltstack,
-			const compat_stack_t __user *, uss_ptr,
-			compat_stack_t __user *, uoss_ptr)
-{
-	return do_compat_sigaltstack(uss_ptr, uoss_ptr);
-}
-
 int compat_restore_altstack(const compat_stack_t __user *uss)
 {
 	int err = do_compat_sigaltstack(uss, NULL);
@@ -4335,6 +4330,15 @@ int __compat_save_altstack(compat_stack_t __user *uss, unsigned long sp)
 }
 #endif
 
+#ifdef CONFIG_COMPAT
+COMPAT_SYSCALL_DEFINE2(sigaltstack,
+			const compat_stack_t __user *, uss_ptr,
+			compat_stack_t __user *, uoss_ptr)
+{
+	return do_compat_sigaltstack(uss_ptr, uoss_ptr);
+}
+#endif
+
 #ifdef __ARCH_WANT_SYS_SIGPENDING
 
 /**
-- 
2.36.1

