Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F1C79B26E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbjIKV7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbjIKNey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:34:54 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECD8125;
        Mon, 11 Sep 2023 06:34:48 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Rknks1V17z9sp2;
        Mon, 11 Sep 2023 15:34:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694439285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sM0TCUwtp+I4p1Y7f2I/GJmIKW0adFKaWbv7dHHJV3w=;
        b=wjU43JN0vndUzN5R2PGvxnW0lcgnOeQ1yjXd7a06tIbLqiXTx3K2by5tBsNzBdYBTy0cKe
        F8N/5ya9dkiG58yv1tgWKX3S41c18l6/1kzc3c86cdomo4+cb8q8jrSiNsgCedrbmbYohZ
        X9lg0DBCvT7EYBqe9cvBiOZ5d7461YqAHvmu/3FtyTDveluBuFf1buxSuYVwCklEKqDM1f
        l0CzTxfxDKC6RHMaegLTnqZhDIz7Z05c/4BSVSzqmznCZXNBso7RaAcGrDg2eYwtlOJ7ew
        IAWE54eVw1QWTVOzO1oJF+EysxhE1RVpgrSZ/HqS5Giz4W6GT8IoRAowzwv5nw==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     minchan@kernel.org, senozhatsky@chromium.org
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        p.raghav@samsung.com, linux-block@vger.kernel.org,
        kernel@pankajraghav.com, gost.dev@samsung.com
Subject: [PATCH 5/5] zram: don't overload blk_idx variable in writeback_store()
Date:   Mon, 11 Sep 2023 15:34:30 +0200
Message-Id: <20230911133430.1824564-6-kernel@pankajraghav.com>
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

Instead of overloading blk_idx variable to find if it was allocated and
used, add a new boolean variable blk_allocated.

No functional changes.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/zram/zram_drv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 27313c2d781d..7c1420e92c6a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -747,6 +747,7 @@ static ssize_t writeback_store(struct device *dev,
 	ssize_t ret = len;
 	int mode, err;
 	unsigned long blk_idx = 0;
+	bool blk_allocated = false;
 	unsigned int io_pages;
 	u64 bd_wb_limit_pages = ULONG_MAX;
 	struct index_mapping map = {};
@@ -803,7 +804,7 @@ static ssize_t writeback_store(struct device *dev,
 		}
 		spin_unlock(&zram->wb_limit_lock);
 
-		if (!blk_idx) {
+		if (!blk_allocated) {
 			io_pages = min(1UL << order, nr_pages);
 			io_pages = min_t(u64, bd_wb_limit_pages, io_pages);
 
@@ -812,6 +813,7 @@ static ssize_t writeback_store(struct device *dev,
 				ret = -ENOSPC;
 				break;
 			}
+			blk_allocated = true;
 		}
 
 		if (!writeback_prep_or_skip_index(zram, mode, index)) {
@@ -850,12 +852,12 @@ static ssize_t writeback_store(struct device *dev,
 		 * the unused blocks after looping through all indices.
 		 */
 		if (map.nr_of_entries == io_pages) {
-			blk_idx = 0;
+			blk_allocated = false;
 			map.nr_of_entries = 0;
 		}
 	}
 
-	if (blk_idx)
+	if (blk_allocated)
 		free_block_bdev_range(zram, blk_idx + map.nr_of_entries,
 				      io_pages - map.nr_of_entries);
 	folio_put(folio);
-- 
2.40.1

