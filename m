Return-Path: <linux-kernel+bounces-58944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841F784EEF7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EAA51F28713
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2476F4C8E;
	Fri,  9 Feb 2024 02:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bdqg9Zgx"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD7346BA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 02:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707446580; cv=none; b=g7F7IiCA2jt3s7+Y0+fRu8vDV0VvB0uSzOURL4P2F0CMtd95/fN9P5QTImxQrI9o7dzAfEz/mSV5am/AqiV5wWstSP+sVERGv3xPOzE7NH8bj6d3VGfl2OmWmZ5XIE/tioxjEOqVEgZWA9K9dRkdICEtdK6VtwGrGrIc1XaAfOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707446580; c=relaxed/simple;
	bh=4GUC0d3doTq/wkq4eLmWrqNcHMjISnVBNOW5DHxLsso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKWI0JHIkt+PaCLfGs9uD3QKQtH/YzJb2OaZRrYkIW7CcoNVsx8FCkA5edXO1tWIRbMkQmstBQo8+qpYe1z4hQy/fQsxL+qMnKdtRTCY0f33pMcUr2z+C9CNy3j1x1WxjcL1H2d7Ymrin5W899xETCf+bq5Vl0SB8dq/gye8J/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bdqg9Zgx; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso1177b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 18:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707446576; x=1708051376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvWDZPUTKjUkTM6+g88yhkLm2G0N9xXsyG7DR3ojB/k=;
        b=Bdqg9ZgxX7Tiv3zN2yEE91I8+ojlZId6ogSzaTQjgeNCo1dYXoU4K7PDExUL/PQ6BJ
         1ZoDJCKHiWcEmaTjBnt7qP2GGlYVkLcEMz26X2Kd6LqewvrppcnbiHyYFVtBFVekve7F
         jH0ae4OQAJw81Hc5+iyFlZP6iouIdI/e9gxpjrUtV0HI6kG/R7YeFSmzVW+Kesz091xr
         1fZFFeFubgsIr/2i3ri88CRVK4q6jFj7+B86sN3QHFPzXAOtNB8nGpUmRNDoxXLdj5JZ
         AdkFx3fe9EMi6w7qYo8egaJkhC1Mt2VOydH7t2tSd1lA/0cqYmTGttSJdfgy2jY49OpK
         nfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707446576; x=1708051376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvWDZPUTKjUkTM6+g88yhkLm2G0N9xXsyG7DR3ojB/k=;
        b=i8f7o+Hwix3Nk3Qp0QEBA5nVWziDHfhNeE9Ro9zESWqnKRxKuJRtPR8iAsgOWXP2/d
         71A4WjJ2xMntF1BU37eTa3Vrt1jew+Ie+Be7SAXAYnJhDWj6sx6zXxCg/COoYxTvX5L7
         ssY1Th7LXVrXXqTiPDRGZVXRARXrX+GNdQmDalVMTLBX/xoIhmGzr3fBuuMXs4KAMGmL
         qtbN0tc7z/8eS1IOLJIHuYf481B8zlh5a6aS4fHBzAq2RvCPwViVN66gZ287L8CnBbqH
         Us4M3B8llIYsRbuVf2Llx20qOD6tIgBAMV4raYHt0k3Rz9bRIZuPXOVwGPyxf+72ARUM
         iS/Q==
X-Gm-Message-State: AOJu0YwGaIrcFo1Gs8ip861OZyam5IUgzlbdN78A2FtLUYhIJKrUdHc+
	905hhaAhR+PLsftkVz24+OFo4eVIuoxHyJC2AZtpqSExlstt3k/ihV+Xn84Y
X-Google-Smtp-Source: AGHT+IENfAKs1qHr7LTnKd/PfxFttIr5PFpLGWSZ7wqiFNkIf/LDMSqcrgk43/flQ9Ud7QcWpdCq0w==
X-Received: by 2002:a05:6a00:1990:b0:6e0:377f:bece with SMTP id d16-20020a056a00199000b006e0377fbecemr816486pfl.9.1707446576174;
        Thu, 08 Feb 2024 18:42:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQ3liWF2O+upZhlMJO7mnOViQ9pDDLsBMYtXlZbp3GsWGnh0+J5S8SqdS1TCSLq4U65E09/aaPskuGeCu9HrCye4cn81dXpK6EttYIUnT7UR6G1JEvyoa3L2KJHNX/NWFxKIgIlcWMQc+jgV9dFi4snT6lEYlfst/ANqJ9Lmu1RRtH0A==
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:20e:63ed:be25:710f])
        by smtp.gmail.com with ESMTPSA id t28-20020a62d15c000000b006d9a7a48bbesm521505pfl.116.2024.02.08.18.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 18:42:55 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v2 2/2] f2fs: support file pinning for zoned devices
