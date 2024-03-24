Return-Path: <linux-kernel+bounces-114613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52957889086
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8463F1C2C519
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3A613CAA0;
	Sun, 24 Mar 2024 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eG0bLM+C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8A323319B;
	Sun, 24 Mar 2024 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322272; cv=none; b=jstUOzOedrVz6d1deC/BTfYNxbREKL3tZ6wu8RVT1k+9AR1dgH0OusJIRNN1tPnNRMMJYNW69/ikl37LJ+sZFx/5VlwAmRgxSzUEGqZr2P716es+mOmE4xO1eWv2kbCPkigEwzNqBEL4j8ro/BFuzLzv2xoKH+LZvp+1WYi5f8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322272; c=relaxed/simple;
	bh=JvuSUMf6w3gYe64JdJhUsZYbOFq0hd3lZID0W4x6fAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OO3Bp/sI48sy0v0kxt38UEhf1VA6VQ3ouSJQfNa6Jb3cSN0Ausl5x8zL8nzcWm4kPoHhL4vRDnzD0QwrhrdJsvVzmhaL2wh4RiKRgmz5lclCJweuO1j2Ox0N27zNwAUq8VTUrAAiysbuA9nf4qNP+yR/T4p0gSQ5fQg2sTx5N7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eG0bLM+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F185DC43390;
	Sun, 24 Mar 2024 23:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322271;
	bh=JvuSUMf6w3gYe64JdJhUsZYbOFq0hd3lZID0W4x6fAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eG0bLM+CEpZGfR50pIEG2jq3FSlcBRKZodSG/b34VTBwYxlsk3mHNF0Wn7RSea4iU
	 MAphhO8xolPAvWuDdCJ1gXMC72806OIHQGgQZSOJA9o1ddn8vKOFcfIZTrKMsOPsCL
	 vKmkum2emIYtwZI82m8OxdcuAXjxNRFiNWFLWkhMyd1AQ4NfwcxbYtMqzes1MhX0Ke
	 w2X7YxIK4O20esHRl+P47YkNFOqHelbfi2oS2i3Gl3r8AjJkVJHl2g5nIBWxOz5Dk3
	 7gYStMLA/iKIQ9T0MsrQY8xZXGl0lpinX9uDG/DOydLYCT4a/1PPS4dEgd43+cx/SO
	 SfNwLuIOz4dxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 354/451] f2fs: compress: fix to cover normal cluster write with cp_rwsem
Date: Sun, 24 Mar 2024 19:10:30 -0400
Message-ID: <20240324231207.1351418-355-sashal@kernel.org>
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
index 459bf10f297a2..553950962842a 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1462,12 +1462,14 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page)
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
 
@@ -1482,6 +1484,10 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 	if (compr_blocks < 0)
 		return compr_blocks;
 
+	/* overwrite compressed cluster w/ normal cluster */
+	if (compr_blocks > 0)
+		f2fs_lock_op(sbi);
+
 	for (i = 0; i < cc->cluster_size; i++) {
 		if (!cc->rpages[i])
 			continue;
@@ -1506,7 +1512,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		if (!clear_page_dirty_for_io(cc->rpages[i]))
 			goto continue_unlock;
 
-		ret = f2fs_write_single_data_page(cc->rpages[i], &_submitted,
+		ret = f2fs_write_single_data_page(cc->rpages[i], &submitted,
 						NULL, NULL, wbc, io_type,
 						compr_blocks, false);
 		if (ret) {
@@ -1514,26 +1520,29 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
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
index 6f649a60859fc..3f0ba71451c27 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2779,7 +2779,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 		.encrypted_page = NULL,
 		.submitted = 0,
 		.compr_blocks = compr_blocks,
-		.need_lock = LOCK_RETRY,
+		.need_lock = compr_blocks ? LOCK_DONE : LOCK_RETRY,
 		.post_read = f2fs_post_read_required(inode) ? 1 : 0,
 		.io_type = io_type,
 		.io_wbc = wbc,
@@ -2859,6 +2859,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	if (err == -EAGAIN) {
 		err = f2fs_do_write_data_page(&fio);
 		if (err == -EAGAIN) {
+			f2fs_bug_on(sbi, compr_blocks);
 			fio.need_lock = LOCK_REQ;
 			err = f2fs_do_write_data_page(&fio);
 		}
-- 
2.43.0


