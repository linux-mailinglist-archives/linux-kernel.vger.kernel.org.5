Return-Path: <linux-kernel+bounces-40022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D58F83D8EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519E61C245F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642871B970;
	Fri, 26 Jan 2024 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I0pcuRJz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0501759D;
	Fri, 26 Jan 2024 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266914; cv=none; b=H0tlrHGK+dckF29GktTafWw5Zg1CQ2MnF+6qJFMhmp28kTTaFD5k2kyf2hSyAR9RB/Uazw4gFrv1HeOaXFy8nPbdhcpdTUq7G2yXd4tGhNHcZIlTK5b9m0TSW/IlOimW5gvrAG4yVPRaazBGCnTtRulcQDv8XTgyAt8R9oxt8Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266914; c=relaxed/simple;
	bh=oqOAl+ldRIt8OGMTrSuoDyTgNjicXhs4LiBOPD1/8sY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bdl26F57CMyUyIB5tQZwi05eMvKucyZ8wSV7aHMQU/fO7AoBIT5PVBf7gj6agV5dZERJT6L8Hbh1ZrDLuy0f/ZA0DwGhKP4/zdCVbcbm6kt1aFGM9GwssRhZ3AbbkD5Zd7wehBGreR7xYnTaO+nheFQeQKsMJwQCzIot8yIYR58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I0pcuRJz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706266909;
	bh=oqOAl+ldRIt8OGMTrSuoDyTgNjicXhs4LiBOPD1/8sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0pcuRJzNcxPhVCg0OOcfv8890ktNEWDxSt/evc3tHBclJf9NTdH2X9YLso6K3Uq0
	 bTFdzyZqkCucmSOP4thzxFY2UYS7Dmkz8GmGFwSXvNt+JQWrARptWf/qKRxJYXfo2f
	 Q7+CeZLg/oeQq+EUXbMWbTKs0/vKjgHtIPZ3kTHKpUg9oYOyKyhl42WOK0lNstllpp
	 z1gXCbIa2HldOWPk9nuX/RwvfzsqzY4gRl8HXUqXdkBVanMcLVt6qJVxERX1wg4fzG
	 0hdSQlyyBzequ3JdO6cUXXQQllOXjm+twmno2Moq+tTJIKX8UAjg4wqpvgLh2g89b2
	 RdIoubZlB1BUQ==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3514D3782089;
	Fri, 26 Jan 2024 11:01:49 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v18 5/9] media: core: Add bitmap manage bufs array entries
Date: Fri, 26 Jan 2024 12:01:37 +0100
Message-Id: <20240126110141.135896-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240126110141.135896-1-benjamin.gaignard@collabora.com>
References: <20240126110141.135896-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a bitmap field to know which of bufs array entries are
used or not.
Remove no more used num_buffers field from queue structure.
Use bitmap_find_next_zero_area() to find the first possible
range when creating new buffers to fill the gaps.
If no suitable range is found try to allocate less buffers
than requested.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 18:
- rework bitmap free range finding loop

 .../media/common/videobuf2/videobuf2-core.c   | 71 ++++++++++++++-----
 include/media/videobuf2-core.h                | 18 +++--
 2 files changed, 64 insertions(+), 25 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 4114df79f8ad..1506fbe8fc76 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -421,11 +421,12 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
  */
 static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, unsigned int index)
 {
-	WARN_ON(index >= q->max_num_buffers || q->bufs[index] || vb->vb2_queue);
+	WARN_ON(index >= q->max_num_buffers || test_bit(index, q->bufs_bitmap) || vb->vb2_queue);
 
 	q->bufs[index] = vb;
 	vb->index = index;
 	vb->vb2_queue = q;
+	set_bit(index, q->bufs_bitmap);
 }
 
 /**
@@ -434,6 +435,7 @@ static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, uns
  */
 static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
 {
+	clear_bit(vb->index, vb->vb2_queue->bufs_bitmap);
 	vb->vb2_queue->bufs[vb->index] = NULL;
 	vb->vb2_queue = NULL;
 }
@@ -452,9 +454,9 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 			     const unsigned int plane_sizes[VB2_MAX_PLANES],
 			     unsigned int *first_index)
 {
-	unsigned int q_num_buffers = vb2_get_num_buffers(q);
 	unsigned int buffer, plane;
 	struct vb2_buffer *vb;
+	unsigned long index = q->max_num_buffers;
 	int ret;
 
 	/*
@@ -462,9 +464,25 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 	 * in the queue is below q->max_num_buffers
 	 */
 	num_buffers = min_t(unsigned int, num_buffers,
-			    q->max_num_buffers - q_num_buffers);
+			    q->max_num_buffers - vb2_get_num_buffers(q));
+
+	while (num_buffers) {
+		index = bitmap_find_next_zero_area(q->bufs_bitmap, q->max_num_buffers,
+						   0, num_buffers, 0);
+
+		if (index < q->max_num_buffers)
+			break;
+		/* Try to find free space for less buffers */
+		num_buffers--;
+	}
+
+	/* If there is no space left to allocate buffers return 0 to indicate the error */
+	if (!num_buffers) {
+		*first_index = 0;
+		return 0;
+	}
 
-	*first_index = q_num_buffers;
+	*first_index = index;
 
 	for (buffer = 0; buffer < num_buffers; ++buffer) {
 		/* Allocate vb2 buffer structures */
@@ -484,7 +502,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 			vb->planes[plane].min_length = plane_sizes[plane];
 		}
 
-		vb2_queue_add_buffer(q, vb, q_num_buffers + buffer);
+		vb2_queue_add_buffer(q, vb, index++);
 		call_void_bufop(q, init_buffer, vb);
 
 		/* Allocate video buffer memory for the MMAP type */
