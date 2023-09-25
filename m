Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25587AE086
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 22:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjIYU7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 16:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbjIYU7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 16:59:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77E8103
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 13:59:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d85fc108f0eso10275272276.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 13:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695675576; x=1696280376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MoZzNLwBFXZ6zs3u7oISPENUKQPc243bPRqXjWkDxms=;
        b=aiuA/KHaVz2P0SFxZCAbocXrMOEnUGhV6rg+YNdlmGO8kOiknYdGP2IB2j3MuaaeYC
         +RPxsAchEJi7qiptO5Y46XukkdmP5VrGL93cXC//qQ2IkOBxrqq5br7ZJ41hLLK27fLA
         QafM787weWBQmu1a3Nhk4/06UJO+i0YtAxyFLmZuBd9K2qJPXqQzx7TYdYxNlWbhhOJx
         iCNMgb0yGCrgFC1UpCn2iys1EWSayWRU3QgIb4LiDDMe6QhXKdkWtGcljKABMzkzfK+X
         +EY/1+VebH2D0qi4GVCKjX8pmzIiQiAEKHzz0HfALfQywpyeAId+LN9DkPnLUtmvhQcU
         wTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695675576; x=1696280376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MoZzNLwBFXZ6zs3u7oISPENUKQPc243bPRqXjWkDxms=;
        b=M+wxF5KDSLXHaY81nX4CgB+Tf6UUr9Ay0zUggTVMapvqo4+aQdSeozkA40mceT/v0l
         K6nKyNcW9ATNc5NTNE8jFnCNhAwLptLHcYKqZ4Do1xP3mL5hU6417ZwONdu9cpY0Dkx/
         xthFc5ht6b2dZ3pwYP1G6/4yTDMVAAdeXJlqhOOd+BAqXkgdU8fjrbbB0wLlQlL/WU6s
         dlZCaraAqG7ZbOtFhH2tbtZts6vaqWJgHhn75hFoOCzWoPo+/P77ubqCbXkUbyqnfyiN
         w0CZiHoIcHsnSAKzhNl5SUw2FbJcOerNQLmHESpChmhgaoRDyGBx+sSnzmPPQqDy9904
         aSHg==
X-Gm-Message-State: AOJu0YxFIn8HO9bvWaxG38KN2dRFDS2xs90Vf28RRj3dmjAPIROYi7zR
        mE+gKXqPy6FsHkPrHiChrsVYgK4sjaWvTA==
X-Google-Smtp-Source: AGHT+IHdrr6tSey1pmQ9IHmrjfquvimOCsUsp/iXLhTEaTToLfmFLDla8oEmmq54xm8c8sbrIyzx4O48+isiaw==
X-Received: from jbrennen.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:3c2a])
 (user=jbrennen job=sendgmr) by 2002:a25:e713:0:b0:d81:89e9:9f46 with SMTP id
 e19-20020a25e713000000b00d8189e99f46mr81683ybh.13.1695675576077; Mon, 25 Sep
 2023 13:59:36 -0700 (PDT)
Date:   Mon, 25 Sep 2023 16:59:33 -0400
In-Reply-To: <20230918210631.3882376-1-jbrennen@google.com>
Mime-Version: 1.0
References: <20230918210631.3882376-1-jbrennen@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230925205933.2869049-1-jbrennen@google.com>
Subject: [PATCH] modpost: Optimize symbol search from linear to binary search
From:   Jack Brennen <jbrennen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, maskray@google.com, cleger@rivosinc.com,
        kernel-team@android.com, Jack Brennen <jbrennen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify modpost to use binary search for converting addresses back
into symbol references.  Previously it used linear search.

This change saves a few seconds of wall time for defconfig builds,
but can save several minutes on allyesconfigs.

Before:
$ make LLVM=1 -j128 allyesconfig vmlinux -s KCFLAGS="-Wno-error"
$ time scripts/mod/modpost -M -m -a -N -o vmlinux.symvers vmlinux.o
198.38user 1.27system 3:19.71elapsed

After:
$ make LLVM=1 -j128 allyesconfig vmlinux -s KCFLAGS="-Wno-error"
$ time scripts/mod/modpost -M -m -a -N -o vmlinux.symvers vmlinux.o
12.02user 0.87system 0:12.91elapsed

