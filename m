Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627927FEEB6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjK3MP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbjK3MPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:15:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A108D48
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:15:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B42C433CA;
        Thu, 30 Nov 2023 12:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701346551;
        bh=eya5RGJR/yzo23MNYSAjve4atlmsodj+/Pdz45xQAyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N6CQWix/XKHdC6Oykitk0RykgUDULVVTXdAfvEvCP/ZN8I060MpB33++h0BTapydh
         O+r0HahjDlBfleiZTvdCb2oCfJQ4HvaGtSo2o2aizNEDQE6C1Ye4+RN/BFC0vIGhcH
         EaRmGX2ny7xXveVANnAh7GluujnmMHAsaaQ5ioaU8G2nlOydTux2aMgLCaFU8UCz4S
         g7gC7Iv+BGpd1ZoTzLv6pgeSaPImHlqZL7xvfoWZQ3qJcg9YC+bEKoaPs5ACWza2lR
         IHWWfReeTfdTwPoO+9vIvcJm0M+8n95K1kfxw+6qZNy6zwwi03in9D+Sstql7ehN2N
         wPU2z7keZUiLg==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Song Shuai <suagrfillet@gmail.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        songshuaishuai@tinylab.org,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v12 for-next 2/4] riscv: ftrace: Make function graph use ftrace directly
Date:   Thu, 30 Nov 2023 13:15:29 +0100
Message-Id: <20231130121531.1178502-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130121531.1178502-1-bjorn@kernel.org>
References: <20231130121531.1178502-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Shuai <suagrfillet@gmail.com>

Similar to commit 0c0593b45c9b ("x86/ftrace: Make function graph use
ftrace directly") and commit c4a0ebf87ceb ("arm64/ftrace: Make
function graph use ftrace directly"), RISC-V has no need for a special
graph tracer hook. The graph_ops::func function can be used to install
the return_hooker.

This cleanup only changes the FTRACE_WITH_REGS implementation, leaving
the mcount-based implementation is unaffected.

Perform the simplification, and also cleanup the register save/restore
macros.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Acked-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/include/asm/ftrace.h |  11 +-
 arch/riscv/kernel/ftrace.c      |  30 +++--
 arch/riscv/kernel/mcount-dyn.S  | 190 +++++++++++++++++++++++++-------
 3 files changed, 175 insertions(+), 56 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 2b2f5df7ef2c..b383926f73be 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -128,7 +128,16 @@ do {									\
 struct dyn_ftrace;
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 #define ftrace_init_nop ftrace_init_nop
-#endif
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+struct ftrace_ops;
+struct ftrace_regs;
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs);
+#define ftrace_graph_func ftrace_graph_func
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+
+#endif /* __ASSEMBLY__ */
 
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 03a6434a8cdd..f5aa24d9e1c1 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -178,32 +178,28 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs)
+{
+	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
+	unsigned long *parent = (unsigned long *)&regs->ra;
+
+	prepare_ftrace_return(parent, ip, frame_pointer(regs));
+}
+#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 extern void ftrace_graph_call(void);
-extern void ftrace_graph_regs_call(void);
 int ftrace_enable_ftrace_graph_caller(void)
 {
-	int ret;
-
-	ret = __ftrace_modify_call((unsigned long)&ftrace_graph_call,
-				    (unsigned long)&prepare_ftrace_return, true, true);
-	if (ret)
-		return ret;
-
-	return __ftrace_modify_call((unsigned long)&ftrace_graph_regs_call,
+	return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
 				    (unsigned long)&prepare_ftrace_return, true, true);
 }
 
 int ftrace_disable_ftrace_graph_caller(void)
 {
-	int ret;
-
-	ret = __ftrace_modify_call((unsigned long)&ftrace_graph_call,
-				    (unsigned long)&prepare_ftrace_return, false, true);
-	if (ret)
-		return ret;
-
-	return __ftrace_modify_call((unsigned long)&ftrace_graph_regs_call,
+	return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
 				    (unsigned long)&prepare_ftrace_return, false, true);
 }
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 58dd96a2a153..c902a7ddb310 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -57,31 +57,150 @@
 	.endm
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-	.macro SAVE_ALL
+
+/**
+* SAVE_ABI_REGS - save regs against the pt_regs struct
+*
+* @all: tell if saving all the regs
+*
+* If all is set, all the regs will be saved, otherwise only ABI
+* related regs (a0-a7,epc,ra and optional s0) will be saved.
+*
+* After the stack is established,
+*
+* 0(sp) stores the PC of the traced function which can be accessed
+* by &(fregs)->regs->epc in tracing function. Note that the real
+* function entry address should be computed with -FENTRY_RA_OFFSET.
+*
+* 8(sp) stores the function return address (i.e. parent IP) that
+* can be accessed by &(fregs)->regs->ra in tracing function.
+*
+* The other regs are saved at the respective localtion and accessed
+* by the respective pt_regs member.
+*
+* Here is the layout of stack for your reference.
+*
+* PT_SIZE_ON_STACK  ->  +++++++++
+*                       + ..... +
+*                       + t3-t6 +
+*                       + s2-s11+
+*                       + a0-a7 + --++++-> ftrace_caller saved
+*                       + s1    +   +
+*                       + s0    + --+
+*                       + t0-t2 +   +
+*                       + tp    +   +
+*                       + gp    +   +
+*                       + sp    +   +
+*                       + ra    + --+ // parent IP
+*               sp  ->  + epc   + --+ // PC
+*                       +++++++++
+**/
+	.macro SAVE_ABI_REGS, all=0
 	addi	sp, sp, -PT_SIZE_ON_STACK
 
