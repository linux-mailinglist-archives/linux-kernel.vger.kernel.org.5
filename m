Return-Path: <linux-kernel+bounces-63274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A77A852D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38D61F25DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13DE29416;
	Tue, 13 Feb 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0jX4YQq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AD7286B3;
	Tue, 13 Feb 2024 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818068; cv=none; b=mfy5a1J3NayRpm+dEDMq+7/g2WyyRob+6Ej/qFxWfOPO5OJ4aqucMamgm+GYCtV45yz8ElPyypQQZmj/nJwNMsVisrBDI3X3bjJisQ8GHM/T1i+uN6GlqFlJDHOG9B1+zzGlvTw+D4G5GE/N8u1CuyR1QGdNMq4F9NGLDwBNy0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818068; c=relaxed/simple;
	bh=a/+zm9TK2gFwduZGHY8tOoqlh5IFNkxyekCp8Kj3vNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hJ7X4j8JaEE8VL3r/VKMWhuMDE4a5RKqA0fDfHzRIfy1+RsC0DgLZbFtsJFfs2+D3wFBGOFk959fdhtGclGVIhxbS2iptNNLdRBGhuV+FZCF0Y7Iu/uyepDNHS7Hkyn5fklEf7FuNQL0Ft0vGQQpxBb2GM3cXClOhrCWhB5Z3us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0jX4YQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8A4C433F1;
	Tue, 13 Feb 2024 09:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707818067;
	bh=a/+zm9TK2gFwduZGHY8tOoqlh5IFNkxyekCp8Kj3vNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d0jX4YQqsFpBUFVUwJ0jlProFRRBqVM13YzAweJwe7L/sp+YDfbSrSlcEOQ3oPtiG
	 3p6aLorkXyU6m6E+SfWhpxrrwWHE0aaYGYEpc2j3sEmh/HBGjjU3JzvbIq5ydTzj4m
	 bR7xFazpb9XLFFtKwr+LHzYzVghqOKaLzmpTiS6Ce7XW5/WsOdFKRe7jkeHgXtRx+i
	 P3Q3FvH8eHlgyizzUF0UbpftuMi4WpyS3WDn3IxX+7leza+YlcPTbBSQc94C6OeyHg
	 G383gV534kiPIcmo/r83es031BqrUR84VS6SpDq3hkrf83vtSYxMSs34HDirGPjXr7
	 AbCdFw6V0OUTg==
From: Arnd Bergmann <arnd@kernel.org>
To: Richard Weinberger <richard@nod.at>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 2/2] ubifs: fix function pointer cast warnings
Date: Tue, 13 Feb 2024 10:54:08 +0100
Message-Id: <20240213095412.453787-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213095412.453787-1-arnd@kernel.org>
References: <20240213095412.453787-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

ubifs has a number of callback functions for ubifs_lpt_scan_nolock() using
two different prototypes, either passing a struct scan_data or
a struct ubifs_lp_stats, but the caller expects a void pointer instead.

clang-16 now warns about this:

