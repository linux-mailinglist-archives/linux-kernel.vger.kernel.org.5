Return-Path: <linux-kernel+bounces-23112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CA982A7C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73031289260
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3276139;
	Thu, 11 Jan 2024 06:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJrCKw9O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1D610D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F69EC433F1;
	Thu, 11 Jan 2024 06:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704955452;
	bh=Yt2x1VIugdYVXsOxoBOVxcIohw/X1vEQrQchbterPrg=;
	h=From:To:Cc:Subject:Date:From;
	b=LJrCKw9ObJhB5WOPt9fG/KvCfAARHtMVBKRloB6IGXiC2c8QIuZaZqg3vLPBQcmif
	 l5Oya0vqJMNBwxbp3Aw3+lJUvgKF/Ns1UWShYNEdcBoLlK9s240rn8GpX0m55Axcnj
	 Negd12cyLVdZ587YXF2EpRJea/TU0uM+mQc263D+QYHwNwMVYO7rz4hupiCXThi7CM
	 GneEhT6fiFoA6Ke/1hd8cP9R9Ln6by10eQADUy/rIeSacYkKC9YdQslORNGfzDAn6c
	 ycUFU9kI/svDBz/4S7CKRo0GBOFOgry8oQRnpTUrfxS/BiQ4KnL8QoY67GJuqaAoqe
	 aRUatm4c8/5cw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: compress: fix to cover f2fs_disable_compressed_file() w/ i_sem
Date: Thu, 11 Jan 2024 14:44:06 +0800
Message-Id: <20240111064406.2970205-1-chao@kernel.org>
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

Meanwhile, this patch adds i_size check to restrict compress inode
conversion condition.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 18 ++++++++++++++++--
 fs/f2fs/file.c |  5 ++---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 74729db0b381..e2e0ca45f881 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4406,19 +4406,33 @@ static inline int set_compress_context(struct inode *inode)
 #endif
 }
 
+static inline bool inode_has_data(struct inode *inode)
+{
+	return (S_ISREG(inode->i_mode) &&
+		(F2FS_HAS_BLOCKS(inode) || i_size_read(inode)));
+}
+
 static inline bool f2fs_disable_compressed_file(struct inode *inode)
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
+	if (f2fs_is_mmap_file(inode) || inode_has_data(inode)) {
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
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0e4c871d6aed..5e5df234eb92 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1926,8 +1926,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 
 			f2fs_down_write(&F2FS_I(inode)->i_sem);
 			if (!f2fs_may_compress(inode) ||
-					(S_ISREG(inode->i_mode) &&
-					F2FS_HAS_BLOCKS(inode))) {
+					inode_has_data(inode)) {
 				f2fs_up_write(&F2FS_I(inode)->i_sem);
 				return -EINVAL;
 			}
@@ -4011,7 +4010,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	if (F2FS_HAS_BLOCKS(inode)) {
+	if (inode_has_data(inode)) {
 		ret = -EFBIG;
 		goto out;
 	}
-- 
2.40.1


