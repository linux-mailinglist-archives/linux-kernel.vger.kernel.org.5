Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FCC7BC3CC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 03:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbjJGBdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 21:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjJGBdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:33:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688C1B6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 18:33:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c724577e1fso22111355ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 18:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696642398; x=1697247198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bw0i5BjLD5HynkaIMHaDuDywPDJie/n4JgfUzvkLhH0=;
        b=DWBS5j/zFGNTnxMbHJXcJnUqeldWRDnxxFSE7sDHh99qQ9PVfawoPUOqBaGDMssJxS
         plcvoJoGrmfKUV7HCdaHQwLiNhfxxDYYZghxJmGRzpHrP/vlCPlCgPSW4nZpvGV6ZsZE
         0inEDWmbkftSYaa4CnGZyV+V/HI+pGT5/oYWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696642398; x=1697247198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bw0i5BjLD5HynkaIMHaDuDywPDJie/n4JgfUzvkLhH0=;
        b=eyG9eNLz03JOv9GgL19bH9fmobd7pBQj32CaRJcLBuj5D0kiPCEWfZcnQZDd0/s6tx
         O1FR2NQ/fUSVcRoYfFGSjIq8mZz6q+/o/WvtJi1S15RxqEAQZbAaVSdU/9wLEZGXfqXy
         LxSDPERifduZGwM9qnEYNo5xa3xv3LJ/dp57AS+QXaDR36oK1yqvY49Rx8IPMxcClhyi
         S/8zvsTT3Y2PHMxQb/KJ1W0ZZd9HccYjeDa7auh5Fj+ize8oHUagevhMySJQ+NbCAeij
         6a+yH2PRAs+QUodM1+2FOpxLo0l+k55NfgIzvnY4gvVFbzT19SOKpSYHNugalIwrsZa+
         1gwQ==
X-Gm-Message-State: AOJu0YwK8BkDINV0Y51OLTWi72cTVGrwC3eUiPcTOrUjLpW4FsRdc85e
        uWlyw1qBqxDMnRuiiILfcKHVjw==
X-Google-Smtp-Source: AGHT+IGgiVE2knzBQevrIgQbdtL+0MzY7MwORkEoTxB4XYaM0iaoUXW5Ll8AxYMc4d8Fn2LTbmKHtg==
X-Received: by 2002:a17:902:ced2:b0:1be:f45c:bc38 with SMTP id d18-20020a170902ced200b001bef45cbc38mr11726592plg.2.1696642397723;
        Fri, 06 Oct 2023 18:33:17 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:138c:8976:eb4a:a91c])
        by smtp.gmail.com with UTF8SMTPSA id iz2-20020a170902ef8200b001c71ec1866fsm4600121plb.258.2023.10.06.18.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 18:33:17 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     dm-devel@redhat.com, linux-kernel@vger.kernel.org
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH RFC] dm thin: Add support for online trim to dm-thinpool
Date:   Fri,  6 Oct 2023 18:33:14 -0700
Message-ID: <20231007013314.3055426-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, dm-thinpool only supports offline trim: there is
a userspace tool called `thin_trim` (part of `thin-provisioning-tools`),
that will look up all the unmapped regions within the thinpool
and issue discards to these regions. However, this can take up a lot of
time, specially on larger storage devices.

This patch augments dm-thinpool's no passdown mode with a message
mechanism that allows userspace to issue 'trim' messages to regions
of the thinpool. In turn, dm-thinpool re-uses the existing discard
mechanism to issue a discard bio to only send discards to regions in
the data device that are currently not mapped on other dm-thin devices.

This patch is intended as an RFC with the following open questions
(assuming that the approach is even viable):

- Most of the patch is modifying current discard functions to work
  without an attached dm-thin context (tc). Would it be preferrable to
  keep this path independent of the thin volume discard path?

- Current RFC patch doesn't protect against userspace attempting to
  discard large ranges of extents in the thinpool (which puts the
  thinpool in read-only mode). What would the optimal way to prevent
  trim from locking up the space in the thinpool (chunking requests?)?

