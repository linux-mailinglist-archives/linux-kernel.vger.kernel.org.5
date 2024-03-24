Return-Path: <linux-kernel+bounces-115546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1802D889C52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C592D2E31DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98279249F3F;
	Mon, 25 Mar 2024 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMLozgVF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A11EF7ED;
	Sun, 24 Mar 2024 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321043; cv=none; b=UCN4Cod8j4z+UQcB8Gro1IYimlMQXdlzjLsWBMzWC3/D3OjMjknsN408rOcI3JVyMY5J9r7vubzEzZrBKKtkxnRxkSwwfuG1Ol21pEuGIHp5JSBrSqjjoczKQIctxhr9xM5HzPszdfmoLxVPh5PPGulgHtpKiBMGA/RDul4D6Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321043; c=relaxed/simple;
	bh=cF+ZlEv5c4xe2wZ0s4b2rD6/X4UJuIYLkFnfRjxTJBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeKNIcZ+Crw+RMJTqeiENaMhh/1MuI0X12ZNlz2bFHu3hWWnXkpY2MAFU684IaDD71KXuAP6gvK8GThWwZQ8rONhGenDPEUdi5czmL+zqBjsNovUV6Chek3mlJ47DsVeNDvZMFYuUCs1DZtb0i2c6tN9I/ZAUeZHllIgvQgtEpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMLozgVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF23C433F1;
	Sun, 24 Mar 2024 22:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321042;
	bh=cF+ZlEv5c4xe2wZ0s4b2rD6/X4UJuIYLkFnfRjxTJBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jMLozgVF+xfQoufxxiY2Xzf5CEjVKZz0VcMTtyZOjGwKvyao39SnYuHGN2nI5guv/
	 ee/0SwIE03rZvvIbFgcWQYaQC2XocDbE1L8Uw0fao8bCZl2+shAdUz5WWkpnIeARv2
	 w2q52bfgvQD1cbP/shypk7y6ad6CginzrtLp/K+YLJDEZoPcbSmWkKSUf/r8rXiOXk
	 qfVkiB7+cCz7+VJNM9BWtMV0guNCRrzNO734+9R2sYHTeGbqG2PJ9bKOZXQWnqBdqy
	 vveTdxqfiTv500w29I4M7jcoGXLILMFcqBaMG4EVI+9O1ULgsg2dFqo8t0IVjSSz1n
	 L94XJGY02ifKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 605/713] f2fs: fix to truncate meta inode pages forcely
Date: Sun, 24 Mar 2024 18:45:31 -0400
Message-ID: <20240324224720.1345309-606-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 67e37b3968c05..200e1e43ef9bb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4628,10 +4628,36 @@ static inline bool f2fs_is_readonly(struct f2fs_sb_info *sbi)
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
index 4dde164254ec2..dfc7fd8aa1e8f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3651,8 +3651,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 	}
 
 	if (fio->post_read)
-		invalidate_mapping_pages(META_MAPPING(sbi),
-				fio->new_blkaddr, fio->new_blkaddr);
+		f2fs_truncate_meta_inode_pages(sbi, fio->new_blkaddr, 1);
 
 	stat_inc_inplace_blocks(fio->sbi);
 
@@ -3842,7 +3841,7 @@ void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 	for (i = 0; i < len; i++)
 		f2fs_wait_on_block_writeback(inode, blkaddr + i);
 
-	invalidate_mapping_pages(META_MAPPING(sbi), blkaddr, blkaddr + len - 1);
+	f2fs_truncate_meta_inode_pages(sbi, blkaddr, len);
 }
 
 static int read_compacted_summaries(struct f2fs_sb_info *sbi)
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 039fe0ce8d83d..1812b7ec8491a 100644
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