-	REG_S t0,  PT_EPC(sp)
-	REG_S x1,  PT_RA(sp)
-	REG_S x2,  PT_SP(sp)
-	REG_S x3,  PT_GP(sp)
-	REG_S x4,  PT_TP(sp)
-	REG_S x5,  PT_T0(sp)
-	save_from_x6_to_x31
+	REG_S	t0,  PT_EPC(sp)
+	REG_S	x1,  PT_RA(sp)
+
+	// save the ABI regs
+
+	REG_S	x10, PT_A0(sp)
+	REG_S	x11, PT_A1(sp)
+	REG_S	x12, PT_A2(sp)
+	REG_S	x13, PT_A3(sp)
+	REG_S	x14, PT_A4(sp)
+	REG_S	x15, PT_A5(sp)
+	REG_S	x16, PT_A6(sp)
+	REG_S	x17, PT_A7(sp)
+
+	// save the leftover regs
+
+	.if \all == 1
+	REG_S	x2, PT_SP(sp)
+	REG_S	x3, PT_GP(sp)
+	REG_S	x4, PT_TP(sp)
+	REG_S	x5, PT_T0(sp)
+	REG_S	x6, PT_T1(sp)
+	REG_S	x7, PT_T2(sp)
+	REG_S	x8, PT_S0(sp)
+	REG_S	x9, PT_S1(sp)
+	REG_S	x18, PT_S2(sp)
+	REG_S	x19, PT_S3(sp)
+	REG_S	x20, PT_S4(sp)
+	REG_S	x21, PT_S5(sp)
+	REG_S	x22, PT_S6(sp)
+	REG_S	x23, PT_S7(sp)
+	REG_S	x24, PT_S8(sp)
+	REG_S	x25, PT_S9(sp)
+	REG_S	x26, PT_S10(sp)
+	REG_S	x27, PT_S11(sp)
+	REG_S	x28, PT_T3(sp)
+	REG_S	x29, PT_T4(sp)
+	REG_S	x30, PT_T5(sp)
+	REG_S	x31, PT_T6(sp)
+
+	// save s0 if FP_TEST defined
+
+	.else
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	REG_S	x8, PT_S0(sp)
+#endif
+	.endif
 	.endm
 
