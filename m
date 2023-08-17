Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC5777F223
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348999AbjHQI3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348923AbjHQI2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:28:44 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690DF30D8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:28:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vpz9R0e_1692260904;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vpz9R0e_1692260904)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 16:28:25 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 4/8] erofs: tidy up z_erofs_do_read_page()
Date:   Thu, 17 Aug 2023 16:28:09 +0800
Message-Id: <20230817082813.81180-4-hsiangkao@linux.alibaba.com>
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

 - Fix a typo: spiltted => split;

 - Move !EROFS_MAP_MAPPED and EROFS_MAP_FRAGMENT upwards;

 - Increase `split` in advance to avoid unnecessary repeat.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 53 ++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 30ecdfe41836..a200e99f7d4f 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -980,49 +980,34 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	struct erofs_map_blocks *const map = &fe->map;
 	const loff_t offset = page_offset(page);
 	bool tight = true, exclusive;
-	unsigned int cur, end, len, spiltted;
+	unsigned int cur, end, len, split;
 	int err = 0;
 
-	/* register locked file pages as online pages in pack */
 	z_erofs_onlinepage_init(page);
 
-	spiltted = 0;
+	split = 0;
 	end = PAGE_SIZE;
 repeat:
-	cur = end - 1;
-
-	if (offset + cur < map->m_la ||
-	    offset + cur >= map->m_la + map->m_llen) {
+	if (offset + end - 1 < map->m_la ||
+	    offset + end - 1 >= map->m_la + map->m_llen) {
 		z_erofs_pcluster_end(fe);
-		map->m_la = offset + cur;
+		map->m_la = offset + end - 1;
 		map->m_llen = 0;
 		err = z_erofs_map_blocks_iter(inode, map, 0);
 		if (err)
 			goto out;
-	} else if (fe->pcl) {
-		goto hitted;
 	}
 
-	if ((map->m_flags & EROFS_MAP_MAPPED) &&
-	    !(map->m_flags & EROFS_MAP_FRAGMENT)) {
-		err = z_erofs_pcluster_begin(fe);
-		if (err)
-			goto out;
-	}
-hitted:
-	/*
-	 * Ensure the current partial page belongs to this submit chain rather
-	 * than other concurrent submit chains or the noio(bypass) chain since
-	 * those chains are handled asynchronously thus the page cannot be used
-	 * for inplace I/O or bvpage (should be processed in a strict order.)
-	 */
-	tight &= (fe->mode > Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE);
+	cur = offset > map->m_la ? 0 : map->m_la - offset;
+	/* bump split parts first to avoid several separate cases */
+	++split;
 
-	cur = end - min_t(erofs_off_t, offset + end - map->m_la, end);
 	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 		zero_user_segment(page, cur, end);
+		tight = false;
 		goto next_part;
 	}
+
 	if (map->m_flags & EROFS_MAP_FRAGMENT) {
 		erofs_off_t fpos = offset + cur - map->m_la;
 
@@ -1031,12 +1016,24 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 				EROFS_I(inode)->z_fragmentoff + fpos);
 		if (err)
 			goto out;
-		++spiltted;
 		tight = false;
 		goto next_part;
 	}
 
-	exclusive = (!cur && (!spiltted || tight));
+	if (!fe->pcl) {
+		err = z_erofs_pcluster_begin(fe);
+		if (err)
+			goto out;
+	}
+
+	/*
+	 * Ensure the current partial page belongs to this submit chain rather
+	 * than other concurrent submit chains or the noio(bypass) chain since
+	 * those chains are handled asynchronously thus the page cannot be used
+	 * for inplace I/O or bvpage (should be processed in a strict order.)
+	 */
+	tight &= (fe->mode > Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE);
+	exclusive = (!cur && ((split <= 1) || tight));
 	if (cur)
 		tight &= (fe->mode >= Z_EROFS_PCLUSTER_FOLLOWED);
 
@@ -1049,8 +1046,6 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto out;
 
 	z_erofs_onlinepage_split(page);
-	/* bump up the number of spiltted parts of a page */
-	++spiltted;
 	if (fe->pcl->pageofs_out != (map->m_la & ~PAGE_MASK))
 		fe->pcl->multibases = true;
 	if (fe->pcl->length < offset + end - map->m_la) {
-- 
2.24.4