Date: Thu,  8 Feb 2024 18:42:26 -0800
Message-ID: <20240209024227.66741-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240209024227.66741-1-daeho43@gmail.com>
References: <20240209024227.66741-1-daeho43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Support file pinning with conventional storage area for zoned devices

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v2: flush previous dirty pages before swapon.
    do not re-check for the last extent of swap area.
    merge this patch with swap file pinning support patch.
---
 fs/f2fs/data.c    | 62 +++++++++++++++++++++++++++++-------------
 fs/f2fs/f2fs.h    | 17 +++++++++++-
 fs/f2fs/file.c    | 24 ++++++++++++-----
 fs/f2fs/gc.c      | 14 +++++++---
 fs/f2fs/segment.c | 69 +++++++++++++++++++++++++++++++++++++++++------
 fs/f2fs/segment.h | 10 +++++++
 6 files changed, 159 insertions(+), 37 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 828c797cd47c..a7c5147f3286 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3836,28 +3836,40 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 							unsigned int blkcnt)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_map_blocks map = { .m_next_pgofs = NULL,
+		.m_next_extent = NULL, .m_seg_type = CURSEG_COLD_DATA_PINNED,
+		.m_may_create = true };
 	unsigned int blkofs;
 	unsigned int blk_per_sec = BLKS_PER_SEC(sbi);
 	unsigned int secidx = start_blk / blk_per_sec;
-	unsigned int end_sec = secidx + blkcnt / blk_per_sec;
+	unsigned int end_sec;
 	int ret = 0;
 
+	if (!blkcnt)
+		return 0;
+	end_sec = secidx + (blkcnt - 1) / blk_per_sec;
+
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
 	set_inode_flag(inode, FI_ALIGNED_WRITE);
 	set_inode_flag(inode, FI_OPU_WRITE);
 
