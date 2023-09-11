Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40A779B97B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245298AbjIKVJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238030AbjIKNeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:34:44 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80B5125;
        Mon, 11 Sep 2023 06:34:39 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Rknkk1MxMz9slY;
        Mon, 11 Sep 2023 15:34:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694439278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BXAvZHy82SoCVQaKv/cbU0xLnaVu+pzPidj59xLN5A8=;
        b=cu7s4m08t6I65Ck7rZOpE28zXVayV5lInSJ72/6vzTSz8wjACsQpffctcc75NXzi7655Yq
        zQpVCUGLw9hB8sY1icjF1R0cGQqaHwQj+2/dRw2528KW+prXimhzVmfA7udgodWOLxfJ2m
        mSzEAcDZK1V4+LS7wCFt+CDLoCjqQDiarfEZksvFz0fxmyz4d7CcbrflquuE2LOmjeIRzI
        Fg3Al6gxwuBWYgoIWyp9KdFq7NY2uAmQBKMLCrMPRhaf1A2R+QJQDBFU8DOU6lmuNQefta
        NR5kiGRq5pW3kD8VM6CDFY2WyAs9EYA9Nxwv9EjeowvpUAwYGc4dMbd2NXPo6A==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     minchan@kernel.org, senozhatsky@chromium.org
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        p.raghav@samsung.com, linux-block@vger.kernel.org,
        kernel@pankajraghav.com, gost.dev@samsung.com
Subject: [PATCH 2/5] zram: encapsulate writeback to the backing bdev in a function
Date:   Mon, 11 Sep 2023 15:34:27 +0200
Message-Id: <20230911133430.1824564-3-kernel@pankajraghav.com>
In-Reply-To: <20230911133430.1824564-1-kernel@pankajraghav.com>
References: <20230911133430.1824564-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Rknkk1MxMz9slY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Raghav <p.raghav@samsung.com>

Encapsulate the flushing data to the backing bdev in writeback in a
separate function writeback_flush_to_bdev(). This is in preparation for
adding batching IO support to writeback_store().

No functional changes.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/zram/zram_drv.c | 125 ++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 57 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index eaf9e227778e..bd93ed653b99 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -635,14 +635,78 @@ static bool writeback_prep_or_skip_index(struct zram *zram, int mode,
 	return ret;
 }
 
+static int writeback_flush_to_bdev(struct zram *zram, unsigned long index,
+				   struct page *page, unsigned long *blk_idx)
+{
+	struct bio bio;
+	struct bio_vec bio_vec;
+	int ret;
+
+	bio_init(&bio, zram->bdev, &bio_vec, 1, REQ_OP_WRITE | REQ_SYNC);
+	bio.bi_iter.bi_sector = *blk_idx * (PAGE_SIZE >> 9);
+	__bio_add_page(&bio, page, PAGE_SIZE, 0);
+
+	/*
+	 * XXX: A single page IO would be inefficient for write
+	 * but it would be not bad as starter.
+	 */
+	ret = submit_bio_wait(&bio);
+	if (ret) {
+		zram_slot_lock(zram, index);
+		zram_clear_flag(zram, index, ZRAM_UNDER_WB);
+		zram_clear_flag(zram, index, ZRAM_IDLE);
+		zram_slot_unlock(zram, index);
+		/*
+		 * BIO errors are not fatal, we continue and simply
+		 * attempt to writeback the remaining objects (pages).
+		 * At the same time we need to signal user-space that
+		 * some writes (at least one, but also could be all of
+		 * them) were not successful and we do so by returning
+		 * the most recent BIO error.
+		 */
+		return ret;
+	}
+
+	atomic64_inc(&zram->stats.bd_writes);
+	/*
+	 * We released zram_slot_lock so need to check if the slot was
+	 * changed. If there is freeing for the slot, we can catch it
+	 * easily by zram_allocated.
+	 * A subtle case is the slot is freed/reallocated/marked as
+	 * ZRAM_IDLE again. To close the race, idle_store doesn't
+	 * mark ZRAM_IDLE once it found the slot was ZRAM_UNDER_WB.
+	 * Thus, we could close the race by checking ZRAM_IDLE bit.
+	 */
+	zram_slot_lock(zram, index);
+	if (!zram_allocated(zram, index) ||
+	    !zram_test_flag(zram, index, ZRAM_IDLE)) {
+		zram_clear_flag(zram, index, ZRAM_UNDER_WB);
+		zram_clear_flag(zram, index, ZRAM_IDLE);
+		goto skip;
+	}
+
+	zram_free_page(zram, index);
+	zram_clear_flag(zram, index, ZRAM_UNDER_WB);
+	zram_set_flag(zram, index, ZRAM_WB);
+	zram_set_element(zram, index, *blk_idx);
+	atomic64_inc(&zram->stats.pages_stored);
+	*blk_idx = 0;
+
+	spin_lock(&zram->wb_limit_lock);
+	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
+		zram->bd_wb_limit -= 1UL << (PAGE_SHIFT - 12);
+	spin_unlock(&zram->wb_limit_lock);
+skip:
+	zram_slot_unlock(zram, index);
+	return 0;
+}
+
 static ssize_t writeback_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
 	unsigned long index = 0;
