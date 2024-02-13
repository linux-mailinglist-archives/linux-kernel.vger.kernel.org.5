Return-Path: <linux-kernel+bounces-62582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C06285233F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34CC41F213E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD031DDE9;
	Tue, 13 Feb 2024 00:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoUOglPN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1C31B7E6;
	Tue, 13 Feb 2024 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783534; cv=none; b=Ih2UQWhcghHKmH2urdVyVVFOqAMxFyXFuWCveIi4kj4I78knDThfmbdAU1VSYF2Ny1+F+s00hdWOfmi9CbOb8xW13LijZ/ujdYMzBIjLBoWhMCeEZEQTbXrp2xZyXL7EMKyeZPbE3m+8sMtTpiQDbFYP3cJLnsmd+72CkuMDfjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783534; c=relaxed/simple;
	bh=274BkG6odmRZp+pj/ydIGfmROZ4E3kRtw2ROe8Tfpfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUcRsoJtu7KwUCpPSLOu0xXGwNQ+bK+SAM5wYZKm6tLzgD/3MAPx/41P5z2I9/DbCPb3+3Yhl+tisCsS3C4xcLBaGBl9OOYZ9YwA7x2Hgu1PG2AiCdw+IfuIXmClEg4aIyjkjl9zkE9Z7NjS6wJtKNVhxqFGCinXavC1xAYa/8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoUOglPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927A6C433C7;
	Tue, 13 Feb 2024 00:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783534;
	bh=274BkG6odmRZp+pj/ydIGfmROZ4E3kRtw2ROe8Tfpfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SoUOglPNiUyZUdIC7VmkEt/Ai9VqglwP3ok+bDCc8ZKCF/3jIJMwlDOmP20BJzNCu
	 87DXYhMV4PmgI31SCAnuUk2fmYMff354EEMrB+g6YFk8lZ0elhr14Eh+3Kf9Qt46T6
	 xkwl09igwbVGS6BDCCub11sTVmKRH1h4d42GZon6TjvIm4HBdxRn0K9ItR09sUyfRK
	 RkNwE2WFCQ9tJbGj967bvbe7/FS4Ug2YnIpDjw6Hnp9CtL+cYU++bOaxaWakDa9TRn
	 Y/wcJUAqAiqgXDEA675ACoeMGp8IinvRkS6zhNO33SK1OmlrlFmsty788+FPuu5EQl
	 wNJM54axhi9pQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 13/58] fs/ntfs3: ntfs3_forced_shutdown use int instead of bool
Date: Mon, 12 Feb 2024 19:17:19 -0500
Message-ID: <20240213001837.668862-13-sashal@kernel.org>
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

[ Upstream commit 97ec56d390a3a0077b36cb38627f671c72dddce6 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fsntfs.c  | 3 ++-
 fs/ntfs3/ntfs_fs.h | 6 +++---
 fs/ntfs3/super.c   | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index fbfe21dbb425..350461d8cece 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -853,7 +853,8 @@ void ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
 	/*
 	 * sb can be NULL here. In this case sbi->flags should be 0 too.
 	 */
-	if (!sb || !(sbi->flags & NTFS_FLAGS_MFTMIRR))
+	if (!sb || !(sbi->flags & NTFS_FLAGS_MFTMIRR) ||
+	    unlikely(ntfs3_forced_shutdown(sb)))
 		return;
 
 	blocksize = sb->s_blocksize;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index d40bc7669ae5..7510875efef6 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -62,7 +62,7 @@ enum utf16_endian;
 /* sbi->flags */
 #define NTFS_FLAGS_NODISCARD		0x00000001
 /* ntfs in shutdown state. */
-#define NTFS_FLAGS_SHUTDOWN		0x00000002
+#define NTFS_FLAGS_SHUTDOWN_BIT		0x00000002  /* == 4*/
 /* Set when LogFile is replaying. */
 #define NTFS_FLAGS_LOG_REPLAYING	0x00000008
 /* Set when we changed first MFT's which copy must be updated in $MftMirr. */
@@ -1001,9 +1001,9 @@ static inline struct ntfs_sb_info *ntfs_sb(struct super_block *sb)
 	return sb->s_fs_info;
 }
 
-static inline bool ntfs3_forced_shutdown(struct super_block *sb)
+static inline int ntfs3_forced_shutdown(struct super_block *sb)
 {
-	return test_bit(NTFS_FLAGS_SHUTDOWN, &ntfs_sb(sb)->flags);
+	return test_bit(NTFS_FLAGS_SHUTDOWN_BIT, &ntfs_sb(sb)->flags);
 }
 
 /*
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index af8521a6ed95..65ef4b57411f 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -719,7 +719,7 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
  */
 static void ntfs_shutdown(struct super_block *sb)
 {
-	set_bit(NTFS_FLAGS_SHUTDOWN, &ntfs_sb(sb)->flags);
+	set_bit(NTFS_FLAGS_SHUTDOWN_BIT, &ntfs_sb(sb)->flags);
 }
 
 /*
-- 
2.43.0


