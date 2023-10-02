Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4FF7B52B2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbjJBMJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237166AbjJBMHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:07:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6381BD;
        Mon,  2 Oct 2023 05:06:52 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:9537:67ca:c85e:d0ae])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B14046607393;
        Mon,  2 Oct 2023 13:06:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696248411;
        bh=sn5wF6D6IMQITXuycpSqegm5P50srmeBUI7DJutIPII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXjk4ZR3JH1ZPbpPnY/8ljdgOME6ON1K0X0GqQlczupovWX6I9lMesxCaOazI/Vig
         2rpiHG08Mc0N/2AfKpY7RkAFzbussmEpL/RM5VGkhxuhP4f8236CgSMovYJB3Xun2P
         QzXUQfmudUMm24y+3rRwneofxTycJtF1gw+/qkX+NxL1XTCsn+G+wfqwHm1de2aBOb
         kBNdbOhhCNCvnteE0BkW2yxbHEMlqyo0hfYSXf7rQbA4/aV/T3qT8wNKk68pyrFoM3
         T46UYK54Rr2xowaE5wspEkmWMKQ1odXSWc6Qrbfj1EzkC8fX/mwfFdA2n2EmKBsPTr
         0ykQNDodUnGxA==
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
Subject: [PATCH v9 49/53] media: core: Add bitmap manage bufs array entries
Date:   Mon,  2 Oct 2023 14:06:13 +0200
Message-Id: <20231002120617.119602-50-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231002120617.119602-1-benjamin.gaignard@collabora.com>
References: <20231002120617.119602-1-benjamin.gaignard@collabora.com>
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

Add a bitmap field to know which of bufs array entries are
used or not.
Remove no more used num_buffers field from queue structure.
Use bitmap_find_next_zero_area() to find the first possible
range when creating new buffers to fill the gaps.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 43 ++++++++++++++-----
 include/media/videobuf2-core.h                | 19 +++++---
 2 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 92de8af58bdc..4cbc17e8b53e 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -412,11 +412,12 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
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
@@ -425,8 +426,7 @@ static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, uns
  */
 static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
 {
-	if (vb->vb2_queue->num_buffers)
-		vb->vb2_queue->num_buffers--;
+	clear_bit(vb->index, vb->vb2_queue->bufs_bitmap);
 	vb->vb2_queue->bufs[vb->index] = NULL;
 	vb->vb2_queue = NULL;
 }
@@ -448,11 +448,12 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
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
 
@@ -874,6 +875,14 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
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
@@ -943,7 +952,6 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	}
 
 	mutex_lock(&q->mmap_lock);
-	q->num_buffers = allocated_buffers;
 
 	if (ret < 0) {
 		/*
@@ -970,6 +978,10 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
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
@@ -1006,9 +1018,19 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
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
@@ -1070,7 +1092,6 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 	}
 
 	mutex_lock(&q->mmap_lock);
-	q->num_buffers += allocated_buffers;
 
 	if (ret < 0) {
 		/*
@@ -2547,7 +2568,9 @@ void vb2_core_queue_release(struct vb2_queue *q)
 	__vb2_queue_free(q, q->max_num_buffers);
 	kfree(q->bufs);
 	q->bufs = NULL;
-	q->num_buffers = 0;
+	bitmap_free(q->bufs_bitmap);
+	q->bufs_bitmap = NULL;
+
 	mutex_unlock(&q->mmap_lock);
 }
 EXPORT_SYMBOL_GPL(vb2_core_queue_release);
@@ -2902,7 +2925,7 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
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

