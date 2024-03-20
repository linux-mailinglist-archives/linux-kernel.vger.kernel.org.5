Return-Path: <linux-kernel+bounces-108489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BF6880B28
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D421C22085
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D696818AE8;
	Wed, 20 Mar 2024 06:23:01 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E208917BB2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915781; cv=none; b=V6sDEUlZhNULACZqyZjB3qA5LLsU9lviTi2FqY0vn177byWLOwRlAqbPgnVQTalzbqykKSVlIjexv1OKZCJ/9fUcUJz8laBW1xdX5kiYulYs9zpRHMdNSYozpSu4ZdO31nTD9h3IuuAg0rSWbJ52BNxk8t4tm9D6PxIOjVm5ycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915781; c=relaxed/simple;
	bh=u/9hsYB0W+tn6FGW7boLfn8FB0Avm/e9ANMlqwULA1c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pZQBTEH9S6CFXy1Q5m5d5HiK7joOyeS1TxLDEynfYNCAnYc6nasPzw3ghoafBCC5pWKP9RO3xO6WG33GEX93rN8az5be7SImQnRNRo4X+KxObNX/rpWrwfRwLMU3wN+bvuqAo7+sDKuyVowfNENzBa4E0cWlGad4O6iNBgtIzyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 42K6Mrgn065635
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:22:53 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 42K6MKnq064146;
	Wed, 20 Mar 2024 14:22:20 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Tzz426PS0z2LRfxd;
	Wed, 20 Mar 2024 14:20:50 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 20 Mar 2024 14:22:17 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH V3] f2fs: add REQ_TIME time update for some user behaviors
Date: Wed, 20 Mar 2024 14:22:16 +0800
Message-ID: <1710915736-31823-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 42K6MKnq064146

some user behaviors requested filesystem operations, which
will cause filesystem not idle.
Meanwhile adjust some f2fs_update_time(REQ_TIME) positions.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
v3: modify some update conditions according to Chao's suggeestions
v2: update patch according to Chao's suggestions
---
---
 fs/f2fs/file.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1761ad1..128e53d 100644
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
 
@@ -3600,6 +3602,8 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	filemap_invalidate_unlock(inode->i_mapping);
 	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 out:
+	if (released_blocks)
+		f2fs_update_time(sbi, REQ_TIME);
 	inode_unlock(inode);
 
 	mnt_drop_write_file(filp);
@@ -3770,6 +3774,8 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 		f2fs_mark_inode_dirty_sync(inode, true);
 	}
 unlock_inode:
+	if (reserved_blocks)
+		f2fs_update_time(sbi, REQ_TIME);
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 
@@ -3966,6 +3972,7 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 	if (len)
 		ret = f2fs_secure_erase(prev_bdev, inode, prev_index,
 				prev_block, len, range.flags);
+	f2fs_update_time(sbi, REQ_TIME);
 out:
 	filemap_invalidate_unlock(mapping);
 	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
@@ -4175,6 +4182,7 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	if (ret)
 		f2fs_warn(sbi, "%s: The file might be partially decompressed (errno=%d). Please delete the file.",
 			  __func__, ret);
+	f2fs_update_time(sbi, REQ_TIME);
 out:
 	inode_unlock(inode);
 	file_end_write(filp);
@@ -4254,6 +4262,7 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	if (ret)
 		f2fs_warn(sbi, "%s: The file might be partially compressed (errno=%d). Please delete the file.",
 			  __func__, ret);
+	f2fs_update_time(sbi, REQ_TIME);
 out:
 	inode_unlock(inode);
 	file_end_write(filp);
-- 
1.9.1


