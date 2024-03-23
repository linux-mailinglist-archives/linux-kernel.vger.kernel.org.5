Return-Path: <linux-kernel+bounces-112264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B142088779C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D003282DEE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43CE12E6C;
	Sat, 23 Mar 2024 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjuXp1ve"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DA710A12;
	Sat, 23 Mar 2024 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711183872; cv=none; b=Ib5iaYvrNKeFnbo865A/Yfhregc9htYR5pAoAwvUHck/unnxQjUIq1Y2fLW3dJUi+OFGRBv7qXlr3OkShCjeNKmvFU6RntQdykNhN/H83lRYSFSMYnjo/oz61ibSUWty9IF4jxPvqWsiOEy1ptOqbqc5Rt6oZ6utpWP/0Qs3UVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711183872; c=relaxed/simple;
	bh=zfLnYeFgwKkzf5JLdkTcYYgqamTkgAlOJE3OoS7bI94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bgDG8A0I4slI/Sb6I8iionwWLXY1EbQe9EbVMI8GKG5NSf5uHg/xp7SMoBEDLIkp9EBhHWgQ+1whDllIoR+YO94X/7vhlJySwsfPDubEcFQ4HPHf3nO4VCAHxjyNZ5bldKSG1r1k+7II4fUnLJxlizE5HaGDA+QwPbIAlYqcDss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjuXp1ve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4B0C433C7;
	Sat, 23 Mar 2024 08:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711183871;
	bh=zfLnYeFgwKkzf5JLdkTcYYgqamTkgAlOJE3OoS7bI94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JjuXp1ve/JakHuVnvvu1WD23250epggW+0vV6IYf1vm3wg8adVjuomqJDjyOUdkct
	 /NGwhcmHq1//PxkCHbRhnaWTAVSaQTh0u8XQS8+eSqHHdZi5PrmhMM0wMvG5q/k/5W
	 4jmM+m2sE6oZKRc177aZt7K7tR+HokHVgqR0qsB6v7Rm5KoXhn3jYuz+0n7oka5ToO
	 D9ev1fwjDI3Lba3owi3YHhYTVgxA83tQPtKgFv5vpit+aq1nwNfXkP66PyuVC/p31R
	 vSLSkfZM9gbJla5O+ZR/QqsDIWJ7H2I4i/1q+vhvloP1wNZGrrRq8RXD32pSX2rU8c
	 bwD923uAuU0Yg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] kconfig: do not reparent the menu inside a choice block
Date: Sat, 23 Mar 2024 17:51:01 +0900
Message-Id: <20240323085101.1243814-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240323085101.1243814-1-masahiroy@kernel.org>
References: <20240323085101.1243814-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The boolean 'choice' is meant to list exclusively selected config
options.

You must not add a dependency between choice members, because such a
dependency would create an invisible entry.

In the followint test case, it is impossible to choose 'C'.

[Test Case 1]

  choice
          prompt "Choose one, but how to choose C?"

  config A
          bool "A"

  config B
          bool "B"

  config C
          bool "C"
          depends on A

  endchoice

Hence, Kconfig shows the following error message:

  Kconfig:1:error: recursive dependency detected!
  Kconfig:1:      choice <choice> contains symbol C
  Kconfig:10:     symbol C is part of choice A
  Kconfig:4:      symbol A is part of choice <choice>
  For a resolution refer to Documentation/kbuild/kconfig-language.rst
  subsection "Kconfig recursive dependency limitations"

However, Kconfig does not report any error for the following similar
code:

[Test Case 2]

  choice
         prompt "Choose one, but how to choose B?"

  config A
          bool "A"

  config B
          bool "B"
          depends on A

  config C
          bool "C"

  endchoice

This is because menu_finalize() reparents the menu tree, making 'B'
a submenu of 'A'.

With reparenting, the menu tree:

  choice
   |- A
   |- B
   \- C

