Return-Path: <linux-kernel+bounces-113451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BAA888473
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC24FB24094
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69AD1AF184;
	Sun, 24 Mar 2024 22:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ1PzXb9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1101AE8D6;
	Sun, 24 Mar 2024 22:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320253; cv=none; b=EGzgBFQauPuKR8mn5sqcMe/hOGOcPWcWMqnagK9+cdidFwVhCHgH6eiMhAwY7dAvlk6UHlpZ3DaNmMsNVxI9gfFASYgPzPJCyZlMF79CMg1QhjwxRABB6ETOa3CugQeoFLdsq6pnV3P0+e8nhdRGnhHuhgZCh5lGaP3i1EPnjJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320253; c=relaxed/simple;
	bh=977aFKEZI/79Z6vD1txCZeAm2HBBiJ349Wa6DSmk5d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CX7DKCDTOJXbwd+k25CdAm7dXi56kg6c0fOD8PFDhAA3ylsE4Cde5ILD1KjsY1pFWwMd905NXJj4lypMXq1+97+DEX3Raq+q6KBLnnwdY/GyQ43X8sq1H5vYLSkuFHt+/39rTTutxue35x1h7uYizDc/UxHCcehwGnwzzNOTWFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ1PzXb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2282AC43394;
	Sun, 24 Mar 2024 22:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320252;
	bh=977aFKEZI/79Z6vD1txCZeAm2HBBiJ349Wa6DSmk5d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SZ1PzXb9s9FLbt2aMA6ncX/W0wvpXx+k3s5P5565PUsa9GNiCsyDudl0XrCfF2pFA
	 hREKgZtZ7Z8gqnsTclFj3u7fkos9DUBJxysY0UvCivZchTKCRujQz3b3EBVCzvgx5/
	 LZZg0D24VsVmpZXjr2Ir8r/DiQf7q3THIfv8SdbIngTAKcwV9uyegO66LQ1S03+DQG
	 qprBdmA5QYkyjl6VnnW9Rq6wFcumIEdR1iQBT0LaqRg2Vv4TdJBpCCZEasVYZrudFk
	 miEKik89L2f1MldXhGwbT3cLj7pZGkqIfi58gSsXwsT6qzXjNbdMhWDB9oLt8C4u9s
	 ctbBkxuWmI7ww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 560/715] f2fs: compress: fix to cover normal cluster write with cp_rwsem
Date: Sun, 24 Mar 2024 18:32:19 -0400
Message-ID: <20240324223455.1342824-561-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 3a8d8a213b406..ff26b49c0d71f 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1443,12 +1443,14 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page)
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
 
@@ -1463,6 +1465,10 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 	if (compr_blocks < 0)
 		return compr_blocks;
 
+	/* overwrite compressed cluster w/ normal cluster */
+	if (compr_blocks > 0)
+		f2fs_lock_op(sbi);
+
 	for (i = 0; i < cc->cluster_size; i++) {
 		if (!cc->rpages[i])
 			continue;
@@ -1487,7 +1493,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		if (!clear_page_dirty_for_io(cc->rpages[i]))
 			goto continue_unlock;
 
-		ret = f2fs_write_single_data_page(cc->rpages[i], &_submitted,
+		ret = f2fs_write_single_data_page(cc->rpages[i], &submitted,
 						NULL, NULL, wbc, io_type,
 						compr_blocks, false);
 		if (ret) {
@@ -1495,26 +1501,29 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
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
index d00e92b6c9025..7a93a99fbd04b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2839,7 +2839,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 		.encrypted_page = NULL,
 		.submitted = 0,
 		.compr_blocks = compr_blocks,
-		.need_lock = LOCK_RETRY,
+		.need_lock = compr_blocks ? LOCK_DONE : LOCK_RETRY,
 		.post_read = f2fs_post_read_required(inode) ? 1 : 0,
 		.io_type = io_type,
 		.io_wbc = wbc,
@@ -2920,6 +2920,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	if (err == -EAGAIN) {
 		err = f2fs_do_write_data_page(&fio);
 		if (err == -EAGAIN) {
+			f2fs_bug_on(sbi, compr_blocks);
 			fio.need_lock = LOCK_REQ;
 			err = f2fs_do_write_data_page(&fio);
 		}
-- 
2.43.0


