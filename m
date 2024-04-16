Return-Path: <linux-kernel+bounces-146421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E038B8A6508
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA551C21255
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674C21598E7;
	Tue, 16 Apr 2024 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoxT+UxJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB044158D98
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252213; cv=none; b=VTMSB/DCC1KIBxkoUiL+FhIZ0HS/WO9qBsuXOsqafrRZ3JzfSP/6uGnkt0vPzEfEUSj1L/F9WSBEeZUwngBhcridu1w14jhkKYEAYjzy1jS9220Z0hNYo8yWtFOCw08NaAAqthrTo+dqzvBrZyRp7dMS3qVqbGwbzpmaIlywz4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252213; c=relaxed/simple;
	bh=+rHA/TjA7B8eR6kxVZ+90vp2Y9xGqpF27dl9oDGOTCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lQwtEPhHcOrJTIOvLmt0jVg094H0YLkMQlOyXA0fvk4r9lNZrrmRYo6wclaDcC92Bosphn4CGacPoKLBPEeNImzhy5x4/t/fPOuRX1Yvbj0lRyi5/wxkwsi9elLB94EcGfPFgt3MVPDI2DewitACVKvm0+j36JW6wFvzYo9KRE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoxT+UxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCED4C4AF07;
	Tue, 16 Apr 2024 07:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713252213;
	bh=+rHA/TjA7B8eR6kxVZ+90vp2Y9xGqpF27dl9oDGOTCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FoxT+UxJEf+VaWlxWxF+lc6GlEDeXmwoSWwYq9YqLCgs+z6+8IJV+I34mp1l1k5QC
	 I8Qf1H7YCeViM7zxMI3Rk4rsntyhRzjYyKLkmqqjYqlFYz5RBYUnXfaGZNE1Poz6Sk
	 W/V5d+tyfya1T/tozU40xqeBgLUFOrnc8Z4OOBXiLcVFLBFuxmTRzm60gi9Rem3L9x
	 FXJr81HS8fFpRn8C3RvBhTnlV/AIvMdize9pZQpdu0r604uTJyo6jq9JBYWM2ru8KZ
	 8uB2OM8Y6m0GpH2diij3Xrx5aMZGateWpOZheqLPEx7ldeMX0uiiNC/7IqnARph3UV
	 aXbjHwY1JKhqg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/4] f2fs: convert f2fs_read_single_page() to use folio
Date: Tue, 16 Apr 2024 15:23:16 +0800
Message-Id: <20240416072318.6486-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240416072318.6486-1-chao@kernel.org>
References: <20240416072318.6486-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert f2fs_read_single_page() to use folio and related
functionality.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 14dcd621acaa..c35107657c97 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2092,7 +2092,7 @@ static inline loff_t f2fs_readpage_limit(struct inode *inode)
 	return i_size_read(inode);
 }
 
-static int f2fs_read_single_page(struct inode *inode, struct page *page,
+static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
 					unsigned nr_pages,
 					struct f2fs_map_blocks *map,
 					struct bio **bio_ret,
@@ -2105,9 +2105,10 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	sector_t last_block;
 	sector_t last_block_in_file;
 	sector_t block_nr;
+	pgoff_t index = folio_index(folio);
 	int ret = 0;
 
-	block_in_file = (sector_t)page_index(page);
+	block_in_file = (sector_t)index;
 	last_block = block_in_file + nr_pages;
 	last_block_in_file = bytes_to_blks(inode,
 			f2fs_readpage_limit(inode) + blocksize - 1);
@@ -2138,7 +2139,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 got_it:
 	if ((map->m_flags & F2FS_MAP_MAPPED)) {
 		block_nr = map->m_pblk + block_in_file - map->m_lblk;
-		SetPageMappedToDisk(page);
+		folio_set_mappedtodisk(folio);
 
 		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
 						DATA_GENERIC_ENHANCE_READ)) {
@@ -2147,15 +2148,15 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 		}
 	} else {
 zero_out:
-		zero_user_segment(page, 0, PAGE_SIZE);
-		if (f2fs_need_verity(inode, page->index) &&
-		    !fsverity_verify_page(page)) {
+		folio_zero_segment(folio, 0, folio_size(folio));
+		if (f2fs_need_verity(inode, index) &&
+		    !fsverity_verify_folio(folio)) {
 			ret = -EIO;
 			goto out;
 		}
-		if (!PageUptodate(page))
-			SetPageUptodate(page);
-		unlock_page(page);
+		if (!folio_test_uptodate(folio))
+			folio_mark_uptodate(folio);
+		folio_unlock(folio);
 		goto out;
 	}
 
@@ -2165,14 +2166,14 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	 */
 	if (bio && (!page_is_mergeable(F2FS_I_SB(inode), bio,
 				       *last_block_in_bio, block_nr) ||
-		    !f2fs_crypt_mergeable_bio(bio, inode, page->index, NULL))) {
+		    !f2fs_crypt_mergeable_bio(bio, inode, index, NULL))) {
 submit_and_realloc:
 		f2fs_submit_read_bio(F2FS_I_SB(inode), bio, DATA);
 		bio = NULL;
 	}
 	if (bio == NULL) {
 		bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
-				is_readahead ? REQ_RAHEAD : 0, page->index,
+				is_readahead ? REQ_RAHEAD : 0, index,
 				false);
 		if (IS_ERR(bio)) {
 			ret = PTR_ERR(bio);
@@ -2187,7 +2188,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	 */
 	f2fs_wait_on_block_writeback(inode, block_nr);
 
-	if (bio_add_page(bio, page, blocksize, 0) < blocksize)
+	if (!bio_add_folio(bio, folio, blocksize, 0))
 		goto submit_and_realloc;
 
 	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
@@ -2453,7 +2454,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 read_single_page:
 #endif
 
-		ret = f2fs_read_single_page(inode, &folio->page, max_nr_pages, &map,
+		ret = f2fs_read_single_page(inode, folio, max_nr_pages, &map,
 					&bio, &last_block_in_bio, rac);
 		if (ret) {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-- 
2.40.1


