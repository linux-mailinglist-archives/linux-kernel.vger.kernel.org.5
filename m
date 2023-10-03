Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F737B6417
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjJCIJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239438AbjJCIHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:07:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C41E1;
        Tue,  3 Oct 2023 01:07:25 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:b6df:b784:6a0f:8451])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C8150660731B;
        Tue,  3 Oct 2023 09:07:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696320444;
        bh=V6so/n5DSLUhUZzOXb2TFLtP93yBP3TgQBtvx5Qlw3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KGDjpueV8n9qx6iUDM15/yGIsddJze92Y3+J/Dq05tLsqgABvMMFL8JZqNKIFbPUB
         fkrtCRM1Q1Cke6SJFG5YbweL0CbbsXDQ5GYWYOT39THAjmEPdw2OlAxvuHnGRc4bN2
         LI99l9fCZ4Cv+ZqKPPcaEl60cMZdujUEWNYA2KFmppNvAY5Q65E/8kgSTVHCrrmU23
         +s/q6e6QMXeJJA8X7k4psND0h+g5BunBInh26mKk3i8OuqA1T8aZ4tin5tjKEK2ttQ
         kAyIFzpNJ+fzrQ9DsxRbsmXpSih4il8ede7y1mDTBGSygJ14+6Dhl3iNwD01kEZvrz
         Sbx1k0IwM1xhw==
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
Subject: [PATCH v10 21/54] media: core: Add helper to get queue number of buffers
Date:   Tue,  3 Oct 2023 10:06:30 +0200
Message-Id: <20231003080704.43911-22-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003080704.43911-1-benjamin.gaignard@collabora.com>
References: <20231003080704.43911-1-benjamin.gaignard@collabora.com>
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

In the future a side effect of introducing DELETE_BUFS ioctl is
the create of 'holes' (i.e. unused buffers) in bufs arrays.
To know which entries of the bufs arrays are used a bitmap will
be added in struct vb2_queue. That will also mean that the number
of buffers will be computed given the number of bit set in this bitmap.
To smoothly allow this evolution all drives must stop using
directly num_buffers field from struct vb2_queue.
Let do it in 4 steps:
- Introduce vb2_get_num_buffers() helper
- Rework how create_bufs first buffer index is computed
- Rework all drivers to remove direct calls to queue num_buffers
- Replace num_buffers by a bitmap.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 109 ++++++++++--------
 .../media/common/videobuf2/videobuf2-v4l2.c   |   4 +-
 include/media/videobuf2-core.h                |  11 +-
 3 files changed, 73 insertions(+), 51 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index c0104f824577..62e987ad9b33 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -426,6 +426,8 @@ static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, uns
  */
 static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
 {
+	if (vb->vb2_queue->num_buffers)
+		vb->vb2_queue->num_buffers--;
 	vb->vb2_queue->bufs[vb->index] = NULL;
 	vb->vb2_queue = NULL;
 }
