Return-Path: <linux-kernel+bounces-113486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AFF8884AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F027A284B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED431B6FD5;
	Sun, 24 Mar 2024 22:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrgX7q+i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04AC1B6FB7;
	Sun, 24 Mar 2024 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320287; cv=none; b=gqYaMm7E/5mw9aznYWTWNe2o5XhxWUwQNW4grxFdW5n8FMHEOCwD/AXqwrg3QRvjjyRmr8HTYuLYVCbxU0JrqDtWgzkYrDFVC/xcUZ8KJw3jyhRwiWd6UR9Uttb//maiVYqCHpfL9y4+t9sUWg86fQjh/QLBx0ZD7qlZ4cPWaa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320287; c=relaxed/simple;
	bh=GFe3nnLiP7oeuT5qH8DV8w75PBL0nMb13K/GArbZWV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfvvIoptmqbnafzfmEYkQ+YYIFDh9EV2/0uFB1G9BVkk0LYvIRGHt8aoFU+gp+hYG2WeMNfZ3OozSgonfRj3cD8Jrh2MyGvXpWAIxBaNJ7lq0vlLJglAkMEyM9H7rdqTen8+edE54s6U7kEffk4GmKohGDNBQsTlJfm1WSyXbDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrgX7q+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DB3C433B1;
	Sun, 24 Mar 2024 22:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320287;
	bh=GFe3nnLiP7oeuT5qH8DV8w75PBL0nMb13K/GArbZWV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YrgX7q+iiNUeRTqb6S3Ipk/FM33Yaejd76UTm1gOlO5GZd2vwg40MFjuW1YnJQ8Lf
	 H5tRYgw+08DRls+t2cBzPOllOttlirE4kGgNMBUW9WUGPp/yanA8I/KhPsRha+YKY5
	 aj/hw9/bdcF9oSP6rOlt0lwxmLs7eOo2mD/5q/SD0hY8uwIscz+sUMkLlRcQPWwPIB
	 kueUd+jrL7xLLZfKzFK94ZjNgJJ1575le4cAsHCzILkneI0ldaTAoBUyPqBhW56OCT
	 tEkAZXpELDsGB0ZgbdkKmXZ2YXbHLQb86ESz4NFFBfE9Z+/KTUesLa/qfOqmA9DNxZ
	 TNdNtfC9Vjfjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiuhong Wang <xiuhong.wang@unisoc.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 595/715] f2fs: compress: relocate some judgments in f2fs_reserve_compress_blocks
Date: Sun, 24 Mar 2024 18:32:54 -0400
Message-ID: <20240324223455.1342824-596-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index caab20648b951..3da9a298c50a7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3684,9 +3684,6 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	if (ret)
 		return ret;
 
-	if (atomic_read(&F2FS_I(inode)->i_compr_blocks))
-		goto out;
-
 	f2fs_balance_fs(sbi, true);
 
 	inode_lock(inode);
@@ -3696,6 +3693,9 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 		goto unlock_inode;
 	}
 
+	if (atomic_read(&F2FS_I(inode)->i_compr_blocks))
+		goto unlock_inode;
+
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
@@ -3742,7 +3742,6 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	}
 unlock_inode:
 	inode_unlock(inode);
-out:
 	mnt_drop_write_file(filp);
 
 	if (ret >= 0) {
-- 
2.43.0


