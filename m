Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E495579AF2E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350464AbjIKVim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbjIKNev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:34:51 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B3B106;
        Mon, 11 Sep 2023 06:34:47 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Rknkq2wrQz9sWC;
        Mon, 11 Sep 2023 15:34:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694439283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0WN7ulzjMpysFWDYCmd+jc2KprSgNcNXEQOmRucvEQI=;
        b=teeid22MXH+w10HGGofK/1vRz+6CBeRd2wRWCS+MBDUIjAT5NY1nMUrTmJgCAgkaetPWNX
        1/YyMGJ3RA8mPhSR5qWybpwzdBdp24pCPNvi5UhJwNj5ZUL9PDvzKFbVdUdYsjYE8IM9Gj
        RtEKjPPMEZItqXO79/TOKxiTg7IYoAoSoeQ9k/KCQ7ebLtVD4Ia6BiEFFQTafJlMJDqYWz
        XtlLn9hpYNoADus+IhNqkrHTVfQBLFS/+pL0Sdn7quhNGo7Dj6bLw6mX+NP9xCjmyjnZrs
        oryOhgib7zia2MWzUG8SqtjAgbyhEI9EJdvd1nrvoIEiFNIQJxIRPYZNAD7iww==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     minchan@kernel.org, senozhatsky@chromium.org
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        p.raghav@samsung.com, linux-block@vger.kernel.org,
        kernel@pankajraghav.com, gost.dev@samsung.com
Subject: [PATCH 4/5] zram: batch IOs during writeback to improve performance
Date:   Mon, 11 Sep 2023 15:34:29 +0200
Message-Id: <20230911133430.1824564-5-kernel@pankajraghav.com>
In-Reply-To: <20230911133430.1824564-1-kernel@pankajraghav.com>
References: <20230911133430.1824564-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Raghav <p.raghav@samsung.com>

This crosses off one of the TODO that was there as a part of
writeback_store() function:
A single page IO would be inefficient for write...

This reduces the time of writeback of 4G data to a nvme backing device from
68 secs to 15 secs (more than 4x improvement).

The idea is to batch the IOs until to a certain limit before the data is
flushed to the backing device. The batch limit is initially chosen based
on the bdi->io_pages value with an upper limit of 32 pages (128k on
x86). The limit is modified based writeback_limit, if set.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/zram/zram_drv.c | 186 +++++++++++++++++++++-------------
 1 file changed, 113 insertions(+), 73 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0b8f814e11dd..27313c2d781d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -551,22 +551,6 @@ static ssize_t backing_dev_store(struct device *dev,
 	return err;
 }
 
