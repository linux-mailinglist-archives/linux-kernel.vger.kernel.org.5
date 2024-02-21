Return-Path: <linux-kernel+bounces-75046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7DF85E227
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C651C22A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F22D82D9C;
	Wed, 21 Feb 2024 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Uckoo+8g"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DC3823CD;
	Wed, 21 Feb 2024 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530891; cv=none; b=WmNlnmjQFI/tNHjzAR5a3SWCdrIfJuYlvH7X9o+rrj5QQPjD7SbXH2caXOOcp5jprdifbAjNuERxDHFmeWfbAfX8LSiVbg6SPHvNhp1iBYoHRi3pNx+FWwIGNIft5H7N9L3sHq4ndbdn9PxzrCqNwZtHi61oFj1W5BeL8VNC+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530891; c=relaxed/simple;
	bh=XB/5UpwLF2szdhyGEIcuE1KozQMJMoIsHBAeazbuPOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OvqqFkxId6OpAWYi9MPGMlk0sUwQNQTtkMTeViCx/x5pmFPHtXowKoJ8Tp4N6bMMIlnpgLdxv1w9fWEKsgm/j7SVbeCMFddFKL7rUNWX1IUydMqdwfRB4wVThcDPSLxpwpJYzP39x9qy2tdbCBL/gTC3W02t1hKYYIp8J3Ku9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Uckoo+8g; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708530887;
	bh=XB/5UpwLF2szdhyGEIcuE1KozQMJMoIsHBAeazbuPOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uckoo+8gdSWv4RMEtd+dVEf2IdDs/9lr3IFEvGkwWUYW29MTD1bQldm3hGsW85+tW
	 Wy5j7P67EWocj26Ny1XfzpVqnmVQm6LirM/vip7/PLwjySr9HbBGjOZ1UIeBPY9HWd
	 hu0LnBtCl3/edLWAnyXUIyYWhiPCPgNce3NNZ/QIt0Ig+dLcqDD4rI6tqdyHKn4G+Y
	 XMMMKxAr2tbQVgtmfTsaw+swGYrWChVhsVAJ4lwiigSRll99ZO5lU/yn386jSxVW/l
	 C6tRXfj7tEzHBVhfjJPKRG6RhLcVGuIwiytnYs7wPKqXDTo/LFqeE3xKptwm0p0hGl
	 NeiwXLe+FoXeA==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 051AB37820D0;
	Wed, 21 Feb 2024 15:54:46 +0000 (UTC)
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
Subject: [PATCH v20 7/9] media: v4l2: Add REMOVE_BUFS ioctl
Date: Wed, 21 Feb 2024 16:54:33 +0100
Message-Id: <20240221155435.100093-8-benjamin.gaignard@collabora.com>
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

VIDIOC_REMOVE_BUFS ioctl allows to remove buffers from a queue.
The number of buffers to remove in given by count field of
struct v4l2_remove_buffers and the range start at the index
specified in the same structure.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 20:
- Rename DELETE_BUFS into REMOVE_BUFS
- Change documention, structure and variables name to use 'remove'

 .../userspace-api/media/v4l/user-func.rst     |  1 +
 .../media/v4l/vidioc-remove-bufs.rst          | 82 +++++++++++++++++++
 .../media/v4l/vidioc-reqbufs.rst              |  1 +
 .../media/common/videobuf2/videobuf2-core.c   | 38 +++++++++
 .../media/common/videobuf2/videobuf2-v4l2.c   | 14 +++-
 drivers/media/v4l2-core/v4l2-dev.c            |  3 +
 drivers/media/v4l2-core/v4l2-ioctl.c          | 32 ++++++++
 include/media/v4l2-ioctl.h                    |  4 +
 include/media/videobuf2-core.h                | 10 +++
 include/media/videobuf2-v4l2.h                |  2 +
 include/uapi/linux/videodev2.h                | 17 ++++
 11 files changed, 203 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-remove-bufs.rst

diff --git a/Documentation/userspace-api/media/v4l/user-func.rst b/Documentation/userspace-api/media/v4l/user-func.rst
index 15ff0bf7bbe6..6f661138801c 100644
--- a/Documentation/userspace-api/media/v4l/user-func.rst
+++ b/Documentation/userspace-api/media/v4l/user-func.rst
@@ -62,6 +62,7 @@ Function Reference
     vidioc-query-dv-timings
     vidioc-querystd
     vidioc-reqbufs
