Return-Path: <linux-kernel+bounces-89648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F399D86F38F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 05:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742811F21D04
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 04:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB95D79E1;
	Sun,  3 Mar 2024 04:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dh6b+igi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0776E6FD0;
	Sun,  3 Mar 2024 04:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709438442; cv=none; b=G5lT7wY7OCdqo0pBWopFqqtoSTbqmhL814HSfsbI3gmnBs0kDbvhP9o1bDNw09b4lD0M32pS/b4tUsvjShFkFYNB7Q9cQfQuQ9YS8jaajO2y1Hg/KPtrv4jPFdb5cmPAvcx9gqUNpxPHWEtitBkTZR6QlV3aAuURnlfvyaog+kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709438442; c=relaxed/simple;
	bh=lXxv7xJWAlJqvQFRnp9M3lrdj0gJLvlnbtl717FZbxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ws9+yfcHdEN4gCl8QSiONwaqWLZaqzmzeOGoPMn4sXBMxB3idnBnIVQRqVqReSIPWwFiAqtqxTiPSTSHFLMM1MTZm0r4926hIjLdDs6yxYGxpJwrnXLA392enZbrZ7MPqp/FIriIwB6JB/2JMQxdNaooZXr2ufVplylzsUfDdlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dh6b+igi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DA0C43390;
	Sun,  3 Mar 2024 04:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709438441;
	bh=lXxv7xJWAlJqvQFRnp9M3lrdj0gJLvlnbtl717FZbxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dh6b+igiB4aTOI/O9SivESZbD0SWWk1mtZ1L2TB6N2TI3XDc4hANH0sF17JsujD1E
	 ZtIeIHk2Xf7zSdIMu2BJwVgLXoFn9XrrykXk7Tt4PNGUqvW1Xngj7AvPnuQ+3EJ60S
	 +CbH1k11Sr2fWB8GQHaNHGN+UVbbMeShUlD3aXsSn1gZbhxQ+kCqhhbVnx4VgVYvGe
	 GlhxWnr1pKQLxu4iil7fr146GTyHRviQPtRmuRzafuE0alNRjIQLtW/UnM/E2KSG+i
	 vtMmttld9BZBSouwO9Pf/zx/JP4XK1JG2g/iMLNIJ4VF/Pzc2c1TNv2WxLNg8lLVrX
	 NPp/uMJwCrkEg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/3] kconfig: use linked list in get_symbol_str() to iterate over menus
Date: Sun,  3 Mar 2024 13:00:34 +0900
Message-Id: <20240303040035.3450914-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240303040035.3450914-1-masahiroy@kernel.org>
References: <20240303040035.3450914-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, get_symbol_str() uses a tricky approach to traverse the
associated menus.

With relevant menus now linked to the symbol using a linked list,
use list_for_each_entry() for iterating on the menus.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/menu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 571394ed71e0..840ce642ec43 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -771,6 +771,7 @@ static void get_symbol_str(struct gstr *r, struct symbol *sym,
 		    struct list_head *head)
 {
 	struct property *prop;
+	struct menu *menu;
 
 	if (sym && sym->name) {
 		str_printf(r, "Symbol: %s [=%s]\n", sym->name,
@@ -787,17 +788,17 @@ static void get_symbol_str(struct gstr *r, struct symbol *sym,
 	}
 
 	/* Print the definitions with prompts before the ones without */
-	for_all_properties(sym, prop, P_SYMBOL) {
-		if (prop->menu->prompt) {
-			get_def_str(r, prop->menu);
-			get_prompt_str(r, prop->menu->prompt, head);
+	list_for_each_entry(menu, &sym->menus, link) {
+		if (menu->prompt) {
+			get_def_str(r, menu);
+			get_prompt_str(r, menu->prompt, head);
 		}
 	}
 
-	for_all_properties(sym, prop, P_SYMBOL) {
-		if (!prop->menu->prompt) {
-			get_def_str(r, prop->menu);
-			get_dep_str(r, prop->menu->dep, "  Depends on: ");
+	list_for_each_entry(menu, &sym->menus, link) {
+		if (!menu->prompt) {
+			get_def_str(r, menu);
+			get_dep_str(r, menu->dep, "  Depends on: ");
 		}
 	}
 
-- 
2.40.1


