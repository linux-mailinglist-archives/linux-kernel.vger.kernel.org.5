Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75127B0900
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjI0Pix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjI0Pgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:36:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249031BF;
        Wed, 27 Sep 2023 08:36:33 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:672:46bd:3ec7:6cdf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 96F4B6607343;
        Wed, 27 Sep 2023 16:36:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695828992;
        bh=iFLs/fHZLvWeWv/xoor7oundLkJeHxwngHpR36nzu+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HM3Z0BUkQleedpD6BfL4oMgv46tuASoQA1MgM0xBif37p5akYiGrjSG062ZnjMByJ
         dJxJljxmnnQKYSpJelWWUNBY3a+ThQ+HQwP5utvYSDJ04Qth5iABF9nNmx5xFtvXvb
         MEO6lnyA7igaaDl4CTI9atTgATw5MEy7gbBB0/wOSvSPrbc/ovx6+ASCc0ZAQqArZ3
         5SYg8QQpQL/TYENnYJakShwQCugWeGqZVvjM4mZkH7xQnZa4UBH9MtG6NaTkBz4JK/
         13rax/msBkct6DBMW008Js7wv1JdqnjCqCLvNyeEii6cJmO1XAk7scB+09EaFLobyZ
         KwunfEYTpTNEw==
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
Subject: [PATCH v8 49/53] media: core: Add bitmap manage bufs array entries
Date:   Wed, 27 Sep 2023 17:35:54 +0200
Message-Id: <20230927153558.159278-50-benjamin.gaignard@collabora.com>
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

Add a bitmap field to know which of bufs array entries are
used or not.
Remove no more used num_buffers field from queue structure.
Use bitmap_find_next_zero_area() to find the first possible
range when creating new buffers to fill the gaps.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 40 +++++++++++++++----
 include/media/videobuf2-core.h                | 19 ++++++---
 2 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index b5a963030cde..8d35cf7cef42 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -415,11 +415,12 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
  */
 static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, unsigned int index)
 {
-	WARN_ON(index >= q->max_num_buffers || q->bufs[index]);
+	WARN_ON(index >= q->max_num_buffers || test_bit(index, q->bufs_bitmap));
 
 	q->bufs[index] = vb;
 	vb->index = index;
 	vb->vb2_queue = q;
+	set_bit(index, q->bufs_bitmap);
 }
 
 /**
@@ -428,6 +429,7 @@ static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, uns
  */
 static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
 {
+	clear_bit(vb->index, vb->vb2_queue->bufs_bitmap);
 	vb->vb2_queue->bufs[vb->index] = NULL;
 	vb->vb2_queue = NULL;
 }
@@ -449,11 +451,12 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 	unsigned long index;
 	int ret;
 
-	/* Ensure that the number of already queue + num_buffers is below q->max_num_buffers */
+	/* Ensure that vb2_get_num_buffers(q) + num_buffers is no more than q->max_num_buffers */
 	num_buffers = min_t(unsigned int, num_buffers,
 			    q->max_num_buffers - vb2_get_num_buffers(q));
 
-	index = vb2_get_num_buffers(q);
+	index = bitmap_find_next_zero_area(q->bufs_bitmap, q->max_num_buffers,
+					   0, num_buffers, 0);
 
 	*first_index = index;
 
@@ -875,6 +878,14 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 		q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);
 	if (!q->bufs)
 		ret = -ENOMEM;
+
+	if (!q->bufs_bitmap)
+		q->bufs_bitmap = bitmap_zalloc(q->max_num_buffers, GFP_KERNEL);
+	if (!q->bufs_bitmap) {
+		ret = -ENOMEM;
+		kfree(q->bufs);
+		q->bufs = NULL;
+	}
 	q->memory = memory;
 	mutex_unlock(&q->mmap_lock);
 	if (ret)
@@ -944,7 +955,6 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	}
 
 	mutex_lock(&q->mmap_lock);
