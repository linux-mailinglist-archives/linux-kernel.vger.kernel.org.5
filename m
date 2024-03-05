Return-Path: <linux-kernel+bounces-91975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A26187194A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6B4B22857
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483D652F6A;
	Tue,  5 Mar 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ph08e/Lr"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600315025C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630103; cv=none; b=H3+5lxVm6ydUupVMMDHbbqNZWS9KJm/itlsPL6zHRaWamntD3lifwKvYDfJAg3gio4JxGzszV8aaX6zx9tDvjzvk4L+bOmy/dLN+RPpvHdOfUQpsuattRZhgutKlXymmW9Euu2uvvBypC0ln7urbGqeSwyOCoGXwEThctQjOGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630103; c=relaxed/simple;
	bh=vN3Ac99ek7L5BiYRI7qoHwLM4d7piH782PBNhDZQRv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FaqWsz5hrkfxi2U37B3oP9erPNTKIvWQIzWdjRKaRUpMnT9ozI+EJDqcyAKIcpdEOJsOr9z/7tOp02+VUUrs4lSdgS/SlMgpfKxAUkTnQ9+qwDpTtpbM9ix7bAdbdIcH5Qqo+f2KxQ2XhL/P4CiE7m4/OedMJyHL7dAcMVdpBik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ph08e/Lr; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709630098; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=W/f5oF95pkOTMpLspbjrxasE1SMC5trVGVW+WGeZJIM=;
	b=ph08e/LrfPvPikVEWRPw9sUzgW4xYWhmBXPpzzoUcDoTjKyKn1gBl2vt994HFfrm+UNW/rYCnJXD3JBVfyHe4/c3NTRNx2LLQyfMOLagm+y1b9nMX5XAz/cPDPO4Rhs5+j9F6xWcuCtJJb0x4DSAtfRKDhwqfep7Wt/ZvY4mK7U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W1tgGh2_1709630096;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1tgGh2_1709630096)
          by smtp.aliyun-inc.com;
          Tue, 05 Mar 2024 17:14:57 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 4/6] erofs: convert z_erofs_fill_bio_vec() to folios
Date: Tue,  5 Mar 2024 17:14:46 +0800
Message-Id: <20240305091448.1384242-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240305091448.1384242-1-hsiangkao@linux.alibaba.com>
References: <20240305091448.1384242-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a folio member to `struct z_erofs_bvec` and convert most
of z_erofs_fill_bio_vec() to folios, which is still straight-forward.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 71 ++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 75b05990b571..d78cc54a96f5 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -19,7 +19,10 @@
 typedef void *z_erofs_next_pcluster_t;
 
 struct z_erofs_bvec {
-	struct page *page;
+	union {
+		struct page *page;
+		struct folio *folio;
+	};
 	int offset;
 	unsigned int end;
 };
@@ -1420,33 +1423,32 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	struct page *page;
 	int bs = i_blocksize(f->inode);
 
-	/* Except for inplace pages, the entire page can be used for I/Os */
+	/* Except for inplace folios, the entire folio can be used for I/Os */
 	bvec->bv_offset = 0;
 	bvec->bv_len = PAGE_SIZE;
 repeat:
 	spin_lock(&pcl->obj.lockref.lock);
 	zbv = pcl->compressed_bvecs[nr];
-	page = zbv.page;
 	spin_unlock(&pcl->obj.lockref.lock);
-	if (!page)
-		goto out_allocpage;
+	if (!zbv.folio)
+		goto out_allocfolio;
 
-	bvec->bv_page = page;
-	DBG_BUGON(z_erofs_is_shortlived_page(page));
+	bvec->bv_page = &zbv.folio->page;
+	DBG_BUGON(z_erofs_is_shortlived_page(bvec->bv_page));
 	/*
-	 * Handle preallocated cached pages.  We tried to allocate such pages
+	 * Handle preallocated cached folios.  We tried to allocate such folios
 	 * without triggering direct reclaim.  If allocation failed, inplace
-	 * file-backed pages will be used instead.
+	 * file-backed folios will be used instead.
 	 */