-	for (; secidx < end_sec; secidx++) {
+	for (; secidx <= end_sec; secidx++) {
+		unsigned int blkofs_end = secidx == end_sec ?
+			(blkcnt - 1) % blk_per_sec : blk_per_sec - 1;
+
 		f2fs_down_write(&sbi->pin_sem);
 
-		f2fs_lock_op(sbi);
-		f2fs_allocate_new_section(sbi, CURSEG_COLD_DATA_PINNED, false);
-		f2fs_unlock_op(sbi);
+		ret = f2fs_allocate_pinning_section(sbi);
+		if (ret) {
+			f2fs_up_write(&sbi->pin_sem);
+			break;
+		}
 
 		set_inode_flag(inode, FI_SKIP_WRITES);
 
-		for (blkofs = 0; blkofs < blk_per_sec; blkofs++) {
+		for (blkofs = 0; blkofs <= blkofs_end; blkofs++) {
 			struct page *page;
 			unsigned int blkidx = secidx * blk_per_sec + blkofs;
 
@@ -3875,6 +3887,12 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 		clear_inode_flag(inode, FI_SKIP_WRITES);
 
 		ret = filemap_fdatawrite(inode->i_mapping);
+		if (!ret && blkofs != blk_per_sec) {
+			map.m_lblk = secidx * blk_per_sec + blkofs;
+			map.m_len = blk_per_sec - blkofs;
+			ret = f2fs_map_blocks(inode, &map,
+					F2FS_GET_BLOCK_PRE_DIO);
+		}
 
 		f2fs_up_write(&sbi->pin_sem);
 
@@ -3946,27 +3964,31 @@ static int check_swap_activate(struct swap_info_struct *sis,
 		nr_pblocks = map.m_len;
 
 		if ((pblock - SM_I(sbi)->main_blkaddr) & sec_blks_mask ||
-				nr_pblocks & sec_blks_mask) {
+				nr_pblocks & sec_blks_mask ||
+				!f2fs_valid_pinned_area(sbi, pblock)) {
+			bool last_extent = false;
+
 			not_aligned++;
 
 			nr_pblocks = roundup(nr_pblocks, blks_per_sec);
 			if (cur_lblock + nr_pblocks > sis->max)
 				nr_pblocks -= blks_per_sec;
 
+			/* this extent is last one */
 			if (!nr_pblocks) {
-				/* this extent is last one */
-				nr_pblocks = map.m_len;
-				f2fs_warn(sbi, "Swapfile: last extent is not aligned to section");
-				goto next;
+				nr_pblocks = last_lblock - cur_lblock;
+				last_extent = true;
 			}
 
 			ret = f2fs_migrate_blocks(inode, cur_lblock,
 							nr_pblocks);
 			if (ret)
 				goto out;
-			goto retry;
+
+			if (!last_extent)
+				goto retry;
 		}
-next:
+
 		if (cur_lblock + nr_pblocks >= sis->max)
 			nr_pblocks = sis->max - cur_lblock;
 
@@ -4004,17 +4026,17 @@ static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
 				sector_t *span)
 {
 	struct inode *inode = file_inode(file);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int ret;
 
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
-	if (f2fs_readonly(F2FS_I_SB(inode)->sb))
+	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
-	if (f2fs_lfs_mode(F2FS_I_SB(inode))) {
-		f2fs_err(F2FS_I_SB(inode),
-			"Swapfile not supported in LFS mode");
+	if (f2fs_lfs_mode(sbi) && !f2fs_sb_has_blkzoned(sbi)) {
+		f2fs_err(sbi, "Swapfile not supported in LFS mode");
 		return -EINVAL;
 	}
 
@@ -4027,13 +4049,17 @@ static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
 
 	f2fs_precache_extents(inode);
 
+	ret = filemap_fdatawrite(inode->i_mapping);
+	if (ret < 0)
+		return ret;
+
 	ret = check_swap_activate(sis, file, span);
 	if (ret < 0)
 		return ret;
 
 	stat_inc_swapfile_inode(inode);
 	set_inode_flag(inode, FI_PIN_FILE);
-	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+	f2fs_update_time(sbi, REQ_TIME);
 	return ret;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 40eb590ed646..351133a11518 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3696,7 +3696,8 @@ void f2fs_get_new_segment(struct f2fs_sb_info *sbi,
 			unsigned int *newseg, bool new_sec, int dir);
 void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end);
-void f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
+int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
+int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi);
 void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
 int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
 bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
@@ -3870,6 +3871,9 @@ void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi);
 block_t f2fs_start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
 int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
+int f2fs_gc_range(struct f2fs_sb_info *sbi,
+		unsigned int start_seg, unsigned int end_seg,
+		bool dry_run, unsigned int dry_run_sections);
 int f2fs_resize_fs(struct file *filp, __u64 block_count);
 int __init f2fs_create_garbage_collection_cache(void);
 void f2fs_destroy_garbage_collection_cache(void);
@@ -4524,6 +4528,17 @@ static inline bool f2fs_lfs_mode(struct f2fs_sb_info *sbi)
 	return F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS;
 }
 
+static inline bool f2fs_valid_pinned_area(struct f2fs_sb_info *sbi,
+					  block_t blkaddr)
+{
+	if (f2fs_sb_has_blkzoned(sbi)) {
+		int devi = f2fs_target_device_index(sbi, blkaddr);
+
+		return !bdev_is_zoned(FDEV(devi).bdev);
+	}
+	return true;
+}
+
 static inline bool f2fs_low_mem_mode(struct f2fs_sb_info *sbi)
 {
 	return F2FS_OPTION(sbi).memory_mode == MEMORY_MODE_LOW;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2c13b340c8a0..21c3aa93a8db 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1733,9 +1733,11 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 
 		f2fs_down_write(&sbi->pin_sem);
 
-		f2fs_lock_op(sbi);
-		f2fs_allocate_new_section(sbi, CURSEG_COLD_DATA_PINNED, false);
-		f2fs_unlock_op(sbi);
+		err = f2fs_allocate_pinning_section(sbi);
+		if (err) {
+			f2fs_up_write(&sbi->pin_sem);
+			goto out_err;
+		}
 
 		map.m_seg_type = CURSEG_COLD_DATA_PINNED;
 		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_PRE_DIO);
@@ -3185,6 +3187,7 @@ int f2fs_pin_file_control(struct inode *inode, bool inc)
 static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	__u32 pin;
 	int ret = 0;
 
@@ -3194,7 +3197,7 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
-	if (f2fs_readonly(F2FS_I_SB(inode)->sb))
+	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
 	ret = mnt_want_write_file(filp);
@@ -3207,9 +3210,18 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 		clear_inode_flag(inode, FI_PIN_FILE);
 		f2fs_i_gc_failures_write(inode, 0);
 		goto done;
+	} else if (f2fs_is_pinned_file(inode)) {
+		goto done;
 	}
 
-	if (f2fs_should_update_outplace(inode, NULL)) {
+	if (f2fs_sb_has_blkzoned(sbi) && F2FS_HAS_BLOCKS(inode)) {
+		ret = -EFBIG;
+		goto out;
+	}
+
+	/* Let's allow file pinning on zoned device. */
+	if (!f2fs_sb_has_blkzoned(sbi) &&
+	    f2fs_should_update_outplace(inode, NULL)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3231,7 +3243,7 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 	set_inode_flag(inode, FI_PIN_FILE);
 	ret = F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN];
 done:
-	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+	f2fs_update_time(sbi, REQ_TIME);
 out:
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a089a938355b..3ff126316d42 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1961,10 +1961,12 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 	init_atgc_management(sbi);
 }
 
-static int f2fs_gc_range(struct f2fs_sb_info *sbi,
-		unsigned int start_seg, unsigned int end_seg, bool dry_run)
+int f2fs_gc_range(struct f2fs_sb_info *sbi,
+		unsigned int start_seg, unsigned int end_seg,
+		bool dry_run, unsigned int dry_run_sections)
 {
 	unsigned int segno;
+	unsigned int gc_secs = dry_run_sections;
 
 	for (segno = start_seg; segno <= end_seg; segno += SEGS_PER_SEC(sbi)) {
 		struct gc_inode_list gc_list = {
@@ -1972,11 +1974,15 @@ static int f2fs_gc_range(struct f2fs_sb_info *sbi,
 			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 		};
 
-		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true);
+		do_garbage_collect(sbi, segno, &gc_list, FG_GC,
+						dry_run_sections == 0);
 		put_gc_inode(&gc_list);
 
 		if (!dry_run && get_valid_blocks(sbi, segno, true))
 			return -EAGAIN;
+		if (dry_run && dry_run_sections &&
+		    !get_valid_blocks(sbi, segno, true) && --gc_secs == 0)
+			break;
 
 		if (fatal_signal_pending(current))
 			return -ERESTARTSYS;
@@ -2014,7 +2020,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 		f2fs_allocate_segment_for_resize(sbi, type, start, end);
 
 	/* do GC to move out valid blocks in the range */
-	err = f2fs_gc_range(sbi, start, end, dry_run);
+	err = f2fs_gc_range(sbi, start, end, dry_run, 0);
 	if (err || dry_run)
 		goto out;
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4e985750c938..0b72c8536ccf 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2632,7 +2632,7 @@ static int is_next_segment_free(struct f2fs_sb_info *sbi,
  * This function should be returned with success, otherwise BUG
  */
 static void get_new_segment(struct f2fs_sb_info *sbi,
-			unsigned int *newseg, bool new_sec)
+			unsigned int *newseg, bool new_sec, bool pinning)
 {
 	struct free_segmap_info *free_i = FREE_I(sbi);
 	unsigned int segno, secno, zoneno;
@@ -2650,6 +2650,16 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 		if (segno < GET_SEG_FROM_SEC(sbi, hint + 1))
 			goto got_it;
 	}
+
+	/*
+	 * If we format f2fs on zoned storage, let's try to get pinned sections
+	 * from beginning of the storage, which should be a conventional one.
+	 */
+	if (f2fs_sb_has_blkzoned(sbi)) {
+		segno = pinning ? 0 : max(first_zoned_segno(sbi), *newseg);
+		hint = GET_SEC_FROM_SEG(sbi, segno);
+	}
+
 find_other_zone:
 	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
 	if (secno >= MAIN_SECS(sbi)) {
@@ -2749,21 +2759,30 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
  * Allocate a current working segment.
  * This function always allocates a free segment in LFS manner.
  */
-static void new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
+static int new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	unsigned int segno = curseg->segno;
+	bool pinning = type == CURSEG_COLD_DATA_PINNED;
 
 	if (curseg->inited)
 		write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, segno));
+
 	segno = __get_next_segno(sbi, type);
-	get_new_segment(sbi, &segno, new_sec);
+	get_new_segment(sbi, &segno, new_sec, pinning);
+	if (new_sec && pinning &&
+	    !f2fs_valid_pinned_area(sbi, START_BLOCK(sbi, segno))) {
+		__set_free(sbi, segno);
+		return -EAGAIN;
+	}
+
 	curseg->next_segno = segno;
 	reset_curseg(sbi, type, 1);
 	curseg->alloc_type = LFS;
 	if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK)
 		curseg->fragment_remained_chunk =
 				get_random_u32_inclusive(1, sbi->max_fragment_chunk);
+	return 0;
 }
 
 static int __next_free_blkoff(struct f2fs_sb_info *sbi,
@@ -3036,7 +3055,7 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
 }
 
