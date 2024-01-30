Return-Path: <linux-kernel+bounces-43978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE44841BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02F91C235D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B86C38F86;
	Tue, 30 Jan 2024 06:17:40 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24C2381DD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706595459; cv=none; b=s9UvT1+ieC+SiSql6a/9v9U/f6oR5lwM2dyqAgjuaAn6Zqr0uWAmpmw5vo3Vikw2Fuxio/11fuF3PxUHtRBgyrywhI8sAKkdRgYh1rEOxD/8nzuwZNBEKmNiNwNzoJ42mzQBUK56ziYld+3IGLt9hGBBHCdp7hkzCmvsl87+MpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706595459; c=relaxed/simple;
	bh=Lj6//V08ocZ6XNHAO5n5KvArX2s79k8uQsKwidn1svo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsvkiSefyQZHtKo+M5gc655R3BiOGNZ0hQqK/36GDeXCGFL6dZoNXwXCdg7JI/V0JHM2a1JuqJOdfVorcfHcPP3iBM7Puob3jjhilolvSA/A5Kbis4ueRxWgxFDOiWiv/n6zFTRuWPkbIyvtNlpvsi4+IzfXvNwBa6WqlWB8/ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxOOh_lLhlAjYIAA--.5763S3;
	Tue, 30 Jan 2024 14:17:35 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnhN7lLhlYXQnAA--.34034S4;
	Tue, 30 Jan 2024 14:17:34 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/8] objtool/LoongArch: Implement instruction decoder
Date: Tue, 30 Jan 2024 14:17:24 +0800
Message-ID: <20240130061730.21118-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240130061730.21118-1-yangtiezhu@loongson.cn>
References: <20240130061730.21118-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxnhN7lLhlYXQnAA--.34034S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoWfJFykXw18AF1DKw4DZr4DZFc_yoW8Gr48Ko
	W8ta4DK34rJr4Uua1UJrn7JF47Zr109rW5Z34SvrsYyF4UZw15WrZFkw43W3Wa9w48JrZr
	Gayj9FykAa17XF1fl-sFpf9Il3svdjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrneAqx4xG64xvF2IEw4CE5I8CrVC2j2WlIxkvb40E47kJYxn0WfASr-VF
	AUDa7-sFnT9fnUUIcSsGvfJTRUUUbTxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I
	8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEnc
	xIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYY7kG6xAYrwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUYVKZJUUUUU==

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


