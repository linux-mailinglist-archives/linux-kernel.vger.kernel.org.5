Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743447993DF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345787AbjIIAiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345706AbjIIAiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:38:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2801D2100;
        Fri,  8 Sep 2023 17:37:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D311EC116A5;
        Sat,  9 Sep 2023 00:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219831;
        bh=waP6Wsv+uLctdAq/ErHS9ag0S0CbxUZd9rhTZHMiE3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgbstGDga0UZxFPIkFmFh4drjrkKG852zT5NMUFT9bocQKUur4K5YQ4Ds6NWvs1kw
         OldRINdfXVEF6mwW3OrtdQdFlNja6mfk2pnwyrmbljLTkmGsGGoEduBp1x/eGJLmqG
         Pd2bjQiMDyvP5HML4SGMLyqmZsqHwkb4f7hbCFPnAVNM07+DDWxcH037wyV5W3Yj37
         Th2Ydsf1ej3EQLQ3TTebRoeqh5e37CvIFYKJBwX8qmAWr2c1eLo8ku7QG0AKfHVbNM
         0RQk2Ep8LU+/0+kjFsRk+kDONva2T/zQ07+/ZmHj3hVHtcWZTNcSAzNg411DYe5YT5
         1PmjaKkwIye1g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, ndesaulniers@google.com,
        peterz@infradead.org, ajones@ventanamicro.com, heiko@sntech.de,
        prabhakar.mahadev-lad.rj@bp.renesas.com, namcaov@gmail.com,
        andy.chiu@sifive.com, jszhang@kernel.org, guoren@kernel.org,
        bjorn@rivosinc.com, alexghiti@rivosinc.com,
        apatel@ventanamicro.com, masahiroy@kernel.org,
        greentime.hu@sifive.com, jeeheng.sia@starfivetech.com,
        xianting.tian@linux.alibaba.com, coelacanthushex@gmail.com,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 28/28] riscv: Add CFI error handling
Date:   Fri,  8 Sep 2023 20:36:02 -0400
Message-Id: <20230909003604.3579407-28-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003604.3579407-1-sashal@kernel.org>
References: <20230909003604.3579407-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
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

From: Sami Tolvanen <samitolvanen@google.com>

[ Upstream commit af0ead42f69389cd4ed68e1a4c6cde45c0adb35c ]

With CONFIG_CFI_CLANG, the compiler injects a type preamble immediately
before each function and a check to validate the target function type
before indirect calls:

  ; type preamble
    .word <id>
  function:
    ...
  ; indirect call check
    lw      t1, -4(a0)
    lui     t2, <hi20>
    addiw   t2, t2, <lo12>
    beq     t1, t2, .Ltmp0
    ebreak
  .Ltmp0:
    jarl    a0

Implement error handling code for the ebreak traps emitted for the
checks. This produces the following oops on a CFI failure (generated
using lkdtm):

