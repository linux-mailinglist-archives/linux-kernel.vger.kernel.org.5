Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A19879E255
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbjIMIjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239015AbjIMIjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:39:10 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6067019AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EOqlq
        SAkn0k3xbfI47MZ3fOAdq93w0S0QRWAAFzrDC4=; b=K6t/DXXC4Dtt0OrhKO75c
        eE8F5UsbDcgDZMdkezi+yZw4G7sm9iJSgjptRX+takJBZ59PxiYNMd6tvFbFJw/U
        aa/DaMealt6ebaKBrfvlHWm2ITqEFyNMtr+J9Qqd5vbOfATl2RPDfu0+m291ObA1
        A5DY3iAlcGM+8tqJ5iAtVY=
Received: from localhost.localdomain (unknown [223.166.237.2])
        by zwqz-smtp-mta-g1-1 (Coremail) with SMTP id _____wAnln7QdAFli8i+Bw--.56942S5;
        Wed, 13 Sep 2023 16:37:57 +0800 (CST)
From:   Ping Gan <jacky_gam_2001@163.com>
To:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        kch@nvidia.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     ping_gan@dell.com, jacky_gam_2001@163.com
Subject: [PATCH 3/4] nvmet: support bio polling queue request
Date:   Wed, 13 Sep 2023 16:36:43 +0800
Message-Id: <cb74516ed445c47cecd0e9500f5766d6e8615e83.1694592708.git.jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1694592708.git.jacky_gam_2001@163.com>
References: <cover.1694592708.git.jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnln7QdAFli8i+Bw--.56942S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr4UJFWxGFyxKF1UtryUAwb_yoWfXr4kpF
        y3JFWktrZ7GrsY9a13Jry7Aay3Ka48Aa4DJr4xWrn3Gr4ft3s3WF1UKFyFvFyfKr95uFZr
        Gwn0yFWxuw45W3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR1mhrUUUUU=
X-Originating-IP: [223.166.237.2]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiWAfpKWNftmHX9QAAsW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If enabling bio polling queue task, we will split and chain
the bios if needed, then fill the request to the lossless ring
of polling queue task.

Signed-off-by: Ping Gan <jacky_gam_2001@163.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 243 ++++++++++++++++++++++++++----
 1 file changed, 214 insertions(+), 29 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 468833675cc9..6f7d04ae6cb7 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -184,6 +184,16 @@ static void nvmet_bio_done(struct bio *bio)
 	nvmet_req_bio_put(req, bio);
 }
 
+static void nvmet_pqt_bio_done(struct bio *bio)
+{
+	struct nvmet_pqt_bio_req *req_done = bio->bi_private;
+
+	nvmet_req_complete(req_done->req, blk_to_nvme_status(req_done->req,
+							bio->bi_status));
+	nvmet_req_bio_put(req_done->req, bio);
+	req_done->io_completed = 1;
+}
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
 				struct sg_mapping_iter *miter)
@@ -237,6 +247,38 @@ static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
+#ifdef CONFIG_NVME_MULTIPATH
+extern struct block_device *nvme_mpath_get_bdev(struct block_device *bdev);
+extern const struct block_device_operations nvme_ns_head_ops;
+#endif
+
+static inline int nvmet_chain_par_bio(struct nvmet_req *req, struct bio **bio,
+					struct sg_mapping_iter *prot_miter, struct block_device *bdev,
+					sector_t sector, struct bio_list *blist)
+{
+	struct bio *parent, *child;
+	unsigned int vec_cnt;
+	int rc;
+
+	parent = *bio;
+	vec_cnt = queue_max_segments(bdev->bd_disk->queue);
+	if (req->metadata_len) {
+		rc = nvmet_bdev_alloc_bip(req, parent,
+						prot_miter);
+		if (unlikely(rc))
+			return rc;
+	}
+	child = bio_alloc(bdev, vec_cnt, parent->bi_opf, GFP_KERNEL);
+	child->bi_iter.bi_sector = sector;
+	*bio = child;
+	bio_chain(*bio, parent);
+	parent->bi_opf |= REQ_POLLED;
+	parent->bi_opf |= REQ_NOWAIT;
+	parent->bi_opf |= REQ_NOMERGE;
+	bio_list_add(blist, parent);
+	return 0;
+}
+
 static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 {
 	unsigned int sg_cnt = req->sg_cnt;
@@ -247,8 +289,13 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	blk_opf_t opf;
 	int i, rc;
 	struct sg_mapping_iter prot_miter;
-	unsigned int iter_flags;
+	unsigned int iter_flags, max_sectors;
+	unsigned short vec_cnt, max_segments;
 	unsigned int total_len = nvmet_rw_data_len(req) + req->metadata_len;
+	bool pqt_enabled = nvmet_pqt_enabled();
+	unsigned int sg_len;
+	struct nvmet_pqt_bio_req *req_done = NULL;
+	struct block_device *bdev = req->ns->bdev;
 
 	if (!nvmet_check_transfer_len(req, total_len))
 		return;
@@ -268,6 +315,24 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		iter_flags = SG_MITER_FROM_SG;
 	}
 
