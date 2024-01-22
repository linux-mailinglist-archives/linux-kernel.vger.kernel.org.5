Return-Path: <linux-kernel+bounces-32275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB75835951
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B12A1C214F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0561FB3;
	Mon, 22 Jan 2024 02:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kn7lVm1f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2591C27
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705890203; cv=none; b=A6k9US/k/IRfh0aY5sweuCEyJGKpriT1Za1b3tmUQ/pf9Mk4ddBZV55KoH0XuwfHeppK4V593i1z+mF2cQV42eyvaNklejEyPAgW0q61IIAtcLCEbYBPET0eBCIjVmjRJvQ8B2NVFANTIWxu933QJuLV35SF5VkfM5us1K7JX6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705890203; c=relaxed/simple;
	bh=z6sXpXgjIIXF4ORGPRhbVLiWL3zHNdnmLT0QW9aWDvc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PKqZFgurY5og4nTeo3IGdd0LVUZyuxa9qKQnb5weDCt7XD+zpENhyIFMKAhzsqZKfA0EAh2R8mmpj6zPOKzPG1AZiIaQqresx3myhnzz+HZU7nkKqGIp6eHpMo4XTw96OFh8gBNyKSFY0jPowcXdW3189jKRbp7fosJPhi1bjhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kn7lVm1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E9AC433F1;
	Mon, 22 Jan 2024 02:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705890203;
	bh=z6sXpXgjIIXF4ORGPRhbVLiWL3zHNdnmLT0QW9aWDvc=;
	h=From:To:Cc:Subject:Date:From;
	b=kn7lVm1fUxlPx66h/CBV2QAlk0VPF75oaJwp5oc0y7G2bZEJ+3Z9eOc0IBHaqhlkW
	 af8ID2Zv7bBqCI2vcOLinzvqe8H7/9YuCSNE2fX/iU7kJd+HNPb3dc3YtqD+lfbXZY
	 Lr6RQHe1JtD9SOMmZ1+Ep1I9GvyX+CMx29upvdpk2qI71DbBsDdpjpmss8+KiuKSbM
	 wGZ8plr4kU758CR3W67LayaxEcbwN5VL02FIf0B2TqhN7mmd2eSF1rioHutaHkcCjK
	 BWU1GmfewrENNlQo2T4APOWn43pXxKiRsOnoJ76joAJLML2zlMp/7GVxF3D07ZlVIb
	 /BLPld6QnqGFg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: compress: fix to cover f2fs_disable_compressed_file() w/ i_sem
Date: Mon, 22 Jan 2024 10:23:13 +0800
Message-Id: <20240122022313.3054810-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
v2:
- remove unneeded i_size check pointed out by Jaegeuk.
 fs/f2fs/f2fs.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4481f68d6418..c6655fbdeb5e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4409,15 +4409,24 @@ static inline bool f2fs_disable_compressed_file(struct inode *inode)
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
2.40.1