-static void __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
+static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
 						bool new_sec, bool force)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
@@ -3046,21 +3065,49 @@ static void __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
 	    !curseg->next_blkoff &&
 	    !get_valid_blocks(sbi, curseg->segno, new_sec) &&
 	    !get_ckpt_valid_blocks(sbi, curseg->segno, new_sec))
-		return;
+		return 0;
 
 	old_segno = curseg->segno;
-	new_curseg(sbi, type, true);
+	if (new_curseg(sbi, type, true))
+		return -EAGAIN;
 	stat_inc_seg_type(sbi, curseg);
 	locate_dirty_segment(sbi, old_segno);
+	return 0;
 }
 
-void f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force)
+int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force)
 {
+	int ret;
+
 	f2fs_down_read(&SM_I(sbi)->curseg_lock);
 	down_write(&SIT_I(sbi)->sentry_lock);
-	__allocate_new_segment(sbi, type, true, force);
+	ret = __allocate_new_segment(sbi, type, true, force);
 	up_write(&SIT_I(sbi)->sentry_lock);
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
+
+	return ret;
+}
+
+int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
+{
+	int err;
+	bool gc_required = true;
+
+retry:
+	f2fs_lock_op(sbi);
+	err = f2fs_allocate_new_section(sbi, CURSEG_COLD_DATA_PINNED, false);
+	f2fs_unlock_op(sbi);
+
+	if (f2fs_sb_has_blkzoned(sbi) && err && gc_required) {
+		f2fs_down_write(&sbi->gc_lock);
+		f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_blk), true, 1);
+		f2fs_up_write(&sbi->gc_lock);
+
+		gc_required = false;
+		goto retry;
+	}
+
+	return err;
 }
 
 void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi)
