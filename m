Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D23770DF7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 07:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjHEFzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 01:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEFzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 01:55:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83464ECF;
        Fri,  4 Aug 2023 22:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VVm3P3asI3oviVAO++8ExuHX7bAYG9Ho51gp9OdQ6NM=; b=TbPmkFKgpaXQa0E52oU9HdcUKC
        jCrORP6DdR7WbwmTMEds8TnHwFPcH7hb+uyOV719HKMk/lX2fipLeAbsoMqy7qLrrQvf2kR+EoG4P
        InqyaK9QajFnU5tGDVCylEI6FyeQ1OWDEaXVgdI6MzyeaOQPgnzDtNXn331e93qYUQSzcivsogP5e
        DGovxpMfl2CO8rPjji0OdjkQLAuB/bAR0TO3VGcs/FfdukthVBP+eflfH+vAB/l5Djpam9T9k0dqQ
        1TjhNKroyWnNj98pwxuoYx3faQdQsS1bEFFQ+FL14KvMrdy6h6KaWBOTpAMDz4Nx2pzmRDod0p/H1
        8fIynSWw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qSAGL-00DjuF-09;
        Sat, 05 Aug 2023 05:55:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     minchan@kernel.org, senozhatsky@chromium.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dusty Mabe <dusty@dustymabe.com>
Subject: [PATCH] zram: take device and not only bvec offset into account
Date:   Sat,  5 Aug 2023 07:55:37 +0200
Message-Id: <20230805055537.147835-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit af8b04c63708 ("zram: simplify bvec iteration in
__zram_make_request") changed the bio iteration in zram to rely on the
implicit capping to page boundaries in bio_for_each_segment.  But it
failed to care for the fact zram not only care about the page alignment
of the bio payload, but also the page alignment into the device.  For
buffered I/O and swap those are the same, but for direct I/O or kernel
internal I/O like XFS log buffer writes they can differ.

Fix this by open coding bio_for_each_segment and limiting the bvec len
so that it never crosses over a page alignment boundary in the device
in addition to the payload boundary already taken care of by
bio_iter_iovec.

Fixes: af8b04c63708 ("zram: simplify bvec iteration in __zram_make_request")
Reported-by: Dusty Mabe <dusty@dustymabe.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5676e6dd5b1672..06673c6ca25555 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1870,15 +1870,16 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
 
 static void zram_bio_read(struct zram *zram, struct bio *bio)
 {
-	struct bvec_iter iter;
-	struct bio_vec bv;
-	unsigned long start_time;
+	unsigned long start_time = bio_start_io_acct(bio);
+	struct bvec_iter iter = bio->bi_iter;
 
-	start_time = bio_start_io_acct(bio);
-	bio_for_each_segment(bv, bio, iter) {
+	do {
 		u32 index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
 		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
 				SECTOR_SHIFT;
+		struct bio_vec bv = bio_iter_iovec(bio, iter);
+
+		bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
 
 		if (zram_bvec_read(zram, &bv, index, offset, bio) < 0) {
 			atomic64_inc(&zram->stats.failed_reads);
@@ -1890,22 +1891,26 @@ static void zram_bio_read(struct zram *zram, struct bio *bio)
 		zram_slot_lock(zram, index);
 		zram_accessed(zram, index);
 		zram_slot_unlock(zram, index);
-	}
+
+		bio_advance_iter_single(bio, &iter, bv.bv_len);
+	} while (iter.bi_size);
+
 	bio_end_io_acct(bio, start_time);
 	bio_endio(bio);
 }
 
 static void zram_bio_write(struct zram *zram, struct bio *bio)
 {
-	struct bvec_iter iter;
-	struct bio_vec bv;
-	unsigned long start_time;
+	unsigned long start_time = bio_start_io_acct(bio);
+	struct bvec_iter iter = bio->bi_iter;
 
-	start_time = bio_start_io_acct(bio);
-	bio_for_each_segment(bv, bio, iter) {
+	do {
 		u32 index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
 		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
 				SECTOR_SHIFT;
+		struct bio_vec bv = bio_iter_iovec(bio, iter);
+
+		bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
 
 		if (zram_bvec_write(zram, &bv, index, offset, bio) < 0) {
 			atomic64_inc(&zram->stats.failed_writes);
@@ -1916,7 +1921,10 @@ static void zram_bio_write(struct zram *zram, struct bio *bio)
 		zram_slot_lock(zram, index);
 		zram_accessed(zram, index);
 		zram_slot_unlock(zram, index);
-	}
+
+		bio_advance_iter_single(bio, &iter, bv.bv_len);
+	} while (iter.bi_size);
+
 	bio_end_io_acct(bio, start_time);
 	bio_endio(bio);
 }
-- 
2.39.2

