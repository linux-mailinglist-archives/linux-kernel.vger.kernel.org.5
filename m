Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB2076FF9D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjHDLqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjHDLqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:46:23 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9869513E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 04:46:16 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe0e34f498so3475102e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 04:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1691149575; x=1691754375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKIwrR5BN59/V8LhHC/Djv2VeOrVQgGtFQtn+MQpMwI=;
        b=sHkEZH0wPd74VY6+fxBMKePqG/hDmXbquNnubxjSEz9T0JdYHpgxTCLSjnIbJotnp2
         8R+JcBH1TLXZXyxhsyJKjnGj8wQ1hHHqiFevjHWN5ozw9idtWu+mA74d05qwcGSFchcF
         basL3L3yBRKoHpAiBz2Y9LT3DdoEuXp1guNMgCLrmGGHoGteF/E+0Sl2ReZ3zf+lffBU
         NIeBgz4HYMFLX9muKLfRWqDmJtnPx3xLYWa+WBTUNAC6K4COOg9OCwIJR6iRrguadBs+
         4IABQkpm3ozXcYg9vCx9i7dTVAUhFTc1eRZuxro5idPitW6DGSfN/zUei+93NhIF8BCW
         D/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691149575; x=1691754375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKIwrR5BN59/V8LhHC/Djv2VeOrVQgGtFQtn+MQpMwI=;
        b=MA3utmyU28oDtwP5LWLMss/81sJqBweedwnNbq+/U8RRWnj50gU6uxdW+LTEnsuFrh
         M9r+8QY/pp1pL2lvBnmvOJmts6njeSFksa3B56noCtopzCjsxJZasFXQCQmNmigZK5ir
         hrAcB3TYGVju7ZY+pwJYwTgIoK3lW1kcK1UELnkPB5BitIi+tIhghlz5TDz2ZZK2MXiY
         anDZnO5RB0P4NDtnOOPa6ojpJRoosT7I0UH1jJrJn+G+Lo2bTxjHakKgck7Z91BhtdQj
         9W1Zy57qHB+I9wb3bEBRUkMLiXJaD+x550Tnh1ukjYZQ3lqp4yoj7BN+mWk94LIzJXtB
         TF9w==
X-Gm-Message-State: AOJu0Yyir23HpAChS0gra+48qZPKujiDd7rLbCKSoMztFOMyqjGYKzlK
        pFY7XGcx1sYgY/AAk60/TFRQMA==
X-Google-Smtp-Source: AGHT+IGiV7SXPUPfsuoa/BpnF/yfFS11P84EaqAG3oVZHI0EsPgITJ4jpF3XTB28ROM4I3by77qojg==
X-Received: by 2002:a05:6512:32b3:b0:4f8:4719:1f4a with SMTP id q19-20020a05651232b300b004f847191f4amr1147847lfe.7.1691149574639;
        Fri, 04 Aug 2023 04:46:14 -0700 (PDT)
Received: from localhost ([194.62.217.4])
        by smtp.gmail.com with ESMTPSA id m1-20020a50ef01000000b00522bfd930dcsm1140172eds.33.2023.08.04.04.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 04:46:14 -0700 (PDT)
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER)
Subject: [PATCH v11 3/3] ublk: enable zoned storage support
Date:   Fri,  4 Aug 2023 13:46:10 +0200
Message-ID: <20230804114610.179530-4-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804114610.179530-1-nmi@metaspace.dk>
References: <20230804114610.179530-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/block/ublk_drv.c      | 331 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  63 ++++++-
 2 files changed, 370 insertions(+), 24 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5dba4b27d820..85a81ee556d5 100644
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
+	__u32 nr_zones;
 };
 
 struct ublk_uring_cmd_pdu {
@@ -185,11 +190,263 @@ struct ublk_params_header {
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
+		buf = kvmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
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
+		pdu->nr_zones = zones_in_request;
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
+		break;
+	case REQ_OP_DRV_IN:
+		ublk_op = pdu->operation;
+		switch (ublk_op) {
+		case UBLK_IO_OP_REPORT_ZONES:
+			iod->op_flags = ublk_op | ublk_req_build_flags(req);
+			iod->nr_zones = pdu->nr_zones;
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
 
@@ -286,6 +543,9 @@ static int ublk_validate_params(const struct ublk_device *ub)
 
 		if (p->max_sectors > (ub->dev_info.max_io_buf_bytes >> 9))
 			return -EINVAL;
+
+		if (ublk_dev_is_zoned(ub) && !p->chunk_sectors)
+			return -EINVAL;
 	} else
 		return -EINVAL;
 
@@ -304,6 +564,11 @@ static int ublk_validate_params(const struct ublk_device *ub)
 	if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
 		return -EINVAL;
 
+	if (ub->params.types & UBLK_PARAM_TYPE_ZONED)
+		return ublk_dev_param_zoned_validate(ub);
+	else if (ublk_dev_is_zoned(ub))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -317,6 +582,9 @@ static int ublk_apply_params(struct ublk_device *ub)
 	if (ub->params.types & UBLK_PARAM_TYPE_DISCARD)
 		ublk_dev_param_discard_apply(ub);
 
+	if (ub->params.types & UBLK_PARAM_TYPE_ZONED)
+		return ublk_dev_param_zoned_apply(ub);
+
 	return 0;
 }
 
@@ -487,6 +755,7 @@ static const struct block_device_operations ub_fops = {
 	.owner =	THIS_MODULE,
 	.open =		ublk_open,
 	.free_disk =	ublk_free_disk,
+	.report_zones =	ublk_report_zones,
 };
 
 #define UBLK_MAX_PIN_PAGES	32
@@ -601,7 +870,8 @@ static inline bool ublk_need_map_req(const struct request *req)
 
 static inline bool ublk_need_unmap_req(const struct request *req)
 {
-	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_READ;
+	return ublk_rq_has_data(req) &&
+	       (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN);
 }
 
 static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
@@ -685,8 +955,13 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
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
@@ -704,6 +979,8 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 		ublk_op = UBLK_IO_OP_WRITE_ZEROES;
 		break;
 	default:
+		if (ublk_queue_is_zoned(ubq))
+			return ublk_setup_iod_zoned(ubq, req);
 		return BLK_STS_IOERR;
 	}
 
