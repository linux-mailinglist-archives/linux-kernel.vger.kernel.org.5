Return-Path: <linux-kernel+bounces-36396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F3D83A005
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F181F2BF89
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60215566E;
	Wed, 24 Jan 2024 03:19:52 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E585C98
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706066391; cv=none; b=MTG/xk6nJ9TE/udQevzpuA/ThQxHwcpdd0agjUfviQeMdY2GQDuQClowevlAq/XDlQLK23Rf9vdIQwglRyQ4AsNSzO0khDfdGn0OdeU3aaTFdfZBRNXt+Yl0N76rqTAgXbN1NXmhB6Zbn7PQZWXxTW+cB5jq58mZq5puTAX8294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706066391; c=relaxed/simple;
	bh=HWEHevNF4RRS3BZnDbsEM9K5QcaLshRXcS3REW1M6vc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uQw7tgTD7bMiWV3gzxuT1JFS8RN6ZHZhfoRKyAQzDa9m/9roJJ8Yac6Gtxo70wdU9kWI4HmhAWzQsMJwPDwwp2grvOFZVp+gLyHIFaVVT4veevUpMhuQbZ96hBn9RmQRdXqn/UzZZF99QRq4DETUsP1Ff5ENgN4PUf911pJDl3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.EiNDX_1706066385;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.EiNDX_1706066385)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 11:19:45 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: huyue2@coolpad.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] erofs: get rid of unneeded GFP_NOFS
Date: Wed, 24 Jan 2024 11:19:45 +0800
Message-Id: <20240124031945.130782-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up some leftovers since there is no way for EROFS to be called
again from a reclaim context.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 2 +-
 fs/erofs/inode.c   | 2 +-
 fs/erofs/utils.c   | 2 +-
 fs/erofs/zdata.c   | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index bc12030393b2..5ff90026fd43 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -459,7 +459,7 @@ static struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb
 
 	inode->i_size = OFFSET_MAX;
 	inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
-	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
+	mapping_set_gfp_mask(inode->i_mapping, GFP_KERNEL);
 	inode->i_blkbits = EROFS_SB(sb)->blkszbits;
 	inode->i_private = ctx;
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 3d616dea55dc..36e638e8b53a 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -60,7 +60,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		} else {
 			const unsigned int gotten = sb->s_blocksize - *ofs;
 
-			copied = kmalloc(vi->inode_isize, GFP_NOFS);
+			copied = kmalloc(vi->inode_isize, GFP_KERNEL);
 			if (!copied) {
 				err = -ENOMEM;
 				goto err_out;
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 5dea308764b4..e146d09151af 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -81,7 +81,7 @@ struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
 repeat:
 	xa_lock(&sbi->managed_pslots);
 	pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
-			   NULL, grp, GFP_NOFS);
+			   NULL, grp, GFP_KERNEL);
 	if (pre) {
 		if (xa_is_err(pre)) {
 			pre = ERR_PTR(xa_err(pre));
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 692c0c39be63..583c062cd0e4 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -230,7 +230,7 @@ static int z_erofs_bvec_enqueue(struct z_erofs_bvec_iter *iter,
 		struct page *nextpage = *candidate_bvpage;
 
 		if (!nextpage) {
-			nextpage = erofs_allocpage(pagepool, GFP_NOFS);
+			nextpage = erofs_allocpage(pagepool, GFP_KERNEL);
 			if (!nextpage)
 				return -ENOMEM;
 			set_page_private(nextpage, Z_EROFS_SHORTLIVED_PAGE);
@@ -302,7 +302,7 @@ static struct z_erofs_pcluster *z_erofs_alloc_pcluster(unsigned int size)
 		if (nrpages > pcs->maxpages)
 			continue;
 
-		pcl = kmem_cache_zalloc(pcs->slab, GFP_NOFS);
+		pcl = kmem_cache_zalloc(pcs->slab, GFP_KERNEL);
 		if (!pcl)
 			return ERR_PTR(-ENOMEM);
 		pcl->pclustersize = size;
@@ -694,7 +694,7 @@ static void z_erofs_cache_invalidate_folio(struct folio *folio,
 	DBG_BUGON(stop > folio_size(folio) || stop < length);
 
 	if (offset == 0 && stop == folio_size(folio))
-		while (!z_erofs_cache_release_folio(folio, GFP_NOFS))
+		while (!z_erofs_cache_release_folio(folio, 0))
 			cond_resched();
 }
 
@@ -713,7 +713,7 @@ int erofs_init_managed_cache(struct super_block *sb)
 	set_nlink(inode, 1);
 	inode->i_size = OFFSET_MAX;
 	inode->i_mapping->a_ops = &z_erofs_cache_aops;
-	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
+	mapping_set_gfp_mask(inode->i_mapping, GFP_KERNEL);
 	EROFS_SB(sb)->managed_cache = inode;
 	return 0;
 }
-- 
2.19.1.6.gb485710b


