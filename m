Return-Path: <linux-kernel+bounces-55831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D8F84C234
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54D12B2A6AE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C407915E90;
	Wed,  7 Feb 2024 02:02:16 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B268134A4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 02:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707271336; cv=none; b=BubJWg8EYabNIOm/U5bFaBIifguF+Dz9/AMiGtfitE6d/d0k2HLPDRav8UAZy1umefQ9zNY6F6B6F0vN6xRVwrthAGmuqRb5aYEYucYkCeupdlHw6BUZCuVAA+xf7iIW4LoePqDlyJ6KECIPOmj/SFoQtSkP7s5bBwRmi9gJ7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707271336; c=relaxed/simple;
	bh=ax5uZYqMwPzUWWg81cnbAG10+zb+AYQ7l9nQlARj9WM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQNkHr9/MEKmxMYCAUtHqg7tYGAFcurolYAkgKaXAGPE0l7lIyxIBCnRnBGbwdoOxP1RuD2A5+MITe1niAvaDrqzRbwYb08AppJegSu+dZLbGlAovbaa6YHN5QcEFulZrYEUx4iHO7hbhTZrO/8uROaSsv6Gg32V4D0jh4Ncwbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41721cDM075958;
	Wed, 7 Feb 2024 10:01:38 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TV3JC0nQwz2K4cHw;
	Wed,  7 Feb 2024 10:01:31 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 7 Feb 2024 10:01:36 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH v2 4/4] f2fs: stop checkpoint when get a out-of-bounds segment
Date: Wed, 7 Feb 2024 10:01:04 +0800
Message-ID: <1707271264-5551-5-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 41721cDM075958

There is low probability that an out-of-bounds segment will be got
on a small-capacity device. In order to prevent subsequent write requests
allocating block address from this invalid segment, which may cause
unexpected issue, stop checkpoint should be performed.

Also introduce a new stop cp reason:  STOP_CP_REASON_OUTOF_RAGNE.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/segment.c       | 12 ++++++++++--
 include/linux/f2fs_fs.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6772ad4..6fe2baf 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2666,7 +2666,11 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 		if (dir == ALLOC_RIGHT) {
 			secno = find_first_zero_bit(free_i->free_secmap,
 							MAIN_SECS(sbi));
-			f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
+			if (secno >= MAIN_SECS(sbi)) {
+				f2fs_stop_checkpoint(sbi, false,
+						STOP_CP_REASON_OUTOF_RAGNE);
+				f2fs_bug_on(sbi, 1);
+			}
 		} else {
 			go_left = 1;
 			left_start = hint - 1;
@@ -2682,7 +2686,11 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 		}
 		left_start = find_first_zero_bit(free_i->free_secmap,
 							MAIN_SECS(sbi));
-		f2fs_bug_on(sbi, left_start >= MAIN_SECS(sbi));
+		if (left_start >= MAIN_SECS(sbi)) {
+			f2fs_stop_checkpoint(sbi, false,
+					STOP_CP_REASON_OUTOF_RAGNE);
+			f2fs_bug_on(sbi, 1);
+		}
 		break;
 	}
 	secno = left_start;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 053137a0..72c6782 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -81,6 +81,7 @@ enum stop_cp_reason {
 	STOP_CP_REASON_CORRUPTED_SUMMARY,
 	STOP_CP_REASON_UPDATE_INODE,
 	STOP_CP_REASON_FLUSH_FAIL,
+	STOP_CP_REASON_OUTOF_RAGNE,
 	STOP_CP_REASON_MAX,
 };
 
-- 
1.9.1


