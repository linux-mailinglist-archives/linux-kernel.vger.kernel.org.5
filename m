Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B083760CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjGYIPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjGYIPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:15:22 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3225BE76
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:15:18 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxXeuThL9k_6MJAA--.18675S3;
        Tue, 25 Jul 2023 16:15:15 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLCOOhL9kAFg6AA--.7611S5;
        Tue, 25 Jul 2023 16:15:14 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v1 3/6] objtool/x86: Separate arch-specific and generic parts
Date:   Tue, 25 Jul 2023 16:15:07 +0800
Message-Id: <1690272910-11869-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1690272910-11869-1-git-send-email-yangtiezhu@loongson.cn>
References: <1690272910-11869-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8CxLCOOhL9kAFg6AA--.7611S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3tryUJF4xGF1DXFWfWr4xZrc_yoW8JFWfto
        W3tFs5Jr48Ary7ZrWqyws2kF4rXa1vkr4UKa1jqFs8Ca4kC34UWr1Iva15Ja4aqrWFgrZ3
        AFWfX3yxXFs7Z3W8l-sFpf9Il3svdjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf
        9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
        UjIYCTnIWjp_UUUYC7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
        8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
        Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
        v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
        xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
        0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j2MKZUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move init_orc_entry(), reg_name(), orc_type_name() and print_reg() from
generic orc_gen.c and orc_dump.c to arch-specific orc.c, then introduce
a new function orc_print_dump() to print info.

Define update_cfi_state() as a weak function which may be overwritten
by the arch-specific implementation.

This is preparation for later patch, no functionality change.

Co-developed-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Co-developed-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/arch/x86/Build          |   1 +
 tools/objtool/arch/x86/orc.c          | 169 ++++++++++++++++++++++++++++++++++
 tools/objtool/check.c                 |  12 +--
 tools/objtool/include/objtool/check.h |   9 ++
 tools/objtool/include/objtool/orc.h   |  10 ++
 tools/objtool/orc_dump.c              |  69 +-------------
 tools/objtool/orc_gen.c               |  92 +-----------------
 7 files changed, 198 insertions(+), 164 deletions(-)
 create mode 100644 tools/objtool/arch/x86/orc.c
 create mode 100644 tools/objtool/include/objtool/orc.h

diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
index 9f7869b..3dedb2f 100644
--- a/tools/objtool/arch/x86/Build
+++ b/tools/objtool/arch/x86/Build
@@ -1,5 +1,6 @@
 objtool-y += special.o
 objtool-y += decode.o
+objtool-y += orc.o
 
 inat_tables_script = ../arch/x86/tools/gen-insn-attr-x86.awk
 inat_tables_maps = ../arch/x86/lib/x86-opcode-map.txt
diff --git a/tools/objtool/arch/x86/orc.c b/tools/objtool/arch/x86/orc.c
new file mode 100644
index 0000000..a4365b8
--- /dev/null
+++ b/tools/objtool/arch/x86/orc.c
@@ -0,0 +1,169 @@
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
+	case CFI_SP_INDIRECT:
+		orc->sp_reg = ORC_REG_SP_INDIRECT;
+		break;
+	case CFI_BP:
+		orc->sp_reg = ORC_REG_BP;
+		break;
+	case CFI_BP_INDIRECT:
+		orc->sp_reg = ORC_REG_BP_INDIRECT;
+		break;
+	case CFI_R10:
+		orc->sp_reg = ORC_REG_R10;
+		break;
+	case CFI_R13:
+		orc->sp_reg = ORC_REG_R13;
+		break;
+	case CFI_DI:
+		orc->sp_reg = ORC_REG_DI;
+		break;
+	case CFI_DX:
+		orc->sp_reg = ORC_REG_DX;
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
+	orc->sp_offset = cfi->cfa.offset;
+	orc->bp_offset = bp->offset;
+
+	return 0;
+}
+
+static const char *reg_name(unsigned int reg)
+{
+	switch (reg) {
+	case ORC_REG_PREV_SP:
+		return "prevsp";
+	case ORC_REG_DX:
+		return "dx";
+	case ORC_REG_DI:
+		return "di";
+	case ORC_REG_BP:
+		return "bp";
+	case ORC_REG_SP:
+		return "sp";
+	case ORC_REG_R10:
+		return "r10";
+	case ORC_REG_R13:
+		return "r13";
+	case ORC_REG_BP_INDIRECT:
+		return "bp(ind)";
+	case ORC_REG_SP_INDIRECT:
+		return "sp(ind)";
+	default:
+		return "?";
+	}
+}
+
+static const char *orc_type_name(unsigned int type)
+{
+	switch (type) {
+	case ORC_TYPE_UNDEFINED:
+		return "(und)";
+	case ORC_TYPE_END_OF_STACK:
+		return "end";
+	case ORC_TYPE_CALL:
+		return "call";
+	case ORC_TYPE_REGS:
+		return "regs";
+	case ORC_TYPE_REGS_PARTIAL:
+		return "regs (partial)";
+	default:
+		return "?";
+	}
+}
+
+static void print_reg(unsigned int reg, int offset)
+{
+	if (reg == ORC_REG_BP_INDIRECT)
+		printf("(bp%+d)", offset);
+	else if (reg == ORC_REG_SP_INDIRECT)
+		printf("(sp)%+d", offset);
+	else if (reg == ORC_REG_UNDEFINED)
+		printf("(und)");
+	else
+		printf("%s%+d", reg_name(reg), offset);
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
+	printf(" signal:%d\n", orc[i].signal);
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8936a05..9e5e462 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2685,9 +2685,9 @@ static bool has_valid_stack_frame(struct insn_state *state)
 	return false;
 }
 
