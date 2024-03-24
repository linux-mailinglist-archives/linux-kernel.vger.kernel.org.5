Return-Path: <linux-kernel+bounces-113913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592AD888756
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04601F2589F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB3021256B;
	Sun, 24 Mar 2024 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIjfAwVm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF79E149C66;
	Sun, 24 Mar 2024 22:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321007; cv=none; b=RUReXQKM1PaI+saLDNOUGVcqXEQn+ABxa8GRptmLbwPCshMsWaRVWLwb5/KoGeI0XqDRCrV0z7YCzAxyaeBeH3nAxEPB07PhKwukvr8pxqgSMgq0k6HgtN0Y7b74DWebzlO4l6HLpvz6FKefp/mUYsmeIC4E3MXfnmThBvBatik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321007; c=relaxed/simple;
	bh=8GbiNBINI7eELsDDxsTJBY9poV2VqsNUaNayQzLsUY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/y6e6944OOPGre+eGC6NnXe+HI35TUOdw3YaM8S57v7Bq4y/Lj1hqH1/+8REyfjzmqI/ld/2uPjsIKxO5RyeD6xZTDccm8fWqG0sOH3pd2ZUmaQBzrgD0LzPhKu5SjAJyq2jBSbFuZNC55e/ga30sAVX/sqeFe0JNBi5DMqCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIjfAwVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2445FC43399;
	Sun, 24 Mar 2024 22:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321005;
	bh=8GbiNBINI7eELsDDxsTJBY9poV2VqsNUaNayQzLsUY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WIjfAwVmqDJwK6j5DXXAi0IeGrEG+o0iLS0Mx0RyEcgV18DesiSwVdvCI/n/LIJyr
	 90Fc2c/xx86AF2Qy2naARZd4eM2CHAvF7CV8fPJPZHbGUeJt4ywrdIt67GFQMwXt5e
	 qYyXGbzvpk2tREnaMbQQ1GC6QxeLchkdlzs1AYHpz4pu7QP2zSkHJ6DEwxNHIfAFZC
	 pOiFB435RolevDZffRkBu+AG2a3D1NObQNjTZhXcvf2DTFYIsdGVsXiTIrvhZZd6vu
	 cvqlHL5uBiw2n/ogCPmPnN4Tr9afTrgB+W3JngddLZCKLwmHyMMPf56ewRFuhULTLB
	 WvUVtbckYGt0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 568/713] f2fs: compress: fix to cover normal cluster write with cp_rwsem
Date: Sun, 24 Mar 2024 18:44:54 -0400
Message-ID: <20240324224720.1345309-569-sashal@kernel.org>
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

[ Upstream commit fd244524c2cf07b5f4c3fe8abd6a99225c76544b ]

When we overwrite compressed cluster w/ normal cluster, we should
not unlock cp_rwsem during f2fs_write_raw_pages(), otherwise data
will be corrupted if partial blocks were persisted before CP & SPOR,
due to cluster metadata wasn't updated atomically.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c | 27 ++++++++++++++++++---------
 fs/f2fs/data.c     |  3 ++-
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 8453a06630208..94e0b0aa95e9b 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1445,12 +1445,14 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page)
 }
 
 static int f2fs_write_raw_pages(struct compress_ctx *cc,
-					int *submitted,
+					int *submitted_p,
 					struct writeback_control *wbc,
 					enum iostat_type io_type)
 {
 	struct address_space *mapping = cc->inode->i_mapping;
-	int _submitted, compr_blocks, ret, i;
+	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
+	int submitted, compr_blocks, i;
+	int ret = 0;
 
 	compr_blocks = f2fs_compressed_blocks(cc);
 
@@ -1465,6 +1467,10 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 	if (compr_blocks < 0)
 		return compr_blocks;
 
+	/* overwrite compressed cluster w/ normal cluster */
+	if (compr_blocks > 0)
+		f2fs_lock_op(sbi);
+
 	for (i = 0; i < cc->cluster_size; i++) {
 		if (!cc->rpages[i])
 			continue;
@@ -1489,7 +1495,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		if (!clear_page_dirty_for_io(cc->rpages[i]))
 			goto continue_unlock;
 
-		ret = f2fs_write_single_data_page(cc->rpages[i], &_submitted,
+		ret = f2fs_write_single_data_page(cc->rpages[i], &submitted,
 						NULL, NULL, wbc, io_type,
 						compr_blocks, false);
 		if (ret) {
@@ -1497,26 +1503,29 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 				unlock_page(cc->rpages[i]);
 				ret = 0;
 			} else if (ret == -EAGAIN) {
+				ret = 0;
 				/*
 				 * for quota file, just redirty left pages to
 				 * avoid deadlock caused by cluster update race
 				 * from foreground operation.
 				 */
 				if (IS_NOQUOTA(cc->inode))
-					return 0;
-				ret = 0;
+					goto out;
 				f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 				goto retry_write;
 			}
-			return ret;
+			goto out;
 		}
 
-		*submitted += _submitted;
+		*submitted_p += submitted;
 	}
 
-	f2fs_balance_fs(F2FS_M_SB(mapping), true);
+out:
+	if (compr_blocks > 0)
+		f2fs_unlock_op(sbi);
 
-	return 0;
+	f2fs_balance_fs(sbi, true);
+	return ret;
 }
 
 int f2fs_write_multi_pages(struct compress_ctx *cc,
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4b0c2ceb5dbfd..b7845be96f6d4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2851,7 +2851,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 		.encrypted_page = NULL,
 		.submitted = 0,
 		.compr_blocks = compr_blocks,
-		.need_lock = LOCK_RETRY,
+		.need_lock = compr_blocks ? LOCK_DONE : LOCK_RETRY,
 		.post_read = f2fs_post_read_required(inode) ? 1 : 0,
 		.io_type = io_type,
 		.io_wbc = wbc,
@@ -2935,6 +2935,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	if (err == -EAGAIN) {
 		err = f2fs_do_write_data_page(&fio);
 		if (err == -EAGAIN) {
+			f2fs_bug_on(sbi, compr_blocks);
 			fio.need_lock = LOCK_REQ;
 			err = f2fs_do_write_data_page(&fio);
 		}
-- 
2.43.0


