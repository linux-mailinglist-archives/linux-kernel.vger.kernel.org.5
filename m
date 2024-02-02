Return-Path: <linux-kernel+bounces-50071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C518473ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0DB6B2B852
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D1214AD1E;
	Fri,  2 Feb 2024 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyfdaKcq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D60C14AD07;
	Fri,  2 Feb 2024 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889523; cv=none; b=RvoqhVaLgtpxkO14FFwlM3hFVPcgLzquhcEMX/gT0FeY8cBxOZdgMUc160bv3DgjKPGfhD3deaXXkPf6IusVOM+MOw19cXQZcexYIeYAHjsEDvU80Ae52iQsounXydxIVPRHmABQoHTUFYHq6B1rxcczP4tDL63s57nZOvMnoVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889523; c=relaxed/simple;
	bh=wpEp8jr15Z5cgoxaTgBZwBu3BqThuXxxzR4c/RRAaAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BzuiSEDWgeThtnFb5yPm2h4Xp98YztDWMXFTOp7W1vvzEWP4r/jSBDO6H8GBat0w4TqfWkPrx/+tD8nRk27Y/B8T5YZBErjeVZvvVlVV8ebqbn2sFzVa6H5grAiw7sX9XXrcl9Jy8fr14zTPI//KI7nOAxEAziwOdOmeaBFC/sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyfdaKcq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14412C43394;
	Fri,  2 Feb 2024 15:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889522;
	bh=wpEp8jr15Z5cgoxaTgBZwBu3BqThuXxxzR4c/RRAaAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hyfdaKcqQxLrNJo8GO3fCAQwWA2hLH6RKVOD9Yek0w0JvBTyi0Wr6x8T0I/GBZnVl
	 M3G+Sn7WXe1yuNQVzLl7zOEDh7l4xyJBBFL9Gj3VSZu+SFEfw9lq8h3VUCKZWjABzM
	 GYRyLDk2OgBcQOLV6qxx34vA3S8c/8UcrF6k4hqYXKl0bhFtKPp4n1E44Up2/PBsfD
	 vSqH8WQ8jMxgVZqnvoEnwWjTdaUDUGmQeGVDlVZifUCQHPMteja/qqEpnA/MFGlyg+
	 4Hqa6qLughKdhv8jbpdZA9VK1Zi5xh4jkmBJRkjNdpL8nwgUVF6JZ5FYYylyFXFQ2U
	 YA/LanjiXGH/A==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 11/27] kconfig: associate struct menu with file name directly
Date: Sat,  3 Feb 2024 00:58:09 +0900
Message-Id: <20240202155825.314567-12-masahiroy@kernel.org>
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

struct menu is linked to struct file for diagnostic purposes.
It is always used to retrieve the file name through menu->file->name.

Associate struct menu with the file name directly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/expr.h   | 2 +-
 scripts/kconfig/menu.c   | 6 +++---
 scripts/kconfig/parser.y | 6 +++---
 scripts/kconfig/qconf.cc | 2 +-
 scripts/kconfig/symbol.c | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index e0d866569155..e8fc85d98cdd 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -256,7 +256,7 @@ struct menu {
 	char *help;
 
 	/* The location where the menu node appears in the Kconfig files */
-	struct file *file;
+	const char *filename;
 	int lineno;
 
 	/* For use by front ends that need to store auxiliary data */
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index ddca95879631..5ad4d2b9fb82 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -23,7 +23,7 @@ void menu_warn(struct menu *menu, const char *fmt, ...)
 {
 	va_list ap;
 	va_start(ap, fmt);
-	fprintf(stderr, "%s:%d:warning: ", menu->file->name, menu->lineno);
+	fprintf(stderr, "%s:%d:warning: ", menu->filename, menu->lineno);
 	vfprintf(stderr, fmt, ap);
 	fprintf(stderr, "\n");
 	va_end(ap);
@@ -53,7 +53,7 @@ void menu_add_entry(struct symbol *sym)
 	memset(menu, 0, sizeof(*menu));
 	menu->sym = sym;
 	menu->parent = current_menu;
-	menu->file = current_file;
+	menu->filename = cur_filename;
 	menu->lineno = cur_lineno;
 
 	*last_entry_ptr = menu;
@@ -676,7 +676,7 @@ struct menu *menu_get_parent_menu(struct menu *menu)
 static void get_def_str(struct gstr *r, struct menu *menu)
 {
 	str_printf(r, "Defined at %s:%d\n",
-		   menu->file->name, menu->lineno);
+		   menu->filename, menu->lineno);
 }
 
 static void get_dep_str(struct gstr *r, struct expr *expr, const char *prefix)
diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index b9d7e26fc160..d1d05c8cd89d 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -101,7 +101,7 @@ struct menu *current_menu, *current_entry;
 
 %destructor {
 	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
-		$$->file->name, $$->lineno);
+		$$->filename, $$->lineno);
 	if (current_menu == $$)
 		menu_end_menu();
 } if_entry menu_entry choice_entry
@@ -527,11 +527,11 @@ static bool zconf_endtoken(const char *tokenname,
 		yynerrs++;
 		return false;
 	}
-	if (current_menu->file != current_file) {
+	if (strcmp(current_menu->filename, cur_filename)) {
 		zconf_error("'%s' in different file than '%s'",
 			    tokenname, expected_tokenname);
 		fprintf(stderr, "%s:%d: location of the '%s'\n",
-			current_menu->file->name, current_menu->lineno,
+			current_menu->filename, current_menu->lineno,
 			expected_tokenname);
 		yynerrs++;
 		return false;
diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 620a3527c767..c6c42c0f4e5d 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1058,7 +1058,7 @@ void ConfigInfoView::menuInfo(void)
 				stream << "<br><br>";
 			}
 
-			stream << "defined at " << _menu->file->name << ":"
+			stream << "defined at " << _menu->filename << ":"
 			       << _menu->lineno << "<br><br>";
 		}
 	}
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index e9e9fb8d8674..7647e3e87cd5 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -1045,12 +1045,12 @@ static void sym_check_print_recursive(struct symbol *last_sym)
 
 		if (sym_is_choice(sym)) {
 			fprintf(stderr, "%s:%d:\tchoice %s contains symbol %s\n",
-				menu->file->name, menu->lineno,
+				menu->filename, menu->lineno,
 				sym->name ? sym->name : "<choice>",
 				next_sym->name ? next_sym->name : "<choice>");
 		} else if (sym_is_choice_value(sym)) {
 			fprintf(stderr, "%s:%d:\tsymbol %s is part of choice %s\n",
-				menu->file->name, menu->lineno,
+				menu->filename, menu->lineno,
 				sym->name ? sym->name : "<choice>",
 				next_sym->name ? next_sym->name : "<choice>");
 		} else if (stack->expr == &sym->dir_dep.expr) {
-- 
2.40.1


