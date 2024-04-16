Return-Path: <linux-kernel+bounces-146422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4218A6509
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C836B283A33
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB3C15A49D;
	Tue, 16 Apr 2024 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKr/BaH/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E26E159915
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252215; cv=none; b=dWGQmvb/LRt7U4KAdr8amSrMIkjOgVV3kOI7VSM1Nti00w/bheij6G2nsKN9MgxSGcl2k1wv8QTcmQJ3NXPB/mTlWt1QOXKJh0okYIh0OtzlXM+/dbJnJ7pGvYakhf1ONqMRwxVvploxLvXYLOV805OffHBbACM8IcrkBxwaSkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252215; c=relaxed/simple;
	bh=gnYDk6OX4XE3h8kNjiuhBPTQmlA/CYDOhV8fZAtl/TE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WlADdYURbdrLcvJQkYG6BtvPc9JdwwrURAPUxSHxEipe/yCZw69aaJMABhqN+L0cvQN/y3h3oFhVZyWD8tCGkisGfG0ou67jbl5lWFwnL/n1gXPXtOT2bZ2XUxpvonVhotknDWeEW5sbgjgKtiwZi8WuoE0ktbc5k05mkpau/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKr/BaH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B632AC32781;
	Tue, 16 Apr 2024 07:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713252215;
	bh=gnYDk6OX4XE3h8kNjiuhBPTQmlA/CYDOhV8fZAtl/TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKr/BaH/HhEmeD863rF3i7syD3sDhrr/9HjkgyFmT7PK4IRCWvQwzvceTrBshObS3
	 g0uD4prp+Q/18p80UXodqWcbJCq3HKHsfNmNiCdUcBLs2YFiKYCh4x6wtG7x8BbE2Z
	 n/n2M7WcqfizbXZKpoQCBfnL+SPKudjKo5roM5dfZvUq+66TkQfPFaweQUT1t/fKoH
	 Ff4+i63bJlrkCxHPTWwxdJg3+dNJ6kYz/fX+bkY7DtehKuPoEI5mcUGget4S/+nRig
	 huv+2Sti2U9KKYlICEZupnrDRKHdmpwrYvjbP2WzXItYqhwiabcU4ROsuWncx3I94F
	 Li46IaVrVVzvA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 3/4] f2fs: convert f2fs_read_inline_data() to use folio
Date: Tue, 16 Apr 2024 15:23:17 +0800
Message-Id: <20240416072318.6486-3-chao@kernel.org>
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

Convert f2fs_read_inline_data() to use folio and related
functionality, and also convert its caller to use folio.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c   | 11 +++++------
 fs/f2fs/f2fs.h   |  4 ++--
 fs/f2fs/inline.c | 34 +++++++++++++++++-----------------
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c35107657c97..3eb90b9b0f8b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2487,20 +2487,19 @@ static int f2fs_mpage_readpages(struct inode *inode,
 
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
@@ -3429,7 +3428,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 	if (f2fs_has_inline_data(inode)) {
 		if (pos + len <= MAX_INLINE_DATA(inode)) {
-			f2fs_do_read_inline_data(page, ipage);
+			f2fs_do_read_inline_data(page_folio(page), ipage);
 			set_inode_flag(inode, FI_DATA_EXIST);
 			if (inode->i_nlink)
 				set_page_private_inline(ipage);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 34acd791c198..13dee521fbe8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4153,10 +4153,10 @@ extern struct kmem_cache *f2fs_inode_entry_slab;
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


