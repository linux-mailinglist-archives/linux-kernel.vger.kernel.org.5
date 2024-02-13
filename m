Return-Path: <linux-kernel+bounces-63273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5C7852D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266291F21101
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B9D24A13;
	Tue, 13 Feb 2024 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2/QZK6n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85450241E5;
	Tue, 13 Feb 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818059; cv=none; b=guj/xtE5c/slJbQ+XPCjhhqKHeZ3hVSijpVW+/vbhNCzNdhX4GyBuZ4jP2EBETK1coOnPtDMQRlocGEC4hVqR0DsEljT/nYaCdlbnnVB0cEK5viLA38sREuDcf2AOzf3J71Fvc6xOoFyScV0d0n7TyHFOp1WUclWQen1CSE15Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818059; c=relaxed/simple;
	bh=tyrKSJ+fpXIRAZe8ycgeQ8Vq9Yq+VZQ5WTyjhUVTRPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BGJ/zW+VCMmB9SaFWCLT5CdBpDNfwKPzG1DDlPw332kBIDVR7wYVGXmm4Jn2ntuOVMkhczBjTwpkuboTZfQdYIP0LmxTJMeATmZcCFENvHvVRZ2H/t1Da/HRM5LliPfW6zxxkyu9qUsBriY/p/0nJ/TC9y3DNO0PQQxzYsiz09A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2/QZK6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8707AC433C7;
	Tue, 13 Feb 2024 09:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707818059;
	bh=tyrKSJ+fpXIRAZe8ycgeQ8Vq9Yq+VZQ5WTyjhUVTRPA=;
	h=From:To:Cc:Subject:Date:From;
	b=m2/QZK6nA2S8/E5kGUsVsTSn9C71ihbSd/3BFmOQyQAui7Jb8Sa1MhdrvJnzxLweS
	 irAvGeDMdoCeXu6FjLCaB964QMcwrfLD+Yj5ev+8e3khQ6qMGYyofGPbxAhwJeCXmf
	 yfmIF0qWgYGDCVuOA5liTwZO1YFrHcJODG93j+26y/pt4R8jizxu5oQlqttzahfJtX
	 M6Ln4G2r+tP7S/Dnq5iuSLpx2W6iFtEt2K8PTJsB/8R4v//i2ntTXlnsGbVNwZTz60
	 goTtSlhokITvTnTMm+bzHzbVn4xKC5/isBKi5DeqYYsU4iS5W6MyyxaOwkvGP6YbuO
	 v/LkRqSB8YDFw==
From: Arnd Bergmann <arnd@kernel.org>
To: Richard Weinberger <richard@nod.at>,
	Nathan Chancellor <nathan@kernel.org>,
	Adrian Hunter <ext-adrian.hunter@nokia.com>,
	Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 1/2] ubifs: fix sort function prototype
Date: Tue, 13 Feb 2024 10:54:07 +0100
Message-Id: <20240213095412.453787-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The global sort() function expects a callback pointer to a function with two
void* arguments, but ubifs has a function with specific object types, which
causes a warning in clang-16 and higher:

fs/ubifs/lprops.c:1272:9: error: cast from 'int (*)(struct ubifs_info *, const struct ubifs_lprops *, int, struct ubifs_lp_stats *)' to 'ubifs_lpt_scan_callback' (aka 'int (*)(struct ubifs_info *, const struct ubifs_lprops *, int, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
 1272 |                                     (ubifs_lpt_scan_callback)scan_check_cb,
      |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Change the prototype to the regular one and cast the object pointers
locally instead.

Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ubifs/find.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ubifs/find.c b/fs/ubifs/find.c
index 873e6e1c92b5..1cb79b167a4f 100644
--- a/fs/ubifs/find.c
+++ b/fs/ubifs/find.c
@@ -726,11 +726,10 @@ int ubifs_find_free_leb_for_idx(struct ubifs_info *c)
 	return err;
 }
 
-static int cmp_dirty_idx(const struct ubifs_lprops **a,
-			 const struct ubifs_lprops **b)
+static int cmp_dirty_idx(const void *a, const void *b)
 {
-	const struct ubifs_lprops *lpa = *a;
-	const struct ubifs_lprops *lpb = *b;
+	const struct ubifs_lprops *lpa = *(const struct ubifs_lprops **)a;
+	const struct ubifs_lprops *lpb = *(const struct ubifs_lprops **)b;
 
 	return lpa->dirty + lpa->free - lpb->dirty - lpb->free;
 }
@@ -754,7 +753,7 @@ int ubifs_save_dirty_idx_lnums(struct ubifs_info *c)
 	       sizeof(void *) * c->dirty_idx.cnt);
 	/* Sort it so that the dirtiest is now at the end */
 	sort(c->dirty_idx.arr, c->dirty_idx.cnt, sizeof(void *),
-	     (int (*)(const void *, const void *))cmp_dirty_idx, NULL);
+	     cmp_dirty_idx, NULL);
 	dbg_find("found %d dirty index LEBs", c->dirty_idx.cnt);
 	if (c->dirty_idx.cnt)
 		dbg_find("dirtiest index LEB is %d with dirty %d and free %d",
-- 
2.39.2


