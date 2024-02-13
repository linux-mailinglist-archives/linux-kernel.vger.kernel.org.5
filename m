Return-Path: <linux-kernel+bounces-62589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E863385235A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FABD1F20F5E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD9F24A0E;
	Tue, 13 Feb 2024 00:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOI9bAI3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACA42421A;
	Tue, 13 Feb 2024 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783542; cv=none; b=siJk/0RzXQsH0WUlr5u34fFzwzmpXMVkRmJ48CtWpk72jGoDCwG8CKzH6MFtNqduGpvxpx4g3lMsRrTzNAtop9Eh3cLXmNS4irbH9s6Es739f1q9xczMDxKmGwLi1fCi+QhTuunQ50LyACJzN/kFW1iL2L+bqhQ13PWx8Vp2cj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783542; c=relaxed/simple;
	bh=wM6RthC67j/VIipcJ57f07ApXcFHG+uC3P1yVWcGx2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMH8jcnH/rZVja1+jNUYcyA+RDFNhGL9+QX+tN6hJauqsMLZEBxITR7V9/F7iF47lhB0dYx7tEU5caO+jHvDmqWlt7/tuF1gXK3eSM7jcBGLF0WKVAHwwXn1nojDQpa7Gwc3Wk98lfD/5fun5O4L8AkI/fFfIa4ygta0zZpvACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOI9bAI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7193C43399;
	Tue, 13 Feb 2024 00:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783542;
	bh=wM6RthC67j/VIipcJ57f07ApXcFHG+uC3P1yVWcGx2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOI9bAI3zhGEWlpkl6o701loaPBkCzekGCxMZJkayh3Q+qrp+6o4Nob4f6QkygmjF
	 /ZmvvMMxgvXIQB25XP0E0GIqsOFIIxEAf6tf6CSiCUCayELzjxTjjyzf15hUI9x9F2
	 J9oy98VCchkoy9xMq9npUWVttZfwkmww+3SIyyg5jGSmF8HmnXeqRTyYmUaqu/wzpD
	 zyOy3rRaoRFzr/tHPzmtM8TwGHGNmtN1Mh4fub84rERrG1I647ca1YukBEr2DH+o71
	 bhs4ZydJMfPxS4xgKpLODMEbcxaU4andMG07M0mMO4CQl6Jro+tmfYiXPrxXQxSvsl
	 W21c8vEecIpVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 20/58] fs/ntfs3: Prevent generic message "attempt to access beyond end of device"
Date: Mon, 12 Feb 2024 19:17:26 -0500
Message-ID: <20240213001837.668862-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 5ca87d01eba7bdfe9536a157ca33c1455bb8d16c ]

It used in test environment.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fsntfs.c  | 24 ++++++++++++++++++++++++
 fs/ntfs3/ntfs_fs.h | 14 +-------------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 321978019407..ae2ef5c11868 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1007,6 +1007,30 @@ static inline __le32 security_hash(const void *sd, size_t bytes)
 	return cpu_to_le32(hash);
 }
 
+/*
+ * simple wrapper for sb_bread_unmovable.
+ */
+struct buffer_head *ntfs_bread(struct super_block *sb, sector_t block)
+{
+	struct ntfs_sb_info *sbi = sb->s_fs_info;
+	struct buffer_head *bh;
+
+	if (unlikely(block >= sbi->volume.blocks)) {
+		/* prevent generic message "attempt to access beyond end of device" */
+		ntfs_err(sb, "try to read out of volume at offset 0x%llx",
+			 (u64)block << sb->s_blocksize_bits);
+		return NULL;
+	}
+
+	bh = sb_bread_unmovable(sb, block);
+	if (bh)
+		return bh;
+
+	ntfs_err(sb, "failed to read volume at offset 0x%llx",
+		 (u64)block << sb->s_blocksize_bits);
+	return NULL;
+}
+
 int ntfs_sb_read(struct super_block *sb, u64 lbo, size_t bytes, void *buffer)
 {
 	struct block_device *bdev = sb->s_bdev;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 2b54ae94440f..81f7563428ee 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -586,6 +586,7 @@ bool check_index_header(const struct INDEX_HDR *hdr, size_t bytes);
 int log_replay(struct ntfs_inode *ni, bool *initialized);
 
 /* Globals from fsntfs.c */
+struct buffer_head *ntfs_bread(struct super_block *sb, sector_t block);
 bool ntfs_fix_pre_write(struct NTFS_RECORD_HEADER *rhdr, size_t bytes);
 int ntfs_fix_post_read(struct NTFS_RECORD_HEADER *rhdr, size_t bytes,
 		       bool simple);
@@ -1032,19 +1033,6 @@ static inline u64 bytes_to_block(const struct super_block *sb, u64 size)
 	return (size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
 }
 
-static inline struct buffer_head *ntfs_bread(struct super_block *sb,
-					     sector_t block)
-{
-	struct buffer_head *bh = sb_bread_unmovable(sb, block);
-
-	if (bh)
-		return bh;
-
-	ntfs_err(sb, "failed to read volume at offset 0x%llx",
-		 (u64)block << sb->s_blocksize_bits);
-	return NULL;
-}
-
 static inline struct ntfs_inode *ntfs_i(struct inode *inode)
 {
 	return container_of(inode, struct ntfs_inode, vfs_inode);
-- 
2.43.0


