Return-Path: <linux-kernel+bounces-152487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC81A8ABF28
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 14:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95153280FA9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 12:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0F31798C;
	Sun, 21 Apr 2024 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlVj7P9O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6AE17555;
	Sun, 21 Apr 2024 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713701315; cv=none; b=se355aSax/FA8EjKlsyLZ4qiuXYL1d8s0k3YTAEw9V2TEDx1kzaBkEbnGIyjEQhhHNZSZ2w3QuTWTDFlp5kazwrMZU1KVOTJiJsiEdZoninhtCYUQlNREGBq54gY5wu7MpZyhCQqHG2oqWhpnmxoqCRkoXzJAcNkeA5AvE8F+Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713701315; c=relaxed/simple;
	bh=Gsdgpbj7NFA5qr1KQmsKddJNtOfk4YkOPTcgoYpVJ7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hgE6sXOSiY0p1RODCjwskfCHB1SRixr50rrqUlfg3dYFRLSTygMq5N21+B7JJUVaW4uusMNGk5s1WvqRMdRVmNaicGSWf3yBiLN6VuiQWgP0lLuruok3KyyvnDJpj8T9alql3cepG+GamkwQLPJUiudcmf1ok4RQH/zmpjFEM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlVj7P9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB872C32783;
	Sun, 21 Apr 2024 12:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713701315;
	bh=Gsdgpbj7NFA5qr1KQmsKddJNtOfk4YkOPTcgoYpVJ7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZlVj7P9O6ogfkUdfOL7URjtws+JHaWSfIisoyfAl0TTpWraHjIfO9u1wd992r4mpG
	 Vqhqn0exuS7VM+sR8h6CUofUu1Ja4e9cd0K4t5VxAEs+2hDhhpJ75kqWNZIjN8FElo
	 SnStG5gswmrSUOO7TKZyfOHyWylxRYvb2kQfNA5I6B+V2NkzXToPwxEx0x807xj7Or
	 TYx2Q51uMko0cTQHnw+787H/tnt2HQwRcAvVHujDx6MKnB2x3O9c2lpRZl9lrQuDlb
	 9hCEceJFTBJaNFqEJ6XouClgfr1HgCycu/6Mbg/pU0+vDXLfFBeVPCUpocb+JS35d/
	 +wL/sYfGfNqeg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-doc@vger.kernel.org
Subject: [PATCH 2/2] kconfig: remove 'optional' property support
Date: Sun, 21 Apr 2024 21:08:24 +0900
Message-Id: <20240421120824.2713923-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240421120824.2713923-1-masahiroy@kernel.org>
References: <20240421120824.2713923-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'choice' statement is primarily used to exclusively select one
option, but the 'optional' property allows all entries to be disabled.

In the following example, both A and B can be disabled simultaneously:

    choice
            prompt "choose A, B, or nothing"
            optional

    config A
            bool "A"

    config B
            bool "B"

    endchoice

You can achieve the equivalent outcome by other means.

One solution is to add another option to guard the choice block.
In the following example, you can set ENABLE_A_B_CHOICE=n to disable
the entire choice block:

    choice
            prompt "choose A or B"
            depends on ENABLE_A_B_CHOICE

    config A
            bool "A"

    config B
            bool "B"

    endchoice

Another approach is to insert one more entry as a place-holder:

    choice
            prompt "choose A, B, or disable both"

    config A
            bool "A"

    config B
            bool "B"

    config DISABLE_A_AND_B
            bool "choose this to disable both A and B"

    endchoice

The latter is commonly used, for example, LTO_NONE, DEBUG_INFO_NONE,
INITRAMFS_COMPRESSION_NONE, etc.

The 'optional' property is even more unnecessary for a tristate choice.

Without the 'optional' property, you can disable A and B; you can set
'm' in the choice prompt, and disable A and B individually:

    choice
            prompt "choose one built-in or make them modular"

    config A
            tristate "A"

    config B
            tristate "B"

    endchoice

