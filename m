Return-Path: <linux-kernel+bounces-50070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044EE8473EA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736001F22AAB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0461114AD00;
	Fri,  2 Feb 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0C4So1+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C096514A4E0;
	Fri,  2 Feb 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889521; cv=none; b=kDGYq9YA7x8lUd8gkpjjwHaEseP5zkq3XGQjqBiSsjP1dKnxUVsreB2gzCIEumqaDZZ/wunVc/1YnysJhOCraeTGt58ONux5lWcdqtV26Vd2cpoTef7pKTj37Qml27Ci6tRk1gm62Q4IubknJ9KJm5dV9qaSVcBoRy1+6+jN4Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889521; c=relaxed/simple;
	bh=iHM8Es9wLEFNU6sshaQjaQFTw2pijimnR0FYXBXj7F4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QSsW0SaU3mLatyyPpeLLHf/leJCCxemvt95ecdqevRhzH33idUWqyBMUxqMXu7iDKWS+dSogpEYg2FDwMCD/ytqqK+7H1lC7oRx+HbjikLCpdqaBRDuq/ccsL/aF4GOchBOKEv3oqzPhCKtJn1TsTdNQta7HZeqrn2k82KHvN+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0C4So1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF894C43399;
	Fri,  2 Feb 2024 15:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889521;
	bh=iHM8Es9wLEFNU6sshaQjaQFTw2pijimnR0FYXBXj7F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0C4So1+9VMNvuKisbwVe9z+KtLjpJDVG3acEzCU05Uj8F1wvC/Fw8tuA5QU9jOAU
	 9XRyExVSBzroC+XcUNTaRbvP7KnjxQ0fuAzCFg4BMdP1tyPLHbHjrWJLO5d9Cb55PO
	 OLYALwt+X9PS1cMve7NS7URkvy8ehpyqfD6/CwXtQQkHWBIvnPiOYeKen1movyXNje
	 hNmsmqb2XBB0kdxtIbe7ST8q6zHBAN1yYCdt3zFiv/37NsgJtAQwRrIA2rgRwB7cgq
	 rT70758KUI1Y5VyHS8MN+sWZzNB1iIU0Vc9c7JR9DYYFfq0Bo1a7rGn7nlgtRz4L4V
	 V7q4EpNBL5TWA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 10/27] kconfig: remove zconf_curname() and zconf_lineno()
Date: Sat,  3 Feb 2024 00:58:08 +0900
Message-Id: <20240202155825.314567-11-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240202155825.314567-1-masahiroy@kernel.org>
References: <20240202155825.314567-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now zconf_curname() and zconf_lineno() are so simple that they just
return cur_filename, cur_lineno, respectively.

Remove these functions, and then use cur_filename and cur_lineno
directly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/internal.h |  3 ++
 scripts/kconfig/lexer.l    | 20 ++++---------
 scripts/kconfig/lkc.h      |  2 --
 scripts/kconfig/menu.c     |  4 +--
 scripts/kconfig/parser.y   | 59 +++++++++++++++++---------------------
 5 files changed, 37 insertions(+), 51 deletions(-)

diff --git a/scripts/kconfig/internal.h b/scripts/kconfig/internal.h
index 2f7298c21b64..788401cd5d6f 100644
--- a/scripts/kconfig/internal.h
+++ b/scripts/kconfig/internal.h
@@ -6,4 +6,7 @@ struct menu;
 
 extern struct menu *current_menu, *current_entry;
 
+extern const char *cur_filename;
+extern int cur_lineno;
+
 #endif /* INTERNAL_H */
diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index 540098435a3b..3b3893f673dc 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -23,13 +23,13 @@
 #define START_STRSIZE	16
 
 /* The Kconfig file currently being parsed.  */
-static const char *cur_filename;
+const char *cur_filename;
 
 /*
  * The line number of the current statement. This does not match yylineno.
  * yylineno is used by the lexer, while cur_lineno is used by the parser.
  */
-static int cur_lineno;
+int cur_lineno;
 
 static int prev_prev_token = T_EOL;
 static int prev_token = T_EOL;
@@ -187,7 +187,7 @@ n	[A-Za-z0-9_-]
 	\n	{
 		fprintf(stderr,
 			"%s:%d:warning: multi-line strings not supported\n",
-			zconf_curname(), zconf_lineno());
+			cur_filename, cur_lineno);
 		unput('\n');
 		BEGIN(INITIAL);
 		yylval.string = text;
