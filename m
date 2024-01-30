Return-Path: <linux-kernel+bounces-43979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D54841BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20211F25230
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9982138FA3;
	Tue, 30 Jan 2024 06:17:40 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846BD381D3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706595459; cv=none; b=tHxGN9zRU83Z8/+NcJEHQWme8n7247uJQkJPvL5tOF4HR2C9+igxvPud9bY1HtpYf3j4n8ZUJQ/FsboRJx5TzjEbD/TDFCQETtqz63lHXqAro1n6kflQs4SkFP4tC27D6xyVIWYk+qdHIG6xlBst5phcDu1EkafE66pH0Zo3TpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706595459; c=relaxed/simple;
	bh=l9YdMYya8Om/hzNwXmrsMGy2ztkrAIYOqDb/PKwRWx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjbXXSrU5uGq28cq2gkBrvcn1lnrTiUwnGTl2JDcSJOyzieRdzoXCWioQzqUvaQCSd1lq6M+ijdWhb1AxjPyAw8a5SQlvdEXa4YFVtCTWu1Y9HOyAkY0W2EssmyPBokYANbMdg3CpPt8uBB19G/97t3W4RSZth9acEzrw0Vjv44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxfeuAlLhlBjYIAA--.24940S3;
	Tue, 30 Jan 2024 14:17:36 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnhN7lLhlYXQnAA--.34034S5;
	Tue, 30 Jan 2024 14:17:35 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/8] objtool/x86: Separate arch-specific and generic parts
Date: Tue, 30 Jan 2024 14:17:25 +0800
Message-ID: <20240130061730.21118-4-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:AQAAf8BxnhN7lLhlYXQnAA--.34034S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3uFW5Kw45AF1rGr47Xw4fWFX_yoWkuw15pF
	15CrWDGrWxXF13Gwn2gan7CrWYkws7Gr1kArnxC340v3yIqw1rJFsIyryjvF98W393Way3
	ua90qFWFkanxAFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8EeHDUUUUU==

Move init_orc_entry(), write_orc_entry(), reg_name(), orc_type_name()
and print_reg() from generic orc_gen.c and orc_dump.c to arch-specific
orc.c, then introduce a new function orc_print_dump() to print info.

This is preparation for later patch, no functionality change.

Co-developed-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Co-developed-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/arch/x86/Build        |   1 +
 tools/objtool/arch/x86/orc.c        | 188 ++++++++++++++++++++++++++++
 tools/objtool/include/objtool/orc.h |  14 +++
 tools/objtool/orc_dump.c            |  69 +---------
 tools/objtool/orc_gen.c             | 113 +----------------
 5 files changed, 206 insertions(+), 179 deletions(-)
 create mode 100644 tools/objtool/arch/x86/orc.c
 create mode 100644 tools/objtool/include/objtool/orc.h

diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
index 9f7869b5c5e0..3dedb2fd8f3a 100644
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
index 000000000000..b6cd943e87f9
--- /dev/null
+++ b/tools/objtool/arch/x86/orc.c
@@ -0,0 +1,188 @@
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
+int write_orc_entry(struct elf *elf, struct section *orc_sec,
+		    struct section *ip_sec, unsigned int idx,
+		    struct section *insn_sec, unsigned long insn_off,
+		    struct orc_entry *o)
+{
+	struct orc_entry *orc;
+
+	/* populate ORC data */
+	orc = (struct orc_entry *)orc_sec->data->d_buf + idx;
+	memcpy(orc, o, sizeof(*orc));
+	orc->sp_offset = bswap_if_needed(elf, orc->sp_offset);
+	orc->bp_offset = bswap_if_needed(elf, orc->bp_offset);
+
+	/* populate reloc for ip */
+	if (!elf_init_reloc_text_sym(elf, ip_sec, idx * sizeof(int), idx,
+				     insn_sec, insn_off))
+		return -1;
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
+	print_reg(orc[i].sp_reg, bswap_if_needed(dummy_elf, orc[i].sp_offset));
+
+	printf(" bp:");
+	print_reg(orc[i].bp_reg, bswap_if_needed(dummy_elf, orc[i].bp_offset));
+
+	printf(" signal:%d\n", orc[i].signal);
+}
diff --git a/tools/objtool/include/objtool/orc.h b/tools/objtool/include/objtool/orc.h
new file mode 100644
index 000000000000..15a32def1071
--- /dev/null
+++ b/tools/objtool/include/objtool/orc.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _OBJTOOL_ORC_H
+#define _OBJTOOL_ORC_H
+
+#include <objtool/check.h>
+
+int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi, struct instruction *insn);
+void orc_print_dump(struct elf *dummy_elf, struct orc_entry *orc, int i);
+int write_orc_entry(struct elf *elf, struct section *orc_sec,
+		    struct section *ip_sec, unsigned int idx,
+		    struct section *insn_sec, unsigned long insn_off,
+		    struct orc_entry *o);
+
+#endif /* _OBJTOOL_ORC_H */
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index 0e183bb1c720..a62247efb64f 100644
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
index bae343908867..922e6aac7cea 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -10,121 +10,10 @@
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
-static int write_orc_entry(struct elf *elf, struct section *orc_sec,
-			   struct section *ip_sec, unsigned int idx,
-			   struct section *insn_sec, unsigned long insn_off,
-			   struct orc_entry *o)
-{
-	struct orc_entry *orc;
-
-	/* populate ORC data */
-	orc = (struct orc_entry *)orc_sec->data->d_buf + idx;
-	memcpy(orc, o, sizeof(*orc));
-	orc->sp_offset = bswap_if_needed(elf, orc->sp_offset);
-	orc->bp_offset = bswap_if_needed(elf, orc->bp_offset);
-
-	/* populate reloc for ip */
-	if (!elf_init_reloc_text_sym(elf, ip_sec, idx * sizeof(int), idx,
-				     insn_sec, insn_off))
-		return -1;
-
-	return 0;
-}
-
 struct orc_list_entry {
 	struct list_head list;
 	struct orc_entry orc;
-- 
2.42.0