+    vidioc-remove-bufs
     vidioc-s-hw-freq-seek
     vidioc-streamon
     vidioc-subdev-enum-frame-interval
diff --git a/Documentation/userspace-api/media/v4l/vidioc-remove-bufs.rst b/Documentation/userspace-api/media/v4l/vidioc-remove-bufs.rst
new file mode 100644
index 000000000000..0fbc0dfbbaa1
--- /dev/null
+++ b/Documentation/userspace-api/media/v4l/vidioc-remove-bufs.rst
@@ -0,0 +1,82 @@
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
+.. c:namespace:: V4L
+
+.. _VIDIOC_REMOVE_BUFS:
+
+************************
+ioctl VIDIOC_REMOVE_BUFS
+************************
+
+Name
+====
+
+VIDIOC_REMOVE_BUFS - Removes buffers from a queue
+
+Synopsis
+========
+
+.. c:macro:: VIDIOC_REMOVE_BUFS
+
+``int ioctl(int fd, VIDIOC_REMOVE_BUFS, struct v4l2_remove_buffers *argp)``
+
+Arguments
+=========
+
+``fd``
+    File descriptor returned by :c:func:`open()`.
+
+``argp``
+    Pointer to struct :c:type:`v4l2_remove_buffers`.
+
+Description
+===========
+
+Applications can optionally call the :ref:`VIDIOC_REMOVE_BUFS` ioctl to
+remove buffers from a queue.
+:ref:`VIDIOC_CREATE_BUFS` ioctl support is mandatory to enable :ref:`VIDIOC_REMOVE_BUFS`.
+This ioctl is available if the ``V4L2_BUF_CAP_SUPPORTS_REMOVE_BUFS`` capability
+is set on the queue when :c:func:`VIDIOC_REQBUFS` or :c:func:`VIDIOC_CREATE_BUFS`
+are invoked.
+
+.. c:type:: v4l2_remove_buffers
+
+.. tabularcolumns:: |p{4.4cm}|p{4.4cm}|p{8.5cm}|
+
+.. flat-table:: struct v4l2_remove_buffers
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2
+
+    * - __u32
+      - ``index``
+      - The starting buffer index to remove.
+    * - __u32
+      - ``count``
+      - The number of buffers to be removed with indices 'index' until 'index + count - 1'.
+        All buffers in this range must be valid and in DEQUEUED state.
+        If count is set to 0 :ref:`VIDIOC_REMOVE_BUFS` will do nothing and return 0.
+    * - __u32
+      - ``type``
+      - Type of the stream or buffers, this is the same as the struct
+	:c:type:`v4l2_format` ``type`` field. See
+	:c:type:`v4l2_buf_type` for valid values.
+    * - __u32
+      - ``reserved``\ [13]
+      - A place holder for future extensions. Drivers and applications
+	must set the array to zero.
+
+Return Value
+============
+
+On success 0 is returned, on error -1 and the ``errno`` variable is set
+appropriately. The generic error codes are described at the
+:ref:`Generic Error Codes <gen-errors>` chapter.
+
+EBUSY
+    File I/O is in progress.
+    One or more of the buffers in the range ``index`` to ``index + count - 1`` are not
+    in DEQUEUED state.
+
+EINVAL
+    One or more of the buffers in the range ``index`` to ``index + count - 1`` do not
+    exist in the queue.
diff --git a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
index 0b3a41a45d05..bbc22dd76032 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
@@ -121,6 +121,7 @@ aborting or finishing any DMA in progress, an implicit
 .. _V4L2-BUF-CAP-SUPPORTS-M2M-HOLD-CAPTURE-BUF:
 .. _V4L2-BUF-CAP-SUPPORTS-MMAP-CACHE-HINTS:
 .. _V4L2-BUF-CAP-SUPPORTS-MAX-NUM-BUFFERS:
+.. _V4L2-BUF-CAP-SUPPORTS-REMOVE-BUFS:
 
 .. raw:: latex
 
diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 009cea95d662..0b2b48e1b2df 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -1691,6 +1691,44 @@ int vb2_core_prepare_buf(struct vb2_queue *q, struct vb2_buffer *vb, void *pb)
 }
 EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
 
