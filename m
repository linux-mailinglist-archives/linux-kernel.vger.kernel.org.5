Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2171810EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377707AbjLMKmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377529AbjLMKmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:42:42 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DBADB;
        Wed, 13 Dec 2023 02:42:47 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7b6f4ee4f7fso146319039f.0;
        Wed, 13 Dec 2023 02:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702464167; x=1703068967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjojUSEOZbZ35+vIKwudAm9m3vU4GuyELsvW3NVGAV4=;
        b=mYdzs9OljlsGpItO7yPZ2oEunx2gSEAaJRMU/OjFG1GmoGLzuoBN9ThjfHg8uvfA2c
         51hRUxTRAtJj2iP2JlPYIopq014PFp/Mk+x6J3JYu1z0iEjrn/rgz7XdM9EB/u8h5vCF
         ed7GVWofyzjkNAlpSVD6JBS0Y1ac/Vt3aDzKZvUvXl6U32i4PvAHpr6KF3ke0Wy7VXMW
         3SZfxnXP+SFQXs/PsbG1DPzsdT8kZPyxfq/Ntv2EWZUK3Pi6zpTKERsuHNzn/tMcfJte
         swV7JO1kTdWL5F9kMO7qVCL7e+UIhxGFm8KXf5pFR3XRdKV1ffx7FH4rZIDyP5hwEknH
         50Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702464167; x=1703068967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjojUSEOZbZ35+vIKwudAm9m3vU4GuyELsvW3NVGAV4=;
        b=NCFQQe27/1pJDb7qTiMeqnpLk4O7XLlakMxlFrxd83+EDRGie3vjGjNtZnH4Uov2RZ
         FaG4oSl6tvNDlNqtLLRZjDPSyqDQSeZAH6Z1wVTBYAPOCXYNrmuwoDmDsZt6szGZGPB5
         sacdELMjp25kBOpC466MJfKpPn5+8saZba7jwjhk0qL2ca021pt6Hq5j5rLQw07LgmKS
         2nvqoyAPnVtK8dVS6GgxNDAdNYXo9XbwgdQKg/8bGK94B+KeCT58SFWXlh//tiQwQ/AB
         D2/Q++mXZvsykR6nAo0svsQ1MjsQqcWMpheHbLBynmzGY3CAQSh1h9MuCw6XwBKkhcrR
         frpw==
X-Gm-Message-State: AOJu0YwXiL1l2pZDaTdwjF9b3TWiZ9UuzPh/lT2ISaqKTb8No7BeEP5C
        4rCpLwlUhiD7aIjvejBCU1fmdXMUiXc=
X-Google-Smtp-Source: AGHT+IEJm2CVbLv3Mruv6RaIegpjcCltNGOoiuUWrt0Eqi4WYZ2y+H2F2QG/sf8SdHUO/4g9fSLyVw==
X-Received: by 2002:a6b:5b17:0:b0:7b4:376f:3991 with SMTP id v23-20020a6b5b17000000b007b4376f3991mr5155964ioh.6.1702464166897;
        Wed, 13 Dec 2023 02:42:46 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id c11-20020a6b4e0b000000b0078647b08ab0sm3058186iob.6.2023.12.13.02.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:42:46 -0800 (PST)
From:   Hongyu Jin <hongyu.jin.cn@gmail.com>
To:     agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        axboe@kernel.dk, ebiggers@kernel.org
Cc:     zhiguo.niu@unisoc.com, ke.wang@unisoc.com, yibin.ding@unisoc.com,
        hongyu.jin@unisoc.com, linux-kernel@vger.kernel.org,
        dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Subject: [PATCH v5 2/5] dm: Support I/O priority for dm_io()
Date:   Wed, 13 Dec 2023 18:42:13 +0800
Message-Id: <20231213104216.27845-3-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213104216.27845-1-hongyu.jin.cn@gmail.com>
References: <CAMQnb4MQUJ0VnA5XO-enrXTJvHbo6FJCVPGszGaq-R34hfbeeg@mail.gmail.com>
 <20231213104216.27845-1-hongyu.jin.cn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongyu Jin <hongyu.jin@unisoc.com>

Add I/O priority parameter for dm_io().

