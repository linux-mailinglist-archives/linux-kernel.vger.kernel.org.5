Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779DF7EC9C8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjKORhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjKORhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:37:40 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC0BD55
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:35 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7788fb06997so459443785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700069854; x=1700674654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5OOH8+riyDmJDIWiL4csbYtTgdsMwlIshYQZoHixI8=;
        b=GTSFNzq5QDqxZwoeNU7Y2lzMYRwLxlmEMqFpDzWCYyjk2CK6dH25FS+Yu3Lpw99GHi
         fmnUXTaC5OI+W6YQA92fJQdLxE2Zw+ugXkaAThKDHy7zHWogYerr7blujD0q59qZ9FNC
         eQw+7el6A86CfiQFuMdh5/GwMPaVtx4ZKUnQALcRpn9EKrTDrhQzEl6roWLYMXv9Dg0q
         kTq88XaQFRnL/Q1Sizl4z/ANCqX+L5q0KWMM3GabBUEh1ShpUBIXxmTxc5ElpITcWLis
         wAi9y2QQKehx36kYrb0bTyXEH5hpBVuVUBbfk8d8pbl6AMNIoqWcJJQO8OBnALDG01+u
         PE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700069854; x=1700674654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5OOH8+riyDmJDIWiL4csbYtTgdsMwlIshYQZoHixI8=;
        b=unuW8RriadVAIgIYPKPjBDPplCN5a6MDXn3I/qRTxg62Nsr+He1wpYLAcCgIaNeJIU
         OU1xPaDQjk22uPh59clVfP4Iycuss2lkksxYH8e3HXAHVP1kACk3x+bF/rVQyYX2YR3w
         L5EOWwT4EU5BlDqqEcov1FOMkTE60VY0XtH2Bp8ITIbqDIpSVUuPAEbHv37NV8tFZCVM
         DjZJDltz5A4NbD8G5shp8YboyWuzW0B7wEk7lTZKNdpGNrMtUE0GUuqQISCcLdXZhjLk
         Z/+OKUrHVzXlGtTl+3v5tv6XsW0YpAkrbPu0BrPFcSvMVvlm3NoBFSGeKqEpeYds55DR
         TVcg==
X-Gm-Message-State: AOJu0Yy6o1vZUwYcFOwAiUFTkRZg67tqxuGITjjAO2hHptFHS1m1T2Cu
        pKROyIQk9oP9tpt2sLTXHA2Dztte1Q==
X-Google-Smtp-Source: AGHT+IG0MuLZhLGHGwLKyltKxNLdgSLExQLasiB5NLof/2T0xpB1+r3+UKeHDCxFOXH+CbDO9huZgQ==
X-Received: by 2002:a05:620a:20d5:b0:778:8b53:cda2 with SMTP id f21-20020a05620a20d500b007788b53cda2mr6267023qka.23.1700069853706;
        Wed, 15 Nov 2023 09:37:33 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b0077bda014d8esm3260099qkg.87.2023.11.15.09.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:37:33 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>, David.Laight@aculab.com,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 07/14] objtool: Convert fixed location stack protector accesses
Date:   Wed, 15 Nov 2023 12:37:01 -0500
Message-ID: <20231115173708.108316-8-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115173708.108316-1-brgerst@gmail.com>
References: <20231115173708.108316-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older versions of GCC fixed the location of the stack protector canary
at %gs:40.  Use objtool to convert these accesses to normal percpu
accesses to __stack_chk_guard.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/Kconfig                        |  4 ++
 scripts/Makefile.lib                    |  2 +
 tools/objtool/arch/x86/decode.c         | 46 +++++++++++++
 tools/objtool/arch/x86/special.c        | 88 +++++++++++++++++++++++++
 tools/objtool/builtin-check.c           |  9 ++-
 tools/objtool/check.c                   | 12 ++++
 tools/objtool/elf.c                     | 34 ++++++++--
 tools/objtool/include/objtool/arch.h    |  3 +
 tools/objtool/include/objtool/builtin.h |  2 +
 tools/objtool/include/objtool/elf.h     |  6 ++
 10 files changed, 201 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a1d2f7fe42bb..6cee46127fd2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -416,6 +416,10 @@ config CC_HAS_SANE_STACKPROTECTOR
 	  We have to make sure stack protector is unconditionally disabled if
 	  the compiler does not allow control of the segment and symbol.
 
+config STACKPROTECTOR_OBJTOOL
+	bool
+	default n
+
 menu "Processor type and features"
 
 config SMP
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 68d0134bdbf9..a15dc76c19d0 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -255,6 +255,8 @@ objtool := $(objtree)/tools/objtool/objtool
 objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HACK)		+= --hacks=jump_label
 objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+= --hacks=noinstr
 objtool-args-$(CONFIG_CALL_DEPTH_TRACKING)		+= --hacks=skylake
+objtool-args-$(CONFIG_STACKPROTECTOR_OBJTOOL)		+= --hacks=stackprotector
+objtool-args-$(CONFIG_SMP)				+= --smp
 objtool-args-$(CONFIG_X86_KERNEL_IBT)			+= --ibt
 objtool-args-$(CONFIG_FINEIBT)				+= --cfi
 objtool-args-$(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL)	+= --mcount
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index e327cd827135..53f3d7323259 100644
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
index 29e949579ede..47c17452c899 100644
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
@@ -137,3 +140,88 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 
 	return rodata_reloc;
 }
+
+/*
+ * Convert op %gs:0x28, reg -> op __stack_chk_guard(%rip), %reg
+ * op is mov, sub, or cmp.
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
+		if (!sec->rsec) {
+			idx = 0;
+			rsec = sec->rsec = elf_create_rela_section(file->elf, sec, count);
+		} else {
+			idx = sec_num_entries(rsec);
+			if (elf_extend_rela_section(file->elf, rsec, count))
+				return -1;
+		}
+
+		sec_for_each_insn(file, sec, insn) {
+			unsigned char *data = insn->sec->data->d_buf + insn->offset;
+
+			if (insn->type != INSN_STACKPROTECTOR)
+				continue;
+
+			if (insn->len != 9)
+				goto invalid;
+
+			/* Remove GS prefix if !SMP */
+			if (data[0] != 0x65)
+				goto invalid;
+			if (!opts.smp)
+				data[0] = 0x90;
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
+			mark_sec_changed(file->elf, insn->sec, true);
+
+			if (!elf_init_reloc_data_sym(file->elf, insn->sec, insn->offset + 4, idx++, __stack_chk_guard, -4))
+				return -1;
+
+			continue;
+
+invalid:
+			fprintf(stderr, "Invalid stackprotector instruction at %s+0x%lx: ", insn->sec->name, insn->offset);
+			for (i = 0; i < insn->len; i++)
+				fprintf(stderr, "%02x ", data[i]);
+			fprintf(stderr, "\n");
+			return -1;
+		}
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
index ac304140c395..57f080ca0195 100644
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
@@ -4812,6 +4817,13 @@ int check(struct objtool_file *file)
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
2.41.0

