Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA9D7ECAE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjKOTAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjKOTAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:00:00 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8138719B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:59:54 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7cc433782so90110207b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700074793; x=1700679593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qmcer6lC4M3sVp5hzPP8TVTi+lzihM8StX6tq1rvRlw=;
        b=GuUugWhL63si7/+oCecj5zlr/69pP7X+2dxbWGcR5DGq173PqZ0X7rk5wk6eMxeTz7
         dkNFzjiMKcJVJKvFBrG0xUtNoLthnjYAl7z7vs4LxuFxBeWvkmSs4vHm4Oo1aHZDYeqs
         3yHmwuq+lVkMHGhouMuGFQJLQJcr3vbHLT1/JddMOQEoGsi1qTgAq5xpTnZYdFCzy3xu
         FK9w9ya4n7ewj9xKcbPNszc0edz8XQs3o4askX1Zj9c/jM4SVj+RoFzKkSR8kkm/r51m
         aTeq/MiiyRxm47XWpsLjWeHaknrzjbnXmNXSB/6K7fio0eez4IUwE5DWQ8yvucPNvOQi
         DxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700074793; x=1700679593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qmcer6lC4M3sVp5hzPP8TVTi+lzihM8StX6tq1rvRlw=;
        b=LO6z5pSbZDGUFBAV5b3dwiu17VDJO+KHRpRJjrexioO4MwTrC81bX/GVGt/LODx5b9
         33WeaW+T406DwBKq80LYXs+YY6iTx4F/LQ5/U/z+5FUGQiwHZzeT1kQriI5mYdY+0A8g
         SsbpTNetUSnPC9hDBr847VxldZNySpMucP9bspItZD1tm2x3y1+f8MRR13rjJD9AGsTw
         MJDxt+wQgqZGZgmhfTaqucC9aWNPmcCjksxQwWE879sJagRhXlvyKhXw5LJs74jNgyeg
         tggj6ZJAFfk8VmiSySpGb17J2HBofX+LEY75HUZbZnzePkux7h2UQiin9ItdyIoH9xT4
         teIA==
X-Gm-Message-State: AOJu0YyuTZH6XRZxm8EaFD91LYfI2jLnjyMj1cdPR+zMLYtLVFKztaIg
        X1m3f4EC81YCpVYEK5vKo82IukSLZoOU
X-Google-Smtp-Source: AGHT+IHERGA7zRpPfbLXEqdgyK4LyKKZECDv5ROgnQkI8SyPb13F+RZ2TBOoN1DR45atLajBKyBsyY0c+xc6
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:ab65:0:b0:da3:723b:b2a4 with SMTP id
 u92-20020a25ab65000000b00da3723bb2a4mr304318ybi.7.1700074793576; Wed, 15 Nov
 2023 10:59:53 -0800 (PST)
Date:   Wed, 15 Nov 2023 18:50:10 +0000
In-Reply-To: <20231115185858.2110875-1-mmaurer@google.com>
Mime-Version: 1.0
References: <20231115185858.2110875-1-mmaurer@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231115185858.2110875-3-mmaurer@google.com>
Subject: [PATCH 2/3] modpost: Extended modversion support
From:   Matthew Maurer <mmaurer@google.com>
To:     gary@garyguo.net, masahiroy@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Song Liu <song@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Matthew Maurer <mmaurer@google.com>,
        Naveen N Rao <naveen@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Marc=20Aur=C3=A8le=20La=20France?=" <tsi@tuyoix.net>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Boqun Feng <boqun.feng@gmail.com>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ard Biesheuvel <ardb@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new format for modversions which stores each field in a separate
elf section. This initially adds support for variable length names, but
could later be used to add additional fields to modversions in a
backwards compatible way if needed.

Adding support for variable length names makes it possible to enable
MODVERSIONS and RUST at the same time.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 arch/powerpc/kernel/module_64.c | 24 +++++++++-
 init/Kconfig                    |  1 -
 kernel/module/internal.h        | 16 ++++++-
 kernel/module/main.c            |  9 +++-
 kernel/module/version.c         | 77 +++++++++++++++++++++++++++++++++
 scripts/mod/modpost.c           | 33 ++++++++++++--
 6 files changed, 151 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 7112adc597a8..2582353a2048 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -355,6 +355,24 @@ static void dedotify_versions(struct modversion_info *vers,
 		}
 }
 
