Return-Path: <linux-kernel+bounces-152782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E12A18AC429
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C6E1C21BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E1F45C10;
	Mon, 22 Apr 2024 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj9OYEaM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2D345BE6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767068; cv=none; b=phttekJtZYwKwpLhIbcBf8XTF1l9wg6ivfgge4NlP3U3x3fiFeNv+rWQPWCK+TFAh06kcN52H26WYXBsruHoXfW7Fwd2qcBrXDwi3K4Hy6S6kYPWG9EBfD9aZEv+Mw6skOt9lhVORoQwUoKXNmQrKs7Zuwm6DUbZPG1fYuTOmDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767068; c=relaxed/simple;
	bh=UXeIomZemy3zpwCifF52rGb5bBATrGJrCt/HKWLMLTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kd1+M7AhvkJZuwvSid7N9XUP9evwX67BWyK6aZk2HEYYNystP5gmtYTiFFNMnzmJZhDz1v8WP0FT+gQmcVLk93YU4sG0UwphFaGtyP5cEK7GyDdirlni+pmFiPnT64TgflRF4Bj1R4pVI4yzyNA8SQUd6qL+Xe7QOZtCrZ5YNp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj9OYEaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20368C116B1;
	Mon, 22 Apr 2024 06:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713767068;
	bh=UXeIomZemy3zpwCifF52rGb5bBATrGJrCt/HKWLMLTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lj9OYEaMDXoPMSLnwW+EthLhggh6OLYI0H7Wx+wX8nEYzdBr9KeJ//zH5vH7aZ3Sv
	 r8xKSNcBAFu6aPb7sPOKhbCAzVcr67SF56r/uslbrgMcofbPdMKKa1kH1Hfbx1kBeo
	 zlXX/CiRQ1W7NeLIVV2GnxjLTjKLDM2U3/e3fatrilSSzQ1l8g3MlYwAGfQ+H7HUi2
	 +juMOG1PgE+l/u5l7RlOSk95rvEQiTGYV/YxMG8guEmOAMAjbQknADRIAGBpwESKZ4
	 +Gs34/HLkyxgifPR5Le4I8w33lOvFTva/+taiDhZw1mEpWElkTszx1mcwYL13rVGhD
	 dh1dk/+uaTT6Q==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 3/4] f2fs: convert f2fs_read_inline_data() to use folio
Date: Mon, 22 Apr 2024 14:24:16 +0800
Message-Id: <20240422062417.2421616-3-chao@kernel.org>
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

