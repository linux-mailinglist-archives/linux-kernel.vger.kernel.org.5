Return-Path: <linux-kernel+bounces-114618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1604C888B54
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BB91C25368
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22BF2A3577;
	Sun, 24 Mar 2024 23:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgRzKZfs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F7D233CD0;
	Sun, 24 Mar 2024 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322276; cv=none; b=b4s666/Gaa+zVn9/RXmCRmuS6rIlW4IvukyHyL2toNSwyXkBoe3B/IFAhchHBeHTjAHqaNQFqAj57DG2BMiq669zlhq+qow/v6Rw47Ox3UjJpw7hpzhq4hQ3R1RkbTJgkGJ9O0tvIizjcnNjc6nFudB0M86mv2O59aPvSyGufoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322276; c=relaxed/simple;
	bh=xSE7ApSkCIxrM0J9QpUOLMYUiAaRl8eiMeWem8yhqGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmQ4KlV0uy80/Qe2ES8CEcN1e2ig9lvYSygvOavBbTTBbMU4owDeiyAP+f1iU6/gOHHF1Znb/AIebbUyo7sXUS5bLPmhc74eyFftVgPBWYzCs1YpvW6avpsBM+x/A3CgW98EuttAMMRROQV6kRF06ba3ofXVvueud/2y9dWHRAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgRzKZfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A78C433A6;
	Sun, 24 Mar 2024 23:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322275;
	bh=xSE7ApSkCIxrM0J9QpUOLMYUiAaRl8eiMeWem8yhqGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FgRzKZfssFnjLWS/Fe7U4M/gu8wrBsTNjxKyzcr/PSAfH6KLjRX4ZVyMcxvxVnUQY
	 xB1E4Kdto6IU4KOFfsw+lTeFwWfihFdA+eka2IJTDztRyiBBYcJns0EnIbg1uCzurA
	 IQ0JetmwKNxhj4Zy1mUKxm+hufb6AE8A+ZjjHz00bUnXIUaN+IlZBbHFzST/sgeHQr
	 hgEg8SkoYCMkteQTwPVtx0lgOAl0ItrSZQCdaOrlC3keO9BFLnUwA+RZauZYU6vT8D
	 iysOnwbGwhXAUeNenDaQBjLq8ZqlcVLhU/v6Fqpt436P3fjuftnnkGp+gEEvvymrpX
	 8Zs8HBCt04PiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 358/451] f2fs: delete obsolete FI_DROP_CACHE
Date: Sun, 24 Mar 2024 19:10:34 -0400
Message-ID: <20240324231207.1351418-359-sashal@kernel.org>
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

From: Chao Yu <chao@kernel.org>

[ Upstream commit bb6e1c8fa5b9b95bbb8e39b6105f8f6550e070fc ]

FI_DROP_CACHE was introduced in commit 1e84371ffeef ("f2fs: change
atomic and volatile write policies") for volatile write feature,
after commit 7bc155fec5b3 ("f2fs: kill volatile write support"),
we won't support volatile write, let's delete related codes.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 54607494875e ("f2fs: compress: fix to avoid inconsistence bewteen i_blocks and dnode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 3 ---
 fs/f2fs/f2fs.h | 6 ------
 2 files changed, 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 95e737fc75ef0..a5d0d0b892875 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2817,9 +2817,6 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 
 	zero_user_segment(page, offset, PAGE_SIZE);
 write:
-	if (f2fs_is_drop_cache(inode))
-		goto out;
-
 	/* Dentry/quota blocks are controlled by checkpoint */
 	if (S_ISDIR(inode->i_mode) || quota_inode) {
 		/*
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2364b6f7500b2..0f7193a0ab422 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -764,7 +764,6 @@ enum {
 	FI_UPDATE_WRITE,	/* inode has in-place-update data */
 	FI_NEED_IPU,		/* used for ipu per file */
 	FI_ATOMIC_FILE,		/* indicate atomic file */
-	FI_DROP_CACHE,		/* drop dirty page cache */
 	FI_DATA_EXIST,		/* indicate data exists */
 	FI_INLINE_DOTS,		/* indicate inline dot dentries */
 	FI_SKIP_WRITES,		/* should skip data page writeback */
@@ -3247,11 +3246,6 @@ static inline bool f2fs_is_cow_file(struct inode *inode)
 	return is_inode_flag_set(inode, FI_COW_FILE);
 }
 
-static inline bool f2fs_is_drop_cache(struct inode *inode)
-{
-	return is_inode_flag_set(inode, FI_DROP_CACHE);
-}
-
 static inline void *inline_data_addr(struct inode *inode, struct page *page)
 {
 	struct f2fs_inode *ri = F2FS_INODE(page);
-- 
2.43.0


