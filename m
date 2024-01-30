Return-Path: <linux-kernel+bounces-43982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED57841BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F031E1F25504
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E645E524B1;
	Tue, 30 Jan 2024 06:17:41 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887D8381D9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706595460; cv=none; b=qSIduCHhMqDTrJv4yIc/xJyfMYIu1541hkqYLCVgD1FezuKrN/OoeRr4tQD0Zu+HoiPikHS3J5r7AHY/hjBaQMISs6A7O3EgKraVlfP2WObMIBTFksJLiHfi3cBHqfTnHvp1Jw3vgY0MRaPUBvJln2JmlBQTJqXbfcgFIrTrfBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706595460; c=relaxed/simple;
	bh=SkvP0SnD0f1lqdGL3eDU+agqYJLN5ukwCqdvfr0Rmv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBkVZzLhaghInw5c7+K+KSqo61v5G7ANw+suPQqgDtoZ+f+5nzZtLxkHpzMXnvwXit7Ev8ipkJuRqMNZEXLjZ6rX628aDm+2bf79bpuC6Gfn0+hXHdSIorttv6VQ9J2xUSRpZWo/bQFTs/bh3Q67gBN5GU4GcS1/kM00eTLQ2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxG+l_lLhlATYIAA--.6743S3;
	Tue, 30 Jan 2024 14:17:35 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnhN7lLhlYXQnAA--.34034S3;
	Tue, 30 Jan 2024 14:17:32 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/8] objtool/LoongArch: Enable objtool to be built
Date: Tue, 30 Jan 2024 14:17:23 +0800
Message-ID: <20240130061730.21118-2-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:AQAAf8BxnhN7lLhlYXQnAA--.34034S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtr47ur1kJF13ZF1rAw1fuFX_yoWxZw15pF
	4Du3sxGF48WFyfuw1xt3W5WrW3Jan7WryIqFy2qry8ZFZrX3s7tr4Skr4DAFy8Xws5KFyx
	XFnag3WjvFsFyabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ36c02F40EFcxC0VAKzVAqx4xG6I80ewCIccxYrVCFb4Uv73VFW2AGmfu7
	bjvjm3AaLaJ3UjIYCTnIWjp_UUUYl7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4
	CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUZVWUtwA2ocxC64kIII0Yj41l84x0
	c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2
	IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2
	jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2
	xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCF
	I7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkvb40E47kJMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgNeODUUUU

Add the minimal changes to enable objtool build on LoongArch,
most of the functions are stubs to only fix the build errors
when make -C tools/objtool.