@@ -423,12 +423,12 @@ void zconf_nextfile(const char *name)
 	yyin = zconf_fopen(file->name);
 	if (!yyin) {
 		fprintf(stderr, "%s:%d: can't open file \"%s\"\n",
-			zconf_curname(), zconf_lineno(), file->name);
+			cur_filename, cur_lineno, file->name);
 		exit(1);
 	}
 	yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
 
-	current_file->lineno = zconf_lineno();
+	current_file->lineno = cur_lineno;
 	file->parent = current_file;
 
 	for (iter = current_file; iter; iter = iter->parent) {
@@ -468,13 +468,3 @@ static void zconf_endfile(void)
 	current_buf = current_buf->parent;
 	free(tmp);
 }
-
-int zconf_lineno(void)
-{
-	return cur_lineno;
-}
-
-const char *zconf_curname(void)
-{
-	return cur_filename;
-}
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 8616ad83be6d..d8249052f2e3 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -36,8 +36,6 @@ void zconf_starthelp(void);
 FILE *zconf_fopen(const char *name);
 void zconf_initscan(const char *name);
 void zconf_nextfile(const char *name);
-int zconf_lineno(void);
-const char *zconf_curname(void);
 
 /* confdata.c */
 extern struct gstr autoconf_cmd;
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 2cce8b651f61..ddca95879631 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -54,7 +54,7 @@ void menu_add_entry(struct symbol *sym)
 	menu->sym = sym;
 	menu->parent = current_menu;
 	menu->file = current_file;
-	menu->lineno = zconf_lineno();
+	menu->lineno = cur_lineno;
 
 	*last_entry_ptr = menu;
 	last_entry_ptr = &menu->next;
@@ -135,7 +135,7 @@ static struct property *menu_add_prop(enum prop_type type, struct expr *expr,
 	memset(prop, 0, sizeof(*prop));
 	prop->type = type;
 	prop->file = current_file;
-	prop->lineno = zconf_lineno();
+	prop->lineno = cur_lineno;
 	prop->menu = current_entry;
 	prop->expr = expr;
 	prop->visible.expr = dep;
diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index ff68def09a2b..b9d7e26fc160 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -144,19 +144,19 @@ config_entry_start: T_CONFIG nonconst_symbol T_EOL
 {
 	$2->flags |= SYMBOL_OPTIONAL;
 	menu_add_entry($2);
-	printd(DEBUG_PARSE, "%s:%d:config %s\n", zconf_curname(), zconf_lineno(), $2->name);
+	printd(DEBUG_PARSE, "%s:%d:config %s\n", cur_filename, cur_lineno, $2->name);
 };
 
 config_stmt: config_entry_start config_option_list
 {
-	printd(DEBUG_PARSE, "%s:%d:endconfig\n", zconf_curname(), zconf_lineno());
+	printd(DEBUG_PARSE, "%s:%d:endconfig\n", cur_filename, cur_lineno);
 };
 
 menuconfig_entry_start: T_MENUCONFIG nonconst_symbol T_EOL
 {
 	$2->flags |= SYMBOL_OPTIONAL;
 	menu_add_entry($2);
-	printd(DEBUG_PARSE, "%s:%d:menuconfig %s\n", zconf_curname(), zconf_lineno(), $2->name);
+	printd(DEBUG_PARSE, "%s:%d:menuconfig %s\n", cur_filename, cur_lineno, $2->name);
 };
 
 menuconfig_stmt: menuconfig_entry_start config_option_list
@@ -165,7 +165,7 @@ menuconfig_stmt: menuconfig_entry_start config_option_list
 		current_entry->prompt->type = P_MENU;
 	else
 		zconfprint("warning: menuconfig statement without prompt");
-	printd(DEBUG_PARSE, "%s:%d:endconfig\n", zconf_curname(), zconf_lineno());
+	printd(DEBUG_PARSE, "%s:%d:endconfig\n", cur_filename, cur_lineno);
 };
 
 config_option_list:
@@ -178,15 +178,13 @@ config_option_list:
 config_option: type prompt_stmt_opt T_EOL
 {
 	menu_set_type($1);
-	printd(DEBUG_PARSE, "%s:%d:type(%u)\n",
-		zconf_curname(), zconf_lineno(),
-		$1);
+	printd(DEBUG_PARSE, "%s:%d:type(%u)\n", cur_filename, cur_lineno, $1);
 };
 
 config_option: T_PROMPT T_WORD_QUOTE if_expr T_EOL
 {
 	menu_add_prompt(P_PROMPT, $2, $3);
-	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
+	printd(DEBUG_PARSE, "%s:%d:prompt\n", cur_filename, cur_lineno);
 };
 
 config_option: default expr if_expr T_EOL