.. will be transformed into the following structure:

  choice
   |- A
   |  \- B
   \- C

Consequently, Kconfig considers only 'A' and 'C' as choice members.
This behavior is awkward. The second test case should be an error too.

Now, let's stop reparenting inside a choice.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/conf.c   |  5 -----
 scripts/kconfig/lkc.h    |  2 +-
 scripts/kconfig/menu.c   | 22 ++++++++++++++++------
 scripts/kconfig/parser.y |  2 +-
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index b5730061872b..965bb40c50e5 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -552,11 +552,6 @@ static int conf_choice(struct menu *menu)
 			continue;
 		}
 		sym_set_tristate_value(child->sym, yes);
-		for (child = child->list; child; child = child->next) {
-			indent += 2;
-			conf(child);
-			indent -= 2;
-		}
 		return 1;
 	}
 }
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index e69d7c59d930..e7cc9e985c4f 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -89,7 +89,7 @@ void menu_add_visibility(struct expr *dep);
 struct property *menu_add_prompt(enum prop_type type, char *prompt, struct expr *dep);
 void menu_add_expr(enum prop_type type, struct expr *expr, struct expr *dep);
 void menu_add_symbol(enum prop_type type, struct symbol *sym, struct expr *dep);
-void menu_finalize(struct menu *parent);
+void menu_finalize(void);
 void menu_set_type(int type);
 
 extern struct menu rootmenu;
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 8498481e6afe..3b822cd110f4 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -282,7 +282,7 @@ static void sym_check_prop(struct symbol *sym)
 	}
 }
 
-void menu_finalize(struct menu *parent)
+static void _menu_finalize(struct menu *parent, bool inside_choice)
 {
 	struct menu *menu, *last_menu;
 	struct symbol *sym;
@@ -296,7 +296,12 @@ void menu_finalize(struct menu *parent)
 		 * and propagate parent dependencies before moving on.
 		 */
 
-		if (sym && sym_is_choice(sym)) {
+		bool is_choice = false;
+
+		if (sym && sym_is_choice(sym))
+			is_choice = true;
+
+		if (is_choice) {
 			if (sym->type == S_UNKNOWN) {
 				/* find the first choice value to find out choice type */
 				current_entry = parent;
@@ -394,7 +399,7 @@ void menu_finalize(struct menu *parent)
 			}
 		}
 
-		if (sym && sym_is_choice(sym))
+		if (is_choice)
 			expr_free(parentdep);
 
 		/*
@@ -402,8 +407,8 @@ void menu_finalize(struct menu *parent)
 		 * moving on
 		 */
 		for (menu = parent->list; menu; menu = menu->next)
-			menu_finalize(menu);
-	} else if (sym) {
+			_menu_finalize(menu, is_choice);
+	} else if (!inside_choice && sym) {
 		/*
 		 * Automatic submenu creation. If sym is a symbol and A, B, C,
 		 * ... are consecutive items (symbols, menus, ifs, etc.) that
@@ -463,7 +468,7 @@ void menu_finalize(struct menu *parent)
 			/* Superset, put in submenu */
 			expr_free(dep2);
 		next:
-			menu_finalize(menu);
+			_menu_finalize(menu, false);
 			menu->parent = parent;
 			last_menu = menu;
 		}
@@ -582,6 +587,11 @@ void menu_finalize(struct menu *parent)
 	}
 }
 
+void menu_finalize(void)
+{
+	_menu_finalize(&rootmenu, false);
+}
+
 bool menu_has_prompt(struct menu *menu)
 {
 	if (!menu->prompt)
diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index b45bfaf0a02b..7fb996612c96 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -515,7 +515,7 @@ void conf_parse(const char *name)
 		menu_add_prompt(P_MENU, "Main menu", NULL);
 	}
 
-	menu_finalize(&rootmenu);
+	menu_finalize();
 
 	menu = &rootmenu;
 	while (menu) {
-- 
2.40.1


