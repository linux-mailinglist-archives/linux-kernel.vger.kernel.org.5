Return-Path: <linux-kernel+bounces-114640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9889E888B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D4028E348
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F372A8769;
	Sun, 24 Mar 2024 23:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmivXUW7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558A614E2F2;
	Sun, 24 Mar 2024 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322296; cv=none; b=ES7YE5NrPtDPnQZ14KXW/Dt1/7l3elEY8Al96deFNfHmTIKpCZi1ZBVhuZn20U3Uy0uEIH/ZUeUeyGW2PVdBwIhNNVBLy8a1LJD6+mF4aOjAzaSj75TNqNEs8Jnuepw2GhejAKaeaLCtZfhqZOmMHmO/kBF9wA2FPtvLHQ1YLVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322296; c=relaxed/simple;
	bh=HsyODytWgbtBrRjb5MoBik/nfr4cLaYq1+8vxwDfyEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2TM4MfGDE0/8QT6aZ75dK0Iquwx0/mihHVkqXhzKOVTXhQ9/Rg05SjgN1snPrubJ0gWvRe/cJIFjsYoExrE9KdXVYBFwL+nCvLWB966njdJASPssxpDId55cTPWzBFDVfNX8Gf5o3uX3hFAppBjiWYVrOX+oBLzS7poCds43cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmivXUW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6189EC433F1;
	Sun, 24 Mar 2024 23:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322296;
	bh=HsyODytWgbtBrRjb5MoBik/nfr4cLaYq1+8vxwDfyEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmivXUW7N5DmMHGIqkYK4e5lfUENx2Ddz/Fj3ctN2m/2Ierh6OC4nNOBte8seX67x
	 k8GqSpRmCeVJQrMFTJo03GMVmZ9KLbcZNzI/1EPKccj7Jv480xmy2EQd5fhJLnw9fJ
	 tSirCnbW4uVxgirnj7T0mesd0+IAXbcn8Ig5+1bMMyvqEmOLLRmvzit3PbGVvt42xA
	 hvMDcqtzxMq27gICfn9TIx8ucCazK6ArPRoVa/fsv2pmnkGxtDiOfPpWusB6+5IFvQ
	 3Ypiu4qpCn9L9IKiljv5ytJThkwu7hhY+ImeGqyMtVvPl3kyWQHwKC0/sudN8XNTyH
	 MTHeebWWKENHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiuhong Wang <xiuhong.wang@unisoc.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 379/451] f2fs: compress: relocate some judgments in f2fs_reserve_compress_blocks
Date: Sun, 24 Mar 2024 19:10:55 -0400
Message-ID: <20240324231207.1351418-380-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index c787a3f408ab3..5dbd874ba3d8d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3657,9 +3657,6 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	if (ret)
 		return ret;
 
-	if (atomic_read(&F2FS_I(inode)->i_compr_blocks))
-		goto out;
-
 	f2fs_balance_fs(sbi, true);
 
 	inode_lock(inode);
@@ -3669,6 +3666,9 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 		goto unlock_inode;
 	}
 
+	if (atomic_read(&F2FS_I(inode)->i_compr_blocks))
+		goto unlock_inode;
+
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
@@ -3715,7 +3715,6 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	}
 unlock_inode:
 	inode_unlock(inode);
-out:
 	mnt_drop_write_file(filp);
 
 	if (ret >= 0) {
-- 
2.43.0


