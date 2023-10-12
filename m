Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79417C6D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379456AbjJLLuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378908AbjJLLsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:48:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957D6D6D;
        Thu, 12 Oct 2023 04:47:19 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7ae7:b86d:c19a:877e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 86788660737D;
        Thu, 12 Oct 2023 12:47:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697111237;
        bh=XGb6zadLPkb1giyVQb8HPAjBYmgjSFi31wCRf9z5B9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dm4c7pjXX7SgbHsEjusMHJW2FDK3NQ11JEILi8v+VAMfmSHE4zOq08I2oK0/vmu0G
         RByQZEDvtSNql4KlqJly2cvLdmUbPKwZRHGD6O4J3nqiqMAAQLWFjvjgk9kQTZhFn6
         4iwdNyIrvlCaf4bHodcak7Ugq8NOasu3AgmhSrLcfYffFt5y2b5dCvXYA89+V1sicw
         BM5ZZWdRZ99iuECiKHCSAAvMqVscoCjDbaBJJ3XsdZ7TKS2UUMc3vcCzS3HhsO7jpu
         DM1jHezH27APRUyubboDr3sO3LZnbdlCWTsoIW876gfNeWk0uxmXjF8Od5p3LZHr3Z
         0CDpj7iy5oJIg==
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
Subject: [PATCH v11 53/56] media: core: Free range of buffers
Date:   Thu, 12 Oct 2023 13:46:39 +0200
Message-Id: <20231012114642.19040-54-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
References: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve __vb2_queue_free() and __vb2_free_mem() to free
range of buffers and not only the last few buffers.
Intoduce starting index to be flexible on range and change the loops
according to this parameters.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 50 ++++++++-----------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 29d46c5be705..7cf2463199d7 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -519,13 +519,12 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 /*
  * __vb2_free_mem() - release all video buffer memory for a given queue
  */