@@ -194,27 +192,26 @@ config_option: default expr if_expr T_EOL
 	menu_add_expr(P_DEFAULT, $2, $3);
 	if ($1 != S_UNKNOWN)
 		menu_set_type($1);
-	printd(DEBUG_PARSE, "%s:%d:default(%u)\n",
-		zconf_curname(), zconf_lineno(),
+	printd(DEBUG_PARSE, "%s:%d:default(%u)\n", cur_filename, cur_lineno,
 		$1);
 };
 
 config_option: T_SELECT nonconst_symbol if_expr T_EOL
 {
 	menu_add_symbol(P_SELECT, $2, $3);
-	printd(DEBUG_PARSE, "%s:%d:select\n", zconf_curname(), zconf_lineno());
+	printd(DEBUG_PARSE, "%s:%d:select\n", cur_filename, cur_lineno);
 };
 
 config_option: T_IMPLY nonconst_symbol if_expr T_EOL
 {
 	menu_add_symbol(P_IMPLY, $2, $3);
-	printd(DEBUG_PARSE, "%s:%d:imply\n", zconf_curname(), zconf_lineno());
+	printd(DEBUG_PARSE, "%s:%d:imply\n", cur_filename, cur_lineno);
 };
 
 config_option: T_RANGE symbol symbol if_expr T_EOL
 {
 	menu_add_expr(P_RANGE, expr_alloc_comp(E_RANGE,$2, $3), $4);
-	printd(DEBUG_PARSE, "%s:%d:range\n", zconf_curname(), zconf_lineno());
+	printd(DEBUG_PARSE, "%s:%d:range\n", cur_filename, cur_lineno);
 };
 
 config_option: T_MODULES T_EOL
@@ -234,7 +231,7 @@ choice: T_CHOICE word_opt T_EOL
 	menu_add_entry(sym);
 	menu_add_expr(P_CHOICE, NULL, NULL);
 	free($2);
-	printd(DEBUG_PARSE, "%s:%d:choice\n", zconf_curname(), zconf_lineno());
+	printd(DEBUG_PARSE, "%s:%d:choice\n", cur_filename, cur_lineno);
 };
 
 choice_entry: choice choice_option_list
@@ -246,7 +243,7 @@ choice_end: end
 {
 	if (zconf_endtoken($1, "choice")) {
 		menu_end_menu();
-		printd(DEBUG_PARSE, "%s:%d:endchoice\n", zconf_curname(), zconf_lineno());
+		printd(DEBUG_PARSE, "%s:%d:endchoice\n", cur_filename, cur_lineno);
 	}
 };
 
@@ -263,27 +260,25 @@ choice_option_list:
 choice_option: T_PROMPT T_WORD_QUOTE if_expr T_EOL
 {
 	menu_add_prompt(P_PROMPT, $2, $3);
-	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
+	printd(DEBUG_PARSE, "%s:%d:prompt\n", cur_filename, cur_lineno);
 };
 
 choice_option: logic_type prompt_stmt_opt T_EOL
 {
 	menu_set_type($1);
-	printd(DEBUG_PARSE, "%s:%d:type(%u)\n",
-	       zconf_curname(), zconf_lineno(), $1);
+	printd(DEBUG_PARSE, "%s:%d:type(%u)\n", cur_filename, cur_lineno, $1);
 };
 
 choice_option: T_OPTIONAL T_EOL
 {
 	current_entry->sym->flags |= SYMBOL_OPTIONAL;
-	printd(DEBUG_PARSE, "%s:%d:optional\n", zconf_curname(), zconf_lineno());
+	printd(DEBUG_PARSE, "%s:%d:optional\n", cur_filename, cur_lineno);
 };
 
 choice_option: T_DEFAULT nonconst_symbol if_expr T_EOL
 {
 	menu_add_symbol(P_DEFAULT, $2, $3);
-	printd(DEBUG_PARSE, "%s:%d:default\n",
-	       zconf_curname(), zconf_lineno());
+	printd(DEBUG_PARSE, "%s:%d:default\n", cur_filename, cur_lineno);
 };
 
 type:
