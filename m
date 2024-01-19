Return-Path: <linux-kernel+bounces-30973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C583C8326FC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73AB62852A7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4843B3CF79;
	Fri, 19 Jan 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lOxKV9R5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2D23CF40;
	Fri, 19 Jan 2024 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705657795; cv=none; b=HMgjwiodx5gAPFANt75dTi9VvsnrrzVg3J9lMFqNgim2X2f8mK0gUgLb09T8ZC9sGPLCCYpxw6GsKh2fy0+pVnFM5LB3U0UhkV/mpyUiWGNOHxio/BCFuViVfJEVPUswmaJaNXSV6x2VbA3EPqGIrQx3uWCXl06y5lTNIDt1F6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705657795; c=relaxed/simple;
	bh=FLBFuqECXkGiY0RlgBdPS2/ncFY9XY1maA7holM0MMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qMFl3LfEChNeyBzoKvD6IS7oZdIWEVHLVyo8L0Ueyig6jfaZzurQCUewrmPbov/8JitU7BXCxHpXtQ1bL5n5xT2h2Vp3ZXgJPv8WrW7WulNoq4/jtOVY+IJRLaFT2mubYzRKh31LcE+KRfJzkke5GSUtQjddzqYf8gJam0H2ml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lOxKV9R5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705657792;
	bh=FLBFuqECXkGiY0RlgBdPS2/ncFY9XY1maA7holM0MMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lOxKV9R5zQoJ1f1oCdaLeFVvL5c2KQhqQxD8InsNbNefu3xvZCTOO4K6dFxlFpKFE
	 eHPVe6c1X8VT7Nba5wfXmv5Zu9otPUd4e+TFpuwmuEHQo30ATVXvZYkrvn3lwG+ET7
	 ZlSY5+M0zcee14joHi3bPwuicRXuk/7S2EmZuv0vgXXx+gDU5qKMmzlborCdEmxPLF
	 LYuDSI8anYEKjNpd6jPpSL7sAKe0gwc8AnvLQmIvFf1KeiFJuvIm1365iAMdoCdNp6
	 dzA6C4NG2EGC5LkT7OOrBEvHRbA56jcsQe688i+HH0LS8tS/dvmj3K4BhDp82PikQq
	 OPiOiissM5BMA==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1B1BF3782084;
	Fri, 19 Jan 2024 09:49:52 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v17 3/8] media: core: Rework how create_buf index returned value is computed
Date: Fri, 19 Jan 2024 10:49:39 +0100
Message-Id: <20240119094944.26763-4-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240119094944.26763-1-benjamin.gaignard@collabora.com>
References: <20240119094944.26763-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When DELETE_BUFS will be introduced holes could created in bufs array.
To be able to reuse these unused indices reworking how create->index
is set is mandatory.
Let __vb2_queue_alloc() decide which first index is correct and
forward this to the caller.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 17:
- rework documentation
 .../media/common/videobuf2/videobuf2-core.c    | 18 +++++++++++++-----
 .../media/common/videobuf2/videobuf2-v4l2.c    | 14 +++++++++-----
 include/media/videobuf2-core.h                 |  5 ++++-
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index d74e93d00f58..fd5ac2845018 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -442,12 +442,15 @@ static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
  * __vb2_queue_alloc() - allocate vb2 buffer structures and (for MMAP type)
  * video buffer memory for all buffers/planes on the queue and initializes the
  * queue
+ * @first_index: index of the first created buffer, all allocated buffers have
+ *		 indices in the range [first..first+count]
  *
  * Returns the number of buffers successfully allocated.
  */
 static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 			     unsigned int num_buffers, unsigned int num_planes,
-			     const unsigned plane_sizes[VB2_MAX_PLANES])
+			     const unsigned int plane_sizes[VB2_MAX_PLANES],
+			     unsigned int *first_index)
 {
 	unsigned int q_num_buffers = vb2_get_num_buffers(q);
 	unsigned int buffer, plane;
@@ -461,6 +464,8 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 	num_buffers = min_t(unsigned int, num_buffers,
 			    q->max_num_buffers - q_num_buffers);
 
+	*first_index = q_num_buffers;
+
 	for (buffer = 0; buffer < num_buffers; ++buffer) {
 		/* Allocate vb2 buffer structures */
 		vb = kzalloc(q->buf_struct_size, GFP_KERNEL);
@@ -820,7 +825,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	unsigned int q_num_bufs = vb2_get_num_buffers(q);
 	unsigned plane_sizes[VB2_MAX_PLANES] = { };
 	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
-	unsigned int i;
+	unsigned int i, first_index;
 	int ret = 0;
 
 	if (q->streaming) {
@@ -906,8 +911,10 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 
 	/* Finally, allocate buffers and video memory */
 	allocated_buffers =
-		__vb2_queue_alloc(q, memory, num_buffers, num_planes, plane_sizes);
+		__vb2_queue_alloc(q, memory, num_buffers, num_planes, plane_sizes, &first_index);
 	if (allocated_buffers == 0) {
+		/* There shouldn't be any buffers allocated, so first_index == 0 */
+		WARN_ON(first_index);
 		dprintk(q, 1, "memory allocation failed\n");
 		ret = -ENOMEM;
 		goto error;
@@ -980,7 +987,8 @@ EXPORT_SYMBOL_GPL(vb2_core_reqbufs);
 int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 			 unsigned int flags, unsigned int *count,
 			 unsigned int requested_planes,
-			 const unsigned int requested_sizes[])
+			 const unsigned int requested_sizes[],
+			 unsigned int *first_index)
 {
 	unsigned int num_planes = 0, num_buffers, allocated_buffers;
 	unsigned plane_sizes[VB2_MAX_PLANES] = { };
@@ -1042,7 +1050,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 
 	/* Finally, allocate buffers and video memory */
 	allocated_buffers = __vb2_queue_alloc(q, memory, num_buffers,
-				num_planes, plane_sizes);
+				num_planes, plane_sizes, first_index);
 	if (allocated_buffers == 0) {
 		dprintk(q, 1, "memory allocation failed\n");
 		ret = -ENOMEM;
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index c575198e8354..03e8080a68a8 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -795,11 +795,15 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
 	for (i = 0; i < requested_planes; i++)
 		if (requested_sizes[i] == 0)
 			return -EINVAL;
-	return ret ? ret : vb2_core_create_bufs(q, create->memory,
-						create->flags,
-						&create->count,
-						requested_planes,
-						requested_sizes);
+	if (ret)
+		return ret;
+
+	return vb2_core_create_bufs(q, create->memory,
+				    create->flags,
+				    &create->count,
+				    requested_planes,
+				    requested_sizes,
+				    &create->index);
 }
 EXPORT_SYMBOL_GPL(vb2_create_bufs);
 
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index fe3423ff3807..e29ff77814d3 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -821,6 +821,8 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
  * @count: requested buffer count.
  * @requested_planes: number of planes requested.
  * @requested_sizes: array with the size of the planes.
+ * @first_index: index of the first created buffer, all allocated buffers have
+ *		 indices in the range [first..first+count]
  *
  * Videobuf2 core helper to implement VIDIOC_CREATE_BUFS() operation. It is
  * called internally by VB2 by an API-specific handler, like
@@ -837,7 +839,8 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 			 unsigned int flags, unsigned int *count,
 			 unsigned int requested_planes,
-			 const unsigned int requested_sizes[]);
+			 const unsigned int requested_sizes[],
+			 unsigned int *first_index);
 
 /**
  * vb2_core_prepare_buf() - Pass ownership of a buffer from userspace
-- 
2.40.1


