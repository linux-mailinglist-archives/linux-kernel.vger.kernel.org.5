Return-Path: <linux-kernel+bounces-40018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4780683D8D9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B38C1F25512
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2987917993;
	Fri, 26 Jan 2024 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1A/chmW/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB16134B4;
	Fri, 26 Jan 2024 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266911; cv=none; b=uviSBpzHJA+4e8TNKVvgn1oxOuJBMI0D9QfSDOeShts1tBOxrkGSpPy6k/+kpDSmqkJeqwhgCA4lNyApf6LMIqAiybrqBzXCpsoncdtkgxeYAXJe1newEctSw8L30M+GDRM3a18GLnqtlJQ2cfzsTCjjfQDqHDT0rqIh0QRJXyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266911; c=relaxed/simple;
	bh=rxonFy/xXtVsAa0j3VVLg0HDonl2D7ONJZ+FYLpKkqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ATOi/fTY8k2P6tFWVb9O6emmsa5VGMMC2+NvEmE25Pn1bfje3HXCQC2q6fbXH9+OgsJerbry2Em6Io9Hy6GV6O24Wq2pfdhBYR4cAG3xJrE8V9bU25cBJ4H76r14TFzqfnkUCmilLFLDtan+GpIhd/c+zNL2pDHLYAxDB8K6IOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1A/chmW/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706266908;
	bh=rxonFy/xXtVsAa0j3VVLg0HDonl2D7ONJZ+FYLpKkqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1A/chmW/4RbUhi7naBQWJJ9z9kf8G/PqQytw1fXdWw7Gme2LwMaYHKpnMYo6cuLvM
	 1Mq61ZLvvwGcmaTJ4bCTlSGXRJbjtM4OWIIbccauRghXxEbtKmZJWVLKGpOJjAr9p1
	 /EEo04eJFagZHT6K2CB7OzsMEac2tAHnSxRfsXlEtYiwcRj/jaO0fN/HXhcxqcRPSW
	 VuxSWsVIUhGR05Q5JXGO0SOQwUBG2OGSfGOnWcAFulM5IAivg2VGeKC/usEOu4Fmxb
	 CvRyUBVmmcQNfcmMEnKwlvn+h4oNYzM2Cv41NH0QlqyPEHBy0og5fhSJUNc7Q+2z+D
	 HeozAedOiTKPw==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 976843782076;
	Fri, 26 Jan 2024 11:01:47 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v18 2/9] videobuf2: Add min_reqbufs_allocation field to vb2_queue structure
Date: Fri, 26 Jan 2024 12:01:34 +0100
Message-Id: <20240126110141.135896-3-benjamin.gaignard@collabora.com>
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

Add 'min_reqbufs_allocation' field in the vb2_queue structure so drivers
can specify the minimum number of buffers to allocate when calling
VIDIOC_REQBUFS.
When initializing the queue, v4l2 core makes sure that the following
constraints are respected:
- the minimum number of buffers to allocate must be at least 2 because
one buffer is used by the hardware while the other is being processed
by userspace.
-if the driver needs 'min_queued_buffers' in the queue before calling
start_streaming(), then the minimum requirement is 'min_queued_buffers + 1'
to keep at least one buffer available for userspace.

Simplify __vb2_init_fileio() by using 'min_reqbufs_allocation' directly
to avoid duplicating the minimum number of buffers to allocate computation.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 38 +++++++++++--------
 include/media/videobuf2-core.h                | 15 +++++++-
 2 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 8aa6057df581..85a56b7fcd4a 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -867,7 +867,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	/*
 	 * Make sure the requested values and current defaults are sane.
 	 */
-	num_buffers = max_t(unsigned int, *count, q->min_queued_buffers);
+	num_buffers = max_t(unsigned int, *count, q->min_reqbufs_allocation);
 	num_buffers = min_t(unsigned int, num_buffers, q->max_num_buffers);
 	memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
 	/*
@@ -919,7 +919,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	 * There is no point in continuing if we can't allocate the minimum
 	 * number of buffers needed by this vb2_queue.
 	 */
-	if (allocated_buffers < q->min_queued_buffers)
+	if (allocated_buffers < q->min_reqbufs_allocation)
 		ret = -ENOMEM;
 
 	/*
@@ -2525,6 +2525,25 @@ int vb2_core_queue_init(struct vb2_queue *q)
 	if (WARN_ON(q->supports_requests && q->min_queued_buffers))
 		return -EINVAL;
 
+	/*
+	 * The minimum requirement is 2: one buffer is used
+	 * by the hardware while the other is being processed by userspace.
+	 */
+	if (q->min_reqbufs_allocation < 2)
+		q->min_reqbufs_allocation = 2;
+
+	/*
+	 * If the driver needs 'min_queued_buffers' in the queue before
+	 * calling start_streaming() then the minimum requirement is
+	 * 'min_queued_buffers + 1' to keep at least one buffer available
+	 * for userspace.
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
@@ -2717,7 +2736,6 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
 	struct vb2_fileio_data *fileio;
 	struct vb2_buffer *vb;
 	int i, ret;
-	unsigned int count = 0;
 
 	/*
 	 * Sanity check
@@ -2738,18 +2756,8 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
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
@@ -2763,7 +2771,7 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
 	 * Request buffers and use MMAP type to force driver
 	 * to allocate buffers by itself.
 	 */
-	fileio->count = count;
+	fileio->count = q->min_reqbufs_allocation;
 	fileio->memory = VB2_MEMORY_MMAP;
 	fileio->type = q->type;
 	q->fileio = fileio;
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index b317286a7b08..ef5500d14c09 100644
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
@@ -619,6 +631,7 @@ struct vb2_queue {
 	u32				timestamp_flags;
 	gfp_t				gfp_flags;
 	u32				min_queued_buffers;
+	u32				min_reqbufs_allocation;
 
 	struct device			*alloc_devs[VB2_MAX_PLANES];
 
-- 
2.40.1


