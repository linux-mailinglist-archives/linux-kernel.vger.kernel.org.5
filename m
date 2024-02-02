Return-Path: <linux-kernel+bounces-50078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D168473FB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6D21F23EDB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FD114E2FA;
	Fri,  2 Feb 2024 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5hexQDB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1C91474CF;
	Fri,  2 Feb 2024 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889530; cv=none; b=Df1xGNeHmxIjyKq0I4aOVqjnordNutv5/neGb0ffFABc9qdJ2ua0Mb37u668Tg8q2d3uhNhd07xpxck9/yc0j5EuRzvuvL+jgIdJZsMO13LpRy+Np/4IilIte1N53/SgFGxqZGPYXVbmy7L0D4VHNXkegkmEOlTmyMUl/YRTxVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889530; c=relaxed/simple;
	bh=peshsf7E5lCNRV8+zJr6/ajkl2ZpyVwBUVUkykrK4Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kvUatAVbEJtOdqoQ00CNq6i24+RtTI94e6F5nGjJttEgQu3X0Q5Auqf8UoFcIMBBLJnvNWvqbC1BcDUowlW3MDOhJscU7GRDebwD1GuBPEkjycJkLBMFs7MUkFubvYCI0hZnMuty/aArzdXmguyYwWRs95oV1GQlFHca2VxZYrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5hexQDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB573C433F1;
	Fri,  2 Feb 2024 15:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889530;
	bh=peshsf7E5lCNRV8+zJr6/ajkl2ZpyVwBUVUkykrK4Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U5hexQDBI2JZxNkl1U0WzrOHVbWR5yUFkSZTnMNyoaK8jpz1fbdNxgWRsdrmPwsfO
	 zFI416IPRWrUvtONVxEcRpvdV4mG1sLe67QTZfl0CvfZaYUD+fiR3Rgl18uRev9PwF
	 4lf1/A3btCeCMr1UeU+QRIvM6rk8M8QEk4aKbMIDlcL3P8nlI8GfQs047swEzMCd4+
	 OP9xrDGEDxTll/Uc5M+eNoaRX5nrQBKAuxSnuxjhsquX1zAyqyYQK4Nb3loZZ1kTJ/
	 ZNhRs7f9yBhhD1K6yqYruJVytpWNyaCHaWBvWBYFz1dwA+4E3X+YMJUXSN2SQDgJuG
	 fYmvHc9upPitg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 18/27] kconfig: change file_lookup() to return the file name
Date: Sat,  3 Feb 2024 00:58:16 +0900
Message-Id: <20240202155825.314567-19-masahiroy@kernel.org>
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

Currently, file_lookup() returns a pointer to (struct file), but the
callers use only file->name.

Make it return the ->name member directly.

This adjustment encapsulates struct file and file_list as internal
implementation.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/expr.h  |  7 -------
 scripts/kconfig/lexer.l |  5 ++---
 scripts/kconfig/lkc.h   |  2 +-
 scripts/kconfig/menu.c  |  2 --
 scripts/kconfig/util.c  | 13 ++++++++++---
 5 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index 760b1e681b43..d667f9aa041e 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -17,11 +17,6 @@ extern "C" {
 #include <stdbool.h>
 #endif
 
-struct file {
-	struct file *next;
-	char name[];
-};
-
 typedef enum tristate {
 	no, mod, yes
 } tristate;
@@ -275,8 +270,6 @@ struct jump_key {
 	struct menu *target;
 };
 
-extern struct file *file_list;
-
 extern struct symbol symbol_yes, symbol_no, symbol_mod;
 extern struct symbol *modules_sym;
 extern int cdebug;
diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index 71f651bb82ba..89544c3a1a29 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -401,13 +401,12 @@ void zconf_initscan(const char *name)
 		exit(1);
 	}
 
-	cur_filename = file_lookup(name)->name;
+	cur_filename = file_lookup(name);
 	yylineno = 1;
 }
 
 void zconf_nextfile(const char *name)
 {
-	struct file *file = file_lookup(name);
 	struct buffer *buf = xmalloc(sizeof(*buf));
 	bool recur_include = false;
 
@@ -443,7 +442,7 @@ void zconf_nextfile(const char *name)
 	}
 
 	yylineno = 1;
-	cur_filename = file->name;
+	cur_filename = file_lookup(name);
 }
 
 static void zconf_endfile(void)
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index d8249052f2e3..71afcbd56273 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -52,7 +52,7 @@ static inline void xfwrite(const void *str, size_t len, size_t count, FILE *out)
 }
 
 /* util.c */
-struct file *file_lookup(const char *name);
+const char *file_lookup(const char *name);
 void *xmalloc(size_t size);
 void *xcalloc(size_t nmemb, size_t size);
 void *xrealloc(void *p, size_t size);
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index b879576d1ab4..f701382f8a69 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -16,8 +16,6 @@ static const char nohelp_text[] = "There is no help available for this option.";
 struct menu rootmenu;
 static struct menu **last_entry_ptr;
 
-struct file *file_list;
-
 void menu_warn(struct menu *menu, const char *fmt, ...)
 {
 	va_list ap;
diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index 2636dccea0c9..610d64c01479 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -9,15 +9,22 @@
 #include <string.h>
 #include "lkc.h"
 
+struct file {
+	struct file *next;
+	char name[];
+};
+
+static struct file *file_list;
+
 /* file already present in list? If not add it */
-struct file *file_lookup(const char *name)
+const char *file_lookup(const char *name)
 {
 	struct file *file;
 	size_t len;
 
 	for (file = file_list; file; file = file->next) {
 		if (!strcmp(name, file->name)) {
-			return file;
+			return file->name;
 		}
 	}
 
@@ -31,7 +38,7 @@ struct file *file_lookup(const char *name)
 
 	str_printf(&autoconf_cmd, "\t%s \\\n", name);
 
-	return file;
+	return file->name;
 }
 
 /* Allocate initial growable string */
-- 
2.40.1