+static void dedotify_ext_version_names(char *str_seq, unsigned long size)
+{
+	unsigned long out = 0;
+	unsigned long in;
+	char last = '\0';
+
+	for (in = 0; in < size; in++) {
+		if (last == '\0')
+			/* Skip all leading dots */
+			if (str_seq[in] == '.')
+				continue;
+		last = str_seq[in];
+		str_seq[out++] = last;
+	}
+	/* Zero the trailing portion of the names table for robustness */
+	bzero(&str_seq[out], size - out);
+}
+
 /*
  * Undefined symbols which refer to .funcname, hack to funcname. Make .TOC.
  * seem to be defined (value set later).
@@ -424,10 +442,12 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
 			me->arch.toc_section = i;
 			if (sechdrs[i].sh_addralign < 8)
 				sechdrs[i].sh_addralign = 8;
-		}
-		else if (strcmp(secstrings+sechdrs[i].sh_name,"__versions")==0)
+		} else if (strcmp(secstrings + sechdrs[i].sh_name, "__versions") == 0)
 			dedotify_versions((void *)hdr + sechdrs[i].sh_offset,
 					  sechdrs[i].sh_size);
+		else if (strcmp(secstrings + sechdrs[i].sh_name, "__version_ext_names") == 0)
+			dedotify_ext_version_names((void *)hdr + sechdrs[i].sh_offset,
+						   sechdrs[i].sh_size);
 
 		if (sechdrs[i].sh_type == SHT_SYMTAB)
 			dedotify((void *)hdr + sechdrs[i].sh_offset,
diff --git a/init/Kconfig b/init/Kconfig
index 9ffb103fc927..6cac5b4db8f6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1885,7 +1885,6 @@ config RUST
 	bool "Rust support"
 	depends on HAVE_RUST
 	depends on RUST_IS_AVAILABLE
-	depends on !MODVERSIONS
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
 	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index c8b7b4dcf782..0c188c96a045 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -80,7 +80,7 @@ struct load_info {
 	unsigned int used_pages;
 #endif
 	struct {
-		unsigned int sym, str, mod, vers, info, pcpu;
+		unsigned int sym, str, mod, vers, info, pcpu, vers_ext_crc, vers_ext_name;
 	} index;
 };
 
@@ -384,6 +384,20 @@ void module_layout(struct module *mod, struct modversion_info *ver, struct kerne
 		   struct kernel_symbol *ks, struct tracepoint * const *tp);
 int check_modstruct_version(const struct load_info *info, struct module *mod);
 int same_magic(const char *amagic, const char *bmagic, bool has_crcs);
+struct modversion_info_ext_s32 {
+	const s32 *value;
+	const s32 *end;
+};
+struct modversion_info_ext_string {
+	const char *value;
+	const char *end;
+};
+struct modversion_info_ext {
+	struct modversion_info_ext_s32 crc;
+	struct modversion_info_ext_string name;
+};
+ssize_t modversion_ext_start(const struct load_info *info, struct modversion_info_ext *ver);
+int modversion_ext_advance(struct modversion_info_ext *ver);
 #else /* !CONFIG_MODVERSIONS */
 static inline int check_version(const struct load_info *info,
 				const char *symname,
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 98fedfdb8db5..e69b2ae46161 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1886,10 +1886,15 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	if (!info->name)
 		info->name = info->mod->name;
 
-	if (flags & MODULE_INIT_IGNORE_MODVERSIONS)
+	if (flags & MODULE_INIT_IGNORE_MODVERSIONS) {
 		info->index.vers = 0; /* Pretend no __versions section! */
-	else
+		info->index.vers_ext_crc = 0;
+		info->index.vers_ext_name = 0;
+	} else {
 		info->index.vers = find_sec(info, "__versions");
+		info->index.vers_ext_crc = find_sec(info, "__version_ext_crcs");
+		info->index.vers_ext_name = find_sec(info, "__version_ext_names");
+	}
 
 	info->index.pcpu = find_pcpusec(info);
 
diff --git a/kernel/module/version.c b/kernel/module/version.c
index 53f43ac5a73e..93d97dad8c77 100644
--- a/kernel/module/version.c
+++ b/kernel/module/version.c
@@ -19,11 +19,28 @@ int check_version(const struct load_info *info,
 	unsigned int versindex = info->index.vers;
 	unsigned int i, num_versions;
 	struct modversion_info *versions;
+	struct modversion_info_ext version_ext;
 
 	/* Exporting module didn't supply crcs?  OK, we're already tainted. */
 	if (!crc)
 		return 1;
 
+	/* If we have extended version info, rely on it */
+	if (modversion_ext_start(info, &version_ext) >= 0) {
+		do {
+			if (strncmp(version_ext.name.value, symname,
+				    version_ext.name.end - version_ext.name.value) != 0)
+				continue;
+
+			if (*version_ext.crc.value == *crc)
+				return 1;
+			pr_debug("Found checksum %X vs module %X\n",
+				 *crc, *version_ext.crc.value);
+			goto bad_version;
+		} while (modversion_ext_advance(&version_ext) == 0);
+		goto broken_toolchain;
+	}
+
 	/* No versions at all?  modprobe --force does this. */
 	if (versindex == 0)
 		return try_to_force_load(mod, symname) == 0;
@@ -46,6 +63,7 @@ int check_version(const struct load_info *info,
 		goto bad_version;
 	}
 
+broken_toolchain:
 	/* Broken toolchain. Warn once, then let it go.. */
 	pr_warn_once("%s: no symbol version for %s\n", info->name, symname);
 	return 1;
@@ -87,6 +105,65 @@ int same_magic(const char *amagic, const char *bmagic,
 	return strcmp(amagic, bmagic) == 0;
 }
 
+#define MODVERSION_FIELD_START(sec, field) \
+	field.value = (typeof(field.value))sec.sh_addr; \
+	field.end = field.value + sec.sh_size
+
+ssize_t modversion_ext_start(const struct load_info *info,
+			     struct modversion_info_ext *start)
+{
+	unsigned int crc_idx = info->index.vers_ext_crc;
+	unsigned int name_idx = info->index.vers_ext_name;
+	Elf_Shdr *sechdrs = info->sechdrs;
+
+	// Both of these fields are needed for this to be useful
+	// Any future fields should be initialized to NULL if absent.
+	if ((crc_idx == 0) || (name_idx == 0))
+		return -EINVAL;
+
+	MODVERSION_FIELD_START(sechdrs[crc_idx], start->crc);
+	MODVERSION_FIELD_START(sechdrs[name_idx], start->name);
+
+	return (start->crc.end - start->crc.value) / sizeof(*start->crc.value);
+}
+
+static int modversion_ext_s32_advance(struct modversion_info_ext_s32 *field)
+{
+	if (!field->value)
+		return 0;
+	if (field->value >= field->end)
+		return -EINVAL;
+	field->value++;
+	return 0;
+}
+
+static int modversion_ext_string_advance(struct modversion_info_ext_string *s)
+{
+	if (!s->value)
+		return 0;
+	if (s->value >= s->end)
+		return -EINVAL;
+	s->value += strnlen(s->value, s->end - s->value - 1) + 1;
+	if (s->value >= s->end)
+		return -EINVAL;
+	return 0;
+}
+
+int modversion_ext_advance(struct modversion_info_ext *start)
+{
+	int ret;
+
+	ret = modversion_ext_s32_advance(&start->crc);
+	if (ret < 0)
+		return ret;
+
+	ret = modversion_ext_string_advance(&start->name);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 /*
  * Generate the signature for all relevant module structures here.
  * If these change, we don't want to try to parse the module.
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 973b5e5ae2dd..884860c2e833 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1910,15 +1910,42 @@ static void add_versions(struct buffer *b, struct module *mod)
 			continue;
 		}
 		if (strlen(s->name) >= MODULE_NAME_LEN) {
-			error("too long symbol \"%s\" [%s.ko]\n",
-			      s->name, mod->name);
-			break;
+			/* this symbol will only be in the extended info */
+			continue;
 		}
 		buf_printf(b, "\t{ %#8x, \"%s\" },\n",
 			   s->crc, s->name);
 	}
 
 	buf_printf(b, "};\n");
+
+	buf_printf(b, "static const s32 ____version_ext_crcs[]\n");
+	buf_printf(b, "__used __section(\"__version_ext_crcs\") = {\n");
+	list_for_each_entry(s, &mod->unresolved_symbols, list) {
+		if (!s->module)
+			continue;
+		if (!s->crc_valid) {
+			// We already warned on this when producing the legacy
+			// modversions table.
+			continue;
+		}
+		buf_printf(b, "\t%#8x,\n", s->crc);
+	}
+	buf_printf(b, "};\n");
+
+	buf_printf(b, "static const char ____version_ext_names[]\n");
+	buf_printf(b, "__used __section(\"__version_ext_names\") =\n");
+	list_for_each_entry(s, &mod->unresolved_symbols, list) {
+		if (!s->module)
+			continue;
+		if (!s->crc_valid) {
+			// We already warned on this when producing the legacy
+			// modversions table.
+			continue;
+		}
+		buf_printf(b, "\t\"%s\\0\"\n", s->name);
+	}
+	buf_printf(b, ";\n");
 }
 
 static void add_depends(struct buffer *b, struct module *mod)
-- 
2.43.0.rc0.421.g78406f8d94-goog

