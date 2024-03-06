Return-Path: <linux-kernel+bounces-93297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DA3872DAD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5F61F25FB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF3F14AA0;
	Wed,  6 Mar 2024 03:48:44 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC85E79E4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 03:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696923; cv=none; b=AS0lyCtl9cc+hEt6mggChyNougldWsxRrt2F2nD6MO/Xl697d0bWeGmUylgIwGY1h6BkhMHUj0G1ozU4aK8wf0qRwpOfqUJ+/m2p43dKgbDufbtK7XUlNh3D5PBAck+It+45nRmGJ2gZvAk2ZIYoa/9bnxNRL229g5eJwkMOapI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696923; c=relaxed/simple;
	bh=Yv/wEQyVLh3O8dYuUsQBBEHcdO49+5NW64lg8IZHy9k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z50YRDS5vIvYc8zPV3ZnFN1DpVQ+RHL4GIz4hudzbEtE1o0nq9RN/hqT9Ebft5rf37kKzoouta72bvWleK0TH9pIetBhGnHcxvZcl3F+4nmeOazz5ALCElfrHkJSW8ZYYcTlujpmLH1xexZS+uv4dU/I+A2Tl49FC5zKIn+Pj1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4263lq9f002745;
	Wed, 6 Mar 2024 11:47:52 +0800 (+08)
	(envelope-from Xiuhong.Wang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TqJJp0bvGz2Kt9WL;
	Wed,  6 Mar 2024 11:46:50 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 6 Mar 2024 11:47:49 +0800
From: Xiuhong Wang <xiuhong.wang@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC: <hongyu.jin.cn@gmail.com>, <niuzhiguo84@gmail.com>, <ke.wang@unisoc.com>,
        <xiuhong.wang.cn@gmail.com>
Subject: [PATCH V2 1/2] f2fs: compress: relocate some judgments in f2fs_reserve_compress_blocks
Date: Wed, 6 Mar 2024 11:47:45 +0800
Message-ID: <20240306034746.3722986-1-xiuhong.wang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 4263lq9f002745

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
 fs/f2fs/file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4ca6c693b33a..74c5e48fce22 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3720,9 +3720,6 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	if (ret)
 		return ret;
 
-	if (atomic_read(&F2FS_I(inode)->i_compr_blocks))
-		goto out;
-
 	f2fs_balance_fs(sbi, true);
 
 	inode_lock(inode);
@@ -3732,6 +3729,9 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 		goto unlock_inode;
 	}
 
+	if (atomic_read(&F2FS_I(inode)->i_compr_blocks))
+		goto unlock_inode;
+
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
@@ -3778,7 +3778,6 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	}
 unlock_inode:
 	inode_unlock(inode);
-out:
 	mnt_drop_write_file(filp);
 
 	if (ret >= 0) {
-- 
2.25.1