-	struct bio bio;
-	struct bio_vec bio_vec;
 	struct page *page;
 	ssize_t ret = len;
 	int mode, err;
@@ -713,63 +777,10 @@ static ssize_t writeback_store(struct device *dev,
 			continue;
 		}
 
-		bio_init(&bio, zram->bdev, &bio_vec, 1,
-			 REQ_OP_WRITE | REQ_SYNC);
-		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
-		__bio_add_page(&bio, page, PAGE_SIZE, 0);
+		err = writeback_flush_to_bdev(zram, index, page, &blk_idx);
 
-		/*
-		 * XXX: A single page IO would be inefficient for write
-		 * but it would be not bad as starter.
-		 */
-		err = submit_bio_wait(&bio);
-		if (err) {
-			zram_slot_lock(zram, index);
-			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
-			zram_clear_flag(zram, index, ZRAM_IDLE);
-			zram_slot_unlock(zram, index);
-			/*
-			 * BIO errors are not fatal, we continue and simply
-			 * attempt to writeback the remaining objects (pages).
-			 * At the same time we need to signal user-space that
-			 * some writes (at least one, but also could be all of
-			 * them) were not successful and we do so by returning
-			 * the most recent BIO error.
-			 */
+		if (err)
 			ret = err;
-			continue;
-		}
-
-		atomic64_inc(&zram->stats.bd_writes);
-		/*
-		 * We released zram_slot_lock so need to check if the slot was
-		 * changed. If there is freeing for the slot, we can catch it
-		 * easily by zram_allocated.
-		 * A subtle case is the slot is freed/reallocated/marked as
-		 * ZRAM_IDLE again. To close the race, idle_store doesn't
-		 * mark ZRAM_IDLE once it found the slot was ZRAM_UNDER_WB.
-		 * Thus, we could close the race by checking ZRAM_IDLE bit.
-		 */
-		zram_slot_lock(zram, index);
-		if (!zram_allocated(zram, index) ||
-			  !zram_test_flag(zram, index, ZRAM_IDLE)) {
-			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
-			zram_clear_flag(zram, index, ZRAM_IDLE);
-			goto next;
-		}
-
-		zram_free_page(zram, index);
-		zram_clear_flag(zram, index, ZRAM_UNDER_WB);
-		zram_set_flag(zram, index, ZRAM_WB);
-		zram_set_element(zram, index, blk_idx);
-		blk_idx = 0;
-		atomic64_inc(&zram->stats.pages_stored);
-		spin_lock(&zram->wb_limit_lock);
-		if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
-			zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
-		spin_unlock(&zram->wb_limit_lock);
-next:
-		zram_slot_unlock(zram, index);
 	}
 
 	if (blk_idx)
-- 
2.40.1