Signed-off-by: Jack Brennen <jbrennen@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
---
 scripts/mod/Makefile    |   4 +-
 scripts/mod/modpost.c   |  70 ++------------
 scripts/mod/modpost.h   |  25 +++++
 scripts/mod/symsearch.c | 200 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 233 insertions(+), 66 deletions(-)
 create mode 100644 scripts/mod/symsearch.c

diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index c9e38ad937fd..3c54125eb373 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -5,7 +5,7 @@ CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO)
 hostprogs-always-y	+= modpost mk_elfconfig
 always-y		+= empty.o
 
-modpost-objs	:= modpost.o file2alias.o sumversion.o
+modpost-objs	:= modpost.o file2alias.o sumversion.o symsearch.o
 
 devicetable-offsets-file := devicetable-offsets.h
 
@@ -16,7 +16,7 @@ targets += $(devicetable-offsets-file) devicetable-offsets.s
 
 # dependencies on generated files need to be listed explicitly
 
-$(obj)/modpost.o $(obj)/file2alias.o $(obj)/sumversion.o: $(obj)/elfconfig.h
+$(obj)/modpost.o $(obj)/file2alias.o $(obj)/sumversion.o $(obj)/symsearch.o: $(obj)/elfconfig.h
 $(obj)/file2alias.o: $(obj)/$(devicetable-offsets-file)
 
 quiet_cmd_elfconfig = MKELF   $@
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index de499dce5265..71ddce212538 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -22,7 +22,6 @@
 #include <errno.h>
 #include "modpost.h"
 #include "../../include/linux/license.h"
-#include "../../include/linux/module_symbol.h"
 
 static bool module_enabled;
 /* Are we using CONFIG_MODVERSIONS? */
@@ -577,11 +576,14 @@ static int parse_elf(struct elf_info *info, const char *filename)
 			*p = TO_NATIVE(*p);
 	}
 
+	symsearch_init(info);
+
 	return 1;
 }
 
 static void parse_elf_finish(struct elf_info *info)
 {
+	symsearch_finish(info);
 	release_file(info->hdr, info->size);
 }
 
@@ -1039,71 +1041,10 @@ static int secref_whitelist(const char *fromsec, const char *fromsym,
 	return 1;
 }
 
-/*
- * If there's no name there, ignore it; likewise, ignore it if it's
- * one of the magic symbols emitted used by current tools.
- *
- * Otherwise if find_symbols_between() returns those symbols, they'll
- * fail the whitelist tests and cause lots of false alarms ... fixable
- * only by merging __exit and __init sections into __text, bloating
- * the kernel (which is especially evil on embedded platforms).
- */
-static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
-{
-	const char *name = elf->strtab + sym->st_name;
-
-	if (!name || !strlen(name))
-		return 0;
-	return !is_mapping_symbol(name);
-}
-
-/* Look up the nearest symbol based on the section and the address */
-static Elf_Sym *find_nearest_sym(struct elf_info *elf, Elf_Addr addr,
-				 unsigned int secndx, bool allow_negative,
-				 Elf_Addr min_distance)
-{
-	Elf_Sym *sym;
-	Elf_Sym *near = NULL;
-	Elf_Addr sym_addr, distance;
-	bool is_arm = (elf->hdr->e_machine == EM_ARM);
-
-	for (sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
-		if (get_secindex(elf, sym) != secndx)
-			continue;
-		if (!is_valid_name(elf, sym))
-			continue;
-
-		sym_addr = sym->st_value;
-
-		/*
-		 * For ARM Thumb instruction, the bit 0 of st_value is set
-		 * if the symbol is STT_FUNC type. Mask it to get the address.
-		 */
-		if (is_arm && ELF_ST_TYPE(sym->st_info) == STT_FUNC)
-			 sym_addr &= ~1;
-
-		if (addr >= sym_addr)
-			distance = addr - sym_addr;
-		else if (allow_negative)
-			distance = sym_addr - addr;
-		else
-			continue;
-
-		if (distance <= min_distance) {
-			min_distance = distance;
-			near = sym;
-		}
-
-		if (min_distance == 0)
-			break;
-	}
-	return near;
-}
-
 static Elf_Sym *find_fromsym(struct elf_info *elf, Elf_Addr addr,
 			     unsigned int secndx)
 {
-	return find_nearest_sym(elf, addr, secndx, false, ~0);
+	return symsearch_find_nearest(elf, addr, secndx, false, ~0);
 }
 
 static Elf_Sym *find_tosym(struct elf_info *elf, Elf_Addr addr, Elf_Sym *sym)
