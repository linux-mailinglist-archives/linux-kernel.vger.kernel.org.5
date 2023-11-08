Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCD97E4EDF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjKHC1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjKHC1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:27:43 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8033D10FC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 18:27:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-daa2684f67eso293153276.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 18:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699410460; x=1700015260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fjSw5yMl7Zaa3WfnbuzU7Ubg5vKwHRFX37791b+j1Dg=;
        b=o7CsKyGSxOpTDdFkIJwH71y9b4XkH/VOQPKrVtsHv2drdvXm1PTy695u3fblFpByx9
         CMLSzvQVLHBTTOTF6Bg8vmDIbDsjMR37C/Qt6UoLxYtHH3baTDPTCQvxIFMTjlmNJBdF
         Uf3gnK+BM4WIV0XZLGtzueMffaf9H6CJkGteFaKGT5Cvn4Bsk5KwlDkWNEiISvJSvv7l
         EjIAwrT9Z6fwOvyXEybIjEO5qWTRE9eXsKsdhXXfol+8r/EuPSKorf2oV1OH2eKn2B7S
         UMbaBc32en/35JH4feYpoiLFhIDxHQq4k4qJZNIw1zx+/wkQT4G1i5MsU0KsWEtFTT/S
         ax6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699410460; x=1700015260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjSw5yMl7Zaa3WfnbuzU7Ubg5vKwHRFX37791b+j1Dg=;
        b=boo4sg1EJHHVRIY+MLcqICS27BN8nrOZiIdNrpJPjosE+4nQ758CU9xjWRc2hzb45z
         INEKpZxVNIoP+YBOk/QIgAz83gBTnVZ9NI8cZon/tWFJsaDnoDVHKy2madZRhCvF6Db1
         zeDAOMt2bjTOekHghaxOVy7WIPK8PVteRWYjlDSSeC1PDFsGK7MzjRvquHY30NQSbiLP
         Jixw8YnZK8xLrXgXEiHM9t1NaP+XEDsgzBkDI9L+C6VwQBEM+X/lszZkITaUurwYZKzM
         6SxiGc80h9S79awZXqQsZSX3W2korSIcaI3DWG72BDjs6S8/CGOMcdXiW+CK962cVBE7
         46hg==
X-Gm-Message-State: AOJu0YyBCMyp30qpSOF9xZbDgamUDTGrQtosukRfUje77kraoGI42lTj
        lJNEVwKBGySncZnHmcQhAShR+URWnLNu
X-Google-Smtp-Source: AGHT+IHldxiMAIxZ5HAkJMuR1XTXLNZhYZ7h25Ivz/3x1GBY7LjNMDFpllxOewqbgHrqtaVX0ZmrznabXIJi
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:5d1:0:b0:d9c:f811:eb9e with SMTP id
 200-20020a2505d1000000b00d9cf811eb9emr10751ybf.4.1699410460764; Tue, 07 Nov
 2023 18:27:40 -0800 (PST)
Date:   Wed,  8 Nov 2023 02:26:24 +0000
In-Reply-To: <20231108022651.645950-2-mmaurer@google.com>
Mime-Version: 1.0
References: <20231108022651.645950-2-mmaurer@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108022651.645950-5-mmaurer@google.com>
Subject: [PATCH 2/3] kconfig: Add special rust_modules config option
From:   Matthew Maurer <mmaurer@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, Matthew Maurer <mmaurer@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for the rust_modules kconfig type, which works similarly to
modules, but for restricting or allowing the use of modules which
directly depend on Rust.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 scripts/kconfig/confdata.c |  3 +++
 scripts/kconfig/expr.h     |  1 +
 scripts/kconfig/lexer.l    |  1 +
 scripts/kconfig/lkc.h      |  1 +
 scripts/kconfig/menu.c     |  7 +++++--
 scripts/kconfig/parser.y   | 12 ++++++++++++
 scripts/kconfig/symbol.c   | 31 +++++++++++++++++++++++++++++--
 7 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 4a6811d77d18..f5e2dcb56e1c 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -549,10 +549,12 @@ int conf_read(const char *name)
 
 	if (conf_read_simple(name, S_DEF_USER)) {
 		sym_calc_value(modules_sym);
+		sym_calc_value(modules_rust_sym);
 		return 1;
 	}
 
 	sym_calc_value(modules_sym);
