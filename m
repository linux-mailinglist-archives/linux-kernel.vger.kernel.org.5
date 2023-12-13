Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39396810EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377761AbjLMKmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377700AbjLMKmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:42:47 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D74411F;
        Wed, 13 Dec 2023 02:42:52 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7b35d476d61so244691739f.0;
        Wed, 13 Dec 2023 02:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702464171; x=1703068971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCH7qHK5H8vXi2OAOx3SCYKWSwB7ChpMXiuHfRRRRKQ=;
        b=ikAFKPNlHXd1hCjPdYYd0wxJggwX0dIPhrIP8v/5AKwHcsZaoHK2gJykexbJ6qI/cm
         GZFv0+7WKKc1iWyxZyXO1zkdtC1DpbTgXU7BlxOh7MLeQRNZi3NglnEQdu1Le/NFYeBt
         3UlFIV2512m5+BN9eceVZSnzwphtUqTtTWoqsz5aZfNml7SxyuiozjcUiC34Eks4W1tM
         lLojLnUaWLItVyxycdCk9OPkEcNh0H4tQ7Njtn9aJu/CqyazB5hUfYlC2wTTqJldyzrz
         DH+YE15HnR5B7upDOmObSX1fZcIpjhNkdZcEbAjwqqO5jhonP0EOmRowdtvl+J6lAKOa
         K8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702464171; x=1703068971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCH7qHK5H8vXi2OAOx3SCYKWSwB7ChpMXiuHfRRRRKQ=;
        b=LSsfQS/sP+FX8ACd9Fk7V0ttQaqy3pO3qke22qasA/8uEibvB3BZgPV6w+hx8LI9NJ
         UhMhqb2nLj4Df3gPFv2/4GJjDHGV1gnULXQmR+W0Y/pnbN8QYjq+kz6x+OUCEJRkjC0d
         6kDNq/aCsDRO/g0oUEbqotR+yx95dHKj20h3XFEyk9VPBkU616RpLwmc2tD0eyjQ4B+O
         wou65UuWl048mvoIp77ojhmuMtiwKi7WTttEOEGXrPtRCXm17BZ1x8QRwVUiOhj7N7IC
         dgUDveeQUz9LRymFQopRdWU5UD4CY/tawP8uendesz5MLnyEflf8z8FD5BySzXF01Pez
         1Nxg==
X-Gm-Message-State: AOJu0YwW8vxvEEzjtHUqy4HBVYik6QgWQvymzEoZM3JjoHqZleHEXxlu
        IDd8Yr7agdIv4/4+fiV7e3Y=
X-Google-Smtp-Source: AGHT+IGUkDYY/69pPfSdo256SxRGG9oyvhuwKzyARdXNbQ9J9lAf+CZWaD1DPntTJa2IuS7L3v9tEQ==
X-Received: by 2002:a5e:d70b:0:b0:7b7:4cd:6b16 with SMTP id v11-20020a5ed70b000000b007b704cd6b16mr7900060iom.31.1702464171468;
        Wed, 13 Dec 2023 02:42:51 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id c11-20020a6b4e0b000000b0078647b08ab0sm3058186iob.6.2023.12.13.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:42:51 -0800 (PST)
From:   Hongyu Jin <hongyu.jin.cn@gmail.com>
To:     agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        axboe@kernel.dk, ebiggers@kernel.org
Cc:     zhiguo.niu@unisoc.com, ke.wang@unisoc.com, yibin.ding@unisoc.com,
        hongyu.jin@unisoc.com, linux-kernel@vger.kernel.org,
        dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Subject: [PATCH v5 3/5] dm-bufio: Support I/O priority
Date:   Wed, 13 Dec 2023 18:42:14 +0800
Message-Id: <20231213104216.27845-4-hongyu.jin.cn@gmail.com>
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

Add I/O priority parameter for dm_bufio_read() and
dm_bufio_prefetch().

