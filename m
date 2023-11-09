Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B187E6F7E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344975AbjKIQlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344848AbjKIQkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:40:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41323C25;
        Thu,  9 Nov 2023 08:38:47 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BD78A66076BF;
        Thu,  9 Nov 2023 16:38:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699547926;
        bh=/+uuleyt+cGl1b4YYzx8KYbIIputX/xtRdfz6yVlpGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jghz5yN1M9txpDrWl1Rv4IuCMylVMIKHXiaolpvMbborCo8lpcYu5LNHeuK5ota5P
         bVKDm4A8F51RBAlSMk/WYwkNre79cflWgymOkFxioY+mVu4wk6MsD3XHip5Vv4eYEQ
         BMVAfZjcoo8Nga1N3GMSSS7R1JDaWn4DQZy0z4aKE60CFmQCnrXnfrnmQYATN8J1G1
         ZaAPA0iEmmtun/E1ehgSohlbxXvPPURKFQtW7qRIs5PEbrrUdAQt8a2UMc44JT8ic6
         1FUmSEIrWgZL9Sc8yK+WPELEMWM7IuzzEhv+kJUw+fzXNyTpKGtWi7Q542EQY3wsIx
         QQN5vnnPigwAA==
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
Subject: [PATCH v15 53/56] media: core: Free range of buffers
Date:   Thu,  9 Nov 2023 17:35:09 +0100
Message-Id: <20231109163512.179524-54-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
References: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve __vb2_queue_free() and __vb2_free_mem() to free
range of buffers and not only the last few buffers.
Intoduce starting index to be flexible on range and change the loops
according to this parameters.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 62 +++++++++----------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index df31cda323a2..3fa923cbdba8 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -525,17 +525,16 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 }
 
 /*
- * __vb2_free_mem() - release all video buffer memory for a given queue
+ * __vb2_free_mem() - release video buffer memory for a given range of
+ * buffers in a given queue
  */
