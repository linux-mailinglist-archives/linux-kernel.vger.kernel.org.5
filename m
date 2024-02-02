Return-Path: <linux-kernel+bounces-50076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EB78473F6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0DE32847E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A148A14E2C0;
	Fri,  2 Feb 2024 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzabgXpC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060D14D44A;
	Fri,  2 Feb 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889528; cv=none; b=vGlH9TsSE/tRJ+ywiiaT5NYZj8a4j0EykBecXIyKxZKtutsXWJJjJGLglRVN1MoHuDuuaTGVU+tv5U4xDgCsPnCxG9rN0TEPS4727OX6iBeulwELS/IjTpjl+w4w0rjK5CBzlpecCfqOol/EKCfYPKtfEiPHYAQ8ubkkRa1HMjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889528; c=relaxed/simple;
	bh=XGcvVEbpwvjpyVs7c6B8hKp1bvuUZzxnFMzXDLqk/JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VPNiRrLPU/jPSnV/SCOyBZ6g22DKKGTKBYabJ/orl5DZJAVcuTGTZMV9ilqb/G3JzoMIwumxTYCI+iJHs77HK5p4CvHLlHR3Uje0HfHKTYpGTOec67tQsS+ECwYwkwJhlovnTd3ZeaZO3hJhEf3ToRRdpozwpp4W0j/L1CgWWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzabgXpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD2EC433F1;
	Fri,  2 Feb 2024 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889528;
	bh=XGcvVEbpwvjpyVs7c6B8hKp1bvuUZzxnFMzXDLqk/JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dzabgXpCqPZGOOmY2HjYfoRaQDHhH7gXNlUAfg2P6hpRiGf6F3shxQfVIzl6C6H8V
	 H629bnB/SwuPIYgpAW4laXhFoErIRoCJPjwTxtVtFuyk/mgAtUpgucIM5BRtFg5ihl
	 R3bhViG2PdiimUVEWaF5M/Alv8ybNbdikVc7M2dh0dxaGtMZgRbrRlF3KTXnF2EIdn
	 L392q5NJZ8paAoI1TBlbTXvE+uFQ93YTVTdEmxTGWUBKtP2pUhfXjBGyV0E1HNe3tG
	 tJ/A4brR7IGKyHS7OII9DgpSZlCXigSn0aZ80ULa8jqLimKyMY7jtqLi14Y0Kch4uu
	 owQfRWCOAHwEw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 16/27] kconfig: move the file and lineno in struct file to struct buffer
Date: Sat,  3 Feb 2024 00:58:14 +0900
Message-Id: <20240202155825.314567-17-masahiroy@kernel.org>
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

struct file has two link nodes, 'next' and 'parent'.

The former is used to link files in the 'file_list' linked list,
which manages the list of Kconfig files seen so far.

The latter is used to link files in the 'current_file' linked list,
which manages the inclusion ("source") tree.

The latter should be tracked together with the lexer state.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/expr.h  |  3 ---
 scripts/kconfig/lexer.l | 50 ++++++++++++++++++-----------------------
 scripts/kconfig/menu.c  |  1 -
 3 files changed, 22 insertions(+), 32 deletions(-)

diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index 037db39c5bf0..85e0d1ab3c8a 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -19,9 +19,7 @@ extern "C" {
 
 struct file {
 	struct file *next;
-	struct file *parent;
 	const char *name;
-	int lineno;
 };
 
 typedef enum tristate {
@@ -278,7 +276,6 @@ struct jump_key {
 };
 
 extern struct file *file_list;
-extern struct file *current_file;
 
 extern struct symbol symbol_yes, symbol_no, symbol_mod;
 extern struct symbol *modules_sym;
diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index db2397c4e343..71f651bb82ba 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -40,6 +40,8 @@ struct buffer {
 	struct buffer *parent;
 	YY_BUFFER_STATE state;
 	int yylineno;
+	const char *filename;
+	int source_lineno;
 };
 
 static struct buffer *current_buf;
@@ -255,7 +257,7 @@ n	[A-Za-z0-9_-]
 		fprintf(stderr, "%s:%d:warning: no new line at end of file\n",
 			cur_filename, yylineno);
 
-	if (current_file) {
+	if (current_buf) {
 		zconf_endfile();
 		return T_EOL;
 	}
@@ -399,19 +401,20 @@ void zconf_initscan(const char *name)
 		exit(1);
 	}
 
-	current_file = file_lookup(name);
-	cur_filename = current_file->name;
+	cur_filename = file_lookup(name)->name;
 	yylineno = 1;
 }
 
 void zconf_nextfile(const char *name)
 {
-	struct file *iter;
 	struct file *file = file_lookup(name);
 	struct buffer *buf = xmalloc(sizeof(*buf));
+	bool recur_include = false;
 
 	buf->state = YY_CURRENT_BUFFER;
 	buf->yylineno = yylineno;
+	buf->filename = cur_filename;
+	buf->source_lineno = cur_lineno;
 	buf->parent = current_buf;
 	current_buf = buf;
 	yyin = zconf_fopen(name);
@@ -422,45 +425,36 @@ void zconf_nextfile(const char *name)
 	}
 	yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
 
-	current_file->lineno = cur_lineno;
-	file->parent = current_file;
+	for (buf = current_buf; buf; buf = buf->parent) {
+		if (!strcmp(buf->filename, name))
+			recur_include = true;
+	}
 
-	for (iter = current_file; iter; iter = iter->parent) {
-		if (!strcmp(iter->name, name)) {
-			fprintf(stderr,
-				"Recursive inclusion detected.\n"
-				"Inclusion path:\n"
-				"  current file : %s\n", name);
-			iter = file;
-			do {
-				iter = iter->parent;
-				fprintf(stderr, "  included from: %s:%d\n",
-					iter->name, iter->lineno);
-			} while (strcmp(iter->name, name));
-			exit(1);
-		}
+	if (recur_include) {
+		fprintf(stderr,
+			"Recursive inclusion detected.\n"
+			"Inclusion path:\n"
+			"  current file : %s\n", name);
+
+		for (buf = current_buf; buf; buf = buf->parent)
+			fprintf(stderr, "  included from: %s:%d\n",
+				buf->filename, buf->source_lineno);
+		exit(1);
 	}
 
 	yylineno = 1;
 	cur_filename = file->name;
-	current_file = file;
 }
 
 static void zconf_endfile(void)
 {
 	struct buffer *tmp;
 
-	current_file = current_file->parent;
-	if (current_file)
-		cur_filename = current_file->name;
-
-	if (!current_buf)
-		return;
-
 	fclose(yyin);
 	yy_delete_buffer(YY_CURRENT_BUFFER);
 	yy_switch_to_buffer(current_buf->state);
 	yylineno = current_buf->yylineno;
+	cur_filename = current_buf->filename;
 	tmp = current_buf;
 	current_buf = current_buf->parent;
 	free(tmp);
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 0ded0b1830d0..b879576d1ab4 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -17,7 +17,6 @@ struct menu rootmenu;
 static struct menu **last_entry_ptr;
 
 struct file *file_list;
-struct file *current_file;
 
 void menu_warn(struct menu *menu, const char *fmt, ...)
 {
-- 
2.40.1


