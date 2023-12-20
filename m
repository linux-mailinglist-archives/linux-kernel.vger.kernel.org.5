Return-Path: <linux-kernel+bounces-7013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 632DA81A086
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1871C1F222AA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAD83B7AB;
	Wed, 20 Dec 2023 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAx8QlLM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3C13B2B2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A60EC433CC;
	Wed, 20 Dec 2023 13:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703080783;
	bh=HlIylD6IwGlkcvAcDhSn7XsD9KaF9Cn4cGLKY52iKZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VAx8QlLM9/SAVXDNxAz7Vm0DbGUGFuklAUi9oWrXB2siqcfYl9r8e7XOChcN4D/Qt
	 xYOXSp7QxrttGDBWDLva4C/KR4QUc1uVnnB3taBjsdab4tRRz9aoM6eOn8KHhUSRik
	 yoI1q/DaZ6Rv6lxN854d+RSSfV6XwtjZuKMsK5veySxq7mflzYcUwhBxKHMi4jqYmX
	 yJHnbh4DQqEp3u57DtS2hcfwgTmo8WaZFLQPO2C1UE7qlbZBgy8xQKwrtfvailz4xi
	 u6VpYHaTbn/olibbEvjwuTOfzOEJU+wehVd/hMyg+dYY6ZF/GPdoNGGiiF7L37IXvs
	 kKXTwkHTljw3A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/6] f2fs: compress: fix to cover normal cluster write with cp_rwsem
Date: Wed, 20 Dec 2023 21:59:30 +0800
Message-Id: <20231220135934.3471407-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231220135934.3471407-1-chao@kernel.org>
References: <20231220135934.3471407-1-chao@kernel.org>
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
index 1122db8cc0b0..a1426c3eadcc 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1471,7 +1471,8 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 					enum iostat_type io_type)
 {
 	struct address_space *mapping = cc->inode->i_mapping;
-	int _submitted, compr_blocks, ret, i;
+	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
+	int _submitted, compr_blocks, ret = 0, i;
 
 	compr_blocks = f2fs_compressed_blocks(cc);
 
@@ -1486,6 +1487,10 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 	if (compr_blocks < 0)
 		return compr_blocks;
 
+	/* overwrite compressed cluster w/ normal cluster */
+	if (compr_blocks > 0)
+		f2fs_lock_op(sbi);
+
 	for (i = 0; i < cc->cluster_size; i++) {
 		if (!cc->rpages[i])
 			continue;
@@ -1518,26 +1523,29 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
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
index 6c72a6e86ba8..ceed5ac6c66b 100644
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
@@ -2929,6 +2929,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	if (err == -EAGAIN) {
 		err = f2fs_do_write_data_page(&fio);
 		if (err == -EAGAIN) {
+			f2fs_bug_on(sbi, compr_blocks);
 			fio.need_lock = LOCK_REQ;
 			err = f2fs_do_write_data_page(&fio);
 		}
-- 
2.40.1


