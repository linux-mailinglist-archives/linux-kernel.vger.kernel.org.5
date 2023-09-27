Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482967B08AA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjI0Pgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjI0PgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:36:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED831AA;
        Wed, 27 Sep 2023 08:36:14 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:672:46bd:3ec7:6cdf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9F6206607340;
        Wed, 27 Sep 2023 16:36:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695828973;
        bh=3VXfNG7IRKWayMDJjnY2OKvWXtDhSL9t0ZbBJkpT8oE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AhE295z6Os2kSjstjZHnsbiS75NyBPd4qD9gvpD25Q1hSa0aZkYI6gMw2uLu1QUQ8
         fzsVB053ECNYZFvIh7eTQ2e8mk1x/JXCcH6KDSF/bcl8Syhrt9KjC1jcDbVFeLENFw
         sI2z8DT/21Wq6YUaQy5fWOKJOZlPk32xK8fGqhsX2R2Wg8+KCTSYq+v57poKzz1d7N
         3RG8GuKm12qaGcRfu+yqCDu1NW00ouO2XL9FBmL1vSRp27hNWm9/pVFMNL593/2vvc
         xUjm+L3imkXV9Xb8MF5vqx3pruTiKZQiS6BIz2rRtzMDp0V9Ohge5+4vf5jA80y0dp
         qhHAxageYW/cQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v8 12/53] media: videobuf2: Be more flexible on the number of queue stored buffers
Date:   Wed, 27 Sep 2023 17:35:17 +0200
Message-Id: <20230927153558.159278-13-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927153558.159278-1-benjamin.gaignard@collabora.com>
References: <20230927153558.159278-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'max_num_buffers' field in vb2_queue struct to let drivers decide
how many buffers could be stored in a queue.
This require 'bufs' array to be allocated at queue init time and freed
when releasing the queue.
By default VB2_MAX_FRAME remains the limit.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 .../media/common/videobuf2/videobuf2-core.c   | 41 +++++++++++++++----
 .../media/common/videobuf2/videobuf2-v4l2.c   |  4 +-
 include/media/videobuf2-core.h                |  4 +-
 3 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 17b0dafacaab..023e00aa4848 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -415,7 +415,7 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
  */
 static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, unsigned int index)
 {
-	WARN_ON(index >= VB2_MAX_FRAME || q->bufs[index]);
+	WARN_ON(index >= q->max_num_buffers || q->bufs[index]);
 
 	q->bufs[index] = vb;
 	vb->index = index;
@@ -447,9 +447,9 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 	struct vb2_buffer *vb;
 	int ret;
 
-	/* Ensure that q->num_buffers+num_buffers is below VB2_MAX_FRAME */
+	/* Ensure that the number of already queue + num_buffers is below q->max_num_buffers */
 	num_buffers = min_t(unsigned int, num_buffers,
-			    VB2_MAX_FRAME - q->num_buffers);
+			    q->max_num_buffers - q->num_buffers);
 
 	for (buffer = 0; buffer < num_buffers; ++buffer) {
 		/* Allocate vb2 buffer structures */
@@ -808,7 +808,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	unsigned plane_sizes[VB2_MAX_PLANES] = { };
 	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	if (q->streaming) {
 		dprintk(q, 1, "streaming active\n");
@@ -852,17 +852,22 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	/*
 	 * Make sure the requested values and current defaults are sane.
 	 */
-	WARN_ON(q->min_buffers_needed > VB2_MAX_FRAME);
 	num_buffers = max_t(unsigned int, *count, q->min_buffers_needed);
-	num_buffers = min_t(unsigned int, num_buffers, VB2_MAX_FRAME);
+	num_buffers = min_t(unsigned int, num_buffers, q->max_num_buffers);
 	memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
 	/*
 	 * Set this now to ensure that drivers see the correct q->memory value
 	 * in the queue_setup op.
 	 */
 	mutex_lock(&q->mmap_lock);
+	if (!q->bufs)
+		q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);
+	if (!q->bufs)
+		ret = -ENOMEM;
 	q->memory = memory;
 	mutex_unlock(&q->mmap_lock);
+	if (ret)
+		return ret;
 	set_queue_coherency(q, non_coherent_mem);
 
 	/*
@@ -968,9 +973,9 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 	unsigned plane_sizes[VB2_MAX_PLANES] = { };
 	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
 	bool no_previous_buffers = !q->num_buffers;
-	int ret;
+	int ret = 0;
 
-	if (q->num_buffers == VB2_MAX_FRAME) {
+	if (q->num_buffers == q->max_num_buffers) {
 		dprintk(q, 1, "maximum number of buffers already allocated\n");
 		return -ENOBUFS;
 	}
@@ -987,7 +992,13 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 		 */
 		mutex_lock(&q->mmap_lock);
 		q->memory = memory;
+		if (!q->bufs)
+			q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);
+		if (!q->bufs)
+			ret = -ENOMEM;
 		mutex_unlock(&q->mmap_lock);
