Return-Path: <linux-kernel+bounces-111816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0640588714D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B58B1C22239
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D886605BC;
	Fri, 22 Mar 2024 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH0SSv8w"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA312604BD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126378; cv=none; b=INLS4peyzxn8x3BTViWNj2XKj88PH1SbSZNYfAHZ45dp6oBVBrfw5x++qpW3BGJ77o08JsLS+wmC3dngszVYbZMgdZsclZN9OXLDvy2ihRhnkC6ZXW7oPjD5SjYcvpIvpdkmt+opJH0cN1+FjGVG/0VqrYnRWwG2M4REJLOmR44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126378; c=relaxed/simple;
	bh=VR1+nGqlR4FTm7oUOrp5UCygrbh+Wx8G/j58KZi1cVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDzoALDDEy84yH4xkeaxkg9JDDt5s/bkNyo6uQdYUTExYFjW/W3I/A6VDJQSsYDHuWWGSVCTagHcCXO25g2VtzV0RUgjlhijz/ztsce4qkFq92pQi/8kzEkHIrySjuWUSUUKxtsjLCiKM9JVVgjlbK7JmNQt6y5NQRtJLgLmSGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cH0SSv8w; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-789d0c90cadso153885085a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126375; x=1711731175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sroh3+iJ8M197CSoj2xHZgfa/yPhMhF/D1xZhTI7Hb4=;
        b=cH0SSv8w8KpxGH1GSDlKgpVyyjKUI3acZWO9cLYGWy5boWMOBxgE2ytR9Fw/i0JkSv
         9wY4KOJIgW5BlAhc0lFRT4KG/R8v7CAyROvXxsBnNrnuGXEAcuWFO1u7nCyajL6Dg6R8
         OQS7bIHcBuUtBlh5fBLPqXBkm1oVA4jZug14rGy2KXI53hWLst6fIAI8kYHP+QIVzdli
         H4kFvz/CXCbXyQLuUiNdLdcCM2N0yOOnwczUXwjj7zOVf6EYWXTf5wrBhKm0w/LvlddC
         qcR0cUM0gQggCZ3p9MMZmZMDQ7IMxVsDMRr+Imgu0nLJAnPCn9JglXTWm1dMax3+Hd9w
         bHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126375; x=1711731175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sroh3+iJ8M197CSoj2xHZgfa/yPhMhF/D1xZhTI7Hb4=;
        b=ZJgH9Jigdozq/B/uxrV8VtUezSNC9CxSBgNenbafPGr8sBXZIuhqqJLAtRKUaVnkI5
         fkstbi2OAJV7wCrCnhf7NHyAXmgALf+Hoik7P9RMhByD6+FOMGwG0N5VU5oHQdzRa0Vm
         4xQPz18kTpWhREW1pbn25cVj01qUNQjb5BBUqyVFJldEA2Mmil4AwaU/NqrAqnZ46XKI
         +DrDvRE4f695H4eKjHN4RiiOiOzI+Hg94qhtPu0C7qpit9xLqgJUYvC4O6//RM2NI3mm
         deENcSaqsuI1P664vJYEizIGkIqEmA9IkbpZscKu91gMhJLtJhAqfR4o+RYlnxCk/59Q
         0ISA==
X-Gm-Message-State: AOJu0YyyLDk9TueUYN90Qp++pEHoKIEUGgoHFAuVtpUzMEexVc+jg7GM
	at9DvMjKEIUqHkrt+YvFqTuYlLylWtyUiU4DVOKCI5uwAVq18T9x4uph+mU=
X-Google-Smtp-Source: AGHT+IEn9IgchdQoZDhoHK+WO7foFRm6sSI5hWXMZJzSFOTdr4X3oECgPHWN2HOx8u9kj0fskVbZ8Q==
X-Received: by 2002:a05:620a:1714:b0:789:f8b3:d89d with SMTP id az20-20020a05620a171400b00789f8b3d89dmr3227492qkb.46.1711126375446;
        Fri, 22 Mar 2024 09:52:55 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j1-20020a37ef01000000b00789e9bbf962sm894901qkk.133.2024.03.22.09.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:52:54 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	David.Laight@aculab.com,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 07/16] objtool: Convert fixed location stack protector accesses