@@ -305,7 +300,7 @@ default:
 
 if_entry: T_IF expr T_EOL
 {
-	printd(DEBUG_PARSE, "%s:%d:if\n", zconf_curname(), zconf_lineno());
+	printd(DEBUG_PARSE, "%s:%d:if\n", cur_filename, cur_lineno);
 	menu_add_entry(NULL);
 	menu_add_dep($2);
 	$$ = menu_add_menu();
@@ -315,7 +310,7 @@ if_end: end
 {
 	if (zconf_endtoken($1, "if")) {
 		menu_end_menu();
-		printd(DEBUG_PARSE, "%s:%d:endif\n", zconf_curname(), zconf_lineno());
+		printd(DEBUG_PARSE, "%s:%d:endif\n", cur_filename, cur_lineno);
 	}
 };
 
@@ -331,7 +326,7 @@ menu: T_MENU T_WORD_QUOTE T_EOL
 {
 	menu_add_entry(NULL);
 	menu_add_prompt(P_MENU, $2, NULL);
-	printd(DEBUG_PARSE, "%s:%d:menu\n", zconf_curname(), zconf_lineno());
+	printd(DEBUG_PARSE, "%s:%d:menu\n", cur_filename, cur_lineno);
 };
 
 menu_entry: menu menu_option_list
@@ -343,7 +338,7 @@ menu_end: end
 {
 	if (zconf_endtoken($1, "menu")) {
 		menu_end_menu();
-		printd(DEBUG_PARSE, "%s:%d:endmenu\n", zconf_curname(), zconf_lineno());
+		printd(DEBUG_PARSE, "%s:%d:endmenu\n", cur_filename, cur_lineno);
 	}
 };
 
@@ -358,7 +353,7 @@ menu_option_list:
 
 source_stmt: T_SOURCE T_WORD_QUOTE T_EOL
 {
-	printd(DEBUG_PARSE, "%s:%d:source %s\n", zconf_curname(), zconf_lineno(), $2);
+	printd(DEBUG_PARSE, "%s:%d:source %s\n", cur_filename, cur_lineno, $2);
 	zconf_nextfile($2);
 	free($2);
 };
@@ -369,7 +364,7 @@ comment: T_COMMENT T_WORD_QUOTE T_EOL
 {
 	menu_add_entry(NULL);
 	menu_add_prompt(P_COMMENT, $2, NULL);
-	printd(DEBUG_PARSE, "%s:%d:comment\n", zconf_curname(), zconf_lineno());
+	printd(DEBUG_PARSE, "%s:%d:comment\n", cur_filename, cur_lineno);
 };
 
 comment_stmt: comment comment_option_list
@@ -384,7 +379,7 @@ comment_option_list:
 
 help_start: T_HELP T_EOL
 {
-	printd(DEBUG_PARSE, "%s:%d:help\n", zconf_curname(), zconf_lineno());
+	printd(DEBUG_PARSE, "%s:%d:help\n", cur_filename, cur_lineno);
 	zconf_starthelp();
 };
 
@@ -409,7 +404,7 @@ help: help_start T_HELPTEXT
 depends: T_DEPENDS T_ON expr T_EOL
 {
 	menu_add_dep($3);
-	printd(DEBUG_PARSE, "%s:%d:depends on\n", zconf_curname(), zconf_lineno());
+	printd(DEBUG_PARSE, "%s:%d:depends on\n", cur_filename, cur_lineno);
 };
 
 /* visibility option */
@@ -548,7 +543,7 @@ static void zconfprint(const char *err, ...)
 {
 	va_list ap;
 
-	fprintf(stderr, "%s:%d: ", zconf_curname(), zconf_lineno());
+	fprintf(stderr, "%s:%d: ", cur_filename, cur_lineno);
 	va_start(ap, err);
 	vfprintf(stderr, err, ap);
 	va_end(ap);
@@ -560,7 +555,7 @@ static void zconf_error(const char *err, ...)
 	va_list ap;
 
 	yynerrs++;
-	fprintf(stderr, "%s:%d: ", zconf_curname(), zconf_lineno());
+	fprintf(stderr, "%s:%d: ", cur_filename, cur_lineno);
 	va_start(ap, err);
 	vfprintf(stderr, err, ap);
 	va_end(ap);
@@ -569,7 +564,7 @@ static void zconf_error(const char *err, ...)
 
 static void yyerror(const char *err)
 {
-	fprintf(stderr, "%s:%d: %s\n", zconf_curname(), zconf_lineno(), err);
+	fprintf(stderr, "%s:%d: %s\n", cur_filename, cur_lineno, err);
 }
 
 static void print_quoted_string(FILE *out, const char *str)
-- 
2.40.1


