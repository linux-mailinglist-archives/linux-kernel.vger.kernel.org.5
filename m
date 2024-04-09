Return-Path: <linux-kernel+bounces-137599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE6A89E475
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AF41C20CB7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58561586CE;
	Tue,  9 Apr 2024 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgV+KyxM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7A044C9D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712694856; cv=none; b=l15gcy21CIwEZhcqfhMltHVVPKfs1GakvWVWXmzdSEPnl2yiIl0O2lIh5rnOlpYfP5f9G63piIEospdEJ5e7ec0nzS+WB3ciWI4bOv0yBtQl6GZDZyvRGsbEt8VRcGzKNCzyl7P6GecLSbQ1vpR9K+U0nr8cQWaPHMu5lHultPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712694856; c=relaxed/simple;
	bh=b3ttuqhR2lE3/ooK+He6Bxq4Y4ocjGQu2qVnnFvzt3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dsfkqw3+0i5h1AIXob9+5yKf99rSuIveeWF5joUkWVERM/ZDTdtTKy1DdfllQO13xSvnzCB/vtr4bXWTOiIjthrMyw/bRWNY9RLJIjkSpq7spHccUD9V3Jo3xhub9G6dekNicoorhpWwtr2ncrp2RJED2uUlIh1dn3OcEC7uxzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgV+KyxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9061AC433F1;
	Tue,  9 Apr 2024 20:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712694855;
	bh=b3ttuqhR2lE3/ooK+He6Bxq4Y4ocjGQu2qVnnFvzt3E=;
	h=From:To:Cc:Subject:Date:From;
	b=jgV+KyxMSmKVsIW5Datu32WxKTPm4RUP3BcRod7zvS2MN6JReG6EoIjj5fgi4XGtE
	 7vTK+miVqsVB2MhHxmbrXMtlQbzEM2ILUxcXHPgc9pxviFXQfwQkh5M/SefZPKuAvk
	 gGRrC2VtowxWxDd4zptc5FoF0eicC1tyBFZ2PoXO5a1eWYs0YxBA0HMaJOpox7belm
	 GrwsYUxaUhNMt+f8/veKgcWDptT3e52FZ+gbXdZHiP2mo8wnr6AbNiYAPy9ZLS9a7a
	 +XuWk4M+4vBRTstUu4xCKXOjLpFONnQHmuPAUmjBRl/gyhl5aPoRX/RqgveM1yF5nz
	 Drx+6Fi2bmXtw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: use folio_test_writeback
Date: Tue,  9 Apr 2024 20:34:09 +0000
Message-ID: <20240409203411.1885121-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's convert PageWriteback to folio_test_writeback.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/compress.c |  2 +-
 fs/f2fs/data.c     |  3 +--
 fs/f2fs/f2fs.h     |  2 +-
 fs/f2fs/gc.c       |  2 +-
 fs/f2fs/inline.c   |  2 +-
 fs/f2fs/inode.c    |  3 ++-
 fs/f2fs/node.c     |  2 +-
 fs/f2fs/segment.c  | 10 +++++-----
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 8892c8262141..d67c471ab5df 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1484,7 +1484,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		if (!PageDirty(cc->rpages[i]))
 			goto continue_unlock;
 