@@ -3426,6 +3473,10 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	 * new segment.
 	 */
 	if (segment_full) {
+		if (type == CURSEG_COLD_DATA_PINNED &&
+		    !((curseg->segno + 1) % sbi->segs_per_sec))
+			goto skip_new_segment;
+
 		if (from_gc) {
 			get_atssr_segment(sbi, type, se->type,
 						AT_SSR, se->mtime);
@@ -3437,6 +3488,8 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 			stat_inc_seg_type(sbi, curseg);
 		}
 	}
+
+skip_new_segment:
 	/*
 	 * segment dirty status should be updated after segment allocation,
 	 * so we just need to update status only one time after previous
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 60d93a16f2ac..953af072915f 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -942,3 +942,13 @@ static inline void wake_up_discard_thread(struct f2fs_sb_info *sbi, bool force)
 	dcc->discard_wake = true;
 	wake_up_interruptible_all(&dcc->discard_wait_queue);
 }
+
+static inline unsigned int first_zoned_segno(struct f2fs_sb_info *sbi)
+{
+	int devi;
+
+	for (devi = 0; devi < sbi->s_ndevs; devi++)
+		if (bdev_is_zoned(FDEV(devi).bdev))
+			return GET_SEGNO(sbi, FDEV(devi).start_blk);
+	return 0;
+}
-- 
2.43.0.687.g38aa6559b0-goog


