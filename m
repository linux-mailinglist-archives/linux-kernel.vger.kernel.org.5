Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07577F79F7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345836AbjKXRBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345801AbjKXRA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:00:29 -0500
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D161BC8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:00:30 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700845228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QWk7YTMvB3DTfZc9sNUwNxdg+CAbRo1hOQbqO2wSQ6A=;
        b=YS/3MDkQDJLZ1KOe1iNDAZDteB/JflqObZ/sxnSGYirEVXMmWDGjQitpPoxMWbwITRRGcK
        lCaiEJ8jACRUkhE5INGw8DLQ17uYGYUcBA+kCBAPjM3CKQX83iJY0AdVDX5aUYv45OjLes
        yYiDU6Zy3ApLCGmeU0KMq1smX6MXIK4=
From:   Sergei Shtepa <sergei.shtepa@linux.dev>
To:     axboe@kernel.dk, hch@infradead.org, corbet@lwn.net,
        snitzer@kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sergei Shtepa <sergei.shtepa@veeam.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v6 11/11] blksnap: prevents using devices with data integrity or inline encryption
Date:   Fri, 24 Nov 2023 17:59:33 +0100
Message-Id: <20231124165933.27580-12-sergei.shtepa@linux.dev>
In-Reply-To: <20231124165933.27580-1-sergei.shtepa@linux.dev>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtepa <sergei.shtepa@veeam.com>

There is an opinion that the use of the blksnap module may violate the
security of encrypted data. The difference storage file may be located
on an unreliable disk or even network storage. To implement secure
compatibility with hardware inline encrypted devices will require
discussion of algorithms and restrictions. For example, a restriction
on the location of the difference storage only in virtual memory might
help. Currently, there is no need for compatibility of the blksnap
module and hardware inline encryption.

I see no obstacles to ensuring the compatibility of the blksnap module
and block devices with data integrity. However, this functionality was
not planned or tested. Perhaps in the future this compatibility can be
implemented.

Theoretically possible that the block device was added to the snapshot
before crypto_profile and integrity.profile were initialized.
Checking the values of bi_crypt_context and bi_integrity ensures that
the blksnap will not perform any actions with I/O units with which it
is not compatible.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/snapshot.c | 17 +++++++++++++++++
 drivers/block/blksnap/tracker.c  | 14 ++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/block/blksnap/snapshot.c b/drivers/block/blksnap/snapshot.c
index 21d94f12b5fc..a7675fdcf359 100644
--- a/drivers/block/blksnap/snapshot.c
+++ b/drivers/block/blksnap/snapshot.c
@@ -149,6 +149,23 @@ int snapshot_add_device(const uuid_t *id, struct tracker *tracker)
 	int ret = 0;
 	struct snapshot *snapshot = NULL;
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	if (tracker->orig_bdev->bd_disk->queue->integrity.profile) {
+		pr_err("Blksnap is not compatible with data integrity\n");
+		ret = -EPERM;
+		goto out_up;
+	} else
+		pr_debug("Data integrity not found\n");
+#endif
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	if (tracker->orig_bdev->bd_disk->queue->crypto_profile) {
+		pr_err("Blksnap is not compatible with hardware inline encryption\n");
+		ret = -EPERM;
+		goto out_up;
+	} else
+		pr_debug("Inline encryption not found\n");
+#endif
 	snapshot = snapshot_get_by_id(id);
 	if (!snapshot)
 		return -ESRCH;
diff --git a/drivers/block/blksnap/tracker.c b/drivers/block/blksnap/tracker.c
index 2b8978a2f42e..b38ead9afa69 100644
--- a/drivers/block/blksnap/tracker.c
+++ b/drivers/block/blksnap/tracker.c
@@ -57,6 +57,20 @@ static bool tracker_submit_bio(struct bio *bio)
 	if (diff_area_is_corrupted(tracker->diff_area))
 		return false;
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	if (bio->bi_crypt_context) {
+		pr_err_once("Hardware inline encryption is not supported\n");
+		diff_area_set_corrupted(tracker->diff_area, -EPERM);
+		return false;
+	}
+#endif
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	if (bio->bi_integrity) {
+		pr_err_once("Data integrity is not supported\n");
+		diff_area_set_corrupted(tracker->diff_area, -EPERM);
+		return false;
+	}
+#endif
 	return diff_area_cow(bio, tracker->diff_area, &copy_iter);
 }
 
-- 
2.20.1

