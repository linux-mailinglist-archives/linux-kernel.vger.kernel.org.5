Return-Path: <linux-kernel+bounces-91976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 940ED87194D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B45E3B22681
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21958535B6;
	Tue,  5 Mar 2024 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ucBxdXl8"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2968D50272
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630104; cv=none; b=I4vH4NYcIj85nVhnDAA7SnO32p2bvKRt50fWs7UU+onEzq8Fvj7g6rOhUY5kga06VwG9vaTFDw2pTbHSCQYRNUahIwkySOxme+mW1VUgO+zpqvsm5XaIWZl8YG438CVv4f+1dC6TvDkfAOSv+W+O+SuNjOeWNSS50AHCF0tqAJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630104; c=relaxed/simple;
	bh=CUZK1S/UTm1NptFywhh0dTVAXevwn1WjX6VxrAW5cmY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lLOaMzM0c+GHebKOmB5QNpsvJ7lW5tkkOyRNfU61ASDCJi3/3t3ERIchvNDpr24Nk0BoDg1SRJKH1vXpDo2Jx3rd7k24exH482aHZIYAtbvi097X/FVLsP0GgxujTkp1ExHzr4ceHGnp2OSJB0MJip9RY0CRso/Skvx/ay2/yNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ucBxdXl8; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709630094; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4tRsgiXWNN9mlTyxXmeapNYFeEWm+OEQOBRVCP5FFws=;
	b=ucBxdXl8CxreHNWnOgqY1MLBj6gxl1ZGVhj+bSiJrdIqII4vNUsbwtiDdFwpg+KylafV1jU1ULLu/AMc6Dg10TnLkZtOOrvxrRqx+sWc1fIo/rTqbaMGOj9MkjfOb6PSCO286x9ZZR6135QpFpmBtNW5U4GLQBV/KZ+BNCCxIhs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W1tgGeK_1709630089;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1tgGeK_1709630089)
          by smtp.aliyun-inc.com;
          Tue, 05 Mar 2024 17:14:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/6] erofs: convert z_erofs_onlinepage_.* to folios
Date: Tue,  5 Mar 2024 17:14:43 +0800
Message-Id: <20240305091448.1384242-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Online folios are locked file-backed folios which will eventually
keep decoded (e.g. decompressed) data of each inode for end users to
utilize.  It may belong to a few pclusters and contain other data (e.g.
compressed data for inplace I/Os) temporarily in a time-sharing manner
to reduce memory footprints for low-ended storage devices with high
latencies under heary I/O pressure.

Apart from folio_end_read() usage, it's a straight-forward conversion.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Some trivial folio conversions for compressed inodes aiming for v6.9.

 fs/erofs/zdata.c | 50 +++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ff0aa72b0db3..5013fcd4965a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -117,46 +117,39 @@ static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
 }
 
 /*
- * bit 30: I/O error occurred on this page
- * bit 0 - 29: remaining parts to complete this page
+ * bit 30: I/O error occurred on this folio
+ * bit 0 - 29: remaining parts to complete this folio
  */
-#define Z_EROFS_PAGE_EIO			(1 << 30)
+#define Z_EROFS_FOLIO_EIO			(1 << 30)
 
-static inline void z_erofs_onlinepage_init(struct page *page)
+static void z_erofs_onlinefolio_init(struct folio *folio)
 {
 	union {
 		atomic_t o;
-		unsigned long v;
+		void *v;
 	} u = { .o = ATOMIC_INIT(1) };
 
-	set_page_private(page, u.v);
-	smp_wmb();
-	SetPagePrivate(page);
+	folio->private = u.v;	/* valid only if file-backed folio is locked */
 }
 
-static inline void z_erofs_onlinepage_split(struct page *page)
+static void z_erofs_onlinefolio_split(struct folio *folio)
 {
-	atomic_inc((atomic_t *)&page->private);
+	atomic_inc((atomic_t *)&folio->private);
 }
 
-static void z_erofs_onlinepage_endio(struct page *page, int err)
+static void z_erofs_onlinefolio_end(struct folio *folio, int err)
 {
 	int orig, v;
 
-	DBG_BUGON(!PagePrivate(page));
-
 	do {
-		orig = atomic_read((atomic_t *)&page->private);
-		v = (orig - 1) | (err ? Z_EROFS_PAGE_EIO : 0);
-	} while (atomic_cmpxchg((atomic_t *)&page->private, orig, v) != orig);
+		orig = atomic_read((atomic_t *)&folio->private);
+		v = (orig - 1) | (err ? Z_EROFS_FOLIO_EIO : 0);
+	} while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
 
-	if (!(v & ~Z_EROFS_PAGE_EIO)) {
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		if (!(v & Z_EROFS_PAGE_EIO))
-			SetPageUptodate(page);
-		unlock_page(page);
-	}
+	if (v & ~Z_EROFS_FOLIO_EIO)
+		return;
+	folio->private = 0;
+	folio_end_read(folio, !(v & Z_EROFS_FOLIO_EIO));
 }
 
 #define Z_EROFS_ONSTACK_PAGES		32
@@ -965,6 +958,7 @@ static int z_erofs_read_fragment(struct super_block *sb, struct page *page,
 static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 				struct page *page, bool ra)
 {
+	struct folio *folio = page_folio(page);
 	struct inode *const inode = fe->inode;
 	struct erofs_map_blocks *const map = &fe->map;
 	const loff_t offset = page_offset(page);
@@ -973,7 +967,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	unsigned int cur, end, len, split;
 	int err = 0;
 
-	z_erofs_onlinepage_init(page);
+	z_erofs_onlinefolio_init(folio);
 	split = 0;
 	end = PAGE_SIZE;
 repeat:
@@ -1035,7 +1029,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	if (err)
 		goto out;
 
-	z_erofs_onlinepage_split(page);
+	z_erofs_onlinefolio_split(folio);
 	if (fe->pcl->pageofs_out != (map->m_la & ~PAGE_MASK))
 		fe->pcl->multibases = true;
 	if (fe->pcl->length < offset + end - map->m_la) {
@@ -1056,7 +1050,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto repeat;
 
 out:
-	z_erofs_onlinepage_endio(page, err);
+	z_erofs_onlinefolio_end(folio, err);
 	return err;
 }
 
@@ -1159,7 +1153,7 @@ static void z_erofs_fill_other_copies(struct z_erofs_decompress_backend *be,
 			cur += len;
 		}
 		kunmap_local(dst);
-		z_erofs_onlinepage_endio(bvi->bvec.page, err);
+		z_erofs_onlinefolio_end(page_folio(bvi->bvec.page), err);
 		list_del(p);
 		kfree(bvi);
 	}
@@ -1316,7 +1310,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		/* recycle all individual short-lived pages */
 		if (z_erofs_put_shortlivedpage(be->pagepool, page))
 			continue;
-		z_erofs_onlinepage_endio(page, err);
+		z_erofs_onlinefolio_end(page_folio(page), err);
 	}
 
 	if (be->decompressed_pages != be->onstack_pages)
-- 
2.39.3


