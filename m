Return-Path: <linux-kernel+bounces-88076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A7486DD0D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B5BB27809
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4915D69E01;
	Fri,  1 Mar 2024 08:27:02 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25A169D14
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281621; cv=none; b=lQzzcGB732AVG986g+lCLZOjPtdFeOuCPT0BiSeIEW3DiBfflBZ73M9eL/jr0hlFlC39JxPMpf3Yob0AOsKgZ8NgK9M5oXeBUl52h4jOX+bkUxtBbX5dnopNMAd1M/JAFCSHoeFYgsV8GWAjSKzDIg3uw6KKdfb+s6SxIwjluf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281621; c=relaxed/simple;
	bh=Qkm28q9qiqVdNpBzw+D1ZzW6MaJgVHb4vj9bN4B0IrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSsBt9EgtuUsiO6TSmOr63pqUVdVGdE2NomrnLIzVJk2rmIO2Qwz5zBehPkASWU4KG+imU8b5dKT5Tq6Sg/s8WazmTcxhvHaM9znm7Ec20GKLKBXnzusYgVg7pzIRUV4E3WzOVq+TXcN4EoRNQWgz0o4u7EBoV+xhpAm+ELIIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4218QCKa055787;
	Fri, 1 Mar 2024 16:26:12 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TmLkR6XLSz2KQsFF;
	Fri,  1 Mar 2024 16:25:19 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 1 Mar 2024 16:26:09 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH 2/2] f2fs: fix to check return value of f2fs_gc_range
Date: Fri, 1 Mar 2024 16:25:55 +0800
Message-ID: <1709281555-11373-2-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1709281555-11373-1-git-send-email-zhiguo.niu@unisoc.com>
References: <1709281555-11373-1-git-send-email-zhiguo.niu@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 4218QCKa055787

f2fs_gc_range may return error, so its caller
f2fs_allocate_pinning_section should determine whether
to do retry based on ist return value.

Also just do f2fs_gc_range when f2fs_allocate_new_section
return -EAGAIN, and check cp error case in f2fs_gc_range.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/gc.c      |  3 +++
 fs/f2fs/segment.c | 13 ++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e435e1f..c60b747 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1986,6 +1986,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 	unsigned int segno;
 	unsigned int gc_secs = dry_run_sections;
 
+	if (unlikely(f2fs_cp_error(sbi)))
+		return -EIO;
+
 	for (segno = start_seg; segno <= end_seg; segno += SEGS_PER_SEC(sbi)) {
 		struct gc_inode_list gc_list = {
 			.ilist = LIST_HEAD_INIT(gc_list.ilist),
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 72f6ee3..1bb3019 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3109,6 +3109,7 @@ static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	unsigned int old_segno;
+	int err = 0;
 
 	if (type == CURSEG_COLD_DATA_PINNED && !curseg->inited)
 		goto allocate;
@@ -3121,8 +3122,9 @@ static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
 
 allocate:
 	old_segno = curseg->segno;
-	if (new_curseg(sbi, type, true))
-		return -EAGAIN;
+	err = new_curseg(sbi, type, true);
+	if (err)
+		return err;
 	stat_inc_seg_type(sbi, curseg);
 	locate_dirty_segment(sbi, old_segno);
 	return 0;
@@ -3151,13 +3153,14 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
 	err = f2fs_allocate_new_section(sbi, CURSEG_COLD_DATA_PINNED, false);
 	f2fs_unlock_op(sbi);
 
-	if (f2fs_sb_has_blkzoned(sbi) && err && gc_required) {
+	if (f2fs_sb_has_blkzoned(sbi) && err == -EAGAIN && gc_required) {
 		f2fs_down_write(&sbi->gc_lock);
-		f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_blk), true, 1);
+		err = f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_blk), true, 1);
 		f2fs_up_write(&sbi->gc_lock);
 
 		gc_required = false;
-		goto retry;
+		if (!err)
+			goto retry;
 	}
 
 	return err;
-- 
1.9.1


