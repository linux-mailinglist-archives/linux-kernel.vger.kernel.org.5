Return-Path: <linux-kernel+bounces-39638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D5983D3F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 06:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75771C22D22
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4A3BE4E;
	Fri, 26 Jan 2024 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bqopl3ah"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ACCBA33
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 05:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706247389; cv=none; b=nN+m+i6t1UcGRhuoHXZj+Xnm5dk8TiVT4W/rYVfM8WP0voqdJw1hwHWPETwJjoH+N5ENbcfVd7fFASOhzYVEJkpFbQ3Xh9vLw5rw9JNNQsRrcAQyclRC3vnq/IIyB7GIIFQKxSaMBPrpKCR57sdkQXIw/cIxvDsq8NLS+qPb2aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706247389; c=relaxed/simple;
	bh=hn5LUYrPwooQxSCTZT4qXdNvz0cEpKO4X5sJ/K1r3tA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QBZEhOJwOSmzdaHgAa9VanSW5m14StF5Y5+rj41POgAdWZ24CSICfXkepKR33vJMufFT34NkH0OYRsuOqAUix7/Xxq4lUtVAnKpRK9fqabr2BD9fbznMRRWi9M49XS9VwWExyccRpTgTL6jLRFLuO+qwsya7n3sBg5LTpL3LUsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bqopl3ah; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706247383; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=h9jiGswXdStGzbdydZiMP7pJ+yL5hOmyEbJy5RVFHxs=;
	b=bqopl3ahydl1RFlvnwjI7yH64GvfUblMLiOh6sSFw47eFfetEqq3JsQrIxSJFcW17zQ6V4xPJZBG7K0OOPqDzRw0c7EsPNYtcT9mYZqtTr2tdAYfmJT4YnOBQJ6iotLHxeJ+HVyL0y2d89q/WHubV79zm5/cPuRge2FwVi+gKJk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W.MYc8x_1706247378;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W.MYc8x_1706247378)
          by smtp.aliyun-inc.com;
          Fri, 26 Jan 2024 13:36:23 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Gao Xiang <xiang@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3] erofs: relaxed temporary buffers allocation on readahead
Date: Fri, 26 Jan 2024 13:36:16 +0800
Message-Id: <20240126053616.3707834-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <TY2PR06MB3342D2245C5E515028C33FD4BE792@TY2PR06MB3342.apcprd06.prod.outlook.com>
References: <TY2PR06MB3342D2245C5E515028C33FD4BE792@TY2PR06MB3342.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chunhai Guo <guochunhai@vivo.com>

Even with inplace decompression, sometimes very few temporary buffers
are still needed for a single decompression shot (e.g. 16 pages for 64k
sliding window or 4 pages for 16k sliding window).  In low-memory
scenarios, it would be better to try to allocate with GFP_NOWAIT on
readahead first. That can help reduce the time spent on page allocation
under durative memory pressure.

Here are detailed performance numbers under multi-app launch benchmark
workload [1] on ARM64 Android devices (8-core CPU and 8GB of memory)
running a 5.15 LTS kernel with EROFS of 4k pclusters:

+----------------+---------+---------+---------+
|      LZ4       | vanilla | patched |  diff   |
|----------------+---------+---------+---------|
|  Average (ms)  |  3364   |  2684   | -20.21% | [64k sliding window]
|----------------+---------+---------+---------|
|  Average (ms)  |  2079   |  1610   | -22.56% | [16k sliding window]
+----------------+---------+---------+---------+

The total size of system images for 4k pcluster is almost unchanged:
(64k sliding window)  9,117,044 KB
(16k sliding window)  9,113,096 KB

Therefore, in addition to switch the sliding window from 64k to 16k,
after applying this patch, it can eventually save 52.14% (3364 -> 1610)
on average with no memory reservation.  That is particularly useful for
embedded devices with limited resources.

[1] https://lore.kernel.org/r/20240109074143.4138783-1-guochunhai@vivo.com

Suggested-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2: https://lore.kernel.org/r/20240120145551.1941483-1-guochunhai@vivo.com
change since v2:
 - update commit message according to test results.

I plan to apply this version.

 fs/erofs/compress.h             |  5 ++---
 fs/erofs/decompressor.c         |  5 +++--
 fs/erofs/decompressor_deflate.c | 19 +++++++++++++------
 fs/erofs/decompressor_lzma.c    | 17 ++++++++++++-----
 fs/erofs/zdata.c                | 16 ++++++++++++----
 5 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 279933e007d2..7cc5841577b2 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -11,13 +11,12 @@
 struct z_erofs_decompress_req {
 	struct super_block *sb;
 	struct page **in, **out;
-
 	unsigned short pageofs_in, pageofs_out;
 	unsigned int inputsize, outputsize;
 
-	/* indicate the algorithm will be used for decompression */
-	unsigned int alg;
+	unsigned int alg;       /* the algorithm for decompression */
 	bool inplace_io, partial_decoding, fillgaps;
+	gfp_t gfp;      /* allocation flags for extra temporary buffers */
 };
 
 struct z_erofs_decompressor {
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 072ef6a66823..d4cee95af14c 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -111,8 +111,9 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
 			victim = availables[--top];
 			get_page(victim);
 		} else {
-			victim = erofs_allocpage(pagepool,
-						 GFP_KERNEL | __GFP_NOFAIL);
+			victim = erofs_allocpage(pagepool, rq->gfp);
+			if (!victim)
+				return -ENOMEM;
 			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
 		}
 		rq->out[i] = victim;
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index 4a64a9c91dd3..b98872058abe 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -95,7 +95,7 @@ int z_erofs_load_deflate_config(struct super_block *sb,
 }
 
 int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