In conclusion, the 'optional' property was unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/kbuild/kconfig-language.rst     |  3 ---
 scripts/kconfig/confdata.c                    |  5 +---
 scripts/kconfig/expr.h                        |  1 -
 scripts/kconfig/gconf.c                       |  2 --
 scripts/kconfig/lexer.l                       |  1 -
 scripts/kconfig/lkc.h                         |  5 ----
 scripts/kconfig/menu.c                        | 12 +++------
 scripts/kconfig/parser.y                      |  9 -------
 scripts/kconfig/tests/choice/Kconfig          | 26 -------------------
 .../tests/choice/allmod_expected_config       |  4 ---
 .../tests/choice/allyes_expected_config       |  4 ---
 .../tests/choice/oldask0_expected_stdout      |  2 --
 scripts/kconfig/tests/choice/oldask1_config   |  1 -
 .../tests/choice/oldask1_expected_stdout      |  6 -----
 14 files changed, 5 insertions(+), 76 deletions(-)

diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
index 79ac2e8184f6..555c2f839969 100644
--- a/Documentation/kbuild/kconfig-language.rst
+++ b/Documentation/kbuild/kconfig-language.rst
@@ -410,9 +410,6 @@ to be set to 'm'. This can be used if multiple drivers for a single
 hardware exists and only a single driver can be compiled/loaded into
 the kernel, but all drivers can be compiled as modules.
 