This is similar with commit e52ec98c5ab1 ("objtool/powerpc:
Enable objtool to be built on ppc").

Co-developed-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Co-developed-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/arch/loongarch/Build            |  2 +
 tools/objtool/arch/loongarch/decode.c         | 71 +++++++++++++++++++
 .../arch/loongarch/include/arch/cfi_regs.h    | 22 ++++++
 .../objtool/arch/loongarch/include/arch/elf.h | 30 ++++++++
 .../arch/loongarch/include/arch/special.h     | 33 +++++++++
 tools/objtool/arch/loongarch/special.c        | 15 ++++
 6 files changed, 173 insertions(+)
 create mode 100644 tools/objtool/arch/loongarch/Build
 create mode 100644 tools/objtool/arch/loongarch/decode.c
 create mode 100644 tools/objtool/arch/loongarch/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/loongarch/include/arch/elf.h
 create mode 100644 tools/objtool/arch/loongarch/include/arch/special.h
 create mode 100644 tools/objtool/arch/loongarch/special.c

diff --git a/tools/objtool/arch/loongarch/Build b/tools/objtool/arch/loongarch/Build
new file mode 100644
index 000000000000..d24d5636a5b8
--- /dev/null
+++ b/tools/objtool/arch/loongarch/Build
@@ -0,0 +1,2 @@
+objtool-y += decode.o
+objtool-y += special.o
diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
new file mode 100644
index 000000000000..cc74ba4e0f54
--- /dev/null
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <string.h>
+#include <objtool/check.h>
+
+int arch_ftrace_match(char *name)
+{
+	return !strcmp(name, "_mcount");
+}
+
+unsigned long arch_jump_destination(struct instruction *insn)
+{
+	return insn->offset + (insn->immediate << 2);
+}
+
+unsigned long arch_dest_reloc_offset(int addend)
+{
+	return addend;
+}
+
+bool arch_pc_relative_reloc(struct reloc *reloc)
+{
+	return false;
+}
+
+bool arch_callee_saved_reg(unsigned char reg)
+{
+	switch (reg) {
+	case CFI_RA:
+	case CFI_FP:
+	case CFI_S0 ... CFI_S8:
+		return true;
+	default:
+		return false;
+	}
+}
+
+int arch_decode_hint_reg(u8 sp_reg, int *base)
+{
+	return 0;
+}
+
+int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
+			    unsigned long offset, unsigned int maxlen,
+			    struct instruction *insn)
+{
+	return 0;
+}
+
+const char *arch_nop_insn(int len)
+{
+	return NULL;
+}
+
+const char *arch_ret_insn(int len)
+{
+	return NULL;
+}
+
+void arch_initial_func_cfi_state(struct cfi_init_state *state)
+{
+	int i;
+
+	for (i = 0; i < CFI_NUM_REGS; i++) {
+		state->regs[i].base = CFI_UNDEFINED;
+		state->regs[i].offset = 0;
+	}
+
+	/* initial CFA (call frame address) */
+	state->cfa.base = CFI_SP;
+	state->cfa.offset = 0;
+}
diff --git a/tools/objtool/arch/loongarch/include/arch/cfi_regs.h b/tools/objtool/arch/loongarch/include/arch/cfi_regs.h
new file mode 100644
index 000000000000..d183cc8f43bf
--- /dev/null
+++ b/tools/objtool/arch/loongarch/include/arch/cfi_regs.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _OBJTOOL_ARCH_CFI_REGS_H
+#define _OBJTOOL_ARCH_CFI_REGS_H
+
+#define CFI_RA		1
+#define CFI_SP		3
+#define CFI_A0		4
+#define CFI_FP		22
+#define CFI_S0		23
+#define CFI_S1		24
+#define CFI_S2		25
+#define CFI_S3		26
+#define CFI_S4		27
+#define CFI_S5		28
+#define CFI_S6		29
+#define CFI_S7		30
+#define CFI_S8		31
+#define CFI_NUM_REGS	32
+
+#define CFI_BP		CFI_FP
+
+#endif /* _OBJTOOL_ARCH_CFI_REGS_H */
diff --git a/tools/objtool/arch/loongarch/include/arch/elf.h b/tools/objtool/arch/loongarch/include/arch/elf.h
new file mode 100644
index 000000000000..9623d663220e
--- /dev/null
+++ b/tools/objtool/arch/loongarch/include/arch/elf.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _OBJTOOL_ARCH_ELF_H
+#define _OBJTOOL_ARCH_ELF_H
+
+/*
+ * See the following link for more info about ELF Relocation types:
+ * https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html#_relocations
+ */
+#ifndef R_LARCH_NONE
+#define R_LARCH_NONE		0
+#endif
+#ifndef R_LARCH_32
+#define R_LARCH_32		1
+#endif
+#ifndef R_LARCH_64
+#define R_LARCH_64		2
+#endif
+#ifndef R_LARCH_32_PCREL
+#define R_LARCH_32_PCREL	99
+#endif
+
+#define R_NONE			R_LARCH_NONE
+#define R_ABS32			R_LARCH_32
+#define R_ABS64			R_LARCH_64
+#define R_DATA32		R_LARCH_32_PCREL
+#define R_DATA64		R_LARCH_32_PCREL
+#define R_TEXT32		R_LARCH_32_PCREL
+#define R_TEXT64		R_LARCH_32_PCREL
+
+#endif /* _OBJTOOL_ARCH_ELF_H */
diff --git a/tools/objtool/arch/loongarch/include/arch/special.h b/tools/objtool/arch/loongarch/include/arch/special.h
new file mode 100644
index 000000000000..35fc979b550a
--- /dev/null
+++ b/tools/objtool/arch/loongarch/include/arch/special.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _OBJTOOL_ARCH_SPECIAL_H
+#define _OBJTOOL_ARCH_SPECIAL_H
+
+/*
+ * See more info about struct exception_table_entry
+ * in arch/loongarch/include/asm/extable.h
+ */
+#define EX_ENTRY_SIZE		12
+#define EX_ORIG_OFFSET		0
+#define EX_NEW_OFFSET		4
+
+/*
+ * See more info about struct jump_entry
+ * in include/linux/jump_label.h
+ */
+#define JUMP_ENTRY_SIZE		16
+#define JUMP_ORIG_OFFSET	0
+#define JUMP_NEW_OFFSET		4
+#define JUMP_KEY_OFFSET		8
+
+/*
+ * See more info about struct alt_instr
+ * in arch/loongarch/include/asm/alternative.h
+ */
+#define ALT_ENTRY_SIZE		12
+#define ALT_ORIG_OFFSET		0
+#define ALT_NEW_OFFSET		4
+#define ALT_FEATURE_OFFSET	8
+#define ALT_ORIG_LEN_OFFSET	10
+#define ALT_NEW_LEN_OFFSET	11
+
+#endif /* _OBJTOOL_ARCH_SPECIAL_H */
diff --git a/tools/objtool/arch/loongarch/special.c b/tools/objtool/arch/loongarch/special.c
new file mode 100644
index 000000000000..9bba1e9318e0
--- /dev/null
+++ b/tools/objtool/arch/loongarch/special.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <objtool/special.h>
+
+bool arch_support_alt_relocation(struct special_alt *special_alt,
+				 struct instruction *insn,
+				 struct reloc *reloc)
+{
+	return false;
+}
+
+struct reloc *arch_find_switch_table(struct objtool_file *file,
+				     struct instruction *insn)
+{
+	return NULL;
+}
-- 
2.42.0


