Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00900796FC5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 07:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbjIGFGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 01:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjIGFF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 01:05:59 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3D3CF9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 22:05:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VrWCVhu_1694063143;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VrWCVhu_1694063143)
          by smtp.aliyun-inc.com;
          Thu, 07 Sep 2023 13:05:48 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: fix memory leak of LZMA global compressed deduplication
Date:   Thu,  7 Sep 2023 13:05:42 +0800
Message-Id: <20230907050542.97152-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When stressing microLZMA EROFS images with the new global compressed
deduplication feature enabled (`-Ededupe`), I found some short-lived
temporary pages weren't properly released, which could slowly cause
unexpected OOMs hours later.

Let's fix it now (LZ4 and DEFLATE don't have this issue.)

Fixes: 5c2a64252c5d ("erofs: introduce partial-referenced pclusters")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor_lzma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 73091fbe3ea4..dee10d22ada9 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -217,9 +217,12 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 			strm->buf.out_size = min_t(u32, outlen,
 						   PAGE_SIZE - pageofs);
 			outlen -= strm->buf.out_size;
-			if (!rq->out[no] && rq->fillgaps)	/* deduped */
+			if (!rq->out[no] && rq->fillgaps) {	/* deduped */
 				rq->out[no] = erofs_allocpage(pagepool,
 						GFP_KERNEL | __GFP_NOFAIL);
+				set_page_private(rq->out[no],
+						 Z_EROFS_SHORTLIVED_PAGE);
+			}
 			if (rq->out[no])
 				strm->buf.out = kmap(rq->out[no]) + pageofs;
 			pageofs = 0;
-- 
2.24.4

