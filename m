Return-Path: <linux-kernel+bounces-18869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5319C826436
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 14:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E5F1C213F0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 13:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FA6134BD;
	Sun,  7 Jan 2024 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmVgyUqS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF8A134B1;
	Sun,  7 Jan 2024 13:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BE9C433C9;
	Sun,  7 Jan 2024 13:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704633594;
	bh=EhenJv98wQ6P7JdtZwqrkrF1c5zd39P2pUl1WVROUA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmVgyUqS3XISmxGQFJG2CHZfXCPit+YlYoVB7c9MLLiOD3wTPX5dXUdkH1tU7ttPA
	 AsleNMoE3oL9K35UXZfkAFgSsBHhtY+GzTtyCy2V4eJt5Yx5fh71F51JTZymp9ZFlf
	 YB8q2cODNB6dYdxRy7g8GpVsKtR/SMc0whHpCKJikYvqwDO77lLzTagpef14qyq7ZF
	 C2KhBTHRhAw1sDN8ZEs2egAcCRe0tjuITtfvkJer3ayrRDIcBoSnHOsz/c/15GH8N8
	 zIecPP9oLw/X3XBHxeUab5eUTS/LWrkWIdP9KzfX5WK8L90OEaCCYF9GHfS9ixHvwK
	 s8T5Y5zdcUL0g==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kconfig: fix line number in recursive inclusion detection
Date: Sun,  7 Jan 2024 22:19:48 +0900
Message-Id: <20240107131948.39752-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240107131948.39752-1-masahiroy@kernel.org>
References: <20240107131948.39752-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error message shows a wrong line number if the 'source' directive
is wrapped to the following line.

[Test Code]

  source \
  "Kconfig"

This results in the following error message:

  Recursive inclusion detected.
  Inclusion path:
    current file : Kconfig
    included from: Kconfig:2

The correct message should be as follows:

  Recursive inclusion detected.
  Inclusion path:
    current file : Kconfig
    included from: Kconfig:1

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lexer.l | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index d75423ec4eae..b3aeb29695d7 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -33,6 +33,7 @@ static int text_size, text_asize;
 struct buffer {
 	struct buffer *parent;
 	YY_BUFFER_STATE state;
+	int lineno;
 };
 
 static struct buffer *current_buf;
@@ -402,6 +403,7 @@ void zconf_nextfile(const char *name)
 	struct buffer *buf = xmalloc(sizeof(*buf));
 
 	buf->state = YY_CURRENT_BUFFER;
+	buf->lineno = yylineno;
 	buf->parent = current_buf;
 	current_buf = buf;
 	yyin = zconf_fopen(file->name);
@@ -412,7 +414,7 @@ void zconf_nextfile(const char *name)
 	}
 	yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
 
-	current_file->lineno = yylineno;
+	current_file->lineno = zconf_lineno();
 	file->parent = current_file;
 
 	for (iter = current_file; iter; iter = iter->parent) {
@@ -425,7 +427,7 @@ void zconf_nextfile(const char *name)
 			do {
 				iter = iter->parent;
 				fprintf(stderr, "  included from: %s:%d\n",
-					iter->name, iter->lineno - 1);
+					iter->name, iter->lineno);
 			} while (strcmp(iter->name, file->name));
 			exit(1);
 		}
@@ -440,8 +442,6 @@ static void zconf_endfile(void)
 	struct buffer *tmp;
 
 	current_file = current_file->parent;
-	if (current_file)
-		yylineno = current_file->lineno;
 
 	if (!current_buf)
 		return;
@@ -449,6 +449,7 @@ static void zconf_endfile(void)
 	fclose(yyin);
 	yy_delete_buffer(YY_CURRENT_BUFFER);
 	yy_switch_to_buffer(current_buf->state);
+	yylineno = current_buf->lineno;
 	tmp = current_buf;
 	current_buf = current_buf->parent;
 	free(tmp);
-- 
2.40.1


