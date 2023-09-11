Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9122479BC57
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjIKUwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbjIKNeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:34:50 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E798106;
        Mon, 11 Sep 2023 06:34:45 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Rknkm0ZMnz9ssn;
        Mon, 11 Sep 2023 15:34:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694439280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tX5Q/p2imNV6Vfwxh+ihQ2ZUaBdn0HxqAB6O7wq75t4=;
        b=A4rvocrwut8w3kDn9hrNosZg/hjRDt10YVYAjjnDvElcx/bLavMp1sppemaUFwSJ0n+p8U
        k0nB1Jk8AVaZSBBl3Lr22PZ7z5XhG4ZZ61JDBptPyPcTCpKQxrM0UFmiDipFo7kMXKdWGy
        +OAfZ3NQyUEm9NPzd9GAhi08xM3HnQJ0K56MVNvPvmJZqOwfUkP6Yyhnan0nx6osZabei9
        CicvRQ9Ai5edtrYhe6x9HU8lNfX9DPYYqJI79ozUcrmI6vGNywf3qe07gXCOJShsyLoeFa
        rJ7TPfBejw7Fu0b9dRrpNVj/nRARjzzYylP5TP+dXHMYCvQUUkGih51d74Rn9A==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     minchan@kernel.org, senozhatsky@chromium.org
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        p.raghav@samsung.com, linux-block@vger.kernel.org,
        kernel@pankajraghav.com, gost.dev@samsung.com
Subject: [PATCH 3/5] zram: add alloc_block_bdev_range() and free_block_bdev_range()
Date:   Mon, 11 Sep 2023 15:34:28 +0200
Message-Id: <20230911133430.1824564-4-kernel@pankajraghav.com>
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

Add [alloc|free]_block_bdev_range() which accepts number of blocks to
allocate or free from the block bitmap.

alloc_block_bdev_range() tries to allocate a range of bitmap based in
the input nr_of_blocks whenever possible, or else it will retry with a
smaller value. This is done so that we don't unnecessarily return EIO
when the underlying device is fragmented.

alloc_block_bdev_range() is not an atomic operation as this function can
be called only from writeback_store() and init_lock is anyway taken
making sure there cannot be two processes allocating from bdev bitmap.

free_block_bdev_range() is just a simple loop that calls the atomic
free_block_bdev() function. As bdev bitmap free can be called from
two different process simulataneously without a lock, atomicity needs
to be maintained.

This is useful when we want to send larger IOs to the backing dev.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/zram/zram_drv.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index bd93ed653b99..0b8f814e11dd 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -576,6 +576,39 @@ static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
 	atomic64_dec(&zram->stats.bd_count);
 }
 
+static unsigned long alloc_block_bdev_range(struct zram *zram,
+					    unsigned int *nr_of_blocksp)
+{
+	unsigned long blk_idx;
+	unsigned int nr_of_blocks = *nr_of_blocksp;
+retry:
+	/* skip 0 bit to confuse zram.handle = 0 */
+	blk_idx = 1;
+	blk_idx = bitmap_find_next_zero_area(zram->bitmap, zram->nr_pages,
+					     blk_idx, nr_of_blocks, 0);
+
+	if ((blk_idx + nr_of_blocks) > zram->nr_pages) {
+		if (nr_of_blocks == 1)
+			return 0;
+
+		nr_of_blocks = nr_of_blocks / 2;
+		goto retry;
+	}
+
+	bitmap_set(zram->bitmap, blk_idx, nr_of_blocks);
+	atomic64_add(nr_of_blocks, &zram->stats.bd_count);
+	*nr_of_blocksp = nr_of_blocks;
+
+	return blk_idx;
+}
+
+static void free_block_bdev_range(struct zram *zram, unsigned long blk_idx,
+				  unsigned int nr_of_blocks)
+{
+	for (unsigned int i = 0; i < nr_of_blocks; i++)
+		free_block_bdev(zram, blk_idx + i);
+}
+
 static void read_from_bdev_async(struct zram *zram, struct page *page,
 			unsigned long entry, struct bio *parent)
 {
-- 
2.40.1