@@ -1116,7 +1057,8 @@ static Elf_Sym *find_tosym(struct elf_info *elf, Elf_Addr addr, Elf_Sym *sym)
 	 * Strive to find a better symbol name, but the resulting name may not
 	 * match the symbol referenced in the original code.
 	 */
-	return find_nearest_sym(elf, addr, get_secindex(elf, sym), true, 20);
+	return symsearch_find_nearest(elf, addr, get_secindex(elf, sym),
+				      true, 20);
 }
 
 static bool is_executable_section(struct elf_info *elf, unsigned int secndx)
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 5f94c2c9f2d9..6413f26fcb6b 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -10,6 +10,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <elf.h>
+#include "../../include/linux/module_symbol.h"
 
 #include "list.h"
 #include "elfconfig.h"
@@ -128,6 +129,8 @@ struct elf_info {
 	 * take shndx from symtab_shndx_start[N] instead */
 	Elf32_Word   *symtab_shndx_start;
 	Elf32_Word   *symtab_shndx_stop;
+
+	struct symsearch *symsearch;
 };
 
 /* Accessor for sym->st_shndx, hides ugliness of "64k sections" */
@@ -154,6 +157,28 @@ static inline unsigned int get_secindex(const struct elf_info *info,
 	return index;
 }
 
+/*
+ * If there's no name there, ignore it; likewise, ignore it if it's
+ * one of the magic symbols emitted used by current tools.
+ *
+ * Internal symbols created by tools should be ignored by modpost.
+ */
+static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
+{
+	const char *name = elf->strtab + sym->st_name;
+
+	if (!name || !strlen(name))
+		return 0;
+	return !is_mapping_symbol(name);
+}
+
+/* symsearch.c */
+void symsearch_init(struct elf_info *elf);
+void symsearch_finish(struct elf_info *elf);
+Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
+				unsigned int secndx, bool allow_negative,
+				Elf_Addr min_distance);
+
 /* file2alias.c */
 void handle_moddevtable(struct module *mod, struct elf_info *info,
 			Elf_Sym *sym, const char *symname);
