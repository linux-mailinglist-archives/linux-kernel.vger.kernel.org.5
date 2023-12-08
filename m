Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ED880A93B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574244AbjLHQgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574444AbjLHQf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:35:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C718C199A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:35:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE94C433CB;
        Fri,  8 Dec 2023 16:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702053332;
        bh=mcOc029J1BqyWbOqtSlrwAjg5MaAlcqBJsrSldWAf8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUFBhlM7PmCPIHyssSqtMtp0iHkXz0NaajpTrYeU7B9HrrgSt6Sze/LesuoHwp5ZK
         xSB8ZFbckeD9MVLZrmE6MV1S8wu6nUgACwNuyfLZBEnOwnjhChCHrzwKnjuTuXIiFQ
         jC2gXriHQP89crMlGaYqaRLQ2+ii82w+BUq5++7TccuBh7QoJNxKe70VJlNj+xhLgz
         nhxvjs7ihyhHZlzHuMTrxQt2wl0jJnbMl0u8buymkdxplPfVzVqIeXthFgA2izpoVO
         rp4WP3WV7Y12Wb4a1HmJNeSxGaGEu4qcCR9A5ibNTgsMdd+OPLKQ0umsxYjqySGFQt
         pEBXTz3LJZP6A==
From:   Naveen N Rao <naveen@kernel.org>
To:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 7/9] powerpc/ftrace: Add support for DYNAMIC_FTRACE_WITH_CALL_OPS
Date:   Fri,  8 Dec 2023 22:00:46 +0530
Message-ID: <cc8ac847f3b23384b79e3db7968f79aea41bdc57.1702045299.git.naveen@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702045299.git.naveen@kernel.org>
References: <cover.1702045299.git.naveen@kernel.org>
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

Implement support for DYNAMIC_FTRACE_WITH_CALL_OPS similar to the
arm64 implementation.

This works by patching-in a pointer to an associated ftrace_ops
structure before each traceable function. If multiple ftrace_ops are
associated with a call site, then a special ftrace_list_ops is used to
enable iterating over all the registered ftrace_ops. If no ftrace_ops
are associated with a call site, then a special ftrace_nop_ops structure
is used to render the ftrace call as a no-op. ftrace trampoline can then
read the associated ftrace_ops for a call site by loading from an offset
from the LR, and branch directly to the associated function.

The primary advantage with this approach is that we don't have to
iterate over all the registered ftrace_ops for call sites that have a
single ftrace_ops registered. This is the equivalent of implementing
support for dynamic ftrace trampolines, which set up a special ftrace
trampoline for each registered ftrace_ops and have individual call sites
branch into those directly.

A secondary advantage is that this gives us a way to add support for
direct ftrace callers without having to resort to using stubs. The
address of the direct call trampoline can be loaded from the ftrace_ops
structure.

To support this, we utilize the space between the existing function
profile sequence and the function entry. During ftrace activation, we
update this location with the associated ftrace_ops pointer. Then, on
ftrace entry, we load from this location and call into
ftrace_ops->func().

For 64-bit powerpc, we also select FUNCTION_ALIGNMENT_8B so that the
ftrace_ops pointer is double word aligned and can be updated atomically.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/Kconfig                     |  2 +
 arch/powerpc/kernel/asm-offsets.c        |  4 ++
 arch/powerpc/kernel/trace/ftrace.c       | 58 ++++++++++++++++++++++++
 arch/powerpc/kernel/trace/ftrace_entry.S | 39 +++++++++++-----
 4 files changed, 91 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 318e5c1b7454..c8ecc9dcc914 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -190,6 +190,7 @@ config PPC
 	select EDAC_SUPPORT
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if ARCH_USING_PATCHABLE_FUNCTION_ENTRY
 	select FUNCTION_ALIGNMENT_4B
+	select FUNCTION_ALIGNMENT_8B		if PPC64 && DYNAMIC_FTRACE_WITH_CALL_OPS
 	select GENERIC_ATOMIC64			if PPC32
 	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
 	select GENERIC_CMOS_UPDATE
