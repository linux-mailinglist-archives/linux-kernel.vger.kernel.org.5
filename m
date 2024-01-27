Return-Path: <linux-kernel+bounces-41200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEE283ED49
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2DD1C218B5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CE125620;
	Sat, 27 Jan 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0+mCO1k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C428831;
	Sat, 27 Jan 2024 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706362107; cv=none; b=M6USz3CvAqayFBEKE4L7gWIsFWAlZSyp6rD7KmSZOcWwaQVUL7er/e1TOWQLC8hZ/J9xewVaxZi+LdfOO0ZMiV1eOHMwOo27nsZPyewZzpHV/LsxjswfOS3hWRcdD789RuIU/nTocagrDq7Ec8qseCGEJzofn+rNK7OtBGAXtdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706362107; c=relaxed/simple;
	bh=YySa0Fk3UXJKapcjnXd2lKKSfNAEPCo71Yx8GEe4vOw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eDQzshI7aRYsjFTfRr4oKY1zwMVpffFVJdWawZK02nrteKgNn/CpcsqyuOQQoruU9w9ABz38LQuTTFXZlKVAnAJswNkxhgOC8g6lOkwyTp/zYgxakC1+YwFAFXhizMEBJlMsJYQoxWSwcZGS1VUACi7bov58FoE91hcrUBVpOpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0+mCO1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84258C43390;
	Sat, 27 Jan 2024 13:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706362107;
	bh=YySa0Fk3UXJKapcjnXd2lKKSfNAEPCo71Yx8GEe4vOw=;
	h=From:To:Cc:Subject:Date:From;
	b=G0+mCO1kNZlkXqGHpVucNcZ+kDrr/VQfHBiPohNoXeY1rxq0AeFrMpyAfJ2eY7L8g
	 v17lbMi6os42Ei+XAQncxT8sSg1Mn4MiUcM0jJKHxdASOd7/vOGG8gL8wfy0bOxzw7
	 1RSK0tuP1rahtS6ui6vBraJ4Hw3XOhHRWYgoNdYG5gA/U30LsX5z9ZKx/Pao9rRWg7
	 mJpeJXWE4eNg7Y30xDIZC9+ZAZq1olIiwDxGBQJ2Kpwj9WSvBNpK1TZSaX3j01t3oD
	 Ftg5NmC4vAjYzCKfNhCWTczIisIJFv0FxAjdoEbGNsl0iDdW9vMa81/kD1K42DhU2b
	 I2Skedw9wvTkw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Aiden Leong <aiden.leong@aibsd.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] modpost: avoid using the alias attribute
Date: Sat, 27 Jan 2024 22:28:11 +0900
Message-Id: <20240127132811.726504-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aiden Leong reported modpost fails to build on macOS since commit
16a473f60edc ("modpost: inform compilers that fatal() never returns"):

  scripts/mod/modpost.c:93:21: error: aliases are not supported on darwin

Nathan's research indicates that Darwin seems to support weak aliases
at least [1]. Although the situation might be improved in future Clang
versions, we can achieve a similar outcome without relying on it.

This commit makes fatal() a macro of error() + exit(1) in modpost.h, as
compilers recognize that exit() never returns.

[1]: https://github.com/llvm/llvm-project/issues/71001

Fixes: 16a473f60edc ("modpost: inform compilers that fatal() never returns")
Reported-by: Aiden Leong <aiden.leong@aibsd.com>
Closes: https://lore.kernel.org/all/d9ac2960-6644-4a87-b5e4-4bfb6e0364a8@aibsd.com/
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 12 +-----------
 scripts/mod/modpost.h |  6 +-----
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 795b21154446..3ab2db83428b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -70,9 +70,7 @@ void modpost_log(enum loglevel loglevel, const char *fmt, ...)
 		break;
 	case LOG_ERROR:
 		fprintf(stderr, "ERROR: ");
-		break;
-	case LOG_FATAL:
-		fprintf(stderr, "FATAL: ");
+		error_occurred = true;
 		break;
 	default: /* invalid loglevel, ignore */
 		break;
@@ -83,16 +81,8 @@ void modpost_log(enum loglevel loglevel, const char *fmt, ...)
 	va_start(arglist, fmt);
 	vfprintf(stderr, fmt, arglist);
 	va_end(arglist);
-
-	if (loglevel == LOG_FATAL)
-		exit(1);
-	if (loglevel == LOG_ERROR)
-		error_occurred = true;
 }
 
-void __attribute__((alias("modpost_log")))
-modpost_log_noret(enum loglevel loglevel, const char *fmt, ...);
-
 static inline bool strends(const char *str, const char *postfix)
 {
 	if (strlen(str) < strlen(postfix))
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 835cababf1b0..ee43c7950636 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -194,15 +194,11 @@ void *sym_get_data(const struct elf_info *info, const Elf_Sym *sym);
 enum loglevel {
 	LOG_WARN,
 	LOG_ERROR,
-	LOG_FATAL
 };
 
 void __attribute__((format(printf, 2, 3)))
 modpost_log(enum loglevel loglevel, const char *fmt, ...);
 
-void __attribute__((format(printf, 2, 3), noreturn))
-modpost_log_noret(enum loglevel loglevel, const char *fmt, ...);
-
 /*
  * warn - show the given message, then let modpost continue running, still
  *        allowing modpost to exit successfully. This should be used when
@@ -218,4 +214,4 @@ modpost_log_noret(enum loglevel loglevel, const char *fmt, ...);
  */
 #define warn(fmt, args...)	modpost_log(LOG_WARN, fmt, ##args)
 #define error(fmt, args...)	modpost_log(LOG_ERROR, fmt, ##args)
-#define fatal(fmt, args...)	modpost_log_noret(LOG_FATAL, fmt, ##args)
+#define fatal(fmt, args...)	do { error(fmt, ##args); exit(1); } while (1)
-- 
2.40.1