-static unsigned long alloc_block_bdev(struct zram *zram)
-{
-	unsigned long blk_idx = 1;
-retry:
-	/* skip 0 bit to confuse zram.handle = 0 */
-	blk_idx = find_next_zero_bit(zram->bitmap, zram->nr_pages, blk_idx);
-	if (blk_idx == zram->nr_pages)
-		return 0;
-
-	if (test_and_set_bit(blk_idx, zram->bitmap))
-		goto retry;
-
-	atomic64_inc(&zram->stats.bd_count);
-	return blk_idx;
-}
-
 static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
 {
 	int was_set;
@@ -628,6 +612,15 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 #define IDLE_WRITEBACK			(1<<1)
 #define INCOMPRESSIBLE_WRITEBACK	(1<<2)
 
+#define MAX_INDEX_ENTRIES_ORDER 5
+#define MAX_INDEX_ENTRIES (1U << MAX_INDEX_ENTRIES_ORDER)
+struct index_mapping {
+	/* Cap the maximum indices to 32 before we flush */
+	unsigned long arr[MAX_INDEX_ENTRIES];
+	unsigned int nr_of_entries;
+};
+
+
 /*
  * Returns: true if the index was prepared for further processing
  *          false if the index can be skipped
@@ -668,39 +661,36 @@ static bool writeback_prep_or_skip_index(struct zram *zram, int mode,
 	return ret;
 }
 
-static int writeback_flush_to_bdev(struct zram *zram, unsigned long index,
-				   struct page *page, unsigned long *blk_idx)
+static int writeback_flush_to_bdev(struct zram *zram, struct folio *folio,
+				   struct index_mapping *map,
+				   unsigned long blk_idx, unsigned int io_pages)
 {
 	struct bio bio;
 	struct bio_vec bio_vec;
-	int ret;
+	int ret = 0;
+
+	if (!map->nr_of_entries)
+		return ret;
 
 	bio_init(&bio, zram->bdev, &bio_vec, 1, REQ_OP_WRITE | REQ_SYNC);
-	bio.bi_iter.bi_sector = *blk_idx * (PAGE_SIZE >> 9);
-	__bio_add_page(&bio, page, PAGE_SIZE, 0);
+	bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
+
+	if (!bio_add_folio(&bio, folio, io_pages * PAGE_SIZE, 0))
+		goto cleanup;
 
-	/*
-	 * XXX: A single page IO would be inefficient for write
-	 * but it would be not bad as starter.
-	 */
 	ret = submit_bio_wait(&bio);
-	if (ret) {
-		zram_slot_lock(zram, index);
-		zram_clear_flag(zram, index, ZRAM_UNDER_WB);
-		zram_clear_flag(zram, index, ZRAM_IDLE);
-		zram_slot_unlock(zram, index);
-		/*
-		 * BIO errors are not fatal, we continue and simply
-		 * attempt to writeback the remaining objects (pages).
-		 * At the same time we need to signal user-space that
-		 * some writes (at least one, but also could be all of
-		 * them) were not successful and we do so by returning
-		 * the most recent BIO error.
-		 */
-		return ret;
-	}
+	/*
+	 * BIO errors are not fatal, we continue and simply
+	 * attempt to writeback the remaining objects (pages).
+	 * At the same time we need to signal user-space that
+	 * some writes (at least one, but also could be all of
+	 * them) were not successful and we do so by returning
+	 * the most recent BIO error.
+	 */
+	if (ret)
+		goto cleanup;
 
-	atomic64_inc(&zram->stats.bd_writes);
+	atomic64_add(map->nr_of_entries, &zram->stats.bd_writes);
 	/*
 	 * We released zram_slot_lock so need to check if the slot was
 	 * changed. If there is freeing for the slot, we can catch it
@@ -710,28 +700,40 @@ static int writeback_flush_to_bdev(struct zram *zram, unsigned long index,
 	 * mark ZRAM_IDLE once it found the slot was ZRAM_UNDER_WB.
 	 * Thus, we could close the race by checking ZRAM_IDLE bit.
 	 */
-	zram_slot_lock(zram, index);
-	if (!zram_allocated(zram, index) ||
-	    !zram_test_flag(zram, index, ZRAM_IDLE)) {
-		zram_clear_flag(zram, index, ZRAM_UNDER_WB);
-		zram_clear_flag(zram, index, ZRAM_IDLE);
-		goto skip;
+	for (int iter = 0; iter < map->nr_of_entries; iter++) {
+		zram_slot_lock(zram, map->arr[iter]);
+		if (!zram_allocated(zram, map->arr[iter]) ||
+		    !zram_test_flag(zram, map->arr[iter], ZRAM_IDLE)) {
+			zram_clear_flag(zram, map->arr[iter], ZRAM_UNDER_WB);
+			zram_clear_flag(zram, map->arr[iter], ZRAM_IDLE);
+			zram_slot_unlock(zram, map->arr[iter]);
+			free_block_bdev(zram, blk_idx + iter);
+			continue;
+		}
+
+		zram_free_page(zram, map->arr[iter]);
+		zram_clear_flag(zram, map->arr[iter], ZRAM_UNDER_WB);
+		zram_set_flag(zram, map->arr[iter], ZRAM_WB);
+		zram_set_element(zram, map->arr[iter], blk_idx + iter);
+		zram_slot_unlock(zram, map->arr[iter]);
+		atomic64_inc(&zram->stats.pages_stored);
+
+		spin_lock(&zram->wb_limit_lock);
+		if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
+			zram->bd_wb_limit -= 1UL << (PAGE_SHIFT - 12);
+		spin_unlock(&zram->wb_limit_lock);
 	}
+	return ret;
 
-	zram_free_page(zram, index);
-	zram_clear_flag(zram, index, ZRAM_UNDER_WB);
-	zram_set_flag(zram, index, ZRAM_WB);
-	zram_set_element(zram, index, *blk_idx);
-	atomic64_inc(&zram->stats.pages_stored);
-	*blk_idx = 0;
-
-	spin_lock(&zram->wb_limit_lock);
-	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
-		zram->bd_wb_limit -= 1UL << (PAGE_SHIFT - 12);
-	spin_unlock(&zram->wb_limit_lock);
-skip:
-	zram_slot_unlock(zram, index);
-	return 0;
+cleanup:
+	for (int iter = 0; iter < map->nr_of_entries; iter++) {
+		zram_slot_lock(zram, map->arr[iter]);
+		zram_clear_flag(zram, map->arr[iter], ZRAM_UNDER_WB);
+		zram_clear_flag(zram, map->arr[iter], ZRAM_IDLE);
+		zram_slot_unlock(zram, map->arr[iter]);
+	}
+	free_block_bdev_range(zram, blk_idx, map->nr_of_entries);
+	return ret;
 }
 
 static ssize_t writeback_store(struct device *dev,
@@ -741,9 +743,15 @@ static ssize_t writeback_store(struct device *dev,
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
 	unsigned long index = 0;
 	struct page *page;
+	struct folio *folio;
 	ssize_t ret = len;
 	int mode, err;
 	unsigned long blk_idx = 0;
+	unsigned int io_pages;
+	u64 bd_wb_limit_pages = ULONG_MAX;
+	struct index_mapping map = {};
+	unsigned int order = min(MAX_INDEX_ENTRIES_ORDER,
+				 ilog2(zram->bdev->bd_disk->bdi->io_pages));
 
 	if (sysfs_streq(buf, "idle"))
 		mode = IDLE_WRITEBACK;
@@ -776,32 +784,48 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	page = alloc_page(GFP_KERNEL);
-	if (!page) {
+	folio = folio_alloc(GFP_KERNEL, order);
+	if (!folio) {
 		ret = -ENOMEM;
 		goto release_init_lock;
 	}
 
 	for (; nr_pages != 0; index++, nr_pages--) {
 		spin_lock(&zram->wb_limit_lock);
-		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
-			spin_unlock(&zram->wb_limit_lock);
-			ret = -EIO;
-			break;
+		if (zram->wb_limit_enable) {
+			if (!zram->bd_wb_limit) {
+				spin_unlock(&zram->wb_limit_lock);
+				ret = -EIO;
+				break;
+			}
+			bd_wb_limit_pages = zram->bd_wb_limit >>
+					    (PAGE_SHIFT - 12);
 		}
 		spin_unlock(&zram->wb_limit_lock);
 
 		if (!blk_idx) {
-			blk_idx = alloc_block_bdev(zram);
+			io_pages = min(1UL << order, nr_pages);
+			io_pages = min_t(u64, bd_wb_limit_pages, io_pages);
+
+			blk_idx = alloc_block_bdev_range(zram, &io_pages);
 			if (!blk_idx) {
 				ret = -ENOSPC;
 				break;
 			}
 		}
 
-		if (!writeback_prep_or_skip_index(zram, mode, index))
-			continue;
+		if (!writeback_prep_or_skip_index(zram, mode, index)) {
+			if (nr_pages > 1 || map.nr_of_entries == 0)
+				continue;
+			/* There are still some unfinished IOs that
+			 * needs to be flushed
+			 */
+			err = writeback_flush_to_bdev(zram, folio, &map,
+						      blk_idx, io_pages);
+			goto next;
+		}
 
+		page = folio_page(folio, map.nr_of_entries);
 		if (zram_read_page(zram, page, index, NULL)) {
 			zram_slot_lock(zram, index);
 			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
@@ -810,15 +834,31 @@ static ssize_t writeback_store(struct device *dev,
 			continue;
 		}
 
-		err = writeback_flush_to_bdev(zram, index, page, &blk_idx);
+		map.arr[map.nr_of_entries++] = index;
+		if (map.nr_of_entries < io_pages)
+			continue;
 
+		err = writeback_flush_to_bdev(zram, folio, &map, blk_idx,
+					      io_pages);
+next:
 		if (err)
 			ret = err;
+
+		/*
+		 * Check if all the blocks have been utilized before
+		 * allocating the next batch. This is necessary to free
+		 * the unused blocks after looping through all indices.
+		 */
+		if (map.nr_of_entries == io_pages) {
+			blk_idx = 0;
+			map.nr_of_entries = 0;
+		}
 	}
 
 	if (blk_idx)
-		free_block_bdev(zram, blk_idx);
-	__free_page(page);
+		free_block_bdev_range(zram, blk_idx + map.nr_of_entries,
+				      io_pages - map.nr_of_entries);
+	folio_put(folio);
 release_init_lock:
 	up_read(&zram->init_lock);
 
-- 
2.40.1