+int vb2_core_remove_bufs(struct vb2_queue *q, unsigned int start, unsigned int count)
+{
+	unsigned int i, ret = 0;
+	unsigned int q_num_bufs = vb2_get_num_buffers(q);
+
+	if (count == 0)
+		return 0;
+
+	if (count > q_num_bufs)
+		return -EINVAL;
+
+	if (start > q->max_num_buffers - count)
+		return -EINVAL;
+
+	mutex_lock(&q->mmap_lock);
+
+	/* Check that all buffers in the range exist */
+	for (i = start; i < start + count; i++) {
+		struct vb2_buffer *vb = vb2_get_buffer(q, i);
+
+		if (!vb) {
+			ret = -EINVAL;
+			goto unlock;
+		}
+		if (vb->state != VB2_BUF_STATE_DEQUEUED) {
+			ret = -EBUSY;
+			goto unlock;
+		}
+	}
+	__vb2_queue_free(q, start, count);
+	dprintk(q, 2, "%u buffers removed\n", count);
+
+unlock:
+	mutex_unlock(&q->mmap_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vb2_core_remove_bufs);
+
 /*
  * vb2_start_streaming() - Attempt to start streaming.
  * @q:		videobuf2 queue
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 03e8080a68a8..9a5dcbb8fef3 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -685,7 +685,7 @@ static void vb2_set_flags_and_caps(struct vb2_queue *q, u32 memory,
 		*flags &= V4L2_MEMORY_FLAG_NON_COHERENT;
 	}
 
-	*caps = V4L2_BUF_CAP_SUPPORTS_ORPHANED_BUFS;
+	*caps |= V4L2_BUF_CAP_SUPPORTS_ORPHANED_BUFS;
 	if (q->io_modes & VB2_MMAP)
 		*caps |= V4L2_BUF_CAP_SUPPORTS_MMAP;
 	if (q->io_modes & VB2_USERPTR)
@@ -1001,6 +1001,18 @@ EXPORT_SYMBOL_GPL(vb2_poll);
 
 /* vb2 ioctl helpers */
 
+int vb2_ioctl_remove_bufs(struct file *file, void *priv,
+			  struct v4l2_remove_buffers *d)
+{
+	struct video_device *vdev = video_devdata(file);
+
+	if (vb2_queue_is_busy(vdev->queue, file))
+		return -EBUSY;
+
+	return vb2_core_remove_bufs(vdev->queue, d->index, d->count);
+}
+EXPORT_SYMBOL_GPL(vb2_ioctl_remove_bufs);
+
 int vb2_ioctl_reqbufs(struct file *file, void *priv,
 			  struct v4l2_requestbuffers *p)
 {
diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index d13954bd31fd..e39e9742fdb5 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -722,6 +722,9 @@ static void determine_valid_ioctls(struct video_device *vdev)
 		SET_VALID_IOCTL(ops, VIDIOC_PREPARE_BUF, vidioc_prepare_buf);
 		SET_VALID_IOCTL(ops, VIDIOC_STREAMON, vidioc_streamon);
 		SET_VALID_IOCTL(ops, VIDIOC_STREAMOFF, vidioc_streamoff);
+		/* VIDIOC_CREATE_BUFS support is mandatory to enable VIDIOC_REMOVE_BUFS */
+		if (ops->vidioc_create_bufs)
+			SET_VALID_IOCTL(ops, VIDIOC_REMOVE_BUFS, vidioc_remove_bufs);
 	}
 
 	if (is_vid || is_vbi || is_meta) {
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 33076af4dfdb..a5a4134218e6 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -489,6 +489,14 @@ static void v4l_print_create_buffers(const void *arg, bool write_only)
 	v4l_print_format(&p->format, write_only);
 }
 
+static void v4l_print_remove_buffers(const void *arg, bool write_only)
+{
+	const struct v4l2_remove_buffers *p = arg;
+
+	pr_cont("type=%s, index=%u, count=%u\n",
+		prt_names(p->type, v4l2_type_names), p->index, p->count);
+}
+
 static void v4l_print_streamparm(const void *arg, bool write_only)
 {
 	const struct v4l2_streamparm *p = arg;
@@ -2092,6 +2100,7 @@ static int v4l_overlay(const struct v4l2_ioctl_ops *ops,
 static int v4l_reqbufs(const struct v4l2_ioctl_ops *ops,
 				struct file *file, void *fh, void *arg)
 {
+	struct video_device *vfd = video_devdata(file);
 	struct v4l2_requestbuffers *p = arg;
 	int ret = check_fmt(file, p->type);
 
@@ -2100,6 +2109,9 @@ static int v4l_reqbufs(const struct v4l2_ioctl_ops *ops,
 
 	memset_after(p, 0, flags);
 
+	if (is_valid_ioctl(vfd, VIDIOC_REMOVE_BUFS))
+		p->capabilities = V4L2_BUF_CAP_SUPPORTS_REMOVE_BUFS;
+
 	return ops->vidioc_reqbufs(file, fh, p);
 }
 
@@ -2133,6 +2145,7 @@ static int v4l_dqbuf(const struct v4l2_ioctl_ops *ops,
 static int v4l_create_bufs(const struct v4l2_ioctl_ops *ops,
 				struct file *file, void *fh, void *arg)
 {
+	struct video_device *vfd = video_devdata(file);
 	struct v4l2_create_buffers *create = arg;
 	int ret = check_fmt(file, create->format.type);
 
@@ -2143,6 +2156,9 @@ static int v4l_create_bufs(const struct v4l2_ioctl_ops *ops,
 
 	v4l_sanitize_format(&create->format);
 
+	if (is_valid_ioctl(vfd, VIDIOC_REMOVE_BUFS))
+		create->capabilities = V4L2_BUF_CAP_SUPPORTS_REMOVE_BUFS;
+
 	ret = ops->vidioc_create_bufs(file, fh, create);
 
 	if (create->format.type == V4L2_BUF_TYPE_VIDEO_CAPTURE ||
@@ -2161,6 +2177,21 @@ static int v4l_prepare_buf(const struct v4l2_ioctl_ops *ops,
 	return ret ? ret : ops->vidioc_prepare_buf(file, fh, b);
 }
 
+static int v4l_remove_bufs(const struct v4l2_ioctl_ops *ops,
+			   struct file *file, void *fh, void *arg)
+{
+	struct v4l2_remove_buffers *remove = arg;
+	int ret = check_fmt(file, remove->type);
+
+	if (ret)
+		return ret;
+
+	if (ops->vidioc_remove_bufs)
+		return ops->vidioc_remove_bufs(file, fh, remove);
+
+	return -ENOTTY;
+}
+
 static int v4l_g_parm(const struct v4l2_ioctl_ops *ops,
 				struct file *file, void *fh, void *arg)
 {
@@ -2910,6 +2941,7 @@ static const struct v4l2_ioctl_info v4l2_ioctls[] = {
 	IOCTL_INFO(VIDIOC_ENUM_FREQ_BANDS, v4l_enum_freq_bands, v4l_print_freq_band, 0),
 	IOCTL_INFO(VIDIOC_DBG_G_CHIP_INFO, v4l_dbg_g_chip_info, v4l_print_dbg_chip_info, INFO_FL_CLEAR(v4l2_dbg_chip_info, match)),
 	IOCTL_INFO(VIDIOC_QUERY_EXT_CTRL, v4l_query_ext_ctrl, v4l_print_query_ext_ctrl, INFO_FL_CTRL | INFO_FL_CLEAR(v4l2_query_ext_ctrl, id)),
+	IOCTL_INFO(VIDIOC_REMOVE_BUFS, v4l_remove_bufs, v4l_print_remove_buffers, INFO_FL_PRIO | INFO_FL_QUEUE | INFO_FL_CLEAR(v4l2_remove_buffers, type)),
 };
 #define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
 
diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
index edb733f21604..bdbb7e542321 100644
--- a/include/media/v4l2-ioctl.h
+++ b/include/media/v4l2-ioctl.h
@@ -163,6 +163,8 @@ struct v4l2_fh;
  *	:ref:`VIDIOC_CREATE_BUFS <vidioc_create_bufs>` ioctl
  * @vidioc_prepare_buf: pointer to the function that implements
  *	:ref:`VIDIOC_PREPARE_BUF <vidioc_prepare_buf>` ioctl
+ * @vidioc_remove_bufs: pointer to the function that implements
+ *	:ref:`VIDIOC_REMOVE_BUFS <vidioc_remove_bufs>` ioctl
  * @vidioc_overlay: pointer to the function that implements
  *	:ref:`VIDIOC_OVERLAY <vidioc_overlay>` ioctl
  * @vidioc_g_fbuf: pointer to the function that implements
@@ -422,6 +424,8 @@ struct v4l2_ioctl_ops {
 				  struct v4l2_create_buffers *b);
 	int (*vidioc_prepare_buf)(struct file *file, void *fh,
 				  struct v4l2_buffer *b);
+	int (*vidioc_remove_bufs)(struct file *file, void *fh,
+				  struct v4l2_remove_buffers *d);
 
 	int (*vidioc_overlay)(struct file *file, void *fh, unsigned int i);
 	int (*vidioc_g_fbuf)(struct file *file, void *fh,
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 7aebeaf671d8..a4e59280747e 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -867,6 +867,16 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
  */
 int vb2_core_prepare_buf(struct vb2_queue *q, struct vb2_buffer *vb, void *pb);
 
+/**
+ * vb2_core_remove_bufs() -
+ * @q:		pointer to &struct vb2_queue with videobuf2 queue.
+ * @start:	first index of the range of buffers to remove.
+ * @count:	number of buffers to remove.
+ *
+ *  Return: returns zero on success; an error code otherwise.
+ */
+int vb2_core_remove_bufs(struct vb2_queue *q, unsigned int start, unsigned int count);
+
 /**
  * vb2_core_qbuf() - Queue a buffer from userspace
  *
diff --git a/include/media/videobuf2-v4l2.h b/include/media/videobuf2-v4l2.h
index 5a845887850b..77ce8238ab30 100644
--- a/include/media/videobuf2-v4l2.h
+++ b/include/media/videobuf2-v4l2.h
@@ -334,6 +334,8 @@ int vb2_ioctl_streamon(struct file *file, void *priv, enum v4l2_buf_type i);
 int vb2_ioctl_streamoff(struct file *file, void *priv, enum v4l2_buf_type i);
 int vb2_ioctl_expbuf(struct file *file, void *priv,
 	struct v4l2_exportbuffer *p);
+int vb2_ioctl_remove_bufs(struct file *file, void *priv,
+			  struct v4l2_remove_buffers *p);
 
 /* struct v4l2_file_operations helpers */
 
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index a8015e5e7fa4..2663213b76a4 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -1036,6 +1036,7 @@ struct v4l2_requestbuffers {
 #define V4L2_BUF_CAP_SUPPORTS_M2M_HOLD_CAPTURE_BUF	(1 << 5)
 #define V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS		(1 << 6)
 #define V4L2_BUF_CAP_SUPPORTS_MAX_NUM_BUFFERS		(1 << 7)
+#define V4L2_BUF_CAP_SUPPORTS_REMOVE_BUFS		(1 << 8)
 
 /**
  * struct v4l2_plane - plane info for multi-planar buffers
@@ -2624,6 +2625,20 @@ struct v4l2_create_buffers {
 	__u32			reserved[5];
 };
 
+/**
+ * struct v4l2_remove_buffers - VIDIOC_REMOVE_BUFS argument
+ * @index:	the first buffer to be removed
+ * @count:	number of buffers to removed
+ * @type:	enum v4l2_buf_type
+ * @reserved:	future extensions
+ */
+struct v4l2_remove_buffers {
+	__u32			index;
+	__u32			count;
+	__u32			type;
+	__u32			reserved[13];
+};
+
 /*
  *	I O C T L   C O D E S   F O R   V I D E O   D E V I C E S
  *
@@ -2723,6 +2738,8 @@ struct v4l2_create_buffers {
 #define VIDIOC_DBG_G_CHIP_INFO  _IOWR('V', 102, struct v4l2_dbg_chip_info)
 
 #define VIDIOC_QUERY_EXT_CTRL	_IOWR('V', 103, struct v4l2_query_ext_ctrl)
+#define VIDIOC_REMOVE_BUFS	_IOWR('V', 104, struct v4l2_remove_buffers)
+
 
 /* Reminder: when adding new ioctls please add support for them to
    drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well! */
-- 
2.40.1