@@ -233,6 +234,7 @@ config PPC
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if ARCH_USING_PATCHABLE_FUNCTION_ENTRY || MPROFILE_KERNEL || PPC32
+	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS if ARCH_USING_PATCHABLE_FUNCTION_ENTRY
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS	if ARCH_USING_PATCHABLE_FUNCTION_ENTRY || MPROFILE_KERNEL || PPC32
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 9f14d95b8b32..8b8a39b57a9f 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -676,5 +676,9 @@ int main(void)
 	DEFINE(BPT_SIZE, BPT_SIZE);
 #endif
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+	OFFSET(FTRACE_OPS_FUNC, ftrace_ops, func);
+#endif
+
 	return 0;
 }
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index d3b4949142a8..af84eabf7912 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -124,6 +124,41 @@ static int ftrace_get_call_inst(struct dyn_ftrace *rec, unsigned long addr, ppc_
 	return 0;
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+static const struct ftrace_ops *powerpc_rec_get_ops(struct dyn_ftrace *rec)
+{
+	const struct ftrace_ops *ops = NULL;
+
+	if (rec->flags & FTRACE_FL_CALL_OPS_EN) {
+		ops = ftrace_find_unique_ops(rec);
+		WARN_ON_ONCE(!ops);
+	}
+
+	if (!ops)
+		ops = &ftrace_list_ops;
+
+	return ops;
+}
+
+static int ftrace_rec_set_ops(const struct dyn_ftrace *rec, const struct ftrace_ops *ops)
+{
+	return patch_ulong((void *)(rec->ip - sizeof(unsigned long)), (unsigned long)ops);
+}
+
+static int ftrace_rec_set_nop_ops(struct dyn_ftrace *rec)
+{
+	return ftrace_rec_set_ops(rec, &ftrace_nop_ops);
+}
+
+static int ftrace_rec_update_ops(struct dyn_ftrace *rec)
+{
+	return ftrace_rec_set_ops(rec, powerpc_rec_get_ops(rec));
+}
+#else
+static int ftrace_rec_set_nop_ops(struct dyn_ftrace *rec) { return 0; }
+static int ftrace_rec_update_ops(struct dyn_ftrace *rec) { return 0; }
+#endif
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr, unsigned long addr)
 {
@@ -159,6 +194,10 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	if (ret || !IS_ENABLED(CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY))
 		return ret;
 
+	ret = ftrace_rec_update_ops(rec);
+	if (ret)
+		return ret;
+
 	ip = rec->ip;
 	ret = ftrace_modify_code(ip, ppc_inst(PPC_RAW_NOP()),
 				 ppc_inst(PPC_RAW_BRANCH(-FTRACE_MCOUNT_TRAMP_OFFSET)));
@@ -214,16 +253,19 @@ void ftrace_replace_code(int enable)
 		case FTRACE_UPDATE_MODIFY_CALL:
 			ret = ftrace_get_call_inst(rec, new_addr, &new_call_inst);
 			ret |= ftrace_get_call_inst(rec, addr, &call_inst);
+			ret |= ftrace_rec_update_ops(rec);
 			old = call_inst;
 			new = new_call_inst;
 			break;
 		case FTRACE_UPDATE_MAKE_NOP:
 			ret = ftrace_get_call_inst(rec, addr, &call_inst);
+			ret |= ftrace_rec_set_nop_ops(rec);
 			old = call_inst;
 			new = nop_inst;
 			break;
 		case FTRACE_UPDATE_MAKE_CALL:
 			ret = ftrace_get_call_inst(rec, new_addr, &call_inst);
+			ret |= ftrace_rec_update_ops(rec);
 			old = nop_inst;
 			new = call_inst;
 			break;
@@ -312,6 +354,12 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 			ret |= ftrace_modify_code(ip, old, ppc_inst(ftrace_mcount_tramp_insns[i]));
 
 		if (IS_ENABLED(CONFIG_PPC64)) {
+			if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS) &&
+			    !IS_ALIGNED(ip, sizeof(unsigned long))) {
+				pr_err("0x%lx: Mis-aligned ftrace_ops patch site\n", ip);
+				return -EINVAL;
+			}
+
 			/* two more nops */
 			ret |= ftrace_validate_inst(ip, old);
 			ip += MCOUNT_INSN_SIZE;
@@ -325,6 +373,9 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 		/* nop at ftrace location */
 		ret |= ftrace_validate_inst(ip, old);
 
+		if (!ret)
+			ret = ftrace_rec_set_nop_ops(rec);
+
 		return ret;
 	}
 
@@ -383,6 +434,13 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	ppc_inst_t old, new;
 	int ret;
 
+	/*
+	 * When using CALL_OPS, the function to call is associated with the
+	 * call site, and we don't have a global function pointer to update.
+	 */
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
+		return 0;
+
 	old = ppc_inst_read((u32 *)&ftrace_call);
 	new = ftrace_create_branch_inst(ip, ppc_function_entry(func), 1);
 	ret = ftrace_modify_code(ip, old, new);
diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
index 537c14b12904..4d1220c2e32f 100644
--- a/arch/powerpc/kernel/trace/ftrace_entry.S
+++ b/arch/powerpc/kernel/trace/ftrace_entry.S
@@ -97,11 +97,6 @@
 	/* Save callee's TOC in the ABI compliant location */
 	std	r2, STK_GOT(r1)
 	LOAD_PACA_TOC()		/* get kernel TOC in r2 */
-	LOAD_REG_ADDR(r3, function_trace_op)
-	ld	r5,0(r3)
-#else
-	lis	r3,function_trace_op@ha
-	lwz	r5,function_trace_op@l(r3)
 #endif
 
 #ifdef CONFIG_LIVEPATCH_64
@@ -177,20 +172,40 @@
 #endif
 .endm
 
-_GLOBAL(ftrace_regs_caller)
-	ftrace_regs_entry 1
-	/* ftrace_call(r3, r4, r5, r6) */
+.macro ftrace_regs_func allregs
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+	PPC_LL	r5, -SZL(r3)
+	PPC_LL	r12, FTRACE_OPS_FUNC(r5)
+	mtctr	r12
+	bctrl
+#else
+#ifdef CONFIG_PPC64
+	LOAD_REG_ADDR(r5, function_trace_op)
+	ld	r5, 0(r5)
+#else
+	lis	r5, function_trace_op@ha
+	lwz	r5, function_trace_op@l(r5)
+#endif
+	.if \allregs == 1
 .globl ftrace_regs_call
 ftrace_regs_call:
+	.else
+.globl ftrace_call
+ftrace_call:
+	.endif
+	/* ftrace_call(r3, r4, r5, r6) */
 	bl	ftrace_stub
+#endif
+.endm
+
+_GLOBAL(ftrace_regs_caller)
+	ftrace_regs_entry 1
+	ftrace_regs_func 1
 	ftrace_regs_exit 1
 
 _GLOBAL(ftrace_caller)
 	ftrace_regs_entry 0
-	/* ftrace_call(r3, r4, r5, r6) */
-.globl ftrace_call
-ftrace_call:
-	bl	ftrace_stub
+	ftrace_regs_func 0
 	ftrace_regs_exit 0
 
 _GLOBAL(ftrace_stub)
-- 
2.43.0

