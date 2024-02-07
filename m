Return-Path: <linux-kernel+bounces-55830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D617184C233
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4491C21BAD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D2C134A6;
	Wed,  7 Feb 2024 02:02:14 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAA712E74
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707271334; cv=none; b=VylOc8HJkJQlGhAerQD5vf/g4Ydn9dBc6NmZ2ZVsY0BfLLfBTA1gIvBpPM2DEYsYslHeoyXwZdibk07/FVkZPUGsw4HHM9PiJ04oXlV/pQrAYP/aIZEqkvhKbZMIH4+eaiLJ7spqkvSREm1kAmokgCj1QErXOz16nsqaHafoc3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707271334; c=relaxed/simple;
	bh=8iTvrOWdUHwLUYIO0I51Nm4DAdcTJoccfesvR6ZoX/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQjH7iDihEs9UnCMVlnktENpG1d2VVl3JB50mlnBlerVA3gjMiAJHUTIz9LvLrFQTqSmEn3lspKte/b2vZ2kpcKtgU+fAG2/M4qafPdFjLCJpqCDkRP+wFcWYHOoYQdwYelmmoFaWJWAoiD9v1psmEcpfFQsn3/OWZq2ccUWKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41721YXP075835;
	Wed, 7 Feb 2024 10:01:34 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TV3J65frxz2K4cHw;
	Wed,  7 Feb 2024 10:01:26 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 7 Feb 2024 10:01:31 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH v2 3/4] f2fs: enhance judgment conditions of GET_SEGNO
Date: Wed, 7 Feb 2024 10:01:03 +0800
Message-ID: <1707271264-5551-4-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
References: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 41721YXP075835

NULL_SEGNO should also be returned when the blk_addr value is
out-of-bound main area even __is_valid_data_blkaddr return true.

For example, a 64MB partition with total 24 main segments has no
any free segments left, then a new wrtie request use get_new_segment
may get a out-of-bound segno 24 if CONFIG_F2FS_CHECK_FS is not enabled.
GET_SEGNO should also return NULL_SEGNO in this case rather than treating
is as valid segment.

Besides, if the caller of GET_SEGNO does not ensure blk_addr pass to
GET_SEGNO is valid, it should do sanity check about return value of
GET_SEGNO, avoid causing some unexpected problems later.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/file.c    | 7 ++++++-
 fs/f2fs/segment.c | 4 +++-
 fs/f2fs/segment.h | 3 ++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 23cd6a1..2cd3cd9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2985,9 +2985,14 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
 	if (ret)
 		return ret;
 
-	if (range.dev_num != 0)
+	if (range.dev_num != 0) {
 		dev_start_segno = GET_SEGNO(sbi, FDEV(range.dev_num).start_blk);
+		if (dev_start_segno == NULL_SEGNO)
+			return -EINVAL;
+	}
 	dev_end_segno = GET_SEGNO(sbi, FDEV(range.dev_num).end_blk);
+	if (dev_end_segno == NULL_SEGNO)
+		return -EINVAL;
 
 	start_segno = sm->last_victim[FLUSH_DEVICE];
 	if (start_segno < dev_start_segno || start_segno >= dev_end_segno)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f373ff7..6772ad4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2496,7 +2496,7 @@ void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
 	struct sit_info *sit_i = SIT_I(sbi);
 
 	f2fs_bug_on(sbi, addr == NULL_ADDR);
-	if (addr == NEW_ADDR || addr == COMPRESS_ADDR)
+	if (segno == NULL_SEGNO)
 		return;
 
 	f2fs_invalidate_internal_cache(sbi, addr);
@@ -3708,6 +3708,8 @@ void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	unsigned char old_alloc_type;
 
 	segno = GET_SEGNO(sbi, new_blkaddr);
+	if (segno == NULL_SEGNO)
+		return;
 	se = get_seg_entry(sbi, segno);
 	type = se->type;
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index f2847f1..b0ea315 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -96,7 +96,8 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) & ((sbi)->blocks_per_seg - 1))
 
 #define GET_SEGNO(sbi, blk_addr)					\
-	((!__is_valid_data_blkaddr(blk_addr)) ?			\
+	((!__is_valid_data_blkaddr(blk_addr) ||			\
+	!f2fs_is_valid_blkaddr(sbi, blk_addr, DATA_GENERIC)) ?	\
 	NULL_SEGNO : GET_L2R_SEGNO(FREE_I(sbi),			\
 		GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
 #define BLKS_PER_SEC(sbi)					\
-- 
1.9.1


