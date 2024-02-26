Return-Path: <linux-kernel+bounces-80377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF87D866789
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE771F217CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549C9D2FA;
	Mon, 26 Feb 2024 01:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz8sjKAE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B8F4C91
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708911140; cv=none; b=DdfKZFRpIvm++ivQYVy6OsXsfOqSgwrL3Z4Cz5FetwKyNyywZ9cEW2xIcH2DHDY3Vrgwoasxab7Khnp4+TLbHK4x48iA1l7uN5nfSW7cOvtW1Wt5GZG8Mpmb48gEYprwfIlJOdwyYeOcYRyqRuw69ia4QtbvJXJumaeWgoqIJVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708911140; c=relaxed/simple;
	bh=JC2tKZVI/N9NKXwRhcw37ItMYVdb46EEQNkTvwv2vU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p9EhI/S2+KAhhiyBYUm4SSMDD6ZQBg/pPfigi8n4AkZhkUc/ucm+QEVBxPzWr8wK7pcj37IJ55qMbVZ4966ImIDBd4qKIOu9BlYKeaGW0sdlMuEZitQ/rbrmtKj43EQWJtWd08OtCpFqzEkyF6BpAMULku6Z8rIoFjWyNMqxx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz8sjKAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E958C433C7;
	Mon, 26 Feb 2024 01:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708911140;
	bh=JC2tKZVI/N9NKXwRhcw37ItMYVdb46EEQNkTvwv2vU0=;
	h=From:To:Cc:Subject:Date:From;
	b=Sz8sjKAET+isPNL/4a4fFdhhgcMkhiNGh9nDOKbXa6M+bIqIqS/gJVLGUZt6kfd7U
	 SM6tD2+qQrobZhW2CxqSvTkKSogfCArlGO5sLq10ZoNJ4ftQcU3PHCNZkcdMUjQRLT
	 Rt5u70cfST75BOH4CAKDNkOdDeWq35f8VPOcUS8UMFQoi4eI+Xto7tlwLPA7XaS9qF
	 qrt/yiu4dFYNzVNu1+2LcnQ7WFDzX1zUzcnE76vkZV4XPaNvyV1A9Ki0dJZqU0Bvzh
	 hJKKTjm9B3Ol/u/2KtJPswTuPIFu6dGqdsdIO7zNpPTumy2iHJ7pj+zQVSZvE0tL81
	 LogR/jchMm3Wg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/4] f2fs: fix blkofs_end correctly in f2fs_migrate_blocks()
Date: Mon, 26 Feb 2024 09:32:05 +0800
Message-Id: <20240226013208.2389246-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In f2fs_migrate_blocks(), when traversing blocks in last section,
blkofs_end should be (start_blk + blkcnt - 1) % blk_per_sec, fix it.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c21b92f18463..0c728e82d936 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3841,13 +3841,14 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	unsigned int blkofs;
 	unsigned int blk_per_sec = BLKS_PER_SEC(sbi);
+	unsigned int end_blk = start_blk + blkcnt - 1;
 	unsigned int secidx = start_blk / blk_per_sec;
 	unsigned int end_sec;
 	int ret = 0;
 
 	if (!blkcnt)
 		return 0;
-	end_sec = secidx + (blkcnt - 1) / blk_per_sec;
+	end_sec = end_blk / blk_per_sec;
 
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
@@ -3857,7 +3858,7 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 
 	for (; secidx <= end_sec; secidx++) {
 		unsigned int blkofs_end = secidx == end_sec ?
-			(blkcnt - 1) % blk_per_sec : blk_per_sec - 1;
+				end_blk % blk_per_sec : blk_per_sec - 1;
 
 		f2fs_down_write(&sbi->pin_sem);
 
-- 
2.40.1