- The patch currently only sets up the 'trim' capability if no passdown
  is enabled: the reasoning behind that is if passdown is enabled,
  thin_trim doesn't necessarily need the trim capability iff all the
  dm-thin devices can passdown requests from the filesystem already.
  Would it be preferrable to have this capability across all discard
  modes?

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 drivers/md/dm-thin.c | 156 +++++++++++++++++++++++++++++++++----------
 1 file changed, 121 insertions(+), 35 deletions(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 07c7f9795b10..9a8eeebd9f49 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -280,6 +280,7 @@ struct pool {
 
 	process_mapping_fn process_prepared_mapping;
 	process_mapping_fn process_prepared_discard;
+	process_mapping_fn process_prepared_trim;
 	process_mapping_fn process_prepared_discard_pt2;
 
 	struct dm_bio_prison_cell **cell_sort_array;
@@ -379,17 +380,17 @@ static sector_t block_to_sectors(struct pool *pool, dm_block_t b)
 /*----------------------------------------------------------------*/
 
 struct discard_op {
-	struct thin_c *tc;
+	struct pool *pool;
 	struct blk_plug plug;
 	struct bio *parent_bio;
 	struct bio *bio;
 };
 
-static void begin_discard(struct discard_op *op, struct thin_c *tc, struct bio *parent)
+static void begin_discard(struct discard_op *op, struct pool *pool, struct bio *parent)
 {
 	BUG_ON(!parent);
 
-	op->tc = tc;
+	op->pool = pool;
 	blk_start_plug(&op->plug);
 	op->parent_bio = parent;
 	op->bio = NULL;
@@ -397,11 +398,11 @@ static void begin_discard(struct discard_op *op, struct thin_c *tc, struct bio *
 
 static int issue_discard(struct discard_op *op, dm_block_t data_b, dm_block_t data_e)
 {
-	struct thin_c *tc = op->tc;
-	sector_t s = block_to_sectors(tc->pool, data_b);
-	sector_t len = block_to_sectors(tc->pool, data_e - data_b);
+	struct pool *pool = op->pool;
+	sector_t s = block_to_sectors(pool, data_b);
+	sector_t len = block_to_sectors(pool, data_e - data_b);
 
-	return __blkdev_issue_discard(tc->pool_dev->bdev, s, len, GFP_NOIO, &op->bio);
+	return __blkdev_issue_discard(pool->data_dev, s, len, GFP_NOIO, &op->bio);
 }
 
 static void end_discard(struct discard_op *op, int r)
@@ -813,6 +814,7 @@ struct dm_thin_new_mapping {
 
 	blk_status_t status;
 	struct thin_c *tc;
+	struct pool *pool;
 	dm_block_t virt_begin, virt_end;
 	dm_block_t data_block;
 	struct dm_bio_prison_cell *cell;
@@ -829,7 +831,7 @@ struct dm_thin_new_mapping {
 
 static void __complete_mapping_preparation(struct dm_thin_new_mapping *m)
 {
-	struct pool *pool = m->tc->pool;
+	struct pool *pool = m->pool;
 
 	if (atomic_dec_and_test(&m->prepare_actions)) {
 		list_add_tail(&m->list, &pool->prepared_mappings);
@@ -840,7 +842,7 @@ static void __complete_mapping_preparation(struct dm_thin_new_mapping *m)
 static void complete_mapping_preparation(struct dm_thin_new_mapping *m)
 {
 	unsigned long flags;
-	struct pool *pool = m->tc->pool;
+	struct pool *pool = m->pool;
 
 	spin_lock_irqsave(&pool->lock, flags);
 	__complete_mapping_preparation(m);
@@ -955,9 +957,9 @@ static void inc_remap_and_issue_cell(struct thin_c *tc,
 
 static void process_prepared_mapping_fail(struct dm_thin_new_mapping *m)
 {
-	cell_error(m->tc->pool, m->cell);
+	cell_error(m->pool, m->cell);
 	list_del(&m->list);
-	mempool_free(m, &m->tc->pool->mapping_pool);
+	mempool_free(m, &m->pool->mapping_pool);
 }
 
 static void complete_overwrite_bio(struct thin_c *tc, struct bio *bio)
@@ -995,7 +997,7 @@ static void complete_overwrite_bio(struct thin_c *tc, struct bio *bio)
 static void process_prepared_mapping(struct dm_thin_new_mapping *m)
 {
 	struct thin_c *tc = m->tc;
-	struct pool *pool = tc->pool;
+	struct pool *pool = m->pool;
 	struct bio *bio = m->bio;
 	int r;
 
@@ -1041,10 +1043,11 @@ static void process_prepared_mapping(struct dm_thin_new_mapping *m)
 static void free_discard_mapping(struct dm_thin_new_mapping *m)
 {
 	struct thin_c *tc = m->tc;
+	struct pool *pool = m->pool;
 
-	if (m->cell)
+	if (m->cell && tc)
 		cell_defer_no_holder(tc, m->cell);
-	mempool_free(m, &tc->pool->mapping_pool);
+	mempool_free(m, &pool->mapping_pool);
 }
 
 static void process_prepared_discard_fail(struct dm_thin_new_mapping *m)
@@ -1066,13 +1069,13 @@ static void process_prepared_discard_no_passdown(struct dm_thin_new_mapping *m)
 
 	r = dm_thin_remove_range(tc->td, m->cell->key.block_begin, m->cell->key.block_end);
 	if (r) {
-		metadata_operation_failed(tc->pool, "dm_thin_remove_range", r);
+		metadata_operation_failed(m->pool, "dm_thin_remove_range", r);
 		bio_io_error(m->bio);
 	} else
 		bio_endio(m->bio);
 
 	cell_defer_no_holder(tc, m->cell);
-	mempool_free(m, &tc->pool->mapping_pool);
+	mempool_free(m, &m->pool->mapping_pool);
 }
 
 /*----------------------------------------------------------------*/
@@ -1086,12 +1089,11 @@ static void passdown_double_checking_shared_status(struct dm_thin_new_mapping *m
 	 */
 	int r = 0;
 	bool shared = true;
-	struct thin_c *tc = m->tc;
-	struct pool *pool = tc->pool;
+	struct pool *pool = m->pool;
 	dm_block_t b = m->data_block, e, end = m->data_block + m->virt_end - m->virt_begin;
 	struct discard_op op;
 
-	begin_discard(&op, tc, discard_parent);
+	begin_discard(&op, pool, discard_parent);
 	while (b != end) {
 		/* find start of unmapped run */
 		for (; b < end; b++) {
@@ -1129,7 +1131,7 @@ static void passdown_double_checking_shared_status(struct dm_thin_new_mapping *m
 static void queue_passdown_pt2(struct dm_thin_new_mapping *m)
 {
 	unsigned long flags;
-	struct pool *pool = m->tc->pool;
+	struct pool *pool = m->pool;
 
 	spin_lock_irqsave(&pool->lock, flags);
 	list_add_tail(&m->list, &pool->prepared_discards_pt2);
@@ -1151,7 +1153,7 @@ static void process_prepared_discard_passdown_pt1(struct dm_thin_new_mapping *m)
 {
 	int r;
 	struct thin_c *tc = m->tc;
-	struct pool *pool = tc->pool;
+	struct pool *pool = m->pool;
 	struct bio *discard_parent;
 	dm_block_t data_end = m->data_block + (m->virt_end - m->virt_begin);
 
@@ -1160,13 +1162,15 @@ static void process_prepared_discard_passdown_pt1(struct dm_thin_new_mapping *m)
 	 * newly unmapped blocks will not be allocated before the end of
 	 * the function.
 	 */
-	r = dm_thin_remove_range(tc->td, m->virt_begin, m->virt_end);
-	if (r) {
-		metadata_operation_failed(pool, "dm_thin_remove_range", r);
-		bio_io_error(m->bio);
-		cell_defer_no_holder(tc, m->cell);
-		mempool_free(m, &pool->mapping_pool);
-		return;
+	if (tc) {
+		r = dm_thin_remove_range(tc->td, m->virt_begin, m->virt_end);
+		if (r) {
+			metadata_operation_failed(pool, "dm_thin_remove_range", r);
+			bio_io_error(m->bio);
+			cell_defer_no_holder(tc, m->cell);
+			mempool_free(m, &pool->mapping_pool);
+			return;
+		}
 	}
 
 	/*
@@ -1176,8 +1180,10 @@ static void process_prepared_discard_passdown_pt1(struct dm_thin_new_mapping *m)
 	r = dm_pool_inc_data_range(pool->pmd, m->data_block, data_end);
 	if (r) {
 		metadata_operation_failed(pool, "dm_pool_inc_data_range", r);
-		bio_io_error(m->bio);
-		cell_defer_no_holder(tc, m->cell);
+		if (m->bio)
+			bio_io_error(m->bio);
+		if (tc)
+			cell_defer_no_holder(tc, m->cell);
 		mempool_free(m, &pool->mapping_pool);
 		return;
 	}
@@ -1190,7 +1196,7 @@ static void process_prepared_discard_passdown_pt1(struct dm_thin_new_mapping *m)
 	else {
 		struct discard_op op;
 
-		begin_discard(&op, tc, discard_parent);
+		begin_discard(&op, pool, discard_parent);
 		r = issue_discard(&op, m->data_block, data_end);
 		end_discard(&op, r);
 	}
@@ -1200,7 +1206,7 @@ static void process_prepared_discard_passdown_pt2(struct dm_thin_new_mapping *m)
 {
 	int r;
 	struct thin_c *tc = m->tc;
-	struct pool *pool = tc->pool;
+	struct pool *pool = m->pool;
 
 	/*
 	 * The passdown has completed, so now we can decrement all those
@@ -1210,11 +1216,14 @@ static void process_prepared_discard_passdown_pt2(struct dm_thin_new_mapping *m)
 				   m->data_block + (m->virt_end - m->virt_begin));
 	if (r) {
 		metadata_operation_failed(pool, "dm_pool_dec_data_range", r);
-		bio_io_error(m->bio);
+		if (m->bio)
+			bio_io_error(m->bio);
 	} else
-		bio_endio(m->bio);
+		if (m->bio)
+			bio_endio(m->bio);
 
-	cell_defer_no_holder(tc, m->cell);
+	if (tc)
+		cell_defer_no_holder(tc, m->cell);
 	mempool_free(m, &pool->mapping_pool);
 }
 
@@ -1319,6 +1328,7 @@ static void schedule_copy(struct thin_c *tc, dm_block_t virt_block,
 	struct dm_thin_new_mapping *m = get_next_mapping(pool);
 
 	m->tc = tc;
+	m->pool = pool;
 	m->virt_begin = virt_block;
 	m->virt_end = virt_block + 1u;
 	m->data_block = data_dest;
@@ -1388,6 +1398,7 @@ static void schedule_zero(struct thin_c *tc, dm_block_t virt_block,
 
 	atomic_set(&m->prepare_actions, 1); /* no need to quiesce */
 	m->tc = tc;
+	m->pool = pool;
 	m->virt_begin = virt_block;
 	m->virt_end = virt_block + 1u;
 	m->data_block = data_block;
@@ -1656,6 +1667,7 @@ static void process_discard_cell_no_passdown(struct thin_c *tc,
 	 * passdown.  We only lock data blocks for allocation and breaking sharing.
 	 */
 	m->tc = tc;
+	m->pool = pool;
 	m->virt_begin = virt_cell->key.block_begin;
 	m->virt_end = virt_cell->key.block_end;
 	m->cell = virt_cell;
@@ -1717,6 +1729,7 @@ static void break_up_discard_bio(struct thin_c *tc, dm_block_t begin, dm_block_t
 			 */
 			m = get_next_mapping(pool);
 			m->tc = tc;
+			m->pool = pool;
 			m->maybe_shared = maybe_shared;
 			m->virt_begin = virt_begin;
 			m->virt_end = virt_begin + len;
@@ -1828,6 +1841,27 @@ static void break_sharing(struct thin_c *tc, struct bio *bio, dm_block_t block,
 	}
 }
 
+static void process_trim(struct pool *pool, dm_block_t begin, dm_block_t end)
+{
+	int r;
+	struct dm_thin_new_mapping *m;
+
+
+	r = ensure_next_mapping(pool);
+	if (r)
+		return;
+
+	m = get_next_mapping(pool);
+
+	m->pool = pool;
+	m->maybe_shared = true;
+	m->virt_begin = 0;
+	m->virt_end = end;
+	m->data_block = begin;
+
+	pool->process_prepared_trim(m);
+}
+
 static void __remap_and_issue_shared_cell(void *context,
 					  struct dm_bio_prison_cell *cell)
 {
@@ -2538,6 +2572,8 @@ static void set_discard_callbacks(struct pool *pool)
 	} else {
 		pool->process_discard_cell = process_discard_cell_no_passdown;
 		pool->process_prepared_discard = process_prepared_discard_no_passdown;
+		pool->process_prepared_trim = process_prepared_discard_passdown_pt1;
+		pool->process_prepared_discard_pt2 = process_prepared_discard_passdown_pt2;
 	}
 }
 
@@ -2577,6 +2613,7 @@ static void set_pool_mode(struct pool *pool, enum pool_mode new_mode)
 		pool->process_discard_cell = process_cell_fail;
 		pool->process_prepared_mapping = process_prepared_mapping_fail;
 		pool->process_prepared_discard = process_prepared_discard_fail;
+		pool->process_prepared_trim = process_prepared_discard_fail;
 
 		error_retry_list(pool);
 		break;
@@ -2590,6 +2627,7 @@ static void set_pool_mode(struct pool *pool, enum pool_mode new_mode)
 		pool->process_discard_cell = process_cell_success;
 		pool->process_prepared_mapping = process_prepared_mapping_fail;
 		pool->process_prepared_discard = process_prepared_discard_success;
+		pool->process_prepared_trim = process_prepared_discard_success;
 
 		error_retry_list(pool);
 		break;
@@ -3834,6 +3872,50 @@ static int process_release_metadata_snap_mesg(unsigned int argc, char **argv, st
 	return r;
 }
 
+static int process_trim_mesg(unsigned int argc, char **argv, struct pool *pool)
+{
+	uint64_t begin, end;
+	int r;
+
+	/* Allow trim only in no_passdown mode */
+	if (!pool->pf.discard_enabled || pool->pf.discard_passdown)
+		return -EINVAL;
+
+	r = check_arg_count(argc, 3);
+	if (r)
+		return r;
+
+	if (kstrtoull(argv[1], 10, (unsigned long long *)&begin)) {
+		DMWARN("trim message: invalid 'begin' %s", argv[1]);
+		return -EINVAL;
+	}
+
+	if (kstrtoull(argv[2], 10, (unsigned long long *)&end)) {
+		DMWARN("trim message: invalid 'end' %s", argv[2]);
+		return -EINVAL;
+	}
+
+	sector_t b = begin >> SECTOR_SHIFT;
+	sector_t e = end >> SECTOR_SHIFT;
+
+	b += pool->sectors_per_block - 1ull; /* so we round up */
+
+	if (block_size_is_power_of_two(pool)) {
+		b >>= pool->sectors_per_block_shift;
+		e >>= pool->sectors_per_block_shift;
+	} else {
+		(void) sector_div(b, pool->sectors_per_block);
+		(void) sector_div(e, pool->sectors_per_block);
+	}
+
+	if (e < b)
+		e = b;
+
+	process_trim(pool, b, e);
+
+	return 0;
+}
+
 /*
  * Messages supported:
  *   create_thin	<dev_id>
@@ -3842,6 +3924,7 @@ static int process_release_metadata_snap_mesg(unsigned int argc, char **argv, st
  *   set_transaction_id <current_trans_id> <new_trans_id>
  *   reserve_metadata_snap
  *   release_metadata_snap
+ *   trim <start> <end>
  */
 static int pool_message(struct dm_target *ti, unsigned int argc, char **argv,
 			char *result, unsigned int maxlen)
@@ -3874,6 +3957,9 @@ static int pool_message(struct dm_target *ti, unsigned int argc, char **argv,
 	else if (!strcasecmp(argv[0], "release_metadata_snap"))
 		r = process_release_metadata_snap_mesg(argc, argv, pool);
 
+	else if (!strcasecmp(argv[0], "trim"))
+		r = process_trim_mesg(argc, argv, pool);
+
 	else
 		DMWARN("Unrecognised thin pool target message received: %s", argv[0]);
 
-- 
2.42.0.609.gbb76f46606-goog

