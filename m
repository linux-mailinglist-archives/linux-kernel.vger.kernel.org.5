Return-Path: <linux-kernel+bounces-153681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA7F8AD199
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F5A281B28
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2D815358D;
	Mon, 22 Apr 2024 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjTbv3hy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897C41534F1;
	Mon, 22 Apr 2024 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802332; cv=none; b=SIIlKglZ7Yfd4AKqJPp0y3bf3jAV3M/c+k0ZvlRnEUz6mUZfwH4UHYxxUtpcxXh5YWHxH3Kw3ES2Basz6G/AE+8ThCf1LazeT5AzqWLafTQTeBOvFOkovJ8YpciP6Y2MLLM39MSg3StI8m9FL81FF5vg39SPXQ2DlD3a39gk1/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802332; c=relaxed/simple;
	bh=zKd6nOk6xLV96IdrDKXncG7Ijui655ng20YGaNHnZnk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PpBIlzR6eSkORHYPYzVjaB1Ab0A5hVrnMCFy7EJfCHKVDT6UdtdLpjrJGMZva6fI8Nke7LyTQTzsKIOzq1GXEHZiGhmQHhby62tQ+sdFShck5tPvQF8ksGJd2aXzml27Bm7C9SfvU+jQFGXKcMf48xJWBULoi4mJFVsuffkqtdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjTbv3hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA71C113CC;
	Mon, 22 Apr 2024 16:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713802332;
	bh=zKd6nOk6xLV96IdrDKXncG7Ijui655ng20YGaNHnZnk=;
	h=From:To:Cc:Subject:Date:From;
	b=DjTbv3hyMIU+X50/+C8c9CgkwI8GLjg2ayqAOZ1m+mmWuvlCVQOZ9oCZP5i+9iwA4
	 +wZ2UQGn6h/0mT1o7BNMF7+WpTQWjNmHrYXE6ZVPueho/NOWqlpV/ead5dJE/Keeip
	 4L7xnp5h8tmXbQqNkg0RqfdxjyV1NVZStKAR7z2I75emJsI7xSkFonVJ/xeT+H95qm
	 DtuBdoZf3GaS4Lj3aG+c3/qNUVVfEfK8kG/8QIOvml9kuzP/ghNY6qx4bPkjxVNY91
	 uN0pJ4WEdKjfwPepV+/XPJpXQhbzLoydoSZ+VC5pWobltUiFuOupi0Lbq/trEiPfwV
	 EOLw1i4TJq/Hw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] kconfig: remove SYMBOL_CHOICE flag
Date: Tue, 23 Apr 2024 01:10:54 +0900
Message-Id: <20240422161054.2867285-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All symbols except choices have a name.

Previously, choices were allowed to have a name, but commit c83f020973bc
("kconfig: remove named choice support") eliminated that possibility.

Now, it is easy to distinguish choices from normal symbols; if the name
is NULL, it is a choice.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/confdata.c | 2 +-
 scripts/kconfig/expr.h     | 4 +---
 scripts/kconfig/gconf.c    | 2 --
 scripts/kconfig/lkc.h      | 3 ++-
 scripts/kconfig/parser.y   | 2 +-
 scripts/kconfig/symbol.c   | 2 +-
 6 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index ce0ef417b71b..a86e71bab5fa 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -888,7 +888,7 @@ int conf_write(const char *name)
 				     "# %s\n"
 				     "#\n", str);
 			need_newline = false;
-		} else if (!(sym->flags & SYMBOL_CHOICE) &&
+		} else if (!sym_is_choice(sym) &&
 			   !(sym->flags & SYMBOL_WRITTEN)) {
 			sym_calc_value(sym);
 			if (!(sym->flags & SYMBOL_WRITE))
diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index 0158f5eac454..68b3dd65cb08 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -72,8 +72,7 @@ enum {
 /*
  * Represents a configuration symbol.
  *
- * Choices are represented as a special kind of symbol and have the
- * SYMBOL_CHOICE bit set in 'flags'.
+ * Choices are represented as a special kind of symbol with null name.
  */
 struct symbol {
 	/* link node for the hash table */
@@ -131,7 +130,6 @@ struct symbol {
 
 #define SYMBOL_CONST      0x0001  /* symbol is const */
 #define SYMBOL_CHECK      0x0008  /* used during dependency checking */
-#define SYMBOL_CHOICE     0x0010  /* start of a choice block (null name) */
 #define SYMBOL_CHOICEVAL  0x0020  /* used as a value in a choice block */
 #define SYMBOL_VALID      0x0080  /* set when symbol.curr is calculated */
 #define SYMBOL_OPTIONAL   0x0100  /* choice is optional - values can be 'n' */
diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
index 9709aca3a30f..74f193272a00 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -83,8 +83,6 @@ static const char *dbg_sym_flags(int val)
 		strcat(buf, "const/");
 	if (val & SYMBOL_CHECK)
 		strcat(buf, "check/");
-	if (val & SYMBOL_CHOICE)
-		strcat(buf, "choice/");
 	if (val & SYMBOL_CHOICEVAL)
 		strcat(buf, "choiceval/");
 	if (val & SYMBOL_VALID)
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index cfb7e9ac41a3..5e27432e4939 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -129,7 +129,8 @@ static inline struct symbol *sym_get_choice_value(struct symbol *sym)
 
 static inline bool sym_is_choice(struct symbol *sym)
 {
-	return sym->flags & SYMBOL_CHOICE ? true : false;
+	/* A choice is a symbol with no name */
+	return sym->name == NULL;
 }
 
 static inline bool sym_is_choice_value(struct symbol *sym)
diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index 8f339b47fe8d..b95993ff3837 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -224,7 +224,7 @@ config_option: T_MODULES T_EOL
 
 choice: T_CHOICE T_EOL
 {
-	struct symbol *sym = sym_lookup(NULL, SYMBOL_CHOICE);
+	struct symbol *sym = sym_lookup(NULL, 0);
 	sym->flags |= SYMBOL_NO_WRITE;
 	menu_add_entry(sym);
 	menu_add_expr(P_CHOICE, NULL, NULL);
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 81fe1884ef8a..8b34992ba5ed 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -827,7 +827,7 @@ struct symbol *sym_lookup(const char *name, int flags)
 			if (symbol->name &&
 			    !strcmp(symbol->name, name) &&
 			    (flags ? symbol->flags & flags
-				   : !(symbol->flags & (SYMBOL_CONST|SYMBOL_CHOICE))))
+				   : !(symbol->flags & SYMBOL_CONST)))
 				return symbol;
 		}
 		new_name = xstrdup(name);
-- 
2.40.1


