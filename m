Return-Path: <linux-kernel+bounces-108387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739F38809E3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F22286E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F08112E52;
	Wed, 20 Mar 2024 02:43:17 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FE3125AC;
	Wed, 20 Mar 2024 02:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902597; cv=none; b=ZnjlPvlx5Yw7E7F9yVCsvOHCmkJLbSyx9lKe9/GALNr1R84WvjE1VLS/UnzElVlwcSz4PJJykoTs38GzyjBiv21FJ34js3Ru7o9YWmqk1q9/Hl6OFAcMy2De+XxR4XJ1U5OWcHhN9PZwtka3B3N/Z5L1gsnv9Qs2Wq/Nj0sRbac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902597; c=relaxed/simple;
	bh=o5ByIZ7XZxU6ChSGkQ6PlpxjmusyaP0JdZrXPAErMlU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNof83rtlrxg8dRKwQH36+ZYYZeG/IYD6YNYrVtJthGOTznq6ZvajCIrw+6BpuLiUkZKYbn6ivX4uhMQorK307/c8l0AqVrBdmFwfvfRV3E14eXMwBAhxxATAvqsLN09XAfxBkJJ7Vw/W5UNbV0AYosIlBqnWithfoqrgJzN5PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TztDR6fxmz1GCKF;
	Wed, 20 Mar 2024 10:42:47 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id D210B140155;
	Wed, 20 Mar 2024 10:43:10 +0800 (CST)
Received: from huawei.com (10.67.189.167) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 20 Mar
 2024 10:43:10 +0800
From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
To: <linux@armlinux.org.uk>, <arnd@arndb.de>, <keescook@chromium.org>,
	<rmk+kernel@armlinux.org.uk>, <haibo.li@mediatek.com>,
	<angelogioacchino.delregno@collabora.com>, <amergnat@baylibre.com>,
	<xiaojiangfeng@huawei.com>
CC: <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
	<douzhaolei@huawei.com>, <gustavoars@kernel.org>, <jpoimboe@kernel.org>,
	<kepler.chenxin@huawei.com>, <kirill.shutemov@linux.intel.com>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
	<nixiaoming@huawei.com>, <peterz@infradead.org>, <wangbing6@huawei.com>,
	<wangfangpeng1@huawei.com>, <jannh@google.com>, <David.Laight@ACULAB.COM>
Subject: [PATCH] ARM: unwind: improve unwinders for noreturn case
Date: Wed, 20 Mar 2024 10:19:29 +0800
Message-ID: <1710901169-22763-1-git-send-email-xiaojiangfeng@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)

This is an off-by-one bug which is common in unwinders,
due to the fact that the address on the stack points
to the return address rather than the call address.

So, for example, when the last instruction of a function
is a function call (e.g., to a noreturn function), it can
cause the unwinder to incorrectly try to unwind from
the function after the callee.

foo:
..
	bl	bar
.. end of function and thus next function ...

which results in LR pointing into the next function.

Fixed this by subtracting 1 from frmae->pc in the call frame
(but not exception frames) like ORC on x86 does.

Refer to the unwind_next_frame function in the unwind_orc.c

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lkml.kernel.org/lkml/20240305175846.qnyiru7uaa7itqba@treble/
Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
---
 arch/arm/include/asm/stacktrace.h |  4 ----
 arch/arm/kernel/stacktrace.c      |  2 --
 arch/arm/kernel/traps.c           |  4 ++--
 arch/arm/kernel/unwind.c          | 18 +++++++++++++++---
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
index 360f0d2..07e4c16 100644
--- a/arch/arm/include/asm/stacktrace.h
+++ b/arch/arm/include/asm/stacktrace.h
@@ -21,9 +21,7 @@ struct stackframe {
 	struct llist_node *kr_cur;
 	struct task_struct *tsk;
 #endif
-#ifdef CONFIG_UNWINDER_FRAME_POINTER
 	bool ex_frame;
-#endif
 };
 
 static __always_inline
@@ -37,9 +35,7 @@ void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
 		frame->kr_cur = NULL;
 		frame->tsk = current;
 #endif
-#ifdef CONFIG_UNWINDER_FRAME_POINTER
 		frame->ex_frame = in_entry_text(frame->pc);
