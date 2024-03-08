Return-Path: <linux-kernel+bounces-96806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B20AA8761AC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F09281671
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF0D54773;
	Fri,  8 Mar 2024 10:13:15 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95953E02
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892794; cv=none; b=h7jnClNAmaFqcoFaWjd0EiTPVxS/ZGAvuvryITyFMKZREFe7MZZwDcrIuvFNcRjXZ7KGpiKTH6lnQWJmFsByNqkZ1GaNVgoMdSxP4UqfUoKeuE5YbDoVxOCxDW5KK0jiJZv7k2zOIcOUIdOOb2NGQCH+29nEUUrva/NlwFlJ/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892794; c=relaxed/simple;
	bh=7k8WPTEeiS2r5DqwA1UaykwUi4lGNl80XV5DxjFL7kI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3ojbWjpT8FhRlEyikjkHauYxRk0/kLKtHiqR1iiK+ARRZVDO2o/GlCvF/f1IZfMrFzqkLGzG7kqW0dpyPfsWvZKHKyZqL89BL1kXe3KKToTkV0nEy4ibEfGw3fgx5dONubLvvlj4LXLLquBmHOf4X+bkB+cegpuVRxicq4J7fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 428ACf4w067951;
	Fri, 8 Mar 2024 18:12:41 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Trhlq5Ttjz2L3SH2;
	Fri,  8 Mar 2024 18:11:35 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 8 Mar 2024 18:12:39 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH 2/2] f2fs: fix to handle error paths of {new,change}_curseg()
Date: Fri, 8 Mar 2024 18:12:33 +0800
Message-ID: <1709892753-27461-2-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1709892753-27461-1-git-send-email-zhiguo.niu@unisoc.com>
References: <1709892753-27461-1-git-send-email-zhiguo.niu@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 428ACf4w067951

{new,change}_curseg() may return error in some special cases,
error handling should be did in their callers, and this will also
facilitate subsequent error path expansion in {new,change}_curseg().

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/extent_cache.c |  2 +-
 fs/f2fs/f2fs.h         |  4 ++--
 fs/f2fs/gc.c           |  7 +++++--
 fs/f2fs/segment.c      | 57 +++++++++++++++++++++++++++++++-------------------
 fs/f2fs/super.c        |  4 +++-
 5 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 48048fa..dce00cf 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -988,7 +988,7 @@ bool f2fs_lookup_read_extent_cache_block(struct inode *inode, pgoff_t index,
 
 void f2fs_update_read_extent_cache(struct dnode_of_data *dn)
 {
-	return __update_extent_cache(dn, EX_READ);
+	__update_extent_cache(dn, EX_READ);
 }
 
 void f2fs_update_read_extent_cache_range(struct dnode_of_data *dn,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4836e7c..7beb074 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3700,10 +3700,10 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
 int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
 bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
-void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
+int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
-void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
+int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end);
 int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
 int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ca1bf41..8852814 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2035,8 +2035,11 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
 
 	/* Move out cursegs from the target range */
-	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++)
-		f2fs_allocate_segment_for_resize(sbi, type, start, end);
+	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
+		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
+		if (err)
+			goto out;
+	}
 
 	/* do GC to move out valid blocks in the range */
 	err = f2fs_gc_range(sbi, start, end, dry_run, 0);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4e4a51a..c1c1308 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2863,7 +2863,7 @@ bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
  * This function always allocates a used segment(from dirty seglist) by SSR
  * manner, so it should recover the existing segment information of valid blocks
  */
-static void change_curseg(struct f2fs_sb_info *sbi, int type)
+static int change_curseg(struct f2fs_sb_info *sbi, int type)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
@@ -2888,21 +2888,23 @@ static void change_curseg(struct f2fs_sb_info *sbi, int type)
 	if (IS_ERR(sum_page)) {
 		/* GC won't be able to use stale summary pages by cp_error */
 		memset(curseg->sum_blk, 0, SUM_ENTRY_SIZE);
-		return;
+		return PTR_ERR(sum_page);
 	}
 	sum_node = (struct f2fs_summary_block *)page_address(sum_page);
 	memcpy(curseg->sum_blk, sum_node, SUM_ENTRY_SIZE);
 	f2fs_put_page(sum_page, 1);
+	return 0;
 }
 
 static int get_ssr_segment(struct f2fs_sb_info *sbi, int type,
 				int alloc_mode, unsigned long long age);
 
-static void get_atssr_segment(struct f2fs_sb_info *sbi, int type,
+static int get_atssr_segment(struct f2fs_sb_info *sbi, int type,
 					int target_type, int alloc_mode,
 					unsigned long long age)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
+	int ret = 0;
 
 	curseg->seg_type = target_type;
 
@@ -2910,38 +2912,41 @@ static void get_atssr_segment(struct f2fs_sb_info *sbi, int type,
 		struct seg_entry *se = get_seg_entry(sbi, curseg->next_segno);
 
 		curseg->seg_type = se->type;
-		change_curseg(sbi, type);
+		ret = change_curseg(sbi, type);
 	} else {
 		/* allocate cold segment by default */
 		curseg->seg_type = CURSEG_COLD_DATA;
-		new_curseg(sbi, type, true);
+		ret = new_curseg(sbi, type, true);
 	}
 	stat_inc_seg_type(sbi, curseg);
+	return ret;
 }
 