Co-developed-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
---
 drivers/md/dm-bufio.c           |  6 +++---
 drivers/md/dm-integrity.c       | 10 +++++-----
 drivers/md/dm-io.c              | 23 +++++++++++++----------
 drivers/md/dm-kcopyd.c          |  4 ++--
 drivers/md/dm-log.c             |  4 ++--
 drivers/md/dm-raid1.c           |  6 +++---
 drivers/md/dm-snap-persistent.c |  4 ++--
 drivers/md/dm-writecache.c      |  8 ++++----
 include/linux/dm-io.h           |  3 ++-
 9 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 62eb27639c9b..91b05bf4b920 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1279,7 +1279,7 @@ static void use_dmio(struct dm_buffer *b, enum req_op op, sector_t sector,
 		io_req.mem.ptr.vma = (char *)b->data + offset;
 	}
 
-	r = dm_io(&io_req, 1, &region, NULL);
+	r = dm_io(&io_req, 1, &region, NULL, IOPRIO_DEFAULT);
 	if (unlikely(r))
 		b->end_io(b, errno_to_blk_status(r));
 }
@@ -2130,7 +2130,7 @@ int dm_bufio_issue_flush(struct dm_bufio_client *c)
 	if (WARN_ON_ONCE(dm_bufio_in_request()))
 		return -EINVAL;
 
-	return dm_io(&io_req, 1, &io_reg, NULL);
+	return dm_io(&io_req, 1, &io_reg, NULL, IOPRIO_DEFAULT);
 }
 EXPORT_SYMBOL_GPL(dm_bufio_issue_flush);
 
@@ -2154,7 +2154,7 @@ int dm_bufio_issue_discard(struct dm_bufio_client *c, sector_t block, sector_t c
 	if (WARN_ON_ONCE(dm_bufio_in_request()))
 		return -EINVAL; /* discards are optional */
 
-	return dm_io(&io_req, 1, &io_reg, NULL);
+	return dm_io(&io_req, 1, &io_reg, NULL, IOPRIO_DEFAULT);
 }
 EXPORT_SYMBOL_GPL(dm_bufio_issue_discard);
 
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index e85c688fd91e..9ffd093ad6cc 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -553,7 +553,7 @@ static int sync_rw_sb(struct dm_integrity_c *ic, blk_opf_t opf)
 		}
 	}
 
-	r = dm_io(&io_req, 1, &io_loc, NULL);
+	r = dm_io(&io_req, 1, &io_loc, NULL, IOPRIO_DEFAULT);
 	if (unlikely(r))
 		return r;
 