@@ -664,7 +682,6 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
 		kfree(vb);
 	}
 
-	q->num_buffers -= buffers;
 	if (!vb2_get_num_buffers(q)) {
 		q->memory = VB2_MEMORY_UNKNOWN;
 		INIT_LIST_HEAD(&q->queued_list);
@@ -818,6 +835,32 @@ static bool verify_coherency_flags(struct vb2_queue *q, bool non_coherent_mem)
 	return true;
 }
 
+static int vb2_core_allocated_buffers_storage(struct vb2_queue *q)
+{
+	if (!q->bufs)
+		q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);
+	if (!q->bufs)
+		return -ENOMEM;
+
+	if (!q->bufs_bitmap)
+		q->bufs_bitmap = bitmap_zalloc(q->max_num_buffers, GFP_KERNEL);
+	if (!q->bufs_bitmap) {
+		kfree(q->bufs);
+		q->bufs = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void vb2_core_free_buffers_storage(struct vb2_queue *q)
+{
+	kfree(q->bufs);
+	q->bufs = NULL;
+	bitmap_free(q->bufs_bitmap);
+	q->bufs_bitmap = NULL;
+}
+
 int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 		     unsigned int flags, unsigned int *count)
 {
@@ -880,10 +923,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	 * in the queue_setup op.
 	 */
 	mutex_lock(&q->mmap_lock);
-	if (!q->bufs)
-		q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);
-	if (!q->bufs)
-		ret = -ENOMEM;
+	ret = vb2_core_allocated_buffers_storage(q);
 	q->memory = memory;
 	mutex_unlock(&q->mmap_lock);
 	if (ret)
@@ -955,7 +995,6 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	}
 
 	mutex_lock(&q->mmap_lock);
-	q->num_buffers = allocated_buffers;
 
 	if (ret < 0) {
 		/*
@@ -983,6 +1022,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	mutex_lock(&q->mmap_lock);
 	q->memory = VB2_MEMORY_UNKNOWN;
 	mutex_unlock(&q->mmap_lock);
+	vb2_core_free_buffers_storage(q);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(vb2_core_reqbufs);
@@ -1016,11 +1056,8 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 		 * value in the queue_setup op.
 		 */
 		mutex_lock(&q->mmap_lock);
+		ret = vb2_core_allocated_buffers_storage(q);
 		q->memory = memory;
-		if (!q->bufs)
-			q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);
-		if (!q->bufs)
-			ret = -ENOMEM;
 		mutex_unlock(&q->mmap_lock);
 		if (ret)
 			return ret;
@@ -1083,7 +1120,6 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 	}
 
 	mutex_lock(&q->mmap_lock);
-	q->num_buffers += allocated_buffers;
 
 	if (ret < 0) {
 		/*
@@ -2584,8 +2620,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
 	__vb2_queue_cancel(q);
 	mutex_lock(&q->mmap_lock);
 	__vb2_queue_free(q, vb2_get_num_buffers(q));
-	kfree(q->bufs);
-	q->bufs = NULL;
+	vb2_core_free_buffers_storage(q);
 	mutex_unlock(&q->mmap_lock);
 }
 EXPORT_SYMBOL_GPL(vb2_core_queue_release);
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 2a9ca70e99c7..88e35a3b7730 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -346,8 +346,8 @@ struct vb2_buffer {
  *			describes the requested number of planes and sizes\[\]
  *			contains the requested plane sizes. In this case
  *			\*num_buffers are being allocated additionally to
- *			q->num_buffers. If either \*num_planes or the requested
- *			sizes are invalid callback must return %-EINVAL.
+ *			the buffers already allocated. If either \*num_planes
+ *			or the requested sizes are invalid callback must return %-EINVAL.
  * @wait_prepare:	release any locks taken while calling vb2 functions;
  *			it is called before an ioctl needs to wait for a new
  *			buffer to arrive; required to avoid a deadlock in
@@ -571,8 +571,9 @@ struct vb2_buf_ops {
  * @mmap_lock:	private mutex used when buffers are allocated/freed/mmapped
  * @memory:	current memory type used
  * @dma_dir:	DMA mapping direction.
- * @bufs:	videobuf2 buffer structures
- * @num_buffers: number of allocated/used buffers
+ * @bufs:	videobuf2 buffer structures. If it is non-NULL then
+ *		bufs_bitmap is also non-NULL.
+ * @bufs_bitmap: bitmap tracking whether each bufs[] entry is used
  * @max_num_buffers: upper limit of number of allocated/used buffers.
  *		     If set to 0 v4l2 core will change it VB2_MAX_FRAME
  *		     for backward compatibility.
@@ -640,7 +641,7 @@ struct vb2_queue {
 	unsigned int			memory;
 	enum dma_data_direction		dma_dir;
 	struct vb2_buffer		**bufs;
-	unsigned int			num_buffers;
+	unsigned long			*bufs_bitmap;
 	unsigned int			max_num_buffers;
 
 	struct list_head		queued_list;
@@ -1170,7 +1171,10 @@ static inline bool vb2_fileio_is_active(struct vb2_queue *q)
  */
 static inline unsigned int vb2_get_num_buffers(struct vb2_queue *q)
 {
-	return q->num_buffers;
+	if (q->bufs_bitmap)
+		return bitmap_weight(q->bufs_bitmap, q->max_num_buffers);
+
+	return 0;
 }
 
 /**
@@ -1279,7 +1283,7 @@ static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
 	if (index >= q->max_num_buffers)
 		return NULL;
 
-	if (index < q->num_buffers)
+	if (test_bit(index, q->bufs_bitmap))
 		return q->bufs[index];
 	return NULL;
 }
-- 
2.40.1


