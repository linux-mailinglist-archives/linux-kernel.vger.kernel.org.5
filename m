Return-Path: <linux-kernel+bounces-152781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0006B8AC427
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28EF1B22252
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B90A446D2;
	Mon, 22 Apr 2024 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcaS7Aqb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C275443ACE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767066; cv=none; b=g7ADro3Ike8aXhs962wviOC+Kx3N+CDoUG70rhHF1d2jNkOClkBwU+kdUAnUnqBGGR9qYzqC85pD2B6QdsLhKFdKNRDJLhlLXUDQIgcxtpYlagSH7farJifeOvbwIbGZRpuPp1Y9oO2HjCm7fcAsOD12S31esCGsjOmH1K2ZOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767066; c=relaxed/simple;
	bh=lq61WtOlYIOBoAAF9mgYkGC8E+tMVi57Ql/mXCqncQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IlsMB8nnOnDgvevKA4b+20WRCuDnUiksqnZpjJrxeCrMllKvtFdVcy3CEY894x71bVzIEN9mQKn4vdg8JB5p7Sv+HsTTClIaALpKosGN+RrtVSPucJmJAF2Rd7ZqIDBoUU+bxfDREtSXhKc5QsYlxrJicMr7MJB3cFIqROnMSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcaS7Aqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544F8C113CC;
	Mon, 22 Apr 2024 06:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713767066;
	bh=lq61WtOlYIOBoAAF9mgYkGC8E+tMVi57Ql/mXCqncQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LcaS7AqbEfyPuC8TTV8PfYy3fb2RB0Ta6U/sZx/YeksnX1Csf90pLAIQj1WICfcMG
	 T7O83eJHF/K/jsbGu8B88bEhvF0MbHVNegVHPd42fgSSAIAUPR4yVIIf7kFynhmIdX
	 5E4CXH3Ow6J0vDL0ZcqZPsiqQwAiR4tIHmBpWrj6I0syQUfYZT2BIfQd/+cK4VCea4
	 Ork8W1606pr5MHSW5Jcm5apIpInaPqW0V5XhovqmTJmT7DgyDpkw+ZzGWls6jpjSdO
	 JwcVBWV5HT6oXhBDzIOYdX1AAuSzYe5yJiSnMg6Hi73aAMc2rnlTsh2iI18q2kww2X
	 WbDzcwwqKc4kQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 2/4] f2fs: convert f2fs_read_single_page() to use folio
Date: Mon, 22 Apr 2024 14:24:15 +0800
Message-Id: <20240422062417.2421616-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240422062417.2421616-1-chao@kernel.org>
References: <20240422062417.2421616-1-chao@kernel.org>
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
v2:
- no change.
 fs/f2fs/data.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6419cf020327..bb6c0e955d7e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2063,7 +2063,7 @@ static inline loff_t f2fs_readpage_limit(struct inode *inode)
 	return i_size_read(inode);
 }
 
-static int f2fs_read_single_page(struct inode *inode, struct page *page,
+static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
 					unsigned nr_pages,
 					struct f2fs_map_blocks *map,
 					struct bio **bio_ret,
@@ -2076,9 +2076,10 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
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
@@ -2109,7 +2110,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 got_it:
 	if ((map->m_flags & F2FS_MAP_MAPPED)) {
 		block_nr = map->m_pblk + block_in_file - map->m_lblk;
-		SetPageMappedToDisk(page);
+		folio_set_mappedtodisk(folio);
 
 		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
 						DATA_GENERIC_ENHANCE_READ)) {
@@ -2118,15 +2119,15 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
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
 
@@ -2136,14 +2137,14 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
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
@@ -2158,7 +2159,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	 */
 	f2fs_wait_on_block_writeback(inode, block_nr);
 
-	if (bio_add_page(bio, page, blocksize, 0) < blocksize)
+	if (!bio_add_folio(bio, folio, blocksize, 0))
 		goto submit_and_realloc;
 
 	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
@@ -2423,7 +2424,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 		goto next_page;
 read_single_page:
 #endif
-		ret = f2fs_read_single_page(inode, &folio->page, max_nr_pages, &map,
+		ret = f2fs_read_single_page(inode, folio, max_nr_pages, &map,
 					&bio, &last_block_in_bio, rac);
 		if (ret) {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-- 
2.40.1


