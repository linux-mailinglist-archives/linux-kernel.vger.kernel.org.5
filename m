Return-Path: <linux-kernel+bounces-88365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DF286E084
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9832B1F25094
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4886D519;
	Fri,  1 Mar 2024 11:36:59 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16C6EB51
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709293019; cv=none; b=djTXL/CBoNDSrtQ2VmGTo2vGRa0ZoX+VMkkkaChUPNFjcZLD5yH7iZHjP0GVKsYTHxBaDFMNnW4peWRO4pwaEW6RPXfLfwDhB8OriQUmuae29yjGz6RSGwE9oej1EpqnOLhnFjDINermPawWVsQX4U8iTfSkd6/uYUGiC/fyRYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709293019; c=relaxed/simple;
	bh=kTOIpCx85MBExZD7m/gewjcjf04YHT5rYbCmo2npUI4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=swAeWRZSxMzOt2/+h6twhCqkDA6UMr7OybM8d7ytMjqFVG2HM4POa7ABV+gpHcwpXkJlwu6T8D7QzX/w5EDa/kDw4UttwH5ejs2GZwXdOd1Jh3GOOyURn1TZAp/7edv46vfZJWzQovO9/i6z256oBe4CMPA2cCmCkcLEwJ0uPn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 421BaPmN084487;
	Fri, 1 Mar 2024 19:36:25 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TmQxw6S0bz2KkZ9v;
	Fri,  1 Mar 2024 19:35:32 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 1 Mar 2024 19:36:23 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH] f2fs: fix to check result of new_curseg in f2fs_allocate_segment_for_resize
Date: Fri, 1 Mar 2024 19:36:16 +0800
Message-ID: <1709292976-13118-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 421BaPmN084487

new_curseg may return error if get_new_segment fail, so its result
should be check in its caller f2fs_allocate_segment_for_resize,
alos pass this results to free_segment_range.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/f2fs.h    | 2 +-
 fs/f2fs/gc.c      | 7 +++++--
 fs/f2fs/segment.c | 9 +++++++--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4331012..39dda7d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3701,7 +3701,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
-void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
+int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end);
 int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
 int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c60b747..7a458fa 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2037,8 +2037,11 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
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
index 1bb3019..2a07b9d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3071,11 +3071,12 @@ static bool need_new_seg(struct f2fs_sb_info *sbi, int type)
 	return false;
 }
 
-void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
+int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	unsigned int segno;
+	int err = 0;
 
 	f2fs_down_read(&SM_I(sbi)->curseg_lock);
 	mutex_lock(&curseg->curseg_mutex);
@@ -3089,7 +3090,10 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 		change_curseg(sbi, type);
 	else
 		new_curseg(sbi, type, true);
-
+	if (curseg->segno == NULL_SEGNO) {
+		err = -ENOSPC;
+		goto unlock;
+	}
 	stat_inc_seg_type(sbi, curseg);
 
 	locate_dirty_segment(sbi, segno);
@@ -3102,6 +3106,7 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 
 	mutex_unlock(&curseg->curseg_mutex);
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
+	return err;
 }
 
 static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
-- 
1.9.1


