Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B723C7E8EC9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjKLGT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjKLGTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:19:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152374C3E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:18:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EF7C4339A;
        Sun, 12 Nov 2023 06:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769910;
        bh=OjrCcl0rfmfc64pY2XcaTipAjTIetFz7lqlGwLAdI1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NUqY1I7x2IBpSxSUqW/7Q6OGxQiYKOlhpkgEMuIXaegTBhYxQabZ9nWdjM3gZ1HA9
         PlNm0fMrqtlmHvJ+jn4V8Ren7NlYCmwAiTI8y5M/k9k/16h+Ii0SRuzEgvYc1u3EJq
         whpJwHxfxSih6gKdXEktmiq5plDVz7/YlAQzH8C7aBOT3HiqHjulOxuCgkBg7WPlH/
         f0NmXgtgbDRUMTm9HiQr8f4uKme+8Sdo5Sh8zYj+XRX1VD270xGtNAxCrjmwn0v60m
         rOVTaDeFOqKNkyQ/yEOWKFz2Qc0ijC27b9+L+CfEBAR0obCEuxoEuHL9jnL5Tdj5S6
         BYGwuFwOZw69Q==
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
Subject: [RFC PATCH V2 30/38] riscv: s64ilp32: Add u32ilp32 ptrace support
Date:   Sun, 12 Nov 2023 01:15:06 -0500
Message-Id: <20231112061514.2306187-31-guoren@kernel.org>
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

The s64ilp32 supports both u64ilp32 and u32ilp32 ABIs, and their pt_regs
differ. So introduce the compat feature to help u32ilp32 ABI. Now
u64ilp32 and u32ilp32 applications could work with the s64ilp32 Linux
ptrace concurrently.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/elf.h | 2 +-
 arch/riscv/kernel/ptrace.c   | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index 5b2bf1a7cb59..58c2e5ef2b7a 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -143,13 +143,13 @@ do {    if ((ex).e_ident[EI_CLASS] == ELFCLASS32)		\
 			(current->personality & (~PER_MASK)));	\
 } while (0)
 
-#ifdef CONFIG_COMPAT
 #define COMPAT_ELF_ET_DYN_BASE		((TASK_SIZE_32 / 3) * 2)
 
 /* rv32 registers */
 typedef compat_ulong_t			compat_elf_greg_t;
 typedef compat_elf_greg_t		compat_elf_gregset_t[ELF_NGREG];
 
+#ifdef CONFIG_COMPAT
 extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 					      int uses_interp);
 #define compat_arch_setup_additional_pages \
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 5471b12127da..1078c0f454c1 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -295,7 +295,7 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
+#if IS_ENABLED(CONFIG_COMPAT) || IS_ENABLED(CONFIG_ARCH_RV64ILP32)
 static int compat_riscv_gpr_get(struct task_struct *target,
 				const struct user_regset *regset,
 				struct membuf to)
@@ -350,7 +350,9 @@ static const struct user_regset_view compat_riscv_user_native_view = {
 	.regsets = compat_riscv_user_regset,
 	.n = ARRAY_SIZE(compat_riscv_user_regset),
 };
+#endif
 
+#ifdef CONFIG_COMPAT
 long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
@@ -368,7 +370,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
-#ifdef CONFIG_COMPAT
+#if IS_ENABLED(CONFIG_COMPAT) || IS_ENABLED(CONFIG_ARCH_RV64ILP32)
 	if (test_tsk_thread_flag(task, TIF_32BIT) &&
 	   !test_tsk_thread_flag(task, TIF_64ILP32))
 		return &compat_riscv_user_native_view;
-- 
2.36.1

