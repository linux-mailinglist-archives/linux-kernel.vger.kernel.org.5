Return-Path: <linux-kernel+bounces-113916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC07888ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5034B1C2AE57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70034212D04;
	Sun, 24 Mar 2024 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7IvdsbC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C194F149C75;
	Sun, 24 Mar 2024 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321009; cv=none; b=RtD/PorYXTbDorHJP3rKw1IwBsv0Bnj6jg6P8KQF71i8YUzjWnK3ukrFC/uN0nGYbWR86Ksa4qZ/R88/G/oru/n0TBjcIz9BrpnCCBU5zPhvj8/AuuM6A/+WvPk2lcO8P7pJs7q2cImIhxnMGlVAmXZH2c84qKc/lXtrZPsVVck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321009; c=relaxed/simple;
	bh=bxdvqjPLjQ41+orf6CfKo1eJE50D1t8Z8962ZNTlcIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2kGTYHr6vXc5JxeWQifZs7Z8T3KKVnyENHH8H8j8G9ZhPnxxdnTng+XVmbsF6Ea+U4v9kmJTYyHtAiEai5mrjyPTZTFKreFrF20hCF79FhtV8S2UAW0fmRV6UV7MURAyMjQF4Y1si7cZDJcwhK7VXpaBSPGZ8wxjeUy5PSIOu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7IvdsbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0732BC433C7;
	Sun, 24 Mar 2024 22:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321008;
	bh=bxdvqjPLjQ41+orf6CfKo1eJE50D1t8Z8962ZNTlcIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N7IvdsbCqk4xFzFi9ST3M1BTxl+jXUUq2qTeJ0GfoGhouo5wfli6wXLR2j+MndB1Y
	 nGHSEQbXIHWERIRcuOEpv375sQJbQpf05ZFi0TA7RUbwT4OTC8uFKSfGelKWpUyl2X
	 dsWCZF0A43/gecKY4/CtWAL5isJ1uEVrEPKwZDj7VMs6GbaOKhRCzsJtryEL+Dz6HO
	 J1iDKpKWvZ/oJ/zUfkTod05H/Kndvr/ZXNZSIgCw/XVel/jED1olHj+YCeCGwFmf59
	 pC5zHIcQ3dxREHGgDQojNY2aK5Z8ZwGXbUhvYKNHV/vAxGO5kbphiNW3CC1I9+FOn1
	 TZX4U/DY0YDDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 571/713] f2fs: delete obsolete FI_DROP_CACHE
Date: Sun, 24 Mar 2024 18:44:57 -0400
Message-ID: <20240324224720.1345309-572-sashal@kernel.org>
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
index ce9dd11c62886..aedb5f6bf75ac 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2894,9 +2894,6 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 
 	zero_user_segment(page, offset, PAGE_SIZE);
 write:
-	if (f2fs_is_drop_cache(inode))
-		goto out;
-
 	/* Dentry/quota blocks are controlled by checkpoint */
 	if (S_ISDIR(inode->i_mode) || quota_inode) {
 		/*
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d94ae53356b52..27dcda5a237e1 100644
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
@@ -3272,11 +3271,6 @@ static inline bool f2fs_is_cow_file(struct inode *inode)
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


