Return-Path: <linux-kernel+bounces-114612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FE7888B44
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B798D1C292C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A3B233AA1;
	Sun, 24 Mar 2024 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ni8AXNT5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87B523317F;
	Sun, 24 Mar 2024 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322270; cv=none; b=KaBQFxLc6lDrZZG7xncmtxTWWTZGWncLAh1de8+isdC+V/XJA/8hlKLTqQ5aiHmEUUzqDwVTTiVq1a2quNpm7NDFHMQA+Ux7qmi9+usFiPtig1yLLfWpjov4N8W6wV9jYnJolcAs6V14q2X+NP6NlfNImNVT08k7VMen7H01dR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322270; c=relaxed/simple;
	bh=b6kF3yVhL7+0sV5B/ea/nN+/xvkW+gs1M9b048poR1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjO7s5kcFmJDvsbom5f6DBT9WADSNqDGduqrvwWrmZjylxi3OCHDR3XP/kjH/RfGuHZUyVSe0VhoLiljrqj4n5fhkUysj+wCq56lGZc1JMI3xiBE7/RudFWO6TWh2SgO0e60R2WEpFkTZbbIVyxFEVrJPf+SdTdzDllBMsH/nys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ni8AXNT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BB2C43390;
	Sun, 24 Mar 2024 23:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322269;
	bh=b6kF3yVhL7+0sV5B/ea/nN+/xvkW+gs1M9b048poR1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ni8AXNT5hBVUzbPttvqXakeJEi+h8lBRPYdiF1awLs+dibcwwSGmItPcka4RGorGX
	 TbSVg6h0tKE9OawDAF0+vjD1J6k67iXHO3EtMppRm/tbpBdtFj9l1EJHUTxYcHzMLp
	 VQj9sGlp7xhc36vz+2OryxZafoOgFAzuyNUG9Z6fYyKUcWaQx1U3+EKSulCSXmcaoi
	 WICXsiAf+yqWyQBn1s653fMOC/VTb3mrt1SCliAP4ezjLPFr26qXZkh613yqCI7/bt
	 5l4qTFdUX4PryLwojLzS+MUkaURfJTYBmqliFSyRxL/s/Q4+r1enMwYmC8/4ERhPIi
	 iVugDatDWOewg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 352/451] f2fs: reduce stack memory cost by using bitfield in struct f2fs_io_info
Date: Sun, 24 Mar 2024 19:10:28 -0400
Message-ID: <20240324231207.1351418-353-sashal@kernel.org>
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

[ Upstream commit 2eae077e6e46f9046d383631145750e043820dce ]

This patch tries to use bitfield in struct f2fs_io_info to improve
memory usage.

struct f2fs_io_info {
..
	unsigned int need_lock:8;	/* indicate we need to lock cp_rwsem */
	unsigned int version:8;		/* version of the node */
	unsigned int submitted:1;	/* indicate IO submission */
	unsigned int in_list:1;		/* indicate fio is in io_list */
	unsigned int is_por:1;		/* indicate IO is from recovery or not */
	unsigned int retry:1;		/* need to reallocate block address */
	unsigned int encrypted:1;	/* indicate file is encrypted */
	unsigned int post_read:1;	/* require post read */
..
};

After this patch, size of struct f2fs_io_info reduces from 136 to 120.

[Nathan: fix a compile warning (single-bit-bitfield-constant-conversion)]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 8a430dd49e9c ("f2fs: compress: fix to guarantee persisting compressed blocks by CP")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c |  6 +++---
 fs/f2fs/compress.c   |  5 +++--
 fs/f2fs/data.c       | 10 +++++-----
 fs/f2fs/f2fs.h       | 18 +++++++++---------
 fs/f2fs/gc.c         |  8 ++++----
 fs/f2fs/node.c       |  2 +-
 fs/f2fs/segment.c    |  6 +++---
 7 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index eb4d69f53337f..3ec203bbd5593 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -70,7 +70,7 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 		.old_blkaddr = index,
 		.new_blkaddr = index,
 		.encrypted_page = NULL,
-		.is_por = !is_meta,
+		.is_por = !is_meta ? 1 : 0,
 	};
 	int err;
 
@@ -234,8 +234,8 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 		.op = REQ_OP_READ,
 		.op_flags = sync ? (REQ_META | REQ_PRIO) : REQ_RAHEAD,
 		.encrypted_page = NULL,
-		.in_list = false,
-		.is_por = (type == META_POR),
+		.in_list = 0,
+		.is_por = (type == META_POR) ? 1 : 0,
 	};
 	struct blk_plug plug;
 	int err;
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 967262c37da52..7d85db7208e14 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1249,10 +1249,11 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		.page = NULL,
 		.encrypted_page = NULL,
 		.compressed_page = NULL,
-		.submitted = false,
+		.submitted = 0,
 		.io_type = io_type,
 		.io_wbc = wbc,
