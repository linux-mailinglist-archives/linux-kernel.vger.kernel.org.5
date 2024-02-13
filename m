Return-Path: <linux-kernel+bounces-62721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F188524CA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328481F24431
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DD0126F04;
	Tue, 13 Feb 2024 00:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWuuOZQS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DE6126F1D;
	Tue, 13 Feb 2024 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783823; cv=none; b=eI2bmJnAbg0sFDHtSN3SvRjs26lIolmCNz0UE8JLbBuS9w6JWUvXbSqeEN7vHdR2AjTBwaB53N7xhfqx1uD9VLkbIWb94MbHVyWcb08RkhziSIeGhKRfNY7W2maYC2gDBwZxGkO/GwRRmGnoFnlkTkDo4lZoYQGZu2J35hcofpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783823; c=relaxed/simple;
	bh=+BAboRruDbRfIGbr8AC6bRPI1FwXzSOLkJH7UsR54A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUrz15FbwdhVwoXzqwGmcE+Jz3Hn/fQHL9F0HQCWEj2nSFtc+VfCC4P8ux+L+xxvxuyrHwlx5rUZ0oZ+FvWoSe5750TVDVdO+Taoe7C5N3TanYqCRb/LPZc54KB5QwecuFJGv2Ptt6Qs7KDAImLMtRKTOEZeVxI4dyyudWgLRbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWuuOZQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D5CC433C7;
	Tue, 13 Feb 2024 00:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783822;
	bh=+BAboRruDbRfIGbr8AC6bRPI1FwXzSOLkJH7UsR54A8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OWuuOZQSE+SvazzgiQzb1iM5efF4U3gUSe5hp35SgO9mdslwAk39HeMBcX7Hzx7W/
	 e1IdgK4AzezvP2d9dWddiZHVtsnamGtkrYI11x8Jaxhy6QiAvpsik5RbuspkVf+kxO
	 DIPZFxM7+uJPNDifrzqnfr7QYwS0Px0EAMK0V3cGA4HYjH/OhCXiHfZBNmInBIPb+k
	 CMDhghamUklGcdkJhAr5/P/RTTJwC5Uj6+ON/hi+hTn2zWkG720Fe3VKaaTGVu4zV2
	 62zICAx8Ay/FTeAttIHbS5DdysKg03I1h9LkwENiSyEWKzTRYgKD8qgjhcCf3XnDwL
	 N0z1CxP4lxdtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 09/22] fs/ntfs3: Prevent generic message "attempt to access beyond end of device"
Date: Mon, 12 Feb 2024 19:23:11 -0500
Message-ID: <20240213002331.672583-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002331.672583-1-sashal@kernel.org>
References: <20240213002331.672583-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index 4413f6da68e6..ff6f1f462b21 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -981,6 +981,30 @@ static inline __le32 security_hash(const void *sd, size_t bytes)
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
index 713b7e3888bc..f618d63ce797 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -581,6 +581,7 @@ bool check_index_header(const struct INDEX_HDR *hdr, size_t bytes);
 int log_replay(struct ntfs_inode *ni, bool *initialized);
 
 /* Globals from fsntfs.c */
+struct buffer_head *ntfs_bread(struct super_block *sb, sector_t block);
 bool ntfs_fix_pre_write(struct NTFS_RECORD_HEADER *rhdr, size_t bytes);
 int ntfs_fix_post_read(struct NTFS_RECORD_HEADER *rhdr, size_t bytes,
 		       bool simple);
@@ -1011,19 +1012,6 @@ static inline u64 bytes_to_block(const struct super_block *sb, u64 size)
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