-	.macro RESTORE_ALL
-	REG_L x1,  PT_RA(sp)
-	REG_L x2,  PT_SP(sp)
-	REG_L x3,  PT_GP(sp)
-	REG_L x4,  PT_TP(sp)
-	/* Restore t0 with PT_EPC */
-	REG_L x5,  PT_EPC(sp)
-	restore_from_x6_to_x31
-
+	.macro RESTORE_ABI_REGS, all=0
+	REG_L	t0, PT_EPC(sp)
+	REG_L	x1, PT_RA(sp)
+	REG_L	x10, PT_A0(sp)
+	REG_L	x11, PT_A1(sp)
+	REG_L	x12, PT_A2(sp)
+	REG_L	x13, PT_A3(sp)
+	REG_L	x14, PT_A4(sp)
+	REG_L	x15, PT_A5(sp)
+	REG_L	x16, PT_A6(sp)
+	REG_L	x17, PT_A7(sp)
+
+	.if \all == 1
+	REG_L	x2, PT_SP(sp)
+	REG_L	x3, PT_GP(sp)
+	REG_L	x4, PT_TP(sp)
+	REG_L	x6, PT_T1(sp)
+	REG_L	x7, PT_T2(sp)
+	REG_L	x8, PT_S0(sp)
+	REG_L	x9, PT_S1(sp)
+	REG_L	x18, PT_S2(sp)
+	REG_L	x19, PT_S3(sp)
+	REG_L	x20, PT_S4(sp)
+	REG_L	x21, PT_S5(sp)
+	REG_L	x22, PT_S6(sp)
+	REG_L	x23, PT_S7(sp)
+	REG_L	x24, PT_S8(sp)
+	REG_L	x25, PT_S9(sp)
+	REG_L	x26, PT_S10(sp)
+	REG_L	x27, PT_S11(sp)
+	REG_L	x28, PT_T3(sp)
+	REG_L	x29, PT_T4(sp)
+	REG_L	x30, PT_T5(sp)
+	REG_L	x31, PT_T6(sp)
+
+	.else
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	REG_L	x8, PT_S0(sp)
+#endif
+	.endif
 	addi	sp, sp, PT_SIZE_ON_STACK
 	.endm
+
+	.macro PREPARE_ARGS
+	addi	a0, t0, -FENTRY_RA_OFFSET
+	la	a1, function_trace_op
+	REG_L	a2, 0(a1)
+	mv	a1, ra
+	mv	a3, sp
+	.endm
+
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 SYM_FUNC_START(ftrace_caller)
 	SAVE_ABI
 
@@ -105,34 +224,29 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
 	call	ftrace_stub
 #endif
 	RESTORE_ABI
-	jr t0
+	jr	t0
 SYM_FUNC_END(ftrace_caller)
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 SYM_FUNC_START(ftrace_regs_caller)
-	SAVE_ALL
-
-	addi	a0, t0, -FENTRY_RA_OFFSET
-	la	a1, function_trace_op
-	REG_L	a2, 0(a1)
-	mv	a1, ra
-	mv	a3, sp
+	SAVE_ABI_REGS 1
+	PREPARE_ARGS
 
 SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	call	ftrace_stub
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	addi	a0, sp, PT_RA
-	REG_L	a1, PT_EPC(sp)
-	addi	a1, a1, -FENTRY_RA_OFFSET
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	mv	a2, s0
-#endif
-SYM_INNER_LABEL(ftrace_graph_regs_call, SYM_L_GLOBAL)
+	RESTORE_ABI_REGS 1
+	jr	t0
+SYM_FUNC_END(ftrace_regs_caller)
+
+SYM_FUNC_START(ftrace_caller)
+	SAVE_ABI_REGS 0
+	PREPARE_ARGS
+
+SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	call	ftrace_stub
-#endif
 
-	RESTORE_ALL
-	jr t0
-SYM_FUNC_END(ftrace_regs_caller)
+	RESTORE_ABI_REGS 0
+	jr	t0
+SYM_FUNC_END(ftrace_caller)
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
-- 
2.40.1

