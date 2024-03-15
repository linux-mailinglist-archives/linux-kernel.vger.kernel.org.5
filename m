Return-Path: <linux-kernel+bounces-104346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F6187CC5F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 298A4282E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F4C1B809;
	Fri, 15 Mar 2024 11:33:33 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE76B1B7E1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502413; cv=none; b=F3w8ogGhfauuC5r1VovWaOI1wqIqb3uWuWJqzV+ne+1VRFiyCvYuoKmucSGxFuWGmRzr5VemAfdkpLbYesCvPtsqkp6tOfIuto/ylPYOKhHXp9o7y4+qZXWtw7jbgOD4Fb0yKucAy4VrUoWQ18Cm35stn/F5vYHquy2mh3ANgSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502413; c=relaxed/simple;
	bh=hR8HNMmNfTIbcQeL6rVaiO5s+Woarxu0aLHVGt3AURU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nwbgoYUv1HztJpvwdTxrRquCYQ1qW2yPcg8yUgvOfk6TGZ9eidZ6g4ZRwiddaUH4KA1rHIiQQ2YHRxNqsH1xSg3MvnOj1pMIyUXAPMFH5/HRpLr+G8Z/RLxwSsvbB0AxEAzFV6orLDQ8FvEgDZT/IbVFUwoGk9tHI49WqZpiVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 42FBWfBd056967;
	Fri, 15 Mar 2024 19:32:41 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Tx2Bf0RM4z2L6tFy;
	Fri, 15 Mar 2024 19:31:22 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 15 Mar 2024 19:32:39 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH V2] f2fs: add REQ_TIME time update for some user behaviors
Date: Fri, 15 Mar 2024 19:32:36 +0800
Message-ID: <1710502356-11469-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 42FBWfBd056967

some user behaviors requested filesystem operations, which
will cause filesystem not idle.
Meanwhile adjust some f2fs_update_time(REQ_TIME) positions.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
v2: update patch according to Chao's suggestions
---
---
 fs/f2fs/file.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1761ad1..8c9d6ea 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2354,13 +2354,14 @@ static bool uuid_is_nonzero(__u8 u[16])
 static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
+	int ret;
 
 	if (!f2fs_sb_has_encrypt(F2FS_I_SB(inode)))
 		return -EOPNOTSUPP;
 
+	ret = fscrypt_ioctl_set_policy(filp, (const void __user *)arg);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
-
-	return fscrypt_ioctl_set_policy(filp, (const void __user *)arg);
+	return ret;
 }
 
 static int f2fs_ioc_get_encryption_policy(struct file *filp, unsigned long arg)
@@ -2786,7 +2787,8 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
 	err = f2fs_defragment_range(sbi, filp, &range);
 	mnt_drop_write_file(filp);
 
-	f2fs_update_time(sbi, REQ_TIME);
+	if (range.len)
+		f2fs_update_time(sbi, REQ_TIME);
 	if (err < 0)
 		return err;
 
@@ -3599,6 +3601,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 
 	filemap_invalidate_unlock(inode->i_mapping);
 	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	f2fs_update_time(sbi, REQ_TIME);
 out:
 	inode_unlock(inode);
 
@@ -3768,6 +3771,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 		clear_inode_flag(inode, FI_COMPRESS_RELEASED);
 		inode_set_ctime_current(inode);
 		f2fs_mark_inode_dirty_sync(inode, true);
+		f2fs_update_time(sbi, REQ_TIME);
 	}
 unlock_inode:
 	inode_unlock(inode);
@@ -3966,6 +3970,7 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 	if (len)
 		ret = f2fs_secure_erase(prev_bdev, inode, prev_index,
 				prev_block, len, range.flags);
+	f2fs_update_time(sbi, REQ_TIME);
 out:
 	filemap_invalidate_unlock(mapping);
 	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
@@ -4175,6 +4180,7 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	if (ret)
 		f2fs_warn(sbi, "%s: The file might be partially decompressed (errno=%d). Please delete the file.",
 			  __func__, ret);
+	f2fs_update_time(sbi, REQ_TIME);
 out:
 	inode_unlock(inode);
 	file_end_write(filp);
@@ -4254,6 +4260,7 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	if (ret)
 		f2fs_warn(sbi, "%s: The file might be partially compressed (errno=%d). Please delete the file.",
 			  __func__, ret);
+	f2fs_update_time(sbi, REQ_TIME);
 out:
 	inode_unlock(inode);
 	file_end_write(filp);
-- 
1.9.1


