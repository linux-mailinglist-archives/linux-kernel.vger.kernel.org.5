Return-Path: <linux-kernel+bounces-152464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C7D8ABED6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 11:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0311F2114B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 09:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9577EAD4;
	Sun, 21 Apr 2024 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEAYOryr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB491DDA6;
	Sun, 21 Apr 2024 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713690179; cv=none; b=rljYB/RoYZf6+Hg1T+WBAotZuKeElD5U5XZDUCh26UdXhgkxPS2YG+ENdS6wDpRDGFWBPLHzM7HWwA3rvWmR4Rvm5AxkHX4tm+Hu3+juTWv4Xo/URF9YCNBVp29r+uAxuZxyWqRi/ptIwh0sjQa35PKO2BIU9GxiqCzbtDCGAXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713690179; c=relaxed/simple;
	bh=zlw4QwpoCgMvxjEIvSbcsPVdEQPaECLZAx6t1pVEAPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RFtuKQguD/Daij9+7BxB8isgp6Cu7/ChLh9gb9k+ftrV+Ec//IWWqQZvXia4hjh+i62Q+c49kQSixWsVRMcnRTSddtJ0Zg6WJgR3jzQKd+1pS3FKZnm5+JNbAa51i1k1izRhQbm0QxdMFDXuqIxg26mu6Vaz92d159qOp1r2DSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEAYOryr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47B5C113CE;
	Sun, 21 Apr 2024 09:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713690178;
	bh=zlw4QwpoCgMvxjEIvSbcsPVdEQPaECLZAx6t1pVEAPE=;
	h=From:To:Cc:Subject:Date:From;
	b=LEAYOryr3lT+RONfhWFOeSRG2G7OjwXBvOaco0fC7BQe8x/3APylzONctWedzpas/
	 yLXgLlJJjXI15RkLV06IL8yBQ5B54xYzqIqBdvQrP0ldNLI3zkgPjXfhRNFV1mgvCT
	 a5RwKWaadbVuVDfg8P9b4ZTm6CaiEP2D7YvvvKFHixXVrlhQqTWVWktyjzvD6o8UUC
	 cbJvEXcAUWCnDHj12kB6W/m2Lnm0rB0+YZuhJt8HCSLp4drT/s4GL6fXwnNwArhsiU
	 itgU1/STPnJOeC/lvSUDir4OgNp6euJvZJqtIZfq88Zm0Ti0e3nVfM7hAkjIAip7bB
	 IQ0uNS6ibokww==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] kconfig: add menu_next() function and menu_for_each(_sub)_entry macros
Date: Sun, 21 Apr 2024 18:02:51 +0900
Message-Id: <20240421090252.2700867-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several functions require traversing menu entries sequentially. This
commit introduces some helpers to simplify such operations.

The menu_next() function facilitates depth-first traversal:

 1. Descend to the child level if the current menu has one
 2. Move to the next sibling at the same level if available
 3. Ascend to the parent level if there is no more child or sibling

The menu_for_each_sub_entry() macro iterates over all submenu entries
using depth-first traverse.

The menu_for_each_entry() macro is the same, but over all menu entries.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lkc.h  |  5 +++++
 scripts/kconfig/menu.c | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index e7cc9e985c4f..cfb7e9ac41a3 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -79,6 +79,11 @@ void str_printf(struct gstr *gs, const char *fmt, ...);
 char *str_get(struct gstr *gs);
 
 /* menu.c */
+struct menu *menu_next(struct menu *menu, struct menu *root);
+#define menu_for_each_sub_entry(menu, root) \
+	for (menu = menu_next(root, root); menu; menu = menu_next(menu, root))
+#define menu_for_each_entry(menu) \
+	menu_for_each_sub_entry(menu, &rootmenu)
 void _menu_init(void);
 void menu_warn(struct menu *menu, const char *fmt, ...);
 struct menu *menu_add_menu(void);
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 3b822cd110f4..fe6af8700622 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -17,6 +17,27 @@ static const char nohelp_text[] = "There is no help available for this option.";
 struct menu rootmenu;
 static struct menu **last_entry_ptr;
 
+/**
+ * menu_next - return the next menu entry with depth-first traversal
+ * @menu: pointer to the current menu
+ * @root: root of the sub-tree to traverse. If NULL is given, the traveral
+ *        continues until it reaches the end of the entire menu tree.
+ * return: the menu to visit next, or NULL when it reaches the end.
+ */
+struct menu *menu_next(struct menu *menu, struct menu *root)
+{
+	if (menu->list)
+		return menu->list;
+
+	while (menu != root && !menu->next)
+		menu = menu->parent;
+
+	if (menu == root)
+		return NULL;
+
+	return menu->next;
+}
+
 void menu_warn(struct menu *menu, const char *fmt, ...)
 {
 	va_list ap;
-- 
2.40.1