-static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
+static void __vb2_free_mem(struct vb2_queue *q, unsigned int start, unsigned int count)
 {
-	unsigned int buffer;
+	unsigned int i;
 	struct vb2_buffer *vb;
-	unsigned int q_num_buffers = vb2_get_num_buffers(q);
 
-	for (buffer = q_num_buffers - buffers; buffer < q_num_buffers;
-	     ++buffer) {
-		vb = vb2_get_buffer(q, buffer);
+	for (i = start; i < q->max_num_buffers && i < start + count; i++) {
+		vb = vb2_get_buffer(q, i);
 		if (!vb)
 			continue;
 
@@ -550,35 +549,35 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
 }
 
 /*
- * __vb2_queue_free() - free buffers at the end of the queue - video memory and
+ * __vb2_queue_free() - free @count buffers from @start index of the queue - video memory and
  * related information, if no buffers are left return the queue to an
  * uninitialized state. Might be called even if the queue has already been freed.
  */
-static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
+static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned int count)
 {
-	unsigned int buffer;
-	unsigned int q_num_buffers = vb2_get_num_buffers(q);
+	unsigned int i;
 
 	lockdep_assert_held(&q->mmap_lock);
 
 	/* Call driver-provided cleanup function for each buffer, if provided */
-	for (buffer = q_num_buffers - buffers; buffer < q_num_buffers;
-	     ++buffer) {
-		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
+	for (i = start; i < q->max_num_buffers && i < start + count; i++) {
+		struct vb2_buffer *vb = vb2_get_buffer(q, i);
 
-		if (vb && vb->planes[0].mem_priv)
+		if (!vb)
+			continue;
+		if (vb->planes[0].mem_priv)
 			call_void_vb_qop(vb, buf_cleanup, vb);
 	}
 
 	/* Release video buffer memory */
-	__vb2_free_mem(q, buffers);
+	__vb2_free_mem(q, start, count);
 
 #ifdef CONFIG_VIDEO_ADV_DEBUG
 	/*
 	 * Check that all the calls were balanced during the life-time of this
 	 * queue. If not then dump the counters to the kernel log.
 	 */
-	if (q_num_buffers) {
+	if (vb2_get_num_buffers(q)) {
 		bool unbalanced = q->cnt_start_streaming != q->cnt_stop_streaming ||
 				  q->cnt_prepare_streaming != q->cnt_unprepare_streaming ||
 				  q->cnt_wait_prepare != q->cnt_wait_finish;
@@ -604,8 +603,8 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 		q->cnt_stop_streaming = 0;
 		q->cnt_unprepare_streaming = 0;
 	}
-	for (buffer = 0; buffer < vb2_get_num_buffers(q); buffer++) {
-		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
+	for (i = start; i < q->max_num_buffers && i < start + count; i++) {
+		struct vb2_buffer *vb = vb2_get_buffer(q, i);
 		bool unbalanced;
 
 		if (!vb)
@@ -622,7 +621,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 
 		if (unbalanced) {
 			pr_info("unbalanced counters for queue %p, buffer %d:\n",
-				q, buffer);
+				q, i);
 			if (vb->cnt_buf_init != vb->cnt_buf_cleanup)
 				pr_info("     buf_init: %u buf_cleanup: %u\n",
 					vb->cnt_buf_init, vb->cnt_buf_cleanup);
@@ -656,9 +655,8 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 #endif
 
 	/* Free vb2 buffers */
-	for (buffer = q_num_buffers - buffers; buffer < q_num_buffers;
-	     ++buffer) {
-		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
+	for (i = start; i < q->max_num_buffers && i < start + count; i++) {
+		struct vb2_buffer *vb = vb2_get_buffer(q, i);
 
 		if (!vb)
 			continue;
@@ -698,7 +696,7 @@ EXPORT_SYMBOL(vb2_buffer_in_use);
 static bool __buffers_in_use(struct vb2_queue *q)
 {
 	unsigned int buffer;
-	for (buffer = 0; buffer < vb2_get_num_buffers(q); ++buffer) {
+	for (buffer = 0; buffer < q->max_num_buffers; ++buffer) {
 		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
 
 		if (!vb)
@@ -858,7 +856,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 		 * queued without ever calling STREAMON.
 		 */
 		__vb2_queue_cancel(q);
-		__vb2_queue_free(q, q_num_bufs);
+		__vb2_queue_free(q, 0, q->max_num_buffers);
 		mutex_unlock(&q->mmap_lock);
 
 		/*
@@ -968,7 +966,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 		 * from already queued buffers and it will reset q->memory to
 		 * VB2_MEMORY_UNKNOWN.
 		 */
-		__vb2_queue_free(q, allocated_buffers);
+		__vb2_queue_free(q, first_index, allocated_buffers);
 		mutex_unlock(&q->mmap_lock);
 		return ret;
 	}
@@ -1008,7 +1006,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 	bool no_previous_buffers = !q_num_bufs;
 	int ret = 0;
 
-	if (q->num_buffers == q->max_num_buffers) {
+	if (q_num_bufs == q->max_num_buffers) {
 		dprintk(q, 1, "maximum number of buffers already allocated\n");
 		return -ENOBUFS;
 	}
@@ -1108,7 +1106,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 		 * from already queued buffers and it will reset q->memory to
 		 * VB2_MEMORY_UNKNOWN.
 		 */
-		__vb2_queue_free(q, allocated_buffers);
+		__vb2_queue_free(q, *first_index, allocated_buffers);
 		mutex_unlock(&q->mmap_lock);
 		return -ENOMEM;
 	}
@@ -1722,7 +1720,7 @@ static int vb2_start_streaming(struct vb2_queue *q)
 		 * Forcefully reclaim buffers if the driver did not
 		 * correctly return them to vb2.
 		 */
-		for (i = 0; i < vb2_get_num_buffers(q); ++i) {
+		for (i = 0; i < q->max_num_buffers; ++i) {
 			vb = vb2_get_buffer(q, i);
 
 			if (!vb)
@@ -2128,7 +2126,7 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
 	 * to vb2 in stop_streaming().
 	 */
 	if (WARN_ON(atomic_read(&q->owned_by_drv_count))) {
-		for (i = 0; i < vb2_get_num_buffers(q); i++) {
+		for (i = 0; i < q->max_num_buffers; i++) {
 			struct vb2_buffer *vb = vb2_get_buffer(q, i);
 
 			if (!vb)
@@ -2172,7 +2170,7 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
 	 * call to __fill_user_buffer() after buf_finish(). That order can't
 	 * be changed, so we can't move the buf_finish() to __vb2_dqbuf().
 	 */
-	for (i = 0; i < vb2_get_num_buffers(q); i++) {
+	for (i = 0; i < q->max_num_buffers; i++) {
 		struct vb2_buffer *vb;
 		struct media_request *req;
 
@@ -2580,7 +2578,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
 	__vb2_cleanup_fileio(q);
 	__vb2_queue_cancel(q);
 	mutex_lock(&q->mmap_lock);
-	__vb2_queue_free(q, vb2_get_num_buffers(q));
+	__vb2_queue_free(q, 0, q->max_num_buffers);
 	kfree(q->bufs);
 	q->bufs = NULL;
 	bitmap_free(q->bufs_bitmap);
-- 
2.39.2

