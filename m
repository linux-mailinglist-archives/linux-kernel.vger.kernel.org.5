Return-Path: <linux-kernel+bounces-114616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD891888B53
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769461C2634B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A871813CABA;
	Sun, 24 Mar 2024 23:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/zfR8EU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF62233CC6;
	Sun, 24 Mar 2024 23:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322275; cv=none; b=PRrgcDrgIHAVYNkN5PYOivXOpZZQFOV6Pk+CH3Yc+J7TuVq6aoIiC8xz8nclYaGsLWYAYhxgpnz08VUUAxwXi8apZoaXZS8ZYobjxXYoLEl3RDdHAHv5vi2VofReApA07LA+Co0kblwJbzw2mRkcbczU+KGTGKtGUSBXvQ94YUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322275; c=relaxed/simple;
	bh=wGfbYmSnZGBN8OjHLJk4JPCJNN/xW3eJ40fgqG6Wvo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQKj9c14I8ICrAle7k5FUUgetNm1KzPEe1cLmMdXA91Llg1E1XkiBu2DZRdTMeovaqSXZSDu0nzd6QFOQzmHuFBerzt/xFn/6tH9G088KMFSUc15b3wyCEBPs2S3O/6Wapqxw3wr0pPCf6MhMchBPN+aXQAXJ7xOJbZoYzcQNog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/zfR8EU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF720C43399;
	Sun, 24 Mar 2024 23:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322274;
	bh=wGfbYmSnZGBN8OjHLJk4JPCJNN/xW3eJ40fgqG6Wvo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/zfR8EUQndRBJkWhFxA3jdyNHe+AkbXSlqWpSV4LCXRfaNCLEi4Jqu9Otie33kmB
	 g96lP98kb+AN0CP6yQPVA7KT4jtB9qoWStpQer6C7t9Mmx5oBqh7F3PQsJo870o20Q
	 DQK9zHsrmh/NMgQ16dUDiNHl4j8J29djr6ayBiY8SMfiouOKi4QILKxA8gIMFoLEhe
	 yy1IlaNsntudSXG+0PFs+st5UdlveW66KjU54PnEL3PDoka746e+8hGtPYbKU6rQwY
	 WyIbY6+Nq1EpiOAuFwv71sCSiyNjY59LP6xVEuxYMJPIq2k4+uGJZjWY18f2iYsYlK
	 HGKMaAKhtbFTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 357/451] f2fs: delete obsolete FI_FIRST_BLOCK_WRITTEN
Date: Sun, 24 Mar 2024 19:10:33 -0400
Message-ID: <20240324231207.1351418-358-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 553950962842a..5973fda2349c7 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1388,8 +1388,6 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	add_compr_block_stat(inode, cc->valid_nr_cpages);
 
 	set_inode_flag(cc->inode, FI_APPEND_WRITE);
-	if (cc->cluster_idx == 0)
-		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 
 	f2fs_put_dnode(&dn);
 	if (quota_inode)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 77b825fdeec85..95e737fc75ef0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2739,8 +2739,6 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	f2fs_outplace_write_data(&dn, fio);
 	trace_f2fs_do_write_data_page(page, OPU);
 	set_inode_flag(inode, FI_APPEND_WRITE);
-	if (page->index == 0)
-		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 out_writepage:
 	f2fs_put_dnode(&dn);
 out:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 16dacf811481c..2364b6f7500b2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -764,7 +764,6 @@ enum {
 	FI_UPDATE_WRITE,	/* inode has in-place-update data */
 	FI_NEED_IPU,		/* used for ipu per file */
 	FI_ATOMIC_FILE,		/* indicate atomic file */
-	FI_FIRST_BLOCK_WRITTEN,	/* indicate #0 data block was written */
 	FI_DROP_CACHE,		/* drop dirty page cache */
 	FI_DATA_EXIST,		/* indicate data exists */
 	FI_INLINE_DOTS,		/* indicate inline dot dentries */
@@ -3248,11 +3247,6 @@ static inline bool f2fs_is_cow_file(struct inode *inode)
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
index 6c9f03e3be8e9..4d634b5b6011f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -602,9 +602,6 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 				valid_blocks++;
 		}
 
-		if (dn->ofs_in_node == 0 && IS_INODE(dn->node_page))
-			clear_inode_flag(dn->inode, FI_FIRST_BLOCK_WRITTEN);
-
 		f2fs_invalidate_blocks(sbi, blkaddr);
 
 		if (!released || blkaddr != COMPRESS_ADDR)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 8161355658562..d4662ccb94c8f 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1410,8 +1410,6 @@ static int move_data_block(struct inode *inode, block_t bidx,
 
 	f2fs_update_data_blkaddr(&dn, newaddr);
 	set_inode_flag(inode, FI_APPEND_WRITE);
-	if (page->index == 0)
-		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 put_page_out:
 	f2fs_put_page(fio.encrypted_page, 1);
 recover_block:
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 0010579f17368..f0f2584fed66e 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -74,20 +74,6 @@ static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
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
@@ -336,7 +322,6 @@ static int do_read_inode(struct inode *inode)
 	struct page *node_page;
 	struct f2fs_inode *ri;
 	projid_t i_projid;
-	int err;
 
 	/* Check if ino is within scope */
 	if (f2fs_check_nid_range(sbi, inode->i_ino))
@@ -417,16 +402,6 @@ static int do_read_inode(struct inode *inode)
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


