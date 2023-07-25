Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68259760CC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjGYIPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjGYIPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:15:22 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8A86E63
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:15:19 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxjuuThL9kBaQJAA--.21707S3;
        Tue, 25 Jul 2023 16:15:15 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLCOOhL9kAFg6AA--.7611S6;
        Tue, 25 Jul 2023 16:15:14 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v1 4/6] objtool/LoongArch: Enable orc to be built
Date:   Tue, 25 Jul 2023 16:15:08 +0800
Message-Id: <1690272910-11869-5-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1690272910-11869-1-git-send-email-yangtiezhu@loongson.cn>
References: <1690272910-11869-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8CxLCOOhL9kAFg6AA--.7611S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3uFW7JF15Jr17Gw1kZF1rXwc_yoWktrykp3
        WDu3y8JrW7Xr13Awn7Kan3WrW5Kws7Wr10yrnxC34IyrWIqrn5Jrs2qryDXF98Wws5W3y7
        uFWagr429a12vabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0epB3UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement init_orc_entry(), reg_name(), orc_type_name(), print_reg(),
orc_print_dump(), arch_write_orc() and update_cfi_state(), and then
set BUILD_ORC as y to build the orc related files.

Co-developed-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Co-developed-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/arch/loongarch/include/asm/orc_types.h |  58 ++++++++++
 tools/objtool/Makefile                       |   4 +
 tools/objtool/arch/loongarch/Build           |   1 +
 tools/objtool/arch/loongarch/decode.c        |  94 ++++++++++++++++
 tools/objtool/arch/loongarch/orc.c           | 158 +++++++++++++++++++++++++++
 tools/objtool/include/objtool/orc.h          |   1 +
 tools/objtool/orc_gen.c                      |   3 +
 7 files changed, 319 insertions(+)
 create mode 100644 tools/arch/loongarch/include/asm/orc_types.h
 create mode 100644 tools/objtool/arch/loongarch/orc.c

diff --git a/tools/arch/loongarch/include/asm/orc_types.h b/tools/arch/loongarch/include/asm/orc_types.h
new file mode 100644
index 0000000..1d37e62
--- /dev/null
+++ b/tools/arch/loongarch/include/asm/orc_types.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _ORC_TYPES_H
+#define _ORC_TYPES_H
+
+#include <linux/types.h>
+
+/*
+ * The ORC_REG_* registers are base registers which are used to find other
+ * registers on the stack.
+ *
+ * ORC_REG_PREV_SP, also known as DWARF Call Frame Address (CFA), is the
+ * address of the previous frame: the caller's SP before it called the current
+ * function.
+ *
+ * ORC_REG_UNDEFINED means the corresponding register's value didn't change in
+ * the current frame.
+ *
+ * The most commonly used base registers are SP and BP -- which the previous SP
+ * is usually based on -- and PREV_SP and UNDEFINED -- which the previous BP is
+ * usually based on.
+ *
+ * The rest of the base registers are needed for special cases like entry code
+ * and GCC realigned stacks.
+ */
+#define ORC_REG_UNDEFINED		0
+#define ORC_REG_PREV_SP			1
+#define ORC_REG_SP			2
+#define ORC_REG_BP			3
+#define ORC_REG_MAX			4
+
+#define ORC_TYPE_UNDEFINED		0
+#define ORC_TYPE_END_OF_STACK		1
+#define ORC_TYPE_CALL			2
+#define ORC_TYPE_REGS			3
+#define ORC_TYPE_REGS_PARTIAL		4
+
+#ifndef __ASSEMBLY__
+/*
+ * This struct is more or less a vastly simplified version of the DWARF Call
+ * Frame Information standard.  It contains only the necessary parts of DWARF
+ * CFI, simplified for ease of access by the in-kernel unwinder.  It tells the
+ * unwinder how to find the previous SP and BP (and sometimes entry regs) on
+ * the stack for a given code address.  Each instance of the struct corresponds
+ * to one or more code locations.
+ */
+struct orc_entry {
+	s16		sp_offset;
+	s16		bp_offset;
+	s16		ra_offset;
+	unsigned int	sp_reg:4;
+	unsigned int	bp_reg:4;
+	unsigned int	ra_reg:4;
+	unsigned int	type:3;
+	unsigned int	signal:1;
+};
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ORC_TYPES_H */
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 83b100c..bf7f7f8 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -57,6 +57,10 @@ ifeq ($(SRCARCH),x86)
 	BUILD_ORC := y
 endif
 
