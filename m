Return-Path: <linux-kernel+bounces-114710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8757888BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07ECD1C29BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF442BC5E7;
	Mon, 25 Mar 2024 00:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SN/LJA30"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389D415FD0A;
	Sun, 24 Mar 2024 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322366; cv=none; b=XDMZk/1mjfMahbO7Mui8MvFBtJKl8U1JY9J+tOiJJsFqAgGw3TElb4z9a2fizOdP/kS8eMVuMHY3kn8vxvn9xx6h5n0x6PE6rFF9aHyzl+WtR/aHyRdbUQRzK6gS1QJP0o0g6wAOt+NOpflOVhI0ARphC3X368GisLWGbuHth2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322366; c=relaxed/simple;
	bh=0qrpJR42X9L3Ym6m0/nCN2yDdWkAsUDcgS2EYnAzAL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9cP4dtrHxXPk6FAS/zYb6uNkYUHZFuPVYMgdz3gUmygIAYq+J67ycPXeQ0K/Shp1/Xo2Vyi3XmMqAwAQJN8Jl7WQE7PQeUXq/Ta268IgdP6sQtOdCo2AaFXUfn3HlICea+R+1szzxdnWZ1jPds8Kl/JmMKPbEimq7zo9D0gxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SN/LJA30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F248C433A6;
	Sun, 24 Mar 2024 23:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322365;
	bh=0qrpJR42X9L3Ym6m0/nCN2yDdWkAsUDcgS2EYnAzAL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SN/LJA301o9c9weJSibALYFpZG8N8WhCz1+zPX03OA8qCaJzG62bPSUXIk2dSZsDN
	 NO3X0xpfgCHFnEiEqUAAiNVsjkiwCaSoYj5ZQtX1mOemTM0zI2fXKQey1a4CrwDrp/
	 m3q4g/rB2fenuxTxvIgYCDBcv+hh1Rj/0dgN9NU9jJZrcZurxRY9HwHo1n8JWelgrt
	 sZaz1X87mUFVzE3rNCDbsmabAZGHp6UCTYSzJwESjyTHO3X2Ykd+Exnqx4D5zCJvV5
	 9rE2kBueC12Uh7RZSJHodtMUd69VAuil1OGvSYW4y53NSEVWmHLpC/OseyXLm+VV/X
	 ARoD7yo9CRDYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hongyu Jin <hongyu.jin@unisoc.com>,
	Yibin Ding <yibin.ding@unisoc.com>,
	Eric Biggers <ebiggers@google.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 447/451] dm io: Support IO priority
Date: Sun, 24 Mar 2024 19:12:03 -0400
Message-ID: <20240324231207.1351418-448-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Hongyu Jin <hongyu.jin@unisoc.com>

[ Upstream commit 6e5f0f6383b4896c7e9b943d84b136149d0f45e9 ]

Some IO will dispatch from kworker with different io_context settings
than the submitting task, we may need to specify a priority to avoid
losing priority.

Add IO priority parameter to dm_io() and update all callers.

Co-developed-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Stable-dep-of: b4d78cfeb304 ("dm-integrity: align the outgoing bio in integrity_recheck")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-bufio.c           |  6 +++---
 drivers/md/dm-integrity.c       | 12 ++++++------
 drivers/md/dm-io.c              | 23 +++++++++++++----------
 drivers/md/dm-kcopyd.c          |  4 ++--
 drivers/md/dm-log.c             |  4 ++--
 drivers/md/dm-raid1.c           |  6 +++---
 drivers/md/dm-snap-persistent.c |  4 ++--
 drivers/md/dm-verity-target.c   |  2 +-
 drivers/md/dm-writecache.c      |  8 ++++----
 include/linux/dm-io.h           |  3 ++-
 10 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 100a6a236d92a..ec662f97ba828 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -614,7 +614,7 @@ static void use_dmio(struct dm_buffer *b, enum req_op op, sector_t sector,
 		io_req.mem.ptr.vma = (char *)b->data + offset;
 	}
 
