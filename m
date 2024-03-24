Return-Path: <linux-kernel+bounces-114392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ABF888A35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D3A1F2857F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69182745CA;
	Sun, 24 Mar 2024 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaKDFUEH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26DE13DBBF;
	Sun, 24 Mar 2024 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321793; cv=none; b=qlGUU5/gK0tqY0kQrHgNot/4kbNZaco9sESLUcaO08xYl9ecn1jKX6M6KGorp1xlBsKPzvGbVCC2O7ltxQq3EBzx3JFKSbDgtpNAzJAyb9HcI8CA6tU/kezIsHuQ3w9auXB1DcLdrEP/u56gTdTBzK7dDipKpz9r7oioexM0tM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321793; c=relaxed/simple;
	bh=hLjy4XuyL+3wLhEljcWF/6T+M7qSWfl8AC6m+cEEF14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGSv+lZG9fbVjLWpczrgaNmXTPk5o9JDNJcf50OP8eLPLLxM9KK4s8bqytoygTUydwqbQEsuqDz9Y+8JjkpB0Ys2tI1jho9wiHMi6yh1X/it91dRDZUuVddeU3e9Et3k5fmz/m+G5t9LXTDVkfIh0adWT7/DqIARbr2rNS1Pl8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaKDFUEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF85AC43399;
	Sun, 24 Mar 2024 23:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321792;
	bh=hLjy4XuyL+3wLhEljcWF/6T+M7qSWfl8AC6m+cEEF14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oaKDFUEHIjH1604zkf2odtLCA+mSuNhzIzYjW2WgXCGJx91qZAW+VozFFatZuwq14
	 Lpp8Ia6gmrVqQmKYmbfs9fd4wOGi6EnR8CsjQssqFMHM8jorC//HWKzh8yO7gp95TX
	 0EtPH7hLBl00QIs17rUC67ofGeZG27A9FN6tcK/rvwzgtyMSapPsjdIhKymukTRghy
	 eUoP/HdGOeWkJkWcbMQtNfEVOzFfS6u64o0I6t1epTdzY+pykCuRMNpQ+3EVR5yNn2
	 4Jp0AU38QdoomB6S3EjDKhsqDeHArhdytIcC9To2X9GFQ1NHbuXQzO8yWWdlcliZ7m
	 HFsJLaUbk9xlA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 520/638] f2fs: compress: fix to cover f2fs_disable_compressed_file() w/ i_sem
Date: Sun, 24 Mar 2024 18:59:17 -0400
Message-ID: <20240324230116.1348576-521-sashal@kernel.org>
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

From: Chao Yu <chao@kernel.org>

[ Upstream commit 2f9420d3a94aeebd92db88f00f4f2f1a3bd3f6cf ]

- f2fs_disable_compressed_file
  - check inode_has_data
					- f2fs_file_mmap
					- mkwrite
					 - f2fs_get_block_locked
					 : update metadata in compressed
					   inode's disk layout
  - fi->i_flags &= ~F2FS_COMPR_FL
  - clear_inode_flag(inode, FI_COMPRESSED_FILE);

we should use i_sem lock to prevent above race case.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2e2792a49de0f..95fa1f7a89707 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4396,15 +4396,24 @@ static inline bool f2fs_disable_compressed_file(struct inode *inode)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
-	if (!f2fs_compressed_file(inode))
+	f2fs_down_write(&F2FS_I(inode)->i_sem);
+
+	if (!f2fs_compressed_file(inode)) {
+		f2fs_up_write(&F2FS_I(inode)->i_sem);
 		return true;
-	if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
+	}
+	if (f2fs_is_mmap_file(inode) ||
+		(S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))) {
+		f2fs_up_write(&F2FS_I(inode)->i_sem);
 		return false;
+	}
 
 	fi->i_flags &= ~F2FS_COMPR_FL;
 	stat_dec_compr_inode(inode);
 	clear_inode_flag(inode, FI_COMPRESSED_FILE);
 	f2fs_mark_inode_dirty_sync(inode, true);
+
+	f2fs_up_write(&F2FS_I(inode)->i_sem);
 	return true;
 }
 
-- 
2.43.0