-			       struct page **pagepool)
+			       struct page **pgpl)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -158,8 +158,12 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 			strm->z.avail_out = min_t(u32, outsz, PAGE_SIZE - pofs);
 			outsz -= strm->z.avail_out;
 			if (!rq->out[no]) {
-				rq->out[no] = erofs_allocpage(pagepool,
-						GFP_KERNEL | __GFP_NOFAIL);
+				rq->out[no] = erofs_allocpage(pgpl, rq->gfp);
+				if (!rq->out[no]) {
+					kout = NULL;
+					err = -ENOMEM;
+					break;
+				}
 				set_page_private(rq->out[no],
 						 Z_EROFS_SHORTLIVED_PAGE);
 			}
@@ -211,8 +215,11 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 
 			DBG_BUGON(erofs_page_is_managed(EROFS_SB(sb),
 							rq->in[j]));
-			tmppage = erofs_allocpage(pagepool,
-						  GFP_KERNEL | __GFP_NOFAIL);
+			tmppage = erofs_allocpage(pgpl, rq->gfp);
+			if (!tmppage) {
+				err = -ENOMEM;
+				goto failed;
+			}
 			set_page_private(tmppage, Z_EROFS_SHORTLIVED_PAGE);
 			copy_highpage(tmppage, rq->in[j]);
 			rq->in[j] = tmppage;
@@ -230,7 +237,7 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 			break;
 		}
 	}
-
+failed:
 	if (zlib_inflateEnd(&strm->z) != Z_OK && !err)
 		err = -EIO;
 	if (kout)
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 2dd14f99c1dc..6ca357d83cfa 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -148,7 +148,7 @@ int z_erofs_load_lzma_config(struct super_block *sb,
 }
 
 int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
-			    struct page **pagepool)
+			    struct page **pgpl)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -215,8 +215,11 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 						   PAGE_SIZE - pageofs);
 			outlen -= strm->buf.out_size;
 			if (!rq->out[no] && rq->fillgaps) {	/* deduped */
-				rq->out[no] = erofs_allocpage(pagepool,
-						GFP_KERNEL | __GFP_NOFAIL);
+				rq->out[no] = erofs_allocpage(pgpl, rq->gfp);
+				if (!rq->out[no]) {
+					err = -ENOMEM;
+					break;
+				}
 				set_page_private(rq->out[no],
 						 Z_EROFS_SHORTLIVED_PAGE);
 			}
@@ -258,8 +261,11 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 
 			DBG_BUGON(erofs_page_is_managed(EROFS_SB(rq->sb),
 							rq->in[j]));
-			tmppage = erofs_allocpage(pagepool,
-						  GFP_KERNEL | __GFP_NOFAIL);
+			tmppage = erofs_allocpage(pgpl, rq->gfp);
+			if (!tmppage) {
+				err = -ENOMEM;
+				goto failed;
+			}
 			set_page_private(tmppage, Z_EROFS_SHORTLIVED_PAGE);
 			copy_highpage(tmppage, rq->in[j]);
 			rq->in[j] = tmppage;
@@ -277,6 +283,7 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 			break;
 		}
 	}
+failed:
 	if (no < nrpages_out && strm->buf.out)
 		kunmap(rq->out[no]);
 	if (ni < nrpages_in)
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index c1c77166b30f..1d0fdc145fd6 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -82,6 +82,9 @@ struct z_erofs_pcluster {
 	/* L: indicate several pageofs_outs or not */
 	bool multibases;
 
+	/* L: whether extra buffer allocations are best-effort */
+	bool besteffort;
+
 	/* A: compressed bvecs (can be cached or inplaced pages) */
 	struct z_erofs_bvec compressed_bvecs[];
 };
@@ -960,7 +963,7 @@ static int z_erofs_read_fragment(struct super_block *sb, struct page *page,
 }
 
 static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
-				struct page *page)
+				struct page *page, bool ra)
 {
 	struct inode *const inode = fe->inode;
 	struct erofs_map_blocks *const map = &fe->map;
@@ -1010,6 +1013,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		err = z_erofs_pcluster_begin(fe);
 		if (err)
 			goto out;
+		fe->pcl->besteffort |= !ra;
 	}
 
 	/*
@@ -1276,7 +1280,11 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 					.inplace_io = overlapped,
 					.partial_decoding = pcl->partial,
 					.fillgaps = pcl->multibases,
+					.gfp = pcl->besteffort ?
+						GFP_KERNEL | __GFP_NOFAIL :
+						GFP_NOWAIT | __GFP_NORETRY
 				 }, be->pagepool);
+	pcl->besteffort = false;
 
 	/* must handle all compressed pages before actual file pages */
 	if (z_erofs_is_inline_pcluster(pcl)) {
@@ -1787,7 +1795,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 			if (PageUptodate(page))
 				unlock_page(page);
 			else
-				(void)z_erofs_do_read_page(f, page);
+				(void)z_erofs_do_read_page(f, page, !!rac);
 			put_page(page);
 		}
 
@@ -1808,7 +1816,7 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	f.headoffset = (erofs_off_t)folio->index << PAGE_SHIFT;
 
 	z_erofs_pcluster_readmore(&f, NULL, true);
-	err = z_erofs_do_read_page(&f, &folio->page);
+	err = z_erofs_do_read_page(&f, &folio->page, false);
 	z_erofs_pcluster_readmore(&f, NULL, false);
 	z_erofs_pcluster_end(&f);
 
@@ -1849,7 +1857,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 		folio = head;
 		head = folio_get_private(folio);
 
-		err = z_erofs_do_read_page(&f, &folio->page);
+		err = z_erofs_do_read_page(&f, &folio->page, true);
 		if (err && err != -EINTR)
 			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
 				  folio->index, EROFS_I(inode)->nid);
-- 
2.39.3


