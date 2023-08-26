Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB67789755
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 16:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjHZOYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 10:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjHZOX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 10:23:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093C71FC7;
        Sat, 26 Aug 2023 07:23:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 909306197E;
        Sat, 26 Aug 2023 14:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E28CC433C7;
        Sat, 26 Aug 2023 14:23:52 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>, stable@vger.kernel.org
Subject: [PATCH V2] LoongArch: Ensure FP/SIMD registers in the core dump file is up to date
Date:   Sat, 26 Aug 2023 22:23:41 +0800
Message-Id: <20230826142341.4107728-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a port of commit 379eb01c21795edb4c ("riscv: Ensure the value
of FP registers in the core dump file is up to date").

The values of FP/SIMD registers in the core dump file come from the
thread.fpu. However, kernel saves the FP/SIMD registers only before
scheduling out the process. If no process switch happens during the
exception handling, kernel will not have a chance to save the latest
values of FP/SIMD registers. So it may cause their values in the core
dump file incorrect. To solve this problem, force fpr_get()/simd_get()
to save the FP/SIMD registers into the thread.fpu if the target task
equals the current task.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Rename get_fpu_regs() to save_fpu_regs().

 arch/loongarch/include/asm/fpu.h | 22 ++++++++++++++++++----
 arch/loongarch/kernel/ptrace.c   |  4 ++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/asm/fpu.h
index b541f6248837..08a45e9fd15c 100644
--- a/arch/loongarch/include/asm/fpu.h
+++ b/arch/loongarch/include/asm/fpu.h
@@ -173,16 +173,30 @@ static inline void restore_fp(struct task_struct *tsk)
 		_restore_fp(&tsk->thread.fpu);
 }
 
-static inline union fpureg *get_fpu_regs(struct task_struct *tsk)
+static inline void save_fpu_regs(struct task_struct *tsk)
 {
+	unsigned int euen;
+
 	if (tsk == current) {
 		preempt_disable();
-		if (is_fpu_owner())
+
+		euen = csr_read32(LOONGARCH_CSR_EUEN);
+
+#ifdef CONFIG_CPU_HAS_LASX
+		if (euen & CSR_EUEN_LASXEN)
+			_save_lasx(&current->thread.fpu);
+		else
+#endif
+#ifdef CONFIG_CPU_HAS_LSX
+		if (euen & CSR_EUEN_LSXEN)
+			_save_lsx(&current->thread.fpu);
+		else
+#endif
+		if (euen & CSR_EUEN_FPEN)
 			_save_fp(&current->thread.fpu);
+
 		preempt_enable();
 	}
-
-	return tsk->thread.fpu.fpr;
 }
 
 static inline int is_simd_owner(void)
diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
index a0767c3a0f0a..9a75dc43eb29 100644
--- a/arch/loongarch/kernel/ptrace.c
+++ b/arch/loongarch/kernel/ptrace.c
@@ -147,6 +147,8 @@ static int fpr_get(struct task_struct *target,
 {
 	int r;
 
+	save_fpu_regs(target);
+
 	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
 		r = gfpr_get(target, &to);
 	else
@@ -278,6 +280,8 @@ static int simd_get(struct task_struct *target,
 {
 	const unsigned int wr_size = NUM_FPU_REGS * regset->size;
 
+	save_fpu_regs(target);
+
 	if (!tsk_used_math(target)) {
 		/* The task hasn't used FP or LSX, fill with 0xff */
 		copy_pad_fprs(target, regset, &to, 0);
-- 
2.39.3

