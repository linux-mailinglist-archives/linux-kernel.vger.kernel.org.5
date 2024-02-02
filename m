Return-Path: <linux-kernel+bounces-50074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 291438473F2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC59CB2B657
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A1514C5AE;
	Fri,  2 Feb 2024 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCMA1Rn8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363DE14C592;
	Fri,  2 Feb 2024 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889526; cv=none; b=OdcD5WW3hss7KKmdx7z45yWZKSCpZV3Mahjaxeamc3T/PJAmzbslRHnXGP5s+X8Pa0BhHQkEnnqKNgABBIBH2gTFukYJLmzceZD8kyjCrBWk7/7fIGjHjjulVNljNZAF/s6X/BiEPJBLBdWtCfNyoZclQOv9xmH/fmcibXQl3DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889526; c=relaxed/simple;
	bh=wHVLJm31U+fA47auTd9+uU0toq5m5ICZ6w8E0bowFB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oIYcfXroHojkMMwMJ1BtujEeGeVhzhUNuz2fs3jCODmHydDrl0GNGzs7jK5U5L2lJyhKuyiCtgk2IOTww6o4eBqmGSnGqZ1+R0AAgRY/Q4++D3JiQ9DKy8x3i3p4172xcik9dXKspT3Abc58wzM7T6rvpt3is39L3orhVxG/IJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCMA1Rn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F8AC433F1;
	Fri,  2 Feb 2024 15:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889526;
	bh=wHVLJm31U+fA47auTd9+uU0toq5m5ICZ6w8E0bowFB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JCMA1Rn8MXKR7+56P3lyywwXtbccGzQZOw5FBgWPErFILpiZ0uSjyFghWApxHNGUh
	 OnOktXn61WWGGT3uDO99/3EFVQYYBcbIoTL2aLOR5EDjiyw87BMO9+/VwdE7ZdgAfU
	 TFIJHl0crcCB3RnriYixGgQsGJXfHQ24eIvWa34KW57CP4dk0WibbrU/kqjMWRuojw
	 lDDzqTjr5thlDu/8kvZsSzjVmtk6m14f60pqLOglw1INbYZkKqZhEUP8UplL5bXun7
	 eIZauYpw3kewrzGTmRpu9jIEx3PRp+bnL3UD8esWOXjPvwIY74JvMssFZoU9x1z9Bz
	 zXynzYixu/vNA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 14/27] kconfig: do not delay the cur_filename update
Date: Sat,  3 Feb 2024 00:58:12 +0900
Message-Id: <20240202155825.314567-15-masahiroy@kernel.org>
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

Currently, cur_filename is updated at the first token of each statement.
However, this seems unnecessary based on my understanding; the parser
can use the same variable as the lexer tracks.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lexer.l  | 17 +++++++----------
 scripts/kconfig/parser.y |  8 ++++++++
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index 35ad1b256470..28e279cd5a22 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -274,24 +274,17 @@ repeat:
 	token = yylex1();
 
 	if (prev_token == T_EOL || prev_token == T_HELPTEXT) {
-		if (token == T_EOL) {
+		if (token == T_EOL)
 			/* Do not pass unneeded T_EOL to the parser. */
 			goto repeat;
-		} else {
+		else
 			/*
-			 * For the parser, update file/lineno at the first token
+			 * For the parser, update lineno at the first token
 			 * of each statement. Generally, \n is a statement
 			 * terminator in Kconfig, but it is not always true
 			 * because \n could be escaped by a backslash.
-			 *
-			 * FIXME:
-			 * cur_filename and cur_lineno are used even after
-			 * yyparse(); menu_finalize() calls menu_add_symbol().
-			 * This should be fixed.
 			 */
-			cur_filename = current_file ? current_file->name : "<none>";
 			cur_lineno = yylineno;
-		}
 	}
 
 	if (prev_prev_token == T_EOL && prev_token == T_WORD &&
@@ -407,6 +400,7 @@ void zconf_initscan(const char *name)
 	}
 
 	current_file = file_lookup(name);
+	cur_filename = current_file->name;
 	yylineno = 1;
 }
 
@@ -448,6 +442,7 @@ void zconf_nextfile(const char *name)
 	}
 
 	yylineno = 1;
+	cur_filename = file->name;
 	current_file = file;
 }
 
@@ -456,6 +451,8 @@ static void zconf_endfile(void)
 	struct buffer *tmp;
 
 	current_file = current_file->parent;
+	if (current_file)
+		cur_filename = current_file->name;
 
 	if (!current_buf)
 		return;
diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index d1d05c8cd89d..e58c24d2e5ab 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -488,6 +488,14 @@ void conf_parse(const char *name)
 		yydebug = 1;
 	yyparse();
 
+	/*
+	 * FIXME:
+	 * cur_filename and cur_lineno are used even after yyparse();
+	 * menu_finalize() calls menu_add_symbol(). This should be fixed.
+	 */
+	cur_filename = "<none>";
+	cur_lineno = 0;
+
 	str_printf(&autoconf_cmd,
 		   "\n"
 		   "$(autoconfig): $(deps_config)\n"
-- 
2.40.1


