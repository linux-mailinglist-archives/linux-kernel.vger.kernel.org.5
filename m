Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEC07FC257
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346813AbjK1R7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346569AbjK1R7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:59:18 -0500
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644832129
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:58:28 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VxLTYBk_1701194300;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VxLTYBk_1701194300)
          by smtp.aliyun-inc.com;
          Wed, 29 Nov 2023 01:58:26 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: fix memory leak on short-lived bounced pages
Date:   Wed, 29 Nov 2023 01:58:10 +0800
Message-Id: <20231128175810.4105671-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both MicroLZMA and DEFLATE algorithms can use short-lived pages on
demand for overlap inplace I/O decompression.

However, those short-lived pages are actually added to
`be->decompressed_pages`.  Thus, it should be checked instead of
`pcl->compressed_bvecs`.

The LZ4 algorithm doesn't work like this, so it won't be impacted.

Fixes: 67139e36d970 ("erofs: introduce `z_erofs_parse_in_bvecs'")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a7e6847f6f8f..e5e44f926692 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1309,12 +1309,11 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		put_page(page);
 	} else {
 		for (i = 0; i < pclusterpages; ++i) {
-			page = pcl->compressed_bvecs[i].page;
+			/* consider shortlived pages added when decompressing */
+			page = be->decompressed_pages[i];
 
 			if (erofs_page_is_managed(sbi, page))
 				continue;
-
-			/* recycle all individual short-lived pages */
 			(void)z_erofs_put_shortlivedpage(be->pagepool, page);
 			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
 		}
-- 
2.39.3

