Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAC97FD782
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjK2NHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjK2NHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:07:02 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C78D10E0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:07:07 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxFeh5N2dlYqc9AA--.64236S3;
        Wed, 29 Nov 2023 21:07:05 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axzy91N2dlVtNPAA--.45987S4;
        Wed, 29 Nov 2023 21:07:05 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/8] objtool/LoongArch: Implement instruction decoder
Date:   Wed, 29 Nov 2023 21:06:55 +0800
Message-ID: <20231129130701.27744-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129130701.27744-1-yangtiezhu@loongson.cn>
References: <20231129130701.27744-1-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axzy91N2dlVtNPAA--.45987S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoWfJFykXw18AF1DKw4DZr4DZFc_yoW8Gr48Ko
        W8ta4DK34rJr4Uua1UJrn7JF47Zr109rW5Z34SvrsYyF4UZw15WrZFkw43W3Wa9w48JrZr
        Gayj9FykAa17XF1fl-sFpf9Il3svdjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf
        9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
        UjIYCTnIWjp_UUUYy7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
        8IcIk0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
        Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
        v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
        xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
        0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
        xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
        IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
        xhVjvjDU0xZFpf9x07jrPEfUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only copy the minimal definitions of instruction opcodes and formats
in inst.h from arch/loongarch to tools/arch/loongarch, and also copy
the definition of sign_extend64() to tools/include/linux/bitops.h to
decode the following kinds of instructions:

(1) stack pointer related instructions
addi.d, ld.d, st.d, ldptr.d and stptr.d

(2) branch and jump related instructions
beq, bne, blt, bge, bltu, bgeu, beqz, bnez, bceqz, bcnez, b, bl and jirl

(3) other instructions
break, nop and ertn

See more info about instructions in LoongArch Reference Manual:
https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html

Co-developed-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Co-developed-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/arch/loongarch/include/asm/inst.h | 161 ++++++++++++++
 tools/include/linux/bitops.h            |  11 +
 tools/objtool/arch/loongarch/decode.c   | 273 +++++++++++++++++++++++-
 3 files changed, 443 insertions(+), 2 deletions(-)
 create mode 100644 tools/arch/loongarch/include/asm/inst.h