+ifeq ($(SRCARCH),loongarch)
+	BUILD_ORC := y
+endif
+
 export BUILD_ORC
 export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
diff --git a/tools/objtool/arch/loongarch/Build b/tools/objtool/arch/loongarch/Build
index d24d563..1d4b784 100644
--- a/tools/objtool/arch/loongarch/Build
+++ b/tools/objtool/arch/loongarch/Build
@@ -1,2 +1,3 @@
 objtool-y += decode.o
 objtool-y += special.o
+objtool-y += orc.o
diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index 2904fbc..8489509 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -3,6 +3,8 @@
 #include <objtool/check.h>
 #include <objtool/warn.h>
 #include <asm/inst.h>
+#include <asm/orc_types.h>
+#include <linux/objtool_types.h>
 
 int arch_ftrace_match(char *name)
 {
@@ -38,6 +40,20 @@ bool arch_callee_saved_reg(unsigned char reg)
 
 int arch_decode_hint_reg(u8 sp_reg, int *base)
 {
+	switch (sp_reg) {
+	case ORC_REG_UNDEFINED:
+		*base = CFI_UNDEFINED;
+		break;
+	case ORC_REG_SP:
+		*base = CFI_SP;
+		break;
+	case ORC_REG_BP:
+		*base = CFI_FP;
+		break;
+	default:
+		return -1;
+	}
+
 	return 0;
 }
 
@@ -310,3 +326,81 @@ void arch_initial_func_cfi_state(struct cfi_init_state *state)
 	state->cfa.base = CFI_SP;
 	state->cfa.offset = 0;
 }
