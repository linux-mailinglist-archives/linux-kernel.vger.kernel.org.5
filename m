Return-Path: <linux-kernel+bounces-57201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAF884D511
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C1D28D991
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A706BFAF;
	Wed,  7 Feb 2024 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D21jP/Ur"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F41E1292E8;
	Wed,  7 Feb 2024 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341213; cv=none; b=uZCfynLNpGeu47WmjTazGfvL2ynT0MoA08SYbJMntoElcVCSEQn5kCI78anmjyaFK0WHoKMHWpRRTZEqaVm1bpX6ZovYezyVtG43xbKRGMRbSBpuixBBHdPUzfTthvko2gx07MF40pWGLg+BjufMhC9uCepm/84ja58J12Uf8IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341213; c=relaxed/simple;
	bh=2snEj2kC0enFNoSyzUn26Rza7/6eOb4qCdhoRdPcBrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1IQXMd4nfgX0oytAOxi3ldKGAywg9yRp7cfDKXyAwhgJ0G6pkWfYxKH+G5FMHQBHS7rTq4Lx74eJDJT4fZzoqk2pVypDGxFL02+JzHavHVuA61ALVHL+BZowIzVIqXvKmdHrDrU3NDTNkOcHSJTT1iMxM1tgbWeTIzWE3oLh0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D21jP/Ur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA382C43390;
	Wed,  7 Feb 2024 21:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341213;
	bh=2snEj2kC0enFNoSyzUn26Rza7/6eOb4qCdhoRdPcBrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D21jP/Urfz508lQDbWEYi9VZUmf/xjPZfD44zq+fUBjlN0wgy3vsPiiFRuuiDaVsp
	 y/9rsMPJg41wLleQ1UX0Saf80NaN3rdsKiA+BlJH1AkEvE2l0vaJHiSQSG72vYfyUV
	 eQTTNHQfdHYcmE1bA1hG9Ls9V8y1xt3VDfLtXGThLh4oraPwbfAYQDGwDmZekwi3uM
	 uhhZVUP4nkVIPS5+UR3mZA5NnUmvhpnhaZGDaJM8Z0n2RBF/atcMKAZhs7BLvWMq3+
	 ENF/rJNTcgoqLla5lzijhuSqqB4IkbdkZrmGPPxppU3e7HyKgwJbCa7Kawg46do1Zi
	 YDa4VHSYdz6Kg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 22/23] ext4: correct the hole length returned by ext4_map_blocks()
Date: Wed,  7 Feb 2024 16:26:03 -0500
Message-ID: <20240207212611.3793-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 6430dea07e85958fa87d0276c0c4388dd51e630b ]

In ext4_map_blocks(), if we can't find a range of mapping in the
extents cache, we are calling ext4_ext_map_blocks() to search the real
path and ext4_ext_determine_hole() to determine the hole range. But if
the querying range was partially or completely overlaped by a delalloc
extent, we can't find it in the real extent path, so the returned hole
length could be incorrect.

