Return-Path: <linux-kernel+bounces-88075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCDF86DD0C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3755128AC2C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4380C69D31;
	Fri,  1 Mar 2024 08:27:00 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F76569D05
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281619; cv=none; b=SWAahStQJ0GShN/itO4WW2ybl2CbwYCxaeE6ep5WyfqRbngOCNuWoz4cuU8LduW2KKgQAQU6LA7+STclneOXkxsPhy40+JQbctLr1r6GU7UV3jHxCCwHxfH+rICj04DJS48AxK78aW6wQcMwKbY5R/hqSrn0uHs3oRgxsyO+u24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281619; c=relaxed/simple;
	bh=9+cMmk/j1E0sLXVifzfj5cm2/RcLIUpa5OLoC8QQBRM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TIP7wbEy1J9jucGJGp+zM6+6VUBxbultt39uueKvdvGyi5uQKD1UowX+6DwBoBXPZ+vkTyE/nVGRy7Uco5LH++ngSgXt0jYhP8cY/AwTFk0nm00TVeq7dSSpdqZIyxxQrjwdDgfxxzjpNOY0GWZS6nh7MqdkLzPsuujvHf1e/ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4218Q82T055542;
	Fri, 1 Mar 2024 16:26:08 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TmLkN0Dccz2KQsFF;
	Fri,  1 Mar 2024 16:25:16 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 1 Mar 2024 16:26:05 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH 1/2] f2fs: fix to check return value __allocate_new_segment
Date: Fri, 1 Mar 2024 16:25:54 +0800
Message-ID: <1709281555-11373-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 4218Q82T055542

__allocate_new_segment may return error when get_new_segment
fails, so its caller should check its return value.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/f2fs.h     | 2 +-
 fs/f2fs/recovery.c | 2 +-
 fs/f2fs/segment.c  | 7 +++++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index db05fd0..4331012 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3705,7 +3705,7 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end);
 int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
 int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi);
-void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
+int f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
 int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
 bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
 					struct cp_control *cpc);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 3078d56..c381f0a 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -851,7 +851,7 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 		f2fs_ra_meta_pages_cond(sbi, blkaddr, ra_blocks);
 	}
 	if (!err)
-		f2fs_allocate_new_segments(sbi);
+		err = f2fs_allocate_new_segments(sbi);
 	return err;
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index cdac4cb..72f6ee3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3163,16 +3163,19 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
 	return err;
 }
 
-void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi)
+int f2fs_allocate_new_segments(struct f2fs_sb_info *sbi)
 {
 	int i;
+	int err = 0;
 
 	f2fs_down_read(&SM_I(sbi)->curseg_lock);
 	down_write(&SIT_I(sbi)->sentry_lock);
 	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++)
-		__allocate_new_segment(sbi, i, false, false);
+		err += __allocate_new_segment(sbi, i, false, false);
 	up_write(&SIT_I(sbi)->sentry_lock);
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
+
+	return err;
 }
 
 bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
-- 
1.9.1


