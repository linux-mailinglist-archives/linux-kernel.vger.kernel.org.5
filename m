Return-Path: <linux-kernel+bounces-109266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8712B8816FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E7C1F2352A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5156A359;
	Wed, 20 Mar 2024 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwPoVxfw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED946A35B;
	Wed, 20 Mar 2024 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957699; cv=none; b=kZpmBy2Hg5te9c3hx/1ox4ZitV/ygas0LZ042ibp9bNHj1HAV6oPLPXRB9uXDukCGsljRAPbVEKbPXMsmY2LAh5B1cdF7G6iUafpZJS5ajHK1HDubVtCIdjB5Jw5UChcpSy5/+i/IDMYzeNics5OnCnTw3iuvYJgm7FE5bqGXWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957699; c=relaxed/simple;
	bh=llIBXk76Yuad8T3alnGEbUTLVx756v+KmjcXU9Ak8MA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m8WBTCLHzLzwbsS5ufjDzjqmJW6hDrniRZAwElLx8m5/SeQVXzkMCn2vWeLjC/kPk8zJRlU0P1Un0UWILkJRXtOqGMmG/9zwja08Y/sIweWk2uTRDrMZPjuP0B8xsJ+5SKcePrQALbk3RBvUc+vpprqNrwA4Y1SQ0/oLWygxfzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwPoVxfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A32C433C7;
	Wed, 20 Mar 2024 18:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710957699;
	bh=llIBXk76Yuad8T3alnGEbUTLVx756v+KmjcXU9Ak8MA=;
	h=From:To:Cc:Subject:Date:From;
	b=gwPoVxfwRZjCBKMju8mA83r6FEoT8PmuO0bob0NvMR2jWn/xwGFZZV4uEV9mG9rh9
	 dSphKTn11rgn/UyOJ0FZYKqS9Xzh4No/BlfvkbzqaNaXlsLDFn/WuR5ZghgWyWx8PI
	 08UkSDQGGtwXwJTukevbXDLZyQo58se/7m4N6U3klbycY1A/ukx9ubUYWehVePimC3
	 LkIUC8IxgydlIEL138wzx6G0IezxFVc+c50zzoyGgprPF47KQok/fArXghUFejLgF0
	 6gB1EkNtKPlDxf8pgEIaLDEAswHWYrw62VFrl101YqgzGCvvUNSo77+VBdje65XrJV
	 4MsqNcq4ItQqg==
From: Arnd Bergmann <arnd@kernel.org>
To: Tony Finch <dot@dotat.at>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	Michal Marek <mmarek@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/unifdef: avoid constexpr keyword
Date: Wed, 20 Mar 2024 18:59:25 +0100
Message-Id: <20240320180134.100863-1-arnd@kernel.org>
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

Fixes: d8379ab1dde3 ("unifdef: update to upstream revision 1.190")
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/unifdef.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/unifdef.c b/scripts/unifdef.c
index db00e3e30a59..1cc31448fd10 100644
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


