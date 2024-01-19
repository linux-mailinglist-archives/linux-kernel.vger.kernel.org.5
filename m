Return-Path: <linux-kernel+bounces-30971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AD48326F8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716041F2318E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605553CF50;
	Fri, 19 Jan 2024 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dErAVSkt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C8C3C693;
	Fri, 19 Jan 2024 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705657794; cv=none; b=KWa/fIlvyMUaarumRX5V/wf9Dp2Zse9Qzf1ZIbc0Z9XSijM895sG6HC+buWG9uPvE4kMwpeYfR+XsdZAfQ9m8ZIarDEh8xwHw79LPGgPIor4ufq4gjrd3ioH7UaiQsZpOB08VCWVvCuZ7lGlpi2rOhHDv4qoagDy7KqbtKIeICg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705657794; c=relaxed/simple;
	bh=SfNHaMz/EWNiEqcLSKoUncdI3TZfa6CIrCQUBzs9qF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kUSdISau1vsXxmNKAh4ZZ6JDf8IrctWCJLATiXJkpWa79gZnkMWQlsBoaCeXjyFSoAKrKNab6UY+0Xx8Ap+Fu0WbGxJQkjqlgv9dXTEOqwV84vvD2PmULtlQ2VZ2qmbvb98DijqMGhrTq5aPH0RIsVGkGoSzG+vttIe5FgCsiHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dErAVSkt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705657791;
	bh=SfNHaMz/EWNiEqcLSKoUncdI3TZfa6CIrCQUBzs9qF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dErAVSkt3+LYjxfpPYlD9u1APsj/JJJufeFWYjoNN5BROSIFolO9WM1udvBHLyzDU
	 uaqzBJGhi40JGJ+NY/6h+oftXB8A59QYjnyxHtBNPCty2w7UgxeUCo5i8tZvAlOxcY
	 YUXKOmMxY8yXchM7KUgcgdsEFDYUyIo51mRaZoqEewFCkzMvkb5yB09dWiIoVdOM5j
	 VPfmAsUvGjw6nUlKnD1e9p72brQv2jNVmcW5pbxiR2Fa7lJD5mx/ob/H1VzHE/PPBX
	 N0Dzv/UT957f8znlPQ8nX74y9Zd4TnWcljXQdhx/8iGkzt2ymoJTYqNttLmTZ/HEnW
	 pj0r+0BNG4VDw==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EC2733782081;
	Fri, 19 Jan 2024 09:49:50 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v17 1/8] videobuf2: Add min_reqbufs_allocation field to vb2_queue structure
Date: Fri, 19 Jan 2024 10:49:37 +0100
Message-Id: <20240119094944.26763-2-benjamin.gaignard@collabora.com>
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

Add 'min_reqbufs_allocation' field in vb2_queue structure so drivers
can specificy the minimum number of buffers to allocate when calling
VIDIOC_REQBUFS.
When initializing the queue, v4l2 core makes sure that the following
constraint are respected:
- minimum number of buffers to allocate should be at least 2 because
one buffer is used by the hardware and other processed by userspace.
- if a minimum number of buffers before start streaming is specify
the minimum number of buffers to allocate should be min_queued_buffers
+ 1 to keep one buffer available for userspace.

Simplify __vb2_init_fileio() by using 'min_reqbufs_allocation' directly
to avoid duplicating the minimum number of buffers to allocate computation.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 17:
- rewrite commit message.
- simplify __vb2_init_fileio() code.
- rewrite documentation

 .../media/common/videobuf2/videobuf2-core.c   | 37 +++++++++++--------
 include/media/videobuf2-core.h                | 15 +++++++-
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index b6bf8f232f48..d74e93d00f58 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -865,7 +865,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	/*
 	 * Make sure the requested values and current defaults are sane.
 	 */
-	num_buffers = max_t(unsigned int, *count, q->min_queued_buffers);
+	num_buffers = max_t(unsigned int, *count, q->min_reqbufs_allocation);
 	num_buffers = min_t(unsigned int, num_buffers, q->max_num_buffers);
 	memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
 	/*
@@ -917,7 +917,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	 * There is no point in continuing if we can't allocate the minimum
 	 * number of buffers needed by this vb2_queue.
 	 */
