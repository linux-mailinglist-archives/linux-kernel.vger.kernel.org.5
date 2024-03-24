Return-Path: <linux-kernel+bounces-113924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9F0888764
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ADAFB233FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCA5214878;
	Sun, 24 Mar 2024 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khwCTsze"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05631EE6A3;
	Sun, 24 Mar 2024 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321017; cv=none; b=OEjsmSrHJ+rkFrE+mu9jEIEGntvO0xT0rZ8D16tE2gsHqDSfRZAnGEcixaopEt2/90n8pUasxsHKOma+j+YjB2BduMEFOOedjQYN1yHVpP9NhvpdEKV5QX4gyta1IJPDidxwsGc2aLsZdmdY763bDTqprvgnw953I82w3M9iP60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321017; c=relaxed/simple;
	bh=HmnWQ2CBxpRenxd0sXt/TBhymVqI/baFXQVZaTfT7OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rH21Ug8YnSk3MZ6f43QkYL14QPr0aEsUu/pCL4f07TU7NWvwTBvarbX/Y5K4AlaM6Dy6B2pSHc7YiHEsk496qkbIlfqU+X/qveZ23vvwtVZWJD9tDH5MCQkGP+f8n/YgL0pWaP3je8S5hPjyrK4WUziipCCqe/KB2SWojtazdGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khwCTsze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EBDC433C7;
	Sun, 24 Mar 2024 22:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321015;
	bh=HmnWQ2CBxpRenxd0sXt/TBhymVqI/baFXQVZaTfT7OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=khwCTszeO5ta/8CNqBVgQEVhHbhO1amUeQdKhS0swub9KtL5mZoMh1mzfjrhq9qnf
	 A5LzA4SfHGaf33c9wWJ11bHdMFO5KJtEYFva8/VAiF+eQ0FoUvmFU6sslU5ZLIlCA/
	 54qBkbe/KcvYs1ahfEXpHLRN1SPL19wrK31mLvG8XQ70LyMDrA71nvthzm+J0UFGm0
	 1Vgnk7M8T46RN9OqKXANhVH4ixAdbudgP/BJMxkTh0l7eiNtVmVdA419XqPqDV8UXD
	 +WXLvCB913YxXXKfbo7X75o4+/pY4xi3HZXtHwlS/1XHJQ8+GcAKt3s4etyw+ruJzk
	 sg7tKf6evlm0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 578/713] f2fs: compress: fix to cover f2fs_disable_compressed_file() w/ i_sem
Date: Sun, 24 Mar 2024 18:45:04 -0400
Message-ID: <20240324224720.1345309-579-sashal@kernel.org>
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
index 2401d91ebc25a..3bd67d4fcb1d4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4399,15 +4399,24 @@ static inline bool f2fs_disable_compressed_file(struct inode *inode)
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


