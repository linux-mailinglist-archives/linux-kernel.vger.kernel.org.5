Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D077758E27
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjGSGzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjGSGzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:55:10 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105B61BFC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:55:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vnkhvgd_1689749700;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vnkhvgd_1689749700)
          by smtp.aliyun-inc.com;
          Wed, 19 Jul 2023 14:55:06 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Shijie Sun <sunshijie@xiaomi.com>
Subject: [PATCH] erofs: fix wrong primary bvec selection on deduplicated extents
Date:   Wed, 19 Jul 2023 14:54:59 +0800
Message-Id: <20230719065459.60083-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

When handling deduplicated compressed data, there can be multiple
decompressed extents pointing to the same compressed data in one shot.

In such cases, the bvecs which belong to the longest extent will be
selected as the primary bvecs for real decompressors to decode and the
other duplicated bvecs will be directly copied from the primary bvecs.

Previously, only relative offsets of the longest extent was checked to
decompress the primary bvecs.  On rare occasions, it can be incorrect
if there are several extents with the same start relative offset.
As a result, some short bvecs could be selected for decompression and
then cause data corruption.

For example, as Shijie Sun reported off-list, considering the following
extents of a file:
 117:   903345..  915250 |   11905 :     385024..    389120 |    4096
...
 119:   919729..  930323 |   10594 :     385024..    389120 |    4096
...
 124:   968881..  980786 |   11905 :     385024..    389120 |    4096

The start relative offset is the same: 2225, but extent 119 (919729..
930323) is shorter than the others.

Let's restrict the bvec length in addition to the start offset if bvecs
are not full.

Reported-by: Shijie Sun <sunshijie@xiaomi.com>
Fixes: 5c2a64252c5d ("erofs: introduce partial-referenced pclusters")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index b69d89a11dd0..de4f12152b62 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1144,10 +1144,11 @@ static void z_erofs_do_decompressed_bvec(struct z_erofs_decompress_backend *be,
 					 struct z_erofs_bvec *bvec)
 {
 	struct z_erofs_bvec_item *item;
+	unsigned int pgnr;
 
-	if (!((bvec->offset + be->pcl->pageofs_out) & ~PAGE_MASK)) {
-		unsigned int pgnr;
-
+	if (!((bvec->offset + be->pcl->pageofs_out) & ~PAGE_MASK) &&
+	    (bvec->end == PAGE_SIZE ||
+	     bvec->offset + bvec->end == be->pcl->length)) {
 		pgnr = (bvec->offset + be->pcl->pageofs_out) >> PAGE_SHIFT;
 		DBG_BUGON(pgnr >= be->nr_pages);
 		if (!be->decompressed_pages[pgnr]) {
-- 
2.24.4