[   21.177245] CFI failure at lkdtm_indirect_call+0x22/0x32 [lkdtm]
(target: lkdtm_increment_int+0x0/0x18 [lkdtm]; expected type: 0x3ad55aca)
[   21.178483] Kernel BUG [#1]
[   21.178671] Modules linked in: lkdtm
[   21.179037] CPU: 1 PID: 104 Comm: sh Not tainted
6.3.0-rc6-00037-g37d5ec6297ab #1
[   21.179511] Hardware name: riscv-virtio,qemu (DT)
[   21.179818] epc : lkdtm_indirect_call+0x22/0x32 [lkdtm]
[   21.180106]  ra : lkdtm_CFI_FORWARD_PROTO+0x48/0x7c [lkdtm]
[   21.180426] epc : ffffffff01387092 ra : ffffffff01386f14 sp : ff20000000453cf0
[   21.180792]  gp : ffffffff81308c38 tp : ff6000000243f080 t0 : ff20000000453b78
[   21.181157]  t1 : 000000003ad55aca t2 : 000000007e0c52a5 s0 : ff20000000453d00
[   21.181506]  s1 : 0000000000000001 a0 : ffffffff0138d170 a1 : ffffffff013870bc
[   21.181819]  a2 : b5fea48dd89aa700 a3 : 0000000000000001 a4 : 0000000000000fff
[   21.182169]  a5 : 0000000000000004 a6 : 00000000000000b7 a7 : 0000000000000000
[   21.182591]  s2 : ff20000000453e78 s3 : ffffffffffffffea s4 : 0000000000000012
[   21.183001]  s5 : ff600000023c7000 s6 : 0000000000000006 s7 : ffffffff013882a0
[   21.183653]  s8 : 0000000000000008 s9 : 0000000000000002 s10: ffffffff0138d878
[   21.184245]  s11: ffffffff0138d878 t3 : 0000000000000003 t4 : 0000000000000000
[   21.184591]  t5 : ffffffff8133df08 t6 : ffffffff8133df07
[   21.184858] status: 0000000000000120 badaddr: 0000000000000000
cause: 0000000000000003
[   21.185415] [<ffffffff01387092>] lkdtm_indirect_call+0x22/0x32 [lkdtm]
[   21.185772] [<ffffffff01386f14>] lkdtm_CFI_FORWARD_PROTO+0x48/0x7c [lkdtm]
[   21.186093] [<ffffffff01383552>] lkdtm_do_action+0x22/0x34 [lkdtm]
[   21.186445] [<ffffffff0138350c>] direct_entry+0x128/0x13a [lkdtm]
[   21.186817] [<ffffffff8033ed8c>] full_proxy_write+0x58/0xb2
[   21.187352] [<ffffffff801d4fe8>] vfs_write+0x14c/0x33a
[   21.187644] [<ffffffff801d5328>] ksys_write+0x64/0xd4
[   21.187832] [<ffffffff801d53a6>] sys_write+0xe/0x1a
[   21.188171] [<ffffffff80003996>] ret_from_syscall+0x0/0x2
[   21.188595] Code: 0513 0f65 a303 ffc5 53b7 7e0c 839b 2a53 0363 0073 (9002) 9582
[   21.189178] ---[ end trace 0000000000000000 ]---
[   21.189590] Kernel panic - not syncing: Fatal exception

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com> # ISA bits
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/r/20230710183544.999540-12-samitolvanen@google.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/Kconfig            |  1 +
 arch/riscv/include/asm/cfi.h  | 22 ++++++++++
 arch/riscv/include/asm/insn.h | 10 +++++
 arch/riscv/kernel/Makefile    |  2 +
 arch/riscv/kernel/cfi.c       | 77 +++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/traps.c     |  4 +-
 6 files changed, 115 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/cfi.h
 create mode 100644 arch/riscv/kernel/cfi.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bea7b73e895dd..6f16e8a7ec75e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -48,6 +48,7 @@ config RISCV
 	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USES_CFI_TRAPS if CFI_CLANG
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
diff --git a/arch/riscv/include/asm/cfi.h b/arch/riscv/include/asm/cfi.h
new file mode 100644
index 0000000000000..56bf9d69d5e38
--- /dev/null
+++ b/arch/riscv/include/asm/cfi.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_CFI_H
+#define _ASM_RISCV_CFI_H
+
+/*
+ * Clang Control Flow Integrity (CFI) support.
+ *
+ * Copyright (C) 2023 Google LLC
+ */
+
+#include <linux/cfi.h>
+
+#ifdef CONFIG_CFI_CLANG
+enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
+#else
+static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
+{
+	return BUG_TRAP_TYPE_NONE;
+}
+#endif /* CONFIG_CFI_CLANG */
+
+#endif /* _ASM_RISCV_CFI_H */
diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index fce00400c9bcc..06e439eeef9ad 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -63,6 +63,7 @@
 #define RVG_RS1_OPOFF		15
 #define RVG_RS2_OPOFF		20
 #define RVG_RD_OPOFF		7
+#define RVG_RS1_MASK		GENMASK(4, 0)
 #define RVG_RD_MASK		GENMASK(4, 0)
 
 /* The bit field of immediate value in RVC J instruction */
@@ -130,6 +131,7 @@
 #define RVC_C2_RS1_OPOFF	7
 #define RVC_C2_RS2_OPOFF	2
 #define RVC_C2_RD_OPOFF		7
+#define RVC_C2_RS1_MASK		GENMASK(4, 0)
 
 /* parts of opcode for RVG*/
 #define RVG_OPCODE_FENCE	0x0f
@@ -289,6 +291,10 @@ static __always_inline bool riscv_insn_is_c_jalr(u32 code)
 #define RV_X(X, s, mask)  (((X) >> (s)) & (mask))
 #define RVC_X(X, s, mask) RV_X(X, s, mask)
 
+#define RV_EXTRACT_RS1_REG(x) \
+	({typeof(x) x_ = (x); \
+	(RV_X(x_, RVG_RS1_OPOFF, RVG_RS1_MASK)); })
+
 #define RV_EXTRACT_RD_REG(x) \
 	({typeof(x) x_ = (x); \
 	(RV_X(x_, RVG_RD_OPOFF, RVG_RD_MASK)); })
@@ -316,6 +322,10 @@ static __always_inline bool riscv_insn_is_c_jalr(u32 code)
 	(RV_X(x_, RV_B_IMM_11_OPOFF, RV_B_IMM_11_MASK) << RV_B_IMM_11_OFF) | \
 	(RV_IMM_SIGN(x_) << RV_B_IMM_SIGN_OFF); })
 
