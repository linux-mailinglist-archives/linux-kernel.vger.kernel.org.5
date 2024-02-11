Return-Path: <linux-kernel+bounces-60772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A66850942
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44982873AE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA505B5AF;
	Sun, 11 Feb 2024 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDpFEovS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFFC5B053;
	Sun, 11 Feb 2024 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707655273; cv=none; b=CQyvPEhvaDNVJp2gjGyA3RLBX2NiZVozRLLXX5UE3rUcv4AXHgjnaIQJOJmWIo9lLUNG8qkaRv2lztKKDW9JDiS9KUKPULTPNPjxAwUbjARx8NNaEJPiJCEs15NIET7awgdT5o/gnyNhA4nKyYAn4FVP8bIW0/fTFrysoBcYxCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707655273; c=relaxed/simple;
	bh=DHTaw0A/DHD3RfxzoqZvFzVkcc+o/cvMO+JI8Q6ldCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KC89okY7ev4xWb3HkYaIYF3O2QpZqnbr9H5QxyROx2sT7k3/r+R2bqooTb9+PX/oDeYlTSFrctrQ/WjBjiuLJRzp9yVZHMpDdu4abg9HTOlXRNosGmz3oUwQI54ei+lh/zEFFsJZrRdUPK1tHPRBvPZYB7z6f3A6zv3pYjGmqAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDpFEovS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DD9C433F1;
	Sun, 11 Feb 2024 12:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707655273;
	bh=DHTaw0A/DHD3RfxzoqZvFzVkcc+o/cvMO+JI8Q6ldCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDpFEovSdYevpA3QzRG0WpGp5bFehtaLfRwtRTAvoqDNO3q8Q+QySR5/s74Ajq+Ty
	 YYnhmNr28wB7W2i2+ajNwevudM5yPDUVTCXkez0h/psSdNkB/y1heN/a2G6ixUUeJ5
	 y2ECvXke1oj6rv2QbCqiTF4vJq5vbnT7ZcSOjJ7o0IJtG0vqMMoqrALaDTJlEz3qpb
	 Nw6cE0q7J2KwLi8w4OcRiiuJO1Xt9/MoYBr+kPo9peJxfVzGsVnL7zOYqhD0EyYpXR
	 n8VfTXboxyCSYJNojdEIpD5dNJuZ53+M6dzGtEmdzT9biuH80teGLWcFCoyNiSf6lT
	 dNilGDm4DUCLg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kconfig: use generic macros to implement symbol hashtable
Date: Sun, 11 Feb 2024 21:41:05 +0900
Message-Id: <20240211124105.29363-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240211124105.29363-1-masahiroy@kernel.org>
References: <20240211124105.29363-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use helper macros in hashtable.h for generic hashtable implementation.