-		if (PageWriteback(cc->rpages[i])) {
+		if (folio_test_writeback(page_folio(cc->rpages[i]))) {
 			if (wbc->sync_mode == WB_SYNC_NONE)
 				goto continue_unlock;
 			f2fs_wait_on_page_writeback(cc->rpages[i], DATA, true, true);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 60056b9a51be..19f1e573297d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2707,8 +2707,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		if (err) {
 			if (fscrypt_inode_uses_fs_layer_crypto(inode))
 				fscrypt_finalize_bounce_page(&fio->encrypted_page);
-			if (PageWriteback(page))
-				end_page_writeback(page);
+			end_page_writeback(page);
 		} else {
 			set_inode_flag(inode, FI_UPDATE_WRITE);
 		}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e9ef971f4dba..dd530dc70005 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4660,7 +4660,7 @@ static inline void f2fs_truncate_meta_inode_pages(struct f2fs_sb_info *sbi,
 
 		page = find_get_page(META_MAPPING(sbi), blkaddr + i);
 		if (page) {
-			if (PageWriteback(page))
+			if (folio_test_writeback(page_folio(page)))
 				need_submit = true;
 			f2fs_put_page(page, 0);
 		}
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 8852814dab7f..ac4cbbe50c2f 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1434,7 +1434,7 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 		goto out;
 
 	if (gc_type == BG_GC) {
-		if (PageWriteback(page)) {
+		if (folio_test_writeback(page_folio(page))) {
 			err = -EAGAIN;
 			goto out;
 		}
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index ac00423f117b..3d3218a4b29d 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -164,7 +164,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 		return -EFSCORRUPTED;
 	}
 
-	f2fs_bug_on(F2FS_P_SB(page), PageWriteback(page));
+	f2fs_bug_on(F2FS_P_SB(page), folio_test_writeback(page_folio(page)));
 
 	f2fs_do_read_inline_data(page, dn->inode_page);
 	set_page_dirty(page);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 12b1fef31f43..d7a5a88a1a5e 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -161,7 +161,8 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
 	if (!f2fs_enable_inode_chksum(sbi, page))
 #else
 	if (!f2fs_enable_inode_chksum(sbi, page) ||
-			PageDirty(page) || PageWriteback(page))
+			PageDirty(page) ||
+			folio_test_writeback(page_folio(page)))
 #endif
 		return true;
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index bb57bbaff7b4..3b9eb5693683 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1743,7 +1743,7 @@ int f2fs_move_node_page(struct page *node_page, int gc_type)
 		goto release_page;
 	} else {
 		/* set page dirty and write it */
-		if (!PageWriteback(node_page))
+		if (!folio_test_writeback(page_folio(node_page)))
 			set_page_dirty(node_page);
 	}
 out_page:
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4fd76e867e0a..065fd5919b48 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3612,13 +3612,13 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	mutex_unlock(&curseg->curseg_mutex);
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
 	return 0;
+
 out_err:
 	*new_blkaddr = NULL_ADDR;
 	up_write(&sit_i->sentry_lock);
 	mutex_unlock(&curseg->curseg_mutex);
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
 	return ret;
-
 }
 
 void f2fs_update_device_state(struct f2fs_sb_info *sbi, nid_t ino,
@@ -3660,8 +3660,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 			&fio->new_blkaddr, sum, type, fio)) {
 		if (fscrypt_inode_uses_fs_layer_crypto(fio->page->mapping->host))
 			fscrypt_finalize_bounce_page(&fio->encrypted_page);
-		if (PageWriteback(fio->page))
-			end_page_writeback(fio->page);
+		end_page_writeback(fio->page);
 		if (f2fs_in_warm_node_list(fio->sbi, fio->page))
 			f2fs_del_fsync_node_entry(fio->sbi, fio->page);
 		goto out;
@@ -3904,7 +3903,7 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 void f2fs_wait_on_page_writeback(struct page *page,
 				enum page_type type, bool ordered, bool locked)
 {
-	if (PageWriteback(page)) {
+	if (folio_test_writeback(page_folio(page))) {
 		struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 
 		/* submit cached LFS IO */
@@ -3913,7 +3912,8 @@ void f2fs_wait_on_page_writeback(struct page *page,
 		f2fs_submit_merged_ipu_write(sbi, NULL, page);
 		if (ordered) {
 			wait_on_page_writeback(page);
-			f2fs_bug_on(sbi, locked && PageWriteback(page));
+			f2fs_bug_on(sbi, locked &&
+				folio_test_writeback(page_folio(page)));
 		} else {
 			wait_for_stable_page(page);
 		}
-- 
2.44.0.478.gd926399ef9-goog