-static int update_cfi_state_regs(struct instruction *insn,
-				  struct cfi_state *cfi,
-				  struct stack_op *op)
+int update_cfi_state_regs(struct instruction *insn,
+			  struct cfi_state *cfi,
+			  struct stack_op *op)
 {
 	struct cfi_reg *cfa = &cfi->cfa;
 
@@ -2710,7 +2710,7 @@ static int update_cfi_state_regs(struct instruction *insn,
 	return 0;
 }
 
-static void save_reg(struct cfi_state *cfi, unsigned char reg, int base, int offset)
+void save_reg(struct cfi_state *cfi, unsigned char reg, int base, int offset)
 {
 	if (arch_callee_saved_reg(reg) &&
 	    cfi->regs[reg].base == CFI_UNDEFINED) {
@@ -2719,7 +2719,7 @@ static void save_reg(struct cfi_state *cfi, unsigned char reg, int base, int off
 	}
 }
 
-static void restore_reg(struct cfi_state *cfi, unsigned char reg)
+void restore_reg(struct cfi_state *cfi, unsigned char reg)
 {
 	cfi->regs[reg].base = initial_func_cfi.regs[reg].base;
 	cfi->regs[reg].offset = initial_func_cfi.regs[reg].offset;
@@ -2778,7 +2778,7 @@ static void restore_reg(struct cfi_state *cfi, unsigned char reg)
  *   41 5d			pop    %r13
  *   c3				retq
  */
-static int update_cfi_state(struct instruction *insn,
+int __weak update_cfi_state(struct instruction *insn,
 			    struct instruction *next_insn,
 			    struct cfi_state *cfi, struct stack_op *op)
 {
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index daa46f1..620c9c0 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -121,4 +121,13 @@ struct instruction *next_insn_same_sec(struct objtool_file *file, struct instruc
 	     insn && insn->sec == _sec;					\
 	     insn = next_insn_same_sec(file, insn))
 
+int update_cfi_state_regs(struct instruction *insn,
+			  struct cfi_state *cfi,
+			  struct stack_op *op);
+void save_reg(struct cfi_state *cfi, unsigned char reg, int base, int offset);
+void restore_reg(struct cfi_state *cfi, unsigned char reg);
+int update_cfi_state(struct instruction *insn,
+		     struct instruction *next_insn,
+		     struct cfi_state *cfi, struct stack_op *op);
+
 #endif /* _CHECK_H */
diff --git a/tools/objtool/include/objtool/orc.h b/tools/objtool/include/objtool/orc.h
new file mode 100644
index 0000000..4c9f946
--- /dev/null
+++ b/tools/objtool/include/objtool/orc.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _OBJTOOL_ORC_H
+#define _OBJTOOL_ORC_H
+
+#include <objtool/check.h>
+
+int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi, struct instruction *insn);
+void orc_print_dump(struct elf *dummy_elf, struct orc_entry *orc, int i);
+
+#endif /* _OBJTOOL_ORC_H */
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index 0e183bb..a62247ef 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -6,65 +6,10 @@
 #include <unistd.h>
 #include <asm/orc_types.h>
 #include <objtool/objtool.h>
+#include <objtool/orc.h>
 #include <objtool/warn.h>
 #include <objtool/endianness.h>
 
-static const char *reg_name(unsigned int reg)
-{
-	switch (reg) {
-	case ORC_REG_PREV_SP:
-		return "prevsp";
-	case ORC_REG_DX:
-		return "dx";
-	case ORC_REG_DI:
-		return "di";
-	case ORC_REG_BP:
-		return "bp";
-	case ORC_REG_SP:
-		return "sp";
-	case ORC_REG_R10:
-		return "r10";
-	case ORC_REG_R13:
-		return "r13";
-	case ORC_REG_BP_INDIRECT:
-		return "bp(ind)";
-	case ORC_REG_SP_INDIRECT:
-		return "sp(ind)";
-	default:
-		return "?";
-	}
-}
-
-static const char *orc_type_name(unsigned int type)
-{
-	switch (type) {
-	case ORC_TYPE_UNDEFINED:
-		return "(und)";
-	case ORC_TYPE_END_OF_STACK:
-		return "end";
-	case ORC_TYPE_CALL:
-		return "call";
-	case ORC_TYPE_REGS:
-		return "regs";
-	case ORC_TYPE_REGS_PARTIAL:
-		return "regs (partial)";
-	default:
-		return "?";
-	}
-}
-
-static void print_reg(unsigned int reg, int offset)
-{
-	if (reg == ORC_REG_BP_INDIRECT)
-		printf("(bp%+d)", offset);
-	else if (reg == ORC_REG_SP_INDIRECT)
-		printf("(sp)%+d", offset);
-	else if (reg == ORC_REG_UNDEFINED)
-		printf("(und)");
-	else
-		printf("%s%+d", reg_name(reg), offset);
-}
-
 int orc_dump(const char *_objname)
 {
 	int fd, nr_entries, i, *orc_ip = NULL, orc_size = 0;
@@ -205,17 +150,7 @@ int orc_dump(const char *_objname)
 			printf("%llx:", (unsigned long long)(orc_ip_addr + (i * sizeof(int)) + orc_ip[i]));
 		}
 
-		printf("type:%s", orc_type_name(orc[i].type));
-
-		printf(" sp:");
-
-		print_reg(orc[i].sp_reg, bswap_if_needed(&dummy_elf, orc[i].sp_offset));
-
-		printf(" bp:");
-
-		print_reg(orc[i].bp_reg, bswap_if_needed(&dummy_elf, orc[i].bp_offset));
-
-		printf(" signal:%d\n", orc[i].signal);
+		orc_print_dump(&dummy_elf, orc, i);
 	}
 
 	elf_end(elf);
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index bae3439..1eff7e0a 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -10,100 +10,10 @@
 #include <asm/orc_types.h>
 
 #include <objtool/check.h>
+#include <objtool/orc.h>
 #include <objtool/warn.h>
 #include <objtool/endianness.h>
 
-static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi,
-			  struct instruction *insn)
-{
-	struct cfi_reg *bp = &cfi->regs[CFI_BP];
-
-	memset(orc, 0, sizeof(*orc));
-
-	if (!cfi) {
-		/*
-		 * This is usually either unreachable nops/traps (which don't
-		 * trigger unreachable instruction warnings), or
-		 * STACK_FRAME_NON_STANDARD functions.
-		 */
-		orc->type = ORC_TYPE_UNDEFINED;
-		return 0;
-	}
-
-	switch (cfi->type) {
-	case UNWIND_HINT_TYPE_UNDEFINED:
-		orc->type = ORC_TYPE_UNDEFINED;
-		return 0;
-	case UNWIND_HINT_TYPE_END_OF_STACK:
-		orc->type = ORC_TYPE_END_OF_STACK;
-		return 0;
-	case UNWIND_HINT_TYPE_CALL:
-		orc->type = ORC_TYPE_CALL;
-		break;
-	case UNWIND_HINT_TYPE_REGS:
-		orc->type = ORC_TYPE_REGS;
-		break;
-	case UNWIND_HINT_TYPE_REGS_PARTIAL:
-		orc->type = ORC_TYPE_REGS_PARTIAL;
-		break;
-	default:
-		WARN_INSN(insn, "unknown unwind hint type %d", cfi->type);
-		return -1;
-	}
-
-	orc->signal = cfi->signal;
-
-	switch (cfi->cfa.base) {
-	case CFI_SP:
-		orc->sp_reg = ORC_REG_SP;
-		break;
-	case CFI_SP_INDIRECT:
-		orc->sp_reg = ORC_REG_SP_INDIRECT;
-		break;
-	case CFI_BP:
-		orc->sp_reg = ORC_REG_BP;
-		break;
-	case CFI_BP_INDIRECT:
-		orc->sp_reg = ORC_REG_BP_INDIRECT;
-		break;
-	case CFI_R10:
-		orc->sp_reg = ORC_REG_R10;
-		break;
-	case CFI_R13:
-		orc->sp_reg = ORC_REG_R13;
-		break;
-	case CFI_DI:
-		orc->sp_reg = ORC_REG_DI;
-		break;
-	case CFI_DX:
-		orc->sp_reg = ORC_REG_DX;
-		break;
-	default:
-		WARN_INSN(insn, "unknown CFA base reg %d", cfi->cfa.base);
-		return -1;
-	}
-
-	switch (bp->base) {
-	case CFI_UNDEFINED:
-		orc->bp_reg = ORC_REG_UNDEFINED;
-		break;
-	case CFI_CFA:
-		orc->bp_reg = ORC_REG_PREV_SP;
-		break;
-	case CFI_BP:
-		orc->bp_reg = ORC_REG_BP;
-		break;
-	default:
-		WARN_INSN(insn, "unknown BP base reg %d", bp->base);
-		return -1;
-	}
-
-	orc->sp_offset = cfi->cfa.offset;
-	orc->bp_offset = bp->offset;
-
-	return 0;
-}
-
 static int write_orc_entry(struct elf *elf, struct section *orc_sec,
 			   struct section *ip_sec, unsigned int idx,
 			   struct section *insn_sec, unsigned long insn_off,
-- 
2.1.0

