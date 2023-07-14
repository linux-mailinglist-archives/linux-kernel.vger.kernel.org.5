Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB4E753326
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbjGNHZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjGNHZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:25:30 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA0E26B3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:25:28 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6ff1a637bso23288621fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1689319526; x=1689924326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INc/TS7QOh9fQC5c+QqVp/zFHtW2y0nMgCcHWWOJr2I=;
        b=F1WdcPAx1MP7oylmsiOp45N20VyTWpc3DBEph1KZ7tuRk7P3fucJTfDFqr3ughzMls
         s7CyHzVdWTdsLLAm8+Z02rDW5a3sZBJIbuGY0uMbwF395u10g4Q3GSKhTN3fyM5DKk63
         9yhmzsZxkVwasrm9t1hBcEwW9KtdLiy/jayP9CCjA4Nqxhy1Eoz7OpBv1ucXg/6jU3hB
         4snSDy9QI1v2UIEZK7bC1Bhevd0IsiD7179Xr3ih/SVHGKyAI3ahZF64zQ572j7JmYk3
         DTr9YAr5opEUPdJBXSz5gZuiRs6Zmu6G1F5SZHq6QaRvODhByIwRIiEDfNHtbVEsq/MR
         odjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689319526; x=1689924326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INc/TS7QOh9fQC5c+QqVp/zFHtW2y0nMgCcHWWOJr2I=;
        b=Ogdoet5A3kz1cRF9DqwPATAKsIj38zZv69sPbKoPlV10OQ3S9EmQ1fXAGCxy9Fpk23
         0tXwd4uYuKQiB+WdqWUfE2yxVWlqQsteskVyuwp/L1YnZ3I2PxMZVqdwMlyd7Gf7KDxC
         DQ05JIXdNKD/9VEBBvMiMWLCbyu4DU7sqVRivQ25FRcJIJg4rgZUK+8ndJu5EeC0abIG
         86MogWrFwu3iCR6o6kgnWaHD52mx73mj9BgVcBAPJ1rtjPC4qvQ9+0pikX9kIgSo3Igg
         9vaNkRGtf5k+IgHhIB60YPd+9GSFKYlW7LVAx9h+x0HUFywr+TqxRde1VVnlcTio1iPC
         H7uQ==
X-Gm-Message-State: ABy/qLaGHR0dU+vnqNMHeJFG8jyRLr9e26QrlAyntuixTHPnU1IOQXrd
        LEsL9mR7DvIahxjjsh3JWFF0Iw==
X-Google-Smtp-Source: APBJJlEzT831mYin6z0TZotV9ghyjNDb6VGW+JTp2i1O91U+n3+mg7iubP2IG+xEPAi+sp7chD5EBQ==
X-Received: by 2002:a2e:8810:0:b0:2b6:d2c5:4d54 with SMTP id x16-20020a2e8810000000b002b6d2c54d54mr3726013ljh.18.1689319526283;
        Fri, 14 Jul 2023 00:25:26 -0700 (PDT)
Received: from localhost ([185.108.254.55])
        by smtp.gmail.com with ESMTPSA id p2-20020a2e8042000000b002b6b60c14besm1869415ljg.29.2023.07.14.00.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 00:25:25 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Matias Bjorling <Matias.Bjorling@wdc.com>,
        linux-kernel@vger.kernel.org (open list),
        Damien Le Moal <dlemoal@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, gost.dev@samsung.com,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH v9 2/2] ublk: enable zoned storage support
Date:   Fri, 14 Jul 2023 09:25:10 +0200
Message-ID: <20230714072510.47770-3-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714072510.47770-1-nmi@metaspace.dk>
References: <20230714072510.47770-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Add zoned storage support to ublk: report_zones and operations:
 - REQ_OP_ZONE_OPEN
 - REQ_OP_ZONE_CLOSE
 - REQ_OP_ZONE_FINISH
 - REQ_OP_ZONE_RESET
 - REQ_OP_ZONE_APPEND

The zone append feature uses the `addr` field of `struct ublksrv_io_cmd` to
communicate ALBA back to the kernel. Therefore ublk must be used with the
user copy feature (UBLK_F_USER_COPY) for zoned storage support to be
available. Without this feature, ublk will not allow zoned storage support.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 drivers/block/ublk_drv.c      | 335 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  36 +++-
 2 files changed, 354 insertions(+), 17 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8d271901efac..5698f4575e05 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -56,16 +56,21 @@
 		| UBLK_F_USER_RECOVERY_REISSUE \
 		| UBLK_F_UNPRIVILEGED_DEV \
 		| UBLK_F_CMD_IOCTL_ENCODE \
