Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105A378FDA6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349645AbjIAMpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347780AbjIAMom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:44:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223BE10F4;
        Fri,  1 Sep 2023 05:44:36 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:4d01:31d2:de6b:d217])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AA0D766072EE;
        Fri,  1 Sep 2023 13:44:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693572274;
        bh=PBj66W9S9V6lVolTjpcA5Zkze5h2qb0ODE/Gm9G/+S8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OG/ZlbLgSNnKMF4l/pe+t6m0sPWQDnGzXcKv0mYRk34oM+o0Cm+i9IycG3RuouHax
         xmHzF9JkoSO3w1QNF5o/itT5irDUbD0e3PyZotYvZMBjC1PVJdkHsNNirUaxC+DRpQ
         tsNtbTv1QXcyGvFksRhI540RIJ0+S5+yl68FdVSMf5EyQE01GUYMm71AH3ZXvs9vpD
         gv8lXimAO+Fbo+KLTQAd9Jh7DjE03gIdIAPJPy4SgHGMirmCdeNQxnJPG9EeHbkffz
         4tv3Dgu83iSh/sfjbAaL0V/3xb78NxhDzCmL0zq9axPMWiMzq4u+PYn1kosaA3/GuX
         k1ufMq6x1Im0Q==
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
Subject: [PATCH v6 17/18] media: v4l2: Add DELETE_BUFS ioctl
Date:   Fri,  1 Sep 2023 14:44:13 +0200
Message-Id: <20230901124414.48497-18-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230901124414.48497-1-benjamin.gaignard@collabora.com>
References: <20230901124414.48497-1-benjamin.gaignard@collabora.com>
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

VIDIOC_DELETE_BUFS ioctl allows to delete buffers from a queue.
The number of buffers to delete in given by count field of
struct v4l2_delete_buffers and the range start at the index
specified in the same structure.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
v6:
- Add lock in vb2_core_delete_buf()
- Fix typo and comments
- Add flags in VIDIOC_DELETE_BUFS decalaration

 .../userspace-api/media/v4l/user-func.rst     |  1 +
 .../media/v4l/vidioc-delete-bufs.rst          | 73 +++++++++++++++++++
 .../media/common/videobuf2/videobuf2-core.c   | 24 ++++++
 .../media/common/videobuf2/videobuf2-v4l2.c   | 38 +++++++++-
 drivers/media/v4l2-core/v4l2-dev.c            |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          | 17 +++++
 include/media/v4l2-ioctl.h                    |  4 +
 include/media/videobuf2-core.h                |  9 +++
 include/media/videobuf2-v4l2.h                | 11 +++
 include/uapi/linux/videodev2.h                | 16 ++++
 10 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst

diff --git a/Documentation/userspace-api/media/v4l/user-func.rst b/Documentation/userspace-api/media/v4l/user-func.rst
index 15ff0bf7bbe6..3fd567695477 100644
--- a/Documentation/userspace-api/media/v4l/user-func.rst
+++ b/Documentation/userspace-api/media/v4l/user-func.rst
@@ -17,6 +17,7 @@ Function Reference
     vidioc-dbg-g-chip-info
     vidioc-dbg-g-register
     vidioc-decoder-cmd
+    vidioc-delete-bufs
     vidioc-dqevent
     vidioc-dv-timings-cap
     vidioc-encoder-cmd
diff --git a/Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst b/Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst
new file mode 100644
index 000000000000..a55fe6331fc8
--- /dev/null
+++ b/Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst
@@ -0,0 +1,73 @@
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
+.. c:namespace:: V4L
+
+.. _VIDIOC_DELETE_BUFS:
+
+************************
+ioctl VIDIOC_DELETE_BUFS
+************************
+
+Name
+====
+
+VIDIOC_DELETE_BUFS - Deletes buffers from a queue
+
+Synopsis
+========
+
+.. c:macro:: VIDIOC_DELETE_BUFs
+
+``int ioctl(int fd, VIDIOC_DELETE_BUFs, struct v4l2_delete_buffers *argp)``
+
+Arguments
+=========
+
+``fd``
+    File descriptor returned by :c:func:`open()`.
+
+``argp``
+    Pointer to struct :c:type:`v4l2_delete_buffers`.
+
+Description
+===========
+
+Applications can optionally call the :ref:`VIDIOC_DELETE_BUFS` ioctl to
+delete buffers from a queue.
+
+.. c:type:: v4l2_delete_buffers
+
+.. tabularcolumns:: |p{4.4cm}|p{4.4cm}|p{8.5cm}|
+
+.. flat-table:: struct v4l2_delete_buffers
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2
+
+    * - __u32
+      - ``index``
+      - The starting buffer index to delete.
+    * - __u32
+      - ``count``
+      - The number of buffers to be deleted.
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
+
+EINVAL
+    The buffer ``index`` doesn't exist in the queue.
diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index dc7f6b59d237..9edb2a1e95fc 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -1633,6 +1633,30 @@ int vb2_core_prepare_buf(struct vb2_queue *q, struct vb2_buffer *vb, void *pb)
 }
 EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
 