-	if (allocated_buffers < q->min_queued_buffers)
+	if (allocated_buffers < q->min_reqbufs_allocation)
 		ret = -ENOMEM;
 
 	/*
@@ -2521,6 +2521,24 @@ int vb2_core_queue_init(struct vb2_queue *q)
 	if (WARN_ON(q->supports_requests && q->min_queued_buffers))
 		return -EINVAL;
 
+	/*
+	 * The minimum requirement should really be 2: one buffer is used
+	 * by the hardware and one other processed by userspace.
+	 */
+	if (q->min_reqbufs_allocation < 2)
+		q->min_reqbufs_allocation = 2;
+
+	/*
+	 * If the driver needs 'min_queued_buffers' before start streaming
+	 * then the minimum requirement is min_queued_buffers + 1 to keep
+	 * at least one buffer available for userspace
+	 */
+	if (q->min_reqbufs_allocation < q->min_queued_buffers + 1)
+		q->min_reqbufs_allocation = q->min_queued_buffers + 1;
+
+	if (WARN_ON(q->min_reqbufs_allocation > q->max_num_buffers))
+		return -EINVAL;
+
 	INIT_LIST_HEAD(&q->queued_list);
 	INIT_LIST_HEAD(&q->done_list);
 	spin_lock_init(&q->done_lock);
@@ -2713,7 +2731,6 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
 	struct vb2_fileio_data *fileio;
 	struct vb2_buffer *vb;
 	int i, ret;
-	unsigned int count = 0;
 
 	/*
 	 * Sanity check
@@ -2734,18 +2751,8 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
 	if (q->streaming || vb2_get_num_buffers(q) > 0)
 		return -EBUSY;
 
-	/*
-	 * Start with q->min_queued_buffers + 1, driver can increase it in
-	 * queue_setup()
-	 *
-	 * 'min_queued_buffers' buffers need to be queued up before you
-	 * can start streaming, plus 1 for userspace (or in this case,
-	 * kernelspace) processing.
-	 */
-	count = max(2, q->min_queued_buffers + 1);
-
 	dprintk(q, 3, "setting up file io: mode %s, count %d, read_once %d, write_immediately %d\n",
-		(read) ? "read" : "write", count, q->fileio_read_once,
+		(read) ? "read" : "write", q->min_reqbufs_allocation, q->fileio_read_once,
 		q->fileio_write_immediately);
 
 	fileio = kzalloc(sizeof(*fileio), GFP_KERNEL);
@@ -2759,7 +2766,7 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
 	 * Request buffers and use MMAP type to force driver
 	 * to allocate buffers by itself.
 	 */
-	fileio->count = count;
+	fileio->count = q->min_reqbufs_allocation;
 	fileio->memory = VB2_MEMORY_MMAP;
 	fileio->type = q->type;
 	q->fileio = fileio;
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 56719a26a46c..fe3423ff3807 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -550,9 +550,21 @@ struct vb2_buf_ops {
  *		@start_streaming can be called. Used when a DMA engine
  *		cannot be started unless at least this number of buffers
  *		have been queued into the driver.
- *		VIDIOC_REQBUFS will ensure at least @min_queued_buffers
+ *		VIDIOC_REQBUFS will ensure at least @min_queued_buffers + 1
  *		buffers will be allocated. Note that VIDIOC_CREATE_BUFS will not
  *		modify the requested buffer count.
+ * @min_reqbufs_allocation: the minimum number of buffers to be allocated when
+ *		calling VIDIOC_REQBUFS. Note that VIDIOC_CREATE_BUFS will *not*
+ *		modify the requested buffer count and does not use this field.
+ *		Drivers can set this if there has to be a certain number of
+ *		buffers available for the hardware to work effectively.
+ *		This allows calling VIDIOC_REQBUFS with a buffer count of 1 and
+ *		it will be automatically adjusted to a workable	buffer count.
+ *		If set, then @min_reqbufs_allocation must be larger than
+ *		@min_queued_buffers + 1.
+ *		If this field is > 3, then it is highly recommended that the
+ *		driver implements the V4L2_CID_MIN_BUFFERS_FOR_CAPTURE/OUTPUT
+ *		control.
  */
 /*
  * Private elements (won't appear at the uAPI book):
@@ -618,6 +630,7 @@ struct vb2_queue {
 	u32				timestamp_flags;
 	gfp_t				gfp_flags;
 	u32				min_queued_buffers;
+	u32				min_reqbufs_allocation;
 
 	struct device			*alloc_devs[VB2_MAX_PLANES];
 
-- 
2.40.1


