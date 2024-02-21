Return-Path: <linux-kernel+bounces-75043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F88585E218
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB01D1F24FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70204823DA;
	Wed, 21 Feb 2024 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="woM5TAZi"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFC81AB0;
	Wed, 21 Feb 2024 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530888; cv=none; b=P2jpz+bdV7ECERtbNTBb7VkV8nywmdJ5zJL2vGgBM99SSSTV+o4FU953OfWAgJbbawbvTi8/Pu6PAUSBDp8UjZpNXrXIoFw7yD0CnTRsRarUfAcxC7K3Po/dQO1DcZIP1CXZE3qFgpoxZl/f7NQaZMW3engb3abbpx0Suvm2YIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530888; c=relaxed/simple;
	bh=F2tCb9wrVF4rzaA8ZIQQ0yFu1+5C0qlZBUoz027HFsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XVkUHMakiF5UUyAyDu0JYHzLya7QI31gw+rkaaJs8Z6KIlcknr4lw83pfLkhxhkvzCp9OyTortwJsd8KgNOrj4qFZUwnKD3jE1jCZQ8YMFYzQ8iWjoDYxD0qwgri7uBp0zdS8rICoaQRUtqstCeIfBZN5Ysq05coLXAHiObe3qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=woM5TAZi; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708530885;
	bh=F2tCb9wrVF4rzaA8ZIQQ0yFu1+5C0qlZBUoz027HFsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=woM5TAZi6ecMXV2UrX4WpflalEahTxiNez6SvyhDY2GxeXAp/tRthaAQqC/pudag6
	 3vQQ8hT6ZviTcUzUFVjSPwAl1oquO35QfjRcYe5DS3BeArFzg9hBl8NESYFj2jVyo/
	 laIsOpLpPNvqBIj4alVMlcZkfrmLj4YurC+uwarGOjcP+pMxQXWYJw7g167F9fv8gX
	 6I0ugIoDjyYcWWoa9jMQv5VThjI4LAp0z6SsHmQGegBDA3w0/Vo9O+bl39A2r0H3pN
	 6BVzV9putUB2INxrkRyY3cz5kW8/PynkbLF9A3WEL+c62zZNY0fNAb7/UTxYyF8m+T
	 c8sFnnBrV6fmQ==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 95B7B37820CE;
	Wed, 21 Feb 2024 15:54:44 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: mchehab@kernel.org,
	tfiga@chromium.org,
	m.szyprowski@samsung.com,
	ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	hverkuil-cisco@xs4all.nl,
	nicolas@ndufresne.ca
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v20 4/9] media: core: Rework how create_buf index returned value is computed
Date: Wed, 21 Feb 2024 16:54:30 +0100
Message-Id: <20240221155435.100093-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240221155435.100093-1-benjamin.gaignard@collabora.com>
References: <20240221155435.100093-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When REMOVE_BUFS will be introduced holes could created in bufs array.
To be able to reuse these unused indices reworking how create->index
is set is mandatory.
Let __vb2_queue_alloc() decide which first index is correct and
forward this to the caller.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c    | 18 +++++++++++++-----
 .../media/common/videobuf2/videobuf2-v4l2.c    | 14 +++++++++-----
 include/media/videobuf2-core.h                 |  5 ++++-
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 58c495b253ce..8e819d198c34 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -442,12 +442,15 @@ static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
  * __vb2_queue_alloc() - allocate vb2 buffer structures and (for MMAP type)
  * video buffer memory for all buffers/planes on the queue and initializes the
  * queue
+ * @first_index: index of the first created buffer, all newly allocated buffers
+ *		 have indices in the range [first_index..first_index+count-1]
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
@@ -907,8 +912,10 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 
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
@@ -982,7 +989,8 @@ EXPORT_SYMBOL_GPL(vb2_core_reqbufs);
 int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 			 unsigned int flags, unsigned int *count,
 			 unsigned int requested_planes,
-			 const unsigned int requested_sizes[])
+			 const unsigned int requested_sizes[],
+			 unsigned int *first_index)
 {
 	unsigned int num_planes = 0, num_buffers, allocated_buffers;
 	unsigned plane_sizes[VB2_MAX_PLANES] = { };
@@ -1044,7 +1052,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 
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
index 2ca120f18edf..ee0cbd8705ec 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -823,6 +823,8 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
  * @count: requested buffer count.
  * @requested_planes: number of planes requested.
  * @requested_sizes: array with the size of the planes.
+ * @first_index: index of the first created buffer, all allocated buffers have
+ *		 indices in the range [first_index..first_index+count-1]
  *
  * Videobuf2 core helper to implement VIDIOC_CREATE_BUFS() operation. It is
  * called internally by VB2 by an API-specific handler, like
@@ -839,7 +841,8 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
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