-A choice accepts another option "optional", which allows to set the
-choice to 'n' and no entry needs to be selected.
-
 comment::
 
 	"comment" <prompt>
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index ce0ef417b71b..cf60a8cf31ca 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -810,9 +810,6 @@ int conf_write_defconfig(const char *filename)
 			/*
 			 * If symbol is a choice value and equals to the
 			 * default for a choice - skip.
-			 * But only if value is bool and equal to "y" and
-			 * choice is not "optional".
-			 * (If choice is "optional" then all values can be "n")
 			 */
 			if (sym_is_choice_value(sym)) {
 				struct symbol *cs;
@@ -820,7 +817,7 @@ int conf_write_defconfig(const char *filename)
 
 				cs = prop_get_symbol(sym_get_choice_prop(sym));
 				ds = sym_choice_default(cs);
-				if (!sym_is_optional(cs) && sym == ds) {
+				if (sym == ds) {
 					if ((sym->type == S_BOOLEAN) &&
 					    sym_get_tristate_value(sym) == yes)
 						continue;
diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index 0158f5eac454..d4b54554714a 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -134,7 +134,6 @@ struct symbol {
 #define SYMBOL_CHOICE     0x0010  /* start of a choice block (null name) */
 #define SYMBOL_CHOICEVAL  0x0020  /* used as a value in a choice block */
 #define SYMBOL_VALID      0x0080  /* set when symbol.curr is calculated */
-#define SYMBOL_OPTIONAL   0x0100  /* choice is optional - values can be 'n' */
 #define SYMBOL_WRITE      0x0200  /* write symbol to file (KCONFIG_CONFIG) */
 #define SYMBOL_CHANGED    0x0400  /* ? */
 #define SYMBOL_WRITTEN    0x0800  /* track info to avoid double-write to .config */
diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
index 9709aca3a30f..37ae4681a68e 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -89,8 +89,6 @@ static const char *dbg_sym_flags(int val)
 		strcat(buf, "choiceval/");
 	if (val & SYMBOL_VALID)
 		strcat(buf, "valid/");
-	if (val & SYMBOL_OPTIONAL)
-		strcat(buf, "optional/");
 	if (val & SYMBOL_WRITE)
 		strcat(buf, "write/");
 	if (val & SYMBOL_CHANGED)
diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index 89544c3a1a29..8dd597c4710d 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -120,7 +120,6 @@ n	[A-Za-z0-9_-]
 "menuconfig"		return T_MENUCONFIG;
 "modules"		return T_MODULES;
 "on"			return T_ON;
-"optional"		return T_OPTIONAL;
 "prompt"		return T_PROMPT;
 "range"			return T_RANGE;
 "select"		return T_SELECT;
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index cfb7e9ac41a3..29269e5d8ece 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -137,11 +137,6 @@ static inline bool sym_is_choice_value(struct symbol *sym)
 	return sym->flags & SYMBOL_CHOICEVAL ? true : false;
 }
 
-static inline bool sym_is_optional(struct symbol *sym)
-{
-	return sym->flags & SYMBOL_OPTIONAL ? true : false;
-}
-
 static inline bool sym_has_value(struct symbol *sym)
 {
 	return sym->flags & SYMBOL_DEF_USER ? true : false;
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index fe6af8700622..e01b9ee87c05 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -593,15 +593,11 @@ static void _menu_finalize(struct menu *parent, bool inside_choice)
 	}
 
 	/*
-	 * For non-optional choices, add a reverse dependency (corresponding to
-	 * a select) of '<visibility> && m'. This prevents the user from
-	 * setting the choice mode to 'n' when the choice is visible.
-	 *
-	 * This would also work for non-choice symbols, but only non-optional
-	 * choices clear SYMBOL_OPTIONAL as of writing. Choices are implemented
-	 * as a type of symbol.
+	 * For choices, add a reverse dependency (corresponding to a select) of
+	 * '<visibility> && m'. This prevents the user from setting the choice
+	 * mode to 'n' when the choice is visible.
 	 */
-	if (sym && !sym_is_optional(sym) && parent->prompt) {
+	if (sym && sym_is_choice(sym) && parent->prompt) {
 		sym->rev_dep.expr = expr_alloc_or(sym->rev_dep.expr,
 				expr_alloc_and(parent->prompt->visible.expr,
 					expr_alloc_symbol(&symbol_mod)));
diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index 8f339b47fe8d..6ac0f44270c4 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -69,7 +69,6 @@ struct menu *current_menu, *current_entry;
 %token T_MODULES
 %token T_ON
 %token T_OPEN_PAREN
-%token T_OPTIONAL
 %token T_PLUS_EQUAL
 %token T_PROMPT
 %token T_RANGE
@@ -140,7 +139,6 @@ stmt_list_in_choice:
 
 config_entry_start: T_CONFIG nonconst_symbol T_EOL
 {
-	$2->flags |= SYMBOL_OPTIONAL;
 	menu_add_entry($2);
 	printd(DEBUG_PARSE, "%s:%d:config %s\n", cur_filename, cur_lineno, $2->name);
 };
@@ -152,7 +150,6 @@ config_stmt: config_entry_start config_option_list
 
 menuconfig_entry_start: T_MENUCONFIG nonconst_symbol T_EOL
 {
-	$2->flags |= SYMBOL_OPTIONAL;
 	menu_add_entry($2);
 	printd(DEBUG_PARSE, "%s:%d:menuconfig %s\n", cur_filename, cur_lineno, $2->name);
 };
@@ -272,12 +269,6 @@ choice_option: logic_type prompt_stmt_opt T_EOL
 	printd(DEBUG_PARSE, "%s:%d:type(%u)\n", cur_filename, cur_lineno, $1);
 };
 
-choice_option: T_OPTIONAL T_EOL
-{
-	current_entry->sym->flags |= SYMBOL_OPTIONAL;
-	printd(DEBUG_PARSE, "%s:%d:optional\n", cur_filename, cur_lineno);
-};
-
 choice_option: T_DEFAULT nonconst_symbol if_expr T_EOL
 {
 	menu_add_symbol(P_DEFAULT, $2, $3);
diff --git a/scripts/kconfig/tests/choice/Kconfig b/scripts/kconfig/tests/choice/Kconfig
index 0930eb65e932..8cdda40868a1 100644
--- a/scripts/kconfig/tests/choice/Kconfig
+++ b/scripts/kconfig/tests/choice/Kconfig
@@ -17,19 +17,6 @@ config BOOL_CHOICE1
 
 endchoice
 
-choice
-	prompt "optional boolean choice"
-	optional
-	default OPT_BOOL_CHOICE1
-
-config OPT_BOOL_CHOICE0
-	bool "choice 0"
-
-config OPT_BOOL_CHOICE1
-	bool "choice 1"
-
-endchoice
-
 choice
 	prompt "tristate choice"
 	default TRI_CHOICE1
@@ -41,16 +28,3 @@ config TRI_CHOICE1
 	tristate "choice 1"
 
 endchoice
-
-choice
-	prompt "optional tristate choice"
-	optional
-	default OPT_TRI_CHOICE1
-
-config OPT_TRI_CHOICE0
-	tristate "choice 0"
-
-config OPT_TRI_CHOICE1
-	tristate "choice 1"
-
-endchoice
diff --git a/scripts/kconfig/tests/choice/allmod_expected_config b/scripts/kconfig/tests/choice/allmod_expected_config
index f1f5dcdb7923..d1f51651740c 100644
--- a/scripts/kconfig/tests/choice/allmod_expected_config
+++ b/scripts/kconfig/tests/choice/allmod_expected_config
@@ -1,9 +1,5 @@
 CONFIG_MODULES=y
 # CONFIG_BOOL_CHOICE0 is not set
 CONFIG_BOOL_CHOICE1=y
-# CONFIG_OPT_BOOL_CHOICE0 is not set
-CONFIG_OPT_BOOL_CHOICE1=y
 CONFIG_TRI_CHOICE0=m
 CONFIG_TRI_CHOICE1=m
-CONFIG_OPT_TRI_CHOICE0=m
-CONFIG_OPT_TRI_CHOICE1=m
diff --git a/scripts/kconfig/tests/choice/allyes_expected_config b/scripts/kconfig/tests/choice/allyes_expected_config
index e5a062a1157c..8a76c1816893 100644
--- a/scripts/kconfig/tests/choice/allyes_expected_config
+++ b/scripts/kconfig/tests/choice/allyes_expected_config
@@ -1,9 +1,5 @@
 CONFIG_MODULES=y
 # CONFIG_BOOL_CHOICE0 is not set
 CONFIG_BOOL_CHOICE1=y
-# CONFIG_OPT_BOOL_CHOICE0 is not set
-CONFIG_OPT_BOOL_CHOICE1=y
 # CONFIG_TRI_CHOICE0 is not set
 CONFIG_TRI_CHOICE1=y
-# CONFIG_OPT_TRI_CHOICE0 is not set
-CONFIG_OPT_TRI_CHOICE1=y
diff --git a/scripts/kconfig/tests/choice/oldask0_expected_stdout b/scripts/kconfig/tests/choice/oldask0_expected_stdout
index b251bba9698b..d2257db46423 100644
--- a/scripts/kconfig/tests/choice/oldask0_expected_stdout
+++ b/scripts/kconfig/tests/choice/oldask0_expected_stdout
@@ -3,8 +3,6 @@ boolean choice
   1. choice 0 (BOOL_CHOICE0) (NEW)
 > 2. choice 1 (BOOL_CHOICE1) (NEW)
 choice[1-2?]: 
-optional boolean choice [N/y/?] (NEW) 
 tristate choice [M/y/?] (NEW) 
   choice 0 (TRI_CHOICE0) [N/m/?] (NEW) 
   choice 1 (TRI_CHOICE1) [N/m/?] (NEW) 
-optional tristate choice [N/m/y/?] (NEW) 
diff --git a/scripts/kconfig/tests/choice/oldask1_config b/scripts/kconfig/tests/choice/oldask1_config
index b67bfe3c641f..0f417856c81c 100644
--- a/scripts/kconfig/tests/choice/oldask1_config
+++ b/scripts/kconfig/tests/choice/oldask1_config
@@ -1,2 +1 @@
 # CONFIG_MODULES is not set
-CONFIG_OPT_BOOL_CHOICE0=y
diff --git a/scripts/kconfig/tests/choice/oldask1_expected_stdout b/scripts/kconfig/tests/choice/oldask1_expected_stdout
index c2125e9bf96a..ffa20ad7f38e 100644
--- a/scripts/kconfig/tests/choice/oldask1_expected_stdout
+++ b/scripts/kconfig/tests/choice/oldask1_expected_stdout
@@ -3,13 +3,7 @@ boolean choice
   1. choice 0 (BOOL_CHOICE0) (NEW)
 > 2. choice 1 (BOOL_CHOICE1) (NEW)
 choice[1-2?]: 
-optional boolean choice [Y/n/?] (NEW) 
-optional boolean choice
-> 1. choice 0 (OPT_BOOL_CHOICE0)
-  2. choice 1 (OPT_BOOL_CHOICE1) (NEW)
-choice[1-2?]: 
 tristate choice
   1. choice 0 (TRI_CHOICE0) (NEW)
 > 2. choice 1 (TRI_CHOICE1) (NEW)
 choice[1-2?]: 
-optional tristate choice [N/y/?] 
-- 
2.40.1