+#define RVC_EXTRACT_C2_RS1_REG(x) \
+	({typeof(x) x_ = (x); \
+	(RV_X(x_, RVC_C2_RS1_OPOFF, RVC_C2_RS1_MASK)); })
+
 #define RVC_EXTRACT_JTYPE_IMM(x) \
 	({typeof(x) x_ = (x); \
 	(RVC_X(x_, RVC_J_IMM_3_1_OPOFF, RVC_J_IMM_3_1_MASK) << RVC_J_IMM_3_1_OFF) | \
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 506cc4a9a45a5..6ac56af42f4a0 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -91,6 +91,8 @@ obj-$(CONFIG_CRASH_CORE)	+= crash_core.o
 
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
+obj-$(CONFIG_CFI_CLANG)		+= cfi.o
+
 obj-$(CONFIG_EFI)		+= efi.o
 obj-$(CONFIG_COMPAT)		+= compat_syscall_table.o
 obj-$(CONFIG_COMPAT)		+= compat_signal.o
diff --git a/arch/riscv/kernel/cfi.c b/arch/riscv/kernel/cfi.c
new file mode 100644
index 0000000000000..820158d7a2913
--- /dev/null
+++ b/arch/riscv/kernel/cfi.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clang Control Flow Integrity (CFI) support.
+ *
+ * Copyright (C) 2023 Google LLC
+ */
+#include <asm/cfi.h>
+#include <asm/insn.h>
+
+/*
+ * Returns the target address and the expected type when regs->epc points
+ * to a compiler-generated CFI trap.
+ */
+static bool decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
+			    u32 *type)
+{
+	unsigned long *regs_ptr = (unsigned long *)regs;
+	int rs1_num;
+	u32 insn;
+
+	*target = *type = 0;
+
+	/*
+	 * The compiler generates the following instruction sequence
+	 * for indirect call checks:
+	 *
+	 *   lw      t1, -4(<reg>)
+	 *   lui     t2, <hi20>
+	 *   addiw   t2, t2, <lo12>
+	 *   beq     t1, t2, .Ltmp1
+	 *   ebreak  ; <- regs->epc
+	 *   .Ltmp1:
+	 *   jalr    <reg>
+	 *
+	 * We can read the expected type and the target address from the
+	 * registers passed to the beq/jalr instructions.
+	 */
+	if (get_kernel_nofault(insn, (void *)regs->epc - 4))
+		return false;
+	if (!riscv_insn_is_beq(insn))
+		return false;
+
+	*type = (u32)regs_ptr[RV_EXTRACT_RS1_REG(insn)];
+
+	if (get_kernel_nofault(insn, (void *)regs->epc) ||
+	    get_kernel_nofault(insn, (void *)regs->epc + GET_INSN_LENGTH(insn)))
+		return false;
+
+	if (riscv_insn_is_jalr(insn))
+		rs1_num = RV_EXTRACT_RS1_REG(insn);
+	else if (riscv_insn_is_c_jalr(insn))
+		rs1_num = RVC_EXTRACT_C2_RS1_REG(insn);
+	else
+		return false;
+
+	*target = regs_ptr[rs1_num];
+
+	return true;
+}
+
+/*
+ * Checks if the ebreak trap is because of a CFI failure, and handles the trap
+ * if needed. Returns a bug_trap_type value similarly to report_bug.
+ */
+enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
+{
+	unsigned long target;
+	u32 type;
+
+	if (!is_cfi_trap(regs->epc))
+		return BUG_TRAP_TYPE_NONE;
+
+	if (!decode_cfi_insn(regs, &target, &type))
+		return report_cfi_failure_noaddr(regs, regs->epc);
+
+	return report_cfi_failure(regs, regs->epc, &target, type);
+}
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f798c853bede6..19807c4d3805d 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -21,6 +21,7 @@
 
 #include <asm/asm-prototypes.h>
 #include <asm/bug.h>
+#include <asm/cfi.h>
 #include <asm/csr.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
@@ -271,7 +272,8 @@ void handle_break(struct pt_regs *regs)
 								== NOTIFY_STOP)
 		return;
 #endif
-	else if (report_bug(regs->epc, regs) == BUG_TRAP_TYPE_WARN)
+	else if (report_bug(regs->epc, regs) == BUG_TRAP_TYPE_WARN ||
+		 handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN)
 		regs->epc += get_break_insn_length(regs->epc);
 	else
 		die(regs, "Kernel BUG");
-- 
2.40.1