-	q->num_buffers = allocated_buffers;
 
 	if (ret < 0) {
 		/*
@@ -971,6 +981,10 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	mutex_lock(&q->mmap_lock);
 	q->memory = VB2_MEMORY_UNKNOWN;
 	mutex_unlock(&q->mmap_lock);
+	kfree(q->bufs);
+	q->bufs = NULL;
+	bitmap_free(q->bufs_bitmap);
+	q->bufs_bitmap = NULL;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(vb2_core_reqbufs);
@@ -1007,9 +1021,19 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 		q->memory = memory;
 		if (!q->bufs)
 			q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);
-		if (!q->bufs)
+		if (!q->bufs) {
 			ret = -ENOMEM;
+			goto unlock;
+		}
+		if (!q->bufs_bitmap)
+			q->bufs_bitmap = bitmap_zalloc(q->max_num_buffers, GFP_KERNEL);
+		if (!q->bufs_bitmap) {
+			ret = -ENOMEM;
+			kfree(q->bufs);
+			q->bufs = NULL;
+		}
 		mutex_unlock(&q->mmap_lock);
+unlock:
 		if (ret)
 			return ret;
 		q->waiting_for_buffers = !q->is_output;
@@ -1071,7 +1095,6 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 	}
 
 	mutex_lock(&q->mmap_lock);
-	q->num_buffers += allocated_buffers;
 
 	if (ret < 0) {
 		/*
@@ -2548,6 +2571,9 @@ void vb2_core_queue_release(struct vb2_queue *q)
 	__vb2_queue_free(q, q->max_num_buffers);
 	kfree(q->bufs);
 	q->bufs = NULL;
+	bitmap_free(q->bufs_bitmap);
+	q->bufs_bitmap = NULL;
+
 	mutex_unlock(&q->mmap_lock);
 }
 EXPORT_SYMBOL_GPL(vb2_core_queue_release);
@@ -2902,7 +2928,7 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
 	 * Check if we need to dequeue the buffer.
 	 */
 	index = fileio->cur_index;
-	if (index >= q->num_buffers) {
+	if (!test_bit(index, q->bufs_bitmap)) {
 		struct vb2_buffer *b;
 
 		/*
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index d433bf84e30c..fc1fcd8faa64 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -346,7 +346,7 @@ struct vb2_buffer {
  *			describes the requested number of planes and sizes\[\]
  *			contains the requested plane sizes. In this case
  *			\*num_buffers are being allocated additionally to
- *			q->num_buffers. If either \*num_planes or the requested
+ *			queue buffers. If either \*num_planes or the requested
  *			sizes are invalid callback must return %-EINVAL.
  * @wait_prepare:	release any locks taken while calling vb2 functions;
  *			it is called before an ioctl needs to wait for a new
@@ -557,7 +557,7 @@ struct vb2_buf_ops {
  * @memory:	current memory type used
  * @dma_dir:	DMA mapping direction.
  * @bufs:	videobuf2 buffer structures
- * @num_buffers: number of allocated/used buffers
+ * @bufs_bitmap: bitmap to manage bufs entries.
  * @max_num_buffers: upper limit of number of allocated/used buffers
  * @queued_list: list of buffers currently queued from userspace
  * @queued_count: number of buffers queued and ready for streaming.
@@ -621,7 +621,7 @@ struct vb2_queue {
 	unsigned int			memory;
 	enum dma_data_direction		dma_dir;
 	struct vb2_buffer		**bufs;
-	unsigned int			num_buffers;
+	unsigned long			*bufs_bitmap;
 	unsigned int			max_num_buffers;
 
 	struct list_head		queued_list;
@@ -1150,7 +1150,10 @@ static inline bool vb2_fileio_is_active(struct vb2_queue *q)
  */
 static inline unsigned int vb2_get_num_buffers(struct vb2_queue *q)
 {
-	return q->num_buffers;
+	if (!q->bufs_bitmap)
+		return 0;
+
+	return bitmap_weight(q->bufs_bitmap, q->max_num_buffers);
 }
 
 /**
@@ -1253,7 +1256,13 @@ static inline void vb2_clear_last_buffer_dequeued(struct vb2_queue *q)
 static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
 						unsigned int index)
 {
-	if (index < q->num_buffers)
+	if (!q->bufs_bitmap)
+		return NULL;
+
+	if (index >= q->max_num_buffers)
+		return NULL;
+
+	if (test_bit(index, q->bufs_bitmap))
 		return q->bufs[index];
 	return NULL;
 }
-- 
2.39.2

