Return-Path: <linux-kernel+bounces-50072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BF38473EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F68B2690F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C021D14AD2D;
	Fri,  2 Feb 2024 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haZEUMwo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0083314AD17;
	Fri,  2 Feb 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889524; cv=none; b=MG6skY22OZ76jO0rLClWViiGwSWXs4IG7/JieSuqbVI8wp2Ag+iyMWGnpf/eFsrsj04L/VR0i2Ye7XaxQRNyEteQ3Y9LHhR61vkrVfbyQFs1PYqXv1wLv9VkWRh/UGSwJhEhYeMY90vaTE9o0A13fZRgXSq9PlmrvHshsbI0Jeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889524; c=relaxed/simple;
	bh=gxW0tHjrvGhvoRdxh0sVyK7nLpSQS+pdJ3RujiPPaL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i1xKyf51bpgxxbrfrpDaznc+B0puwNgrOLBseI6OcISVL42sQvyic2Ty05zu+nlm9+3kMNzrmiT0kpJuVBtEmNaqDA5RnyI3xfp7BuFoTtmJc46wGQGsSXeRhqGufZj5DokQ4p22BpcIG4nq0N+Q9l6ux+rnMZUWv0+KSvm7Kfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haZEUMwo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF78C433C7;
	Fri,  2 Feb 2024 15:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889523;
	bh=gxW0tHjrvGhvoRdxh0sVyK7nLpSQS+pdJ3RujiPPaL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=haZEUMwoK2qxyOJAE+WGgjaRtCm2pJJSqqFFaOAutj0bG88g+6wRlPQqUJsaKOjho
	 sJ5q8YkizICQyuM6iy/ibz2PR5eT7sIZYPVROWbeAlDPal6ev/DUJRhOIs7MZuWCTN
	 z3ZCPFcP7rTtGFZylp5Lce3S0Yxpuj3lJju4ho5cf4j5kstVpUITCMNvpX2DHxZjsY
	 6gxP3/s5LbXCxUjvhF/QiMkzHBGNXsiGNhvHpBWiQntJ1II2SZY9zJf59uAkV50JZJ
	 FwpVEnypXXQ4EGtXP3nBV+R/zReZNiLh0mcekvV5vU5lVR3ZFa8w9qXBDYqb1Hwoaq
	 hrgOdTIp0+HQA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 12/27] kconfig: associate struct property with file name directly
Date: Sat,  3 Feb 2024 00:58:10 +0900
Message-Id: <20240202155825.314567-13-masahiroy@kernel.org>
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

struct property is linked to struct file for diagnostic purposes.
It is always used to retrieve the file name through prop->file->name.

Associate struct property with the file name directly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/expr.h   |  2 +-
 scripts/kconfig/menu.c   |  4 ++--
 scripts/kconfig/symbol.c | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index e8fc85d98cdd..037db39c5bf0 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -195,7 +195,7 @@ struct property {
 	struct menu *menu;         /* the menu the property are associated with
 	                            * valid for: P_SELECT, P_RANGE, P_CHOICE,
 	                            * P_PROMPT, P_DEFAULT, P_MENU, P_COMMENT */
-	struct file *file;         /* what file was this property defined */
+	const char *filename;      /* what file was this property defined */
 	int lineno;                /* what lineno was this property defined */
 };
 
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 5ad4d2b9fb82..0ded0b1830d0 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -33,7 +33,7 @@ static void prop_warn(struct property *prop, const char *fmt, ...)
 {
 	va_list ap;
 	va_start(ap, fmt);
-	fprintf(stderr, "%s:%d:warning: ", prop->file->name, prop->lineno);
+	fprintf(stderr, "%s:%d:warning: ", prop->filename, prop->lineno);
 	vfprintf(stderr, fmt, ap);
 	fprintf(stderr, "\n");
 	va_end(ap);
@@ -134,7 +134,7 @@ static struct property *menu_add_prop(enum prop_type type, struct expr *expr,
 	prop = xmalloc(sizeof(*prop));
 	memset(prop, 0, sizeof(*prop));
 	prop->type = type;
-	prop->file = current_file;
+	prop->filename = cur_filename;
 	prop->lineno = cur_lineno;
 	prop->menu = current_entry;
 	prop->expr = expr;
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 7647e3e87cd5..dae630a74e50 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -1041,7 +1041,7 @@ static void sym_check_print_recursive(struct symbol *last_sym)
 		}
 		if (stack->sym == last_sym)
 			fprintf(stderr, "%s:%d:error: recursive dependency detected!\n",
-				prop->file->name, prop->lineno);
+				prop->filename, prop->lineno);
 
 		if (sym_is_choice(sym)) {
 			fprintf(stderr, "%s:%d:\tchoice %s contains symbol %s\n",
@@ -1055,28 +1055,28 @@ static void sym_check_print_recursive(struct symbol *last_sym)
 				next_sym->name ? next_sym->name : "<choice>");
 		} else if (stack->expr == &sym->dir_dep.expr) {
 			fprintf(stderr, "%s:%d:\tsymbol %s depends on %s\n",
-				prop->file->name, prop->lineno,
+				prop->filename, prop->lineno,
 				sym->name ? sym->name : "<choice>",
 				next_sym->name ? next_sym->name : "<choice>");
 		} else if (stack->expr == &sym->rev_dep.expr) {
 			fprintf(stderr, "%s:%d:\tsymbol %s is selected by %s\n",
-				prop->file->name, prop->lineno,
+				prop->filename, prop->lineno,
 				sym->name ? sym->name : "<choice>",
 				next_sym->name ? next_sym->name : "<choice>");
 		} else if (stack->expr == &sym->implied.expr) {
 			fprintf(stderr, "%s:%d:\tsymbol %s is implied by %s\n",
-				prop->file->name, prop->lineno,
+				prop->filename, prop->lineno,
 				sym->name ? sym->name : "<choice>",
 				next_sym->name ? next_sym->name : "<choice>");
 		} else if (stack->expr) {
 			fprintf(stderr, "%s:%d:\tsymbol %s %s value contains %s\n",
-				prop->file->name, prop->lineno,
+				prop->filename, prop->lineno,
 				sym->name ? sym->name : "<choice>",
 				prop_get_type_name(prop->type),
 				next_sym->name ? next_sym->name : "<choice>");
 		} else {
 			fprintf(stderr, "%s:%d:\tsymbol %s %s is visible depending on %s\n",
-				prop->file->name, prop->lineno,
+				prop->filename, prop->lineno,
 				sym->name ? sym->name : "<choice>",
 				prop_get_type_name(prop->type),
 				next_sym->name ? next_sym->name : "<choice>");
-- 
2.40.1