Date: Fri, 22 Mar 2024 12:52:24 -0400
Message-ID: <20240322165233.71698-8-brgerst@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322165233.71698-1-brgerst@gmail.com>
References: <20240322165233.71698-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Older versions of GCC fixed the location of the stack protector canary
at %gs:40.  Use objtool to convert these accesses to normal percpu
accesses to __stack_chk_guard.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/Kconfig                        |  4 ++
 scripts/Makefile.lib                    |  2 +
 tools/objtool/arch/x86/decode.c         | 46 +++++++++++++
 tools/objtool/arch/x86/special.c        | 91 +++++++++++++++++++++++++
 tools/objtool/builtin-check.c           |  9 ++-
 tools/objtool/check.c                   | 12 ++++
 tools/objtool/elf.c                     | 34 +++++++--
 tools/objtool/include/objtool/arch.h    |  3 +
 tools/objtool/include/objtool/builtin.h |  2 +
 tools/objtool/include/objtool/elf.h     |  6 ++
 10 files changed, 204 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 88d72227e3cb..121cfb9ffc0e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -417,6 +417,10 @@ config CC_HAS_SANE_STACKPROTECTOR
 	  We have to make sure stack protector is unconditionally disabled if
 	  the compiler does not allow control of the segment and symbol.
 
+config STACKPROTECTOR_OBJTOOL
+	bool
+	default n
+
 menu "Processor type and features"
 
 config SMP
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1bd59b8db05f..6bc4c69a9e50 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -258,6 +258,8 @@ objtool := $(objtree)/tools/objtool/objtool
 objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HACK)		+= --hacks=jump_label
 objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+= --hacks=noinstr
 objtool-args-$(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)	+= --hacks=skylake
+objtool-args-$(CONFIG_STACKPROTECTOR_OBJTOOL)		+= --hacks=stackprotector
+objtool-args-$(CONFIG_SMP)				+= --smp
 objtool-args-$(CONFIG_X86_KERNEL_IBT)			+= --ibt
 objtool-args-$(CONFIG_FINEIBT)				+= --cfi
 objtool-args-$(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL)	+= --mcount
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 3a1d80a7878d..583a16b8bf47 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -144,6 +144,18 @@ static bool has_notrack_prefix(struct insn *insn)
 	return false;
 }
 
+static bool has_gs_prefix(struct insn *insn)
+{
+	int i;
+
+	for (i = 0; i < insn->prefixes.nbytes; i++) {
+		if (insn->prefixes.bytes[i] == 0x65)
+			return true;
+	}
+
+	return false;
+}
+
 int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    struct instruction *insn)
@@ -408,10 +420,44 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 
 		break;
 
+	case 0x2b:
+	case 0x3b:
+	case 0x39:
+		if (!rex_w)
+			break;
+
+		/* sub %gs:0x28, reg */
+		/* cmp %gs:0x28, reg */
+		/* cmp reg, %gs:0x28 */
+		if (has_gs_prefix(&ins) &&
+		    modrm_mod == 0 &&
+		    modrm_rm == 4 &&
+		    sib_index == 4 &&
+		    sib_base == 5 &&
+		    ins.displacement.value == 0x28)
+		{
+			insn->type = INSN_STACKPROTECTOR;
+			break;
+		}
+
+		break;
+
 	case 0x8b:
 		if (!rex_w)
 			break;
 
+		/* mov %gs:0x28, reg */
+		if (has_gs_prefix(&ins) &&
+		    modrm_mod == 0 &&
+		    modrm_rm == 4 &&
+		    sib_index == 4 &&
+		    sib_base == 5 &&
+		    ins.displacement.value == 0x28)
+		{
+			insn->type = INSN_STACKPROTECTOR;
+			break;
+		}
+
 		if (rm_is_mem(CFI_BP)) {
 
 			/* mov disp(%rbp), reg */
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 4134d27c696b..020b6040c487 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -3,6 +3,9 @@
 
 #include <objtool/special.h>
 #include <objtool/builtin.h>
+#include <objtool/warn.h>
+#include <objtool/check.h>
+#include <objtool/elf.h>
 
 #define X86_FEATURE_POPCNT (4 * 32 + 23)
 #define X86_FEATURE_SMAP   (9 * 32 + 20)
@@ -137,3 +140,91 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 
 	return rodata_reloc;
 }
