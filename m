Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957517FC1F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345438AbjK1SEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345415AbjK1SEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:04:30 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E62D63
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:04:35 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VxLRJJv_1701194672;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VxLRJJv_1701194672)
          by smtp.aliyun-inc.com;
          Wed, 29 Nov 2023 02:04:33 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] erofs: fix memory leak on short-lived bounced pages
Date:   Wed, 29 Nov 2023 02:04:31 +0800
Message-Id: <20231128180431.4116991-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231128175810.4105671-1-hsiangkao@linux.alibaba.com>
References: <20231128175810.4105671-1-hsiangkao@linux.alibaba.com>
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
`be->compressed_pages`.  Thus, it should be checked instead of
`pcl->compressed_bvecs`.

The LZ4 algorithm doesn't work like this, so it won't be impacted.

Fixes: 67139e36d970 ("erofs: introduce `z_erofs_parse_in_bvecs'")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
  - should be `be->compressed_pages`.

 fs/erofs/zdata.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a7e6847f6f8f..a33cd6757f98 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1309,12 +1309,11 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		put_page(page);
 	} else {
 		for (i = 0; i < pclusterpages; ++i) {
-			page = pcl->compressed_bvecs[i].page;
+			/* consider shortlived pages added when decompressing */
+			page = be->compressed_pages[i];
 
 			if (erofs_page_is_managed(sbi, page))
 				continue;
-
-			/* recycle all individual short-lived pages */
 			(void)z_erofs_put_shortlivedpage(be->pagepool, page);
 			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
 		}
-- 
2.39.3

