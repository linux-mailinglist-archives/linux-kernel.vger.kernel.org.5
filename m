Return-Path: <linux-kernel+bounces-62643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 247E98523F0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A891C21F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C470560250;
	Tue, 13 Feb 2024 00:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP7HXQZy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF6860249;
	Tue, 13 Feb 2024 00:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783667; cv=none; b=tTUGpDQNlCWPFD35zgYhTShx+FaQBx7iS9UK0NjO6g4fYfVWOGrEWJV+x3C2xtOFJ4oqFHwRR1d5/nCnS4yK35dZA6HciJ1xI7CzYy71HwM9/9Ut6y1BiOXrzhoBMxFs52bhUPFzNyQcPZ6d5sRJnxgTU5DKroUX5W2gyBOBzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783667; c=relaxed/simple;
	bh=5VO5ByHXA+KglQtXhuGq+fTGFxTkBcbxJ2WD86RT6oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxoP/mde+K6zH2Jd/fOnO6UAUS736Idul2frryAMpaIteNecjQ64UHs6EyH9hlD2+rLLk9EVw8v+RGMkSRoh4zD6AZR2EIIObEWi4II0LAZ9lu+p2VWx6gcX70YLK2S9wP103b/9dL7rstzdlHT0ysyHADtqFpQMYuuFxMu/b9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YP7HXQZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3991FC43390;
	Tue, 13 Feb 2024 00:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783666;
	bh=5VO5ByHXA+KglQtXhuGq+fTGFxTkBcbxJ2WD86RT6oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YP7HXQZyoISYaRTE7Db2tSfMq/cOtv9ENcBUiAvqCyeutbH6z9Hvk/XqetPqyJXz6
	 hnSLUg/ozuW1pU9Zrp+nEwvpF8xxGS7RUVSzNEoNBNLW06GQo/JAmXTAUqdZihHzzL
	 ngTm0KM0ZPKMCnJnUh4xMb60ZtOezKI7Yf/Dh53I/easb/6aRlyytuOrppvzUSUjpf
	 2ZMEsGmd8DnyjE3miJerAg2fGXAWqOQYntsstjuOoZisX7NgPzPfrTz9RofCIU6CBt
	 j0caSuf6WoTwORhJL87ivYNWMnGjwhWpNoLK/bO65kiq7RG8TiLUKMFNVTEMEWkTAi
	 Z3svvYdvlGt/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 12/51] fs/ntfs3: ntfs3_forced_shutdown use int instead of bool
Date: Mon, 12 Feb 2024 19:19:49 -0500
Message-ID: <20240213002052.670571-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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
index 414913232eae..67ce2eedc9bd 100644
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
index a313b4ddee16..378e261e23b0 100644
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


