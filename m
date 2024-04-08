Return-Path: <linux-kernel+bounces-134883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CB189B834
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4CC283ADD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A3823758;
	Mon,  8 Apr 2024 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgLeGJ76"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B701BC39;
	Mon,  8 Apr 2024 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712560684; cv=none; b=iPAvMEsJsHKG5LhvYBSdp/gh6MJsiYholl3dnb9T7NM4QMPoHwEzhJAyJlDtv3Alt9vXBK4yb790lK3gCxJOCpxaBr5bE9mmcBNs67iHgKB2p0d6T8QTS6f8sKiZfl4bC+iBHF2+cJCybCNAkct5rB+WXLmpUopIoutOfBrHK3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712560684; c=relaxed/simple;
	bh=PeBPt4G9W0LmsRTARU9M+5NwqUbIJJWVt9mpkDc2sWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QfrHXKIXgylZNnK2db6uppuBtrvn/mv0gxjgpqRP+eog1B8Lh6gsxuCce3fR+bM0GvES5AWrap9i9WUQtfnqjn0728NrXfaiTQX53eH+qwsZULVppONjtSJGEcbbstuLNUnXHw7QHZU+UYIHCSDIzQEnCP5feAYPP9oZNXo4NdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgLeGJ76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AD8C433F1;
	Mon,  8 Apr 2024 07:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712560683;
	bh=PeBPt4G9W0LmsRTARU9M+5NwqUbIJJWVt9mpkDc2sWg=;
	h=From:To:Cc:Subject:Date:From;
	b=UgLeGJ76YP3rd6UiwswfVWrpKIHDyxNPQic39I/Spme7VRat0g+2xW/AiXlz6FdDf
	 lsemZ3tLEXS0hqvpZoCQK0ZJlVjO+s9MbC8H0AQDn+UmraV7OexV1Yoflm49jOfAts
	 cXdwrtgzDqihIwGO/Pt0id5EpsODa1ksBFoyDsABRARPsqapRINpGZ/DxxkrfTk2O0
	 3glL661XlJ+nQojgSMLcerJjV4kcDqmf3DHIvdiV7U3OWnCXp1mP46HkDEJWDEPEk+
	 Dp0aTe163K3z3TBa4ZKc01uLQAAyYeSXJstdcI7Hr+ViKyhGSbX9IVLnTnDuQJWmsv
	 k87l5ACeSDbug==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Tony Finch <dot@dotat.at>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] scripts/unifdef: avoid constexpr keyword
Date: Mon,  8 Apr 2024 09:17:52 +0200
Message-Id: <20240408071758.2526806-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Starting with c23, 'constexpr' is a keyword in C like in C++ and cannot
be used as an identifier:

scripts/unifdef.c:206:25: error: 'constexpr' can only be used in variable declarations
  206 | static bool             constexpr;              /* constant #if expression */
      |                         ^
scripts/unifdef.c:880:13: error: expected identifier or '('
  880 |                 constexpr = false;
      |                           ^

Rename this instance to allow changing to C23 at some point in the future.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kbuild@vger.kernel.org
Reviewed-By: Tony Finch <dot@dotat.at>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 v2: include fixup from Tony
---
 scripts/unifdef.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/unifdef.c b/scripts/unifdef.c
index db00e3e30a59..ff15efd6e7d7 100644
--- a/scripts/unifdef.c
+++ b/scripts/unifdef.c
@@ -203,7 +203,7 @@ static int              depth;			/* current #if nesting */
 static int              delcount;		/* count of deleted lines */
 static unsigned         blankcount;		/* count of blank lines */
 static unsigned         blankmax;		/* maximum recent blankcount */
-static bool             constexpr;		/* constant #if expression */
+static bool             constexpression;	/* constant #if expression */
 static bool             zerosyms = true;	/* to format symdepth output */
 static bool             firstsym;		/* ditto */
 
@@ -819,7 +819,7 @@ static const struct ops {
 /*
  * Function for evaluating the innermost parts of expressions,
  * viz. !expr (expr) number defined(symbol) symbol
- * We reset the constexpr flag in the last two cases.
+ * We reset the constexpression flag in the last two cases.
  */
 static Linetype
 eval_unary(const struct ops *ops, int *valp, const char **cpp)
@@ -877,7 +877,7 @@ eval_unary(const struct ops *ops, int *valp, const char **cpp)
 		cp = skipcomment(cp);
 		if (defparen && *cp++ != ')')
 			return (LT_ERROR);
-		constexpr = false;
+		constexpression = false;
 	} else if (!endsym(*cp)) {
 		debug("eval%d symbol", ops - eval_ops);
 		sym = findsym(cp);
@@ -895,7 +895,7 @@ eval_unary(const struct ops *ops, int *valp, const char **cpp)
 			lt = *valp ? LT_TRUE : LT_FALSE;
 			cp = skipargs(cp);
 		}
-		constexpr = false;
+		constexpression = false;
 	} else {
 		debug("eval%d bad expr", ops - eval_ops);
 		return (LT_ERROR);
@@ -955,10 +955,10 @@ ifeval(const char **cpp)
 	int val = 0;
 
 	debug("eval %s", *cpp);
-	constexpr = killconsts ? false : true;
+	constexpression = killconsts ? false : true;
 	ret = eval_table(eval_ops, &val, cpp);
 	debug("eval = %d", val);
-	return (constexpr ? LT_IF : ret == LT_ERROR ? LT_IF : ret);
+	return (constexpression ? LT_IF : ret == LT_ERROR ? LT_IF : ret);
 }
 
 /*
-- 
2.39.2


