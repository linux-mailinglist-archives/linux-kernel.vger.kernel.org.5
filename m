Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E4980B9F7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 10:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjLJJUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 04:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjLJJUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 04:20:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C1E102
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 01:20:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35EEC433C8;
        Sun, 10 Dec 2023 09:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702200047;
        bh=c1XbgCcpxu3d0B/1CATk98nDLk0XqyEJ9d7k2gjQZM8=;
        h=From:To:Cc:Subject:Date:From;
        b=ih4AafpLeUQyDzAUdh8J9F7WUFdiDG6H+E8KdJ1BitFkJ6vjAwXbJft2PvHru8VaF
         gWit9nM9FUzXDDy/xgbfyH7WfoUEUkjO7osz4/hj5jdoeS1S/3JuQJvh5tvZ2J6pPM
         luLUwllV8invWxjOlNNxp18PnIySvO4hfzj5IXHE+CQO2DBMhRmZ6AfIXx5S0ApECC
         iNH+eeWUgEJMJ14gRyl32kNwd5zty4XyLBGFKfix2HFyRWNjDDs41VDQMo58xSh5XN
         QSpdH9VT2oY+XqtnaOxEU+JKAszpPXz0nq9qT13BebnwSJV4iBPBOpC8BazuFCddeU
         XEn1tofwaPofg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 1/6] f2fs: delete obsolete FI_FIRST_BLOCK_WRITTEN
Date:   Sun, 10 Dec 2023 17:20:35 +0800
Message-Id: <20231210092040.3374741-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3c6c2bebef79 ("f2fs: avoid punch_hole overhead when releasing
volatile data") introduced FI_FIRST_BLOCK_WRITTEN as below reason:

This patch is to avoid some punch_hole overhead when releasing volatile
data. If volatile data was not written yet, we just can make the first
page as zero.

After commit 7bc155fec5b3 ("f2fs: kill volatile write support"), we
won't support volatile write, but it missed to remove obsolete
FI_FIRST_BLOCK_WRITTEN, delete it in this patch.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c |  2 --
 fs/f2fs/data.c     |  2 --
 fs/f2fs/f2fs.h     |  6 ------
 fs/f2fs/file.c     |  3 ---
 fs/f2fs/gc.c       |  2 --
 fs/f2fs/inode.c    | 25 -------------------------
 6 files changed, 40 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 36e5dab6baae..b35be5799726 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1369,8 +1369,6 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	add_compr_block_stat(inode, cc->valid_nr_cpages);
 
 	set_inode_flag(cc->inode, FI_APPEND_WRITE);
-	if (cc->cluster_idx == 0)
-		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 
 	f2fs_put_dnode(&dn);
 	if (quota_inode)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 42f0f6184f73..73d0726ac366 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2810,8 +2810,6 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	f2fs_outplace_write_data(&dn, fio);
 	trace_f2fs_do_write_data_page(page, OPU);
 	set_inode_flag(inode, FI_APPEND_WRITE);
-	if (page->index == 0)
-		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 out_writepage:
 	f2fs_put_dnode(&dn);
 out:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 86a145be4e53..be9a8e50ac50 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -781,7 +781,6 @@ enum {
 	FI_UPDATE_WRITE,	/* inode has in-place-update data */
 	FI_NEED_IPU,		/* used for ipu per file */
 	FI_ATOMIC_FILE,		/* indicate atomic file */
-	FI_FIRST_BLOCK_WRITTEN,	/* indicate #0 data block was written */
 	FI_DROP_CACHE,		/* drop dirty page cache */
 	FI_DATA_EXIST,		/* indicate data exists */
 	FI_INLINE_DOTS,		/* indicate inline dot dentries */
@@ -3279,11 +3278,6 @@ static inline bool f2fs_is_cow_file(struct inode *inode)
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
index 325dab01a29d..5025abf2d995 100644
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
index f550cdeaa663..2fbe16ad726f 100644
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
index 560bfcad1af2..108e3d00028a 100644
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
2.40.1

