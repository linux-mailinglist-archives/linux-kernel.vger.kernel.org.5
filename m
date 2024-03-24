Return-Path: <linux-kernel+bounces-115543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA57889C41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FF81F36154
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81231249624;
	Mon, 25 Mar 2024 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mqjva9Lg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A78D12C7E5;
	Sun, 24 Mar 2024 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321039; cv=none; b=nx+V+zeQ4/iu0o2e7XYazJdKxPvMltqG+B563upg67nhmSPG/Nr7apIOPI922rLFaADApLMAHfac1uD7cKbYR6q/FsZXAtnDITNGU6x5bQRqfB6as9yffQbyyaoUw2natSDOjJayEuHprutWKhNDr1rWtRFPYryRHYqDJsxwdyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321039; c=relaxed/simple;
	bh=FVbYgoZrft2CYm90iEudwn483lk1Jez6x5T3j0VE+p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/+Mfp1KHg7ClTlt9MPrRCFvR6MmtK7QWmeAeT0XpR/fAk4KyeM34KJh+gR7oFwlt+KbI2sjOJwvjjSKffay/ZArS6qMasgb9Ii4CwHuHil3bVBX20uuJflB4DEVECbB1k3khTTsB1oZOLRFrKIloVxtr8yUhGZlEdWO/wyYbjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mqjva9Lg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FCFC433F1;
	Sun, 24 Mar 2024 22:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321039;
	bh=FVbYgoZrft2CYm90iEudwn483lk1Jez6x5T3j0VE+p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mqjva9LggzTcFtbVsChMDgGJ7u5PMvEnNaMTSukSQY5r43KK47H30eDHJPIe10YMD
	 SeYdEJYkC/93f7oPlGvUJTS5Cqe/N4XH0+I/MfMQA/eMqZHwH9QLbsNjlIwk69kSRi
	 n60xl8yRCONKLFlPAMSQG0e7bTduLPjFtktw1wPPuI9AccmZ/hKmXcMgDYxov9exfE
	 AEol7Krs+wZ5OTxOfwOVXV6Nqo3QWylp20R93Vkncu1EaQ4jbpq3d/kpywvk1YA6qT
	 wV/CCLD5MbmRsNCTf0ttbktv/S6v6vHVTrgw8nvRnaP8864Q/OLVkKaoh/SK32uiES
	 l24RIKgo9CrVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiuhong Wang <xiuhong.wang@unisoc.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 602/713] f2fs: compress: relocate some judgments in f2fs_reserve_compress_blocks
Date: Sun, 24 Mar 2024 18:45:28 -0400
Message-ID: <20240324224720.1345309-603-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index a82dc1af16797..f44c29a6bc24b 100644
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


