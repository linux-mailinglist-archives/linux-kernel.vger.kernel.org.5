Return-Path: <linux-kernel+bounces-113488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E238884F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9039FB28E12
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C28413D26D;
	Sun, 24 Mar 2024 22:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIriK91Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B5E13D252;
	Sun, 24 Mar 2024 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320289; cv=none; b=Jjk6FGH++BkUQZ6cvS++NHQMWBjHPzlpQ0c51/vv7q0xdG94Lp9VQS7QpfbaQSkZV9Wr34ZUw3qxqMVDmCXxcHmR8NVVUFpMPr7Qz++obXKRbDdb1Qa20Yez3K1O0uObx4xa9NlM00S8ZzVjxQ0Jm1SSjvAi92CctCg7ba2RAJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320289; c=relaxed/simple;
	bh=3kma1Y6AdIc19Pk8e1FcqH4ovOx1uQ9+Nf1Foklvnog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeDLe+xge2paa4L1SWOedpJG+mBdWPCNK5xS72e4KbomZU2I0L5yDlHiTmtKFFnM7P5C7mS9rWt+0DfPvb+FuRgt19PVFUYvMQ7xeFu4pree6+M7m/gWmJyvnJF6o/2gkgrYLi5e7PuaikRNRN+JoqbN8r6DZopAS+Ks14sggAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIriK91Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDDCC43399;
	Sun, 24 Mar 2024 22:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320289;
	bh=3kma1Y6AdIc19Pk8e1FcqH4ovOx1uQ9+Nf1Foklvnog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NIriK91YNbbElGo2wSA56zVTDYlzUkiFt6sNVNh5nPA4ZtuvICTdkZ4vwiB2PepCd
	 bzb+28XoB3NR7y5jjLah3Cl0c/a2LSkdm91hklzXKnh9OhWUuYNsd++I8Z60oe94Hl
	 B6btUthbg0WsgyRWSPmE71e3pyue506N2ke/4w72Zk20dR0g+1fZ9lFbhWcRj1sVph
	 m7BNPVA+M504jhkQSffkXgu4oJ05ZgjUUSqTixSF+vyQSGJYc8YLRBS4GXXjEeQMoo
	 RPFh1zU0PzNwgmkuOMQRdKIi7K6A8jP9SWPQLb0kDZFxnM6t1nzNAfbgbWyRHP60h7
	 GfAthnDomJXbA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 597/715] f2fs: fix to truncate meta inode pages forcely
Date: Sun, 24 Mar 2024 18:32:56 -0400
Message-ID: <20240324223455.1342824-598-sashal@kernel.org>
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

[ Upstream commit 9f0c4a46be1fe9b97dbe66d49204c1371e3ece65 ]

Below race case can cause data corruption:

Thread A				GC thread
					- gc_data_segment
					 - ra_data_block
					  - locked meta_inode page
- f2fs_inplace_write_data
 - invalidate_mapping_pages
 : fail to invalidate meta_inode page
   due to lock failure or dirty|writeback
   status
 - f2fs_submit_page_bio
 : write last dirty data to old blkaddr
					 - move_data_block
					  - load old data from meta_inode page
					  - f2fs_submit_page_write
					  : write old data to new blkaddr

Because invalidate_mapping_pages() will skip invalidating page which
has unclear status including locked, dirty, writeback and so on, so
we need to use truncate_inode_pages_range() instead of
invalidate_mapping_pages() to make sure meta_inode page will be dropped.

Fixes: 6aa58d8ad20a ("f2fs: readahead encrypted block during GC")
Fixes: e3b49ea36802 ("f2fs: invalidate META_MAPPING before IPU/DIO write")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c    |  5 +++--
 fs/f2fs/f2fs.h          | 28 +++++++++++++++++++++++++++-
 fs/f2fs/segment.c       |  5 ++---
 include/linux/f2fs_fs.h |  1 +
 4 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index b0597a539fc54..9afc8d24dc369 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1587,8 +1587,9 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 */
 	if (f2fs_sb_has_encrypt(sbi) || f2fs_sb_has_verity(sbi) ||
 		f2fs_sb_has_compression(sbi))
-		invalidate_mapping_pages(META_MAPPING(sbi),
-				MAIN_BLKADDR(sbi), MAX_BLKADDR(sbi) - 1);
+		f2fs_bug_on(sbi,
+			invalidate_inode_pages2_range(META_MAPPING(sbi),
+				MAIN_BLKADDR(sbi), MAX_BLKADDR(sbi) - 1));
 
 	f2fs_release_ino_entry(sbi, false);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 585559ea71557..5a6c35d70c7ad 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4635,10 +4635,36 @@ static inline bool f2fs_is_readonly(struct f2fs_sb_info *sbi)
 	return f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb);
 }
 
+static inline void f2fs_truncate_meta_inode_pages(struct f2fs_sb_info *sbi,
+					block_t blkaddr, unsigned int cnt)
+{
+	bool need_submit = false;
+	int i = 0;
+
+	do {
+		struct page *page;
+
+		page = find_get_page(META_MAPPING(sbi), blkaddr + i);
+		if (page) {
+			if (PageWriteback(page))
+				need_submit = true;
+			f2fs_put_page(page, 0);
+		}
+	} while (++i < cnt && !need_submit);
+
+	if (need_submit)
+		f2fs_submit_merged_write_cond(sbi, sbi->meta_inode,
+							NULL, 0, DATA);
+
+	truncate_inode_pages_range(META_MAPPING(sbi),
+			F2FS_BLK_TO_BYTES((loff_t)blkaddr),
+			F2FS_BLK_END_BYTES((loff_t)(blkaddr + cnt - 1)));
+}
+
 static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
 								block_t blkaddr)
 {
-	invalidate_mapping_pages(META_MAPPING(sbi), blkaddr, blkaddr);
+	f2fs_truncate_meta_inode_pages(sbi, blkaddr, 1);
 	f2fs_invalidate_compress_page(sbi, blkaddr);
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 77409e3665954..60531f50f37fe 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3653,8 +3653,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 	}
 
 	if (fio->post_read)
-		invalidate_mapping_pages(META_MAPPING(sbi),
-				fio->new_blkaddr, fio->new_blkaddr);
+		f2fs_truncate_meta_inode_pages(sbi, fio->new_blkaddr, 1);
 
 	stat_inc_inplace_blocks(fio->sbi);
 
@@ -3844,7 +3843,7 @@ void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 	for (i = 0; i < len; i++)
 		f2fs_wait_on_block_writeback(inode, blkaddr + i);
 
-	invalidate_mapping_pages(META_MAPPING(sbi), blkaddr, blkaddr + len - 1);
+	f2fs_truncate_meta_inode_pages(sbi, blkaddr, len);
 }
 
 static int read_compacted_summaries(struct f2fs_sb_info *sbi)
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 053137a0fe456..3f016d3c1ec4f 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -27,6 +27,7 @@
 
 #define F2FS_BYTES_TO_BLK(bytes)	((bytes) >> F2FS_BLKSIZE_BITS)
 #define F2FS_BLK_TO_BYTES(blk)		((blk) << F2FS_BLKSIZE_BITS)
+#define F2FS_BLK_END_BYTES(blk)		(F2FS_BLK_TO_BYTES(blk + 1) - 1)
 
 /* 0, 1(node nid), 2(meta nid) are reserved node id */
 #define F2FS_RESERVED_NODE_NUM		3
-- 
2.43.0


