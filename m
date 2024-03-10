Return-Path: <linux-kernel+bounces-98246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC92D877752
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 15:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D22CB21623
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8B238394;
	Sun, 10 Mar 2024 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umV6OlMc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F6376FE;
	Sun, 10 Mar 2024 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710080188; cv=none; b=Hn5tiMlYTXqeFd5zCzIFvS4oEmBEImnilbz5f2j06gLUN8JiSP/eRIyP4zJrRNo+EsZLjytWc8ZdGBHWqpQQUkD0kSmp6NkNcfaqkG28uspgoc0LoG3j+nOseyCF6bVLFa74qEeiFlnEhGFItFccMQPv07aBCAwGdQbFiZIJESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710080188; c=relaxed/simple;
	bh=7vHRaqub7OyWr23f8EkYfPHp+c5k770mXy9fDSYLW7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=efiomIrhUaPbnbghybKERTORxmRx4k28Vf1jX1bWpbL1+CdNVOSqiD5LfctWbVynp8XSLSOj8w2v4K72ywwC5AHrvtddQtluuec5bufC5q3xwABSRPmb5hxK4vYBGMS1wknJcgu9lL3JDK4AmZ9A6KCP0ly4Spl/mWlnHinWlBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umV6OlMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E475FC433F1;
	Sun, 10 Mar 2024 14:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710080187;
	bh=7vHRaqub7OyWr23f8EkYfPHp+c5k770mXy9fDSYLW7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=umV6OlMcWsSGI86w0sG3Xcw+0gRNusmwvmRktKRlAhxtM8k8mwVdfEUBi087Zx1fa
	 BPb1z1SzDNv/kC7z6SWhT/DTm2DJ9PbcETLoCUU6bo5bh5EwNUJDblT3MsIkHSPhgf
	 ljt6y4CUTLqJN/qtvCt73tzDZcKUW0FzjvHGrgeRXvnleK+Rm1yJpUsrrvGrtY3AFy
	 pTQTRhjOS2qCa+zhrRdd8ybqDyQyjaFgPUlkHb5Dolal1Lvjzai3RsAhoRdnoAtOuy
	 +pFBDgr2T793Rl/PcHu4fz5FUvEyTi4TSdcik9gm3YaOAL/Ix7bZZvfRbfN662Wmne
	 8Udf029VIDhSw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/3] kconfig: use menu_for_each_entry() to traverse menu tree
Date: Sun, 10 Mar 2024 23:16:19 +0900
Message-Id: <20240310141619.606415-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240310141619.606415-1-masahiroy@kernel.org>
References: <20240310141619.606415-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use menu_for_each_entry() to traverse the menu tree instead of
implementing similar logic in each function.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/confdata.c | 29 +++++------------------------
 scripts/kconfig/parser.y   | 15 +--------------
 2 files changed, 6 insertions(+), 38 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 0e35c4819cf1..16066730a6a0 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -784,7 +784,6 @@ static void print_symbol_for_rustccfg(FILE *fp, struct symbol *sym)
 int conf_write_defconfig(const char *filename)
 {
 	struct symbol *sym;
-	struct menu *menu;
 	FILE *out;
 
 	out = fopen(filename, "w");
@@ -793,23 +792,19 @@ int conf_write_defconfig(const char *filename)
 
 	sym_clear_all_valid();
 
-	/* Traverse all menus to find all relevant symbols */
-	menu = rootmenu.list;
-
-	while (menu != NULL)
-	{
+	menu_for_each_entry(menu) {
 		sym = menu->sym;
 		if (sym && !sym_is_choice(sym)) {
 			sym_calc_value(sym);
 			if (!(sym->flags & SYMBOL_WRITE))
-				goto next_menu;
+				continue;
 			sym->flags &= ~SYMBOL_WRITE;
 			/* If we cannot change the symbol - skip */
 			if (!sym_is_changeable(sym))
-				goto next_menu;
+				continue;
 			/* If symbol equals to default value - skip */
 			if (strcmp(sym_get_string_value(sym), sym_get_string_default(sym)) == 0)
-				goto next_menu;
+				continue;
 
 			/*
 			 * If symbol is a choice value and equals to the
@@ -827,25 +822,11 @@ int conf_write_defconfig(const char *filename)
 				if (!sym_is_optional(cs) && sym == ds) {
 					if ((sym->type == S_BOOLEAN) &&
 					    sym_get_tristate_value(sym) == yes)
-						goto next_menu;
+						continue;
 				}
 			}
 			print_symbol_for_dotconfig(out, sym);
 		}
-next_menu:
-		if (menu->list != NULL) {
-			menu = menu->list;
-		}
-		else if (menu->next != NULL) {
-			menu = menu->next;
-		} else {
-			while ((menu = menu->parent)) {
-				if (menu->next != NULL) {
-					menu = menu->next;
-					break;
-				}
-			}
-		}
 	}
 	fclose(out);
 	return 0;
diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index b45bfaf0a02b..a69a453e4f44 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -473,8 +473,6 @@ assign_val:
 
 void conf_parse(const char *name)
 {
-	struct menu *menu;
-
 	autoconf_cmd = str_new();
 
 	str_printf(&autoconf_cmd, "\ndeps_config := \\\n");
@@ -517,20 +515,9 @@ void conf_parse(const char *name)
 
 	menu_finalize(&rootmenu);
 
-	menu = &rootmenu;
-	while (menu) {
+	menu_for_each_entry(menu) {
 		if (menu->sym && sym_check_deps(menu->sym))
 			yynerrs++;
-
-		if (menu->list) {
-			menu = menu->list;
-			continue;
-		}
-
-		while (!menu->next && menu->parent)
-			menu = menu->parent;
-
-		menu = menu->next;
 	}
 
 	if (yynerrs)
-- 
2.40.1


