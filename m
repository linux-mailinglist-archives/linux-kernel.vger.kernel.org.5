Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7B579B1AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377500AbjIKW0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238031AbjIKNep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:34:45 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE71DCD7;
        Mon, 11 Sep 2023 06:34:39 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Rknkh1Cz9z9sqY;
        Mon, 11 Sep 2023 15:34:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694439276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKXrEFssCVb4iL+iRLOPhm9fa5JUtWNhHDnCVqBgNPc=;
        b=a+rOwbLDJ0Sf+xzYoZzSRlHvx9UHJnqj+mQVZDnY4zqvNEODoN/XYhwdhjLk4ZgWiYjj1N
        HpekzhvAisQ0yOeJC/Y9d4Oa6OZyrKxeFauCcz3dewg6KxTCn8otgbWvPnJsDS6ReTC1fA
        WY8b7BNPjuCa6UaQJPrVHHpWItY6WDxdLT7flVA6EAwA6yZKVsVSUILep8Mw1vxGyTghVz
        e0jdDb4xdCYtn7n2FlomMQNjAmiziLVVkwicfOTf5AS59l8W8F8nyrLO3l7rFGubeh3Nf1
        NsB1marZdTVTnRSOsQSA9cOZ1kaHRKUrt8tESFD9rpGFfxYPwmDyxRmebVnq0A==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     minchan@kernel.org, senozhatsky@chromium.org
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        p.raghav@samsung.com, linux-block@vger.kernel.org,
        kernel@pankajraghav.com, gost.dev@samsung.com
Subject: [PATCH 1/5] zram: move index preparation to a separate function in writeback_store
Date:   Mon, 11 Sep 2023 15:34:26 +0200
Message-Id: <20230911133430.1824564-2-kernel@pankajraghav.com>
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

Add a new function writeback_prep_or_skip_index() that does the check
and set the approapriate flags before writeback starts. The function
returns false if the index can be skipped.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/zram/zram_drv.c | 68 +++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 06673c6ca255..eaf9e227778e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -595,6 +595,46 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 #define IDLE_WRITEBACK			(1<<1)
 #define INCOMPRESSIBLE_WRITEBACK	(1<<2)
 
+/*
+ * Returns: true if the index was prepared for further processing
+ *          false if the index can be skipped
+ */
+static bool writeback_prep_or_skip_index(struct zram *zram, int mode,
+					 unsigned long index)
+{
+	bool ret = false;
+
+	zram_slot_lock(zram, index);
+	if (!zram_allocated(zram, index))
+		goto skip;
+
+	if (zram_test_flag(zram, index, ZRAM_WB) ||
+	    zram_test_flag(zram, index, ZRAM_SAME) ||
+	    zram_test_flag(zram, index, ZRAM_UNDER_WB))
+		goto skip;
+
+	if (mode & IDLE_WRITEBACK && !zram_test_flag(zram, index, ZRAM_IDLE))
+		goto skip;
+	if (mode & HUGE_WRITEBACK && !zram_test_flag(zram, index, ZRAM_HUGE))
+		goto skip;
+	if (mode & INCOMPRESSIBLE_WRITEBACK &&
+	    !zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
+		goto skip;
+
+	/*
+	 * Clearing ZRAM_UNDER_WB is duty of caller.
+	 * IOW, zram_free_page never clear it.
+	 */
+	zram_set_flag(zram, index, ZRAM_UNDER_WB);
+	/* Need for hugepage writeback racing */
+	zram_set_flag(zram, index, ZRAM_IDLE);
+
+	ret = true;
+skip:
+	zram_slot_unlock(zram, index);
+	return ret;
+}
+
 static ssize_t writeback_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
@@ -662,33 +702,9 @@ static ssize_t writeback_store(struct device *dev,
 			}
 		}
 
-		zram_slot_lock(zram, index);
-		if (!zram_allocated(zram, index))
-			goto next;
+		if (!writeback_prep_or_skip_index(zram, mode, index))
+			continue;
 
-		if (zram_test_flag(zram, index, ZRAM_WB) ||
-				zram_test_flag(zram, index, ZRAM_SAME) ||
-				zram_test_flag(zram, index, ZRAM_UNDER_WB))
-			goto next;
-
-		if (mode & IDLE_WRITEBACK &&
-		    !zram_test_flag(zram, index, ZRAM_IDLE))
-			goto next;
-		if (mode & HUGE_WRITEBACK &&
-		    !zram_test_flag(zram, index, ZRAM_HUGE))
-			goto next;
-		if (mode & INCOMPRESSIBLE_WRITEBACK &&
-		    !zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
-			goto next;
-
-		/*
-		 * Clearing ZRAM_UNDER_WB is duty of caller.
-		 * IOW, zram_free_page never clear it.
-		 */
-		zram_set_flag(zram, index, ZRAM_UNDER_WB);
-		/* Need for hugepage writeback racing */
-		zram_set_flag(zram, index, ZRAM_IDLE);
-		zram_slot_unlock(zram, index);
 		if (zram_read_page(zram, page, index, NULL)) {
 			zram_slot_lock(zram, index);
 			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
-- 
2.40.1

