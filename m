Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA988789C40
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 10:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjH0IkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 04:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjH0Ij7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 04:39:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148E013E;
        Sun, 27 Aug 2023 01:39:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A47EE60F7D;
        Sun, 27 Aug 2023 08:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18049C433C8;
        Sun, 27 Aug 2023 08:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693125595;
        bh=YzIwPUhAIk98KSVOhAjG5Ib6wpaBGGcNghTCEj9deJU=;
        h=From:To:Cc:Subject:Date:From;
        b=HdAwxenOM8yUDMXJbFzt+mAm1X+PADXLPz55W3BtvbFqFQZedXvl3rsRofL4u62wb
         OQ5HMt7Nv/vA4rruNXNqt3urENYWaWXnJJCJblntkww8wLRdv1MSQwjsOxdVWuosJg
         TxzKvwUCMg4iriM6BSKNIzPfTkiUPWKO5KA1H1DRpgbAipR31UOVq7X30ECqw8q8l3
         uyLhz6tudsOYZMUV8EU5f2Fau3ERd0yPY82gsvpUREIDkev4iu/XVR1MC1UkWbQQ/O
         SmToHrvJYu3AwX/U5RbFEc8FOM6m9LW5EyBgwePv4pxD8SlOnJ38ZUNl2tKxXMHZvg
         GsdrQe51zfkGw==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Nam Cao <namcaov@gmail.com>
Subject: [PATCH] riscv: Only consider swbp/ss handlers for correct privileged mode
Date:   Sun, 27 Aug 2023 10:39:49 +0200
Message-Id: <20230827083949.204927-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/include/asm/kprobes.h | 11 ++++++++++-
 arch/riscv/include/asm/uprobes.h | 13 ++++++++++++-
 arch/riscv/kernel/traps.c        | 28 ++++++++++++++++++----------
 3 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
index e7882ccb0fd4..89fbd90f16a2 100644
--- a/arch/riscv/include/asm/kprobes.h
+++ b/arch/riscv/include/asm/kprobes.h
@@ -40,6 +40,15 @@ void arch_remove_kprobe(struct kprobe *p);
 int kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr);
 bool kprobe_breakpoint_handler(struct pt_regs *regs);
 bool kprobe_single_step_handler(struct pt_regs *regs);
-
+#else
+static inline bool kprobe_breakpoint_handler(struct pt_regs *)
+{
+	return false;
+}
+
+static inline bool kprobe_single_step_handler(struct pt_regs *)
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
index f798c853bede..cd6f10c73a16 100644
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
@@ -246,22 +248,28 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
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

base-commit: 7d2f353b2682dcfe5f9bc71e5b61d5b61770d98e
-- 
2.39.2