-		| UBLK_F_USER_COPY)
+		| UBLK_F_USER_COPY \
+		| UBLK_F_ZONED)
 
 /* All UBLK_PARAM_TYPE_* should be included here */
-#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
-		UBLK_PARAM_TYPE_DISCARD | UBLK_PARAM_TYPE_DEVT)
+#define UBLK_PARAM_TYPE_ALL                                \
+	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
+	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED)
 
 struct ublk_rq_data {
 	struct llist_node node;
 
 	struct kref ref;
+	__u64 sector;
+	__u32 operation;
+	__u32 nr_sectors;
 };
 
 struct ublk_uring_cmd_pdu {
@@ -110,6 +115,11 @@ struct ublk_uring_cmd_pdu {
  */
 #define UBLK_IO_FLAG_NEED_GET_DATA 0x08
 
+/*
+ * Set when IO is Zone Append
+ */
+#define UBLK_IO_FLAG_ZONE_APPEND 0x10
+
 struct ublk_io {
 	/* userspace buffer address from io cmd */
 	__u64	addr;
@@ -185,11 +195,264 @@ struct ublk_params_header {
 	__u32	types;
 };
 
+static inline unsigned int ublk_req_build_flags(struct request *req);
+static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
+						   int tag);
+
 static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
 {
 	return ub->dev_info.flags & UBLK_F_USER_COPY;
 }
 
+static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_ZONED;
+}
+
+static inline bool ublk_queue_is_zoned(struct ublk_queue *ubq)
+{
+	return ubq->flags & UBLK_F_ZONED;
+}
+
+#ifdef CONFIG_BLK_DEV_ZONED
+
+static int ublk_get_nr_zones(const struct ublk_device *ub)
+{
+	const struct ublk_param_basic *p = &ub->params.basic;
+
+	/* Zone size is a power of 2 */
+	return p->dev_sectors >> ilog2(p->chunk_sectors);
+}
+
+static int ublk_revalidate_disk_zones(struct ublk_device *ub)
+{
+	return blk_revalidate_disk_zones(ub->ub_disk, NULL);
+}
+
+static int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
+{
+	const struct ublk_param_zoned *p = &ub->params.zoned;
+	int nr_zones;
+
+	if (!ublk_dev_is_zoned(ub))
+		return -EINVAL;
+
+	if (!p->max_zone_append_sectors)
+		return -EINVAL;
+
+	nr_zones = ublk_get_nr_zones(ub);
+
+	if (p->max_active_zones > nr_zones)
+		return -EINVAL;
+
+	if (p->max_open_zones > nr_zones)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ublk_dev_param_zoned_apply(struct ublk_device *ub)
+{
+	const struct ublk_param_zoned *p = &ub->params.zoned;
+
+	disk_set_zoned(ub->ub_disk, BLK_ZONED_HM);
+	blk_queue_required_elevator_features(ub->ub_disk->queue,
+					     ELEVATOR_F_ZBD_SEQ_WRITE);
+	disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
+	disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
+	blk_queue_max_zone_append_sectors(ub->ub_disk->queue, p->max_zone_append_sectors);
+
+	ub->ub_disk->nr_zones = ublk_get_nr_zones(ub);
+
+	return 0;
+}
+
+/* Based on virtblk_alloc_report_buffer */
+static void *ublk_alloc_report_buffer(struct ublk_device *ublk,
+				      unsigned int nr_zones, size_t *buflen)
+{
+	struct request_queue *q = ublk->ub_disk->queue;
+	size_t bufsize;
+	void *buf;
+
+	nr_zones = min_t(unsigned int, nr_zones,
+			 ublk->ub_disk->nr_zones);
+
+	bufsize = nr_zones * sizeof(struct blk_zone);
+	bufsize =
+		min_t(size_t, bufsize, queue_max_hw_sectors(q) << SECTOR_SHIFT);
+
+	while (bufsize >= sizeof(struct blk_zone)) {
+		buf = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
+		if (buf) {
+			*buflen = bufsize;
+			return buf;
+		}
+		bufsize >>= 1;
+	}
+
+	*buflen = 0;
+	return NULL;
+}
+
+static int ublk_report_zones(struct gendisk *disk, sector_t sector,
+		      unsigned int nr_zones, report_zones_cb cb, void *data)
+{
+	struct ublk_device *ub = disk->private_data;
+	unsigned int zone_size_sectors = disk->queue->limits.chunk_sectors;
+	unsigned int first_zone = sector >> ilog2(zone_size_sectors);
+	unsigned int done_zones = 0;
+	unsigned int max_zones_per_request;
+	int ret;
+	struct blk_zone *buffer;
+	size_t buffer_length;
+
+	nr_zones = min_t(unsigned int, ub->ub_disk->nr_zones - first_zone,
+			 nr_zones);
+
+	buffer = ublk_alloc_report_buffer(ub, nr_zones, &buffer_length);
+	if (!buffer)
+		return -ENOMEM;
+
+	max_zones_per_request = buffer_length / sizeof(struct blk_zone);
+
+	while (done_zones < nr_zones) {
+		unsigned int remaining_zones = nr_zones - done_zones;
+		unsigned int zones_in_request =
+			min_t(unsigned int, remaining_zones, max_zones_per_request);
+		struct request *req;
+		struct ublk_rq_data *pdu;
+		blk_status_t status;
+
+		memset(buffer, 0, buffer_length);
+
+		req = blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
+		if (IS_ERR(req)) {
+			ret = PTR_ERR(req);
+			goto out;
+		}
+
+		pdu = blk_mq_rq_to_pdu(req);
+		pdu->operation = UBLK_IO_OP_REPORT_ZONES;
+		pdu->sector = sector;
+		pdu->nr_sectors = zones_in_request * zone_size_sectors;
+
+		ret = blk_rq_map_kern(disk->queue, req, buffer, buffer_length,
+					GFP_KERNEL);
+		if (ret) {
+			blk_mq_free_request(req);
+			goto out;
+		}
+
+		status = blk_execute_rq(req, 0);
+		ret = blk_status_to_errno(status);
+		blk_mq_free_request(req);
+		if (ret)
+			goto out;
+
+		for (unsigned int i = 0; i < zones_in_request; i++) {
+			struct blk_zone *zone = buffer + i;
+
+			/* A zero length zone means no more zones in this response */
+			if (!zone->len)
+				break;
+
+			ret = cb(zone, i, data);
+			if (ret)
+				goto out;
+
+			done_zones++;
+			sector += zone_size_sectors;
+
+		}
+	}
+
+	ret = done_zones;
+
+out:
+	kvfree(buffer);
+	return ret;
+}
+
+static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
+					 struct request *req)
+{
+	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
+	struct ublk_io *io = &ubq->ios[req->tag];
+	struct ublk_rq_data *pdu = blk_mq_rq_to_pdu(req);
+	u32 ublk_op;
+
+	switch (req_op(req)) {
+	case REQ_OP_ZONE_OPEN:
+		ublk_op = UBLK_IO_OP_ZONE_OPEN;
+		break;
+	case REQ_OP_ZONE_CLOSE:
+		ublk_op = UBLK_IO_OP_ZONE_CLOSE;
+		break;
+	case REQ_OP_ZONE_FINISH:
+		ublk_op = UBLK_IO_OP_ZONE_FINISH;
+		break;
+	case REQ_OP_ZONE_RESET:
+		ublk_op = UBLK_IO_OP_ZONE_RESET;
+		break;
+	case REQ_OP_ZONE_APPEND:
+		ublk_op = UBLK_IO_OP_ZONE_APPEND;
+		io->flags |= UBLK_IO_FLAG_ZONE_APPEND;
+		break;
+	case REQ_OP_DRV_IN:
+		ublk_op = pdu->operation;
+		switch (ublk_op) {
+		case UBLK_IO_OP_REPORT_ZONES:
+			iod->op_flags = ublk_op | ublk_req_build_flags(req);
+			iod->nr_sectors = pdu->nr_sectors;
+			iod->start_sector = pdu->sector;
+			return BLK_STS_OK;
+		default:
+			return BLK_STS_IOERR;
+		}
+	case REQ_OP_ZONE_RESET_ALL:
+	case REQ_OP_DRV_OUT:
+		/* We do not support reset_all and drv_out */
+		return BLK_STS_NOTSUPP;
+	default:
+		return BLK_STS_IOERR;
+	}
+
+	iod->op_flags = ublk_op | ublk_req_build_flags(req);
+	iod->nr_sectors = blk_rq_sectors(req);
+	iod->start_sector = blk_rq_pos(req);
+	iod->addr = io->addr;
+
+	return BLK_STS_OK;
+}
+
+#else
+
+#define ublk_report_zones (NULL)
+
+static int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ublk_dev_param_zoned_apply(struct ublk_device *ub)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ublk_revalidate_disk_zones(struct ublk_device *ub)
+{
+	return 0;
+}
+
+static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
+					 struct request *req)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif
+
 static inline void __ublk_complete_rq(struct request *req);
 static void ublk_complete_rq(struct kref *ref);
 