-	r = dm_io(&io_req, 1, &region, NULL);
+	r = dm_io(&io_req, 1, &region, NULL, IOPRIO_DEFAULT);
 	if (unlikely(r))
 		b->end_io(b, errno_to_blk_status(r));
 }
@@ -1375,7 +1375,7 @@ int dm_bufio_issue_flush(struct dm_bufio_client *c)
 
 	BUG_ON(dm_bufio_in_request());
 
-	return dm_io(&io_req, 1, &io_reg, NULL);
+	return dm_io(&io_req, 1, &io_reg, NULL, IOPRIO_DEFAULT);
 }
 EXPORT_SYMBOL_GPL(dm_bufio_issue_flush);
 
@@ -1398,7 +1398,7 @@ int dm_bufio_issue_discard(struct dm_bufio_client *c, sector_t block, sector_t c
 
 	BUG_ON(dm_bufio_in_request());
 
-	return dm_io(&io_req, 1, &io_reg, NULL);
+	return dm_io(&io_req, 1, &io_reg, NULL, IOPRIO_DEFAULT);
 }
 EXPORT_SYMBOL_GPL(dm_bufio_issue_discard);
 
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 94382e43ea506..aff818eb31fbb 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -579,7 +579,7 @@ static int sync_rw_sb(struct dm_integrity_c *ic, blk_opf_t opf)
 		}
 	}
 
-	r = dm_io(&io_req, 1, &io_loc, NULL);
+	r = dm_io(&io_req, 1, &io_loc, NULL, IOPRIO_DEFAULT);
 	if (unlikely(r))
 		return r;
 