-	if (page->private == Z_EROFS_PREALLOCATED_PAGE) {
-		set_page_private(page, 0);
+	if (zbv.folio->private == (void *)Z_EROFS_PREALLOCATED_PAGE) {
+		zbv.folio->private = 0;
 		tocache = true;
 		goto out_tocache;
 	}
 
-	mapping = READ_ONCE(page->mapping);
+	mapping = READ_ONCE(zbv.folio->mapping);
 	/*
-	 * File-backed pages for inplace I/Os are all locked steady,
+	 * File-backed folios for inplace I/Os are all locked steady,
 	 * therefore it is impossible for `mapping` to be NULL.
 	 */
 	if (mapping && mapping != mc) {
@@ -1456,22 +1458,21 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 		return;
 	}
 
-	lock_page(page);
-	/* the cached page is still in managed cache */
-	if (page->mapping == mc) {
+	folio_lock(zbv.folio);
+	if (zbv.folio->mapping == mc) {
 		/*
-		 * The cached page is still available but without a valid
-		 * `->private` pcluster hint.  Let's reconnect them.
+		 * The cached folio is still in managed cache but without
+		 * a valid `->private` pcluster hint.  Let's reconnect them.
 		 */
-		if (!PagePrivate(page)) {
-			/* compressed_bvecs[] already takes a ref */
-			attach_page_private(page, pcl);
-			put_page(page);
+		if (!folio_test_private(zbv.folio)) {
+			folio_attach_private(zbv.folio, pcl);
+			/* compressed_bvecs[] already takes a ref before */
+			folio_put(zbv.folio);
 		}
 
 		/* no need to submit if it is already up-to-date */
-		if (PageUptodate(page)) {
-			unlock_page(page);
+		if (folio_test_uptodate(zbv.folio)) {
+			folio_unlock(zbv.folio);
 			bvec->bv_page = NULL;
 		}
 		return;
@@ -1481,32 +1482,32 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	 * It has been truncated, so it's unsafe to reuse this one. Let's
 	 * allocate a new page for compressed data.
 	 */
-	DBG_BUGON(page->mapping);
+	DBG_BUGON(zbv.folio->mapping);
 	tocache = true;
-	unlock_page(page);
-	put_page(page);
-out_allocpage:
+	folio_unlock(zbv.folio);
+	folio_put(zbv.folio);
+out_allocfolio:
 	page = erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
 	spin_lock(&pcl->obj.lockref.lock);
-	if (pcl->compressed_bvecs[nr].page) {
+	if (pcl->compressed_bvecs[nr].folio) {
 		erofs_pagepool_add(&f->pagepool, page);
 		spin_unlock(&pcl->obj.lockref.lock);
 		cond_resched();
 		goto repeat;
 	}
-	pcl->compressed_bvecs[nr].page = page;
+	pcl->compressed_bvecs[nr].folio = zbv.folio = page_folio(page);
 	spin_unlock(&pcl->obj.lockref.lock);
 	bvec->bv_page = page;
 out_tocache:
 	if (!tocache || bs != PAGE_SIZE ||
-	    add_to_page_cache_lru(page, mc, pcl->obj.index + nr, gfp)) {
-		/* turn into a temporary shortlived page (1 ref) */
-		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
+	    filemap_add_folio(mc, zbv.folio, pcl->obj.index + nr, gfp)) {
+		/* turn into a temporary shortlived folio (1 ref) */
+		zbv.folio->private = (void *)Z_EROFS_SHORTLIVED_PAGE;
 		return;
 	}
-	attach_page_private(page, pcl);
+	folio_attach_private(zbv.folio, pcl);
 	/* drop a refcount added by allocpage (then 2 refs in total here) */
-	put_page(page);
+	folio_put(zbv.folio);
 }
 
 static struct z_erofs_decompressqueue *jobqueue_init(struct super_block *sb,
-- 
2.39.3


