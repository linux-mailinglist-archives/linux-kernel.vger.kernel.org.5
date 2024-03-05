Return-Path: <linux-kernel+bounces-91978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7A9871953
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40691F21A7E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143B6548EE;
	Tue,  5 Mar 2024 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YGwPsL5R"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3230652F67
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630106; cv=none; b=AVaYScbWuB1vuEgIXUHY9WG+5U5VsCYSXGjlnMwExloZRtSCS1L0b3BjFuVDj5KFE8r+u1HDYE7oxe01BmT8Ri3+LXtU+ylRXr4mscOZTLfh/A17YqdKzl/nFo+hVk5HKeEUDEsa+y3LJKTIlaeDCH/btbHdCdWlsRQMwhXt1po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630106; c=relaxed/simple;
	bh=9wnm/M0nqJDVjRMKUUmYKlSQKSw1dJ4j4w50pLUUkrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RLdn+y4DBc+/iXqsixVhPsrJHbIL9R7Nfu8FmXlgiK3mVu8RaIbQ2vE5Saebk/J30KnQu9pUyrt9tB/H8vnn79ZH2IoWiww5xGF/H6W3imTFo2swjMY/a9WhAtTxiLu736CrVib8F1Cw7bitUQKSysTXS+KpxelPdh4tLVSUhU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YGwPsL5R; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709630096; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GFDbGG8sHGCt0S8InIcbIqzI0LPCx+wjhzefgM3ZHC8=;
	b=YGwPsL5RX02Gmgr9gQhBC4YBznh4v4UU2Ari9rk4jhjFjqT8qzCIKdwGC5Ig7lVLRhvcL9NiCCNw6YJcMpfyXwY0MPM7RMaoHU1+bWSJgFOinA2PSFrEf9pzCqOQclib4A9mRWDOKlfDuZVpZhc+Up00K8RmULu378bu6t+nKmY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W1tgGg5_1709630094;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1tgGg5_1709630094)
          by smtp.aliyun-inc.com;
          Tue, 05 Mar 2024 17:14:55 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/6] erofs: convert z_erofs_do_read_page() to folios
Date: Tue,  5 Mar 2024 17:14:44 +0800
Message-Id: <20240305091448.1384242-2-hsiangkao@linux.alibaba.com>
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

It is a straight-forward conversion. Besides, it's renamed as
z_erofs_scan_folio().

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5013fcd4965a..c25074657708 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -955,21 +955,20 @@ static int z_erofs_read_fragment(struct super_block *sb, struct page *page,
 	return 0;
 }
 
-static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
-				struct page *page, bool ra)
+static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *fe,
+			      struct folio *folio, bool ra)
 {
-	struct folio *folio = page_folio(page);
 	struct inode *const inode = fe->inode;
 	struct erofs_map_blocks *const map = &fe->map;
-	const loff_t offset = page_offset(page);
-	const unsigned int bs = i_blocksize(inode);
+	const loff_t offset = folio_pos(folio);
+	const unsigned int bs = i_blocksize(inode), fs = folio_size(folio);
 	bool tight = true, exclusive;
 	unsigned int cur, end, len, split;
 	int err = 0;
 
 	z_erofs_onlinefolio_init(folio);
 	split = 0;
-	end = PAGE_SIZE;
+	end = fs;
 repeat:
 	if (offset + end - 1 < map->m_la ||
 	    offset + end - 1 >= map->m_la + map->m_llen) {
@@ -986,7 +985,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	++split;
 
 	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
-		zero_user_segment(page, cur, end);
+		folio_zero_segment(folio, cur, end);
 		tight = false;
 		goto next_part;
 	}
@@ -995,8 +994,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		erofs_off_t fpos = offset + cur - map->m_la;
 
 		len = min_t(unsigned int, map->m_llen - fpos, end - cur);
-		err = z_erofs_read_fragment(inode->i_sb, page, cur, cur + len,
-				EROFS_I(inode)->z_fragmentoff + fpos);
+		err = z_erofs_read_fragment(inode->i_sb, &folio->page, cur,
+			cur + len, EROFS_I(inode)->z_fragmentoff + fpos);
 		if (err)
 			goto out;
 		tight = false;
@@ -1011,18 +1010,18 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	}
 
 	/*
-	 * Ensure the current partial page belongs to this submit chain rather
+	 * Ensure the current partial folio belongs to this submit chain rather
 	 * than other concurrent submit chains or the noio(bypass) chain since
-	 * those chains are handled asynchronously thus the page cannot be used
+	 * those chains are handled asynchronously thus the folio cannot be used
 	 * for inplace I/O or bvpage (should be processed in a strict order.)
 	 */
 	tight &= (fe->mode > Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE);
-	exclusive = (!cur && ((split <= 1) || (tight && bs == PAGE_SIZE)));
+	exclusive = (!cur && ((split <= 1) || (tight && bs == fs)));
 	if (cur)
 		tight &= (fe->mode >= Z_EROFS_PCLUSTER_FOLLOWED);
 
 	err = z_erofs_attach_page(fe, &((struct z_erofs_bvec) {
-					.page = page,
+					.page = &folio->page,
 					.offset = offset - map->m_la,
 					.end = end,
 				  }), exclusive);
@@ -1789,7 +1788,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 			if (PageUptodate(page))
 				unlock_page(page);
 			else
-				(void)z_erofs_do_read_page(f, page, !!rac);
+				z_erofs_scan_folio(f, page_folio(page), !!rac);
 			put_page(page);
 		}
 
@@ -1810,7 +1809,7 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	f.headoffset = (erofs_off_t)folio->index << PAGE_SHIFT;
 
 	z_erofs_pcluster_readmore(&f, NULL, true);
-	err = z_erofs_do_read_page(&f, &folio->page, false);
+	err = z_erofs_scan_folio(&f, folio, false);
 	z_erofs_pcluster_readmore(&f, NULL, false);
 	z_erofs_pcluster_end(&f);
 
@@ -1851,7 +1850,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 		folio = head;
 		head = folio_get_private(folio);
 
-		err = z_erofs_do_read_page(&f, &folio->page, true);
+		err = z_erofs_scan_folio(&f, folio, true);
 		if (err && err != -EINTR)
 			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
 				  folio->index, EROFS_I(inode)->nid);
-- 
2.39.3


