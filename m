Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A00759236
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjGSJ7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjGSJ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:58:59 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AE7EC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:58:58 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R5WRw64D0zLnrr;
        Wed, 19 Jul 2023 17:56:28 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:58:55 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>
CC:     <sidhartha.kumar@oracle.com>, <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v2 3/9] mm/page_io: convert bio_first_page_all() to bio_first_folio_all()
Date:   Wed, 19 Jul 2023 17:58:42 +0800
Message-ID: <20230719095848.3422629-4-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230719095848.3422629-1-zhangpeng362@huawei.com>
References: <20230719095848.3422629-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

Convert bio_first_page_all() to bio_first_folio_all() to return a
folio, which makes it easier to use.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 Documentation/block/biovecs.rst  | 2 +-
 drivers/block/drbd/drbd_bitmap.c | 2 +-
 fs/f2fs/data.c                   | 2 +-
 include/linux/bio.h              | 4 ++--
 kernel/power/swap.c              | 2 +-
 mm/page_io.c                     | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/block/biovecs.rst b/Documentation/block/biovecs.rst
index ddb867e0185b..258f6faed333 100644
--- a/Documentation/block/biovecs.rst
+++ b/Documentation/block/biovecs.rst
@@ -133,7 +133,7 @@ Usage of helpers:
 	bio_for_each_segment_all()
 	bio_for_each_bvec_all()
 	bio_first_bvec_all()
-	bio_first_page_all()
+	bio_first_folio_all()
 	bio_last_bvec_all()
 
 * The following helpers iterate over single-page segment. The passed 'struct
diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 85ca000a0564..ce1a07ba85ff 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -939,7 +939,7 @@ static void drbd_bm_endio(struct bio *bio)
 	struct drbd_bm_aio_ctx *ctx = bio->bi_private;
 	struct drbd_device *device = ctx->device;
 	struct drbd_bitmap *b = device->bitmap;
-	unsigned int idx = bm_page_to_idx(bio_first_page_all(bio));
+	unsigned int idx = bm_page_to_idx(&bio_first_folio_all(bio)->page);
 
 	if ((ctx->flags & BM_AIO_COPY_PAGES) == 0 &&
 	    !bm_test_page_unchanged(b->bm_pages[idx]))
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5882afe71d82..6706858de984 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -288,7 +288,7 @@ static void f2fs_post_read_work(struct work_struct *work)
 
 static void f2fs_read_end_io(struct bio *bio)
 {
-	struct f2fs_sb_info *sbi = F2FS_P_SB(bio_first_page_all(bio));
+	struct f2fs_sb_info *sbi = F2FS_P_SB(&bio_first_folio_all(bio)->page);
 	struct bio_post_read_ctx *ctx;
 	bool intask = in_task();
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c4f5b5228105..7d2979d24530 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -248,9 +248,9 @@ static inline struct bio_vec *bio_first_bvec_all(struct bio *bio)
 	return bio->bi_io_vec;
 }
 
-static inline struct page *bio_first_page_all(struct bio *bio)
+static inline struct folio *bio_first_folio_all(struct bio *bio)
 {
-	return bio_first_bvec_all(bio)->bv_page;
+	return page_folio(bio_first_bvec_all(bio)->bv_page);
 }
 
 static inline struct bio_vec *bio_last_bvec_all(struct bio *bio)
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index f6ebcd00c410..2796ce48ca4b 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -247,7 +247,7 @@ static void hib_finish_batch(struct hib_bio_batch *hb)
 static void hib_end_io(struct bio *bio)
 {
 	struct hib_bio_batch *hb = bio->bi_private;
-	struct page *page = bio_first_page_all(bio);
+	struct page *page = &bio_first_folio_all(bio)->page;
 
 	if (bio->bi_status) {
 		pr_alert("Read-error on swap-device (%u:%u:%Lu)\n",
diff --git a/mm/page_io.c b/mm/page_io.c
index 5ddb5d9c5013..e21d570c873d 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -29,7 +29,7 @@
 
 static void __end_swap_bio_write(struct bio *bio)
 {
-	struct page *page = bio_first_page_all(bio);
+	struct page *page = &bio_first_folio_all(bio)->page;
 
 	if (bio->bi_status) {
 		/*
@@ -57,7 +57,7 @@ static void end_swap_bio_write(struct bio *bio)
 
 static void __end_swap_bio_read(struct bio *bio)
 {
-	struct page *page = bio_first_page_all(bio);
+	struct page *page = &bio_first_folio_all(bio)->page;
 
 	if (bio->bi_status) {
 		pr_alert_ratelimited("Read-error on swap-device (%u:%u:%llu)\n",
-- 
2.25.1

