Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6704677F226
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349005AbjHQI3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348924AbjHQI2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:28:45 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DC2273C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:28:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vpz9R1O_1692260905;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vpz9R1O_1692260905)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 16:28:26 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 5/8] erofs: drop z_erofs_page_mark_eio()
Date:   Thu, 17 Aug 2023 16:28:10 +0800
Message-Id: <20230817082813.81180-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be folded into z_erofs_onlinepage_endio() to simplify the code.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a200e99f7d4f..4009283944ca 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -143,22 +143,17 @@ static inline void z_erofs_onlinepage_split(struct page *page)
 	atomic_inc((atomic_t *)&page->private);
 }
 
-static inline void z_erofs_page_mark_eio(struct page *page)
+static void z_erofs_onlinepage_endio(struct page *page, int err)
 {
-	int orig;
+	int orig, v;
+
+	DBG_BUGON(!PagePrivate(page));
 
 	do {
 		orig = atomic_read((atomic_t *)&page->private);
-	} while (atomic_cmpxchg((atomic_t *)&page->private, orig,
-				orig | Z_EROFS_PAGE_EIO) != orig);
-}
-
-static inline void z_erofs_onlinepage_endio(struct page *page)
-{
-	unsigned int v;
+		v = (orig - 1) | (err ? Z_EROFS_PAGE_EIO : 0);
+	} while (atomic_cmpxchg((atomic_t *)&page->private, orig, v) != orig);
 
-	DBG_BUGON(!PagePrivate(page));
-	v = atomic_dec_return((atomic_t *)&page->private);
 	if (!(v & ~Z_EROFS_PAGE_EIO)) {
 		set_page_private(page, 0);
 		ClearPagePrivate(page);
@@ -1066,9 +1061,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto repeat;
 
 out:
-	if (err)
-		z_erofs_page_mark_eio(page);
-	z_erofs_onlinepage_endio(page);
+	z_erofs_onlinepage_endio(page, err);
 	return err;
 }
 
@@ -1171,9 +1164,7 @@ static void z_erofs_fill_other_copies(struct z_erofs_decompress_backend *be,
 			cur += len;
 		}
 		kunmap_local(dst);
-		if (err)
-			z_erofs_page_mark_eio(bvi->bvec.page);
-		z_erofs_onlinepage_endio(bvi->bvec.page);
+		z_erofs_onlinepage_endio(bvi->bvec.page, err);
 		list_del(p);
 		kfree(bvi);
 	}
@@ -1344,9 +1335,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		/* recycle all individual short-lived pages */
 		if (z_erofs_put_shortlivedpage(be->pagepool, page))
 			continue;
-		if (err)
-			z_erofs_page_mark_eio(page);
-		z_erofs_onlinepage_endio(page);
+		z_erofs_onlinepage_endio(page, err);
 	}
 
 	if (be->decompressed_pages != be->onstack_pages)
-- 
2.24.4