We can git rid of the hash head index of for_all_symbols().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/conf.c      | 12 ++++++------
 scripts/kconfig/confdata.c  | 25 ++++++++++++-------------
 scripts/kconfig/expr.h      |  9 ++++-----
 scripts/kconfig/internal.h  |  9 +++++++++
 scripts/kconfig/lkc_proto.h |  2 --
 scripts/kconfig/parser.y    |  2 --
 scripts/kconfig/symbol.c    | 22 +++++++++++-----------
 7 files changed, 42 insertions(+), 39 deletions(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 662a5e7c37c2..b5730061872b 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -14,6 +14,7 @@
 #include <sys/time.h>
 #include <errno.h>
 
+#include "internal.h"
 #include "lkc.h"
 
 static void conf(struct menu *menu);
@@ -171,7 +172,7 @@ enum conf_def_mode {
 static bool conf_set_all_new_symbols(enum conf_def_mode mode)
 {
 	struct symbol *sym, *csym;
-	int i, cnt;
+	int cnt;
 	/*
 	 * can't go as the default in switch-case below, otherwise gcc whines
 	 * about -Wmaybe-uninitialized
@@ -226,7 +227,7 @@ static bool conf_set_all_new_symbols(enum conf_def_mode mode)
 		}
 	}
 
-	for_all_symbols(i, sym) {
+	for_all_symbols(sym) {
 		if (sym_has_value(sym) || sym->flags & SYMBOL_VALID)
 			continue;
 		switch (sym_get_type(sym)) {
@@ -278,14 +279,14 @@ static bool conf_set_all_new_symbols(enum conf_def_mode mode)
 	 * and the rest to no.
 	 */
 	if (mode != def_random) {
-		for_all_symbols(i, csym) {
+		for_all_symbols(csym) {
 			if ((sym_is_choice(csym) && !sym_has_value(csym)) ||
 			    sym_is_choice_value(csym))
 				csym->flags |= SYMBOL_NEED_SET_CHOICE_VALUES;
 		}
 	}
 
-	for_all_symbols(i, csym) {
+	for_all_symbols(csym) {
 		if (sym_has_value(csym) || !sym_is_choice(csym))
 			continue;
 
@@ -304,9 +305,8 @@ static bool conf_set_all_new_symbols(enum conf_def_mode mode)
 static void conf_rewrite_tristates(tristate old_val, tristate new_val)
 {
 	struct symbol *sym;
-	int i;
 
-	for_all_symbols(i, sym) {
+	for_all_symbols(sym) {
 		if (sym_get_type(sym) == S_TRISTATE &&
 		    sym->def[S_DEF_USER].tri == old_val)
 			sym->def[S_DEF_USER].tri = new_val;
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index dafc572e7b7e..c5b6487d68ac 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -18,6 +18,7 @@
 #include <time.h>
 #include <unistd.h>
 
+#include "internal.h"
 #include "lkc.h"
 
 struct gstr autoconf_cmd;
@@ -322,7 +323,7 @@ int conf_read_simple(const char *name, int def)
 	size_t  line_asize = 0;
 	char *p, *val;
 	struct symbol *sym;
-	int i, def_flags;
+	int def_flags;
 	const char *warn_unknown, *sym_name;
 
 	warn_unknown = getenv("KCONFIG_WARN_UNKNOWN_SYMBOLS");
@@ -380,7 +381,7 @@ int conf_read_simple(const char *name, int def)
 	conf_warnings = 0;
 
 	def_flags = SYMBOL_DEF << def;
-	for_all_symbols(i, sym) {
+	for_all_symbols(sym) {
 		sym->flags |= SYMBOL_CHANGED;
 		sym->flags &= ~(def_flags|SYMBOL_VALID);
 		if (sym_is_choice(sym))
@@ -489,7 +490,6 @@ int conf_read(const char *name)
 {
 	struct symbol *sym;
 	int conf_unsaved = 0;
-	int i;
 
 	conf_set_changed(false);
 
@@ -500,7 +500,7 @@ int conf_read(const char *name)
 
 	sym_calc_value(modules_sym);
 
-	for_all_symbols(i, sym) {
+	for_all_symbols(sym) {
 		sym_calc_value(sym);
 		if (sym_is_choice(sym) || (sym->flags & SYMBOL_NO_WRITE))
 			continue;
@@ -524,7 +524,7 @@ int conf_read(const char *name)
 		/* maybe print value in verbose mode... */
 	}
 
-	for_all_symbols(i, sym) {
+	for_all_symbols(sym) {
 		if (sym_has_value(sym) && !sym_is_choice_value(sym)) {
 			/* Reset values of generates values, so they'll appear
 			 * as new, if they should become visible, but that
@@ -862,7 +862,6 @@ int conf_write(const char *name)
 	const char *str;
 	char tmpname[PATH_MAX + 1], oldname[PATH_MAX + 1];
 	char *env;
-	int i;
 	bool need_newline = false;
 
 	if (!name)
@@ -946,7 +945,7 @@ int conf_write(const char *name)
 	}
 	fclose(out);
 
-	for_all_symbols(i, sym)
+	for_all_symbols(sym)
 		sym->flags &= ~SYMBOL_WRITTEN;
 
 	if (*tmpname) {
@@ -1016,7 +1015,7 @@ static int conf_touch_deps(void)
 {
 	const char *name, *tmp;
 	struct symbol *sym;
-	int res, i;
+	int res;
 
 	name = conf_get_autoconfig_name();
 	tmp = strrchr(name, '/');
@@ -1030,7 +1029,7 @@ static int conf_touch_deps(void)
 	conf_read_simple(name, S_DEF_AUTO);
 	sym_calc_value(modules_sym);
 
-	for_all_symbols(i, sym) {
+	for_all_symbols(sym) {
 		sym_calc_value(sym);
 		if ((sym->flags & SYMBOL_NO_WRITE) || !sym->name)
 			continue;
@@ -1096,7 +1095,7 @@ static int __conf_write_autoconf(const char *filename,
 	char tmp[PATH_MAX];
 	FILE *file;
 	struct symbol *sym;
-	int ret, i;
+	int ret;
 
 	if (make_parent_dir(filename))
 		return -1;
@@ -1113,7 +1112,7 @@ static int __conf_write_autoconf(const char *filename,
 
 	conf_write_heading(file, comment_style);
 
-	for_all_symbols(i, sym)
+	for_all_symbols(sym)
 		if ((sym->flags & SYMBOL_WRITE) && sym->name)
 			print_symbol(file, sym);
 
@@ -1136,7 +1135,7 @@ int conf_write_autoconf(int overwrite)
 {
 	struct symbol *sym;
 	const char *autoconf_name = conf_get_autoconfig_name();
-	int ret, i;
+	int ret;
 
 	if (!overwrite && is_present(autoconf_name))
 		return 0;
@@ -1148,7 +1147,7 @@ int conf_write_autoconf(int overwrite)
 	if (conf_touch_deps())
 		return 1;
 
-	for_all_symbols(i, sym)
+	for_all_symbols(sym)
 		sym_calc_value(sym);
 
 	ret = __conf_write_autoconf(conf_get_autoheader_name(),
diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index dd3350aed302..3bc375f1a1cd 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -17,6 +17,8 @@ extern "C" {
 #include <stdbool.h>
 #endif
 
+#include "list_types.h"
+
 typedef enum tristate {
 	no, mod, yes
 } tristate;
@@ -74,8 +76,8 @@ enum {
  * SYMBOL_CHOICE bit set in 'flags'.
  */
 struct symbol {
-	/* The next symbol in the same bucket in the symbol hash table */
-	struct symbol *next;
+	/* link node for the hash table */
+	struct hlist_node node;
 
 	/* The name of the symbol, e.g. "FOO" for 'config FOO' */
 	char *name;
@@ -124,8 +126,6 @@ struct symbol {
 	struct expr_value implied;
 };
 
-#define for_all_symbols(i, sym) for (i = 0; i < SYMBOL_HASHSIZE; i++) for (sym = symbol_hash[i]; sym; sym = sym->next)
-
 #define SYMBOL_CONST      0x0001  /* symbol is const */
 #define SYMBOL_CHECK      0x0008  /* used during dependency checking */
 #define SYMBOL_CHOICE     0x0010  /* start of a choice block (null name) */
@@ -150,7 +150,6 @@ struct symbol {
 #define SYMBOL_NEED_SET_CHOICE_VALUES  0x100000
 
 #define SYMBOL_MAXLENGTH	256
-#define SYMBOL_HASHSIZE		9973
 
 /* A property represent the config options that can be associated
  * with a config "symbol".
diff --git a/scripts/kconfig/internal.h b/scripts/kconfig/internal.h
index 788401cd5d6f..6c721c4cfd72 100644
--- a/scripts/kconfig/internal.h
+++ b/scripts/kconfig/internal.h
@@ -2,6 +2,15 @@
 #ifndef INTERNAL_H
 #define INTERNAL_H
 
+#include "hashtable.h"
+
+#define SYMBOL_HASHSIZE		(1U << 14)
+
+extern HASHTABLE_DECLARE(sym_hashtable, SYMBOL_HASHSIZE);
+
+#define for_all_symbols(sym) \
+	hash_for_each(sym_hashtable, sym, node)
+
 struct menu;
 
 extern struct menu *current_menu, *current_entry;
diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index 94299e42402f..2807fa584c2b 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -18,8 +18,6 @@ void conf_set_message_callback(void (*fn)(const char *s));
 bool conf_errors(void);
 
 /* symbol.c */
-extern struct symbol * symbol_hash[SYMBOL_HASHSIZE];
-
 struct symbol * sym_lookup(const char *name, int flags);
 struct symbol * sym_find(const char *name);
 void print_symbol_for_listconfig(struct symbol *sym);
diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index efd0e234e0d2..b505e43e0d02 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -28,8 +28,6 @@ static void zconf_error(const char *err, ...);
 static bool zconf_endtoken(const char *tokenname,
 			   const char *expected_tokenname);
 
-struct symbol *symbol_hash[SYMBOL_HASHSIZE];
-
 struct menu *current_menu, *current_entry;
 
 %}
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 518977c525de..1290c6d2f8c2 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <regex.h>
 
+#include "internal.h"
 #include "lkc.h"
 #include "util.h"
 
@@ -161,9 +162,8 @@ static void sym_set_changed(struct symbol *sym)
 static void sym_set_all_changed(void)
 {
 	struct symbol *sym;
-	int i;
 
-	for_all_symbols(i, sym)
+	for_all_symbols(sym)
 		sym_set_changed(sym);
 }
 
@@ -476,9 +476,8 @@ void sym_calc_value(struct symbol *sym)
 void sym_clear_all_valid(void)
 {
 	struct symbol *sym;
-	int i;
 
-	for_all_symbols(i, sym)
+	for_all_symbols(sym)
 		sym->flags &= ~SYMBOL_VALID;
 	conf_set_changed(true);
 	sym_calc_value(modules_sym);
@@ -804,6 +803,8 @@ bool sym_is_changeable(struct symbol *sym)
 	return sym->visible > sym->rev_dep.tri;
 }
 
+HASHTABLE_DEFINE(sym_hashtable, SYMBOL_HASHSIZE);
+
 struct symbol *sym_lookup(const char *name, int flags)
 {
 	struct symbol *symbol;
@@ -818,9 +819,9 @@ struct symbol *sym_lookup(const char *name, int flags)
 			case 'n': return &symbol_no;
 			}
 		}
-		hash = strhash(name) % SYMBOL_HASHSIZE;
+		hash = strhash(name);
 
-		for (symbol = symbol_hash[hash]; symbol; symbol = symbol->next) {
+		hash_for_each_possible(sym_hashtable, symbol, node, hash) {
 			if (symbol->name &&
 			    !strcmp(symbol->name, name) &&
 			    (flags ? symbol->flags & flags
@@ -839,8 +840,7 @@ struct symbol *sym_lookup(const char *name, int flags)
 	symbol->type = S_UNKNOWN;
 	symbol->flags = flags;
 
-	symbol->next = symbol_hash[hash];
-	symbol_hash[hash] = symbol;
+	hash_add(sym_hashtable, &symbol->node, hash);
 
 	return symbol;
 }
@@ -860,9 +860,9 @@ struct symbol *sym_find(const char *name)
 		case 'n': return &symbol_no;
 		}
 	}
-	hash = strhash(name) % SYMBOL_HASHSIZE;
+	hash = strhash(name);
 
-	for (symbol = symbol_hash[hash]; symbol; symbol = symbol->next) {
+	hash_for_each_possible(sym_hashtable, symbol, node, hash) {
 		if (symbol->name &&
 		    !strcmp(symbol->name, name) &&
 		    !(symbol->flags & SYMBOL_CONST))
@@ -922,7 +922,7 @@ struct symbol **sym_re_search(const char *pattern)
 	if (regcomp(&re, pattern, REG_EXTENDED|REG_ICASE))
 		return NULL;
 
-	for_all_symbols(i, sym) {
+	for_all_symbols(sym) {
 		if (sym->flags & SYMBOL_CONST || !sym->name)
 			continue;
 		if (regexec(&re, sym->name, 1, match, 0))
-- 
2.40.1


