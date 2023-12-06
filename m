Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD44B806A6C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346772AbjLFJLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346770AbjLFJLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:11:12 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4320D10C1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:11:18 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VxxSRQT_1701853874;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VxxSRQT_1701853874)
          by smtp.aliyun-inc.com;
          Wed, 06 Dec 2023 17:11:15 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>, dhavale@google.com,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 4/5] erofs: refine z_erofs_transform_plain() for sub-page block support
Date:   Wed,  6 Dec 2023 17:10:56 +0800
Message-Id: <20231206091057.87027-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
References: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
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

Sub-page block support is still unusable even with previous commits if
interlaced PLAIN pclusters exist.  Such pclusters can be found if the
fragment feature is enabled.

This commit tries to handle "the head part" of interlaced PLAIN
pclusters first: it was once explained in commit fdffc091e6f9 ("erofs:
support interlaced uncompressed data for compressed files").

It uses a unique way for both shifted and interlaced PLAIN pclusters.
As an added bonus, PLAIN pclusters larger than the block size is also
supported now for the upcoming large lclusters.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor.c | 81 ++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 33 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 021be5feb1bc..5ec11f5024b7 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -319,43 +319,58 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 				   struct page **pagepool)
 {
-	const unsigned int inpages = PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT;
-	const unsigned int outpages =
+	const unsigned int nrpages_in =
+		PAGE_ALIGN(rq->pageofs_in + rq->inputsize) >> PAGE_SHIFT;
+	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
-	const unsigned int righthalf = min_t(unsigned int, rq->outputsize,
-					     PAGE_SIZE - rq->pageofs_out);
-	const unsigned int lefthalf = rq->outputsize - righthalf;
-	const unsigned int interlaced_offset =
-		rq->alg == Z_EROFS_COMPRESSION_SHIFTED ? 0 : rq->pageofs_out;
-	u8 *src;
-
-	if (outpages > 2 && rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
-	}
-
-	if (rq->out[0] == *rq->in) {
-		DBG_BUGON(rq->pageofs_out);
-		return 0;
+	const unsigned int bs = rq->sb->s_blocksize;
+	unsigned int cur = 0, ni = 0, no, pi, po, insz, cnt;
+	u8 *kin;
+
+	DBG_BUGON(rq->outputsize > rq->inputsize);
+	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
+		cur = bs - (rq->pageofs_out & (bs - 1));
+		pi = (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;
+		cur = min(cur, rq->outputsize);
+		if (cur && rq->out[0]) {
+			kin = kmap_local_page(rq->in[nrpages_in - 1]);
+			if (rq->out[0] == rq->in[nrpages_in - 1]) {
+				memmove(kin + rq->pageofs_out, kin + pi, cur);
+				flush_dcache_page(rq->out[0]);
+			} else {
+				memcpy_to_page(rq->out[0], rq->pageofs_out,
+					       kin + pi, cur);
+			}
+			kunmap_local(kin);
+		}
+		rq->outputsize -= cur;
 	}
 
-	src = kmap_local_page(rq->in[inpages - 1]) + rq->pageofs_in;
-	if (rq->out[0])
-		memcpy_to_page(rq->out[0], rq->pageofs_out,
-			       src + interlaced_offset, righthalf);
-
-	if (outpages > inpages) {
-		DBG_BUGON(!rq->out[outpages - 1]);
-		if (rq->out[outpages - 1] != rq->in[inpages - 1]) {
-			memcpy_to_page(rq->out[outpages - 1], 0, src +
-					(interlaced_offset ? 0 : righthalf),
-				       lefthalf);
-		} else if (!interlaced_offset) {
-			memmove(src, src + righthalf, lefthalf);
-			flush_dcache_page(rq->in[inpages - 1]);
-		}
+	for (; rq->outputsize; rq->pageofs_in = 0, cur += PAGE_SIZE, ni++) {
+		insz = min(PAGE_SIZE - rq->pageofs_in, rq->outputsize);
+		rq->outputsize -= insz;
+		if (!rq->in[ni])
+			continue;
+		kin = kmap_local_page(rq->in[ni]);
+		pi = 0;
+		do {
+			no = (rq->pageofs_out + cur + pi) >> PAGE_SHIFT;
+			po = (rq->pageofs_out + cur + pi) & ~PAGE_MASK;
+			DBG_BUGON(no >= nrpages_out);
+			cnt = min(insz - pi, PAGE_SIZE - po);
+			if (rq->out[no] == rq->in[ni]) {
+				memmove(kin + po,
+					kin + rq->pageofs_in + pi, cnt);
+				flush_dcache_page(rq->out[no]);
+			} else if (rq->out[no]) {
+				memcpy_to_page(rq->out[no], po,
+					       kin + rq->pageofs_in + pi, cnt);
+			}
+			pi += cnt;
+		} while (pi < insz);
+		kunmap_local(kin);
 	}
-	kunmap_local(src);
+	DBG_BUGON(ni > nrpages_in);
 	return 0;
 }
 
-- 
2.39.3

