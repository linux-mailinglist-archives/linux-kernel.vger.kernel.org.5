Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E09279C742
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjILG4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjILG4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:56:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAC1E75;
        Mon, 11 Sep 2023 23:56:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D400C433C7;
        Tue, 12 Sep 2023 06:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694501793;
        bh=ACq4UovHGdsS/35TyjryQ/+Lm+A5dK/cB8Beun04Eg4=;
        h=From:To:Cc:Subject:Date:From;
        b=hl8PyhhukPibWgT7UB5eKKyk1cSrK6mmQfdkENKV5r9iIl1rgqSx0kMjsvFosBy2V
         6Bt+bm0l/X1sWzOwqeImCQCCLXEt5Z+5aOPIBRrnRW4eH0JwVVHVbn6Sytykb9YYyG
         uBX0ta5sWPf59uk4juiqRgroHKrqRBNguVOWaZwGS+U4RY8sKJ/SkFSAuEA/y0aecS
         9plt4R4apoX9MffEtQ7xsMQVp05QS8JfMR4ZoBXJU5M0c3Y5pTozsuV9PYo3bg07ng
         RsoIhaeUyPN3MlR/r+Q091tLCVTOwUGPJawYWr+hMTsDPzZivRl95VMw644VR/bZC0
         NT+kQR2L8gk+w==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Nam Cao <namcaov@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v3] riscv: Only consider swbp/ss handlers for correct privileged mode
Date:   Tue, 12 Sep 2023 08:56:19 +0200
Message-Id: <20230912065619.62020-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

RISC-V software breakpoint trap handlers are used for {k,u}probes.

When trapping from kernelmode, only the kernelmode handlers should be
considered. Vice versa, only usermode handlers for usermode
traps. This is not the case on RISC-V, which can trigger a bug if a
userspace process uses uprobes, and a WARN() is triggered from
kernelmode (which is implemented via {c.,}ebreak).

The kernel will trap on the kernelmode {c.,}ebreak, look for uprobes
handlers, realize incorrectly that uprobes need to be handled, and
exit the trap handler early. The trap returns to re-executing the
{c.,}ebreak, and enter an infinite trap-loop.

The issue was found running the BPF selftest [1].

Fix this issue by only considering the swbp/ss handlers for
kernel/usermode respectively. Also, move CONFIG ifdeffery from traps.c
to the asm/{k,u}probes.h headers.

Note that linux/uprobes.h only include asm/uprobes.h if CONFIG_UPROBES
is defined, which is why asm/uprobes.h needs to be unconditionally
included in traps.c

Link: https://lore.kernel.org/linux-riscv/87v8d19aun.fsf@all.your.base.are.belong.to.us/ # [1]
Fixes: 74784081aac8 ("riscv: Add uprobes supported")
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Nam Cao <namcaov@gmail.com>
Tested-by: Puranjay Mohan <puranjay12@gmail.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
v2->v3: Remove incorrect tags (Conor)
        Collect review/test tags
v1->v2: Fix Clang build warning (kernel test robot)
---
 arch/riscv/include/asm/kprobes.h | 11 ++++++++++-
 arch/riscv/include/asm/uprobes.h | 13 ++++++++++++-
 arch/riscv/kernel/traps.c        | 28 ++++++++++++++++++----------
 3 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
index e7882ccb0fd4..78ea44f76718 100644
--- a/arch/riscv/include/asm/kprobes.h
+++ b/arch/riscv/include/asm/kprobes.h
@@ -40,6 +40,15 @@ void arch_remove_kprobe(struct kprobe *p);
 int kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr);
 bool kprobe_breakpoint_handler(struct pt_regs *regs);
 bool kprobe_single_step_handler(struct pt_regs *regs);
-
+#else
+static inline bool kprobe_breakpoint_handler(struct pt_regs *regs)
+{
+	return false;
+}
+
+static inline bool kprobe_single_step_handler(struct pt_regs *regs)
+{
+	return false;
+}
 #endif /* CONFIG_KPROBES */
 #endif /* _ASM_RISCV_KPROBES_H */
diff --git a/arch/riscv/include/asm/uprobes.h b/arch/riscv/include/asm/uprobes.h
index f2183e00fdd2..3fc7deda9190 100644
--- a/arch/riscv/include/asm/uprobes.h
+++ b/arch/riscv/include/asm/uprobes.h
@@ -34,7 +34,18 @@ struct arch_uprobe {
 	bool simulate;
 };
 
+#ifdef CONFIG_UPROBES
 bool uprobe_breakpoint_handler(struct pt_regs *regs);
 bool uprobe_single_step_handler(struct pt_regs *regs);
-
+#else
+static inline bool uprobe_breakpoint_handler(struct pt_regs *regs)
+{
+	return false;
+}
+
+static inline bool uprobe_single_step_handler(struct pt_regs *regs)
+{
+	return false;
+}
+#endif /* CONFIG_UPROBES */
 #endif /* _ASM_RISCV_UPROBES_H */
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 19807c4d3805..fae8f610d867 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -13,6 +13,8 @@
 #include <linux/kdebug.h>
 #include <linux/uaccess.h>
 #include <linux/kprobes.h>
+#include <linux/uprobes.h>
+#include <asm/uprobes.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/irq.h>
@@ -247,22 +249,28 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
 	return GET_INSN_LENGTH(insn);
 }
 
+static bool probe_single_step_handler(struct pt_regs *regs)
+{
+	bool user = user_mode(regs);
+
+	return user ? uprobe_single_step_handler(regs) : kprobe_single_step_handler(regs);
+}
+
+static bool probe_breakpoint_handler(struct pt_regs *regs)
+{
+	bool user = user_mode(regs);
+
+	return user ? uprobe_breakpoint_handler(regs) : kprobe_breakpoint_handler(regs);
+}
+
 void handle_break(struct pt_regs *regs)
 {
-#ifdef CONFIG_KPROBES
-	if (kprobe_single_step_handler(regs))
+	if (probe_single_step_handler(regs))
 		return;
 
-	if (kprobe_breakpoint_handler(regs))
-		return;
-#endif
-#ifdef CONFIG_UPROBES
-	if (uprobe_single_step_handler(regs))
+	if (probe_breakpoint_handler(regs))
 		return;
 
-	if (uprobe_breakpoint_handler(regs))
-		return;
-#endif
 	current->thread.bad_cause = regs->cause;
 
 	if (user_mode(regs))

base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.39.2

