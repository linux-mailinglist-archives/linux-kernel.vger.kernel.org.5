Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6F177F221
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348927AbjHQI3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348911AbjHQI2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:28:40 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DFA10C9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:28:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vpz9QzF_1692260900;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vpz9QzF_1692260900)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 16:28:22 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/8] erofs: avoid obsolete {collector,collection} terms
Date:   Thu, 17 Aug 2023 16:28:07 +0800
Message-Id: <20230817082813.81180-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

{collector,collection} were once reserved in order to indicate different
runtime logical extent instance of multi-reference pclusters.

However, de-duplicated decompression has been landed in a more flexable
way, thus `struct z_erofs_collection` was formally removed in commit
87ca34a7065d ("erofs: get rid of `struct z_erofs_collection'").

Let's handle the remaining leftovers, for example:
    `z_erofs_collector_begin` => `z_erofs_pcluster_begin`
    `z_erofs_collector_end` => `z_erofs_pcluster_end`

as well as some comments.  No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index dc104add0a99..4ed99346c4e1 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -507,19 +507,17 @@ enum z_erofs_pclustermode {
 	 */
 	Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE,
 	/*
-	 * The current collection has been linked with the owned chain, and
-	 * could also be linked with the remaining collections, which means
-	 * if the processing page is the tail page of the collection, thus
-	 * the current collection can safely use the whole page (since
-	 * the previous collection is under control) for in-place I/O, as
-	 * illustrated below:
-	 *  ________________________________________________________________
-	 * |  tail (partial) page |          head (partial) page           |
-	 * |  (of the current cl) |      (of the previous collection)      |
-	 * |                      |                                        |
-	 * |__PCLUSTER_FOLLOWED___|___________PCLUSTER_FOLLOWED____________|
+	 * The pcluster was just linked to a decompression chain by us.  It can
+	 * also be linked with the remaining pclusters, which means if the
+	 * processing page is the tail page of a pcluster, this pcluster can
+	 * safely use the whole page (since the previous pcluster is within the
+	 * same chain) for in-place I/O, as illustrated below:
+	 *  ___________________________________________________
+	 * |  tail (partial) page  |    head (partial) page    |
+	 * |  (of the current pcl) |   (of the previous pcl)   |
+	 * |___PCLUSTER_FOLLOWED___|_____PCLUSTER_FOLLOWED_____|
 	 *
-	 * [  (*) the above page can be used as inplace I/O.               ]
+	 * [  (*) the page above can be used as inplace I/O.   ]
 	 */
 	Z_EROFS_PCLUSTER_FOLLOWED,
 };
@@ -851,7 +849,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	return err;
 }
 
-static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
+static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
 	struct erofs_workgroup *grp = NULL;
@@ -908,12 +906,12 @@ void erofs_workgroup_free_rcu(struct erofs_workgroup *grp)
 	call_rcu(&pcl->rcu, z_erofs_rcu_callback);
 }
 
-static bool z_erofs_collector_end(struct z_erofs_decompress_frontend *fe)
+static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 {
 	struct z_erofs_pcluster *pcl = fe->pcl;
 
 	if (!pcl)
-		return false;
+		return;
 
 	z_erofs_bvec_iter_end(&fe->biter);
 	mutex_unlock(&pcl->lock);
@@ -929,7 +927,7 @@ static bool z_erofs_collector_end(struct z_erofs_decompress_frontend *fe)
 		erofs_workgroup_put(&pcl->obj);
 
 	fe->pcl = NULL;
-	return true;
+	fe->backmost = false;
 }
 
 static int z_erofs_read_fragment(struct super_block *sb, struct page *page,
@@ -978,8 +976,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 
 	if (offset + cur < map->m_la ||
 	    offset + cur >= map->m_la + map->m_llen) {
-		if (z_erofs_collector_end(fe))
-			fe->backmost = false;
+		z_erofs_pcluster_end(fe);
 		map->m_la = offset + cur;
 		map->m_llen = 0;
 		err = z_erofs_map_blocks_iter(inode, map, 0);
@@ -995,7 +992,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	    map->m_flags & EROFS_MAP_FRAGMENT)
 		goto hitted;
 
-	err = z_erofs_collector_begin(fe);
+	err = z_erofs_pcluster_begin(fe);
 	if (err)
 		goto out;
 
@@ -1862,7 +1859,7 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	z_erofs_pcluster_readmore(&f, NULL, true);
 	err = z_erofs_do_read_page(&f, page);
 	z_erofs_pcluster_readmore(&f, NULL, false);
-	(void)z_erofs_collector_end(&f);
+	z_erofs_pcluster_end(&f);
 
 	/* if some compressed cluster ready, need submit them anyway */
 	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, 0), false);
@@ -1909,7 +1906,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 		put_page(page);
 	}
 	z_erofs_pcluster_readmore(&f, rac, false);
-	(void)z_erofs_collector_end(&f);
+	z_erofs_pcluster_end(&f);
 
 	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, nr_pages), true);
 	erofs_put_metabuf(&f.map.buf);
-- 
2.24.4