fs/ubifs/find.c:170:9: error: cast from 'int (*)(struct ubifs_info *, const struct ubifs_lprops *, int, struct scan_data *)' to 'ubifs_lpt_scan_callback' (aka 'int (*)(struct ubifs_info *, const struct ubifs_lprops *, int, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  170 |                                     (ubifs_lpt_scan_callback)scan_for_dirty_cb,
      |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/ubifs/find.c:449:9: error: cast from 'int (*)(struct ubifs_info *, const struct ubifs_lprops *, int, struct scan_data *)' to 'ubifs_lpt_scan_callback' (aka 'int (*)(struct ubifs_info *, const struct ubifs_lprops *, int, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  449 |                                     (ubifs_lpt_scan_callback)scan_for_free_cb,
      |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Change all of these callback functions to actually take the void * argument
that is passed by their caller.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ubifs/find.c   | 23 ++++++++++++-----------
 fs/ubifs/lprops.c |  6 +++---
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/ubifs/find.c b/fs/ubifs/find.c
index 1cb79b167a4f..6ebf3c04ac5f 100644
--- a/fs/ubifs/find.c
+++ b/fs/ubifs/find.c
@@ -82,8 +82,9 @@ static int valuable(struct ubifs_info *c, const struct ubifs_lprops *lprops)
  */
 static int scan_for_dirty_cb(struct ubifs_info *c,
 			     const struct ubifs_lprops *lprops, int in_tree,
-			     struct scan_data *data)
+			     void *arg)
 {
+	struct scan_data *data = arg;
 	int ret = LPT_SCAN_CONTINUE;
 
 	/* Exclude LEBs that are currently in use */
@@ -166,8 +167,7 @@ static const struct ubifs_lprops *scan_for_dirty(struct ubifs_info *c,
 	data.pick_free = pick_free;
 	data.lnum = -1;
 	data.exclude_index = exclude_index;
-	err = ubifs_lpt_scan_nolock(c, -1, c->lscan_lnum,
-				    (ubifs_lpt_scan_callback)scan_for_dirty_cb,
+	err = ubifs_lpt_scan_nolock(c, -1, c->lscan_lnum, scan_for_dirty_cb,
 				    &data);
 	if (err)
 		return ERR_PTR(err);
@@ -349,8 +349,9 @@ int ubifs_find_dirty_leb(struct ubifs_info *c, struct ubifs_lprops *ret_lp,
  */
 static int scan_for_free_cb(struct ubifs_info *c,
 			    const struct ubifs_lprops *lprops, int in_tree,
-			    struct scan_data *data)
+			    void *arg)
 {
+	struct scan_data *data = arg;
 	int ret = LPT_SCAN_CONTINUE;
 
 	/* Exclude LEBs that are currently in use */
@@ -446,7 +447,7 @@ const struct ubifs_lprops *do_find_free_space(struct ubifs_info *c,
 	data.pick_free = pick_free;
 	data.lnum = -1;
 	err = ubifs_lpt_scan_nolock(c, -1, c->lscan_lnum,
-				    (ubifs_lpt_scan_callback)scan_for_free_cb,
+				    scan_for_free_cb,
 				    &data);
 	if (err)
 		return ERR_PTR(err);
@@ -589,8 +590,9 @@ int ubifs_find_free_space(struct ubifs_info *c, int min_space, int *offs,
  */
 static int scan_for_idx_cb(struct ubifs_info *c,
 			   const struct ubifs_lprops *lprops, int in_tree,
-			   struct scan_data *data)
+			   void *arg)
 {
+	struct scan_data *data = arg;
 	int ret = LPT_SCAN_CONTINUE;
 
 	/* Exclude LEBs that are currently in use */
@@ -625,8 +627,7 @@ static const struct ubifs_lprops *scan_for_leb_for_idx(struct ubifs_info *c)
 	int err;
 
 	data.lnum = -1;
-	err = ubifs_lpt_scan_nolock(c, -1, c->lscan_lnum,
-				    (ubifs_lpt_scan_callback)scan_for_idx_cb,
+	err = ubifs_lpt_scan_nolock(c, -1, c->lscan_lnum, scan_for_idx_cb,
 				    &data);
 	if (err)
 		return ERR_PTR(err);
@@ -781,8 +782,9 @@ int ubifs_save_dirty_idx_lnums(struct ubifs_info *c)
  */
 static int scan_dirty_idx_cb(struct ubifs_info *c,
 			   const struct ubifs_lprops *lprops, int in_tree,
-			   struct scan_data *data)
+			   void *arg)
 {
+	struct scan_data *data = arg;
 	int ret = LPT_SCAN_CONTINUE;
 
 	/* Exclude LEBs that are currently in use */
@@ -841,8 +843,7 @@ static int find_dirty_idx_leb(struct ubifs_info *c)
 	if (c->pnodes_have >= c->pnode_cnt)
 		/* All pnodes are in memory, so skip scan */
 		return -ENOSPC;
-	err = ubifs_lpt_scan_nolock(c, -1, c->lscan_lnum,
-				    (ubifs_lpt_scan_callback)scan_dirty_idx_cb,
+	err = ubifs_lpt_scan_nolock(c, -1, c->lscan_lnum, scan_dirty_idx_cb,
 				    &data);
 	if (err)
 		return err;
diff --git a/fs/ubifs/lprops.c b/fs/ubifs/lprops.c
index 6d6cd85c2b4c..a11c3dab7e16 100644
--- a/fs/ubifs/lprops.c
+++ b/fs/ubifs/lprops.c
@@ -1014,8 +1014,9 @@ void dbg_check_heap(struct ubifs_info *c, struct ubifs_lpt_heap *heap, int cat,
  */
 static int scan_check_cb(struct ubifs_info *c,
 			 const struct ubifs_lprops *lp, int in_tree,
-			 struct ubifs_lp_stats *lst)
+			 void *arg)
 {
+	struct ubifs_lp_stats *lst = arg;
 	struct ubifs_scan_leb *sleb;
 	struct ubifs_scan_node *snod;
 	int cat, lnum = lp->lnum, is_idx = 0, used = 0, free, dirty, ret;
@@ -1269,8 +1270,7 @@ int dbg_check_lprops(struct ubifs_info *c)
 
 	memset(&lst, 0, sizeof(struct ubifs_lp_stats));
 	err = ubifs_lpt_scan_nolock(c, c->main_first, c->leb_cnt - 1,
-				    (ubifs_lpt_scan_callback)scan_check_cb,
-				    &lst);
+				    scan_check_cb, &lst);
 	if (err && err != -ENOSPC)
 		goto out;
 
-- 
2.39.2