@@ -1089,7 +1089,7 @@ static void rw_journal_sectors(struct dm_integrity_c *ic, blk_opf_t opf,
 	io_loc.sector = ic->start + SB_SECTORS + sector;
 	io_loc.count = n_sectors;
 
-	r = dm_io(&io_req, 1, &io_loc, NULL);
+	r = dm_io(&io_req, 1, &io_loc, NULL, IOPRIO_DEFAULT);
 	if (unlikely(r)) {
 		dm_integrity_io_error(ic, (opf & REQ_OP_MASK) == REQ_OP_READ ?
 				      "reading journal" : "writing journal", r);
@@ -1205,7 +1205,7 @@ static void copy_from_journal(struct dm_integrity_c *ic, unsigned int section, u
 	io_loc.sector = target;
 	io_loc.count = n_sectors;
 
-	r = dm_io(&io_req, 1, &io_loc, NULL);
+	r = dm_io(&io_req, 1, &io_loc, NULL, IOPRIO_DEFAULT);
 	if (unlikely(r)) {
 		WARN_ONCE(1, "asynchronous dm_io failed: %d", r);
 		fn(-1UL, data);
@@ -1532,7 +1532,7 @@ static void dm_integrity_flush_buffers(struct dm_integrity_c *ic, bool flush_dat
 		fr.io_reg.count = 0,
 		fr.ic = ic;
 		init_completion(&fr.comp);
-		r = dm_io(&fr.io_req, 1, &fr.io_reg, NULL);
+		r = dm_io(&fr.io_req, 1, &fr.io_reg, NULL, IOPRIO_DEFAULT);
 		BUG_ON(r);
 	}
 
@@ -1737,7 +1737,7 @@ static noinline void integrity_recheck(struct dm_integrity_io *dio, char *checks
 			io_loc.sector = sector;
 			io_loc.count = ic->sectors_per_block;
 
-			r = dm_io(&io_req, 1, &io_loc, NULL);
+			r = dm_io(&io_req, 1, &io_loc, NULL, IOPRIO_DEFAULT);
 			if (unlikely(r)) {
 				dio->bi_status = errno_to_blk_status(r);
 				goto free_ret;
@@ -2774,7 +2774,7 @@ static void integrity_recalc(struct work_struct *w)
 	io_loc.sector = get_data_sector(ic, area, offset);
 	io_loc.count = n_sectors;
 
-	r = dm_io(&io_req, 1, &io_loc, NULL);
+	r = dm_io(&io_req, 1, &io_loc, NULL, IOPRIO_DEFAULT);
 	if (unlikely(r)) {
 		dm_integrity_io_error(ic, "reading data", r);
 		goto err;
diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index e488b05e35fa3..ec97658387c39 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -295,7 +295,7 @@ static void km_dp_init(struct dpages *dp, void *data)
  *---------------------------------------------------------------*/
 static void do_region(const blk_opf_t opf, unsigned int region,
 		      struct dm_io_region *where, struct dpages *dp,
-		      struct io *io)
+		      struct io *io, unsigned short ioprio)
 {
 	struct bio *bio;
 	struct page *page;
@@ -344,6 +344,7 @@ static void do_region(const blk_opf_t opf, unsigned int region,
 				       &io->client->bios);
 		bio->bi_iter.bi_sector = where->sector + (where->count - remaining);
 		bio->bi_end_io = endio;
+		bio->bi_ioprio = ioprio;
 		store_io_and_region_in_bio(bio, io, region);
 
 		if (op == REQ_OP_DISCARD || op == REQ_OP_WRITE_ZEROES) {
@@ -371,7 +372,7 @@ static void do_region(const blk_opf_t opf, unsigned int region,
 
 static void dispatch_io(blk_opf_t opf, unsigned int num_regions,
 			struct dm_io_region *where, struct dpages *dp,
-			struct io *io, int sync)
+			struct io *io, int sync, unsigned short ioprio)
 {
 	int i;
 	struct dpages old_pages = *dp;
@@ -388,7 +389,7 @@ static void dispatch_io(blk_opf_t opf, unsigned int num_regions,
 	for (i = 0; i < num_regions; i++) {
 		*dp = old_pages;
 		if (where[i].count || (opf & REQ_PREFLUSH))
-			do_region(opf, i, where + i, dp, io);
+			do_region(opf, i, where + i, dp, io, ioprio);
 	}
 
 	/*
@@ -413,7 +414,7 @@ static void sync_io_complete(unsigned long error, void *context)
 
 static int sync_io(struct dm_io_client *client, unsigned int num_regions,
 		   struct dm_io_region *where, blk_opf_t opf, struct dpages *dp,
-		   unsigned long *error_bits)
+		   unsigned long *error_bits, unsigned short ioprio)
 {
 	struct io *io;
 	struct sync_io sio;
@@ -435,7 +436,7 @@ static int sync_io(struct dm_io_client *client, unsigned int num_regions,
 	io->vma_invalidate_address = dp->vma_invalidate_address;
 	io->vma_invalidate_size = dp->vma_invalidate_size;
 
-	dispatch_io(opf, num_regions, where, dp, io, 1);
+	dispatch_io(opf, num_regions, where, dp, io, 1, ioprio);
 
 	wait_for_completion_io(&sio.wait);
 
@@ -447,7 +448,8 @@ static int sync_io(struct dm_io_client *client, unsigned int num_regions,
 
 static int async_io(struct dm_io_client *client, unsigned int num_regions,
 		    struct dm_io_region *where, blk_opf_t opf,
-		    struct dpages *dp, io_notify_fn fn, void *context)
+		    struct dpages *dp, io_notify_fn fn, void *context,
+		    unsigned short ioprio)
 {
 	struct io *io;
 
@@ -467,7 +469,7 @@ static int async_io(struct dm_io_client *client, unsigned int num_regions,
 	io->vma_invalidate_address = dp->vma_invalidate_address;
 	io->vma_invalidate_size = dp->vma_invalidate_size;
 
-	dispatch_io(opf, num_regions, where, dp, io, 0);
+	dispatch_io(opf, num_regions, where, dp, io, 0, ioprio);
 	return 0;
 }
 
@@ -509,7 +511,8 @@ static int dp_init(struct dm_io_request *io_req, struct dpages *dp,
 }
 
 int dm_io(struct dm_io_request *io_req, unsigned int num_regions,
-	  struct dm_io_region *where, unsigned long *sync_error_bits)
+	  struct dm_io_region *where, unsigned long *sync_error_bits,
+	  unsigned short ioprio)
 {
 	int r;
 	struct dpages dp;
@@ -520,11 +523,11 @@ int dm_io(struct dm_io_request *io_req, unsigned int num_regions,
 
 	if (!io_req->notify.fn)
 		return sync_io(io_req->client, num_regions, where,
-			       io_req->bi_opf, &dp, sync_error_bits);
+			       io_req->bi_opf, &dp, sync_error_bits, ioprio);
 
 	return async_io(io_req->client, num_regions, where,
 			io_req->bi_opf, &dp, io_req->notify.fn,
-			io_req->notify.context);
+			io_req->notify.context, ioprio);
 }
 EXPORT_SYMBOL(dm_io);
 
diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
index 0ef78e56aa88c..fda51bd140ed3 100644
--- a/drivers/md/dm-kcopyd.c
+++ b/drivers/md/dm-kcopyd.c
@@ -572,9 +572,9 @@ static int run_io_job(struct kcopyd_job *job)
 	io_job_start(job->kc->throttle);
 
 	if (job->op == REQ_OP_READ)
-		r = dm_io(&io_req, 1, &job->source, NULL);
+		r = dm_io(&io_req, 1, &job->source, NULL, IOPRIO_DEFAULT);
 	else
-		r = dm_io(&io_req, job->num_dests, job->dests, NULL);
+		r = dm_io(&io_req, job->num_dests, job->dests, NULL, IOPRIO_DEFAULT);
 
 	return r;
 }
diff --git a/drivers/md/dm-log.c b/drivers/md/dm-log.c
index b7dd5a0cd58ba..da77878cb2c02 100644
--- a/drivers/md/dm-log.c
+++ b/drivers/md/dm-log.c
@@ -295,7 +295,7 @@ static int rw_header(struct log_c *lc, enum req_op op)
 {
 	lc->io_req.bi_opf = op;
 
-	return dm_io(&lc->io_req, 1, &lc->header_location, NULL);
+	return dm_io(&lc->io_req, 1, &lc->header_location, NULL, IOPRIO_DEFAULT);
 }
 
 static int flush_header(struct log_c *lc)
@@ -308,7 +308,7 @@ static int flush_header(struct log_c *lc)
 
 	lc->io_req.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
-	return dm_io(&lc->io_req, 1, &null_location, NULL);
+	return dm_io(&lc->io_req, 1, &null_location, NULL, IOPRIO_DEFAULT);
 }
 
 static int read_header(struct log_c *log)
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index 2327645fc0648..1004199ae77ac 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -273,7 +273,7 @@ static int mirror_flush(struct dm_target *ti)
 	}
 
 	error_bits = -1;
-	dm_io(&io_req, ms->nr_mirrors, io, &error_bits);
+	dm_io(&io_req, ms->nr_mirrors, io, &error_bits, IOPRIO_DEFAULT);
 	if (unlikely(error_bits != 0)) {
 		for (i = 0; i < ms->nr_mirrors; i++)
 			if (test_bit(i, &error_bits))
@@ -543,7 +543,7 @@ static void read_async_bio(struct mirror *m, struct bio *bio)
 
 	map_region(&io, m, bio);
 	bio_set_m(bio, m);
-	BUG_ON(dm_io(&io_req, 1, &io, NULL));
+	BUG_ON(dm_io(&io_req, 1, &io, NULL, IOPRIO_DEFAULT));
 }
 
 static inline int region_in_sync(struct mirror_set *ms, region_t region,
@@ -670,7 +670,7 @@ static void do_write(struct mirror_set *ms, struct bio *bio)
 	 */
 	bio_set_m(bio, get_default_mirror(ms));
 
-	BUG_ON(dm_io(&io_req, ms->nr_mirrors, io, NULL));
+	BUG_ON(dm_io(&io_req, ms->nr_mirrors, io, NULL, IOPRIO_DEFAULT));
 }
 
 static void do_writes(struct mirror_set *ms, struct bio_list *writes)
diff --git a/drivers/md/dm-snap-persistent.c b/drivers/md/dm-snap-persistent.c
index 80b95746a43e0..eee1cd3aa3fcf 100644
--- a/drivers/md/dm-snap-persistent.c
+++ b/drivers/md/dm-snap-persistent.c
@@ -220,7 +220,7 @@ static void do_metadata(struct work_struct *work)
 {
 	struct mdata_req *req = container_of(work, struct mdata_req, work);
 
-	req->result = dm_io(req->io_req, 1, req->where, NULL);
+	req->result = dm_io(req->io_req, 1, req->where, NULL, IOPRIO_DEFAULT);
 }
 
 /*
@@ -244,7 +244,7 @@ static int chunk_io(struct pstore *ps, void *area, chunk_t chunk, blk_opf_t opf,
 	struct mdata_req req;
 
 	if (!metadata)
-		return dm_io(&io_req, 1, &where, NULL);
+		return dm_io(&io_req, 1, &where, NULL, IOPRIO_DEFAULT);
 
 	req.where = &where;
 	req.io_req = &io_req;
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index b48e1b59e6da4..6a707b41dc865 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -503,7 +503,7 @@ static noinline int verity_recheck(struct dm_verity *v, struct dm_verity_io *io,
 	io_loc.bdev = v->data_dev->bdev;
 	io_loc.sector = cur_block << (v->data_dev_block_bits - SECTOR_SHIFT);
 	io_loc.count = 1 << (v->data_dev_block_bits - SECTOR_SHIFT);
-	r = dm_io(&io_req, 1, &io_loc, NULL);
+	r = dm_io(&io_req, 1, &io_loc, NULL, IOPRIO_DEFAULT);
 	if (unlikely(r))
 		goto free_ret;
 
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index a705e24d3e2b6..20fc84b24fc75 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -531,7 +531,7 @@ static void ssd_commit_flushed(struct dm_writecache *wc, bool wait_for_ios)
 		req.notify.context = &endio;
 
 		/* writing via async dm-io (implied by notify.fn above) won't return an error */
-		(void) dm_io(&req, 1, &region, NULL);
+		(void) dm_io(&req, 1, &region, NULL, IOPRIO_DEFAULT);
 		i = j;
 	}
 
@@ -568,7 +568,7 @@ static void ssd_commit_superblock(struct dm_writecache *wc)
 	req.notify.fn = NULL;
 	req.notify.context = NULL;
 
-	r = dm_io(&req, 1, &region, NULL);
+	r = dm_io(&req, 1, &region, NULL, IOPRIO_DEFAULT);
 	if (unlikely(r))
 		writecache_error(wc, r, "error writing superblock");
 }
@@ -596,7 +596,7 @@ static void writecache_disk_flush(struct dm_writecache *wc, struct dm_dev *dev)
 	req.client = wc->dm_io;
 	req.notify.fn = NULL;
 
-	r = dm_io(&req, 1, &region, NULL);
+	r = dm_io(&req, 1, &region, NULL, IOPRIO_DEFAULT);
 	if (unlikely(r))
 		writecache_error(wc, r, "error flushing metadata: %d", r);
 }
@@ -984,7 +984,7 @@ static int writecache_read_metadata(struct dm_writecache *wc, sector_t n_sectors
 	req.client = wc->dm_io;
 	req.notify.fn = NULL;
 
-	return dm_io(&req, 1, &region, NULL);
+	return dm_io(&req, 1, &region, NULL, IOPRIO_DEFAULT);
 }
 
 static void writecache_resume(struct dm_target *ti)
diff --git a/include/linux/dm-io.h b/include/linux/dm-io.h
index 92e7abfe04f92..70b3737052dd2 100644
--- a/include/linux/dm-io.h
+++ b/include/linux/dm-io.h
@@ -79,7 +79,8 @@ void dm_io_client_destroy(struct dm_io_client *client);
  * error occurred doing io to the corresponding region.
  */
 int dm_io(struct dm_io_request *io_req, unsigned int num_regions,
-	  struct dm_io_region *region, unsigned int long *sync_error_bits);
+	  struct dm_io_region *region, unsigned int long *sync_error_bits,
+	  unsigned short ioprio);
 
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_DM_IO_H */
-- 
2.43.0