@@ -756,7 +1033,8 @@ static inline void __ublk_complete_rq(struct request *req)
 	 *
 	 * Both the two needn't unmap.
 	 */
-	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE)
+	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE &&
+	    req_op(req) != REQ_OP_DRV_IN)
 		goto exit;
 
 	/* for READ request, writing data in iod->addr to rq buffers */
@@ -1120,6 +1398,9 @@ static void ublk_commit_completion(struct ublk_device *ub,
 	/* find the io request and complete */
 	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
 
+	if (req_op(req) == REQ_OP_ZONE_APPEND)
+		req->__sector = ub_cmd->zone_append_lba;
+
 	if (req && likely(!blk_should_fake_timeout(req->q)))
 		ublk_put_req_ref(ubq, req);
 }
@@ -1468,8 +1749,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			if (!ub_cmd->addr && (!ublk_need_get_data(ubq) ||
 						req_op(req) == REQ_OP_READ))
 				goto out;
-		} else if (ub_cmd->addr) {
-			/* User copy requires addr to be unset */
+		} else if (req_op(req) != REQ_OP_ZONE_APPEND && ub_cmd->addr) {
+			/*
+			 * User copy requires addr to be unset when command is
+			 * not zone append
+			 */
 			ret = -EINVAL;
 			goto out;
 		}
@@ -1546,11 +1830,14 @@ static inline bool ublk_check_ubuf_dir(const struct request *req,
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
@@ -1890,17 +2177,24 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 
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
@@ -2050,6 +2344,13 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
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
index 4b8558db90e1..2685e53e4752 100644
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
@@ -232,9 +238,26 @@ struct ublksrv_ctrl_dev_info {
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
+ * and shall indicate the first zone of the report. The `nr_zones` shall
+ * indicate how many zones should be reported at most. The report shall be
+ * delivered as a `struct blk_zone` array. To report fewer zones than requested,
+ * zero the last entry of the returned array.
+ *
+ * Related definitions(blk_zone, blk_zone_cond, blk_zone_type, ...) in
+ * include/uapi/linux/blkzoned.h are part of ublk UAPI.
+ */
+#define		UBLK_IO_OP_REPORT_ZONES		18
 
 #define		UBLK_IO_F_FAILFAST_DEV		(1U << 8)
 #define		UBLK_IO_F_FAILFAST_TRANSPORT	(1U << 9)
@@ -255,7 +278,10 @@ struct ublksrv_io_desc {
 	/* op: bit 0-7, flags: bit 8-31 */
 	__u32		op_flags;
 
-	__u32		nr_sectors;
+	union {
+		__u32		nr_sectors;
+		__u32		nr_zones; /* for UBLK_IO_OP_REPORT_ZONES */
+	};
 
 	/* start sector for this io */
 	__u64		start_sector;
@@ -284,11 +310,21 @@ struct ublksrv_io_cmd {
 	/* io result, it is valid for COMMIT* command only */
 	__s32	result;
 
-	/*
-	 * userspace buffer address in ublksrv daemon process, valid for
-	 * FETCH* command only
-	 */
-	__u64	addr;
+	union {
+		/*
+		 * userspace buffer address in ublksrv daemon process, valid for
+		 * FETCH* command only
+		 *
+		 * `addr` should not be used when UBLK_F_USER_COPY is enabled,
+		 * because userspace handles data copy by pread()/pwrite() over
+		 * /dev/ublkcN. But in case of UBLK_F_ZONED, this union is
+		 * re-used to pass back the allocated LBA for
+		 * UBLK_IO_OP_ZONE_APPEND which actually depends on
+		 * UBLK_F_USER_COPY
+		 */
+		__u64	addr;
+		__u64	zone_append_lba;
+	};
 };
 
 struct ublk_param_basic {
@@ -331,6 +367,13 @@ struct ublk_param_devt {
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
@@ -342,11 +385,13 @@ struct ublk_params {
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

