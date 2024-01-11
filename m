Return-Path: <linux-kernel+bounces-23105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D29E82A7B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E67A1C245FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C37253BA;
	Thu, 11 Jan 2024 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKKjCjVP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0F46B6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3183C43390;
	Thu, 11 Jan 2024 06:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704955337;
	bh=/uXMDvSOj4ElzaKYgiipftBm0qNMtUebJdjXyJwsNz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DKKjCjVPjWXCbOFCnOQfP0ek3Hvak8Z4Z3uLF1tVCIAxbItx0Vzqd05veQm/NExGD
	 iOM8vgp+UBR/fVNGv64FMvCvbtO93CKnFzR75jMhwbaWIVT0GqmSKApPDlCBokfWst
	 KzuO0i510CaClc/LAMhkdD2mzatL3DFFUYPoX/XZujTg9Af+1ItF6AB6dH7Gu0MehR
	 wRq0DEQHJrERbJVZTwYp91rchogMv3z6LBvROIKClQ2YKm9tcj2bJ+MHjB8VjZPHKW
	 RxQ7e9OywUM+31u6e4IQQDevQOzv0CpRhhzodicptp7ItZy1gwBERM3Saro06ty9Do
	 UBqAEb0gaYFZg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v4 2/6] f2fs: compress: fix to cover normal cluster write with cp_rwsem
Date: Thu, 11 Jan 2024 14:42:04 +0800
Message-Id: <20240111064208.2969599-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240111064208.2969599-1-chao@kernel.org>
References: <20240111064208.2969599-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we overwrite compressed cluster w/ normal cluster, we should
not unlock cp_rwsem during f2fs_write_raw_pages(), otherwise data
will be corrupted if partial blocks were persisted before CP & SPOR,
due to cluster metadata wasn't updated atomically.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 20 ++++++++++++++------
 fs/f2fs/data.c     |  3 ++-
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 9940b7886e5d..bf4cfab67aec 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1448,7 +1448,8 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 					enum iostat_type io_type)
 {
 	struct address_space *mapping = cc->inode->i_mapping;
-	int _submitted, compr_blocks, ret, i;
+	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
+	int _submitted, compr_blocks, ret = 0, i;
 
 	compr_blocks = f2fs_compressed_blocks(cc);
 
@@ -1463,6 +1464,10 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 	if (compr_blocks < 0)
 		return compr_blocks;
 
+	/* overwrite compressed cluster w/ normal cluster */
+	if (compr_blocks > 0)
+		f2fs_lock_op(sbi);
+
 	for (i = 0; i < cc->cluster_size; i++) {
 		if (!cc->rpages[i])
 			continue;
@@ -1495,26 +1500,29 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
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
 
 		*submitted += _submitted;
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
index 81f9e2cc49e2..b171a9980f6a 100644
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
2.40.1


