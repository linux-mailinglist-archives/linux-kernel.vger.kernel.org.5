Return-Path: <linux-kernel+bounces-113941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B202388877D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294041F25582
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFBA13EFE1;
	Sun, 24 Mar 2024 23:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIU0yWPI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581891EF7F7;
	Sun, 24 Mar 2024 22:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321041; cv=none; b=pJXckm+B3bQUJ+Sy8FAIVmEY2BccPzcOyToZtzDoYlng8lORpDTWlj9wOARuc9mYmFMxHiJKTfXReY5BAKpF58FUATDjMmBK/7//HIvfb6yzHIAyVFEqN2V4EYGAKHpiLAQ4PLvy/KGDjSmahudOFaGTSbFZs36WBCF97hgLkv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321041; c=relaxed/simple;
	bh=xFOjwRe1N0fmcE2H+s34s5+o9Z0fdmM6VqtNDv4+8Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vc/0L8S6GfJdOe9SYh9VMABhU/+h7+d6jCSpw+PQcie00Sujc9Ab5eJtYpam8e08awz1jrbNjazkUbHtL2Ef6TOrfb9EdV5QZtJ8k4qRlncyXjzt39fyOwq5XgjPoadXJOvYZPoGl6d9kZKNs5adIPoAYEd+NXFfpL6kOUya8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIU0yWPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9425AC433F1;
	Sun, 24 Mar 2024 22:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321041;
	bh=xFOjwRe1N0fmcE2H+s34s5+o9Z0fdmM6VqtNDv4+8Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QIU0yWPIVzex3hINFLRPcquKQxw/kOoxwEVEeppE/6cT0+hQ22+EiFFeTZCJmqWve
	 y/aEjoYWaGmZBHBygYOPRtnu6x/eD7wYykdZ0WevFARHIQwoI7HHsWleKL8zd4gxwf
	 aTHfkEPTnUrS/mLO/TORWtcCOc+bqDLoHvYcvrkQ7m5RavYamRvE0/uMjCNK06k6Mw
	 JhYlGqt2Qr9Nqau6Ptt89GTuAIHJvEkSPO9dpBu/BYz2HhPAYrC8FZOM7Tbd/wRXPt
	 guvFE8TlkLyTYjH2eCCNJoG5cTDhPiygGCFCoUP4x7MBg+bN3FIWtT+LGYDQGh924I
	 G+1TgxnxkN2wQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 604/713] f2fs: introduce f2fs_invalidate_internal_cache() for cleanup
Date: Sun, 24 Mar 2024 18:45:30 -0400
Message-ID: <20240324224720.1345309-605-sashal@kernel.org>
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

[ Upstream commit 4e4f1eb9949b10cb7d76370fd27d41f20ef2b32b ]

Just cleanup, no logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 9f0c4a46be1f ("f2fs: fix to truncate meta inode pages forcely")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c    |  8 +++-----
 fs/f2fs/f2fs.h    |  7 +++++++
 fs/f2fs/gc.c      |  5 ++---
 fs/f2fs/segment.c | 14 ++++----------
 4 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d71683039b961..c611d064aee3e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1485,11 +1485,9 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 	old_blkaddr = dn->data_blkaddr;
 	f2fs_allocate_data_block(sbi, NULL, old_blkaddr, &dn->data_blkaddr,
 				&sum, seg_type, NULL);
-	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO) {
-		invalidate_mapping_pages(META_MAPPING(sbi),
-					old_blkaddr, old_blkaddr);
-		f2fs_invalidate_compress_page(sbi, old_blkaddr);
-	}
+	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
+		f2fs_invalidate_internal_cache(sbi, old_blkaddr);
+
 	f2fs_update_data_blkaddr(dn, dn->data_blkaddr);
 	return 0;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bdae73e2540a5..67e37b3968c05 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4628,6 +4628,13 @@ static inline bool f2fs_is_readonly(struct f2fs_sb_info *sbi)
 	return f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb);
 }
 
+static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
+								block_t blkaddr)
+{
+	invalidate_mapping_pages(META_MAPPING(sbi), blkaddr, blkaddr);
+	f2fs_invalidate_compress_page(sbi, blkaddr);
+}
+
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2fbe16ad726f4..405a6077bd83b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1380,9 +1380,8 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	memcpy(page_address(fio.encrypted_page),
 				page_address(mpage), PAGE_SIZE);
 	f2fs_put_page(mpage, 1);
-	invalidate_mapping_pages(META_MAPPING(fio.sbi),
-				fio.old_blkaddr, fio.old_blkaddr);
-	f2fs_invalidate_compress_page(fio.sbi, fio.old_blkaddr);
+
+	f2fs_invalidate_internal_cache(fio.sbi, fio.old_blkaddr);
 
 	set_page_dirty(fio.encrypted_page);
 	if (clear_page_dirty_for_io(fio.encrypted_page))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7b7ed2dac16b8..4dde164254ec2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2495,8 +2495,7 @@ void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
 	if (addr == NEW_ADDR || addr == COMPRESS_ADDR)
 		return;
 
-	invalidate_mapping_pages(META_MAPPING(sbi), addr, addr);
-	f2fs_invalidate_compress_page(sbi, addr);
+	f2fs_invalidate_internal_cache(sbi, addr);
 
 	/* add it into sit main buffer */
 	down_write(&sit_i->sentry_lock);
@@ -3557,11 +3556,8 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 reallocate:
 	f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
 			&fio->new_blkaddr, sum, type, fio);
-	if (GET_SEGNO(fio->sbi, fio->old_blkaddr) != NULL_SEGNO) {
-		invalidate_mapping_pages(META_MAPPING(fio->sbi),
-					fio->old_blkaddr, fio->old_blkaddr);
-		f2fs_invalidate_compress_page(fio->sbi, fio->old_blkaddr);
-	}
+	if (GET_SEGNO(fio->sbi, fio->old_blkaddr) != NULL_SEGNO)
+		f2fs_invalidate_internal_cache(fio->sbi, fio->old_blkaddr);
 
 	/* writeout dirty page into bdev */
 	f2fs_submit_page_write(fio);
@@ -3757,9 +3753,7 @@ void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		update_sit_entry(sbi, new_blkaddr, 1);
 	}
 	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO) {
-		invalidate_mapping_pages(META_MAPPING(sbi),
-					old_blkaddr, old_blkaddr);
-		f2fs_invalidate_compress_page(sbi, old_blkaddr);
+		f2fs_invalidate_internal_cache(sbi, old_blkaddr);
 		if (!from_gc)
 			update_segment_mtime(sbi, old_blkaddr, 0);
 		update_sit_entry(sbi, old_blkaddr, -1);
-- 
2.43.0