-#endif
 }
 
 extern int unwind_frame(struct stackframe *frame);
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 620aa82..1abd4f9 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -154,9 +154,7 @@ static void start_stack_trace(struct stackframe *frame, struct task_struct *task
 	frame->kr_cur = NULL;
 	frame->tsk = task;
 #endif
-#ifdef CONFIG_UNWINDER_FRAME_POINTER
 	frame->ex_frame = in_entry_text(frame->pc);
-#endif
 }
 
 void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 3bad79d..b64e442 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -84,10 +84,10 @@ void dump_backtrace_entry(unsigned long where, unsigned long from,
 	printk("%sFunction entered at [<%08lx>] from [<%08lx>]\n",
 		loglvl, where, from);
 #elif defined CONFIG_BACKTRACE_VERBOSE
-	printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pS)\n",
+	pr_warn("%s[<%08lx>] (%ps) from [<%08lx>] (%pB)\n",
 		loglvl, where, (void *)where, from, (void *)from);
 #else
-	printk("%s %ps from %pS\n", loglvl, (void *)where, (void *)from);
+	pr_warn("%s %ps from %pB\n", loglvl, (void *)where, (void *)from);
 #endif
 
 	if (in_entry_text(from) && end <= ALIGN(frame, THREAD_SIZE))
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 9d21921..f2baf92 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -30,6 +30,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 
+#include <asm/sections.h>
 #include <asm/stacktrace.h>
 #include <asm/traps.h>
 #include <asm/unwind.h>
@@ -416,8 +417,14 @@ int unwind_frame(struct stackframe *frame)
 
 	pr_debug("%s(pc = %08lx lr = %08lx sp = %08lx)\n", __func__,
 		 frame->pc, frame->lr, frame->sp);
-
-	idx = unwind_find_idx(frame->pc);
+	/*
+	 * For a call frame (as opposed to a exception frame), when the last
+	 * instruction of a function is a function call (e.g., to a noreturn
+	 * function), it can cause the unwinder incorrectly try to unwind
+	 * from the function after the callee, fixed this by subtracting 1
+	 * from frame->pc in the call frame like ORC on x86 does.
+	 */
+	idx = unwind_find_idx(frame->ex_frame ? frame->pc : frame->pc - 1);
 	if (!idx) {
 		if (frame->pc && kernel_text_address(frame->pc)) {
 			if (in_module_plt(frame->pc) && frame->pc != frame->lr) {
@@ -427,6 +434,7 @@ int unwind_frame(struct stackframe *frame)
 				 * the state of the stack or the register file
 				 */
 				frame->pc = frame->lr;
+				frame->ex_frame = in_entry_text(frame->pc);
 				return URC_OK;
 			}
 			pr_warn("unwind: Index not found %08lx\n", frame->pc);
@@ -454,6 +462,7 @@ int unwind_frame(struct stackframe *frame)
 		if (frame->pc == frame->lr)
 			return -URC_FAILURE;
 		frame->pc = frame->lr;
+		frame->ex_frame = in_entry_text(frame->pc);
 		return URC_OK;
 	} else if ((idx->insn & 0x80000000) == 0)
 		/* prel31 to the unwind table */
@@ -515,6 +524,7 @@ int unwind_frame(struct stackframe *frame)
 	frame->lr = ctrl.vrs[LR];
 	frame->pc = ctrl.vrs[PC];
 	frame->lr_addr = ctrl.lr_addr;
+	frame->ex_frame = in_entry_text(frame->pc);
 
 	return URC_OK;
 }
@@ -544,6 +554,7 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 		 */
 here:
 		frame.pc = (unsigned long)&&here;
+		frame.ex_frame = false;
 	} else {
 		/* task blocked in __switch_to */
 		frame.fp = thread_saved_fp(tsk);
@@ -554,11 +565,12 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 		 */
 		frame.lr = 0;
 		frame.pc = thread_saved_pc(tsk);
+		frame.ex_frame = false;
 	}
 
 	while (1) {
 		int urc;
-		unsigned long where = frame.pc;
+		unsigned long where = frame.ex_frame ? frame.pc : frame.pc - 1;
 
 		urc = unwind_frame(&frame);
 		if (urc < 0)
-- 
1.8.5.6