-static void __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
+static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_ALL_DATA_ATGC);
+	int ret = 0;
 
 	if (!sbi->am.atgc_enabled)
-		return;
+		return 0;
 
 	f2fs_down_read(&SM_I(sbi)->curseg_lock);
 
 	mutex_lock(&curseg->curseg_mutex);
 	down_write(&SIT_I(sbi)->sentry_lock);
 
-	get_atssr_segment(sbi, CURSEG_ALL_DATA_ATGC, CURSEG_COLD_DATA, SSR, 0);
+	ret = get_atssr_segment(sbi, CURSEG_ALL_DATA_ATGC,
+					CURSEG_COLD_DATA, SSR, 0);
 
 	up_write(&SIT_I(sbi)->sentry_lock);
 	mutex_unlock(&curseg->curseg_mutex);
 
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
-
+	return ret;
 }
-void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
+int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
 {
-	__f2fs_init_atgc_curseg(sbi);
+	return __f2fs_init_atgc_curseg(sbi);
 }
 
 static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int type)
@@ -3069,11 +3074,12 @@ static bool need_new_seg(struct f2fs_sb_info *sbi, int type)
 	return false;
 }
 
-void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
+int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	unsigned int segno;
+	int ret = 0;
 
 	f2fs_down_read(&SM_I(sbi)->curseg_lock);
 	mutex_lock(&curseg->curseg_mutex);
@@ -3084,9 +3090,9 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 		goto unlock;
 
 	if (f2fs_need_SSR(sbi) && get_ssr_segment(sbi, type, SSR, 0))
-		change_curseg(sbi, type);
+		ret = change_curseg(sbi, type);
 	else
-		new_curseg(sbi, type, true);
+		ret = new_curseg(sbi, type, true);
 
 	stat_inc_seg_type(sbi, curseg);
 
@@ -3100,6 +3106,7 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 
 	mutex_unlock(&curseg->curseg_mutex);
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
+	return ret;
 }
 
 static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
@@ -3486,14 +3493,17 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	bool from_gc = (type == CURSEG_ALL_DATA_ATGC);
 	struct seg_entry *se = NULL;
 	bool segment_full = false;
+	int ret = 0;
 
 	f2fs_down_read(&SM_I(sbi)->curseg_lock);
 
 	mutex_lock(&curseg->curseg_mutex);
 	down_write(&sit_i->sentry_lock);
 
-	if (curseg->segno == NULL_SEGNO)
+	if (curseg->segno == NULL_SEGNO) {
+		ret = -ENOSPC;
 		goto out_err;
+	}
 
 	if (from_gc) {
 		f2fs_bug_on(sbi, GET_SEGNO(sbi, old_blkaddr) == NULL_SEGNO);
@@ -3546,17 +3556,17 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 		}
 
 		if (from_gc) {
-			get_atssr_segment(sbi, type, se->type,
+			ret = get_atssr_segment(sbi, type, se->type,
 						AT_SSR, se->mtime);
 		} else {
 			if (need_new_seg(sbi, type))
-				new_curseg(sbi, type, false);
+				ret = new_curseg(sbi, type, false);
 			else
-				change_curseg(sbi, type);
+				ret = change_curseg(sbi, type);
 			stat_inc_seg_type(sbi, curseg);
 		}
 
-		if (curseg->segno == NULL_SEGNO)
+		if (ret)
 			goto out_err;
 	}
 
@@ -3599,7 +3609,7 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	up_write(&sit_i->sentry_lock);
 	mutex_unlock(&curseg->curseg_mutex);
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
-	return -ENOSPC;
+	return ret;
 
 }
 
@@ -3829,7 +3839,8 @@ void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	/* change the current segment */
 	if (segno != curseg->segno) {
 		curseg->next_segno = segno;
-		change_curseg(sbi, type);
+		if (change_curseg(sbi, type))
+			goto out_unlock;
 	}
 
 	curseg->next_blkoff = GET_BLKOFF_FROM_SEG0(sbi, new_blkaddr);
@@ -3855,12 +3866,14 @@ void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	if (recover_curseg) {
 		if (old_cursegno != curseg->segno) {
 			curseg->next_segno = old_cursegno;
-			change_curseg(sbi, type);
+			if (change_curseg(sbi, type))
+				goto out_unlock;
 		}
 		curseg->next_blkoff = old_blkoff;
 		curseg->alloc_type = old_alloc_type;
 	}
 
+out_unlock:
 	up_write(&sit_i->sentry_lock);
 	mutex_unlock(&curseg->curseg_mutex);
 	f2fs_up_write(&SM_I(sbi)->curseg_lock);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 78a7658..f2b6d3f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4685,7 +4685,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto free_meta;
 
-	f2fs_init_inmem_curseg(sbi);
+	err = f2fs_init_inmem_curseg(sbi);
+	if (err)
+		goto sync_free_meta;
 
 	/* f2fs_recover_fsync_data() cleared this already */
 	clear_sbi_flag(sbi, SBI_POR_DOING);
-- 
1.9.1