+#ifdef CONFIG_NVME_MULTIPATH
+	if (pqt_enabled && bdev->bd_disk->fops == &nvme_ns_head_ops) {
+		bdev = nvme_mpath_get_bdev(bdev);
+		if (!bdev) {
+			nvmet_req_complete(req, 0);
+			return;
+		}
+		opf |= REQ_DRV;
+	}
+#endif
+	if (pqt_enabled) {
+		req_done = kmalloc(sizeof(struct nvmet_pqt_bio_req), GFP_KERNEL);
+		if (!req_done) {
+			nvmet_req_complete(req, 0);
+			return;
+		}
+	}
+
 	if (is_pci_p2pdma_page(sg_page(req->sg)))
 		opf |= REQ_NOMERGE;
 
@@ -278,54 +343,174 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		bio_init(bio, req->ns->bdev, req->inline_bvec,
 			 ARRAY_SIZE(req->inline_bvec), opf);
 	} else {
-		bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt), opf,
+		vec_cnt = bio_max_segs(sg_cnt);
+		if (pqt_enabled)
+			vec_cnt = queue_max_segments(bdev->bd_disk->queue);
+		bio = bio_alloc(bdev, vec_cnt, opf,
 				GFP_KERNEL);
 	}
 	bio->bi_iter.bi_sector = sector;
-	bio->bi_private = req;
-	bio->bi_end_io = nvmet_bio_done;
+	if (!pqt_enabled) {
+		bio->bi_private = req;
+		bio->bi_end_io = nvmet_bio_done;
+	} else {
+		req_done->req = req;
+		bio->bi_private = req_done;
+		bio->bi_end_io = nvmet_pqt_bio_done;
+	}
 
-	blk_start_plug(&plug);
+	if (!pqt_enabled)
+		blk_start_plug(&plug);
 	if (req->metadata_len)
 		sg_miter_start(&prot_miter, req->metadata_sg,
 			       req->metadata_sg_cnt, iter_flags);
 
-	for_each_sg(req->sg, sg, req->sg_cnt, i) {
-		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
-				!= sg->length) {
-			struct bio *prev = bio;
-
-			if (req->metadata_len) {
-				rc = nvmet_bdev_alloc_bip(req, bio,
-							  &prot_miter);
-				if (unlikely(rc)) {
-					bio_io_error(bio);
-					return;
+	if (!pqt_enabled) {
+		for_each_sg(req->sg, sg, req->sg_cnt, i) {
+			while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
+					!= sg->length) {
+				struct bio *prev = bio;
+
+				if (req->metadata_len) {
+					rc = nvmet_bdev_alloc_bip(req, bio,
+								  &prot_miter);
+					if (unlikely(rc)) {
+						bio_io_error(bio);
+						return;
+					}
 				}
-			}
 
-			bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt),
-					opf, GFP_KERNEL);
-			bio->bi_iter.bi_sector = sector;
+				bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt),
+						opf, GFP_KERNEL);
+				bio->bi_iter.bi_sector = sector;
 
-			bio_chain(bio, prev);
-			submit_bio(prev);
-		}
+				bio_chain(bio, prev);
+				submit_bio(prev);
+			}
 
