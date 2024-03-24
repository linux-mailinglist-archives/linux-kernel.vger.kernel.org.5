Return-Path: <linux-kernel+bounces-113457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E1E88847C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF761F242E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C381AF1AA;
	Sun, 24 Mar 2024 22:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eq/gKX7X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE1C1B0602;
	Sun, 24 Mar 2024 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320258; cv=none; b=XCf88Z2uJvFmC39MFGizZhhBrKH5i0fP92mn1lgSmJ0cA1l1V+lfTCStdCZAVR4tfnMXxxgztG4d3xoVttRhOcnrm4ZI7VOl3ftsyf9HjVyZDiLVoQYiruuQoyH+ul2UFDPIOutsJKQBPbJuGcrqugy5poHBmSbcEH6fO4E9M0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320258; c=relaxed/simple;
	bh=KI8qSZZy6SggNUMA1yvSb34YeToixqBDBxB761i2aM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7f7NbwmKnEQqO53NSL5pg3WDYCmm+6y78Hx181QLIVFy7Y7a+PDGFcXnjTkLuBDSQc0Dy144FWm/iDxV9Qzrh+jJ10+7TJV2V0mCMjIGZUTNlysfX5rhCYZ5WZUYGcBDyIf7JN5SywZujSgAtkHpA9+nekuLTGlXNk+p55g/mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eq/gKX7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFC9C433A6;
	Sun, 24 Mar 2024 22:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320258;
	bh=KI8qSZZy6SggNUMA1yvSb34YeToixqBDBxB761i2aM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eq/gKX7X5NXZp+BnAlv45YkAx2QNbqQ+5Y7iMN2T1yxxkWWBpQe1o1QZ1Txy/rki3
	 u73bNTPifdwBCPWUEMJGkTsrncOzbIzVE22OgEWair2kNtFN54spaJnpJG2hGfVmmL
	 ccIpUgSjCyC2E5zkN6HRRZ9jxjKf/+bTjMmPVy6avciPfXvAM4pS83cifyK6+55RND
	 xokNNVW3LO153J8bC5vZb1mwOoubQvwF1L5yC6WKB2eUHXJgYozy4obAY1OFHT5R/3
	 REs816+eQDOoeWmO1ARTW9thc895eNWv29x2cfV4vqqaqnzHXmmSn+eer3ZnAmM2Mc
	 qYScVLWMv92hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 566/715] f2fs: compress: fix to cover f2fs_disable_compressed_file() w/ i_sem
Date: Sun, 24 Mar 2024 18:32:25 -0400
Message-ID: <20240324223455.1342824-567-sashal@kernel.org>
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
index e4e249dd4c712..03c0d2e996fff 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4406,15 +4406,24 @@ static inline bool f2fs_disable_compressed_file(struct inode *inode)
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


