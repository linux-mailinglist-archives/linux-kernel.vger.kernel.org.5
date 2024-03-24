Return-Path: <linux-kernel+bounces-113914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D19888758
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D640B2330B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BA8212572;
	Sun, 24 Mar 2024 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxCuXBE6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5174149C6C;
	Sun, 24 Mar 2024 22:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321007; cv=none; b=KxrSHmHjXoG+ODbq4DdQU5BlIR0P1iCMaZhYeCPqLfAayqPvp6fm4db9qF8yOxEdJZ6vVTbXIZTR9+k+WcmJC4wtHQeXaieVxgF0jzLkN2XRHk0ZAeq17eMNykNA9JGfId2aiFz20JEO062Tf0uXyqMm/W+TjFaODDp4Ln5ShkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321007; c=relaxed/simple;
	bh=cwRNxhXWNw47SjWgUnjk7NJpAlO72cCaT6tJDj3G88Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQRMAJ7caEvkqn/HFj/aDVIBonwLgmkMyur1Nappsh6cx6eYkg45jNCOT5kIBk5sluufekLh6uRmHtUt8McjPDH0uzGA5CVxJJYguFQybf2roD+24oGIMIAKMKgcd3oS9pOHEOEnBtnr2IfaR96xYOKjorrrTpNYa4UgHMXwvns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxCuXBE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22ABAC433C7;
	Sun, 24 Mar 2024 22:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321007;
	bh=cwRNxhXWNw47SjWgUnjk7NJpAlO72cCaT6tJDj3G88Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxCuXBE6KwDZsh0EMqtdVHmFGt1LoZEaUCh1lusA5eORu2xaPmYm147NLVqq4RZ2v
	 d8j0gJTGwp6Y+dBPNJl53q7KZcKtlqVEDKDGFXLnpgeTdwvmVklR8dN11a94klpO1C
	 0A1O7QnS3ld1rnqwU1coCHBDSXlR278JsUvKqorrxZ8fKnGs0y5bQ4eHMebg7W1UQM
	 Ub+VN+7HQa6stZWmYExiQJuNGY2ZqwgST5NASdpF+t6ATC5E8Wq7f0Y0PAUSbxiWYK
	 YzNr7VjREAyx1J0fmNkMNC8Vfzdp39Ccg4HtvJgM5Z6oenetW9dy4JMzeDa+qU21Q9
	 aizBqrBzwYaAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 570/713] f2fs: delete obsolete FI_FIRST_BLOCK_WRITTEN
Date: Sun, 24 Mar 2024 18:44:56 -0400
Message-ID: <20240324224720.1345309-571-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 94e0b0aa95e9b..06e9bbfba1f1a 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1371,8 +1371,6 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	add_compr_block_stat(inode, cc->valid_nr_cpages);
 
 	set_inode_flag(cc->inode, FI_APPEND_WRITE);
-	if (cc->cluster_idx == 0)
-		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 
 	f2fs_put_dnode(&dn);
 	if (quota_inode)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b7845be96f6d4..ce9dd11c62886 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2812,8 +2812,6 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	f2fs_outplace_write_data(&dn, fio);
 	trace_f2fs_do_write_data_page(page, OPU);
 	set_inode_flag(inode, FI_APPEND_WRITE);
-	if (page->index == 0)
-		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 out_writepage:
 	f2fs_put_dnode(&dn);
 out:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2f899d54d1837..d94ae53356b52 100644
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
@@ -3273,11 +3272,6 @@ static inline bool f2fs_is_cow_file(struct inode *inode)
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
index 01b6295341918..14eecc63dc077 100644
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
index 560bfcad1af23..108e3d00028a1 100644
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