@@ -286,6 +549,9 @@ static int ublk_validate_params(const struct ublk_device *ub)
 
 		if (p->max_sectors > (ub->dev_info.max_io_buf_bytes >> 9))
 			return -EINVAL;
+
+		if (ublk_dev_is_zoned(ub) && !p->chunk_sectors)
+			return -EINVAL;
 	} else
 		return -EINVAL;
 
@@ -304,6 +570,11 @@ static int ublk_validate_params(const struct ublk_device *ub)
 	if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
 		return -EINVAL;
 
+	if (ub->params.types & UBLK_PARAM_TYPE_ZONED)
+		return ublk_dev_param_zoned_validate(ub);
+	else if (ublk_dev_is_zoned(ub))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -317,6 +588,9 @@ static int ublk_apply_params(struct ublk_device *ub)
 	if (ub->params.types & UBLK_PARAM_TYPE_DISCARD)
 		ublk_dev_param_discard_apply(ub);
 
+	if (ub->params.types & UBLK_PARAM_TYPE_ZONED)
+		return ublk_dev_param_zoned_apply(ub);
+
 	return 0;
 }
 
@@ -487,6 +761,7 @@ static const struct block_device_operations ub_fops = {
 	.owner =	THIS_MODULE,
 	.open =		ublk_open,
 	.free_disk =	ublk_free_disk,
+	.report_zones =	ublk_report_zones,
 };
 
 #define UBLK_MAX_PIN_PAGES	32