@@ -1071,7 +1071,7 @@ static void rw_journal_sectors(struct dm_integrity_c *ic, blk_opf_t opf,
 	io_loc.sector = ic->start + SB_SECTORS + sector;
 	io_loc.count = n_sectors;
 
-	r = dm_io(&io_req, 1, &io_loc, NULL);
+	r = dm_io(&io_req, 1, &io_loc, NULL, IOPRIO_DEFAULT);
 	if (unlikely(r)) {
 		dm_integrity_io_error(ic, (opf & REQ_OP_MASK) == REQ_OP_READ ?
 				      "reading journal" : "writing journal", r);
@@ -1188,7 +1188,7 @@ static void copy_from_journal(struct dm_integrity_c *ic, unsigned int section, u
 	io_loc.sector = target;
 	io_loc.count = n_sectors;
 
-	r = dm_io(&io_req, 1, &io_loc, NULL);
+	r = dm_io(&io_req, 1, &io_loc, NULL, IOPRIO_DEFAULT);
 	if (unlikely(r)) {
 		WARN_ONCE(1, "asynchronous dm_io failed: %d", r);
 		fn(-1UL, data);
@@ -1517,7 +1517,7 @@ static void dm_integrity_flush_buffers(struct dm_integrity_c *ic, bool flush_dat
 		fr.io_reg.count = 0,
 		fr.ic = ic;
 		init_completion(&fr.comp);
-		r = dm_io(&fr.io_req, 1, &fr.io_reg, NULL);
+		r = dm_io(&fr.io_req, 1, &fr.io_reg, NULL, IOPRIO_DEFAULT);
 		BUG_ON(r);
 	}
 
@@ -2739,7 +2739,7 @@ static void integrity_recalc(struct work_struct *w)
 	io_loc.sector = get_data_sector(ic, area, offset);
 	io_loc.count = n_sectors;
 
-	r = dm_io(&io_req, 1, &io_loc, NULL);
+	r = dm_io(&io_req, 1, &io_loc, NULL, IOPRIO_DEFAULT);
 	if (unlikely(r)) {
 		dm_integrity_io_error(ic, "reading data", r);
 		goto err;
diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index f053ce245814..7409490259d1 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -305,7 +305,7 @@ static void km_dp_init(struct dpages *dp, void *data)
  */
 static void do_region(const blk_opf_t opf, unsigned int region,
 		      struct dm_io_region *where, struct dpages *dp,
-		      struct io *io)
+		      struct io *io, unsigned short ioprio)
 {
 	struct bio *bio;
 	struct page *page;
@@ -354,6 +354,7 @@ static void do_region(const blk_opf_t opf, unsigned int region,
 				       &io->client->bios);
 		bio->bi_iter.bi_sector = where->sector + (where->count - remaining);
 		bio->bi_end_io = endio;
+		bio->bi_ioprio = ioprio;
 		store_io_and_region_in_bio(bio, io, region);
 
 		if (op == REQ_OP_DISCARD || op == REQ_OP_WRITE_ZEROES) {
@@ -383,7 +384,7 @@ static void do_region(const blk_opf_t opf, unsigned int region,
 
 static void dispatch_io(blk_opf_t opf, unsigned int num_regions,
 			struct dm_io_region *where, struct dpages *dp,
-			struct io *io, int sync)
+			struct io *io, int sync, unsigned short ioprio)
 {
 	int i;
 	struct dpages old_pages = *dp;
@@ -400,7 +401,7 @@ static void dispatch_io(blk_opf_t opf, unsigned int num_regions,
 	for (i = 0; i < num_regions; i++) {
 		*dp = old_pages;
 		if (where[i].count || (opf & REQ_PREFLUSH))
-			do_region(opf, i, where + i, dp, io);
+			do_region(opf, i, where + i, dp, io, ioprio);
 	}
 
 	/*
@@ -425,7 +426,7 @@ static void sync_io_complete(unsigned long error, void *context)
 
 static int sync_io(struct dm_io_client *client, unsigned int num_regions,
 		   struct dm_io_region *where, blk_opf_t opf, struct dpages *dp,
-		   unsigned long *error_bits)
+		   unsigned long *error_bits, unsigned short ioprio)
 {
 	struct io *io;
 	struct sync_io sio;
@@ -447,7 +448,7 @@ static int sync_io(struct dm_io_client *client, unsigned int num_regions,
 	io->vma_invalidate_address = dp->vma_invalidate_address;
 	io->vma_invalidate_size = dp->vma_invalidate_size;
 
-	dispatch_io(opf, num_regions, where, dp, io, 1);
+	dispatch_io(opf, num_regions, where, dp, io, 1, ioprio);
 
 	wait_for_completion_io(&sio.wait);
 
@@ -459,7 +460,8 @@ static int sync_io(struct dm_io_client *client, unsigned int num_regions,
 
 static int async_io(struct dm_io_client *client, unsigned int num_regions,
 		    struct dm_io_region *where, blk_opf_t opf,
-		    struct dpages *dp, io_notify_fn fn, void *context)
+		    struct dpages *dp, io_notify_fn fn, void *context,
+		    unsigned short ioprio)
 {
 	struct io *io;
 
@@ -479,7 +481,7 @@ static int async_io(struct dm_io_client *client, unsigned int num_regions,
 	io->vma_invalidate_address = dp->vma_invalidate_address;
 	io->vma_invalidate_size = dp->vma_invalidate_size;
 
-	dispatch_io(opf, num_regions, where, dp, io, 0);
+	dispatch_io(opf, num_regions, where, dp, io, 0, ioprio);
 	return 0;
 }
 
@@ -521,7 +523,8 @@ static int dp_init(struct dm_io_request *io_req, struct dpages *dp,
 }
 
 int dm_io(struct dm_io_request *io_req, unsigned int num_regions,
-	  struct dm_io_region *where, unsigned long *sync_error_bits)
+	  struct dm_io_region *where, unsigned long *sync_error_bits,
+	  unsigned short ioprio)
 {
 	int r;
 	struct dpages dp;
@@ -532,11 +535,11 @@ int dm_io(struct dm_io_request *io_req, unsigned int num_regions,
 
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
index d01807c50f20..79c65c9ad5fa 100644
--- a/drivers/md/dm-kcopyd.c
+++ b/drivers/md/dm-kcopyd.c
@@ -578,9 +578,9 @@ static int run_io_job(struct kcopyd_job *job)
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
index f9f84236dfcd..f7f9c2100937 100644
--- a/drivers/md/dm-log.c
+++ b/drivers/md/dm-log.c
@@ -300,7 +300,7 @@ static int rw_header(struct log_c *lc, enum req_op op)
 {
 	lc->io_req.bi_opf = op;
 
-	return dm_io(&lc->io_req, 1, &lc->header_location, NULL);
+	return dm_io(&lc->io_req, 1, &lc->header_location, NULL, IOPRIO_DEFAULT);
 }
 
 static int flush_header(struct log_c *lc)
@@ -313,7 +313,7 @@ static int flush_header(struct log_c *lc)
 
 	lc->io_req.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
-	return dm_io(&lc->io_req, 1, &null_location, NULL);
+	return dm_io(&lc->io_req, 1, &null_location, NULL, IOPRIO_DEFAULT);
 }
 
 static int read_header(struct log_c *log)
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index ddcb2bc4a617..9511dae5b556 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -278,7 +278,7 @@ static int mirror_flush(struct dm_target *ti)
 	}
 
 	error_bits = -1;
-	dm_io(&io_req, ms->nr_mirrors, io, &error_bits);
+	dm_io(&io_req, ms->nr_mirrors, io, &error_bits, IOPRIO_DEFAULT);
 	if (unlikely(error_bits != 0)) {
 		for (i = 0; i < ms->nr_mirrors; i++)
 			if (test_bit(i, &error_bits))
@@ -554,7 +554,7 @@ static void read_async_bio(struct mirror *m, struct bio *bio)
 
 	map_region(&io, m, bio);
 	bio_set_m(bio, m);
-	BUG_ON(dm_io(&io_req, 1, &io, NULL));
+	BUG_ON(dm_io(&io_req, 1, &io, NULL, IOPRIO_DEFAULT));
 }
 
 static inline int region_in_sync(struct mirror_set *ms, region_t region,
@@ -681,7 +681,7 @@ static void do_write(struct mirror_set *ms, struct bio *bio)
 	 */
 	bio_set_m(bio, get_default_mirror(ms));
 
-	BUG_ON(dm_io(&io_req, ms->nr_mirrors, io, NULL));
+	BUG_ON(dm_io(&io_req, ms->nr_mirrors, io, NULL, IOPRIO_DEFAULT));
 }
 
 static void do_writes(struct mirror_set *ms, struct bio_list *writes)
diff --git a/drivers/md/dm-snap-persistent.c b/drivers/md/dm-snap-persistent.c
index 15649921f2a9..568d10842b1f 100644
--- a/drivers/md/dm-snap-persistent.c
+++ b/drivers/md/dm-snap-persistent.c
@@ -223,7 +223,7 @@ static void do_metadata(struct work_struct *work)
 {
 	struct mdata_req *req = container_of(work, struct mdata_req, work);
 
-	req->result = dm_io(req->io_req, 1, req->where, NULL);
+	req->result = dm_io(req->io_req, 1, req->where, NULL, IOPRIO_DEFAULT);
 }
 
 /*
@@ -247,7 +247,7 @@ static int chunk_io(struct pstore *ps, void *area, chunk_t chunk, blk_opf_t opf,
 	struct mdata_req req;
 
 	if (!metadata)
-		return dm_io(&io_req, 1, &where, NULL);
+		return dm_io(&io_req, 1, &where, NULL, IOPRIO_DEFAULT);
 
 	req.where = &where;
 	req.io_req = &io_req;
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 074cb785eafc..6a4279bfb1e7 100644
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
@@ -990,7 +990,7 @@ static int writecache_read_metadata(struct dm_writecache *wc, sector_t n_sectors
 	req.client = wc->dm_io;
 	req.notify.fn = NULL;
 
-	return dm_io(&req, 1, &region, NULL);
+	return dm_io(&req, 1, &region, NULL, IOPRIO_DEFAULT);
 }
 
 static void writecache_resume(struct dm_target *ti)
diff --git a/include/linux/dm-io.h b/include/linux/dm-io.h
index 7595142f3fc5..7b2968612b7e 100644
--- a/include/linux/dm-io.h
+++ b/include/linux/dm-io.h
@@ -80,7 +80,8 @@ void dm_io_client_destroy(struct dm_io_client *client);
  * error occurred doing io to the corresponding region.
  */
 int dm_io(struct dm_io_request *io_req, unsigned int num_regions,
-	  struct dm_io_region *region, unsigned int long *sync_error_bits);
+	  struct dm_io_region *region, unsigned int long *sync_error_bits,
+	  unsigned short ioprio);
 
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_DM_IO_H */
-- 
2.34.1

