Return-Path: <linux-kernel+bounces-114397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E123888FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC59529010E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A0A27550F;
	Sun, 24 Mar 2024 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLGEQPpF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3919E1F0970;
	Sun, 24 Mar 2024 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321817; cv=none; b=E/dccl57pupRD4bKbgZaTv+MUXvNWbdQNjuJcrULUv62p5CyeyI6WHEkusdGSJaxLnkJssLiRa6/Gyy85Z43Ag9fXIzx5K/NXQjySaoAeWZIdbA7p4yPwHWIq0zupWeGA7J9+43qXyE+JsQErmrjQ7Qcz/3uQAErDUbegQpkJYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321817; c=relaxed/simple;
	bh=K0BLUe0va2BCxmuw9OBC6cSWbWqVc+VU5QSx3+C4C7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpJnCF6O6CnZAUgGnPgmELhe1HIElzxcmmodB8DCRv/ELbTkAgcSxhyWhcHacAjHViGMDYQm4U3jwLKseAMXlpo0F33MdF9nPcCmQVb5n2xT7V5/HC+E+Vlr37nOHBzMK/0aXles/e4tPOwkfGFXjWYGJzU1iiLfuS253YWsc68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLGEQPpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A33C43390;
	Sun, 24 Mar 2024 23:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321816;
	bh=K0BLUe0va2BCxmuw9OBC6cSWbWqVc+VU5QSx3+C4C7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BLGEQPpFLF5whsg3Sw75HWWn6H17F39TQwXJN4mdI5iHLxZwuB4FNn22Nq31fUj83
	 Zv/49TJffgeKIjRVS1XVmjo6fpghPX/JtgwNpkmJX/a+t26W8Ta5FmLR1ZEJldWnlo
	 NNxwb8aPdrgctpcrLxDDIdRmgZCYKmD1Og9olSwdTAKWUv1SNhj/L5pVUNeHK05f4l
	 Jiq+v+4et1KqjPuqvOvq4AYJnDWu9ME6pVCboDDwIHnmdkWXqNerdefMb3X9RmtrdW
	 ZTm5v+PfOc5KrQVNLv3PHscVGR0Z3fNGLx0FU/O5S3VxXhiq4T4xNPzyoYh2hQHmWQ
	 dnTi/yHDdAC4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiuhong Wang <xiuhong.wang@unisoc.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 544/638] f2fs: compress: relocate some judgments in f2fs_reserve_compress_blocks
Date: Sun, 24 Mar 2024 18:59:41 -0400
Message-ID: <20240324230116.1348576-545-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Xiuhong Wang <xiuhong.wang@unisoc.com>

[ Upstream commit b7d797d241c154d73ec5523f87f3b06d4f299da1 ]

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
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2c2ddb0d15836..b156ac6a17390 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3679,9 +3679,6 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	if (ret)
 		return ret;
 
-	if (atomic_read(&F2FS_I(inode)->i_compr_blocks))
-		goto out;
-
 	f2fs_balance_fs(sbi, true);
 
 	inode_lock(inode);
@@ -3691,6 +3688,9 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 		goto unlock_inode;
 	}
 
+	if (atomic_read(&F2FS_I(inode)->i_compr_blocks))
+		goto unlock_inode;
+
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
@@ -3737,7 +3737,6 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	}
 unlock_inode:
 	inode_unlock(inode);
-out:
 	mnt_drop_write_file(filp);
 
 	if (ret >= 0) {
-- 
2.43.0