-		.encrypted = fscrypt_inode_uses_fs_layer_crypto(cc->inode),
+		.encrypted = fscrypt_inode_uses_fs_layer_crypto(cc->inode) ?
+									1 : 0,
 	};
 	struct dnode_of_data dn;
 	struct node_info ni;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8b561af379743..7b3eb192f9c03 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -982,7 +982,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		bio_page = fio->page;
 
 	/* set submitted = true as a return value */
-	fio->submitted = true;
+	fio->submitted = 1;
 
 	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
 
@@ -998,7 +998,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 				(fio->type == DATA || fio->type == NODE) &&
 				fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)) {
 			dec_page_count(sbi, WB_DATA_TYPE(bio_page));
-			fio->retry = true;
+			fio->retry = 1;
 			goto skip;
 		}
 		io->bio = __bio_alloc(fio, BIO_MAX_VECS);
@@ -2776,10 +2776,10 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 		.old_blkaddr = NULL_ADDR,
 		.page = page,
 		.encrypted_page = NULL,
-		.submitted = false,
+		.submitted = 0,
 		.compr_blocks = compr_blocks,
 		.need_lock = LOCK_RETRY,
-		.post_read = f2fs_post_read_required(inode),
+		.post_read = f2fs_post_read_required(inode) ? 1 : 0,
 		.io_type = io_type,
 		.io_wbc = wbc,
 		.bio = bio,
@@ -2902,7 +2902,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	}
 
 	if (submitted)
-		*submitted = fio.submitted ? 1 : 0;
+		*submitted = fio.submitted;
 
 	return 0;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e5a9498b89c06..1d78bca5037f4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1183,19 +1183,19 @@ struct f2fs_io_info {
 	struct page *encrypted_page;	/* encrypted page */
 	struct page *compressed_page;	/* compressed page */
 	struct list_head list;		/* serialize IOs */
-	bool submitted;		/* indicate IO submission */
-	int need_lock;		/* indicate we need to lock cp_rwsem */
-	bool in_list;		/* indicate fio is in io_list */
-	bool is_por;		/* indicate IO is from recovery or not */
-	bool retry;		/* need to reallocate block address */
-	int compr_blocks;	/* # of compressed block addresses */
-	bool encrypted;		/* indicate file is encrypted */
-	bool post_read;		/* require post read */
+	unsigned int compr_blocks;	/* # of compressed block addresses */
+	unsigned int need_lock:8;	/* indicate we need to lock cp_rwsem */
+	unsigned int version:8;		/* version of the node */
+	unsigned int submitted:1;	/* indicate IO submission */
+	unsigned int in_list:1;		/* indicate fio is in io_list */
+	unsigned int is_por:1;		/* indicate IO is from recovery or not */
+	unsigned int retry:1;		/* need to reallocate block address */
+	unsigned int encrypted:1;	/* indicate file is encrypted */
+	unsigned int post_read:1;	/* require post read */
 	enum iostat_type io_type;	/* io type */
 	struct writeback_control *io_wbc; /* writeback control */
 	struct bio **bio;		/* bio for ipu */
 	sector_t *last_block;		/* last block number in bio */
-	unsigned char version;		/* version of the node */
 };
 
 struct bio_entry {
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ec7212f7a9b73..8161355658562 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1187,8 +1187,8 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 		.op = REQ_OP_READ,
 		.op_flags = 0,
 		.encrypted_page = NULL,
-		.in_list = false,
-		.retry = false,
+		.in_list = 0,
+		.retry = 0,
 	};
 	int err;
 
@@ -1276,8 +1276,8 @@ static int move_data_block(struct inode *inode, block_t bidx,
 		.op = REQ_OP_READ,
 		.op_flags = 0,
 		.encrypted_page = NULL,
-		.in_list = false,
-		.retry = false,
+		.in_list = 0,
+		.retry = 0,
 	};
 	struct dnode_of_data dn;
 	struct f2fs_summary sum;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c6d0e07096326..5db6740d31364 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1587,7 +1587,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 		.op_flags = wbc_to_write_flags(wbc),
 		.page = page,
 		.encrypted_page = NULL,
-		.submitted = false,
+		.submitted = 0,
 		.io_type = io_type,
 		.io_wbc = wbc,
 	};
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 16bf9d5c8d4f9..a3dabec1f216a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3312,10 +3312,10 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 		struct f2fs_bio_info *io;
 
 		if (F2FS_IO_ALIGNED(sbi))
-			fio->retry = false;
+			fio->retry = 0;
 
 		INIT_LIST_HEAD(&fio->list);
-		fio->in_list = true;
+		fio->in_list = 1;
 		io = sbi->write_io[fio->type] + fio->temp;
 		spin_lock(&io->io_lock);
 		list_add_tail(&fio->list, &io->io_list);
@@ -3396,7 +3396,7 @@ void f2fs_do_write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
 		.new_blkaddr = page->index,
 		.page = page,
 		.encrypted_page = NULL,
-		.in_list = false,
+		.in_list = 0,
 	};
 
 	if (unlikely(page->index >= MAIN_BLKADDR(sbi)))
-- 
2.43.0