@@ -601,7 +876,8 @@ static inline bool ublk_need_map_req(const struct request *req)
 
 static inline bool ublk_need_unmap_req(const struct request *req)
 {
-	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_READ;
+	return ublk_rq_has_data(req) &&
+	       (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN);
 }
 
 static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
@@ -685,8 +961,13 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 {
 	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
 	struct ublk_io *io = &ubq->ios[req->tag];
+	enum req_op op = req_op(req);
 	u32 ublk_op;
 
+	if (!ublk_queue_is_zoned(ubq) &&
+	    (op_is_zone_mgmt(op) || op == REQ_OP_ZONE_APPEND))
+		return -EIO;
+
 	switch (req_op(req)) {
 	case REQ_OP_READ:
 		ublk_op = UBLK_IO_OP_READ;
@@ -704,6 +985,8 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 		ublk_op = UBLK_IO_OP_WRITE_ZEROES;
 		break;
 	default:
+		if (ublk_queue_is_zoned(ubq))
+			return ublk_setup_iod_zoned(ubq, req);
 		return BLK_STS_IOERR;
 	}
 
@@ -756,7 +1039,8 @@ static inline void __ublk_complete_rq(struct request *req)
 	 *
 	 * Both the two needn't unmap.
 	 */
-	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE)
+	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE &&
+	    req_op(req) != REQ_OP_DRV_IN)
 		goto exit;
 
 	/* for READ request, writing data in iod->addr to rq buffers */
@@ -1120,6 +1404,11 @@ static void ublk_commit_completion(struct ublk_device *ub,
 	/* find the io request and complete */
 	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
 
+	if (io->flags & UBLK_IO_FLAG_ZONE_APPEND) {
+		req->__sector = ub_cmd->addr;
+		io->flags &= ~UBLK_IO_FLAG_ZONE_APPEND;
+	}
+
 	if (req && likely(!blk_should_fake_timeout(req->q)))
 		ublk_put_req_ref(ubq, req);
 }
@@ -1419,7 +1708,8 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
 		goto out;
 