+
+/*
+ * Convert op %gs:0x28, reg -> op __stack_chk_guard(%rip), reg
+ * op is MOV, SUB, or CMP.
+ *
+ * This can be removed when the minimum supported GCC version is raised
+ * to 8.1 or later.
+ */
+int arch_hack_stackprotector(struct objtool_file *file)
+{
+	struct section *sec;
+	struct symbol *__stack_chk_guard;
+	struct instruction *insn;
+
+	int i;
+
+	__stack_chk_guard = find_symbol_by_name(file->elf, "__stack_chk_guard");
+
+	for_each_sec(file, sec) {
+		int count = 0;
+		int idx;
+		struct section *rsec = sec->rsec;
+
+		sec_for_each_insn(file, sec, insn) {
+			if (insn->type == INSN_STACKPROTECTOR)
+				count++;
+		}
+
+		if (!count)
+			continue;
+
+		if (!__stack_chk_guard)
+			__stack_chk_guard = elf_create_undef_symbol(file->elf, "__stack_chk_guard");
+
+		if (!rsec) {
+			idx = 0;
+			rsec = sec->rsec = elf_create_rela_section(file->elf, sec, count);
+		} else {
+			idx = sec_num_entries(rsec);
+			if (elf_extend_rela_section(file->elf, rsec, count))
+				return -1;
+		}
+
+		sec_for_each_insn(file, sec, insn) {
+			unsigned char *data = sec->data->d_buf + insn->offset;
+
+			if (insn->type != INSN_STACKPROTECTOR)
+				continue;
+
+			if (insn->len != 9)
+				goto invalid;
+
+			/* Convert GS prefix to DS if !SMP */
+			if (data[0] != 0x65)
+				goto invalid;
+			if (!opts.smp)
+				data[0] = 0x3e;
+
+			/* Set Mod=00, R/M=101.  Preserve Reg */
+			data[3] = (data[3] & 0x38) | 5;
+
+			/* Displacement 0 */
+			data[4] = 0;
+			data[5] = 0;
+			data[6] = 0;
+			data[7] = 0;
+
+			/* Pad with NOP */
+			data[8] = 0x90;
+
+			if (!elf_init_reloc_data_sym(file->elf, sec, insn->offset + 4, idx++, __stack_chk_guard, -4))
+				return -1;
+
+			continue;
+
+invalid:
+			fprintf(stderr, "Invalid stackprotector instruction at %s+0x%lx: ", sec->name, insn->offset);
+			for (i = 0; i < insn->len; i++)
+				fprintf(stderr, "%02x ", data[i]);
+			fprintf(stderr, "\n");
+			return -1;
+		}
+
+		mark_sec_changed(file->elf, sec, true);
+	}
+
+	return 0;
+}
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 5e21cfb7661d..0ab2efb45c0e 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -62,12 +62,17 @@ static int parse_hacks(const struct option *opt, const char *str, int unset)
 		found = true;
 	}
 