+	sym_calc_value(modules_rust_sym);
 
 	for_all_symbols(i, sym) {
 		sym_calc_value(sym);
@@ -1090,6 +1092,7 @@ static int conf_touch_deps(void)
 
 	conf_read_simple(name, S_DEF_AUTO);
 	sym_calc_value(modules_sym);
+	sym_calc_value(modules_rust_sym);
 
 	for_all_symbols(i, sym) {
 		sym_calc_value(sym);
diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index edfe3046d050..6b576fbc330e 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -283,6 +283,7 @@ struct file *lookup_file(const char *name);
 
 extern struct symbol symbol_yes, symbol_no, symbol_mod;
 extern struct symbol *modules_sym;
+extern struct symbol *modules_rust_sym;
 extern int cdebug;
 struct expr *expr_alloc_symbol(struct symbol *sym);
 struct expr *expr_alloc_one(enum expr_type type, struct expr *ce);
diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index cc386e443683..d6c7fd11f07e 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -114,6 +114,7 @@ n	[A-Za-z0-9_-]
 "optional"		return T_OPTIONAL;
 "prompt"		return T_PROMPT;
 "range"			return T_RANGE;
+"rust_modules"		return T_MODULES_RUST;
 "select"		return T_SELECT;
 "source"		return T_SOURCE;
 "string"		return T_STRING;
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 471a59acecec..ea97ff25909e 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -108,6 +108,7 @@ void menu_get_ext_help(struct menu *menu, struct gstr *help);
 /* symbol.c */
 void sym_clear_all_valid(void);
 struct symbol *sym_choice_default(struct symbol *sym);
+bool sym_depends_rust(struct symbol *sym);
 struct property *sym_get_range_prop(struct symbol *sym);
 const char *sym_get_string_default(struct symbol *sym);
 struct symbol *sym_check_deps(struct symbol *sym);
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index d5898cd6aeb8..10a115f3a450 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -96,8 +96,11 @@ static struct expr *rewrite_m(struct expr *e)
 		break;
 	case E_SYMBOL:
 		/* change 'm' into 'm' && MODULES */
-		if (e->left.sym == &symbol_mod)
-			return expr_alloc_and(e, expr_alloc_symbol(modules_sym));
+		if (e->left.sym == &symbol_mod) {
+			if (sym_depends_rust(e->left.sym))
+				e = expr_alloc_and(e, expr_alloc_symbol(modules_rust_sym));
+			e = expr_alloc_and(e, expr_alloc_symbol(modules_sym));
+		}
 		break;
 	default:
 		break;
diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index 2af7ce4e1531..37d9e390f545 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -68,6 +68,7 @@ struct menu *current_menu, *current_entry;
 %token T_MENU
 %token T_MENUCONFIG
 %token T_MODULES
+%token T_MODULES_RUST
 %token T_ON
 %token T_OPEN_PAREN
 %token T_OPTIONAL
@@ -224,6 +225,15 @@ config_option: T_MODULES T_EOL
 	modules_sym = current_entry->sym;
 };
 
+config_option: T_MODULES_RUST T_EOL
+{
+	if (modules_rust_sym)
+		zconf_error("symbol '%s' redefines option 'rust_modules' already defined by symbol '%s'",
+			    current_entry->sym->name, modules_rust_sym->name);
+	modules_rust_sym = current_entry->sym;
+};
+
+
 /* choice entry */
 
 choice: T_CHOICE word_opt T_EOL
@@ -495,6 +505,8 @@ void conf_parse(const char *name)
 		exit(1);
 	if (!modules_sym)
 		modules_sym = sym_find( "n" );
+	if (!modules_rust_sym)
+		modules_rust_sym = sym_find( "n" );
 
 	if (!menu_has_prompt(&rootmenu)) {
 		current_entry = &rootmenu;
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 0572330bf8a7..d48fbde936d1 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -38,6 +38,18 @@ static struct symbol symbol_empty = {
 struct symbol *modules_sym;
 static tristate modules_val;
 
+struct symbol *modules_rust_sym;
+static tristate modules_rust_val;
+
+bool sym_depends_rust(struct symbol *sym)
+{
+	static struct symbol *rust_sym;
+
+	if (!rust_sym)
+		rust_sym = sym_find("RUST");
+	return expr_depends_symbol(sym->dir_dep.expr, rust_sym, true);
+}
+
 enum symbol_type sym_get_type(struct symbol *sym)
 {
 	enum symbol_type type = sym->type;
@@ -47,6 +59,8 @@ enum symbol_type sym_get_type(struct symbol *sym)
 			type = S_BOOLEAN;
 		else if (modules_val == no)
 			type = S_BOOLEAN;
+		else if ((modules_rust_val == no) && sym_depends_rust(sym))
+			type = S_BOOLEAN;
 	}
 	return type;
 }
@@ -443,6 +457,10 @@ void sym_calc_value(struct symbol *sym)
 			sym_set_all_changed();
 			modules_val = modules_sym->curr.tri;
 		}
+		if (modules_rust_sym == sym) {
+			sym_set_all_changed();
+			modules_rust_val = modules_rust_sym->curr.tri;
+		}
 	}
 
 	if (sym_is_choice(sym)) {
@@ -474,6 +492,7 @@ void sym_clear_all_valid(void)
 		sym->flags &= ~SYMBOL_VALID;
 	conf_set_changed(true);
 	sym_calc_value(modules_sym);
+	sym_calc_value(modules_rust_sym);
 }
 
 bool sym_tristate_within_range(struct symbol *sym, tristate val)
@@ -704,6 +723,7 @@ const char *sym_get_string_default(struct symbol *sym)
 
 	sym_calc_visibility(sym);
 	sym_calc_value(modules_sym);
+	sym_calc_value(modules_rust_sym);
 	val = symbol_no.curr.tri;
 	str = symbol_empty.curr.val;
 
@@ -734,9 +754,12 @@ const char *sym_get_string_default(struct symbol *sym)
 	val = EXPR_OR(val, sym->rev_dep.tri);
 
 	/* transpose mod to yes if modules are not enabled */
-	if (val == mod)
-		if (!sym_is_choice_value(sym) && modules_sym->curr.tri == no)
+	if ((val == mod) && !sym_is_choice_value(sym)) {
+		if (modules_sym->curr.tri == no)
+			val = yes;
+		if ((modules_rust_sym->curr.tri == no) && sym_depends_rust(sym))
 			val = yes;
+	}
 
 	/* transpose mod to yes if type is bool */
 	if (sym->type == S_BOOLEAN && val == mod)
@@ -778,7 +801,11 @@ const char *sym_get_string_value(struct symbol *sym)
 			return "n";
 		case mod:
 			sym_calc_value(modules_sym);
+			sym_calc_value(modules_rust_sym);
+			if (sym_depends_rust(sym))
+				return (modules_rust_sym->curr.tri == no) ? "n" : "m";
 			return (modules_sym->curr.tri == no) ? "n" : "m";
+
 		case yes:
 			return "y";
 		}
-- 
2.42.0.869.gea05f2083d-goog

