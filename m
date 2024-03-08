Return-Path: <linux-kernel+bounces-96763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B5A876117
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992B4281910
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1007F535D3;
	Fri,  8 Mar 2024 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xg8g/nSv"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3F26296
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890927; cv=none; b=nKN0HjOGgy5G+IiZpoYNAaIN39xFMZwW5DysfR6ZjKi44HIpKoDox6w3kihjKWFqtGuVHlcXlHphrlQAJ59/KwF+ss3reiI5ol0jFrb9MzlGEaii/dXX1gCdogyfDIoRzkVKKfR/Ia2HlNY76yVYIJWZDZLSnEHempsCFABD28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890927; c=relaxed/simple;
	bh=KnkZ5Gq1bMoD5dDooJ1Sz34gq3K9ZKnvAC9/LDRiCdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aycfLfB2ZRlFMd6rZxrW7lq1F4dSVownp8JkVRkET0eCdB9JEZKyJ+M8CpSI4a1hLOGwbyCDqEByOaM+N7l5JBJic0cj7jgIA9fu/yx30/XF3cKa3SHNYaCgFRpZgBGUlggqUiCguQrOcfVZLIXeLo4bVb99VFD4WQmPKGiDQT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xg8g/nSv; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709890921; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PohGYe+mm6oxbfvIxTFM4WCMG4EhVItl1TIJs+7QSW4=;
	b=xg8g/nSvRHteGX2gW2xMthIgC0FgHkznrYX4t38TCv+Nrgki52Ge6Ux7W6e6x/sAaNWeZwp6zo15Qqs5kqa/R4uplF2EZ87VIoeMQYFD3z6OypLe5a9HzET9n4tirATa3WhZhyZrPtYD6ERqD3EvAZlmCRwD+bRXcevJE8zIauo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W22IFiv_1709890920;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W22IFiv_1709890920)
          by smtp.aliyun-inc.com;
          Fri, 08 Mar 2024 17:42:01 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] erofs: support compressed inodes over fscache
Date: Fri,  8 Mar 2024 17:41:59 +0800
Message-Id: <20240308094159.40547-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240308094159.40547-1-jefflexu@linux.alibaba.com>
References: <20240308094159.40547-1-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since fscache can utilize iov_iter to write dest buffers, bio_vec can
be used in this way too.

To simplify this, pseudo bios are prepared and bio_vec will be filled
with bio_add_page().  And a common .bi_end_io will be called directly
to handle I/O completion.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/inode.c    | 14 ++++++--------
 fs/erofs/internal.h |  4 ++++
 fs/erofs/zdata.c    | 32 ++++++++++++++++++------------
 4 files changed, 77 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index b9fb4c4da39c..8aff1a724805 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -174,6 +174,53 @@ static int erofs_fscache_read_io_async(struct fscache_cookie *cookie,
 	return 0;
 }
 
+struct erofs_fscache_bio {
+	struct erofs_fscache_io io;
+	struct bio bio;		/* w/o bdev to share bio_add_page/endio() */
+	struct bio_vec bvecs[BIO_MAX_VECS];
+};
+
+static void erofs_fscache_bio_endio(void *priv,
+		ssize_t transferred_or_error, bool was_async)
+{
+	struct erofs_fscache_bio *io = priv;
+
+	if (IS_ERR_VALUE(transferred_or_error))
+		io->bio.bi_status = errno_to_blk_status(transferred_or_error);
+	io->bio.bi_end_io(&io->bio);
+	BUILD_BUG_ON(offsetof(struct erofs_fscache_bio, io) != 0);
+	erofs_fscache_io_put(&io->io);
+}
+
+struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev)
+{
+	struct erofs_fscache_bio *io;
+
+	io = kmalloc(sizeof(*io), GFP_KERNEL | __GFP_NOFAIL);
+	bio_init(&io->bio, NULL, io->bvecs, BIO_MAX_VECS, REQ_OP_READ);
+	io->io.private = mdev->m_fscache->cookie;
+	io->io.end_io = erofs_fscache_bio_endio;
+	refcount_set(&io->io.ref, 1);
+	return &io->bio;
+}
+
+void erofs_fscache_submit_bio(struct bio *bio)
+{
+	struct erofs_fscache_bio *io = container_of(bio,
+			struct erofs_fscache_bio, bio);
+	int ret;
+
+	iov_iter_bvec(&io->io.iter, ITER_DEST, io->bvecs, bio->bi_vcnt,
+		      bio->bi_iter.bi_size);
+	ret = erofs_fscache_read_io_async(io->io.private,
+				bio->bi_iter.bi_sector << 9, &io->io);
+	erofs_fscache_io_put(&io->io);
+	if (!ret)
+		return;
+	bio->bi_status = errno_to_blk_status(ret);
+	bio->bi_end_io(bio);
+}
+
 static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
 {
 	struct erofs_fscache *ctx = folio->mapping->host->i_private;
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 36e638e8b53a..0eb0e6f933c3 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -259,14 +259,12 @@ static int erofs_fill_inode(struct inode *inode)
 
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
 #ifdef CONFIG_EROFS_FS_ZIP
-		if (!erofs_is_fscache_mode(inode->i_sb)) {
-			DO_ONCE_LITE_IF(inode->i_sb->s_blocksize != PAGE_SIZE,
-				  erofs_info, inode->i_sb,
-				  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
-			inode->i_mapping->a_ops = &z_erofs_aops;
-			err = 0;
-			goto out_unlock;
-		}
+		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
+			  erofs_info, inode->i_sb,
+			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
+		inode->i_mapping->a_ops = &z_erofs_aops;
+		err = 0;
+		goto out_unlock;
 #endif
 		err = -EOPNOTSUPP;
 		goto out_unlock;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f8623113be6c..92120bf4ab71 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -512,6 +512,8 @@ void erofs_fscache_unregister_fs(struct super_block *sb);
 struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 					char *name, unsigned int flags);
 void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
+struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev);
+void erofs_fscache_submit_bio(struct bio *bio);
 #else
 static inline int erofs_fscache_register_fs(struct super_block *sb)
 {
@@ -529,6 +531,8 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 static inline void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache)
 {
 }
