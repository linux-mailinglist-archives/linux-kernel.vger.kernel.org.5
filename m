Return-Path: <linux-kernel+bounces-114385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6542C888A27
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E741C27D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EDE272967;
	Sun, 24 Mar 2024 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3iaU6n4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C913DBB1;
	Sun, 24 Mar 2024 23:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321785; cv=none; b=Y6O3O0/mhoCg78RlgexX2bLo8wl4CrCrro2AJ0W/xXsGC1amj0LeW+VGF0SNuPzcFpPVCOpHwFacb7w/saBWdh43kWVlSscUWEw90V9kNYFnbumwUKek39VYkl1MBzqUf4fjP2Qc9CAinAvMoyW2/R6CEjzqHX/WJPzSFyAg0nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321785; c=relaxed/simple;
	bh=uImw4pK84pk3Qq3k0dJ1r/q4nJXq0hjMGvq1rdv3s54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtx1yoZ7wao+TAMJCh+MoRGWjhuOENyVq0Syxb108uXrO5+VloKBTjeiIYXtBjI2/4nBPSFz4tA8Jd4mRM5B62yabHWOcdP+uc63uKo1EM8bnMvG3+/AohuFEbjr+L1aIXcxP5TLy5YnNDwZNAe7G11aCaF0e3TkFKS6jVnZVtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3iaU6n4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198D3C43390;
	Sun, 24 Mar 2024 23:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321784;
	bh=uImw4pK84pk3Qq3k0dJ1r/q4nJXq0hjMGvq1rdv3s54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k3iaU6n4HYCoo3edP/UohI89i/5SyBefmLHu69vya5jiCwqF44U+T900U9tG0vtLy
	 p7cW5Z5fSJWciXxGlzB+yixwQKALdPp+D3qH/TnoczklBqrrVRv1wWOC01vsRL0iPr
	 vmt9oUFt96f4L0RQszP//myTpNujSKdBYPnvN+shpLPGFl2R+mSiCJIarCQ70713dJ
	 Fbx6myrd8yuW0JMZdy57H+F6dE+kamgJmMjOAgTGOYP98qF7t0kvoJVC67DGuJbYp3
	 IgwCOHtd1w8U/P1Iuxw8x0nQAYMXWWIynZIFmZsQMtYoIYL6Nj7gXAURL45PfJwOoX
	 qYtErBmBcSyMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 512/638] f2fs: delete obsolete FI_FIRST_BLOCK_WRITTEN
Date: Sun, 24 Mar 2024 18:59:09 -0400
Message-ID: <20240324230116.1348576-513-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit a53936361330e4c55c0654605178281387d9c761 ]