-	if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
+	if (ublk_support_user_copy(ubq) &&
+	    !(io->flags & UBLK_IO_FLAG_ZONE_APPEND) && ub_cmd->addr) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1542,11 +1832,14 @@ static inline bool ublk_check_ubuf_dir(const struct request *req,
 		int ubuf_dir)
 {
 	/* copy ubuf to request pages */
-	if (req_op(req) == REQ_OP_READ && ubuf_dir == ITER_SOURCE)
+	if ((req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN) &&
+	    ubuf_dir == ITER_SOURCE)
 		return true;
 
 	/* copy request pages to ubuf */
-	if (req_op(req) == REQ_OP_WRITE && ubuf_dir == ITER_DEST)
+	if ((req_op(req) == REQ_OP_WRITE ||
+	     req_op(req) == REQ_OP_ZONE_APPEND) &&
+	    ubuf_dir == ITER_DEST)
 		return true;
 
 	return false;
@@ -1885,17 +2178,24 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 
 	get_device(&ub->cdev_dev);
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
+
+	if (ublk_dev_is_zoned(ub)) {
+		ret = ublk_revalidate_disk_zones(ub);
+		if (ret)
+			goto out_put_cdev;
+	}
+
 	ret = add_disk(disk);
+	if (ret)
+		goto out_put_cdev;
+
+	set_bit(UB_STATE_USED, &ub->state);
+
+out_put_cdev:
 	if (ret) {
-		/*
-		 * Has to drop the reference since ->free_disk won't be
-		 * called in case of add_disk failure.
-		 */
 		ub->dev_info.state = UBLK_S_DEV_DEAD;
 		ublk_put_device(ub);
-		goto out_put_disk;
 	}
-	set_bit(UB_STATE_USED, &ub->state);
 out_put_disk:
 	if (ret)
 		put_disk(disk);
@@ -2045,6 +2345,13 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	if (ublk_dev_is_user_copy(ub))
 		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
 
+	/* Zoned storage support requires user copy feature */
+	if (ublk_dev_is_zoned(ub) &&
+	    (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) || !ublk_dev_is_user_copy(ub))) {
+		ret = -EINVAL;
+		goto out_free_dev_number;
+	}
+
 	/* We are not ready to support zero copy */
 	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 4b8558db90e1..4d97eb0f7d13 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -176,6 +176,12 @@
 /* Copy between request and user buffer by pread()/pwrite() */
 #define UBLK_F_USER_COPY	(1UL << 7)
 
+/*
+ * User space sets this flag when setting up the device to request zoned storage support. Kernel may
+ * deny the request by returning an error.
+ */
+#define UBLK_F_ZONED (1ULL << 8)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
@@ -232,9 +238,24 @@ struct ublksrv_ctrl_dev_info {
 #define		UBLK_IO_OP_READ		0
 #define		UBLK_IO_OP_WRITE		1
 #define		UBLK_IO_OP_FLUSH		2
-#define		UBLK_IO_OP_DISCARD	3
-#define		UBLK_IO_OP_WRITE_SAME	4
-#define		UBLK_IO_OP_WRITE_ZEROES	5
+#define		UBLK_IO_OP_DISCARD		3
+#define		UBLK_IO_OP_WRITE_SAME		4
+#define		UBLK_IO_OP_WRITE_ZEROES		5
+#define		UBLK_IO_OP_ZONE_OPEN		10
+#define		UBLK_IO_OP_ZONE_CLOSE		11
+#define		UBLK_IO_OP_ZONE_FINISH		12
+#define		UBLK_IO_OP_ZONE_APPEND		13
+#define		UBLK_IO_OP_ZONE_RESET		15
+/*
+ * Construct a zone report. The report request is carried in `struct
+ * ublksrv_io_desc`. The `start_sector` field must be the first sector of a zone
+ * and shall indicate the first zone of the report. The `nr_sectors` shall
+ * indicate how many zones should be reported (divide by zone size to get number
+ * of zones in the report) and must be an integer multiple of the zone size. The
+ * report shall be delivered as a `struct blk_zone` array. To report fewer zones
+ * than requested, zero the last entry of the returned array.
+ */
+#define		UBLK_IO_OP_REPORT_ZONES		18
 
 #define		UBLK_IO_F_FAILFAST_DEV		(1U << 8)
 #define		UBLK_IO_F_FAILFAST_TRANSPORT	(1U << 9)
@@ -331,6 +352,13 @@ struct ublk_param_devt {
 	__u32   disk_minor;
 };
 
+struct ublk_param_zoned {
+	__u32	max_open_zones;
+	__u32	max_active_zones;
+	__u32	max_zone_append_sectors;
+	__u8	reserved[20];
+};
+
 struct ublk_params {
 	/*
 	 * Total length of parameters, userspace has to set 'len' for both
@@ -342,11 +370,13 @@ struct ublk_params {
 #define UBLK_PARAM_TYPE_BASIC           (1 << 0)
 #define UBLK_PARAM_TYPE_DISCARD         (1 << 1)
 #define UBLK_PARAM_TYPE_DEVT            (1 << 2)
+#define UBLK_PARAM_TYPE_ZONED           (1 << 3)
 	__u32	types;			/* types of parameter included */
 
 	struct ublk_param_basic		basic;
 	struct ublk_param_discard	discard;
 	struct ublk_param_devt		devt;
+	struct ublk_param_zoned	zoned;
 };
 
 #endif
-- 
2.41.0

