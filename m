Return-Path: <linux-kernel+bounces-114387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83438888A28
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F0F1F22B56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C7A272985;
	Sun, 24 Mar 2024 23:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsfbYBbc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F7B13DBBD;
	Sun, 24 Mar 2024 23:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321786; cv=none; b=VvbMyXCHKGgF7juEsr3wYJTm+brkYZoScLk/jToqW3qb9cvJw1gJPbtWyJYBFAX+GrBmepC+QrrDb4jNZzy9PkMGWdpRYRrX6ktyqChe0nMAxqe4uQCh3JeOhDhU5Ta4WDTf9Vz96NV3TjM2bOYpkd4I90gPc2Jx4s9K5XkWHtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321786; c=relaxed/simple;
	bh=BwBv29kroLMPRgMD9y1A9FY44mZRKWRTSVBxTVhkABo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+1v3vVMT32EGfFCvwUtT+mh7WdyeecvjTU2Xz+LFKdRBY+4jJOrBABc9it+9IEG0r5Sy+ZNfAr/u4DS/bxUPPfP4tbudjkOuFZaqAx21nvNW3BjAp2rg0hKgzf5L3c3bg142hsT300Yua2PtD9jVsl4wfrsEpbn/tfuMuvHu3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsfbYBbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005F4C433B1;
	Sun, 24 Mar 2024 23:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321785;
	bh=BwBv29kroLMPRgMD9y1A9FY44mZRKWRTSVBxTVhkABo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZsfbYBbcXJzsp0MQxcE1ZtMvdlHavQh+L9w9PWL7WQa5JVvf4UWyLvkT8e8ZEk+Tx
	 WWGKPhLOKmwZq9lvjv5Jh6IuiIqaXnrixSm9kbk+6leR4A6TVf5gkWkJ7PUhDnk3DU
	 EPoFprVMTreGlwaM4LvbK5EYvFJLr3P/Beuv5hOtP06nyoFD0fX1jJcuLzJehj/9ub
	 7gRtTsO/khBJ06dHtvmmhDkfRJyOvmjnesPCR3n5++mn7xko5w2IF3JkvOtCYg5O+n
	 WSxxvasDx3BqLvqHgPjuiVLtR8gayOEXanYeV4C3miPjWXDvmKOm6Gnjv6jjgIRfev
	 h1I9oIfTltRrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 513/638] f2fs: delete obsolete FI_DROP_CACHE
Date: Sun, 24 Mar 2024 18:59:10 -0400
Message-ID: <20240324230116.1348576-514-sashal@kernel.org>
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
index fee4c7130edaa..7bfccb4570a2b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2891,9 +2891,6 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 
 	zero_user_segment(page, offset, PAGE_SIZE);
 write:
-	if (f2fs_is_drop_cache(inode))
-		goto out;
-
 	/* Dentry/quota blocks are controlled by checkpoint */
 	if (S_ISDIR(inode->i_mode) || quota_inode) {
 		/*
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7acbc78b864b4..d64114de07919 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -774,7 +774,6 @@ enum {
 	FI_UPDATE_WRITE,	/* inode has in-place-update data */
 	FI_NEED_IPU,		/* used for ipu per file */
 	FI_ATOMIC_FILE,		/* indicate atomic file */
-	FI_DROP_CACHE,		/* drop dirty page cache */
 	FI_DATA_EXIST,		/* indicate data exists */
 	FI_INLINE_DOTS,		/* indicate inline dot dentries */
 	FI_SKIP_WRITES,		/* should skip data page writeback */
@@ -3271,11 +3270,6 @@ static inline bool f2fs_is_cow_file(struct inode *inode)
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