Commit 3c6c2bebef79 ("f2fs: avoid punch_hole overhead when releasing
volatile data") introduced FI_FIRST_BLOCK_WRITTEN as below reason:

This patch is to avoid some punch_hole overhead when releasing volatile
data. If volatile data was not written yet, we just can make the first
page as zero.

After commit 7bc155fec5b3 ("f2fs: kill volatile write support"), we
won't support volatile write, but it missed to remove obsolete
FI_FIRST_BLOCK_WRITTEN, delete it in this patch.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 54607494875e ("f2fs: compress: fix to avoid inconsistence bewteen i_blocks and dnode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c |  2 --
 fs/f2fs/data.c     |  2 --
 fs/f2fs/f2fs.h     |  6 ------
 fs/f2fs/file.c     |  3 ---
 fs/f2fs/gc.c       |  2 --
 fs/f2fs/inode.c    | 25 -------------------------
 6 files changed, 40 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 100353355213d..8093d2f2a174f 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1364,8 +1364,6 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	add_compr_block_stat(inode, cc->valid_nr_cpages);
 
 	set_inode_flag(cc->inode, FI_APPEND_WRITE);
-	if (cc->cluster_idx == 0)
-		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 
 	f2fs_put_dnode(&dn);
 	if (quota_inode)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6f673fc44bdbc..fee4c7130edaa 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2809,8 +2809,6 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	f2fs_outplace_write_data(&dn, fio);
 	trace_f2fs_do_write_data_page(page, OPU);
 	set_inode_flag(inode, FI_APPEND_WRITE);
-	if (page->index == 0)
-		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 out_writepage:
 	f2fs_put_dnode(&dn);
 out:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e4d2ac1f79c59..7acbc78b864b4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -774,7 +774,6 @@ enum {
 	FI_UPDATE_WRITE,	/* inode has in-place-update data */
 	FI_NEED_IPU,		/* used for ipu per file */
 	FI_ATOMIC_FILE,		/* indicate atomic file */
-	FI_FIRST_BLOCK_WRITTEN,	/* indicate #0 data block was written */
 	FI_DROP_CACHE,		/* drop dirty page cache */
 	FI_DATA_EXIST,		/* indicate data exists */
 	FI_INLINE_DOTS,		/* indicate inline dot dentries */
@@ -3272,11 +3271,6 @@ static inline bool f2fs_is_cow_file(struct inode *inode)
 	return is_inode_flag_set(inode, FI_COW_FILE);
 }
 
-static inline bool f2fs_is_first_block_written(struct inode *inode)
-{
-	return is_inode_flag_set(inode, FI_FIRST_BLOCK_WRITTEN);
-}
-
 static inline bool f2fs_is_drop_cache(struct inode *inode)
 {
 	return is_inode_flag_set(inode, FI_DROP_CACHE);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 436a59d33c923..c5ccdd3e58666 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -599,9 +599,6 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 				valid_blocks++;
 		}
 
-		if (dn->ofs_in_node == 0 && IS_INODE(dn->node_page))
-			clear_inode_flag(dn->inode, FI_FIRST_BLOCK_WRITTEN);
-
 		f2fs_invalidate_blocks(sbi, blkaddr);
 
 		if (!released || blkaddr != COMPRESS_ADDR)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f550cdeaa6638..2fbe16ad726f4 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1405,8 +1405,6 @@ static int move_data_block(struct inode *inode, block_t bidx,
 
 	f2fs_update_data_blkaddr(&dn, newaddr);
 	set_inode_flag(inode, FI_APPEND_WRITE);
-	if (page->index == 0)
-		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 put_page_out:
 	f2fs_put_page(fio.encrypted_page, 1);
 recover_block:
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index cde243840abd1..8d8e90152ca87 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -76,20 +76,6 @@ static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
 	}
 }
 
-static int __written_first_block(struct f2fs_sb_info *sbi,
-					struct f2fs_inode *ri)
-{
-	block_t addr = le32_to_cpu(ri->i_addr[offset_in_addr(ri)]);
-
-	if (!__is_valid_data_blkaddr(addr))
-		return 1;
-	if (!f2fs_is_valid_blkaddr(sbi, addr, DATA_GENERIC_ENHANCE)) {
-		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
-		return -EFSCORRUPTED;
-	}
-	return 0;
-}
-
 static void __set_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
 {
 	int extra_size = get_extra_isize(inode);
@@ -398,7 +384,6 @@ static int do_read_inode(struct inode *inode)
 	struct page *node_page;
 	struct f2fs_inode *ri;
 	projid_t i_projid;
-	int err;
 
 	/* Check if ino is within scope */
 	if (f2fs_check_nid_range(sbi, inode->i_ino))
@@ -480,16 +465,6 @@ static int do_read_inode(struct inode *inode)
 	/* get rdev by using inline_info */
 	__get_inode_rdev(inode, ri);
 
-	if (S_ISREG(inode->i_mode)) {
-		err = __written_first_block(sbi, ri);
-		if (err < 0) {
-			f2fs_put_page(node_page, 1);
-			return err;
-		}
-		if (!err)
-			set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
-	}
-
 	if (!f2fs_need_inode_block_update(sbi, inode->i_ino))
 		fi->last_disk_size = inode->i_size;
 
-- 
2.43.0


