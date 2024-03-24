Return-Path: <linux-kernel+bounces-114383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2E0888A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9F11C288BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDF32720F7;
	Sun, 24 Mar 2024 23:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErbdGyo2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E72217E17;
	Sun, 24 Mar 2024 23:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321784; cv=none; b=jPIcDg9PNsoRa9kbPa9bAqs6uYkp2v93QwgSb7QDQ1IZ9PkbrLvQ2rOxyN7vcPMlrp7y1TLKqo/AubUfTmWS0EFPnrBAOuUitMdbziMujjRXIoUHBuxhRqPb3BAchI12hj/rX9SxPI7gTHkVkQc2FrT1c4VgljoFlTg3bfb+VFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321784; c=relaxed/simple;
	bh=HtIh6Izzs/rj3ULEcLwsf1FABKMnRpwiZxfRnnYtDN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IoC7Trk/zsM0l5ny8epsBIyqVBg5KgaURKrrM1HzqEXcZ+4ONkotbMOh+ZqEloNCxIH8DFdOc+6kLU/UJbIaVhIJsyAO/oNzdS0xouqJudMOSBHKFJNRrt8gQQmejPfx3UbTw1io8bxC9aisI2v8Q7AXwhJCkkuhqBJ13qZdqj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErbdGyo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D37C43390;
	Sun, 24 Mar 2024 23:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321782;
	bh=HtIh6Izzs/rj3ULEcLwsf1FABKMnRpwiZxfRnnYtDN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ErbdGyo20we8YcnuYmuHuBiH9vAf5iaazUVksWCFjFt/b2jDtjKU/RFI6COyFKVf7
	 gyHxL5t8MyLuo1y4sTclOxSxvUZmNTK+RCiENK19Cz+A6n2OSmKZnrYR389a/5HaFU
	 6Od3KOUADLscpwBsWH5eaIX1kecwXwYohYjPss9K8R9g32RGPRssxPwx81JGGky1S3
	 6mrFLm3R01SYUVsjtJ3gT9oc1od4MaQFvaM5FPTIfcQpdVt8R2tGB+U/VjcJrxfji3
	 gEYWrkrzZEOIbOzgE4ehCuHHxxUZpPEjhbbMtygaKgZsJqFB+hL317aUIr2Js774ks
	 ng1xEHudH1PFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 510/638] f2fs: compress: fix to cover normal cluster write with cp_rwsem
Date: Sun, 24 Mar 2024 18:59:07 -0400
Message-ID: <20240324230116.1348576-511-sashal@kernel.org>
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
index dfc59a658836f..100353355213d 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1438,12 +1438,14 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page)
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
 
@@ -1458,6 +1460,10 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 	if (compr_blocks < 0)
 		return compr_blocks;
 
+	/* overwrite compressed cluster w/ normal cluster */
+	if (compr_blocks > 0)
+		f2fs_lock_op(sbi);
+
 	for (i = 0; i < cc->cluster_size; i++) {
 		if (!cc->rpages[i])
 			continue;
@@ -1482,7 +1488,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		if (!clear_page_dirty_for_io(cc->rpages[i]))
 			goto continue_unlock;
 
-		ret = f2fs_write_single_data_page(cc->rpages[i], &_submitted,
+		ret = f2fs_write_single_data_page(cc->rpages[i], &submitted,
 						NULL, NULL, wbc, io_type,
 						compr_blocks, false);
 		if (ret) {
@@ -1490,26 +1496,29 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
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
index 349c9559f0b36..6f673fc44bdbc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2848,7 +2848,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 		.encrypted_page = NULL,
 		.submitted = 0,
 		.compr_blocks = compr_blocks,
-		.need_lock = LOCK_RETRY,
+		.need_lock = compr_blocks ? LOCK_DONE : LOCK_RETRY,
 		.post_read = f2fs_post_read_required(inode) ? 1 : 0,
 		.io_type = io_type,
 		.io_wbc = wbc,
@@ -2932,6 +2932,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	if (err == -EAGAIN) {
 		err = f2fs_do_write_data_page(&fio);
 		if (err == -EAGAIN) {
+			f2fs_bug_on(sbi, compr_blocks);
 			fio.need_lock = LOCK_REQ;
 			err = f2fs_do_write_data_page(&fio);
 		}
-- 
2.43.0


