Return-Path: <linux-kernel+bounces-159795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F478B3424
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8D01C22695
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDA314265F;
	Fri, 26 Apr 2024 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVQjZxoL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BBB1422C6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124038; cv=none; b=Sqw5tmEH6tJZzbudPu1/CvESoJLeXTaej/r+0F3lbHzqW5ohZl51ZPUPQDBMhYMc7sxvZM0krFW/9dGs4ULMoeoYd/AlfTBXPa0IdgKNIQKH5U2HgDDuQwBuWYNs/pBJ/5VL1K9dxvB0gv2ITpXXy5geb8YxGbC46L9DlzbR9iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124038; c=relaxed/simple;
	bh=HF9FygCkrUCOWv1FRx+lwLlEuJ62OvrqDXz7ynsbe8s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AokXjCdk0rpimrWvMyHhi51yhH/n+Z0yCNH3J+hOwHo42RQ1wsKcCw/eiw4I6vvHKbPXCwAOS2jGizyb4grpjL/EYPetCeFFKu9gxyyXNOCK3ssM8YNTeT6FVsC77ZLnBdzay21038i7HAn0Vtg1Snr8CbNiVcxHcHITkhMstto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVQjZxoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821A3C113CD;
	Fri, 26 Apr 2024 09:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714124038;
	bh=HF9FygCkrUCOWv1FRx+lwLlEuJ62OvrqDXz7ynsbe8s=;
	h=From:To:Cc:Subject:Date:From;
	b=jVQjZxoL58daYHJEOErMTjYz+2gxxdXEQDbVkU1O+yBl0YDklLpTtxyKQAySLlFdX
	 lZ5XS2LtUwv1aaf3xZ46QaKH0xD94sScQdmhdWxw/EIVZdwVc8WNE1z6czWGpMjMaD
	 JDUlWHm3W0CAXueuuKp0XAYcQlbJ3pHO84nS/m08Eu2y4zdUB8RSef/pG2Ude5UOCH
	 yMj/hYMM/gIIkwimjjO/itS/WyfvfaABPm1ptvfbp3M92Mv+J0KXlVz4QiZLrN/t48
	 QUxgGinOY9QdRXima3utm8VPqpy1/XslL12yD5KU0x0O+x2hm2pGv4HaCBgHlh8a8Y
	 JRyuZPb7/ZhvQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Yunlei He <heyunlei@oppo.com>
Subject: [PATCH] f2fs: fix to avoid allocating WARM_DATA segment for direct IO
Date: Fri, 26 Apr 2024 17:33:48 +0800
Message-Id: <20240426093348.377018-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If active_log is not 6, we never use WARM_DATA segment, let's
avoid allocating WARM_DATA segment for direct IO.

Signed-off-by: Yunlei He <heyunlei@oppo.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c    |  3 ++-
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/file.c    |  5 +++--
 fs/f2fs/segment.c | 11 +++++++++--
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bee1e45f76b8..0c516c653f05 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4179,7 +4179,8 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	map.m_lblk = bytes_to_blks(inode, offset);
 	map.m_len = bytes_to_blks(inode, offset + length - 1) - map.m_lblk + 1;
 	map.m_next_pgofs = &next_pgofs;
-	map.m_seg_type = f2fs_rw_hint_to_seg_type(inode->i_write_hint);
+	map.m_seg_type = f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
+						inode->i_write_hint);
 	if (flags & IOMAP_WRITE)
 		map.m_may_create = true;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e8ff301eaf32..6dd50a6075c0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3747,7 +3747,7 @@ int f2fs_build_segment_manager(struct f2fs_sb_info *sbi);
 void f2fs_destroy_segment_manager(struct f2fs_sb_info *sbi);
 int __init f2fs_create_segment_manager_caches(void);
 void f2fs_destroy_segment_manager_caches(void);
-int f2fs_rw_hint_to_seg_type(enum rw_hint hint);
+int f2fs_rw_hint_to_seg_type(struct f2fs_sb_info *sbi, enum rw_hint hint);
 enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
 			enum page_type type, enum temp_type temp);
 unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 856a5d3bd6bf..23601d747716 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4643,7 +4643,8 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 
 	map.m_may_create = true;
 	if (dio) {
-		map.m_seg_type = f2fs_rw_hint_to_seg_type(inode->i_write_hint);
+		map.m_seg_type = f2fs_rw_hint_to_seg_type(sbi,
+						inode->i_write_hint);
 		flag = F2FS_GET_BLOCK_PRE_DIO;
 	} else {
 		map.m_seg_type = NO_CHECK_TYPE;
@@ -4696,7 +4697,7 @@ static void f2fs_dio_write_submit_io(const struct iomap_iter *iter,
 {
 	struct inode *inode = iter->inode;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	int seg_type = f2fs_rw_hint_to_seg_type(inode->i_write_hint);
+	int seg_type = f2fs_rw_hint_to_seg_type(sbi, inode->i_write_hint);
 	enum temp_type temp = f2fs_get_segment_temp(seg_type);
 
 	bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, DATA, temp);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8313d6aeaf41..94f3380be04c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3358,8 +3358,14 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	return err;
 }
 
-int f2fs_rw_hint_to_seg_type(enum rw_hint hint)
+int f2fs_rw_hint_to_seg_type(struct f2fs_sb_info *sbi, enum rw_hint hint)
 {
+	if (F2FS_OPTION(sbi).active_logs == 2)
+		return CURSEG_HOT_DATA;
+	else if (F2FS_OPTION(sbi).active_logs == 4)
+		return CURSEG_COLD_DATA;
+
+	/* active_log == 6 */
 	switch (hint) {
 	case WRITE_LIFE_SHORT:
 		return CURSEG_HOT_DATA;
@@ -3499,7 +3505,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 				is_inode_flag_set(inode, FI_HOT_DATA) ||
 				f2fs_is_cow_file(inode))
 			return CURSEG_HOT_DATA;
-		return f2fs_rw_hint_to_seg_type(inode->i_write_hint);
+		return f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
+						inode->i_write_hint);
 	} else {
 		if (IS_DNODE(fio->page))
 			return is_cold_node(fio->page) ? CURSEG_WARM_NODE :
-- 
2.40.1