Convert f2fs_read_inline_data() to use folio and related
functionality, and also convert its caller to use folio.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- no change.
 fs/f2fs/data.c   | 11 +++++------
 fs/f2fs/f2fs.h   |  4 ++--
 fs/f2fs/inline.c | 34 +++++++++++++++++-----------------
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bb6c0e955d7e..24f9a39ffd56 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2457,20 +2457,19 @@ static int f2fs_mpage_readpages(struct inode *inode,
 
 static int f2fs_read_data_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
-	struct inode *inode = page_file_mapping(page)->host;
+	struct inode *inode = folio_file_mapping(folio)->host;
 	int ret = -EAGAIN;
 
-	trace_f2fs_readpage(page, DATA);
+	trace_f2fs_readpage(&folio->page, DATA);
 
 	if (!f2fs_is_compress_backend_ready(inode)) {
-		unlock_page(page);
+		folio_unlock(folio);
 		return -EOPNOTSUPP;
 	}
 
 	/* If the file has inline data, try to read it directly */
 	if (f2fs_has_inline_data(inode))
-		ret = f2fs_read_inline_data(inode, page);
+		ret = f2fs_read_inline_data(inode, folio);
 	if (ret == -EAGAIN)
 		ret = f2fs_mpage_readpages(inode, NULL, folio);
 	return ret;
@@ -3399,7 +3398,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 	if (f2fs_has_inline_data(inode)) {
 		if (pos + len <= MAX_INLINE_DATA(inode)) {
-			f2fs_do_read_inline_data(page, ipage);
+			f2fs_do_read_inline_data(page_folio(page), ipage);
 			set_inode_flag(inode, FI_DATA_EXIST);
 			if (inode->i_nlink)
 				set_page_private_inline(ipage);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3f7196122574..a0ae99bcca39 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4154,10 +4154,10 @@ extern struct kmem_cache *f2fs_inode_entry_slab;
 bool f2fs_may_inline_data(struct inode *inode);
 bool f2fs_sanity_check_inline_data(struct inode *inode);
 bool f2fs_may_inline_dentry(struct inode *inode);
-void f2fs_do_read_inline_data(struct page *page, struct page *ipage);
+void f2fs_do_read_inline_data(struct folio *folio, struct page *ipage);
 void f2fs_truncate_inline_inode(struct inode *inode,
 						struct page *ipage, u64 from);
-int f2fs_read_inline_data(struct inode *inode, struct page *page);
+int f2fs_read_inline_data(struct inode *inode, struct folio *folio);
 int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page);
 int f2fs_convert_inline_inode(struct inode *inode);
 int f2fs_try_convert_inline_dir(struct inode *dir, struct dentry *dentry);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 3d3218a4b29d..7638d0d7b7ee 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -61,22 +61,22 @@ bool f2fs_may_inline_dentry(struct inode *inode)
 	return true;
 }
 
-void f2fs_do_read_inline_data(struct page *page, struct page *ipage)
+void f2fs_do_read_inline_data(struct folio *folio, struct page *ipage)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio_file_mapping(folio)->host;
 
-	if (PageUptodate(page))
+	if (folio_test_uptodate(folio))
 		return;
 
-	f2fs_bug_on(F2FS_P_SB(page), page->index);
+	f2fs_bug_on(F2FS_I_SB(inode), folio_index(folio));
 
-	zero_user_segment(page, MAX_INLINE_DATA(inode), PAGE_SIZE);
+	folio_zero_segment(folio, MAX_INLINE_DATA(inode), folio_size(folio));
 
 	/* Copy the whole inline data block */
-	memcpy_to_page(page, 0, inline_data_addr(inode, ipage),
+	memcpy_to_folio(folio, 0, inline_data_addr(inode, ipage),
 		       MAX_INLINE_DATA(inode));
-	if (!PageUptodate(page))
-		SetPageUptodate(page);
+	if (!folio_test_uptodate(folio))
+		folio_mark_uptodate(folio);
 }
 
 void f2fs_truncate_inline_inode(struct inode *inode,
@@ -97,13 +97,13 @@ void f2fs_truncate_inline_inode(struct inode *inode,
 		clear_inode_flag(inode, FI_DATA_EXIST);
 }
 
-int f2fs_read_inline_data(struct inode *inode, struct page *page)
+int f2fs_read_inline_data(struct inode *inode, struct folio *folio)
 {
 	struct page *ipage;
 
 	ipage = f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
 	if (IS_ERR(ipage)) {
-		unlock_page(page);
+		folio_unlock(folio);
 		return PTR_ERR(ipage);
 	}
 
@@ -112,15 +112,15 @@ int f2fs_read_inline_data(struct inode *inode, struct page *page)
 		return -EAGAIN;
 	}
 
-	if (page->index)
-		zero_user_segment(page, 0, PAGE_SIZE);
+	if (folio_index(folio))
+		folio_zero_segment(folio, 0, folio_size(folio));
 	else
-		f2fs_do_read_inline_data(page, ipage);
+		f2fs_do_read_inline_data(folio, ipage);
 
-	if (!PageUptodate(page))
-		SetPageUptodate(page);
+	if (!folio_test_uptodate(folio))
+		folio_mark_uptodate(folio);
 	f2fs_put_page(ipage, 1);
-	unlock_page(page);
+	folio_unlock(folio);
 	return 0;
 }
 
@@ -166,7 +166,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 
 	f2fs_bug_on(F2FS_P_SB(page), folio_test_writeback(page_folio(page)));
 
-	f2fs_do_read_inline_data(page, dn->inode_page);
+	f2fs_do_read_inline_data(page_folio(page), dn->inode_page);
 	set_page_dirty(page);
 
 	/* clear dirty state */
-- 
2.40.1


