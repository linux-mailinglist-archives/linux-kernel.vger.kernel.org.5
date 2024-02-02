Return-Path: <linux-kernel+bounces-50069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D7A8473E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2BF1F23C85
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAABE14A4E5;
	Fri,  2 Feb 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtAWmj2G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7A614A4D0;
	Fri,  2 Feb 2024 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889521; cv=none; b=LUEmCLpak0qYw3CAaad0CUhZZlBkMGa4F0EbzEMHIGn/qd/HL2pp3nd2IP8Dibha24tW/L4UIVQfqzZRYcjwZ+W89Qi2bQ2X9iFFzY1wpiH5Gb8AtBqwtBhQaNxltOpaQ1DhryfOxaV46hBkr9IV47laTxyHxU3fRKW0jJjWty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889521; c=relaxed/simple;
	bh=8wkF4aCE3aM2rNs899RXOTttKfK3DnuDTaZdLUAKOrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JDq4Xyy14MPvM0t4SgDZDev0qqOjj47pVmeu6NrZwpstMQ8AA8Sqcy5/HdoERLp4jreXrNTVvnLVrNjg0TapXopVzzYvmWuUNb3YXu/M8q4Ge3nehjpXc/lrHlJhGZUtqa5KyFt3F+8a12CqJeB1NY5NuVi8/DYxBL7ZiQqKm0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtAWmj2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56A0C43394;
	Fri,  2 Feb 2024 15:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889520;
	bh=8wkF4aCE3aM2rNs899RXOTttKfK3DnuDTaZdLUAKOrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EtAWmj2GnZ9LalaqkZJtJmN54oRDwbsmKa3ZSy+feXm/bK+8miHaLi8rLJ0KlGz17
	 svTAIO0xE2Ik+DZ2Vvhrag3+bOCH48ienK0/8htM5PaL0gs/4SmRNRCcqTmsZGnvmI
	 LjGUl8x2/UgxL8QW1gPMExpWq8jy6eFZSIGoHFBRetJti4/kVh6XkllGlRcWqEmF76
	 f9OCQdGw4j8ILqN5FZ49QYK2qSBpAkAh4C5ZHwi+qUX7Yzp+0XBYRmMtoJj2whcAG6
	 qWi7q5Dw0nbZtiNhex0wQs8RI/D6n1342U+psgnRSa1g9ZRQtgK9WojsAjbTHX9+cn
	 85Ml7qSR1H2ew==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 09/27] kconfig: replace current_pos with separate cur_{filename,lineno}
Date: Sat,  3 Feb 2024 00:58:07 +0900
Message-Id: <20240202155825.314567-10-masahiroy@kernel.org>
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

Replace current_pos with separate variables representing the file name
and the line number, respectively.

No functional change is intended.

By the way, you might wonder why the "<none>" fallback exists in
zconf_curname(). menu_add_symbol() saves the current file and the line
number. It is intended to be called only during the yyparse() time.
However, menu_finalize() calls it, where there is no file being parsed.
This is a long-standing hack that should be fixed later. I left a FIXME
comment.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lexer.l | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index 1bb372868ecf..540098435a3b 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -22,10 +22,14 @@
 
 #define START_STRSIZE	16
 
-static struct {
-	struct file *file;
-	int lineno;
-} current_pos;
+/* The Kconfig file currently being parsed.  */
+static const char *cur_filename;
+
+/*
+ * The line number of the current statement. This does not match yylineno.
+ * yylineno is used by the lexer, while cur_lineno is used by the parser.
+ */
+static int cur_lineno;
 
 static int prev_prev_token = T_EOL;
 static int prev_token = T_EOL;
@@ -279,9 +283,14 @@ repeat:
 			 * of each statement. Generally, \n is a statement
 			 * terminator in Kconfig, but it is not always true
 			 * because \n could be escaped by a backslash.
+			 *
+			 * FIXME:
+			 * cur_filename and cur_lineno are used even after
+			 * yyparse(); menu_finalize() calls menu_add_symbol().
+			 * This should be fixed.
 			 */
-			current_pos.file = current_file;
-			current_pos.lineno = yylineno;
+			cur_filename = current_file ? current_file->name : "<none>";
+			cur_lineno = yylineno;
 		}
 	}
 
@@ -462,10 +471,10 @@ static void zconf_endfile(void)
 
 int zconf_lineno(void)
 {
-	return current_pos.lineno;
+	return cur_lineno;
 }
 
 const char *zconf_curname(void)
 {
-	return current_pos.file ? current_pos.file->name : "<none>";
+	return cur_filename;
 }
-- 
2.40.1