diff --git a/scripts/mod/symsearch.c b/scripts/mod/symsearch.c
new file mode 100644
index 000000000000..174e88686418
--- /dev/null
+++ b/scripts/mod/symsearch.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Helper functions for finding the symbol in an ELF which is "nearest"
+ * to a given address.
+ */
+
+#include "modpost.h"
+
+struct syminfo {
+	unsigned int symbol_index;
+	unsigned int section_index;
+	Elf_Addr addr;
+};
+
+/*
+ * Container used to hold an entire binary search table.
+ * Entries in table are ascending, sorted first by section_index,
+ * then by addr, and last by symbol_index.  The sorting by
+ * symbol_index is used to ensure predictable behavior when
+ * multiple symbols are present with the same address; all
+ * symbols past the first are effectively ignored, by eliding
+ * them in symsearch_fixup().
+ */
+struct symsearch {
+	size_t table_size;
+	struct syminfo table[];
+};
+
+static int syminfo_compare(const void *s1, const void *s2)
+{
+	const struct syminfo *sym1 = s1;
+	const struct syminfo *sym2 = s2;
+
+	if (sym1->section_index > sym2->section_index)
+		return 1;
+	if (sym1->section_index < sym2->section_index)
+		return -1;
+	if (sym1->addr > sym2->addr)
+		return 1;
+	if (sym1->addr < sym2->addr)
+		return -1;
+	if (sym1->symbol_index > sym2->symbol_index)
+		return 1;
+	if (sym1->symbol_index < sym2->symbol_index)
+		return -1;
+	return 0;
+}
+
+static size_t symbol_count(struct elf_info *elf)
+{
+	size_t result = 0;
+
+	for (Elf_Sym *sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
+		if (is_valid_name(elf, sym))
+			result++;
+	}
+	return result;
+}
+
+/*
+ * Populate the search array that we just allocated.
+ * Be slightly paranoid here.  The ELF file is mmap'd and could
+ * conceivably change between symbol_count() and symsearch_populate().
+ * If we notice any difference, bail out rather than potentially
+ * propagating errors or crashing.
+ */
+static void symsearch_populate(struct elf_info *elf,
+			       struct syminfo *table,
+			       size_t table_size)
+{
+	bool is_arm = (elf->hdr->e_machine == EM_ARM);
+
+	for (Elf_Sym *sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
+		if (is_valid_name(elf, sym)) {
+			if (table_size-- == 0)
+				fatal("%s: size mismatch\n", __func__);
+			table->symbol_index = sym - elf->symtab_start;
+			table->section_index = get_secindex(elf, sym);
+			table->addr = sym->st_value;
+
+			/*
+			 * For ARM Thumb instruction, the bit 0 of st_value is
+			 * set if the symbol is STT_FUNC type. Mask it to get
+			 * the address.
+			 */
+			if (is_arm && ELF_ST_TYPE(sym->st_info) == STT_FUNC)
+				table->addr &= ~1;
+
+			table++;
+		}
+	}
+
+	if (table_size != 0)
+		fatal("%s: size mismatch\n", __func__);
+}
+
+/*
+ * Do any fixups on the table after sorting.
+ * For now, this just finds adjacent entries which have
+ * the same section_index and addr, and it propagates
+ * the first symbol_index over the subsequent entries,
+ * so that only one symbol_index is seen for any given
+ * section_index and addr.  This ensures that whether
+ * we're looking at an address from "above" or "below"
+ * that we see the same symbol_index.
+ * This does leave some duplicate entries in the table;
+ * in practice, these are a small fraction of the
+ * total number of entries, and they are harmless to
+ * the binary search algorithm other than a few occasional
+ * unnecessary comparisons.
+ */
+static void symsearch_fixup(struct syminfo *table, size_t table_size)
+{
+	/* Don't look at index 0, it will never change. */
+	for (size_t i = 1; i < table_size; i++) {
+		if (table[i].addr == table[i-1].addr &&
+		    table[i].section_index == table[i-1].section_index) {
+			table[i].symbol_index = table[i-1].symbol_index;
+		}
+	}
+}
+
+void symsearch_init(struct elf_info *elf)
+{
+	size_t table_size = symbol_count(elf);
+
+	elf->symsearch = NOFAIL(malloc(
+					sizeof(struct symsearch) +
+					sizeof(struct syminfo) * table_size));
+	elf->symsearch->table_size = table_size;
+
+	symsearch_populate(elf, elf->symsearch->table, table_size);
+	qsort(elf->symsearch->table, table_size,
+	      sizeof(struct syminfo), syminfo_compare);
+
+	symsearch_fixup(elf->symsearch->table, table_size);
+}
+
+void symsearch_finish(struct elf_info *elf)
+{
+	free(elf->symsearch);
+	elf->symsearch = NULL;
+}
+
+/*
+ * Find the syminfo which is in secndx and "nearest" to addr.
+ * allow_negative: allow returning a symbol whose address is > addr.
+ * min_distance: ignore symbols which are further away than this.
+ *
+ * Returns a pointer into the symbol table for success.
+ * Returns NULL if no legal symbol is found within the requested range.
+ */
+Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
+				unsigned int secndx, bool allow_negative,
+				Elf_Addr min_distance)
+{
+	size_t hi = elf->symsearch->table_size;
+	size_t lo = 0;
+	struct syminfo *table = elf->symsearch->table;
+	struct syminfo target;
+
+	target.addr = addr;
+	target.section_index = secndx;
+	target.symbol_index = ~0;  /* compares greater than any actual index */
+	while (hi > lo) {
+		size_t mid = lo + (hi-lo)/2;   /* Avoids potential overflow */
+
+		if (syminfo_compare(&table[mid], &target) > 0)
+			hi = mid;
+		else
+			lo = mid+1;
+	}
+
+	/*
+	 * table[hi], if it exists, is the first entry in the array which
+	 * lies beyond target.  table[hi-1], if it exists, is the last
+	 * entry in the array which comes before target, including the
+	 * case where it perfectly matches the section and the address.
+	 *
+	 * Note -- if the address we're looking up falls perfectly
+	 * in the middle of two symbols, this is written to always
+	 * prefer the symbol with the lower address.
+	 */
+	Elf_Sym *result = NULL;
+
+	if (allow_negative &&
+	    hi < elf->symsearch->table_size &&
+	    table[hi].section_index == secndx &&
+	    table[hi].addr - addr <= min_distance) {
+		min_distance = table[hi].addr - addr;
+		result = &elf->symtab_start[table[hi].symbol_index];
+	}
+	if (hi > 0 &&
+	    table[hi-1].section_index == secndx &&
+	    addr - table[hi-1].addr <= min_distance) {
+		result = &elf->symtab_start[table[hi-1].symbol_index];
+	}
+	return result;
+}
-- 
2.42.0.515.g380fc7ccd1-goog