Fortunately, ext4_ext_put_gap_in_cache() have already handle delalloc
extent, but it searches start from the expanded hole_start, doesn't
start from the querying range, so the delalloc extent found could not be
the one that overlaped the querying range, plus, it also didn't adjust
the hole length. Let's just remove ext4_ext_put_gap_in_cache(), handle
delalloc and insert adjusted hole extent in ext4_ext_determine_hole().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240127015825.1608160-4-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 111 +++++++++++++++++++++++++++++-----------------
 1 file changed, 70 insertions(+), 41 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 592be39e3d51..cece004b32d5 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2227,7 +2227,7 @@ static int ext4_fill_es_cache_info(struct inode *inode,
 
 
 /*
- * ext4_ext_determine_hole - determine hole around given block
+ * ext4_ext_find_hole - find hole around given block according to the given path
  * @inode:	inode we lookup in
  * @path:	path in extent tree to @lblk
  * @lblk:	pointer to logical block around which we want to determine hole
@@ -2239,9 +2239,9 @@ static int ext4_fill_es_cache_info(struct inode *inode,
  * The function returns the length of a hole starting at @lblk. We update @lblk
  * to the beginning of the hole if we managed to find it.
  */
-static ext4_lblk_t ext4_ext_determine_hole(struct inode *inode,
-					   struct ext4_ext_path *path,
-					   ext4_lblk_t *lblk)
+static ext4_lblk_t ext4_ext_find_hole(struct inode *inode,
+				      struct ext4_ext_path *path,
+				      ext4_lblk_t *lblk)
 {
 	int depth = ext_depth(inode);
 	struct ext4_extent *ex;
@@ -2268,30 +2268,6 @@ static ext4_lblk_t ext4_ext_determine_hole(struct inode *inode,
 	return len;
 }
 
-/*
- * ext4_ext_put_gap_in_cache:
- * calculate boundaries of the gap that the requested block fits into
- * and cache this gap
- */
-static void
-ext4_ext_put_gap_in_cache(struct inode *inode, ext4_lblk_t hole_start,
-			  ext4_lblk_t hole_len)
-{
-	struct extent_status es;
-
-	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
-				  hole_start + hole_len - 1, &es);
-	if (es.es_len) {
-		/* There's delayed extent containing lblock? */
-		if (es.es_lblk <= hole_start)
-			return;
-		hole_len = min(es.es_lblk - hole_start, hole_len);
-	}
-	ext_debug(inode, " -> %u:%u\n", hole_start, hole_len);
-	ext4_es_insert_extent(inode, hole_start, hole_len, ~0,
-			      EXTENT_STATUS_HOLE);
-}
-
 /*
  * ext4_ext_rm_idx:
  * removes index from the index block.
@@ -4064,6 +4040,69 @@ static int get_implied_cluster_alloc(struct super_block *sb,
 	return 0;
 }
 
+/*
+ * Determine hole length around the given logical block, first try to
+ * locate and expand the hole from the given @path, and then adjust it
+ * if it's partially or completely converted to delayed extents, insert
+ * it into the extent cache tree if it's indeed a hole, finally return
+ * the length of the determined extent.
+ */
+static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
+						  struct ext4_ext_path *path,
+						  ext4_lblk_t lblk)
+{
+	ext4_lblk_t hole_start, len;
+	struct extent_status es;
+
+	hole_start = lblk;
+	len = ext4_ext_find_hole(inode, path, &hole_start);
+again:
+	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
+				  hole_start + len - 1, &es);
+	if (!es.es_len)
+		goto insert_hole;
+
+	/*
+	 * There's a delalloc extent in the hole, handle it if the delalloc
+	 * extent is in front of, behind and straddle the queried range.
+	 */
+	if (lblk >= es.es_lblk + es.es_len) {
+		/*
+		 * The delalloc extent is in front of the queried range,
+		 * find again from the queried start block.
+		 */
+		len -= lblk - hole_start;
+		hole_start = lblk;
+		goto again;
+	} else if (in_range(lblk, es.es_lblk, es.es_len)) {
+		/*
+		 * The delalloc extent containing lblk, it must have been
+		 * added after ext4_map_blocks() checked the extent status
+		 * tree, adjust the length to the delalloc extent's after
+		 * lblk.
+		 */
+		len = es.es_lblk + es.es_len - lblk;
+		return len;
+	} else {
+		/*
+		 * The delalloc extent is partially or completely behind
+		 * the queried range, update hole length until the
+		 * beginning of the delalloc extent.
+		 */
+		len = min(es.es_lblk - hole_start, len);
+	}
+
+insert_hole:
+	/* Put just found gap into cache to speed up subsequent requests */
+	ext_debug(inode, " -> %u:%u\n", hole_start, len);
+	ext4_es_insert_extent(inode, hole_start, len, ~0, EXTENT_STATUS_HOLE);
+
+	/* Update hole_len to reflect hole size after lblk */
+	if (hole_start != lblk)
+		len -= lblk - hole_start;
+
+	return len;
+}
 
 /*
  * Block allocation/map/preallocation routine for extents based files
@@ -4181,22 +4220,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	 * we couldn't try to create block if create flag is zero
 	 */
 	if ((flags & EXT4_GET_BLOCKS_CREATE) == 0) {
-		ext4_lblk_t hole_start, hole_len;
+		ext4_lblk_t len;
 
-		hole_start = map->m_lblk;
-		hole_len = ext4_ext_determine_hole(inode, path, &hole_start);
-		/*
-		 * put just found gap into cache to speed up
-		 * subsequent requests
-		 */
-		ext4_ext_put_gap_in_cache(inode, hole_start, hole_len);
+		len = ext4_ext_determine_insert_hole(inode, path, map->m_lblk);
 
-		/* Update hole_len to reflect hole size after map->m_lblk */
-		if (hole_start != map->m_lblk)
-			hole_len -= map->m_lblk - hole_start;
 		map->m_pblk = 0;
-		map->m_len = min_t(unsigned int, map->m_len, hole_len);
-
+		map->m_len = min_t(unsigned int, map->m_len, len);
 		goto out;
 	}
 
-- 
2.43.0