+static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) { return NULL; }
+static inline void erofs_fscache_submit_bio(struct bio *bio) {}
 #endif
 
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index c1bd4d8392eb..3216b920d369 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1561,7 +1561,7 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 	qtail[JQ_BYPASS] = &pcl->next;
 }
 
-static void z_erofs_submissionqueue_endio(struct bio *bio)
+static void z_erofs_endio(struct bio *bio)
 {
 	struct z_erofs_decompressqueue *q = bio->bi_private;
 	blk_status_t err = bio->bi_status;
@@ -1582,7 +1582,8 @@ static void z_erofs_submissionqueue_endio(struct bio *bio)
 	if (err)
 		q->eio = true;
 	z_erofs_decompress_kickoff(q, -1);
-	bio_put(bio);
+	if (bio->bi_bdev)
+		bio_put(bio);
 }
 
 static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
@@ -1596,7 +1597,6 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	z_erofs_next_pcluster_t owned_head = f->owned_head;
 	/* bio is NULL initially, so no need to initialize last_{index,bdev} */
 	erofs_off_t last_pa;
-	struct block_device *last_bdev;
 	unsigned int nr_bios = 0;
 	struct bio *bio = NULL;
 	unsigned long pflags;
@@ -1643,9 +1643,13 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				continue;
 
 			if (bio && (cur != last_pa ||
-				    last_bdev != mdev.m_bdev)) {
-submit_bio_retry:
-				submit_bio(bio);
+				    bio->bi_bdev != mdev.m_bdev)) {
+io_retry:
+				if (!erofs_is_fscache_mode(sb))
+					submit_bio(bio);
+				else
+					erofs_fscache_submit_bio(bio);
+
 				if (memstall) {
 					psi_memstall_leave(&pflags);
 					memstall = 0;
@@ -1660,15 +1664,16 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			}
 
 			if (!bio) {
-				bio = bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
-						REQ_OP_READ, GFP_NOIO);
-				bio->bi_end_io = z_erofs_submissionqueue_endio;
+				bio = erofs_is_fscache_mode(sb) ?
+					erofs_fscache_bio_alloc(&mdev) :
+					bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
+						  REQ_OP_READ, GFP_NOIO);
+				bio->bi_end_io = z_erofs_endio;
 				bio->bi_iter.bi_sector = cur >> 9;
 				bio->bi_private = q[JQ_SUBMIT];
 				if (readahead)
 					bio->bi_opf |= REQ_RAHEAD;
 				++nr_bios;
-				last_bdev = mdev.m_bdev;
 			}
 
 			if (cur + bvec.bv_len > end)
@@ -1676,7 +1681,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			DBG_BUGON(bvec.bv_len < sb->s_blocksize);
 			if (!bio_add_page(bio, bvec.bv_page, bvec.bv_len,
 					  bvec.bv_offset))
-				goto submit_bio_retry;
+				goto io_retry;
 
 			last_pa = cur + bvec.bv_len;
 			bypass = false;
@@ -1689,7 +1694,10 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	} while (owned_head != Z_EROFS_PCLUSTER_TAIL);
 
 	if (bio) {
-		submit_bio(bio);
+		if (!erofs_is_fscache_mode(sb))
+			submit_bio(bio);
+		else
+			erofs_fscache_submit_bio(bio);
 		if (memstall)
 			psi_memstall_leave(&pflags);
 	}
-- 
2.19.1.6.gb485710b