+	if (!str || strstr(str, "stackprotector")) {
+		opts.hack_stackprotector = true;
+		found = true;
+	}
+
 	return found ? 0 : -1;
 }
 
 static const struct option check_options[] = {
 	OPT_GROUP("Actions:"),
-	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr,skylake", "patch toolchain bugs/limitations", parse_hacks),
+	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr,skylake,stackprotector", "patch toolchain bugs/limitations", parse_hacks),
 	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
 	OPT_BOOLEAN('m', "mcount", &opts.mcount, "annotate mcount/fentry calls for ftrace"),
 	OPT_BOOLEAN('n', "noinstr", &opts.noinstr, "validate noinstr rules"),
@@ -94,6 +99,7 @@ static const struct option check_options[] = {
 	OPT_BOOLEAN(0, "sec-address", &opts.sec_address, "print section addresses in warnings"),
 	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
 	OPT_BOOLEAN('v', "verbose", &opts.verbose, "verbose warnings"),
+	OPT_BOOLEAN(0, "smp", &opts.smp, "building an SMP kernel"),
 
 	OPT_END(),
 };
@@ -133,6 +139,7 @@ static bool opts_valid(void)
 {
 	if (opts.hack_jump_label	||
 	    opts.hack_noinstr		||
+	    opts.hack_stackprotector	||
 	    opts.ibt			||
 	    opts.mcount			||
 	    opts.noinstr		||
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0a2c161fc04d..0056dd99ff7f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1315,6 +1315,11 @@ __weak bool arch_is_embedded_insn(struct symbol *sym)
 	return false;
 }
 
+__weak int arch_hack_stackprotector(struct objtool_file *file)
+{
+	return 0;
+}
+
 static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn)
 {
 	struct reloc *reloc;
@@ -4824,6 +4829,13 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
+	if (opts.hack_stackprotector) {
+		ret = arch_hack_stackprotector(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
+	}
+
 	free_insns(file);
 
 	if (opts.verbose)
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index cfb970727c8a..2af99b2a054c 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -846,6 +846,32 @@ elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size)
 	return sym;
 }
 
+struct symbol *
+elf_create_undef_symbol(struct elf *elf, const char *sym_name)
+{
+	struct symbol *sym = calloc(1, sizeof(*sym));
+	char *name = strdup(sym_name);
+
+	if (!sym || !name) {
+		perror("malloc");
+		return NULL;
+	}
+
+	sym->name = name;
+	sym->sec = find_section_by_index(elf, 0);
+
+	sym->sym.st_name = elf_add_string(elf, NULL, name);
+	sym->sym.st_info = GELF_ST_INFO(STB_GLOBAL, STT_NOTYPE);
+	sym->sym.st_value = 0;
+	sym->sym.st_size = 0;
+
+	sym = __elf_create_symbol(elf, sym);
+	if (sym)
+		elf_add_symbol(elf, sym);
+
+	return sym;
+}
+
 static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 				    unsigned int reloc_idx,
 				    unsigned long offset, struct symbol *sym,
@@ -924,7 +950,7 @@ struct reloc *elf_init_reloc_data_sym(struct elf *elf, struct section *sec,
 				      struct symbol *sym,
 				      s64 addend)
 {
-	if (sym->sec && (sec->sh.sh_flags & SHF_EXECINSTR)) {
+	if (sym->sec && (sym->sec->sh.sh_flags & SHF_EXECINSTR)) {
 		WARN("bad call to %s() for text symbol %s",
 		     __func__, sym->name);
 		return NULL;
@@ -1196,9 +1222,9 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	return sec;
 }
 
-static struct section *elf_create_rela_section(struct elf *elf,
-					       struct section *sec,
-					       unsigned int reloc_nr)
+struct section *elf_create_rela_section(struct elf *elf,
+					struct section *sec,
+					unsigned int reloc_nr)
 {
 	struct section *rsec;
 	struct reloc_block *block;
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 0b303eba660e..c60fec88b3af 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -28,6 +28,7 @@ enum insn_type {
 	INSN_CLD,
 	INSN_TRAP,
 	INSN_ENDBR,
+	INSN_STACKPROTECTOR,
 	INSN_OTHER,
 };
 
@@ -96,4 +97,6 @@ int arch_rewrite_retpolines(struct objtool_file *file);
 
 bool arch_pc_relative_reloc(struct reloc *reloc);
 
+int arch_hack_stackprotector(struct objtool_file *file);
+
 #endif /* _ARCH_H */
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index fcca6662c8b4..5085d3135e6b 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -13,6 +13,7 @@ struct opts {
 	bool hack_jump_label;
 	bool hack_noinstr;
 	bool hack_skylake;
+	bool hack_stackprotector;
 	bool ibt;
 	bool mcount;
 	bool noinstr;
@@ -38,6 +39,7 @@ struct opts {
 	bool sec_address;
 	bool stats;
 	bool verbose;
+	bool smp;
 };
 
 extern struct opts opts;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 7851467f6878..b5eec9e4a65d 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -120,6 +120,10 @@ struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name,
 				   size_t entsize, unsigned int nr);
 
+struct section *elf_create_rela_section(struct elf *elf,
+					struct section *sec,
+					unsigned int reloc_nr);
+
 int elf_extend_rela_section(struct elf *elf,
 			    struct section *rsec,
 			    int add_relocs);
@@ -130,6 +134,8 @@ struct section *elf_create_section_pair(struct elf *elf, const char *name,
 
 struct symbol *elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size);
 
+struct symbol *elf_create_undef_symbol(struct elf *elf, const char *sym_name);
+
 struct reloc *elf_init_reloc_text_sym(struct elf *elf, struct section *sec,
 				      unsigned long offset,
 				      unsigned int reloc_idx,
-- 
2.44.0