+		if (ret)
+			return ret;
 		q->waiting_for_buffers = !q->is_output;
 		set_queue_coherency(q, non_coherent_mem);
 	} else {
@@ -999,7 +1010,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 			return -EINVAL;
 	}
 
-	num_buffers = min(*count, VB2_MAX_FRAME - q->num_buffers);
+	num_buffers = min(*count, q->max_num_buffers - q->num_buffers);
 
 	if (requested_planes && requested_sizes) {
 		num_planes = requested_planes;
@@ -2467,6 +2478,10 @@ int vb2_core_queue_init(struct vb2_queue *q)
 	    WARN_ON(!q->ops->buf_queue))
 		return -EINVAL;
 
+	if (WARN_ON(q->max_num_buffers > BUFFER_INDEX_MASK + 1) ||
+	    WARN_ON(q->min_buffers_needed > q->max_num_buffers))
+		return -EINVAL;
+
 	if (WARN_ON(q->requires_requests && !q->supports_requests))
 		return -EINVAL;
 
@@ -2489,6 +2504,12 @@ int vb2_core_queue_init(struct vb2_queue *q)
 
 	q->memory = VB2_MEMORY_UNKNOWN;
 
+	if (!q->max_num_buffers)
+		q->max_num_buffers = VB2_MAX_FRAME;
+
+	/* The maximum is limited by offset cookie encoding pattern */
+	q->max_num_buffers = min_t(unsigned int, q->max_num_buffers, BUFFER_INDEX_MASK + 1);
+
 	if (q->buf_struct_size == 0)
 		q->buf_struct_size = sizeof(struct vb2_buffer);
 
@@ -2513,6 +2534,8 @@ void vb2_core_queue_release(struct vb2_queue *q)
 	__vb2_queue_cancel(q);
 	mutex_lock(&q->mmap_lock);
 	__vb2_queue_free(q, q->num_buffers);
+	kfree(q->bufs);
+	q->bufs = NULL;
 	mutex_unlock(&q->mmap_lock);
 }
 EXPORT_SYMBOL_GPL(vb2_core_queue_release);
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 3395e702ad1f..278ea1107b01 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -1156,7 +1156,7 @@ int _vb2_fop_release(struct file *file, struct mutex *lock)
 
 	if (lock)
 		mutex_lock(lock);
-	if (file->private_data == vdev->queue->owner) {
+	if (!vdev->queue->owner || file->private_data == vdev->queue->owner) {
 		vb2_queue_release(vdev->queue);
 		vdev->queue->owner = NULL;
 	}
@@ -1284,7 +1284,7 @@ void vb2_video_unregister_device(struct video_device *vdev)
 	 */
 	get_device(&vdev->dev);
 	video_unregister_device(vdev);
-	if (vdev->queue && vdev->queue->owner) {
+	if (vdev->queue) {
 		struct mutex *lock = vdev->queue->lock ?
 			vdev->queue->lock : vdev->lock;
 
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index cd3ff1cd759d..1d6d68e8a711 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -558,6 +558,7 @@ struct vb2_buf_ops {
  * @dma_dir:	DMA mapping direction.
  * @bufs:	videobuf2 buffer structures
  * @num_buffers: number of allocated/used buffers
+ * @max_num_buffers: upper limit of number of allocated/used buffers
  * @queued_list: list of buffers currently queued from userspace
  * @queued_count: number of buffers queued and ready for streaming.
  * @owned_by_drv_count: number of buffers owned by the driver
@@ -619,8 +620,9 @@ struct vb2_queue {
 	struct mutex			mmap_lock;
 	unsigned int			memory;
 	enum dma_data_direction		dma_dir;
-	struct vb2_buffer		*bufs[VB2_MAX_FRAME];
+	struct vb2_buffer		**bufs;
 	unsigned int			num_buffers;
+	unsigned int			max_num_buffers;
 
 	struct list_head		queued_list;
 	unsigned int			queued_count;
-- 
2.39.2

