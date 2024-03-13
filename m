Return-Path: <linux-kernel+bounces-101094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448F687A235
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E441F21311
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FF216429;
	Wed, 13 Mar 2024 04:12:09 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA52A15AD0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710303128; cv=none; b=e5SJST31ZMakFbxIQEXUIX7ObjUGrUpoubYfcSEE0JWu63zLm/UbhP/INk1Yj+tSoEz8vuDpriW0bBxQW1onjigvTJXDP+vWYt/31iJGF/szH4e5Q9cnk+XSG7aYJ/FGonDDZwJqbwWNv4IhLlUuVx2iX0NhbM7hkIRuf1fU+Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710303128; c=relaxed/simple;
	bh=m9EzkrvhnBGFjEynb0P7dNnLLLE/B+RI5XGgC6B+yrQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uX4z1BbCn6/WIHq3CUPfJKQuFkJOpGb4R3/vB/BZVOrHcrnID6gZYItGcYVk7PZWuwC8b9LclLpS7T4GJHrudQskaMQIvKpdsbxDILnoTfRFW0VkD8xuWWA11tf3jfwihBpZL5+MkhLTRLt1ZkilvKx1KiRU4Qgs4adIDb6uVXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 42D4BEfm081099;
	Wed, 13 Mar 2024 12:11:14 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TvcVG3CXdz2L0GYg;
	Wed, 13 Mar 2024 12:09:58 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 13 Mar 2024 12:11:11 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH] f2fs: add REQ_TIME time update for some user behaviors
Date: Wed, 13 Mar 2024 12:11:01 +0800
Message-ID: <1710303061-16822-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 42D4BEfm081099

some user behaviors requested filesystem operations, which
will cause filesystem not idle.
Meanwhile adjust f2fs_update_time(REQ_TIME) of
f2fs_ioc_defragment to successful case.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4dfe38e..dac3836 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2784,7 +2784,6 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
 	err = f2fs_defragment_range(sbi, filp, &range);
 	mnt_drop_write_file(filp);
 
-	f2fs_update_time(sbi, REQ_TIME);
 	if (err < 0)
 		return err;
 
@@ -2792,6 +2791,7 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
 							sizeof(range)))
 		return -EFAULT;
 
+	f2fs_update_time(sbi, REQ_TIME);
 	return 0;
 }
 
@@ -3331,6 +3331,7 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
 	if (copy_from_user(&block_count, (void __user *)arg,
 			   sizeof(block_count)))
 		return -EFAULT;
+	f2fs_update_time(sbi, REQ_TIME);
 
 	return f2fs_resize_fs(filp, block_count);
 }
@@ -3424,6 +3425,7 @@ static int f2fs_ioc_setfslabel(struct file *filp, unsigned long arg)
 	f2fs_up_write(&sbi->sb_lock);
 
 	mnt_drop_write_file(filp);
+	f2fs_update_time(sbi, REQ_TIME);
 out:
 	kfree(vbuf);
 	return err;
@@ -3597,6 +3599,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 
 	filemap_invalidate_unlock(inode->i_mapping);
 	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	f2fs_update_time(sbi, REQ_TIME);
 out:
 	inode_unlock(inode);
 
@@ -3766,6 +3769,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 		clear_inode_flag(inode, FI_COMPRESS_RELEASED);
 		inode_set_ctime_current(inode);
 		f2fs_mark_inode_dirty_sync(inode, true);
+		f2fs_update_time(sbi, REQ_TIME);
 	}
 unlock_inode:
 	inode_unlock(inode);
@@ -3964,6 +3968,7 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 	if (len)
 		ret = f2fs_secure_erase(prev_bdev, inode, prev_index,
 				prev_block, len, range.flags);
+	f2fs_update_time(sbi, REQ_TIME);
 out:
 	filemap_invalidate_unlock(mapping);
 	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
@@ -4173,6 +4178,7 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	if (ret)
 		f2fs_warn(sbi, "%s: The file might be partially decompressed (errno=%d). Please delete the file.",
 			  __func__, ret);
+	f2fs_update_time(sbi, REQ_TIME);
 out:
 	inode_unlock(inode);
 	file_end_write(filp);
@@ -4252,6 +4258,7 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	if (ret)
 		f2fs_warn(sbi, "%s: The file might be partially compressed (errno=%d). Please delete the file.",
 			  __func__, ret);
+	f2fs_update_time(sbi, REQ_TIME);
 out:
 	inode_unlock(inode);
 	file_end_write(filp);
-- 
1.9.1


