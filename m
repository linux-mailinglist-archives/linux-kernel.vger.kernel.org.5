Return-Path: <linux-kernel+bounces-146419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADDA8A6504
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D022A1F21784
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E144155752;
	Tue, 16 Apr 2024 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmzRrNAn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3247FBA4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252211; cv=none; b=JdI0gz3Bgt3CQBKqB39jkRZHSNwui0olagor6nUuayjmUGIyuyAwi7k1nRnAVroePXD3fJHT/o/wlphMcTFy9Dd3MHgtiQdKFDHQvr5HrwOk9vIaNZpm3hbbYW9I0CWSCSi/AEDEaSTS7iEUr0ufTRpmYITZbeV3J1xaVwyeJ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252211; c=relaxed/simple;
	bh=i3fSC2Sh/bh/pxYyReh8mIapiLEcvyOrjS7DPGLwxGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NeiFV80VvepFGSJYqtv9doFLsnBXAkBpxDLTYcIarrbI2fnEvKiokb4bE/0r+k7MEL+KpUH8Xy6FczLlkVon2jGWTMnAnyrqyfnY37CyuqaHZuSfrLnPyCUgx0nZPyuwNdbrCxmq1RTQadlkJYU5mhcItDn9LrpLLw3zQaSYoeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmzRrNAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFBCC113CE;
	Tue, 16 Apr 2024 07:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713252211;
	bh=i3fSC2Sh/bh/pxYyReh8mIapiLEcvyOrjS7DPGLwxGg=;
	h=From:To:Cc:Subject:Date:From;
	b=pmzRrNAn/c99ECm+p/63BcBUXJBAOvsCcC0qPDo6usf22bxfystbdB+0IXl5k6KKr
	 CMgYFlwRYQ0oyci0aN29K4ii7j6Jn80azXZapmjhevKloLQ0/SLH5+SuTnAyYwHdcj
	 MNaHVb9ak8i3ZnYWY96+CMb+yFWMSgcqn8XN+BETuOo+KdjAVRLtZaoSNGqLXYndY+
	 kjjZ3ZjfsFFgvK0QoKV1JnvILvgRQut30UcqNgc5B5XE4qVxXSSd6ggg7kvX3O6DU2
	 u+ybA9Vn3/zO64Bl8ln8HR/3A3pmNOtpysmQvEQ+SlYLJAOCU90aM3wuxReBspWLEw
	 vWS+cgEPombzw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/4] f2fs: convert f2fs_mpage_readpages() to use folio
Date: Tue, 16 Apr 2024 15:23:15 +0800
Message-Id: <20240416072318.6486-1-chao@kernel.org>
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
 fs/f2fs/data.c | 80 +++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9c5512be1a1b..14dcd621acaa 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2374,7 +2374,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
  * Major change was from block_size == page_size in f2fs by default.
  */
 static int f2fs_mpage_readpages(struct inode *inode,
-		struct readahead_control *rac, struct page *page)
+		struct readahead_control *rac, struct folio *folio)
 {
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
@@ -2394,6 +2394,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 #endif
 	unsigned nr_pages = rac ? readahead_count(rac) : 1;
 	unsigned max_nr_pages = nr_pages;
+	pgoff_t index;
 	int ret = 0;
 
 	map.m_pblk = 0;
@@ -2407,64 +2408,63 @@ static int f2fs_mpage_readpages(struct inode *inode,
 
 	for (; nr_pages; nr_pages--) {
 		if (rac) {
-			page = readahead_page(rac);
-			prefetchw(&page->flags);
+			folio = readahead_folio(rac);
+			prefetchw(&folio->flags);
 		}
 
-#ifdef CONFIG_F2FS_FS_COMPRESSION
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
+		index = folio_index(folio);
 
-				nc_cluster_idx = NULL_CLUSTER;
-			}
-			ret = f2fs_init_compress_ctx(&cc);
+#ifdef CONFIG_F2FS_FS_COMPRESSION
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
@@ -2501,7 +2501,7 @@ static int f2fs_read_data_folio(struct file *file, struct folio *folio)
 	if (f2fs_has_inline_data(inode))
 		ret = f2fs_read_inline_data(inode, page);
 	if (ret == -EAGAIN)
-		ret = f2fs_mpage_readpages(inode, NULL, page);
+		ret = f2fs_mpage_readpages(inode, NULL, folio);
 	return ret;
 }
 
-- 
2.40.1


