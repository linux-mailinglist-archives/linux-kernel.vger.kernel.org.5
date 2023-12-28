Return-Path: <linux-kernel+bounces-12702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4585781F919
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11A9284F61
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431F3E578;
	Thu, 28 Dec 2023 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCLXEq5O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6BAE54C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 14:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B96FC433C7;
	Thu, 28 Dec 2023 14:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703773924;
	bh=9bgjtozDzWABSz5MpQDd5yOqAUr2mxUTvlK3pdYj7L8=;
	h=From:To:Cc:Subject:Date:From;
	b=MCLXEq5O89CRbk4jUqbDm2omlafRC6JTlg9vTcyDq6vLRBP3dpI9QgRtGvnIWNG4v
	 8J0hxmFQC3cSQyR1IIvWWdpCRuWAfa5Vg35cD82kZTumr3EtHIsg3XGjhC5qmWlpk3
	 bZy5U5nXuqVdB2+7/Kk/FYYDt3EAmJzJluGoupnrvrk2PJRVNlTqO+5aNIKfN0d2wT
	 2YBb4wcHt7+vtjkA9ihFzlL+JhHT8AbeOJT4blGyuAH2siqJCQPrjKwREbt4g2Xr3o
	 o27PWy9GvTg/OjyqfwJU8cblWTyPOna1+fuzIfacQmVzACfHYBr7dc2T69M1vv3npl
	 PwyTFH5EjzI3g==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 1/6] f2fs: compress: fix to guarantee persisting compressed blocks by CP
Date: Thu, 28 Dec 2023 22:31:47 +0800
Message-Id: <20231228143152.1543509-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If data block in compressed cluster is not persisted with metadata
during checkpoint, after SPOR, the data may be corrupted, let's
guarantee to write compressed page by checkpoint.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- treat compressed page as CP guaranteed data explictly.
 fs/f2fs/compress.c |  4 +++-
 fs/f2fs/data.c     | 17 +++++++++--------
 fs/f2fs/f2fs.h     |  4 +++-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index c5a4364c4482..9940b7886e5d 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1418,6 +1418,8 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page)
 	struct f2fs_sb_info *sbi = bio->bi_private;
 	struct compress_io_ctx *cic =
 			(struct compress_io_ctx *)page_private(page);
+	enum count_type type = WB_DATA_TYPE(page,
+				f2fs_is_compressed_page(page));
 	int i;
 
 	if (unlikely(bio->bi_status))
@@ -1425,7 +1427,7 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page)
 
 	f2fs_compress_free_page(page);
 
-	dec_page_count(sbi, F2FS_WB_DATA);
+	dec_page_count(sbi, type);
 
 	if (atomic_dec_return(&cic->pending_pages))
 		return;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dce8defdf4c7..81f9e2cc49e2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -48,7 +48,7 @@ void f2fs_destroy_bioset(void)
 	bioset_exit(&f2fs_bioset);
 }
 
-static bool __is_cp_guaranteed(struct page *page)
+bool f2fs_is_cp_guaranteed(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode;
@@ -65,8 +65,6 @@ static bool __is_cp_guaranteed(struct page *page)
 			S_ISDIR(inode->i_mode))
 		return true;
 
-	if (f2fs_is_compressed_page(page))
-		return false;
 	if ((S_ISREG(inode->i_mode) && IS_NOQUOTA(inode)) ||
 			page_private_gcing(page))
 		return true;
@@ -338,7 +336,7 @@ static void f2fs_write_end_io(struct bio *bio)
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		struct page *page = bvec->bv_page;
-		enum count_type type = WB_DATA_TYPE(page);
+		enum count_type type = WB_DATA_TYPE(page, false);
 
 		if (page_private_dummy(page)) {
 			clear_page_private_dummy(page);
@@ -762,7 +760,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 		wbc_account_cgroup_owner(fio->io_wbc, fio->page, PAGE_SIZE);
 
 	inc_page_count(fio->sbi, is_read_io(fio->op) ?
-			__read_io_type(page) : WB_DATA_TYPE(fio->page));
+			__read_io_type(page) : WB_DATA_TYPE(fio->page, false));
 
 	if (is_read_io(bio_op(bio)))
 		f2fs_submit_read_bio(fio->sbi, bio, fio->type);
@@ -973,7 +971,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	if (fio->io_wbc)
 		wbc_account_cgroup_owner(fio->io_wbc, fio->page, PAGE_SIZE);
 
-	inc_page_count(fio->sbi, WB_DATA_TYPE(page));
+	inc_page_count(fio->sbi, WB_DATA_TYPE(page, false));
 
 	*fio->last_block = fio->new_blkaddr;
 	*fio->bio = bio;
@@ -1007,6 +1005,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
 	struct f2fs_bio_info *io = sbi->write_io[btype] + fio->temp;
 	struct page *bio_page;
+	enum count_type type;
 
 	f2fs_bug_on(sbi, is_read_io(fio->op));
 
@@ -1046,7 +1045,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	/* set submitted = true as a return value */
 	fio->submitted = 1;
 
-	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
+	type = WB_DATA_TYPE(bio_page, fio->compressed_page);
+	inc_page_count(sbi, type);
 
 	if (io->bio &&
 	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
@@ -1059,7 +1059,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		if (F2FS_IO_ALIGNED(sbi) &&
 				(fio->type == DATA || fio->type == NODE) &&
 				fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)) {
-			dec_page_count(sbi, WB_DATA_TYPE(bio_page));
+			dec_page_count(sbi, WB_DATA_TYPE(bio_page,
+						fio->compressed_page));
 			fio->retry = 1;
 			goto skip;
 		}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 65294e3b0bef..50f3d546ded8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1080,7 +1080,8 @@ struct f2fs_sm_info {
  * f2fs monitors the number of several block types such as on-writeback,
  * dirty dentry blocks, dirty node blocks, and dirty meta blocks.
  */
-#define WB_DATA_TYPE(p)	(__is_cp_guaranteed(p) ? F2FS_WB_CP_DATA : F2FS_WB_DATA)
+#define WB_DATA_TYPE(p, f)			\
+	(f || f2fs_is_cp_guaranteed(p) ? F2FS_WB_CP_DATA : F2FS_WB_DATA)
 enum count_type {
 	F2FS_DIRTY_DENTS,
 	F2FS_DIRTY_DATA,
@@ -3804,6 +3805,7 @@ void f2fs_init_ckpt_req_control(struct f2fs_sb_info *sbi);
  */
 int __init f2fs_init_bioset(void);
 void f2fs_destroy_bioset(void);
+bool f2fs_is_cp_guaranteed(struct page *page);
 int f2fs_init_bio_entry_cache(void);
 void f2fs_destroy_bio_entry_cache(void);
 void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
-- 
2.40.1


