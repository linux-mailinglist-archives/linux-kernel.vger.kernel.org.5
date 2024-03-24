Return-Path: <linux-kernel+bounces-113450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C45288846E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300241C23CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFFB1AE8F3;
	Sun, 24 Mar 2024 22:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpMHdPr0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC1F1AE8CD;
	Sun, 24 Mar 2024 22:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320252; cv=none; b=mkKX0gew3xn0Y/ZPIUxoclcQY0QtoZyIU0F4SGGayqFNOTuobFAvZGtKxzEoo2e5hoiL7KBe4KF3lMUblmhZw1V9j7cB9DAhJGj+rhyCMX+ahDKUxDNY8ZW3sNOSA6acjISf3lGOkNTGv00Ycu8eH38gTajrO22Pxs1Guog1XMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320252; c=relaxed/simple;
	bh=OL/nnTz4eR3VfyoniYVBW5CLME8rWWSikfF8Vp0ue4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFRm7O5q46z1QUKJS1mnGwYcx7iU/Yyj2f9vODtTGWzgcqOrTKI8J9ZRHbXBi9gWcUcUxMTO7OxZ1bG1vTaND8/d2sqOodMP8sjnGt+8wSPPrpJfcT6BpSqPanYV8USJ5QOnp9sI9eDOseuyZ0m2y5Bl3JaVozksMXxMX0HtBDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpMHdPr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AE7C433A6;
	Sun, 24 Mar 2024 22:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320251;
	bh=OL/nnTz4eR3VfyoniYVBW5CLME8rWWSikfF8Vp0ue4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PpMHdPr0rCuZ0SZYzVdRyIatEhuMfXnB6fPj1eux36UnColpo1yLi0gQINNpVTMxw
	 BFLxsoVjNWySt+4zNO0jhtQVBT1EF4oNpYyxf164ITStw5BL9UA+le77nMUOelu0yt
	 Nw5DeG9bjqW9p+sC05oDXI7rEzhnsZNJ9DGXUoa9nhoEOsANeuXU1ZXE9AzOozHLBv
	 DBPMQStYg0p2iJ1KQ7/N56NDZ1aptCV+CjQaSdJYd+5aVhognzW3yLChoA8GchptKZ
	 QJfXcVo48K3NT2X/ctYe6fDWzVu/o+NwXORLUZOJcrgHeJpt2ZB0TRzbmH0ohuF73l
	 LV9OOy1s5yKEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 559/715] f2fs: compress: fix to guarantee persisting compressed blocks by CP
Date: Sun, 24 Mar 2024 18:32:18 -0400
Message-ID: <20240324223455.1342824-560-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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

[ Upstream commit 8a430dd49e9cb021372b0ad91e60aeef9c6ced00 ]

If data block in compressed cluster is not persisted with metadata
during checkpoint, after SPOR, the data may be corrupted, let's
guarantee to write compressed page by checkpoint.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c |  4 +++-
 fs/f2fs/data.c     | 17 +++++++++--------
 fs/f2fs/f2fs.h     |  4 +++-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 531517dac0796..3a8d8a213b406 100644
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
index 26e317696b338..d00e92b6c9025 100644
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
index 31554e2a0a320..99511d9a92c0c 100644
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
2.43.0


