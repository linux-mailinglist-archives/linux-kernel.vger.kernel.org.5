Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1D6803FB8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346227AbjLDUfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346219AbjLDUex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:34:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE011A6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:34:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55A9C433CC;
        Mon,  4 Dec 2023 20:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722052;
        bh=PGvdhsaMBMYO+a/7wVrzlPR3gLeQ5lkgOcpsQ7exj7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQfHhGBatVYZl/v4UUhTuuVQvPlpOvQbG7YyiahZTa1JrLQKpvZ6YX/6tMO0yhi1l
         su5RwV5DxpOhXEv3C/r8Untse3WtPMkak7ETFvaE/rdPDfeTtaMfd7E4fDJK6EKhHx
         RnHdeqXoBAPdu99vAyvrBi4FAoFVrw/lmEZj2NrZ7W6VrALbmVtWM2OlkrKd91ieAt
         HW4ZlwaqrcxE0fNWIJOOnhqzy7PTKncMEfPSDXzF1GIHUt7hNtMnkOhbFjnc8PzwjM
         yjfNGimMAd89GD7e1GBOBAZUp86jaSRHKcJFSPfYwGR94huK1aOboGlwNPIQZ+E2wn
         01Dt0u3yVUVEg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 22/32] block: warn once for each partition in bio_check_ro()
Date:   Mon,  4 Dec 2023 15:32:42 -0500
Message-ID: <20231204203317.2092321-22-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 67d995e069535c32829f5d368d919063492cec6e ]

Commit 1b0a151c10a6 ("blk-core: use pr_warn_ratelimited() in
bio_check_ro()") fix message storm by limit the rate, however, there
will still be lots of message in the long term. Fix it better by warn
once for each partition.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20231128123027.971610-3-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-core.c          | 14 +++++++++++---
 include/linux/blk_types.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fdf25b8d6e784..2eca76ccf4ee0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -501,9 +501,17 @@ static inline void bio_check_ro(struct bio *bio)
 	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev)) {
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
 			return;
-		pr_warn_ratelimited("Trying to write to read-only block-device %pg\n",
-				    bio->bi_bdev);
-		/* Older lvm-tools actually trigger this */
+
+		if (bio->bi_bdev->bd_ro_warned)
+			return;
+
+		bio->bi_bdev->bd_ro_warned = true;
+		/*
+		 * Use ioctl to set underlying disk of raid/dm to read-only
+		 * will trigger this.
+		 */
+		pr_warn("Trying to write to read-only block-device %pg\n",
+			bio->bi_bdev);
 	}
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d5c5e59ddbd25..92c8997b19381 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -69,6 +69,7 @@ struct block_device {
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	bool			bd_make_it_fail;
 #endif
+	bool			bd_ro_warned;
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
 	 * path
-- 
2.42.0