Co-developed-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
---
 drivers/md/dm-bufio.c                         | 35 ++++++++++---------
 drivers/md/dm-ebs-target.c                    |  8 ++---
 drivers/md/dm-integrity.c                     |  2 +-
 drivers/md/dm-snap-persistent.c               |  4 +--
 drivers/md/dm-verity-fec.c                    |  4 +--
 drivers/md/dm-verity-target.c                 |  4 +--
 drivers/md/persistent-data/dm-block-manager.c |  6 ++--
 include/linux/dm-bufio.h                      |  5 ++-
 8 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 91b05bf4b920..f3b051d3517e 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1256,7 +1256,7 @@ static void dmio_complete(unsigned long error, void *context)
 }
 
 static void use_dmio(struct dm_buffer *b, enum req_op op, sector_t sector,
-		     unsigned int n_sectors, unsigned int offset)
+		     unsigned int n_sectors, unsigned int offset, unsigned short ioprio)
 {
 	int r;
 	struct dm_io_request io_req = {
@@ -1279,7 +1279,7 @@ static void use_dmio(struct dm_buffer *b, enum req_op op, sector_t sector,
 		io_req.mem.ptr.vma = (char *)b->data + offset;
 	}
 
-	r = dm_io(&io_req, 1, &region, NULL, IOPRIO_DEFAULT);
+	r = dm_io(&io_req, 1, &region, NULL, ioprio);
 	if (unlikely(r))
 		b->end_io(b, errno_to_blk_status(r));
 }
@@ -1295,7 +1295,7 @@ static void bio_complete(struct bio *bio)
 }
 
 static void use_bio(struct dm_buffer *b, enum req_op op, sector_t sector,
-		    unsigned int n_sectors, unsigned int offset)
+		    unsigned int n_sectors, unsigned int offset, unsigned short ioprio)
 {
 	struct bio *bio;
 	char *ptr;
@@ -1303,13 +1303,14 @@ static void use_bio(struct dm_buffer *b, enum req_op op, sector_t sector,
 
 	bio = bio_kmalloc(1, GFP_NOWAIT | __GFP_NORETRY | __GFP_NOWARN);
 	if (!bio) {
-		use_dmio(b, op, sector, n_sectors, offset);
+		use_dmio(b, op, sector, n_sectors, offset, ioprio);
 		return;
 	}
 	bio_init(bio, b->c->bdev, bio->bi_inline_vecs, 1, op);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_end_io = bio_complete;
 	bio->bi_private = b;
+	bio->bi_ioprio = ioprio;
 
 	ptr = (char *)b->data + offset;
 	len = n_sectors << SECTOR_SHIFT;
@@ -1332,7 +1333,7 @@ static inline sector_t block_to_sector(struct dm_bufio_client *c, sector_t block
 	return sector;
 }
 
-static void submit_io(struct dm_buffer *b, enum req_op op,
+static void submit_io(struct dm_buffer *b, enum req_op op, unsigned short ioprio,
 		      void (*end_io)(struct dm_buffer *, blk_status_t))
 {
 	unsigned int n_sectors;
@@ -1362,9 +1363,9 @@ static void submit_io(struct dm_buffer *b, enum req_op op,
 	}
 
 	if (b->data_mode != DATA_MODE_VMALLOC)
-		use_bio(b, op, sector, n_sectors, offset);
+		use_bio(b, op, sector, n_sectors, offset, ioprio);
 	else
-		use_dmio(b, op, sector, n_sectors, offset);
+		use_dmio(b, op, sector, n_sectors, offset, ioprio);
 }
 
 /*
@@ -1420,7 +1421,7 @@ static void __write_dirty_buffer(struct dm_buffer *b,
 	b->write_end = b->dirty_end;
 
 	if (!write_list)
-		submit_io(b, REQ_OP_WRITE, write_endio);
+		submit_io(b, REQ_OP_WRITE, IOPRIO_DEFAULT, write_endio);
 	else
 		list_add_tail(&b->write_list, write_list);
 }
@@ -1434,7 +1435,7 @@ static void __flush_write_list(struct list_head *write_list)
 		struct dm_buffer *b =
 			list_entry(write_list->next, struct dm_buffer, write_list);
 		list_del(&b->write_list);
-		submit_io(b, REQ_OP_WRITE, write_endio);
+		submit_io(b, REQ_OP_WRITE, IOPRIO_DEFAULT, write_endio);
 		cond_resched();
 	}
 	blk_finish_plug(&plug);
@@ -1816,7 +1817,7 @@ static void read_endio(struct dm_buffer *b, blk_status_t status)
  * and uses dm_bufio_mark_buffer_dirty to write new data back).
  */
 static void *new_read(struct dm_bufio_client *c, sector_t block,
-		      enum new_flag nf, struct dm_buffer **bp)
+		      enum new_flag nf, struct dm_buffer **bp, unsigned short ioprio)
 {
 	int need_submit = 0;
 	struct dm_buffer *b;
@@ -1869,7 +1870,7 @@ static void *new_read(struct dm_bufio_client *c, sector_t block,
 		return NULL;
 
 	if (need_submit)
-		submit_io(b, REQ_OP_READ, read_endio);
+		submit_io(b, REQ_OP_READ, ioprio, read_endio);
 
 	wait_on_bit_io(&b->state, B_READING, TASK_UNINTERRUPTIBLE);
 
@@ -1889,17 +1890,17 @@ static void *new_read(struct dm_bufio_client *c, sector_t block,
 void *dm_bufio_get(struct dm_bufio_client *c, sector_t block,
 		   struct dm_buffer **bp)
 {
-	return new_read(c, block, NF_GET, bp);
+	return new_read(c, block, NF_GET, bp, IOPRIO_DEFAULT);
 }
 EXPORT_SYMBOL_GPL(dm_bufio_get);
 
 void *dm_bufio_read(struct dm_bufio_client *c, sector_t block,
-		    struct dm_buffer **bp)
+		    struct dm_buffer **bp, unsigned short ioprio)
 {
 	if (WARN_ON_ONCE(dm_bufio_in_request()))
 		return ERR_PTR(-EINVAL);
 
-	return new_read(c, block, NF_READ, bp);
+	return new_read(c, block, NF_READ, bp, ioprio);
 }
 EXPORT_SYMBOL_GPL(dm_bufio_read);
 
@@ -1909,12 +1910,12 @@ void *dm_bufio_new(struct dm_bufio_client *c, sector_t block,
 	if (WARN_ON_ONCE(dm_bufio_in_request()))
 		return ERR_PTR(-EINVAL);
 
-	return new_read(c, block, NF_FRESH, bp);
+	return new_read(c, block, NF_FRESH, bp, IOPRIO_DEFAULT);
 }
 EXPORT_SYMBOL_GPL(dm_bufio_new);
 
 void dm_bufio_prefetch(struct dm_bufio_client *c,
-		       sector_t block, unsigned int n_blocks)
+		       sector_t block, unsigned int n_blocks, unsigned short ioprio)
 {
 	struct blk_plug plug;
 
@@ -1950,7 +1951,7 @@ void dm_bufio_prefetch(struct dm_bufio_client *c,
 			dm_bufio_unlock(c);
 
 			if (need_submit)
-				submit_io(b, REQ_OP_READ, read_endio);
+				submit_io(b, REQ_OP_READ, ioprio, read_endio);
 			dm_bufio_release(b);
 
 			cond_resched();
diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index 435b45201f4d..8198c8a7b416 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -84,7 +84,7 @@ static int __ebs_rw_bvec(struct ebs_c *ec, enum req_op op, struct bio_vec *bv,
 
 		/* Avoid reading for writes in case bio vector's page overwrites block completely. */
 		if (op == REQ_OP_READ || buf_off || bv_len < dm_bufio_get_block_size(ec->bufio))
-			ba = dm_bufio_read(ec->bufio, block, &b);
+			ba = dm_bufio_read(ec->bufio, block, &b, IOPRIO_DEFAULT);
 		else
 			ba = dm_bufio_new(ec->bufio, block, &b);
 
@@ -194,13 +194,13 @@ static void __ebs_process_bios(struct work_struct *ws)
 	bio_list_for_each(bio, &bios) {
 		block1 = __sector_to_block(ec, bio->bi_iter.bi_sector);
 		if (bio_op(bio) == REQ_OP_READ)
-			dm_bufio_prefetch(ec->bufio, block1, __nr_blocks(ec, bio));
+			dm_bufio_prefetch(ec->bufio, block1, __nr_blocks(ec, bio), IOPRIO_DEFAULT);
 		else if (bio_op(bio) == REQ_OP_WRITE && !(bio->bi_opf & REQ_PREFLUSH)) {
 			block2 = __sector_to_block(ec, bio_end_sector(bio));
 			if (__block_mod(bio->bi_iter.bi_sector, ec->u_bs))
-				dm_bufio_prefetch(ec->bufio, block1, 1);
+				dm_bufio_prefetch(ec->bufio, block1, 1, IOPRIO_DEFAULT);
 			if (__block_mod(bio_end_sector(bio), ec->u_bs) && block2 != block1)
-				dm_bufio_prefetch(ec->bufio, block2, 1);
+				dm_bufio_prefetch(ec->bufio, block2, 1, IOPRIO_DEFAULT);
 		}
 	}
 
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 9ffd093ad6cc..1e40e712bcd7 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1418,7 +1418,7 @@ static int dm_integrity_rw_tag(struct dm_integrity_c *ic, unsigned char *tag, se
 		if (unlikely(r))
 			return r;
 
-		data = dm_bufio_read(ic->bufio, *metadata_block, &b);
+		data = dm_bufio_read(ic->bufio, *metadata_block, &b, IOPRIO_DEFAULT);
 		if (IS_ERR(data))
 			return PTR_ERR(data);
 
diff --git a/drivers/md/dm-snap-persistent.c b/drivers/md/dm-snap-persistent.c
index 568d10842b1f..a2072b95e28c 100644
--- a/drivers/md/dm-snap-persistent.c
+++ b/drivers/md/dm-snap-persistent.c
@@ -524,7 +524,7 @@ static int read_exceptions(struct pstore *ps,
 
 				if (unlikely(pf_chunk >= dm_bufio_get_device_size(client)))
 					break;
-				dm_bufio_prefetch(client, pf_chunk, 1);
+				dm_bufio_prefetch(client, pf_chunk, 1, IOPRIO_DEFAULT);
 				prefetch_area++;
 				if (unlikely(!prefetch_area))
 					break;
@@ -533,7 +533,7 @@ static int read_exceptions(struct pstore *ps,
 
 		chunk = area_location(ps, ps->current_area);
 
-		area = dm_bufio_read(client, chunk, &bp);
+		area = dm_bufio_read(client, chunk, &bp, IOPRIO_DEFAULT);
 		if (IS_ERR(area)) {
 			r = PTR_ERR(area);
 			goto ret_destroy_bufio;
diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 3ef9f018da60..715173cbf0ee 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -68,7 +68,7 @@ static u8 *fec_read_parity(struct dm_verity *v, u64 rsb, int index,
 	block = div64_u64_rem(position, v->fec->io_size, &rem);
 	*offset = (unsigned int)rem;
 
-	res = dm_bufio_read(v->fec->bufio, block, buf);
+	res = dm_bufio_read(v->fec->bufio, block, buf, IOPRIO_DEFAULT);
 	if (IS_ERR(res)) {
 		DMERR("%s: FEC %llu: parity read failed (block %llu): %ld",
 		      v->data_dev->name, (unsigned long long)rsb,
@@ -247,7 +247,7 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
 			bufio = v->bufio;
 		}
 
-		bbuf = dm_bufio_read(bufio, block, &buf);
+		bbuf = dm_bufio_read(bufio, block, &buf, IOPRIO_DEFAULT);
 		if (IS_ERR(bbuf)) {
 			DMWARN_LIMIT("%s: FEC %llu: read failed (%llu): %ld",
 				     v->data_dev->name,
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 26adcfea0302..0038e168f3d7 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -307,7 +307,7 @@ static int verity_verify_level(struct dm_verity *v, struct dm_verity_io *io,
 			return -EAGAIN;
 		}
 	} else
-		data = dm_bufio_read(v->bufio, hash_block, &buf);
+		data = dm_bufio_read(v->bufio, hash_block, &buf, IOPRIO_DEFAULT);
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
@@ -717,7 +717,7 @@ static void verity_prefetch_io(struct work_struct *work)
 		}
 no_prefetch_cluster:
 		dm_bufio_prefetch(v->bufio, hash_block_start,
-				  hash_block_end - hash_block_start + 1);
+				  hash_block_end - hash_block_start + 1, IOPRIO_DEFAULT);
 	}
 
 	kfree(pw);
diff --git a/drivers/md/persistent-data/dm-block-manager.c b/drivers/md/persistent-data/dm-block-manager.c
index 0e010e1204aa..86a4f73d2f3d 100644
--- a/drivers/md/persistent-data/dm-block-manager.c
+++ b/drivers/md/persistent-data/dm-block-manager.c
@@ -474,7 +474,7 @@ int dm_bm_read_lock(struct dm_block_manager *bm, dm_block_t b,
 	void *p;
 	int r;
 
-	p = dm_bufio_read(bm->bufio, b, (struct dm_buffer **) result);
+	p = dm_bufio_read(bm->bufio, b, (struct dm_buffer **) result, IOPRIO_DEFAULT);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
 
@@ -510,7 +510,7 @@ int dm_bm_write_lock(struct dm_block_manager *bm,
 	if (dm_bm_is_read_only(bm))
 		return -EPERM;
 
-	p = dm_bufio_read(bm->bufio, b, (struct dm_buffer **) result);
+	p = dm_bufio_read(bm->bufio, b, (struct dm_buffer **) result, IOPRIO_DEFAULT);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
 
@@ -624,7 +624,7 @@ EXPORT_SYMBOL_GPL(dm_bm_flush);
 
 void dm_bm_prefetch(struct dm_block_manager *bm, dm_block_t b)
 {
-	dm_bufio_prefetch(bm->bufio, b, 1);
+	dm_bufio_prefetch(bm->bufio, b, 1, IOPRIO_DEFAULT);
 }
 
 bool dm_bm_is_read_only(struct dm_block_manager *bm)
diff --git a/include/linux/dm-bufio.h b/include/linux/dm-bufio.h
index 75e7d8cbb532..6cdd9cb66dd5 100644
--- a/include/linux/dm-bufio.h
+++ b/include/linux/dm-bufio.h
@@ -62,7 +62,7 @@ void dm_bufio_set_sector_offset(struct dm_bufio_client *c, sector_t start);
  * it dirty.
  */
 void *dm_bufio_read(struct dm_bufio_client *c, sector_t block,
-		    struct dm_buffer **bp);
+		    struct dm_buffer **bp, unsigned short ioprio);
 
 /*
  * Like dm_bufio_read, but return buffer from cache, don't read
@@ -84,8 +84,7 @@ void *dm_bufio_new(struct dm_bufio_client *c, sector_t block,
  * I/O to finish.
  */
 void dm_bufio_prefetch(struct dm_bufio_client *c,
-		       sector_t block, unsigned int n_blocks);
-
+		       sector_t block, unsigned int n_blocks, unsigned short ioprio);
 /*
  * Release a reference obtained with dm_bufio_{read,get,new}. The data
  * pointer and dm_buffer pointer is no longer valid after this call.
-- 
2.34.1

