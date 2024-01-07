Return-Path: <linux-kernel+bounces-18868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF29826434
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 14:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1381F219E4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 13:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB50134AD;
	Sun,  7 Jan 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaocn+Ue"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814A134A6;
	Sun,  7 Jan 2024 13:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3462AC433C8;
	Sun,  7 Jan 2024 13:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704633593;
	bh=yqUZakV4GV4CxI5FT16aZfQMpPe8/dakYmO+NY7zAso=;
	h=From:To:Cc:Subject:Date:From;
	b=oaocn+UeQhTi7Qguxa9FM2DSdeNqH/AX81W4rF5lnGi1M/XWdTy+1TD0jWqtH9UEb
	 m9dLDYdoIW/TXGV/Z53fivq4GnLqu/g8VLcptXWNS3XVCElw8Hrl7625454OM7QL7B
	 qmUK8v5OIeUl4UzdmnFj2OEZ3f9WNpAfLB03/eYw5z5vcy3IgD8Ieg3Rs3mRpdkkkd
	 /p2Cr9MQWTqurLqXH1ZeDGt/qxlvdMB3l+CqqjPk3BvBMhhfpAYS8ORzFl0l+A6tPL
	 jFYlJgZeAKe11ceeosV6wdm4e0r6ZY2ZBQtM67NLYC/goSl6sEwyLYVfGz1FeM3nRp
	 p4uRdLW7IAHfQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kconfig: remove unneeded buffer allocation in zconf_initscan()
Date: Sun,  7 Jan 2024 22:19:47 +0900
Message-Id: <20240107131948.39752-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Kconfig, there is a stack to save the lexer state for each inclusion
level.

Currently, it operates as an empty stack, with the 'current_buf' always
pointing to an empty buffer. There is no need to preallocate the buffer.
Change it to a full stack.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lexer.l | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index cc386e443683..d75423ec4eae 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -391,9 +391,6 @@ void zconf_initscan(const char *name)
 		exit(1);
 	}
 
-	current_buf = xmalloc(sizeof(*current_buf));
-	memset(current_buf, 0, sizeof(*current_buf));
-
 	current_file = file_lookup(name);
 	yylineno = 1;
 }
@@ -403,9 +400,10 @@ void zconf_nextfile(const char *name)
 	struct file *iter;
 	struct file *file = file_lookup(name);
 	struct buffer *buf = xmalloc(sizeof(*buf));
-	memset(buf, 0, sizeof(*buf));
 
-	current_buf->state = YY_CURRENT_BUFFER;
+	buf->state = YY_CURRENT_BUFFER;
+	buf->parent = current_buf;
+	current_buf = buf;
 	yyin = zconf_fopen(file->name);
 	if (!yyin) {
 		fprintf(stderr, "%s:%d: can't open file \"%s\"\n",
@@ -413,8 +411,6 @@ void zconf_nextfile(const char *name)
 		exit(1);
 	}
 	yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
-	buf->parent = current_buf;
-	current_buf = buf;
 
 	current_file->lineno = yylineno;
 	file->parent = current_file;
@@ -441,20 +437,21 @@ void zconf_nextfile(const char *name)
 
 static void zconf_endfile(void)
 {
-	struct buffer *parent;
+	struct buffer *tmp;
 
 	current_file = current_file->parent;
 	if (current_file)
 		yylineno = current_file->lineno;
 
-	parent = current_buf->parent;
-	if (parent) {
-		fclose(yyin);
-		yy_delete_buffer(YY_CURRENT_BUFFER);
-		yy_switch_to_buffer(parent->state);
-	}
-	free(current_buf);
-	current_buf = parent;
+	if (!current_buf)
+		return;
+
+	fclose(yyin);
+	yy_delete_buffer(YY_CURRENT_BUFFER);
+	yy_switch_to_buffer(current_buf->state);
+	tmp = current_buf;
+	current_buf = current_buf->parent;
+	free(tmp);
 }
 
 int zconf_lineno(void)
-- 
2.40.1


