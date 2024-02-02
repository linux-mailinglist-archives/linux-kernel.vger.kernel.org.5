Return-Path: <linux-kernel+bounces-50075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06348473F4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289061C22946
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCAF14D438;
	Fri,  2 Feb 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+pSyziy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000F14C5BA;
	Fri,  2 Feb 2024 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889527; cv=none; b=o4+wSrR1oYYrWqMFB9/ziEqKH+o0+OTc5tcWMUQm543MCiRsBPvc39OthNbHYyH7BD3Nwn48vHfU+2r8XdUWKsgW+2jDFtFzQIGdsx7+uSAee681jQKBr5bVDKBRbYREmGTzU3vICf2F8yp43cGBG+MGkafoQsGjv1di3XQU7qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889527; c=relaxed/simple;
	bh=iQfJFbCfo6g+jL93vYCPjdUyp6aRJx+Zc0bUp6Uw6sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4f5E0y/wi7hBk17YH/EaMLHnAdhIrL1shc6NesxIN7WL0YY09H5QHqjRtqJFKt3gbYkGv443fuuMLgp9Dv8kYiE9CvI2AkJ1qj86xVuBR2XULVEtBgEBT6w4AoX8UOyfMZMUOB8WtSXZGMLYN0iJyCNuF4LV1iPVqYHj46cpLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+pSyziy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80171C43399;
	Fri,  2 Feb 2024 15:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889527;
	bh=iQfJFbCfo6g+jL93vYCPjdUyp6aRJx+Zc0bUp6Uw6sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q+pSyziySnu8Lju8MA/luc1F9M6N3CrRz4pHXOEMWnZXGqN5iYhwHBWgOktnOqE1R
	 i7dHfKfihIoTBvE47kKMInfeaDOLQFPHdA7vWX5tRq/la63RVmqdPI6ZIHe+0dbnR9
	 pooakkKDIAc6ljG1mZYRr0EzjLN5HimPYRGQDubE7IGx4iIrlH21Jx5wN+8QU42Qnn
	 W+x3w+87KpYfsRei5OI5Z5Z9VqcWUFgUTHWIGWtDs11PHQHGiR3f/4Q0FkAmBjCjQU
	 ie3gcXs2gKlaO+DIylXw+TCj7MKXYrZLsZ6NLU3aK4uipyrXRjUJ2O2GoUGQvXl7ui
	 YOz6a36G4Z9Fw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 15/27] kconfig: replace remaining current_file->name with cur_filename
Date: Sat,  3 Feb 2024 00:58:13 +0900
Message-Id: <20240202155825.314567-16-masahiroy@kernel.org>
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

Replace the remaining current_file->name in the lexer context.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lexer.l      | 4 ++--
 scripts/kconfig/preprocess.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index 28e279cd5a22..db2397c4e343 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -84,7 +84,7 @@ static void warn_ignored_character(char chr)
 {
 	fprintf(stderr,
 	        "%s:%d:warning: ignoring unsupported character '%c'\n",
-	        current_file->name, yylineno, chr);
+	        cur_filename, yylineno, chr);
 }
 %}
 
@@ -253,7 +253,7 @@ n	[A-Za-z0-9_-]
 
 	if (prev_token != T_EOL && prev_token != T_HELPTEXT)
 		fprintf(stderr, "%s:%d:warning: no new line at end of file\n",
-			current_file->name, yylineno);
+			cur_filename, yylineno);
 
 	if (current_file) {
 		zconf_endfile();
diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 12665b981c3e..69b806a6d8b7 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include "internal.h"
 #include "list.h"
 #include "lkc.h"
 #include "preprocess.h"
@@ -22,7 +23,7 @@ static void __attribute__((noreturn)) pperror(const char *format, ...)
 {
 	va_list ap;
 
-	fprintf(stderr, "%s:%d: ", current_file->name, yylineno);
+	fprintf(stderr, "%s:%d: ", cur_filename, yylineno);
 	va_start(ap, format);
 	vfprintf(stderr, format, ap);
 	va_end(ap);
@@ -123,7 +124,7 @@ static char *do_error_if(int argc, char *argv[])
 
 static char *do_filename(int argc, char *argv[])
 {
-	return xstrdup(current_file->name);
+	return xstrdup(cur_filename);
 }
 
 static char *do_info(int argc, char *argv[])
@@ -185,8 +186,7 @@ static char *do_shell(int argc, char *argv[])
 static char *do_warning_if(int argc, char *argv[])
 {
 	if (!strcmp(argv[0], "y"))
-		fprintf(stderr, "%s:%d: %s\n",
-			current_file->name, yylineno, argv[1]);
+		fprintf(stderr, "%s:%d: %s\n", cur_filename, yylineno, argv[1]);
 
 	return xstrdup("");
 }
-- 
2.40.1


