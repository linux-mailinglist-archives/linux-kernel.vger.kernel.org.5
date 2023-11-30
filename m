Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BA97FEEB7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbjK3MQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjK3MPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:15:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD19D48
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:15:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E23C43391;
        Thu, 30 Nov 2023 12:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701346554;
        bh=svHjq6BTZhzzPhI8kj7ht+r5VyVLRJaN4ub31HCJx4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R9oL32ff+QkFBx3i3fH0/0mtKAmFM0CH0F0ufNbYTBbEiCG/7ylFsb3GKTmfh8VNy
         rRMKrEoXB0cvPPfEql1QxbXKdPachSTbTMH9wqFnvEYGIAm5stSZbLzDOM/hs+7zt0
         se/LW52xooEzYPnnLdH1QjeQ81/wdImJNsH0qFfzJTcK+HNxDEwlflYUIL2a1gdsPt
         nT8EK1rshSQQgviG62rvN5WDVxzkuKjjr+RoOCzSsVW/kMk/XdKkF+F1eAE3AROh0L
         8f9Tf7L/UYygK9dBMWYE4yzeJtFSJqvI5TL2QM3dDPSfGzP4+4vDQXMWfx0AW0BsTF
         sQl5p+GNdog6g==
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
Subject: [PATCH v12 for-next 3/4] riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
Date:   Thu, 30 Nov 2023 13:15:30 +0100
Message-Id: <20231130121531.1178502-4-bjorn@kernel.org>
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

Select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
register_ftrace_direct[_multi] interfaces allowing users to register
the customed trampoline (direct_caller) as the mcount for one or more
target functions. And modify_ftrace_direct[_multi] are also provided
for modifying direct_caller.

To make the direct_caller and the other ftrace hooks (e.g.
function/fgraph tracer, k[ret]probes) co-exist, a temporary register
is nominated to store the address of direct_caller in
ftrace_regs_caller. After the setting of the address direct_caller by
direct_ops->func and the RESTORE_REGS in ftrace_regs_caller,
direct_caller will be jumped to by the `jr` inst.

Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Acked-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/ftrace.h |  7 +++++++
 arch/riscv/kernel/mcount-dyn.S  | 10 ++++++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 69c95e42be9f..4684cdc754a0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -114,6 +114,7 @@ config RISCV
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
+	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index b383926f73be..329172122952 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -135,6 +135,13 @@ struct ftrace_regs;
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs);
 #define ftrace_graph_func ftrace_graph_func
+
+static inline void __arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
+{
+		regs->t1 = addr;
+}
+#define arch_ftrace_set_direct_caller(fregs, addr) \
+	__arch_ftrace_set_direct_caller(&(fregs)->regs, addr)
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index c902a7ddb310..b7ce001779c1 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -229,6 +229,7 @@ SYM_FUNC_END(ftrace_caller)
 
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 SYM_FUNC_START(ftrace_regs_caller)
+	mv	t1, zero
 	SAVE_ABI_REGS 1
 	PREPARE_ARGS
 
@@ -236,7 +237,10 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	call	ftrace_stub
 
 	RESTORE_ABI_REGS 1
+	bnez	t1, .Ldirect
 	jr	t0
+.Ldirect:
+	jr	t1
 SYM_FUNC_END(ftrace_regs_caller)
 
 SYM_FUNC_START(ftrace_caller)
@@ -250,3 +254,9 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	jr	t0
 SYM_FUNC_END(ftrace_caller)
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+SYM_CODE_START(ftrace_stub_direct_tramp)
+	jr	t0
+SYM_CODE_END(ftrace_stub_direct_tramp)
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
-- 
2.40.1

