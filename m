Return-Path: <linux-kernel+bounces-60771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4502850940
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A85C287198
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F007B5A7B4;
	Sun, 11 Feb 2024 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mw52ZIKc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3796659149;
	Sun, 11 Feb 2024 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707655272; cv=none; b=KXR/sPfe2jrPBWkal05FJFIOuvybwGf1H8nV2gOdJrCF/eixDUWKHOK+4uJCGVtbCJT8PcUV0fSWBDJNef9idlU3IF4uELXnOoFd2YoxK7oy9rACPS9aY/urjKWXgYdcX58bOENzq0rNWVOm5Lym92D8Hk7SWwaFSxVWLs/OHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707655272; c=relaxed/simple;
	bh=IgiCGgj/rOMnOunox9MFGVkrzA1V8Ly9pLePgk7MAZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i3fWbMTJpcQZHGkAlqaCVyC07WKjXbCG6sWnhSrRJUwNsm1cN5DNlvnBynZXrdPac4TLexK/gGC00uFUS7qT4vyt2+zf0VOPOCsZjF16bQcAkT/C6xfN7mq2pj+TRAE2KOn9aJXTj9TOFMuQOqdWf185M1evttdd4z4ebWOtK90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mw52ZIKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB13C433C7;
	Sun, 11 Feb 2024 12:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707655271;
	bh=IgiCGgj/rOMnOunox9MFGVkrzA1V8Ly9pLePgk7MAZo=;
	h=From:To:Cc:Subject:Date:From;
	b=mw52ZIKcgUE4a4x2s3lmZWiam+3TqQ+DGdGllCMmEfdfZDKgBXO/M75yuBWKzT0eP
	 K3g+fxR52ZiD4WlwyseGwSBKA9yRR4xL9Zk2w/WHRScxEJ8cYvnirIhdYRWsoVincl
	 FYF9Hi15jS/NRsAmHG5Xd9jr/ObjPVjrRLDhcxDaNCnJ7VXH+dtt8QMdZu4I7sTAuS
	 0Kjr0hDOarYrlfrzX7aUdaIZw7ALdoRcALFKXBlVhKnLzbCwxgseSBuPXb8YJClQZ0
	 1tzl6ffCy/2kPI7+jMdwPKfKcUHRspz0JKGzPr8HqNB5fwov90cEVgOEnINf53k63h
	 VLkyhq+mToCKQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kconfig: print recursive dependency errors in the parsed order
Date: Sun, 11 Feb 2024 21:41:04 +0900
Message-Id: <20240211124105.29363-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

for_all_symbols() iterates in the symbol hash table. The order of
iteration depends on the hash table implementation.

If you use it for printing errors, they are shown in random order.

For example, the order of following test input and the corresponding
error do not match:
 - scripts/kconfig/tests/err_recursive_dep/Kconfig
 - scripts/kconfig/tests/err_recursive_dep/expected_stderr

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/parser.y                      | 20 ++++++++++++----
 .../tests/err_recursive_dep/expected_stderr   | 24 +++++++++----------
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index e58c24d2e5ab..efd0e234e0d2 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -473,8 +473,7 @@ assign_val:
 
 void conf_parse(const char *name)
 {
-	struct symbol *sym;
-	int i;
+	struct menu *menu;
 
 	autoconf_cmd = str_new();
 
@@ -517,10 +516,23 @@ void conf_parse(const char *name)
 	}
 
 	menu_finalize(&rootmenu);
-	for_all_symbols(i, sym) {
-		if (sym_check_deps(sym))
+
+	menu = &rootmenu;
+	while (menu) {
+		if (menu->sym && sym_check_deps(menu->sym))
 			yynerrs++;
+
+		if (menu->list) {
+			menu = menu->list;
+			continue;
+		}
+
+		while (!menu->next && menu->parent)
+			menu = menu->parent;
+
+		menu = menu->next;
 	}
+
 	if (yynerrs)
 		exit(1);
 	conf_set_changed(true);
diff --git a/scripts/kconfig/tests/err_recursive_dep/expected_stderr b/scripts/kconfig/tests/err_recursive_dep/expected_stderr
index c9f4abf9a791..05d4ced70320 100644
--- a/scripts/kconfig/tests/err_recursive_dep/expected_stderr
+++ b/scripts/kconfig/tests/err_recursive_dep/expected_stderr
@@ -1,10 +1,10 @@
-Kconfig:11:error: recursive dependency detected!
-Kconfig:11:	symbol B is selected by B
+Kconfig:5:error: recursive dependency detected!
+Kconfig:5:	symbol A depends on A
 For a resolution refer to Documentation/kbuild/kconfig-language.rst
 subsection "Kconfig recursive dependency limitations"
 
-Kconfig:5:error: recursive dependency detected!
-Kconfig:5:	symbol A depends on A
+Kconfig:11:error: recursive dependency detected!
+Kconfig:11:	symbol B is selected by B
 For a resolution refer to Documentation/kbuild/kconfig-language.rst
 subsection "Kconfig recursive dependency limitations"
 
@@ -14,9 +14,9 @@ Kconfig:21:	symbol C2 depends on C1
 For a resolution refer to Documentation/kbuild/kconfig-language.rst
 subsection "Kconfig recursive dependency limitations"
 
-Kconfig:32:error: recursive dependency detected!
-Kconfig:32:	symbol D2 is selected by D1
+Kconfig:27:error: recursive dependency detected!
 Kconfig:27:	symbol D1 depends on D2
+Kconfig:32:	symbol D2 is selected by D1
 For a resolution refer to Documentation/kbuild/kconfig-language.rst
 subsection "Kconfig recursive dependency limitations"
 
@@ -26,13 +26,13 @@ Kconfig:42:	symbol E2 is implied by E1
 For a resolution refer to Documentation/kbuild/kconfig-language.rst
 subsection "Kconfig recursive dependency limitations"
 
+Kconfig:49:error: recursive dependency detected!
+Kconfig:49:	symbol F1 default value contains F2
+Kconfig:51:	symbol F2 depends on F1
+For a resolution refer to Documentation/kbuild/kconfig-language.rst
+subsection "Kconfig recursive dependency limitations"
+
 Kconfig:60:error: recursive dependency detected!
 Kconfig:60:	symbol G depends on G
 For a resolution refer to Documentation/kbuild/kconfig-language.rst
 subsection "Kconfig recursive dependency limitations"
-
-Kconfig:51:error: recursive dependency detected!
-Kconfig:51:	symbol F2 depends on F1
-Kconfig:49:	symbol F1 default value contains F2
-For a resolution refer to Documentation/kbuild/kconfig-language.rst
-subsection "Kconfig recursive dependency limitations"
-- 
2.40.1