-static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
+static void __vb2_free_mem(struct vb2_queue *q, unsigned int start, unsigned int count)
 {
-	unsigned int buffer = 0;
-	long i;
+	unsigned int i;
 	struct vb2_buffer *vb;
 
-	for (i = vb2_get_num_buffers(q); i >= 0 && buffer < buffers; i--) {
+	for (i = start; i < q->max_num_buffers && i < start + count; i++) {
 		vb = vb2_get_buffer(q, i);
 		if (!vb)
 			continue;
@@ -537,36 +536,32 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
 			__vb2_buf_dmabuf_put(vb);
 		else
 			__vb2_buf_userptr_put(vb);
-		buffer++;
 	}
 }
 
 /*
- * __vb2_queue_free() - free buffers at the end of the queue - video memory and
+ * __vb2_queue_free() - free count buffers from start index of the queue - video memory and
  * related information, if no buffers are left return the queue to an
  * uninitialized state. Might be called even if the queue has already been freed.
  */
-static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
+static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned int count)
 {
-	unsigned int buffer;
-	long i;
+	unsigned int i;
 
 	lockdep_assert_held(&q->mmap_lock);
 
 	/* Call driver-provided cleanup function for each buffer, if provided */
-	for (i = vb2_get_num_buffers(q), buffer = 0; i >= 0 && buffer < buffers; i--) {
+	for (i = start; i < q->max_num_buffers && i < start + count; i++) {
 		struct vb2_buffer *vb = vb2_get_buffer(q, i);
 
 		if (!vb)
 			continue;
-		if (vb->planes[0].mem_priv) {
+		if (vb->planes[0].mem_priv)
 			call_void_vb_qop(vb, buf_cleanup, vb);
-			buffer++;
-		}
 	}
 
 	/* Release video buffer memory */
-	__vb2_free_mem(q, buffers);
+	__vb2_free_mem(q, start, count);
 
 #ifdef CONFIG_VIDEO_ADV_DEBUG
 	/*
@@ -599,8 +594,8 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 		q->cnt_stop_streaming = 0;
 		q->cnt_unprepare_streaming = 0;
 	}
-	for (buffer = 0; buffer < vb2_get_num_buffers(q); buffer++) {
-		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
+	for (i = start; i < q->max_num_buffers && i < start + count; i++) {
+		struct vb2_buffer *vb = vb2_get_buffer(q, i);
 		bool unbalanced;
 
 		if (!vb)
@@ -617,7 +612,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 
 		if (unbalanced) {
 			pr_info("unbalanced counters for queue %p, buffer %d:\n",
-				q, buffer);
+				q, i);
 			if (vb->cnt_buf_init != vb->cnt_buf_cleanup)
 				pr_info("     buf_init: %u buf_cleanup: %u\n",
 					vb->cnt_buf_init, vb->cnt_buf_cleanup);
@@ -651,7 +646,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 #endif
 
 	/* Free vb2 buffers */
-	for (i = vb2_get_num_buffers(q), buffer = 0; i >= 0 && buffer < buffers; i--) {
+	for (i = start; i < q->max_num_buffers && i < start + count; i++) {
 		struct vb2_buffer *vb = vb2_get_buffer(q, i);
 
 		if (!vb)
@@ -659,7 +654,6 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 
 		vb2_queue_remove_buffer(vb);
 		kfree(vb);
-		buffer++;
 	}
 
 	if (!vb2_get_num_buffers(q)) {
@@ -693,7 +687,7 @@ EXPORT_SYMBOL(vb2_buffer_in_use);
 static bool __buffers_in_use(struct vb2_queue *q)
 {
 	unsigned int buffer;
-	for (buffer = 0; buffer < vb2_get_num_buffers(q); ++buffer) {
+	for (buffer = 0; buffer < q->max_num_buffers; ++buffer) {
 		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
 
 		if (!vb)
@@ -853,7 +847,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 		 * queued without ever calling STREAMON.
 		 */
 		__vb2_queue_cancel(q);
-		__vb2_queue_free(q, q_num_bufs);
+		__vb2_queue_free(q, 0, q->max_num_buffers);
 		mutex_unlock(&q->mmap_lock);
 
 		/*
@@ -963,7 +957,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 		 * from already queued buffers and it will reset q->memory to
 		 * VB2_MEMORY_UNKNOWN.
 		 */
-		__vb2_queue_free(q, allocated_buffers);
+		__vb2_queue_free(q, first_index, allocated_buffers);
 		mutex_unlock(&q->mmap_lock);
 		return ret;
 	}
@@ -1003,7 +997,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 	bool no_previous_buffers = !q_num_bufs;
 	int ret = 0;
 
-	if (q->num_buffers == q->max_num_buffers) {
+	if (q_num_bufs == q->max_num_buffers) {
 		dprintk(q, 1, "maximum number of buffers already allocated\n");
 		return -ENOBUFS;
 	}
@@ -1103,7 +1097,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 		 * from already queued buffers and it will reset q->memory to
 		 * VB2_MEMORY_UNKNOWN.
 		 */
-		__vb2_queue_free(q, allocated_buffers);
+		__vb2_queue_free(q, *first_index, allocated_buffers);
 		mutex_unlock(&q->mmap_lock);
 		return -ENOMEM;
 	}
@@ -1717,7 +1711,7 @@ static int vb2_start_streaming(struct vb2_queue *q)
 		 * Forcefully reclaim buffers if the driver did not
 		 * correctly return them to vb2.
 		 */
-		for (i = 0; i < vb2_get_num_buffers(q); ++i) {
+		for (i = 0; i < q->max_num_buffers; ++i) {
 			vb = vb2_get_buffer(q, i);
 
 			if (!vb)
@@ -2123,7 +2117,7 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
 	 * to vb2 in stop_streaming().
 	 */
 	if (WARN_ON(atomic_read(&q->owned_by_drv_count))) {
-		for (i = 0; i < vb2_get_num_buffers(q); i++) {
+		for (i = 0; i < q->max_num_buffers; i++) {
 			struct vb2_buffer *vb = vb2_get_buffer(q, i);
 			if (!vb)
 				continue;
@@ -2166,7 +2160,7 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
 	 * call to __fill_user_buffer() after buf_finish(). That order can't
 	 * be changed, so we can't move the buf_finish() to __vb2_dqbuf().
 	 */
-	for (i = 0; i < vb2_get_num_buffers(q); i++) {
+	for (i = 0; i < q->max_num_buffers; i++) {
 		struct vb2_buffer *vb;
 		struct media_request *req;
 		vb = vb2_get_buffer(q, i);
@@ -2569,7 +2563,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
 	__vb2_cleanup_fileio(q);
 	__vb2_queue_cancel(q);
 	mutex_lock(&q->mmap_lock);
-	__vb2_queue_free(q, q->max_num_buffers);
+	__vb2_queue_free(q, 0, q->max_num_buffers);
 	kfree(q->bufs);
 	q->bufs = NULL;
 	bitmap_free(q->bufs_bitmap);
-- 
2.39.2

