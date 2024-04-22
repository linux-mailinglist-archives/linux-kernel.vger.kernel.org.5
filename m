Return-Path: <linux-kernel+bounces-152779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB28AC421
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7F81F21A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1732341231;
	Mon, 22 Apr 2024 06:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+el3r3n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5428A1802B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767065; cv=none; b=PP0McBglc77aZQHZkjzImrFL2z0UstinvoYoLB6oKlEAm1+rYrzzigjcBMl9QzcAO4MUD34Mo7r0Fyy90Rq4g1q0YABxPs6g2yBxhLdhTxyPfMTbQ6nppQ9HL1BJwkHvolylSUFSx1uhTBW45GCeyniPYV0fywwNulBds13r6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767065; c=relaxed/simple;
	bh=2QoZ6xX4IimgOgvIRYJS2/KFiClJl3fHIS1noYBxHZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f2o59bQfyvNDubSx5YORof3h+ytLTnIOA4TGJY+wlHLYOQ+Ahg1JqxIIYbdutjNRRSZyYsPA8I8tuTxrhHiY5dGAniuPwRbOOpsGfAIHQ07NpLAjCmCI46FAM2iUOfLcTgMJxrowpsPqGmNlvW5taenTEK8t0P5I0Z5M51JWJlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+el3r3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9FBC116B1;
	Mon, 22 Apr 2024 06:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713767064;
	bh=2QoZ6xX4IimgOgvIRYJS2/KFiClJl3fHIS1noYBxHZI=;
	h=From:To:Cc:Subject:Date:From;
	b=L+el3r3nSlCtYRJogplF8kaG7cSfgKJKTO2aTkJFvJy+GTo+A20CNyJLvoFKydy9p
	 693A20syONNQ1vqBX4aQASUamtPQT+aV05b8q8+idnZFAmc9tTlqx7cjLID/fU1c/H
	 CJLuukhW45QnMz1MrnCPDm8P2Sb9CRkyh5AZC/d9Czz9wrE958LwUj2krxfyOvIq45
	 kr2feC11lYEgDADb2mB91TpiBCY/KmsFHFZ5lT53LkyypFzP2mnbFO0XHVYuepSr4B
	 hozQT0fPOLE8Fz7mOdf+JOHjt2OILnzFE85/SlVhLCiQRqX4xByk6N/tbzQLCrsyZb
	 3CFeUGBcV2MWA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 1/4] f2fs: convert f2fs_mpage_readpages() to use folio
Date: Mon, 22 Apr 2024 14:24:14 +0800
Message-Id: <20240422062417.2421616-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert f2fs_mpage_readpages() to use folio and related
functionality.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix compile warning w/o CONFIG_F2FS_FS_COMPRESSION reported by lkp
 fs/f2fs/data.c | 81 +++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 41 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ed7d08785fcf..6419cf020327 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2345,7 +2345,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
  * Major change was from block_size == page_size in f2fs by default.
  */
 static int f2fs_mpage_readpages(struct inode *inode,
-		struct readahead_control *rac, struct page *page)
+		struct readahead_control *rac, struct folio *folio)
 {
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
@@ -2362,6 +2362,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 		.nr_cpages = 0,
 	};
 	pgoff_t nc_cluster_idx = NULL_CLUSTER;
+	pgoff_t index;
 #endif
 	unsigned nr_pages = rac ? readahead_count(rac) : 1;
 	unsigned max_nr_pages = nr_pages;
@@ -2378,64 +2379,62 @@ static int f2fs_mpage_readpages(struct inode *inode,
 
 	for (; nr_pages; nr_pages--) {
 		if (rac) {
-			page = readahead_page(rac);
-			prefetchw(&page->flags);
+			folio = readahead_folio(rac);
+			prefetchw(&folio->flags);
 		}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-		if (f2fs_compressed_file(inode)) {
-			/* there are remained compressed pages, submit them */
-			if (!f2fs_cluster_can_merge_page(&cc, page->index)) {
-				ret = f2fs_read_multi_pages(&cc, &bio,
-							max_nr_pages,
-							&last_block_in_bio,
-							rac != NULL, false);
-				f2fs_destroy_compress_ctx(&cc, false);
-				if (ret)
-					goto set_error_page;
-			}
-			if (cc.cluster_idx == NULL_CLUSTER) {
-				if (nc_cluster_idx ==
-					page->index >> cc.log_cluster_size) {
-					goto read_single_page;
-				}
-
-				ret = f2fs_is_compressed_cluster(inode, page->index);
-				if (ret < 0)
-					goto set_error_page;
-				else if (!ret) {
-					nc_cluster_idx =
-						page->index >> cc.log_cluster_size;
-					goto read_single_page;
-				}
-
-				nc_cluster_idx = NULL_CLUSTER;
-			}
-			ret = f2fs_init_compress_ctx(&cc);
+		index = folio_index(folio);
+
+		if (!f2fs_compressed_file(inode))
+			goto read_single_page;
+
+		/* there are remained compressed pages, submit them */
+		if (!f2fs_cluster_can_merge_page(&cc, index)) {
+			ret = f2fs_read_multi_pages(&cc, &bio,
+						max_nr_pages,
+						&last_block_in_bio,
+						rac != NULL, false);
+			f2fs_destroy_compress_ctx(&cc, false);
 			if (ret)
 				goto set_error_page;
+		}
+		if (cc.cluster_idx == NULL_CLUSTER) {
+			if (nc_cluster_idx == index >> cc.log_cluster_size)
+				goto read_single_page;
 
-			f2fs_compress_ctx_add_page(&cc, page);
+			ret = f2fs_is_compressed_cluster(inode, index);
+			if (ret < 0)
+				goto set_error_page;
+			else if (!ret) {
+				nc_cluster_idx =
+					index >> cc.log_cluster_size;
+				goto read_single_page;
+			}
 
-			goto next_page;
+			nc_cluster_idx = NULL_CLUSTER;
 		}
+		ret = f2fs_init_compress_ctx(&cc);
+		if (ret)
+			goto set_error_page;
+
+		f2fs_compress_ctx_add_page(&cc, &folio->page);
+
+		goto next_page;
 read_single_page:
 #endif
-
-		ret = f2fs_read_single_page(inode, page, max_nr_pages, &map,
+		ret = f2fs_read_single_page(inode, &folio->page, max_nr_pages, &map,
 					&bio, &last_block_in_bio, rac);
 		if (ret) {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 set_error_page:
 #endif
-			zero_user_segment(page, 0, PAGE_SIZE);
-			unlock_page(page);
+			folio_zero_segment(folio, 0, folio_size(folio));
+			folio_unlock(folio);
 		}
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 next_page:
 #endif
-		if (rac)
-			put_page(page);
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		if (f2fs_compressed_file(inode)) {
@@ -2472,7 +2471,7 @@ static int f2fs_read_data_folio(struct file *file, struct folio *folio)
 	if (f2fs_has_inline_data(inode))
 		ret = f2fs_read_inline_data(inode, page);
 	if (ret == -EAGAIN)
-		ret = f2fs_mpage_readpages(inode, NULL, page);
+		ret = f2fs_mpage_readpages(inode, NULL, folio);
 	return ret;
 }
 
-- 
2.40.1