diff --git a/tools/arch/loongarch/include/asm/inst.h b/tools/arch/loongarch/include/asm/inst.h
new file mode 100644
index 000000000000..c25b5853181d
--- /dev/null
+++ b/tools/arch/loongarch/include/asm/inst.h
@@ -0,0 +1,161 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_INST_H
+#define _ASM_INST_H
+
+#include <linux/bitops.h>
+
+#define LOONGARCH_INSN_NOP		0x03400000
+
+enum reg0i15_op {
+	break_op	= 0x54,
+};
+
+enum reg0i26_op {
+	b_op		= 0x14,
+	bl_op		= 0x15,
+};
+
+enum reg1i21_op {
+	beqz_op		= 0x10,
+	bnez_op		= 0x11,
+	bceqz_op	= 0x12, /* bits[9:8] = 0x00 */
+	bcnez_op	= 0x12, /* bits[9:8] = 0x01 */
+};
+
+enum reg2_op {
+	ertn_op		= 0x1920e,
+};
+
+enum reg2i12_op {
+	addid_op	= 0x0b,
+	andi_op		= 0x0d,
+	ldd_op		= 0xa3,
+	std_op		= 0xa7,
+};
+
+enum reg2i14_op {
+	ldptrd_op	= 0x26,
+	stptrd_op	= 0x27,
+};
+
+enum reg2i16_op {
+	jirl_op		= 0x13,
+	beq_op		= 0x16,
+	bne_op		= 0x17,
+	blt_op		= 0x18,
+	bge_op		= 0x19,
+	bltu_op		= 0x1a,
+	bgeu_op		= 0x1b,
+};
+
+struct reg0i15_format {
+	unsigned int immediate : 15;
+	unsigned int opcode : 17;
+};
+
+struct reg0i26_format {
+	unsigned int immediate_h : 10;
+	unsigned int immediate_l : 16;
+	unsigned int opcode : 6;
+};
+
+struct reg1i21_format {
+	unsigned int immediate_h  : 5;
+	unsigned int rj : 5;
+	unsigned int immediate_l : 16;
+	unsigned int opcode : 6;
+};
+
+struct reg2_format {
+	unsigned int rd : 5;
+	unsigned int rj : 5;
+	unsigned int opcode : 22;
+};
+
+struct reg2i12_format {
+	unsigned int rd : 5;
+	unsigned int rj : 5;
+	unsigned int immediate : 12;
+	unsigned int opcode : 10;
+};
+
+struct reg2i14_format {
+	unsigned int rd : 5;
+	unsigned int rj : 5;
+	unsigned int immediate : 14;
+	unsigned int opcode : 8;
+};
+
+struct reg2i16_format {
+	unsigned int rd : 5;
+	unsigned int rj : 5;
+	unsigned int immediate : 16;
+	unsigned int opcode : 6;
+};
+
+union loongarch_instruction {
+	unsigned int word;
+	struct reg0i15_format	reg0i15_format;
+	struct reg0i26_format	reg0i26_format;
+	struct reg1i21_format	reg1i21_format;
+	struct reg2_format	reg2_format;
+	struct reg2i12_format	reg2i12_format;
+	struct reg2i14_format	reg2i14_format;
+	struct reg2i16_format	reg2i16_format;
+};
+
+#define LOONGARCH_INSN_SIZE	sizeof(union loongarch_instruction)
+
+enum loongarch_gpr {
+	LOONGARCH_GPR_ZERO = 0,
+	LOONGARCH_GPR_RA = 1,
+	LOONGARCH_GPR_TP = 2,
+	LOONGARCH_GPR_SP = 3,
+	LOONGARCH_GPR_A0 = 4,	/* Reused as V0 for return value */
+	LOONGARCH_GPR_A1,	/* Reused as V1 for return value */
+	LOONGARCH_GPR_A2,
+	LOONGARCH_GPR_A3,
+	LOONGARCH_GPR_A4,
+	LOONGARCH_GPR_A5,
+	LOONGARCH_GPR_A6,
+	LOONGARCH_GPR_A7,
+	LOONGARCH_GPR_T0 = 12,
+	LOONGARCH_GPR_T1,
+	LOONGARCH_GPR_T2,
+	LOONGARCH_GPR_T3,
+	LOONGARCH_GPR_T4,
+	LOONGARCH_GPR_T5,
+	LOONGARCH_GPR_T6,
+	LOONGARCH_GPR_T7,
+	LOONGARCH_GPR_T8,
+	LOONGARCH_GPR_FP = 22,
+	LOONGARCH_GPR_S0 = 23,
+	LOONGARCH_GPR_S1,
+	LOONGARCH_GPR_S2,
+	LOONGARCH_GPR_S3,
+	LOONGARCH_GPR_S4,
+	LOONGARCH_GPR_S5,
+	LOONGARCH_GPR_S6,
+	LOONGARCH_GPR_S7,
+	LOONGARCH_GPR_S8,
+	LOONGARCH_GPR_MAX
+};
+
+#define DEF_EMIT_REG2I16_FORMAT(NAME, OP)				\
+static inline void emit_##NAME(union loongarch_instruction *insn,	\
+			       enum loongarch_gpr rj,			\
+			       enum loongarch_gpr rd,			\
+			       int offset)				\
+{									\
+	insn->reg2i16_format.opcode = OP;				\
+	insn->reg2i16_format.immediate = offset;			\
+	insn->reg2i16_format.rj = rj;					\
+	insn->reg2i16_format.rd = rd;					\
+}
+
+DEF_EMIT_REG2I16_FORMAT(jirl, jirl_op)
+
+#endif /* _ASM_INST_H */
diff --git a/tools/include/linux/bitops.h b/tools/include/linux/bitops.h
index f18683b95ea6..7319f6ced108 100644
--- a/tools/include/linux/bitops.h
+++ b/tools/include/linux/bitops.h
@@ -87,4 +87,15 @@ static inline __u32 rol32(__u32 word, unsigned int shift)
 	return (word << shift) | (word >> ((-shift) & 31));
 }
 
+/**
+ * sign_extend64 - sign extend a 64-bit value using specified bit as sign-bit
+ * @value: value to sign extend
+ * @index: 0 based bit index (0<=index<64) to sign bit
+ */
+static __always_inline __s64 sign_extend64(__u64 value, int index)
+{
+	__u8 shift = 63 - index;
+	return (__s64)(value << shift) >> shift;
+}
+
 #endif
diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index cc74ba4e0f54..ff0b53144d12 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -1,6 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include <string.h>
 #include <objtool/check.h>
+#include <objtool/warn.h>
+#include <asm/inst.h>
+
+#ifndef EM_LOONGARCH
+#define EM_LOONGARCH	258
+#endif
 
 int arch_ftrace_match(char *name)
 {
@@ -39,21 +45,284 @@ int arch_decode_hint_reg(u8 sp_reg, int *base)
 	return 0;
 }
 