+
+int update_cfi_state(struct instruction *insn,
+		     struct instruction *next_insn,
+		     struct cfi_state *cfi, struct stack_op *op)
+{
+	struct cfi_reg *cfa = &cfi->cfa;
+	struct cfi_reg *regs = cfi->regs;
+
+	/* ignore UNWIND_HINT_UNDEFINED regions */
+	if (cfi->force_undefined)
+		return 0;
+
+	/* stack operations don't make sense with an undefined CFA */
+	if (cfa->base == CFI_UNDEFINED) {
+		if (insn_func(insn)) {
+			WARN_INSN(insn, "undefined stack state");
+			return -1;
+		}
+		return 0;
+	}
+
+	if (cfi->type == UNWIND_HINT_TYPE_REGS ||
+	    cfi->type == UNWIND_HINT_TYPE_REGS_PARTIAL)
+		return update_cfi_state_regs(insn, cfi, op);
+
+	switch (op->dest.type) {
+	case OP_DEST_REG:
+		switch (op->src.type) {
+		case OP_SRC_ADD:
+			if (op->dest.reg == CFI_SP && op->src.reg == CFI_SP) {
+				/* addi.d sp,sp,si12 */
+				cfi->stack_size -= op->src.offset;
+				if (cfa->base == CFI_SP)
+					cfa->offset -= op->src.offset;
+			} else if (op->dest.reg == CFI_FP && op->src.reg == CFI_SP) {
+				/* addi.d fp,sp,si12 */
+				if (cfa->base == CFI_SP && cfa->offset == op->src.offset) {
+					cfa->base = CFI_FP;
+					cfa->offset = 0;
+				}
+			} else if (op->dest.reg == CFI_SP && op->src.reg == CFI_FP) {
+				/* addi.d sp,fp,si12 */
+				if (cfa->base == CFI_FP && cfa->offset == 0) {
+					cfa->base = CFI_SP;
+					cfa->offset = -op->src.offset;
+				}
+			}
+			break;
+		case OP_SRC_REG_INDIRECT:
+			/* ld.d rd,sp,si12 */
+			if (op->src.reg == CFI_SP &&
+			    op->src.offset == (regs[op->dest.reg].offset + cfi->stack_size)) {
+				restore_reg(cfi, op->dest.reg);
+				/* GCC may not restore sp, we adjust it directly. */
+				if (cfa->base == CFI_FP && cfa->offset == 0) {
+					cfa->base = CFI_SP;
+					cfa->offset = cfi->stack_size;
+				}
+			}
+			break;
+		default:
+			break;
+		}
+		break;
+	case OP_DEST_REG_INDIRECT:
+		if (op->src.type == OP_SRC_REG)
+			/* st.d rd,sp,si12 */
+			if (op->dest.offset)
+				save_reg(cfi, op->src.reg, CFI_CFA,
+					 op->dest.offset - cfi->stack_size);
+		break;
+	default:
+		WARN_FUNC("unknown stack-related instruction", insn->sec, insn->offset);
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/tools/objtool/arch/loongarch/orc.c b/tools/objtool/arch/loongarch/orc.c
new file mode 100644
index 0000000..f59ab10
--- /dev/null
+++ b/tools/objtool/arch/loongarch/orc.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/objtool_types.h>
+#include <asm/orc_types.h>
+
+#include <objtool/check.h>
+#include <objtool/orc.h>
+#include <objtool/warn.h>
+#include <objtool/endianness.h>
+
+int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi, struct instruction *insn)
+{
+	struct cfi_reg *bp = &cfi->regs[CFI_BP];
+	struct cfi_reg *ra = &cfi->regs[CFI_RA];
+
+	memset(orc, 0, sizeof(*orc));
+
+	if (!cfi) {
+		/*
+		 * This is usually either unreachable nops/traps (which don't
+		 * trigger unreachable instruction warnings), or
+		 * STACK_FRAME_NON_STANDARD functions.
+		 */
+		orc->type = ORC_TYPE_UNDEFINED;
+		return 0;
+	}
+
+	switch (cfi->type) {
+	case UNWIND_HINT_TYPE_UNDEFINED:
+		orc->type = ORC_TYPE_UNDEFINED;
+		return 0;
+	case UNWIND_HINT_TYPE_END_OF_STACK:
+		orc->type = ORC_TYPE_END_OF_STACK;
+		return 0;
+	case UNWIND_HINT_TYPE_CALL:
+		orc->type = ORC_TYPE_CALL;
+		break;
+	case UNWIND_HINT_TYPE_REGS:
+		orc->type = ORC_TYPE_REGS;
+		break;
+	case UNWIND_HINT_TYPE_REGS_PARTIAL:
+		orc->type = ORC_TYPE_REGS_PARTIAL;
+		break;
+	default:
+		WARN_INSN(insn, "unknown unwind hint type %d", cfi->type);
+		return -1;
+	}
+
+	orc->signal = cfi->signal;
+
+	switch (cfi->cfa.base) {
+	case CFI_SP:
+		orc->sp_reg = ORC_REG_SP;
+		break;
+	case CFI_BP:
+		orc->sp_reg = ORC_REG_BP;
+		break;
+	default:
+		WARN_INSN(insn, "unknown CFA base reg %d", cfi->cfa.base);
+		return -1;
+	}
+
+	switch (bp->base) {
+	case CFI_UNDEFINED:
+		orc->bp_reg = ORC_REG_UNDEFINED;
+		break;
+	case CFI_CFA:
+		orc->bp_reg = ORC_REG_PREV_SP;
+		break;
+	case CFI_BP:
+		orc->bp_reg = ORC_REG_BP;
+		break;
+	default:
+		WARN_INSN(insn, "unknown BP base reg %d", bp->base);
+		return -1;
+	}
+
+	switch (ra->base) {
+	case CFI_UNDEFINED:
+		orc->ra_reg = ORC_REG_UNDEFINED;
+		break;
+	case CFI_CFA:
+		orc->ra_reg = ORC_REG_PREV_SP;
+		break;
+	case CFI_BP:
+		orc->ra_reg = ORC_REG_BP;
+		break;
+	default:
+		WARN_INSN(insn, "unknown RA base reg %d", ra->base);
+		return -1;
+	}
+
+	orc->sp_offset = cfi->cfa.offset;
+	orc->bp_offset = bp->offset;
+	orc->ra_offset = ra->offset;
+
+	return 0;
+}
+
+static const char *reg_name(unsigned int reg)
+{
+	switch (reg) {
+	case ORC_REG_SP:
+		return "sp";
+	case ORC_REG_BP:
+		return "fp";
+	case ORC_REG_PREV_SP:
+		return "prevsp";
+	default:
+		return "?";
+	}
+}
+
+static const char *orc_type_name(unsigned int type)
+{
+	switch (type) {
+	case UNWIND_HINT_TYPE_CALL:
+		return "call";
+	case UNWIND_HINT_TYPE_REGS:
+		return "regs";
+	case UNWIND_HINT_TYPE_REGS_PARTIAL:
+		return "regs (partial)";
+	default:
+		return "?";
+	}
+}
+
+static void print_reg(unsigned int reg, int offset)
+{
+	if (reg == ORC_REG_UNDEFINED)
+		printf(" (und) ");
+	else
+		printf("%s + %3d", reg_name(reg), offset);
+
+}
+
+void orc_print_dump(struct elf *dummy_elf, struct orc_entry *orc, int i)
+{
+	printf("type:%s", orc_type_name(orc[i].type));
+
+	printf(" sp:");
+
+	print_reg(orc[i].sp_reg, bswap_if_needed(dummy_elf, orc[i].sp_offset));
+
+	printf(" bp:");
+
+	print_reg(orc[i].bp_reg, bswap_if_needed(dummy_elf, orc[i].bp_offset));
+
+	printf(" ra:");
+
+	print_reg(orc[i].ra_reg, bswap_if_needed(dummy_elf, orc[i].ra_offset));
+
+	printf(" signal:%d\n", orc[i].signal);
+}
+
+void arch_write_orc(struct elf *elf, struct orc_entry *orc)
+{
+	orc->ra_offset = bswap_if_needed(elf, orc->ra_offset);
+}
diff --git a/tools/objtool/include/objtool/orc.h b/tools/objtool/include/objtool/orc.h
index 4c9f946..85ce2bf 100644
--- a/tools/objtool/include/objtool/orc.h
+++ b/tools/objtool/include/objtool/orc.h
@@ -6,5 +6,6 @@
 
 int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi, struct instruction *insn);
 void orc_print_dump(struct elf *dummy_elf, struct orc_entry *orc, int i);
+void arch_write_orc(struct elf *elf, struct orc_entry *orc);
 
 #endif /* _OBJTOOL_ORC_H */
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 1eff7e0a..6975056 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -14,6 +14,8 @@
 #include <objtool/warn.h>
 #include <objtool/endianness.h>
 
+void __weak arch_write_orc(struct elf *elf, struct orc_entry *orc) {}
+
 static int write_orc_entry(struct elf *elf, struct section *orc_sec,
 			   struct section *ip_sec, unsigned int idx,
 			   struct section *insn_sec, unsigned long insn_off,
@@ -26,6 +28,7 @@ static int write_orc_entry(struct elf *elf, struct section *orc_sec,
 	memcpy(orc, o, sizeof(*orc));
 	orc->sp_offset = bswap_if_needed(elf, orc->sp_offset);
 	orc->bp_offset = bswap_if_needed(elf, orc->bp_offset);
+	arch_write_orc(elf, orc);
 
 	/* populate reloc for ip */
 	if (!elf_init_reloc_text_sym(elf, ip_sec, idx * sizeof(int), idx,
-- 
2.1.0

