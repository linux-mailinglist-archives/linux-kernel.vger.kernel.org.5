Return-Path: <linux-kernel+bounces-89647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE48786F38D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 05:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01041C210B3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 04:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DB463A1;
	Sun,  3 Mar 2024 04:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6/WB8v0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824007F;
	Sun,  3 Mar 2024 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709438440; cv=none; b=pv1I3dQhlv80NrEBqqiBWjDR273PecfH0fqAxET8gBp0/Su6k4FlvAd1hJjUyZ3kWnPiCtYMU5KAogh0BoCs5fqu0uQ4IMoDJGKCpJip7SguylhH3prMYL5S5iee44o7vEYaB864oNeh12bsKR75GF9yhtTTfkbm0WKGwoHXu5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709438440; c=relaxed/simple;
	bh=Mxd0x4K9NZGsIbjj7+JyTXQS+jqX7z7/GCh2qtsgiqY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=udCM0OeR4eI45p32Mw62yQWR4kM+gf3I1DJjqIOJuZKnf998fiQpAHuBYQB1Vf9eTsgZ44DexeTOo2sMOi/wZbWyAMjH93QF7WGa8NBE7u+VExd3PCiCsBZALQ/CtTEi0vFu4IPo8f7ET4KtN/qL0EFz6aZz6GOSx0DZwWa3ugU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6/WB8v0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB65C433F1;
	Sun,  3 Mar 2024 04:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709438440;
	bh=Mxd0x4K9NZGsIbjj7+JyTXQS+jqX7z7/GCh2qtsgiqY=;
	h=From:To:Cc:Subject:Date:From;
	b=I6/WB8v0xtfAoZ9fO/YJHz0CBTagIz671gnhuLv+pRQSDnvsYOIxdAjZ+RdzKvGpB
	 x/RXj0TYkydoeb1QXSIiPLUnSV8og78DVG6DyWtmP46FrMao3tq3J4iLKsF4BTCF7Z
	 AaruHtJujblerzweEmzLJ3qKv211MKvELXbvr30TrU0H0Fqkg4PC8snPHu8clIvJws
	 GoIWv5B9S6tiqMgiRHU/acj6TecEijtegH3EUe5xaUL2zQWQxojnfThIUEMbLnEPmW
	 VShbeYPr5HvJAslQJJZbU8QZBuX9XLrqkkwwrGSX60vFcSu0dt5mmyT4RlSbtLGVaQ
	 1mX0uNlNEd0eQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/3] kconfig: link menus to a symbol
Date: Sun,  3 Mar 2024 13:00:33 +0900
Message-Id: <20240303040035.3450914-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there is no direct link from (struct symbol *) to
(struct menu *).

It is still possible to access associated menus through the P_SYMBOL
property, because property::menu is the relevant menu entry, but it
results in complex code, as seen in get_symbol_str().

Use a linked list for simpler traversal of relevant menus.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/expr.h   | 5 +++++
 scripts/kconfig/menu.c   | 4 +++-
 scripts/kconfig/symbol.c | 4 ++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index 3bc375f1a1cd..0158f5eac454 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -108,6 +108,9 @@ struct symbol {
 	 */
 	tristate visible;
 
+	/* config entries associated with this symbol */
+	struct list_head menus;
+
 	/* SYMBOL_* flags */
 	int flags;
 
@@ -222,6 +225,8 @@ struct menu {
 	 */
 	struct symbol *sym;
 
+	struct list_head link;	/* link to symbol::menus */
+
 	/*
 	 * The prompt associated with the node. This holds the prompt for a
 	 * symbol as well as the text for a menu or comment, along with the
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 44465945d6b1..571394ed71e0 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -57,8 +57,10 @@ void menu_add_entry(struct symbol *sym)
 	*last_entry_ptr = menu;
 	last_entry_ptr = &menu->next;
 	current_entry = menu;
-	if (sym)
+	if (sym) {
 		menu_add_symbol(P_SYMBOL, sym, NULL);
+		list_add_tail(&menu->link, &sym->menus);
+	}
 }
 
 struct menu *menu_add_menu(void)
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index dd5cf9727a9a..81fe1884ef8a 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -15,18 +15,21 @@
 struct symbol symbol_yes = {
 	.name = "y",
 	.curr = { "y", yes },
+	.menus = LIST_HEAD_INIT(symbol_yes.menus),
 	.flags = SYMBOL_CONST|SYMBOL_VALID,
 };
 
 struct symbol symbol_mod = {
 	.name = "m",
 	.curr = { "m", mod },
+	.menus = LIST_HEAD_INIT(symbol_mod.menus),
 	.flags = SYMBOL_CONST|SYMBOL_VALID,
 };
 
 struct symbol symbol_no = {
 	.name = "n",
 	.curr = { "n", no },
+	.menus = LIST_HEAD_INIT(symbol_no.menus),
 	.flags = SYMBOL_CONST|SYMBOL_VALID,
 };
 
@@ -838,6 +841,7 @@ struct symbol *sym_lookup(const char *name, int flags)
 	symbol->name = new_name;
 	symbol->type = S_UNKNOWN;
 	symbol->flags = flags;
+	INIT_LIST_HEAD(&symbol->menus);
 
 	hash_add(sym_hashtable, &symbol->node, hash);
 
-- 
2.40.1


