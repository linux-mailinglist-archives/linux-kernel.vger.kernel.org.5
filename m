Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962CC7E8EA2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjKLGRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjKLGQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:16:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AF64783
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:16:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F980C433C7;
        Sun, 12 Nov 2023 06:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769794;
        bh=t5MrC4fvvQc/xekSl+yR6G661NNGQj6PgtJ8W5ldz/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmZIsck3qQZ47ZtEtuPfCGlEnruD5oZdRze4VoBdVlszVX+zR+zesI8h/f8NTefwq
         VWhnjyuIgcvNRfcyJRHmdcrLSoeVXKTKxUu6YHOA6pYGK2Al4X7XOduITVsoRh51Xy
         YWIgiXgVwRNzjIX3F8cKKmCa/PJg3/dCzlDqt078w29bGlY12eAurMcl+H4E9Vpyb0
         5dPifGZVFfAhrfLPx+/jDOWlknO4zCU4aBCHHHkE/Pz9pURH66T6YyPE344dZTL81u
         wccacwGGK5aJ+vaR+VI5EM23Ux+fNTmGjWLzaiUVZJ9p8eMvZDCnEZtb51WSPw7+wf
         GTMrhXIlKwycg==
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
Subject: [RFC PATCH V2 11/38] riscv: u64ilp32: Enable user space runtime switch
Date:   Sun, 12 Nov 2023 01:14:47 -0500
Message-Id: <20231112061514.2306187-12-guoren@kernel.org>
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

This patch didn't introduce any new syscall table but reused the
existing rv32 implementation to ease the maintenance of the kernel side.
Unify the UXL mode setting by ELF e_flags to support u64ilp32 &
u32ilp32.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/csr.h         | 2 --
 arch/riscv/include/asm/elf.h         | 7 ++++++-
 arch/riscv/include/asm/syscall.h     | 2 +-
 arch/riscv/include/asm/thread_info.h | 1 +
 arch/riscv/kernel/process.c          | 4 +---
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 7bac43a3176e..638b7a836acc 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -44,11 +44,9 @@
 #define SR_SD		_AC(0x8000000000000000, UL) /* FS/VS/XS dirty */
 #endif
 
-#ifdef CONFIG_64BIT
 #define SR_UXL		_AC(0x300000000, UL) /* XLEN mask for U-mode */
 #define SR_UXL_32	_AC(0x100000000, UL) /* XLEN = 32 for U-mode */
 #define SR_UXL_64	_AC(0x200000000, UL) /* XLEN = 64 for U-mode */
-#endif
 
 /* SATP flags */
 #ifndef CONFIG_64BIT
diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index c24280774caf..5b2bf1a7cb59 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -127,18 +127,23 @@ do {							\
 		*(struct user_regs_struct *)regs;	\
 } while (0);
 
-#ifdef CONFIG_COMPAT
+#define EF_RISCV_64ILP32	0x20
 
 #define SET_PERSONALITY(ex)					\
 do {    if ((ex).e_ident[EI_CLASS] == ELFCLASS32)		\
 		set_thread_flag(TIF_32BIT);			\
 	else							\
 		clear_thread_flag(TIF_32BIT);			\
+	if ((ex).e_flags & EF_RISCV_64ILP32)			\
+		set_thread_flag(TIF_64ILP32);			\
+	else							\
+		clear_thread_flag(TIF_64ILP32);			\
 	if (personality(current->personality) != PER_LINUX32)	\
 		set_personality(PER_LINUX |			\
 			(current->personality & (~PER_MASK)));	\
 } while (0)
 
+#ifdef CONFIG_COMPAT
 #define COMPAT_ELF_ET_DYN_BASE		((TASK_SIZE_32 / 3) * 2)
 
 /* rv32 registers */
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 0148c6bd9675..a1122b88c362 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -81,7 +81,7 @@ static inline void syscall_handler(struct pt_regs *regs, ulong syscall)
 	syscall_t fn;
 
 #ifdef CONFIG_COMPAT
-	if ((regs->status & SR_UXL) == SR_UXL_32)
+	if (test_thread_flag(TIF_32BIT))
 		fn = compat_sys_call_table[syscall];
 	else
 #endif
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 1833beb00489..61f7101aebb3 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -93,6 +93,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define TIF_NOTIFY_SIGNAL	9	/* signal notifications exist */
 #define TIF_UPROBE		10	/* uprobe breakpoint or singlestep */
 #define TIF_32BIT		11	/* compat-mode 32bit process */
+#define TIF_64ILP32		12	/* 64ILP32 process */
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 93057ca2e2a7..87bdb0d6dbf3 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -126,14 +126,12 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	regs->epc = pc;
 	regs->sp = sp;
 
-#ifdef CONFIG_64BIT
 	regs->status &= ~SR_UXL;
 
-	if (is_compat_task())
+	if (test_thread_flag(TIF_32BIT) && !test_thread_flag(TIF_64ILP32))
 		regs->status |= SR_UXL_32;
 	else
 		regs->status |= SR_UXL_64;
-#endif
 }
 
 void flush_thread(void)
-- 
2.36.1

