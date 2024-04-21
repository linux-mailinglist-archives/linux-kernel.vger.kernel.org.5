Return-Path: <linux-kernel+bounces-152465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB018ABED8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 11:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F0E1C20949
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 09:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4227210A3E;
	Sun, 21 Apr 2024 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4JmH+p8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D87710940;
	Sun, 21 Apr 2024 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713690180; cv=none; b=Ckjbwrg4NBD1X0pyrlwvmPVpM1kEZDxwKsCf3Zv8uuaWpakOMkWkQ/T+rAVWcZ+tE0CbFhpRGjz/F3tjyDy6eO5KQqg10LsUbHaVGatz4yWWEIJkkxZHPfUl26wbgMngoSVXPzFAA2cOYrjOyt4BBSaX1WzNEmeRuP4LOiJ8Gu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713690180; c=relaxed/simple;
	bh=sMkrcyPFZTw4unEKDwixdGVUFlnihGpjujBV9mFCGbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iffr2votfDW/asOLnjk3jeMaeAAKjyyDSoh+LxdrI4SEdwGNrGbXaweyJeVGYNI56vWQqTr1SeVhbDPd8aywRBWwhf/XkIzbu34BQUPC7dxbxVlS05NnVtnXoOWbUDOnuTQ0FrWZw0cilD3hspwDiw4JZ0pUCsDlxv69C4TQB1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4JmH+p8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC01AC32782;
	Sun, 21 Apr 2024 09:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713690179;
	bh=sMkrcyPFZTw4unEKDwixdGVUFlnihGpjujBV9mFCGbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4JmH+p8TO6KXue3YwPkzv9oVhTcp8QLZPr0YdFT9HSAeFaAqun3T/ys3uMpL90tH
	 Mwic9NsnkVnK8pQjfCcw6ouKToQ1f+lyAbnI6UouxXBvGptwKh25aHzyV6QQxmhY7x
	 sslV/4kjAlqGDL8gKJa1EnS+VYUCrRjbsm6s22ICTvnyRNL1bIX/qL6wqc0a8ymgAn
	 av0wFNoslOAcawwrAu4N5OV5svRiwusiouJNiHUVYNMebUfBVloDdhtl2ye3yiEwkA
	 0wXYQOOdqQ6Ng1nTKKZpLpCAEkPkQD3D2+Oyz0c+ZPC2sGmc6Z15nCJF5n74ZoG3/V
	 n7WxrhpYdWrQA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] kconfig: use menu_for_each_entry() to traverse menu tree
Date: Sun, 21 Apr 2024 18:02:52 +0900
Message-Id: <20240421090252.2700867-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240421090252.2700867-1-masahiroy@kernel.org>
References: <20240421090252.2700867-1-masahiroy@kernel.org>
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

 scripts/kconfig/confdata.c | 28 +++++-----------------------
 scripts/kconfig/parser.y   | 13 +------------
 2 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 0e35c4819cf1..ce0ef417b71b 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -793,23 +793,19 @@ int conf_write_defconfig(const char *filename)
 
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
@@ -827,25 +823,11 @@ int conf_write_defconfig(const char *filename)
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
index 7fb996612c96..8f339b47fe8d 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -517,20 +517,9 @@ void conf_parse(const char *name)
 
 	menu_finalize();
 
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


