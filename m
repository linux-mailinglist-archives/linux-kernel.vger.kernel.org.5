Return-Path: <linux-kernel+bounces-91918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02563871864
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3E01F21ED6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B974DA08;
	Tue,  5 Mar 2024 08:41:21 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634842E40B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628081; cv=none; b=PZEPUDm1za3V7+9dn6uwY7gNk1O+GsK/TAyjrs0wDQ/Au3XWrFXhx8kEkvV8OQcUtFuBIyUFA8AI93nZ9r/OCTq7bmHZ7IP9lCxmbZOBjFoYQmTA1PbFLkH5EZbWmLckqNWyhqqsqYIFF+rnSx9XvLIR8hb78EOQr04P8eZixIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628081; c=relaxed/simple;
	bh=roqZZS1J6+mS/5WViN0o5iGgh62i3WANCyF/OAM+R2Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q9gAiTCJHZLG+wB7CpQNrMuOIz1rz9DFnJkUniEp94ZXEZ0M4+APKmDUaZ5vkGeA4HXstccL4fGB5g5Z/1X7Hwhc5yMXKhJe0WRdDHmoGzzF9nqk1gh2pzHOep3TkmBNGOhXmKxyK17s/5CTpmpkZe2hWOJK18Kf2SZrmNmLXEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4258eUNs002849;
	Tue, 5 Mar 2024 16:40:30 +0800 (+08)
	(envelope-from Xiuhong.Wang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Tppry0wJnz2KnhJL;
	Tue,  5 Mar 2024 16:39:30 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 5 Mar 2024 16:40:28 +0800
From: Xiuhong Wang <xiuhong.wang@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC: <hongyu.jin.cn@gmail.com>, <niuzhiguo84@gmail.com>, <ke.wang@unisoc.com>,
        <xiuhong.wang.cn@gmail.com>
Subject: [PATCH 1/2] f2fs: compress: relocate some judgments in f2fs_reserve_compress_blocks
Date: Tue, 5 Mar 2024 16:40:22 +0800
Message-ID: <20240305084023.3686070-1-xiuhong.wang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 4258eUNs002849

The following f2fs_io test will get a "0" result instead of -EINVAL,
unisoc # ./f2fs_io compress file
unisoc # ./f2fs_io reserve_cblocks file
 0
it's not reasonable, so the judgement of
atomic_read(&F2FS_I(inode)->i_compr_blocks) should be placed after
the judgement of is_inode_flag_set(inode, FI_COMPRESS_RELEASED).

Fixes: c75488fb4d82 ("f2fs: introduce F2FS_IOC_RESERVE_COMPRESS_BLOCKS")
Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4ca6c693b33a..572d7bd4d161 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3720,18 +3720,18 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	if (ret)
 		return ret;
 
-	if (atomic_read(&F2FS_I(inode)->i_compr_blocks))
-		goto out;
-
 	f2fs_balance_fs(sbi, true);
 
 	inode_lock(inode);
 
 	if (!is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
-		goto unlock_inode;
+		goto out;
 	}
 
+	if (atomic_read(&F2FS_I(inode)->i_compr_blocks))
+		goto out;
+
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
@@ -3776,9 +3776,8 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 		inode_set_ctime_current(inode);
 		f2fs_mark_inode_dirty_sync(inode, true);
 	}
-unlock_inode:
-	inode_unlock(inode);
 out:
+	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 
 	if (ret >= 0) {
-- 
2.25.1