+int vb2_core_delete_buf(struct vb2_queue *q, struct vb2_buffer *vb)
+{
+	mutex_lock(&q->mmap_lock);
+	if (vb->planes[0].mem_priv)
+		call_void_vb_qop(vb, buf_cleanup, vb);
+
+	/* Free MMAP buffers or release USERPTR buffers */
+	if (q->memory == VB2_MEMORY_MMAP)
+		__vb2_buf_mem_free(vb);
+	else if (q->memory == VB2_MEMORY_DMABUF)
+		__vb2_buf_dmabuf_put(vb);
+	else
+		__vb2_buf_userptr_put(vb);
+
+	vb2_queue_remove_buffer(q, vb);
+	mutex_unlock(&q->mmap_lock);
+
+	dprintk(q, 2, "buffer %d deleted\n", vb->index);
+	kfree(vb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vb2_core_delete_buf);
+
 /*
  * vb2_start_streaming() - Attempt to start streaming.
  * @q:		videobuf2 queue
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 8ba658ad9891..d0098f58a65c 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -385,7 +385,7 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
 
 	vb = vb2_get_buffer(q, b->index);
 	if (!vb) {
-		dprintk(q, 1, "%s: buffer is NULL\n", opname);
+		dprintk(q, 1, "%s: buffer %u was deleted\n", opname, b->index);
 		return -EINVAL;
 	}
 
@@ -757,6 +757,42 @@ int vb2_prepare_buf(struct vb2_queue *q, struct media_device *mdev,
 }
 EXPORT_SYMBOL_GPL(vb2_prepare_buf);
 
+int vb2_delete_bufs(struct vb2_queue *q, struct v4l2_delete_buffers *d)
+{
+	struct vb2_buffer *vb;
+	unsigned int index;
+	int ret = 0;
+
+	if (d->index > q->num_buffers ||
+	    d->count > q->num_buffers ||
+	    (d->index + d->count) > q->num_buffers) {
+		return -EINVAL;
+	}
+
+	for (index = d->index; index < d->index + d->count; index++) {
+		vb = vb2_get_buffer(q, index);
+		if (!vb) {
+			dprintk(q, 1, "can't find the requested buffer\n");
+			ret = -EINVAL;
+			goto error;
+		}
+		if (vb->state != VB2_BUF_STATE_DEQUEUED) {
+			dprintk(q, 1, "can't delete non dequeued buffer index %d\n", vb->index);
+			ret = -EINVAL;
+			goto error;
+		}
+
+		ret = vb2_core_delete_buf(q, vb);
+		if (ret)
+			break;
+	}
+
+error:
+	d->index = index;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vb2_delete_bufs);
+
 int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
 {
 	unsigned requested_planes = 1;
diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index f81279492682..215654fd6581 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -720,6 +720,7 @@ static void determine_valid_ioctls(struct video_device *vdev)
 		SET_VALID_IOCTL(ops, VIDIOC_PREPARE_BUF, vidioc_prepare_buf);
 		SET_VALID_IOCTL(ops, VIDIOC_STREAMON, vidioc_streamon);
 		SET_VALID_IOCTL(ops, VIDIOC_STREAMOFF, vidioc_streamoff);
+		SET_VALID_IOCTL(ops, VIDIOC_DELETE_BUFS, vidioc_delete_bufs);
 	}
 
 	if (is_vid || is_vbi || is_meta) {
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index f4d9d6279094..aac3a0ea0126 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -489,6 +489,13 @@ static void v4l_print_create_buffers(const void *arg, bool write_only)
 	v4l_print_format(&p->format, write_only);
 }
 
+static void v4l_print_delete_buffers(const void *arg, bool write_only)
+{
+	const struct v4l2_delete_buffers *p = arg;
+
+	pr_cont("index=%d, count=%d\n", p->index, p->count);
+}
+
 static void v4l_print_streamparm(const void *arg, bool write_only)
 {
 	const struct v4l2_streamparm *p = arg;
@@ -2160,6 +2167,15 @@ static int v4l_prepare_buf(const struct v4l2_ioctl_ops *ops,
 	return ret ? ret : ops->vidioc_prepare_buf(file, fh, b);
 }
 
+static int v4l_delete_bufs(const struct v4l2_ioctl_ops *ops,
+			   struct file *file, void *fh, void *arg)
+{
+	struct v4l2_delete_buffers *delete = arg;
+	int ret = check_fmt(file, delete->type);
+
+	return ret ? ret : ops->vidioc_delete_bufs(file, fh, delete);
+}
+
 static int v4l_g_parm(const struct v4l2_ioctl_ops *ops,
 				struct file *file, void *fh, void *arg)
 {
@@ -2909,6 +2925,7 @@ static const struct v4l2_ioctl_info v4l2_ioctls[] = {
 	IOCTL_INFO(VIDIOC_ENUM_FREQ_BANDS, v4l_enum_freq_bands, v4l_print_freq_band, 0),
 	IOCTL_INFO(VIDIOC_DBG_G_CHIP_INFO, v4l_dbg_g_chip_info, v4l_print_dbg_chip_info, INFO_FL_CLEAR(v4l2_dbg_chip_info, match)),
 	IOCTL_INFO(VIDIOC_QUERY_EXT_CTRL, v4l_query_ext_ctrl, v4l_print_query_ext_ctrl, INFO_FL_CTRL | INFO_FL_CLEAR(v4l2_query_ext_ctrl, id)),
+	IOCTL_INFO(VIDIOC_DELETE_BUFS, v4l_delete_bufs, v4l_print_delete_buffers, INFO_FL_PRIO | INFO_FL_QUEUE | INFO_FL_CLEAR(v4l2_delete_buffers, type)),
 };
 #define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
 
diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
index edb733f21604..55afbde54211 100644
--- a/include/media/v4l2-ioctl.h
+++ b/include/media/v4l2-ioctl.h
@@ -163,6 +163,8 @@ struct v4l2_fh;
  *	:ref:`VIDIOC_CREATE_BUFS <vidioc_create_bufs>` ioctl
  * @vidioc_prepare_buf: pointer to the function that implements
  *	:ref:`VIDIOC_PREPARE_BUF <vidioc_prepare_buf>` ioctl
+ * @vidioc_delete_bufs: pointer to the function that implements
+ *	:ref:`VIDIOC_DELETE_BUFS <vidioc_delete_bufs>` ioctl
  * @vidioc_overlay: pointer to the function that implements
  *	:ref:`VIDIOC_OVERLAY <vidioc_overlay>` ioctl
  * @vidioc_g_fbuf: pointer to the function that implements
@@ -422,6 +424,8 @@ struct v4l2_ioctl_ops {
 				  struct v4l2_create_buffers *b);
 	int (*vidioc_prepare_buf)(struct file *file, void *fh,
 				  struct v4l2_buffer *b);
+	int (*vidioc_delete_bufs)(struct file *file, void *fh,
+				  struct v4l2_delete_buffers *d);
 
 	int (*vidioc_overlay)(struct file *file, void *fh, unsigned int i);
 	int (*vidioc_g_fbuf)(struct file *file, void *fh,
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 97153c69583f..e2c5ff31efd0 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -843,6 +843,15 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
  */
 int vb2_core_prepare_buf(struct vb2_queue *q, struct vb2_buffer *vb, void *pb);
 
+/**
+ * vb2_core_delete_buf() -
+ * @q: pointer to &struct vb2_queue with videobuf2 queue.
+ * @vb:		pointer to struct &vb2_buffer.
+ *
+ *  Return: returns zero on success; an error code otherwise.
+ */
+int vb2_core_delete_buf(struct vb2_queue *q, struct vb2_buffer *vb);
+
 /**
  * vb2_core_qbuf() - Queue a buffer from userspace
  *
diff --git a/include/media/videobuf2-v4l2.h b/include/media/videobuf2-v4l2.h
index 5a845887850b..2ef68fdf388f 100644
--- a/include/media/videobuf2-v4l2.h
+++ b/include/media/videobuf2-v4l2.h
@@ -118,6 +118,17 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create);
  */
 int vb2_prepare_buf(struct vb2_queue *q, struct media_device *mdev,
 		    struct v4l2_buffer *b);
+/**
+ * vb2_delete_bufs() - Delete buffers from the queue
+ *
+ * @q:		pointer to &struct vb2_queue with videobuf2 queue.
+ * @d:		delete parameter, passed from userspace to
+ *		&v4l2_ioctl_ops->vidioc_delete_bufs handler in driver
+ *
+ * The return values from this function are intended to be directly returned
+ * from &v4l2_ioctl_ops->vidioc_delete_bufs handler in driver.
+ */
+int vb2_delete_bufs(struct vb2_queue *q, struct v4l2_delete_buffers *d);
 
 /**
  * vb2_qbuf() - Queue a buffer from userspace
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 78260e5d9985..9cc7f570d995 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -2616,6 +2616,20 @@ struct v4l2_create_buffers {
 	__u32			reserved[6];
 };
 
+/**
+ * struct v4l2_delete_buffers - VIDIOC_DELETE_BUFS argument
+ * @index:	the first buffer to be deleted
+ * @count:	number of buffers to delete
+ * @type:	enum v4l2_buf_type
+ * @reserved:	future extensions
+ */
+struct v4l2_delete_buffers {
+	__u32			index;
+	__u32			count;
+	__u32			type;
+	__u32			reserved[13];
+};
+
 /*
  *	I O C T L   C O D E S   F O R   V I D E O   D E V I C E S
  *
@@ -2715,6 +2729,8 @@ struct v4l2_create_buffers {
 #define VIDIOC_DBG_G_CHIP_INFO  _IOWR('V', 102, struct v4l2_dbg_chip_info)
 
 #define VIDIOC_QUERY_EXT_CTRL	_IOWR('V', 103, struct v4l2_query_ext_ctrl)
+#define VIDIOC_DELETE_BUFS	_IOWR('V', 104, struct v4l2_delete_buffers)
+
 
 /* Reminder: when adding new ioctls please add support for them to
    drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well! */
-- 
2.39.2