@@ -509,12 +511,12 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
  */
 static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
 {
-	unsigned int buffer;
+	unsigned int buffer = 0;
+	long i = q->max_num_buffers;
 	struct vb2_buffer *vb;
 
-	for (buffer = q->num_buffers - buffers; buffer < q->num_buffers;
-	     ++buffer) {
-		vb = vb2_get_buffer(q, buffer);
+	for (i = q->max_num_buffers; i >= 0 && buffer < buffers; i--) {
+		vb = vb2_get_buffer(q, i);
 		if (!vb)
 			continue;
 
@@ -525,6 +527,7 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
 			__vb2_buf_dmabuf_put(vb);
 		else
 			__vb2_buf_userptr_put(vb);
+		buffer++;
 	}
 }
 
@@ -536,16 +539,20 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
 static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 {
 	unsigned int buffer;
+	long i = q->max_num_buffers;
 
 	lockdep_assert_held(&q->mmap_lock);
 
 	/* Call driver-provided cleanup function for each buffer, if provided */
-	for (buffer = q->num_buffers - buffers; buffer < q->num_buffers;
-	     ++buffer) {
-		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
+	for (i = q->max_num_buffers, buffer = 0; i >= 0 && buffer < buffers; i--) {
+		struct vb2_buffer *vb = vb2_get_buffer(q, i);
 
-		if (vb && vb->planes[0].mem_priv)
+		if (!vb)
+			continue;
+		if (vb->planes[0].mem_priv) {
 			call_void_vb_qop(vb, buf_cleanup, vb);
+			buffer++;
+		}
 	}
 
 	/* Release video buffer memory */
@@ -556,7 +563,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 	 * Check that all the calls were balanced during the life-time of this
 	 * queue. If not then dump the counters to the kernel log.
 	 */
-	if (q->num_buffers) {
+	if (vb2_get_num_buffers(q)) {
 		bool unbalanced = q->cnt_start_streaming != q->cnt_stop_streaming ||
 				  q->cnt_prepare_streaming != q->cnt_unprepare_streaming ||
 				  q->cnt_wait_prepare != q->cnt_wait_finish;
@@ -582,7 +589,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 		q->cnt_stop_streaming = 0;
 		q->cnt_unprepare_streaming = 0;
 	}
-	for (buffer = 0; buffer < q->num_buffers; ++buffer) {
+	for (buffer = 0; buffer < q->max_num_buffers; buffer++) {
 		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
 		bool unbalanced;
 
@@ -634,19 +641,18 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 #endif
 
 	/* Free vb2 buffers */
-	for (buffer = q->num_buffers - buffers; buffer < q->num_buffers;
-	     ++buffer) {
-		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
+	for (i = q->max_num_buffers, buffer = 0; i >= 0 && buffer < buffers; i--) {
+		struct vb2_buffer *vb = vb2_get_buffer(q, i);
 
 		if (!vb)
 			continue;
 
 		vb2_queue_remove_buffer(vb);
 		kfree(vb);
+		buffer++;
 	}
 
-	q->num_buffers -= buffers;
-	if (!q->num_buffers) {
+	if (!vb2_get_num_buffers(q)) {
 		q->memory = VB2_MEMORY_UNKNOWN;
 		INIT_LIST_HEAD(&q->queued_list);
 	}
@@ -677,7 +683,7 @@ EXPORT_SYMBOL(vb2_buffer_in_use);
 static bool __buffers_in_use(struct vb2_queue *q)
 {
 	unsigned int buffer;
-	for (buffer = 0; buffer < q->num_buffers; ++buffer) {
+	for (buffer = 0; buffer < q->max_num_buffers; ++buffer) {
 		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
 
 		if (!vb)
@@ -803,6 +809,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 		     unsigned int flags, unsigned int *count)
 {
 	unsigned int num_buffers, allocated_buffers, num_planes = 0;
+	unsigned int q_num_bufs = vb2_get_num_buffers(q);
 	unsigned plane_sizes[VB2_MAX_PLANES] = { };
 	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
 	unsigned int i;
@@ -818,7 +825,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 		return -EBUSY;
 	}
 
-	if (*count == 0 || q->num_buffers != 0 ||
+	if (*count == 0 || q_num_bufs != 0 ||
 	    (q->memory != VB2_MEMORY_UNKNOWN && q->memory != memory) ||
 	    !verify_coherency_flags(q, non_coherent_mem)) {
 		/*
@@ -836,7 +843,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 		 * queued without ever calling STREAMON.
 		 */
 		__vb2_queue_cancel(q);
-		__vb2_queue_free(q, q->num_buffers);
+		__vb2_queue_free(q, q_num_bufs);
 		mutex_unlock(&q->mmap_lock);
 
 		/*
@@ -936,7 +943,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	if (ret < 0) {
 		/*
 		 * Note: __vb2_queue_free() will subtract 'allocated_buffers'
-		 * from q->num_buffers and it will reset q->memory to
+		 * from already queued buffers and it will reset q->memory to
 		 * VB2_MEMORY_UNKNOWN.
 		 */
 		__vb2_queue_free(q, allocated_buffers);
@@ -970,10 +977,11 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 	unsigned int num_planes = 0, num_buffers, allocated_buffers;
 	unsigned plane_sizes[VB2_MAX_PLANES] = { };
 	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
-	bool no_previous_buffers = !q->num_buffers;
+	unsigned int q_num_bufs = vb2_get_num_buffers(q);
+	bool no_previous_buffers = !q_num_bufs;
 	int ret = 0;
 
-	if (q->num_buffers == q->max_num_buffers) {
+	if (q_num_bufs == q->max_num_buffers) {
 		dprintk(q, 1, "maximum number of buffers already allocated\n");
 		return -ENOBUFS;
 	}
@@ -1008,7 +1016,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 			return -EINVAL;
 	}
 
-	num_buffers = min(*count, q->max_num_buffers - q->num_buffers);
+	num_buffers = min(*count, q->max_num_buffers - q_num_bufs);
 
 	if (requested_planes && requested_sizes) {
 		num_planes = requested_planes;
@@ -1040,7 +1048,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 		num_buffers = allocated_buffers;
 
 		/*
-		 * q->num_buffers contains the total number of buffers, that the
+		 * num_buffers contains the total number of buffers, that the
 		 * queue driver has set up
 		 */
 		ret = call_qop(q, queue_setup, q, &num_buffers,
@@ -1061,7 +1069,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 	if (ret < 0) {
 		/*
 		 * Note: __vb2_queue_free() will subtract 'allocated_buffers'
-		 * from q->num_buffers and it will reset q->memory to
+		 * from already queued buffers and it will reset q->memory to
 		 * VB2_MEMORY_UNKNOWN.
 		 */
 		__vb2_queue_free(q, allocated_buffers);
@@ -1678,7 +1686,7 @@ static int vb2_start_streaming(struct vb2_queue *q)
 		 * Forcefully reclaim buffers if the driver did not
 		 * correctly return them to vb2.
 		 */
-		for (i = 0; i < q->num_buffers; ++i) {
+		for (i = 0; i < q->max_num_buffers; ++i) {
 			vb = vb2_get_buffer(q, i);
 
 			if (!vb)
@@ -2084,9 +2092,8 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
 	 * to vb2 in stop_streaming().
 	 */
 	if (WARN_ON(atomic_read(&q->owned_by_drv_count))) {
-		for (i = 0; i < q->num_buffers; ++i) {
+		for (i = 0; i < q->max_num_buffers; i++) {
 			struct vb2_buffer *vb = vb2_get_buffer(q, i);
-
 			if (!vb)
 				continue;
 
@@ -2128,10 +2135,9 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
 	 * call to __fill_user_buffer() after buf_finish(). That order can't
 	 * be changed, so we can't move the buf_finish() to __vb2_dqbuf().
 	 */
-	for (i = 0; i < q->num_buffers; ++i) {
+	for (i = 0; i < q->max_num_buffers; i++) {
 		struct vb2_buffer *vb;
 		struct media_request *req;
-
 		vb = vb2_get_buffer(q, i);
 		if (!vb)
 			continue;
@@ -2176,6 +2182,7 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
 
 int vb2_core_streamon(struct vb2_queue *q, unsigned int type)
 {
+	unsigned int q_num_bufs = vb2_get_num_buffers(q);
 	int ret;
 
 	if (type != q->type) {
@@ -2188,12 +2195,12 @@ int vb2_core_streamon(struct vb2_queue *q, unsigned int type)
 		return 0;
 	}
 
-	if (!q->num_buffers) {
+	if (!q_num_bufs) {
 		dprintk(q, 1, "no buffers have been allocated\n");
 		return -EINVAL;
 	}
 
-	if (q->num_buffers < q->min_buffers_needed) {
+	if (q_num_bufs < q->min_buffers_needed) {
 		dprintk(q, 1, "need at least %u allocated buffers\n",
 				q->min_buffers_needed);
 		return -EINVAL;
@@ -2531,9 +2538,10 @@ void vb2_core_queue_release(struct vb2_queue *q)
 	__vb2_cleanup_fileio(q);
 	__vb2_queue_cancel(q);
 	mutex_lock(&q->mmap_lock);
-	__vb2_queue_free(q, q->num_buffers);
+	__vb2_queue_free(q, q->max_num_buffers);
 	kfree(q->bufs);
 	q->bufs = NULL;
+	q->num_buffers = 0;
 	mutex_unlock(&q->mmap_lock);
 }
 EXPORT_SYMBOL_GPL(vb2_core_queue_release);
@@ -2562,7 +2570,7 @@ __poll_t vb2_core_poll(struct vb2_queue *q, struct file *file,
 	/*
 	 * Start file I/O emulator only if streaming API has not been used yet.
 	 */
-	if (q->num_buffers == 0 && !vb2_fileio_is_active(q)) {
+	if (vb2_get_num_buffers(q) == 0 && !vb2_fileio_is_active(q)) {
 		if (!q->is_output && (q->io_modes & VB2_READ) &&
 				(req_events & (EPOLLIN | EPOLLRDNORM))) {
 			if (__vb2_init_fileio(q, 1))
@@ -2600,7 +2608,7 @@ __poll_t vb2_core_poll(struct vb2_queue *q, struct file *file,
 	 * For output streams you can call write() as long as there are fewer
 	 * buffers queued than there are buffers available.
 	 */
-	if (q->is_output && q->fileio && q->queued_count < q->num_buffers)
+	if (q->is_output && q->fileio && q->queued_count < vb2_get_num_buffers(q))
 		return EPOLLOUT | EPOLLWRNORM;
 
 	if (list_empty(&q->done_list)) {
@@ -2649,8 +2657,8 @@ struct vb2_fileio_buf {
  * struct vb2_fileio_data - queue context used by file io emulator
  *
  * @cur_index:	the index of the buffer currently being read from or
- *		written to. If equal to q->num_buffers then a new buffer
- *		must be dequeued.
+ *		written to. If equal to number of already queues buffers
+ *		then a new buffer must be dequeued.
  * @initial_index: in the read() case all buffers are queued up immediately
  *		in __vb2_init_fileio() and __vb2_perform_fileio() just cycles
  *		buffers. However, in the write() case no buffers are initially
@@ -2660,7 +2668,7 @@ struct vb2_fileio_buf {
  *		buffers. This means that initially __vb2_perform_fileio()
  *		needs to know what buffer index to use when it is queuing up
  *		the buffers for the first time. That initial index is stored
- *		in this field. Once it is equal to q->num_buffers all
+ *		in this field. Once it is equal to num_buffers all
  *		available buffers have been queued and __vb2_perform_fileio()
  *		should start the normal dequeue/queue cycle.
  *
@@ -2710,7 +2718,7 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
 	/*
 	 * Check if streaming api has not been already activated.
 	 */
-	if (q->streaming || q->num_buffers > 0)
+	if (q->streaming || vb2_get_num_buffers(q) > 0)
 		return -EBUSY;
 
 	/*
@@ -2760,7 +2768,7 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
 	/*
 	 * Get kernel address of each buffer.
 	 */
-	for (i = 0; i < q->num_buffers; i++) {
+	for (i = 0; i < vb2_get_num_buffers(q); i++) {
 		vb = vb2_get_buffer(q, i);
 		WARN_ON_ONCE(!vb);
 
@@ -2779,18 +2787,23 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
 		/*
 		 * Queue all buffers.
 		 */
-		for (i = 0; i < q->num_buffers; i++) {
-			ret = vb2_core_qbuf(q, q->bufs[i], NULL, NULL);
+		for (i = 0; i < vb2_get_num_buffers(q); i++) {
+			struct vb2_buffer *vb2 = vb2_get_buffer(q, i);
+
+			if (!vb2)
+				continue;
+
+			ret = vb2_core_qbuf(q, vb2, NULL, NULL);
 			if (ret)
 				goto err_reqbufs;
 			fileio->bufs[i].queued = 1;
 		}
 		/*
 		 * All buffers have been queued, so mark that by setting
-		 * initial_index to q->num_buffers
+		 * initial_index to num_buffers
 		 */
-		fileio->initial_index = q->num_buffers;
-		fileio->cur_index = q->num_buffers;
+		fileio->initial_index = vb2_get_num_buffers(q);
+		fileio->cur_index = fileio->initial_index;
 	}
 
 	/*
@@ -2984,12 +2997,12 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
 		 * If we are queuing up buffers for the first time, then
 		 * increase initial_index by one.
 		 */
-		if (fileio->initial_index < q->num_buffers)
+		if (fileio->initial_index < vb2_get_num_buffers(q))
 			fileio->initial_index++;
 		/*
 		 * The next buffer to use is either a buffer that's going to be
-		 * queued for the first time (initial_index < q->num_buffers)
-		 * or it is equal to q->num_buffers, meaning that the next
+		 * queued for the first time (initial_index < num_buffers)
+		 * or it is equal to num_buffers, meaning that the next
 		 * time we need to dequeue a buffer since we've now queued up
 		 * all the 'first time' buffers.
 		 */
@@ -3036,7 +3049,7 @@ static int vb2_thread(void *data)
 	int ret = 0;
 
 	if (q->is_output) {
-		prequeue = q->num_buffers;
+		prequeue = vb2_get_num_buffers(q);
 		copy_timestamp = q->copy_timestamp;
 	}
 
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index cf881c8d8d4d..a4ebef82d94e 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -628,7 +628,7 @@ struct vb2_buffer *vb2_find_buffer(struct vb2_queue *q, u64 timestamp)
 	 * This loop doesn't scale if there is a really large number of buffers.
 	 * Maybe something more efficient will be needed in this case.
 	 */
-	for (i = 0; i < q->num_buffers; i++) {
+	for (i = 0; i < q->max_num_buffers; i++) {
 		vb2 = vb2_get_buffer(q, i);
 
 		if (!vb2)
@@ -765,7 +765,7 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
 	validate_memory_flags(q, create->memory, &create->flags);
 
 	create->max_buffers = q->max_num_buffers;
-	create->index = q->num_buffers;
+	create->index = vb2_get_num_buffers(q);
 
 	if (create->count == 0)
 		return ret != -EBUSY ? ret : 0;
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 1d6d68e8a711..dffb9647d4d1 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -1141,6 +1141,15 @@ static inline bool vb2_fileio_is_active(struct vb2_queue *q)
 	return q->fileio;
 }
 
+/**
+ * vb2_get_num_buffers() - get the number of buffer in a queue
+ * @q:		pointer to &struct vb2_queue with videobuf2 queue.
+ */
+static inline unsigned int vb2_get_num_buffers(struct vb2_queue *q)
+{
+	return q->num_buffers;
+}
+
 /**
  * vb2_is_busy() - return busy status of the queue.
  * @q:		pointer to &struct vb2_queue with videobuf2 queue.
@@ -1149,7 +1158,7 @@ static inline bool vb2_fileio_is_active(struct vb2_queue *q)
  */
 static inline bool vb2_is_busy(struct vb2_queue *q)
 {
-	return (q->num_buffers > 0);
+	return (vb2_get_num_buffers(q) > 0);
 }
 
 /**
-- 
2.39.2