+static bool is_loongarch(const struct elf *elf)
+{
+	if (elf->ehdr.e_machine == EM_LOONGARCH)
+		return true;
+
+	WARN("unexpected ELF machine type %d", elf->ehdr.e_machine);
+	return false;
+}
+
+#define ADD_OP(op) \
+	if (!(op = calloc(1, sizeof(*op)))) \
+		return -1; \
+	else for (*ops_list = op, ops_list = &op->next; op; op = NULL)
+
+static bool decode_insn_reg0i26_fomat(union loongarch_instruction inst,
+				      struct instruction *insn)
+{
+	switch (inst.reg0i26_format.opcode) {
+	case b_op:
+		insn->type = INSN_JUMP_UNCONDITIONAL;
+		insn->immediate = sign_extend64(inst.reg0i26_format.immediate_h << 16 |
+						inst.reg0i26_format.immediate_l, 25);
+		break;
+	case bl_op:
+		insn->type = INSN_CALL;
+		insn->immediate = sign_extend64(inst.reg0i26_format.immediate_h << 16 |
+						inst.reg0i26_format.immediate_l, 25);
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+static bool decode_insn_reg1i21_fomat(union loongarch_instruction inst,
+				      struct instruction *insn)
+{
+	switch (inst.reg1i21_format.opcode) {
+	case beqz_op:
+	case bnez_op:
+	case bceqz_op:
+		insn->type = INSN_JUMP_CONDITIONAL;
+		insn->immediate = sign_extend64(inst.reg1i21_format.immediate_h << 16 |
+						inst.reg1i21_format.immediate_l, 20);
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+static bool decode_insn_reg2i12_fomat(union loongarch_instruction inst,
+				      struct instruction *insn,
+				      struct stack_op **ops_list,
+				      struct stack_op *op)
+{
+	switch (inst.reg2i12_format.opcode) {
+	case addid_op:
+		if ((inst.reg2i12_format.rd == CFI_SP) || (inst.reg2i12_format.rj == CFI_SP)) {
+			/* addi.d sp,sp,si12 or addi.d fp,sp,si12 */
+			insn->immediate = sign_extend64(inst.reg2i12_format.immediate, 11);
+			ADD_OP(op) {
+				op->src.type = OP_SRC_ADD;
+				op->src.reg = inst.reg2i12_format.rj;
+				op->src.offset = insn->immediate;
+				op->dest.type = OP_DEST_REG;
+				op->dest.reg = inst.reg2i12_format.rd;
+			}
+		}
+		break;
+	case ldd_op:
+		if (inst.reg2i12_format.rj == CFI_SP) {
+			/* ld.d rd,sp,si12 */
+			insn->immediate = sign_extend64(inst.reg2i12_format.immediate, 11);
+			ADD_OP(op) {
+				op->src.type = OP_SRC_REG_INDIRECT;
+				op->src.reg = CFI_SP;
+				op->src.offset = insn->immediate;
+				op->dest.type = OP_DEST_REG;
+				op->dest.reg = inst.reg2i12_format.rd;
+			}
+		}
+		break;
+	case std_op:
+		if (inst.reg2i12_format.rj == CFI_SP) {
+			/* st.d rd,sp,si12 */
+			insn->immediate = sign_extend64(inst.reg2i12_format.immediate, 11);
+			ADD_OP(op) {
+				op->src.type = OP_SRC_REG;
+				op->src.reg = inst.reg2i12_format.rd;
+				op->dest.type = OP_DEST_REG_INDIRECT;
+				op->dest.reg = CFI_SP;
+				op->dest.offset = insn->immediate;
+			}
+		}
+		break;
+	case andi_op:
+		if (inst.reg2i12_format.rd == 0 &&
+		    inst.reg2i12_format.rj == 0 &&
+		    inst.reg2i12_format.immediate == 0)
+			/* andi r0,r0,0 */
+			insn->type = INSN_NOP;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+static bool decode_insn_reg2i14_fomat(union loongarch_instruction inst,
+				      struct instruction *insn,
+				      struct stack_op **ops_list,
+				      struct stack_op *op)
+{
+	switch (inst.reg2i14_format.opcode) {
+	case ldptrd_op:
+		if (inst.reg2i14_format.rj == CFI_SP) {
+			/* ldptr.d rd,sp,si14 */
+			insn->immediate = sign_extend64(inst.reg2i14_format.immediate, 13);
+			ADD_OP(op) {
+				op->src.type = OP_SRC_REG_INDIRECT;
+				op->src.reg = CFI_SP;
+				op->src.offset = insn->immediate;
+				op->dest.type = OP_DEST_REG;
+				op->dest.reg = inst.reg2i14_format.rd;
+			}
+		}
+		break;
+	case stptrd_op:
+		if (inst.reg2i14_format.rj == CFI_SP) {
+			/* stptr.d ra,sp,0 */
+			if (inst.reg2i14_format.rd == LOONGARCH_GPR_RA &&
+			    inst.reg2i14_format.immediate == 0)
+				break;
+
+			/* stptr.d rd,sp,si14 */
+			insn->immediate = sign_extend64(inst.reg2i14_format.immediate, 13);
+			ADD_OP(op) {
+				op->src.type = OP_SRC_REG;
+				op->src.reg = inst.reg2i14_format.rd;
+				op->dest.type = OP_DEST_REG_INDIRECT;
+				op->dest.reg = CFI_SP;
+				op->dest.offset = insn->immediate;
+			}
+		}
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+static bool decode_insn_reg2i16_fomat(union loongarch_instruction inst,
+				      struct instruction *insn)
+{
+	switch (inst.reg2i16_format.opcode) {
+	case jirl_op:
+		if (inst.reg2i16_format.rd == 0 &&
+		    inst.reg2i16_format.rj == CFI_RA &&
+		    inst.reg2i16_format.immediate == 0) {
+			/* jirl r0,ra,0 */
+			insn->type = INSN_RETURN;
+		} else if (inst.reg2i16_format.rd == CFI_RA) {
+			/* jirl ra,rj,offs16 */
+			insn->type = INSN_CALL_DYNAMIC;
+		} else if (inst.reg2i16_format.rd == CFI_A0 &&
+			   inst.reg2i16_format.immediate == 0) {
+			/*
+			 * jirl a0,t0,0
+			 * this is a special case in loongarch_suspend_enter,
+			 * just treat it as a call instruction.
+			 */
+			insn->type = INSN_CALL_DYNAMIC;
+		} else if (inst.reg2i16_format.rd == 0 &&
+			   inst.reg2i16_format.immediate == 0) {
+			/* jirl r0,rj,0 */
+			insn->type = INSN_JUMP_DYNAMIC;
+		} else if (inst.reg2i16_format.rd == 0 &&
+			   inst.reg2i16_format.immediate != 0) {
+			/*
+			 * jirl r0,t0,12
+			 * this is a rare case in JUMP_VIRT_ADDR,
+			 * just ignore it due to it is harmless for tracing.
+			 */
+			break;
+		} else {
+			/* jirl rd,rj,offs16 */
+			insn->type = INSN_JUMP_UNCONDITIONAL;
+			insn->immediate = sign_extend64(inst.reg2i16_format.immediate, 15);
+		}
+		break;
+	case beq_op:
+	case bne_op:
+	case blt_op:
+	case bge_op:
+	case bltu_op:
+	case bgeu_op:
+		insn->type = INSN_JUMP_CONDITIONAL;
+		insn->immediate = sign_extend64(inst.reg2i16_format.immediate, 15);
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    struct instruction *insn)
 {
+	struct stack_op **ops_list = &insn->stack_ops;
+	const struct elf *elf = file->elf;
+	struct stack_op *op = NULL;
+	union loongarch_instruction inst;
+
+	if (!is_loongarch(elf))
+		return -1;
+
+	if (maxlen < LOONGARCH_INSN_SIZE)
+		return 0;
+
+	insn->len = LOONGARCH_INSN_SIZE;
+	insn->type = INSN_OTHER;
+	insn->immediate = 0;
+
+	inst = *(union loongarch_instruction *)(sec->data->d_buf + offset);
+
+	if (decode_insn_reg0i26_fomat(inst, insn))
+		return 0;
+	if (decode_insn_reg1i21_fomat(inst, insn))
+		return 0;
+	if (decode_insn_reg2i12_fomat(inst, insn, ops_list, op))
+		return 0;
+	if (decode_insn_reg2i14_fomat(inst, insn, ops_list, op))
+		return 0;
+	if (decode_insn_reg2i16_fomat(inst, insn))
+		return 0;
+
+	if (inst.word == 0)
+		insn->type = INSN_NOP;
+	else if (inst.reg0i15_format.opcode == break_op) {
+		/* break */
+		insn->type = INSN_BUG;
+	} else if (inst.reg2_format.opcode == ertn_op) {
+		/* ertn */
+		insn->type = INSN_RETURN;
+	}
+
 	return 0;
 }
 
 const char *arch_nop_insn(int len)
 {
-	return NULL;
+	static u32 nop;
+
+	if (len != LOONGARCH_INSN_SIZE)
+		WARN("invalid NOP size: %d\n", len);
+
+	nop = LOONGARCH_INSN_NOP;
+
+	return (const char *)&nop;
 }
 
 const char *arch_ret_insn(int len)
 {
-	return NULL;
+	static u32 ret;
+
+	if (len != LOONGARCH_INSN_SIZE)
+		WARN("invalid RET size: %d\n", len);
+
+	emit_jirl((union loongarch_instruction *)&ret, LOONGARCH_GPR_RA, LOONGARCH_GPR_ZERO, 0);
+
+	return (const char *)&ret;
 }
 
 void arch_initial_func_cfi_state(struct cfi_init_state *state)
-- 
2.42.0