-		sector += sg->length >> 9;
-		sg_cnt--;
+			sector += sg->length >> 9;
+			sg_cnt--;
+		}
+	} else {
+		bio_list_init(&req_done->blist);
+		if (!test_bit(QUEUE_FLAG_POLL, &bdev->bd_disk->queue->queue_flags))
+			goto err_bio;
+		max_sectors = bdev->bd_disk->queue->limits.max_sectors;
+		max_sectors <<= 9;
+		max_segments = queue_max_segments(bdev->bd_disk->queue);
+		sg_len = 0;
+		unsigned int offset, len, vec_len, i;
+		bool sg_start_pg = true, need_chain_bio = false;
+		struct page *sglist_page, *max_sector_align;
+		sector_t temp_sector;
+
+		/*
+		 * for bio's polling mode we will split bio to
+		 * avoid low level's bio splitting when submit.
+		 */
+		for_each_sg(req->sg, sg, req->sg_cnt, i) {
+			temp_sector = sector;
+			offset = (sg->offset % PAGE_SIZE);
+			if (offset + sg->length > PAGE_SIZE) { // need to split
+				len = sg->length;
+				i = 0;
+				sglist_page = virt_to_page(page_to_virt(sg_page(sg)) + offset);
+				if (offset != 0)
+					sg_start_pg = false;
+				while (len > PAGE_SIZE) {
+					max_sector_align = virt_to_page(page_to_virt(sglist_page) +
+											(PAGE_SIZE*i));
+					vec_len = sg_start_pg?PAGE_SIZE:(PAGE_SIZE - offset);
+					if (bio->bi_vcnt == max_segments - 1 ||
+							sg_len + vec_len > max_sectors)
+						need_chain_bio = true;
+					else {
+						__bio_add_page(bio, max_sector_align,
+								vec_len, sg_start_pg?0:offset);
+						temp_sector += vec_len >> 9;
+						sg_len += vec_len;
+					}
+					if (need_chain_bio) {
+						rc = nvmet_chain_par_bio(req, &bio, &prot_miter,
+								bdev, temp_sector, &req_done->blist);
+						if (unlikely(rc))
+							goto err_bio;
+						__bio_add_page(bio, max_sector_align, vec_len,
+								sg_start_pg?0:(PAGE_SIZE - offset));
+						temp_sector += vec_len >> 9;
+						sg_len = vec_len;
+						need_chain_bio = false;
+					}
+					if (!sg_start_pg) {
+						len -= (PAGE_SIZE - offset);
+						sg_start_pg = true;
+					} else {
+						len -= PAGE_SIZE;
+					}
+					i++;
+				}
+				if (len > 0) {
+					max_sector_align = virt_to_page(page_to_virt(sglist_page) +
+											(i * PAGE_SIZE));
+					if (bio->bi_vcnt == max_segments - 1 ||
+							sg_len + len > max_sectors) {
+						rc = nvmet_chain_par_bio(req, &bio, &prot_miter,
+								bdev, temp_sector, &req_done->blist);
+						if (unlikely(rc))
+							goto err_bio;
+						sg_len = len;
+					} else {
+						sg_len += len;
+					}
+					__bio_add_page(bio, max_sector_align, len, 0);
+					temp_sector += len >> 9;
+				}
+			} else {
+				if (bio->bi_vcnt == max_segments - 1 ||
+						sg_len + sg->length > max_sectors) {
+					rc = nvmet_chain_par_bio(req, &bio, &prot_miter,
+							bdev, temp_sector, &req_done->blist);
+					if (unlikely(rc))
+						goto err_bio;
+					sg_len = sg->length;
+				} else {
+					sg_len += sg->length;
+				}
+				__bio_add_page(bio, sg_page(sg), sg->length, sg->offset);
+			}
+			sector += sg->length >> 9;
+			sg_cnt--;
+		}
 	}
 
 	if (req->metadata_len) {
 		rc = nvmet_bdev_alloc_bip(req, bio, &prot_miter);
 		if (unlikely(rc)) {
-			bio_io_error(bio);
-			return;
+			goto err_bio;
 		}
 	}
 
-	submit_bio(bio);
-	blk_finish_plug(&plug);
+	if (pqt_enabled) {
+		bio->bi_opf |= REQ_POLLED;
+		bio->bi_opf |= REQ_NOWAIT;
+		bio->bi_opf |= REQ_NOMERGE;
+		bio_list_add(&req_done->blist, bio);
+		req_done->io_completed = 0;
+		rc = nvmet_pqt_ring_enqueue(req_done);
+		if (rc < 0)
+			goto err_bio;
+		nvmet_wakeup_pq_thread();
+	} else {
+	    submit_bio(bio);
+    }
+	if (!pqt_enabled)
+		blk_finish_plug(&plug);
+	return;
+err_bio:
+	bio_io_error(bio);
+	if (pqt_enabled)
+		kfree(req_done);
+	return;
 }
 
 static void nvmet_bdev_execute_flush(struct nvmet_req *req)
-- 
2.26.2

